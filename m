Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EF9403B16;
	Thu,  9 Jul 2026 10:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591403; cv=none; b=B+yMhw/+bMwzgWCDdy2aHhSCjsPhekA95vkTeVzj8Vmg2ahIEnJJIeOdm2MsS7nysE9GjGTICGY853kd+JYyJVP1ApWM9817PzAfizmusJZwNEINTXJfG9mT5O+o8O59KXXyB7Z7Z7OQWR3m7RTD3Ys2kE6sxdLdUMq/8Xiuv6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591403; c=relaxed/simple;
	bh=mgJHxkDC6AQQ4FbXv+hMBUjHSmh+urV/pD58T8SISus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZCShMaG7PDFCC9nfkjf0G9O6BpMjo7lUSkUcADGh/0KitPUPR89W7ulIDtTFKopV2URTTqlibbCwipoQdMCDMXBw+skwVhw/7YVdXXgTr7zHNGCIiJ39cLGSnE2AJNy9sEciSZJO3k1Di3bLQpj8y/cZ++XmOLiwyAabmhDpp4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2SmfoFFB; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2SmfoFFB"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 5B6E8C2F4C2;
	Thu,  9 Jul 2026 10:03:34 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 074AB5FF03;
	Thu,  9 Jul 2026 10:03:20 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4329111BC3743;
	Thu,  9 Jul 2026 12:03:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783591398; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bjbWHrkEbZhqNNjFAfExo40p6wzkNg4ER6UO0UODCFo=;
	b=2SmfoFFBpZS+uLmjQy7RYwa4rK5ruVNuh3Es0RMXlt4P9qIXFC+687dRJXzZ3/AKSm7eUL
	6bsRq4yiPLEado7y/g2D4Kq26/+G1jT+te/CiKMM1EIHiUP3TYlPM6sc/8Voah8E+65yPz
	0qvQre0T4GR9VaZLLpf45eBpfhkvqoajUIbyf/qZGIOwMMTB4xGJvSgNZXAUdZo1WsEAqh
	1EnoipGpuY6vYxIdZQrlvHWpzo6X4fP2TdlIIUcUnpqik6tHLwFrpIbI1CsxUJ8l4ueDuI
	JnANK+SPKqhIzl4ZQp1k+/ib8uPVQ9GrixrFuDFDVuQxBDUixAkMRCfbyXtPQQ==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 09 Jul 2026 12:01:43 +0200
Subject: [PATCH bpf-next v5 02/10] bpf: mark instructions accessing program
 stack
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260709-kasan-v5-2-1c64af8e4e1e@bootlin.com>
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
In-Reply-To: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

In order to prepare to emit KASAN checks in JITed programs, JIT
compilers need to be aware about whether some load/store instructions
are targeting the bpf program stack, as those should not be monitored
(we already have guard pages for that, and it is difficult anyway to
correctly monitor any kind of data passed on stack).

To support this need, make the BPF verifier mark the instructions
depending on whether they could access or not memory other than stack.
As different states in the verifier could lead to different memory types
for the same access, just marking an instruction as accessing stack only
is not enough (it could be some other memory type in another verifier
state), so the algorithm rather sets by default any load/store
instruction as stack only, and if _any_ state leads to any memory access
type other than PTR_TO_STACK, it overrides this setting. It also takes
care about shifting back the instruction marking in adjust_insn_aux_data
if the verifier patches instructions. However, if the verifier generates
new BPF_ST/BPF_STX/BPF_LDX while patching some instructions, those new
ones are systematically marked as non-stack-accessing: this may
over-instrument a few memory accessing instructions, but it allows
making sure that we will not miss accidentally any.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v5:
- fix incorrect marking for single instruction patch

Changes in v4:
- include BPF_ATOMIC in is_mem_insn
- correctly mark instructions in adjust_insn_aux_data if patch generates
  a single instruction (ie replace an instruction)

Changes in v3:
- drop getter
- drop cBPF handling
- update marking shifting logic to track more precisely orignal
  instructions
- systematically mark newly generated instructions as non-stack
  accessing

Changes in v2:
- invert marking logic to cover possible different reg types when the
  verifier covers different states
- add a best-effort processing for classical bpf programs, inspecting
  directly src and dst registers since we don't have verifier env
- make sure to keep marking in sync with prog when it is patched by
  verifier
