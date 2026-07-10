Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A02BE03B
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 19:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783711191; cv=none; b=FpnulH7KGdW5txlrdGGVgJ9JDwFX+T8mcF2vaK6dbmNCvxYEwl2/pEOlDtP2MMtZ4oqnOZylYhueGpqKrvgJleaQK30RWkfKhdzR2FJ7g268hGl9VFXKVMQds2B9XVFTW7oHCRYpqVU///iR4+O/2M0YFpVLGoXuCb5bSdYhqXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783711191; c=relaxed/simple;
	bh=MDuyKwOnI4c8UkUFug0giLAGO1E70cqFGeZjVC9YgZY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jgFBsrFD9mHHnZ6bU4aqGE2JEmSN15AbTpvhZaMGVTFLm5ixyVu9AQv7yKOZZ+TF1RIggh0wT0g+uB3ybEHABaOc/g7a9QFzPN5k4GsbaVkfE5QSbXGm08O9YqQYQIWeyUeR1G2hWm7guVnRwOTtXY1EM8MWn5/UKxVIod36AyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=bwAZe7UQ; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="bwAZe7UQ"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca97d139d5fso979606a12.0
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 12:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783711188; x=1784315988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=07skD6UBUnzDgRpfjlevYHiGMN3WuSNHUvliv5fl0GM=;
        b=bwAZe7UQcrCpuzYmhRBeNRmfKKTRR9XrwufRREp5aNuocPtpoNUKxKQS9GCqNe7PD1
         1D+vEclOFcZ+86WhR4M2tsKpLDrW8ptSzpVPZIr+fPWIMw6lL2uKpRdxxs7/Q5mLJyS/
         dfXRwj07tjXUl5aDot7rTaJKlYJZpossn1Q1QZqj05mrbmIzWz0TDRPmgMmNzG3WfNFF
         nFh1j1aNmQR8Gi19PYRatpIYrJ1FgDbqCvBpyM27vaTV5b345Xd1kq1l6/l94Y4oHWI9
         qKaSiEXJJotkCN/BXj5D0eXxcWY9xjSHvNiBaDndwZ2UR+781Sx/4WfLcG4TdiM96AJ9
         T81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783711188; x=1784315988;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=07skD6UBUnzDgRpfjlevYHiGMN3WuSNHUvliv5fl0GM=;
        b=ELaoj8Dy0WAQZOowl5sv6ipgVwBLsezEBNqOTmUUFlVSvkjvQX2LJLMMlTAflZExm2
         IUJz+wBTlCEWNVndwqLUTSFnVMhR62NlNYR1dRBTTmKhYHskpJ+oyEv4lQiYd+XRc277
         znsTIIh3efnIrJm1POJ1ejwZ25ZKgfWzSW1s58d1bza30cmXWY7clf4moQNpXyDs64By
         MUQhvtu4LxJ41M+ZJpMj7z0xs/UtULc4HWDMuJ9yqHMaSrJHjZLmgY95DsS9V72M+GB2
         VeCtnPxCX7ylHEdcCzFgS2QZRiwxBjATFpNuA4TJTCHkoPesYhcXYgrbGP+GuomPwkAb
         VAFQ==
X-Forwarded-Encrypted: i=1; AHgh+RpvcAuTLX+nc1b1Oq8WPHgRhMcqnb0DInQaqv/aohE0o+0zlIPYvTifiHFQVDUQQw/umYw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbWwI2HALmpjMdeLnfbBVxcOZxTTMdNkp53DEnrynIgeW1Z9JH
	2IjCXQSXD2LQLUX3qz4d90nFaGw+nf5eZYj+WzbERC61OJ5lK6fhoqRMM5PaxklJdCsCdVid61r
	fHbK7ytnwspM=
X-Gm-Gg: AfdE7clQDK+fZjUl0J/fKIrCTVkQkBhesIbBcqYJoZ0sbys3HMCGYLgNHA5bmgs9P/1
	J8YHqQkEdtwrHis+In5Lx3vP+twTOT0MLzZbAmhtyqH74gcTfNfozR2qbgC0+iNLpQu18OCd8PY
	vt/j5at7TjGO47dXjrGdCoa14ggLmY4hcHsa2jWd8f0pHTRcslcDU1b1p3L9CIt1YGy+nv1tzOC
	DKVOqsXgZZnovrWkWLZqpb5w6d3fjlkAawfTmkn4x9n8mMf9LcgIfBRKSOGOyFTNdhLdysYzIKg
	8pXqMb7ubyTUQEwpPbl2eSyes2e3PY7HddvoB/Rd6nluMW8hAXtSCRaFVeg6kS/9TUd/tzfGGsn
	GgM3trt2v9qs5veFODsN/XNpA8al8oJzFU8hjAkXKVK3/+48KtDdjEUq2BZkaDWhEy9LfsFtM+n
	4fv8GtUtUniWeL1vfUoCC4ag8i1jUWITApiwa+60gIBlKGAVl5dICIDH8QEKeCMIhGiZ/y3A==
