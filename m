Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793984391;
	b=JSIziN4Is0IgsrsAlI3FO7ZrXWKdqRDpG9jBb6WOp8gliGXqmzl1u/K0lz+IgyiWrhjV
	 6fxzrvz5WrRxA+xQvcLfn1g6aTSPauJMw5btRXWkXvuy/oRxgxL+4LPpiJuDLkl5dMD4p
	 KpDlyWNXNtghICkpPKNc9cxga3Ai9jjJswV/lzonTeTtjCCEvjB+I8pYDZRBPh4uWL/Fw
	 LITRpbI8qH2f9jlQzUQ9XvnU3MZf949VzBPS6He/L0hNT6PE5y/JOnJXrLfu8BHVIWGPp
	 DDM+EdSYi22R4dSv2Ibomz9j4pBxvZL87Gk6uZu4OhdGhicFykALtWCLCvtPjX+PjLw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793984391;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=KL+KSSXu3b8P5TKRa9ZgiayGp/Utp/dI5DQ/LmoYroo=;
	b=IdU1M9tKmShKYmiau9mOkMcsPbGfpAhCw6yjSgLjUHq4SdGX5UEgTO5ewobddBBSisST
	 YzwDBM6eQhih13f7kA6oulrgSGToJjTHxr0XNlCkNy5WVQRPcvR65NScJg0VEiKCpLOaD
	 GiiZNCB+Qu+2TlB5vvTUWyU3pzJp937TEPw82uzAmTTG7hvkiCZucoO0QwzRvNuh9Ctul
	 8T1CL3IR/H+r1pD24rlWOZTGftPQfoRbAmOX9oe1+/42ulPaQY+mE2kMe8PN2UUQzsxNq
	 JZhYDsuU1SejUpC7sKWv2odXqQqZPkc1GNsEhyAsijSSfpYx1+YsncVTFbe+IIUJA2A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwIuSmBm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549DF606A335;
	Fri,  6 Nov 2026 16:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XwIuSmBm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3AB11F008A2;
	Fri,  6 Nov 2026 16:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793984391;
	bh=KL+KSSXu3b8P5TKRa9ZgiayGp/Utp/dI5DQ/LmoYroo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XwIuSmBmUiVCt4kN66UhGgrBG/oCgNdFJ6a+vDduteFCLQknDwuTd5vT06d1a0JJy
	 SozeFV0CdkNSN79W7i5pdU12xifwDBz1ra6pN/MHJs0hJ67PYQ/q9BEDCWx+qEsu9u
	 oYinMpVm+Q6nd71HytqI8seX78PE3dFBgAlTTcyxn/t+EaOuIQZfW3G2cHEm2LTme9
	 x4MARZcpBaU+4kC5ujG0k1gWL845TJ4Gmgxw8CQqt5gcrj0qXzG+ZfSlmHiqNd3RE/
	 BHFcknoq8ADyKHUGHryvc2drY4Cda3wDUFARr8OBUMnio+03YoGHz6q1MmrmeDELDM
	 LmtpHi9Ou/KYQ==
Date: Fri, 6 Nov 2026 06:59:50 -1000
From: Tejun Heo <tj@kernel.org>
To: Radu Toader <radu.m.toader@gmail.com>
Cc: peterz@infradead.org, mingo@redhat.com, tglx@kernel.org,
	juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, kprateek.nayak@amd.com,
	void@manifault.com, arighi@nvidia.com, changwoo@igalia.com,
	frederic@kernel.org, anna-maria@linutronix.de,
	bigeasy@linutronix.de, joshdon@google.com, haoluo@google.com,
	brho@google.com, linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev, bpf@vger.kernel.org
Subject: Re: [PATCH 1/2] sched_ext: Add scx_tickbug, a scheduler that holds a
 task on an idle CPU
Message-ID: <au4HhnJoKvJ6GPJT@slm.duckdns.org>
References: <20261106094343.174905-1-radu.m.toader@gmail.com>
 <20261106094343.174905-2-radu.m.toader@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106094343.174905-2-radu.m.toader@gmail.com>

Hello,

On Fri, Nov 06, 2026 at 09:43:42AM +0000, Radu Toader wrote:
...
> This scheduler is the same thing with the kick removed: a tagged task
> is parked on the target CPU's run queue and released only by a timer
> pinned to another CPU, so the window is as wide as -H says. Untagged
> tasks go through a shared DSQ and per-CPU kthreads keep their local DSQ
> and preemption, so the machine stays usable and the timer's softirq
> cannot be starved.

Thanks for catching the bug. However, this scheduler is more of an one-off
debug code and I'm not sure we want to carry this in tree. Maybe put it in a
github gist or sth and point to it from the fix patch?

Thanks.

-- 
tejun
