Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794429208;
	b=ZKPhILFdUwkLTfXHcdLcWsmKeV2R40FS7xPOOjfWEMyFIpaHau8m4pcL26y+rvsSycVO
	 MeoGX5e7Fh2WkRJjVCMm623Em866dfm8Xwtk+qqCGSPGBAsueerDNj1Nk7SFTpAfALlEc
	 adr+owf80bTEzeDbP50Kdj9dYqoiImC6TvkdJU22uD8cUR2W9a9b7o1bAf3VwCxPzY3t/
	 hRsHBCbkiujXD5u2dtzU1QSkTwqNDVaCOmv15CbRhQyGFlgoEvoCRkOL6Qtq91H/AFejS
	 K+AvKxf0kKTrJTsxPkPeVvrQiv9Ahyq8oNwwlzyeZPAhtsxJbWG/Y1FgYtoU1NlBFZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794429208;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=+jJOft0aO8xzfEBQK88XLI14W0B4GaY5O7q0mxJh6vM=;
	b=g1lkOHAlBOdhf36UDXCk7rLkPra0HM+WAUFXye2BwxE8JxtkqJIHIqlGWGqEbSTzYABi
	 3h3b+4/AlfUDaXk36sD6/5Mj0thdvpv2n3I6TagXdREglf5laQANu/OyDdCotNpOOpsj8
	 bF6gb6R6vTnCBhGj6/UbdQoYGHRVE7xCjGsHNX6Ij1ieC9FHmIi8uEicKw69G76NmToiP
	 p2n+zlV+YbMEzKy1+Sj72ZMvwlDg03QJaRGZLFcRQhSuT/EQDqHUMYYU4kxpWm+iVIeZZ
	 +7i5tsL7PORufHYmvIagrdRyn/UhLmZ30TtI0oh3MZ0W7pUGGtCrJXgVdW7TqXmnELA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DHeU7es3;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E679F606A334
	for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 20:33:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E679F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DHeU7es3
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ed08b07213so14506095ad.2
        for <bpf@vger.kernel.org>; Wed, 11 Nov 2026 12:33:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794429207; x=1795034007; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+jJOft0aO8xzfEBQK88XLI14W0B4GaY5O7q0mxJh6vM=;
        b=DHeU7es3r9dJDGW93d48Jtqg+Dgo9RvltjTQZdK320db0IbDhljvMqVV0TfAMbY5FT
         7heJ/4QRsUBgs7UmQEL49wfNia5qOwqRSnzrb0HNHSaWmdK+m/nNFd6eYYEeAOMCQJat
         fuNOXfpmS4Eeh+mq8jZHXUzoswVenJpdG5amIZ+yqi0oUqvzgSp9kb3TC63BAyIGhe2w
         s8JP2X8tZ0ZnX3g4PqcyUIJhVk25YRj3fIFls2k4Uxu42akb4UjzO8aVomLwA4FSk/xF
         hMpbfjwOUFUUzJhahFLlQRAJeehOmIYNCFzaLmtgYUtY9dItOoIVBQqSEWvEaf38CicZ
         ya4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794429207; x=1795034007;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+jJOft0aO8xzfEBQK88XLI14W0B4GaY5O7q0mxJh6vM=;
        b=ok6zr/07w3gk2i/Bze8B0MaFsnvZjccJqIMbeslV9CvVV7eQjO9byPGJ1NZvt9LlAF
         M0cwHra1MhLGtUK3gjWy3XZjt93mmTBHX4SLkMr8V/COOToSP9yFR40wPmjfV4yPjh90
         48xtK9ZcngXs4XaFtWSoCh8dZegpt90piOPLgqAM/5tIUWZrArT+B3euDpAZB673is1G
         pcUSVNOYAMGa0ST1FgPPs0QbvsMJiIdxlwku9ft/UeRFbHL3o4NF8Su47ntbYW5/g3ku
         MGVOFgpZFZxC9SS9h1uWwkb2DDBDnUj+31hKFIWySETQ9lLBv54q7esmLVBVJwwZfygP
         B27g==
