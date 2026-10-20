Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504165;
	b=Dyr0mlv8wTQo5IhxtNjZTAdvY3psDFKvEwycWLSCfjjPl6EoS06GFJtc/DeGaV8Jkz2b
	 d4tj5nSbrC0EB7frRO4TTa4sMyDp2xBVGw2wN1xt7s6WXGyMaApEZuvUAByP05WXaS3T1
	 NwNpCM4f8SKRydwEixBE4WrzdGQOuKmU5+4vMq0vXVfKMKETrGlZQFWuO4jVQOeo9RnrA
	 KJzp90gn1W3l3Ej/HQiRQNK4I5GdOn1N1f5EIm9ahEKZG4+0PsF0hoTGsFtiSOh48IFgV
	 pSdE1QYdT8B/cp6iE3yjFhwTtCH/bJBDu1LFcK9oGCCxGoi54MAX9gP0X7JcQpCJGfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504165;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=TCuwUlgjsjgq6HIlrPRr3zg9Ei2scfmEW2TTFFhMGK0=;
	b=bN6WjmoXYy6c+iT1RU3WSkHMErlOs9nTM52Qgax+XReuoYfYRxt8ZSnjWD6B0Dk+JdDr
	 yNJEeUWRxg37GbOmu9cYT90N3EwgbD5ohI4y6mnPDfXI5OhqKOVyJx8C9FK5XzYa7lSGO
	 cTDu7ZId55pINyNRDy8ANaul3ocUEZb10UGnJ0kWHTtlSl7M7mUV4V2ZFMhyhvuzwGOub
	 PliPdOPMzbQCLLIAMbIv3/7uqsi58M6s93peRX+ZKMH7WhsAVoFlNiU/teF9i5KXZRnIK
	 LjkHZy+ZIjY1oAqI6lRVaQsbLbfDjloK0Y6UfJuoXZc33TgVn1dXQTgbyHO6agdbP8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.56
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F04606B653;
	Tue, 20 Oct 2026 13:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4F04606B653
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKd4NZMzKHMZF;
	Tue, 20 Oct 2026 21:49:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 8925E409A8;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S13;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Yonghong Song <yonghong.song@linux.dev>
Subject: [PATCH bpf-next 11/16] bpf, arm64: Add support for arena percpu
Date: Tue, 20 Oct 2026 13:22:56 +0000
Message-ID: <1ada7d01118df6deb0707b1a17ff11e041d6ca80.1792503001.git.xukuohai@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1792503001.git.xukuohai@huawei.com>
References: <cover.1792503001.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S13
X-Coremail-Antispam: 1UD129KBjvJXoWxXryxCF1rCw1xuF4UWryxuFg_yoWrCrWxpF
	n2kr95Cr48XF45Z395Xw4DJr13KanYgw48KrZ8G3yftryYqryDGFsYka13Aa45WrWUur43
	GFy2gry3ua4UArUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPYb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
	Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
	rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267
	AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x02
	67AKxVW0oVCq3wAaw2AFwI0_Jrv_JF1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64
	xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j
	6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwCY1x0262kKe7AKxVWUtV
	W8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr
	1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07Ui4SrU
	UUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add arm64 JIT support for the arena percpu pseudo instruction.
Translate the address for each cpu by adding the offset
smp_processor_id() * chunk_sz to cpu 0's address.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c | 51 ++++++++++++++++++++++++++++-------
 include/linux/bpf.h           |  2 +-
 kernel/bpf/arena.c            |  2 +-
 3 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index 1d5f4cf88d33..998806cc700e 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -500,6 +500,21 @@ static void emit_percpu_ptr(const u8 dst_reg, void __percpu *ptr,
 	emit(A64_ADD(1, dst_reg, dst_reg, tmp), ctx);
 }
 
+static void emit_current_cpu_id(u8 dst, struct jit_ctx *ctx)
+{
+	u8 tmp = bpf2a64[TMP_REG_1];
+	u8 tmp2 = bpf2a64[TMP_REG_2];
+	u32 cpu_offset = offsetof(struct thread_info, cpu);
+
+	emit(A64_MRS_SP_EL0(tmp), ctx);
+	if (is_lsi_offset(cpu_offset, 2)) {
+		emit(A64_LDR32I(dst, tmp, cpu_offset), ctx);
+	} else {
+		emit_a64_mov_i(1, tmp2, cpu_offset, ctx);
+		emit(A64_LDR32(dst, tmp, tmp2), ctx);
+	}
+}
+
 #define BTI_INSNS (IS_ENABLED(CONFIG_ARM64_BTI_KERNEL) ? 1 : 0)
 #define PAC_INSNS (IS_ENABLED(CONFIG_ARM64_PTR_AUTH_KERNEL) ? 1 : 0)
 
