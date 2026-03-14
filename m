Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF243FFD
	for <bpf@vger.kernel.org>; Sat, 14 Mar 2026 00:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773446755; cv=none; b=pBUjk5ml/ZxcJ+mt1PiTAhrFwJdrcKBOYcxEkte30BEFp7SFqY0a9UYgV+OOMxM2jdGGFTNwI0jx4IzB2wA6nAoLZMjx3KahRYFT79oQPb9fXeCbaUP7j8Xuo1GR4sNe0Xi2V3QY7iS/KAxdSzcp4IigE9FIj0ZVIfFXfvhTnO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773446755; c=relaxed/simple;
	bh=Z4EZI/oIT45EyAcpOOirijckrnsgBrxsa2uVfYuBbkg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Ew+SuGuGdkvurjWXrHQwTO6Lgy5lRys1yS6ORnRqPsFlGPef94J7Segn1LhVOAxwugXoKOpTvwNrlEL90pVKEcb5y5KxO081E/ZqVce8C3e+GKPk4t8+BYubeh0dHpyC0pJPgO3Fm6WWTAz6J2FONzB5Tx8cGXwEOOW0CUwIgwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W2OTO9kd; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W2OTO9kd"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35b85613f3fso435055a91.1
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 17:05:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773446754; x=1774051554; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=laPjCUdDwNjB0rfVLS+ddbHb9EbEJgaUmiAy6K5gdoQ=;
        b=W2OTO9kdhjpUwkKbl6x+nrZn5FwbFtuvAuB/vhRlFMJi+iZVTl5y+G6khyFGWgHan5
         UxCPwLFm1N0MNGI2Ty+CAMbGQo/vRrqQxAEKUIspjIbm3m8OCr+rfK13UItVoYNLHZOB
         m24F5s+Liikj1kOO1OcF4TT+LFcRZOsBNWYcXYhqRgzKTcZsmvaIJeolhWWyQ9Nv1pGu
         VQhptEwxKEUvtQVAlNYNRJOMKH/Z5R9kxYgGv3ndMOllzTxnztocZewAtHcANMwqH1jI
         oH3vOjzoP2HYxpSwJoOJpEDPGLA61SNxYWPldKJhRU9ZolELjlPUW5Ac5cORvF4fNqEp
         lHQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773446754; x=1774051554;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=laPjCUdDwNjB0rfVLS+ddbHb9EbEJgaUmiAy6K5gdoQ=;
        b=aFF86R0voAUaG/7LU8KyvHgRYC37zOW4gem7mur0F4lzI7QeZah9v3FuPB7Xr4/N3Y
         SkKvp4HhIR3DUpsYQ9cyBSkmU4ZAb8KK9RWwb34CdwFc/WiZ05/3PeqUM1JsZZvtSgxo
         DQOSwrnOpXbDzGaEEJ6sMKwcaApXFpTo2QGFVJZOfBZcBW9r7ofaOEB7ncqHZpqKR+hj
         0kzk5+jHylv5vY1X/V+hoXqFLNw6HgoqXX62WP5Sk59/O3wgobdi6leT+z0V7LRALXRe
         7gmKNLFiEbnfyPaK+lajTerHtItmIvbjsQbPU3kuT9f+J6ymVMD+OFwwM6IajKw9j5z6
         LuBA==
X-Forwarded-Encrypted: i=1; AJvYcCUJ7dHRLkaaO6RyMgzbBfEzhpSdapOZ/o9QW+yR2KbijBiHSXqC3If8tJQX9CTrW4o01Bc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgK4WwwvswkcN+qEcC9A9bL/XnJ1VmMbX7Z/SxGztIG5cnBJbu
	sh0gUsJ0EflsU+UmSEaWAo7US+vlbrdA+UvLEH3+XPKKykOY3V/X5BZO
X-Gm-Gg: ATEYQzyuvmhpBMb7Myb5UKhTBxKU4+sUSLjubBVNJl4ze/RkHUBMo4UbvNSRRbcf/ar
	pqUvZMYNQIuHQaMvO28RAsNS+WLOQSmnNTtlp9JCAH/bZub74TfCPSdHH5AbjbA4NsRb5mJi6Vj
	EKJUwsJuUlAh2FbuVMSynn73vATlxnjaaxnrq+ol5ufHyF1JMhUR0cguqVaGsSba0wGApu12gau
	zNxGXnaOIBgqTQFQaiwaaOoBlPmcY3VvX66PJOBXXQEZyj8VTHqXI0Z848Gd3wkLiSF0Y7d8p8H
	cfsOro6VJ6mbRgI2FU/F0HPBDUD3m5+ygzQIngqFs51KogsVo4WwF0YNX8DS4sSxAM8Su9Y7q1B
	p68vBx8ITr3039/6Df218dl+TdcBg0e4EKzGBk7YPCbaH+cyxRWOsPqDH4zBuEMbhLbeSy3mPOS
	PB5u2I4ljFwDrAmRZ5b8P3jD503vy/JCRZE/Z9W9he6Y6sbQFXy+52YZMFch+3Qg==