---
 include/linux/bpf_verifier.h |  2 ++
 kernel/bpf/fixups.c          | 32 +++++++++++++++++++++++++++++++-
 kernel/bpf/verifier.c        |  9 +++++++++
 3 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 317e99b9acc0..abe8459cc701 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -723,6 +723,8 @@ struct bpf_insn_aux_data {
 	u16 const_reg_map_mask;
 	u16 const_reg_subprog_mask;
 	u32 const_reg_vals[10];
+	/* instruction can access non-stack memory */
+	bool non_stack_access;
 };
 
 #define MAX_USED_MAPS 64 /* max number of maps accessed by one eBPF program */
diff --git a/kernel/bpf/fixups.c b/kernel/bpf/fixups.c
index 188ea6205d61..0eda5512baec 100644
--- a/kernel/bpf/fixups.c
+++ b/kernel/bpf/fixups.c
@@ -152,6 +152,18 @@ static int get_callee_stack_depth(struct bpf_verifier_env *env,
 }
 #endif
 
+static bool is_mem_insn(struct bpf_insn *insn)
+{
+	if (BPF_CLASS(insn->code) != BPF_ST &&
+	    BPF_CLASS(insn->code) != BPF_STX &&
+	    BPF_CLASS(insn->code) != BPF_LDX)
+		return false;
+
+	return (BPF_MODE(insn->code) == BPF_MEM ||
+		BPF_MODE(insn->code) == BPF_MEMSX ||
+		BPF_MODE(insn->code) == BPF_ATOMIC);
+}
+
 /* single env->prog->insni[off] instruction was replaced with the range
  * insni[off, off + cnt).  Adjust corresponding insn_aux_data by copying
  * [0, off) and [off, end) to new locations, so the patched range stays zero
@@ -172,8 +184,14 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 	 */
 	data[off].zext_dst = insn_has_def32(insn + off + cnt - 1);
 
-	if (cnt == 1)
+	if (cnt == 1) {
+		/* A non-memory accessing insn could have been replaced by a
+		 * memory accessing insn, systematically mark it for non-stack
+		 * access
+		 */
+		data[off].non_stack_access = is_mem_insn(insn + off);
 		return;
+	}
 	prog_len = new_prog->len;
 
 	memmove(data + off + cnt - 1, data + off,
@@ -183,7 +201,19 @@ static void adjust_insn_aux_data(struct bpf_verifier_env *env,
 		/* Expand insni[off]'s seen count to the patched range. */
 		data[i].seen = old_seen;
 		data[i].zext_dst = insn_has_def32(insn + i);
+		if (i == off + insn_off_in_patch) {
+			data[i].non_stack_access = data[off + cnt - 1].non_stack_access;
+			data[off + cnt - 1].non_stack_access = false;
+		} else if (is_mem_insn(insn + i)) {
+			data[i].non_stack_access = true;
+		}
 	}
+	/*
+	 * Last slot instruction could be a newly generated
+	 * BPF_ST/BPF_LDX/BPF_STX
+	 */
+	if (is_mem_insn(insn + off + cnt - 1) && insn_off_in_patch != cnt - 1)
+		data[off + cnt - 1].non_stack_access = true;
 
 	/*
 	 * The indirect_target flag of the original instruction was moved to the last of the
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 233472a871be..bc3b4771396a 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3207,6 +3207,11 @@ static void mark_indirect_target(struct bpf_verifier_env *env, int idx)
 	env->insn_aux_data[idx].indirect_target = true;
 }
 
+static void mark_non_stack_access(struct bpf_verifier_env *env, int idx)
+{
+	env->insn_aux_data[idx].non_stack_access = true;
+}
+
 #define LR_FRAMENO_BITS	4
 #define LR_SPI_BITS	6
 #define LR_ENTRY_BITS	(LR_SPI_BITS + LR_FRAMENO_BITS + 1)
@@ -6400,6 +6405,10 @@ static int check_mem_access(struct bpf_verifier_env *env, int insn_idx, struct b
 		else
 			coerce_reg_to_size_sx(&regs[value_regno], size);
 	}
+
+	if (!err && reg->type != PTR_TO_STACK)
+		mark_non_stack_access(env, insn_idx);
+
 	return err;
 }
 

-- 
2.54.0

