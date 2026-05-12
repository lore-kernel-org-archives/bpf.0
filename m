Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6742E8B81
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 02:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778551515; cv=none; b=tteHyqSGtn6QHj84cIs9EdcT1k01LE3J41ypJ6sgpdT6LmtcrrnoSiog92a70CHRdgazoq34vejayQ/QRnAkhFto3IfjojLyFVTF1QLa2xNbTjtjt5TX8JyulaAPaLwv36QebdlBKxKJCgDi+r4yFCCmBdDJkJdLRlUeMDLVCos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778551515; c=relaxed/simple;
	bh=UBGLLCMo7yiQ6SX7rkr8NS7qSympvxKDRjTQiWrNbas=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=EGsYFURVNSlx5fco0ayOxHLMW/4TTN1aYUcgWe46fmP6owaQFqtscSz7uWrtD+QTl0luKvrE99nwhPtbKamfi07c1hor/wbEFt90o/3kYEU1keEILu5Jt6v/TLmlX0Fq++rn57yadNYAKbvQ+FUzh9tIi7/OSforZmjw6Eo/O8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=U7OEgS1/; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="U7OEgS1/"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-367c26471f5so2072625a91.1
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 19:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1778551511; x=1779156311; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UBGLLCMo7yiQ6SX7rkr8NS7qSympvxKDRjTQiWrNbas=;
        b=U7OEgS1/usuz+KULylSip+NiZNiQ+IqvkXH0Nqf7Aua8eDfT/O20jnXHwG/WgJ2swN
         a1Xpyx2gR7Fy/PpWdrZ0q1X2epahfYjWoi1al0uPrrmK413pkm9s9MArJr4y3R85Bfk2
         SXfN4GrSvpDN/4FFnIk/GtHs9ulrRarDMxsoJWm1xuLmd8ndFSSFImi+fxbXe8LaQt9f
         CD38oOZkj99Mjr42UbzQx4Zu7/NmVsUeehwO3NuzlB6KbnYfCC8zjTWY9Q2GK9ZUJJ0h
         bVkT6EwUX36Vn9lRaoGpitCgv4/o0U6tM+BCycX3IGodlH0qyWFY92XO7u7+3ljwQRLZ
         uzxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778551511; x=1779156311;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UBGLLCMo7yiQ6SX7rkr8NS7qSympvxKDRjTQiWrNbas=;
        b=O7IPUdeHFHteW1SudOYhRfru443yZOXuna+TOmG/eMBDUs9/CN5oCvK6cLJHMAsL4q
         LtfgvnSJU4BEm4KAzqAjTNbWHEAu3y/nFgQRIE0yLG5PkRferrUIlDZx0j2yId4A2f75
         WAw7qv+PZdZu1CSA3GcGAhhCu0E5EW1k8XkfMg6rzz0W3LyVKJwbHfjJ/6qejjRak9Fe
         GBrl+vNl2LYKbzK41RfuA7IF1ffWw4kSN2VFWqX1SXpmvI+FNz7+fkcFBA+/a1IVyvnl
         p8aW9E7oEimI1nN33KnlfIqcS22lwIOflPLyEYGiAkcirZFCVNIHeScu87cUCriCbs17
         uOPQ==
X-Forwarded-Encrypted: i=1; AFNElJ+h/BmjWFsx0FOVtC7yjnUJWD9hZgYc0ULlrgWhIJkmsq8eorqtrCkCWmlCCgNeSmZYWiI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHvMpsAbu1PFFaRtelp6zIDLuwgo2rTIU03wB716FZttFBKYx7
	FUMUPbR5q1Yig9Nbotu/eDBrzkTfYKoQcu2ij51VcJoNDlBz0cqck3oBDRLHc3HYQOo=
X-Gm-Gg: Acq92OEDD3MMWXVhI10CZPQe+6MYG28lL5YWXB5WDNUeMtWLjSnDJdjIIRwEIYc6Wnt
	0zj38CLYX5KubH6m6iAMxLL4EcvL9tGUpcaQnkHToPrdNkV+M3xIQEw3rkaRQk+ERTPJX4J0ka4
	lHzB+E3NZl0zxAygMgm09+iJWemDaZ2gX9PB3r9+XNerGLGYj8arRl0VCQvOJf7SZzprGVeHlzJ
	IQtcOhHqSLbVdevVMZF934ERHBK5UdMZJIwxH4lRIuTGxeb6dZC7NKBNeKW5nKsLItywDZEM/UH
	3MU+ZVlIqqKqc7XsJqKVSvfXubRMa2vFHz8fA57hiR71laHn444ywEzPddsaXsvtsGTiNp9tSOV
	MnHzf1JVWY5OibMjSfw+pBKKT1bzCqHb8mSM1BunQrrw173TnrNK18YkFqHbvVs8eqEWaVVKUzl
	pmBgdui9zwtyHXoPJDOVMvXyQveg69mIPW0wY=
X-Received: by 2002:a17:90b:2f4e:b0:35f:c46f:2b0 with SMTP id 98e67ed59e1d1-365ac080c4bmr25713690a91.14.1778551510958;
        Mon, 11 May 2026 19:05:10 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368b9afd07csm152067a91.6.2026.05.11.19.05.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 19:05:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 22:05:09 -0400
