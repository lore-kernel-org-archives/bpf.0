Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794274746;
	b=gaOOPzALbv25bAPv175s7tLEv2sSioiTjdzpECflUhWbZHO+eXiBbVCb1uDh2NNF+SC7
	 djF4hVejiB3ByF6nx1F0vuC+7WrJFhR0X2SDKe6B34suvEj1eUdql1gq6/3K44x/NQr+h
	 RhyeY3GcsxYcVI7sr9CsyuFb3k+xsKyDvzfOJL1Cf0UYMsq4si9Qkp8FFWhRzadKkcmre
	 dG+UxgzMXd779I7uTwF5LLEKl5spNQ59elTdhkU2fOIz+AfjYbA6o+mU9kOcAzYu1jYCk
	 uiQ2jXSfzW8Hv5rR+6QLaKHerDAJYvPmuyxIsssRH85w9M0Tb3QupD73WcqpXdcAThA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794274746;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=izMpnTIdQ5ormRCJAYZFhR2HeLtKhw23SOmeONPmeSg=;
	b=mhMRdX9KOJJPv3ivWnBUpTCoYLLTGkMp5b69hkPjqyUHnglS14iVfJgGSZc0kaVeSb5p
	 f5/cVyBOREVj2hb05ibxYiKg8twiFzLLlkzQ/YCHEllYqv5xw30r8o2Z0gLqj+Sylx8OA
	 bPKtbZ2Rdd6VNLCEoLruMK7OkkH5frzo0/1oRBVRSeXLL1LITiPya31Mj+YL90NRrKXxB
	 hXhZDmLC/ja5+S9qSEjthk0x7PehSlV+PHLyYsSjEQNnbLQ+VSUPSN/SuxsCpnYBsGAUV
	 7RAEz6t6WjqkXF8NcFtuw+9NVuA86bxjwWuzVPM+3/5jWdFFchdXhPis7xhPeSiz5dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=joQmOXeb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD48F60A261F
	for <bpf@vger.kernel.org>; Tue, 10 Nov 2026 01:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=joQmOXeb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8D21F0089F;
	Tue, 10 Nov 2026 01:39:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794274745;
	bh=izMpnTIdQ5ormRCJAYZFhR2HeLtKhw23SOmeONPmeSg=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=joQmOXebbeHqjNxS6TCtFaA/qhAR7GJ7cUDjl37K2UvNFk46R+Cbn/fh6RRd4QG79
	 jJULKBZN+iSbW+GbLUqnZYVLs2fLWB0Mp3Ty+DsFRvs2rfip300uCXMFzUbdP1xJwS
	 HZwKx7G6XVoB5T9nAr9jhV6a6qfHZ7lR3KlEvLclFdOh2Y3KFpRJUesH0bCMzDcUjj
	 3V7V9OluIIvzu4BgJYkUHpRss4mNNNa89u+XM4Zce2oJfB9xStkVzOs2fdG5+/67KS
	 TKlH2xUqPtjyPzSaO2Dd84CJCD3czbjK5DKStdwJVo0rhIibHu4BxIprL0MuyAVEpI
	 RgMCwngw9Tq+Q==
Message-ID: <sashiko-outbox-205974@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 09/20] bpf: Register bpf_task_wake() for all
 program types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <d3069dd53406ddc20ca68dc1a1904ee9b73c52b3.1794269506.git.memxor@gmail.com>
References: <cover.1794269506.git.memxor@gmail.com>
 <d3069dd53406ddc20ca68dc1a1904ee9b73c52b3.1794269506.git.memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 01:39:05 +0000
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
- [High] bpf: UAF and refcount UAF in bpf_task_wake_defer() on dying or
  unborn task
--

commit 80d3e640be3a3d90e547a97946f0b4ff6582d291
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

bpf: Register bpf_task_wake() for all program types

This commit registers bpf_task_wake() in its own kfunc set for all program
types so that any BPF program can wake a parked task.

> diff --git a/kernel/bpf/task_park.c b/kernel/bpf/task_park.c
> index 0e3d7f3ec597e..9de1b496ead1b 100644
> --- a/kernel/bpf/task_park.c
> +++ b/kernel/bpf/task_park.c
> @@ -281,13 +281,31 @@ BTF_KFUNCS_START(bpf_task_park_kfunc_ids)
>  BTF_ID_FLAGS(func, bpf_task_park, KF_SLEEPABLE)
>  BTF_KFUNCS_END(bpf_task_park_kfunc_ids)
> =20
> +BTF_KFUNCS_START(bpf_task_wake_kfunc_ids)
> +BTF_ID_FLAGS(func, bpf_task_wake, KF_RCU)
> +BTF_KFUNCS_END(bpf_task_wake_kfunc_ids)
> +
>  static const struct btf_kfunc_id_set bpf_task_park_kfunc_set =3D {
>  	.owner =3D THIS_MODULE,
>  	.set =3D &bpf_task_park_kfunc_ids,
>  };
> =20
> +static const struct btf_kfunc_id_set bpf_task_wake_kfunc_set =3D {
> +	.owner =3D THIS_MODULE,
> +	.set =3D &bpf_task_wake_kfunc_ids,
> +};
> +
> +/*
> + * The park stays with syscall programs, whose runner holds the program =
across
> + * the sleep. The wake touches only the task and defers itself where it =
cannot
> + * be issued, so every program type has it, to wake a parked task from t=
he
> + * kernel event that makes it worth waking.
> + */
>  static int __init bpf_task_park_kfunc_init(void)
>  {
> -	return register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_task_park_=
kfunc_set);
> +	int ret;
> +
> +	ret =3D register_btf_kfunc_id_set(BPF_PROG_TYPE_SYSCALL, &bpf_task_park=
_kfunc_set);
> +	return ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &bpf_task=
_wake_kfunc_set);
>  }

[Severity: High]
Can registering bpf_task_wake() for all program types cause a refcount
addition-on-zero and use-after-free in bpf_task_wake_defer() when called on=
 a
task that is being freed?

Exposing bpf_task_wake() to all program types lets lsm, tracing, and
struct_ops programs call it on a trusted task_struct argument after
task->usage and task->rcu_users have already dropped to zero, such as from
__put_task_struct() -> security_task_free(), or during a failing
copy_process() before task->rcu_users is initialized.  When called with
interrupts disabled, bpf_task_wake() defers the wakeup through
bpf_task_wake_defer():

kernel/bpf/task_park.c:bpf_task_wake_defer() {
    ...
	if (cmpxchg_relaxed(&node->next, NULL, WAKE_Q_TAIL))
		return;
	get_task_struct(task);
	head =3D this_cpu_read(bpf_task_wake_queue);
	do {
		WRITE_ONCE(node->next, head ?: WAKE_Q_TAIL);
	} while (!try_cmpxchg(this_cpu_ptr(&bpf_task_wake_queue), &head, node));
	irq_work_queue(this_cpu_ptr(&bpf_task_wake_work));
}

get_task_struct() increments task->usage from zero while __put_task_struct()
or bad_fork_free proceeds to free the task_struct, so bpf_task_wake_deferre=
d()
later dereferences and puts the freed task from irq_work.

Guarding the deferred wakeup with refcount_inc_not_zero(&task->rcu_users) a=
nd
releasing it with put_task_struct_rcu_user(), as bpf_task_acquire() and
bpf_task_work_schedule() do, would avoid queueing a task whose lifetime has
ended or has not yet started.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794269506.gi=
t.memxor@gmail.com?part=3D9
