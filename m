Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD940B37B;
	Thu,  9 Jul 2026 10:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591424; cv=none; b=C5eVcI0VO4p/VkttB1MJf75gzNamrBu65RClsLUkZLGtT85l+7Tv+JPBjLYdOUGTXs33egK9v+iJtPx+wFysUsBm4YUtWEoz0yJ073g2FN1+9vSOgnBIfSnZ0iS2rG70OMwjaRKvfKvB9dHkFyLr3OdPDz2aiximQQ5zZLg1o0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591424; c=relaxed/simple;
	bh=P5vr14w2jPhWbOKQycMZkDakDXaxz0szpDZ7BTTpesg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rVokDHN7Dj5UXKMeuJs79+rNAjGaqHbt5TNxGMXDUe/BdsQVLVLgLNY2WSJiWFxKpghNJ3KmuoYX6O8B5ROtrFriv0Bvep/22u1ksKWomrZd5g/WB9gSvE7Xe4/iz8Bb55Ty0lfJ3B3EM1dX8pp9Nn/6vOKdAmbFA213IwHGhrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=P49YLAgW; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="P49YLAgW"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 0F4414E40D13;
	Thu,  9 Jul 2026 10:03:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D821D5FF03;
	Thu,  9 Jul 2026 10:03:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF58811BC3747;
	Thu,  9 Jul 2026 12:03:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783591420; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=fYm1kP1M7fb0+cA42RUh4WwgYhDm73UuY5LUlWxI1wk=;
	b=P49YLAgWjlf+NnXiniDlUsoI0ugNQE4R3h/z2KaF1jzv237DDDgMHaT7TdDKS8TMgOWLcS
	neA0eUpQtZbAAfliA60pX8OIR5HdQGuoDK2YLi3zEqZB2FxW+t5hb5GLOG2VeH98SJQ5Kw
	YF8KIUcj1oMa44KZVL1iJphlh6yOTY9KatJ9n0eKZbS+tqBUSMWJ2erLZZPuEGUxtRmaVt
	6iyFh9vAy6VIhnUXjq+oTcFvvZGpS40f5Dd9nn0MeOc8IrZwiqrUaLIfuswAmxdFi02rHs
	7rwUJgAR8RJL1JivN0Q2yYyW7wQ0ZAeahG+1fahZiCaGddAPpE5F5xJr95g+9w==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 09 Jul 2026 12:01:50 +0200
Subject: [PATCH bpf-next v5 09/10] selftests/bpf: move bpf_jit_harden
 helper into testing_helpers
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260709-kasan-v5-9-1c64af8e4e1e@bootlin.com>
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
In-Reply-To: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
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
 Ingo Molnar <mingo@redhat.com>, Andrey Konovalov <andreyknvl@gmail.com>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Move set_bpf_jit_harden to testing helpers so that other selftests can
change the hardening configuration without re-implementing a helper.

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
2.54.0

