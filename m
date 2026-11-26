Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708114;
	b=RC23mv4Gvs3hifMtj7DErnb1ae+2UHXvvf7ItIr+ap+bObMQZG3878IALT0qc5timBJ6
	 0TffEdsQIYaOFhuCka7OAFgZMpKyWfd1W2s/hW2D/8l3UWxbLAiFPgKtS5sipL5cYiMG7
	 UrvRkfuRT6OuYhtjlebqsTj5qGubgvFs4rH5tw/rBehuXX1+Myt1RF1peRIicpXYK3RZr
	 jd8Q9rhXlyf55IyWy1sfG4hxaIpeoVpfuQZyCgiqT8q1rVl7q9K3IAifgyBRdzC/IfsYc
	 EwgoAoaY58F/i3nHVoskeSNDHE9ukpScE9sZaq4GnUIgUhIBYqF7RfoYgfGyuRD1yUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708114;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ya6HJitKGWtXBRSHeBA7m0MB0rx0/E16IMlLvkO+2HA=;
	b=I87F2tYgEgZTGvw5ODiCCQzWQoVz5vv45iP/PR+qK6MW80toWqkjKkkmV392676r78Nw
	 DrrhZ/A95CUmgOLMNVru1HYE40e0Ma177OpdYOc1aiTWWgVmBVitAG50Kf1QcahtXyvHK
	 3XI4vNXKdRaM3qZ8OchIKVKJfZeqlEw7Ddlj49exGTBxRKoGpavoTShVh3UD7Ynbol+XC
	 aEnZwyKfmkbnOYCKqyYT6pn5AVh7LrK3dNCRy63qzftmgmhRFbKasVxX+QF/DJJWcXDpV
	 mzJV+b6KRI3jz4g6RWmRbY6PIzvvqByJx8VfNDSfSaz8Mk3lKXwsK+uczsIbi+7J0GQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FZ63DkyS;
	arc=none smtp.remote-ip=95.215.58.114
Received: from mta1.migadu.com (out-114.mta1.migadu.com [95.215.58.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05CD0606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:48:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 05CD0606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FZ63DkyS
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=C9T2j2mlU2nW9y/Vvy31YfpIlidt9As5/mZQWXfV67Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795708111; v=1; x=1796312911;
 b=FZ63DkySL86VxF2S/hyj8LC4RXg2BlV056FGHwH6lMfapR28WJZ5UA1YZ3RwGc6mAuEKa7hq
 4730InlyJN85TDW5Y1RJSRjIfUrgGtJgb7ARpuCX+hUHvrrHeCrDa4uKwpCj+4fzZxGE9tHoIyU
 j0TKwMRMJlldwrWULRQR+Gc8=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 889de62353043a88;
	Thu, 26 Nov 2026 15:48:30 +0000
X-Mizu-Trace-ID: 889de62353043a88
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Guillaume Laporte <glapt.pro@outlook.com>,
	Vincent Thiberville <vincent@harfanglab.fr>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	KaFai Wan <kafai.wan@linux.dev>,
	Leon Hwang <leon.hwang@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH 6.18.y 2/4] bpf: Reject programs with inlined helpers if JIT is not available
Date: Thu, 26 Nov 2026 15:47:11 +0000
Message-ID: <20261126154714.169698-3-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126154714.169698-1-leon.hwang@linux.dev>
References: <20261126154714.169698-1-leon.hwang@linux.dev>
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

From: Tiezhu Yang <yangtiezhu@loongson.cn>

[ Upstream commit f1c27922576edccb99d0257827d09bd05c0304a6 ]

When an architecture (such as LoongArch, ARM64, and RISC-V) implements
bpf_jit_inlines_helper_call(), the verifier skips rewriting the helper
call offset (insn->imm) in bpf_do_misc_fixups(). This is because the
helper is expected to be inlined by the JIT compiler later. Therefore,
insn->imm remains as the raw helper enum ID.

However, if JIT is disabled at runtime (net.core.bpf_jit_enable=0) or
if JIT compilation fails dynamically (e.g., due to OOM), the program
falls back to the BPF interpreter.

When the interpreter executes (__bpf_call_base + insn->imm) with the
unpatched raw ID, it jumps into an invalid address space, triggering
an instruction alignment fault or a kernel panic.

Although these helpers have valid C implementations in the kernel, the
omission of offset rewriting makes runtime interpreter fallback fatal.

Fix this by setting 'prog->jit_required = 1' when helper call rewriting
is skipped for JIT inlining. This ensures that such programs are safely
rejected if JIT is not available, preventing the runtime kernel panic.

Fixes: 2ddec2c80b44 ("riscv, bpf: inline bpf_get_smp_processor_id()")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Suggested-by: KaFai Wan <kafai.wan@linux.dev>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
[edit]
  Apply the bpf_do_misc_fixups() change from kernel/bpf/fixups.c to
  do_misc_fixups() in kernel/bpf/verifier.c.
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e91ee66c8e31..2749dee1643d 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23022,8 +23022,10 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 		}
 
 		/* Skip inlining the helper call if the JIT does it. */
-		if (bpf_jit_inlines_helper_call(insn->imm))
+		if (bpf_jit_inlines_helper_call(insn->imm)) {
+			prog->jit_required = 1;
 			goto next_insn;
+		}
 
 		if (insn->imm == BPF_FUNC_get_route_realm)
 			prog->dst_needed = 1;
-- 
2.55.0

