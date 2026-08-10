Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC93AB496;
	Mon, 10 Aug 2026 12:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365782; cv=none; b=GUV6Wkcj1PZErUGFfh9+qV+KpiLYz1mL3WVMMmP6MZKx68c0X/hgTPrbdUoZ9E8Ph/180ytsEV6IhN3FmPr8Vgcm5S0sNS6QkoDBcty+kAKaP58nKaKMknhOeZVLmKGw/I5BBwmNv8vKymEohtz3+7U3Gy/WqWVbsB/SY1W85oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365782; c=relaxed/simple;
	bh=+lJmqsqQ7i6Nia+Sra3FhPPVbO4YW6QPpg18KaY7wVY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Qe3Dhz2+PEjnfdeaXUyla7IJ7lz9fNG+i2G0KoRAO+t7PCkhAlrFC3mu7gbaMcNFFMe21OZcqW3fsKksvO1TJ5BtudRM6JFzwDdUjNS2+03uG5rzCGwMrKuDrIVdVJ+aqWVwRtRMUV+8b9hmIbMOTRJET27Zyz+W5rlIBcJbHMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Byph0iM6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Byph0iM6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F6F61F000E9;
	Mon, 10 Aug 2026 12:43:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786365780;
	bh=mdlB1HXOoqK2FYTy4nWctbxVB2KgCne0kR9BJEWwrbE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Byph0iM6CZagy7+0Zqk8Cls3yvBjLwirf3+1lcO7AJmpxv6ri4DvBhdTQuck7W7Th
	 aNzR4NZe1fJRIk0tHaMzD2QptsFLOYj661bStNZ+QJVqNGZ4WonlWMlvoJ6IcpKfVy
	 P4zkJOksgIBeparNtxb6+ImExCzcVpNimcCIfJQMBsppz7cHwq0NSqEpv1eBBwG4rT
	 3ZRb152Cxcn6AM0e3JS0qBbBFisEwVC8Gg/QIb7MB1qgxPW6QUK8C+b+0axUixt4Jr
	 k6+5h8nrxdFCfqG/2NFB6qE7US4c3Hf7xhOZbAvtIu93F8nNLiGghXu8SfcnKnY/gC
	 ZusOhP+BDGtFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/6] rcu: Make Tiny call_rcu() safe to call from any
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260810122758.183765-3-puranjay@kernel.org>
References: <20260810122758.183765-1-puranjay@kernel.org>
 <20260810122758.183765-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 12:42:59 +0000
Message-Id: <20260810124300.6F6F61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Moving `debug_rcu_head_queue()` into `rcu_do_enqueue()` bypasses d=
ebugobjects tracking for deferred RCU callbacks, masking use-after-free bug=
s and causing list corruption on double frees.
--

--- Patch [2]: [PATCH v4 2/6] rcu: Make Tiny call_rcu() safe to call from a=
ny context ---
commit b9d1d9e1aa870c19c3d9b30019cdb1bc509b6703
Author: Puranjay Mohan <puranjay@kernel.org>

rcu: Make Tiny call_rcu() safe to call from any context

This commit updates Tiny call_rcu() to handle interrupts-disabled contexts
when the scheduler is active. It defers the callback on a lockless list
which is re-issued later via an irq_work, similar to Tree RCU.

> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index dccccd6be9411..656b6a682e31a 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
[ ... ]
> @@ -157,29 +251,19 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
>   */
>  void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> -	static atomic_t doublefrees;
> -	unsigned long flags;
> -
> -	if (debug_rcu_head_queue(head)) {
> -		if (atomic_inc_return(&doublefrees) < 4) {
> -			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->=
func);
> -			mem_dump_obj(head);
> -		}
> +	if (should_rcu_defer()) {
> +		call_rcu_defer(head, func);
>  		return;
>  	}

[Severity: High]
Does moving debug_rcu_head_queue() into rcu_do_enqueue() bypass debugobjects
tracking for deferred RCU callbacks?

Execution is routed to call_rcu_defer() before debug_rcu_head_queue() can
activate the object in the debugobjects tracker. Adding to the lockless list
in call_rcu_defer() overwrites head->next without verifying if the RCU head
is already enqueued.

If a caller erroneously frees the object or double-queues it during the
deferral window before the timer tick issues the irq_work drain, could this
mask use-after-free bugs or create cyclic structures on double frees?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810122758.1837=
65-1-puranjay@kernel.org?part=3D2
