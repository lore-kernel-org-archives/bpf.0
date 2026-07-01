Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4838C403B01
	for <bpf@vger.kernel.org>; Wed,  1 Jul 2026 10:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900232; cv=none; b=Mcr9Y1fE6tVA1z38DMdsZKuEZwllncvLDz9F1Dt4z2hCXGxs3MGbJ2JpAgBZX6Ey3aztPjITxVCLrYlAOUqfJnffXvGs1SVMecMfOM1y3c8BTIKhp64FgQrlh+w0WjXcXWyugpN4b19TQNYIoufjEFWIaWM6zmKVJJeYsT1WacY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900232; c=relaxed/simple;
	bh=etE+N/MlYVxSd4KeNUi+uyfU/waPnCA4ygyLzHNTOPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nkE4DlA2MVjD9ZhbyPahT6eUC69XPGqmS2WJmbInOVyd0PP+q00BT8LmQOcBVl3lhEGIX0hZeM6mNY+FzjM7pL2GfDua9CPZp/yMM8zk+5Td+LfZnWQ53vh62mgxGnDr6UPMrgDJKHs86K3gOKbL0o5cTwoxtoXUPCw2WAtqdWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1nRYS6Gi; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1nRYS6Gi"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 23BC34E40BE9;
	Wed,  1 Jul 2026 10:03:50 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ED89E60288;
	Wed,  1 Jul 2026 10:03:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BF52104C9DD6;
	Wed,  1 Jul 2026 12:03:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782900228; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=wdlnHacym1R+fO8OXKjuu51Mo8jbgvgR2Hwxia5FoqM=;
	b=1nRYS6GiuoJxeYQig2ya0kH1Xf/yHQyYvrpJ8wS7l+iSR9Wx+xg3iOIhdt/l96tO0801cx
	Qr+q7KOuIGl0G2P1nOt+bpkO/z3fybSYp9X2HE5LRYRPFxO/FJU5UtHMxrnp3dBIY3ow15
	outanTXf9wzwiCplD2YjkXk9kU9JJkvoqSGJzaI6bx75/l537W5BuWHQSw/paND36MxfBe
	oayNdrdafH+FldDSMG81RUihi42rLDOKbwcri0YmZFWxtrC/5Qt5yqvh8bMa2GCp7S0trM
	/fjQiv/eTV33NxLu97hrQucVVY0IQiXQ+/d2QkwxO1tQny5WYMwpHL3pDlld5Q==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 01 Jul 2026 12:02:56 +0200
Subject: [PATCH bpf-next v3 08/10] selftests/bpf: add helper to check
 whether eBPF KASAN is active
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260701-kasan-v3-8-bd09bb942d86@bootlin.com>
References: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
In-Reply-To: <20260701-kasan-v3-0-bd09bb942d86@bootlin.com>
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

Add a simple helper checking whether JIT compiler is able to insert
KASAN checks in programs. This will allow to conditionally run
selftests for KASAN checks in JITed programs.

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- fix condition
---
 tools/testing/selftests/bpf/unpriv_helpers.c | 5 +++++
 tools/testing/selftests/bpf/unpriv_helpers.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing/selftests/bpf/unpriv_helpers.c
index f997d7ec8fd0..11201b65a3d4 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.c
+++ b/tools/testing/selftests/bpf/unpriv_helpers.c
@@ -142,3 +142,8 @@ bool get_unpriv_disabled(void)
 	}
 	return mitigations_off;
 }
+
+bool get_kasan_jit_enabled(void)
+{
+	return config_contains("CONFIG_BPF_JIT_KASAN=y") == 1;
+}
diff --git a/tools/testing/selftests/bpf/unpriv_helpers.h b/tools/testing/selftests/bpf/unpriv_helpers.h
index 151f67329665..bc5f4c953c9d 100644
--- a/tools/testing/selftests/bpf/unpriv_helpers.h
+++ b/tools/testing/selftests/bpf/unpriv_helpers.h
@@ -5,3 +5,4 @@
 #define UNPRIV_SYSCTL "kernel/unprivileged_bpf_disabled"
 
 bool get_unpriv_disabled(void);
+bool get_kasan_jit_enabled(void);

-- 
2.54.0

