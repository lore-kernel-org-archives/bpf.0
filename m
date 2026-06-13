Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E5A37FF54;
	Sat, 13 Jun 2026 12:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781354329; cv=none; b=mH2T80B1gV6jusaqxUBLvFYRsLjeEBFqGgAKdyBoGh0Dfngr4X1Gdpe5ni8o9AEQ6AwPN0uXHQLgRM6BzFW3s07Hh3NQnCIoWB/Xm9mDbNFXDimjBid0X1kbWxPUYbAeotlMMyUdB/SE7+Zn896JhPUlm3ip0sARl3O2hIx2occ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781354329; c=relaxed/simple;
	bh=ZFZ3iE6W0HcCW3a9BAq/7fMf0AD35kg2fBoEbGUJcKg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rIlc2wL+fNWhll70zp/hnbGexwuY1h5qeTAYHD3ZKkQPY6Sv8k97h7Q6VJitDJHnhBOMzbWsPU2VfpuElPqCuNjuTTgie+FocE50cqPplDAX4sHg5M44ICIr1QLh5a6NMr/qMpJH6PaHF+w/MGC1OX+E8xncPhLG0Xw62ge/Thg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=P46/gfOC; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="P46/gfOC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=K13arM2R/qD/s5+nXegru39XeB/nByJ
	u15fbPTVRjQk=; b=P46/gfOCdUFxtJLNfbmFouhF34Iumb8zNdnMBz5Nv0gmi2J
	j3FL7DpLFNYXgC4zKCFVkLm933Bb9ScQuvIHCJ9hf7MI6hA+MzZtphnO3fKLpvjm
	crHCI/7gF+KNWFEtXQgRIiLxGUR+8WuRdeKW+qfiFDyQ3gIpIpucHM0qqGGU=
Received: from [127.0.0.1] (unknown [101.6.30.195])
	by web3 (Coremail) with SMTP id ygQGZQD3RJJETy1qoxlnAg--.6726S3;
	Sat, 13 Jun 2026 20:38:29 +0800 (CST)
From: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
Date: Sat, 13 Jun 2026 20:38:27 +0800
Subject: [PATCH bpf-next v2 1/2] bpf: Preserve untrusted memory pointer
 type on scalar add
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260613-f01-03-scalar-add-bpf-next-v2-v2-1-ce07bec3f72b@mails.tsinghua.edu.cn>
References: <20260613-f01-03-scalar-add-bpf-next-v2-v2-0-ce07bec3f72b@mails.tsinghua.edu.cn>
In-Reply-To: <20260613-f01-03-scalar-add-bpf-next-v2-v2-0-ce07bec3f72b@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781354309; l=2066;
 i=gnq25@mails.tsinghua.edu.cn; s=20260605; h=from:subject:message-id;
 bh=ZFZ3iE6W0HcCW3a9BAq/7fMf0AD35kg2fBoEbGUJcKg=;
 b=qEtufUtswkVgNyvVaLNxICBgm1vDEAfxJVjVXBPTBR362KPAqoyxmS+rlm8YPv1x+CIaBelKC
 OjXU8Q5yRMdDdlIwLoe8SZtuP+ev3CJ2Pm1SjAVGrV5GVosY8+fhrtl
X-Developer-Key: i=gnq25@mails.tsinghua.edu.cn; a=ed25519;
 pk=nqQ48fAxVTDp3z/IUmqv6BB+agXPpd8tQjDOBxwlgZo=
X-CM-TRANSID:ygQGZQD3RJJETy1qoxlnAg--.6726S3
X-Coremail-Antispam: 1UD129KBjvJXoW7WF17tw4ftF1fKr4kKr4xCrg_yoW8ZFWfpF
	WkGryrtw4kCF12939xXFWkAFyYk3yft3yUCFW7Z34IvFy7tFy0qF47KFy7XrWFkF48K34r
	tr1Yv3yY9ayUArJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCY02Av
	z4vE14v_Xr1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU0FksPUUUUU==
X-CM-SenderInfo: xjqtjko6pdxz3vow2x5qjk3toohg3hdfq/1tbiAgURA2osh5yKyQAGsN

scalar += rdonly_untrusted_mem reaches adjust_ptr_min_max_vals() with the
pointer as the source register. The untrusted PTR_TO_MEM case returns there
without updating the scalar destination, leaving stale verifier state.

Handle the untrusted PTR_TO_MEM case before the early return. Addition and
pointer-minus-scalar subtraction preserve the pointer type and keep the
existing "do not track offsets" rule for untrusted memory.
Scalar-minus-pointer and unsupported pointer ALU operations are still
rejected instead of being accepted by the early return.

Fixes: f2362a57aeff ("bpf: allow void* cast using bpf_rdonly_cast()")
Signed-off-by: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>
---
 kernel/bpf/verifier.c | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c8d980fdd709..26c67c53166b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13729,8 +13729,32 @@ static int adjust_ptr_min_max_vals(struct bpf_verifier_env *env,
 	 * Accesses to untrusted PTR_TO_MEM are done through probe
 	 * instructions, hence no need to track offsets.
 	 */
-	if (base_type(ptr_reg->type) == PTR_TO_MEM && (ptr_reg->type & PTR_UNTRUSTED))
-		return 0;
+	if (base_type(ptr_reg->type) == PTR_TO_MEM &&
+	    (ptr_reg->type & PTR_UNTRUSTED)) {
+		switch (opcode) {
+		case BPF_ADD:
+			*dst_reg = *ptr_reg;
+			return 0;
+		case BPF_SUB:
+			if (dst_reg == off_reg) {
+				verbose(env, "R%d tried to subtract pointer from scalar\n",
+					dst);
+				return -EACCES;
+			}
+			*dst_reg = *ptr_reg;
+			return 0;
+		case BPF_AND:
+		case BPF_OR:
+		case BPF_XOR:
+			verbose(env, "R%d bitwise operator %s on pointer prohibited\n",
+				dst, bpf_alu_string[opcode >> 4]);
+			return -EACCES;
+		default:
+			verbose(env, "R%d pointer arithmetic with %s operator prohibited\n",
+				dst, bpf_alu_string[opcode >> 4]);
+			return -EACCES;
+		}
+	}
 
 	switch (base_type(ptr_reg->type)) {
 	case PTR_TO_CTX:

-- 
2.34.1

