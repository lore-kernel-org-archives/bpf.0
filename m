Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C65047044E;
	Tue,  4 Aug 2026 17:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865580; cv=none; b=ot5eQkmM/xgeUeiu36LAZEjxivO6nEFbZH5e4Zo2QJ2lo20eyWuBZG4FDKC/lH9N2fBFhxVynubtB1iTc/HJ2ex7oho9++ZiC6+modzgqWX0osv3hmLqHoNEpRoRGTmtK3NW+3w/RG07YxADf3/Aw9n3QRCXFZeVSHlTcC1Q/2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865580; c=relaxed/simple;
	bh=T/8VPbw0+RdN1NiADAUuRcSfpb9HaCNOmtXN2iip1SM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QNImdH67cwcXVQDsg7VAzvFR4AccHDmcHpI/DWNGXsaGmbPK8zC+GjhwHm74rozEf2vHLtj8Wb+uGCbMC4P0M+LXpADIVtwWphu3sqMENjx1DweQ9fL51fiyyIbFMYKcg3rPonZ3ZRaJMp7a1xJjTZILjsY4u+L2AfB3jJZbL9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ciiN0TAU; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ciiN0TAU"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id C65AA1A140B;
	Tue,  4 Aug 2026 17:46:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 90C786029E;
	Tue,  4 Aug 2026 17:46:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1913B11C33456;
	Tue,  4 Aug 2026 19:46:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785865570; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=JU3L+df83l9QR9Jyin43E3VGRjhMOIOuUHGxEgFQzpM=;
	b=ciiN0TAU3HC+wYecjfrE2ogxdpDr1nIoln9eLk4gK6N0rTdI6VV/lt3d2Fh4tlWZiX5jRP
	K1cVbO78NeZXVoaKiLs5rXrF2Brtw22MDhgDzzKHW5S2Yz0/j9mIqwA0gMbuW4JAABZjIj
	4J4e6xcbbK+/UTxIGNS+C9ARNDGZvPiFCoUywetaZrv6ZRBfx/ixnTlCxlmAdJiOnczWhp
	/j3bswvY77vBAcvAhf+fWcuXLBK95s7WVwvogIJL8cRaf3/1b0KZGMQnEqQ1d3a39r2N+q
	u9BxBiRgFwrKlb9p1Y5wt7118wu1LCdiBbG3FmsXa5NSN++kwMF0qlEM2gA8KA==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 04 Aug 2026 19:45:37 +0200
Subject: [PATCH bpf-next v6 6/9] selftests/bpf: make cmdline_contains
 stricter
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-kasan-v6-6-549ef845f491@bootlin.com>
References: <20260804-kasan-v6-0-549ef845f491@bootlin.com>
In-Reply-To: <20260804-kasan-v6-0-549ef845f491@bootlin.com>
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

cmdline_contains is used by BPF selftests to check the presence of
specific kernel commandline parameters, but it currently suffers from
two issues:
- the read commandline isn't NULL terminated right after the read data
  but only at the end of the buffer, leaving uninitialized bytes that
  are then possibly tokenized
- the comparison of found tokens is done based on the size of found
  token. This could lead to too-short-but-matching tokens to wrongly
  match the search pattern.

Enforce stricter checks in cmdline_contains to avoid accidental matches.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
 tools/testing/selftests/bpf/unpriv_helpers.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index f997d7ec8fd0..c99d81df2aa2 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -72,8 +72,9 @@ static int config_contains(const char *pat)
 
 static bool cmdline_contains(const char *pat)
 {
+	int fd, cnt, ret = false;
 	char cmdline[4096], *c;
-	int fd, ret = false;
+	size_t pat_len;
 
 	fd = open("/proc/cmdline", O_RDONLY);
 	if (fd < 0) {
@@ -81,14 +82,16 @@ static bool cmdline_contains(const char *pat)
 		return false;
 	}
 
-	if (read(fd, cmdline, sizeof(cmdline) - 1) < 0) {
+	cnt = read(fd, cmdline, sizeof(cmdline) - 1);
+	if (cnt < 0) {
 		perror("read /proc/cmdline");
 		goto out;
 	}
 
-	cmdline[sizeof(cmdline) - 1] = '\0';
+	cmdline[cnt] = '\0';
+	pat_len = strlen(pat);
 	for (c = strtok(cmdline, " \n"); c; c = strtok(NULL, " \n")) {
-		if (strncmp(c, pat, strlen(c)))
+		if (strlen(c) != pat_len || strcmp(c, pat))
 			continue;
 		ret = true;
 		break;

-- 
2.55.0