X-Received: by 2002:a05:6a20:d49a:b0:3bf:6c08:fba2 with SMTP id adf61e73a8af0-3c110ba295dmr342869637.54.1783711188004;
        Fri, 10 Jul 2026 12:19:48 -0700 (PDT)
Received: from rip.tailfedc6c.ts.net (149-169-99-5.nat.asu.edu. [149.169.99.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3118ee6091dsm41912582eec.14.2026.07.10.12.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 12:19:47 -0700 (PDT)
From: Jennifer Miller <jmill@asu.edu>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	kees@kernel.org,
	linux-hardening@vger.kernel.org
Cc: jmill@asu.edu,
	xmei5@asu.edu,
	samitolvanen@google.com,
	peterz@infradead.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next v1 0/1] Enable BPF JIT hardening by default when x86_64 CFI is enabled
Date: Fri, 10 Jul 2026 12:19:31 -0700
Message-Id: <20260710191932.120911-1-jmill@asu.edu>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi all,

As part of some academic research we, Xiang (CC'd) and I, found three
(closely-related) methods for bypassing different configurations of
x86-64 CFI schemes (kCFI and FineIBT). The methods have some limitations
which I will provide further details on in the rest of this mail.
We previously reported this to security@k.o and were encouraged to have
a public discussion about hardening against this, rather than dealing
with it in private.

In short, the cBPF JIT code can contain controlled 32-bit immediates
which can be used to partially or fully craft CFI hashes and endbr64
instructions to bypass control flow integrity mitigations. To mitigate
these bypasses we'd recommend enabling JIT Constant Blinding for
unprivileged users by default (bpf_jit_harden=1) when CFI is enabled.
I have included a potential patch that does this, I am not sure though
if this change could somehow be more local to CFI related code, or if
it'd be better to modify the function that controls whether JIT blinding
is enabled (bpf_jit_blinding_enabled) rather than touching the sysctl's
default value.

For some additional context, in the past few years misaligned
instructions in the cBPF JIT region have become a somewhat common target
for Control Flow Hijacking exploits because they provide constrained
shellcode execution, a number of submissions to Google's KernelCTF
program have used this approach[1-3]. There is randomization applied to
start of the JIT code so it is probabilistic whether control flow is
hijacked to the expected code, on a system where panic on oops is not
enabled it is possible to retry until the attack succeeds.

We have a PoC exploit for each method, where we took an existing exploit
and demonstrated that we can get code execution from control flow
hijacking on a kernel with CFI enabled, we can share more details about
those about if desired.

There are three methods, each under different configurations:
1. Full Hash Forgery
    - Bypasses kCFI, kernel versions >= 6.2
2. Endbr64 Forgery + Pivot
    - Bypasses FineIBT
3. Opcode Collision Forgery
    - Bypasses kCFI, for kernel versions < 6.2


1. Full Hash Forgery

This method applies when CONFIG_CFI=y and CONFIG_FINEIBT=n or when
CONFIG_FINEIBT=y but kCFI is being used, either as a fallback (AMD) or
forced via `cfi=kcfi` on the kernel cmdline. However, if
CONFIG_FINEIBT=y then a leak of a kCFI hash or the random value that is
xored with the hashes to randomize them (via an arbitrary read or
otherwise) is necessary for this to work.

CFI hashes are four bytes long and it is only possible to forge at most
four consecutive bytes in JIT code using 32-bit immediates. When
CONFIG_FINEIBT=y, the hash is stored at [dest-0xf] (offset depends on
function alignment config but -0xf is where it is at by default) where
'dest' is the target of indirect control flow. If the target hash is
0x21524111 when kCFI is in use, then the negation of the hash is must
be forged in the immediate (-0x21524111 == 0xdeadbeef).

insn0 = {.code = BPF_LD + BPF_K, .k = 0xdeadbeef}; // hash
insn1 = {.code = BPF_LD + BPF_K, .k = 0xcafeb0ba}; // filler
insn2 = {.code = BPF_LD + BPF_K, .k = 0xcafeb0ba}; // filler
insn3 = {.code = BPF_LD + BPF_K, .k = 0xc3d42948}; // code

Produces:
mov eax, 0xdeadbeef
mov eax, 0xcafeb0ba
mov eax, 0xcafeb0ba
mov eax, 0xc3d42948

At the kCFI protected callsite:
[dest-0xf] == 0xdeadbeef (hash check succeeds)
[dest] == 0xc3d42948 == `sub rsp, rdx; ret;` (pivots the stack)


2. Endbr64 Forgery + Pivot

This method applies when CONFIG_FINEIBT=y and FineIBT is used at
run-time. An endbr64 instruction can be crafted in  a 32-bit JIT
immediate and the aligned instructions that follow will be executed
afterwards. This method is *highly* constrained in which callsites can
be used, we have only found one viable callsite so far. If FineIBT
paranoid is enabled, which is true by default for existing Intel CPUs
but not for future CPUs with support for FRED, then a leak of a kCFI
hash is required.

Since the kernel uses rbp as a general purpose register when frame
pointers are omitted it is possible to find call-sites where rbp points
to a heap chunk. BPF JIT code ends in a `leave; ret` sequence, so if rbp
points to the heap then after executing this sequence the heap pointer
will become our new stack when returning from the JIT code, achieving a
stack pivot to the heap. Not only does it need to point to a heap chunk
but [rbp+0x8] must be controlled for the stack pivot to be useful (there
needs to be at least one ROP gadget there to a longer ROP chain
elsewhere in memory). As previously mentioned, we have only found one
case of a call-site where this is possible. Enumerating all call-sites
where this is possible is non-trivial, so we are still unsure of how many
there actually are.


3. Opcode Collision Forgery

This method only really applies when CONFIG_CFI_CLANG=y on kernels with
support for kCFI before FineIBT was merged (pre 6.2). More recent
kernels default to placing padding after the CFI hash rather than before
it. Without FineIBT, CFI hashes are not randomized on boot so a leak is
not necessary.

Prior to 6.2 the padding for CFI stubs was hardcoded to be before the
hash, making it more difficult to forge a full hash in an unaligned JIT
instruction while maintaining control flow hijacking. Using the full
four bytes of a 32-bit immediate to forge a hash would result in aligned
instructions after the hash being executed and would likely result in a
fault when the JIT code tries to return. To maintain code execution
avoid using all four-bytes of the immediate and instead reserve a few
bytes following the hash to craft a jump instruction to the next 4 byte
immediate and continue with the limited shellcode execution in unaligned
instructions. Not crafting all four bytes of the hash in the 32-bit
immediate means that an "opcode-collision" is necessary to craft the
full hash, which looks something like this:

insn0 = {.code = BPF_LD + BPF_K, .k = 0x7fdb0000}; // hash part 1
insn1 = {.code = BPF_LD + BPF_K, .k = 0x9002eb1a}; // hash part 2 + insn

Produces:
mov eax, 0x7fdb0000
mov eax, 0x9002eb1a

Combined:
b8 00 00 [db 7f b8 1a] eb 02 90

At the kCFI protected callsite:
[dest-0x4] == 0x1ab87fdb (hash check succeeds)
[dest] == 0x02eb == `jmp .+4` (continue control flow hijacking)

Since 0xb8 is the opcode byte for the `mov eax` instruction, it is
possible to forge a kCFI hash such as 0x1ab87fdb using two instructions
in the JIT region and still retain limited shellcode execution through
code stored in 32-bit immediates.

There are a number of instructions that take 32-bit immediates that can
be generated in cBPF JIT (e.g., or, xor, and, sub, add, etc...), with
various opcode bytes which can collide with a CFI hash. Xiang enumerated
these instructions and did an analysis to see how many hashes could be
bypassed with this method on a 6.1 LTS kernel (pre-FineIBT so no CFI
hash rerandomization yet, compiled with the KernelCTF config plus the
configs necessary for kCFI), and found that approx 14% of the hashes
were able to be crafted via an opcode collision in the JIT code.


~Jennifer

[1] https://github.com/google/security-research/blob/master/pocs/linux/kernelctf/CVE-2023-3609_cos_mitigation/docs/exploit.md#spray-ebpf-programs
[2] https://github.com/google/security-research/blob/master/pocs/linux/kernelctf/CVE-2024-36972_lts_cos/docs/exploit.md#spray-ebpf-programs
[3] https://github.com/google/security-research/blob/master/pocs/linux/kernelctf/CVE-2025-21756_cos/docs/exploit.md#spray-ebpf-programs


Jennifer Miller (1):
  bpf: Enable JIT hardening by default when x86_64 CFI is enabled

 kernel/bpf/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--
2.34.1

