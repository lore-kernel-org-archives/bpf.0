Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794987259;
	b=Fz2/vCW2822VYQzGgubq1Zist3M6WyzQu/ah22JyblNkZFgN3xXsgi/1QibJIBVY0/0h
	 ccbtFYm/q+USJlNCXtmVL86HT2lg/PcK2o93GSRiX1NJi+BG6NSO8adYkl60/Wra3UCjQ
	 IO/WlbXVrInZ2gtHea6ymyHnwrgu3WHTXiLzKZPG73A+uHIRia8eqipHOZnzupYXPt+4X
	 mqoxU4VF3qcA3GZUVTGc+jd7cUU1JsoyYhZyfV+/BOlYNrd55E/iL1Nm6JwJ10uYVNfSt
	 UV2JNwWRQ3NQGXDtOg2BndQWMDm3RlaPyieFUVChdy7LQ1Br72VuH+4okMx55jjPe9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794987259;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=ZlM43h4YcZYPb2lh6vOLR1Gxai+gJzcwC6njybeWZ7w=;
	b=w5Mq/fvc7HguQD8xIAmzx3CopeDyKgOu64A3wP5ZUNi/OphvuIeuFdMHpjuG8h8udfk6
	 n4cYplojtHbCLScEkFxSaJTS+9uik6MM/ResEWUhnJUW6eSEzI/rZjtJJeGNs2DJyKsUm
	 NJSzfJuDEhy/EeKzg1KfDBGmnGmVOVGANoiD0zt1+xCBsBF8INXfNRGdexwGcyzlU8w2R
	 e9M9VnUtwh6gJbfStzg4T4AwLZkWA7zYUPczfhxARYkxQSU00ABA0ZRZNg90fimlhq3Wx
	 J/JAJnMxbPX8fVf7m16FFMLnSyRxAdrUWeJW9D6zACA1uejjONDxtGuDd05ZTJaEgXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ScVdSO0q;
	arc=none smtp.remote-ip=117.135.210.3
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F81F606A32A;
	Wed, 18 Nov 2026 07:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F81F606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ScVdSO0q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Zl
	M43h4YcZYPb2lh6vOLR1Gxai+gJzcwC6njybeWZ7w=; b=ScVdSO0qXDDdpswZ/M
	Bssbn1RMH47NixMv4jOh/NJ10vaFWywuaNx4+puS+MKavlgEbA7L9aC0Si7/69Z1
	klBuKZYoPCwlQBX7M8lGSA50pqou1yrVI9I+no+st9+3CP5+PiJ7N2hl9aUoQOh9
	aLSzqToQQRuYE2mQ/K5uXg7SI=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wDX39q9VP1q6+71Hw--.26225S2;
	Wed, 18 Nov 2026 15:33:19 +0800 (CST)
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
Subject: [PATCH bpf-next] selftests/bpf: Run all summarization freplace cases
Date: Wed, 18 Nov 2026 15:33:09 +0800
Message-ID: <20261118073309.125424-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wDX39q9VP1q6+71Hw--.26225S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Wry7Ar47JF1ktF13XryxKrg_yoW8Wr48pa
	s3WrWktFyfGF17tw1Ikw47XFWfuFWkXrW5Gr40qr1DZws5J392gryxKw43JFykuFWfXw1F
	v3ZIkr1Y9wsFvrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UD739UUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6x9eLWr9VL8OvwAA3K

From: Yun Lu <luyun@kylinos.cn>

The test matrix groups targets by the side effect under test.
ARRAY_SIZE(mains) gives the number of groups, so using it as the
target loop bound skips the two standalone entry-point targets in
each group.

Use the target and replacement counts from the current group and
derive the group count from mains. This restores four packet-data
cases and enables four sleepable-program cases.

Fixes: 72ed076abf54 ("selftests/bpf: Add tests for extending sleepable global subprogs")
Reported-by: Jackie Liu <liuyun01@kylinos.cn>
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 tools/testing/selftests/bpf/prog_tests/summarization.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

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
-- 
2.43.0

