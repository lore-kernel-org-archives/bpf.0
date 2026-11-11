Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794408320;
	b=mVw2Ki05aXLaE7J/nV+IS0GkwQxDvWEpPoVwgzcbxJOwp4XvQbrMVnsNeyePap9C8s/G
	 aLnmNwPvdBbYvXMdR4m2YW6Ykoc+5cy+1qw34GB/fmIDdEoyxdkT4r3UzhSgec8j+uM7f
	 k1IRwPuDPZNWeBt1oAcW1uqcYViRG5hAgEAhTPmAGiI+rHt7lS4txqsKYBEDiNsUFdokp
	 +IS9loJOw98Iei81mXSN6z1w88lZf+1KxxjcGzvySj0rorjFtGsW/bTT91mW/FVjsmJt7
	 enLt3W0FV1oeFOmFvWFlCMT6RcXaWIMB6VqT1hW9vud0fu1lpXr4jufpSAd0sMxVfKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794408320;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UmV05VH7l21caSp7hruy6Nkc75GSzfz1tFnMwpC9RlI=;
	b=sN8jbRjTFtX8u4itqaKYODdePaC9CD1WhPUM9DDM6DlPrm7waXq5nxrtdvWNoW3T1+g7
	 n+DrS5NMxsD4i254zHns83jR5TwpwBXqQvTwnalAkLCXGfrQsWaS27vjhmBijB01aM5pR
	 KEdfEhEILmwBPmAdNCIObQYYc9pnuIoHOel5haHG2dZeLm0k/3iRqV3+l3uS8Qa0/0Su6
	 NI0x2q4MPFVrxKnu2Td+V0LTHzIS9iqegbdOsJM1bU8/HX4VvmZ9SgsBngw/jIlyqvCyA
	 wv6IJSFyhUwbdJX8yRzSjKwMxj2v2k/VXZ326SrdH65v3wOVir4j1pcbCJUYZ8LGhog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0o+Zuo2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884C5606A326
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B0o+Zuo2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486D11F00A05;
	Wed, 11 Nov 2026 14:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794408320;
	bh=UmV05VH7l21caSp7hruy6Nkc75GSzfz1tFnMwpC9RlI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=B0o+Zuo2PSPQxNSxSSPTrIBRq6X0QTRKopkyAgxFJjC5rrOOKtZ1TZKZ2zNFOYePp
	 vr1pdl4CCxyZbRkj8GNWO854jLxJQLw2cU9nSi/9ej+Dt3t5+tygTyinDdtFhdq31b
	 QZxAQjyB1KlxHw44lV7nJQQAukYLuYVHEX6dmlhZRCPAvEUJS6pQcN/qsKvumHMoDf
	 foabSh+fBnZZx9aJIsj8GBMvM0j9l6ViTzknt4QgHzLev29DBdD4QtGSeo3XwAq/fq
	 36IMJGZFAfWQKPEf63wzw3pOpDDSlev5DtvhoB3stdgauKlASn4OLLNk9wsxN1plH6
	 TdKprZT8yVzAQ==
Message-ID: <sashiko-outbox-209183@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 02/29] bpf: Add bpf_throw_unwind() and an
 arch entry hook
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <7b56a21a5f2750a8325154d741318a1d451c21ed.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
 <7b56a21a5f2750a8325154d741318a1d451c21ed.1794399387.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 14:45:19 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] bpf: missing __bpf_unwind_entry and notrace on non-returning
  bpf_throw()
- [Medium] bpf: missing noinline and __used/__retain/__noclone on
  bpf_throw_unwind()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [Critical] bpf: unprotected dentry mutation via static kfunc rewrite
  in specialize_kfunc() [1]
--

commit 83fef6290827fc9875d42699c4b52cdbf2a7cf72
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Add bpf_throw_unwind() and an arch entry hook

This commit moves the stack-unwinding body of bpf_throw() into
bpf_throw_unwind() and adds a weak bpf_arch_throw_entry() hook so an
architecture can capture callee-saved registers before unwinding.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 937a0d7d68390..de31fdd18411e 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3460,7 +3460,13 @@ static bool bpf_stack_walker(void *cookie, u64 ip,=
 u64 sp, u64 bp)
