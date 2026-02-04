Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE713E9F6F
	for <bpf@vger.kernel.org>; Wed,  4 Feb 2026 11:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770203740; cv=none; b=Il8nR8yJhiptm/qlXsJ8D7WnT/7SAZ1ahVNYyn4xUKeky6ADvLNCuDafYyzGeUC7+Tk74RkrF5A+v0/5vcOCkjbhyDcE2VpDeEh8muMt9ekaJv+HoHhz2LnCOIPJmkoJtuEH0UEKAp+MF8pkg233Oh85+QWawLYy1hMaEu0+Rm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770203740; c=relaxed/simple;
	bh=PyTPoqLw8iZ5sa4CYUBG20+iTbUS2dNZKxhVlh0tRkY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UxL50mLR1ZwPExO0wP3BhH/UoIneKOCIrGn27Tqz2pTYSHLj5QobOTONcY1idHsiGlvx7V8qQIbMCtiLo7Ur5J0IgOQL+F0neMC76Lht7u1IidV6MniaW2xnvEpjniidHefBkn0F2RUxglR4MOYHXfiznwCx45tfhWux6mKKmps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=fail smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [112.32.2.84])
	by mtasvr (Coremail) with SMTP id _____wCHKTxGKoNpoYV9AA--.2551S3;
	Wed, 04 Feb 2026 19:15:18 +0800 (CST)
Received: from localhost.localdomain (unknown [112.32.2.84])
	by mail-app1 (Coremail) with SMTP id yy_KCgBn5c1EKoNppYIFBg--.8223S2;
	Wed, 04 Feb 2026 19:15:17 +0800 (CST)
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
Subject: [PATCH bpf-next v3 2/2] selftests/bpf: Add tests for BPF_END bitwise tracking
Date: Wed,  4 Feb 2026 19:15:03 +0800
Message-Id: <20260204111503.77871-3-ziye@zju.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260204111503.77871-1-ziye@zju.edu.cn>
References: <20260204111503.77871-1-ziye@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgBn5c1EKoNppYIFBg--.8223S2
X-CM-SenderInfo: qtstiiaquyiko62m3hxhgxhubq/
X-CM-DELIVERINFO: =?B?5bVpZwXKKxbFmtjJiESix3B1w3tzYfmPt4q7bPP17nv9Zvsme7sPvU0377+RBBKdO8
	083m9YdTa8lQerqvWm+lkv19AYYsViaNaFI8WiGr+eXAe/Pft1IKDEoMDsO3iN6x35z93C
	ODjRAhQIxv1NEcWHa63N5RPxYw6l01w8CbPzC/8w
X-Coremail-Antispam: 1Uk129KBj93XoWxAr48KrW5tF47ZF13KFykWFX_yoWrWFy7pr
	95CFs3WayxJry2v3W3AFWxWFy5Ca1kZa1kJw4DZ3409342yFWUJr17KrWjqw15ZrZ3Xr13
	ZF9I93srta18ZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUBjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2
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
	Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07URlksUUUUU=

Now BPF_END has bitwise tracking support. This patch adds selftests to
cover various cases of BPF_END (`bswap(16|32|64)`, `be(16|32|64)`,
`le(16|32|64)`) with bitwise propagation.

This patch is based on existing `verifier_bswap.c`, and add several
types of new tests:

1. Unconditional byte swap operations:
   - bswap16/bswap32/bswap64 with unknown bytes

2. Endian conversion operations (architecture-aware):
   - be16/be32/be64: convert to big-endian
     * on little-endian: do swap
     * on big-endian: truncation (16/32-bit) or no-op (64-bit)
   - le16/le32/le64: convert to little-endian
     * on big-endian: do swap
     * on little-endian: truncation (16/32-bit) or no-op (64-bit)

Each test simulates realistic networking scenarios where a value is
masked with unknown bits (e.g., var_off=(0x0; 0x3f00), range=[0,0x3f00]),
then byte-swapped, and the verifier must prove the result stays within
expected bounds.

Specifically, these selftests are based on dead code elimination:
If the BPF verifier can precisely track bitwise through byte swap
operations, it can prune the trap path (invalid memory access) that
should be unreachable, allowing the program to pass verification.
If bitwise tracking is incorrect, the verifier cannot prove the trap
is unreachable, causing verification failure.

The tests use preprocessor conditionals (#ifdef __BYTE_ORDER__) to
verify correct behavior on both little-endian and big-endian
architectures, and require Clang 18+ for bswap instruction support.

Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Co-developed-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_bswap.c      | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bswap.c b/tools/testing/selftests/bpf/progs/verifier_bswap.c
index e61755656e8d..4b779deee767 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bswap.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
@@ -48,6 +48,49 @@ __naked void bswap_64(void)
 	: __clobber_all);
 }
 
+#define BSWAP_RANGE_TEST(name, op, in_value, out_value) \
+	SEC("socket") \
+	__success __log_level(2) \
+	__msg("r0 &= {{.*}}; R0=scalar({{.*}},var_off=(0x0; " #in_value "))") \
+	__msg("r0 = " op " r0 {{.*}}; R0=scalar({{.*}},var_off=(0x0; " #out_value "))") \
+	__naked void name(void) \
+	{ \
+		asm volatile (				\
+		"call %[bpf_get_prandom_u32];"		\
+		"r0 &= " #in_value ";"			\
+		"r0 =  " op " r0;"			\
+		"r2 =  " #out_value " ll;"		\
+		"if r0 > r2 goto trap_%=;"		\
+		"r0 = 0;"				\
+		"exit;"					\
+	"trap_%=:"					\
+		"r1 = 42;"				\
+		"r0 = *(u64 *)(r1 + 0);"		\
+		"exit;"					\
+	:						\
+	: __imm(bpf_get_prandom_u32)			\
+	: __clobber_all);				\
+	}
+
+BSWAP_RANGE_TEST(bswap16_range, "bswap16", 0x3f00, 0x3f)
+BSWAP_RANGE_TEST(bswap32_range, "bswap32", 0x3f00, 0x3f0000)
+BSWAP_RANGE_TEST(bswap64_range, "bswap64", 0x3f00, 0x3f000000000000)
+#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
+BSWAP_RANGE_TEST(be16_range, "be16", 0x3f00, 0x3f)
+BSWAP_RANGE_TEST(be32_range, "be32", 0x3f00, 0x3f0000)
+BSWAP_RANGE_TEST(be64_range, "be64", 0x3f00, 0x3f000000000000)
+BSWAP_RANGE_TEST(le16_range, "le16", 0x3f00, 0x3f00)
+BSWAP_RANGE_TEST(le32_range, "le32", 0x3f00, 0x3f00)
+BSWAP_RANGE_TEST(le64_range, "le64", 0x3f00, 0x3f00)
+#else
+BSWAP_RANGE_TEST(be16_range, "be16", 0x3f00, 0x3f00)
+BSWAP_RANGE_TEST(be32_range, "be32", 0x3f00, 0x3f00)
+BSWAP_RANGE_TEST(be64_range, "be64", 0x3f00, 0x3f00)
+BSWAP_RANGE_TEST(le16_range, "le16", 0x3f00, 0x3f)
+BSWAP_RANGE_TEST(le32_range, "le32", 0x3f00, 0x3f0000)
+BSWAP_RANGE_TEST(le64_range, "le64", 0x3f00, 0x3f000000000000)
+#endif
+
 #else
 
 SEC("socket")
-- 
2.53.0

