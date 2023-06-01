import re



'''
规则是每行一条的文本，将查找和匹配用等号隔开，文本两边的空格会被省略。

导入模块后，先更新热词词典，然后再替换句子中的热词。

使用方法示例：


热词文本 = """
    毫安时  =  mAh
    伏特   =   V
    赫兹   =   Hz
"""

更新热词词典(热词文本)

热词替换('这款手机有5000毫安时的大电池')   # 输出：这款手机有5000mAh的大电池
热词替换('国内交流电一般是50赫兹')               # 输出：国内交流电一般是50Hz

'''



__all__ = ['更新热词词典', '热词替换']

热词词典 = {}       


def 更新热词词典(热词文本: str):
    '''
    把热词规则文本中的每一行用 = 分开，去除多余空格后添加到热词词典，
    key     是被替换的词，
    value   是将被替换成的词
    '''
    global 热词词典; 热词词典.clear()
    for 热词 in 热词文本.splitlines():
        if not 热词 or 热词.startswith('#'): continue
        if len(热词.split('=')) == 2:
            key = 热词.split('=')[0].strip()
            value = 热词.split('=')[1].strip()
            热词词典[key] = value
    return len(热词词典)


def 匹配热词(句子:str):
    '''
    将全局「热词词典」中的热词按照 key 依次与句子匹配，将所有匹配到的热词放到列表
    '''
    global 热词词典

    所有匹配 = []
    for 词 in 热词词典:
        if 词 in 句子:
            所有匹配.append(词)
    
    return 所有匹配

def 热词替换(句子:str):
    '''
    从热词词典中查找匹配的热词，替换句子

    句子：       被查找和替换的句子
    '''
    所有匹配 = 匹配热词(句子)
    for 匹配项 in 所有匹配:
        句子 = 句子.replace(匹配项, 热词词典[匹配项])
    return 句子

if __name__ == '__main__':
    print(f'\x9b42m-------------开始---------------\x9b0m')

    热词文本 = '''
        毫安时  =  mAh
        伏特   =   V
        赫兹   =   Hz
    '''

    更新热词词典(热词文本)

    res = 热词替换('这款手机有5000毫安时的大电池')


    print(f'{res}')

