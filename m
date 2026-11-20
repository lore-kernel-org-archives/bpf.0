Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795163129;
	b=RXXOOhO7jB3wVrUMq54LDi//IIbjofrFmuFEw/0io0ypgg/4h4N/272exPd3YGYouX8C
	 2yCsP6ooymfrYtVT36rc+cIxD3+OvkIxoppfc1e4ON5DE/SOD09DjkhCTxZlmvkgTTuAe
	 kpUKC6M6tDH95ippSs+FBAFeYVT7tRIvWhHRoothoBODygmZ1LCFWkbxyiZy/ZjyFYiKh
	 J27IoaZh8rgT14dZaFEP1Tzzk6l3hCjFDK10b/SWweE0WqiOyiNM0EID+iYoY4KuiEhux
	 Gai2vyzjKyE1velGxGjo03PyZgXyopanPEMiM1ux0QB/qsMBoVvzxyhf82Jx6P/o/Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795163129;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Ez13IOwOLNPPYWlxIajx2XcnRHlor2z7zZPOeodgmpM=;
	b=lxN3p5KuPoyyX7kOLEwi2/HC4V4bAwdrm93mCdEv6Lj48hKFRNjrpMLR0ue2wFI0Mv8r
	 rEtqK1/mKPsa96N5MrwcTsAndQjHlbiYd4xxZYdlE+e83l/DfZNnK+sD7oTc30hT3aKla
	 zy8bKiSmfKhJmIfH+E6BVcZ6G+KXsAan2eZok+4E2u7QYusGeKlOgv25v2I+LoTCZBa9+
	 yFhIS2Cic21OfWl9CL78r6tc0IHXvJgMAlq1ZvOwuxDZEiNIwfSnDgN9d9GUmwfR0Wltg
	 4GqRkTC+apglBjlWq357czvY8wm+x1BfC7XMXaeVkgU+kuZo+PLoh7ehKJL9zROEemg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHQfOx43;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C81606A326
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 08:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oHQfOx43
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B0B81F000CA;
	Fri, 20 Nov 2026 08:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795163129;
	bh=Ez13IOwOLNPPYWlxIajx2XcnRHlor2z7zZPOeodgmpM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=oHQfOx4340qiQrgCm1VmxNyaz1+jos2RTUVw1CHHBAjsTdkDVe1l7/avPxvnLsI3a
	 dni4x3n0Nru1GgqCqYmNzUwqRxrtJ9Dk9O17PT4Z6u1D+QdwXSbWgJG8VwDKNopGKZ
	 5gpGhD802V0V+v2fb1ZwaBooGypRbxSaX9SxogiUOEUoygfMDNZMCbiCrpRCruCowF
	 By3CIT0JvLEKWFsyTBW6fZl+Z6RApsClptpWsgqQqR/6Cbk35SyKTBy/br+XikVFig
	 d0I2iubHbHMaX1/CCVasI9bR2ZmQxNoN8eLG0Pa+8rDD/e9/gVM1VFXOYYvJ4wub+o
	 4stE87FmigXVQ==
Content-Type: multipart/mixed; boundary="===============3318702700188406068=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <7b04662404b23938a69ae6f8e19f977600ba54626e25e2729d08a6532f71b8ce@mail.kernel.org>
In-Reply-To: <20261120074430.2704488-8-alexei.starovoitov@gmail.com>
References: <20261120074430.2704488-8-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 07/49] bpf: Name an id after the xreg that has it
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 08:25:28 +0000 (UTC)

--===============3318702700188406068==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Name an id after the xreg that has it

