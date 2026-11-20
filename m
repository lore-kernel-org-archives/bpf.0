Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795211480;
	b=SSn6RnAtogMY7ARpGGd53LaSawbIzEmvJvH6cH1CVJJEFlSdaYbjm8gl2lVzQz6x4kY/
	 ngbWvI59L8De8SE0wVUq84FtANUB3pHbEakRnjpxU8NZub9VWVGr0QQzo8pYxkS1Rok4B
	 jWMbkTiAVkFwzakzTOZvJRgq5x2rfxQupeob7KyEHnyiXxaDlObyaj+kEH6f8IUsY+tkL
	 ZY0Tf+5HWNd++d0NdF1bi4e3FRtA56p0mmW+dj3D7q3HDCWoA4i9wT/mJDJOfdjMOEywb
	 U8vbGpPbcXXkvr5CyuqP+ARvDgaGcyyIhxMr2APfHYcoHrSPAfWE27iWe6Ijz0qhajA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795211480;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=wwcByI3ezn1rWNi6BxSYb5wsmVycL1eCCzPe0cScClM=;
	b=nk4ABOCOHKQJE0P8jebhmHfQ28imFI9Ku4rYWoS1GLUslbxP+b8jPwASS438FpyzIsjL
	 +qveuXvk7mK7bF7VZkfoql9HgcKwHBP/Zx8JAIJlpkFJ55pye9mrl/NgUw74r6UvBTGC8
	 E/vDrA00tg/IfBKSXAM46iGKyXyeYXWpUEhUG3A0tdtmjks17d1Z1/Xu5qzhgvOD8L63R
	 n3GWsQKqM+s6cjuVYso8IzRUvT9uBrwWlb9vL3ZPnSKCkckrDRcU/aX+WtVZmRa5fTdYC
	 lIBJ4zJsnglCeE9oAihhveieWp19gG0RR7+uBrrEgOwWZe54/7Fnw0wK0VoH5Bi+6hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maQwKLz8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA1A606A6AF
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 21:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=maQwKLz8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11E851F000C0;
	Fri, 20 Nov 2026 21:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795211480;
	bh=wwcByI3ezn1rWNi6BxSYb5wsmVycL1eCCzPe0cScClM=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=maQwKLz83a0zsv0NcT4+E+xxZOVi7NSxyNuvQpMBRxZwwPbJ7DRNftKbWEflBpbLD
	 f7X4724qOcXS04REf7qarotMIOl6bX5vgddda710KCJMPUFXal0eCn+nvfAB0YDEn7
	 of8Y58m6zGf8VcuHASrECGnjL0TtMlhbRrFKQlmDui35xyRry/NqlF8f7+vARPDP5m
	 Y8QYbU99t84zvzhQGlRyPy0wYMONSv+JS3VAiQz6odJmhEmRU2Su620Dx5bpHuuk0g
	 i5BgnCIytDeJn2KXCB0ElpVdcNd+vFI79uXnBmzUr8EJUoA1HAavd256MpgxVvd3L/
	 3BysjHIhpnFvQ==
Content-Type: multipart/mixed; boundary="===============2186023635858555349=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e46acf14558160ae31976ba65801b41b07551c1faf55af800503300c090b546c@mail.kernel.org>
In-Reply-To: <20261120204959.614908-37-alexei.starovoitov@gmail.com>
References: <20261120204959.614908-37-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next v2 36/49] bpf: Do not let a join raise what a program requires
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 20 Nov 2026 21:51:18 +0000 (UTC)

--===============2186023635858555349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Do not let a join raise what a program requires

TL;DR: bpf_restore_precision() may restore a stale prec->undo if
find_calls_to_unproven() fails (-E2BIG, -ENOMEM, -EINTR), mixing old masks
with current loop precision; an offloaded program's replay pass could then
fail or differ.

> diff --git a/kernel/bpf/precision.c b/kernel/bpf/precision.c
> --- a/kernel/bpf/precision.c
> +++ b/kernel/bpf/precision.c

[ ... ]

> +int bpf_partition_for_pessimized(struct bpf_verifier_env *env)
> +{
> +	struct bpf_precision *prec = env->precision;
> +	int ret;
> +	u32 i;
> +
> +	if (!env->pessimized)
> +		return 0;
> +	prec->good_budget = prec->budget;
> +	for (i = 0; i < prec->loop_cnt; i++)
> +		prec->loops[i]->good = prec->loops[i]->precision;
> +	for (i = 0; i < env->prog->len; i++)
> +		if (env->insn_aux_data[i].pessimized)
> +			note_unproven_after_pass(env, i);
> +	ret = bpf_partition_more(env);
> +	if (ret <= 0 && prec->data_deps)
> +		bpf_restore_precision(env);
> +	return ret;
> +}
> +
> +/* Go back to the precision of the last pass without errors */
> +void bpf_restore_precision(struct bpf_verifier_env *env)
> +{
> +	struct bpf_precision *prec = env->precision;
> +	struct bpf_loop *loop;
> +	u32 i;
> +
> +	memcpy(prec->data_deps, prec->undo, 5 * prec->words * sizeof(long));

Can this restore a stale copy of the masks?

prec->undo is set to the current data_deps only in partition_next().  In
bpf_partition_more(), partition_next() runs only if find_calls_to_unproven()
succeeds:

	return find_calls_to_unproven(env) ?: partition_next(env);

find_calls_to_unproven() calls bpf_add_cost_and_check(), which can return
-E2BIG, -ENOMEM or -EINTR.  On that path data_deps still holds the
precision of the good pass, but prec->undo holds the data_deps from before
the partition that led to this pass.

The memcpy() above then replaces data_deps, control_deps, disjoint_apart,
type_apart and in_frames with that older copy, while loop->precision below
gets loop->good, which is the current value.  No pass ran with that mix,
so the comment "Go back to the precision of the last pass without errors"
does not hold here.

For an offloaded program, the replay pass would then run with this mixed
precision instead of being the good pass once more.  Could it fail, or
give the driver requirements that differ from the pass just accepted?

Would it work to make undo match data_deps before calling
bpf_partition_more(), or to restore only when partition_next() actually
ran?

> +	for (i = 0; i < 5 * prec->words; i++)
> +		prec->kept[i] &= prec->data_deps[i];
> +	prec->budget = prec->good_budget;
> +	for (i = 0; i < prec->loop_cnt; i++) {
> +		loop = prec->loops[i];
> +		loop->precision = loop->good;
> +		loop->partitioned = false;
> +		loop->changed = true;
> +	}
> +}


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44817467639
--===============2186023635858555349==--