Message-Id: <DIGBW43UUKDX.1H7FT7A9JDOOT@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Tejun Heo"
 <tj@kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Emil Tsalapatis"
 <emil@etsalapatis.com>, "Eduard Zingerman" <eddyz87@gmail.com>, "Andrii
 Nakryiko" <andrii@kernel.org>, "David Vernet" <void@manifault.com>, "Andrea
 Righi" <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for
 direct kernel access
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260427105109.2554518-1-tj@kernel.org>
 <20260427105109.2554518-3-tj@kernel.org>
 <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>
In-Reply-To: <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>

On Mon May 11, 2026 at 8:31 PM EDT, Kumar Kartikeya Dwivedi wrote:
> On Mon, 27 Apr 2026 at 12:51, Tejun Heo <tj@kernel.org> wrote:
>>
>> bpf_arena's kern_vm range is selectively populated: only allocated pages
>> have PTEs. This catches a narrow class of buggy BPF programs that
>> dereference unmapped arena addresses, but the protection is shallow - wi=
thin
>> the allocated set there are countless ways for a buggy program to corrup=
t
>> arena memory.
>>
>> It does, however, impose cost on the kernel side accesses. A kfunc or
>> struct_ops callback that wants to consume an arena pointer cannot simply
>> load through it; the page may have been freed underneath, so the access =
has
>> to go through copy_from_kernel_nofault(). Out-parameter writes currently
>> have no equivalent.
>>
>> Arena is becoming the primary memory model for BPF programs, and more kf=
unc
>> / struct_ops surfaces will want to read and write arena memory directly.=
 The
>> actual answer for catching arena memory bugs is arena ASAN, which addres=
ses
>> all memory access bugs meaningfully. Given that, it's worth offering an
>> opt-in mode that drops the partial fault protection in exchange for chea=
p
>> direct kernel-side access.
>>
>> Add BPF_F_ARENA_MAP_ALWAYS. Arenas created with this flag allocate a
>> per-arena "garbage" page and pre-populate every PTE in the kern_vm range=
 to
>> point at it. arena_alloc_pages() replaces the garbage PTE with a real pa=
ge;
>> arena_free_pages() restores the garbage PTE instead of clearing.
>> arena_vm_fault() ignores the garbage page so user-side fault semantics a=
re
>> unchanged.
>>
>> Stores into garbage-backed addresses are silently absorbed; loads return
>> indeterminate bytes. Userspace mappings are unaffected. The flag is opt-=
in -
>> arenas without it behave exactly as before.
>>
>> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> Signed-off-by: Tejun Heo <tj@kernel.org>
>> ---
>
> If we go down this route, we should probably make this flag the
> default behavior. Otherwise, we cannot universally enable passing
> arena memory into kfuncs. Every subsystem will have to check the flag,
> we'll have to gate being able to pass memory based on the flag's
> presence, etc., which just adds complexity everywhere. It will
> eliminate a few patches in this set too. From the programmer's
> perspective, program behavior isn't changing much, so we can use
> zeroed page (to guarantee faulting loads return 0) instead of setting
> the PTE to NULL. While at it we should drop
> bpf_prog_report_arena_violation, and its various users.
>
> Summarizing past discussions on all this, with more details on various
> pros/cons:
>
> Currently, the semantics for a fault dictate that the program simply
> continues, and the destination register becomes 0. One could argue the
> ideal form should have been to abort the program on fault, but that
> wasn't possible at the time of implementation. We added fault
> reporting to the program's streams to improve debuggability. Now since
> we have an ASAN implementation, you can likely run that to catch
> memory safety problems. An argument against this is that it doesn't
> help surface a class of issues for production programs. We don't have
> data on whether stray faults or memory corruption within present pages
> is the more common occurrence of bugs in the small set of programs
> using arenas, so it hard to pass any clear judgement. One thing we do
> lose is faults on NULL-derefs, which are likely common, but Emil had
> some ideas on that.
>
> Another thing we lose is the ability to build something like GWP-Asan
> [0] that we can run in production programs without paying much of the
> performance cost by sampling allocations we want to detect bugs for.
> But between ASAN and Rust-BPF plans, I am not sure how compelling it
> will be going forward. So while it's sort of sad to lose the ability
> to fault feedback, it is also non-trivial to enable direct access to
> arena memory for the kernel while preserving faults (I won't go into
> the details here) without using fault-safe memcpy to move data from/to
> arena on the kernel side.

I completely agree with the discussion points, though imo we do not=20
need to make this flag the default if we support it. The complexity is
mostly checking whether a kfunc that takes arena arguments accepts the
burden of validating them, or if it depends on the new flag to prevent
faults. Any new kfuncs should have clear semantics on that, and we can
validate proper behavior with selftests.

Whatever we choose, I am strongly in favor of keeping some kind of error
reporting when touching the first page in the arena. This has been by
far the biggest indicator of bugs, and if we only keep ASAN then we lose
our strongest signal for most use cases. This is made even worse by the
fact the new flag is incompatible with GWP-Asan, making it too costly to
run sanitization at scale.

For the flag, the solution would be to move reserving the low addresses
of arenas from libarena to the arena itself. The arena would have a low
watermark below which it would retain the existing faulting behavior.
The kfunc would bounds check check the arguments to ensure they're not
below the low watermark, and fail if they are.

It's not ideal - it adds the burden of bounds checking into the
kfunc - but it's reasonable that arena-related kfuncs should take into
account the arena's semantics.

>
> [0]: https://llvm.org/docs/GwpAsan.html
>
>> [...]

