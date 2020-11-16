Return-Path: <bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FDAC6379D
	for <bpf@archiver.kernel.org>; Mon, 16 Nov 2020 14:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 280D2206F9
	for <bpf@archiver.kernel.org>; Mon, 16 Nov 2020 14:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iyTqTWge"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728759AbgKPOtW (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 16 Nov 2020 09:49:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730595AbgKPOtV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Nov 2020 09:49:21 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F285DC0613CF
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 06:49:20 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id u18so25450393lfd.9
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2020 06:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K9YYtxJZQ61dSHuSpVyOeAjqq4q4KVseeuBlzImXEsk=;
        b=iyTqTWgek9bpE1bnvCpobrfYhS0xCjKb3JBPV+nxXvs4iD6Z/VuKvsdWJkQfGdMT24
         a0aVXFiD7UOh2jj1/LZ8S17qmTdHdU0v+GxXMKhiRAlpGNrhLZ54+DwuC5RZyHzSx/UD
         2NnvlyyG4FPwdQOiosGPPn8y8am71+tfm9RPg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K9YYtxJZQ61dSHuSpVyOeAjqq4q4KVseeuBlzImXEsk=;
        b=q1RA4Pzf09XXo9olOrIQjkMAMe6IeNM1yX0X5ejFoy68GFojjfdXeKcL1Xv5caS7o1
         dXINsKRU8IlYrIQWp02kRJrNYCKhGazno+VGKDWv3HL4kgcoHPMStvf4n+btjrfJBgk9
         Yf9KaP7kjiIPjC/aN+u+kSULuI7z5W7G9V6HqoXtXIUq2/Y3Gu2MpmsLygN30lThyTwg
         SkPCtTTgjp5hLnSGXeq4K1E922cPRpjy28tqhDtKYZzTJWEjrr9JDiE5SXYVGhU73rhu
         nXRcq+UKy/tPTAvYeASMfUnjYCE7HJb5srs05IK+LHoINeP2MQ/3FaDCh0MWN+hfsujo
         H2Qw==
X-Gm-Message-State: AOAM5327G+cciAN7yPYGWAd0lINNEOZNpGdsyAZAD2dqbtS1Uuxz5xpL
        ED21cED813Oxh2EDQM7bzTPs5SWWxdG3TzZim3k/Ww==
X-Google-Smtp-Source: ABdhPJybKMFf5F9fDnkcEIlA3gETcN9cfU8sjsqKeX/1OowNQYDHMKgr3Z4bnO8+xXrWp/CToC+gA2tOJl/m2hJTgWo=
X-Received: by 2002:ac2:5591:: with SMTP id v17mr5379656lfg.562.1605538159370;
 Mon, 16 Nov 2020 06:49:19 -0800 (PST)
MIME-Version: 1.0
References: <20201116140110.1412642-1-kpsingh@chromium.org> <20201116140110.1412642-2-kpsingh@chromium.org>
In-Reply-To: <20201116140110.1412642-2-kpsingh@chromium.org>
From:   KP Singh <kpsingh@chromium.org>
Date:   Mon, 16 Nov 2020 15:49:08 +0100
Message-ID: <CACYkzJ4qpyP_tF+-AG6ukA1DLJJzV2xmaVO4r08bUMUCvOAT1g@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] bpf: Add tests for bpf_lsm_set_bprm_opts
To:     open list <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Paul Turner <pjt@google.com>,
        Pauline Middelink <middelin@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

[...]

> +
> +#include "vmlinux.h"
> +#include <errno.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +
> +char _license[] SEC("license") = "GPL";
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
> +       __uint(map_flags, BPF_F_NO_PREALLOC);
> +       __type(key, int);
> +       __type(value, int);
> +} secure_exec_task_map SEC(".maps");
> +
> +SEC("lsm/bprm_creds_for_exec")
> +int BPF_PROG(secure_exec, struct linux_binprm *bprm)
> +{
> +       int *secureexec;
> +
> +       secureexec = bpf_task_storage_get(&secure_exec_task_map,
> +                                  bpf_get_current_task_btf(), 0,
> +                                  BPF_LOCAL_STORAGE_GET_F_CREATE);
> +       if (!secureexec)
> +               return 0;
> +
> +       if (*secureexec)
> +               bpf_lsm_set_bprm_opts(bprm, BPF_LSM_F_BPRM_SECUREEXEC);

This can just be:

       if (secureexec && *secureexec)
                  bpf_lsm_set_bprm_opts(bprm, BPF_LSM_F_BPRM_SECUREEXEC);

               bpf_lsm_set_bprm_opts(bprm, BPF_LSM_F_BPRM_SECUREEXEC);

> +       return 0;
> +}
> --
> 2.29.2.299.gdc1121823c-goog
>
