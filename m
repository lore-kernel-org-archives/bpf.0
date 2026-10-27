Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793126746;
	b=GL5EAWiyS5HrQCw/la80MGtIxkK9B1XdlxClQC1cyC5RsxfswbhWbAyxPs1DDnLeDhOu
	 GAV2opltFIx91AqAeUMYm7LQ931UnCY9aW04810KxAyiQ9NYl1xj2GDuF2f2eITCuR6qA
	 b6G8aVlq2JZZgiDOAKlSa/vP5X6pzjF/T0Uh8IHOjzxcRUpTHH7UrtTVK9Fk396QqoHkt
	 fG1CDiB+ukbOUT3An3590H0VrgaXkLbgU37yqRd8OK18tKgZiePK1zmmUPCZyVMxGc4mk
	 +dRQSouCvH3PquBVqzLEjSxxxOzHGSwI/Z8tUwNrys+X1H1IsZAOS8Uh8yuwluoqSjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793126746;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Content-Type:Date:
	 Message-Id:Cc:Subject:From:To:In-Reply-To:References:
	 Content-Transfer-Encoding:MIME-Version;
	bh=xEd/EOFch2GeJF5HJ5/eqQs7E8sv3533NOGtKb2nOOQ=;
	b=mQZOUJrw+4/zT1UxbV1iRqlM6PAqVtPtD6L8xzc6W7YcU53KqY6qaBfAZolbfJFzxQUx
	 n2yPaijbQQjFZg6Qz1aYiOqRCsOArXELm4ETpicezTEG8QlWMW1pGzASAlLi2wU30h8h/
	 ASKA8G9cMcDNYkgTYSMF3Cej6VgJlaII3oczRjG9M50elY6rp7N6tbUx3Su9GVdADCnON
	 Y1ufHRGz0xbJtIpqsIVq0Qw6wtVIoU/hF04pIgcdJqGF9iFRB1DVrPS8111uC4IKlEIoJ
	 8WjDY7/8yTFIGjxk6TK3211OQ8htRw5t6uNHKPrniGPqpF6cnie7ajSkRdE+/MAN0pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iucb3Y88;
	arc=none smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0710A606A326
	for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 18:45:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0710A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iucb3Y88
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso600915ad.1
        for <bpf@vger.kernel.org>; Tue, 27 Oct 2026 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793126745; x=1793731545; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xEd/EOFch2GeJF5HJ5/eqQs7E8sv3533NOGtKb2nOOQ=;
        b=iucb3Y88eQPSsgKMldw5U6OO6VKebJLGsaSTmZzK3zyLBfferu3Bhvgc8f/mHW2TWL
         N2WOQQ+UGZvD/NdZHq1uNfzdnqsQLMEe2j7y6/LzHGWiTuAY94P+Zrh9r9DzT1NEJdtu
         w6VMtdw8OSwnJzH9Ue4R6+Xm+UXpKRRCyBJ3aVUCKtiIqUvo2GBveIzfUYWm/WTs5phg
         Lupjnrl70Ixhpb9uBJlzjjPK2zijqfgsFdjwr+kCsE7WrcmcaOU2ymGS+tFrlUI7zJEV
         h/udAUqt5/nbG6ZTgBfkIvj4LFVDhfthaaYBqItKSoN5PuJeqE5nEJPGNBeuSzjY5p0Z
         jKUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793126745; x=1793731545;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xEd/EOFch2GeJF5HJ5/eqQs7E8sv3533NOGtKb2nOOQ=;
        b=yfyGMiKoDxsjM9DXxDKataazo9Wp1FWjYl/QkEHKSIs9fJGR4goqMiUD1VsTKx/tkc
         h//hoa52OpRarn5/qGZfbiKGWtEYRJwI57Dr2Vf0Ms3xrrIeKxIsCPi+AkqIGm7TkxMl
         bgWsNv5IA9CqJnjPIg2QzD8le+x+tGvk0Innrfl3WN+FW7kb2Y/ZNonZiVFHii/Fo0NU
         YbtOmtl6zFP2lYynJdP4Ox+otu0tbJfUIeZbekZ+yv9qo0C5CrzeI3SZrbK9f/58HrY4
         8Lxkj1ds0xoi5uYDJa8psbxl3U6Pma28q8Jkcs4w9Qx7QAoLCs6iPqdO1o/bOG5reJKT
         QPFQ==
