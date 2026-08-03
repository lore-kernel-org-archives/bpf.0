Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F7E4137BA;
	Mon,  3 Aug 2026 14:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785768560; cv=none; b=IhXMY8sroek5Tv/Wv7wH0KHjG4vIXjqLEf6adPhjlnGGaOmk6vLVHToaG5ZvzcNx6ezTLQQjw5x2XRjWcZzNPXRtskAa2PWeGGX3YOhCTwgBsmnI62HOqS1G9mNWKiJ8iOBPzx724zaf8x2M0QwKwRHAux+NBsshaWD4ibf6vJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785768560; c=relaxed/simple;
	bh=nKdsDyKdd2oAqdjPZpM4lvJrxGJXIyH+oKTP5ICQAqk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VVHrERU8s2vFs4syVrSjUJpgghUk5ZPdJuJaBiV2XE8JddZXSoYKNjr2z8nyaswk39kMLIvIdn0BMyW2BlruSCyJ79G2SR7MbkaRvlXTia6MAFvbAM+P6nABNiropFsyohgdGhxm1h35OVv/jjPm53X/ti0GCLgiZEeGgCpKy6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlKiqgwM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlKiqgwM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D8C31F000E9;
	Mon,  3 Aug 2026 14:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785768559;
	bh=oFkUVyWlCbT1mPjrx2EmyX6W5aUevlpHVXr6CiVU82c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UlKiqgwMlxahe6dfsHzEeYG1YFlQBm/tFkQpzXFqu89Jxc+0L1yKIUuXDQJ9Ts3K1
	 BvI/kpcXh9kzpt+J9783N8Pe0PdMWeYdq84PoNkH6x9P3LLnyC5VgH7k6DDx5OQovx
	 TRgHE+MZCM9fHl3U8VMYXrpJDjIftdFTEbRHs8X1qH7FBGKky5kxDmIYp50crCVH9e
	 Si8g+n1iBhDtXw2Os4fFn9oz0l9/xkBIQNkgNZTI9UtruG6ZFvuydbrN6tttbuaOAt
	 JrMGBdaENkUXg3ndFtpHh6WLZ05F7T00QZaCgs6assFeM/hQQnlC7xO2eLgZqzroBZ
	 c0EKDJhFs7hcA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] srcu: Make call_srcu() safe to call from any
 context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Puranjay Mohan" <puranjay@kernel.org>
Cc: bpf@vger.kernel.org, linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260803135329.2327280-3-puranjay@kernel.org>
References: <20260803134839.2103051-1-puranjay@kernel.org>
 <20260803135329.2327280-3-puranjay@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 14:49:18 +0000
Message-Id: <20260803144919.2D8C31F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Tiny SRCU's call_srcu() remains unsafe to call from NMI context, l=
eaving it vulnerable to list corruption.
--

--- Patch [3]: [PATCH v2 3/6] srcu: Make call_srcu() safe to call from any =
context ---
commit e3be0303432c7c7afdd4ed014dae0987e25bf7d3
Author: Puranjay Mohan <puranjay@kernel.org>

srcu: Make call_srcu() safe to call from any context

This commit updates Tree SRCU to make call_srcu() safe to call from any
context, including NMIs. It defers callbacks via a per-CPU irq_work when
interrupts are already disabled to prevent list corruption and deadlocks.

> srcu: Make call_srcu() safe to call from any context
>=20
> call_srcu() has the same constraint as call_rcu(): its callback list and
> locks are only touched with interrupts disabled.  srcu_gp_start_if_needed=
()
> enqueues under raw_spin_lock_irqsave() and may walk the srcu_node tree, as
> do callback invocation and grace-period work.  A call_srcu() with
> interrupts disabled can race a list operation in flight on this CPU and
> corrupt the list or deadlock.  call_rcu_tasks_trace() is call_srcu() under
> the hood, so a sleepable BPF program freeing an object can reach this.

[Severity: High]
This isn't a bug introduced by this patch, but does Tiny SRCU also need a
similar fix to safely handle NMI contexts?

In kernel/rcu/srcutiny.c, call_srcu() relies solely on local_irq_save(),
which does not mask NMIs:

	local_irq_save(flags);
	*ssp->srcu_cb_tail =3D rhp;
	ssp->srcu_cb_tail =3D &rhp->next;
	local_irq_restore(flags);

If an NMI interrupts call_srcu() exactly between assigning the tail and
updating the tail pointer, and the NMI handler invokes call_srcu()
(e.g., via call_rcu_tasks_trace()) on the same srcu_struct, could this
overwrite the tail pointer and permanently detach the list?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803134839.2103=
051-1-puranjay@kernel.org?part=3D3
