Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D725319CC0C
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 22:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775512970; cv=pass; b=ufHgUCIYeVtglwB0EtVGMmXFMRLGDhgOrNZWBmExAsQcNpxQm/PYwPJpi54JMAkPd/Rp8Py6Em+MEnWkpGP8vTboF9SgPcobiBWuvGGdF0Y0RkqWF1AwaXJe4hj7ariRZZ8XoM0XpCz++FnZdjuXO/H4gMnZy22gA/Bn23n7Y6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775512970; c=relaxed/simple;
	bh=rlcmOJ1ejHc5rmLxc5m41AH5MiwpMcsoHUuKpS+9kko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IDY5FAvMC+4Ly1Xpi3NecA8KHITv3LCfp2LoH/GmQDOmLosYuPPtAHHcj4j6C9WNPSsyblfnpfNo8W+grdbG4lZKjvop2hJXPG/7hgrwrKapZoG35VhGjXQEu3hmPj7vHU/SvUtcovicH0qcI4Q1XIVLxsXiDQLJMSmkOTE5u4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lvWtSPGV; arc=pass smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lvWtSPGV"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-48374014a77so57916395e9.3
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 15:02:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775512967; cv=none;
        d=google.com; s=arc-20240605;
        b=Uy/l4XW5ku+f7ORWqTM7DgNZ5WFetn2vnv2Nuy0j2HY0irv4+mwnEngRIjPgeftrf6
         AqtH4lZ/eNLGc98HbndKg56UMusFQmUWN5yClMDR0GC2ESIv7Vq/r7tLOs9iyie7ztER
         T2tFEUWjSQ9yq80F2kZHSJ+Ev6WSkjN04n/q8ZC3ZeJpFV+swJGpog/pLgaTnfEBu0qs
         7fWMXL9yh68CWKj8KFnR8H28U7G2tlygmShYwnZ+VesS6QR699pNCbx9C6mYQe/qE5mU
         mAe8tImY82zm/tA/EM9DP4jY6aOHiEP5Xc4OAJrfBdNm5opvjGJv0MlCJFVICX853pC7
         W8wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cJxWVMuWXnqSQVQSsWUmcpacrnODdYQQANqcFwrJow0=;
        fh=7bDoJvJFrYZ7A5N7vkXSdgfOZxNzt0h83jMpSbUYmDE=;
        b=E4OWhKn0ce4hpmofq6AgtDx00w12jfot0zQj3KBdAQc8TpmH5K+SsSIIZCPNIag5Xc
         bcHIHUUBF9gwfk2dyjuml9BKFtQbRDkW0OWepPwqONg3gKjOQXv+0liK9pWzK9a7adbR
         9J3t4R5lHuWXGWAlVBq2d/VQxJ2FlU5+9PXgJNWMW50Qzxc4i2VjEBEERrWEp9zqY6J/
         izgntBChhV1fKs+qY1oULbPVVdM3V/TbEJNacDmilEutovk7FHVk3/UwfUg2CDdAFQWO
         qlV4Zpc7yi7Zw0e+ybWIh0t4ELauyIExHiNuA1NBjNNcnGoUhniUxD67RiScAnXh+v9K
         gV3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775512967; x=1776117767; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJxWVMuWXnqSQVQSsWUmcpacrnODdYQQANqcFwrJow0=;
        b=lvWtSPGVJ78JCw+XP0HYJeRTD8k1386wNn23XE0vE5imiwec+fLmaiFfx/45qCYdHl
         oGqRVADO3E3oX/WQR3W6JZbttkS3nwHhLmqa2j4d6tjC6L8S8ZcDaJ2U4TdnUduGQxCz
         oxcwOdBRC2VQTvB6gxVVSEaJT2EL5/HqIAb8gwSO2Ranrm8NeglykuA7AB6HGYbWQBSH
         NvHYbMVirGab67LotuMoqDiIN9fZJh3QTSIVm4t7CBWirdzmoI6CNypmXZh1a0+WN5Nq
         auk4eY2/o/Dq44R6xEjVG0bSzotqGrOHyGXATTRDZRdvBL36V7txdxmnuKyJ/buqzRVO
         EWPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775512967; x=1776117767;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cJxWVMuWXnqSQVQSsWUmcpacrnODdYQQANqcFwrJow0=;
        b=sgz4ulP2ejfeFM7vyUCWOrh6ckUEqhPbyvttMisfgRKeUK8esXKUw/b0k3uAXUaGe9
         l64pFpJRgMoTM7NnCkE9NszZUlZpvR6lSAwomJ/yGwyseaDhC/AaxnW6dmL3VmN2IH3r
         u/3tU0kBMEugfGpduyGUNOhku+UrB8Kvv84zMVNJ/ts/zASzR7Ye5m8vl8w2kU6Gbex8
         mxJ0oq4W7plJeT51oa+s4JaOiHo5UlmTBNz3Xrx87y6zz4KWypqZeaaF2MZnWTbe/o4u
         nRv1X2afSn1Zyqckh4DIkDd7eoBrHV2biwFWpH6ia/WVCiqDk1SPYi7G95pMY5pR51gZ
         OgQA==
