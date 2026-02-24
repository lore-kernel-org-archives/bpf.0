Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778012765C4
	for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 22:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771970655; cv=pass; b=vDjlmCXif0fioIdZTnQrfw3cxSRU3WMT31t2UIfF0/AWxQ3EISAKtYpMsuB7wmB1hvnAbprbOj2/FvC35Q136oa9k5Hgu6YjI8X1mLDNkTRk3E52GsfnLXjzAoDb44b9O0vSYWG39cijZpZlZwX3NevafQdf+tUV5S0Qi6+d5ek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771970655; c=relaxed/simple;
	bh=Kji4CKWQfbqmwIXEd6B5VeuYLM52cYxwDoV8Fagu9/0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=njEpICYGub0AiGykip61oYMCUMqZDe3cbccqQsYSUAGARyJQ6aAJ1kVOCgltFkZeIopuT4VFIpOi8epM3/pVKbAZ1K4w/icbhs880QxP6REPgv1lPkpFDtUOji/gghXU6iErXdWpZkAFPgxsdNb1dve/7LQhkNqsij/m4oz1t6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ET8pFTEc; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET8pFTEc"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ad79dfb6eso6054720d50.0
        for <bpf@vger.kernel.org>; Tue, 24 Feb 2026 14:04:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771970653; cv=none;
        d=google.com; s=arc-20240605;
        b=OD1pr/chJ/eiR6Bh64BfQzIv0gP87DAjDWevmTNbqCVZ5TdGRIVGnAw5EP+w2Lse30
         U/x7qVv/uR3DM1tB7vQz26ZUoSh384aX+/qwrn23/TckS4D1b4fHCD/MhxmA3Csp+8XB
         XT6dVhRNK7bgsKvUjUTV8EZADm6kodBDUq/+apwyCDimVQimEx2SXCthAFAQnD7J+lz3
         oFUyyvXvQDuNTVYTdnHDaGHb65dycyt+OLxn5Wwlt1nNfD4przw9vO/j48xQE8aZbxhH
         d8pe37/dj++QuFdn9/ivoVvThb91LY28tt2/lQ0j4v81la4w0XiQ7HCBEgvyUL0k733q
         C+gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rID69f081BV9g7oIH/IgzgsDV6HI0SICxo1BJHLUf+Y=;
        fh=MmfgE51KrUb6DiSIxk9FCBfQWUAtqoUU+Dfpq5pbLQI=;
        b=PGcpe1H3TKNpo47If46NK4aZ303/TVMvBSqM+9AsjpStLmUmM/ixNI9d8Z2rWXfg2l
         1cgqlw8g3H0pj0CUU85sL1GEXnRcZUJIjvkdHwb9sAhZxDnD9xM2SJQg//PuBowV4Dai
         wpOR26+7kfVt8bfK3N9y7a8PBMjTsYLLP0cDuGL+6vvwMgP/dfrtv2NL6kDdhQE2k/ay
         0PFQD9ztkLdHTXaaBnaz5s9jc2FLiSjh8ch8CZcPjh1YmYTYIKdnDiDaFMq8z83Wh4K4
         ChnKT3OF/PRSrpktDfTZg80goGOhSzavZPoqLs9C+ykXjhy/hTvc1KlXVX04Fg7EgReW
         rQVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771970653; x=1772575453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rID69f081BV9g7oIH/IgzgsDV6HI0SICxo1BJHLUf+Y=;
        b=ET8pFTEcYg2PsoKbzPAMV1kSIMH/yUc0077AmZFxKnFm36y7g2E92qWFjKD7c/CQrq
         EsXx2CG8iBdyGNihDKSaLu7BEP6Q5IpTILb0IZ5HnYZgXTtT6BnjcHrbmL65toHSHkxs
         mSdEElUtgLj5L6WqCziaKXL7u8vi105ss4fkpUmlTVlBcyEuZPSGMHtAJqSoCY6xA3rm
         kxK2gODiZDDrdquDHt54GxFFL+u7O63y+XJXvNMqs54PWIUUpjZFOj4FefDepM5fnCsh
         h2lNC+eVartshqS2EAlPoSPbKNx/jr/QTPKYP//cYqkaLE54zAa0SRNbYY0bFZ2ai7yC
         R0KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771970653; x=1772575453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rID69f081BV9g7oIH/IgzgsDV6HI0SICxo1BJHLUf+Y=;
        b=isSX2CjrJqYEfIIDEP9p7Y6pvo9c0vFxkrBcIjc7XAok1gGTUasSMHkfQ1xzczi0A2
         4X4L+spW32HyPBw3UmLJS2GtVvvr61vzkbtiJdzquifUL9sjmuoQtem4KdGBcRIxnlHK
         mJ1yFAJcN5T60BfSdH6FoEu/VUE6MEU9rM4dbFpw0J7uVLQv3fIkg2ZHGmV92Hx2Gk0X
         IU/bt8wY7d3dGgkWvPAN8RrR3szXJnT1X42KEKsawQ37AHvbwpId3mTIt+D4aZWXkiPf
         70tacyS7G3wZ2oojGw/HRLfNUP4LAkqPXM3gwl6MSXj+DOdwWWe+DR/bC/pzBoaWoGq/
         75MA==
