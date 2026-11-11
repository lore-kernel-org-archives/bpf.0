Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385155;
	b=ZhsfGgxMMNGkb/vbjytELAzUtZhSwlhujKRrYOAOyOrpZOodyUR6rm7bljI5YfqUFvKY
	 UtwffgZ/JOwVoskrJsyqosX/K2oiPtGJ2ERPDqoNKzpGXs2AaS7hoIRjyxaBhPWts/kl6
	 gL/lwxVQD2x/HN8BJk4VcIgPj9pCRTrDqmehk22HpPd5qPxmqX5cOPIYfeCXfyiWMnsNd
	 EHPCNSPVAhbUZgRuIb78buq0yHjF6vljiq3PtTHfkwZtTPuIcG97bfyNb6YjBBF85r9B+
	 GiR8riqb0Y8+CdMZxvsRBr4+GQRoiUHZbuZJTydsVruwskaMoMES9PHHoA018fbGGRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385155;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=R/kVKg5RS0h+n5k1/2I7+Zp+UMXtMdG38C9X4lNBAv0=;
	b=mKzatrcw+M9NVf6uoT2LDdrgQd0hX4f2+xwjBwIfnU45sb1zk6Cp5wUpwJjiKj6sJren
	 tadd8+SbJ2GOokDYkWhfnJHt/xsdZ0vLN4L4Ge5neFgD3h/6WMbjMm7bTD1eA475Xb+14
	 N60h7XVgcKj24XYIryRGenPKt8XGu02N0Yw6808N+vdSXlbbDbJa5S3ugwL7ZKR+xM38d
	 1jfFp5rzd2OlPO/7/9JAAojFwLOmtN9nq4SIeaZLiht7mZ45/yUU4TowHtviCcd4gRRGX
	 uU3772QibR3dCpFuXdVHoILjQLDfnE/VPNgtXaIPqW+92OAkBB3Xx+fEXEXsfqy/L8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2yWkhu+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5B606A31C
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 08:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H2yWkhu+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6911F00A05;
	Wed, 11 Nov 2026 08:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794385155;
	bh=R/kVKg5RS0h+n5k1/2I7+Zp+UMXtMdG38C9X4lNBAv0=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=H2yWkhu+PBIR4T7OG4ZKvOvjVzrmLzgfArLj9BqF3eRHLw1tzj4ZB1LKziZS2x4pY
	 Mvu6qT2JDNFUWuHidZMM/3RMT02hcjyZn8G42j5Me1505DpvP4ARR4VOFT/+z/bEAL
	 4qu7Gy3mn15AhgV/NqlnNFGiU/U9MHr6PQeIrc9A6WGifOd5cShTqyrc8KIwygK5vr
	 DTzM+emcyRbvDjQSBJlWVATR2pc0CV5oYSPOUqv96TjdlQawLKD4GfYktK3XFyPnXf
	 cw9eI5Rm0w+ZtM97QZ13Jl1LhuJogiXcLPkLl+rKZvfPzHK3fJsIKSYhR7+7pzec/W
	 AsriFIeC3zUuw==
Content-Type: multipart/mixed; boundary="===============0158783972550198979=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <5bd21390934bbc2695cee1671c96d225aa0736e0aaabb0a396391a3c180da0b7@mail.kernel.org>
In-Reply-To: <20261111024333.228633-3-luyun_611@163.com>
References: <20261111024333.228633-3-luyun_611@163.com>
Subject: Re: [PATCH bpf-next v3 2/6] bpf: Check task work value membership before scheduling
From: bot+bpf-ci@kernel.org
To: luyun_611@163.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev
Cc: yatsenko@meta.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 08:19:14 +0000 (UTC)

--===============0158783972550198979==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Check task work value membership before scheduling

TL;DR: Nit only: the kernel-doc for bpf_task_work_schedule_signal() and
_resume() describes the return values twice, in the description and in
Return:. A single concise Return: line may suffice.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c

[ ... ]

> @@ -4927,7 +4948,16 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
>   * @callback: pointer to BPF subprogram to call
>   * @aux: pointer to bpf_prog_aux of the caller BPF program, implicitly set by the verifier
>   *
> - * Return: 0 if task work has been scheduled successfully, negative error code otherwise
> + * When the membership check is reached, scheduling is rejected with -ENOENT
> + * if the current map lookup does not return this value; a value inserted
> + * again at the same address is the current identity. Earlier errors keep
> + * their own codes. A live value with no user reference or a busy context is
> + * rejected with -EBUSY. Return 0 only means the scheduling irq_work was
> + * queued; it does not guarantee that the callback will run.
> + *
> + * Return: 0 if the scheduling irq_work was queued, -ENOENT if the value is
> + * no longer the current map value at the membership check, -EBUSY for a busy
> + * context or zero usercnt, or another negative error code on failure.
>   */
>  __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,

This isn't a bug, but the kernel-doc for bpf_task_work_schedule_signal()
now describes the -ENOENT, -EBUSY and 0 results twice, once in the
description paragraph and again in the Return: section.

Would a single Return: line listing 0, -ENOENT (value no longer in the
map) and -EBUSY be enough here?

The same question applies to bpf_task_work_schedule_resume(), which says
"See bpf_task_work_schedule_signal() for return semantics." and then
repeats a Return: line anyway.  The other kfunc docs in
kernel/bpf/helpers.c use a single concise Return: line.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42981420568
--===============0158783972550198979==--
