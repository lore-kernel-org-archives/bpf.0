Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34604B7A2B;
	Fri, 18 Sep 2026 10:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789727337; cv=none; b=naKJha2jE65zMnQ/6jucpIH+t48aL7hc/Y1J1hYOSaO6kiaX60tzzzO+zyntFlfbXpCZd7Diu43S2jdf7fPeXQm5v4+SAnwjn8PYd9EgWHyMKeto+lBKfBD/txuFYkXSsJTacsQZHt0QzPcCNUIolVIbRCtjBsCZI0GQVHONQoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789727337; c=relaxed/simple;
	bh=q0Bh07F9jPbv89LLGHtsDICHemkDDuSZfld/qkcLE+Y=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=dE+MvBy3t4QidB2lWNnQZxBUF+dFBSXBlcLZ5yilDfcZXMeU2BBgPBRuIgrSX15225tgjpdl/cWoNyb3hpH3g0+W6fLZLM7WFfmXXI1dJJvbqTPs7aiU3DmwatFeC5lZflCvAZSsE2RSX/arDQCNAQZin825I3QVhBN1lAhloaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kVN2iJOx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kVN2iJOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4961F000FF;
	Fri, 18 Sep 2026 10:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789727335;
	bh=vaQy4DHOEvSSGCoiivtyuq63dL3zsfByVWaSOQyZ5SY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=kVN2iJOxME0ArWA0m2KaCIhGbR2tof6TagwNQkGM6xUIPfzAqIc2ng14oIs4Kvmha
	 kBLZRQaS6nuqf1BO+ngRdhok+hp2Z+pB4q5M2utrvXenq2UfTN8uYyvCl3RRsL7QGX
	 y5EmdBPEBIpP+cyncEvQGw1h9DQy+kKOTuJbTkhf1zn25bP1cJOK6sOpWx5Q7fbWYP
	 c+uWvewAi3w5WxExbECu3ErP6sGpqbOjyGEBZaWUFFcse1xX7di7MAlXnYmaDi2KRs
	 VXTFTuy89ARbOnA8XN0st0Ndh80FmeKZHQfyceaPFtqKuLrij7O0uhgscIbgv5kMDc
	 /C2nJpnLo2a8Q==
Content-Type: multipart/mixed; boundary="===============5432951590939359719=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <cbc55fa2453eb1d899a7c594f68dd48bac28253e2cc977d828f8143303848158@mail.kernel.org>
In-Reply-To: <20260918091058.297740-2-tasos.papagiannnis@gmail.com>
References: <20260918091058.297740-2-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next v8 1/5] mm: Add copy_remote_mm_str()
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,david@kernel.org,akpm@linux-foundation.org,andrii@kernel.org,ast@kernel.org,brauner@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kpsingh@kernel.org,ljs@kernel.org,matt@bobrowski.net,memxor@gmail.com,song@kernel.org,sun.jian.kdev@gmail.com,utilityemal77@gmail.com,viro@zeniv.linux.org.uk,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 10:28:54 +0000 (UTC)

--===============5432951590939359719==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index dd09c438fa23e..63f40e615754d 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h

[ ... ]

> diff --git a/mm/internal.h b/mm/internal.h
> index 38b1165212c94..557b293813557 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -25,6 +25,9 @@
>  struct folio_batch;
>  struct hstate;
>
> +int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +			 void *buf, int len, unsigned int gup_flags);
> +

__copy_remote_mm_str() goes from 'static' to an mm-wide helper, but its
'len >= 1' precondition is left undocumented and is now enforced in a
different translation unit from the implementations.

Both implementations begin by writing to the buffer unconditionally,
before any length check:

mm/memory.c:__copy_remote_mm_str() {
    void *old_buf = buf;
    int err = 0;

    if (mmap_read_lock_killable(mm))
	    return -EINTR;

    *(char *)buf = '\0';
    ...
}

mm/nommu.c:__copy_remote_mm_str() {
    unsigned long addr_end;
    struct vm_area_struct *vma;
    int ret = 0;

    if (mmap_read_lock_killable(mm))
	    return -EINTR;

    *(char *)buf = '\0';
    ...
}

Neither ever tests 'len == 0'. The guard lives only in the two wrappers,
in a third file (mm/util.c), so calling __copy_remote_mm_str() with
len == 0 writes one byte past the end of a zero-length buffer.

Before the patch this was structurally impossible: __copy_remote_vm_str()
was 'static' in mm/memory.c and mm/nommu.c and its single caller was the
copy_remote_vm_str() immediately below it in the same file, so the guard
and the unguarded write could not drift apart. Now any file in mm/ that
includes internal.h can call it, and the declaration carries no comment
about the contract.

Should either the 'len must be >= 1' requirement be documented at the
mm/internal.h declaration, or should the 'if (unlikely(len == 0))
return 0;' test be moved into __copy_remote_mm_str() so the guard sits
with the write it protects?


> diff --git a/mm/memory.c b/mm/memory.c
> index 8b0c2c735d3de..fc6933d7e9d36 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c

[ ... ]

> diff --git a/mm/nommu.c b/mm/nommu.c
> index 498e01ee40b05..9a810c35e7e90 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -1741,13 +1741,12 @@ int access_process_vm(struct task_struct *tsk, unsigned long addr, void *buf, in
>  }
>  EXPORT_SYMBOL_GPL(access_process_vm);
>
> -#ifdef CONFIG_BPF_SYSCALL
>  /*
>   * Copy a string from another process's address space as given in mm.
>   * If there is any error return -EFAULT.
>   */
> -static int __copy_remote_vm_str(struct mm_struct *mm, unsigned long addr,
> -				void *buf, int len)
> +int __copy_remote_mm_str(struct mm_struct *mm, unsigned long addr,
> +			 void *buf, int len, unsigned int gup_flags)
>  {

The NOMMU implementation gains an 'unsigned int gup_flags' parameter that
it never references, and at the same time the patch deletes the only
documentation that said so.

The pre-patch NOMMU kernel-doc read:

 * @gup_flags:  flags modifying lookup behaviour (unused)

The replacement is a single shared kernel-doc in mm/util.c, compiled for
both MMU and NOMMU:

mm/util.c:copy_remote_mm_str():
 * @gup_flags:  flags modifying lookup behaviour

mm/util.c:copy_remote_vm_str():
 * @gup_flags:  flags modifying lookup behaviour

The '(unused)' caveat is gone from both blocks.

The full NOMMU body makes no use of the argument - it goes from
find_vma()/check_add_overflow() to 'ret = strscpy(buf, (char *)addr, len)'
with no reference to gup_flags.

Should the kernel-doc in mm/util.c note that the flags are ignored on
!CONFIG_MMU, or should the '(unused)' comment be restored somewhere in
the NOMMU code itself?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35330379263
--===============5432951590939359719==--
