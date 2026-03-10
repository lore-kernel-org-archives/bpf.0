Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E92C363C56
	for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 10:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773138129; cv=none; b=J6vJYI8AaCArXzMLpxkYZXzBknkgsWLjSZMYHg01d6hKRVOxj1/9dkBHHyrN5tG99jTuv2GYaMzAnb6FVGO6DPhxFxEgR53ckKM7oP/vnaJEdAdXoN7xTM8gDkDPRBgTWqAm/SECyy/mjLFOUCX3li7EvJ2hP5dt5LCp4xbCOHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773138129; c=relaxed/simple;
	bh=lsJxPgERSHCsqMaCBHoOm4tyTpcumC7QEA2MNaPrJZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kikZhxZXHmhMPTDF7ONTGS3MyjWX+Ng/Dp58CnKNYj8ShB92l//ExrUGDAwCAUqfelddbUSmGVbSNV8czmW6ZZGo5XwyDfZVLPy+Vpghf5ZsQ9I62ngf7peR6lBpfLwCI5Bt5uLeeQBzn3dV5aYXL8LDBtDyxDIx1rI8U2N8fHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ3AsnvL; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ3AsnvL"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7d74fc959d8so1226163a34.2
        for <bpf@vger.kernel.org>; Tue, 10 Mar 2026 03:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773138127; x=1773742927; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60EfY+sfS+PwmLhh8wH27SBzK8XMzpeMTJAeMRMgVvc=;
        b=GZ3AsnvLcNGDbJ2ZVxfMS4SQDF2pTWGdw1BYcbvheyeFNMhRnDO2jewExR7CLNKwsO
         ekn0MaRuTAAhTh3JSxxJy89UbO3Z+DY3QCHFhcSfewl2nU3uIweEs7ImJngUzm2gQjt3
         n32AcpS6onoDmoo+0KmxjrANuy2uwtFIfaXotE8SAcOiCmyj53vwFAUgYJTP4GZvvXVl
         una8Wpgb5txrF5LQR7CD5K3Qsiewp+mYE/AN4khSCmls8NiOerW6jnLdw61VIsAtg2Y/
         9LGKQnfOIXC4+SXwl4WGjyt+3j3ornXd7+e+SQeBNPkaVuJS203+z7Hj85Ae/I68j1gC
         NjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773138127; x=1773742927;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=60EfY+sfS+PwmLhh8wH27SBzK8XMzpeMTJAeMRMgVvc=;
        b=doY8NAZOuXZZOGBV4my6YM/D2C2uUcs3Uf7Sn/jOnfeRT/wHorXy9PpAqeaNlpKenI
         ZLB50QG894zijO4XYLOpiL/sc0lEioSGSCNML55ycC/tSJ0A9q1Zv3cxUshh7AhoYvXb
         nW7cCFSIkrssMs3HbmAY7h9LKRWYk/79iXu//KH6AV4QubYwgvIYSeCOLVtODv9YNdeB
         e9eyRts8Bplyzqnbjd0JQ8ClenDdmZp2Z+nNTwXlrP8DEgG75sPX/iThwsn9l5Z3mdwO
         o6PFu8mquyh6ehW0A7z6vrqW4XOPXjvEI9EuKhyJ2PbnydbQrEwnsbis5nubuSrAns55
         T1EA==
X-Gm-Message-State: AOJu0Yy6HJXhTgM28z5wmOeEuqY2H65wdqgkMNCGfDgpDEdl8UhQT7Xs
	ZbvDYMiDeGl/qjj48zdBPamp65qnoH/IQ/GtPX4do91FHNjMsoD8Fpzj
X-Gm-Gg: ATEYQzx2vBkXJVe7yG7sexUTGjNmoEtZQD+01wypRGenwLg8m0V8IC0KsMNj5sByVQd
	HbVUiF0QLriSzhdao2wfa3fBnVVNtZKTvd9kfuEKX1fFgwzAf8LDtPyr5aVZjblsbxqAZ0LwMoT
	bkL2mFSd4TlCyhO4NeqYp3Ga+ASJOeNI0tcbTRXP30mD/deq5yr8VH27oV0COMKYr3C9h9ijBh9
	sA/sKfTVnNUjBnQe/IpmsPCVTH8vjvI2pQSkQ/KmxeZmBfotd3pbFgaegF8aikSFRiPEWoT/fEK
	APi+ba97Nr05657+DrZk587xTs5U8riAmThBUG8bvNjPtb0uRbrGuXUnqQ6tdNxgq2baYggywqS
	5l6w/OZ9nKHfxLENTEZr8DeKwjgiVHrgA8KhADobZYw6oPo9T4xOiiOYA5aGsThRLb9WWFukd8O
	GAQCNe4q01LYCqc+3rl+Iz0xsWEyfkneZUSTtQ9JMVhj+XtdRVh82bjynLmm0flBs++3HTHRNn4
	TLiqGDbG1wHiHKyf/Ee3BDc0KE=
