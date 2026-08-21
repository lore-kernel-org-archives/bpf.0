Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A163839A4C4;
	Fri, 21 Aug 2026 22:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787352065; cv=none; b=foBxL2LyuHsmxCnaEDFC/GHkLANFJrtlZ9QADGq4/HZJ649945Fbv8wO4EELxg8pEUWi5zSSEtGjy3LzK6R+tgrol9lJNU5OfLi87as8leswzz1qp7eIMLWO0aNgYdkFKENsHgX1OqKkUHtbdQjAakOnBJec2I47sy7+IGB1Heo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787352065; c=relaxed/simple;
	bh=pAFEFzOJKFdpVM+63OQsKxU3wbQDCYAvT2NDoiZ6cMU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ePiA7UqGEse/HyrKpxfSFfm9QvZp4YJphbISh0tgDPh/hEYXFb5rO/cYwIcGUmad7rjkuE9bTst6xCi1/Y5NoeFgubYNocUZJaBfUC4gEAMkQM+Qq+UCepiiTeSVpS6L8m1F864VLXfrHiZ2INnlJ72A6VxVCBAQ7VjxkjbzXGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=u/Es5Y8w; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="u/Es5Y8w"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 1B30B4E4131E;
	Fri, 21 Aug 2026 22:41:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DB19C604AA;
	Fri, 21 Aug 2026 22:41:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3C9F911C776EF;
	Sat, 22 Aug 2026 00:40:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787352056; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZjB1J2uoOBIgNgE8DtfzBEFXbASZ4vr8vOrDEGoxOJw=;
	b=u/Es5Y8wcok84Ay9FqVisSOilwXTNWKTLbCJnxHUBB1Gzw0O5uAw0iUZRVwfKQ5iAreO0H
	xxwNtdGzA9imnY9HUbByd3TmRfeHjzpZX3orPBUnBaJVtKcMxZjYaLBqeFU75YbCdydYNG
	W9Ln3xaIEDs/C7OTMIg0kxzMtupZrA8jmvhC/TwG7E1T7Om4gUn13QfsqklbdWRIViwUnb
	Dm/zHmnhFguw+lIdhb42WXGnWNQs/ALLYTvL0ikZicRwUr79EXYp4kgYxmDqXn57rVZKw0
	04myJvy3rmZJaw9Awa+vab/ewynD3MdD0qNCb9Na+r1VuixeBN7rFXjRri8P/w==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Sat, 22 Aug 2026 00:39:50 +0200
Subject: [PATCH bpf-next v7 8/9] selftests/bpf: move bpf_jit_harden helper
 into testing_helpers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260822-kasan-v7-8-99afee6ef7fd@bootlin.com>
References: <20260822-kasan-v7-0-99afee6ef7fd@bootlin.com>
In-Reply-To: <20260822-kasan-v7-0-99afee6ef7fd@bootlin.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
 "H. Peter Anvin" <hpa@zytor.com>, Shuah Khan <shuah@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Yafang Shao <laoar.shao@gmail.com>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Move set_bpf_jit_harden to testing helpers so that other selftests can
change the hardening configuration without re-implementing a helper.

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v5:
- check set_bpf_jit_harden return code in cleanup path

Changes in v3:
- new patch
---
 .../selftests/bpf/prog_tests/bpf_insn_array.c      | 44 +++-------------------
 tools/testing/selftests/bpf/testing_helpers.c      | 32 ++++++++++++++++
 tools/testing/selftests/bpf/testing_helpers.h      |  1 +
 3 files changed, 38 insertions(+), 39 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
index 0222a9a5d076..815f3e04540f 100644
--- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
+++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
@@ -227,42 +227,6 @@ static void check_incorrect_index(void)
 	check_mid_insn_index();
 }
 
