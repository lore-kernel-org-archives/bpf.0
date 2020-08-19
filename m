Return-Path: <SRS0=4a0o=B5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF5EC433E3
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 18:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F36D620658
	for <bpf@archiver.kernel.org>; Wed, 19 Aug 2020 18:32:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597861951;
	bh=JTCYO8qkHEiuX+BlGTWxjy1hbhVzsbjzkn2WWsZSY0Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=qTx+vE8MRIUIb7n45ZUalrX1LyTk9xP1UaBG1aWJ6WkbKfU7l69G5TiJjhAYd0q3D
	 3RDd4tBoXrVNmGBFfrOaQOZSxfn/V8L9ahiuXVoVrHMiKyPmMhGyz2evHdB0oo6v2y
	 0mEEH6YhVKT+nwKhcHGYrm0+s45TlzoycxZWKx/w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgHSSca (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 19 Aug 2020 14:32:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgHSSc1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Aug 2020 14:32:27 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDD1C061383
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 11:32:26 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id v4so26531060ljd.0
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 11:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PCuKkyRxcbup4ABdZGpC9XS5K02qBsfUZIlHBjZs1pc=;
        b=YN7mKrskvwWbX56uQExfTWNmH6b7b06GM1t6v6PKQMs/53B4exuT41lXnTdk02Vy1a
         kyWEZ0RcGu5BbhBuNhEnWP2R+82h3AWl7VuY+FT8Owk6ALwcQj9n43iDoTjn/PJjStUs
         +r7PqpmcMgHSVrmWSkasonWj1JvkoFL9fZBlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PCuKkyRxcbup4ABdZGpC9XS5K02qBsfUZIlHBjZs1pc=;
        b=mN4cLk/HpzIQrYRdmG//cqN+JGHJwTYbJ62N6OHI4Si7yfHSLLnbqPhUwF7542VVjY
         1eBRzfrHDKaiPj6oSBNSV2LyF3lLWOneNsA7hbc+vhOt1X6nS+zGfoDk/SjQ6JbzSTVO
         VbVZ3czSTk+FW4b1H7KwwghiexJeCzuqcues6HL+pA8D3X16qU978j2ytclEJ/uDZ7JK
         oeSoP2WB4S7gp/lwRQh+ogZeQbCXpk3tsfP8kYHDcrB9yB2aobhJZ1dYfoSA2ULgO122
         5fIT9Ua1uNEU+SWI4RPqYVOD8hN1s3miVg8tctRzWnYz07CIy3zQzR+pG0epkjCK22Rt
         2BFA==
X-Gm-Message-State: AOAM530HuA2/sYTdhvStGptRU3Rv5q6Djmou4x2nC8NaY+AIICvLSB8S
        YXUqNiPbW9eBu7UiKlOKuTP2i//L1aD6DA==
X-Google-Smtp-Source: ABdhPJyOorufACqZ0WjRj1G6BZcP+Awaf9TfakCpSh6pfKXPlDEdDQ/wol9WFovi2HgIxPGMrnN7Bw==
X-Received: by 2002:a2e:b010:: with SMTP id y16mr13276985ljk.391.1597861943683;
        Wed, 19 Aug 2020 11:32:23 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id w19sm6734624ljd.112.2020.08.19.11.32.21
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Aug 2020 11:32:22 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id t6so26476091ljk.9
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2020 11:32:21 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr13526311ljf.285.1597861941474;
 Wed, 19 Aug 2020 11:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <87ft8l6ic3.fsf@x220.int.ebiederm.org> <20200817220425.9389-9-ebiederm@xmission.com>
 <CAHk-=whCU_psWXHod0-WqXXKB4gKzgW9q=d_ZEFPNATr3kG=QQ@mail.gmail.com>
 <875z9g7oln.fsf@x220.int.ebiederm.org> <CAHk-=wjk_CnGHt4LBi2WsOeYOxE5j79R8xHzZytCy8t-_9orQw@mail.gmail.com>
 <20200818110556.q5i5quflrcljv4wa@wittgenstein> <87pn7m22kn.fsf@x220.int.ebiederm.org>
In-Reply-To: <87pn7m22kn.fsf@x220.int.ebiederm.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Aug 2020 11:32:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8BQbgJFLa+J0e=iT-1qpmCRTbPAJ8gd6MJQ=kbRPqyQ@mail.gmail.com>
Message-ID: <CAHk-=wj8BQbgJFLa+J0e=iT-1qpmCRTbPAJ8gd6MJQ=kbRPqyQ@mail.gmail.com>
Subject: Re: [PATCH 09/17] file: Implement fnext_task
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "<linux-fsdevel@vger.kernel.org>" <linux-fsdevel@vger.kernel.org>,
        criu@openvz.org, bpf <bpf@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Cyrill Gorcunov <gorcunov@gmail.com>,
        Jann Horn <jann@thejh.net>, Kees Cook <keescook@chromium.org>,
        =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Matthew Wilcox <willy@debian.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Matthew Wilcox <matthew@wil.cx>,
        Trond Myklebust <trond.myklebust@fys.uio.no>,
        Chris Wright <chrisw@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Aug 19, 2020 at 6:25 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> So I sat down and played with it and here is what I wound up with is:
>
> __fcheck_files -> files_lookup_fd_raw
> fcheck_files   -> files_lookup_fd_locked
> fcheck_files   -> files_lookup_fd_rcu
> fcheck         -> lookup_fd_rcu
> ...
> fcheck_task    -> task_lookup_fd_fcu
> fnext_task     -> task_lookup_next_fd_rcu

This certainly looks fine to me. No confusion about what it does. So Ack.

                   Linus
