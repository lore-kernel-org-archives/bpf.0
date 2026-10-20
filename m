Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504167;
	b=f4YiI0NUymQl3g8mJuBEjQX+eXfAX+B7OEEvVtMYnoTo8F0erlSqXToGBIgHwYRlR0lP
	 dVwEdQzP9jBZThrE0hQBmjab5ElQa9fSy4KHQSQO/NsgP22oVfWfKcS8pK/IS7zEKBoiv
	 RE7QQ+h18TvmBUeD5OIl82uftFgtCuvajtu7BvtJscWnWzde37aAO89wARL8DMMUjMyZb
	 Rq1lmFeeGqcn2DSp6DA+lot8qgndvNmmzEaIPV55nv+0FAsv87f4GcC2prYCrrgb9u7LB
	 asr02hMd/YrR6mQmrZSoo1ZeI5uyA865fVSChMabjYShKgcQfXJYWG4pwY3FdyRUw+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504167;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=am9GVX7SQ5scMn/uwgP4zmStNjq9PW4eRV9QLWiIbH0=;
	b=QBBbEqCYt4Y93i/pN4hatvd3lsrx4dF4jnGryHi44zjuK/1zMTLQ+2JF91HlIdg7VrmB
	 bPLXk9yUFhIsmuKE87BXGw0yS0IGMvrHmDsYkVWo6smAaKor3ggzx1rndGF961L29OxN8
	 ZoWrr4Uv9Bo6p0mq5P9Y+503wSlKZk5lUz1cu4q0B8DLZUQbS4C1Zj/QxWVeg9udOrNgk
	 lte5lZ5XXXoaU/gDhLiTXckgug+AoY8yvbTipXW8KYm6RB2swn1LvRFyZyRuuT45VWMMt
	 P1Yc76MvtrmKXI+iZXnnNTTj9pZdZ/8gSkXfVzw7lxplqmCwQR2ViOiZ2T+TqgxZFlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.51
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B13E2606F468;
	Tue, 20 Oct 2026 13:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B13E2606F468
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKn3gWHzYQtvr;
	Tue, 20 Oct 2026 21:49:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 7ADEF4056D;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S12;
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
Subject: [PATCH bpf-next 10/16] bpf, x86: Add support for arena percpu
Date: Tue, 20 Oct 2026 13:22:55 +0000
Message-ID: <f7b5dd9137eb77203be0c03841da50f9b020417f.1792503001.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S12
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfZF45tF1rZF45JFWUArb_yoW8CF13pF
	srur9xZrWDWw13GrnxXF1UArW5JF4kWr1xWw12krW5Z3Z8Xw4xWFyYka17t345CryrWrW3
	XFyFkFnxKa4kXF7anT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP0b4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
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
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1KFAJUU
	UUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Add x86 JIT support for the arena percpu pseudo instruction.
Translate the address for each cpu by adding the offset
smp_processor_id() * chunk_sz to cpu 0's address.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 arch/x86/net/bpf_jit_comp.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index 72a2a0a89e03..7c09a4d90cd1 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -2772,6 +2772,34 @@ static int do_jit(struct bpf_verifier_env *env, struct bpf_prog *bpf_prog, int *
 
 		case BPF_LD | BPF_IMM | BPF_DW:
 			emit_mov_imm64(&prog, dst_reg, insn[1].imm, insn[0].imm);
+
+#ifdef CONFIG_SMP
+			if (insn->src_reg == BPF_PSEUDO_ARENA_PERCPU) {
+				u32 chunk_sz = bpf_arena_percpu_chunk_sz(bpf_prog_arena(bpf_prog));
+
+				/* aux = smp_processor_id(); mov aux, gs:[cpu_number] */
+				EMIT2(0x65, add_2mod(0x40, 0, AUX_REG));
+				EMIT3(0x8B, add_2reg(0x04, 0, AUX_REG), 0x25);
+				EMIT((u32)(unsigned long)&cpu_number, 4);
+
+				/*
+				 * aux *= chunk_sz
+				 * arena_map_alloc() guarantees
+				 * chunk_sz * nr_cpu_ids <= vm_range <= 4 GiB and
+				 * cpu_number < nr_cpu_ids, so a 32-bit imul
+				 * cannot overflow here.
+				 */
+				maybe_emit_mod(&prog, AUX_REG, AUX_REG, false);
+				/* imul aux, aux, imm32 */
+				EMIT2_off32(0x69, add_2reg(0xC0, AUX_REG, AUX_REG),
+					    chunk_sz);
+
+				/* dst += aux */
+				maybe_emit_mod(&prog, dst_reg, AUX_REG, true);
+				EMIT2(0x01, add_2reg(0xC0, dst_reg, AUX_REG));
+			}
+#endif
+
 			insn++;
 			i++;
 			break;
@@ -5072,6 +5100,11 @@ bool bpf_jit_supports_percpu_insn(void)
 	return true;
 }
 
+bool bpf_jit_supports_arena_percpu_insn(void)
+{
+	return true;
+}
+
 void bpf_jit_free(struct bpf_prog *prog)
 {
 	if (prog->jited) {
-- 
2.47.3