X-Gm-Message-State: AFq9FYJEktmY5h45Cj4tlPRT0hCbfaTqXatiK80Di18qvfXzglgCMeqq
	Ht5mtfGxgfFs5IvJ/6OAFQcQHr9ighzcpILLXXXzLFEAVS3JMPPObHjeUdaAXQ==
X-Gm-Gg: AYBFou3KmyT03Y5S4Fa6NHwUUwODwj2Dk5lJNCquR5PfPPXOhxGT9PdvUAmP/oody/p
	B7gLi4nvdvzcIem55qJ3005CUBl8w97c6xHRcNJTz/njM6UgKFu+VME1LtaboYOT4pQCJZg/myZ
	DTLzhaePnNYqa8LdVDFga9UeA+vEgBM9OFQbzP/CMeLa0JU/xjnWkvoypTfedQQSpxfzESzoaKg
	KaRDZpv1prY15HLIgE1+stu+TOjkeQoDP5FuqHfElFhbW5JHAe1yBEFJ6n6/seHzsB8pfTFljm9
	xHtOfuwwclAUL3xwt+Pup+v/8RNJFTlvHnJJUfJioFaROiccqiQy0ef0LNstR7QKvUmL0W051gz
	grDwoE4oxOkQLIOgrU+UPqJj5A7sTpWCYC+4DNiRjOHqUrSpKjbOYQnu7OtpYWfvbyIfY5J2GU6
	D3L0EXBB+dQhvJlXzXtErYsHGFlVVBps442/7z+Okh5VYAWrfnIRCGjGEcvr0LBVyG2ooN20EB8
	9g+roeO9h5PWZKeXzrwCTYW3BYuogv6I9CsVqweftGq8Qrc/VIrnW7u0EcY0wMFn3L7gR1vyFwv
	ZviCp63Pplv+wYWY5rr8vLF/rhTAwkB+gBtnuU+doEF4TRzsHWzzf3pip7FX
X-Received: by 2002:a17:902:d504:b0:2e8:3d48:4d92 with SMTP id d9443c01a7336-2eb003bf1dfmr2299145ad.33.1793126745024;
        Tue, 27 Oct 2026 11:45:45 -0700 (PDT)
Received: from localhost ([153.61.198.241])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6bcdf0bsm13618135ad.27.2026.10.27.11.45.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2026 11:45:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 18:45:44 +0000
Message-Id: <DMFUDQAC6N4S.1CNBGYKG58DMR@gmail.com>
Cc: <bpf@vger.kernel.org>, <daniel@iogearbox.net>, <andrii@kernel.org>,
 <eddyz87@gmail.com>
Subject: Re: [PATCH bpf 26/81] bpf: Support BPF_REG_ARENA_SP in the verifier
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
In-Reply-To: <CAP01T75HAHkP4bzdGzeazN4n_FNd5w1Pckd3GBN68V0n1PNe_w@mail.gmail.com>
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com> <20261026025943.404450-27-alexei.starovoitov@gmail.com> <CAP01T76dRouzrPOZS8AQ4TMnJ0GzyRm8cPJ8RYUTu01bQgf2Xw@mail.gmail.com> <DMF694XH2TJO.P59A31VE6GWP@gmail.com> <CAP01T75HAHkP4bzdGzeazN4n_FNd5w1Pckd3GBN68V0n1PNe_w@mail.gmail.com>
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

On Mon, Oct 26, 2026 at 5:18 PM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
> Overall, I think it is less clear to me (or anyone looking at patches)
> as to why you did things this way.

point taken.

I was wrong in my previous email. An iterator over kernel objects
stays in the r10 stack, and it works today.

> Are there real patterns that existing stack tracking simply cannot
> salvage?

Yes.

Pattern 1: one insn, two kinds of memory

  sum(&local_array)     r1 = fp-64    --+
                                        +-->  r2 = *(u64 *)(r1 + 0)
  sum(&vec)             r1 = arena    --+
                                              one insn, one JIT form

We discussed an idea to let llvm clone such function.
I tried it, and it didn't work.
Short summary:

  case                               why a copy does not help
  ---------------------------------  ------------------------------------
  the pointer comes from memory      no kind for the compiler, a scalar
                                     for the verifier
  an indirect call: &dyn Trait, fmt  one function for the two kinds
  if c { &local } else { &*boxed }   one pointer, two kinds, one function
  n pointer arguments                up to 2^n copies

