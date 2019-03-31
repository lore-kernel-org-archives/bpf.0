Return-Path: <SRS0=ngad=SC=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 532EEC43381
	for <bpf@archiver.kernel.org>; Sun, 31 Mar 2019 18:20:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BFE720872
	for <bpf@archiver.kernel.org>; Sun, 31 Mar 2019 18:20:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731326AbfCaSUB (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sun, 31 Mar 2019 14:20:01 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:57870 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731283AbfCaSUB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 31 Mar 2019 14:20:01 -0400
Received: by mail-it1-f197.google.com with SMTP id p23so7593907itc.7
        for <bpf@vger.kernel.org>; Sun, 31 Mar 2019 11:20:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=64lyVqrAmSNqgnvvXOQw41LdifBrv+S+PiTwaiesBnk=;
        b=C9N8HT57DC5TZ6mU/smrGR0G13HHqj5/b8SBleu2ewrKNnTWDyDDJF+BWOB5A7PLfJ
         RRDyUYlBQ1DfUc0FXLY/nkk5sqs5r4ho2aWLvb/ahiSFtNHjtiPNMaI/3g42dwkGdlIn
         YVeiDvdDOSJhOEv7+YyaN+Wuvvd19MB+XuelZtd9onsGYMu6iRa/8h1ub/O8ztYFsGEX
         7z+4d8ODZrKbrjG4Ho4HdE6VGRvQEV5kj90DuLHLJvlJwTrzv8mM082k08Mu5hc5SoYe
         MlrAkh+NniH9lAmVNpmWQYC/FEN3xkpCVEJmiPcGbChXlfeuTJA89qVMF++QNrFteYso
         u+0A==
X-Gm-Message-State: APjAAAV0ZGPYJMnGtLes6ooq0Ljme2eYBjtNZcPaJe/Ymtpi/t1QYGrz
        WGba2D/lW1GKhg+Vi0asfinOUvZbhVXfxOE+NgyjcseQJ3E6
X-Google-Smtp-Source: APXvYqwYc7YT95rQW3y3YkH0IjCUzv6zgypejJek1mPQFMyraQ3qD0wYSln+d2ySQbcyidRmMyizHd9+5gHqDAuEqkVUFpX78+wy
MIME-Version: 1.0
X-Received: by 2002:a5d:8c8f:: with SMTP id g15mr8814847ion.36.1554056400848;
 Sun, 31 Mar 2019 11:20:00 -0700 (PDT)
Date:   Sun, 31 Mar 2019 11:20:00 -0700
In-Reply-To: <000000000000e92d1805711f5552@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bbcb82058567f37d@google.com>
Subject: Re: WARNING in bpf_jit_free
From:   syzbot <syzbot+2ff1e7cb738fd3c41113@syzkaller.appspotmail.com>
To:     airlied@linux.ie, ast@kernel.org, bpf@vger.kernel.org,
        daniel@ffwll.ch, daniel@iogearbox.net, davem@davemloft.net,
        dri-devel@lists.freedesktop.org, hawk@kernel.org,
        jakub.kicinski@netronome.com, john.fastabend@gmail.com,
        kafai@fb.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, maxime.ripard@bootlin.com,
        netdev@vger.kernel.org, paul.kocialkowski@bootlin.com,
        songliubraving@fb.com, syzkaller-bugs@googlegroups.com,
        wens@csie.org, xdp-newbies@vger.kernel.org, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit 0fff724a33917ac581b5825375d0b57affedee76
Author: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Date:   Fri Jan 18 14:51:13 2019 +0000

     drm/sun4i: backend: Use explicit fourcc helpers for packed YUV422 check

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1467550f200000
start commit:   0e40da3e Merge tag 'kbuild-fixes-v5.1' of git://git.kernel..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1667550f200000
console output: https://syzkaller.appspot.com/x/log.txt?x=1267550f200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8dcdce25ea72bedf
dashboard link: https://syzkaller.appspot.com/bug?extid=2ff1e7cb738fd3c41113
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16973653200000

Reported-by: syzbot+2ff1e7cb738fd3c41113@syzkaller.appspotmail.com
Fixes: 0fff724a3391 ("drm/sun4i: backend: Use explicit fourcc helpers for  
packed YUV422 check")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
