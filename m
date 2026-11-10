Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=207.54.77.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317123;
	b=4HyXou7zCwUcrrgkRIFQ8Zgp0EVxGd7ZkRx1+YdcSQczaXLZqXMVQygw/bUplKdz0DK1
	 4/gQpLE/R1uO9WNMXHVaCNEcpABNdyRvvK2T6HMX4YiH8GyXGiHtxQ7UnJMvb1U0MPVCt
	 9STCbyfSiCKFUvEHOjFHa3tCV4Nc8cHGbeLORjzXNpLJEKZxKcRo2WG+/HSH2jte3rXXZ
	 ynd9IFgpWE7YB++lyaR58gReHD1oTOdk6dqxZ9WdIgZxpHlHkMLzGy0LzD9BGVLpwwroN
	 vM9qV7463YiT/LZnDjP1mk16OSqQu6k/q+DmZifd2XzYXgFDdi2J1i5TiDCUZ6sc7/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317123;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-Amp-Result:X-Amp-File-Uploaded:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=1HcQRU24a1N1wxCF46Q1BL7VR4te5rMjnRwtqwYW0C8=;
	b=i4S0LZzORFTmYMP3l0Ly8mD+SRaectW0TGzozRIAyr3YCk2XH0JvOsCr2Mtx00UFbIs4
	 eZjmuAWAe+53lkkgVpOhlQ51CZvjH7PzGsrZvtsCcVT7xPAu37sRKsrcJFTj3GK9xEI5H
	 ykAo27d/btSdkQoGeArZEDPdT93ykLdttIPnxfntWKLbIYsZ98fGdatN5vlTq8Rst1gWW
	 izYLJjTSdfbujwUMNuChLrylEYvXoREqhOQUYvIgmlEhdjNP+wzitgc7591FSKtZedC6O
	 ZnMINgCxEOXUdMdARTVPWwzyg+jo+Jz9v8pggP7WBcXJqYkUgaoVVLYZYmPTy76RJcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mobileye.com;
	spf=pass smtp.mailfrom=mobileye.com;
	arc=none smtp.remote-ip=207.54.77.50
Received: from esa3.hc555-34.eu.iphmx.com (esa3.hc555-34.eu.iphmx.com [207.54.77.50])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81396606A330;
	Tue, 10 Nov 2026 13:25:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81396606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mobileye.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mobileye.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=mobileye.com; i=@mobileye.com; q=dns/txt; s=MoEyIP;
  t=1794317120; x=1825853120;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=qxIEV334y6g+Esme3fGjY9OI+Q/y/cHPKzSPAq+HTVw=;
  b=HuSoegsZtvwFfn4o9dp3mfnZC9OU83PmhlKaO6Qs+EtDcmMPf5Bd7I65
   7xB9L1zKY3vWAB9RQ2rcthDK8ZoKZUC2AsYS9DBr8a/7npIjcEpysahKA
   8FY50pBkY2z4K7o8HXcexeyq4LWASOQstq/CYWPtcbBITCfWNp+lglCin
   ugrH3cI2i7HpEhmMoMoF8BEMQgY+dhF7n7G+C+Ij5MLBTLGc4SxIog5sS
   dDd0bMO6dhtiQMTC13Jh4IgXv6Bhc+yME/bS/nbuHP2e2kQ/wtwXHaXAe
   iH5dDJQUBUkwFtA1IvWe6ojhOVrBrH5U5l61BDZrL+e/IxRDH9O5on9+0
   g==;
X-CSE-ConnectionGUID: TL0qhKkNTlGU3QBxuWKb7w==
X-CSE-MsgGUID: r82APvrTSaOi9k7UOj4kDQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO ces01_data.me-corp.lan) ([146.255.191.134])
  by esa3.hc555-34.eu.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2026 15:22:52 +0200
X-CSE-ConnectionGUID: YORbQvFuRaCxS+lZwqw9qA==
X-CSE-MsgGUID: 8uon9bWISS2zxiLTME+BrQ==
Received: from unknown (HELO epgd071.me-corp.lan) ([10.154.54.2])
  by ces01_data.me-corp.lan with SMTP; 10 Nov 2026 15:31:01 +0200
Received: by epgd071.me-corp.lan (sSMTP sendmail emulation); Tue, 10 Nov 2026 15:22:50 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
Subject: [PATCH v6 0/6] riscv: restrict the ISA used for atomics to avoid
 unsupported or slow AMO
