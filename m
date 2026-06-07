Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D883612F8
	for <bpf@vger.kernel.org>; Sun,  7 Jun 2026 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780819950; cv=none; b=rfBvpRmZBOJXyj88qYy9SRVLOCbnBGWGncKGp0GuayqVmvrrtBB0Msu+NFUxdNSjCrBa11ecOZ8izN9AVjKJtVWfMnoEiRm6VmUMs1Sd3WpFW9WNl+JnyLtWjsCCt8RoHAvokqGR/53i5KJzMvQg18Z+ScSXWWX1MOOx07Igjuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780819950; c=relaxed/simple;
	bh=UE3k+n0biXiRCzjVZnt05USfjcvQoxUFXVsgkxb7aq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rGho0qd9iXvQvFH1krn7sTE0t9QFN7zVmCeK2JgcGGlTSSiVvAb6/o3apV5C0WmhhWQwZa7GPMY1wBynqP1Wa1iCnHDta0GqYwtXAiUZ+wlydCSSDqCf/D60ugqAbb0+7Ykq9HDdPP3cBaMti1itqGIAoSbsuP86MFUDg+0qKCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W34yJ9qc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W34yJ9qc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12BC21F00893;
	Sun,  7 Jun 2026 08:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780819949;
	bh=N3P7zzP1wIDsKGs2pFaYO8oAFuwTEx9XqcYbk6Hhbp0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=W34yJ9qcOoXNGTG7MMjdGVVXoSznJ8Bbg/A2dLceKHiLZSL2wvnXLwNO/SC/vI3/q
	 3K53KH4PIU7t496DEXT2JEYQCq4oThJq6fsAyr9I6OrhvE6bpf2p/KX9WoGNLNTxU9
	 gAwQCfigZa8VbbFXhSOtLruZU21YqF/kulF4bNo11yEHT8CfZpMp2w3ZGQoNog0IAG
	 q9YDtDq42r8V9hFzseU4HPb+gzapxHmQcZ2nGpc+zzR2p/7bL5X61BBtlHDN9O2L46
	 nZw5p7bILuNXIQH35g4/AS3VBFw8k0HRISUw4Jm6Du1xfbvYXjvN+kHI0ekVubN7mI
	 r6XlwIUq4OdZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] arm64: mm: Complete the PTE store in
 ptep_try_set()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tejun Heo" <tj@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <088f52fd25860ca961449d53f91b214a@kernel.org>
References: <088f52fd25860ca961449d53f91b214a@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Jun 2026 08:12:28 +0000
Message-Id: <20260607081229.12BC21F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The patch uses `__set_pte_complete()` in `ptep_try_set()`, which i=
ncorrectly defers architectural PTE barriers if a synchronous BPF fault int=
errupts a lazy MMU block, leading to an infinite page fault livelock.
--

commit 3da2cf1409cd9f964e0879e7b2ee1aaae71958ab
Author: Tejun Heo <tj@kernel.org>

arm64: mm: Complete the PTE store in ptep_try_set()

This commit updates ptep_try_set() to call __set_pte_complete() after
successfully setting a new PTE via try_cmpxchg(). This mirrors the behavior
in __set_pte() to ensure architectural barriers are issued for valid kernel
PTEs on arm64.

Link: https://lore.kernel.org/all/aiRFcz78QTZdIHHB@arm.com/

> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pg=
table.h
> index 984f0502c9d0f..9f5d75e736919 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1838,7 +1838,11 @@ static inline bool ptep_try_set(pte_t *ptep, pte_t=
 new_pte)
>  {
>  	pteval_t old =3D 0;
> =20
> -	return try_cmpxchg(&pte_val(*ptep), &old, pte_val(new_pte));
> +	if (!try_cmpxchg(&pte_val(*ptep), &old, pte_val(new_pte)))
> +		return false;
> +
> +	__set_pte_complete(new_pte);

[Severity: High]
Does calling __set_pte_complete() here risk deferring required architectural
barriers during synchronous BPF arena page faults like
bpf_arena_kernel_fault()?

If a BPF program triggers while the interrupted task is inside a lazy MMU
block (like zap_pte_range()), the kprobe runs as a synchronous debug
exception, so in_interrupt() is false.

__set_pte_complete() delegates to queue_pte_barriers(), which defers the
hardware barriers by setting TIF_LAZY_MMU_PENDING if
is_lazy_mmu_mode_active() returns true. Since in_interrupt() is false,
is_lazy_mmu_mode_active() will evaluate to true.

Because the required dsb is deferred, the fault handler can return without
the memory system observing the new PTE. The CPU then retries the faulting
instruction, which faults again, resulting in an infinite page fault loop.

> +	return true;
>  }
>  #define ptep_try_set ptep_try_set

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/088f52fd25860ca9614=
49d53f91b214a@kernel.org?part=3D1
