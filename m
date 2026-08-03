Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D08379974
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 10:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785754253; cv=none; b=KXvZ4/KH9zdWXsd9ybCY0WUpK5to0f/xHCXn9Zd77ZekIOIap+/cVpn2as35DD2fkjFD+wfK3SzoNdby7tzqh6RDjEIzHWOs72Tdpdby0uY9DLfLr3sGoea+y/5zJAKpDNJo52UBARcSwbB44g5alP/LtXF+aFyxJ2ddZ9gxF94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785754253; c=relaxed/simple;
	bh=ijhPBqMJjgnaI51qrF53bMM6qhVWtCoq7+D0ObZEL7g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hd3DKE0X0Cr6xLzYZaz8yEgu93hcndTnyZdpx3j4BNx6n0gN6VKvuJcNaW4hffWM6n16jV0i3ixV+eSr1x6Dqz0TSWZg7nUQt2oq9YO/040lgkLM1pOdNYo1XZMNgkbs0EM3QDxO85wqemp5TkudQGW/3U156y9/qMrJWhAtiDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kLxXenI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kLxXenI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92C7B1F00A3D;
	Mon,  3 Aug 2026 10:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785754251;
	bh=J2gJRVTn3n6G/S0hNnOUd18cfwePRymQtUpfiN4lKMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kLxXenI31IpLYBvDovtHZmGGHKfF1OEKr51uRFyi+PDAKG3v/ZC0szQNtCINtZfon
	 14K1wXRjy3u/6l6H27fAYsGnWjcy5Ho5QTWIfgBptPpuKHQS/bde9i29Cw7uzUevcQ
	 HolIHEK3GyZdzdOQfTXkfMqZwqdpGDmf8NKaN/3fBDpfQY2jY9hNw/aNgzRlGQHzH2
	 5xATrLeFT7mxxK48o37vi2glAVJseZQHrXN19yOOuyefdujT4/ubGRxd1DE0Z8xpDR
	 WBgxNXa0ZYoH9JRvb8bGxG/93HhdX7eQObLTTfCpViA0M/k/rodu9WU2l8v1Axpg8k
	 DXbaBzuekm9gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: disable lockdep while running BPF on lock_release
Reply-To: sashiko-reviews@lists.linux.dev
To: quanyeyang <quanyemostima@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803-fix-lock-tracepoint-bpf-lockdep-v1-1-91fb7afb526a@gmail.com>
References: <20260803-fix-lock-tracepoint-bpf-lockdep-v1-1-91fb7afb526a@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 10:50:51 +0000
Message-Id: <20260803105051.92C7B1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Disabling lockdep during `trace_call_bpf` for `lock_release` hides=
 valid lock inversions and allows silent physical deadlocks.
- [High] Temporarily disabling lockdep globally via `lockdep_off()` in `tra=
ce_call_bpf()` unintentionally blinds lockdep to any hardware interrupts an=
d softirqs that preempt the BPF program.

Pre-existing issues:
- [High] The patch fails to disable lockdep for BPF programs attached to `l=
ock_release` via raw tracepoints.
--

--- Patch [1]: [PATCH] bpf: disable lockdep while running BPF on lock_relea=
se ---
commit 4871557897dd6c7f2fd05dc2170475d6e2824a6e
Author: quanyeyang <quanyemostima@gmail.com>

bpf: disable lockdep while running BPF on lock_release

trace_lock_release() runs before __lock_release(), so the lock is
still on the held stack when attached BPF programs execute. This patch marks
lock_release with TRACE_EVENT_FL_BPF_NO_LOCKDEP and temporarily disables
lockdep around bpf_prog_run_array() for that event to avoid false recursive
locking warnings.

Closes: https://syzkaller.appspot.com/bug?extid=3Def8d17bae14efb960935

> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 75495a5c35079..f2460f3c860e0 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c

[ ... ]

> @@ -144,8 +146,12 @@ unsigned int trace_call_bpf(struct trace_event_call =
*call, void *ctx)
>  	 * rcu_dereference() which is accepted risk.
>  	 */
>  	rcu_read_lock();
> +	if (no_lockdep)
> +		lockdep_off();

[Severity: High]
Could this introduce a regression by suppressing valid warnings about real
physical lock deadlocks caused by BPF programs?

If a BPF program attached to lock_release acquires a kernel lock, the CPU
physically holds the original lock while executing the BPF program. If the
BPF lock ordering violates the kernel's lock graph, wouldn't this cause a
silent deadlock without any lockdep warning?

[Severity: High]
Could this also introduce a regression by unintentionally blinding lockdep =
to
hardware interrupts and softirqs?

trace_call_bpf() for lock_release can execute with hardware interrupts
enabled. The lockdep_off() macro increments current->lockdep_recursion.
If a hardware interrupt fires while the BPF program is executing, it runs
in a context where current->lockdep_recursion > 0.

Does this mean all lock acquisitions in the interrupt handler and
subsequent softirqs will completely bypass lockdep tracking?

[Severity: High]
This is a pre-existing issue, but does this approach fail to disable lockdep
for BPF programs attached to lock_release via raw tracepoints?

If a user attaches a BPF program using the raw tracepoint interface
(raw_tracepoint/lock_release), the kernel dispatches this through
__bpf_trace_run() which bypasses trace_call_bpf() completely.

Will the false positive lockdep warning still trigger for raw tracepoints
since they lack this lockdep suppression logic?

>  	ret =3D bpf_prog_run_array(rcu_dereference(call->prog_array),
>  				 ctx, bpf_prog_run);
> +	if (no_lockdep)
> +		lockdep_on();
>  	rcu_read_unlock();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803-fix-lock-t=
racepoint-bpf-lockdep-v1-1-91fb7afb526a@gmail.com?part=3D1
