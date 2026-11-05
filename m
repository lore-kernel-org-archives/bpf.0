Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896706;
	b=eQ3ZgQWIt1IbQrhIn7gza9Zfd9GViqoXbilZZK9WFjNDQuA4Vzx0bwNnwHd62C9irNUc
	 cwcVAAX+qlaWchf6tIfo4Ju3GSecbShudnFfx0GtOxbdhoOB5iuv/gwkgMkU2qRKSmTMM
	 JRW3ry7V1JRlbn4bsQSi7Nbw3TW+NUmHEs7IRRvvVomOWaBK27h00tAlHWk5u3dv4Pj3v
	 gutpmP3TpFnnCc2RG8lJVcgD+ChBXRw0VVqWxr0B/ojWxev/FcBEDJkGK1kkUgESZJv3s
	 4/4PDXexBnBzjX19wUeBaSargJ/j0cA5xFVaWil6GSSam/DidA6uA054saD03UE0uTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896706;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=eGJncRZo7pGOtgDIQrvzb7fQrMtZ5o5Cn5x2f91k7gQ=;
	b=4w0nErOFCUJtms5+s7p42h0x+7oorwncTmSMDgLedyoDHcVsqH/Wa4Rr55LbV6UmLwRW
	 Oo/dwUmg7l8rL214TCfAPVqN8Q6mGiHIWPnT6X+C0zA2Do1HA/GZJqfN0MZm3y65l2eja
	 tvr2EoRSovFjZViL67Ge7F8FlAbcJ1PMRzK7VEyLIZvNaQppZF3SRmmHNh5j84Gx0oz8R
	 IvJjGHErJXHvwP/kmrhyRlE3aIkEIfwK5puJwfUr+8BfFnaRj0jldiUNEmOj4kHWZeCY7
	 JKFXaTCsXodpD/g6gpng1z/TVzwDkkfKNiqzXVjazO5Q8RWbEf2EbsyK2JrSHMvunyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.171
