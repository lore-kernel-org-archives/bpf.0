Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6FB43D565F
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 12:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.161.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782216177; cv=none; b=Vvd+0okKth3sghkQNVOePt30e5oajrX1mkJP5WtwHNjqw8MjhqGv5XZQzghuNoOgmf9rUybxvdMGr92hw4WVYbsaL1ncErPi91THqO4SBuHk94h6U8K/A2oIhgwmri91eRXQ1FAYr4ey3Y5274+3kE30oJ74D72coLCUZxxyzoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782216177; c=relaxed/simple;
	bh=Em+G8wG5OOlDDv+h7mTWBgurWYXzo64GZeBXveuDXgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mFhjx61HCzsP+bCS4Z9y3EXsJN9tz7Zk/P09qzhJ1dJlSqo/IoqLFa87lbLemksW67OAtNO4q0d8P7nCLPN+SpTeEBijGz4l4va8/Gtgqd2pIGQ3euLJSWxSadv/1Fb7k5nkHUQwGH3cRlK/oTjnaQvnxQxRawmCjPXFjB8dvEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=162.243.161.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.57.97])
	by mtasvr (Coremail) with SMTP id _____wDXZQnmdTpql3z9Ag--.12205S3;
	Tue, 23 Jun 2026 20:02:46 +0800 (CST)
Received: from localhost.localdomain (unknown [10.162.57.97])
	by mail-app3 (Coremail) with SMTP id zS_KCgAnrW7kdTpqQvtzAg--.29614S2;
	Tue, 23 Jun 2026 20:02:45 +0800 (CST)
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
Subject: [PATCH bpf-next 2/2] selftests/bpf: Add tests for non-const src shift with bounded dst
Date: Tue, 23 Jun 2026 20:02:18 +0800
Message-ID: <20260623120218.25869-3-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260623120218.25869-1-ziye@zju.edu.cn>
References: <20260623120218.25869-1-ziye@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zS_KCgAnrW7kdTpqQvtzAg--.29614S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?LwFuOwXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083jO/wNhIP+pglnkLd0BnOseXv1c7II/hpngBR5jCitoEclNsWV8CPERisfiSglV847/X
	sY0et4VrViBj6rB+m1eOzd4IW7/Oam7APkTTWnhX
X-Coremail-Antispam: 1Uk129KBj93XoW3Ary5Gry7Zry7CryDWFWfWFX_yoWfWF4xpF
	Z5Gry7CryDCF4av3W09F4aqFWYyFn3Za90qF17uF1xA34Y934YqFyakry5Crn5J3yxZ3ya
	qFWkXF9rGFW8J3XCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

Extend the non-const src shift tests to cover scenarios where the
destination is also a bounded random value, not a constant. This
stresses the verifier's ability to compute correct bounds and var_off
when both shift operands carry unknown bits.

Also add overflow-src variants for the BPF_LSH, BPF_RSH and BPF_ARSH
tests where the shift amount src is in range [32, 35] for 32-bit shifts
or [64, 67] for 64-bit shifts. These cases confirm that the verifier
correctly drops the dst register bounds (R1=scalar()) when the shift
amount exceeds the operand width.

The full set of new and extended tests:

  [lsh]  [32]: dst=1,        src=[1, 4]     (dst=const, src=bounded)
  [lsh]  [32]: dst=1,        src=[32, 35]   (overflow src)
  [lsh]  [64]: dst=1,        src=[1, 4]     (dst=const, src=bounded)
  [lsh]  [64]: dst=1,        src=[64, 67]   (overflow src)
  [rsh]  [32]: dst=0xff,     src=[1, 4]     (dst=const, src=bounded)
  [rsh]  [32]: dst=1,        src=[32, 35]   (overflow src)
  [rsh]  [64]: dst=0xff,     src=[1, 4]     (dst=const, src=bounded)
  [rsh]  [64]: dst=1,        src=[64, 67]   (overflow src)
  [arsh] [32]: dst=-8,       src=[1, 4]     (dst=const, src=bounded)
  [arsh] [32]: dst=1,        src=[32, 35]   (overflow src)
  [arsh] [64]: dst=-8,       src=[1, 4]     (dst=const, src=bounded)
  [arsh] [64]: dst=1,        src=[64, 67]   (overflow src)
  [arsh] [32]: dst=[1, 8],   src=[1, 2]     (positive dst)
  [arsh] [32]: dst=[-8, 7],  src=[1, 2]     (mixed-sign dst)
  [arsh] [32]: dst=[-16,-8], src=[1, 2]     (negative / overflow dst)
  [arsh] [64]: dst=[1, 8],   src=[1, 2]     (positive dst)
  [arsh] [64]: dst=[-8, 7],  src=[1, 2]     (mixed-sign dst)
  [arsh] [64]: dst=[-16,-8], src=[1, 2]     (negative / overflow dst)

Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
---
 .../selftests/bpf/progs/verifier_bounds.c     | 167 ++++++++++++++++++
 1 file changed, 167 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bounds.c b/tools/testing/selftests/bpf/progs/verifier_bounds.c
