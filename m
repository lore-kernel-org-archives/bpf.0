Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A450F33D6C8
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 11:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770377505; cv=none; b=rVveibdmGK810PyW80ceErgHhVHMI97e7SOyKH4qivbi4S+byxB7HE8saXXYuPxCQ2tBktkuAOTffr05ABrQ7adq96sAHVMJnhG0PSHD5O6/lL9fZrIf/bGnSi2f2L9SeA9HF0Sz3Yw/a+wiEHZQ7GOwEXwbz7LXuk7sdvTr7ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770377505; c=relaxed/simple;
	bh=apnDY6Kddwco21NSKCv9btdFF2DFGp0OaER17FkMt5U=;
	h=Content-Type:Date:Message-Id:Subject:Cc:From:To:Mime-Version; b=oqDz+BmDeRTQmPjIWSA4AKY0UQpYHK/FUUTJY67qEZ9UY1fVvZqaB+tc5vZkvbPdePEI39kwac/VkBxV0AGNgh1wsLDg6uiuRKEJU4IcNtJvKPjE6Wdxp7qa2pCq8Ib0xK8fyxuy4Yjzb32qbyi8e7ZW07QR1N/zUR43OnkKKkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tNVUDuET; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tNVUDuET"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 963574E4243E
	for <bpf@vger.kernel.org>; Fri,  6 Feb 2026 11:31:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6CDC860729;
	Fri,  6 Feb 2026 11:31:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9237B119D1C7D;
	Fri,  6 Feb 2026 12:31:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770377495; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=vGlltzjpygBI0zwsbcegnH/DJy30Hovhut7Q4RMQ40Q=;
	b=tNVUDuETczDA55het919Uv2QmYgucGCjV9pgqHqp8mVPgr6qEcqnr0+Lal8YIcdcsu5ZDY
	15TCYdm7oh0cFixi0L6S29RmOBR2dtr9q4gO4pNDeHbKbiodmusCyHmMpKe0TOWIdicuGy
	0Qui30kAAmcvP7fVojcE5i1nSaTVF4uHq1ehcZE6ETy5Dp4XDmE3If7zXyKVqpCZ0z1Ndd
	tS9aSyHCamngHrY7ZAzOaQ32I3g7ccTkjqCaKqY1PEIQng3D+CVMtZVTX3eCtBgQYiSUui
	WbnY4gxC1pHNtQxdY4b/yC+wIVTXXE+xlrtEFqvtrv11rlpX3VqzbDV8YfP57g==
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Feb 2026 12:31:34 +0100
Message-Id: <DG7UG112AVBC.JKYISDTAM30T@bootlin.com>
Subject: [RFC] adding KASAN support to JIT compiler(s)
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, "Bastien Curutchet (eBPF Foundation)"
 <bastien.curutchet@bootlin.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Daniel Borkmann" <daniel@iogearbox.net>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "bpf" <bpf@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: aerc 0.21.0-0-g5549850facc2
X-Last-TLS-Session-Version: TLSv1.3

Hi everyone,

I am starting to work on adding KASAN support for loaded programs in the
kernel (in the context of the sponsorship granted to the eBPF Foundation
by the Alpha-Omega project, see [0]). I have done a bit of
research/experiments, but before actually writing and sending things
upstream, I'm sharing here what I understood on the requirement overall,
and how I am currently considering to implement it. Please feel free to
correct or enrich any part below!

# Brief

Once a program has passed the verifier (and have been JIted into native
code), we have strong guarantees that its _behavior_ will not trigger
bugs like infinite loops, invalid access on input context, NULL pointer
dereference, and so on. However, eBPF programs can still generate
invalid memory accesses in some scenarios:
- programs validated behavior relies on the hypothesis
that the tools (helpers, kfuncs) and data (eg kernel data) provided to
eBPF programs are sane: eg if a pointer returned by the kernel to a
program is somehow bogus (used after free, triggering out of bounds
accesses, etc), a bpf program that has been validated by the verifier
will happily use this pointer.
- there could be a bug in the verifier and/or the JIT compiler, letting
  invalid accesses slip through

To help detect those issues, Address Sanitizing can be implemented for
loaded programs.

Similarly to the KASAN tooling implemented for kernel code ([1]), the
goal will be to instrument any load/store performed by loaded eBPF
programs.  This means detecting those load/store in eBPF bytecode (when
being processed by the JIT compiler), and insert calls to the
corresponding __asan_loadX/__asan_storeX before those accesses,
similarly to what compilers do for KASAN. The major difference here is
that this instrumentation will not be inserted at program build time: it
will be inserted dynamically by the JIT compiler, while it is turning
the eBPF bytecode into native machine code (and so, this work will focus
on jit-enabled systems). I am considering this general process:

# Basic instrumentation

