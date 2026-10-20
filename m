Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.249.212.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792504165;
	b=jzf0zDLmTtD9j0WOogcui4F+ZCaoK3cMQWfXrYq64kE3RfPRo0ZqbFsnqO26nm+gikvx
	 ir5kvxhvpV3ERzMxvSzj99rmXztyN1A161PGCHAD7Akm1uxpQKIrdgrUD741g8+PrKsCd
	 FHG0jPRHBhUuADpQ8kTWqhNlwj84PThFhNtw7PU4alCkIkae8rv93Jt5rPVgtCAg7RexC
	 vyqJmf6ioQyy0Jjf5gKaJ5K5auCyoqiX1cKbETZjlfrZOZ6nZ6axMymVF8YC77tPOAYt4
	 O92C73jYaMg4/KW312S7jweAB6aNmk9CiB6d43VX5ACZ5dad6F5g/5QXpSzwpUpBhsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792504165;
	h=DMARC-Filter:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=Pt63WmV8iZIJMhH88+iZCVG/APjehhxZj9wqSB8cxSs=;
	b=WwicNI/6fa25UDPpZo1wRPKhIKzQX1XFOEhELFRjLUELH3/wRCn2ntYPGZC9yN3/E8dX
	 QZxpZ18qM7TsEzeFlfu4wViRXftVFemNnIId0aW8+JF3j2B6ZqvCjkvr/BAfq2JGkCvEY
	 sAJVWsDqEQHWrLftte6mLElkqMmiUcaWLCkic+Xdov2v0OoELf8edHRg3MoLEs/GRrwBm
	 FZgDVOlrgaW0y6kwrO5VQYO1Gv8lHoTpcPnLVfJ1vA6Axs+Zl0gyBHkg6Z+Zq/PzJxcGi
	 MDZzKWFc/nN6W4gGM5Ww8ZQQU6Cw7zAuoO5TzCXkgDz7GgPgscfvdCVweu1jii3jvkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=huaweicloud.com;
	spf=pass smtp.mailfrom=huaweicloud.com;
	arc=none smtp.remote-ip=45.249.212.56
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4543606B652;
	Tue, 20 Oct 2026 13:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4543606B652
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4j8DKd28c9zKHMXL;
	Tue, 20 Oct 2026 21:49:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 3FECA408EF;
	Tue, 20 Oct 2026 21:49:19 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3d_pdcddq79ScBA--.16873S8;
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
Subject: [PATCH bpf-next 06/16] libbpf: Relocate arena percpu access instructions
Date: Tue, 20 Oct 2026 13:22:51 +0000
Message-ID: <bca6974a5064e05d9e62b8038147b26d8ecd8500.1792503001.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgB3d_pdcddq79ScBA--.16873S8
X-Coremail-Antispam: 1UD129KBjvJXoWxurW5uFWrAr45Aw48uF4UArb_yoWruw4UpF
	ZxAryfCrWfCF4I9rs3tayvyF45Ww4xWF12kay29r15ZFy3tws5JasFkF42y3W5Kw40yw1x
	Gr9F93yUK34DArJanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJw
	CI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7IU1KFAJUU
	UUU==
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

Introduce a pseudo instruction for arena percpu, and relocate the normal
arena percpu access instruction to it.

