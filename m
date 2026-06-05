Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AAC3F7896
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 22:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780699869; cv=none; b=O8rXbHhWqNLdehMjCd60Q6GQCqhNfWiKMRcwiR91qMjeUWGq0jggbvicaORJyWvD39vcuHe+7FzrTzPJvSetUXxOIg05nspJEQeorvGiDaGgcE3qLsU04ftxXKxNUbj+NbJ7mk3eG47Kq6u//BGJkYWYAhB4LuCxglu3CaRoiww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780699869; c=relaxed/simple;
	bh=ny4GQn4XgGQEWoPUVGJ3cv0L3K4O6XFv668n/dGLmdY=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=h9i8ySrIAPdm20fQ0PMxLPAhXaN8EbeZWftGVeXtj/j8CtURjZ0Jb9nMSspb6DtkZ2ntdl97FaAG5rNOk1M0zop+5IBIqkcuqPkxSPlXUQqZvpiLGae4M0Ozl3Y0AKZqe84dI0KpuQV2uYNbxV8zh+MxbVHOHBQUbNGDUYVCuTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYwDMLi6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYwDMLi6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA2C1F00898;
	Fri,  5 Jun 2026 22:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780699868;
	bh=dIPlEInEOJ6U6Awl38mG8kt9O46avrs97346efN5sRg=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=OYwDMLi67sPCj4k98lPNfEE/0Jp9X12gYKsDK4Gzi4fKnTShOrlqCuIa7C9+/drhA
	 B9mj2qTUThQ4vKttySgPzysUEasXWglY8A4PuQRhQIPy3AztTJSWVeqW821TQvAEyb
	 9yMQADQnbrExDzwEWyaHIbOybEFfZtggZaC8fvKcCeZqw3XAQlNEqHhA+GlCLB8opc
	 lSp5lcxkUbgL970dvH3m27GZR4wJ7eqZ+iquCmxmxBqZY08xIzpbgNwJ/hcuup+D8N
	 UKOPvJUxr33iHon6D+yn+p8XuzKGJeUyenanVwIODMPBOJazFfZx/3PvE6hbYBcNuk
	 y6z+8LkYQd3aQ==
Content-Type: multipart/mixed; boundary="===============7961670871701440976=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <a0534129e647e709ded3d9dd3894dd075c6ce276140dcc08a9a552eac14bfa0d@mail.kernel.org>
In-Reply-To: <20260605222020.5231-3-emil@etsalapatis.com>
References: <20260605222020.5231-3-emil@etsalapatis.com>
Subject: Re: [PATCH bpf-next v4 2/3] selftests/bpf: libarena: Add spmc queue data structure
From: bot+bpf-ci@kernel.org
To: emil@etsalapatis.com,bpf@vger.kernel.org
Cc: ast@kernel.org,andrii@kernel.org,memxor@gmail.com,daniel@iogearbox.net,eddyz87@gmail.com,song@kernel.org,mattbobrowski@google.com,emil@etsalapatis.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri,  5 Jun 2026 22:51:08 +0000 (UTC)

--===============7961670871701440976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: libarena: Add spmc queue data structure
>
> Expand libarena with a single producer multiple consumer deque data
> structure. This is a single producer, multiple consumer lockless structure
> that permits efficient work stealing. The structure is a Lev-Chase queue,
> so it is lock-free and wait-free.
>
> The data structure exposes three main calls. two of them are available to
> the thread owning the queue and one available to all threads in the program:
>
> spmc_owner_push(): Push an item to the top of the queue.
> spmc_owner_pop(): Pop an item from the top of the queue.
> spmc_steal(): Steal a thread from the bottom of the queue from
> any thread.

The commit message describes an API that doesn't match the implementation.

The message refers to spmc_owner_push() and spmc_owner_pop(), but the actual
functions declared in libarena/spmc.h and defined in spmc.bpf.c are
spmc_owned_add() and spmc_owned_remove():

tools/testing/selftests/bpf/libarena/include/libarena/spmc.h:
    int spmc_owned_add(struct spmc __arena *spmc, u64 val);
    int spmc_owned_remove(struct spmc __arena *spmc, u64 *val);
    int spmc_steal(struct spmc __arena *spmc, u64 *val);

Additionally, the descriptions are inverted. The message says the owner
operates on the 'top' and stealers steal from the 'bottom', whereas the code
has the owner operate on 'bottom' and stealers operate on 'top':

tools/testing/selftests/bpf/libarena/src/spmc.bpf.c:spmc_owned_add() {
    b = smp_load_acquire(&spmc->bottom);
    ...
    spmc_arr_put(arr, b, val);
    smp_store_release(&spmc->bottom, b + 1);
}

tools/testing/selftests/bpf/libarena/src/spmc.bpf.c:spmc_owned_remove() {
    b = READ_ONCE(spmc->bottom) - 1;
    ...
    value = spmc_arr_get(arr, b);
}

tools/testing/selftests/bpf/libarena/src/spmc.bpf.c:spmc_steal() {
    t = smp_load_acquire(&spmc->top);
    ...
    value = spmc_arr_get(arr, t);
    ...
    if (cmpxchg(&spmc->top, t, t + 1) != t)
}

Finally, the message says spmc_steal() steals "a thread" rather than an item
or value.

Should the commit message be updated to match the actual API and
implementation?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27043406243
--===============7961670871701440976==--
