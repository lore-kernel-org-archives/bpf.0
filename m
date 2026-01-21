Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62D54A1391;
	Wed, 21 Jan 2026 15:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769008724; cv=none; b=ftvsKj3Xgztoms91CZfe8CrzvAHb+SClkNK1dtC9CgEHptIrfLngTZP+537me3E9a9dL8c8Ky0J7ZzxI+me/KKsz2zA0dBRGGbtERfXXK8CS7D/502z5EC0eYneINVNWsHnKGZ77NiHbQb8wYLdT8gexa1JZEJ1NpmiAy5B+O0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769008724; c=relaxed/simple;
	bh=nojLYlnUBROHjmm2L7wgWdhcwqMsQDSOTW0Dc6oUXqw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MepzgtqhRSpu9Dsv2vmfzFPEPuDKMTDwFk1ihhssFCWrwFJ6JY1DIKg5td8BuIKv0lWl/R8yHA05J9DIMJYQcDncCi1JiQo+zmtOMlB5Tp8CWPqOL8GW5b5GONR+kvveiG2rxDce5sDLp1qDqXD0e5gF0EyqBa+UWO4gDfFcv+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=l/eWjegY; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="l/eWjegY"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 320634E421C9;
	Wed, 21 Jan 2026 15:18:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 040386070A;
	Wed, 21 Jan 2026 15:18:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3FAE1119B1697;
	Wed, 21 Jan 2026 16:18:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769008719; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=nK5OdHC4v4urBGe4fZDeYp81OhszkNIDiCdCwuVXm2s=;
	b=l/eWjegYtPvqkKzAjaiG7DbUVHX2oVDrh+ndnNcyxwbAwJicxDdvc2CaVtLLA7oKDG8ZEq
	plBGSVHFr/jcNZfK7Ty1L3Ji85/6Fhlu8SMiiUmPr19GiOink/haWVBjQV5zA2zwhcoQRy
	oJ3LQWFfSvWSSoSSgQhvG0ytlpaHeMJvkZ1lMCGggkQrX9hTsCfZhk0xlcajBWFjt1xr7W
	+Bw5+qm+58sqCLrO/v85ILw7/IYmPaBrnn0xevT9/PVIg5Qbcn/lkKW6fm42YwWqTs4ZDc
	YEL+4chX6vinlbL+xb+Hku/jixAl1OX+zVZtnzi/awCITg6T7U43WMlqk/dGhg==
From: =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
Date: Wed, 21 Jan 2026 16:18:14 +0100
Subject: [PATCH bpf-next v2 1/4] selftests/bpf: reorder test_progs sources
 alphabetically
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260121-bpftool-tests-v2-1-64edb47e91ae@bootlin.com>
References: <20260121-bpftool-tests-v2-0-64edb47e91ae@bootlin.com>
In-Reply-To: <20260121-bpftool-tests-v2-0-64edb47e91ae@bootlin.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
 Quentin Monnet <qmo@kernel.org>
Cc: ebpf@linuxfoundation.org, 
 Bastien Curutchet <bastien.curutchet@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3

Update test_progs sources listing to make those sorted alphabetically

Signed-off-by: Alexis Lothoré (eBPF Foundation) <alexis.lothore@bootlin.com>
---
Changes in v2:
- new commit
---
 tools/testing/selftests/bpf/Makefile | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index fd42b7193d4e..0270b0a6dd79 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -729,25 +729,25 @@ $(VERIFY_SIG_HDR): $(VERIFICATION_CERT)
 # Define test_progs test runner.
 TRUNNER_TESTS_DIR := prog_tests
 TRUNNER_BPF_PROGS_DIR := progs
-TRUNNER_EXTRA_SOURCES := test_progs.c		\
-			 cgroup_helpers.c	\
-			 trace_helpers.c	\
-			 network_helpers.c	\
-			 testing_helpers.c	\
-			 btf_helpers.c		\
-			 cap_helpers.c		\
-			 unpriv_helpers.c 	\
-			 netlink_helpers.c	\
-			 jit_disasm_helpers.c	\
-			 io_helpers.c		\
-			 test_loader.c		\
-			 xsk.c			\
-			 disasm.c		\
-			 disasm_helpers.c	\
-			 json_writer.c 		\
+TRUNNER_EXTRA_SOURCES := btf_helpers.c			\
+			 cap_helpers.c			\
+			 cgroup_helpers.c		\
+			 disasm.c			\
+			 disasm_helpers.c		\
+			 flow_dissector_load.h		\
+			 ip_check_defrag_frags.h	\
+			 io_helpers.c			\
+			 jit_disasm_helpers.c		\
+			 json_writer.c 			\
+			 netlink_helpers.c		\
+			 network_helpers.c		\
+			 test_loader.c			\
+			 test_progs.c			\
+			 testing_helpers.c		\
+			 trace_helpers.c		\
+			 unpriv_helpers.c 		\
 			 $(VERIFY_SIG_HDR)		\
-			 flow_dissector_load.h	\
-			 ip_check_defrag_frags.h
+			 xsk.c
 TRUNNER_LIB_SOURCES := find_bit.c
 TRUNNER_EXTRA_FILES := \
 		       $(OUTPUT)/xdp_synproxy				\

-- 
2.52.0

