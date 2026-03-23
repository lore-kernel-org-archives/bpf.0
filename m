Received: from mail-dl1-f54.google.com (mail-dl1-f54.google.com [74.125.82.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE20F199E89
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 18:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774291335; cv=none; b=gqnS0aUkrTonTv+nBa03BVhBaiOqmu7RWbbnEJEHWgF5PiA++ELPQi6oawt4oBHG0m3veu9PfGvp0N5UZoVL7RFsxZzvowHNN6DXkWhcpHVFPNDsZFxzeKsgGAW+K7HeCN+k/mgb7JXf+M0fXDmhLar7R3wioQljQYskRwVEa4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774291335; c=relaxed/simple;
	bh=Xt7ReF5qI5DEqbFPfzjdtwrjTML+lZF/L23/Yko3F+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MUmYRZAtFEHw0XpeTdLWUnYkE58S8CezCbxRjdpCEid/dfbTw0dGVKF3lnd4FUKP94X9OC5knwwfWJYuL/VSUbkmQ/J8N/5E1niDvgWElAlinJLXxnlXsRWH7pwQmDZAqZ5Ws1fxuKTgKKlovFcyy93Y8q9zIBZx08fxg/YI/iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zwjag9Ho; arc=none smtp.client-ip=74.125.82.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zwjag9Ho"
Received: by mail-dl1-f54.google.com with SMTP id a92af1059eb24-12732e6a123so6562794c88.1
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 11:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774291334; x=1774896134; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VkjUaTN0COwFptb0I8fe52nCd5hVWCrl1+bt228v/Xg=;
        b=Zwjag9HopDINFJ8DiHJW2OdR0TmsBnKxAb7VzTNPgPbgO6i93Qu4k6lCjuVjyT6l5d
         yt7AjmSE4LSRm0UCynr2dNPIgn3YZvvGn4RwQD/KXqKNEGgspLK95+xFWKP828HAd5wr
         /4ElCm/732Z7nXArq97TuDH7rmz0v3Jz8eKxDsytWeUS2tLprl2aKGXfpi7iFh0Y5rI/
         9W2DxCTjs463GkXQX5vM512EWRWvEi8jHNeEUxRS9ylqG5YYWzf35QjdgbK44bk9p75R
         dr6tBkkxdBiEbuNg/m80wh/gUjBj3qC/AE7MffpfXkCuVVHy48pB+NFqTYcA+mOdNngu
         qLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774291334; x=1774896134;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VkjUaTN0COwFptb0I8fe52nCd5hVWCrl1+bt228v/Xg=;
        b=VgnUX36QNzNY6/LNXqSWN8+xJz3MeDmcO/m5nAcP5P55hzX6w8aPSMVDajIogUf1n0
         MRc/IDpNqa/6JQV4vLuLzjf4h06FsnvSSNJWuLcixEd5Ia11y0mPcp2huZpYbcmIcLaZ
         eQ6uUsqQRIZGkoCOdVlGYFnbhsV5wagYdER7KATzBLQHJb0pXYP+nPob0Tj5ubRJ7dFu
         VZGp91fIJj0LyYRIBMBEXCVW16ZZpSMh9Wz6bRayiu1XWavblu0L6SavprbCv+PDZwZu
         sf49ATjR6sVjca6KyoPMvGxBLrAqo5gqXWlsPXXbapciP9Rv/tyEb7MwSO4ohuZQ8Ow9
         2qBA==
X-Forwarded-Encrypted: i=1; AJvYcCWHM6s/WYSQy+LU0VqHVKItT/wJceo4WAmtLMEKXruiKf9Fx5fIbZXwlBoGc8RCgb/soDI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6vGdqp48u+Yz3v5puSO2gWOe+qOSHn8kjs8LNm8hDArYFR6Vw
	t8lh3HVfBaJqegNx4vhHD1EvAIrFtef3MxbMscpJkO/1FqfKUZhOdT6s
X-Gm-Gg: ATEYQzy8p22hudPZKzU3UgoLEXc4uSbjirVCsb22aGLLVnAAYFGTDlRM9A7pPEPBWpb
	ujqX5kQETJluXdqv9hYQPQBwoBrUJepBLhym/DmnhsYDWD8u6ykEfJRE70wvAaXUPThdzWkODjh
	qkZR61W61WELsaJAKeTyivGYdurj+TdM5WSgsBJ6WcCr//MVF48EwC+ohb/PDyKI+FKUdrTDeYX
	Jvu9qhEqKNM4kKGsbfOtHrfBBd2unGRwyDMPlT1VeYCAbBazWiAUmrNRwM0D422mquQV4uIy3WL
	Uyi2YnfYRdcjIbB+YSFZAjxPl3pVsbQj1HIF5DLlnVRRrvGiyzknaGncOjkgQR7k5deoz1TFJUp
	KzkScPtJPm37wLUjbfZMhC2mYG5+A1bCJKN6pPkH0UimnOR9bGuknmKVDAYcjWrm4BUOxuzgv8d
	eujTv09QCvS7VA5l/d73IysDy32gCq1691e8Vunl0AwnuVWICB17a1+kZpSaxqmM4wlHA/9grhy
	qFSpGs=
X-Received: by 2002:a05:7022:22b:b0:11b:ec5f:1c37 with SMTP id a92af1059eb24-12a72686c9dmr7665035c88.18.1774291333631;
        Mon, 23 Mar 2026 11:42:13 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:45ca:895c:22d:457a? ([2620:10d:c090:500::2:8b17])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12a734bbb57sm9657547c88.10.2026.03.23.11.42.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:42:12 -0700 (PDT)
Message-ID: <33c006d7275cb443b5750f062cb78c38449a7537.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/6] bpf: Use bpf_verifier_env buffers for
 reg_set_min_max
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Harishankar
 Vishwanathan <harishankar.vishwanathan@gmail.com>, Shung-Hsi Yu	
 <shung-hsi.yu@suse.com>, Srinivas Narayana <srinivas.narayana@rutgers.edu>,
  Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Date: Mon, 23 Mar 2026 11:42:11 -0700
In-Reply-To: <9fdf9830803fe3a5c4059341c84a03836105f5bf.1774025082.git.paul.chaignon@gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
	 <9fdf9830803fe3a5c4059341c84a03836105f5bf.1774025082.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-20 at 17:49 +0100, Paul Chaignon wrote:
> In a subsequent patch, the regs_refine_cond_op and reg_bounds_sync
> functions will be called in is_branch_taken instead of reg_set_min_max,
> to simulate each branch's outcome. Since they will run before we branch
> out, these two functions will need to work on temporary registers for
> the two branches.
>=20
> This refactoring patch prepares for that change, by introducing the
> temporary registers on bpf_verifier_env and using them in
> reg_set_min_max.
>=20
> This change also allows us to save one fake_reg slot as we don't need to
> allocate an additional temporary buffer in case of a BPF_K condition.
>=20
> Finally, you may notice that this patch removes the check for
> "false_reg1 =3D=3D false_reg2" in reg_set_min_max. That check was introdu=
ced
> in commit d43ad9da8052 ("bpf: Skip bounds adjustment for conditional
> jumps on same scalar register") to avoid an invariant violation. Given
> that "env->false_reg1 =3D=3D env->false_reg2" doesn't make sense and
> invariant violations are addressed in a subsequent commit, this patch
> just removes the check.
>=20
> Suggested-by: Eduard Zingerman <eddyz87@gmail.com>
> Co-developed-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail=
.com>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.c=
om>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b638ab841c10..fbc29fb96a60 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -17184,10 +17184,6 @@ static void regs_refine_cond_op(struct bpf_reg_s=
tate *reg1, struct bpf_reg_state
>   * but we don't support that right now.
>   */
>  static int reg_set_min_max(struct bpf_verifier_env *env,
> -			   struct bpf_reg_state *true_reg1,
> -			   struct bpf_reg_state *true_reg2,
> -			   struct bpf_reg_state *false_reg1,
> -			   struct bpf_reg_state *false_reg2,
>  			   u8 opcode, bool is_jmp32)
>  {
>  	int err;
> @@ -17196,30 +17192,23 @@ static int reg_set_min_max(struct bpf_verifier_=
env *env,
>  	 * variable offset from the compare (unless they were a pointer into
>  	 * the same object, but we don't bother with that).
>  	 */
> -	if (false_reg1->type !=3D SCALAR_VALUE || false_reg2->type !=3D SCALAR_=
VALUE)
> -		return 0;
> -
> -	/* We compute branch direction for same SCALAR_VALUE registers in
> -	 * is_scalar_branch_taken(). For unknown branch directions (e.g., BPF_J=
SET)
> -	 * on the same registers, we don't need to adjust the min/max values.
> -	 */
> -	if (false_reg1 =3D=3D false_reg2)

A side note:

The above hunk was added as a part of [1] to mitigate some invariant
violation errors. Surprisingly, none of the tests added in [1] fail
on current master if above hunk is commented out. Probably due to
recent improvements in bounds deduction. Should we remove these
tests as a part of the series?

[1] https://lore.kernel.org/all/20251103063108.1111764-3-kafai.wan@linux.de=
v/

[...]
