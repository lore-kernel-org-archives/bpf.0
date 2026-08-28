Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637039CD01
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 09:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908925; cv=none; b=D317qWoAEUJhhOFZHARgNXHqvr726b8nyHhq9wWvx8khnOfpUfQic6D1iUbsHEeUpYzlZql9WZE7QWz6Z9aW/RWtSz0ixWCd3YVAgz9B/YM6Y6e3DyYpU8wfFZpyGd1UMGYiu+pedMBOs3sHHRJ9zzcyOj5KspATTQYYG6xJt5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908925; c=relaxed/simple;
	bh=HXi7NSRQhhf/igJ8sIZ5qhIpTU8wkcQ6VOAutXrLPIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qAOPApagSvHRDrATv0xPieyZV8WzYwIucO7U+fxMoAhgo4thGHFwckp5VhXt2//L94H0jy2sRv8MXzaN6XW4o9TGdpjXeuraB+ReaV+Y4O47W2kX57udZGLKfEw5ZhBFeIyREDKogj5XC4JzGwYW2tw/fJG1g9viIDB644dErXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jYIowAHy; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jYIowAHy"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 33C941A189D;
	Fri, 28 Aug 2026 09:22:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 066AD60537;
	Fri, 28 Aug 2026 09:22:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9DE6A11C78028;
	Fri, 28 Aug 2026 11:21:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787908920; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YURpgYjUK0qnr6W3P7guU1YJ7lGdHWmKu6Gc7x/q/ZU=;
	b=jYIowAHy0qpZesVC+B4Z+HjMB01j2iPWKWApCXnZJLJRmuvcRZ+zROBBuvg/kEKV/6aYWW
	0IXTJV0Vlsgz67J/0ZR4GYyIEwCVLixMXrEzsfqH9dphQcYbVrwF+vM5Y1x8wckPscFySL
	yJDNiMCQFrEUu8sxijOps3OKdhZ78bnpeSQRE2VFJKZrZdeHweH/lT3d7064oN7hGp0AI9
	9lCkbwSe2o1PSawA0i6oisxCpiMm3iUVNHaj2qerV/peEOpAMa5dEC4sAlEmVO4OZNaLRM
	4tU2+ypYCUxF0WMrjreyWYAi5R9uxzd9+7Ec9Kr50U9MffYNC7+Um1sLd7AWsw==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Fri, 28 Aug 2026 11:21:14 +0200
Subject: [PATCH bpf-next v8 6/8] selftests/bpf: make cmdline_contains
 stricter
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260828-kasan-v8-6-7c1c0fdb9d7f@bootlin.com>
References: <20260828-kasan-v8-0-7c1c0fdb9d7f@bootlin.com>
In-Reply-To: <20260828-kasan-v8-0-7c1c0fdb9d7f@bootlin.com>
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

Fixes: 399f6185a1c0 ("selftests/bpf: Fix selftests broken by mitigations=off")
Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v7:
- add missing Fixes tag
- drop unneeded size check, already done by strcmp
---
 tools/testing/selftests/bpf/unpriv_helpers.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index f997d7ec8fd0..9dadcacaef0c 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -72,8 +72,8 @@ static int config_contains(const char *pat)
 
 static bool cmdline_contains(const char *pat)
 {
+	int fd, cnt, ret = false;
 	char cmdline[4096], *c;
-	int fd, ret = false;
 
 	fd = open("/proc/cmdline", O_RDONLY);
 	if (fd < 0) {
@@ -81,14 +81,15 @@ static bool cmdline_contains(const char *pat)
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
 	for (c = strtok(cmdline, " \n"); c; c = strtok(NULL, " \n")) {
-		if (strncmp(c, pat, strlen(c)))
+		if (strcmp(c, pat))
 			continue;
 		ret = true;
 		break;

-- 
2.55.0

