Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0AD33AB5C7;
	Sat, 25 Jul 2026 10:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784974563; cv=none; b=qgNoOPb21MVP5MAY1CSW/W09lRIywqyL7ivVfPh3NyZdGNrOp88thWNrAVrF2ZsV7T+4p/5NJnPJbRcmG/KFG3RbNWwVNLtJltmRmrF9LlrL56+y4I0SSJS0st0ZHlLcJqpeuTx5VKOWR9VNYZpfXrBNvo+mNAcy3L5VWTBj/3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784974563; c=relaxed/simple;
	bh=Fug0w4UJyChk1b6Qn07mtiopgbwExpr8HE3fH/yct1A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RaMlPM970JR3jnnB0dDvZWHeOzI7xqNSF5mZkEPt3zPCYBlf8k7lCNP096vLb9RH5/ZCXnkoi0/B1Llik1Wpt0G+eesrD3hrWIhGXOqczN11iEN9hGZ0c5SowXiURp3d4b3w9XZOwggzUQ4c+nrm9WPl6hHxu072dpEZpYzf2pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h6ghg2rx5zKHMb6;
	Sat, 25 Jul 2026 18:14:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id C15CC4058F;
	Sat, 25 Jul 2026 18:15:47 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgAnOHTRjGRqlDL6CQ--.33326S9;
	Sat, 25 Jul 2026 18:15:47 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Song Liu <song@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
	Puranjay Mohan <puranjay@kernel.org>,
	Xu Kuohai <xukuohai@huaweicloud.com>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Hengqi Chen <hengqi.chen@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	"David S. Miller" <davem@davemloft.net>,
	Shahab Vahedi <list+bpf@vahedi.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Naveen N Rao <naveen@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next v2 7/7] bpf: Fix double-free RO header in bpf_jit_free
Date: Sat, 25 Jul 2026 10:20:20 +0000
Message-Id: <20260725102020.2287770-8-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260725102020.2287770-1-pulehui@huaweicloud.com>
References: <20260725102020.2287770-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAnOHTRjGRqlDL6CQ--.33326S9
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW7WF1UuFyxWFWrAFWrXwb_yoW3CFy3p3
	WDAF9Iyw4qgw4fKr4UtF48AF4UJw48Wa47WFW8u3yUKFn0gr97XFyrKa48GFZ0yrW8Jw15
	ZF1DKr15Ca4kJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmq14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE
	3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2I
	x0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8
	JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2
	ka0xkIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Y
	z7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zV
	AF1VAY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_JFI_Gr1l
	IxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIY
	CTnIWIevJa73UjIFyTuYvjTRNdb1DUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

When bpf_jit_binary_pack_finalize fails in bpf_jit_free, it implicitly
frees ro_header. However, JITs are unaware of this. They extract and
free it again, leading to double-free issue.

bpf_jit_free
  bpf_jit_binary_pack_finalize(ro_header, rw_header)
    ptr = bpf_arch_text_copy(ro_header, rw_header, rw_header->size);
    kvfree(rw_header);
    if (IS_ERR(ptr)) { <-- copy failed
      bpf_prog_pack_free(ro_header, ro_header->size); <-- first free ro_header
      return PTR_ERR(ptr);
    }
  hdr = bpf_jit_binary_pack_hdr(prog); <-- fetch ro_header
  bpf_jit_binary_pack_free(hdr, NULL); <-- double free ro_header

Fix this by dropping the implicit free in bpf_jit_binary_pack_finalize.
Accordingly, adapt the JITs to explicitly handle freeing ro_header in
their error paths. This also fixes the missing memory uncharge upon
failure, as bpf_prog_pack_free does not uncharge.

Additionally, initialize ro_header->size in bpf_jit_binary_pack_alloc to
ensures ro_header->size is always valid during free, and remove
unnecessary bpf_arch_text_copy in JITs.

Fixes: 1d5f82d9dd47 ("bpf, x86: fix freeing of not-finalized bpf_prog_pack")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c   |  7 ++-----
 arch/loongarch/net/bpf_jit.c    |  6 ++----
 arch/powerpc/net/bpf_jit_comp.c |  5 +++--
 arch/riscv/net/bpf_jit_core.c   |  7 ++-----
 arch/x86/net/bpf_jit_comp.c     |  7 ++-----
 kernel/bpf/core.c               | 17 +++++++++--------
 6 files changed, 20 insertions(+), 29 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index f4e4d4578e38..f5851e08e76e 100644
--- a/arch/arm64/net/bpf_jit_comp.c
+++ b/arch/arm64/net/bpf_jit_comp.c
@@ -2258,7 +2258,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			goto out_free_hdr;
 		}
 		if (WARN_ON(bpf_jit_binary_pack_finalize(ro_header, header))) {
-			/* ro_header and header has been freed */
+			bpf_jit_binary_pack_free(ro_header, NULL);
 			ro_header = NULL;
 			header = NULL;
 			goto out_free_hdr;
@@ -2307,11 +2307,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		prog->jited = 0;
 		prog->jited_len = 0;
 	}
