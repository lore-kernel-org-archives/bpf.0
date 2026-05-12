Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DAE92D7D2E
	for <bpf@vger.kernel.org>; Tue, 12 May 2026 03:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778557379; cv=none; b=UJRvNWUc6sTKY5IkCXuJcz1jA+QQI6qe3azFRcs5ZHszbUufEqCQxdezsZcWE0UChl/vMK+l5E4KXYefkSEp/FqJ5Wc8CH6WxygbWCeP2p/efk6TNRrlf+JSCKUYUOREY7bEVl+S69dY59SCR/LOWI+lfIpPq689dYorjuhzOvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778557379; c=relaxed/simple;
	bh=tlvfNnjfEf7erXWtwODtCCyzXp+PidzbcrAIr6BJS/w=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=IHOmk2rxbXIZebtK22fYRwKmPS8DExjY2Sv/RF92mqxgfxNXEMgoeeozv+BgXeBuZt8+S8nClq6+xMa5tde6WwnWTOftGTjM0re6LhpCGXKnhxEHjcAkD6zmJuhB7U647HGqtMDDhPgzlBjk1DqLnT/euywAJenjScpM/ugsuqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=r66QgZW7; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="r66QgZW7"
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-c798fc1a28cso2241653a12.3
        for <bpf@vger.kernel.org>; Mon, 11 May 2026 20:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1778557377; x=1779162177; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlvfNnjfEf7erXWtwODtCCyzXp+PidzbcrAIr6BJS/w=;
        b=r66QgZW7MGWtXNAcA8RYft0I1Kkg0uyLkVu3iQ8ix5Fgw8coejtdKW85leC8+MjKuy
         aDy7xD4QFKWwF6g8NltANaDObJBiR7WQ3nzCLlzCIZhIyMlBRouxAMzvgg91r0W3NcAl
         Q8dAtsh8VKOncKeaDYRJSrguwv6wTV68GdvbUgN1jpEdSrDW6anTAOeAJKwVkp/J30IJ
         muGmE491ASho8uzg/lS6OjZVeOcUx0lVMivfTv6+78pTPbfP/cuc4TsDY4UCEX5a/tzV
         e1eXrbbyG43oPVVYTQqE50t1q9pj4KL0ANsL+P99g9xZnALTuLBZQVqMgRig2S4DDVdv
         xakg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778557377; x=1779162177;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tlvfNnjfEf7erXWtwODtCCyzXp+PidzbcrAIr6BJS/w=;
        b=BZfb3qpZd6Sehwppo6UyW+q4EJWtV0/P+OJ9yt+iVQUkTf+lug7rB62HaClDPqlESS
         9ToAJuXzzxxbPBwOCLqyVsl2adbfe2pfrqnf3pNGboZI0/vRL0ij1EslpYvnTb2s0Bsy
         hKpOVUIZWvar6V2sH7v4ZJS8X0hCB+9thu+cqDUu9STtXS+pa2aKo+4IzbXnoIh6BDMs
         QUpH/ULh837INEq0ZkfsKZ21gEd3zuUXtPnNQN4RThXlJB/bHSfxpYqmCUhkX7Ki4E7S
         cZDWZaf2UNaLqmGZyLLoeO5UDc+itpnOrZdISCE9J5UsNy0pnnzKgOGGYbdCHPcO475P
         pSuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8yEyImY6Gbm7jWYHgiyfENW7JsVYhelDqUi6z5ZopPdOW0QWvQOHpxvDCKh3VM9AbJ214=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuaykiUTnrVB69cU3GaWi6VrJGPSxE9DyYBwHtMhF54dmU85Iv
	eBkeFL9YasnwGvO4yPpN3wC0pX8bkzNrCMsF9lBmie31qR4xzF3POcpikZkCU9SKPWQ=
X-Gm-Gg: Acq92OHh9/aR1Vy9BImnt/MIdLCJOHEs5PGIbOnoH/eRCsne+v8gnzY7/hSE93MhX6q
	a/vbXZcSkttPtFh759uLGEdeBV6Nn06E87ImxbrX/XYayEWORLy/rvPww/0vm4fTGDU8DdghD+W
	nUj5ySNcA4BPBJQ+KJ8sqBIakHUrt4C4KSr8MzALryGX2i8KyqT0Fnp9Esw6i2HHbgAgqfE+kOf
	49AQ3QTQna4biLY11Cf+Pl6qLZVb3DGE0BrmHimFVYSvjEORTZIzK1U5QSuWhCPd7FLIumNn3TN
	8xQQpcCvCFkn0RN+0QdbbkelwgGLgaifd4sWoNfci7iwYCaPVQs8CJAvWg0pVmc0KM6No1t2zj1
	ow1hGvRH0XkN7ihpI8rm2g7W1Nu6fYQZ+StD0ZWHslDZHniWjXZI9Lkg/K+D6SIKit2rmDX7qdu
	9iaKKm3Hxv/U9JtOOiHh0OgST+
