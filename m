Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7183B371068
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 02:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778553860; cv=pass; b=X1r6VvKpwkD4/AdMSQUWLb0fX1RHFF2JsJiM1/YSUU2CSPyyKuKf+BZ6U37RrvgwPraI8rJXC1Enugb11qYMyMwWXhg8ciI98CyPcD6oYwozbPJyTHzg5QtG2zBI6DgxUXnePEG+kCbn89CTkQ/8Dh/ctpWmmkBVUe+FnxedRdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778553860; c=relaxed/simple;
	bh=b9zLwgQOpkKcamLtiDDaoswAhjVuywCuDT+EeOJH+A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxYE9tBkWlTx7GE/THBwr6TIO5T52JwfwWdpqW625Grc8YTjOHkvAtrEgfAyacwvX+TiAyKRpRbhm7HAm9QSE4D68Jq7EpXrdZQX4IGkCPuQq0UVtzxcvziUn4aQ7/oO2ONG0JfnXiFzkxGt0rRg1hfOtyQ3iGOY56YZTUYb/Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8LX66wx; arc=pass smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8LX66wx"
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-48a3e9862f0so33199835e9.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 19:44:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778553857; cv=none;
        d=google.com; s=arc-20240605;
        b=cy1nCOniDRXmgNDiditvf/kidLxt63ovXNDWn5hla5oZ4ukQIMVPDmPCHOM9/X+9Tj
         kxjFh+IJpIkIHOeNjJ4oPx+aEAXzzC+rdwa76YczsgQDyZZ9FEvr6bZKpL9tbKDJcYE4
         e1uAS2Z5sEarIgWLMXI0LGbI/yuXtvkyUkLPElaBz3Xkvs8GDadhMxzfGazYbB3cHTZM
         AGByJoHxG3OCdskXetZEkvghxxgnssrprEMOjqJgOwRfRIMP6w4N380WRr+ZQNsdZikN
         zKomIRc4+T0ybqyUbl6inawwmSPFpciLg3pvyllsUu5P2ifRD8B3tFVBU+t9V3RG2WQ1
         qXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=b9zLwgQOpkKcamLtiDDaoswAhjVuywCuDT+EeOJH+A8=;
        fh=Q0RnZr+GSWMr6JdaJJ2DEJjO+uR0XG9CL8ryJkSCjD8=;
        b=abiafCxz4ZYQoX2hzajA9CF6yVG49MTt/Q6gt2C9qgQusBdOu86Heu1FWhpynn6Whm
         jBh7yl76VPPxwYnAF2lDZ44ZqwjWvCc9fVM7nAUEfyDLB/zP+wCu12o+aFpTZAdsUOuQ
         HkmSUDBjTfFqS1i0QyPbxa3lvoaoE89VCAy6Sxq7zBcMn/ksq0wIJjyQlxelCmuqabpd
         Vn/mYX0h11C6KDQoIZ/ce3tWvZhEm9Fid3c9Hcg+ZT+z4cXDRN0+DHMReBySLOBFkyDn
         ag3mpaDdal5+BO3Fm6sqAdpxHKDgJLFlMDIuLka32EkTf9P8x2sQL9IUZc89fRm6U+z8
         skAQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778553857; x=1779158657; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b9zLwgQOpkKcamLtiDDaoswAhjVuywCuDT+EeOJH+A8=;
        b=f8LX66wxormSqxG80rXPDb/sIbcbKJJAZlM9J8RSE4yGiLWVzvWKnrjdOL6hjw0XJN
         yXC54tGyjCzpiJFVw/lPH16X4uu8yBx96TycCO4FBatcoFQcLoumi3PQE5xlPtujFydE
         0b1oska+CzY7IOkZsGUoBOrE59EJVvfV0s7qIx3ce5XP85oYYsnFZV9gaQywuun50iab
         ENm9ZcSFDGGV2ROXEGFOP2j9m4vyFljoeWgKkq73kXY4Ip8FKvf7JX9aOzCgPEG8a1YF
         I6yJPvJUpCEnThoXKGmCHhcJLqDAsjBFk10JX5J9b8bCI5aXy2wu58+V3I0PCNVFXyF6
         qUeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778553857; x=1779158657;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9zLwgQOpkKcamLtiDDaoswAhjVuywCuDT+EeOJH+A8=;
        b=H/TbR4YjjMIjJkII67lwKxX4KGAkCg45h9Vfq20j5mvN11f57g2Aj5DXvTQVzzQdqm
         wy//DmhV8lZw74gfeAVKbpA5xyjNH17zhGPyfE9Bqv1Mkb4XTQ9lNJ6NFTq1fm3WrxGg
         SW96u/J6HKsSyfhzpQCu0nixWySIxOHcNiWHD+DkSG0Q87RKgPpnms5+j8w/MjxJ4OOi
         IS6I34q63ZXsPeaCnN8ALpvN2rjFAcqZw491EjHuaKax8/85KTkoBXHjDde/4OT1zeGq
         w6H1l/09RPfn5/ROQ63dTxB0bY6Ahx+3RK9Z1hPhtmNjxwW+GzOWGN/8I7w3vyIl/kxL
         8Y/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8llZrGVdiDzmZMYe9rUE7Mr+L5BIyMk8AdBdf4INgm9QTCPy5Ykp1QX256FgbRjMAqq74=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBgwSY3t8hDWcoM6FXfNVoplgIU4jlRS172DtwPmMRlJmy+UPa
	rzDiELCBgX9RE3q0CE2FYWJdSJCCcXcrvtHvPphhUJOW232FxYjyX4rzbYL+SAJOmM4ilkQl95e
	c3Ehx3sNTfkK865YwylXecHMIkx0wl10=
