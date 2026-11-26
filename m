Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795698804;
	b=MXc5X6Bern/svZTPvft8B+/IA9EnujBFH4v8Bfk6G/t0X0bobqagH3AbhNDGk0p4NIL6
	 ntjAYInIKznPqe2uqjMJPE9BG+NN4MHUlU251mqamxqIdQkIQV/indDbaKxBIfNo4jhf4
	 rOAtyAgLx9rsx8zu5dz5qHJ/3c9rpGVf87ceVBqhPevvAiQv0bl23kcGRV2dyRuCw1Vhk
	 vKNnBadMe1DOnhqXHkeasgycmj9GSng3PRMoT2EjTYWe++edz+JYaJzkHZu3xm0I1j7Gd
	 yzHuJsRG0hr56zBJ68N03NWCEhu7lYXiaQr/+ks5klkxIv99gPZ8Xw+CUYfiwrra9PA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795698804;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=uPJCbMDaqinmxAdEFzrxo12zHApvRGF4LfrGZRkgXRo=;
	b=v66pqlw3+AcnvQNaqh7T5DHxxaUzqpivwKEOKleizwUskuEJMJcvlCX5OJf+drzMQThA
	 eEcX4lTG4LNCqxb0uVw02QIIVpEkgR88tyKGeht2f2Hhiv0+igz4aQJwTK8S6GLfZkOhg
	 FrJfCRPdrfgxxXHsOAQy+bYz0sdjNX775+D7btHz7bSkp1cwWrGdgISIe+yhQSCrXwhnI
	 k62S05wRNjEljnF21Urr3IuNZtcgfJSHGO32at7vN3IT6TWm9TQ5lPr2ctVNDbdItcsYi
	 BvM0o3hEVYJhdx670JaCzz2d9dFw/xF7jXheG8rVPlVCznG7er8MiUmCkOb02DFG0Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dq1a4P4/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB40606A31C;
	Thu, 26 Nov 2026 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dq1a4P4/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D481F000C6;
	Thu, 26 Nov 2026 13:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795698804;
	bh=uPJCbMDaqinmxAdEFzrxo12zHApvRGF4LfrGZRkgXRo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=dq1a4P4/pDsGG/GFcAgTmB4G8m3z4RAESJkIW7AfHjH+hrmRkKSwXP0EJBtSOtKOT
	 ElsTd1o8qLp00ttAcdMujNybLGsBLIoViXYBskP1+vSorfgdkG8HGlZVMNZotL4Z9F
	 Ps9z6DS44dkQmJQCReFv+VlKfEqkUeXncm6jaKNd2JEQ0M7tn1SHimfVhD0Ccagvqz
	 4rDpeDgQ67e+q4P/5/0P8/H9w9iNj+UBRABqO5NZx+pzQN+6vAibCAjZHL/2+8xyBP
	 DTEHnZAL8b/Rk/+pwBTwNJG/+MxNJEvwp+zoUdjMhnhj/ma5holwjWgf6oj2IZuS/6
	 nF0cHMuU2SEGw==
Message-ID: <sashiko-outbox-235577@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 01/18] sched: Add task enqueue/dequeue trace points
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gabriele Monaco" <gmonaco@redhat.com>, linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org
In-Reply-To: <20261126130004.127155-2-gmonaco@redhat.com>
References: <20261126130004.127155-1-gmonaco@redhat.com>
 <20261126130004.127155-2-gmonaco@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 13:13:23 +0000
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
- [Low] sched: commit message lacks rationale for enqueue and dequeue
  tracepoints
--

commit 9e126d48d20c6a32f27d4f37320ca4e103557c73
Author: Nam Cao <namcao@linutronix.de>

> sched: Add task enqueue/dequeue trace points
>
> Add trace points into enqueue_task() and dequeue_task().
>
> Signed-off-by: Nam Cao <namcao@linutronix.de>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Co-developed-by: Gabriele Monaco <gmonaco@redhat.com>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

[Severity: Low]
As reported by Peter Zijlstra on v2 [1], could the commit message explain w=
hy
sched_enqueue and sched_dequeue are needed, and how delayed dequeues are
handled across enqueue_task(), dequeue_task(), and __block_task()?

[1] https://lore.kernel.org/r/20261001154934.GT88198@noisy.programming.kick=
s-ass.net

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126130004.1271=
55-1-gmonaco@redhat.com?part=3D1
