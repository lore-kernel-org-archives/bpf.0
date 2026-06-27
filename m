Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC513AE6FA;
	Sat, 27 Jun 2026 14:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782571973; cv=none; b=kAlJl89MN4SHOprBDLn4bPNnudBLkRagBn/mdJ+brLM42vfhekcIWxlpRDkLetvKsUtrBN+HiEUN6Oi4kbFejMhO+n9V49ADGFpkJml9kMiiY+zjbrt31P66eELe7OWLOwG0FUPx83th8oS0bHu2OfaOs1cdyFFUhf05TvjIk3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782571973; c=relaxed/simple;
	bh=El1ciXutw6B9FJ5ryOy24kTeWjvMDV+H9JGY7KPJZzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYR5xYCFyUFm5WIbyZrIKgdTm2HaQ3C1AFaiH845hC7t+QwHaivedBTgyikD8BDN0RT5wZSNDmOGRkEZkzzjLUL/8EQFTX5anPpV6woR8iv3gtpn4EoxihBueAo0aoGfuhu/DtId++mZ8hvr8gzcx7J97IBaY1PbJK2jimtR6U4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4gnb9B6Mx8zYQtjC;
	Sat, 27 Jun 2026 22:51:58 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id ACA1740570;
	Sat, 27 Jun 2026 22:52:46 +0800 (CST)
Received: from localhost.huawei.com (unknown [10.67.174.243])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgAHPCa94z9qh0oVAA--.10903S3;
	Sat, 27 Jun 2026 22:52:46 +0800 (CST)
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
Subject: [RFC PATCH bpf-next 01/12] libbpf: Prepare bpf SDT probe section for the linker
Date: Sat, 27 Jun 2026 22:51:35 +0000
Message-ID: <addc1860d60c2eee409f187805b6cfbc5382e82a.1782571533.git.xukuohai@huawei.com>
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
X-CM-TRANSID:_Ch0CgAHPCa94z9qh0oVAA--.10903S3
X-Coremail-Antispam: 1UD129KBjvJXoW7uFyfCw17tw48Jw15KFyfJFb_yoW8tFy3pr
	WDCry2yr15Xr4fZan5Xa1F93y5JFsrWrWUGry7Gr90vF1fXa1ag3WIva13Zr13Z393Aw13
	JrWY9FW8ZryUZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmSb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M280x2IEY4vEnII2IxkI6r1a6r45M2
	8IrcIa0xkI8VA2jI8067AKxVWUGwA2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4
	xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v2
	6r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACI402YVCY1x0262
	8vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE
	7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI
	8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWU
	CwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x07jgqXLUUUUU=
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

The follow up patch introduces bpf SDT probe macros that emit per-probe
metadata into a new data section named .bpf_sdt_notes. Each entry begins
with a ___sdt_jt_* symbol and contains an R_BPF_64_ABS64 relocation
referencing the probe site address in the bpf prog.

Prepare the linker for this by treating .bpf_sdt_notes like .jumptables.
Bypass the section-type check when appending ___sdt_jt_* symbols so they
can survive from linking, and relocate to real address inside each entry.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 tools/lib/bpf/libbpf_internal.h | 1 +
 tools/lib/bpf/linker.c          | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 04cd303fb5a8..ed7a587a61ca 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -75,6 +75,7 @@
 #endif
 
 #define JUMPTABLES_SEC ".jumptables"
+#define SDT_NOTES_SEC ".bpf_sdt_notes"
 
 #define BTF_INFO_ENC(kind, kind_flag, vlen) \
 	((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN))
diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 78f92c39290a..3a72276244c7 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2028,6 +2028,8 @@ static int linker_append_elf_sym(struct bpf_linker *linker, struct src_obj *obj,
 
 		if (strcmp(src_sec->sec_name, JUMPTABLES_SEC) == 0)
 			goto add_sym;
+		if (strcmp(src_sec->sec_name, SDT_NOTES_SEC) == 0)
+			goto add_sym;
 	}
 
 	if (sym_bind == STB_LOCAL)
@@ -2274,6 +2276,13 @@ static int linker_append_elf_relos(struct bpf_linker *linker, struct src_obj *ob
 						insn->imm += sec->dst_off / sizeof(struct bpf_insn);
 					else
 						insn->imm += sec->dst_off;
+				} else if (strcmp(src_linked_sec->sec_name, SDT_NOTES_SEC) == 0) {
+					/* .bpf_sdt_notes contains R_BPF_64_ABS64 relocations
+					 * referencing code section symbols. Adjust the 64-bit
+					 * address by dst_off.
+					 */
+					__u64 *addr = dst_linked_sec->raw_data + dst_rel->r_offset;
+					*addr += sec->dst_off;
 				} else {
 					pr_warn("relocation against STT_SECTION in non-exec section is not supported!\n");
 					return -EINVAL;
-- 
2.47.3