X-Gm-Gg: Acq92OH5OScWzqxPbMSq8uS9srFy4RwwCiwQhTptt/Hc+aFZuIDOpnqV3v6v9rYm7sm
	d3NRcKe4w/Kv7OFkvsGEDyi9bFkNQZetIp23yIh/EjIOKDpCl6z+Ldis9wM0HReYpB58ifsrK8V
	SlaYSC7AE55xJVnuf2ytMeNnug/tp8j/bX0kjyCS2fDceNME6p3p6VaMaztTXiBj0qtrrlKa4mg
	36KyyYxWPKmmNZJ7VKr0VmEpKKT5UWy8aEWt15NhiAOjZXmsJ5ZrQJOGVCrCjulrc6u74rb4DbZ
	PK3NvFn1QhiWQ7/yUaN4i5oAw7vU+uaY8NKP6bZd7BhPm5cv33xWzN/W2GFnrFzMuVw9QA3xAxe
	bXl3Es/hO5eZ7BN5m6f8RWSOq5496RMd2Wn3zk+VJOnmRWaPSfJzcYLCb
X-Received: by 2002:a05:600c:5813:b0:48e:6be6:168d with SMTP id
 5b1f17b1804b1-48e8e1f63a7mr19322365e9.8.1778553856750; Mon, 11 May 2026
 19:44:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427105109.2554518-1-tj@kernel.org> <20260427105109.2554518-3-tj@kernel.org>
 <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com> <DIGBW43UUKDX.1H7FT7A9JDOOT@etsalapatis.com>
In-Reply-To: <DIGBW43UUKDX.1H7FT7A9JDOOT@etsalapatis.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 12 May 2026 04:43:40 +0200
X-Gm-Features: AVHnY4LJUDHYlnNKv9mHKnF1ipPaCXJ6GrMIFsXa4Ijx1zB9GdxmVXUsdbTDwgQ
Message-ID: <CAP01T77_Lgfj8yX6JtErGES9icebqygDUZT-wzXq9UV6JGugYA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for direct
 kernel access
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, 
	Changwoo Min <changwoo@igalia.com>, bpf@vger.kernel.org, sched-ext@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 May 2026 at 04:05, Emil Tsalapatis <emil@etsalapatis.com> wrote:
>
> On Mon May 11, 2026 at 8:31 PM EDT, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 27 Apr 2026 at 12:51, Tejun Heo <tj@kernel.org> wrote:
> >>
> >> bpf_arena's kern_vm range is selectively populated: only allocated pages
> >> have PTEs. This catches a narrow class of buggy BPF programs that
> >> dereference unmapped arena addresses, but the protection is shallow - within
> >> the allocated set there are countless ways for a buggy program to corrupt
> >> arena memory.
> >>
> >> It does, however, impose cost on the kernel side accesses. A kfunc or
> >> struct_ops callback that wants to consume an arena pointer cannot simply
> >> load through it; the page may have been freed underneath, so the access has
> >> to go through copy_from_kernel_nofault(). Out-parameter writes currently
> >> have no equivalent.
> >>
> >> Arena is becoming the primary memory model for BPF programs, and more kfunc
> >> / struct_ops surfaces will want to read and write arena memory directly. The
> >> actual answer for catching arena memory bugs is arena ASAN, which addresses
> >> all memory access bugs meaningfully. Given that, it's worth offering an
> >> opt-in mode that drops the partial fault protection in exchange for cheap
> >> direct kernel-side access.
> >>
> >> Add BPF_F_ARENA_MAP_ALWAYS. Arenas created with this flag allocate a
> >> per-arena "garbage" page and pre-populate every PTE in the kern_vm range to
> >> point at it. arena_alloc_pages() replaces the garbage PTE with a real page;
> >> arena_free_pages() restores the garbage PTE instead of clearing.
> >> arena_vm_fault() ignores the garbage page so user-side fault semantics are
> >> unchanged.
> >>
> >> Stores into garbage-backed addresses are silently absorbed; loads return
> >> indeterminate bytes. Userspace mappings are unaffected. The flag is opt-in -
> >> arenas without it behave exactly as before.
> >>
> >> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> >> Signed-off-by: Tejun Heo <tj@kernel.org>
> >> ---
> >
> > If we go down this route, we should probably make this flag the
> > default behavior. Otherwise, we cannot universally enable passing
> > arena memory into kfuncs. Every subsystem will have to check the flag,
> > we'll have to gate being able to pass memory based on the flag's
> > presence, etc., which just adds complexity everywhere. It will
> > eliminate a few patches in this set too. From the programmer's
> > perspective, program behavior isn't changing much, so we can use
> > zeroed page (to guarantee faulting loads return 0) instead of setting
> > the PTE to NULL. While at it we should drop
> > bpf_prog_report_arena_violation, and its various users.
> >
> > Summarizing past discussions on all this, with more details on various
> > pros/cons:
> >
> > Currently, the semantics for a fault dictate that the program simply
> > continues, and the destination register becomes 0. One could argue the
> > ideal form should have been to abort the program on fault, but that
> > wasn't possible at the time of implementation. We added fault
> > reporting to the program's streams to improve debuggability. Now since
> > we have an ASAN implementation, you can likely run that to catch
> > memory safety problems. An argument against this is that it doesn't
> > help surface a class of issues for production programs. We don't have
> > data on whether stray faults or memory corruption within present pages
> > is the more common occurrence of bugs in the small set of programs
> > using arenas, so it hard to pass any clear judgement. One thing we do
> > lose is faults on NULL-derefs, which are likely common, but Emil had
> > some ideas on that.
> >
> > Another thing we lose is the ability to build something like GWP-Asan
> > [0] that we can run in production programs without paying much of the
> > performance cost by sampling allocations we want to detect bugs for.
> > But between ASAN and Rust-BPF plans, I am not sure how compelling it
> > will be going forward. So while it's sort of sad to lose the ability
> > to fault feedback, it is also non-trivial to enable direct access to
> > arena memory for the kernel while preserving faults (I won't go into
> > the details here) without using fault-safe memcpy to move data from/to
> > arena on the kernel side.
>
> I completely agree with the discussion points, though imo we do not
> need to make this flag the default if we support it. The complexity is
> mostly checking whether a kfunc that takes arena arguments accepts the
> burden of validating them, or if it depends on the new flag to prevent
> faults. Any new kfuncs should have clear semantics on that, and we can
> validate proper behavior with selftests.

The main problem is accessing the arena or arena flags etc. to decide
whether we can read / write the address. It needs to be passed around
or retrieved at runtime from within the kfunc. It also makes it
conditional on the flag, so depending on whether a flag is set my
program will load or not load, since verifier prevents me from passing
arena memory as argument to kfunc. In practice, once sched-ext
requires it for its programs it will defacto be the default since
that's where arenas are used (for now at least). At that point, why
bother with the flag.

>
> Whatever we choose, I am strongly in favor of keeping some kind of error
> reporting when touching the first page in the arena. This has been by
> far the biggest indicator of bugs, and if we only keep ASAN then we lose
> our strongest signal for most use cases. This is made even worse by the
> fact the new flag is incompatible with GWP-Asan, making it too costly to
> run sanitization at scale.
>
> For the flag, the solution would be to move reserving the low addresses
> of arenas from libarena to the arena itself. The arena would have a low
> watermark below which it would retain the existing faulting behavior.
> The kfunc would bounds check check the arguments to ensure they're not
> below the low watermark, and fail if they are.
>
> It's not ideal - it adds the burden of bounds checking into the
> kfunc - but it's reasonable that arena-related kfuncs should take into
> account the arena's semantics.

Another data point to consider is that if we omit this initial
faultable region for catching NULL-derefs, we gain the ability to
allow passing arena memory into any kfunc where memory arguments are
taken, which might be pretty useful. We won't be able to do it if we
have the initial region as faultable since we can't rely on kernel
writes hitting a page without any checks on the memory region. You
must treat arena arguments specially and cannot mix them with other
memory arguments.

The other way to keep the faultable region in the beginning would be
to emit some assertion/runtime check in the verifier and abort the
program if the arena memory being passed into the helper is accessible
for the size parameter used for the helper call, or fix it up to some
page that is likely to be present.

In practice, if most users set the flag then I think you likely lose
the benefit of the default behavior, or cannot rely on it anyway. When
it becomes a dependency for passing arena memory in the kernel to
helpers, most users will blindly set it.

So in the end, it boils down to whether we think retaining faults
(e.g., conditionally for the NULL case) is critical, and whether we
have some convincing evidence for it.

If not, the best course to me seems to be to make the flag behavior
default, and just rely on ASan (and Rust in the future) to prevent any
memory safety issues, and drop the stream based feedback on fault,
etc.

>
> >
> > [0]: https://llvm.org/docs/GwpAsan.html
> >
> >> [...]
>
