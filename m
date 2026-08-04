Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31FD3D9695
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 17:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785865580; cv=none; b=uLMkwtbcsZFm2BlvsJaD80nv5phrukBbJInynJK8yufU9yEOtAeZpvl/Y61uAyNlX25XKZhTnT1jM2sIIO0nGik/zeETKTr4l6P2of1p6aTsGrTq0k42urMpvhNes0++nshcNo2+vKEWgzzjN1Yyw1TV9OzJTobz/7YEC5eS4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785865580; c=relaxed/simple;
	bh=19bZIBLT+huYyKma1eIhoR8n4LUeDJExLvZq6JpPGps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eZT61m4AKL/LGO7c/OghKblJHn5+Q7ZhLXguyV3Ts1/JiAXAW+R9z+odSEkqT14hF1dRMUVxN4qJWqKLJ3C+Ax+69RV9X6EmOtt+NBhX6oncC5bh2puzdGUdL9KRUem00nVkem+XyGDu9JJIRSVKqa0QP4JRuCQbfEHVIFESf44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0lFvLGiR; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0lFvLGiR"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E9CCA4E410EF;
	Tue,  4 Aug 2026 17:46:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BAD456029E;
	Tue,  4 Aug 2026 17:46:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BF7A911C3344F;
	Tue,  4 Aug 2026 19:46:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785865573; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7XonepTaW6pnmsBTB/BUJstAxxVjJ9BcMll4Kit8Xbk=;
	b=0lFvLGiRTRobpUlxkaP4OKCAD5ZveQiS52dKZJUtG3pMUu3lQvJl6+t7RxOXs9L+c3i8fz
	r6fjGlatgRzuRzfQRqZpe2mtJVs8TuW85N8wn9a9sHq7mICAVXaxAnSvC9ZKJoquh4Azrk
	aeM3AaBtUx45yusVlECbkzdPgc0CQ2isYFf8ZZO1LcttYMxZ1qO8qlyTesAdlhejDc1fMN
	2rbhQkX4kBsyDlDJPinZoSLHKYFhQFqUkByUdHyRoPLbcP84qJ62//TYO7s3a2uvALyqtD
	7W1RlLrdSVajJFKy3j/odQkYpltbl51C1C1q/Epq8vA3BZhmpKmzx54tG9QAEg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Tue, 04 Aug 2026 19:45:38 +0200
Subject: [PATCH bpf-next v6 7/9] selftests/bpf: add helpers for KASAN in
 JIT testing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260804-kasan-v6-7-549ef845f491@bootlin.com>
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
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3

Add two simple helpers to allow checking whether KASAN for eBPF tests
should be executed:
- one helper to check if BPF_JIT_KASAN is enabled in kernel
  configuration
- one helper to check if the kernel is running with kasan_multi_shot
  (otherwise only the first test will be able to trigger a report)

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>
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
index c99d81df2aa2..2b0a48e729de 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -145,3 +145,13 @@ bool get_unpriv_disabled(void)
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
2.55.0

