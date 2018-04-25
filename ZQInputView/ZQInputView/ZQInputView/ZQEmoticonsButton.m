//
//  ZQEmoticonsButton.m
//  ZQInputView
//
//  Created by zhouyu on 24/04/2018.
//  Copyright © 2018 zhouyu. All rights reserved.
//

#import "ZQEmoticonsButton.h"

@implementation ZQEmoticonsButton

- (void)setModel:(ZQEmoticonsModel *)model {
    _model = model;
    
    if (model.path && model.png) {
        NSString *imagePath = [NSString stringWithFormat:@"%@/%@",model.path,model.png];
        [self setImage:[UIImage imageWithContentsOfFile:imagePath] forState:UIControlStateNormal];
    } else {
        [self setImage:nil forState:UIControlStateNormal];
    }
    
    if (model.emoji) {
        [self setTitle:model.emoji forState:UIControlStateNormal];
    } else {
        [self setTitle:nil forState:UIControlStateNormal];
    }
}

/*加载图片特别费时,是造成卡顿的真凶--imageNamed加载方式特别费时,imageWithContentsOfFile恰恰降低了很多
 CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
 UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
 CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
 NSLog(@"%d-----Linked in %f ms", __LINE__,linkTime *1000.0);
 
 2018-04-25 00:22:45.925392+0800 ZQInputView[3610:511415] 22-----Linked in 20.267963 ms
 2018-04-25 00:22:45.927612+0800 ZQInputView[3610:511415] 22-----Linked in 1.921058 ms
 2018-04-25 00:22:45.930087+0800 ZQInputView[3610:511415] 22-----Linked in 2.265930 ms
 2018-04-25 00:22:45.932540+0800 ZQInputView[3610:511415] 22-----Linked in 2.249956 ms
 2018-04-25 00:22:45.934841+0800 ZQInputView[3610:511415] 22-----Linked in 2.077937 ms
 2018-04-25 00:22:45.936940+0800 ZQInputView[3610:511415] 22-----Linked in 1.895070 ms
 2018-04-25 00:22:45.939394+0800 ZQInputView[3610:511415] 22-----Linked in 2.136946 ms
 2018-04-25 00:22:45.941928+0800 ZQInputView[3610:511415] 22-----Linked in 2.328038 ms
 2018-04-25 00:22:45.944316+0800 ZQInputView[3610:511415] 22-----Linked in 2.164006 ms
 2018-04-25 00:22:45.946776+0800 ZQInputView[3610:511415] 22-----Linked in 2.263069 ms
 2018-04-25 00:22:45.949497+0800 ZQInputView[3610:511415] 22-----Linked in 2.483964 ms
 2018-04-25 00:22:45.952129+0800 ZQInputView[3610:511415] 22-----Linked in 2.259016 ms
 2018-04-25 00:22:45.954245+0800 ZQInputView[3610:511415] 22-----Linked in 1.914024 ms
 2018-04-25 00:22:45.955948+0800 ZQInputView[3610:511415] 22-----Linked in 1.513004 ms
 2018-04-25 00:22:45.957566+0800 ZQInputView[3610:511415] 22-----Linked in 1.453996 ms
 2018-04-25 00:22:45.959244+0800 ZQInputView[3610:511415] 22-----Linked in 1.494050 ms
 2018-04-25 00:22:45.961100+0800 ZQInputView[3610:511415] 22-----Linked in 1.675963 ms
 2018-04-25 00:22:45.962932+0800 ZQInputView[3610:511415] 22-----Linked in 1.603007 ms
 2018-04-25 00:22:45.964572+0800 ZQInputView[3610:511415] 22-----Linked in 1.459002 ms
 2018-04-25 00:22:45.966348+0800 ZQInputView[3610:511415] 22-----Linked in 1.554966 ms
 2018-04-25 00:22:45.967985+0800 ZQInputView[3610:511415] 22-----Linked in 1.446009 ms
 2018-04-25 00:22:45.969843+0800 ZQInputView[3610:511415] 22-----Linked in 1.675010 ms
 2018-04-25 00:22:45.971411+0800 ZQInputView[3610:511415] 22-----Linked in 1.386046 ms
 2018-04-25 00:22:45.973010+0800 ZQInputView[3610:511415] 22-----Linked in 1.417994 ms
 2018-04-25 00:22:45.974572+0800 ZQInputView[3610:511415] 22-----Linked in 1.386046 ms
 2018-04-25 00:22:45.976168+0800 ZQInputView[3610:511415] 22-----Linked in 1.423955 ms
 2018-04-25 00:22:45.977974+0800 ZQInputView[3610:511415] 22-----Linked in 1.634002 ms
 2018-04-25 00:22:45.979619+0800 ZQInputView[3610:511415] 22-----Linked in 1.449943 ms
 2018-04-25 00:22:45.981233+0800 ZQInputView[3610:511415] 22-----Linked in 1.439095 ms
 2018-04-25 00:22:45.982873+0800 ZQInputView[3610:511415] 22-----Linked in 1.454949 ms
 2018-04-25 00:22:45.984491+0800 ZQInputView[3610:511415] 22-----Linked in 1.421928 ms
 2018-04-25 00:22:45.986337+0800 ZQInputView[3610:511415] 22-----Linked in 1.664042 ms
 2018-04-25 00:22:45.987949+0800 ZQInputView[3610:511415] 22-----Linked in 1.419902 ms
 2018-04-25 00:22:45.989532+0800 ZQInputView[3610:511415] 22-----Linked in 1.387000 ms
 2018-04-25 00:22:45.991126+0800 ZQInputView[3610:511415] 22-----Linked in 1.422048 ms
 2018-04-25 00:22:45.992725+0800 ZQInputView[3610:511415] 22-----Linked in 1.423955 ms
 2018-04-25 00:22:45.994534+0800 ZQInputView[3610:511415] 22-----Linked in 1.597047 ms
 2018-04-25 00:22:45.996138+0800 ZQInputView[3610:511415] 22-----Linked in 1.387000 ms
 2018-04-25 00:22:45.997723+0800 ZQInputView[3610:511415] 22-----Linked in 1.416922 ms
 2018-04-25 00:22:45.999369+0800 ZQInputView[3610:511415] 22-----Linked in 1.479030 ms
 2018-04-25 00:22:46.001002+0800 ZQInputView[3610:511415] 22-----Linked in 1.443982 ms
 2018-04-25 00:22:46.002804+0800 ZQInputView[3610:511415] 22-----Linked in 1.613021 ms
 2018-04-25 00:22:46.004421+0800 ZQInputView[3610:511415] 22-----Linked in 1.448035 ms
 2018-04-25 00:22:46.006027+0800 ZQInputView[3610:511415] 22-----Linked in 1.414061 ms
 */

