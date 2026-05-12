Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B6921CC51
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 00:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545951; cv=pass; b=ltmgx/WyQDNZHkd26dNDDftye6ydBUYrXXIKyLkG0Z5dCctGMhTEzbMDf4EryLDnUl9b/RsdzFsZhhDQRF2a1c3ua+MThSl8T3qEA0ke6kA0FZypXZxIOPcnlHwUIwt1A6fFbCCe6pikAnGcLX1wOCqJ6r5JNnpwv5aBGlBRPdU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545951; c=relaxed/simple;
	bh=DLipxZvxsoUVWde4JunXu3jCwr9EfsRTFS5dQlBwn7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WNlfe9Jb75NltQ70rkfVp3XalrKz/a6zVTyJUwWcUbsXxDGIQfngHqrH34t7GFgGhVlXGDliyvhKdV2bzka8BztpI1QYEF4S4U5QFLJvuLCcDU5/rtAWsoHjESwiU0j2EkdoEsA9RWPbTwD+kBzOVuKkKH6LfFBrLAaCX35UzgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=heKCJL6+; arc=pass smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="heKCJL6+"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-48374014a77so45641295e9.3
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 17:32:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778545948; cv=none;
        d=google.com; s=arc-20240605;
        b=NBwzKvAcYxFk4Pm0rpugvC4IfR1NangD3duMOTZNqiqyZKOeXakFqBm7/I6xFP5iGI
         jR6j36UuryZ6Vcf9KVkPDCZV4coei8JgFCSHrr/wnOmZR0EMOXSyHrEo83dBlcMSLzNw
         DUr26s/znMOv410H5beMidYdyLi2qNeHr9izT6yu6apgSso4gHxh2+UoDovlgpQUDAkT
         3dHRjuTNmaqemwX6Q7aI1CFJ0BDDL90AOmTlbhwUfZBTSn4v1zQey+bqnEmggju0Ouu/
         HxOyYfu9NpvC+xECgxKNS7im1J79GpjhKYvRVMycH5d+EnX/AM15PGiF/gee+cs7S9QW
         r5hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DLipxZvxsoUVWde4JunXu3jCwr9EfsRTFS5dQlBwn7s=;
        fh=RTiv6w/2boCFmmQl6yElW1e6UebNM1lEC5UKCj+Ni4Y=;
        b=EtMoW2jE1oGvwaljqkF1gvJfSegTHHDu3txiDGsXv+qM5gsDJtegJEaeUBqkITEfNG
         b9+UVFKAWEGccri3vhU5BJfl2Ap5A40PjFQ7OrLZLVA2hO6mY4kcXC6z7s2uhpsTvbSN
         Y5lU8xKw0NLbMwMGHu9SxglGIYWosevikiDIk/HF1kmg5pB3c6j5/Y9zUpjA5Zzndhwe
         /5OQCgJ6LhAs0h52BA4vS8pnTDugcajvPqgvzDCXsPBC6n/2/K7X1MPRYFjavn/An86U
         Vb07cc78QKT54bOKTyxao/rWjlLOq+SHBkjivdmLZ4r1c4C7TEmHQJtgmbUpghrJrTqs
         mB7Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778545948; x=1779150748; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DLipxZvxsoUVWde4JunXu3jCwr9EfsRTFS5dQlBwn7s=;
        b=heKCJL6+AIy6gEZ6clFFzbciyYiFFvv4lKzk5Evz+OX8RlFRQ40RfhVM4XsJ0d+YOO
         u6VwcRZjTpBM5rkRYSlzZnVB3rTv2WzRy4APO4xykTPrJjjVkXaaBshuVyVZGFh5RFDw
         UPKPfe2SXUg5kL3Kg9BmZR/0p/d1whgOxnMAiHj2xCbYsjueyA0UIZW3ofVV7Quz3oVL
         Wi+7Qfcqf48UQtPOLiM+99OAMXWrfVGG3XFNsg1Q1o7XblcBnvT/AFXxRl8057FRq5+N
         6PolhV22+uwlU8a7nk1y4a+UNFUNooDH/pUZMctjimeFbnJ4R0AVk+NyCyXX419SX1vd
         YQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778545948; x=1779150748;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DLipxZvxsoUVWde4JunXu3jCwr9EfsRTFS5dQlBwn7s=;
        b=kls4fzL8xZDqCgMR662gU4ZTdPSqorSJ5ajmV18nwCfvJpe+zfCDmtZTPvAB8XhTdZ
         wzYsxwU7bAx3VUhEmPE1EIi+xijjF3CFn23mp9LUXaYbwXkVyEIxMdayQL5zBpX3IXA9
         RO1DhLRn5lGLJTvZBD1eutEY5KaQLIFZg33fSkjo4j9KayLU6O0PNPrEPwxJNU8QWoiR
         FJw1iwzymesE2mHfLZmqdHBm7fTofN5+EjJWGgD6axUBfO0KCer2/M/1bW/VD9+jDnBq
         Qw/lCuD0fW2eR4thALYKTIE7eH49lSnsAXK4TUOD6dyy0RTEQ0zeZr385UmPmzrb20Vi
         QzKg==
X-Forwarded-Encrypted: i=1; AFNElJ8JENqYSoQo5U6uh00UzAvImKe1McnzStMZ6Y3BQN2pj7FWh7BnsW31xf6ic9TV58L7DNI=@vger.kernel.org
X-Gm-Message-State: AOJu0YztrTruA9I+/gQkpT/poXwtKu7yiLOWwCVQInh9JJ/+I3NigSu/
	9k0FrVInE3QJUJYKis5g3pUvoAcFWk4uxkfDicc/L7e8rh8+51WM2RJNyP/ayYYcWKvx/Xivnx4
	KvCPvrxY8+jbcTCCl4WpEXlYTPP4dvxM=
