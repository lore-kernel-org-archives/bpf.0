Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA3F3BBA1A
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781266294; cv=none; b=rayOp178XbG+tWT1+3Thhg/I8XTS7i+VCSef4CWQaCgTKF5yfEMtZsvTr94WP56RnynMv4NIQ7gVwKX4Bb604Qegw8JKJvrPRoMbjDzUL2QcQ6vFiq9kWinPwfhgUO9U9w+/kip/U4gdTUGS0LCxZvyxoMmiikNZocaVembuIWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781266294; c=relaxed/simple;
	bh=qorWLy1BHOl4e1vkT4VVhRiP+c8vPwzVsySSuOAxcC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JbrOMvaw3fGk9n43kkWP9dmDqUCLf3keMgS95J46gRW6qM4HQte0MBWQPu98LHMd1vP9fKy534g5hRqWtpG1DbOXOJfioisxT8AnnLAuAhCZAX2tR7u7Hb/INJPSSBBpzxp+SgLPa5WtV5K1/0YgxSaQ2vL30G+jyTGCw1iYv7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.57.97])
	by mtasvr (Coremail) with SMTP id _____wA3lztl9ytqIOeCAg--.16103S3;
	Fri, 12 Jun 2026 20:11:17 +0800 (CST)
Received: from localhost.localdomain (unknown [10.162.57.97])
	by mail-app2 (Coremail) with SMTP id zC_KCgAXqtBk9ytqPewAAg--.57641S2;
	Fri, 12 Jun 2026 20:11:17 +0800 (CST)
From: Tianci Cao <ziye@zju.edu.cn>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	tangyazhou518@outlook.com,
	shenghaoyuan0928@163.com,
	ziye@zju.edu.cn
Subject: [PATCH bpf-next v2 2/2] selftests/bpf: Add tests for non-const src shift
Date: Fri, 12 Jun 2026 20:10:38 +0800
Message-ID: <20260612121041.25254-3-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612121041.25254-1-ziye@zju.edu.cn>
References: <20260612121041.25254-1-ziye@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zC_KCgAXqtBk9ytqPewAAg--.57641S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?p98QJAXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083gQkFDeLwlqL5lzEaRMYLHJ0ju4ivMOLCffUoEHyrJq3eKmEWdn9ek9J64oTujaDQlkN
	iG2Y12L/weeU2+cEUvbzyYr7BDRcMckJpVHlJ7+X
X-Coremail-Antispam: 1Uk129KBj93XoW3Gry5ZF4rCFy5KFW7XFyUXFc_yoW7Gw1Upr
	93K345ArykCr909w1fCFZxJFWYyFs5Zw45tr18Ar18AFyUur17tw4IkryfArn3AFyxZr1a
	vF9rXa9rWF4DGFbCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc
	02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAF
	wI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0Y48IcxkI7V
	AKI48G6xCjnVAKz4kxM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC2
	0s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI
	0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE
	14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20x
	vaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1iZ23UUUUU==

Add test cases for shift operations with non-const but bounded source
operand:
- shift_with_non_const_src_lsh: Tests left shift (BPF_LSH) where the shift
  amount is in range [1, 4] and the destination is a known constant (1).
  The verifier should compute correct bounds [2, 16] for the result.
- shift_with_non_const_src_rsh: Tests logical right shift (BPF_RSH) where
  the shift amount is in range [1, 4] and the destination is 0xff. The
  verifier should compute correct bounds [15, 127] for the result.
- shift_with_non_const_src_arsh: Tests arithmetic right shift (BPF_ARSH)
  where the shift amount is in range [1, 4] and the destination is a
  negative constant (-8). The verifier applies the three-branch signed
  bound logic to derive result bounds [-4, -1]. When the shift amount is
  non-constant, the var_off is conservatively set to tnum_unknown.

Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 108 ++++++++++++++++++
 1 file changed, 108 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index bc038ac2df98..63ee7603d482 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -482,6 +482,114 @@ l0_%=:	/* exit */					\
 	: __clobber_all);
 }
 
+SEC("socket")
+__description("pure bounds check after non-const 32-bit left shift")
+__success __log_level(2)
+__msg("w1 <<= w2 {{.*}}; R1=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=16,var_off=(0x0; 0x1f))")
+__naked void shift_with_non_const_src_lsh_32(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w2 = w0;					\
+	w2 &= 3;					\
+	w2 += 1;					\
+	w1 = 1;						\
+	w1 <<= w2;					\
+	exit;						\
+"	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("pure bounds check after non-const 32-bit right shift")
+__success __log_level(2)
+__msg("w1 >>= w2 {{.*}}; R1=scalar(smin=umin=smin32=umin32=15,smax=umax=smax32=umax32=127,var_off=(0x0; 0x7f))")
+__naked void shift_with_non_const_src_rsh_32(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w2 = w0;					\
+	w2 &= 3;					\
+	w2 += 1;					\
+	w1 = 0xff;					\
+	w1 >>= w2;					\
+	exit;						\
+"	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("pure bounds check after non-const 32-bit arithmetic shift")
+__success __log_level(2)
+__msg("w1 s>>= w2 {{.*}}; R1=scalar(smin=umin=umin32=0xfffffffc,smax=umax=0xffffffff,smin32=-4,smax32=-1,var_off=(0xfffffffc; 0x3)) R2=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))")
+__naked void shift_with_non_const_src_arsh_32(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	w2 = w0;					\
+	w2 &= 3;					\
+	w2 += 1;					\
+	w1 = -8;					\
+	w1 s>>= w2;					\
+	exit;						\
+"	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("pure bounds check after non-const 64-bit left shift")
+__success __log_level(2)
+__msg("r1 <<= r2 {{.*}}; R1=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=16,var_off=(0x0; 0x1f))")
+__naked void shift_with_non_const_src_lsh_64(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	r2 &= 3;					\
+	r2 += 1;					\
+	r1 = 1;						\
+	r1 <<= r2;					\
+	exit;						\
+"	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("pure bounds check after non-const 64-bit right shift")
+__success __log_level(2)
+__msg("r1 >>= r2 {{.*}}; R1=scalar(smin=umin=smin32=umin32=15,smax=umax=smax32=umax32=127,var_off=(0x0; 0x7f))")
+__naked void shift_with_non_const_src_rsh_64(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	r2 &= 3;					\
+	r2 += 1;					\
+	r1 = 0xff;					\
+	r1 >>= r2;					\
+	exit;						\
+"	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
+SEC("socket")
+__description("pure bounds check after non-const 64-bit arithmetic shift")
+__success __log_level(2)
+__msg("r1 s>>= r2 {{.*}}; R1=scalar(smin=smin32=-4,smax=smax32=-1,umin=0xfffffffffffffffc,umin32=0xfffffffc,var_off=(0xfffffffffffffffc; 0x3)) R2=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))")
+__naked void shift_with_non_const_src_arsh_64(void)
+{
+	asm volatile ("					\
+	call %[bpf_get_prandom_u32];			\
+	r2 = r0;					\
+	r2 &= 3;					\
+	r2 += 1;					\
+	r1 = -8;					\
+	r1 s>>= r2;					\
+	exit;						\
+"	:: __imm(bpf_get_prandom_u32)
+	: __clobber_all);
+}
+
 SEC("socket")
 __description("bounds check after 32-bit right shift with 64-bit input")
 __failure __msg("math between map_value pointer and 4294967294 is not allowed")
-- 
2.43.0

