Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795EC33BBC0;
	Sat, 25 Jul 2026 15:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784994292; cv=none; b=jNGJMHAVFp1V4VPTV5XrAb5b5dYh+91fHA0GQ8wYl11ETV/XRiUYKFO98lqFaSGiX3N4yJsVUI4jj2G75N0p7sZIdCVUPPopsqjoVLJqI6xmETey7DkNptqhfRI7rvUHaODmmzT0esiUSJ+TnCREGSOlRlhiIRC3joB0J552Ro4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784994292; c=relaxed/simple;
	bh=tygjhcvY1sEn3qbQZdFMN5H8VtpSDzovVv8+VgwEAVo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Al2lYhG46NDg/4X9eXYZUHhKW2N4/RvhL5HqB/84rbOFtNKWrpFml9dzEPAQgUfEaKfXstxgo3SNx8Z+ZpkoT7DLJXn65TIpxxJ0qrbnwz29yjqgCqYB5EAQl4vvDqRSF2hQcu1kRLPFxVRl5V5EhhgaAQa8Qd7FEVSyz//hSKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4h6q095sMhzKHMbd;
	Sat, 25 Jul 2026 23:43:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 865F6408AA;
	Sat, 25 Jul 2026 23:44:42 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP1 (Coremail) with UTF8SMTPA id cCh0CgCXpXHo2WRqLfYVCg--.46096S5;
	Sat, 25 Jul 2026 23:44:42 +0800 (CST)
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
Subject: [PATCH bpf-next v3 3/9] parisc: Fix memory leak in bpf_jit_free
Date: Sat, 25 Jul 2026 15:49:09 +0000
Message-Id: <20260725154915.2488611-4-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260725154915.2488611-1-pulehui@huaweicloud.com>
References: <20260725154915.2488611-1-pulehui@huaweicloud.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXpXHo2WRqLfYVCg--.46096S5
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1kCryDAr4UAF48Wr4fuFg_yoW8Xr1UpF
	98Cw13Cr4vgr4Igrs3Ja1xZFW5Jw4kWw15WFW7u3y0g3Z0gw1kWF1Ska4rGFZ0kryUXw4r
	Xr4rKry3GrykJ3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1l
	e2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI
	8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwAC
	jcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0x
	kIwI1lc7CjxVAaw2AFwI0_GFv_Wryl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
	Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1V
	AY17CE14v26r4a6rW5MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAI
	cVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMI
	IF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j6F4UJbIYCTnI
	WIevJa73UjIFyTuYvjTRM6wCDUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

If a subprogram fails to JIT in jit_subprogs(), previously JITed
subprograms are freed. However, the generic bpf_jit_free() fails to
free their leftover jit_data, causing a memory leak.

Implement a custom bpf_jit_free() to free this data.

Fixes: 22de5d626231 ("parisc: Add eBPF JIT compiler glue code and Makefile")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 arch/parisc/net/bpf_jit_core.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/arch/parisc/net/bpf_jit_core.c b/arch/parisc/net/bpf_jit_core.c
index 172770132440..ef63c38bdf15 100644
--- a/arch/parisc/net/bpf_jit_core.c
+++ b/arch/parisc/net/bpf_jit_core.c
@@ -178,6 +178,25 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	goto out_offset;
 }
 
+void bpf_jit_free(struct bpf_prog *fp)
+{
+	if (fp->jited) {
+		struct hppa_jit_data *jit_data = fp->aux->jit_data;
+		struct bpf_binary_header *hdr = bpf_jit_binary_hdr(fp);
+
+		/* Cleanup for earlier subprogs if jit_subprogs() aborts */
+		if (jit_data) {
+			kfree(jit_data->ctx.offset);
+			kfree(jit_data);
+		}
+
+		bpf_jit_binary_free(hdr);
+		WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
+	}
+
+	bpf_prog_unlock_free(fp);
+}
+
 u64 hppa_div64(u64 div, u64 divisor)
 {
 	div = div64_u64(div, divisor);
-- 
2.34.1