X-Forwarded-Encrypted: i=1; AJvYcCWXuXfsMihYb7blsSpZFte6Qds2xOdohhESpHIhTyRGRqjoq0a5zzJLl5SfxDQgFSAa1DI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTaaFW7MAiBj92QKfaUGrtfd/A6oBm1xvjK7H+3R62brSp9mnK
	M6GL299P48n3D4WsePoHLkFaXR8Q4jGfDeDlEnBSwN7+NZOGZIfnbnhsNKpvU8c9QxWjZRq7sBQ
	+CkjxbFNYGMEeaVfN6ZD1AI/IH0LKvRw=
X-Gm-Gg: ATEYQzwKks+g9gnI/Lxnar2xWvlH5gEZY0hU7g0DuJUqNhhF8gITEsOoczQ6tEO4PVN
	WXxcEAL1s+g0vvB/CviqosLyEMFEBbvXzuiCOxbUCqOSplxVOmKuOP2SY13LD6Lk4e64XGO+BMT
	lS6hDFeiHHn6dbetEbN/ql349djIgKlA4bMqBG37uQzVXIwlHuxBVD/D7gz+LbfXoz/yZkytDJ1
	Bt399zxWB16bUdUrVdoqqIXa96iL8o+Zjtpf+yNax573lwKRe6yBWLslcWAho5XGbpeWCc/LqM7
	3MqwUGt3PdEo6cP4Ng==
X-Received: by 2002:a05:690e:b85:b0:64c:a37b:53d2 with SMTP id
 956f58d0204a3-64ca37b5566mr1987174d50.39.1771970653477; Tue, 24 Feb 2026
 14:04:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260224211202.214325-1-ihor.solodrai@linux.dev>
In-Reply-To: <20260224211202.214325-1-ihor.solodrai@linux.dev>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 24 Feb 2026 14:04:02 -0800
X-Gm-Features: AaiRm52hQil36BCQAstazkHT0rmZIV3p8jECAwpWYV87RTSu9naB1cl4Q8eGb14
Message-ID: <CAMB2axNHh0ihZHS6yoU9hFXsoBnARgnHBMh6+sEZnLmL3KbpbQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Fix flakiness of task_local_storage/sys_enter_exit
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, bpf@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 24, 2026 at 1:12=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> The test_sys_enter_exit test was setting target_pid before attaching
> the BPF programs, which causes syscalls made during the attach phase
> to be counted. This is flaky because, apparently, there is no
> guarantee that both on_enter and on_exit will trigger during the
> attachment.
>
> Move the target_pid assignment to after task_local_storage__attach()
> so that only explicit sys_gettid() calls are counted.
>
> Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
> Closes: https://github.com/kernel-patches/vmtest/issues/448
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>
> ---
>
> v1->v2: reset skel->bss->target_pid to 0 before asserts (Amery)
> v1: https://lore.kernel.org/bpf/20260224015855.1481707-1-ihor.solodrai@li=
nux.dev/
>
> ---
>  .../bpf/prog_tests/task_local_storage.c          | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c =
b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> index 7bee33797c71..1b26c12f255a 100644
> --- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> +++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
> @@ -25,24 +25,30 @@
>  static void test_sys_enter_exit(void)
>  {
>         struct task_local_storage *skel;
> +       pid_t pid =3D sys_gettid();
>         int err;
>
>         skel =3D task_local_storage__open_and_load();
>         if (!ASSERT_OK_PTR(skel, "skel_open_and_load"))
>                 return;
>
> -       skel->bss->target_pid =3D sys_gettid();
> -
>         err =3D task_local_storage__attach(skel);
>         if (!ASSERT_OK(err, "skel_attach"))
>                 goto out;
>
> +       /* Set target_pid after attach so that syscalls made during
> +        * attach are not counted.
> +        */
> +       skel->bss->target_pid =3D pid;
> +
>         sys_gettid();
>         sys_gettid();
>
> -       /* 3x syscalls: 1x attach and 2x gettid */
> -       ASSERT_EQ(skel->bss->enter_cnt, 3, "enter_cnt");
> -       ASSERT_EQ(skel->bss->exit_cnt, 3, "exit_cnt");
> +       skel->bss->target_pid =3D 0;
> +
> +       /* 2x gettid syscalls */
> +       ASSERT_EQ(skel->bss->enter_cnt, 2, "enter_cnt");
> +       ASSERT_EQ(skel->bss->exit_cnt, 2, "exit_cnt");

Does tools/testing/selftests/bpf/prog_tests/cgrp_local_storage.c also
have the same flakiness issue and should also be updated in the same
way?

>         ASSERT_EQ(skel->bss->mismatch_cnt, 0, "mismatch_cnt");
>  out:
>         task_local_storage__destroy(skel);
> --
> 2.53.0
>
