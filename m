Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9249372B57
	for <bpf@vger.kernel.org>; Thu, 26 Feb 2026 01:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772070509; cv=none; b=MjVgfxvuwtxptcTBdRSPqbBRCTUAmQFrfD2AaMnC8SqpZGKbj2BpIvubflA7BZoEfQCvffolqAkyhcVba/XYxwomCdwU8ibOb66raJboP4HnabTukWntQMiCsRgagmKS3Ssqs9zhUkz2DFFKyzeY2OiNGL+B89jymYrgvROKKUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772070509; c=relaxed/simple;
	bh=CqRAlZVeQma8SZdDwiRfrMPRcwQ8Eolz8aHP0g1KgEY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=k66QVscG6qrG8i5PrXgC9JWvGg71jOzMdNog9dsNaWomfjGFwT0QIoclkidQ8fQo69Lp0ej6X7JwfuZDMx2ZTU8E6QP5Hkmx5Akx7cPXcGTwoKIcW5H9iwsgDNUQ9vKSN3XSVM0Vx7rDlvRRBerAOMWxMUsRnnOD02FAMLEXPsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=nug8wTiD; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="nug8wTiD"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb513e860cso29415185a.2
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 17:48:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1772070505; x=1772675305; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rGG8l/LRkrT6kvLWJ5Kuwp4U4A1RZ/1I4nkayK+sN9M=;
        b=nug8wTiD3+cFhX3ktTQopbW0tZ8++gmN0SVvEqnn+uByKgwmXixidw//b6nSnB3lNC
         EeCROsMIOmNjkxtWESCPuD3b82q9gn+ohoqHW1KzevKCbM06bjhSEDtjyhReraCNzOlt
         sttTbXdGINb+m8kQpMFOguddb8giA9tSW7vFrp1Dzu2eqGoQZKlTXzZhz7TGFerZzfJo
         Af3UN3VSODQEYKRHYH9wAhfXd1kVe0upiQyVPezeegKggl3FJInbszRtbWJbD+FgKniL
         tFlZ8DvRpitHk/UF2kW5v8l8n+RBym0G/poDxBDx1FGc3oarCcxFOzhQe4wOJTkgQUnv
         +Jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772070505; x=1772675305;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rGG8l/LRkrT6kvLWJ5Kuwp4U4A1RZ/1I4nkayK+sN9M=;
        b=piet2neOGlbIfXB2Yd5b91PnHDacYqyUECkZe+86H7l9RxXvtBSn1NheGHnm9ZTLsO
         2rQNwppiUt9IKB1nZkmUNPPZxwcaFvui+MSR5erJ6UyOZmksd3cF4OBKgMj7kJQ6bTWS
         2HTr4CP67WwTc3Si0rE43lb3/4xfUA2eJomqevTJ7bESU9EMvG9xfWHMBPP8CJ3vNCWd
         b+AL7ZbgLOVE8kySmzWHPI/UZnvVpxvIG/sXQp10DEWbivm68WS+RUuXAvvFFUbyXzdO
         aqsz+j6sscVbfDz2BG6fxJvN1i7RXYawD3jYeyfRvd7+hslGXuQYiFihBhGcSZsbZp+o
         4ViA==
X-Forwarded-Encrypted: i=1; AJvYcCWCkI5DSMORk9om0Kv59I4xJAaBOvrPedRUmKnxHsUU0+O4AqoRGc9k/aTNxUu7iNTp1pg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGNwdfqNUO3B5M6o3Du/QoUqtMHtveAnzbiCFbt1FBOIka+xzL
	uRtBFbtT0UX18V4ZG+SUkPlhEUgQhffvGvi+18Gpo/4IOcphyFa/rDN4F/Ik8EtAxxs=
X-Gm-Gg: ATEYQzy71IpI5KXd9SQYrpSbW1zZexqar1JmrEsJNRtofczCoOf9ChZ6nTZSt5EzjHU
	viFM0sxAQGnYmhvIZBaW/ZqlilNwy9GbcjYeV+jZoN6MAP1/prIeQxdy7CFk5xR1TB8ZBY2Gdag
	5YfmscwWRNGF3fXbNY/SfnMKHGm0qsdEvHPIfgecGxqt9KPiMPTlchHYlPf4b4QhUKXrfEEQm1B
	0mjj6GmvdW4+Y/pgmwYGBIFa2E6R7c/cqe6UE065x/kGUqfM6Yn6x+O/Qwf+CAgLKBY1Bl3NCrv
	tStD9vBm55eDh8bn/MSHusG2UA1WG5Yui+RHDqPblse0tbmQH2LUActvZm0MiTBc71Xi0l1/cNm
	kiD0jsLn3bGVbeq2hQ/nCA6RI2YA3ZrMH0h6FAig9FG41wG8nxfAjP8CGSUrJAV6Jd+uzbPQA6l
	WwwQrzrAAlYBVvrmQabfJFXwo=