TL;DR:
- Verifier log ids change (e.g. "Unreleased reference id=2" can't appear now),
  so several selftest __msg() patterns likely fail; none updated
- Id naming comment doesn't match bpf_renumber_ids(), and bpf_id_is_xreg() is
  true for returned ids
- reg_object_equal() is unused

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -241,6 +241,12 @@ static inline bool reg_fixed_part_equal(const struct bpf_reg_state *ra,
>  	return ra->type == rb->type && !memcmp(&ra->raw, &rb->raw, sizeof(ra->raw));
>  }
>
> +/* That and the ids, see bpf_renumber_ids() */
> +static inline bool reg_object_equal(const struct bpf_reg_state *ra, const struct bpf_reg_state *rb)
> +{
> +	return !memcmp(ra, rb, offsetof(struct bpf_reg_state, var_off));
> +}

The commit message says "Equal sets have equal ids now, and
reg_object_equal() is a memcmp()."  Nothing calls reg_object_equal() at
this commit, or at the end of the series (a50a112fb866 "bpf: Delete the
equations that say nothing").  refsafe(), regsafe() and the join code that
would use it are not defined in this tree.

Should the helper be added together with its first user, or should the
changelog say that it is groundwork that is not used yet?

[ ... ]

> @@ -1048,21 +1060,28 @@ struct bpf_id_pair {
>  };
>
>  /*
> - * A function that is verified on its own, see func_is_on_its_own(), has no ids of its caller.
[ ... ]
> + * At a join point each id gets the number of the xreg that has it, see bpf_renumber_ids().
> + * The low bits give the origin of the id:
> + *
> + *  bpf_new_id()       an insn made it. It is renumbered at the end of the basic block.
> + *  BPF_REF_ID()       it is held. The number is the index in refs[].
> + *  BPF_XREG_ID()      the number is the first xreg that has it.
> + *  BPF_RETURNED_ID()  a function on its own returned it. No xreg of the caller has it.
[ ... ]
> + */
> +#define bpf_new_id(env)		(((env)->id_gen += 4) - 3)
> +#define BPF_REF_ID(i)		(((i) + 1) << 2)
> +#define BPF_XREG_ID(i)		((i) << 2 | 2)
> +#define BPF_RETURNED_ID(id)	((id) | 1)
> +
> +static inline bool bpf_id_is_xreg(u32 id)
> +{
> +	return id & 2;
> +}

This comment says BPF_REF_ID() takes the index in refs[] and BPF_XREG_ID()
takes the first xreg, but bpf_renumber_ids() in kernel/bpf/states.c passes
other numbers:

  renumber_id(env, &st->refs[i].id, BPF_REF_ID(2 * i));
  renumber_id(env, &st->refs[i].parent_id, BPF_REF_ID(2 * i + 1));

so BPF_REF_ID(1) is the name of refs[0].parent_id, not of refs[1].id.
Likewise BPF_XREG_ID() gets 3 * xreg, 3 * xreg + 1 and 3 * xreg + 2 for
id, parent_id and map_uid, and the xreg itself is numbered by
fr * (BPF_ID_MAP_SIZE / MAX_CALL_FRAMES + 1) + ..., which differs from the
hidden registers at 11..13 and fp-8 at MAX_BPF_EXT_REG defined earlier in
the same header.

Can the refs index or the xreg be read back from a printed id the way the
comment and the commit message describe?  The ids appear in "Unreleased
reference id=%d" and in the register dumps.

Also, bpf_id_is_xreg() returns true for BPF_RETURNED_ID() values (bit 1 is
set in 3 mod 4), while the comment says no xreg of the caller has those
ids.  The current callers of arg_needs_caller() only become more
conservative because of it, but is that the intended meaning of the name?

[ ... ]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -12586,7 +12490,7 @@ static int check_reference_leak(struct bpf_verifier_env *env, bool exception_exi
>  			continue;
>  		verbose(env, "Unreleased reference id=%d alloc_insn=%d\n",
>  			state->refs[i].id, state->refs[i].insn_idx);
> -		bpf_diag_leak(env, state->refs[i].id, state->refs[i].insn_idx, env->insn_idx);
> +		bpf_diag_leak(env, &state->refs[i], env->insn_idx);
>  		refs_lingering = true;

The id printed here has different values now.  A reference id comes from
bpf_new_id(), which gives 1, 5, 9, ..., or from a BPF_REF_ID() name given
by bpf_renumber_ids(), which gives 4, 12, 20, ...  So the values 2 and 3
can never be printed, but several selftests match exactly those values:

  tools/testing/selftests/bpf/progs/verifier_sock.c
      __msg("Unreleased reference id=2 alloc_insn=6")
  tools/testing/selftests/bpf/progs/iters_state_safety.c
      __msg("Unreleased reference id=2 alloc_insn=7")
  tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
      __msg("Unreleased reference id=3 alloc_insn={{[0-9]+}}")
  tools/testing/selftests/bpf/progs/rbtree_fail.c
      __msg("Unreleased reference id=3 alloc_insn={{[0-9]+}}")

In the sockmap case check_helper_call() gives R0 the id bpf_new_id() == 1
for PTR_MAYBE_NULL, and then acquire_reference() gives it bpf_new_id() ==
5, so the log would say "Unreleased reference id=5 alloc_insn=6" where it
used to say id=2.  Other __msg() patterns in 13 progs/ files match numeric
ids such as "(id=1," and depend on the same numbering.

No commit in b96f99ad6132..a50a112fb866 touches tools/testing/selftests/bpf,
and the commit message does not mention that the log output changes.  Do
these expected messages need updating?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44698144269
--===============3318702700188406068==--
