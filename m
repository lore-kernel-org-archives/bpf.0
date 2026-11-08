Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794138213;
	b=kLck+PX4DT2d348S9KJn/2XPvsiVv+Oi01teofhCWr6PQx1A/9t44V4Gr9L5rrw6WyPA
	 pTb9pj+Lv9kGptcHE0zsojh0zNOvsgt5YNyGr1pGjMMNsFg4N/eDW5e8hvgeq6uqNipWV
	 CEQsVP81q+0PetEXGJkquZTjELFWLStBMD4zK36ZOKviC0bWaK+0u4Qr3pfJ0HxIDANaO
	 fHbkrkY5CuYlTQedswc6jrzqQ3LNbCcYYBWSVwz+teJVbNyakNNdPU8X4yrnUE2IciNhM
	 u0JRXaCk/nCwtotZ/ZB/8BKxssc1r70kDYyvi8Kb8JWBxJAw2vnUUbPH5PvHYNiDNMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794138213;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VwQGFsaaCoMROSPE2Da/1tMfn7BcmAloMkj2bJskjEI=;
	b=lgrslsNE8cdsV7OntdmyEN3mUoX/5x5ptOoefMATDApSfIyaxyNdT3so/skJLNw1mEZe
	 XRht8OpzYZgBgV5m37ET7l7olMzSO4wgQkgoGCaJjsfmC4QtiJa0utrETANroKyJcNOWO
	 SqxtIJ+WZjCwP7BusKTenCfBuFjX5bA+a4pgSwJAr/aKbfYuJlH2IwVZBg3Gl9ECto0qy
	 JC9Q1d2boH7FVQtn9PSlhF/ba+X5Ouau7ERo0NJy0NjJRbbxNjWrndGS5NtfKffj3G/xD
	 ffuwlJe3nCP9nZ9tDgLvMymrI1so3kmZuAm2NX5wAi4miQ6825SzGkr3t+VHaG9PR8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=fail reason="signature verification failed" header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0cw5gtW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECC4606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S0cw5gtW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8753C1F0089F;
	Sun,  8 Nov 2026 11:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794138212;
	bh=VwQGFsaaCoMROSPE2Da/1tMfn7BcmAloMkj2bJskjEI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=S0cw5gtW/h9wOfpi24c0z4XXuiTegGbNkIAjQrt++QxS99ghrd3J8Kjn2UokX7how
	 K6pRsO6eavp4mb/tlvZYnEp+IavUbQOxbBMFR1UYa1Uk63F3i2fms+alNUOuGQ8ivO
	 HW2uA/5z3dYQUubfN7n29Gyff6QIpuWu6ad1gJr21bN7rBsmEJ9CrZw58xOnEn/fVo
	 l2P05CqSaYSPPGMGKhVDsHUGfGkYlahiE9mts6LvxG7V+G6w3RQi9ARq982fiiW34t
	 pG64Uy9lv9nvE7RJMq28VoRTIvRDFkGkmACgsabYqrxFbMHFHLhpVGtKikFiIGFGa1
	 uoONW16Tdyznw==
Message-ID: <sashiko-outbox-203699@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 1/3] riscv: implement this_cpu operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, dennis@kernel.org, tj@kernel.org, cl@gentwo.org, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org, thuth@redhat.com, ajones@ventanamicro.com, ben.dooks@codethink.co.uk, rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com, conor.dooley@microchip.com, tglx@kernel.org, debug@rivosinc.com, seanwascoding@gmail.com, andybnac@gmail.com, menglong8.dong@gmail.com, cyrilbur@tenstorrent.com, wangruikang@iscas.ac.cn, atishp@rivosinc.com, apatel@ventanamicro.com, linux-mm@kvack.org, bpf@vger.kernel.org, arnd@arndb.de, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, qingfang.deng@siflower.com.cn, dave@stgolabs.net, emil@etsalapatis.com
 , ihor.solodrai@linux.dev, broonie@kernel.org
In-Reply-To: <20261108110406.97495-2-cuiyunhui@bytedance.com>
References: <20261108110406.97495-1-cuiyunhui@bytedance.com>
 <20261108110406.97495-2-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 11:43:30 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] riscv: percpu: typeof(pcp) retains __percpu and const qualifiers
  in locals
--

commit 9753271dee3a084b7bff8ad7ad29d76cb64e49f4
Author: Yunhui Cui <cuiyunhui@bytedance.com>

riscv: implement this_cpu operations

This commit implements RISC-V-specific this_cpu operations using preemption
disablement and relaxed AMOs (or 32-bit LR/SC for 8-bit and 16-bit accesses
when Zabha is unavailable).

Link: https://lore.kernel.org/r/20260826010748.zphu3wh2hlm4t4o2@offworld

> diff --git a/arch/riscv/include/asm/percpu.h b/arch/riscv/include/asm/per=
cpu.h
> new file mode 100644
> index 0000000000000..280b122b9fe69
> --- /dev/null
> +++ b/arch/riscv/include/asm/percpu.h

[ ... ]

> +#define _pcp_protect_return(op, pcp, args...)				\
> +({									\
> +	typeof(pcp) __retval;						\
> +	preempt_disable_notrace();					\
> +	__retval =3D (typeof(pcp))op(raw_cpu_ptr(&(pcp)), ##args);	\
> +	preempt_enable_notrace();					\
> +	__retval;							\
> +})
> +
> +#define _pcp_protect_cmpxchg_return(op, pcp, old, new)			\
> +({									\
> +	typeof(pcp) __retval;						\
> +	typeof(pcp) *__pcp_ptr;						\
> +									\
> +	preempt_disable_notrace();					\
> +	__pcp_ptr =3D raw_cpu_ptr(&(pcp));				\
> +	instrument_atomic_read_write(__pcp_ptr, sizeof(*__pcp_ptr));	\
> +	__retval =3D (typeof(pcp))op(__pcp_ptr, (unsigned long)(old),	\
> +				     (unsigned long)(new));		\
> +	preempt_enable_notrace();					\
> +	__retval;							\
> +})

[ ... ]

> +#define this_cpu_cmpxchg128(pcp, o, n)					\
> +({									\
> +	u128 old__ =3D (o), new__ =3D (n), ret__;				\
> +	typeof(pcp) *ptr__;						\
> +									\
> +	preempt_disable_notrace();					\
> +	ptr__ =3D raw_cpu_ptr(&(pcp));					\
> +	if (system_has_cmpxchg128())					\
> +		ret__ =3D cmpxchg128_local(ptr__, old__, new__);		\
> +	else								\
> +		ret__ =3D __percpu_generic_cmpxchg128(ptr__, old__, new__); \
> +	preempt_enable_notrace();					\
> +	ret__;								\
> +})

[Severity: Low]
Should _pcp_protect_return(), _pcp_protect_cmpxchg_return(), and
this_cpu_cmpxchg128() use TYPEOF_UNQUAL(pcp) instead of typeof(pcp) for
their local variables and pointers?

typeof(pcp) retains the __percpu address-space and const qualifiers from
pcp.  Because raw_cpu_ptr() strips __percpu via PERCPU_PTR() (since commit
6a39fe05ecaa ("percpu: use TYPEOF_UNQUAL() in *_cpu_ptr() accessors")),
declaring __pcp_ptr and ptr__ with typeof(pcp) * leaves them in the
__percpu address space and triggers sparse address-space mismatch warnings
on assignment from raw_cpu_ptr() and when passing them to helpers taking
regular pointers.  Retaining const on __retval also causes a build error if
this_cpu_read() is used on a const per-CPU variable.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108110406.9749=
5-1-cuiyunhui@bytedance.com?part=3D1
