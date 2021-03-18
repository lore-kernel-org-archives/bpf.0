Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D8DC433E0
	for <bpf@archiver.kernel.org>; Thu, 18 Mar 2021 16:05:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF7B64E6B
	for <bpf@archiver.kernel.org>; Thu, 18 Mar 2021 16:05:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhCRQFQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Mar 2021 12:05:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:57328 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231835AbhCRQFC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Mar 2021 12:05:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EF05564E37
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 16:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616083501;
        bh=1JE/AbYPEBgdvboIFCWbKHaSN5mZtVvY2ZXvL8qGmGg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IMVd56OvJM1OrQxhXsFFfVEqgxwCyNc0xx03ZYWz1OJX23zL2duduA37qdZPMcr88
         Ma62o8jvUgVIqOhqg64oEu47OTuHVgx/hGVqADGZC8PQWugtTmCOdY+lmdkbLXsBr5
         +l3ZfxQMMUvk0HH0rWptKXTTHltzmScP20b/IOql/mY/WRLTE4C3XBSAnBnFANtRlU
         vAw50afK3olr4PY6exs0xU+TydR1LBDWJzzmch3liOVZ8v8COreWZc9nrTzD2fE9Nh
         O/epFqCvFwySNWY4ui+szKn3Mr6p6ks9g69qxuoLGu7KedHkBaPiOToRn3uO0det9U
         aXdlNO8/F9Sjg==
Received: by mail-lf1-f42.google.com with SMTP id z7so5411981lfd.5
        for <bpf@vger.kernel.org>; Thu, 18 Mar 2021 09:05:00 -0700 (PDT)
X-Gm-Message-State: AOAM533A4o1HuBVLAfP+c0qKFpxNfBXtukexxBWNsp21w5i1fCfrQnQU
        Y74b1XM3shLWUo9zr9CeWOclHM4klOg6WZ5yj756Yg==
X-Google-Smtp-Source: ABdhPJxm8BLHUnngptvtR9B67BXGQaLuZyg9n5+1UvVHJFmJ+MGUVAcGFey6xEJJ6lCrv85csCunM11iSwq/jzi/2jM=
X-Received: by 2002:a05:6512:398e:: with SMTP id j14mr6229802lfu.9.1616083499203;
 Thu, 18 Mar 2021 09:04:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAEf4BzZ2t_VbdtSde9uPEYNaggZLj3peyA8opHj1Ao_FO8AVrQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZ2t_VbdtSde9uPEYNaggZLj3peyA8opHj1Ao_FO8AVrQ@mail.gmail.com>
From:   KP Singh <kpsingh@kernel.org>
Date:   Thu, 18 Mar 2021 17:04:48 +0100
X-Gmail-Original-Message-ID: <CACYkzJ5eynv81uQ9_PA9uA=FUqva_j8MmpCgM1Pv=urVkXZsWA@mail.gmail.com>
Message-ID: <CACYkzJ5eynv81uQ9_PA9uA=FUqva_j8MmpCgM1Pv=urVkXZsWA@mail.gmail.com>
Subject: Re: test_ima passing only first time
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Sorry I totally missed this email. Taking a look now.

On Wed, Mar 10, 2021 at 10:57 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> Hey KP,
>
> test_ima is passing only the very first time I run it in my VM. Alexei
> earlier reported similar issues. If you run it second time without
> restarting the VM, you get the following:
>
> 10+0 records in
> 10+0 records out
> 10485760 bytes (10 MB, 10 MiB) copied, 0.00425121 s, 2.5 GB/s
> mke2fs 1.45.0 (6-Mar-2019)
> Discarding device blocks: done
> Creating filesystem with 10240 1k blocks and 2560 inodes
> Filesystem UUID: b9927426-1d29-458f-b2a0-8fe56455d209
> Superblock backups stored on blocks:
>         8193
>
> Allocating group tables: done
> Writing inode tables: done
> Writing superblocks and filesystem accounting information: done
>
> ./ima_setup.sh: line 53: /sys/kernel/security/ima/policy: Permission denied
> test_test_ima:PASS:skel_load 0 nsec
> test_test_ima:PASS:ringbuf 0 nsec
> test_test_ima:PASS:attach 0 nsec
> test_test_ima:PASS:mkdtemp 0 nsec
> test_test_ima:FAIL:71
> #128 test_ima:FAIL
>
> Do you see it on your side? Do you have any idea what's wrong?
>
> Also, see that super-descriptive `test_test_ima:FAIL:71` line? That's
> the reason I'm always bitching about CHECK_FAIL() use. At least this
> one is not inside some loop.
>
> -- Andrii
