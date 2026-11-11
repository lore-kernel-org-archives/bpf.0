Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794405879;
	b=XjHCFRBbqXLL4xy9xAWa14NWJpFzSUaJJkKQQtmsacB8zpcBcYRpStymcwb1Zdv6IlVh
	 5BHzYeDNI1sy18/arqh74g2+b+/8wPex31h34XV9VD6SuVAYNAkx+A5dSyh9oe4Q+DCi+
	 Yc1/LkT+g9sk+6zPBvmvFwVzpXexAyoyvbOH2d9RkZ+u+cP2gjTsjsFWAAPjuzYpp+PbM
	 mIN8Tveo+oiSNjEGskqzewSk8RvXn0axhHicEbz2Guudta6qUeFPbcBJsEpWZ4Y6EtaOW
	 +c+slW0wyNU4SfLogZLc5JzacRyywwP+coDmVUyBynoYa6M8a1HYQoJQGFtkBykr9uw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794405879;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=aKNWF8jW5eTRiS7jioKU0pNn54GoocEL1UHYgBIru9I=;
	b=gK9KoMg7DzjtLVqWT46jvgqQk8gLdnSkXiXszBvDxdtvvAqM9/KMdO6tuX8+TnoIupTj
	 JLo91UZy8HA6j9wnVphHaIJdzNDOj+doeWQkubME7wUJ6pMcvaHT7f7d6JVQ/0c939dwS
	 KAHub0vRn1Lo67xyR3V3GY12QJ9IK/W8pzwPDigVTi3dOYwCCmFVugERD2OqPWX0Z2zEO
	 b1aY0vY8NLQnT3B5goRBn92kzyh9koDHw5glrgkKRkpMJNy4TFMTq/qnQ51sg3bvnQOoe
	 N2BUqRjwRuSQuzOOCKSd/cWNFEubDFI/b1io05u4GlySb68anUyLB9b1svUEpkZpEBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfuQvqWa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F65606A327
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mfuQvqWa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A3B81F00A06;
	Wed, 11 Nov 2026 14:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794405878;
	bh=aKNWF8jW5eTRiS7jioKU0pNn54GoocEL1UHYgBIru9I=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mfuQvqWa9Rdn0ikrYBYWlYwx7Jk62cKULaE58lomptNXoXen7S0lJJdkgcYjummZ5
	 ipmC0vwIH6LoNmfoh/CcgfCF3Bm53SmYtsLKQahcXXT2ZjUxN1gH2i5VoMuF7NSwBy
	 HstcE63X9yTkMgF/k5XHy5gpsR7QOOsFUqY8zNQPO6AefeyDt1Y+ojquYOnpovSjbU
	 zpJQ99lDSThf42Mdqc2YwZLsAf8IUaLXzIAe1ivg/dlqZbSxsYv9btFmEaah4hKTXP
	 n81b+TEbKoEnlM1W+nTIakwa3ponVsTJbamuqykfKmyKZS8myF+4uG50mM1eh/E+p5
	 nJu3dlFoPEchg==
Content-Type: multipart/mixed; boundary="===============3868269184810280649=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <84a4fee779825fcc73abafe131d55ad4f657cafe4805928da92e3133d7c1a4b0@mail.kernel.org>
In-Reply-To: <06579bd381e516e66f97d7b0c00e55d019011a7e.1794399387.git.memxor@gmail.com>
References: <06579bd381e516e66f97d7b0c00e55d019011a7e.1794399387.git.memxor@gmail.com>
Subject: Re: [PATCH bpf-next v1 12/29] bpf: Release resources in hidden slots on bpf_throw()
From: bot+bpf-ci@kernel.org
To: memxor@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ihor.solodrai@linux.dev,kkd@meta.com,kernel-team@meta.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 14:04:38 +0000 (UTC)

--===============3868269184810280649==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Release resources in hidden slots on bpf_throw()

TL;DR:
- Possible link failure with CONFIG_NET=y, INET=n: bpf_sk_release_proto is
  guarded by INET, not NET
- bpf_throw() unwind may release spin locks and IRQ flags out of order,
  leaving IRQs disabled or the held-lock table wrong