Date: Tue, 10 Nov 2026 15:20:57 +0200
Message-Id: <20261110-lrsc-only-v6-0-bafc3cc0fcae@mobileye.com>
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
X-B4-Tracking: v=1; b=H4sIADka82oC/22PQQ6CMBBFr0K6tmamtAiuvIdxYctUmgA1rSESw
 t0tbGyMi1n8ybw3+QuLFBxFdi4WFmhy0fkxhepQMNPdxwdx16bMBIgKUADvQzTcj/3MjYFKCmG
 V1sjS/TOQde/ddb2l3Ln48mHe1VO5bXcLpsksU8mBkxGNqbEBq/EyeO16mulo/MA20SS/MALms
 EywJGwBQValLv/AKodVDqsE29ShtuqkBf1+Xtf1A7m7HtYfAQAA
X-Change-ID: 20260120-lrsc-only-cc06422f5bb1
To: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
 Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
 Mark Rutland <mark.rutland@arm.com>, Gary Guo <gary@garyguo.net>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Chao-ying Fu <chao-ying.fu@globalfoundries.com>, 
 Conor Dooley <conor.dooley@microchip.com>, torvalds@linux-foundation.org, 
 olof@lixom.net, aleksa.paunovic@htecgroup.com, arikalo@gmail.com, 
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
 Miguel Ojeda <ojeda@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Boqun Feng <boqun@kernel.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Vladimir.Kondratiev@mobileye.com, bpf@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
 Jonathan Corbet <corbet@lwn.net>, 
 Charlie Jenkins <thecharlesjenkins@gmail.com>, 
 Nam Cao <namcao@linutronix.de>, rust-for-linux@vger.kernel.org, 
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
X-Mailer: b4 0.16.0

The A extension is Zaamo (AMO*.w/d) plus Zalrsc (LR/SC). The kernel
requires all of it: -march has "a", atomic_add, bitops, xchg and the
like are AMO instructions, cmpxchg is an LR/SC loop.

This series lets the kernel restrict the ISA it uses for atomics to
Zalrsc, when the toolchain can express that, for CPUs where AMO is
missing or slow. MIPS P8700 [1] traps every AMO instruction into
M-mode and emulates it there. The extension is formally present, but a
typical uncontended atomic increment costs:

  native AMO                                    2..5 cycles
  LR/SC, private L1 reservation monitor        6..12 cycles
  LR/SC, PoC (L2) reservation monitor       about 40 cycles
  AMO emulated by an M-mode trap           about 600 cycles

The last two were measured on Mobileye's eyeq7h, which is built on
this CPU for ADAS and autonomous driving. Kernel atomics are on its
scheduling, memory-management and driver paths, so the emulated AMO
cost is not acceptable there. perf bench on eyeq7h, same tree built
with RISCV_ISA_ZAAMO=y and =n, same userspace, built with LR/SC
atomics in both cases so that only the kernel changes:

                                     ZAAMO=y     ZAAMO=n
  sched messaging, 400 processes     0.653 s     0.536 s    -18%
  futex hash, 24 threads          64131 op/s  79142 op/s    +23%
  futex wake, 24 threads            0.221 ms    0.168 ms    -24%
  futex requeue, 24 threads         0.064 ms    0.036 ms    -44%
  futex lock-pi, 24 threads         435 op/s    478 op/s    +10%

futex wake-parallel swings by an order of magnitude between runs on
both kernels and is left out. With the ZAAMO=y kernel the firmware
counter of emulated instructions, fw_illegal_insn, runs at about
4000 per second per CPU at idle, and at about 85000 per second on
CPU0, where network Rx runs, under iperf3 Rx traffic.

Patch 1 makes kprobes and uprobes reject a probe inside an LR/SC
sequence, where the breakpoint trap drops the reservation and the loop
never completes. Both scan forward from the probed instruction using
the constrained-sequence rules of the ISA. The problem exists today,
since cmpxchg is already LR/SC. The patch is independent of the others
and can be merged on its own.

