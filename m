Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794254285;
	b=FIe0hknqCBP70PuVIc+Usn5WLd3dRLEzMkIIfsi0Rh9XGDixjZLfoILT0mMtENpZ5zeE
	 IgPstgSqKfLvLwKW0M7g6drXap2D4a0XeqgoS/m52+2NxVPmBDg3G4nqXqF+LyhJUYhzc
	 2XSRjnr3TaLEnYqqTV6ZhDtWB2p5MHhIUKtgGucxPHs29N9n+iLp1wckCmUAbw6Rkphg4
	 Pr/hL0H8+MjcWWnBBZt9kDLTRtMoro13fCUKr1HPFN/S9JQ1sneUs6lqGFKcUErZU8vQ8
	 mTIPD+9M3tPP9E+x80kUe3HXorzh/0Z6R45VyiOMtOtPRZaSwqh/lwQtdifnrF/vRDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794254285;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+TpZeABLEGDFPdHMw3IQ0aXis6WxVSnn1N2SuHse+zU=;
	b=2QlAF4I4RPAnQN+4d+gcIAZsbRjldRw2HNss2M/2hMc9/Zzj3Mgxn9+7HV6OvWoEYgWC
	 ZGOwMK/DAACGL/jPQubktUmwjpf6Ss+KW8yF1k2g/X1ZDU8DRguGDL2vhTWtBv5OG8L2O
	 wYqNvGU5Sj0GxLLlfGvb9QYku/YWCjKk7ECYHCATJaMMqMe4I7UZzlM41vfsD3KzD5slE
	 y7mB3ST9Lg+DGDswBXRYCTJR22UBsJkQ+gvQT8LW/ayB13iUpH3pCcRAhhjge0cUyyREh
	 B14GtOFfugS7JUOx3TLQuw3z4rH1OW3nsdS1xYP1CnAwRh+XpYnMcyu9B6gyJRxDO9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jd/OT2nD";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBCF606A326;
	Mon,  9 Nov 2026 19:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jd/OT2nD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 425EB1F0089F;
	Mon,  9 Nov 2026 19:58:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794254285;
	bh=+TpZeABLEGDFPdHMw3IQ0aXis6WxVSnn1N2SuHse+zU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jd/OT2nDm3xtg790g19pXgA9sOGAowcUSNzwdHRuTeAGFF+d+BwJH0kRVEvh8qvmm
	 kQG0DVcCieCh+JCN9os5OUtDzWMhcj4aM4dmwn5/ojBFWZShrbGF/8wwdhgj8l/x6a
	 reYfRboZOKSctEQNQhQW6MyoFhNF0d9ssizIA+4RGYvWiP8/KrVMeUA2zkB61aLqNZ
	 bJXokA8TOvHK+oB1FE6/VQ7rfQKKIXNE35T0OEtRYyjApE0SemuXqepKY3hKI6tbBw
	 jbcLnzdxSOb0DcUIwuRnnttYp3CHnli9Vw5dzSTDV29ONgpWJXhcSKaR64qokfb0TJ
	 0/ZIsecATiDJA==
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
Subject: [PATCH 11/13] x86/kprobes: Use kprobe address iterator in can_probe
Date: Mon,  9 Nov 2026 20:57:59 +0100
Message-ID: <20261109195759.1091316-1-jolsa@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109194916.1089703-1-jolsa@kernel.org>
References: <20261109194916.1089703-1-jolsa@kernel.org>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Walk the instructions before the target with for_each_addr_kprobe() and
pass each matching kprobe to recover_probed_instruction(). Reuse the
iterator’s kprobe for the target instruction as well.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 arch/x86/kernel/kprobes/core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 6ad8b89a9ba1..4d63826f6c04 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -287,6 +287,8 @@ static inline bool is_exception_insn(struct insn *insn)
 static bool can_probe(unsigned long paddr)
 {
 	unsigned long addr, __addr, offset = 0;
+	struct kprobe_iter iter;
+	struct kprobe *kp;
 	struct insn insn;
 	kprobe_opcode_t buf[MAX_INSN_SIZE];
 
@@ -295,7 +297,9 @@ static bool can_probe(unsigned long paddr)
 
 	/* Decode instructions */
 	addr = paddr - offset;
-	while (addr < paddr) {
+	for_each_addr_kprobe(iter, kp, addr, paddr) {
+		if (addr == paddr)
+			break;
 		/*
 		 * Check if the instruction has been modified by another
 		 * kprobe, in which case we replace the breakpoint by the
@@ -304,7 +308,7 @@ static bool can_probe(unsigned long paddr)
 		 * relative-jump. Since the relative-jump itself is
 		 * normally used, we just go through if there is no kprobe.
 		 */
-		__addr = recover_probed_instruction(buf, addr, NULL);
+		__addr = recover_probed_instruction(buf, addr, &kp);
 		if (!__addr)
 			return false;
 
@@ -327,7 +331,7 @@ static bool can_probe(unsigned long paddr)
 	if (addr != paddr)
 		return false;
 
-	__addr = recover_probed_instruction(buf, addr, NULL);
+	__addr = recover_probed_instruction(buf, addr, &kp);
 	if (!__addr)
 		return false;
 
-- 
2.43.0