X-Received: by 2002:a05:6a21:e081:b0:3ab:e30:ee9a with SMTP id adf61e73a8af0-3ad96c69768mr1508647637.20.1778557376800;
        Mon, 11 May 2026 20:42:56 -0700 (PDT)
Received: from localhost ([2001:569:58a0:da00:a5c8:c4ce:f7c1:40c1])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c8267727401sm10531073a12.30.2026.05.11.20.42.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2026 20:42:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 11 May 2026 23:42:55 -0400
Message-Id: <DIGDYYV9XL4C.1FAADQDKVOBG3@etsalapatis.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Emil Tsalapatis"
 <emil@etsalapatis.com>
Cc: "Tejun Heo" <tj@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "David Vernet" <void@manifault.com>, "Andrea Righi"
 <arighi@nvidia.com>, "Changwoo Min" <changwoo@igalia.com>,
 <bpf@vger.kernel.org>, <sched-ext@lists.linux.dev>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/9] bpf/arena: Add BPF_F_ARENA_MAP_ALWAYS for
 direct kernel access
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260427105109.2554518-1-tj@kernel.org>
 <20260427105109.2554518-3-tj@kernel.org>
 <CAP01T76jRW0sjkzebSvDKy+AK-fh7hq+0zhDcP7oLGcg_qxOfA@mail.gmail.com>
 <DIGBW43UUKDX.1H7FT7A9JDOOT@etsalapatis.com>
 <CAP01T77_Lgfj8yX6JtErGES9icebqygDUZT-wzXq9UV6JGugYA@mail.gmail.com>
In-Reply-To: <CAP01T77_Lgfj8yX6JtErGES9icebqygDUZT-wzXq9UV6JGugYA@mail.gmail.com>

On Mon May 11, 2026 at 10:43 PM EDT, Kumar Kartikeya Dwivedi wrote:
> On Tue, 12 May 2026 at 04:05, Emil Tsalapatis <emil@etsalapatis.com> wrot=
e:
>>
>> On Mon May 11, 2026 at 8:31 PM EDT, Kumar Kartikeya Dwivedi wrote:
>> > On Mon, 27 Apr 2026 at 12:51, Tejun Heo <tj@kernel.org> wrote:
>> >>
>> >> bpf_arena's kern_vm range is selectively populated: only allocated pa=
ges
>> >> have PTEs. This catches a narrow class of buggy BPF programs that
>> >> dereference unmapped arena addresses, but the protection is shallow -=
 within
>> >> the allocated set there are countless ways for a buggy program to cor=
rupt
>> >> arena memory.
>> >>
>> >> It does, however, impose cost on the kernel side accesses. A kfunc or
>> >> struct_ops callback that wants to consume an arena pointer cannot sim=
ply
>> >> load through it; the page may have been freed underneath, so the acce=
ss has
>> >> to go through copy_from_kernel_nofault(). Out-parameter writes curren=
tly
>> >> have no equivalent.
>> >>
>> >> Arena is becoming the primary memory model for BPF programs, and more=
 kfunc
>> >> / struct_ops surfaces will want to read and write arena memory direct=
ly. The
>> >> actual answer for catching arena memory bugs is arena ASAN, which add=
resses
>> >> all memory access bugs meaningfully. Given that, it's worth offering =
an
>> >> opt-in mode that drops the partial fault protection in exchange for c=
heap
>> >> direct kernel-side access.
>> >>
>> >> Add BPF_F_ARENA_MAP_ALWAYS. Arenas created with this flag allocate a
>> >> per-arena "garbage" page and pre-populate every PTE in the kern_vm ra=
nge to
>> >> point at it. arena_alloc_pages() replaces the garbage PTE with a real=
 page;
