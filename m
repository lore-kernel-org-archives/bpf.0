Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE33A16BD
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785219814; cv=none; b=RwrusxxLxB0nfbfBZDG8bjHH01LJLm4tLFwhid8xVSBHRxjsxO3UX30H1MfPYRGea2QTWW/eat2cnde/bKibNqM8a+tTyulsrXHV1KkXMXMtVfM5UfX18iJQynRPHY3j4SaSE56Y1D9amZmb3ajt7tc9REx5x803oIlfdVqKeQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785219814; c=relaxed/simple;
	bh=cU8j8ChTBS1U5s3WutXNWHrllbEaR+4N4/zhRuE4VmM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bdu16eJg6a+LurFirCbRCjbsZEOB2gDptMCHZx2KKGCkH3+2gXFQxe/O57HZzuS3iMRmAU/F7F2bEtAXaZU9BiEaXOrPNvXmr/v4zeUzupUvVE9ZZpRB96viAAYpaNmkmXj7ndBqDvoHol3ruWoEVgd+rdG/iTDBon+UQsNkHpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dW1I79h/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dW1I79h/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 806161F000E9;
	Tue, 28 Jul 2026 06:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785219812;
	bh=kkNwJSyuABI6Vs+sZqLG8qHp+l7SQnLt8FlxQSbCY2E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dW1I79h/9avQW9DI9icesvzGVn39VIReCe9ozqs+GkOPbKLciY13qTaDx7nvu6vSx
	 Hmfr4gD9VEH0aIuOpM7qgqZ45ktVpdT57n7OvkX1qu8GBrfAmoOPUseMO3cWLzVAuM
	 UmSlrafh0CbZWrV7Wg/FMGW2tVvb8g/wYGqEURxc5MyVMsT1EE+m+ra3aXWDHh/M+I
	 whuNo3TrAEUP3Q5jfSwnsPP8JKVoaYlnjAxRFLO2ryVhz3qaUzYsXUP7tDO9BYPv/j
	 QcuxKC55MXdFW89kXzWrzYCtC8E/K0QbVK+4+BZJOnq3AZdQH0dSzhEIqe1Hw0VOYZ
	 W2/tHbYKXiEjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: arena: fix mmap_lock deadlock on arena
 lock failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260728060517.95183-1-jiayuan.chen@linux.dev>
References: <20260728060517.95183-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 06:23:32 +0000
Message-Id: <20260728062332.806161F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] BPF arena page faults can spuriously crash the user process with S=
IGSEGV due to transient lockless allocation failures.
--

--- Patch [1]: [PATCH bpf-next] bpf: arena: fix mmap_lock deadlock on arena=
 lock failure ---
commit c57623f4077e743e8c901306fcec7c67d2aafc17
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf: arena: fix mmap_lock deadlock on arena lock failure

This commit fixes a potential deadlock in the arena page fault handler by
returning VM_FAULT_SIGBUS instead of VM_FAULT_RETRY when the arena spinlock
cannot be acquired. Returning retry would cause the fault path to attempt
retaking the mmap_lock, which was never dropped.

> diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
> --- a/kernel/bpf/arena.c
> +++ b/kernel/bpf/arena.c
> @@ -490,8 +490,12 @@ static vm_fault_t arena_vm_fault(struct vm_fault *vm=
f)
>  	kaddr =3D kbase + (u32)(vmf->address);
> =20
>  	if (raw_res_spin_lock_irqsave(&arena->spinlock, flags))
> -		/* Make a reasonable effort to address impossible case */
> -		return VM_FAULT_RETRY;
> +		/*
> +		 * A failed lock means a possible deadlock was detected. Don't
> +		 * return VM_FAULT_RETRY: this handler never took mmap_lock, but
> +		 * the fault path would re-take it on retry and deadlock. Fail.
> +		 */
> +		return VM_FAULT_SIGBUS;

[Severity: High]
This is a pre-existing issue, but looking further down in arena_vm_fault(),
does a transient allocation failure unexpectedly cause a SIGSEGV?

Since the raw spinlock is held, disabling IRQs, bpf_map_alloc_pages()
falls back to an opportunistic lockless allocation which can fail under
memory pressure:

	ret =3D bpf_map_alloc_pages(map, NUMA_NO_NODE, 1, &page);
	if (ret) {
		range_tree_set(&arena->rt, vmf->pgoff, 1);
		goto out_sigsegv_memcg;
	}

When this lockless allocation fails, the error path jumps to
out_sigsegv_memcg and returns VM_FAULT_SIGSEGV instead of VM_FAULT_OOM or
safely dropping the lock to retry.

Could this cause user processes mapping a BPF arena to experience spurious
crashes during memory contention?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728060517.9518=
3-1-jiayuan.chen@linux.dev?part=3D1
