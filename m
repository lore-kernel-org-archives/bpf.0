Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793986359;
	b=vj+jfHnFTDH1dY7vQS07dHALRg+N81dNrhQjRqUW0mbaECbQ7hFB75iGfo83tx3hvPka
	 zzy9pzdED/E9GUr2NFPzXA2MMjDi2Pv33J37v0o3/TUH/InzjPP2kgVnTBHxOpswxwk7n
	 Z8sc6hUl0Rd172cs3iybjQrTkilI7nNSqjIhLxrjn+VBfuVw1T2fFXSugtvRHGWV84zVS
	 GjGVZuy7QkC19WDKmGpIyZvE5SLqdeL+OTFQA34i1Q48eJdrmG20fYVRLL9H2kG9Vr1Tw
	 dfxjzJiTIW/LTmDxuo1KCnpdduqvGXNon5T0aUB5G60t+XJOsmgMUnaZTvv/T+Q9Sow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986359;
	h=Received:DKIM-Signature:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ybZChZ9rAXXJpYgVjjNMXpb0KllCBOdJmkiYdEAub2w=;
	b=wJ5/jecRoGyRTb3w0PAcvsqNxq2CIP7K/HAFXBrdDlShojpwU8OX+Z7/bUIpy8Hi5aaO
	 aP4Sbmewcl5/WJO+N554WLabSLUwQL5Q4SCW0n1Z+SH3pUIP6jgjHKrYvXD3ZHnrRFw3J
	 t6z9FKlMEysfsGU52AkFmaAOaXtF+5/sxVA0SJVTNF++lF863I2fvuop/mmsnA5RLY/2m
	 A/6ek1MfOq7G12mKKWjqZDdPstE6c3slt0a8UZ/h8+3BwlBHYO/aBaKjsfl0hIUewtxev
	 cTjBIeW9I+TKFknqoTKVS8rQpjURw6nI+Hdlc/eOdPAsyAO8cDA0fPQOPppaAj0fDEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jf3kisSZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA001606A32C;
	Fri,  6 Nov 2026 17:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jf3kisSZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E95E1F008A2;
	Fri,  6 Nov 2026 17:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793986359;
	bh=ybZChZ9rAXXJpYgVjjNMXpb0KllCBOdJmkiYdEAub2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Jf3kisSZKUNQEmo4gG2lyzj11wxrXhVhlZ9uxM6uQcpiKNxiBQgZUvTs42wXPkBRh
	 sdmu9pmR0qfc8PqeGFoHcF/YCDwRr7JBszTRd9qZJeE9l7bX1a8GUcpcJ++xMyljKg
	 VqXgKCtEHSkpfj+j9Akjs1bUGCkaqiXNA+VBj4LXSUafSzIML90uC/l1K2iPx4tdY+
	 W2EfU+NipLJDld7o8CbhfPKuNRrJ69qEa8zeMYTOPbrUjcly8ZUZJIKviq41nimBTO
	 QkdprJA8+M0o/OJuFW12dxmyxKs3/hCW5PVubhJr/F6h3qxc/HpunevXPtIxM5tOGV
	 KfYN3qziIb6ZA==
Date: Fri, 06 Nov 2026 07:32:38 -1000
Message-ID: <1ee462ef3e697e999011e4a0cd2864bd@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Cc: void@manifault.com, arighi@nvidia.com, changwoo@igalia.com, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next] sched_ext: Reset task fields on exit of an SCX_TASK_READY task
In-Reply-To: <20261106142818.1475-1-rahadbhuiya2021@gmail.com>
References: <20261106142818.1475-1-rahadbhuiya2021@gmail.com>
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
Content-Transfer-Encoding: 7bit

Hello, Rahad.

On Fri, Nov 06, 2026 at 08:28:18PM +0600, Rahad Bhuiya wrote:
> However, in __scx_disable_and_exit_task(), an exiting task in state
> SCX_TASK_READY (e.g., a forked task that was initialized via
> ops.init_task() but never enabled under an ext_sched_class before exiting,
> or a disabled task) currently breaks out of the state switch without
> calling scx_reset_task_fields().

Neither example has anything to reset. A forked task which exits while
READY goes through sched_ext_dead() and is freed. A task disabled from
ENABLED is already reset: both callers of scx_disable_task(), the
ENABLED case here and switched_from_scx(), call scx_reset_task_fields()
right after it.

A READY task is on a sched but outside the ext class. RT and DL tasks
are always in that state, and so are non-SCHED_EXT tasks under a partial
switch. The sched's BPF code can still write such a task's dsq_vtime and
slice, and because the READY exit doesn't reset them, they carry over
when the task moves to another sched.

For example, an RT task in a cgroup owned by sub-sched A gets its
dsq_vtime set by A's ops.cgroup_move(), as scx_flatcg does. If the task
is then moved to a cgroup owned by sub-sched B and later switches to
SCHED_NORMAL, B's ops.enable() sees the dsq_vtime from A's clock.

Can you rewrite the description around that case?

> Fixes: a298fd5f4ee8 ("sched_ext: Fix use-after-free of a NONE rescuee leaving its sched while running")

a298fd5f4ee8 didn't change the READY case. It was a bare break before
and after. The gap goes back to 5771e79e461e ("sched_ext: Reset
dsq_vtime and slice when a task leaves SCX"), which put the reset only
on the ENABLED path, so that'd be the one to point at if the patch keeps
a Fixes tag.

sched_ext patches go through the sched_ext tree, not bpf-next. Can you
repost with the above updated?

Thanks.

--
tejun
