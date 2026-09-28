Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0B9344036
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 21:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632123; cv=none; b=Okwrw2Cr7hdWjeUG/t8up9msYvWPxXN8UCOQqNGlR0BJk1cIkmJr2VOGNVt9qe821Tcd2VPGH8A6jzJ1DuOkPek5pbOvpI0cPRcN6uaYcoJ3WHhzlhpgaVkCAP11Wvu349kjmr5EECOrYk5ApRrXooJRLCA98Zd0jvLYXVkbyZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632123; c=relaxed/simple;
	bh=6AbZzd3okR162+XQZGChV+16mKk2TjYSq3Q+RFQq3MU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=JqO+gH1kwj+0z2t2DYWSvXY8L8QtJrfAUff6jiTvpYTvyeszU4c/jQyciGaLbzGg5y5IAAv42/RmtyjSWD1Jy+4mdaQWso1BWdQinwzI6jL/9QHZKRmOFn/4/ikXm3yGJQkZKHbvl3F0C2qS6AWJLz53SVxO4nhBq7V4wl05cok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=LJhaBo4o; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="LJhaBo4o"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a4805e15cfso632359a91.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 14:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1790632120; x=1791236920; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uLxz4I+sYstS/de5CE+Uvz1o1jA5m0CZqK/6y8pmb8Q=;
        b=LJhaBo4oTjNTM8RbJIxJqQ+ZqLsNtkZoGpblTiKGew8aJI9lBZcmDGGneboIogQrsN
         g+EmTr/hiE5gbcopFfV/IBlszf65vqsc/n7/3ris/HvzQIzPwPqU1Vixt5fAmVrbOPs7
         DWCuxGqxtSrHPeouIvlcwZifzd5HvRwgqMgM4PrE7EusV1F4nwMYB7yL774RdKX29da4
         nDBhphEiSeYGQ8+ervtWOo1/7H4P1FBpnJ4ryiM3pgKWJfZRdl5rPlVO7zJVhJQnMinL
         JlKxO5LjDJ/CF5ASl16D3clsEslO2E2qL1DPj1FP7o/lH7w0SG4JdWvJ6gNqdcsud9H/
         RGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790632120; x=1791236920;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uLxz4I+sYstS/de5CE+Uvz1o1jA5m0CZqK/6y8pmb8Q=;
        b=oZMtJctMsrkNKMI+16QCMmsZbgKsZIMonZ663IgHs12o+Q+I8CpveAn/FZzMIPb54C
         zpRElCakglFImmy3p5MVpDMJ6kgsYqdeXrez+MwbXwR+evyvge3BaftbqlzFCdZIjqKd
         mA3CW6Xh/yiWko7X5EMSYHQyjJ6HH3RHPLXF55VZwtZyKFm31N4BoZtBM0r2iTERK3QV
         tVZ848/A5zTDFHGtbQv2KSe2rDfiM6W46nJoxjNBLJrNcCphoi3fFd+qYG+jaDnwNww+
         fg2AdPRaewdt5yBtCv8JWZXep8BK8CXzsx5X7t5OuiKIco0LobKKcEoqrv4V0quoIEpO
         0A/g==
X-Forwarded-Encrypted: i=1; AKwUvBxlrcsvgCH+OiUdexaIj8jyWsw8nm+fjIWiEkrm5xCrCo7cjHJoqcSIYfO2FPrQcOtTvvo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSyfb0xh2CUH0STOBmCzh68jSbWD5onePltcdfkZrB/S31Orbv
	MxX2prUbgYRCZEN0A2NETKh1MQ5xH4rjICgFDllWRpyfYgy2UTqrERIiAO/ZIQLcbCc=