Patch 2 adds RISCV_ISA_ZAAMO, default y, with no change to the default
build. With it off, -march carries _zalrsc instead of "a" and every
kernel atomic is an LR/SC loop, selected with the preprocessor like
the other ISA options. The loops use the ordering convention of the
existing LR/SC code: lr, sc.rl and a full fence when fully ordered,
lr.aq for acquire, sc.rl for release. The choice is made at compile
time rather than with alternatives, so the many kernels for CPUs with
native AMO do not pay for nop padding at every atomic site. Such a
kernel runs on any hart with A, so there is no NONPORTABLE dependency.
It needs a compiler that accepts _zaamo and _zalrsc in -march, GCC
15.1 or later; TOOLCHAIN_HAS_ZALRSC_ZAAMO keeps the option fixed at y
otherwise. Zabha, Zacas, userspace CFI and Rust emit AMO instructions
and depend on RISCV_ISA_ZAAMO. Zalrsc stays mandatory: cmpxchg, the
conditional atomics and futex CAS are LR/SC sequences. Zaamo plus
Zacas, with CAS loops as on x86, would also provide every atomic and
is left for whoever has such hardware.

Patch 3 makes the boot-time check accept a hart that lists "zalrsc"
alone, or "zaamo" and "zalrsc" instead of "a", when the kernel was
built for that. Userspace sees whatever the hart advertises.

Patch 4 sets A when a hart lists "zaamo" and "zalrsc" instead of "a",
so ELF hwcap and /proc/cpuinfo report the same ISA either way.

Patch 5 makes the BPF JIT emit LR/SC loops when Zaamo is off, so BPF
programs do not trap either.

Patch 6 measures at boot whether an uncontended AMO is faster than the
equivalent LR/SC sequence on each CPU and reports the answer to
userspace through a new hwprobe key, RISCV_HWPROBE_KEY_AMO_PERF, the
way the misaligned access speed is reported. On P8700 it says "slow";
a program or a runtime that can choose then knows to use LR/SC. This
patch is optional. eyeq7h does not need it: it is an embedded platform
whose userspace is built for the hardware, not a generic distribution
that has to find out at run time. It is here for whoever has to run
generic userspace on such a CPU.

How the pieces fit together, with "..." for the rest of -march:

  Hardware AMO  DT, cpuinfo  RISCV_ISA_ZAAMO  Userspace -march
  ------------  -----------  ---------------  ---------------------------
  native        a            y (default)      ...a, unchanged
  native        a            n                ...a; only the kernel
                                              switches to LR/SC
  emulated      a            y                ...a or ..._zalrsc; the
                                              kernel traps on every
                                              AMO. This is today.
  emulated      a            n                ...a runs but traps on
                                              every AMO; ..._zalrsc
                                              does not
  emulated      zalrsc       n (y: hart       ..._zalrsc; ...a still
                             rejected)        runs, slowly
  absent        zalrsc       n (y: hart       ..._zalrsc; ...a dies
                             rejected)        with SIGILL

The kernel expands "a" to zaamo and zalrsc, and with patch 4 folds
the two back into "a", so userspace sees the same ISA in hwcap,
hwprobe and /proc/cpuinfo whether the DT lists "a" or both
sub-extensions. For an emulating CPU the firmware chooses between
"a", which is formally true and keeps every existing binary running,
and "zalrsc" alone, which lets userspace that checks hwcap or hwprobe
know not to use AMO; with patch 6, hwprobe says so in either case.
Nothing in the series depends on the last column:
a kernel built without Zaamo runs userspace built either way. Building
userspace without "a" needs the same GCC 15.1 as the kernel and an
-march that spells out the base, e.g. rv64imfdc_zicsr_zifencei_zalrsc,
since "g" implies "a".

Tested on the eyeq7h hardware running locktorture for a several hours.

Conor Dooley NAKed the v5 Kconfig option [2] on the grounds that
Zalrsc-only hardware does not exist and the kernel should not carry
an option for an emulation workaround. The trailer is kept on patch 2.
The option is for hardware that exists, P8700 based eyeq7h, where the
alternative is a kernel that is unusably slow; the series is small,
compile-time only and leaves the default build untouched.

[1] https://mips.com/products/hardware/p8700/
[2] https://lore.kernel.org/linux-riscv/20261106-smock-headband-d6a7d568c228@spud/

