Return-Path: <bpf-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 202FDC05027
	for <bpf@archiver.kernel.org>; Thu,  2 Feb 2023 23:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjBBXGd (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 2 Feb 2023 18:06:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjBBXGb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 18:06:31 -0500
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DA57909D
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 15:06:30 -0800 (PST)
Received: by mail-io1-f70.google.com with SMTP id r11-20020a6b8f0b000000b0071853768168so2034009iod.23
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 15:06:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yS69ZluBz1g0tjn3hzPqjYm4xHf7bwIwQjBQ4SRSpG8=;
        b=PzDsg2LqPHGng0S5YF3jFmOiRZGly5sdX7fVylXJYTFR0ROAKRw/V7K4fx+zD54Jri
         VxSbQXL+GnDwSC38VJBdAuXC2t1pS/9jCyDpDg6Aiv+v9nt8bbPjXVODTN/F8kvM6lh5
         TCYC2x8YwRzAlCg3QYKOsBQC+uiH9OSRhPwwlcvRcONCR8ASg1SiVx4Q2wFWY659m/tl
         zj3HvCOgjKPtT+Oljd7IXYqdeFOXdDwPmKCuyV57SfkhrtYtHVRm6Xn+HCLqzSgIWRBF
         jqtJWOsPqdd0PUsinoPkPegbHWuRSpatDkIwrHvZluozDJzKLZ6zCVhBTijOJDR6TcNt
         iTyw==
X-Gm-Message-State: AO0yUKXLOXFRFBACVAfBFU1AQX6RZHa0unEDaC2wmxE+3YorsC76gph2
        RrcVMxtrYwFoVz5mb9OH8RzLcP4UedBswHMLy86yDrXiZhmo
X-Google-Smtp-Source: AK7set/HcUh7jDIQP0/0+CxSz0TVrJgoNJNITN0WYAXolAanigKsaQ9gbYXZTh75VDzDWKeu3urX9D13aaYGsWIqDI3gZMUp3DGK
MIME-Version: 1.0
X-Received: by 2002:a05:6602:22cf:b0:704:8263:b926 with SMTP id
 e15-20020a05660222cf00b007048263b926mr1835233ioe.53.1675379189876; Thu, 02
 Feb 2023 15:06:29 -0800 (PST)
Date:   Thu, 02 Feb 2023 15:06:29 -0800
In-Reply-To: <0000000000009da4c705dcb87735@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a0f9905f3bf9d9d@google.com>
Subject: Re: [syzbot] WARNING in check_map_prog_compatibility
From:   syzbot <syzbot+e3f8d4df1e1981a97abb@syzkaller.appspotmail.com>
To:     andrii.nakryiko@gmail.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com,
        jolsa@kernel.org, kafai@fb.com, kpsingh@kernel.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, martin.lau@linux.dev, memxor@gmail.com,
        nathan@kernel.org, ndesaulniers@google.com, netdev@vger.kernel.org,
        sdf@google.com, song@kernel.org, songliubraving@fb.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

This bug is marked as fixed by commit:
bpf: Relax the requirement to use preallocated hash maps in

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=e3f8d4df1e1981a97abb

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 10 trees can be found at
https://syzkaller.appspot.com/upstream/repos
