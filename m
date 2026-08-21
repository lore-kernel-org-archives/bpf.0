Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03E339A4AA;
	Fri, 21 Aug 2026 22:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787352057; cv=none; b=EmxIkIifOF33Tzt2ojY0iY/tk3tjs4iIQ1cb1+uMLQClu2E2lv3PzAyHwMcCp2qKq4NM6vCVxAPbACnh/WVumz+BVumEqj3fJZL4+ll3XudPImtcPfTAKfsnOQJX9pmVjp5scbBASU45pEErICFij9lvqV8wrGUQ6tMDFMbZZOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787352057; c=relaxed/simple;
	bh=xdCnY/3DX3sXooEk/gY9+LpZS07QhwIdT3OEWA1yDMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cpUp6aV0SND+K/aVYEZmgaUyjbYgjmW4bWFBd/Zz90uaCU3QN/BxBluOpEH4Vv3MN72G7ihlrM1nDNYyJlrp9cVwVZKBHtbXXasf1R1W035dTePhdCYe3JaXvkb62+cUayycHqBALdFB+cIl002CM3RcYcRG5LhTbLIMW+3SD3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=g2/1Vg2K; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="g2/1Vg2K"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 4D59C1A1796;
	Fri, 21 Aug 2026 22:40:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 20AA5604AA;
	Fri, 21 Aug 2026 22:40:54 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3EA1E11C7770D;
	Sat, 22 Aug 2026 00:40:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787352048; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=NW+Ti3IITyJJsuvwqKKh41ldDnxjK1STj2/1r0/iZGs=;
	b=g2/1Vg2KWr4ywQzRpKICKKDeh7bKDjmLO0ZQ0HFZfjqwTH72G7N6t+zb/rrFlWzv8svkJQ
	Gkf18shMKyNNrjFbE+oIP5n0G39PiASrnRSpRzVrffVYdCWEwNHxK7+eQcDp39ibT7K/EW
	ncp75lTI6F9C+Ixp+aIPvHn/UDYBiG57agNxsbQYe4yurfUtYVHYNwppjcP1Er63MhcfjH
	YbM/T4yEfjpdsDkuPhtBTzotRt6/OtDcPFL5cpjk+qCWVisnBOPbm3bF74Lvccgkj8Nxdp
	TfpI7MY6sXLjq6M3aCEMeciEKpVEPeQVnLRj4m2tpYLo9uUrv4J4/l7ZIHf09g==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Sat, 22 Aug 2026 00:39:49 +0200
Subject: [PATCH bpf-next v7 7/9] selftests/bpf: add helpers for KASAN in
 JIT testing
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260822-kasan-v7-7-99afee6ef7fd@bootlin.com>
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
index 9dadcacaef0c..2c8c5edb8751 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -143,3 +143,13 @@ bool get_unpriv_disabled(void)
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