X-Forwarded-Encrypted: i=1; AL+hErEOYZj2vbjfCtBDWG6ED1bAmeyN4E+4q2jnDSDetVJuz8Zj02uxIN08hZFJ8fKgkrzn4B4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9AjYcebchXViVIZa0b6Bk60OXZj6E8GFT6sqO2n5OGm5SZdpbl
	qdJgMXKqS5GutDWNiMuSKGo9aEzCl6GT1DWG7h9zV0LMnNnlIdDn/ols
X-Gm-Gg: AYBFou1W7+sw3De2WwO8MJ6lVulhoGqHhsX2hdyFwztI+ap1b/8j96eLfWqzWzRtdpU
	SpcZ9YZe7x/dayW2bXEbRbN+n9QYyVuvWZbwGTY2oQ+18H1ugyu0BzL0LhV9+8DFuFUHBNrDNZK
	/g+9JT4s560QybGMOP/YlPQ6j5db2c8ihxn8PD4cX1RC+mUMLe0DuyADLYFDujMSZViALDS8LOH
	aPPTZUD35EQCgkbrJ6gY0H3f3RpTPNN7A+/gyj4hb1rLwoSrKKSSRzjdNub3a/xsoveZFrhlrcL
	lPqZnTKf3gmsh0TSFA2Qrr9hZeig3bLXJqi2N6Al5xK7HY78UEfEuSLl4RIiJIxVR5/UhwA1Krs
	IG/PcWvScrOFxscKB/nMX60JaPGHBWkwrX7bX8FDBtINrl0hlmueU+lZYfxxC/bHipwXs5Pc7wK
	kqdKjvajss2zw9a8aBn3o/hzpfS+mBZZQ7NvHRHOXKiYPHnLSdCujqB3VxOusu68tsv9q7Bkcj9
	PLSuqJzxKRA+Zyy4N9CZw0Zym7lWRAtoVez7AMWdc28ypjOTWU2+7DbrumrTJxjEqDEzOtLS/U6
	UkkOvlmS+jGn3TkZeaMHSR9yf92Hzuw03X+04wwU3BZrbONgRSUv5B28xXVdLRy76pDm3ZwbhhC
	MSKjlENtD1Z+A4J0UWnBVbR7nNhSjFrFDpg==
X-Received: by 2002:a17:902:7615:b0:2ed:ef1:f78 with SMTP id d9443c01a7336-2edd7ab6a4emr26040095ad.21.1794429207072;
        Wed, 11 Nov 2026 12:33:27 -0800 (PST)
Received: from localhost ([153.61.198.251])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2edb6dd2225sm24528035ad.56.2026.11.11.12.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 12:33:26 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 20:33:26 +0000
Message-Id: <DMSO2CZRMEUE.LE9RG32M5QBN@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <kkd@meta.com>, <kernel-team@meta.com>
Subject: Re: [PATCH bpf-next v1 00/29] Exceptions - Resource Cleanup - Redux
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
In-Reply-To: <cover.1794399387.git.memxor@gmail.com>
References: <cover.1794399387.git.memxor@gmail.com>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, Nov 11, 2026 at 04:56 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> This series allows the main program and its subprogs, static and global,
> to throw while holding resources. The unwinder releases the resources of
> every frame it discards.

Agree that we need bpf_throw() from everywhere.
Below is an idea for brainstorming. No code yet.

Drop elaboration in the verifier. Pads instead of descriptors.

Keep the analysis of what a frame holds at a site.
Change what comes out of it: not tables for a C unwinder, but landing pads.
A pad is BPF insns that the verifier adds after the main pass, like guards.
Then throw, cancel and rust panic are one mechanism:
unwind_goto / unwind_exit.