> diff --git a/kernel/bpf/unwind.c b/kernel/bpf/unwind.c
> new file mode 100644
> index 000000000000..3b488a4bd759
> --- /dev/null
> +++ b/kernel/bpf/unwind.c

[ ... ]

> +noinline void bpf_unwind_release(const struct bpf_resource *res, void *handle)
> +{

[ ... ]

> +#ifdef CONFIG_NET
> +	case BPF_RESOURCE_SOCK:
> +		bpf_sk_release_proto.func((u64)(long)handle, 0, 0, 0, 0);
> +		break;
> +#endif

Can this fail to link with CONFIG_NET=y, CONFIG_INET=n and
CONFIG_BPF_SYSCALL=y?

unwind.o is built whenever CONFIG_BPF_SYSCALL is set, and this case is
compiled under CONFIG_NET.  But bpf_sk_release_proto is defined in
net/core/filter.c inside the CONFIG_INET block:

net/core/filter.c:
    #ifdef CONFIG_INET
    ...
    const struct bpf_func_proto bpf_sk_release_proto = {
    ...
    #endif /* CONFIG_INET */

INET is a separate bool under NET and BPF_SYSCALL does not select it, so
vmlinux would end up with an undefined reference to bpf_sk_release_proto.

Should the guard here be CONFIG_INET, matching the definition (as
kernel/bpf/cgroup.c does for bpf_tcp_sock_proto)?

[ ... ]

> +static void bpf_unwind_release_frame(struct bpf_unwind_ctx *ctx, const struct bpf_prog *prog, u64 bp)
> +{

[ ... ]

> +			if (!handle || release_phase(res) != ctx->phase)
> +				continue;
> +			late = res->kind == BPF_RESOURCE_IRQ_FLAG &&
> +			       !arch_irqs_disabled_flags(*(unsigned long *)handle);
> +			if (passes == 2 && late != (pass == 1))
> +				continue;
> +			bpf_unwind_release(res, handle);
> +		}
> +	}
> +}

Only BPF_RESOURCE_IRQ_FLAG entries can be "late" here, but doesn't
bpf_spin_lock() also save and restore IRQ state?  The commit message says
"Every later save found interrupts disabled ... the locks and the other
flags can be released in any order before it."

__bpf_spin_lock_irqsave() does local_irq_save() into the per-CPU
irqsave_flags, and bpf_spin_unlock() ends up in
__bpf_spin_unlock_irqrestore(), which does local_irq_restore() of that
value.

Consider a frame that does:

    bpf_spin_lock(&v->lock);                       /* IRQs on -> off */
    if (bpf_res_spin_lock_irqsave(&v->rl, &flags)) /* flags saved: off */
        ...
    bpf_throw(0);

The IRQ_FLAG for flags is not "late", so pass 0 releases the SPIN_LOCK,
RES_LOCK and that flag in descriptor order.  If the descriptor lists them in
acquisition order, bpf_spin_unlock() turns interrupts back on and then
bpf_local_irq_restore(&flags) turns them off again.  Pass 1 has no late flag
to restore, so the exception callback runs and the program returns to its
caller with IRQs disabled, although it was entered with them enabled.

Can the same happen when the flags are in this frame's stack but a callee
saved them under this frame's spin lock?

Separately, releasing entries of a frame in acquisition order breaks the
LIFO assumption of bpf_res_spin_unlock():

    rqh->locks[cnt - 1]

is cleared whichever lock is passed in.  Does the held-lock table then name
the wrong lock while the unwind runs, so that AA detection is missed or
misdiagnosed?

Would it work to treat a SPIN_LOCK whose saved irqsave_flags has IRQs
enabled as "late" too, or to release the lock and IRQ entries of a frame in
reverse acquisition order?

This commit generates no descriptors, so the path is not reached yet.  It
gets enabled later in the series by cd4657cd0e50 ("bpf: Track held
resources in hidden stack slots") and faacef7a1935 ("bpf: Describe locks at
throw sites"), and no later commit in the series changes this ordering.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43027088527
--===============3868269184810280649==--
