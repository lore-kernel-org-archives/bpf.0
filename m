Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE45224B15
	for <bpf@vger.kernel.org>; Sat,  7 Feb 2026 03:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770433385; cv=pass; b=fTqqXYlAJT0SjyaNDhDs2l8AsTvbBKcj7raJ9uG52ojU1sEhevnHx0ke0sNrnUi2WWKwQdUr0dWTS4lJ+13N1zkud+KAuUiEj1PvHDXIGeTxFcu7pB17Wp1cvWlTHf8EDc7loOjCO1d4sI6kg97B3wY/KOd/3poRl5cbuLrGfsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770433385; c=relaxed/simple;
	bh=UTkj7h8M47DmM4dR5UoVU3GddRZQGJEFUnGavZcKXjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Igl0YBKGMTeUlY92+7t660OAlKmN7fg+SUbTPeRdT/4nZh4605qR3ARKZuJtWE7+h9LciFW/W7IyEvJaMGic0jTAzFjZZ/iVmc2WDQWA41v+uSeeiX8pwKE5bDF5AkQY9VDzDHfWG6k/0DLv6sPgroGLMCnxCiuDP6M7976IjGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MHae4ubf; arc=pass smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MHae4ubf"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47ee0291921so12210815e9.3
        for <bpf@vger.kernel.org>; Fri, 06 Feb 2026 19:03:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770433383; cv=none;
        d=google.com; s=arc-20240605;
        b=M6mH0JhhcAADIOa3CUMHhjlDNgaZ2mPzcVRYcRvxsS8uxlSu6v8Di3xqxozrVl7Ly/
         dn6BKr9k5MhFR4Qyrli4UhvbT4QrIKSEBQ0v8Ctd+3/eL7t1PdqlQMGuThcWTX8X82jQ
         bK+n5a3q+N+8nukPWsIt6OnRfA4IywRU3Mj6t+xDiWavESxlKpp+5p1YcGjnTOnAKUF7
         M6x79CAyggqeSUhzQBTON3MJC7h5fpmy63isUUj+u3nFToOPLmYEJzfZel/Fv5wLzVDO
         towXVzzOPVuuhodKYEBLadKQVnBiXLdkCyaF5U1oAB+PtuQWyoa8FefnobmfiCYpH7l3
         c6ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wJOhkhj4xC/GmPWp2X4zXP4+6h1OHVYsU8hDiuLZZMI=;
        fh=daLfeIiCICAD4C8At3fbsQS4NFuQ3TbypFSrirDFhnI=;
        b=H/TDXEffyv/8znFoThjq6iRJsHoW9uKWEo+A9X7FukLYDkULJTdInXjRYeiZM8qQ8d
         kvezNL4SxMk1kp2f+Yoa8fMXvF4JdV4Nh/5YbpsL9Cm4VcXYCVkNH9GDNSncvubqP89O
         2W4Yt3Mlcku53Zn6mWXoRtO6pP/QN7n7YmbtufX4ze721eaLdndavqcxDEAyrR9s3Cu3
         xVnN75MvRcb8kwYIJqvOdcTTB7gimOITsTRb1CF8sQRHI+5Zu6zn/uRfVL3itN4vlnGn
         kc1CrJYXsPR9rOYNkepMbAp0D7FlWjVD04KAyfe/3UX0y0o72eLLB/WWci3rInlKrC9y
         3Cyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770433383; x=1771038183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wJOhkhj4xC/GmPWp2X4zXP4+6h1OHVYsU8hDiuLZZMI=;
        b=MHae4ubfPcilwAHhGfekpmIBX5vafjkJf6FYrlFF0xqg8BgVllLjEcQ5UYu+xzyMNt
         C0Jak464Wr9fROuPWc4mhVSYel5Kn2jl1bm9MbNzd0x/hbX/1j90etZHT9GBVF1PizOg
         l9QweDx7Fh173pgEwf5l1/MMD4lArjnE79y6tHMpSJ/Bd2FqZseBrbmJ7HNG5MgG3IXS
         X7jMi6968Ztbo/xRzqVS6+ZTEh/xAbtgla7XEfm9f7nACy75xYw8x8MDMCNSr5N+1j+Z
         IEQ/ZgA+VJCwnZYDiyRJIwdPB3H9BDowD6aL8rUq6L0ZQfceBUuAFMYqrClaAmScTqNC
         Ls8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770433383; x=1771038183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wJOhkhj4xC/GmPWp2X4zXP4+6h1OHVYsU8hDiuLZZMI=;
        b=jsDDv89m3y5xOnojz3qaXpntje2FzZfXa/WwjMCZXBcJjigG18eBB0P9qLKIH1tw8A
         slRY3fSlvv1dgkVhxdQry0diEuiy/eK3q1OT9TJILA0EgX7Yr8hgwXJ7QXZ9PDGMHSDs
         UfQEGvqfU5vMXIN1QZJloFGeaW0D8YCbWlheIgldjg0fqhOaBzmxsHkghXkBEfpCQJ9I
         4+f5ycHe4tM4lzUXOGZIRtLhepL7hQprTv/vyd/DQR7ZTJQUOQhs5kjjFbEoRfy4cIfm
         JZgyich4FDlAsnRbI970aCohVKAixptk2AArzIjarH74QZd33aNyOg19GUiARiToY3mZ
         t2YA==