@@ -1742,19 +1757,10 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		const u8 r0 = bpf2a64[BPF_REG_0];
 		bool func_addr_fixed;
 		u64 func_addr;
-		u32 cpu_offset;
 
 		/* Implement helper call to bpf_get_smp_processor_id() inline */
 		if (insn->src_reg == 0 && insn->imm == BPF_FUNC_get_smp_processor_id) {
-			cpu_offset = offsetof(struct thread_info, cpu);
-
-			emit(A64_MRS_SP_EL0(tmp), ctx);
-			if (is_lsi_offset(cpu_offset, 2)) {
-				emit(A64_LDR32I(r0, tmp, cpu_offset), ctx);
-			} else {
-				emit_a64_mov_i(1, tmp2, cpu_offset, ctx);
-				emit(A64_LDR32(r0, tmp, tmp2), ctx);
-			}
+			emit_current_cpu_id(r0, ctx);
 			break;
 		}
 
@@ -1829,6 +1835,26 @@ static int build_insn(const struct bpf_verifier_env *env, const struct bpf_insn
 		else
 			emit_a64_mov_i64(dst, imm64, ctx);
 
+#ifdef CONFIG_SMP
+		if (insn->src_reg == BPF_PSEUDO_ARENA_PERCPU) {
+			u32 chunk_sz = bpf_arena_percpu_chunk_sz(bpf_prog_arena(ctx->prog));
+
+			/* tmp = smp_processor_id() */
+			emit_current_cpu_id(tmp, ctx);
+			/*
+			 * tmp *= chunk_sz
+			 * arena_map_alloc() guarantees
+			 * chunk_sz * nr_cpu_ids <= vm_range <= 4 GiB and
+			 * cpu_number < nr_cpu_ids, so a 32-bit mul
+			 * cannot overflow here.
+			 */
+			emit_a64_mov_i(0, tmp2, chunk_sz, ctx);
+			emit(A64_MUL(0, tmp, tmp, tmp2), ctx);
+			/* dst += tmp */
+			emit(A64_ADD(1, dst, dst, tmp), ctx);
+		}
+#endif
+
 		return 1;
 	}
 
@@ -3446,6 +3472,11 @@ bool bpf_jit_supports_percpu_insn(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_percpu_insn(void)
+{
+	return true;
+}
+
 bool bpf_jit_bypass_spec_v4(void)
 {
 	/* In case of arm64, we rely on the firmware mitigation of Speculative
diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5ffefcd5f15e..4a7af8433c19 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -677,7 +677,7 @@ u64 bpf_arena_map_kern_vm_start(struct bpf_map *map);
 u32 bpf_arena_percpu_chunk_off(const struct bpf_map *map);
 u32 bpf_arena_percpu_chunk_sz(const struct bpf_map *map);
 bool bpf_arena_percpu_off_in_range(const struct bpf_map *map, u32 off);
-struct bpf_map *bpf_prog_arena(struct bpf_prog *prog);
+struct bpf_map *bpf_prog_arena(const struct bpf_prog *prog);
 int bpf_obj_name_cpy(char *dst, const char *src, unsigned int size);
 
 struct bpf_offload_dev;
diff --git a/kernel/bpf/arena.c b/kernel/bpf/arena.c
index 310573a2661b..4d2df31d1811 100644
--- a/kernel/bpf/arena.c
+++ b/kernel/bpf/arena.c
@@ -133,7 +133,7 @@ bool bpf_arena_percpu_off_in_range(const struct bpf_map *map, u32 off)
  * prog->aux->arena. Return that arena's underlying bpf_map, or NULL if
  * @prog does not reference an arena.
  */
-struct bpf_map *bpf_prog_arena(struct bpf_prog *prog)
+struct bpf_map *bpf_prog_arena(const struct bpf_prog *prog)
 {
 	struct bpf_arena *arena = prog->aux->arena;
 
-- 
2.47.3