>> >> arena_free_pages() restores the garbage PTE instead of clearing.
>> >> arena_vm_fault() ignores the garbage page so user-side fault semantic=
s are
>> >> unchanged.
>> >>
>> >> Stores into garbage-backed addresses are silently absorbed; loads ret=
urn
>> >> indeterminate bytes. Userspace mappings are unaffected. The flag is o=
pt-in -
>> >> arenas without it behave exactly as before.
>> >>
>> >> Suggested-by: Alexei Starovoitov <ast@kernel.org>
>> >> Signed-off-by: Tejun Heo <tj@kernel.org>
>> >> ---
>> >
>> > If we go down this route, we should probably make this flag the
>> > default behavior. Otherwise, we cannot universally enable passing
>> > arena memory into kfuncs. Every subsystem will have to check the flag,
>> > we'll have to gate being able to pass memory based on the flag's
>> > presence, etc., which just adds complexity everywhere. It will
>> > eliminate a few patches in this set too. From the programmer's
>> > perspective, program behavior isn't changing much, so we can use
>> > zeroed page (to guarantee faulting loads return 0) instead of setting
>> > the PTE to NULL. While at it we should drop
>> > bpf_prog_report_arena_violation, and its various users.
>> >
>> > Summarizing past discussions on all this, with more details on various
>> > pros/cons:
>> >
>> > Currently, the semantics for a fault dictate that the program simply
>> > continues, and the destination register becomes 0. One could argue the
>> > ideal form should have been to abort the program on fault, but that
>> > wasn't possible at the time of implementation. We added fault
>> > reporting to the program's streams to improve debuggability. Now since
>> > we have an ASAN implementation, you can likely run that to catch
>> > memory safety problems. An argument against this is that it doesn't
>> > help surface a class of issues for production programs. We don't have
>> > data on whether stray faults or memory corruption within present pages
>> > is the more common occurrence of bugs in the small set of programs
>> > using arenas, so it hard to pass any clear judgement. One thing we do
>> > lose is faults on NULL-derefs, which are likely common, but Emil had
>> > some ideas on that.
>> >
>> > Another thing we lose is the ability to build something like GWP-Asan
>> > [0] that we can run in production programs without paying much of the
>> > performance cost by sampling allocations we want to detect bugs for.
>> > But between ASAN and Rust-BPF plans, I am not sure how compelling it
>> > will be going forward. So while it's sort of sad to lose the ability
>> > to fault feedback, it is also non-trivial to enable direct access to
>> > arena memory for the kernel while preserving faults (I won't go into
>> > the details here) without using fault-safe memcpy to move data from/to
>> > arena on the kernel side.
>>
>> I completely agree with the discussion points, though imo we do not
>> need to make this flag the default if we support it. The complexity is
>> mostly checking whether a kfunc that takes arena arguments accepts the
>> burden of validating them, or if it depends on the new flag to prevent
>> faults. Any new kfuncs should have clear semantics on that, and we can
>> validate proper behavior with selftests.
>
> The main problem is accessing the arena or arena flags etc. to decide
> whether we can read / write the address. It needs to be passed around
> or retrieved at runtime from within the kfunc. It also makes it
> conditional on the flag, so depending on whether a flag is set my
> program will load or not load, since verifier prevents me from passing
> arena memory as argument to kfunc. In practice, once sched-ext
> requires it for its programs it will defacto be the default since
> that's where arenas are used (for now at least). At that point, why
> bother with the flag.
>

While sched_ext is currently the main user of arenas, there are other
potential users - the *_ext's being developed in MM, for example If=20
we change the default behavior, we risk making arenas less useful for=20
them until Rust-BPF or an equivalent solution prevents memory access
errors further up the BPF software stack. I think ASAN can only partly
help in terms of reporting since it won't be on by default.

As an aside, whether Rust-BPF would solve the problem depends on whether
we allow/require unsafe Rust to be compilable down to BPF, and how much
users end up writing and deploying unsafe Rust. Anecdotally, I've seen
arena-based data structure implementations in Rust that are full of unsafe
blocks.

>>
>> Whatever we choose, I am strongly in favor of keeping some kind of error
>> reporting when touching the first page in the arena. This has been by
>> far the biggest indicator of bugs, and if we only keep ASAN then we lose
>> our strongest signal for most use cases. This is made even worse by the
>> fact the new flag is incompatible with GWP-Asan, making it too costly to
>> run sanitization at scale.
>>
>> For the flag, the solution would be to move reserving the low addresses
>> of arenas from libarena to the arena itself. The arena would have a low
>> watermark below which it would retain the existing faulting behavior.
>> The kfunc would bounds check check the arguments to ensure they're not
>> below the low watermark, and fail if they are.
>>
>> It's not ideal - it adds the burden of bounds checking into the
>> kfunc - but it's reasonable that arena-related kfuncs should take into
>> account the arena's semantics.
>
> Another data point to consider is that if we omit this initial
> faultable region for catching NULL-derefs, we gain the ability to
> allow passing arena memory into any kfunc where memory arguments are
> taken, which might be pretty useful. We won't be able to do it if we
> have the initial region as faultable since we can't rely on kernel
> writes hitting a page without any checks on the memory region. You
> must treat arena arguments specially and cannot mix them with other
> memory arguments.
>
> The other way to keep the faultable region in the beginning would be
> to emit some assertion/runtime check in the verifier and abort the
> program if the arena memory being passed into the helper is accessible
> for the size parameter used for the helper call, or fix it up to some
> page that is likely to be present.
>
> In practice, if most users set the flag then I think you likely lose
> the benefit of the default behavior, or cannot rely on it anyway. When
> it becomes a dependency for passing arena memory in the kernel to
> helpers, most users will blindly set it.
>
> So in the end, it boils down to whether we think retaining faults
> (e.g., conditionally for the NULL case) is critical, and whether we
> have some convincing evidence for it.

Fair enough. While anecdotal, IME it makes a big difference to be able
to track NULL dereferences. Explicit checks within the program do help,
but at that point we are depending on implementing perfect error
handling for the program.

>
> If not, the best course to me seems to be to make the flag behavior
> default, and just rely on ASan (and Rust in the future) to prevent any
> memory safety issues, and drop the stream based feedback on fault,
> etc.
>
>>
>> >
>> > [0]: https://llvm.org/docs/GwpAsan.html
>> >
>> >> [...]
>>