index bc038ac2df98..52ae3dc59360 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bounds.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bounds.c
@@ -482,6 +482,173 @@ l0_%=:	/* exit */					\
 	: __clobber_all);
 }
 
+#define SHIFT_NON_CONST_SRC_TEST(name, desc, rand, dst, src, op, src_add, dst_init, msg) \
+	SEC("socket")					\
+	__description(desc)				\
+	__success __log_level(2)			\
+	__msg(#dst " " op " " #src " {{.*}}; " msg)	\
+	__naked void name(void)				\
+	{						\
+		asm volatile ("				\
+		call %[bpf_get_prandom_u32];		\
+		" #src " = " #rand ";			\
+		" #src " &= 3;				\
+		" #src " += " #src_add ";		\
+		" #dst " = " #dst_init ";		\
+		" #dst " " op " " #src ";		\
+		exit;					\
+"		:: __imm(bpf_get_prandom_u32)		\
+		: __clobber_all);			\
+	}
+
+SHIFT_NON_CONST_SRC_TEST(
+	shift_with_non_const_src_lsh_32,
+	"bounds check after non-const 32-bit left shift",
+	w0, w1, w2, "<<=", 1, 1,
+	"R1=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=16,var_off=(0x0; 0x1f))"
+)
+
+SHIFT_NON_CONST_SRC_TEST(
+	shift_with_non_const_src_lsh_32_overflow,
+	"bounds check after non-const 32-bit lsh with overflow src",
+	w0, w1, w2, "<<=", 32, 1,
+	"R1=scalar() R2=scalar(smin=umin=smin32=umin32=32,smax=umax=smax32=umax32=35,var_off=(0x20; 0x3))"
+)
+
+SHIFT_NON_CONST_SRC_TEST(
+	shift_with_non_const_src_rsh_32,
+	"bounds check after non-const 32-bit right shift",
+	w0, w1, w2, ">>=", 1, 0xff,
+	"R1=scalar(smin=umin=smin32=umin32=15,smax=umax=smax32=umax32=127,var_off=(0x0; 0x7f))"
+)
+
+SHIFT_NON_CONST_SRC_TEST(
+	shift_with_non_const_src_rsh_32_overflow,
+	"bounds check after non-const 32-bit rsh with overflow src",
+	w0, w1, w2, ">>=", 32, 1,
+	"R1=scalar() R2=scalar(smin=umin=smin32=umin32=32,smax=umax=smax32=umax32=35,var_off=(0x20; 0x3))"
+)
+
+SHIFT_NON_CONST_SRC_TEST(
+	shift_with_non_const_src_arsh_32,
+	"bounds check after non-const 32-bit arithmetic shift",
+	w0, w1, w2, "s>>=", 1, -8,
+	"R1=scalar(smin=umin=umin32=0xfffffffc,smax=umax=0xffffffff,smin32=-4,smax32=-1,var_off=(0xfffffffc; 0x3)) R2=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))"
+)
+
+SHIFT_NON_CONST_SRC_TEST(
+	shift_with_non_const_src_arsh_32_overflow,
+	"bounds check after non-const 32-bit arsh with overflow src",
+	w0, w1, w2, "s>>=", 32, 1,
+	"R1=scalar() R2=scalar(smin=umin=smin32=umin32=32,smax=umax=smax32=umax32=35,var_off=(0x20; 0x3))"
+)
+
+SHIFT_NON_CONST_SRC_TEST(
+	shift_with_non_const_src_lsh_64,
+	"bounds check after non-const 64-bit left shift",
+	r0, r1, r2, "<<=", 1, 1,
+	"R1=scalar(smin=umin=smin32=umin32=2,smax=umax=smax32=umax32=16,var_off=(0x0; 0x1f))"
+)
+
+SHIFT_NON_CONST_SRC_TEST(
+	shift_with_non_const_src_lsh_64_overflow,
+	"bounds check after non-const 64-bit lsh with overflow src",
+	r0, r1, r2, "<<=", 64, 1,
+	"R1=scalar() R2=scalar(smin=umin=smin32=umin32=64,smax=umax=smax32=umax32=67,var_off=(0x40; 0x3))"
+)
+
+SHIFT_NON_CONST_SRC_TEST(
+	shift_with_non_const_src_rsh_64,
+	"bounds check after non-const 64-bit right shift",
+	r0, r1, r2, ">>=", 1, 0xff,
+	"R1=scalar(smin=umin=smin32=umin32=15,smax=umax=smax32=umax32=127,var_off=(0x0; 0x7f))"
+)
+
+SHIFT_NON_CONST_SRC_TEST(
+	shift_with_non_const_src_rsh_64_overflow,
+	"bounds check after non-const 64-bit rsh with overflow src",
+	r0, r1, r2, ">>=", 64, 1,
+	"R1=scalar() R2=scalar(smin=umin=smin32=umin32=64,smax=umax=smax32=umax32=67,var_off=(0x40; 0x3))"
+)
+
+SHIFT_NON_CONST_SRC_TEST(
+	shift_with_non_const_src_arsh_64,
+	"bounds check after non-const 64-bit arithmetic shift",
+	r0, r1, r2, "s>>=", 1, -8,
+	"R1=scalar(smin=smin32=-4,smax=smax32=-1,umin=0xfffffffffffffffc,umin32=0xfffffffc,var_off=(0xfffffffffffffffc; 0x3)) R2=scalar(smin=umin=smin32=umin32=1,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))"
+)
+
+SHIFT_NON_CONST_SRC_TEST(
+	shift_with_non_const_src_arsh_64_overflow,
+	"bounds check after non-const 64-bit arsh with overflow src",
+	r0, r1, r2, "s>>=", 64, 1,
+	"R1=scalar() R2=scalar(smin=umin=smin32=umin32=64,smax=umax=smax32=umax32=67,var_off=(0x40; 0x3))"
+)
+
+#define SHIFT_ARSH_DST_RANGE_TEST(name, desc, rand, dst, src, dst_mask, dst_delta, msg) \
+	SEC("socket")					\
+	__description(desc)				\
+	__success __log_level(2)			\
+	__msg(#dst " s>>= " #src " {{.*}}; {{.*}} " msg)\
+	__naked void name(void)				\
+	{						\
+		asm volatile ("				\
+		call %[bpf_get_prandom_u32];		\
+		" #dst " = " #rand ";			\
+		" #dst " &= " #dst_mask ";		\
+		" #dst " += " #dst_delta ";		\
+		call %[bpf_get_prandom_u32];		\
+		" #src " = " #rand ";			\
+		" #src " &= 1;				\
+		" #src " += 1;				\
+		" #dst " s>>= " #src ";			\
+		exit;					\
+"		:: __imm(bpf_get_prandom_u32)		\
+		: __clobber_all);			\
+	}
+
+SHIFT_ARSH_DST_RANGE_TEST(
+	shift_with_non_const_src_arsh_32_pos,
+	"bounds check after non-const 32-bit arsh with positive dst",
+	w0, w6, w2, 7, 1,
+	"R6=scalar(smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))"
+)
+
+SHIFT_ARSH_DST_RANGE_TEST(
+	shift_with_non_const_src_arsh_32_mixed,
+	"bounds check after non-const 32-bit arsh with mixed-sign dst",
+	w0, w6, w2, 15, -8,
+	"R6=scalar(smin=0,smax=umax=0xffffffff,smin32=-4,smax32=3,var_off=(0x0; 0xffffffff))"
+)
+
+SHIFT_ARSH_DST_RANGE_TEST(
+	shift_with_non_const_src_arsh_32_neg,
+	"bounds check after non-const 32-bit arsh with negative dst",
+	w0, w6, w2, 8, -16,
+	"R6=scalar(smin=umin=umin32=0xfffffff8,smax=umax=umax32=0xfffffffe,smin32=-8,smax32=-2,var_off=(0xfffffff8; 0x7))"
+)
+
+SHIFT_ARSH_DST_RANGE_TEST(
+	shift_with_non_const_src_arsh_64_pos,
+	"bounds check after non-const 64-bit arsh with positive dst",
+	r0, r6, r2, 7, 1,
+	"R6=scalar(smin=smin32=0,smax=umax=smax32=umax32=4,var_off=(0x0; 0x7))"
+)
+
+SHIFT_ARSH_DST_RANGE_TEST(
+	shift_with_non_const_src_arsh_64_mixed,
+	"bounds check after non-const 64-bit arsh with mixed-sign dst",
+	r0, r6, r2, 15, -8,
+	"R6=scalar(smin=smin32=-4,smax=smax32=3)"
+)
+
+SHIFT_ARSH_DST_RANGE_TEST(
+	shift_with_non_const_src_arsh_64_neg,
+	"bounds check after non-const 64-bit arsh with negative dst",
+	r0, r6, r2, 8, -16,
+	"R6=scalar(smin=smin32=-8,smax=smax32=-2,umin=0xfffffffffffffff8,umax=0xfffffffffffffffe,umin32=0xfffffff8,umax32=0xfffffffe,var_off=(0xfffffffffffffff8; 0x7))"
+)
+
 SEC("socket")
 __description("bounds check after 32-bit right shift with 64-bit input")
 __failure __msg("math between map_value pointer and 4294967294 is not allowed")
-- 
2.43.0