Received: from esa4.hc555-34.eu.iphmx.com (esa4.hc555-34.eu.iphmx.com [207.54.77.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C4C606A32C;
	Thu,  5 Nov 2026 16:38:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8C4C606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1793896702; x=1825432702;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=WvyUYNeaZ1LL9KGoOQ7tav19Ed1rArF0jm0dRRx4+Ug=;
  b=TV5JssVhOEKiLOvJ+MqV+KLxQ81QiNt9aqECl7hIb0v8aLZSrN1+rDmo
   tMJLQEjhlelVAOUu9obwC4nIpxEYoSEJEIyF4JCsNtMBksYVYhSZw+FQs
   DcQXC6iuHePFuyDuhVifMyuKwOhF17RPrJfwOtYvFvgg135sEPJd1oUIC
   S7XnGzS0MYuiRXPl9cfqOgpu/Rj0bYfgH7URwts7ROI+i1DeI4J5BVgid
   kQFioOB+1XW+kuU6z7wxQB9m08/sG0j61wJ3wxQJm1t5ja2lhPKJtUFSX
   hKGGj+uY/IxQcRf+dVaGdsToe9AitgcCwQ2/lmObRfg6N27L4b1Hwi+su
   g==;
X-CSE-ConnectionGUID: kxlx5RjZRbCDeUXhqehlfg==
X-CSE-MsgGUID: tvmmzmU8TMWCEwyPNQvxEg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces03_data.me-corp.lan) ([146.255.191.134])
  by esa4.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2026 18:38:13 +0200
X-CSE-ConnectionGUID: 6zHfRl9qR8Wg4YoysQMoXw==
X-CSE-MsgGUID: snS1cDkuTMebzCQMYkG3wA==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces03_data.me-corp.lan with SMTP; 05 Nov 2026 18:46:01 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Thu, 05 Nov 2026 18:38:11 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: [PATCH v5 0/3] riscv: support CPUs with slow Zaamo
Date: Thu, 05 Nov 2026 18:37:35 +0200
Message-Id: <20261105-lrsc-only-v5-0-f0648f57b2e1@mobileye.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANCw7GoC/12MQQ6CMBBFr0K6tmamLURceQ/jwg6DNAFKWtNIC
 He3sJG4mMWb/PcWETk4juJaLCJwctH5MUN5KgR1z/HF0jWZhQJVASqQfYgk/djPkggqo1RbWos
 i76fArfvsrfsjc+fi24d5Tye9ffcK5jtUkpYgmVRNF6yhtXgbvHU9z3wmP4gtlMxPRsCjbLJsG
 BtAMJW2+k9e1/ULdy9YjeIAAAA=
X-Change-ID: 20260120-lrsc-only-cc06422f5bb1
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Chao-ying Fu <chao-ying.fu@globalfoundries.com>, 
 torvalds@linux-foundation.org, olof@lixom.net, 
 aleksa.paunovic@htecgroup.com, arikalo@gmail.com, 
 Boqun Feng <boqun@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
 =?utf-8?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn@kernel.org>, 
 Pu Lehui <pulehui@huawei.com>, Puranjay Mohan <puranjay@kernel.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Boqun Feng <boqun@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vladimir.Kondratiev@mobileye.com, bpf@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
X-Mailer: b4 0.16.0

RISC-V split the A extension into Zaamo (AMO*.w/AMO*.d) and Zalrsc
(LR/SC). The kernel puts "a" in -march and emits AMO for atomic_add,
bitops, xchg and the like, and LR/SC for cmpxchg.

Zaamo is not always native. On MIPS P8700 [1] every AMO instruction
traps into M-mode and is emulated there, so the extension is formally
supported, and advertised to userspace, but very slow. A typical
uncontended atomic increment costs:

  native AMO                                     2..5 cycles
  LR/SC, private L1 reservation monitor         6..12 cycles
  LR/SC, PoC (L2) reservation monitor       about 40 cycles
  AMO emulated by an M-mode trap           about 600 cycles

The last two were measured on the eyeq7h hardware. On such a CPU the
kernel has to use LR/SC for every atomic.

Mobileye is going to use the "eyeq7h" platform, built on this CPU, for
ADAS and autonomous driving. Kernel atomics are on the scheduling,
memory-management and driver paths of that product, so the emulated
AMO cost is not acceptable there.

Patch 1 adds RISCV_ISA_ZAAMO. It defaults to y and nothing changes:
-march keeps "a" and the generated code is the same. When it is turned
off, -march carries _zalrsc instead of "a" and every kernel atomic is
an LR/SC loop. Such a kernel runs on any hart that implements A, it
just does not use AMO, so the option does not depend on NONPORTABLE.
Turning Zaamo off needs a compiler that accepts _zaamo and _zalrsc in
-march; GCC 15.1 is the first release that does.

The choice is made at compile time rather than with alternatives.
Nearly every CPU has a native A extension, and an alternative would
inflate all those kernels with the nops needed to pad one AMO to the
size of an LR/SC loop, at every atomic site, for the benefit of a few.

Nothing changes for userspace. The hart still advertises "a", which is
true. Userspace that cares can know about the slow AMO upfront, or
measure it.

Zalrsc stays mandatory. cmpxchg, conditional atomics and futex CAS are
already LR/SC sequences; Zaamo cannot replace them. RISCV_ISA_ZALRSC
is always y and exists as the Kconfig counterpart of
RISCV_ISA_EXT_ZALRSC, which hwcap.h already has next to
RISCV_ISA_EXT_ZAAMO; the two sets are tested together, for example by
rv_ext_enabled() in the BPF JIT. RISCV_ISA_A exists for the same
reason, paired with RISCV_ISA_EXT_A.

Three sets of extensions provide every atomic Linux needs: "a", which
is what the kernel supports today; Zalrsc plus Ziccrse, which this
series adds, with Ziccrse as the forward-progress guarantee for the
constrained LR/SC loops; and Zaamo plus Zacas, with CAS loops in place
of LR/SC as on x86. The series leaves the last one open:
RISCV_ISA_ZALRSC is where it would go, by allowing "n" there and making
amocas the base implementation.

The BPF JIT encodes its own atomics. Patch 2 makes it emit LR/SC loops
when Zaamo is disabled, so BPF programs do not trap either. The Zabha
and Zacas paths in the JIT and in cmpxchg.h are selected at runtime
from the ISA string; firmware for a CPU that emulates AMO should not
advertise them, as both extensions are AMO.

A breakpoint inside an LR/SC sequence drops the reservation and the
loop never completes. With every atomic an LR/SC loop that is easy to
hit, so patch 3 makes kprobes and uprobes reject such addresses.
kprobes walk from the enclosing symbol; uprobes scan forward using the
constrained-sequence rules from the ISA. This patch fixes a problem
that exists today, since cmpxchg is already an LR/SC loop. It does not
depend on the rest of the series and can be merged on its own.

[1] https://mips.com/products/hardware/p8700/

Changes in v5:
- Treat Zaamo as supported but slow rather than absent. The hart keeps
  advertising "a" and the kernel keeps accepting it, so the boot-time
  extension check patch is dropped.
- Drop the NONPORTABLE dependency. A kernel built without Zaamo runs
  on any hart that implements A.
- Rename TOOLCHAIN_HAS_ZALRSC to TOOLCHAIN_HAS_ZALRSC_ZAAMO and test
  both _zaamo and _zalrsc in -march.
- Explain why RISCV_ISA_ZALRSC and RISCV_ISA_A exist, and why the
  choice is made at compile time rather than with alternatives.
- Add the BPF JIT patch. Without Zaamo the JIT emits LR/SC loops for
  the BPF read-modify-write atomics on RV32 and RV64, and reserves a
  second exception-table entry for the sc of an arena atomic.
- Reject kprobes and uprobes on lr and sc, and on any instruction
  between them.
- Link to v4: https://patch.msgid.link/20261101-lrsc-only-v4-0-4e1d010463b3@mobileye.com

Changes in v4:
- Require a compiler that accepts _zalrsc in -march before Zaamo can
  be disabled. GCC 15.1 introduces that support. Older compilers keep
  Zaamo enabled and -march keeps "a".
- Link to v3: https://patch.msgid.link/20261026-lrsc-only-v3-0-ec29c8190fb1@mobileye.com

Changes in v3:
- Make Zalrsc mandatory. cmpxchg and the conditional atomics already
  use LR/SC, so RISCV_ISA_ZALRSC can no longer be turned off.
- Check AMO and LR/SC support independently. A kernel that emits both
  requires "a", or both "zaamo" and "zalrsc".
- Put the LR/SC bitop sequence in its own block so two inlined
  set_bit or clear_bit calls compile.
- Remove the LR/SC loop that ran after the hart lottery and accessed
  address 1. Build the lottery increment with add so RV32 assembles.
- Add an exception-table entry for sc as well as lr in the futex
  LR/SC helper.

Changes in v2:
- Switch from a runtime choice of atomic implementation to a
  compile-time one, gated by NONPORTABLE.

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
---
Vladimir Kondratiev (3):
      riscv: build kernel atomics from LR/SC when Zaamo is disabled
      riscv, bpf: emit LR/SC loops when Zaamo is disabled
      riscv: probes: reject probes inside an LR/SC sequence

 arch/riscv/Kconfig                     |  53 ++++++++++++++++
 arch/riscv/Makefile                    |  16 +++--
 arch/riscv/include/asm/atomic.h        |  52 +++++++++++++++-
 arch/riscv/include/asm/bitops.h        |  47 ++++++++++++++
 arch/riscv/include/asm/cmpxchg.h       |  16 +++++
 arch/riscv/include/asm/futex.h         |  45 ++++++++++++++
 arch/riscv/include/asm/insn.h          |  28 +++++++++
 arch/riscv/kernel/entry.S              |   7 +++
 arch/riscv/kernel/head.S               |  12 ++++
 arch/riscv/kernel/probes/decode-insn.c |  94 ++++++++++++++++++++++++++++
 arch/riscv/kernel/probes/decode-insn.h |   7 +++
 arch/riscv/kernel/probes/kprobes.c     |  22 ++++++-
 arch/riscv/kernel/probes/uprobes.c     |  31 ++++++++++
 arch/riscv/net/bpf_jit.h               |   1 +
 arch/riscv/net/bpf_jit_comp32.c        |  81 +++++++++++++++++++++++--
 arch/riscv/net/bpf_jit_comp64.c        | 108 ++++++++++++++++++++++++++++++++-
 arch/riscv/net/bpf_jit_core.c          |  29 +++++++++
 17 files changed, 636 insertions(+), 13 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20260120-lrsc-only-cc06422f5bb1

Best regards,
--  
Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

