Return-Path: <SRS0=66DU=DI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3671FC4727E
	for <bpf@archiver.kernel.org>; Thu,  1 Oct 2020 21:12:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F206320796
	for <bpf@archiver.kernel.org>; Thu,  1 Oct 2020 21:12:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="tkrBQe3E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbgJAVHI (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 1 Oct 2020 17:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgJAVGt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Oct 2020 17:06:49 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20490C0613E2
        for <bpf@vger.kernel.org>; Thu,  1 Oct 2020 14:06:49 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id i26so10101716ejb.12
        for <bpf@vger.kernel.org>; Thu, 01 Oct 2020 14:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GJfQdlSGvnYX8WTWiSSvgRRMTzNs36g2ODPiTwjRAs8=;
        b=tkrBQe3EU3XlxTk9RswYWhAU4d1iEgcKP+mNKsyk7QnifbEkLUVCT/Bz9HiE4WZDH9
         kPwoGKUUr+ktBtCxlwk704U4nOoVOcFG4gZqxD8/WNDpZpcxtCXcBKHmqjgCOI2sZjKz
         RIHBYbLW3UYEy3kwlVU6CHuZOl2ouk0fj2blw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GJfQdlSGvnYX8WTWiSSvgRRMTzNs36g2ODPiTwjRAs8=;
        b=oRBT6N4IkTI1bg7EsacDzVOQ2DsH9BIcZmM2w/Mc7858Ikiaq3oCZPBBxlOeXi3UAX
         uJ50xTCJL5sNusjXnneXqkN/rFGGWeEG8QH6cB3R4dC3zL0r1kBHz1J06c4WqQOlY/Yz
         ryOjpqEbk1gVGfMhMSWgirpSBi7bbf2LT9WNWQwrrmUc2YKaVkMaxJs/p8UMAd0MlkgS
         1l63RVQFEgJd81VsE1CcFJrFnoLvx/KTvGctqgZ+bq8iXGARYqD9652Tog/UUnf571QH
         LBNP/MzH71PoUWqllPYrEGa3ng6iMHxUp5MwG+lB7y3U6txu1OrWjxbKj+BMDxNdrlbz
         kL4Q==
X-Gm-Message-State: AOAM531PXopBxNTL+HRz1/bxULIn88pSM6bBDu1dkG28NMzjkU32+CpL
        lZ63UUKqBpzhHYwXTzF0eFawzBtcE1hcgvpnLcSVhA==
X-Google-Smtp-Source: ABdhPJwvS6nNR0DvYHDBM04oUTIB+MUropRM/aV9HBVmK+CT5YH4iBVjeeDR8WdQ3dsdp+vdjAc8sF9ARo7WZujAD1Q=
X-Received: by 2002:a17:906:3e0c:: with SMTP id k12mr10020262eji.189.1601586407475;
 Thu, 01 Oct 2020 14:06:47 -0700 (PDT)
MIME-Version: 1.0
References: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
In-Reply-To: <45f07f17-18b6-d187-0914-6f341fe90857@gmail.com>
From:   Sargun Dhillon <sargun@sargun.me>
Date:   Thu, 1 Oct 2020 14:06:10 -0700
Message-ID: <CAMp4zn9XA-z_6UKvWkFh_U2wPRjZF3=QvrXX7EikO5AEovCWBA@mail.gmail.com>
Subject: Re: For review: seccomp_user_notif(2) manual page
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Kees Cook <keescook@chromium.org>,
        Christian Brauner <christian@brauner.io>,
        linux-man <linux-man@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Aleksa Sarai <cyphar@cyphar.com>, Jann Horn <jannh@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Will Drewry <wad@chromium.org>, bpf@vger.kernel.org,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andy Lutomirski <luto@amacapital.net>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Robert Sesek <rsesek@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Sep 30, 2020 at 4:07 AM Michael Kerrisk (man-pages)
<mtk.manpages@gmail.com> wrote:
>
> Hi Tycho, Sargun (and all),
>
> I knew it would be a big ask, but below is kind of the manual page
> I was hoping you might write [1] for the seccomp user-space notification
> mechanism. Since you didn't (and because 5.9 adds various new pieces
> such as SECCOMP_ADDFD_FLAG_SETFD and SECCOMP_IOCTL_NOTIF_ADDFD
> that also will need documenting [2]), I did :-). But of course I may
> have made mistakes...
>
> I've shown the rendered version of the page below, and would love
> to receive review comments from you and others, and acks, etc.
>
> There are a few FIXMEs sprinkled into the page, including one
> that relates to what appears to me to be a misdesign (possibly
> fixable) in the operation of the SECCOMP_IOCTL_NOTIF_RECV
> operation. I would be especially interested in feedback on that
> FIXME, and also of course the other FIXMEs.
>
> The page includes an extensive (albeit slightly contrived)
> example program, and I would be happy also to receive comments
> on that program.
>
> The page source currently sits in a branch (along with the text
> that you sent me for the seccomp(2) page) at
> https://git.kernel.org/pub/scm/docs/man-pages/man-pages.git/log/?h=seccomp_user_notif
>
> Thanks,
>
> Michael
>
> [1] https://lore.kernel.org/linux-man/2cea5fec-e73e-5749-18af-15c35a4bd23c@gmail.com/#t
> [2] Sargun, can you prepare something on SECCOMP_ADDFD_FLAG_SETFD
>     and SECCOMP_IOCTL_NOTIF_ADDFD to be added to this page?
>
> ====
>
> --
> Michael Kerrisk
> Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
> Linux/UNIX System Programming Training: http://man7.org/training/

Should we consider the SECCOMP_GET_NOTIF_SIZES dance to be "deprecated" at
this point, given that the extensible ioctl mechanism works? If we add
new fields to the
seccomp datastructures, we would move them from fixed-size ioctls, to
variable sized
ioctls that encode the datastructure size / length?

-- This is mostly a question for Kees and Tycho.
