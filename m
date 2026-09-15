Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC54E372673
	for <bpf@vger.kernel.org>; Tue, 15 Sep 2026 15:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789484525; cv=none; b=ApSZ8pEzDol810JmJ/nW5NZMqyeKf2Z7WtnmWjEWIxoDSy9lkSzV+dezZurb0Y1/I9eTfoONDYjoMbKJa5Fpdjss6PHgDy3EFKNq+iTvFkiRVH7qqB4lllS+tA+z0FKRl9cLLWlrsCU4HFxmp/soHhZ66mSGOsG8fyMjYVLp3Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789484525; c=relaxed/simple;
	bh=co8JGpbnvuqHwYcpddB8EEmfvMIBhZfwisGa57lDQHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=X0MiNTe/PymHTPBDcjdbB+vPaSH5+7AS83J7bnnSYRf0ejw4b1iseJOx35apatlQv1SHPltUj0mvaze29aF1eEnqLdLVwkzEujt/H4NldKy2uSMwgHvvdLFzUXsx/bkqasvnFmQivpPEYiSsiIiN5G03jlJQPwH+tKyBERNe4E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YQQpm5K1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YQQpm5K1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C55D1F000FF;
	Tue, 15 Sep 2026 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789484523;
	bh=D3RkyXybN2ckVlcBkWYHa9AELXQEnOlIkhe0XTj6mUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YQQpm5K1POaLfaQslPydOpwrPV4X6FM+5C3Xr3w+C/uxxZNFN3TFSsOfOInYpLykX
	 jOk/9LEu4ZjvZbT0MiWVb/tk6cj2gRyoLYMbKXHG1t+H6kEhEnWEj6tGtaqiIK1AoY
	 DfplFESsjyLa1RmMsUSD4akaJdfh0ITRMzyc1QZP/YaSnbU8M3cp/Wniev399p/YMT
	 /ojw2YhmE3TTq/P/aglslHx+RoHlIWbbez0d7x/tUV8i5fck4JLntP6DEF5aodWLYM
	 yGzCKW/f2270iQs0nVUluqBN1BO4KNM9uikYfzzfPYLjPv0lPN8x3nQFr8zZGHkBRi
	 Gt9Eov+SGt4aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 3/4] bpf: Add bpf_call_rcu_tasks_trace()
 kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260915143640.36292-4-puranjay@kernel.org>
References: <20260915143640.36292-1-puranjay@kernel.org>
 <20260915143640.36292-4-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 15:02:02 +0000
Message-Id: <20260915150203.4C55D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] bpf: Deadlock risk calling bpf_call_rcu_tasks_trace() from NMI con=
text
- [Medium] API behavior change in bpf_timer/bpf_wq returning -EBADF instead=
 of -ENOENT
--

commit 144bc88aada0f77bf3ad5ba54cb25dc2ae7529ca
Author: Puranjay Mohan <puranjay@kernel.org>

bpf: Add bpf_call_rcu_tasks_trace() kfunc

Sleepable BPF programs hold rcu_read_lock_trace(), not rcu_read_lock(),
so a plain RCU grace period does not wait for them.  A program whose
readers are sleepable needs this flavour to defer reclaim safely.

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 6debb92fc8740..b76e2866693af 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -1428,7 +1428,7 @@ static int bpf_async_update_prog_callback(struct bp=
f_async_cb *cb,
>  	if (prog) {
>  		prog =3D bpf_prog_inc_not_zero(prog);
>  		if (IS_ERR(prog))
> -			return PTR_ERR(prog);
> +			return -EBADF;
>  	}

[Severity: Medium]
Will this change break backward compatibility for existing BPF programs?

Because bpf_async_update_prog_callback() is shared, this changes the
user-visible return value from -ENOENT to -EBADF when bpf_prog_inc_not_zero=
()
fails (e.g., when a program's refcount reaches zero).

This affects existing UAPI helpers like bpf_timer_set_callback() and
bpf_wq_set_callback(). Programs relying on the specific -ENOENT error
code for fallback logic might break.

[ ... ]

> +__bpf_kfunc int bpf_call_rcu_tasks_trace(struct bpf_rcu_head *rh, void *=
map__const_map,
> +					 bpf_rcu_callback_t callback, struct bpf_prog_aux *aux)
> +{
> +	return __bpf_call_rcu(rh, map__const_map, callback, aux, true);
> +}

[Severity: High]
Could this lead to a deadlock if called from NMI context?

The bpf_call_rcu_tasks_trace() kfunc uses call_rcu_tasks_trace(), which maps
to call_srcu(). call_srcu() internally acquires sdp->lock, which is a
raw_spinlock_t.

If a BPF program running in NMI context (such as BPF_PROG_TYPE_PERF_EVENT)
calls this kfunc, and the NMI interrupted a code path that was already
holding the same sdp->lock, the NMI handler will spin forever. Since the
kfunc is exposed without NMI-context restrictions, could a userspace
process able to attach perf events trigger this deadlock?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915143640.3629=
2-1-puranjay@kernel.org?part=3D3
