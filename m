Received: from azure-sdnproxy.icoremail.net (azure-sdnproxy.icoremail.net [4.193.249.245])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06613002BA
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 08:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.193.249.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772613199; cv=none; b=hp4ccIn/sJdfx0Fx4wfYKKIkpc+MHwkF3KTh4r6uR6JPO+p+PVXHNE/mdighPt4TGJB1ggAoiNmLbd/kBS24mWcnZh6+P/MmMTvIpZ5nBata2rAEB4q6chtBtoO3A4J1EWdSNZljqPC/HlaWYMhcolY2vb2q1p0fymSVeYmz6LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772613199; c=relaxed/simple;
	bh=zAwmWaW8YcwElg8ioZGkadOOvsAGkHuJ5M8biODJtTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hv+GGI70D+ZoXvz3VLoQCoOuq2vJZzMn9aGY3Z+kMP99RyUp7r4wrejZQviKghxcIuijwS15AK0OUypeQh4mEurYTPq/tYn/O3zsPonbdNPlWdBsezszALuxcyuE76/MrekYwViJt5LLF66ZFNhryaAg11KL5cZCtpo3z352XOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=4.193.249.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [122.224.66.117])
	by mtasvr (Coremail) with SMTP id _____wBHP2Y57qdpSswEAQ--.16646S3;
	Wed, 04 Mar 2026 16:32:57 +0800 (CST)
Received: from wolframium.tail477849.ts.net (unknown [122.224.66.117])
	by mail-app1 (Coremail) with SMTP id yy_KCgD3ds827qdphc12Bg--.80S2;
	Wed, 04 Mar 2026 16:32:54 +0800 (CST)
From: Yazhou Tang <tangyazhou@zju.edu.cn>
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
	ziye@zju.edu.cn,
	glapt.pro@outlook.com
Subject: [PATCH bpf v2 2/2] selftests/bpf: Add test for BPF_END register ID reset
Date: Wed,  4 Mar 2026 16:32:28 +0800
Message-ID: <20260304083228.142016-3-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260304083228.142016-1-tangyazhou@zju.edu.cn>
References: <20260304083228.142016-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgD3ds827qdphc12Bg--.80S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBgQACmmnOYkbZwADsJ
X-CM-DELIVERINFO: =?B?82XzuwXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9H+6e/0XdEnku/cOG5HghNgXWtPNL9WR/xageCYcjfsB76TxlLUeXS4XUCIUbMeWbGm1
	8142LYqNcF9cwbCLMK6Qj+5SFz24dMo6uWNLjZAjl4Llh01klg8PZI3gc7aSeQ==
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw1DWF1kKr43Xryrtr18WFX_yoW8Zw18pw
	n5GwnxKa97Wr17Ca13CFs7ZFy5CFs7ZayYvw40v34j9F1UCFyUArn7KryjqF1fArZ3Z3yF
	vF9Ig34Uua1UAabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Eb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k26cxKx2
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
	JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU81v35UUUUU==

From: Yazhou Tang <tangyazhou518@outlook.com>

Add a test case to ensure that BPF_END operations correctly break
register's scalar ID ties.

The test creates a scenario where r1 is a copy of r0, r0 undergoes a
byte swap, and then r0 is checked against a constant.

- Without the fix in the verifier, the bounds learned from r0 are
  incorrectly propagated to r1, making the verifier believe r1 is
  bounded and wrongly allowing subsequent pointer arithmetic.

- With the fix, r1 remains an unbounded scalar, and the verifier
  correctly rejects the arithmetic operation between the frame pointer
  and the unbounded register.

Co-developed-by: Tianci Cao <ziye@zju.edu.cn>
Signed-off-by: Tianci Cao <ziye@zju.edu.cn>
Co-developed-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Shenghao Yuan <shenghaoyuan0928@163.com>
Signed-off-by: Yazhou Tang <tangyazhou518@outlook.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
---
 .../selftests/bpf/progs/verifier_bswap.c      | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_bswap.c b/tools/testing/selftests/bpf/progs/verifier_bswap.c
index 4b779deee767..cffaf36192bc 100644
--- a/tools/testing/selftests/bpf/progs/verifier_bswap.c
+++ b/tools/testing/selftests/bpf/progs/verifier_bswap.c
@@ -91,6 +91,28 @@ BSWAP_RANGE_TEST(le32_range, "le32", 0x3f00, 0x3f0000)
 BSWAP_RANGE_TEST(le64_range, "le64", 0x3f00, 0x3f000000000000)
 #endif
 
+SEC("socket")
+__description("BSWAP, reset reg id")
+__failure __msg("math between fp pointer and register with unbounded min value is not allowed")
+__naked void bswap_reset_reg_id(void)
+{
+	asm volatile ("					\
+	call %[bpf_ktime_get_ns];			\
+	r1 = r0;					\
+	r0 = be16 r0;					\
+	if r0 != 1 goto l0_%=;				\
+	r2 = r10;					\
+	r2 += -512;					\
+	r2 += r1;					\
+	*(u8 *)(r2 + 0) = 0;				\
+l0_%=:							\
+	r0 = 0;						\
+	exit;						\
+"	:
+	: __imm(bpf_ktime_get_ns)
+	: __clobber_all);
+}
+
 #else
 
 SEC("socket")
-- 
2.53.0

