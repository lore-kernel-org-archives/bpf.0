Received: from sgoci-sdnproxy-4.icoremail.net (sgoci-sdnproxy-4.icoremail.net [129.150.39.64])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9C6C36DA1D
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.150.39.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530851; cv=none; b=IoPY58r1I1lpmvP2qKCbkfoSNCWDjONg3IVTzhH+2C4p2p30Qb929U7AwXzzUHngx4dISP6WLnz8ZZ5TNPOKMDVI87t+xfRgoGHv2DfmVQ2jDmRRoT5+tAx+i6f322DKk/jcICnUV6vqjxeMoUyisE5lKNAGnoETv0msyg15cYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530851; c=relaxed/simple;
	bh=D4uylBfMQ9oH2LagNRpMzwbWwMasSc0nAq6dHLeLbk4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u1J2emi7mo/pkX1B9w4LeztC1nQ2ksdFOWk9PBer70iJCulexbb3gXRUrxqaFL3abtDs+51ScLFmEUXwyUoHW7uowMdgVdYL6L2h4dhDP2UFj7u/zKKh71LIzPNEFu1tzc42Ie0CKVEl9+t/Lzd4q2Nsb9dL9tP9hCBAaS5rx8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn; spf=pass smtp.mailfrom=zju.edu.cn; arc=none smtp.client-ip=129.150.39.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zju.edu.cn
Received: from zju.edu.cn (unknown [10.162.163.215])
	by mtasvr (Coremail) with SMTP id _____wAnAoeFrKZpuDr+AA--.768S3;
	Tue, 03 Mar 2026 17:40:21 +0800 (CST)
Received: from lutetium.tail477849.ts.net (unknown [10.162.163.215])
	by mail-app1 (Coremail) with SMTP id yy_KCgAXItyDrKZpfj9zBg--.44130S2;
	Tue, 03 Mar 2026 17:40:19 +0800 (CST)
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
Subject: [PATCH bpf 2/2] selftests/bpf: Add test for BPF_END register ID reset
Date: Tue,  3 Mar 2026 17:39:56 +0800
Message-ID: <20260303093956.395076-3-tangyazhou@zju.edu.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303093956.395076-1-tangyazhou@zju.edu.cn>
References: <20260303093956.395076-1-tangyazhou@zju.edu.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:yy_KCgAXItyDrKZpfj9zBg--.44130S2
X-CM-SenderInfo: qssvjiasrsq6lmxovvfxof0/1tbiBhETCmml6AkiIQAAsg
X-CM-DELIVERINFO: =?B?UC9NDQXKKxbFmtjJiESix3B1w3vD7IpoGYuur0o+r46DyAi5OfOO+T4vrW4FyUBIyu
	9q9MD0CNUctfjAuOW3KnrInED5BIg/KcxW2+TuidH1Sg/49cLCqYrgutCUp7yI0H/n3eO6
	Q2o4C+xRzGywyTvFM7/tn0pVjaAPbxMxbdFVQQ+7whHToeslJCBXPAeBYSJbZg==
X-Coremail-Antispam: 1Uk129KBj93XoW7Aw1DWF1kKr43Xryrtr18WFX_yoW8ZrWDpr
	n5GwnxKa97Wr17Ca13CFs7ZFy5CFs7ZayYvw48Za4j9F1UCFyUArn7KryjqF1fAr93Z3yF
	vF9Ig34Uua1UJabCm3ZEXasCq-sJn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7KY7ZEXa
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