X-Received: by 2002:a17:90b:1d03:b0:359:8f13:667d with SMTP id 98e67ed59e1d1-35a22055567mr4736510a91.27.1773446753642;
        Fri, 13 Mar 2026 17:05:53 -0700 (PDT)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35a02fc845asm9525242a91.11.2026.03.13.17.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 17:05:53 -0700 (PDT)
Message-ID: <a41262218c37af754dda48811b3a165341c92028.camel@gmail.com>
Subject: Re: [PATCH bpf-next 2/4] bpf: Simulate branches to prune based on
 range violations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Paul Chaignon <paul.chaignon@gmail.com>, bpf@vger.kernel.org
Cc: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>,  Shung-Hsi Yu <shung-hsi.yu@suse.com>
Date: Fri, 13 Mar 2026 17:05:50 -0700
In-Reply-To: <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>
References: <cover.1773441432.git.paul.chaignon@gmail.com>
	 <aacec3599b3965e022be1b9792f29e88a1780a78.1773441432.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-03-13 at 23:54 +0100, Paul Chaignon wrote:
> From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
>=20
> This patch fixes the invariant violation warnings. These warnings
> happen after we refine ranges & tnum based on an incorrectly-detected
> branch condition. For example, the branch is always true, but we miss
> it in is_branch_taken; we then refine based on the branch being false
> and end up with incoherent ranges (e.g. umax < umin).
>=20
> To avoid this, we can simulate the refinement on both branches. More
> specifically, this patch simulates both branches taken using
> regs_refine_cond_op and reg_bounds_sync. If the resulting register
> states are ill-formed on one of the branches, is_branch_taken can mark
> that branch as "never taken".
>=20
> On a more formal note, we can deduce a branch is not taken when
> regs_refine_cond_op or reg_bounds_syncreturns an ill-formed state
> because the branch operators are sound (formally verified). Soundness
> means that the verifier is guaranteed to produce sound outputs on the
> taken branches. On the non-taken branch (explored because of
> imprecision in the bounds), the verifier is free to produce any output.
> We use ill-formedness as a signal that the branch is dead and prune
> that branch.

So, the argument here is that only the following transitions are
possible:
- reg_bounds_sync(valid reg) -> reg_bounds_sync(valid reg)
- reg_bounds_sync(invalid reg) -> reg_bounds_sync(invalid reg)
- reg_bounds_sync(invalid reg) -> reg_bounds_sync(valid reg)
                                  but this is sound, albeit imprecise

right?

