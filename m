Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 388184C9554;
	Wed, 22 Jul 2026 11:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784719411; cv=none; b=A/WdB8N9zi8FUSdcSA75dxCL10O7oyvlExCWpBF3DVOIRVMfyd5ssZc4opZ4EPWmBalQgzgLrExRZDZbziQ5RdiFyUX1/cSdCI/V8lZoFKOod5fpya+cgN01Nv9FB6spx2eCVqDBxH6AN+oEFPgImNVB2iMKexQGNYBVpVR0zCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784719411; c=relaxed/simple;
	bh=anGj889sra5hAL2XwAyOti7iZ48DVrcvDEeXO5I/4go=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jyxIW0TSFZR6OLreBNTQfJ7MI2nc3tedine6urKVQvzNi5sMxOZbQUn7yMrTjGLSCF8VOJfJjl0AtDiiXyr6TEPUUAnTRX4Tb/voWSLtz1zuErsbX44leeN5aSjKBZR3AsJVRiTIIj6MYQOi/vn1nnB/p24bw4IIZBXpZclRkRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4h4sLR5WYYzYQtt5;
	Wed, 22 Jul 2026 19:22:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id AFF9E4058F;
	Wed, 22 Jul 2026 19:23:24 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with UTF8SMTPA id gCh0CgB3qVorqGBqllacCA--.32600S6;
	Wed, 22 Jul 2026 19:23:24 +0800 (CST)
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
	Pu Lehui <pulehui@huawei.com>,
	Pu Lehui <pulehui@huaweicloud.com>
Subject: [PATCH bpf-next 4/4] bpf: Fix double-free RO header in bpf_jit_free
Date: Wed, 22 Jul 2026 11:27:54 +0000
Message-Id: <20260722112754.1615201-5-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260722112754.1615201-1-pulehui@huaweicloud.com>
References: <20260722112754.1615201-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3qVorqGBqllacCA--.32600S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGF1DCF43AF13CF1fGF1Dtrb_yoWrCry7pF
	1DJF9Ikw4qgw4fJF4Dta18CF4Utw48W3W7WFWUu3y8KFn8Wr92qF1rK34rGFZ8ArWUt34r
	ZFy5Kr1Yka4kX37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr
	1UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7sRiHUDtUUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

When bpf_jit_binary_pack_finalize fails in bpf_jit_free, it implicitly
frees ro_header. However, JITs are unaware of this. They extract and
free it again, leading to double-free issue.

Fix this by dropping the implicit free in bpf_jit_binary_pack_finalize.
Accordingly, adapt the JITs to explicitly handle freeing ro_header in
their error paths. This also fixes the missing memory uncharge upon
failure, as bpf_prog_pack_free does not uncharge.

Fixes: 1d5f82d9dd47 ("bpf, x86: fix freeing of not-finalized bpf_prog_pack")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/arm64/net/bpf_jit_comp.c   | 2 +-
 arch/loongarch/net/bpf_jit.c    | 2 +-
 arch/powerpc/net/bpf_jit_comp.c | 4 +++-
 arch/riscv/net/bpf_jit_core.c   | 2 +-
 arch/x86/net/bpf_jit_comp.c     | 2 +-
 kernel/bpf/core.c               | 5 ++---
 6 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/net/bpf_jit_comp.c b/arch/arm64/net/bpf_jit_comp.c
index f4e4d4578e38..e200b0207f7a 100644
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
diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
index 3d3ed1677d01..c8c8664dccaf 100644
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
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 7b07b43575f1..0ca14b7d0b0e 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -339,8 +339,10 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
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
index 059db1adeaf8..440d5b965e60 100644
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
diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
index de7515ea1bea..d017bb0397b8 100644
--- a/arch/x86/net/bpf_jit_comp.c
+++ b/arch/x86/net/bpf_jit_comp.c
@@ -3988,7 +3988,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			 * Both cases are serious bugs and justify WARN_ON.
 			 */
 			if (WARN_ON(bpf_jit_binary_pack_finalize(header, rw_header))) {
-				/* header has been freed */
+				bpf_jit_binary_pack_free(header, NULL);
 				header = NULL;
 				goto out_image;
 			}
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 47fe047ad30b..77195911a3b3 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -1237,10 +1237,9 @@ int bpf_jit_binary_pack_finalize(struct bpf_binary_header *ro_header,
 
 	kvfree(rw_header);
 
-	if (IS_ERR(ptr)) {
-		bpf_prog_pack_free(ro_header, ro_header->size);
+	if (IS_ERR(ptr))
 		return PTR_ERR(ptr);
-	}
+
 	return 0;
 }
 
-- 
2.34.1

