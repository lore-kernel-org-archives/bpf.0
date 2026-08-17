Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4EA3BB135
	for <bpf@vger.kernel.org>; Mon, 17 Aug 2026 20:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786999085; cv=none; b=k4R5IN7VD9jjXwvGJoBiVndW2D6qpKauhV+xQid845GsvSucYG0HwyHhACLTGuJGavzEiPnppv/OcpHFz4UUzSd4WZt3bQAw7KLilKe9OzarkcIduHcOnmTQZloiHNR6fb0r7SyjJlafP4lMTbb6tfLhinDvHxQTx4TeKWJ0vKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786999085; c=relaxed/simple;
	bh=FWdwL5vplJazWZxHnMSgHscIa/slfGDARfxFPqN9nvY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=t6FhoVLkknMWWz+3JGM+/cnlwDETzzEPIB1jrDStii8m3Qn/ovhhjLTzptGcHKnh/CR7ouKcl0NmgCkAI4ymfyknjqTdlmkf/vcDqV3vTv/XGAMp4jwOQTOYps0KwQk/3bqvWs1W6lH1FuG7ehb/CnRiFVlR6MDG0X8890duCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKGCqrnF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKGCqrnF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2CD1F000E9;
	Mon, 17 Aug 2026 20:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786999083;
	bh=EIJDlnUdpUwyANj2ufBIipOUaA1zx3ENQ4c4XJ7MRQE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FKGCqrnFwH7AYh7DnA+5PrfhjSauedahDmaiOWLq6vsMJarrSqyPK+SJ2Z01dGdxf
	 /1ZzVDUTgB0X+1kbMj0UgArGfbKTk6q09ccjfvqe0V0nk3hSw0THz9uaj8h8E+RRau
	 5yVlsocXGLBM/1caK8MgXIvw/PntnyHE+ySfZ1E0WZ3WibZgfPphA9Y7BKEsCtiqEW
	 43tiGLSmpmKj14FSvxVraPVPYTC7m/jaqxAPjW/PcNg+bx4aIvGbssX7zj0+z8e17I
	 GdsgJyv/Irc9wkiCgxwW4jO4f+qUFB7CfAmMqpnQQjcUZSBgS46ScT0tiCr95RvUxH
	 vGLjY9ujnhYuQ==
Content-Type: multipart/mixed; boundary="===============0009087013681644693=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fa0d9a7b2cf4f9806b4e7e75673d135099da380e3b74a54c0a6a657e00956337@mail.kernel.org>
In-Reply-To: <20260817191616.11071-4-emil@etsalapatis.com>
References: <20260817191616.11071-4-emil@etsalapatis.com>
Subject: Re: [PATCH 3/6] selftests/bpf: libarena: Disable IRQs during allocation
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 17 Aug 2026 20:38:02 +0000 (UTC)

--===============0009087013681644693==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

>     selftests/bpf: libarena: Disable IRQs during allocation
>
>     The libarena buddy allocator currently uses arena_spin_lock/unlock
>     to protect its internal data structures in its critical section.
>     These locks disable preemption, but not IRQs. This in turns can cause
>     ABBA deadlocks when an allocation/free operation gets an IRQ while
>     in the critical section, and can only resume after another operation
>     that in turn blocks on the buddy lock. We have concretely seen this
>     with sched_ext schedulers:
>
>     a) Task 1 on CPU A attempts an allocation during initialization,
>     which is done without holding an rq lock. The task takes an IRQ
>     in the middle of the allocation.
>     b) Task 2 on CPU B exits. It attempts to take the buddy allocator
>     lock during its sched-ext state teardown, and blocks on the spinlock.
>     It does so while holding CPU B's rq lock.
>     c) The scheduler run on CPU A and attempts to move tasks from CPU
>     B's rq to CPU A's rq before resuming running Task 1. This requires
>     B's rq lock, which requires Task 2 to take the buddy allocator lock
>     first.
>
>     Fix this by disabling IRQs when taking the buddy lock. We use the
>     already existing arena_spin_[lock_irqsave, unlock_irqrestore] calls
>     for this.
>
>     Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

This looks like a bug fix for the buddy allocator's locking. Should this
include:

  Fixes: 86426a28c52d ("selftests/bpf: Add buddy allocator for libarena")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32062809860
--===============0009087013681644693==--