-static int set_bpf_jit_harden(char *level)
-{
-	char old_level;
-	int err = -1;
-	int fd = -1;
-
-	fd = open("/proc/sys/net/core/bpf_jit_harden", O_RDWR | O_NONBLOCK);
-	if (fd < 0) {
-		ASSERT_FAIL("open .../bpf_jit_harden returned %d (errno=%d)", fd, errno);
-		return -1;
-	}
-
-	err = read(fd, &old_level, 1);
-	if (err != 1) {
-		ASSERT_FAIL("read from .../bpf_jit_harden returned %d (errno=%d)", err, errno);
-		err = -1;
-		goto end;
-	}
-
-	lseek(fd, 0, SEEK_SET);
-
-	err = write(fd, level, 1);
-	if (err != 1) {
-		ASSERT_FAIL("write to .../bpf_jit_harden returned %d (errno=%d)", err, errno);
-		err = -1;
-		goto end;
-	}
-
-	err = 0;
-	*level = old_level;
-end:
-	if (fd >= 0)
-		close(fd);
-	return err;
-}
-
 static void check_blindness(void)
 {
 	struct bpf_insn insns[] = {
@@ -272,7 +236,7 @@ static void check_blindness(void)
 		BPF_MOV64_IMM(BPF_REG_0, 1),
 		BPF_EXIT_INSN(),
 	};
-	int prog_fd = -1, map_fd;
+	int prog_fd = -1, map_fd, ret;
 	struct bpf_insn_array_value val = {};
 	char bpf_jit_harden = '@'; /* non-exizsting value */
 	int i;
@@ -291,7 +255,8 @@ static void check_blindness(void)
 		goto cleanup;
 
 	bpf_jit_harden = '2';
-	if (set_bpf_jit_harden(&bpf_jit_harden)) {
+	ret = set_bpf_jit_harden(&bpf_jit_harden);
+	if (!ASSERT_OK(ret, "set bpf_jit_harden")) {
 		bpf_jit_harden = '@'; /* open, read or write failed => no write was done */
 		goto cleanup;
 	}
@@ -313,7 +278,8 @@ static void check_blindness(void)
 cleanup:
 	/* restore the old one */
 	if (bpf_jit_harden != '@')
-		set_bpf_jit_harden(&bpf_jit_harden);
+		ASSERT_OK(set_bpf_jit_harden(&bpf_jit_harden),
+			  "restore hardening configuration");
 
 	close(prog_fd);
 	close(map_fd);
diff --git a/tools/testing/selftests/bpf/testing_helpers.c b/tools/testing/selftests/bpf/testing_helpers.c
index c970e7793dfc..737f668b35e2 100644
--- a/tools/testing/selftests/bpf/testing_helpers.c
+++ b/tools/testing/selftests/bpf/testing_helpers.c
@@ -519,6 +519,38 @@ bool is_jit_enabled(void)
 	return enabled;
 }
 
+int set_bpf_jit_harden(char *level)
+{
+	char old_level;
+	int err = -1;
+	int fd = -1;
+
+	fd = open("/proc/sys/net/core/bpf_jit_harden", O_RDWR | O_NONBLOCK);
+	if (fd < 0)
+		return -1;
+
+	err = read(fd, &old_level, 1);
+	if (err != 1) {
+		err = -1;
+		goto end;
+	}
+
+	lseek(fd, 0, SEEK_SET);
+
+	err = write(fd, level, 1);
+	if (err != 1) {
+		err = -1;
+		goto end;
+	}
+
+	err = 0;
+	*level = old_level;
+end:
+	if (fd >= 0)
+		close(fd);
+	return err;
+}
+
 int stack_mprotect(void)
 {
 	void *buf;
diff --git a/tools/testing/selftests/bpf/testing_helpers.h b/tools/testing/selftests/bpf/testing_helpers.h
index 2edc6fb7fc52..e00642afe86f 100644
--- a/tools/testing/selftests/bpf/testing_helpers.h
+++ b/tools/testing/selftests/bpf/testing_helpers.h
@@ -59,6 +59,7 @@ struct bpf_insn;
 int get_xlated_program(int fd_prog, struct bpf_insn **buf, __u32 *cnt);
 int testing_prog_flags(void);
 bool is_jit_enabled(void);
+int set_bpf_jit_harden(char *level);
 int stack_mprotect(void);
 
 #endif /* __TESTING_HELPERS_H */

-- 
2.55.0

