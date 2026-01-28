Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D4925485A;
	Wed, 28 Jan 2026 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769601444; cv=none; b=gn2grEPNR0ezeFg04j1CTEcQmdWRL5JCWk2o9ymmJW8kYRaiFpLoI7/j816zYQrqyn1ANEwXasto1BHJm+2yb3CD1+AdPpRiX5Tu00E1X1+A9/8rX1zc7uTXcDfecTlhMa2/Dr9DVBgofQQiS2+XsVJt+TxStk1ylTi1s5kLn7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769601444; c=relaxed/simple;
	bh=hQDBvjcN2GTZgu7CN2zBOx4sBb6h79x7UGonvI29DMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KbrfXwEw42AWG2cNl9QLmUz9gyovCFM75W1e/iNdetDwZ41LJwWMYrli6JdOmlLcCkOA0A8ciEn1LrvTWYsZztjo6MSxD99mTeCwbBgja9sESc2FlIaUJLoVZTv81kpiJbMp0XBWpGejHi8yk6bvqIPV08/ZrfUuGRSKXmny+ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=io/yDQkD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="io/yDQkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8910BC4CEF1;
	Wed, 28 Jan 2026 11:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769601444;
	bh=hQDBvjcN2GTZgu7CN2zBOx4sBb6h79x7UGonvI29DMI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=io/yDQkDuOQGnRm/bD2p7s4MRxz85pN6gMBKMTxDs2gMhip0wDyemYBsVwrkqqlVg
	 NPblZ88moSATcE7yh6jfvNZacUfsLMRvTm0pjZwum0T1kTYk8rpeG613v0bCWLLQs2
	 derufY3AUE+ZqneoInGYld0cgCvVjkYJfiQlTjt2oFxrtMDf1oTl9Yz/NI2XJw/+K8
	 EViMkVD6FTC4+Cix0D/Gf50fEo7gq43MbKX4o1ZEYBpI4O20Czjuu0ov/A/emlLACm
	 JuoVxNID+na2lhW5QgwRkHTZaCgYzGALJCLqa5YKCxUiBIc+fXMXaNefOeRVB8Jo1l
	 iybTPz8Tdht/w==
From: Thomas Gleixner <tglx@kernel.org>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Gabriele Monaco
 <gmonaco@redhat.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Michael Jeanson <mjeanson@efficios.com>, Jens Axboe <axboe@kernel.dk>,
 "Paul E. McKenney" <paulmck@kernel.org>, "Gautham R. Shenoy"
 <gautham.shenoy@amd.com>, Florian Weimer <fweimer@redhat.com>, Tim Chen
 <tim.c.chen@intel.com>, Yury Norov <yury.norov@gmail.com>, Shrikanth Hegde
 <sshegde@linux.ibm.com>, bpf <bpf@vger.kernel.org>,
 sched-ext@lists.linux.dev, Kernel Team <kernel-team@meta.com>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Puranjay Mohan <puranjay@kernel.org>,
 Tejun Heo <tj@kernel.org>
Subject: Re: [patch V5 00/20] sched: Rewrite MM CID management
In-Reply-To: <2b7463d7-0f58-4e34-9775-6e2115cfb971@linux.dev>
References: <20251119171016.815482037@linutronix.de>
 <2b7463d7-0f58-4e34-9775-6e2115cfb971@linux.dev>
Date: Wed, 28 Jan 2026 12:57:20 +0100
Message-ID: <877bt29cgv.ffs@tglx>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 27 2026 at 16:01, Ihor Solodrai wrote:
> BPF CI caught a deadlock on current bpf-next tip (35538dba51b4).
> Job: https://github.com/kernel-patches/bpf/actions/runs/21417415035/job/61670254640
>
> It appears to be related to this series. Pasting a splat below.

The deadlock splat is completely unrelated as it is a consequence of the
panic which is triggered by the watchdog:

> [   45.009755] watchdog: CPU2: Watchdog detected hard LOCKUP on cpu 2

...

> [   46.053170]   lock(&nmi_desc[NMI_LOCAL].lock);
> [   46.053172]   <Interrupt>
> [   46.053173]     lock(&nmi_desc[NMI_LOCAL].lock);

...

> Any ideas what might be going on?

Without a full backtrace of all CPUs it's hard to tell because it's
unclear what is holding the runqueue lock of CPU2 long enough to trigger
the hard lockup watchdog.

I'm pretty sure the CID changes are unrelated, that new code just happen
to show up as the messenger which gets stuck on the lock forever.

> [   46.053209] CPU: 2 UID: 0 PID: 126 Comm: test_progs Tainted: G           OE       6.19.0-rc5-g748c6d52700a-dirty #1 PREEMPT(full)
> [   46.053214] Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
> [   46.053215] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> [   46.053217] Call Trace:
> [   46.053220]  <NMI>
> [   46.053223]  dump_stack_lvl+0x5d/0x80
> [   46.053227]  print_usage_bug.part.0+0x22b/0x2c0
> [   46.053231]  lock_acquire+0x272/0x2b0
> [   46.053235]  ? __register_nmi_handler+0x83/0x350
> [   46.053240]  _raw_spin_lock_irqsave+0x39/0x60
> [   46.053242]  ? __register_nmi_handler+0x83/0x350
> [   46.053246]  __register_nmi_handler+0x83/0x350
> [   46.053250]  native_stop_other_cpus+0x31c/0x460
> [   46.053255]  ? __pfx_native_stop_other_cpus+0x10/0x10
> [   46.053260]  vpanic+0x1c5/0x3f0

vpanic() really should disable lockdep here before taking that lock in
NMI context. The resulting lockdep splat is not really useful.

Thanks.

        tglx