X-Gm-Message-State: AOJu0YzjclVP+OqVGw1ZX8hHsxV3zU0JADur03YyU6HxeJuvEAJihxAB
	48ThtOOsaQPiB7JyQr24nD5bfMtOyJZJwlHnGB67QTietqzMIDuLNB4Nonr906eUMBH6Yo1OZv+
	gRstdCm//izf4ly8Yergph0DUnaRhy78=
X-Gm-Gg: AeBDietuP/+Dp4ouUMo1W6eeoNmyd7RDUK1gEID8bTtxpcDmXrgWr0KqsJ7hhuez6CL
	5MXvUxuAKSBOkAEKpVef4CCFOOjXL0RPRJHFe59HSwlm7QSd+9IvvlkFqEKfu4dHEtPwPa8rVU+
	gzxXCMgFrjc7H181pvXG7WrqCUy22te9EaykxxBczuQkEQxsBkHaBsfN3QQO3iEwutreAMwEFDR
	nKoyMYNkKm94Ha+ZOLQv5gWlz8NQlUX8OCItVYPH9NZpmqcykC0uBfdleQv6HomWV19rttmUX6v
	qwj3e4iDZHb7ECz1qzqZTnanVfrRkxe00riuR0UQ6tlFWO3OI0jZGWoghtg5nt3jgfK0Xv0Tio3
	gCk82855YKmNNm+nD9acRk+VgyA==
X-Received: by 2002:a05:600c:3544:b0:485:303b:c50a with SMTP id
 5b1f17b1804b1-488997352d3mr197648855e9.13.1775512966858; Mon, 06 Apr 2026
 15:02:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406194403.1649608-1-memxor@gmail.com> <20260406194403.1649608-8-memxor@gmail.com>
In-Reply-To: <20260406194403.1649608-8-memxor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 6 Apr 2026 15:02:35 -0700
X-Gm-Features: AQROBzDLVvXHEKRXROtEB_XBt_ot58fNezfgrfq7IQJSA3ONUsL4u1gSF5DDVpk
Message-ID: <CAADnVQL_0p4QrgvHyaOcA8Q_tYcnUXuc44Zxa59KcAfQJkiU2Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 7/7] selftests/bpf: Add tests for syscall ctx
 accesses beyond U16_MAX
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Tejun Heo <tj@kernel.org>, Dan Schatzberg <dschatzberg@meta.com>, kkd@meta.com, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 6, 2026 at 12:44=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Ensure we reject programs that access beyond the maximum syscall ctx
> size, i.e. U16_MAX either through direct accesses or helpers/kfuncs.
>
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../selftests/bpf/progs/verifier_ctx.c        | 108 ++++++++++++++++++
>  1 file changed, 108 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_ctx.c b/tools/tes=
ting/selftests/bpf/progs/verifier_ctx.c
> index 887cd07ed885..7856dad3d1f3 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_ctx.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_ctx.c
> @@ -406,6 +406,37 @@ int syscall_ctx_unaligned_var_off_write(void *ctx)
>         return 0;
>  }
>
> +SEC("?syscall")
> +__description("syscall: reject ctx access past U16_MAX with fixed offset=
")
> +__failure __msg("outside of the allowed memory range")
> +int syscall_ctx_u16_max_fixed_off(void *ctx)

I don't think we fixed __description() issue yet.
This test is hard to run individually.
Need to type test_progs -t verifier_ctx/"syscal... offset".
whole description name.
W/o it: test_progs -t verifier_ctx/syscall_ctx_u16_max
will work.

Would be great to follow up.
