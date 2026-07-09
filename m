Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE06405855;
	Thu,  9 Jul 2026 10:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591421; cv=none; b=kzpLnOIw18rgifrQvkp4am3wpRFAdV4er4BrlYzxtzoRgYtVrd9d+3KZuT4bvCG7JJRmz8sLSNSmmgGkszLxpd6S43vNGK/0h/hjQojynGTIWQcYzK1YB8yezVUW5xRVrRiGeAzcVL/xQU/9BVjFgcrFXAimMwWYP2kf3hInVYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591421; c=relaxed/simple;
	bh=hANZ/y7CoXj3Gzilljhef9yYe7inszCEDzBwC+ylOHA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FT9kpMQ3cYVLmxrEMuEmOhUgG0UO7482Ld0nN3WSHvXmxP24Q1sBvVIqBgXHTVdEknjesVt6O9U3EfD4YkkfGyfU+tUGJFuhZx16RO6Ub6d1DP3tQmsfNneq703sGCRsoL6zW3jdIjjVkQ0/qARq30BVSgrq7YH529S3tw2yPto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d/6gqjzb; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d/6gqjzb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2D1A1C2F4C2;
	Thu,  9 Jul 2026 10:03:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D24625FF03;
	Thu,  9 Jul 2026 10:03:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9891811BC374B;
	Thu,  9 Jul 2026 12:03:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783591417; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=unUdDMU0gKLGOyEOx1tzKElYwdackbPgPQ7PiZyXPpY=;
	b=d/6gqjzbaOAHIVRucoI2G4qwYVJIJJdQPQOQAdOeSHeDf8ZizQ3Vy0RjUCm56AQc+KM1TG
	ToMU6r6bRdCTTkhio4WApguU/RMSnQmyW4NpVCf8wCoToGncIQKTk77Y5uHtF+FtOnJhdr
	u3UhzhWDphZF0n65FkKpky8BoW495ri6gHRCGTIOlG7eSUFUkZjLm3dzgox5zqJl+vkkbR
	409HS7rqG3r7YTY2flVjqQh1x8cTcyR8P6iuNfUYKYqm6IOoYSGlrGbDKM8heZMgrwjHlM
	9SWTlQJnXKiY7TiAs5jGGznXR14yPTCnqgmCKC6wduuckJ05n+LWjKSlq6flng==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Thu, 09 Jul 2026 12:01:49 +0200
Subject: [PATCH bpf-next v5 08/10] selftests/bpf: add helpers for KASAN in
 JIT testing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260709-kasan-v5-8-1c64af8e4e1e@bootlin.com>
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

Add two simple helpers to allow checking whether KASAN for eBPF tests
should be executed:
- one helper to check if BPF_JIT_KASAN is enabled in kernel
  configuration
- one helper to check if the kernel is running with kasan_multi_shot
  (otherwise only the first test will be able to trigger a report)

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v5:
- add kasan_multi_shot helper

Changes in v2:
- fix condition
---
 tools/testing/selftests/bpf/unpriv_helpers.c | 10 ++++++++++
 tools/testing/selftests/bpf/unpriv_helpers.h |  2 ++
 2 files changed, 12 insertions(+)

diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index f997d7ec8fd0..95be83937883 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -142,3 +142,13 @@ bool get_unpriv_disabled(void)
 	}
 	return mitigations_off;
 }
+
+bool get_kasan_jit_enabled(void)
+{
+	return config_contains("CONFIG_BPF_JIT_KASAN=y") == 1;
+}
+
+bool get_kasan_multi_shot_enabled(void)
+{
+	return cmdline_contains("kasan_multi_shot");
+}
diff --git a/tools/testing/selftests/bpf/unpriv_helpers.h b/tools/testing/selftests/bpf/unpriv_helpers.h
index 151f67329665..a7ceb51577cd 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.h
+++ b/tools/testing/selftests/bpf/unpriv_helpers.h
@@ -5,3 +5,5 @@
 #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
 
 bool get_unpriv_disabled(void);
+bool get_kasan_jit_enabled(void);
+bool get_kasan_multi_shot_enabled(void);

-- 
2.54.0

