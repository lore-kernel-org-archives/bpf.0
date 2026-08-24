Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E1028B7EA
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601470; cv=none; b=ta9aLwnclY8vYQ5l4E2fQ0a2lfVjE6fuG59ME/F++Fc9lFDRn+Z68iQ800GKSRkG8D0mmdioyYuvC161iBY3/KF8OIh9Ba6616uqcgeVGV0AvaEEAA93zdFtw+SLW/KAIqPChgrmrtzSUfkvYcoWk4wXLPFWCHqrQ+LB5qWZLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601470; c=relaxed/simple;
	bh=wPhvBXlANJgV/brNWjIJWSUa9gQHjk9HzmXYLhH3jVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e0krSmF1581WnhkMNvQ99608xS7U1HS8S1cZtRg/TkRRWYDPwYMAMu4s0jHmH28mCiS0wmmdA1rKZx7hDyGX6sMTIQafsjdr7W2b6o9/6XjIBCD+zVsLQ3/3QQqN5Z0yuNAzQY366qlb7QHm3+veFarDTDH0aMs7sWqaQo4IfwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DxHwgofs; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxHwgofs"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-451bde4ab1cso1590435fac.1
        for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787601468; x=1788206268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KoklG3uiWQbM7pCXMM23b5hw6qTkjuOpdfgSwD5UvE4=;
        b=DxHwgofs+rqgHSs00RTg+j6cYyRx0wgdKHB26YSmU7J6AugQL06MPKSTgtJ9mhG39w
         ipPCsolZa+j+nusnIy3Q1y3va4kRgpbfbf1lAz2TifWAg41KxH0bBdkoADGNuGKb7X9i
         zD84mh5L57zV28qGqSqGLtnm/knWNySln4kETCJAK9rbGuwxfAD3ml2M+Km3aAeXUIMO
         iHs1bJbV7WqFUlXLomoag1L5kGHt+j9cL+SAUkM3KjbglTGk1ozMOFOi9EtcMH/IdS5E
         lV5B1tAHU6Q/2NlFjP8ASN1UANr2hqT0hYyUBi+s4+VJWzrfgC7gO5D/u8XT2cof8yat
         hNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787601468; x=1788206268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KoklG3uiWQbM7pCXMM23b5hw6qTkjuOpdfgSwD5UvE4=;
        b=IgWBJYVhZ/wBg4BOyd7Dcr0FxOWz++vcnzDJxvU2MqhmPCsH9vyOGh59eoSpI8VUqn
         gHVeYoIi08ig0FJ1gqSmoue/+x4oxFnNQBh2is4ogffkFv2dA0tTdWh6PdUtWjfT6ea5
         l3UbqywHLVzbve1ryfXt4wChu2E5Dqi10bSAEz+ikrTKp8rES1wa8yTZ+o0+id/tGFrn
         tJc2RPFqmOvhwW13LFlf2k2hyhrqKuqwemmXi5KFMkO2Ku+hcuuXS5OsyAfQReb0+buQ
         2ArVaFbghiEohHP5eh6fJL3/A9+p+oFlWjMbjRLpEFDvhCHA1uAS0B7L9TO27pmkJACA
         x5Fg==
X-Gm-Message-State: AFuF++lVSVamTxMk5cXezlm/wYa2sBBZSsGDoEi75717HhVn2Z7J+5Q9
	6LJVqtPP+hNkVxJ40tHDhGn8gEE9+xGl1YU0+YGgn2HjE1FPtofdPHRhCQksUPD7
X-Gm-Gg: AR+sD12zoOluqB4MPa+Wz1j8aldFvi3ECHO/VobiK69amya77Nbo73312rEzEhcqQff
	NbxQLkvexajwhsRNMNZmiDlotRfMh5bo1ytpfSIt/pJHB6PuDh1urEhbVv6XDmoUwr96fsOSEZ8
	QYsygyaOOAnvYpYhxiZsJrTDNjH0sNPFQk631bGRL6MFHWJjmH8+QutfPHzAB79t+RIvYjs50ki
	p3hlMlBgtcPWSRj/oFqFvzO2/pQh0sy4T45FZvP5eISYjpN4ny7B5hlGo85lXMVXRKbmDSSx1IA
	BGvQ3kjy/cFF143khjN6hlNRYB/94AbMLOTr1URRnv7H2yU0XMAX0kw9qZUK6MYL+pZZeDvPNT6
	qGaaA5wb/LPkhhOCH1k+9pfz8GdpHbFiLrkyOP8Ba3EfHPJec+4vLXTNfTrM3bg2W8skisqozYO
	SsZYrC4a1ZvEFm+37vywav+N8mznUpOk0jMBVp7MGsTtdz8/63YicN92Q11cVL++Y56bsG0mutb
	5bIOUYv0RhKTEn7AMcSN6MDHCqIwcSds4D+BeDLBOggqxjv/30Cyu4YeJO/ub6Vsd2PIA==
X-Received: by 2002:a05:6820:619:b0:6ae:9b39:68ce with SMTP id 006d021491bc7-6b16b5185eemr18972371eaf.24.1787601468136;
        Mon, 24 Aug 2026 12:57:48 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f48fc4e6f3sm5041909a34.14.2026.08.24.12.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 12:57:47 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next] selftests/bpf: Resolve bpftool through bpftool_helpers in core_reloc
Date: Mon, 24 Aug 2026 21:57:46 +0200
Message-ID: <20260824195746.3070450-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

run_btfgen() shells out to a hardcoded "./bpftool". That path only
exists in the build tree, where DEFINE_TEST_RUNNER_RULES symlinks
bpftool next to each runner binary. After "make install" it is not
there: commit 0b236ac75d04 ("selftests/bpf: Fix make install target")
dropped bpftool from TEST_GEN_PROGS_EXTENDED, which used to flatten it
into $(INSTALL_PATH), and installs it under $(INSTALL_PATH)/tools/sbin/
instead, matching detect_bpftool_path().

Running test_progs from the install tree therefore fails all 64
core_reloc_btfgen subtests:

  run_core_reloc_tests:FAIL:run_btfgen unexpected error: 32512 (errno 95)
  sh: line 1: ./bpftool: No such file or directory

32512 is 127 << 8, i.e. the shell could not find the binary.

Use run_bpftool_command() from bpftool_helpers.h, which locates bpftool
via $BPFTOOL, ./tools/sbin/bpftool or ../tools/sbin/bpftool, the last of
which also covers the test_progs flavors. bpftool_helpers.c is already
in TRUNNER_EXTRA_SOURCES, so no build change is needed.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/prog_tests/core_reloc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
index 08963c82f30b..80432c4656b5 100644
--- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
+++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
@@ -7,6 +7,7 @@
 #include <sys/mman.h>
 #include <sys/syscall.h>
 #include <bpf/btf.h>
+#include "bpftool_helpers.h"

 static int duration = 0;

@@ -985,16 +986,15 @@ static size_t roundup_page(size_t sz)

 static int run_btfgen(const char *src_btf, const char *dst_btf, const char *objpath)
 {
-	char command[4096];
+	char args[4096];
 	int n;

-	n = snprintf(command, sizeof(command),
-		     "./bpftool gen min_core_btf %s %s %s",
+	n = snprintf(args, sizeof(args), "gen min_core_btf %s %s %s",
 		     src_btf, dst_btf, objpath);
-	if (n < 0 || n >= sizeof(command))
+	if (n < 0 || n >= sizeof(args))
 		return -1;

-	return system(command);
+	return run_bpftool_command(args);
 }

 static void run_core_reloc_tests(bool use_btfgen)
--
2.53.0-Meta

