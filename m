Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45903C4160E
	for <bpf@archiver.kernel.org>; Fri, 22 Jan 2021 18:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18A8923AFA
	for <bpf@archiver.kernel.org>; Fri, 22 Jan 2021 18:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbhAVR0g (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Jan 2021 12:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbhAVRFA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Jan 2021 12:05:00 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C28C061786
        for <bpf@vger.kernel.org>; Fri, 22 Jan 2021 09:04:18 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z9so4600453qtv.6
        for <bpf@vger.kernel.org>; Fri, 22 Jan 2021 09:04:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkXre3Jn5BQNLfYvq2ivFLi/y/XcVxQ/mvEDUU0zFUM=;
        b=aoCtGDeoCpDuZ1M8hmOguwCqCcdPweO66+78DRPhUdJmBTVuBVsXUOJHicfzJEjlhr
         1UVmndO5Z+DmmkChJq0UN9Qh/xWgge9WH9166mtn4yOLhj2O9703VgJc7ljORbPjqmQx
         q1LHMhoS0oPw1GyaUP4HUaagl0Q7ADyP7H1L+miS0SX//Ow6XbdZOzc6/vZT/Hcn9dR/
         vn5U4JSeqJvl8jfXqdGqZp0Emqt4T6ieC//nLtT6jFqfIhyaZPUNbfQseQBBW0zaE4wU
         0t39QbyrVWg6de/Wns7Ot/zMl/cXyHM9MQZnyP6cKYRYQP0rLiAADAy9UarF1mROSTwQ
         gFvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkXre3Jn5BQNLfYvq2ivFLi/y/XcVxQ/mvEDUU0zFUM=;
        b=YbLlozcpKwljkG2bV5Fjsxs+dr3cEC+GfdMsZrhiVPC9hW3AcAym+TmZ9c/d1XGZMe
         h+YBjEAvlE+pCtfygOpFgDRI+Kyq3ZTNv4IKBEEebbxwRj2OT9QhYwcKHqeFLfcMeMDU
         g87Pbf3ABgDHJt6ICKY/rW+v3JthkgtaEA79AxbP5tHM3xDvMjpMN668I2G6MobBvFSV
         WYOydOE2Ksm3iaIxiF49TT7pLUHHoT3pm6MZgO25mImcKkgriFR/Vkegb2aFFSrOESSk
         ZC8TDZV6Albu7WHhNh9zqxCJEoo4+4uHc7uN6hDc6GykcWvRWiut7epamGZgEwwuwkHa
         my+Q==
X-Gm-Message-State: AOAM532SCMSLY13vz8mLD8/GaK3oUyJS7ZJUdN1soASrKiWGtTVZFFsW
        P9FtcYa4E1BLsfPakEa2MrXaN11ZWzmuEn6EOxOyEg==
X-Google-Smtp-Source: ABdhPJyIloiXBIr5YvNM8BIAng+QSQEug8CjQEDk0vbyqGkd+rKpaD+MeeZqw+cctMfxM8PgY9TZXF3ZoQK/5mrXu2o=
X-Received: by 2002:ac8:524f:: with SMTP id y15mr5264291qtn.266.1611335057791;
 Fri, 22 Jan 2021 09:04:17 -0800 (PST)
MIME-Version: 1.0
References: <20210122164232.61770-1-loris.reiff@liblor.ch>
In-Reply-To: <20210122164232.61770-1-loris.reiff@liblor.ch>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 22 Jan 2021 09:04:07 -0800
Message-ID: <CAKH8qBvy0aRODNXtdseu5ygLMzAKPD-N8H1=GfGqPz--v83KpQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] bpf: cgroup: Fix optlen WARN_ON_ONCE toctou
To:     Loris Reiff <loris.reiff@liblor.ch>
Cc:     bpf <bpf@vger.kernel.org>, Netdev <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, Martin Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>, kpsingh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jan 22, 2021 at 8:43 AM Loris Reiff <loris.reiff@liblor.ch> wrote:
>
> A toctou issue in `__cgroup_bpf_run_filter_getsockopt` can trigger a
> WARN_ON_ONCE in a check of `copy_from_user`.
> `*optlen` is checked to be non-negative in the individual getsockopt
> functions beforehand. Changing `*optlen` in a race to a negative value
> will result in a `copy_from_user(ctx.optval, optval, ctx.optlen)` with
> `ctx.optlen` being a negative integer.
>
> Fixes: 0d01da6afc54 ("bpf: implement getsockopt and setsockopt hooks")
> Signed-off-by: Loris Reiff <loris.reiff@liblor.ch>
> ---
>  kernel/bpf/cgroup.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 96555a8a2..6ec8f02f4 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1442,6 +1442,11 @@ int __cgroup_bpf_run_filter_getsockopt(struct sock *sk, int level,
>                         goto out;
>                 }
>
> +               if (ctx.optlen < 0) {
> +                       ret = -EFAULT;
> +                       goto out;
> +               }
> +
>                 if (copy_from_user(ctx.optval, optval,
>                                    min(ctx.optlen, max_optlen)) != 0) {
>                         ret = -EFAULT;
> --
> 2.29.2
Good point, user's optlen can be concurrently changed after the kernel
updated it.

Reviewed-by: Stanislav Fomichev <sdf@google.com>
