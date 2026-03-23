Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A70631618C
	for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774292717; cv=none; b=BOHpAMCxAvFY2nK2YsjwTJYHSIIdRO67T+LzpbXFSjxDh4USOM5etcp9D3qZXr+tIYBxEJ+BC9sEyNJE1AZU40LH5QC8A3qaqj4sGWN660PgMYobMPRBXpgJ2t6vSfjaCHDX5qfgUcB3NwaoRbeOyeF1yfj7OAryKtccsbDEXVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774292717; c=relaxed/simple;
	bh=C51bjNjSsp7oBymVcEAF6ZNb3f7+dyevHj7/0Btif5Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CCY94QbUEqoQoMuNdU4rSQyamBg2+AK2lAddrp6iQ5Rvo4scsDA7zJKCw4//769kENYG+663n+Zb/3VxXSHCqK9TFC8OniPLR4OJHd6FvScl1wm+rt+jV2OeFf0dZZZKcjPWvCF6M1IAoD4J3GBZ60iO6klC2r3BxqKdOiI2wNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDfs1wjT; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDfs1wjT"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2c0ecaae7dfso7520090eec.1
        for <bpf@vger.kernel.org>; Mon, 23 Mar 2026 12:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774292715; x=1774897515; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rBt9E7S2wk1HCEDuzQF5CZmgHmzLw5dnz/U6mEQWakc=;
        b=cDfs1wjTfSZw1OUfbs/j5wZEEwmtvLzAITPqTS5cmZbRQO4006dLcGfw7/HRH0L2qQ
         L5yG5vNgOLt5Hyo6lKuwdKfBTbOatDjzjCQYQJz+PN2vScvENeW4ilhFDAz6u+0j/XER
         qGhgQ3rAkkCwcs3TJZpn2A1aYeHoCYV3NR+rbLDDZbvMENvzuwAZdUuEwSSVPUfF2V/a
         V6etNUo7EdcQxSH/om27JRsvLawng7W5yTIGGNePHnf5hz8dopd3n+8XZKXyCbAC1ytt
         6d2aLgbeTtp36QV51jhJ+UwrsXPj7Y+Qm63b4c64GH6EwI1XTDnwypQlEkdHfincChKE
         pX/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774292715; x=1774897515;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBt9E7S2wk1HCEDuzQF5CZmgHmzLw5dnz/U6mEQWakc=;
        b=BiZjdpmO5QN5u7qQVTKJ3nFXcoLEdMrcPg1Mk2gqITaj2G6YehNE4oPAM7qmTc/j0Y
         JtUvbkdk8YFLFuBPRoA/lnTJlTa+Lgq7ga0Lu4+6zyXVmxYIs+1oL7MoudQi1DhY6hm1
         7ANAjTWzVehbd3AH4EZrZquc//EUnIL8xVmixg41i4ocLLKpwYvgVL8QT8mNa4znrWAL
         YPMUMBeTOjk2cI+NSMRR9o3a3Pb7sZKLaCDPz6JRgGDwtD5yNw/KnU5jVf6SpcaQ6BRP
         Ufu1ZL6qfOSDeeK7Y24RW0UzGeVVsQ32dSUYUFIW/1pnkio4UGmailWIUdXXjOXWV6vy
         PfOA==
X-Forwarded-Encrypted: i=1; AJvYcCU0bQtcKGJHdc+eBEvS5cNbjlGLKExSuplvaupRdKxF8B4aPHpHx4Y1YyiQFu5+I3BQ2NU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMpEM+464/BMKALm6bNQOH8eTElU6rHtJWeDtIwbrbPjDpbH/C
	Z3U9glnZ8ZCdoETZ6Ak3yLUY2xRdfO+mrMqNViycytDlc25fh0QIWNW1
X-Gm-Gg: ATEYQzyWRMgL3C9D12Hs79n9jPJpPgVb3+wevhimJHa1Xy0iwns1J+/ueF0ZlBM6heO
	w04c7hpGTSRngdrsTUeiLAxS1ihNn5MTVn+pbceX8kUxbm9sGCT1o8W/MIoBQlmAMvTDRqxFOnR
	aRIo0aapXmpgfvQEXZzpQrJTMicYW2egbL5LngMEefwc2vgADz3y6Hm844UwqLc0diXkHVwR57r
	mxmqzXFI8tpenkxM/hnJE7CrfkY4QYwsfmdAywO4V4jLfYGH9Jg4uSSEGf9MkZWTKjXIDNAVazF
	WdhKZV3zCWcbkN99xPJJweB7XoW4wfhfADMYsow//N7d9yz717hk/mYO9n7QX/fiOi79MZ+SEUt
	uXPsrm7Q8TYiKaeaJI+GNnOxkggLxKoIHDqyYJ30rYGHYcTHEZOobN1bitocjSZjKKUbnMbgBwS
	5EpYoK8c+4RsMjt/ZCUo043Iz29L5IAdypOzDyEl5lgdXHFxviBnByny9y9dlIephmkc0pBoxlE
	UM8AUN8iPuoXbn0ew==
