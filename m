Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB2CC433FE
	for <bpf@archiver.kernel.org>; Mon,  7 Nov 2022 10:48:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231797AbiKGKsU (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 7 Nov 2022 05:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231651AbiKGKsU (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 05:48:20 -0500
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C89119005
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 02:48:19 -0800 (PST)
Received: by mail-io1-f71.google.com with SMTP id j17-20020a5d93d1000000b006bcdc6b49cbso6969433ioo.22
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 02:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9HymTYv1Z6I3VvgCZ0iLRhqEFf+ukVe1UdjyszgmAxI=;
        b=mEzzxVM41lpz9SaLKqDnBMsTqeeWu0cMRBoT7nH/9XwJbUSs39V4RfXgHDY1N04s+Z
         iQk3184kGl3hyktEmviBnVoP9Crf2yk4jJJeJ+klWB6/MMV6IRZgDVkNDiixRi9Ug0iU
         m0PuuWo/SLvn0ct4TigJI8JWmVhfRB3Yo6RJbkZ4MQ3+WLfqqeDFyssprGv6wUDGYGl5
         SiyY0ZZutUsRYVmcejluPQsq2y3GJdLU4zNPigetxfsjm2AkeZG4cssBJFDTPXCF1AIG
         Z5GIxdqboyKTQSRXf4qZhVNpfeoyQPu0Er/qF8IZ1PB2qz1lXHguUeOOMmckZeab25dy
         3Glg==
X-Gm-Message-State: ANoB5pkliW6/mItYY9R93oukCH8+rGrr6V2w7X5QAHxLSWNbkuwqshH8
        qWVYVwq5XHFg5D3lq9uuldl8xQroEytcIqbZixKdkN3gCxj6
X-Google-Smtp-Source: AA0mqf7r1E4MKid00wX0yDhGFAGS6Xo1k+8PsoDNvQMQNAUP6OuSDpJhigPiU3WHs+JavxGKKAry0mzKRG/vb8O76Qox/AZOd5qM
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1565:b0:302:c61:4c38 with SMTP id
 k5-20020a056e02156500b003020c614c38mr4401538ilu.76.1667818098935; Mon, 07 Nov
 2022 02:48:18 -0800 (PST)
Date:   Mon, 07 Nov 2022 02:48:18 -0800
In-Reply-To: <000000000000dc81b705a0af279c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000564bd705ecdf291f@google.com>
Subject: Re: [syzbot] WARNING in bpf_check (3)
From:   syzbot <syzbot+245129539c27fecf099a@syzkaller.appspotmail.com>
To:     andrii@kernel.org, andriin@fb.com, ast@kernel.org,
        bpf@vger.kernel.org, clang-built-linux@googlegroups.com,
        daniel@iogearbox.net, davem@davemloft.net, haoluo@google.com,
        hawk@kernel.org, john.fastabend@gmail.com, jolsa@kernel.org,
        kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        martin.lau@linux.dev, memxor@gmail.com, nathan@kernel.org,
        ndesaulniers@google.com, netdev@vger.kernel.org, sdf@google.com,
        shanavas@crystalwater.ae, song@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        trix@redhat.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 34dd3bad1a6f1dc7d18ee8dd53f1d31bffd2aee8
Author: Alexei Starovoitov <ast@kernel.org>
Date:   Fri Sep 2 21:10:47 2022 +0000

    bpf: Relax the requirement to use preallocated hash maps in tracing progs.

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1232e176880000
start commit:   506357871c18 Merge tag 'spi-fix-v6.0-rc4' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b95a17a5bfb1521
dashboard link: https://syzkaller.appspot.com/bug?extid=245129539c27fecf099a
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10940477080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=177e8f43080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: Relax the requirement to use preallocated hash maps in tracing progs.

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