X-Received: by 2002:a05:6820:1b0e:b0:67a:1dad:9d63 with SMTP id 006d021491bc7-67b9bc65edamr9090191eaf.6.1773138127574;
        Tue, 10 Mar 2026 03:22:07 -0700 (PDT)
Received: from localhost.localdomain (108-214-96-168.lightspeed.sntcca.sbcglobal.net. [108.214.96.168])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-67bb331eee0sm3877789eaf.8.2026.03.10.03.22.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 03:22:07 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH 2/2] selftests/bpf: Skip bpffs debug iter checks when unavailable in test_bpffs
Date: Tue, 10 Mar 2026 18:21:45 +0800
Message-ID: <20260310102145.857810-2-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260310102145.857810-1-sun.jian.kdev@gmail.com>
References: <20260310102145.857810-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

maps.debug/progs.debug may be inaccessible or absent (EPERM/EACCES/ENOENT)
in some environments, which used to abort test_bpffs before it exercised
the pin and rename checks. Treat these errors as "iter unavailable", log
an INFO message, and continue with the core bpffs tests.

Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
---
 .../selftests/bpf/prog_tests/test_bpffs.c     | 43 ++++++++++++++++---
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
index e8021ff0581c..95a7d2582ba7 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_bpffs.c
@@ -11,15 +11,18 @@
 /* TDIR must be in a location we can create a directory in. */
 #define TDIR "/tmp/test_bpffs_testdir"
 
-static int read_iter(char *file)
+static int read_iter(const char *file, int *save_errno)
 {
 	/* 1024 should be enough to get contiguous 4 "iter" letters at some point */
 	char buf[1024];
 	int fd, len;
 
 	fd = open(file, O_RDONLY);
-	if (fd < 0)
+	if (fd < 0) {
+		if (save_errno)
+			*save_errno = errno;
 		return -1;
+	}
 	while ((len = read(fd, buf, sizeof(buf) - 1)) > 0) {
 		buf[len] = '\0';
 		if (strstr(buf, "iter")) {
@@ -27,10 +30,33 @@ static int read_iter(char *file)
 			return 0;
 		}
 	}
+	if (save_errno)
+		*save_errno = (len < 0) ? errno : 0;
 	close(fd);
 	return -1;
 }
 
+static bool is_iter_skip_err(int err, int serrno)
+{
+	return err && (serrno == EPERM || serrno == EACCES || serrno == ENOENT);
+}
+
+static int read_iter_or_skip(const char *file)
+{
+	int serrno = 0;
+	int err = read_iter(file, &serrno);
+
+	if (is_iter_skip_err(err, serrno)) {
+		fprintf(stderr,
+			"INFO: %s unavailable (%d), skipping iter check\n",
+			file,
+			serrno);
+		return 0;
+	}
+
+	return err;
+}
+
 static int fn(void)
 {
 	struct stat a, b, c;
@@ -69,13 +95,16 @@ static int fn(void)
 	if (!ASSERT_OK(err, "mount bpffs " TDIR "/fs2"))
 		goto out;
 
-	err = read_iter(TDIR "/fs1/maps.debug");
-	if (!ASSERT_OK(err, "reading " TDIR "/fs1/maps.debug"))
+	err = read_iter_or_skip(TDIR "/fs1/maps.debug");
+	if (err) {
+		ASSERT_OK(err, "reading " TDIR "/fs1/maps.debug");
 		goto out;
-	err = read_iter(TDIR "/fs2/progs.debug");
-	if (!ASSERT_OK(err, "reading " TDIR "/fs2/progs.debug"))
+	}
+	err = read_iter_or_skip(TDIR "/fs2/progs.debug");
+	if (err) {
+		ASSERT_OK(err, "reading " TDIR "/fs2/progs.debug");
 		goto out;
-
+	}
 	err = mkdir(TDIR "/fs1/a", 0777);
 	if (!ASSERT_OK(err, "creating " TDIR "/fs1/a"))
 		goto out;
-- 
2.43.0