/*加载图片特别费时,是造成卡顿的真凶--imageNamed加载方式特别费时
 CFAbsoluteTime startTime =CFAbsoluteTimeGetCurrent();
 UIImage *image = [UIImage imageNamed:imagePath];
 CFAbsoluteTime linkTime = (CFAbsoluteTimeGetCurrent() - startTime);
 NSLog(@"%d-----Linked in %f ms", __LINE__,linkTime *1000.0);
 
 2018-04-25 00:12:43.793491+0800 ZQInputView[3291:476100] 24-----Linked in 62.180042 ms
 2018-04-25 00:12:43.847259+0800 ZQInputView[3291:476100] 24-----Linked in 53.030968 ms
 2018-04-25 00:12:43.885906+0800 ZQInputView[3291:476100] 24-----Linked in 38.304925 ms
 2018-04-25 00:12:43.921600+0800 ZQInputView[3291:476100] 24-----Linked in 35.480022 ms
 2018-04-25 00:12:43.971309+0800 ZQInputView[3291:476100] 24-----Linked in 48.895001 ms
 2018-04-25 00:12:44.009891+0800 ZQInputView[3291:476100] 24-----Linked in 38.231015 ms
 2018-04-25 00:12:44.053943+0800 ZQInputView[3291:476100] 24-----Linked in 43.695092 ms
 2018-04-25 00:12:44.113761+0800 ZQInputView[3291:476100] 24-----Linked in 55.670977 ms
 2018-04-25 00:12:44.154009+0800 ZQInputView[3291:476100] 24-----Linked in 40.014029 ms
 2018-04-25 00:12:44.193645+0800 ZQInputView[3291:476100] 24-----Linked in 39.317966 ms
 2018-04-25 00:12:44.227230+0800 ZQInputView[3291:476100] 24-----Linked in 33.339024 ms
 2018-04-25 00:12:44.252775+0800 ZQInputView[3291:476100] 24-----Linked in 25.280952 ms
 2018-04-25 00:12:44.276031+0800 ZQInputView[3291:476100] 24-----Linked in 23.010969 ms
 2018-04-25 00:12:44.296840+0800 ZQInputView[3291:476100] 24-----Linked in 20.521045 ms
 2018-04-25 00:12:44.317812+0800 ZQInputView[3291:476100] 24-----Linked in 20.782948 ms
 2018-04-25 00:12:44.340024+0800 ZQInputView[3291:476100] 24-----Linked in 22.006035 ms
 2018-04-25 00:12:44.360209+0800 ZQInputView[3291:476100] 24-----Linked in 19.959927 ms
 2018-04-25 00:12:44.380456+0800 ZQInputView[3291:476100] 24-----Linked in 20.010948 ms
 2018-04-25 00:12:44.400928+0800 ZQInputView[3291:476100] 24-----Linked in 20.233989 ms
 2018-04-25 00:12:44.421221+0800 ZQInputView[3291:476100] 24-----Linked in 20.110011 ms
 2018-04-25 00:12:44.441226+0800 ZQInputView[3291:476100] 24-----Linked in 19.790053 ms
 2018-04-25 00:12:44.462688+0800 ZQInputView[3291:476100] 24-----Linked in 21.173954 ms
 2018-04-25 00:12:44.483657+0800 ZQInputView[3291:476100] 24-----Linked in 20.747066 ms
 2018-04-25 00:12:44.504491+0800 ZQInputView[3291:476100] 24-----Linked in 20.617008 ms
 2018-04-25 00:12:44.525379+0800 ZQInputView[3291:476100] 24-----Linked in 20.649076 ms
 2018-04-25 00:12:44.546334+0800 ZQInputView[3291:476100] 24-----Linked in 20.769000 ms
 2018-04-25 00:12:44.568425+0800 ZQInputView[3291:476100] 24-----Linked in 21.915913 ms
 2018-04-25 00:12:44.590065+0800 ZQInputView[3291:476100] 24-----Linked in 21.420002 ms
 2018-04-25 00:12:44.610732+0800 ZQInputView[3291:476100] 24-----Linked in 20.466089 ms
 2018-04-25 00:12:44.631421+0800 ZQInputView[3291:476100] 24-----Linked in 20.483017 ms
 2018-04-25 00:12:44.652786+0800 ZQInputView[3291:476100] 24-----Linked in 21.167040 ms
 2018-04-25 00:12:44.674636+0800 ZQInputView[3291:476100] 24-----Linked in 21.651030 ms
 2018-04-25 00:12:44.695938+0800 ZQInputView[3291:476100] 24-----Linked in 21.037936 ms
 2018-04-25 00:12:44.716498+0800 ZQInputView[3291:476100] 24-----Linked in 20.365000 ms
 2018-04-25 00:12:44.738176+0800 ZQInputView[3291:476100] 24-----Linked in 21.522999 ms
 2018-04-25 00:12:44.760064+0800 ZQInputView[3291:476100] 24-----Linked in 21.667957 ms
 2018-04-25 00:12:44.781910+0800 ZQInputView[3291:476100] 24-----Linked in 21.596909 ms
 2018-04-25 00:12:44.805188+0800 ZQInputView[3291:476100] 24-----Linked in 23.013949 ms
 2018-04-25 00:12:44.828680+0800 ZQInputView[3291:476100] 24-----Linked in 22.518992 ms
 2018-04-25 00:12:44.851124+0800 ZQInputView[3291:476100] 24-----Linked in 22.244930 ms
 2018-04-25 00:12:44.873735+0800 ZQInputView[3291:476100] 24-----Linked in 22.403002 ms
 2018-04-25 00:12:44.896374+0800 ZQInputView[3291:476100] 24-----Linked in 22.452950 ms
 2018-04-25 00:12:44.919721+0800 ZQInputView[3291:476100] 24-----Linked in 23.149014 ms
 2018-04-25 00:12:44.943558+0800 ZQInputView[3291:476100] 24-----Linked in 23.645997 ms
 */

@end
