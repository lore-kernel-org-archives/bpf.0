Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794253763;
	b=kQ0Fg5WoxBtdLw66dmscyLGSNSYArpCwhhXbF0EXoJHtIOtNdqCgSX5Uvab2yeIazKI0
	 VJ6DlMk6AblYIS2Nlpe7LSDh8muP9iIppP/LfiCfZVcKySlSuvR6hTQlPBxDYmoQS0cFO
	 tBeZdnGS+a1xbAi0aQyl3Y12GNIcleTnhseaWIIbKfSkYcSucKxoqEv818ioNWt2D7/Y9
	 ia44UjQNGnPJeCLrHt2YvIreJL3ToEfixWj2EYIcT7uTnEe1rSXlqtHbtZCkSeV9dPqsx
	 5kIKM1pVtTXBTqgwCnuSA8JEe89l2pqULaX+e3xKXSytmd/+Cyxv9HRyE4iXAGGcMtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253763;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6uYZlzUkYuV0QU50JNXZ76p2Ot13Vwc+AOqGGnYBP2M=;
	b=xBQg9WSDXuTzXzDEPz3azXbiv2oINaeCkfNzNiuuSBq2ZEr1+CI9V9Q7t6sbuVOqzhyw
	 PRU+nCU4VbUfbXNsSSUK4SEPurvRzBQ8IEIbG761dXBqWEAWTgaAbyhBDUV5tyTclh6wW
	 g/gc9d0MD5uACq02R7vJwisypi+hto1H+edcWniwqoMcJCvYWXeSjdEI/WqThoiSm14pv
	 PrVy9h9dMW5ypnNqc94x43OgKlzU/ND9dD3isIJNRKUkRUr07zLhtIB6D7quDU2vWt9Bd
	 jaTO8nzIKoCy5VUIULaFQcAJQhUhJngpZZnQjoZK2Oyy51ZNix95BZ4TKoSqe9uVOgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CI1REky4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D53F606A326;
	Mon,  9 Nov 2026 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CI1REky4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E256D1F008A1;
	Mon,  9 Nov 2026 19:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253762;
	bh=6uYZlzUkYuV0QU50JNXZ76p2Ot13Vwc+AOqGGnYBP2M=;
	h=From:To:Cc:Subject:Date;
	b=CI1REky4h0qVA+JPGs+6PUHJD31QUllGBES8CiKFP+eZ8ss+iWTnJwPD74V3GbrVb
	 6quiFlky3NIuS66oUYHGKqIIbiHcB2snRbDSiGMRCm8DOr/xYfFs1PHiBmvSUV0wmf
	 pxc9gYnX/sTUSFLVZZUM3UAinDyabNi6N9oTX1VYLLnEIcwW9hGhv+Yz/M6Qf8Jacs
	 whk5PgSb+MPmipnFYsOIe+dCqdFHsGVSLBr4hyjIYMJPCwfcTW96i/52OhLdTikB0n
	 VPQWHXKv/NxzIck5Beka7YdekHkvt/U3YdVUvRGfa/SNVM2CbWL7l+Oj/ZIntr6As7
	 3joODekM/qyEw==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Alan Maguire <almagui@kernel.org>,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH 00/13] kprobes: Reduce registration and optimization lookup costs
Date: Mon,  9 Nov 2026 20:49:03 +0100
Message-ID: <20261109194916.1089703-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hi,
this series reduces repeated lookup work when registering and preparing
large numbers of kprobes, particularly on x86 with optimized probes.

The kernel already provides interfaces for registering large numbers of
kprobes. Faster registration will become more important for our planned
inline function tracing support, which will use kprobes.

The changes address two kinds of lookup:

  - add indexes sorted by code address for core static-call and jump-label
    reservation checks. The original tables remain sorted by key for
    updates. Build the indexes during late init and retain linear scans
    if allocation fails. Module reservation checks remain linear.

  - add an address-ordered rbtree of registered kprobes and iterators for
    ranges and monotonically increasing addresses. Convert instruction
    recovery and optimization checks to reuse these iterators instead
    of repeatedly looking up individual addresses.

The series also determines x86 jump-label instruction sizes directly
from their opcode or NOP encoding, avoiding instruction decoding.

The final samples patch is included only to demonstrate the testing and
is not intended for merging. It adds 50k functions to the kernel, along
with sample module code that registers kprobes on them, simulating kprobes
on inline kernel functions.

There's overall speedup about 10x for registering the kprobe, please check
the perf stats below. Plus there's one more low hanging fruit leftover I
plan to send later for bug entry lookup that will add bit more speed up.

The test below measures perf stat for the probe_many_example.ko module to
attach kprobes to 20,000 functions.

  Performance counter stats for:
    'insmod ./samples/kprobes/kprobe_many_example.ko nr_functions=20000':

  Before:
    50,908,260,992      cycles:k                                                              
    53,886,723,615      instructions:k                                                        

      10.072721766 seconds time elapsed

  After:
     5,122,978,035      cycles:k                                                              
     5,620,945,319      instructions:k                                                        

       1.027289983 seconds time elapsed

thanks,
jirka


Assisted-by: LLM
---
Jiri Olsa (13):
      static_call: Index code text reservation lookups
      jump_label: Index text reservation lookups
      jump_label/x86: Avoid decoding instructions for jump entry size
      kprobes: Maintain an rbtree of registered probes
      kprobes: Add an iterator for address ranges
      kprobes: Add an address iterator for probe lookup
      kprobes: Use kprobe iterator in get_optimized_kprobe
      x86/kprobes: Use kprobe iterator in __recover_optprobed_insn
      x86/kprobes: Use kprobe iterator in arch_check_optimized_kprobe
      x86/kprobes: Use kprobe address iterator in can_optimize
      x86/kprobes: Use kprobe address iterator in can_probe
      x86/kprobes: Use kprobe address iterator in in copy_optimized_instructions
      samples/kprobes: Add batch probe example

 arch/x86/kernel/jump_label.c          |  14 +++++++----
 arch/x86/kernel/kprobes/common.h      |   7 +++---
 arch/x86/kernel/kprobes/core.c        |  26 +++++++++++--------
 arch/x86/kernel/kprobes/opt.c         |  32 ++++++++++++++---------
 include/linux/kprobes.h               |  25 ++++++++++++++++++
 kernel/Makefile                       |   3 +++
 kernel/jump_label.c                   | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 kernel/kprobes.c                      | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 kernel/kprobes_many.c                 |  81 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/static_call_inline.c           | 114 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--
 samples/Kconfig                       |   8 ++++++
 samples/kprobes/Makefile              |   1 +
 samples/kprobes/kprobe_many_example.c |  80 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 13 files changed, 598 insertions(+), 42 deletions(-)
 create mode 100644 kernel/kprobes_many.c
 create mode 100644 samples/kprobes/kprobe_many_example.c
