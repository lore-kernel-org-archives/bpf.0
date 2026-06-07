Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778D3227B94;
	Sun,  7 Jun 2026 08:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780821531; cv=none; b=e+L52idbjwc291TdcOo/f41SqvXYRmZy08O1dBOsd1PcrVKBelEqH2wTIQmUaY4uxLyw8QX/KVkJC/Brx8tkBfYJzhmzIUFK48XQS/+pE5GY5mOSepsk8T1EvYcQ/jNByUqYBVATKbdj6wOa3YCUG5bmSsmokXIGcpFiU9ilp/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780821531; c=relaxed/simple;
	bh=roQg21H0HWN6RzOxbsWAXLe5T2RYMTmm4Hh7OaNiSCw=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qPS05LDXseS2vebvxLOmxIHJxsBxGEoZP9u263QIApHPsvzYoOBMWno95dEbbZG+k+FsIHCAz+cYkENuwFqVqL6pRtqS9L8DvG4Vx8+XfhTxNonlNd2ydnxQI0pUeM7D8PSaxK17bs5oYD74CgYKNmcbaQfK7vfUV07gxJBsSKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XahCIgSf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XahCIgSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D5F1F00893;
	Sun,  7 Jun 2026 08:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780821530;
	bh=NXFgpgZtmgGyvqSFzwfkAaFL3jpCX7D1eIvkr3SRPGo=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XahCIgSflUlzl9MWnz+cVVrZO791s3shralebfA1ZscwPQBWMV3lOv6iiqKQWv29e
	 PMBtpmj/XvsfZUQ12mz6JHz5MztoQUmNtHwN5fBS9k9un17alPkeTS3alohOG/TgvQ
	 4Z3JL91qpTkvpVykTqVfrd6CyIdEBECULF95rG3CyUhe6CA+MaEival3LEW8TXQrGV
	 +/xUJQFd2p45QrgM6wSB8aRAQunmi/JJtuyzJbv1AkUruuR7x5tOspHr3g2AEh+WIh
	 yiID2mj8DEC1GYMAuR21uvwZSU6f1RJ88QjRmjgKO+Ia8jlYqIMaQ7jala4td/Zsss
	 VqZauw5+EPSgg==
Content-Type: multipart/mixed; boundary="===============0148180687452261602=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <5f68f44310d4878185fd5ebc52d66530b99f174c6d04ab1170dc53cefaa54568@mail.kernel.org>
In-Reply-To: <088f52fd25860ca961449d53f91b214a@kernel.org>
References: <088f52fd25860ca961449d53f91b214a@kernel.org>
Subject: Re: [PATCH bpf-next] arm64: mm: Complete the PTE store in ptep_try_set()
From: bot+bpf-ci@kernel.org
To: tj@kernel.org,catalin.marinas@arm.com,will@kernel.org,ast@kernel.org
Cc: david@kernel.org,arighi@nvidia.com,memxor@gmail.com,akpm@linux-foundation.org,rppt@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,eddyz87@gmail.com,yonghong.song@linux.dev,emil@etsalapatis.com,void@manifault.com,changwoo@igalia.com,linux-arm-kernel@lists.infradead.org,linux-mm@kvack.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Sun,  7 Jun 2026 08:38:49 +0000 (UTC)

--===============0148180687452261602==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 3ce0f2a6cab6..dc8525431273 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -1838,7 +1838,11 @@ static inline bool ptep_try_set(pte_t *ptep, pte_t new_pte)
>  {
>  	pteval_t old = 0;
>
> -	return try_cmpxchg(&pte_val(*ptep), &old, pte_val(new_pte));
> +	if (!try_cmpxchg(&pte_val(*ptep), &old, pte_val(new_pte)))
> +		return false;
> +
> +	__set_pte_complete(new_pte);

An earlier posting of this drew a question on the mailing list about
__set_pte_complete() deferring the barriers in some contexts:

  https://lore.kernel.org/all/20260607081229.12BC21F00893@smtp.kernel.org/

The concern is that __set_pte_complete() delegates to
queue_pte_barriers(), which only sets TIF_LAZY_MMU_PENDING and defers the
dsb when is_lazy_mmu_mode_active() is true.

The scenario raised is a synchronous BPF arena fault (for example via a
kprobe, where in_interrupt() is false) interrupting a task that is inside a
lazy MMU block such as zap_pte_range(). There is_lazy_mmu_mode_active()
would be true, so the dsb is deferred, and the fault handler could return
before the memory system observes the new PTE. The faulting instruction
would then retry and fault again.

Can this path actually loop, or is the deferred barrier guaranteed to be
flushed before the faulting instruction is retried?

Note this deferral mechanism is the same one used by the existing
__set_pte() path that this change deliberately mirrors, and the comment
above came from an automated review rather than a human, so the scenario
has not been confirmed.

> +	return true;
>  }
>  #define ptep_try_set ptep_try_set

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27087148382
--===============0148180687452261602==--
