Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BF1630C629
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784137134; cv=none; b=ZGPEzCQlk1zjfvADJ+xqrKZ/EYpLQMSvU0M9O/kgHK+Qezg8rgINccL53ZOvz1c1kknX4XGjkDT3cFvDw5dpjGv3ORwP3rocRZK86k94YhMHWNJBc458VzEHzIOGckKcXMHOJF4CeCI9CBBpUXTEb2okcDyW9Ehd+auj8f5czj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784137134; c=relaxed/simple;
	bh=X8Aq2FZGHZCyz8Nh4oGa1uzgpSX0ZTRJ33SpO6m3spQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jPi6eWQG3rIzlA13WfutkTxNFshFUdKLUFuHTAYIvF0flFZJx7FC/NEFrwTio6JrxT8K23CTxuBWSa5ByySCvD+gI/bZ0Bdhyx/wcZGUNee0Qe5M0s+DCC8RplrzLDmROMZk4dLs60zfpZd4LBQNszciQ2z02+JXPHSNdIQbdPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c0JRwTiC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c0JRwTiC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE47D1F00A3A;
	Wed, 15 Jul 2026 17:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784137133;
	bh=wFx2BbTbrCWtJkHY78fU0GFXwwB1BFBT2r+w1p2fYJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c0JRwTiCh1ZO24CtKzMkHN1UUYx3UW/JAUvRe0x1fZorNmrYVtRcwiggcLCs4lsMV
	 MOERBiILB5Xaaza0SQi7+FHnbT3gCU/O+zi9xHLN06+tamskDKpsoaflxPzztMWrCU
	 0qsvvqO64ibyf6fl4c6MvPqXzumGq2MsnBQlqna09abvCU/oVndznZblhSEfZZVIli
	 QH66bdiFhFdTcb5sXbTUet9HW7BYJ5SQnNEC7Hz/vpeXyIEIwIjs5JHQOFkzcY0Iss
	 HVKKt2X+XQtntQXEPYqwXcyRUyFmMxf+Ewgo70rrNDhrsC54skc9V5RV9qCOGvCwfD
	 dImBSyx3ooe9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 1/2] bpf: Disable raw mdoe for bloom filter
 map_peek
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715172127.2416388-2-ameryhung@gmail.com>
References: <20260715172127.2416388-1-ameryhung@gmail.com>
 <20260715172127.2416388-2-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 17:38:52 +0000
Message-Id: <20260715173852.DE47D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_map_pop_elem() and bpf_map_peek_elem() leak uninitialized kern=
el stack memory on queue and stack maps if the map's spinlock is contended.
--

--- Patch [1]: [PATCH bpf-next v1 1/2] bpf: Disable raw mdoe for bloom filt=
er map_peek ---
commit 89de02f623877f9e477f4639136b8a23b2fbbd7c
Author: Amery Hung <ameryhung@gmail.com>

bpf: Disable raw mdoe for bloom filter map_peek

This commit prevents an information leak by disabling raw mode for
bpf_map_peek_elem() when used with a bloom filter. It notes that unlike
queue or stack maps, bloom filters use the value buffer as an input and
do not fill it.

> bpf: Disable raw mdoe for bloom filter map_peek

[Severity: Low]
This isn't a bug, but there is a typo (mdoe) in the commit subject line.

> bpf_map_peek_elem() tags its value argument ARG_PTR_TO_MAP_VALUE |
> MEM_UNINIT, telling the verifier the callee fills the buffer. This holds
> for queue/stack maps, but not for a bloom filter, which reads the buffer
> as an input to test set membership and never writes it.

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
since the commit message mentions that the MEM_UNINIT assumption holds for
queue and stack maps, does it hold true if the map's spinlock is contended?

Looking at __queue_map_get() in kernel/bpf/queue_stack_maps.c:

	if (raw_res_spin_lock_irqsave(&qs->lock, flags))
		return -EBUSY;

And similarly in __stack_map_get():

	if (raw_res_spin_lock_irqsave(&qs->lock, flags))
		return -EBUSY;

If the lock fails (e.g. due to deadlock detection), these functions return
-EBUSY immediately without zero-initializing the output memory. Since the
verifier assumes the buffer is initialized due to the MEM_UNINIT tag, could
a BPF program read uninitialized kernel stack memory if bpf_map_pop_elem()
or bpf_map_peek_elem() is called on a queue or stack map and hits this
contention path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715172127.2416=
388-1-ameryhung@gmail.com?part=3D1