> We have had five patches fixing specific cases of invariant violations
> in the past, all added with selftests:
> - commit fbc7aef517d8 ("bpf: Fix u32/s32 bounds when ranges cross
> =C2=A0 min/max boundary")
> - commit efc11a667878 ("bpf: Improve bounds when tnum has a single
> =C2=A0 possible value")
> - commit f41345f47fb2 ("bpf: Use tnums for JEQ/JNE is_branch_taken
> =C2=A0 logic")
> - commit 00bf8d0c6c9b ("bpf: Improve bounds when s64 crosses sign
> =C2=A0 boundary")
> - commit 6279846b9b25 ("bpf: Forget ranges when refining tnum after
> =C2=A0 JSET")
>=20
> To confirm that this patch addresses all invariant violations, we have
> also reverted those five commits and verified that their related
> selftests don't cause any invariant violation warnings anymore. Those
> selftests still fail but only because of mis-detected branches or
> less-precise bounds than expected. This demonstrates that the current
> patch is enough to avoid the invariant violation warning AND that the
> previous five patches are still useful to improve branch detection.
>=20
> In addition to the selftests, this change was also tested with the
> Cilium complexity test suite: all programs were successfully loaded and
> it didn't change the number of processed instructions.
>=20
> Fixes: 5f99f312bd3b ("bpf: add register bounds sanity checks and sanitiza=
tion")
> Reported-by: syzbot+c950cc277150935cc0b5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dc950cc277150935cc0b5
> Co-developed-by: Paul Chaignon <paul.chaignon@gmail.com>
> Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
> Signed-off-by: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.c=
om>
> ---
> =C2=A0kernel/bpf/verifier.c | 53 ++++++++++++++++++++++++++++++++++++++++=
++-
> =C2=A01 file changed, 52 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 974305ef3210..bd3bdfb6b0c1 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -16676,6 +16676,57 @@ static void find_good_pkt_pointers(struct bpf_ve=
rifier_state *vstate,
> =C2=A0	}));
> =C2=A0}
> =C2=A0
> +static void regs_refine_cond_op(struct bpf_reg_state *reg1, struct bpf_r=
eg_state *reg2,
> +				u8 opcode, bool is_jmp32);
> +static u8 rev_opcode(u8 opcode);
> +
> +/* Learn more information about live branches by simulating both branche=
s being taken using
> + * regs_refine_cond_op. Because regs_refine_cond_op is sound when the br=
anch is taken, if it
> + * produces ill-formed register bounds, it must mean that the branch is =
dead.
> + */
> +static int simulate_both_branches_taken(struct bpf_reg_state *false_reg1=
,
> +					struct bpf_reg_state *false_reg2, u8 opcode, bool is_jmp32)
> +{
> +	struct bpf_reg_state false_reg1_c, false_reg2_c, true_reg1_c, true_reg2=
_c;

struct bpf_reg_state size is 112 bytes, so the above takes ~448 bytes
of kernel stack. So far we tried to reduce the stack usage by moving
big temporaries/buffers inside bpf_verifier_env.

An additional benefit from storing these registers in `env` is that
there would no need to recompute registers state in check_cond_jmp_op().

> +
> +	/* Create copies of reg states to simulate both branches because regs_r=
efine_cond_op
> +	 * will modify the reg states passed in.
> +	 */
> +	memcpy(&false_reg1_c, false_reg1, sizeof(struct bpf_reg_state));
> +	memcpy(&false_reg2_c, false_reg2, sizeof(struct bpf_reg_state));
> +	memcpy(&true_reg1_c, false_reg1, sizeof(struct bpf_reg_state));
> +	memcpy(&true_reg2_c, false_reg2, sizeof(struct bpf_reg_state));

Nit: there is (a now useless) wrapper for this: `copy_register_state`/

> +
> +	/* Fallthrough (FALSE) branch */
> +	regs_refine_cond_op(&false_reg1_c, &false_reg2_c, rev_opcode(opcode), i=
s_jmp32);
> +	/* If there is a range bounds violation in *any* of the abstract values=
 in either
> +	 * reg_states in the FALSE branch (i.e. false_reg1, false_reg2), the FA=
LSE branch must be
> +	 * dead. Only TRUE branch will be taken.
> +	 */
> +	if (range_bounds_violation(&false_reg1_c) || range_bounds_violation(&fa=
lse_reg2_c))
> +		return 1;

How hard would it be to modify reg_bounds_sync() such that it
preserves invariant violation? Thus avoiding the first round of
range_bounds_violation() checks.

> +	reg_bounds_sync(&false_reg1_c);
> +	reg_bounds_sync(&false_reg2_c);
> +	if (range_bounds_violation(&false_reg1_c) || range_bounds_violation(&fa=
lse_reg2_c))
> +		return 1;
> +
> +	/* Jump (TRUE) branch */
> +	regs_refine_cond_op(&true_reg1_c, &true_reg2_c, opcode, is_jmp32);
> +	/* If there is a range bounds violation in *any* of the abstract values=
 in either
> +	 * reg_states in the TRUE branch (i.e. true_reg1, true_reg2), the TRUE =
branch must be dead.
> +	 * Only TRUE branch will be taken.
> +	 */
> +	if (range_bounds_violation(&true_reg1_c) || range_bounds_violation(&tru=
e_reg2_c))
> +		return 0;
> +	reg_bounds_sync(&true_reg1_c);
> +	reg_bounds_sync(&true_reg2_c);
> +	if (range_bounds_violation(&true_reg1_c) || range_bounds_violation(&tru=
e_reg2_c))
> +		return 0;
> +
> +	/* Both branches are possible, we can't determine which one will be tak=
en. */
> +	return -1;
> +}
> +
> =C2=A0/*
> =C2=A0 * <reg1> <op> <reg2>, currently assuming reg2 is a constant
> =C2=A0 */
> @@ -16832,7 +16883,7 @@ static int is_scalar_branch_taken(struct bpf_reg_=
state *reg1, struct
> bpf_reg_sta
> =C2=A0		break;
> =C2=A0	}
> =C2=A0
> -	return -1;
> +	return simulate_both_branches_taken(reg1, reg2, opcode, is_jmp32);
> =C2=A0}
> =C2=A0
> =C2=A0static int flip_opcode(u32 opcode)
