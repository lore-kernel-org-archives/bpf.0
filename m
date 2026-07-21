Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EDE8446072;
	Tue, 21 Jul 2026 09:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784626816; cv=none; b=GRxwl6KPKWhRksWwkLwoA6xpp7mu7MkvbPXrU5ljcjYEybynsnGAV0F0x9uUQDGMFDsefe6ZTVe9RnhFDFuNxauMISdaHxmgBqitJ3U4UAmstot+rBXLnAPe2qqHLzv5FQmSpy6QIDaDd/qowCuX2lWC9RVkNhvGzOo9/S0dYHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784626816; c=relaxed/simple;
	bh=4Eh/RxkQJHDfqyPfKE/LkZkNntH4SB3qBdeIqcJg+Gw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W3ZJ8WBc8Gq4r65vJvNAEiIySUGpSApK/4UVsdDNNeGm3mPI7FUdMWZnmI/QjXrbtWvcp0m3bh2axzNVAH+u3lMlInY7RRcLn1UljqdstxuF9pGdwVIytQi+O1Q0VNtzfgfzJukXqcB1OnokFaKmrMMFUB0NjjgQawsARfQ491U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=VTjO4Yt9; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="VTjO4Yt9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:
	Date:Message-Id:In-Reply-To:References:MIME-Version:
	Content-Transfer-Encoding; bh=GyeSxN+qtR8+J1Gn31f9yWA79fnqxHbEV0
	vee7rOiIM=; b=VTjO4Yt9SJ7UQ/l719fSI4TNMJZdb/yIRS3UTKvAKSEG2vlVwc
	gvTVCjxBmVfUf5p9AJ09OSF9FnDJgGYIH0sa8BOVvYlTgmJksByLvOeeVb5GN0we
	AnYmeOftOYryalKpF3wWZ4ccb36G5s5fVqLpZ1yn7vKDb2rgAgn9UuWog=
Received: from c9a6c405b3f2.. (unknown [202.112.238.121])
	by web2 (Coremail) with SMTP id yQQGZQB3dbdfPl9q4NAnAA--.61424S3;
	Tue, 21 Jul 2026 17:39:57 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Subject: [PATCH 1/2] bpf: Preserve stack frame number for commuted arithmetic
Date: Tue, 21 Jul 2026 09:39:42 +0000
Message-Id: <a092a059781aad37b8d8ce3bb927052de5f73431.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1784563950.git.chenyy23@mails.tsinghua.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yQQGZQB3dbdfPl9q4NAnAA--.61424S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kr1rtw1xZF47tF4DJr4ktFb_yoW8tF4fpr
	s3G3s3tr4vyw47uanFv3WkAr98Gw4vq34xCFy8A34Iy3WUJF9YqrWfKFy3A39akrWkt34I
	yr15u34a9ayUZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUH014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr0_GcWl
	nxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4
	CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvj
	eVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I
	1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67AK6r4f
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUUwID3UUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

When scalar += pointer is handled in adjust_ptr_min_max_vals(), the
destination register has to inherit the pointer register state from the
source pointer. Copying only selected fields is fragile because pointer
provenance is tracked by several bpf_reg_state fields.

For the commuted form, pass a temporary scalar offset register to the
common pointer arithmetic helper and copy the full pointer state before
applying pointer arithmetic. This preserves the frame number for
PTR_TO_STACK registers and keeps parent identity fields consistent.

Fixes: f1174f77b50c ("bpf/verifier: rework value tracking")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 52be0a118cce0..3c0af83db4672 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13796,11 +13796,12 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 		return -EACCES;
 	}
 
-	/* In case of 'scalar += pointer', dst_reg inherits pointer type and id.
-	 * The id may be overwritten later if we create a new variable offset.
+	/* For 'scalar += pointer', dst_reg inherits the complete pointer
+	 * register state. Individual fields may be adjusted later by pointer
+	 * arithmetic.
 	 */
-	dst_reg->type = ptr_reg->type;
-	dst_reg->id = ptr_reg->id;
+	if (ptr_reg != dst_reg)
+		*dst_reg = *ptr_reg;
 
 	if (!check_reg_sane_offset_scalar(env, off_reg, ptr_reg->type) ||
 	    !check_reg_sane_offset_ptr(env, ptr_reg, ptr_reg->type))
@@ -14854,15 +14855,18 @@ static int adjust_reg_min_max_vals(struct bpf_verifier_env *env,
 					bpf_alu_string[opcode >> 4]);
 				return -EACCES;
 			} else {
+				struct bpf_reg_state off_reg;
+
 				/* scalar += pointer
 				 * This is legal, but we have to reverse our
 				 * src/dest handling in computing the range
 				 */
+				off_reg = *dst_reg;
 				err = mark_chain_precision(env, insn->dst_reg);
 				if (err)
 					return err;
 				return adjust_ptr_min_max_vals(env, insn,
-							       src_reg, dst_reg);
+							       src_reg, &off_reg);
 			}
 		} else if (ptr_reg) {
 			/* pointer += scalar */

base-commit: 0bcca2a42cc50b7d64a95c08dffc6b93661a7ea2
-- 
2.34.1

