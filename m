Return-Path: <SRS0=ErZJ=SV=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=DATE_IN_PAST_06_12,
	FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA60EC282DA
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 20:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 981812171F
	for <bpf@archiver.kernel.org>; Fri, 19 Apr 2019 20:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfDSUCq (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 19 Apr 2019 16:02:46 -0400
Received: from mail-it1-f197.google.com ([209.85.166.197]:33281 "EHLO
        mail-it1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbfDSUCq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 19 Apr 2019 16:02:46 -0400
Received: by mail-it1-f197.google.com with SMTP id t13so7515207itk.0
        for <bpf@vger.kernel.org>; Fri, 19 Apr 2019 13:02:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=9GG250W1uR9v7CnVvHHW+E6SPNHnBXsTXZ6Fs+l+fvk=;
        b=AxVkwah4lhhOeOml42C+n5rpv6GnO+iTwevVqqoBvGswyIsZ8lGnJXZ4mY2ceAAYmh
         GW0p8xz6esJAV71yoPVTw0ZGvCCu7qGJipU6GoddK7uxRtmwmS/kB+/6BvEMULyWDJUU
         wtIzv77BGLB0dY1SQew0BftxPIOAJ23jP/WzqQ7C6Tbh6TaTBDlJnmB61EqVu8bXynv6
         2jwXF4cHA4ugQnkpiyJdi15vJObuPa0Nq74qMuqlaB5GrgePZENo4P7QYsGZlnq3ub5H
         L93wnhJ2AxEqyOcRzn8/04FvNjcug6araMfn9g8LJiesUAqL2VQA+3mMI/PxSvhuH+HL
         NKfg==
X-Gm-Message-State: APjAAAVNN/8DvPEswiODVXJtp84XnxgTcdChYZRSHXCkKxjouGhk/vS4
        40RC68hjK4zz/oSLBhAht4gCI3s38UOrWcH0xnn41zvmpqwr
X-Google-Smtp-Source: APXvYqxwTd3P66I9Qzs2OGTstgOgAtAsleLVLGNtfyV0RBpMHZtRWiEwZYu8LU3gCmGGr0arownWf5uLyXPHiB7cQExfurd1jBmE
MIME-Version: 1.0
X-Received: by 2002:a05:660c:20e:: with SMTP id y14mr1812862itj.17.1555662060542;
 Fri, 19 Apr 2019 01:21:00 -0700 (PDT)
Date:   Fri, 19 Apr 2019 01:21:00 -0700
In-Reply-To: <0000000000004a6d7c057e77e97e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008265310586ddcc2a@google.com>
Subject: Re: KASAN: use-after-free Read in refcount_sub_and_test_checked (2)
From:   syzbot <syzbot+b0775615fa4c4479b691@syzkaller.appspotmail.com>
To:     -O-request@vger.kernel.org, acme@kernel.org, aisheng.dong@nxp.com,
        alexander.shishkin@linux.intel.com, andrew.hendry@gmail.com,
        ast@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        davem@davemloft.net, dvlasenk@redhat.com, fabio.estevam@nxp.com,
        gregkh@linuxfoundation.org, jolsa@redhat.com, kafai@fb.com,
        kernel@pengutronix.de, linux-kernel@vger.kernel.org,
        linux-x25@vger.kernel.org, mingo@redhat.com, ms@dev.tdt.de,
        mturquette@baylibre.com, namhyung@kernel.org,
        netdev@vger.kernel.org, peterz@infradead.org, sboyd@kernel.org,
        shawnguo@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot has bisected this bug to:

commit cd67d3272768aa3f44c0f7cc71b82a112dce01fa
Author: Aisheng Dong <aisheng.dong@nxp.com>
Date:   Thu Jan 24 13:22:49 2019 +0000

     clk: imx: scu: add fallback compatible string support

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11f0432d200000
start commit:   6d906f99 Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13f0432d200000
console output: https://syzkaller.appspot.com/x/log.txt?x=15f0432d200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=856fc6d0fbbeede9
dashboard link: https://syzkaller.appspot.com/bug?extid=b0775615fa4c4479b691
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15df396b200000

Reported-by: syzbot+b0775615fa4c4479b691@syzkaller.appspotmail.com
Fixes: cd67d3272768 ("clk: imx: scu: add fallback compatible string  
support")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
