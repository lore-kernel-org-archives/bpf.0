Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=114.242.206.163
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607160;
	b=RwzbiCAC8FZFhb0uDpcpttrTKFv7LeVj1y1+YHVqPzFSv2v+SuvOzMpzk6WI00509TZo
	 AnkzXvpzA8wRIG1xVnFmxu1JaLu7rRJPnx8iER/pcYFFTGMEaecVGKR0l5uInn3braCBC
	 LCdFZ5f2xRV36XmQzgJII8cHjaAOQWxnByXVAj2s2PgDuRYwjS2/VOi+ijRGIS5/hvJfC
	 Hs7Emrpg2XmaHbQRgrUUydvw/PBsm+1Th+qXl7PmMjRLzmVE4I0Qt74LHo1FF4VeV1z3l
	 hk68565ZuwuzyH3M9sDrzSk0eNq6jhhChuJif6ambrT747azCF7Ensp6WVLW+x4cdYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607160;
	h=DMARC-Filter:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-CM-SenderInfo:
	 X-Coremail-Antispam;
	bh=0XFyu5ohozRsphsglreF2QooKn6bFRpdsO1k5OqAHm8=;
	b=RF0CMd8PKQB5t6ZRApmMlJhjh8u55PXfklijEF6KK2bq/Rdqq0EfkwWMELw+XpDKODXX
	 HRndBrL9aLMMjW2+0dCMfSriWgssUShJJeng+kblkgquBL419DUV71DT705GRbk4DSn3A
	 7RamFV9s4JPC4WKYfWEJStNIry/dBCwoRJP7wRf1o3qqewgiLfU/Tu3ZTdBKADy6Yd88C
	 aX9cSGWmsf3DPMpSG2MXKvR8DhpiNX20fGGlxFMayNqiNr2x6C/5Msa1jHxacJQ5ZPi9w
	 +EedZ6D66zqpU8hmv6htO2ZReZvObQ1YOdgZkBl07aDxyDxpaE9V2qNnv2bpTaPHKnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=loongson.cn;
	spf=pass smtp.mailfrom=loongson.cn;
	arc=none smtp.remote-ip=114.242.206.163
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6CA606A329;
	Mon,  2 Nov 2026 08:12:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB6CA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [123.138.236.242])
	by gateway (Coremail) with SMTP id _____8CxPtPzRehqU3gbAA--.13915S3;
	Mon, 02 Nov 2026 16:12:35 +0800 (CST)
Received: from linux.localdomain (unknown [123.138.236.242])
	by front1 (Coremail) with SMTP id qMiowJAx3c7vRehq5cwxAA--.37701S4;
	Mon, 02 Nov 2026 16:12:34 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v1 2/2] selftests/bpf: Handle unaligned access failure in fexit_bpf2bpf
Date: Mon,  2 Nov 2026 16:12:30 +0800
Message-ID: <20261102081230.7063-3-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20261102081230.7063-1-yangtiezhu@loongson.cn>
References: <20261102081230.7063-1-yangtiezhu@loongson.cn>
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
X-CM-TRANSID:qMiowJAx3c7vRehq5cwxAA--.37701S4
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj93XoWxAr1kWF18KF4DCFy5tw1rZrc_yoW5Kryxpa
	s5Aw1jkryfZFySqw1UJa92gFZ5trWkJr1YkF1Ig398ZwsrArn7Xr1xKFW5WF98WrZYvws5
	Z3yIkF9xur4UZagCm3ZEXasCq-sJn29KB7ZKAUJUUUUr529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9Fb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r126r13M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	tVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v2
	6r1Y6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2
	KfnxnUUI43ZEXa7IU8XyCJUUUUU==

When executing "./test_progs -t fexit_bpf2bpf", there are 5 failures
with the same log:

  ; tcp->check++; @ test_pkt_access.c:98
  226: (69) r1 = *(u16 *)(r2 +16)
  misaligned packet access off 2+(0x0; 0x3f)+16 size 2
  ...
  libbpf: prog 'test_pkt_access': failed to load: -EACCES
  libbpf: failed to load object './test_pkt_access.bpf.o'

This is because CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not set
on certain processors that lack hardware unaligned access support.
In this case, the affected tests should be skipped.

Add a get_unaligned_access_enabled() helper and use it to skip the
tests gracefully if the program fails to load with -EACCES.

Before:
  $ sudo ./test_progs -t fexit_bpf2bpf | tail -1
  Summary: 0/10 PASSED, 1 SKIPPED, 1/5 FAILED

After:
  $ sudo ./test_progs -t fexit_bpf2bpf | tail -1
  Summary: 1/10 PASSED, 6 SKIPPED, 0/0 FAILED

Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 .../testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c  | 11 +++++++++++
 tools/testing/selftests/bpf/unpriv_helpers.c          |  5 +++++
 tools/testing/selftests/bpf/unpriv_helpers.h          |  1 +
 3 files changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
index d2f2dcc0f2e1..1c0e93dcb3ce 100644
--- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
@@ -3,6 +3,7 @@
 #include <test_progs.h>
 #include <network_helpers.h>
 #include <bpf/btf.h>
+#include <unpriv_helpers.h>
 #include "bind4_prog.skel.h"
 #include "freplace_progmap.skel.h"
 #include "fentry_sleepable.skel.h"
@@ -76,6 +77,11 @@ static void test_fexit_bpf2bpf_common(const char *obj_file,
 
 	err = bpf_prog_test_load(target_obj_file, BPF_PROG_TYPE_UNSPEC,
 			    &tgt_obj, &tgt_fd);
+	if (err < 0 && errno == EACCES && !get_unaligned_access_enabled()) {
+		test__skip();
+		return;
+	}
+
 	if (!ASSERT_OK(err, "tgt_prog_load"))
 		return;
 
@@ -297,6 +303,11 @@ static void test_fmod_ret_freplace(void)
 
 	err = bpf_prog_test_load(tgt_name, BPF_PROG_TYPE_UNSPEC,
 			    &pkt_obj, &pkt_fd);
+	if (err < 0 && errno == EACCES && !get_unaligned_access_enabled()) {
+		test__skip();
+		return;
+	}
+
 	/* the target prog should load fine */
 	if (CHECK(err, "tgt_prog_load", "file %s err %d errno %d\n",
 		  tgt_name, err, errno))
diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index c8dd5d848584..54ce342b3fe4 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -161,3 +161,8 @@ bool get_kasan_multi_shot_enabled(void)
 {
 	return cmdline_contains("kasan_multi_shot");
 }
+
+bool get_unaligned_access_enabled(void)
+{
+	return config_contains("CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y") == 1;
+}
diff --git a/tools/testing/selftests/bpf/unpriv_helpers.h b/tools/testing/selftests/bpf/unpriv_helpers.h
index c24d53e14f3a..6e3ad636ea83 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.h
+++ b/tools/testing/selftests/bpf/unpriv_helpers.h
@@ -9,3 +9,4 @@ bool get_unpriv_sysctl_disabled(void);
 bool get_unpriv_mitigations_disabled(void);
 bool get_kasan_jit_enabled(void);
 bool get_kasan_multi_shot_enabled(void);
+bool get_unaligned_access_enabled(void);
-- 
2.42.0