X-Received: by 2002:a05:620a:708b:b0:8ca:2a02:dfd5 with SMTP id af79cd13be357-8cb8c9fc439mr2209625785a.30.1772070505267;
        Wed, 25 Feb 2026 17:48:25 -0800 (PST)
Received: from localhost ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-899c739e75dsm5306146d6.46.2026.02.25.17.48.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Feb 2026 17:48:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Feb 2026 20:48:23 -0500
Message-Id: <DGOIKEXPX2RI.1BAP1MAEYVCA4@etsalapatis.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <eddyz87@gmail.com>, <martin.lau@kernel.org>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>, <clm@meta.com>,
 <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Separate bpf_throw() and
 bpf_exit() return value validation
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20260225033356.518313-3-emil@etsalapatis.com>
 <2409d3ff0161cdc45e6511e078c94df903113df01d3a879d134f6de82397d7e2@mail.kernel.org>
In-Reply-To: <2409d3ff0161cdc45e6511e078c94df903113df01d3a879d134f6de82397d7e2@mail.kernel.org>

On Tue Feb 24, 2026 at 11:23 PM EST, bot+bpf-ci wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
>> +static int check_throw_return_code(struct bpf_verifier_env *env)
>> +{
>> +	const char *exit_ctx =3D "At program exit";
>> +	const struct bpf_prog *prog =3D env->prog;
>> +	struct bpf_reg_state *reg =3D reg_state(env, BPF_REG_1);
>> +	struct bpf_retval_range range =3D retval_range(0, 1);
>> +	enum bpf_prog_type prog_type =3D resolve_prog_type(env->prog);
>> +	struct bpf_func_state *frame =3D env->cur_state->frame[0];
>> +	const bool is_subprog =3D frame->subprogno;
>> +	bool return_32bit =3D false;
>> +	int err, ret;
>> +
>> +	/*
>> +	 * BPF_LSM_CGROUP LSM programs must not modify the return value of a v=
oid program
>> +	 * (see the logic in return_retval_range()).
>> +	 */
>> +	if (prog_type =3D=3D BPF_PROG_TYPE_LSM && prog->expected_attach_type !=
=3D BPF_LSM_CGROUP &&
>> +			!prog->aux->attach_func_proto->type)
>> +		return 0;
>
> Is the comment above this condition a bit misleading?  It describes
> why BPF_LSM_CGROUP programs need validation, but the condition
> itself handles the opposite case -- non-CGROUP void LSM programs
> that skip validation.
>
> A reader would naturally associate the comment with the code that
> follows it, and could be confused by the mismatch between the
> comment mentioning BPF_LSM_CGROUP and the condition checking
> !=3D BPF_LSM_CGROUP.
>
> In the old check_return_code(), the per-case comment was:
>
>     if (prog->expected_attach_type =3D=3D BPF_LSM_CGROUP)
>         /* See return_retval_range, can be 0 or 0-1 depending on hook. */
>         break;
>
> Would something like the following be clearer here?
>
>     /*
>      * Non-CGROUP LSM programs with void return type do not need
>      * cookie validation.  BPF_LSM_CGROUP programs need validation
>      * even for void hooks (see return_retval_range()).
>      */
>

I mildly disagree with the AI here, I think it's a small leap from
reading that BPF_LSM_CGROUP void programs must still be verified to
understanding why we only return 0 for non-BPF_LSM_CGROUP programs. We
also refer to return_retval_range() for a more definitive explanation
instead of duplicating it here. Ofc if human reviewers prefer the proposed
version I will update it.

> [ ... ]
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/223813=
17682
>
> AI-authorship-score: low
> AI-authorship-explanation: Standard refactoring suggested by reviewer Edu=
ard Zingerman during patch review, with natural kernel coding patterns and =
commit message prose consistent with human authorship.
> issues-found: 1
> issue-severity-score: low
> issue-severity-explanation: Misleading comment in new check_throw_return_=
code() describes BPF_LSM_CGROUP behavior before a condition handling non-CG=
ROUP programs, creating readability confusion but no runtime impact.

