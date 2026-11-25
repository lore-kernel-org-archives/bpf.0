Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.118
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609317;
	b=c46mbFg0AnGdJaCIXrlf2TqteeqzPDnE5S5fPkvBmkTJliI1YJ1cZcDeXRfN5nlUdaIm
	 gmH4uuQmy8pQAC+N4Cu1S3cDkrwSCqtOuOyiOVAQ+iSA0NTgbmi2ZUqsey2aR41M6P5mL
	 KH1YOpAb6i2o7K/3OjFkRy0AbQ4cZ47JHQyDDb02Ty+2JT1N5LEATUzh6JYqxVqVSJOCN
	 96DrYGDBnf4abkxEgQ6F7SPZAIOo+JUVLRskFjpjoZDUY9oqEJ/ZuclY7hQFkWAzykonW
	 v7/9mbdm1Xoeo22LUkqz+QgCF3G1P0N7J+jcnU2IZTBM0cROWG0aqsiI1ERnEL+4UKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609317;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YO+gVdYbAsguYJfAA7/L0gHdhb6kJyRHPaqV/Yh+2u4=;
	b=CX23ono/Ne+qzyZiEW8f9j53weadBO99cfvfmPSH7VKOT2zlrgXQYZEwzWc+40uq4/BZ
	 LW+Do9tZRRjOr1STH1wtIdSSD6L+0gX8oIs5bxMogR35CHJytE+Ce4P3MfUptDKeUuCFA
	 YuqSd77Deev+LgWZitHsEL3zzXxR0O4BZH5nzhgOcOUSistODxV6w5XRoLdhgdlyqvGRz
	 FS/5KJidx1y1qjtGwPgvZCgtCB+b9ZW0txrpbmyfgaW6I18Ojgh23T+3ZAlv2SLJJ/MaE
	 FZETIZDS3/L+4xiLn1vWTmsEtx2bt/kcE+gLetdsBtufowhCVfAmOoN91VVtHHYAkOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=q9ipg8Ng;
	arc=none smtp.remote-ip=115.124.30.118
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1430606A334;
	Wed, 25 Nov 2026 12:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1430606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=q9ipg8Ng
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1795609310; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=YO+gVdYbAsguYJfAA7/L0gHdhb6kJyRHPaqV/Yh+2u4=;
	b=q9ipg8Ng06GISbuGWVZOmuVBpgByjGOIEdHFQmTyCqA+2rCeWB4SYdiNsH4oQoEPAOo9aDMY9yUdEV/38aT7Z8JEKEoBvaJINcxk7KOCi4Maolmsmv41pNEWwxPeqUr5wdzIugeI52J0vcr2R7b0l5tyTClWM6zI3Ga7IrUlX4c=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045133197;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=28;SR=0;TI=SMTPD_---0XFRij20_1795609307;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0XFRij20_1795609307 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 25 Nov 2026 20:21:48 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	bjorn@kernel.org,
	puranjay@kernel.org,
	alexei.starovoitov@gmail.com
Cc: eddyz87@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	pulehui@huawei.com,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	luke.r.nels@gmail.com,
	xi.wang@gmail.com,
	shuah@kernel.org,
	rgbi3307@gmail.com,
	guoren@kernel.org,
	bpf@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 bpf-next 3/3] selftests/bpf: Test a private stack together with stack arguments
Date: Wed, 25 Nov 2026 20:21:26 +0800
Message-ID: <20261125122126.939-4-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261125122126.939-1-cp0613@linux.alibaba.com>
References: <20261125122126.939-1-cp0613@linux.alibaba.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add two asm programs to verifier_stack_arg.c, inside the block that is
already gated on x86, arm64 and riscv64. A raw_tp program with a 64 byte
frame calls a ten-argument subprog with a 64 byte frame of its own, and
BPF_PROG_TEST_RUN runs the pair without attaching it. Args 9 and 10 stay
in the kernel frame and arg 10 points into the caller's frame, so the two
have to agree on where the outgoing area is. The callee returns what the
caller stored plus arg 9, so a wrong area shows up as a wrong retval
rather than as a crash.

Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
---
 .../selftests/bpf/progs/verifier_stack_arg.c  | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
index c642675dd92b..16afc69af947 100644
--- a/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
+++ b/tools/testing/selftests/bpf/progs/verifier_stack_arg.c
@@ -1156,6 +1156,55 @@ __naked void stack_arg_precision_fallback(void)
 	);
 }
 
+/* Writes both ends of its frame, then reads args 9, 10 and the frame of the caller. */
+static __naked __noinline __used
+long priv_stack_10args(long a, long b, long c, long d, long e, long f, long g, long h,
+		       long i, long *j)
+{
+	asm volatile (
+		"r1 = 0;"
+		"*(u64 *)(r10 - 8) = r1;"
+		"*(u64 *)(r10 - 64) = r1;"
+		"r0 = *(u64 *)(r11 + 32);"
+		"r1 = *(u64 *)(r11 + 40);"
+		"r1 = *(u64 *)(r1 + 0);"
+		"r0 += r1;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
+/*
+ * A frame of 64 bytes in a raw_tp prog goes to the private stack.
+ * arm64 and riscv64 pass args 9 and 10 on the kernel stack. On x86-64
+ * both frames stay there as well.
+ */
+SEC("raw_tp")
+__description("stack_arg: private stack in the caller and in the callee")
+__success __retval(890)
+__naked void stack_arg_priv_stack(void)
+{
+	asm volatile (
+		"r1 = 800;"
+		"*(u64 *)(r10 - 64) = r1;"
+		"r1 = r10;"
+		"r1 += -64;"
+		"*(u64 *)(r11 - 40) = r1;"
+		"*(u64 *)(r11 - 32) = 90;"
+		"*(u64 *)(r11 - 24) = 8;"
+		"*(u64 *)(r11 - 16) = 7;"
+		"*(u64 *)(r11 - 8) = 6;"
+		"r1 = 1;"
+		"r2 = 2;"
+		"r3 = 3;"
+		"r4 = 4;"
+		"r5 = 5;"
+		"call priv_stack_10args;"
+		"exit;"
+		::: __clobber_all
+	);
+}
+
 #else
 
 /* No BTF tells about this store. The insn is what JIT has to deal with. */
-- 
2.50.1

