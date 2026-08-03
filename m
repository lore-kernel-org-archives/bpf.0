Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5707441D207;
	Mon,  3 Aug 2026 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785766697; cv=none; b=L+wlIj3jglal8WNUg6kAhUcetxkYR1Bm9bNJAmewdhOECS8IQW77sNUmaCtBX2Vfo7c6eWV8V6LgLIjFFbuc7LLARLLKuJP2vZ9Vv7muhikQKIbu9Gjq0sR7wbEZ5UriOtksugGY5pJAipbfq2G9ue1IMR1Zueqq7cT5Wg7Oyg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785766697; c=relaxed/simple;
	bh=T8sRHTMTe5QlgkoWNjw44IaSUfMYsUEsNHjHOApIevg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=C9fQv/fT9myI/yJ4WvpHLLkaHhUkE6jMRb8RRtUekvKWekj4GV1v0Rqk2JofA2a9xUFyALjEFLH8Z3Ds0VX/vmhmJ7pWvDAJZWtr9M9IjFpINDYAhl4Bjjzw//cUwn/l2AsZUIj1vCI5d3t6PbUXmnSSR/pjmhMfNc17vmt+xoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eEvhVfIc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eEvhVfIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A765F1F000E9;
	Mon,  3 Aug 2026 14:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785766695;
	bh=Idr4OkEplk4HQ/PYnRhr8cIGroCI9uguCmarq8UsQ8Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eEvhVfIcWdO0TsrpqFir72+ydc4xuKbZh5quM+LvU9qh84yeI7htTkhY18FcoLgVR
	 t2DCD+LNIh2P8XLg5kjkd24zJEjQEN5EFXiGS1djv3u6Uta3JjeB8I8B0/uto4te/E
	 5+dtIGSgQLJJZlZBd+mjUnpHbxfHDJjaDORiTT1jRsOmmSh+U3KvvIy4U/UnZSb2cM
	 Ro6K/e4b1ioOLhZj1SR6/V9capzJ8DB7ETje2PfrMk8mEgH2IcnpgU9Rz8w8PKolGX
	 7nxE58lglwV4wTrCK2NH8k9nmOpnowoufY0SrUn7oIUrudvqSKEjGsPuGqY/JJ+uWj
	 YdR8K0Q6M/xJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/6] rcu: Make call_rcu() safe to call from any
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260803135329.2327280-1-puranjay@kernel.org>
References: <20260803134839.2103051-1-puranjay@kernel.org>
 <20260803135329.2327280-1-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:18:14 +0000
Message-Id: <20260803141815.A765F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Concurrent `rcu_barrier()` calls can cause missed wakeups and syst=
em hangs in `irq_work_sync()` on architectures without IPI-based `irq_work`.
--

--- Patch [1]: [PATCH v2 1/6] rcu: Make call_rcu() safe to call from any co=
ntext ---
commit f033f4bd0a671eccd668878bff133f083ff63d97
Author: Puranjay Mohan <puranjay@kernel.org>

rcu: Make call_rcu() safe to call from any context

This commit makes call_rcu() safe to call from any context by deferring
the callback on a per-CPU llist when interrupts are disabled, and raising
an irq_work to re-issue it once interrupts are enabled. It introduces
rcu_defer_flush() to flush these deferred callbacks during rcu_barrier().

> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 96848fc1f02b8..31e2d2207ac03 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c

[ ... ]

> @@ -3896,8 +3990,12 @@ void rcu_barrier(void)
>  	unsigned long flags;
>  	unsigned long gseq;
>  	struct rcu_data *rdp;
> -	unsigned long s =3D rcu_seq_snap(&rcu_state.barrier_sequence);
> +	unsigned long s;
> =20
> +	/* Register any deferred callbacks before snapshotting the sequence. */
> +	rcu_defer_flush();
> +

[Severity: High]
Because rcu_defer_flush() is called before taking the rcu_state.barrier_mut=
ex,
can multiple threads execute it concurrently?

If multiple threads call rcu_defer_flush() concurrently, they will both
call irq_work_sync(&rdp->defer_work) on the same per-CPU irq_work:

kernel/rcu/tree.c:rcu_defer_flush() {
...
    if (cpu_online(cpu))
        irq_work_sync(&rdp->defer_work);
...
}

On architectures where arch_irq_work_has_interrupt() is false,
irq_work_sync() waits using rcuwait_wait_event(). Since rcuwait only
supports a single waiter, won't concurrent callers overwrite the internal
task pointer, causing one of the threads to miss the wakeup and hang
indefinitely?

> +	s =3D rcu_seq_snap(&rcu_state.barrier_sequence);
>  	rcu_barrier_trace(TPS("Begin"), -1, s);
> =20
>  	/* Take mutex to serialize concurrent rcu_barrier() requests. */
>  	mutex_lock(&rcu_state.barrier_mutex);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803134839.2103=
051-1-puranjay@kernel.org?part=3D1
