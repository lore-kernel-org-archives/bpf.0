Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793114107;
	b=jMo2OYlhoF8vNcx0AmnxS0iMkNdB4FsWNs8M5iQGQDiVIxfx82rf6PbyIcphhQ63+edl
	 1oczvDdZQhrmxGUfgBoS+ZKXY8ES2UYwk6seBAiCqXM0eFe5vCgd7IYWPGG4Kh/tZtq9p
	 y6ZFJVGAOYJvFY299CzmS7TSXEd8DPgbcGfPl1Lto+krnJJdU6oitduY1n4fIHlq2aOiR
	 fFU5QwDQuoecJEm78ZvSn9d9tYmw/tu7dnicbHzM6iO0u33627LdS/kbVyt08X3xS1Zp4
	 4RR/NS6jB7AlBT63tY/F0CyTLQ78aqS9R7Wakwko89lBIob3G47h/U1imiI86X4I08g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793114107;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8Dg5RqFu1U+WwFY3qsMcMAcDofgLEtToUk7x3ImG0b4=;
	b=19pb/Kr1w7x9YUKWbBjQrtebRsDjQohbj9Qiy4K8DL/vrvE/hxPkzFLdOFDVjYSODzbY
	 7EaMsbdtmnYsAFE7+fnRcOX6H1kVWU8/1gNbrHIsLWpk6e7NV88lv1slol6iCQ0ErA7bz
	 a4CpsJYQiJhwvbpGHzpW5TCqrcbRHq1prv1sJlUYLj/nkzRf7fGuhcNrW/zkxhAbLZbzR
	 XmTJpSv59c/rvN1DSTCPOLIjLi75BrIECDTPvQ9JebU85BzsfdURAC3SEojgWu2tvP5cn
	 003/cGQ7xxWWu2slu8bnwnABQWeFXBTusfBTeKC+aj1TH8IBXxlGt9ubHvZ7eFG23Nw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivQP5DlF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09328606A321
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 15:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ivQP5DlF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B80A1F01825;
	Tue, 27 Oct 2026 15:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793114106;
	bh=8Dg5RqFu1U+WwFY3qsMcMAcDofgLEtToUk7x3ImG0b4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ivQP5DlFRMoRl8wE10qVFeq201r/X6NvNgMBRIA5XFe9ULUIrjqDW5SZoM8s/Cm2c
	 wTr05dX+kcXxT6asUIsRe8mAXlxbd3YczC3DC/sivhkya0hF8GMefUKshrvreJKhHk
	 HpKDcHiY5tS6MtyKnjKto4r+4HIBZsBO50t8Ps44bgw6gfVZgMM7LjRo5lZ7TJfAQ+
	 j+YWYi2td6Gy6s9sE1A68sKvrIreP2BZ7ENxoClJTJoSxuK/ejs0UaHyJRg/1E4R/y
	 ChmpqbYbzSrTRhkt2gPaKK6Vs8SjExU3cJoNaUJZMMp42WF2r2976pgoA+dQHkH10T
	 V6WM/oJEAwvWQ==
Message-ID: <sashiko-outbox-186817@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: fix out-of-bounds frame access for async callback
 stack args
Reply-To: sashiko-reviews@lists.linux.dev
To: "Henry Martin" <bsdhenrymartin@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261027150237.938383-1-bsdhenrymartin@gmail.com>
References: <20261027150237.938383-1-bsdhenrymartin@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 15:15:06 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] bpf: incomplete caller stack_arg_regs validation in check_stac=
k_arg_read()
--

commit a0bf590a32c2dfabebbd87131532c05aca33f96d
Author: Henry Martin <bsdhenrymartin@gmail.com>

bpf: fix out-of-bounds frame access for async callback stack args

