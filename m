Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E182C46D09D
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 17:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787591313; cv=none; b=JkRjzz2x3NjFZwoTc+Dlv8fuBlk3UO5/jfFueYp9GU/7pfWrQUbeX1vAf7M0Q3/HcaJzty41e9q+GkKj86i/R1bXngGXRtZfdC+9kUt0R6cRBOqxdMN+FakC81WBRiJB2wJD0Xs9ND0Y7aQNs5bEEKnHUJYswjJZPIrHsOCL2Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787591313; c=relaxed/simple;
	bh=v0uKoEtxuOtBOv5xEpE6W/ujXNutICk5DSp9GzCmKKQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fo0ek+OFSZ+GGWe+n/dWaJMmUDasaz4gNarz4Zh892KORmpVEuIC5f1wEvik+wrbqthx7XhUGXCt8KV/JhnAFlgrovKJ1xmNPT9CgkT88sJBudgSScwQrJ+Vdz9nUBfXeISk3Iu+ieLTViWUALtv5WY9J+oKo114CEJBGMHYIDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QQIOaEZA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QQIOaEZA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E051F000E9;
	Mon, 24 Aug 2026 17:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787591311;
	bh=ux4JQSzDx3Cp7BCNkxnDpL/Wzj72EmF1F1EUPEj2+tU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QQIOaEZA7ziQnZmMUxIVvYWNYaxLt75XNXGIUGdBjBmoF7/bgbKUr0JguAAkw+sPX
	 DZ5AsMMRyZKeZmtpI7EJ1ml4tHwIqvCnRG/NLuhqLg206pSLnO2cAcL0FtWE1Axg/8
	 f3QgRGpx7MbnI9g+iRGz7x9cxsiziXxvPntgvIAbQcqC/fYL06Co4A35mDOJ6mvZ8V
	 hGYse8QscEwGucMFxMISYfIn86KAy/ZjxSLuLIEXKMnC63WG5m70kbU0YOfHfFUl0u
	 MQH6sACP19F7FToUb/U85F91B+mxWj5aL/YhHyr+0/7/8LdmGQjQi8CXhavMW/16vn
	 226B09pFjbHVg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: arena: reschedule while freeing the arena pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Breno Leitao" <leitao@debian.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824-b4-bpf-arena-free-resched-v1-1-5c447477a64b@debian.org>
References: <20260824-b4-bpf-arena-free-resched-v1-1-5c447477a64b@debian.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 17:08:30 +0000
Message-Id: <20260824170831.33E051F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Calling cond_resched() inside a pte_fn_t callback violates the laz=
y_mmu_mode contract, causing 'scheduling while atomic' bugs and failing to =
resolve softlockups on architectures where lazy MMU mode disables preemptio=
n.
--

--- Patch [1]: [PATCH] bpf: arena: reschedule while freeing the arena pages=
 ---
commit aff4ff38f5c4bf3ce9d58e40df7c294fa156e787
Author: Breno Leitao <leitao@debian.org>

bpf: arena: reschedule while freeing the arena pages

This commit adds a cond_resched() call to the page freeing callback used
when tearing down a BPF arena to prevent softlockups.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> index 7b6847200b431..c5f6bebbb15c3 100644
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -364,6 +364,7 @@ static int existing_page_cb(pte_t *ptep, unsigned lon=
g addr, void *data)
>  	 * the freed page. So it all relies on 1.
>  	 */
>  	__free_page(page);
> +	cond_resched();

[Severity: High]
Does adding cond_resched() here violate the lazy MMU mode contract?

The callback existing_page_cb() is a pte_fn_t called by apply_to_pte_range(=
),
which establishes an atomic context by wrapping the callback loop in
lazy_mmu_mode_enable():

mm/memory.c:apply_to_pte_range() {
...
	lazy_mmu_mode_enable();
	if (fn) {
		do {
			if (create || !pte_none(ptep_get(pte))) {
				err =3D fn(pte, addr, data);
...
}

On architectures like PowerPC64 with hash MMUs, lazy_mmu_mode_enable()
explicitly disables preemption. Since preemption is disabled, cond_resched()
evaluates to a no-op, which means it won't actually yield the CPU and will
fail to resolve the original softlockup.

Additionally, if CONFIG_DEBUG_ATOMIC_SLEEP is enabled, this could trigger a
"sleeping function called from invalid context" bug during teardown.

>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-b4-bpf-are=
na-free-resched-v1-1-5c447477a64b@debian.org?part=3D1
