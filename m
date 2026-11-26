Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.61
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795707032;
	b=l5qzvp389TaRq6Z3KNlyFv7z3uPJIWgZah4Jk7Yj2jLbka8foKrIK+DScq79CsZOMC2u
	 spFwrIgidbsYiC+xbuXhCrt8FVz5tQmcmU6jRsWBoQvdaR5xcrvOFkAvWS7kYS9uPbVO0
	 aceIEcTQM0Oj3G4qrh9q+juWzAYR2N19suETtaLzLG+0c0SUAklYAgLx9ifkr0Ehv6Z2w
	 TuZZbFbcYyCUljErIMYnKUq+CtHgqiwDQAiejVB2lWV0hfpXodmhEQxnuBMyEUhLpR7iT
	 Duxt/XljVgbLMgChaqFtSIXyi9PHb6nIv8qoYJ14h1Z5iw/VP+dmtfvrnX+jwqm4qpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795707032;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IOrQAYiFZGkfHaVcGtU2ILDIBM1AgyST3Ynrv8o1atw=;
	b=Ps41YhsYb34EEDZt8dWSr+RBp1v3t64YK+rwRLiwHCIPh9TIWcvB/FWjp8ZlS+xfW8FL
	 Yr8Nmg2bKYvWyGfON7JeFURwcesVsmpWE9M2hZOVgDdPS4PQuyv2XUieocX8pHHtjZdHA
	 xJuQ/KbAcRYIxfEMEAD9BDl1s110Vjn6r5sIUsBUZTMB9siDY0zlBksgBVPuXKex/41Ua
	 BISVZU1XReHqdg2FiESPaQzTEUepV9B6F3kMPIwjNWGQUNFa0xmHhf2Rug3E+KehnUGv/
	 NCF8+FkMfZPeUeFN9CQC7YTdKdqfSTuozkaRRIHugH7UIAw0oQin1KEpkUdvgZI0u5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JPYqKJmO;
	arc=none smtp.remote-ip=91.218.175.61
Received: from mta0.migadu.com (out-61.mta0.migadu.com [91.218.175.61])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FC8606A32A
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:30:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43FC8606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=JPYqKJmO
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZBB7CMWco3C2UZrjURWiKqdxZ+YQ7M6cwRgIBlKdNCQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795707030; v=1; x=1796311830;
 b=JPYqKJmO/QqsRV0quh+vT6sSdKurSWhxpdry5ZaGNulRA/XNc+FY/z/bqY0tdfJiksAgmWKz
 MvofBvZ+XMq2IhaZvt80d9lBCbboYUvrxrichvZ9mIhLRE+0qJqgkdzTsxVEl4ddRZNhBWh4wXk
 L2E/upmHF6lu17lX9nLiW2Gk=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 268944202c3aa925;
	Thu, 26 Nov 2026 15:30:29 +0000
X-Mizu-Trace-ID: 268944202c3aa925
X-Migadu-Flow: FLOW_OUT
From: Leon Hwang <leon.hwang@linux.dev>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Leon Hwang <leon.hwang@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH linux-6.12.y 4/4] bpf: Disallow interpreter fallback for BPF_ADDR_PERCPU insn
Date: Thu, 26 Nov 2026 15:30:02 +0000
Message-ID: <20261126153002.162337-5-leon.hwang@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261126153002.162337-1-leon.hwang@linux.dev>
References: <20261126153002.162337-1-leon.hwang@linux.dev>
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

[ Upstream commit 7a0855e73757ee9cf25ba635a1c735018ecba742 ]

The BPF_MOV64_PERCPU_REG insn requires JIT to emit native code to for
'dst_reg = src_reg + <percpu_base_off>'.

However, the interpreter ignores the 'off' at its ALU64_MOV_X label.
The 'off' indicates the insn is BPF_MOV64_PERCPU_REG insn. Then, when
the interpreter loads memory from the register, it will hit a page
fault.

[    2.545572] BUG: unable to handle page fault for address: ffffffffacaaf034
[    2.546485] #PF: supervisor read access in kernel mode
[    2.547167] #PF: error_code(0x0000) - not-present page
[    2.547850] PGD 134e63067 P4D 134e63067 PUD 134e64063 PMD 10021c063 PTE 800ffffeca550062
[    2.548912] Oops: Oops: 0000 [#1] SMP PTI

Set jit_required as true in order to disallow interpreter fallback in
core.c::__bpf_prog_select_runtime(), if any BPF_ADDR_PERCPU insn is
patched to the prog.

BTW, rename the helper bpf_map_supports_cpu_flags() to
bpf_map_is_percpu_map().

Fixes: 7bdbf7446305 ("bpf: add special internal-only MOV instruction to resolve per-CPU addrs")
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
Link: https://lore.kernel.org/bpf/20260715141122.15783-4-leon.hwang@linux.dev
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
[edit]
  Add bpf_map_is_percpu_map() directly because 6.12.y lacks
  bpf_map_supports_cpu_flags().

  Apply the map lookup and bpf_get_smp_processor_id() changes to
  do_misc_fixups() in kernel/bpf/verifier.c.

  Omit the current-task helper hunk because 6.12.y lacks the verifier
  inlining introduced by commit
  eaedea154eb9 ("bpf, x86: inline bpf_get_current_task() for x86_64").
Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
---
 include/linux/bpf.h   | 13 +++++++++++++
 kernel/bpf/verifier.c |  4 ++++
 2 files changed, 17 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d4a9108594bf..ed879905579d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3504,4 +3504,17 @@ static inline bool bpf_is_subprog(const struct bpf_prog *prog)
 	return prog->aux->func_idx != 0;
 }
 
+static inline bool bpf_map_is_percpu_map(enum bpf_map_type map_type)
+{
+	switch (map_type) {
+	case BPF_MAP_TYPE_PERCPU_ARRAY:
+	case BPF_MAP_TYPE_PERCPU_HASH:
+	case BPF_MAP_TYPE_LRU_PERCPU_HASH:
+	case BPF_MAP_TYPE_PERCPU_CGROUP_STORAGE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 #endif /* _LINUX_BPF_H */
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ab6263a769d2..d34a602b1e76 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21602,6 +21602,9 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 					return -EINVAL;
 				}
 
+				if (bpf_map_is_percpu_map(map_ptr->map_type))
+					prog->jit_required = true;
+
 				new_prog = bpf_patch_insn_data(env, i + delta,
 							       insn_buf, cnt);
 				if (!new_prog)
@@ -21706,6 +21709,7 @@ static int do_misc_fixups(struct bpf_verifier_env *env)
 			 * way, it's fine to back out this inlining logic
 			 */
 #ifdef CONFIG_SMP
+			prog->jit_required = true;
 			insn_buf[0] = BPF_MOV32_IMM(BPF_REG_0, (u32)(unsigned long)&pcpu_hot.cpu_number);
 			insn_buf[1] = BPF_MOV64_PERCPU_REG(BPF_REG_0, BPF_REG_0);
 			insn_buf[2] = BPF_LDX_MEM(BPF_W, BPF_REG_0, BPF_REG_0, 0);
-- 
2.55.0

