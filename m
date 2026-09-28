Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54215485949;
	Mon, 28 Sep 2026 09:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790586308; cv=none; b=IN2jn4D8jsAkdF9+fieD22PWWQodohsC5xrdzCWcgHJ3ca/oQnF2H9p3GKJ+pVAWOI8bP940LIevfycsfX+EcbPGySNd3ecs+9RSxxA3AYsjozRS+A9iJ+BNumyDrxkBR0JxCA/LzHcFpKoWKaLnIss/pkDq5z8ixs6cTf7lDzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790586308; c=relaxed/simple;
	bh=OcB/HbUJXOH4AxpxgD5AjyEHemYd1NtXf1vwRzdhtQk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jcRadNQeM1wWP0Cn5vTIJFKN430Dr23UfCoi8OmmmcH144+TBLOo4aa0UEnTcH2jhBmvddRroQ/YQzCjLUu+mYWAMEsyOWeLzwDhAJVc1kG6Y6/eUYoffO8X571yYCYdmitfJhL1TQU/NeiwfvXaQgEjSPA+b5nq8IUyun4M224=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gjz9IG/a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gjz9IG/a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 009E11F000FF;
	Mon, 28 Sep 2026 09:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790586306;
	bh=o3adarYtVvsy0MBOXWtEhIf3HmHUT/7SthKqv/p+Bk8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Gjz9IG/aR9HRZ4et/x7TD0nd0jpjp2aHjmseYxW8i1qmGFRerSWaRcO3z9t3VLXQS
	 tSYQ+MvWLpinEHO//RD+TS2azGRYqLxDPXYPOkweg8V3DZGQzRCYkeH95wb/ONWxRX
	 Lg59ZB+gwY5qRUk2Or9YMM2zbdXMa1owgbWeCMkV44wI0ahYIUHyzMRR+oLeR5qHe4
	 huWeF31eEEe0One95SLP+vjpytjDAyaxaIntRTp20IPsUprLKXRr0sIG/5Uspy2u+f
	 RhoyaROimNPX0YShb0iUiq80kazn+Qo9c7yvP7mp6YjC04Ngt4Ka2BdHh17VwlBA6b
	 GZylG73v1YPmA==
Content-Type: multipart/mixed; boundary="===============0836752905273921371=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cc8705840580f8645d92a6bb8431ad9766aceb52fc9423513f93d16d8b908ac0@mail.kernel.org>
In-Reply-To: <20260928081144.207908-1-chenyuan_fl@163.com>
References: <20260928081144.207908-1-chenyuan_fl@163.com>
Subject: Re: [PATCH] bpf: Claim the per-CPU send_signal irq_work before filling it
From: bot+bpf-ci@kernel.org
To: chenyuan_fl@163.com,ast@kernel.org,daniel@iogearbox.net,bpf@vger.kernel.org
Cc: yonghong.song@linux.dev,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,jolsa@kernel.org,ihor.solodrai@linux.dev,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,chenyuan@kylinos.cn,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 28 Sep 2026 09:05:05 +0000 (UTC)

--===============0836752905273921371==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 195f78db9bda..e60b4fdf2923 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -823,6 +823,8 @@ const struct bpf_func_proto bpf_task_pt_regs_proto = {
>
>  struct send_signal_irq_work {
>  	struct irq_work irq_work;
> +	/* Covers the fill-to-run span which irq_work_is_busy() cannot see. */
> +	atomic_t claimed;
>  	struct task_struct *task;
>  	u32 sig;
>  	enum pid_type type;
> @@ -842,6 +844,8 @@ static void do_bpf_send_signal(struct irq_work *entry)
>
>  	group_send_sig_info(work->sig, siginfo, work->task, work->type);
>  	put_task_struct(work->task);
> +	/* Release once the fields are consumed. */
> +	atomic_set_release(&work->claimed, 0);
>  }
>
>  static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struct *task, u64 value)
> @@ -885,7 +889,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struc
>  			return -EINVAL;
>
>  		work = this_cpu_ptr(&send_signal_work);
> -		if (irq_work_is_busy(&work->irq_work))
> +		if (atomic_xchg(&work->claimed, 1))
>  			return -EBUSY;
>
>  		/* Add the current task, which is the target of sending signal,
> @@ -898,7 +902,12 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type, struct task_struc
>  			copy_siginfo(&work->info, &info);
>  		work->sig = sig;
>  		work->type = type;
> -		irq_work_queue(&work->irq_work);
> +		if (unlikely(!irq_work_queue(&work->irq_work))) {
> +			/* Unreachable while the claim is held. */
> +			put_task_struct(task);
> +			atomic_set_release(&work->claimed, 0);
> +			return -EBUSY;
> +		}

This isn't a bug, but since the comment says this cannot happen while the
claim is held, would it be clearer to drop the branch or reduce it to a
WARN_ON_ONCE(!irq_work_queue(...))? As written it looks like a recovery
path, but it wouldn't actually undo the overwritten fields if it ever ran.

>  		return 0;
>  	}
>

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36398456272
--===============0836752905273921371==--
