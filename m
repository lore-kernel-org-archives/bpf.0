Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7B056E07B;
	Tue,  8 Sep 2026 16:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884338; cv=none; b=CBgHARusUffvMNI6r1e+6eNzvH7pcYwLeRpsyowdC1oh0Wki5hNqDrIUl8t+ljXaKTxcnpFG8cvetdgiCjMnnpadYCkopXDphARBRlASzM4lEkrQ9znfZ6Qkvws5FKkA1txZVhtMlUmxtd6DJD0CC+OM7wryFEnzOjPxzM76Fjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884338; c=relaxed/simple;
	bh=to7lm0KQf9XZAysTN3Z3S+/Vp1iJARUYlP91H0tKhxc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qY1Kp4QYI4SVMXMUCNfk16+SOyXoU0qa2YU3inScIER6RlLa4u2LUHBsPk1M1Be0IHuOyH53gsv+bgp+jr2viH2hcKL6XP82Z0xka1I55Wjfis9PkUlBkVzGR4EGkZObkBq9lc1pwiVrZxnnWDPM93AyOmFFt46X+BP0FcdFvZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M0Di9Fan; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M0Di9Fan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60D071F00A3A;
	Tue,  8 Sep 2026 16:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788884336;
	bh=wVJUfZRIhHanRgHO4bwYsGjNciskUqMKHVOfC/XbW84=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=M0Di9FanjFgZXn5fUF3WVAoQT0IHgGUvttln0zHA3j+SwhvMih8Nxh75ZiqMsH9Kt
	 99UYoLmRxMY6hxL79xlDKjedw6D3hL9Mbeyz4CfL7s1PmO7F5/m8rCnMjjBosAr1EW
	 5yUhBDyOlSBLe6LU9FZ6Go6ORdwgewjjionbkLPbz4aORn07Ac1aEVJuVCNPi0NXZT
	 M4V8COecqUZ+oDJeRRIFZiViBXk0VHY44DvqQOSmdMdj5HZJGWQfvZmOjuqv3K2Xqi
	 dFwlzCQurqkXZ8cx4jnqARFjFCapVaMwtGA1Gq4JpEGUEPcLKDvOTjKGotHvtNW4SS
	 kMjGvvcq4d5Dw==
Content-Type: multipart/mixed; boundary="===============2920598840718806967=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <4ef240a5bea36ff84df9589671367832860795159386a4c8fba546a0fa8b786f@mail.kernel.org>
In-Reply-To: <20260908135302.74963-4-tasos.papagiannnis@gmail.com>
References: <20260908135302.74963-4-tasos.papagiannnis@gmail.com>
Subject: Re: [PATCH bpf-next v6 3/5] bpf: Add user memory access kfuncs for mm_struct
From: bot+bpf-ci@kernel.org
To: tasos.papagiannnis@gmail.com,bpf@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,linux-kernel@vger.kernel.org,linux-mm@kvack.org,david@kernel.org,akpm@linux-foundation.org,andrii@kernel.org,ast@kernel.org,brauner@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,kpsingh@kernel.org,ljs@kernel.org,matt@bobrowski.net,memxor@gmail.com,song@kernel.org,sun.jian.kdev@gmail.com,utilityemal77@gmail.com,viro@zeniv.linux.org.uk,tasos.papagiannnis@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  8 Sep 2026 16:18:55 +0000 (UTC)

--===============2920598840718806967==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index b3cc5c8fc875..3338bebdd86e 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -679,9 +679,44 @@ const struct bpf_func_proto bpf_copy_from_user_proto = {
>  	.arg3_type	= ARG_ANYTHING,
>  };
>
> +static int __bpf_copy_from_user_mm(void *dst, u32 size,
> +				   const void __user *user_ptr,
> +				   struct mm_struct *mm)
> +{
> +	int ret;
> +
> +	ret = access_remote_vm(mm, (unsigned long)user_ptr, dst, size, 0);

Does this drop the address-wrap guard on !CONFIG_MMU builds?

The refactor replaces access_process_vm() with access_remote_vm(). On
CONFIG_MMU these are equivalent, but on !CONFIG_MMU they differ.

The old path through access_process_vm() (mm/nommu.c) includes this guard:

  int access_process_vm(struct task_struct *tsk, unsigned long addr,
                        void *buf, int len, unsigned int gup_flags)
  {
          struct mm_struct *mm;

          if (addr + len < addr)      /* wrap guard */
                  return 0;
          mm = get_task_mm(tsk);
          ...
  }

The new path through access_remote_vm() (mm/nommu.c) has no guard:

  int access_remote_vm(struct mm_struct *mm, unsigned long addr,
                       void *buf, int len, unsigned int gup_flags)
  {
          return __access_remote_vm(mm, addr, buf, len, gup_flags);
  }

In __access_remote_vm, the length clamp uses the same wrapped addition:

  vma = find_vma(mm, addr);
  if (vma) {
          if (addr + len >= vma->vm_end)
                  len = vma->vm_end - addr;   /* skipped when wrapped */
          ...
          copy_from_user_page(vma, NULL, addr, buf, (void *) addr, len);

When addr + len wraps to a small value, the check is false, len stays
unclamped, and copy_from_user_page() (a plain memcpy on nommu) reads past
vma->vm_end and past the end of the address space, causing memory
disclosure or a bus fault.

This affects bpf_copy_from_user_task() (which previously had the guard),
and the two new kfuncs bpf_copy_from_user_mm() and
bpf_copy_from_user_mm_str(), since all three call __bpf_copy_from_user_mm().
The address comes directly from the BPF program with no validation on this
path.

The sibling string helper __bpf_copy_from_user_mm_str() does keep the
check via copy_remote_mm_str(), which calls __copy_remote_mm_str() in
mm/nommu.c and uses check_add_overflow(). Only the non-string path lost
it.

This also contradicts the changelog claim "No behavior change is intended
for the existing task-based interfaces" - on !CONFIG_MMU, the behavior of
bpf_copy_from_user_task() does change (a wrapping address previously
returned 0, now reaches the unclamped read).

> +	if (ret == size)
> +		return 0;
> +
> +	memset(dst, 0, size);
> +	/* Return -EFAULT for partial read */
> +	return ret < 0 ? ret : -EFAULT;
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34245694915
--===============2920598840718806967==--
