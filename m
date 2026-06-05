Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32B4388E71;
	Fri,  5 Jun 2026 15:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.27.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672477; cv=none; b=Ud/OyoWf+o4v92rxxznQctyqd0USdS2EgM9403IgT2qcPXHwptx2nLAMPGp7Y0sviJ0NjYVqxyrP9vzbhhjXH1w2FhSRyAkQ2JBASZ42WQGtyKNTbt2gDj4goWudff4CyVRCH3AZZRxwNiHqBF4yXumuI/I5WaRmiQOZpg2HDxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672477; c=relaxed/simple;
	bh=0wSyyP8FRVzf7/nN2rkijpLZ/QyF8u8izV48o+OfdU8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AusVaqzSYmBo3moth0c78bLRCRt/oT1hkkfYTVH3FyC03igSKjsxHQuLagEJdeowt+bC3Q929gHCDvb8E1xgCwyP75caVl3wsv+sVZsWSL0aJWhvNm9DAsqZyxlb4skXpvEnEtf3v/VEL0qJaWadxAXnZSMpJXC7EDnoZ/p41LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org; spf=pass smtp.mailfrom=mess.org; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=nsQqgNeT; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b=F4yPuMJl; arc=none smtp.client-ip=92.243.27.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mess.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="nsQqgNeT";
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.b="F4yPuMJl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1780672468; bh=0wSyyP8FRVzf7/nN2rkijpLZ/QyF8u8izV48o+OfdU8=;
	h=From:To:Cc:Subject:Date:From;
	b=nsQqgNeT4wTAFr+aVxwsUmHlJytWUwxwIGNAFV2wGyAscuzcALE4+wddUnU5NJA6D
	 myYFMyoSFTEO2k95Qq5inFspaIabeiwVTIunVpqKkfOOtwGBNeuGLzr7qaeZvUrK6L
	 3f02DSRk0nSlh1utxsmhmI6GofH/tmph0f+HGr1U51cMst4vdzjRnUKQtpoMAcc+Vc
	 3YVBCNAxZQQ0YYwOGHEfrmcHfi07Gd8L4mxoZGXyrsChTX4r39CFyWncg8/X4EVaY4
	 VW5BomhqnsicSwYI0Hu/cXAPxO880lUkoB8c5Vg1/nV/7hpXKrVhvFWl9ngjgjs/nz
	 GI0ctaA+ScZJQ==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id 4C8B441AB7; Fri, 05 Jun 2026 16:14:28 +0100 (BST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1780672467; bh=0wSyyP8FRVzf7/nN2rkijpLZ/QyF8u8izV48o+OfdU8=;
	h=From:To:Cc:Subject:Date:From;
	b=F4yPuMJltgSemibAHXlgfScPQuJQ6vWGgtvcuKFa6VexTMnTY3kqWOh5+3Vvy5Ohi
	 FhsYH/CgFy2C03Uy+N4XtbgJIFCMpdRQ7mBnRWyuI2Q38KlRRXjeQX+JzbB0a9T2Uw
	 z1mqpnovKqL9/CYrhE/r0J0Qe2oMzplO//6rhMhJG950Szaa/lRiuRqGO84yATq32g
	 4voCViaFz1Tgj8OQBG2w1Z2fS3uMyAX6L2GxGKvLC725xnKv+F8QX2fxu03tVTlvsn
	 vOLQYX9PTpLJh2TLlmm4WfZCII2rxw+lC9CGH3NaEbLN9MCljPWS+5nWpOD2chU1Q6
	 eM+uI598Ty/Yw==
Received: from maru.local (unknown [62.232.99.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id 7A2BA408E6;
	Fri, 05 Jun 2026 16:14:26 +0100 (BST)
From: Sean Young <sean@mess.org>
To: Bastien Curutchet  <bastien.curutchet@bootlin.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Sean Young <sean@mess.org>,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf: Fix test_lirc test
Date: Fri,  5 Jun 2026 16:14:16 +0100
Message-ID: <20260605151417.777614-1-sean@mess.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 68a99f6a0ebf ("media: lirc: report ir receiver overflow"),
the rc-loopback driver does not accept edges over 50ms, as these are
never seen in real life ir protocols. Fix this.

Signed-off-by: Sean Young <sean@mess.org>
---
 tools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c | 4 ++--
 tools/testing/selftests/bpf/test_lirc_mode2_user.c       | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c b/tools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c
index 7a6620671a83..cbe4284c032f 100644
--- a/tools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_lirc_mode2_kern.c
@@ -13,9 +13,9 @@ int bpf_decoder(unsigned int *sample)
 	if (LIRC_IS_PULSE(*sample)) {
 		unsigned int duration = LIRC_VALUE(*sample);
 
-		if (duration & 0x10000)
+		if (duration & 0x1000)
 			bpf_rc_keydown(sample, 0x40, duration & 0xffff, 0);
-		if (duration & 0x20000)
+		if (duration & 0x2000)
 			bpf_rc_pointer_rel(sample, (duration >> 8) & 0xff,
 					   duration & 0xff);
 	}
diff --git a/tools/testing/selftests/bpf/test_lirc_mode2_user.c b/tools/testing/selftests/bpf/test_lirc_mode2_user.c
index 88e4aeab21b7..cd191da20d14 100644
--- a/tools/testing/selftests/bpf/test_lirc_mode2_user.c
+++ b/tools/testing/selftests/bpf/test_lirc_mode2_user.c
@@ -50,8 +50,8 @@ int main(int argc, char **argv)
 {
 	struct bpf_object *obj;
 	int ret, lircfd, progfd, inputfd;
-	int testir1 = 0x1dead;
-	int testir2 = 0x20101;
+	int testir1 = 0x1ead;
+	int testir2 = 0x2101;
 	u32 prog_ids[10], prog_flags[10], prog_cnt;
 
 	if (argc != 3) {
@@ -125,7 +125,7 @@ int main(int argc, char **argv)
 		}
 
 		if (event.type == EV_MSC && event.code == MSC_SCAN &&
-		    event.value == 0xdead) {
+		    event.value == 0x1ead) {
 			break;
 		}
 	}
-- 
2.54.0