X-Gm-Message-State: AOJu0YxfvJgFkm1Y/spFIxrbLYTqQkC7JJEWXdpAwxHhpY/Ky+Ld9llN
	S+h9Zi265GISMj2u+eRknDiUrfRhPXp/alXoRlqsoGE388VAxmWiAO+SOzlaIe2sP1z5PaYFozc
	SP4e8Fhi6H1OU3fXbt8dENwu/rrXl4rg=
X-Gm-Gg: AZuq6aIKfG4kTH6Hjc2LdAvCR27dJFLPcwKwAzVs5Q4mHN5NPeATTlr9vhsEZsdI/qO
	a2EX4RkoI3RKYrfSU3vQq1RIDfplUlNOrqO44TKSQm6DJrjrYSXGEa6s5jvc0+FTa6Jqw7y92AJ
	v+Q1ZpGCQDVCFpb6YRb2NqUM60QT5u7KO4nSw9rNKi32lrXejSmVVYkfUCHoxxbk3atRZDzJazK
	gOBccfiIsT7O8C56DLwNfAU5yxkDsoZZKWHoCu05F9uKj78f36g0EU7xiqXLulI1LbzJ5z1+c/u
	caNqoigpcA7/sbk40y1NFw9j1LioEj+PjAbMTdubYdOHf5fchygrfIEhuoiXzbvS3gmwtjpt2Kl
	EZQKbHmeLQBJ81g==
X-Received: by 2002:a05:600c:3e12:b0:476:d494:41d2 with SMTP id
 5b1f17b1804b1-4832021d67dmr58048285e9.29.1770433382686; Fri, 06 Feb 2026
 19:03:02 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <DG7UG112AVBC.JKYISDTAM30T@bootlin.com>
In-Reply-To: <DG7UG112AVBC.JKYISDTAM30T@bootlin.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 6 Feb 2026 19:02:51 -0800
X-Gm-Features: AZwV_QgBJYKlZ9FJWkY44j_QnMiB_Zk3ua8KVZ-IaiFEiMCm0lP84rMGnPaVCjc
Message-ID: <CAADnVQLX7RSnOqQuU32Cgq-e0MVqyeNrtCQSBbk0W2xGkE-ZNw@mail.gmail.com>
Subject: Re: [RFC] adding KASAN support to JIT compiler(s)
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	"Bastien Curutchet (eBPF Foundation)" <bastien.curutchet@bootlin.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 6, 2026 at 3:31=E2=80=AFAM Alexis Lothor=C3=A9
<alexis.lothore@bootlin.com> wrote:
>
> Hi everyone,
>
> I am starting to work on adding KASAN support for loaded programs in the
> kernel (in the context of the sponsorship granted to the eBPF Foundation
> by the Alpha-Omega project, see [0]). I have done a bit of
> research/experiments, but before actually writing and sending things
> upstream, I'm sharing here what I understood on the requirement overall,
> and how I am currently considering to implement it. Please feel free to
> correct or enrich any part below!
>
> # Brief
>
> Once a program has passed the verifier (and have been JIted into native
> code), we have strong guarantees that its _behavior_ will not trigger
> bugs like infinite loops, invalid access on input context, NULL pointer
> dereference, and so on. However, eBPF programs can still generate
> invalid memory accesses in some scenarios:
> - programs validated behavior relies on the hypothesis
> that the tools (helpers, kfuncs) and data (eg kernel data) provided to
> eBPF programs are sane: eg if a pointer returned by the kernel to a
> program is somehow bogus (used after free, triggering out of bounds
> accesses, etc), a bpf program that has been validated by the verifier
> will happily use this pointer.
> - there could be a bug in the verifier and/or the JIT compiler, letting
>   invalid accesses slip through
>
> To help detect those issues, Address Sanitizing can be implemented for
> loaded programs.
>
> Similarly to the KASAN tooling implemented for kernel code ([1]), the
> goal will be to instrument any load/store performed by loaded eBPF
> programs.  This means detecting those load/store in eBPF bytecode (when
> being processed by the JIT compiler), and insert calls to the
> corresponding __asan_loadX/__asan_storeX before those accesses,
> similarly to what compilers do for KASAN. The major difference here is
> that this instrumentation will not be inserted at program build time: it
> will be inserted dynamically by the JIT compiler, while it is turning
> the eBPF bytecode into native machine code (and so, this work will focus
> on jit-enabled systems). I am considering this general process:
>
> # Basic instrumentation
>
> - start in do_jit(), in arch/<$ARCH>/net/bpf_jit_comp.c
>   - note from Alexei: let's focus on x86 instead of all architectures.
> - in the main loop going over all instructions, for all load/store
>   instructions
>   - note from Alexei: let's focus on LDX/STX for now instead of _any_
>     load/store instruction to keep JIT complexity reasonable
> - identify the size (b, h, w, dw) and type (read/write) of the access.
>   Depending on those two, define the __asan_XXX function to call (those
>   functions are defined in mm/kasan/generic.c, and are basically
>   wrappers around check_region_inline)
>   - I did some tests, emitting explicit calls to the __asan_load/store
>     checkers implemented in the kernel directly into the jitted code,
>     and it seems to be fine to call those from bpf execution context
> - similarly to what ASAN is doing ([2]), possibly implement a fast path/s=
low
>   path, mechanism:
>   - fast path: emit instructions to first check the whole corresponding
>     shadow byte, it it's 0, access is legitimate, jump back to the
>     actual memory access
>   - slow path: if the shadow byte is not 0, emit a call to the relevant
>     __asan_load/storeXXX to validate or report the access.