>  	return false;
>  }
> =20
> -__bpf_kfunc void bpf_throw(u64 cookie)
> +/*
> + * Unwind the stack to the exception callback of the main program. @regs=
 holds
> + * the callee-saved registers of the throw site, or is NULL when the
> + * architecture has no native entry and the kfunc was called directly.
> + */
> +__bpf_unwind_entry
> +notrace void bpf_throw_unwind(struct bpf_throw_regs *regs, u64 cookie)
>  {
>  	struct bpf_throw_ctx ctx =3D {};

[Severity: Medium]
Should bpf_throw_unwind() keep the noinline, __used, __retain, and
__noclone attributes that bpf_throw() had via __bpf_kfunc?

Without noinline, the compiler can inline bpf_throw_unwind(NULL, cookie)
into its same-file caller bpf_throw(), running the unwinding body inside a
function that is neither __noscs nor notrace.  And on architectures without
an assembly caller to bpf_throw_unwind(), LTO, --gc-sections, or IPA-SRA can
drop or clone the standalone symbol so resolve_btfids fails on
BTF_ID(func, bpf_throw_unwind) in noreturn_deny.

> @@ -3481,6 +3487,11 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  	WARN(1, "A call to BPF exception callback should never return\n");
>  }
> =20
> +__bpf_kfunc void bpf_throw(u64 cookie)
> +{
> +	bpf_throw_unwind(NULL, cookie);
> +}

[Severity: High]
Does bpf_throw() also need __bpf_unwind_entry and notrace?

Whenever bpf_arch_throw_entry() returns NULL, specialize_kfunc() leaves
calls to bpf_throw() targeting this C wrapper, which never returns either.
Under CONFIG_FRAME_POINTER=3Dy (-fno-optimize-sibling-calls), bpf_throw()
cannot tail-call bpf_throw_unwind(), so on arm64 with shadow call stack
enabled its prologue still pushes a return address onto the shadow call
stack that is never popped, corrupting the return address of the BPF
program's caller.  Likewise, without notrace, function_graph tracing on
bpf_throw() pushes an entry onto current->ret_stack that is never popped on
unwind.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 20b1b9ff574c7..c5b4025ee2223 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -24793,6 +24795,11 @@ static int specialize_kfunc(struct bpf_verifier_=
env *env, struct bpf_kfunc_desc
>  	} else if (func_id =3D=3D special_kfunc_list[KF_bpf_arena_free_pages]) {
>  		if (env->insn_aux_data[insn_idx].non_sleepable)
>  			addr =3D (unsigned long)bpf_arena_free_pages_non_sleepable;
> +	} else if (func_id =3D=3D special_kfunc_list[KF_bpf_throw]) {
> +		void *entry =3D bpf_arch_throw_entry();
> +
> +		if (entry)
> +			addr =3D (unsigned long)entry;
>  	}
>  	desc->addr =3D addr;
>  	return 0;

[Severity: Critical]
This problem wasn't introduced by this patch, but can specialize_kfunc()
cause an unlocked dentry xattr mutation [1] when rewriting
KF_bpf_set_dentry_xattr and KF_bpf_remove_dentry_xattr?

kernel/bpf/verifier.c:specialize_kfunc() {
    ...
	} else if (func_id =3D=3D special_kfunc_list[KF_bpf_set_dentry_xattr]) {
		if (bpf_lsm_has_d_inode_locked(prog))
			addr =3D (unsigned long)bpf_set_dentry_xattr_locked;
	} else if (func_id =3D=3D special_kfunc_list[KF_bpf_remove_dentry_xattr]) {
		if (bpf_lsm_has_d_inode_locked(prog))
			addr =3D (unsigned long)bpf_remove_dentry_xattr_locked;
    ...
}

The rewrite checks only whether the LSM hook holds i_rwsem on the hook's
own dentry, not whether the dentry argument passed to the kfunc is that
same dentry.  If a program attached to such a hook passes an unrelated
dentry (for example, obtained via bpf_task_get_open_file()), the _locked
variant runs __vfs_setxattr() or __vfs_removexattr() on that dentry without
holding its inode's i_rwsem.

[1] https://sashiko.dev/#/bug/linux-1f1b04a2-315c-40c0-91e1-333f3c841441

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794399387.gi=
t.memxor@gmail.com?part=3D2
