Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E11BB78F2B;
	Wed, 30 Sep 2026 00:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790727026; cv=none; b=T7VjY8RxvD0its4bCoE0J+AO2ak0uDSDFnvU6GN1ckym4UblaC08+xnT9tYWLFxdYawqNljGbvrTpMoFpErrAmjcPgS3ckeaXQaFeogjK12Ntb/aQI6S+EmfQkRIK1EdsK5XILn0SE6imFFv7I1V3MJe8KTFQPRbIyePtPMWHGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790727026; c=relaxed/simple;
	bh=qqLAEODXDtGLCpi6NI3ALzCy+QkE7TxbF0QwnutAscc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eVN1kXaTxAmPjzeK0exUKBYZsMfVYV7CUw3dvJVQ3yAzXdabjIS99MiVm/+gD5cj7bVclOZ/m5GLt5btc1jHHrrZamLFr9YyzVRAUvxAOiprTJHoGQ9IkKWl2xaQiRYXsFYoWTExxEMJP7N40ujAFptcoCJeEVl34iAPaDFWTWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fujMi+Hn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fujMi+Hn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F2371F00893;
	Wed, 30 Sep 2026 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790727024;
	bh=T1D0zTTkL0Glq0FcFULyVy/r9e1sBxKdczzQcmwhCgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fujMi+Hn3rxpYPZ5GXsJAnJSAfbdA8MWB9xXc2WO90wyti+6LtkLMeQmIMKk0ntBc
	 ddLy3pokFFOOiQAkn6l5M5kaxHmyfqgemzrSf4iw3v0MSHq59sf2+bK1HgDoVdko1U
	 M/qcaq4lO1HvisKFw67Qiw6DkZp3ynXf+M5YJ9cDx3wYi2/8YgZzk1ZPPQxIJlOG3Q
	 MbZrIaik/NiMsFAYGTPW1nOtTlZ0rm8KaNCXvgX/fcNQ3Js0uMy1bhErLcWLSRu0V4
	 yxiU/edyQzxXl6wzMoWsnyraQ/bl8hLESxwbRC7OhY9m+yR/F5qc5XH0++Uj5o+8vP
	 5dNmTriY0r8Gg==
From: sashiko-bot@kernel.org
Subject: Re: [RESEND PATCH v2] kprobes: Make optprobe optimizer
 multi-generational and asynchronous
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <179072636063.409480.10967951178575355535.stgit@devnote2>
References: <179072636063.409480.10967951178575355535.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 00:10:23 +0000
Message-Id: <20260930001024.4F2371F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] kprobes: 100% CPU busy-loop livelock when flushing optimizer
- [High] kprobes: memory leak of optinsn slots during async unoptimization
--

commit 9f64df8dc4c148639fefa4dcd4859438e335848a
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

kprobes: Make optprobe optimizer multi-generational and asynchronous

This patch decouples kprobe jump optimization from synchronous waiting by
moving to an asynchronous, multi-generational model using call_rcu_tasks().

> diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> index 4edd8ca5c6578..377fa9bfa0291 100644
> --- a/kernel/kprobes.c
> +++ b/kernel/kprobes.c
[ ... ]
> @@ -588,17 +653,25 @@ static void do_unoptimize_kprobes(void)
[ ... ]
> -/* Reclaim all kprobes on the 'freeing_list' */
> -static void do_free_cleaned_kprobes(void)
> +/* Reclaim all kprobes on the 'free_list' */
> +static void do_free_cleaned_kprobes(struct list_head *free_list)
>  {
>  	struct optimized_kprobe *op, *tmp;
> =20
> -	list_for_each_entry_safe(op, tmp, &freeing_list, list) {
> +	list_for_each_entry_safe(op, tmp, free_list, list) {
> +		struct kprobe *_p;
> +
>  		list_del_init(&op->list);
[ ... ]
> -		struct kprobe *_p =3D get_optimized_kprobe(op->kp.addr);
> +		_p =3D get_optimized_kprobe(op->kp.addr);
>  		if (unlikely(_p))
>  			optimize_kprobe(_p);
> =20
> -		free_aggr_kprobe(&op->kp);
> +		free_aggr_kprobe(&op->kp);
>  	}
>  }

[Severity: High]
Does this leak the dynamically allocated optinsn memory slots?

Later in the patch, kill_optimized_kprobe() is modified to intentionally
defer calling arch_remove_optimized_kprobe(op) if the probe is queued,
leaving the optimizer to reclaim it after the quiescence period.

However, when do_free_cleaned_kprobes() runs to reclaim the probe after the
grace period, free_aggr_kprobe() only frees the kprobe struct. Without a
call to arch_remove_optimized_kprobe(op) here, the executable memory slots
allocated for the optimized kprobes appear to be permanently leaked.

[ ... ]
> @@ -624,67 +696,138 @@ static void do_free_cleaned_kprobes(void)
[ ... ]
> +/* Kprobe jump optimizer */
> +static void kprobe_optimizer(void)
> +{
[ ... ]
> +	/* Step 3: Wake up flushers and kick optimizer again if needed */
>  	optimizer_passes++;
>  	wake_up_var_locked(&optimizer_passes, &kprobe_mutex);

[Severity: High]
Does unconditionally incrementing optimizer_passes here cause a 100% CPU
busy-loop livelock?

When wait_for_kprobe_optimizer_locked() is called while a Tasks RCU grace
period is in flight, it sees optprobe_optimizer_busy() is true and wakes the
optimizer thread.

The optimizer thread wakes up, clears its flushing state, and calls
kprobe_optimizer(). Since the RCU callback hasn't fired yet, it makes no
progress but unconditionally increments optimizer_passes here.

This wakes wait_for_kprobe_optimizer_locked(), which loops, wakes the
optimizer again, and waits for another optimizer_passes change. Both threads
could spin in this tight loop until the Tasks RCU grace period completes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179072636063.409480=
.10967951178575355535.stgit@devnote2?part=3D1