This commit adds a check in check_stack_arg_read() to reject r11-based
incoming stack argument loads when vstate->curframe =3D=3D 0, preventing an
out-of-bounds read on vstate->frame[-1] for async callbacks queued via
push_async_cb().

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 5601d20562186..51e07d1aaea4f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -4653,6 +4653,11 @@ static int check_stack_arg_read(struct bpf_verifie=
r_env *env, struct bpf_func_st
>  		return -EACCES;
>  	}
> =20
> +	if (vstate->curframe =3D=3D 0) {
> +		verbose(env, "stack arg read with no caller frame\n");
> +		return -EINVAL;
> +	}
> +
>  	caller =3D vstate->frame[vstate->curframe - 1];
>  	arg =3D &caller->stack_arg_regs[spi];

[Severity: Critical]
Is checking vstate->curframe =3D=3D 0 sufficient to ensure that
caller->stack_arg_regs[spi] is valid and initialized here?

Synchronous callbacks (such as those passed to bpf_loop or
bpf_for_each_map_elem) are queued via push_callback_call(), which advances
curframe via push_stack() and setup_func_entry() so that curframe >=3D 1 and
state->in_callback_fn is true:

kernel/bpf/verifier.c:push_callback_call() {
	caller =3D state->frame[state->curframe];
	err =3D btf_check_subprog_call(env, subprog);
	if (err =3D=3D -EFAULT)
		return err;
	...
	callback_state =3D push_stack(env, env->subprog_info[subprog].start, insn_=
idx, false);
	if (IS_ERR(callback_state))
		return PTR_ERR(callback_state);

	err =3D setup_func_entry(env, subprog, insn_idx, set_callee_state_cb,
			       callback_state);
}

When a static subprogram declares more than 5 BTF arguments,
prepare_subprog_args() caches sub->arg_slot_cnt > 5 (so
bpf_in_stack_arg_cnt(subprog) > 0), and btf_check_func_arg_match() can retu=
rn
-EINVAL before reaching check_func_args() -> check_outgoing_stack_args():

kernel/bpf/verifier.c:btf_check_func_arg_match() {
	if (!bpf_subprog_is_global(env, subprog)) {
		for (i =3D 0; i < min_t(u32, sub->arg_slot_cnt, MAX_BPF_FUNC_REG_ARGS); i=
++)
			if (caller->regs[BPF_REG_1 + i].type =3D=3D NOT_INIT)
				return -EINVAL;
	}
	return check_func_args(env, &meta, env->insn_idx);
}

Similarly, once a static subprogram is marked unreliable by a prior call,
btf_check_subprog_call() returns -EINVAL immediately without running
check_outgoing_stack_args() for the new caller frame:

kernel/bpf/verifier.c:btf_check_subprog_call() {
	if (prog->aux->func_info_aux[subprog].unreliable)
		return -EINVAL;

	err =3D btf_check_func_arg_match(env, subprog, btf);
	if (err)
		prog->aux->func_info_aux[subprog].unreliable =3D true;
	return err;
}

Because push_callback_call(), check_func_call(), and check_func_callx()
ignore -EINVAL from btf_check_subprog_call(), execution can reach
check_stack_arg_read() with vstate->curframe >=3D 1 without
check_outgoing_stack_args() having validated the caller's outgoing stack
arguments.

If caller->out_stack_arg_cnt <=3D spi, won't indexing caller->stack_arg_reg=
s[spi]
trigger a NULL pointer dereference or slab out-of-bounds read? And for a
synchronous callback where the frame invoking the helper wrote an outgoing
stack argument slot prior to the helper call, push_callback_call() clones
caller->stack_arg_regs before invalidate_outgoing_stack_args() runs, so
wouldn't check_stack_arg_read() copy that register state into
cur->regs[dst_regno] even though the kernel helper does not pass BPF stack
arguments at runtime?

Should check_stack_arg_read() also reject loads when state->in_callback_fn =
is
set, or when spi >=3D caller->out_stack_arg_cnt or
caller->stack_arg_regs[spi].type =3D=3D NOT_INIT?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027150237.9383=
83-1-bsdhenrymartin@gmail.com?part=3D1
