Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795377783;
	b=cdW5xfCgw+EIsNYBrMpilselaWGF7aDPYanp6Usdm5I2t4/24+JSzkZes1FaFQga9P9N
	 RSw3fZdaiUXYZpDLrkmNCWpPsCIhq8Zl1Kklkr+XnE6cyV4Vh2yS691h6IAZArPDr73ah
	 N9McvCMf4UtneQHqDPlo/5DiJ/yUIGNKY6EnZaBQ3lfYpza6UrVQUpx/AZfon28IZBLE8
	 zD9LoCjTm8tJqMkNNHQKLrbi5Q0lXVa599SxQ6INVTiuQ47oFFUr462BNxuOlofh9Al0+
	 q6ylQ/PrBnhj+x7ETF4r/wNPAm0d+AsisCsqQ+5JeB7ZGUCyS+279ykjjps113Z+27A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795377783;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Dzt/jndt9xmik8tYb6MvTyuT1iTXCpduY31R4yi2Vtg=;
	b=Rr0811C56FPumknGPFD15wPbwBmU7HdsjyfErEdotkZBJPOvcBPEL99x94BWAt8fXrT8
	 6BIXz+Tv+FSFckR0aPv4TYGYp+AAez9d2mEJD8ULKAywvLqGn/Zbw+V8haApGVpTeOrzE
	 gmKSJ3Fx3haxg5S4XLLm4Vm9XCjEwdygMiSXn8ao903+qvQz9OpXGb1Pv3bg7l7RiOjT5
	 7UXBIq2YXOxWL9+bPHkY1QsVnOVs8r7PfEKUHo5yrREQhKBAjO7CFuW+zO0A5C6oTlHgW
	 jz2QWGhLmayCmnGTIqzSADXyyTTGO7Y429mhxUf3K+Z3ufdYIDWoN+ZkCkp6ykobCnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHTq8wpN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50E3606A31D;
	Sun, 22 Nov 2026 20:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHTq8wpN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0D241F000C4;
	Sun, 22 Nov 2026 20:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795377783;
	bh=Dzt/jndt9xmik8tYb6MvTyuT1iTXCpduY31R4yi2Vtg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IHTq8wpNk/k/21qlhZ/N43qyz6hwV/v1Xj+E6EJlNxy0piqOu5p5GgeteupJFRnTI
	 tnr82ROPensnWuIdXQabD1iSJxZcd6HziJjNVyq/HqIXGWYeEBU1KHyuW8c/MOjM/8
	 ytZDQRjlab12cd9KZ2q+60vHOr6pd6O+otVtXVzxKiTovDOoir4ap429PVdPQUIaDn
	 HKL9iGye4wGtZZZw4KBjSDwSiL9CQFp+UgpDWMd4ZmENNKpCOSs9MKEhZJIfscHFy4
	 AdjP5M+pE/8UfhcOMj7nZG+kWyk+go3ibFoURJwOGfdJp5p2GDib59BVpRyc3WjuX+
	 GW9b5XSoaB2hQ==
From: Jiri Olsa <jolsa@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCHv2 2/2] x86/kprobes: Use ftrace_location_range in __recover_probed_insn
Date: Sun, 22 Nov 2026 21:02:39 +0100
Message-ID: <20261122200239.1481088-3-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261122200239.1481088-1-jolsa@kernel.org>
References: <20261122200239.1481088-1-jolsa@kernel.org>
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

The __recover_probed_insn function is called for every instruction
decoded on the way to the probed address and it uses ftrace_location
to find out whether the instruction is the ftrace location.

When the address is not ftrace location, ftrace_location does also
the symbol lookup to map the sym+0 address to its ftrace location.
But __recover_probed_insn only checks if the returned location is
the address itself, and that can't be the result of the mapping
after the lookup of the address failed, so the symbol lookup is
done for nothing for almost every decoded instruction.

Using ftrace_location_range for the address instead, which does
just the lookup of the address.

Adding the missing ftrace_location_range stub for the config
without dynamic ftrace.

Registering 20587 kprobes (as disabled) with the kprobe_many_example
sample module [1] in qemu with 8 CPUs goes from 4.02s to 3.70s.

The sample module was posted as the last patch of the kprobes
lookup cost series [1] only to demonstrate the testing, it is not
merged and is not going to be.

[1] https://lore.kernel.org/bpf/20261109195827.1091410-1-jolsa@kernel.org/

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 6 +++++-
 include/linux/ftrace.h         | 4 ++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 133ff20caccd..34d71907e6d1 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -207,7 +207,11 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
 	bool faddr;
 
 	kp = get_kprobe((void *)addr);
-	faddr = ftrace_location(addr) == addr;
+	/*
+	 * Only the exact ftrace location matters, so skip the symbol
+	 * lookup ftrace_location() does to map sym+0 to its location.
+	 */
+	faddr = ftrace_location_range(addr, addr) == addr;
 	/*
 	 * Use the current code if it is not modified by Kprobe
 	 * and it cannot be modified by ftrace.
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 1c2056a1a68b..255751899682 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -1075,6 +1075,10 @@ static inline unsigned long ftrace_location(unsigned long ip)
 {
 	return 0;
 }
+static inline unsigned long ftrace_location_range(unsigned long start, unsigned long end)
+{
+	return 0;
+}
 
 /*
  * Again users of functions that have ftrace_ops may not
-- 
2.56.1

