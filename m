Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794481551;
	b=V5l1iZZvJKITDPP7dzl+/Q4lqg4MJMJl656z8VGBkkLWp4GxSulGISC1yM2ChIn0jbGj
	 4qrk7m2tM2NObZC1TccKp1cWTFbVvBR6AQgWMtj0BeYUDSXV5FoYqr6h5OdTZpopQpO2v
	 cA4OrQd6tQNGmtIaBh6r35hwu7QaaPluvgaqKUZJM+0ZNT6qkLENUCZbTqLahTCsc7zHr
	 YalLsZcOClzL1qc0+nH7NsKMiI7grMd1+8M5/X+xKOq+TjJHdvKhA7mFO196tfR6ouHUZ
	 5uTWp2OCoPN7fYRzPf7bsgVnT/sO50ym79oeZ5WIefcKUAoPddrJbqhIqKnTCuwwjsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794481551;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=S89kIsd7BUlNlcCFv+9S+QJBXNwSQ/ww2MZ5b/xIKxw=;
	b=208DINBUYsTAv8kgHXqsE0aqy5CJ4Nf8yF9t3EbbAdKK7xrF5hM0KQar2vPuwsPG8hC+
	 Hgo070HsNwFUL2I26NWkgSdDb/ou89qCcYPA2uRPebivKOTIxX6Qijkh1YVHlpvO460w8
	 4k2O8yD22XgC/13zEnzhuTAkuekELTOb7DdN7+wXOIctLm5BT2US+9MKZ8aIbyVwESpPi
	 1ey3ke/9fVe9EUCUwDKgmqqOQaps5EpWAGvUthdjqqZuv//k2Mf3dIKqdU6y5PDtdMr7j
	 MrcnPQzNa0XOQL9vX5tJvB9PpbjQ6fp/5KqLZpV+nSaTGfSyPmLxOSpARM20Zg5Ft/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oA970PEO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32CEE606A323
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 11:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oA970PEO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096681F00A05;
	Thu, 12 Nov 2026 11:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794481550;
	bh=S89kIsd7BUlNlcCFv+9S+QJBXNwSQ/ww2MZ5b/xIKxw=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=oA970PEOuLEH/aI6RiajFyeNZAl4rDhQbuif1X1YEtlCcn8f2VvX5zNyjcgEtM+w1
	 LMumGtAQKRoKfB2FEhatsvGjYvQuAts20+c25DfIJ0jQvaqJ2vuyMpsU6xCIn5wldx
	 Awi8pRUt/jOSJksmknaiEDYsbiQTfvzb2Keh+gd0GQYNPcLGz9hmJlIbuytou3SU2y
	 ld8fW2+dYAQBVR9SXudIP+agL9pUjTuTCAkvtYTk85W4cLQn8D8pVovdEV7XSdcuit
	 rJu3lL4WmySU+Gaz6RP9A9698+ylc5Yjvj6HGZI4AiIkJUy+DbWsyDHeLlSylN6oIs
	 OJZqj98/E80kA==
Message-ID: <sashiko-outbox-210988@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/9] riscv: add infrastructure for preemptible
 this_cpu operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yunhui Cui" <cuiyunhui@bytedance.com>, pjw@kernel.org, palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, dennis@kernel.org, tj@kernel.org, cl@gentwo.org, oleg@redhat.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, bjorn@kernel.org, pulehui@huawei.com, puranjay@kernel.org, broonie@kernel.org, dave@stgolabs.net, david.laight.linux@gmail.com, jszhang@kernel.org, tglx@kernel.org, conor.dooley@microchip.com, thuth@redhat.com, ajones@ventanamicro.com, ben.dooks@codethink.co.uk, rkrcmar@ventanamicro.com, samuel.holland@sifive.com, zong.li@sifive.com, debug@rivosinc.com, seanwascoding@gmail.com, andybnac@gmail.com, menglong8.dong@gmail.com, cyrilbur@tenstorrent.com, wangruikang@iscas.ac.cn, atishp@rivosinc.com, apatel@ventanamicro.com, arnd@arndb.de, nathan@kernel.org, nick.desaulniers+lkml@gmail.com, 
 morbo@google.com, justinstitt@google.com, qingfang.deng@siflower.com.cn, linux-mm@kvack.org, bpf@vger.kernel.org
In-Reply-To: <20261112104149.38589-3-cuiyunhui@bytedance.com>
References: <20261112104149.38589-1-cuiyunhui@bytedance.com>
 <20261112104149.38589-3-cuiyunhui@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:05:48 +0000
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
- [Medium] riscv: ptrace: wrong x0 offset assumption in
  riscv_pcpu_regs_fixup()
- [Low] riscv: entry: non-__always_inline helpers called from noinstr
  riscv_pcpu_regs_fixup()
--

commit dbc8e3fbcb707ac729e711e7321ce4a62f50767e
Author: Yunhui Cui <cuiyunhui@bytedance.com>

