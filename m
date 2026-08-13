Received: from tsinghua.edu.cn (smtp47.tsinghua.edu.cn [101.6.4.71])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07373C5526;
	Thu, 13 Aug 2026 12:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.6.4.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622793; cv=none; b=azyXc1Dq2K3+OOjBXbI31EE9/nLytbTp3u5itIj7KBRk09KMlUjD3049jnnVuTlc+oFxD3vzHaxmN5DMMeZ1Ks7eN16jmkcvD7Mo8H9e4bl5b/5L60izXMIu2pNsgzP+EPYCmsIgpHrLQcLqj5/lBwIm1zq+vCHJ+zuK+GU1TBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622793; c=relaxed/simple;
	bh=ZB1u8jji+0VL7AvM+I75o7mMwE0wZChFD7mjV+N8mVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jKosuURYO/gfyTslnCcmrky4mW6rN/tbb+5WK+wMBwpYHAZbq/WIEEGKFFKC37vVnTpPtT6gHyubNEz4CY8N43RLpL/D1oWmritfaP5puLvj+9DCBLnFInUfl52zIZBMAxAzY521DTmK/LGVS8QjLsV3zMI+YUWZw4te/XX9Bho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn; dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b=gOWqM2F6; arc=none smtp.client-ip=101.6.4.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mails.tsinghua.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mails.tsinghua.edu.cn header.i=@mails.tsinghua.edu.cn header.b="gOWqM2F6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mails.tsinghua.edu.cn; s=dkim; h=Received:From:Date:Subject:
	MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:
	References:In-Reply-To:To:Cc; bh=6DzfoD2xT+MsQwO/csAq5sVs/v+Tek+
	uBFzuHy9rXCo=; b=gOWqM2F683AH59uQVcZH0NvV1n3blJ6f9BClk7A5NlktBRr
	11pp6UGBumlFErBVxf2mP25URb0ZiPlXQpTy5FiJWLeSL6FzLXkHRKjXhaCCgEir
	qbcotipLwvMpSWgAGEYEsSpxdPEj0U0XVCtEStCGc6FpAHTRCs8IwwYzUEvI=
Received: from [172.17.0.4] (unknown [101.6.30.195])
	by web2 (Coremail) with SMTP id yQQGZQCXlLYLsn1qPyv_AA--.41218S3;
	Thu, 13 Aug 2026 20:01:20 +0800 (CST)
From: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>
Date: Thu, 13 Aug 2026 12:01:03 +0000
Subject: [PATCH bpf-next 1/2] bpf: Check pointer type for all atomic RMW
 paths
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260813-bpf-next-038-mixed-atomic-v1-v1-1-e79aadb46a8a@mails.tsinghua.edu.cn>
References: <20260813-bpf-next-038-mixed-atomic-v1-v1-0-e79aadb46a8a@mails.tsinghua.edu.cn>
In-Reply-To: <20260813-bpf-next-038-mixed-atomic-v1-v1-0-e79aadb46a8a@mails.tsinghua.edu.cn>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786622482; l=1466;
 i=chenyy23@mails.tsinghua.edu.cn; s=kernel; h=from:subject:message-id;
 bh=ZB1u8jji+0VL7AvM+I75o7mMwE0wZChFD7mjV+N8mVo=;
 b=LAyWXd2FHhTujPf2ZRvj7Yh7lcWtqcup3JwYE7t/ChTUvzin/7VLQXCAvK6TMQtUa98VIis3c
 sN1by8UOT/YBFWpf6/KMyiswNb123UkyNcZ8KA81OR3e8E0Uo76u6X/
X-Developer-Key: i=chenyy23@mails.tsinghua.edu.cn; a=ed25519;
 pk=+Q11PEDVzoU+87KHlIeNWKwv/GiutzE5094ej7opM+s=
X-CM-TRANSID:yQQGZQCXlLYLsn1qPyv_AA--.41218S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Kw43Cr1fAryUWF15tw13Arb_yoW8Xr45pr
	48tF90q3yvv3W7uwnrAF48Zry5Ga1rt3y7GF1jvw1ftF1YqFs0qFW8K3W3Za4Ykr4vg342
	vFWYvrsY9a4UuFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l8cAvFVAK
	0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUCVW8JwA2z4
	x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2
	z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw20F6cxK64vIFxWle2I262IYc4
	CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4r
	Kr1UJr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc
	8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCY02Av
	z4vE14v_Xr1l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8Ww4UJr1UMxC20s
	026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_
	JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14
	v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8I
	cIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r
	4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU1eWlPUUUUU==
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
---
 kernel/bpf/verifier.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 164d16c243ca6..3d672f6665bec 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6509,11 +6509,9 @@ static int check_atomic_rmw(struct bpf_verifier_env *env,
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