X-Gm-Gg: AYBFou2m4K6IZVNDi2Spb3CGhDfw2XxoQNuBb4myWvVwZTrezWiaiqrQ3EhwVHNYsCG
	xEKNQMfXsJjCsFnYhO8zfXJ0B2jkaMZICEYzlgEsF1Wz0OvmuafRgvhQACD1y8vCNRZ6wGZBH7K
	mbXJAD46pb7WMsGHfM2N7pXefiOUzwcyY5sbqjLtp2HZMrhYaVC77vx48lRJ3OAurjVibvYmROZ
	L7t2+ft6l4OEsdi0C9maMKBjKURv0Dtar1Pmnizo9Afqvxaj6CMxnD+K2Es45WvlKn1FXhclOpA
	UVkYz7CXzln/LWVdP4EnHmOEQ7zclYr/kfknsRIuvLjYiHSxolLK52BNF49aZYUXSfzOfBqtdaM
	GXfE4YOgDGgrJImpH+f6GhCwYlOght+TaJ0t7GTDm1owAnGaX5RmaY8OTUjhof9mO/BsphiGohP
	5WL9jHaNyw9CQhnhIjXdREerav+Hj+TxxMeT5DGqYGOkHXXYWJVqc0umYQsWwMKuIIeHkCrYQWD
	PHfYUrhCy3HpsUc/coIuSSY+jTI0RVP
X-Received: by 2002:a17:90a:d2cb:b0:3a4:85c4:68fc with SMTP id 98e67ed59e1d1-3a485c46bc8mr2000402a91.29.1790632120284;
        Mon, 28 Sep 2026 14:48:40 -0700 (PDT)
Received: from localhost (69-172-153-146.cable.teksavvy.com. [69.172.153.146])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a49803d745sm1429887a91.11.2026.09.28.14.48.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 14:48:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 21:48:37 +0000
Message-Id: <DLRA3YMR3SBJ.RMYGB5MNQM25@etsalapatis.com>
Subject: Re: [PATCH bpf-next v5 6/7] bpf: Support per-call-site kfunc
 specialization
From: "Emil Tsalapatis" <emil@etsalapatis.com>
To: <bot+bpf-ci@kernel.org>, <emil@etsalapatis.com>, <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <daniel@iogearbox.net>, <martin.lau@kernel.org>,
 <yonghong.song@linux.dev>, <mason@kernel.org>, <ihor.solodrai@linux.dev>
X-Mailer: aerc 0.21.0
References: <20260928202643.9114-7-emil@etsalapatis.com>
 <347f689699a63771b3be60c747063acb8dae433d2d7c1cde09a9d5dfe8e2ab35@mail.kernel.org>
In-Reply-To: <347f689699a63771b3be60c747063acb8dae433d2d7c1cde09a9d5dfe8e2ab35@mail.kernel.org>