riscv: add infrastructure for preemptible this_cpu operations

This commit adds per-task and exception-frame tracking for registers used in
preemptible per-CPU operations so exception return can fix up the per-CPU
offset and address registers if the task migrated.

Link: https://lore.kernel.org/r/20261108213254.67805ef0@pumpkin
Link: https://lore.kernel.org/r/avG07pmpcLGkq5i-@xhacker

> diff --git a/arch/riscv/include/asm/ptrace.h b/arch/riscv/include/asm/ptr=
ace.h
> index addc8188152f7..ceff8f63bc866 100644
> --- a/arch/riscv/include/asm/ptrace.h
> +++ b/arch/riscv/include/asm/ptrace.h
> @@ -53,6 +53,8 @@ struct pt_regs {
>  	unsigned long cause;
>  	/* a0 value before the syscall */
>  	unsigned long orig_a0;
> +	/* Active preemptible per-CPU operation, if any. */
> +	unsigned long pcpu_gprs;
>  };
> =20
>  #define PTRACE_SYSEMU			0x1f
> @@ -145,6 +147,19 @@ static inline unsigned long regs_get_register(struct=
 pt_regs *regs,
>  	return *(unsigned long *)((unsigned long)regs + offset);
>  }
> =20
> +static inline void regs_set_register(struct pt_regs *regs,
> +				     unsigned int offset, unsigned long val)
> +{
> +	if (unlikely(offset > MAX_REG_OFFSET))
> +		return;
> +
> +	/* Register x0 is represented by the first, read-only slot. */
> +	if (offset)
> +		*(unsigned long *)((unsigned long)regs + offset) =3D val;
> +}
> +
> +void noinstr riscv_pcpu_regs_fixup(struct pt_regs *regs);

[Severity: Low]
Should regs_get_register() and regs_set_register() (or the GPR helpers call=
ed
by riscv_pcpu_regs_fixup()) be marked __always_inline?

riscv_pcpu_regs_fixup() is a noinstr function called from ret_from_exception
after irqentry_exit(), and under sanitizer configurations such as KASAN or
KCSAN the compiler may not inline plain static inline functions into a
noinstr caller.

[ ... ]

> diff --git a/arch/riscv/kernel/entry-common.c b/arch/riscv/kernel/entry-c=
ommon.c
> new file mode 100644
> index 0000000000000..023d856b1679b
> --- /dev/null
> +++ b/arch/riscv/kernel/entry-common.c
> @@ -0,0 +1,32 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/bitfield.h>
> +#include <linux/compiler.h>
> +#include <linux/percpu.h>
> +
> +#include <asm/current.h>
> +#include <asm/ptrace.h>
> +
> +/*
> + * If the interrupted context had an active per-CPU operation, rewrite i=
ts
> + * saved offset and address registers for the CPU on which it will resum=
e.
> + */
> +void noinstr riscv_pcpu_regs_fixup(struct pt_regs *regs)
> +{
> +	unsigned long pcpu_offset =3D __my_cpu_offset;
> +	unsigned long gprs =3D regs->pcpu_gprs;
> +	unsigned long pcp;
> +	unsigned int reg_pcp;
> +	unsigned int reg_off;
> +	unsigned int reg_addr;
> +
> +	reg_pcp =3D FIELD_GET(PCPU_GPR_PCP, gprs);
> +	reg_off =3D FIELD_GET(PCPU_GPR_OFF, gprs);
> +	reg_addr =3D FIELD_GET(PCPU_GPR_ADDR, gprs);
> +
> +	/* pt_regs offset zero represents x0, followed by x1 through x31. */
> +	pcp =3D regs_get_register(regs, reg_pcp * sizeof(unsigned long));
> +	regs_set_register(regs, reg_off * sizeof(unsigned long), pcpu_offset);
> +	regs_set_register(regs, reg_addr * sizeof(unsigned long),
> +			  pcp + pcpu_offset);
> +}

[Severity: Medium]
Does riscv_pcpu_regs_fixup() read regs->epc instead of 0 if reg_pcp is x0?

Offset 0 of struct pt_regs is epc rather than x0, and regs_get_register(reg=
s,
0) returns regs->epc without special-casing offset 0.  By contrast,
regs_set_register() treats offset 0 as read-only x0, making it inconsistent
with regs_get_register() and regs_query_register_offset() for epc while
duplicating regs_get_gpr() and regs_set_gpr() in arch/riscv/mm/extable.c:

arch/riscv/mm/extable.c:regs_get_gpr() {
	if (unlikely(!offset || offset > MAX_REG_OFFSET))
		return 0;

	return *(unsigned long *)((unsigned long)regs + offset);
}

Sharing regs_get_gpr() and regs_set_gpr() (or providing dedicated GPR-index
helpers) would return 0 for x0 and keep the byte-offset regs_get_register()
API consistent.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112104149.3858=
9-1-cuiyunhui@bytedance.com?part=3D2