Are you sure compilers do this optimization for KASAN?
I don't remember ever seeing it in assembly.
It sounds interesting, but let's do it in phase 2 when the whole
thing is working and we start optimizing speed.

>
> # Memory tracking
>
> For this instrumentation to behave correctly, the monitored memory must
> be tracked accordingly. The method used by KASAN is to allocate some
> "shadow memory", which allows monitoring 8 bytes of memory with 1 byte
> of shadow memory. Legit memory must have its corresponding shadow area
> "unpoisoned", and must be poisoned/quarantined again once accesses are no=
t
> legitimate anymore. There are different memory types, with some of them
> already covered/monitored:
> - data passed to programs: KASAN on kernel side is already taking care
>   of {un}poisoning this memory, so we can check directly the
>   corresponding shadow memory.
> - bpf global variables: global variables in bpf programs are turned into
>   maps. Those maps, when created by the kernel, are then already
>   monitored (ie: poisoned/unpoisoned) when the corresponding memory is
>   allocated/deallocated. I did not check all maps, but looking at a few
>   of those, they are vmalloc'ed, so the proper monitoring will depend
>   directly on CONFIG_KASAN_VMALLOC

bpf global vars are in bpf array. So there is a shadow memory for it.

As far as other map types. There is arena and it's special.
load/store to arena are JITed differently already.
They cannot be instrumented for kasan.

> - bpf stack: when a program allocate some memory on its own stack, it is
>   not tracked by KASAN. To be able to track stack memory misusage, JIT
>   compiler must insert some red zones around the variables on the stack.
>   This point looks more complex than the previous ones, as we need to:
>   - identify variables that live on bpf program stack instead of
>     registers
>   - insert asan left/right red zones, and possibly inter-variables red zo=
nes
>   - and so account for this "stack overhead", eg in the verifier
>   I then propose to put this "stack monitoring" as a next step, to be
>   implemented once we have a basic kasan monitoring integrated in x86
>   JIT compiler.

I'm not sure it can be deferred. Pretty much all bpf programs
access stack with load/stores.
So all of such instructions should not be instrumented.
It shouldn't be hard to do though.
The verifier knows all stack accesses.
It can mark such LDX/STX insns in insn_aux_data with some flag.
Currently JITs don't have access to verifier info,
but that's the direction we're going to:
See proposal:
https://lore.kernel.org/all/CAADnVQLha64x_LQ1Ph+0dEdP2sNms71k41pwEVMwxrbBG7=
8M5Q@mail.gmail.com/
It was couple weeks ago. If Xu Kuohai isn't going to follow up
then this can be a prerequisite.

>
> # Integration
>
> - KASAN monitoring for eBPF programs can be set under a new
>   CONFIG_KASAN_EBPF kconfig
>   - will likely depend on a few other Kconfigs, eg CONFIG_BPF_JIT, and
>     possibly a CONFIG_HAVE_KASAN_EBPF, that would be set for x86 only
>     for now
> - I am also thinking about adding a sysctl (present and enabled by
>   default if CONFIG_KASAN_EBPF=3D1), to allow temporarily disabling KASAN
>   for ebpf programs. When set to 0, JIT compiler would stop inserting
>   checking instructions in new programs being loaded.

I'm not sure that sysctl is necessary. If the kernel is compiled
with kasan and JIT supports it, it should go and instrument all progs.
We can add sysctl later if necessary.

> # Testing
>
> This new KASAN feature must obviously come with some tests. I'd like to
> find a way to trigger KASAN reports in ebpf programs without having to
> alter the verifier specifically for testing. I am thinking about
> creating dedicated _faulty_ kfuncs in
> tools/testing/selftests/bpf/bpf_testmod.c, and a corresponding bpf
> program:
> - those kfuncs would return kernel data to be used by the test program,
>   but they would trigger a variety of issues, eg:
>   - returned data has already been freed
>   - returned data is not pointing to the beginning of an allocated
>     buffer but at an arbitrary offset in this buffer, making the caller
>     potentially perform OoB accesses
>   - etc
> - ebpf programs would trigger kasan reports when trying to access the
>   corresponding data, the test would be about making sure that the
>   report is indeed triggered

Everything else makes total sense.
Thank you for working on it.