and real case in <&PanicInfo as Display>::fmt().

Pattern 2: the address of a local goes to memory, a load gives a scalar

That's typical rust heap.

Pattern 3: LLVM removes a bounds check, here in core::fmt::num

  loop { remain /= 10000; offset -= 4; buf[offset] = ...; }

and 'buf' is on stack.
run-time clamp won't help, since real tracked spill/fills are in r10.

Pattern 4: fp in an argument

...

So an address-taken local must be where the heap is... in arena.

experiments for arena-stack

  where the local is                      what breaks it
  --------------------------------------  ---------------------------------
- structs by value, more inlining         an optimization. Pattern 2 stays
- a second vm area or arena, a map value  a different base: pattern 1
- arena, a fixed frame for each function  recursion, a second run on the
  and cpu, as in the private stack        same cpu
- arena stack, sp in a per-cpu cell       preemption, see below
- arena stack, sp in bpf_run_ctx          load, add, store in each function
- arena stack, sp in a hidden argument    an argument and a callee saved
                                          register. BTF does not match
- arena stack, sp in a reserved r9        a verifier change too, and one
                                          register less for the prog
- arena stack, sp in r12, the kernel      the series. It costs verifier
  supplies the stack                      code and a register in each JIT

The choices made for this arena-stack design:

  in the series                    what was rejected and why
  -------------------------------  ----------------------------------------
- one 'r12 += N', the first insn   'r12 -= rX': the depth has no bound
  of a function                    several 'r12 += imm': verifier state
- the verifier tracks nothing      tracked slots: a store through a scalar
                                     invalidates them
- 'rX = r12' gives a scalar        PTR_TO_ARENA: after a load from memory
                                     it is a scalar. Two types at one insn
- the cast of a kernel pointer is  an error: two progs cannot share
  a move (patch 18)                  fill(&mut Event), ring buffer and Box
- the kernel supplies the stacks,  compiler, libbpf: the entry code is in
  one set for each arena             each object file
- contiguous, 32 Kbyte at most,    fixed, 4 per cpu: 512 Mbyte of addresses
  pages at the first use           segments: each function can fail
                                   pages on a fault: can fail in mid-run
- regular arena pages              hidden from user space: no gain. It can
                                     corrupt all other data of the prog
- a run takes the per-cpu stack:   preemption off: no sleepable progs
  a counter, local xadd. If it is  two calls, get and put: 4 nsec
  taken: one of 16 more stacks,    split, sleepable or not: two mechanisms
  then new pages                   skip the second run: not for a scheduler
- grows up: r12 - off, like r10    down, r12 + off: harder to read
- x86-64: R9. Arg 6 of a BPF call  reject 6 arguments: Rust has them
  is on the stack                  r12 in a frame slot: a load per access
- a callback takes its own stack   reject r12 there: scx_central needs it
- bpf_throw() keeps the stack:     a slot in the frame of main: an irq
  the kernel frees the arena as      overwrites it after rsp = rbp
  a whole, and Rust unwinds        give back first: no record of new pages

> It might require teaching the compiler not to move certain types on
> the stack to r12 relative accesses, but it just feels ugly.

it might feel fragile, but it worked for huge corpus of rust crates:
https://github.com/llvm/llvm-project/pull/235577

Your dsq iterator exapmle is 'alloca [48 x i8]' in the IR, so it works
(I replied too soon yesteday).

llvm selects the stack by use: 

  rule 1   r10   The function that owns the local passes its address to
                 a helper or a kfunc: iterator, irq flag, dynptr, map key.
  rule 2   r10   The prog stores a kernel pointer in it and loads it again.
                 Also a local that holds the address of such a local.
  else     r12

> For certain things, like open coded iterators on kernel collections,
> there is no other choice.

Of the 16 rust sched that I hacked 4 walk dsq and 13 call
bpf_local_irq_save(). In testing they loaded and *run*.

But I agree that passing them around is fragile.
The hope is for typed arena to save the day.
Then rule 2 will go away.

> unsure how various assumptions around address contiguity get affected
> when stack reuse occurs [...]

A local never changes its stack, and it is contiguous. The compiler selects
the stack after all IR optimizations, for the full alloca and
its full life. r12 locals have a stack id of their own, and stack coloring merges
only objects with the same id. An iterator in one scope and a buffer in the
next are two allocas, one in each stack.

