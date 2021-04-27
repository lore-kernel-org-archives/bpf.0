Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33034C43460
	for <bpf@archiver.kernel.org>; Tue, 27 Apr 2021 18:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BC0E613C0
	for <bpf@archiver.kernel.org>; Tue, 27 Apr 2021 18:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237442AbhD0SG2 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 27 Apr 2021 14:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236552AbhD0SG1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Apr 2021 14:06:27 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34A47C061574;
        Tue, 27 Apr 2021 11:05:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 124so14025785lff.5;
        Tue, 27 Apr 2021 11:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=voehpRrgPSUyKAUYqMCooYCC9snBLdd6zp79y1bt9aU=;
        b=LXUImeXNzzBi3a2W//2YnoQbN9d8sMAeTW8gAjiIk0GVXqo1YUx3iMua+u/ZY4vg3N
         DCf5T6XxXeebuGhZk9sujNmaemA9YRIob4U8GPmvP7EYTo71DLFzs2Nz2gYZjrR7n2oS
         v6ywlfFAYrlyWbWiV1zGb3NH1Z/0sixxh5Vy867684O0ohAzOX2rSg8ZB9IVT+a2ylsB
         fjkNIlzemow8mRzubWbpcGNaZaGEz/a4xjUDo+/15dSKCW5yXMrA/GgvKAFTW48rH0aH
         MbdY8J7DsBsj4sILhSFQIhazG9O1ojPRbViKLHPk1MbbJi5IkiRiL6Fs0wowRHPZHeF6
         +WgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=voehpRrgPSUyKAUYqMCooYCC9snBLdd6zp79y1bt9aU=;
        b=HodtMskljA7eHJJLsziFVFTsKHLpLA1mdy/Ptopiy6PRxdzwho4GXX4KuUOx79AI8M
         5UOiZt4cYRVD9sjsPXCutMG4Q7VJgPyYybwda6MEQljthHH5hb/gcE6TWbu/KGfoH2p+
         JbPcQstIX6ubZgCyek1bB41HxSg2l2+3dUPAtlxjGiHzfACzewrJM7Dgb8swDhyYiQlm
         hpMX2a8dHU/pBGu9YTVMqKM9OS1nzMHP9plVLncEHj0ob8EhIeF1MMfpWnY/TJTsqtKk
         dsu6oCGPs20FScxzVl8zGxyb4NvXdaCN2k0Uu3dm6hfv9d97TOkVQN7teCkesRWOQJkZ
         DAFQ==
X-Gm-Message-State: AOAM532BaVnDtX3jx/wBnWfiopTxs+HB100US4vEAB4Cfzvcv9krtJaX
        ndZCGCfisKH+F2kaoIrdt7POI6cxLSfjQSMH13E=
X-Google-Smtp-Source: ABdhPJzw72zeE2/7nP38aq6iRM+kP7rwVWlTw2BFQDLCGuSlHWkgR+cxnHReunB+w6mVyCpN1/L+jYKxKRLjFJ8WRwU=
X-Received: by 2002:ac2:510d:: with SMTP id q13mr18081232lfb.75.1619546742689;
 Tue, 27 Apr 2021 11:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210421130105.1226686-1-gregkh@linuxfoundation.org>
 <20210421130105.1226686-67-gregkh@linuxfoundation.org> <YIhQsRZ9LgZKlkPw@kroah.com>
In-Reply-To: <YIhQsRZ9LgZKlkPw@kroah.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 27 Apr 2021 11:05:30 -0700
Message-ID: <CAADnVQKrsue+0tCCjU9wzGALPqWZXF2vxUH1hJuF7uJkf5x+oQ@mail.gmail.com>
Subject: Re: [PATCH 066/190] Revert "bpf: Remove unnecessary assertion on fp_old"
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Aditya Pakki <pakki001@umn.edu>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Apr 27, 2021 at 10:59 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Apr 21, 2021 at 02:59:01PM +0200, Greg Kroah-Hartman wrote:
> > This reverts commit 5bf2fc1f9c88397b125d5ec5f65b1ed9300ba59d.
> >
> > Commits from @umn.edu addresses have been found to be submitted in "bad
> > faith" to try to test the kernel community's ability to review "known
> > malicious" changes.  The result of these submissions can be found in a
> > paper published at the 42nd IEEE Symposium on Security and Privacy
> > entitled, "Open Source Insecurity: Stealthily Introducing
> > Vulnerabilities via Hypocrite Commits" written by Qiushi Wu (University
> > of Minnesota) and Kangjie Lu (University of Minnesota).
> >
> > Because of this, all submissions from this group must be reverted from
> > the kernel tree and will need to be re-reviewed again to determine if
> > they actually are a valid fix.  Until that work is complete, remove this
> > change to ensure that no problems are being introduced into the
> > codebase.
> >
> > Cc: Aditya Pakki <pakki001@umn.edu>
> > Cc: Daniel Borkmann <daniel@iogearbox.net>
> > Cc: https
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  kernel/bpf/core.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
> > index 75244ecb2389..da29211ea5d8 100644
> > --- a/kernel/bpf/core.c
> > +++ b/kernel/bpf/core.c
> > @@ -230,6 +230,8 @@ struct bpf_prog *bpf_prog_realloc(struct bpf_prog *fp_old, unsigned int size,
> >       struct bpf_prog *fp;
> >       u32 pages;
> >
> > +     BUG_ON(fp_old == NULL);
> > +
> >       size = round_up(size, PAGE_SIZE);
> >       pages = size / PAGE_SIZE;
> >       if (pages <= fp_old->pages)
> > --
> > 2.31.1
> >
>
> The original commit here is correct, I'll drop this revert.

Yes. No need to revert. The original commit removed BUG_ON and it's fine.
Thanks for checking.