X-Gm-Gg: Acq92OEQffEjDgaCHXao8/SUzPT99BSzd0sajrUzLCK7en68ConA+Pb/XQzjvb8+/Z/
	ccLlHww6aK0m4hi39vHVVboN+pC91VVP7Rb7tCrx07pCjD1qOY15UUOGKtgdksCSpW7Y754aZgG
	L0UpyaEG3qfBkjQrymjdJ2wwzqwzECPL3e9X8Y+cuhIq4NA+OCP3X7WqaF5J8zBHY5EVKsUU/e5
	VZ+skSjUYb7RvRGoe6YU4WaUz5izBJEvcL64qxEHSUR1y8Tb5bDa3C6fnyTnHOOeEibimUpsxmd
	yeE7lOBOmEg0Pkk5DaSkavHVSaVjBLJMZtlb2YHjQdJB8OOgvZyDY4Xiz6AXctJEUWMC/mSYXNO
	DYBC/2WO1rcOF+QdUDMib2awGpoleBD/9dhHGhtyBXUCJKBu/R2ht7uHkkw==
X-Received: by 2002:a05:6000:2386:b0:43c:ef4f:79dc with SMTP id
 ffacd0b85a97d-456969c3922mr16875069f8f.8.1778545947757; Mon, 11 May 2026
 17:32:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427105109.2554518-1-tj@kernel.org> <20260427105109.2554518-3-tj@kernel.org>
In-Reply-To: <20260427105109.2554518-3-tj@kernel.org>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 12 May 2026 02:31:51 +0200
X-Gm-Features: AVHnY4IN6SRbhkgvisYjF50cU7eRw3WpE3dVeN6f3nAoVL9QPK8GJxHjvocBCDQ
Message-ID: <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for direct
 kernel access
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, David Vernet <void@manifault.com>, 
	Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>, bpf@vger.kernel.org, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Apr 2026 at 12:51, Tejun Heo <tj@kernel.org> wrote:
>
> bpf_arena's kern_vm range is selectively populated: only allocated pages
> have PTEs. This catches a narrow class of buggy BPF programs that
> dereference unmapped arena addresses, but the protection is shallow - within
> the allocated set there are countless ways for a buggy program to corrupt
> arena memory.
>
> It does, however, impose cost on the kernel side accesses. A kfunc or
> struct_ops callback that wants to consume an arena pointer cannot simply
> load through it; the page may have been freed underneath, so the access has
> to go through copy_from_kernel_nofault(). Out-parameter writes currently
> have no equivalent.
>
> Arena is becoming the primary memory model for BPF programs, and more kfunc
> / struct_ops surfaces will want to read and write arena memory directly. The
> actual answer for catching arena memory bugs is arena ASAN, which addresses
> all memory access bugs meaningfully. Given that, it's worth offering an
> opt-in mode that drops the partial fault protection in exchange for cheap
> direct kernel-side access.
>
> Add BPF_F_ARENA_MAP_ALWAYS. Arenas created with this flag allocate a
> per-arena "garbage" page and pre-populate every PTE in the kern_vm range to
> point at it. arena_alloc_pages() replaces the garbage PTE with a real page;
> arena_free_pages() restores the garbage PTE instead of clearing.
> arena_vm_fault() ignores the garbage page so user-side fault semantics are
> unchanged.
>
> Stores into garbage-backed addresses are silently absorbed; loads return
> indeterminate bytes. Userspace mappings are unaffected. The flag is opt-in -
> arenas without it behave exactly as before.
>
> Suggested-by: Alexei Starovoitov <ast@kernel.org>
> Signed-off-by: Tejun Heo <tj@kernel.org>
> ---

If we go down this route, we should probably make this flag the
default behavior. Otherwise, we cannot universally enable passing
arena memory into kfuncs. Every subsystem will have to check the flag,
we'll have to gate being able to pass memory based on the flag's
presence, etc., which just adds complexity everywhere. It will
eliminate a few patches in this set too. From the programmer's
perspective, program behavior isn't changing much, so we can use
zeroed page (to guarantee faulting loads return 0) instead of setting
the PTE to NULL. While at it we should drop
bpf_prog_report_arena_violation, and its various users.

Summarizing past discussions on all this, with more details on various
pros/cons:

Currently, the semantics for a fault dictate that the program simply
continues, and the destination register becomes 0. One could argue the
ideal form should have been to abort the program on fault, but that
wasn't possible at the time of implementation. We added fault
reporting to the program's streams to improve debuggability. Now since
we have an ASAN implementation, you can likely run that to catch
memory safety problems. An argument against this is that it doesn't
help surface a class of issues for production programs. We don't have
data on whether stray faults or memory corruption within present pages
is the more common occurrence of bugs in the small set of programs
using arenas, so it hard to pass any clear judgement. One thing we do
lose is faults on NULL-derefs, which are likely common, but Emil had
some ideas on that.

Another thing we lose is the ability to build something like GWP-Asan
[0] that we can run in production programs without paying much of the
performance cost by sampling allocations we want to detect bugs for.
But between ASAN and Rust-BPF plans, I am not sure how compelling it
will be going forward. So while it's sort of sad to lose the ability
to fault feedback, it is also non-trivial to enable direct access to
arena memory for the kernel while preserving faults (I won't go into
the details here) without using fault-safe memcpy to move data from/to
arena on the kernel side.

[0]: https://llvm.org/docs/GwpAsan.html

> [...]
