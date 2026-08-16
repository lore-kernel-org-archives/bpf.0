Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [13.75.44.102])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B0136A376;
	Sun, 16 Aug 2026 10:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.75.44.102
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786877822; cv=none; b=dkrPcpTsFeMcibyabdhtlxvX4s9bBivfSqtOosRKNonratwk1vBNHVGI6FLHEVsJtRw/K5VB7PSl/c4URc8GEo+wGKEZTubKx+sAn7xVfeVvtfjnyOaJq2qqiHijKYCyfdFXfiQtfGEi2tppNrR3L+cJMJltjtV3ENByqHaJAIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786877822; c=relaxed/simple;
	bh=DQ26j5KfDBjdkJdGIUsSNO9aYlVJwusBnVeo+Z7hxC8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bg6hVvIV3ppDgiOJgJX/e3QriB72JfPRVE8sTyaSmm0YfkbK8D4rvI2PJt8KJpT7XysMouVB6qSAL0yfwf4I0I4fO923xEse+0YTlBg8Xsb3J6HVEz3JVKLEMaMo6eBjPxzVNK/wUwfaofcF9X78UbEUTbZ8p1OV21XiIrL9GOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=oqwtBese; arc=none smtp.client-ip=13.75.44.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="oqwtBese"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=ZgJfDn5KQYjme6KfWIFnnNgLsyC3Z6a
	FTYgMcP1BOnM=; b=oqwtBese1EQihmrYuDlHJdwhwC41H2xIue7Xsd00VPhNfnn
	EOBlk5xhFhkaFs3V/L4GxvHehMqN1pYAVCxeYZEit44J8xDRzyE6a9xhde9Doi0y
	vjYSKoTSxJF+CnBvIcCivIhD2+AwcQR3xnNQO+uq7GBtb9KRFfW0Qejs9tsM=
Received: from [172.17.0.4] (unknown [101.6.30.195])
	by web1 (Coremail) with SMTP id yAQGZQB3Gclkl4FqEsoEAg--.40530S3;
	Sun, 16 Aug 2026 18:56:44 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Sun, 16 Aug 2026 10:56:33 +0000
Subject: [PATCH bpf-next v2 1/2] bpf: Check pointer type for all atomic RMW
 paths
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260816-bpf-next-038-mixed-atomic-v1-v2-1-4644c1886dbc@mails.tsinghua.edu.cn>
References: <20260816-bpf-next-038-mixed-atomic-v1-v2-0-4644c1886dbc@mails.tsinghua.edu.cn>
In-Reply-To: <20260816-bpf-next-038-mixed-atomic-v1-v2-0-4644c1886dbc@mails.tsinghua.edu.cn>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786877805; l=1514;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=DQ26j5KfDBjdkJdGIUsSNO9aYlVJwusBnVeo+Z7hxC8=;
 b=7uk+GBhXfxI0d48fmH00zZR9L9LBHeYamKEb2pC/Wava5LMk19W1rCAKIUvVeeeR5krvZm8vm
 J8o2YNzvxmTDQ80n7NCLKffoR+17RERCq+ztVwd0PIrEa6yci+qcqOf
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yAQGZQB3Gclkl4FqEsoEAg--.40530S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw43Cr1fAryUWF15tw13Arb_yoW8XF4xpr
	4kGasFq3yvv347uwnrAF48Cry5KF4rtw47Gw1jvw1ftF17tFs0qFW8K3W3Za4Ykr40q342
	yFWjvr9Y9a4UuFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9v1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Av
	z4vE14v_Gw1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xva
	j40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JV
	W8JrUvcSsGvfC2KfnxnUUI43ZEXa7VU1Z2-7UUUUU==
X-CM-SenderInfo: xfkh05r1stqzpdlo2hxwvl0wxkxdhvlgxou0/

Atomic RMW verification records an instruction pointer type only when the
current destination is PTR_TO_ARENA. A second path can therefore reach the
same instruction with an ordinary pointer without comparing it against the
saved arena type.

The post-verification fixup uses the saved type to rewrite the instruction
to BPF_PROBE_ATOMIC for every path. Record the actual destination type for
all atomic RMW paths so the existing mismatch check rejects incompatible
uses of one instruction.

Fixes: d503a04f8bc0 ("bpf: Add support for certain atomics in bpf_arena to x86 JIT")
Signed-off-by: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 kernel/bpf/verifier.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index d17f14b35b79f..93463caf5c9ad 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6739,11 +6739,9 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
 	if (err)
 		return err;
 
-	if (is_arena_reg(env, insn->dst_reg)) {
-		err = save_aux_ptr_type(env, PTR_TO_ARENA, false);
-		if (err)
-			return err;
-	}
+	err = save_aux_ptr_type(env, dst_reg->type, false);
+	if (err)
+		return err;
 	/* Check whether we can write into the same memory. */
 	err = check_mem_access(env, env->insn_idx, dst_reg, argno_from_reg(insn->dst_reg), insn->off,
 			       BPF_SIZE(insn->code), BPF_WRITE, -1, true, false);

-- 
2.43.0