- start in do_jit(), in arch/<$ARCH>/net/bpf_jit_comp.c
  - note from Alexei: let's focus on x86 instead of all architectures.
- in the main loop going over all instructions, for all load/store
  instructions
  - note from Alexei: let's focus on LDX/STX for now instead of _any_
    load/store instruction to keep JIT complexity reasonable
- identify the size (b, h, w, dw) and type (read/write) of the access.
  Depending on those two, define the __asan_XXX function to call (those
  functions are defined in mm/kasan/generic.c, and are basically
  wrappers around check_region_inline)
  - I did some tests, emitting explicit calls to the __asan_load/store
    checkers implemented in the kernel directly into the jitted code,
    and it seems to be fine to call those from bpf execution context
- similarly to what ASAN is doing ([2]), possibly implement a fast path/slo=
w
  path, mechanism:
  - fast path: emit instructions to first check the whole corresponding
    shadow byte, it it's 0, access is legitimate, jump back to the
    actual memory access
  - slow path: if the shadow byte is not 0, emit a call to the relevant
    __asan_load/storeXXX to validate or report the access.=20

# Memory tracking

For this instrumentation to behave correctly, the monitored memory must
be tracked accordingly. The method used by KASAN is to allocate some
"shadow memory", which allows monitoring 8 bytes of memory with 1 byte
of shadow memory. Legit memory must have its corresponding shadow area
"unpoisoned", and must be poisoned/quarantined again once accesses are not
legitimate anymore. There are different memory types, with some of them
already covered/monitored:
- data passed to programs: KASAN on kernel side is already taking care
  of {un}poisoning this memory, so we can check directly the
  corresponding shadow memory.
- bpf global variables: global variables in bpf programs are turned into
  maps. Those maps, when created by the kernel, are then already
  monitored (ie: poisoned/unpoisoned) when the corresponding memory is
  allocated/deallocated. I did not check all maps, but looking at a few
  of those, they are vmalloc'ed, so the proper monitoring will depend
  directly on CONFIG_KASAN_VMALLOC
- bpf stack: when a program allocate some memory on its own stack, it is
  not tracked by KASAN. To be able to track stack memory misusage, JIT
  compiler must insert some red zones around the variables on the stack.
  This point looks more complex than the previous ones, as we need to:
  - identify variables that live on bpf program stack instead of
    registers
  - insert asan left/right red zones, and possibly inter-variables red zone=
s
  - and so account for this "stack overhead", eg in the verifier
  I then propose to put this "stack monitoring" as a next step, to be
  implemented once we have a basic kasan monitoring integrated in x86
  JIT compiler.

# Integration

- KASAN monitoring for eBPF programs can be set under a new
  CONFIG_KASAN_EBPF kconfig
  - will likely depend on a few other Kconfigs, eg CONFIG_BPF_JIT, and
    possibly a CONFIG_HAVE_KASAN_EBPF, that would be set for x86 only
    for now
- I am also thinking about adding a sysctl (present and enabled by
  default if CONFIG_KASAN_EBPF=3D1), to allow temporarily disabling KASAN
  for ebpf programs. When set to 0, JIT compiler would stop inserting
  checking instructions in new programs being loaded.

# Testing

This new KASAN feature must obviously come with some tests. I'd like to
find a way to trigger KASAN reports in ebpf programs without having to
alter the verifier specifically for testing. I am thinking about
creating dedicated _faulty_ kfuncs in
tools/testing/selftests/bpf/bpf_testmod.c, and a corresponding bpf
program:
- those kfuncs would return kernel data to be used by the test program,
  but they would trigger a variety of issues, eg:
  - returned data has already been freed
  - returned data is not pointing to the beginning of an allocated
    buffer but at an arbitrary offset in this buffer, making the caller
    potentially perform OoB accesses
  - etc
- ebpf programs would trigger kasan reports when trying to access the
  corresponding data, the test would be about making sure that the
  report is indeed triggered

Alexei also made me aware that Emil Tsalapatis is working on adding ASAN
for bpf arenas ([3]). The main difference is that Emil's sanitizing will
be directly included in the bpf bytecode, while this RFC proposes to
inject ASAN checks in the JITed code. Also, Emil's series seems to need
dedicated KASAN support as it aims to sanitize accesses on memory
returned by the custom allocators brought by this same series (on top of
bpf arenas).

This plan is based from some small tests and quite a lot of code
reading, I hope not to miss any major feature and/or technical
constraint, hence this RFC. Once again, feel free to correct me and/or
challenge this plan.

Alexis

[0] https://alpha-omega.dev/grants/grantrecipients/
[1] https://www.kernel.org/doc/html/latest/dev-tools/kasan.html
[2] https://github.com/google/sanitizers/wiki/AddressSanitizerAlgorithm#map=
ping
[3] https://lore.kernel.org/bpf/20260127181610.86376-1-emil@etsalapatis.com=
/

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