1. One unwinder

  site                                 the verifier emits
  -----------------------------------  ---------------------------------
  call bpf_throw                       r0 = cookie; goto pad
  loop guard, recursion check          may_goto pad
  call / callx of a subprog that may   unwind_goto pad, behind the call
  unwind, no unwind_goto behind it
  helper that runs a callback          unwind_goto pad, behind the call
  (your 'helpers have pads')
  arena load / store / atomic          unwind_goto pad, behind the access.
                                       JIT points the extable entry at it

  pad:  release calls
        r0 = 0
        unwind_exit          main prog: call exception_cb; exit

Every frame leaves through its epilogue. The frame at the site has R0-R9.
A frame that waits in a call has R6-R9 and its stack.
No stack walk, no asm entries, no saved register offsets, no site tables.
No void (*)(void *) wrappers: a pad calls the release kfunc with its type.
A frame of rust keeps its own pads. Nothing is skipped by construction.
Sites that need the same pad share it. Most sites hold nothing.

2. Three questions, answered apart

  WHO        The frame that acquired it since its entry.
  releases   What a callee returns with is the caller's.
             Or the callee that it was MOVED into: the caller keeps no
             live copy behind the call (R6-R9, stack).
             Decided at the call from the state and liveness.
             Nothing provisional. Nothing to settle after the pass.
  WHERE is   The prog's own live place, like your lattice: register,
  the handle spill, stack object, pointer to what the lock is in + delta,
             fixed address, load through a live pointer.
             The prog has to release it later, so the handle is live.
  WHETHER    The pc, when all states at the site agree.
  it is held Otherwise a DROP FLAG, as rustc and clang do it.

3. The drop flag

One hidden byte in the frame. The entry of the subprog zeroes the word.

  flag = 1   behind the insn of THIS frame that brought the resource:
             the acquiring call, the call of a subprog that returns
             with it, or the entry when it was moved in
  flag = 0   at the insn of THIS frame that takes it away:
             the releasing call, or the call that moves it out

        *(u8 *)(r10 - H) = 0
        if r7 == 0 goto skip
        call bpf_task_from_pid
        r6 = r0
        *(u8 *)(r10 - H) = 1
  skip: ... arena access, loop, call foo ...          -> pad
        if r7 == 0 goto out
        *(u8 *)(r10 - H) = 0
        r1 = r6
        call bpf_task_release
  pad:  r1 = *(u8 *)(r10 - H)
        if r1 == 0 goto done
        r1 = r6
        if r1 == 0 goto done
        call bpf_task_release
  done: r0 = 0
        unwind_exit

The stores are unconditional. bpf_res_spin_lock() needs a test of r0 first.
The flag has no handle in it. So there is no register to find at the
acquire, no compare chain at the release, no refresh after a call.
A flag is emitted only where the states at some site disagree.

Identity: a reference carries its origin, as in your set.
A join or a subsumption can pair two references with different origins.
Then the origins go into one set (union-find) and share a flag.
States are joined as today.
Sections become entries of refs[], so they have an origin too.

4. What I hope goes away, in your terms

  tables, unwinder, phases, asm entries,   pads
  registers recovered from prologues
  mirror                                   flag + the prog's own place
  NULL in the lattice                      flag. A pad tests for NULL too
  entry guarded by a scalar                flag
  descriptor per chain of calls            flag in the callee's frame:
                                           'differs by chain' is 'held
                                           on some paths' there
  provisional listings, transfer           move at the call
  other origins are not joined             union-find

What stays: classes, type -> release kfunc, the places, helpers have pads,
the return value of a cancelled prog, the struct_ops hook, the stack in
arena, bpf_throw() reads all registers and slots for liveness.

5. Where I'm looking for ideas.

 a. Several resources of one origin at once. rbtree_search pops nodes
    into an array in a loop that is walked. A flag per origin cannot say
    which.
 b. A callee releases what the caller keeps live, on some paths only.
    try_consume(obj). During the call the pc of the callee tells.
    Behind the call only the callee knows. Maybe: the callee has its own
    flag and returns it in a scratch register at exit and unwind_exit.
    R2 survives exit already for 16 byte returns.
    I think you're doing something like that in your followup patches.

