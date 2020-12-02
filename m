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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A89FCC64E8A
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 01:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 584692220B
	for <bpf@archiver.kernel.org>; Wed,  2 Dec 2020 01:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbgLBBZT (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 1 Dec 2020 20:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgLBBZS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Dec 2020 20:25:18 -0500
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com [IPv6:2607:f8b0:4864:20::b41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA11C0613D6;
        Tue,  1 Dec 2020 17:24:32 -0800 (PST)
Received: by mail-yb1-xb41.google.com with SMTP id s8so101069yba.13;
        Tue, 01 Dec 2020 17:24:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=STVF/ryvADGkGMK7DNHXzwlJ5JL3imCy6lZ6BF1wMKE=;
        b=dpSl1EuPN8vw/N4sDBBP8dnWGXDCYB0ca5jkjjdSCiHyV7+lqZv62mAvLlzbKVoxI0
         EOdcBcwtIYUPRBhOfoJ5HAUi4fYRTXEdFpcxp4orRNSci/YZhPLbFJwGAHDWRAxrttZ4
         7c5Y4r7Nt3/Z4Nz9SbQq+KskqDihm+QDX2bUtGluJ8V438mSIcCXokle9Ch8rCav3a9f
         gGbXTcdNlJc2XrLjcRJ0FxVJa6iX6qOiqqn9oRmy3C61P1goQoSUGUdrKyRMYfWlfjmD
         X9FEs6Kw/eKI34A4inL7lcKRXqpuB7EGzSE539xpyckWjOxVI3rmGcJM0sjJyYR7UON9
         SY3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=STVF/ryvADGkGMK7DNHXzwlJ5JL3imCy6lZ6BF1wMKE=;
        b=t7w6ZpfhsNG2P467XH9orczNm9xZyRux8Y7TfAh6dlQgGJA8gxAjeeHupPm4JuGMTZ
         5zOZuZohhJ1QsnySVBLNQXYhZxIS2GCgAHBhKzeZGxKT/j8C7g3RKTPrE4EVvFu4KlIk
         oPA6unhW5d1griXVw0eJI2qD5W+XZRiOmuMwCdkuPjx5HIBQl0udV1dRjg9gs3PMXWXB
         VsYaz2x26qaXUD2hh/KIcAE4WJJaOYr5qzSjgQMm6TbBf8QO/OW/b6d4+8k+n11nzIyz
         trCED/GAYUlq2DcSl+vadCwaLkzPJtQ4vcNRuLljrfgGcATQM8YFatIV2CaQKe7Yw6g7
         BmUA==
X-Gm-Message-State: AOAM533QHTqdxJ6XqN5u5nIrVupnVL6sKexG8BqWLZyCBNnfcQhlhsgU
        l1M/KGUaL0tSwhuUWuf2SO3mVhJqBa4G/D3lihU=
X-Google-Smtp-Source: ABdhPJz36D9qZ28r003t8vIswx9m70aeiSWOddpiPpsZB1sTGsyZYk7QMZlS20cBTaz0aBwVIHv+htvXMzH1UjuzVXU=
X-Received: by 2002:a25:2845:: with SMTP id o66mr361759ybo.260.1606872271921;
 Tue, 01 Dec 2020 17:24:31 -0800 (PST)
MIME-Version: 1.0
References: <20201128192502.88195-1-dev@der-flo.net> <20201128192502.88195-2-dev@der-flo.net>
In-Reply-To: <20201128192502.88195-2-dev@der-flo.net>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 1 Dec 2020 17:24:21 -0800
Message-ID: <CAEf4BzbfDGQoazRO-ZZAksxSc_j5HMOpAPLx57A0UjR7JjAYDg@mail.gmail.com>
Subject: Re: [PATCH 1/2] selftests/bpf: Avoid errno clobbering
To:     Florian Lehner <dev@der-flo.net>
Cc:     bpf <bpf@vger.kernel.org>, Networking <netdev@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        john fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@google.com>,
        Krzesimir Nowak <krzesimir@kinvolk.io>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Nov 28, 2020 at 11:28 AM Florian Lehner <dev@der-flo.net> wrote:
>
> Commit 8184d44c9a57 ("selftests/bpf: skip verifier tests for unsupported
> program types") added a check to skip unsupported program types. As
> bpf_probe_prog_type can change errno, do_single_test should save it before
> printing a reason why a supported BPF program type failed to load.
>
> Fixes: 8184d44c9a57 ("selftests/bpf: skip verifier tests for unsupported program types")
> Cc: Stanislav Fomichev <sdf@google.com>
> Cc: Krzesimir Nowak <krzesimir@kinvolk.io>
> Signed-off-by: Florian Lehner <dev@der-flo.net>
> ---

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  tools/testing/selftests/bpf/test_verifier.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
> index 4bfe3aa2cfc4..ceea9409639e 100644
> --- a/tools/testing/selftests/bpf/test_verifier.c
> +++ b/tools/testing/selftests/bpf/test_verifier.c
> @@ -936,6 +936,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>         int run_errs, run_successes;
>         int map_fds[MAX_NR_MAPS];
>         const char *expected_err;
> +       int saved_errno;
>         int fixup_skips;
>         __u32 pflags;
>         int i, err;
> @@ -997,6 +998,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>         }
>
>         fd_prog = bpf_load_program_xattr(&attr, bpf_vlog, sizeof(bpf_vlog));
> +       saved_errno = errno;
>
>         /* BPF_PROG_TYPE_TRACING requires more setup and
>          * bpf_probe_prog_type won't give correct answer
> @@ -1013,7 +1015,7 @@ static void do_test_single(struct bpf_test *test, bool unpriv,
>         if (expected_ret == ACCEPT || expected_ret == VERBOSE_ACCEPT) {
>                 if (fd_prog < 0) {
>                         printf("FAIL\nFailed to load prog '%s'!\n",
> -                              strerror(errno));
> +                              strerror(saved_errno));
>                         goto fail_log;
>                 }
>  #ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
> --
> 2.28.0
>