The pseudo instruction is encoded as a BPF_PSEUDO_ARENA_PERCPU ldimm64,
and carries the offset of the value in cpu 0's chunk. At run time, the JIT
translates the offset to the value's address in the running cpu's replica.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/uapi/linux/bpf.h       | 13 +++++++++++++
 tools/include/uapi/linux/bpf.h | 13 +++++++++++++
 tools/lib/bpf/libbpf.c         | 35 +++++++++++++++++++++++++++++++++-
 3 files changed, 60 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6f70db7515dd..9e5fa52c9bc2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1418,6 +1418,19 @@ enum {
  */
 #define BPF_PSEUDO_FUNC		4
 
+/* insn[0].src_reg:  BPF_PSEUDO_ARENA_PERCPU
+ * insn[0].imm:      map fd
+ * insn[1].imm:      offset of the value in cpu 0's chunk, including the chunk's
+ *                   offset in the arena and the value's offset in the chunk
+ * insn[0].off:      0
+ * insn[1].off:      0
+ * ldimm64 rewrite:  address of the value in cpu 0's chunk. The JIT adds
+ *                   smp_processor_id() * chunk_sz to step it into the
+ *                   running cpu's replica
+ * verifier type:    PTR_TO_ARENA
+ */
+#define BPF_PSEUDO_ARENA_PERCPU	7
+
 /* when bpf_call->src_reg == BPF_PSEUDO_CALL, bpf_call->imm == pc-relative
  * offset to another bpf function
  */
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 246f52361372..6b17dcfc36b4 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1418,6 +1418,19 @@ enum {
  */
 #define BPF_PSEUDO_FUNC		4
 
+/* insn[0].src_reg:  BPF_PSEUDO_ARENA_PERCPU
+ * insn[0].imm:      map fd
+ * insn[1].imm:      offset of the value in cpu 0's chunk, including the chunk's
+ *                   offset in the arena and the value's offset in the chunk
+ * insn[0].off:      0
+ * insn[1].off:      0
+ * ldimm64 rewrite:  address of the value in cpu 0's chunk. The JIT adds
+ *                   smp_processor_id() * chunk_sz to step it into the
+ *                   running cpu's replica
+ * verifier type:    PTR_TO_ARENA
+ */
+#define BPF_PSEUDO_ARENA_PERCPU	7
+
 /* when bpf_call->src_reg == BPF_PSEUDO_CALL, bpf_call->imm == pc-relative
  * offset to another bpf function
  */
diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 0b0c9d72b353..8634778e8ba5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -378,6 +378,7 @@ enum reloc_type {
 	RELO_SUBPROG_ADDR,
 	RELO_CORE,
 	RELO_INSN_ARRAY,
+	RELO_ARENA_PERCPU,
 };
 
 struct reloc_desc {
@@ -4934,7 +4935,8 @@ static int bpf_prog_compute_hash(struct bpf_program *prog)
 		purged[i] = prog->insns[i];
 		if (purged[i].code == (BPF_LD | BPF_IMM | BPF_DW) &&
 		    (purged[i].src_reg == BPF_PSEUDO_MAP_FD ||
-		     purged[i].src_reg == BPF_PSEUDO_MAP_VALUE)) {
+		     purged[i].src_reg == BPF_PSEUDO_MAP_VALUE ||
+		     purged[i].src_reg == BPF_PSEUDO_ARENA_PERCPU)) {
 			purged[i].imm = 0;
 			i++;
 			if (i >= prog->insns_cnt ||
@@ -5070,6 +5072,20 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
 		return 0;
 	}
 
+	/* arena percpu data relocation */
+	if (shdr_idx == obj->efile.arena_percpu_shndx) {
+		if (obj->arena_map_idx < 0) {
+			pr_warn("prog '%s': bad arena percpu data relocation at insn %u, no arena maps defined\n",
+				prog->name, insn_idx);
+			return -LIBBPF_ERRNO__RELOC;
+		}
+		reloc_desc->type = RELO_ARENA_PERCPU;
+		reloc_desc->insn_idx = insn_idx;
+		reloc_desc->map_idx = obj->arena_map_idx;
+		reloc_desc->sym_off = sym->st_value;
+		return 0;
+	}
+
 	/* jump table data relocation */
 	if (shdr_idx == obj->efile.jumptables_data_shndx) {
 		reloc_desc->type = RELO_INSN_ARRAY;
@@ -7105,6 +7121,23 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
 						   relo->map_idx, map);
 			}
 			break;
+		case RELO_ARENA_PERCPU:
+			/*
+			 * resolve the symbol to its arena-relative offset in cpu 0's chunk. The JIT
+			 * will add smp_processor_id() * chunk_sz to it at run time, so the address
+			 * ends up in the running cpu's replica.
+			 */
+			insn[1].imm = insn[0].imm + relo->sym_off + obj->arena_percpu.offset;
+
+			map = &obj->maps[relo->map_idx];
+			if (map->autocreate) {
+				insn[0].src_reg = BPF_PSEUDO_ARENA_PERCPU;
+				insn[0].imm = map->fd;
+			} else {
+				poison_map_ldimm64(prog, i, relo->insn_idx, insn,
+						   relo->map_idx, map);
+			}
+			break;
 		case RELO_EXTERN_LD64:
 			ext = &obj->externs[relo->ext_idx];
 			if (ext->type == EXT_KCFG) {
-- 
2.47.3