Changes in v6:
- Fully ordered LR/SC loops in atomic_fetch_*, test_and_*_bit, xchg
  and futex are now lr, sc.rl and a trailing fence rw,rw, following
  commit 5ce6c1f3535f ("riscv/atomic: Strengthen implementations with
  fences"), instead of lr.aqrl/sc.aqrl.
- test_and_set_bit_lock uses lr.aq with a plain sc, and
  clear_bit_unlock and xor_unlock_is_negative_byte use a plain lr
  with sc.rl, instead of putting the ordering bit on both.
- Bound the futex LR/SC loop to 128 retries and return -EAGAIN, as
  arm64 does; futex_wake_op() retries.
- RISCV_ISA_ZABHA, RISCV_ISA_ZACAS, RISCV_USER_CFI and
  RUSTC_SUPPORTS_RISCV depend on RISCV_ISA_ZAAMO, since Zabha, Zacas,
  ssamoswap and the Rust target emit AMO instructions.
- Drop RISCV_ISA_ZALRSC and RISCV_ISA_A. The Makefile and the boot
  check key on RISCV_ISA_ZAAMO alone.
- kprobes scan forward with the same constrained-sequence rules as
  uprobes, so an lr without an sc, as in __cmpwait(), no longer
  rejects every later probe in the function.
- Move the probes patch first.
- Bring back the boot-time extension check as patch 3, keyed on
  RISCV_ISA_ZAAMO. A hart may list "zalrsc" alone, or "zaamo" and
  "zalrsc" instead of "a".
- Add patch 4: a hart that lists "zaamo" and "zalrsc" gets A set,
  so hwcap and /proc/cpuinfo match a hart that lists "a".
- Add patch 6: probe AMO speed against LR/SC at boot and report it
  through hwprobe, RISCV_HWPROBE_KEY_AMO_PERF.
- Record Conor Dooley's NAK on patch 2.
- Rewrite the cover letter; add perf bench results and a table of
  hardware, DT, Kconfig and userspace combinations.
- Link to v5: https://patch.msgid.link/20261105-lrsc-only-v5-0-f0648f57b2e1@mobileye.com

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
Vladimir Kondratiev (6):
      riscv: probes: reject probes inside an LR/SC sequence
      riscv: build kernel atomics from LR/SC when Zaamo is disabled
      riscv: accept the atomic extensions this kernel was built with
      riscv: report the A extension when Zaamo and Zalrsc are both present
      riscv, bpf: emit LR/SC loops when Zaamo is disabled
      riscv: hwprobe: report whether AMO is faster than LR/SC

 Documentation/admin-guide/kernel-parameters.txt |   7 +
 Documentation/arch/riscv/hwprobe.rst            |  18 +++
 arch/riscv/Kconfig                              |  49 +++++++
 arch/riscv/Makefile                             |  15 +-
 arch/riscv/include/asm/atomic.h                 |  53 ++++++-
 arch/riscv/include/asm/bitops.h                 |  76 +++++++++-
 arch/riscv/include/asm/cmpxchg.h                |  39 ++++-
 arch/riscv/include/asm/cpufeature.h             |   4 +
 arch/riscv/include/asm/futex.h                  |  58 ++++++++
 arch/riscv/include/asm/hwprobe.h                |   2 +-
 arch/riscv/include/asm/insn-def.h               |   5 +
 arch/riscv/include/asm/insn.h                   |  28 ++++
 arch/riscv/include/uapi/asm/hwprobe.h           |   5 +
 arch/riscv/kernel/Makefile                      |   1 +
 arch/riscv/kernel/amo_speed.c                   | 183 ++++++++++++++++++++++++
 arch/riscv/kernel/cpu.c                         |  23 ++-
 arch/riscv/kernel/cpufeature.c                  |   9 ++
 arch/riscv/kernel/entry.S                       |   7 +
 arch/riscv/kernel/head.S                        |  12 ++
 arch/riscv/kernel/probes/decode-insn.c          |  94 ++++++++++++
 arch/riscv/kernel/probes/decode-insn.h          |   7 +
 arch/riscv/kernel/probes/kprobes.c              |  15 +-
 arch/riscv/kernel/probes/uprobes.c              |  31 ++++
 arch/riscv/kernel/sys_hwprobe.c                 |  37 +++++
 arch/riscv/net/bpf_jit.h                        |   1 +
 arch/riscv/net/bpf_jit_comp32.c                 |  81 ++++++++++-
 arch/riscv/net/bpf_jit_comp64.c                 | 108 +++++++++++++-
 arch/riscv/net/bpf_jit_core.c                   |  29 ++++
 28 files changed, 969 insertions(+), 28 deletions(-)
---
base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
change-id: 20260120-lrsc-only-cc06422f5bb1

Best regards,
--  
Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>