On Mon Sep 28, 2026 at 9:11 PM UTC, bot+bpf-ci wrote:
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 5cbae5d05fe7..7bdbda7764c7 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>
> [ ... ]
>
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 8183a8f22ed5..8ba831329ab7 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>
> [ ... ]
>
>> @@ -22062,6 +22065,56 @@ static int specialize_kfunc(struct bpf_verifier=
_env *env, struct bpf_kfunc_desc
>>  	return 0;
>>  }
>>
>> +static int add_kfunc_desc_target(struct bpf_verifier_env *env,
>> +				 const struct bpf_kfunc_desc *target_desc,
>> +				 u16 base_desc_idx, u16 *desc_idx)
>> +{
>> +	struct bpf_kfunc_desc desc =3D *target_desc;
>> +	struct bpf_kfunc_desc_tab *new_tab;
>> +	struct bpf_kfunc_desc_tab *tab;
>> +	struct bpf_prog_aux *prog_aux;
>> +	u32 i;
>> +
>> +	prog_aux =3D env->prog->aux;
>> +	tab =3D prog_aux->kfunc_tab;
>> +
>> +	if (WARN_ON_ONCE(base_desc_idx >=3D tab->nr_base_descs))
>> +		return -EFAULT;
>> +	if (WARN_ON_ONCE(tab->descs[base_desc_idx].func_id !=3D desc.func_id |=
|
>> +			 tab->descs[base_desc_idx].offset !=3D desc.offset))
>> +		return -EFAULT;
>
> This isn't a bug, but would verifier_bug_if() be a better fit for these
> sanity checks?
>
> Looking at bpf_fixup_kfunc_call() a few lines below, the
> descriptor-not-found case uses:
>
>   verifier_bug(env, "kernel function descriptor not found for func_id %u"=
,
>                insn->imm);
>   return -EFAULT;
>
> verifier_bug() writes the reason to the verifier log and only WARNs under
> CONFIG_DEBUG_KERNEL. A bare WARN_ON_ONCE() warns on every kernel and leav=
es
> the log with no explanation for the -EFAULT.
>


Seems like a reasonable change, I will leave this version up for a bit befo=
re
resending in case anything else comes up that we need to change in the next
respin. Not applying Changes Requested for now since patches 5/6 could use =
a
review.


>> +
>> +	if (tab->descs[base_desc_idx].addr =3D=3D desc.addr) {
>> +		*desc_idx =3D base_desc_idx;
>> +		return 0;
>> +	}
>> +
>> +	for (i =3D tab->nr_base_descs; i < tab->nr_descs; i++) {
>> +		if (tab->descs[i].func_id =3D=3D desc.func_id &&
>> +		    tab->descs[i].offset =3D=3D desc.offset &&
>> +		    tab->descs[i].addr =3D=3D desc.addr) {
>> +			*desc_idx =3D i;
>> +			return 0;
>> +		}
>> +	}
>> +
>> +	if (tab->nr_descs =3D=3D MAX_KFUNC_CALL_DESCS) {
>> +		verbose(env, "too many different kernel function call targets\n");
>> +		return -E2BIG;
>> +	}
>> +
>> +	new_tab =3D krealloc(tab, struct_size(tab, descs, tab->nr_descs + 1),
>> +			   GFP_KERNEL_ACCOUNT);
>> +	if (!new_tab)
>> +		return -ENOMEM;
>> +	tab =3D new_tab;
>> +	prog_aux->kfunc_tab =3D tab;
>> +
>> +	*desc_idx =3D tab->nr_descs;
>> +	tab->descs[tab->nr_descs++] =3D desc;
>> +	return 0;
>> +}
>
> [ ... ]
>
>> @@ -22082,9 +22135,11 @@ static void __fixup_collection_insert_kfunc(str=
uct bpf_insn_aux_data *insn_aux,
>>  int bpf_fixup_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn =
*insn,
>>  		     struct bpf_insn *insn_buf, int insn_idx, int *cnt)
>>  {
>> +	struct bpf_kfunc_desc desc_copy;
>>  	struct bpf_kfunc_desc *desc;
>>  	unsigned long call_imm;
>> -	u16 desc_idx;
>> +	u16 base_desc_idx, desc_idx;
>> +	bool near_call;
>>  	int err;
>>
>>  	if (!insn->imm) {
>> @@ -22104,13 +22159,17 @@ int bpf_fixup_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>>  			     insn->imm);
>>  		return -EFAULT;
>>  	}
>> -	desc_idx =3D desc - env->prog->aux->kfunc_tab->descs;
>> +	base_desc_idx =3D desc - env->prog->aux->kfunc_tab->descs;
>> +
>> +	near_call =3D !bpf_jit_supports_far_kfunc_call();
>> +	desc_copy =3D *desc;
>> +	desc =3D &desc_copy;
>>
>>  	err =3D specialize_kfunc(env, desc, insn_idx);
>>  	if (err)
>>  		return err;
>>
>> -	if (!bpf_jit_supports_far_kfunc_call()) {
>> +	if (near_call) {
>>  		call_imm =3D BPF_CALL_IMM(desc->addr);
>>  		if ((unsigned long)(s32)call_imm !=3D call_imm) {
>>  			verbose(env, "address of kernel func_id %u is out of range\n",
>
> The same question applies to the WARN_ON_ONCE() in bpf_add_kfunc_call()
> which checks `tab->nr_descs !=3D tab->nr_base_descs`.
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/364807=
60039

