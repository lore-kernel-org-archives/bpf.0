Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795057040;
	b=OrmvEDPSBHBNgk70pRwV9FRf8RELCNqXaQjgDJA+DzlmMwjgtfwx0tqMaFfnAjzN3+w4
	 hEa3rAQWymOqKE0XmzTWSzkSoCVkt5B/01vCFuwcFXuzirE60xQzXPEyAmqfeUomm3vLL
	 +SDoj6abepiy4cA4CMxnDuMCO/F2Ay89rjyKPI9gs3vbSAYX+of81t/QMGppEFa9coARg
	 PasRnpPODtA9N+bTKACIRe9mMykg8PrpoDltLU19scuB3XjuoyiRItCyFhT0YYDM+eGs9
	 GO3QbkF7PTxNQ6Xto1OGXT4meJ6vkAwVuwixqoEFN9xIuBNWAuxdjYh6U9/t/5jHc4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795057040;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=n45qhIWgljouYKMGyLEtTBZkMLiNMOhwqdxxq1twSXI=;
	b=MpzMDwUFA2xgGXKhudmL4ihfr4DEEevSEeCsYFIJ+qGLGts2ft6eS/Hrp3K+fR9CvjhZ
	 mr8qsw4l1A4gN1HRRI8nl5VutFWpcJWZtg+DVV2XkJA3kgWDdyJOhVtToRxqyeSmtQXmP
	 rU8rtH139JHN3ATlWYz4QZ5ZoZCjd1iawX9W6dkFoNKLucBfuNrfrQyDrUyXZbrivRJLQ
	 XsABKZIDWZTRVcKKlQenYNuvBJoe1HM8pF/7MN+4DyKsfVFfOb8n2FE0C4sf0/klCVsJZ
	 ekM0nRvyoLvCYvWIaC6qqnWzt5mBa47KWNtu7nHaY5ZQRBOPhjASyuuJYWbtfb2jjwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JwN2Kjro;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F5F606A31C;
	Thu, 19 Nov 2026 02:57:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2F5F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=JwN2Kjro
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=n4
	5qhIWgljouYKMGyLEtTBZkMLiNMOhwqdxxq1twSXI=; b=JwN2KjroRV1Jn5JsTH
	nA+6tSf/0JjkLNNsf8iHugUqSeB0ALRsPgoQiOLwXZjcKMZ4bIQW3e5Z7UEFC6ft
	gm8OVUj4H61uGthjNT/TSxXLQTir2SLxBsX5+IcySwsEsaw7HpoOcDzVcK7ltFBM
	OxDT5PMLQ3if/L48KXFKM/yOk=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wDXl39hZf5q5uiiIg--.59922S2;
	Thu, 19 Nov 2026 10:56:34 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: andrii@kernel.org,
	eddyz87@gmail.com,
	ihor.solodrai@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	shuah@kernel.org
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH bpf-next v2] selftests/bpf: Run all summarization freplace cases
Date: Thu, 19 Nov 2026 10:56:23 +0800
Message-ID: <20261119025623.192740-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
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
X-CM-TRANSID:_____wDXl39hZf5q5uiiIg--.59922S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxAFWrCr4xKrW8tw4kuFWrAFb_yoW5Wr4rpa
	4xX398KFyxKF17Jw10kwsrWFWa9FWvqrW5Ar40g34UZr1kJ34vgryxKF4UJF9a9FWfZr1S
	vasrKr15ZwsrArDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UD739UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wPLmmr+ZWP8PgAA3p

From: Yun Lu <luyun@kylinos.cn>

ARRAY_SIZE(mains) gives the number of groups in the test matrix.
Using it as the target loop bound skips the two standalone
entry-point targets in each group.

Derive the group count from mains and use the target and replacement
counts from the current group. This restores four packet-data cases
and enables four sleepable-program cases.

Tag the context arguments of the standalone sleepable entry points
with __arg_ctx. On arm64 and s390x, the verifier marks the
unrecognized entry-point BTF as unreliable and rejects freplace before
the RCU read-lock check that the test expects.

Fixes: 72ed076abf54 ("selftests/bpf: Add tests for extending sleepable global subprogs")
Reported-by: Jackie Liu <liuyun01@kylinos.cn>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
v2:
- Add __arg_ctx to both standalone sleepable entry points.
- Run summarization_freplace on x86_64 and arm64 QEMU.

v1: https://lore.kernel.org/bpf/20261118073309.125424-1-luyun_611@163.com/

 tools/testing/selftests/bpf/prog_tests/summarization.c | 6 +++---
 tools/testing/selftests/bpf/progs/summarization.c      | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/summarization.c b/tools/testing/selftests/bpf/prog_tests/summarization.c
index 3e4bcf071735..f51b203eca8a 100644
--- a/tools/testing/selftests/bpf/prog_tests/summarization.c
+++ b/tools/testing/selftests/bpf/prog_tests/summarization.c
@@ -116,9 +116,9 @@ void test_summarization_freplace(void)
 	};
 	char buf[64];
 
-	for (int t = 0; t < 2; t++) {
-		for (int i = 0; i < ARRAY_SIZE(mains); ++i) {
-			for (int j = 0; j < ARRAY_SIZE(replacements); ++j) {
+	for (int t = 0; t < ARRAY_SIZE(mains); t++) {
+		for (int i = 0; i < ARRAY_SIZE(mains[t]); ++i) {
+			for (int j = 0; j < ARRAY_SIZE(replacements[t]); ++j) {
 				snprintf(buf, sizeof(buf), "%s_with_%s",
 					 mains[t][i].to_be_replaced, replacements[t][j].func);
 				if (!test__start_subtest(buf))
diff --git a/tools/testing/selftests/bpf/progs/summarization.c b/tools/testing/selftests/bpf/progs/summarization.c
index f89effe82c9e..f08c7a73ad8e 100644
--- a/tools/testing/selftests/bpf/progs/summarization.c
+++ b/tools/testing/selftests/bpf/progs/summarization.c
@@ -61,7 +61,7 @@ int main_might_sleep_with_subprogs(struct pt_regs *ctx)
 }
 
 SEC("?uprobe.s")
-int main_might_sleep(struct pt_regs *ctx)
+int main_might_sleep(struct pt_regs *ctx __arg_ctx)
 {
 	int i;
 
@@ -70,7 +70,7 @@ int main_might_sleep(struct pt_regs *ctx)
 }
 
 SEC("?uprobe.s")
-int main_does_not_sleep(struct pt_regs *ctx)
+int main_does_not_sleep(struct pt_regs *ctx __arg_ctx)
 {
 	return 0;
 }
-- 
2.43.0