X-Received: by 2002:a05:693c:2b06:b0:2be:1544:5c40 with SMTP id 5a478bee46e88-2c1097b06b1mr6860861eec.31.1774292715199;
        Mon, 23 Mar 2026 12:05:15 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:45ca:895c:22d:457a? ([2620:10d:c090:500::2:8b17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c10b17a7c1sm13201729eec.7.2026.03.23.12.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 12:05:14 -0700 (PDT)
Message-ID: <847173114a13630e1512ad05375c6b407720a916.camel@gmail.com>
Subject: Re: [PATCH v2 bpf-next 4/6] bpf: Simulate branches to prune based
 on range violations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>, Harishankar
 Vishwanathan <harishankar.vishwanathan@gmail.com>, Shung-Hsi Yu	
 <shung-hsi.yu@suse.com>, Srinivas Narayana <srinivas.narayana@rutgers.edu>,
  Santosh Nagarakatte <santosh.nagarakatte@rutgers.edu>
Date: Mon, 23 Mar 2026 12:05:12 -0700
In-Reply-To: <d4fe45f8bd5c6a48efd2ba3b66932bf7eb5aa020.1774025082.git.paul.chaignon@gmail.com>
References: <cover.1774025082.git.paul.chaignon@gmail.com>
	 <d4fe45f8bd5c6a48efd2ba3b66932bf7eb5aa020.1774025082.git.paul.chaignon@gmail.com>
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

[...]

> @@ -16717,11 +16717,48 @@ static void find_good_pkt_pointers(struct bpf_v=
erifier_state *vstate,
>  	}));
>  }
> =20
> +static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_r=
eg_state *reg2,
> +				u8 opcode, bool is_jmp32);
> +static u8 rev_opcode(u8 opcode);
> +
> +/* Learn more information about live branches by simulating both branche=
s being
> + * taken using regs_refine_cond_op. Because regs_refine_cond_op is sound=
 when
> + * the branch is taken, if it produces ill-formed register bounds, it mu=
st mean
> + * that the branch is dead.
> + */
> +static int simulate_both_branches_taken(struct bpf_verifier_env *env, u8=
 opcode, bool is_jmp32)
> +{
> +	/* Fallthrough (FALSE) branch */
> +	regs_refine_cond_op(&env->false_reg1, &env->false_reg2, rev_opcode(opco=
de), is_jmp32);
> +	reg_bounds_sync(&env->false_reg1);
> +	reg_bounds_sync(&env->false_reg2);
> +	/* If there is a range bounds violation in *any* of the abstract values=
 in
> +	 * either reg_states in the FALSE branch (i.e. reg1, reg2), the
> +	 * FALSE branch must be dead. Only TRUE branch will be taken.
> +	 */
> +	if (range_bounds_violation(&env->false_reg1) || range_bounds_violation(=
&env->false_reg2))
> +		return 1;
> +
> +	/* Jump (TRUE) branch */
> +	regs_refine_cond_op(&env->true_reg1, &env->true_reg2, opcode, is_jmp32)=
;
> +	reg_bounds_sync(&env->true_reg1);
> +	reg_bounds_sync(&env->true_reg2);
> +	/* If there is a range bounds violation in *any* of the abstract values=
 in
> +	 * either reg_states in the TRUE branch (i.e. true_reg1, true_reg2), th=
e
> +	 * TRUE branch must be dead. Only FALSE branch will be taken.
> +	 */
> +	if (range_bounds_violation(&env->true_reg1) || range_bounds_violation(&=
env->true_reg2))
> +		return 0;

Why did you chose to limit these checks to range_bounds_violation(),
excluding const_{subreg_,}tnum_out_of_sync_with_range_bounds()?

Also, it appears that tnum bounds checking functions are unnecessarily
restricted and should be implemented as follows:

  static bool const_tnum_out_of_sync_with_range_bounds(struct bpf_reg_state=
 *reg)
  {

        u64 tnum_umin =3D reg->var_off.value;
        u64 tnum_umax =3D reg->var_off.value | reg->var_off.mask;
        s64 tnum_smin =3D (s64)tnum_umin;
        s64 tnum_smax =3D (s64)tnum_smax;

	// check that [tnum_umin, tnum_umax] and [reg->umin_value, reg->umax_value=
] intersect
	// check that [tnum_smin, tnum_smax] and [reg->smin_value, reg->smax_value=
] intersect
        return ...;
  }

Wdyt?

> +
> +	/* Both branches are possible, we can't determine which one will be tak=
en. */
> +	return -1;
> +}
> +
>  /*
>   * <reg1> <op> <reg2>, currently assuming reg2 is a constant
>   */
> -static int is_scalar_branch_taken(struct bpf_reg_state *reg1, struct bpf=
_reg_state *reg2,
> -				  u8 opcode, bool is_jmp32)
> +static int is_scalar_branch_taken(struct bpf_verifier_env *env, struct b=
pf_reg_state *reg1,
> +				  struct bpf_reg_state *reg2, u8 opcode, bool is_jmp32)
>  {
>  	struct tnum t1 =3D is_jmp32 ? tnum_subreg(reg1->var_off) : reg1->var_of=
f;
>  	struct tnum t2 =3D is_jmp32 ? tnum_subreg(reg2->var_off) : reg2->var_of=
f;

[...]
