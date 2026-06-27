Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 226AE3B47D3;
	Sat, 27 Jun 2026 14:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571995; cv=none; b=J4VMeJr8KNPexmLqqxj2a5tex7tCY+ZEfcqlTjJlLj8gRcw+jm4M9KI/MkK5vorhMoErgJ5Y9lMLWhRcEKJjnI90n/D1phZAEsWBc9igeZ2YQBxkEOIEbD/hjFse4STfvaH0zfyMwKW2QRgLHmfOn5CIGQOBwriuYZNkqTm0v0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571995; c=relaxed/simple;
	bh=9e8TnwLHQQvR6TpBelr1G791pC6JdSIAtEdA2RNgkig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgENArZRF1o1FRdbSxE9RDLVSH9br5WNkUiEMPN6SWOz76n9HLuGBDZjvVdhR9A+EqPBd4kvRbMVGzQSjIqr8uEtYbBWlD7xpU/qhMMPvgjMXzrlemtq2LsdnSGCk/lPj2i/TZw08OkxWckByYD8uUQe+TDg1TvlXMgtefTeEj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gnbB40SGWzKHMNS;
	Sat, 27 Jun 2026 22:52:44 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 659534058D;
	Sat, 27 Jun 2026 22:52:47 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHPCa94z9qh0oVAA--.10903S13;
	Sat, 27 Jun 2026 22:52:47 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	Eyal Birger <eyal.birger@gmail.com>,
	Rong Tao <rongtao@cestc.cn>
Subject: [RFC PATCH bpf-next 11/12] bpf, x86: Add JIT support SDT for probe
Date: Sat, 27 Jun 2026 22:51:45 +0000
Message-ID: <48943c5608280cade48d459ca15fd156c7470209.1782571533.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782571533.git.xukuohai@huawei.com>
References: <cover.1782571533.git.xukuohai@huawei.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAHPCa94z9qh0oVAA--.10903S13
X-Coremail-Antispam: 1UD129KBjvJXoWxGr1DCFWktw1xJF43AFyUtrb_yoW5ur4DpF
	Z7A3ZxAF4kX3ZakF97Za1UZF4aqFs5tr4xCryxG34fGay5GryUWF1fKayayry5Kr95Aw1r
	Zr4qvrn8CF1fG3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUAVCq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAv
	FVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJw
	A2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr2
	1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv
	67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7
	CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E
	4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
	WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
	Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7
	xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
	6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUIJ5rDUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add x86 JIT support for SDT probe. For the target side, each probe site
is jited to a 5-byte NOP so it can be patched to a CALL instruction when
an observer program is attached. For the observer side, the normal bpf
trampoline is reused, except that the argument registers come from the
arg_regs[] array in the func_model, rather than the fixed BPF R1~R5.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/x86/net/bpf_jit_comp.c | 38 +++++++++++++++++++++++++++++--------
 1 file changed, 30 insertions(+), 8 deletions(-)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 054e043ffcd2..262f1bd74d53 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2797,6 +2797,16 @@ st:			insn_off = insn->off;
 			}
 
 			if (!jmp_offset) {
+				int index = bpf_prog->aux->subprog_start + i - 1;
+
+				/*
+				 * Emit a 5-byte NOP for SDT probe site, so it can be patched to
+				 * a CALL instruction when observer program is attached.
+				 */
+				if (env->insn_aux_data[index].sdt_entry) {
+					emit_nops(&prog, X86_PATCH_SIZE);
+					break;
+				}
 				/*
 				 * If jmp_padding is enabled, the extra nops will
 				 * be inserted. Otherwise, optimize out nop jumps.
@@ -3059,9 +3069,13 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 
 			/* copy the arguments from regs into stack */
 			for (j = 0; j < arg_regs; j++) {
+				u8 reg = (flags & BPF_TRAMP_F_SDT_PROBE)
+					? m->arg_regs[nr_regs]
+					: (nr_regs == 5 ? X86_REG_R9
+					   : BPF_REG_1 + nr_regs);
+
 				emit_stx(prog, BPF_DW, BPF_REG_FP,
-					 nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs,
-					 -stack_size);
+					 reg, -stack_size);
 				stack_size -= 8;
 				nr_regs++;
 			}
@@ -3072,7 +3086,7 @@ static void save_args(const struct btf_func_model *m, u8 **prog,
 }
 
 static void restore_regs(const struct btf_func_model *m, u8 **prog,
-			 int stack_size)
+			 int stack_size, u32 flags)
 {
 	int i, j, arg_regs, nr_regs = 0;
 
@@ -3087,9 +3101,12 @@ static void restore_regs(const struct btf_func_model *m, u8 **prog,
 		arg_regs = (m->arg_size[i] + 7) / 8;
 		if (nr_regs + arg_regs <= 6) {
 			for (j = 0; j < arg_regs; j++) {
-				emit_ldx(prog, BPF_DW,
-					 nr_regs == 5 ? X86_REG_R9 : BPF_REG_1 + nr_regs,
-					 BPF_REG_FP,
+				u8 reg = (flags & BPF_TRAMP_F_SDT_PROBE)
+					? m->arg_regs[nr_regs]
+					: (nr_regs == 5 ? X86_REG_R9
+					   : BPF_REG_1 + nr_regs);
+
+				emit_ldx(prog, BPF_DW, reg, BPF_REG_FP,
 					 -stack_size);
 				stack_size -= 8;
 				nr_regs++;
@@ -3547,7 +3564,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	}
 
 	if (flags & BPF_TRAMP_F_CALL_ORIG) {
-		restore_regs(m, &prog, regs_off);
+		restore_regs(m, &prog, regs_off, flags);
 		save_args(m, &prog, arg_stack_off, true, flags);
 
 		if (flags & BPF_TRAMP_F_TAIL_CALL_CTX) {
@@ -3603,7 +3620,7 @@ static int __arch_prepare_bpf_trampoline(struct bpf_tramp_image *im, void *rw_im
 	}
 
 	if (flags & BPF_TRAMP_F_RESTORE_REGS)
-		restore_regs(m, &prog, regs_off);
+		restore_regs(m, &prog, regs_off, flags);
 
 	/* This needs to be done regardless. If there were fmod_ret programs,
 	 * the return value is only updated on the stack and still needs to be
@@ -4220,3 +4237,8 @@ bool bpf_jit_supports_fsession(void)
 {
 	return true;
 }
+
+bool bpf_jit_supports_sdt_probe(void)
+{
+	return true;
+}
-- 
2.47.3