-	if (header) {
-		bpf_arch_text_copy(&ro_header->size, &header->size,
-				   sizeof(header->size));
+	if (header)
 		bpf_jit_binary_pack_free(ro_header, header);
-	}
 	goto out_off;
 }
 
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 2738b4db1165..48ad418df133 100644
--- a/arch/loongarch/net/bpf_jit.c
+++ b/arch/loongarch/net/bpf_jit.c
@@ -2298,7 +2298,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			goto out_free;
 		}
 		if (WARN_ON(bpf_jit_binary_pack_finalize(ro_header, header))) {
-			/* ro_header and header have been freed */
+			bpf_jit_binary_pack_free(ro_header, NULL);
 			ro_header = NULL;
 			header = NULL;
 			goto out_free;
@@ -2341,10 +2341,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		prog->jited_len = 0;
 	}
 
-	if (header) {
-		bpf_arch_text_copy(&ro_header->size, &header->size, sizeof(header->size));
+	if (header)
 		bpf_jit_binary_pack_free(ro_header, header);
-	}
 	goto out_offset;
 }
 
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 7b07b43575f1..ff9bcd55165b 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -314,7 +314,6 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		bpf_jit_build_prologue(code_base, &cgctx);
 		if (bpf_jit_build_body(fp, code_base, fcode_base, &cgctx, addrs, pass,
 				       extra_pass)) {
-			bpf_arch_text_copy(&fhdr->size, &hdr->size, sizeof(hdr->size));
 			bpf_jit_binary_pack_free(fhdr, hdr);
 			goto out_err;
 		}
@@ -339,8 +338,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 #endif
 
 	if (!fp->is_func || extra_pass) {
-		if (bpf_jit_binary_pack_finalize(fhdr, hdr))
+		if (bpf_jit_binary_pack_finalize(fhdr, hdr)) {
+			bpf_jit_binary_pack_free(fhdr, NULL);
 			goto out_err;
+		}
 	}
 
 	fp->bpf_func = (void *)fimage;
diff --git a/arch/riscv/net/bpf_jit_core.c b/arch/riscv/net/bpf_jit_core.c
index 059db1adeaf8..55530e80df2e 100644
--- a/arch/riscv/net/bpf_jit_core.c
+++ b/arch/riscv/net/bpf_jit_core.c
@@ -154,7 +154,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 
 	if (!prog->is_func || extra_pass) {
 		if (WARN_ON(bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header))) {
-			/* ro_header has been freed */
+			bpf_jit_binary_pack_free(jit_data->ro_header, NULL);
 			jit_data->ro_header = NULL;
 			jit_data->header = NULL;
 			goto out_free_hdr;
@@ -183,11 +183,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		prog->jited = 0;
 		prog->jited_len = 0;
 	}
-	if (jit_data->header) {
-		bpf_arch_text_copy(&jit_data->ro_header->size, &jit_data->header->size,
-				   sizeof(jit_data->header->size));
+	if (jit_data->header)
 		bpf_jit_binary_pack_free(jit_data->ro_header, jit_data->header);
-	}
 	goto out_offset;
 }
 
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index b2feec81e231..281e89764d98 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3930,11 +3930,8 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 		if (proglen <= 0) {
 out_image:
 			image = NULL;
-			if (header) {
-				bpf_arch_text_copy(&header->size, &rw_header->size,
-						   sizeof(rw_header->size));
+			if (header)
 				bpf_jit_binary_pack_free(header, rw_header);
-			}
 			if (extra_pass) {
 				prog->bpf_func = NULL;
 				prog->jited = 0;
@@ -3987,7 +3984,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			 * Both cases are serious bugs and justify WARN_ON.
 			 */
 			if (WARN_ON(bpf_jit_binary_pack_finalize(header, rw_header))) {
-				/* header has been freed */
+				bpf_jit_binary_pack_free(header, NULL);
 				header = NULL;
 				goto out_image;
 			}
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index e2076667b245..00c32539f074 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1218,6 +1218,13 @@ bpf_jit_binary_pack_alloc(unsigned int proglen, u8 **image_ptr,
 		return NULL;
 	}
 
+	/* Initialize ro_header->size to ensure it is valid during free */
+	if (IS_ERR(bpf_arch_text_copy(&ro_header->size, &size, sizeof(size)))) {
+		bpf_prog_pack_free(ro_header, size);
+		bpf_jit_uncharge_modmem(size);
+		return NULL;
+	}
+
 	*rw_header = kvmalloc(size, GFP_KERNEL);
 	if (!*rw_header) {
 		bpf_prog_pack_free(ro_header, size);
@@ -1249,10 +1256,9 @@ int bpf_jit_binary_pack_finalize(struct bpf_binary_header *ro_header,
 
 	kvfree(rw_header);
 
-	if (IS_ERR(ptr)) {
-		bpf_prog_pack_free(ro_header, ro_header->size);
+	if (IS_ERR(ptr))
 		return PTR_ERR(ptr);
-	}
+
 	return 0;
 }
 
@@ -1260,11 +1266,6 @@ int bpf_jit_binary_pack_finalize(struct bpf_binary_header *ro_header,
  *   1) when the program is freed after;
  *   2) when the JIT engine fails (before bpf_jit_binary_pack_finalize).
  * For case 2), we need to free both the RO memory and the RW buffer.
- *
- * bpf_jit_binary_pack_free requires proper ro_header->size. However,
- * bpf_jit_binary_pack_alloc does not set it. Therefore, ro_header->size
- * must be set with either bpf_jit_binary_pack_finalize (normal path) or
- * bpf_arch_text_copy (when jit fails).
  */
 void bpf_jit_binary_pack_free(struct bpf_binary_header *ro_header,
 			      struct bpf_binary_header *rw_header)
-- 
2.34.1

