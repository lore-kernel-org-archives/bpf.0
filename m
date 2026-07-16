Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9E93F4109;
	Thu, 16 Jul 2026 08:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784192275; cv=none; b=t+8deqRr25lW0Nzud9j8g4h0tAswrntjHsJxDKk+esNqHGmVRphC12nlL4ZbHK94bzOJpUyAEwV7a8JNKtFhht00pzOJV0IZ+tU2gj2zTWdwUZJirqZ+ywJQ/1Fxr7ysP8xJWNvcF73qPbvwCckr7DsVBmeMMR7POvmsZs+yY50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784192275; c=relaxed/simple;
	bh=sxDReqpNLpihDImWqQxCu7SoBNma2krL86Ep2B0Vh7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W8MFv7N/Pqw6uxHk1uvRKPxR6zIPUKPPZpUWPI4tkQbbyEszJNF1UUcEbaQRXMpzaWgH670CH3AquUsmpiLPKBPQfoGuQtqFRqAnf+ir4DEAyvUSlGalbUdXWSs/STRWqSf932M9M0LADDQ6fOI1E1WRBKs2O0aCb+OoIujRt44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 65a7114280f411f1aa26b74ffac11d73-20260716
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:ee0a969b-f913-4098-9069-0b55d5f0dd00,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:e7bac3a,CLOUDID:886244ca0ff6ca646818881a33cb8c89,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA
	:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 65a7114280f411f1aa26b74ffac11d73-20260716
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 434987799; Thu, 16 Jul 2026 16:57:39 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	paul.chaignon@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] tools/resolve_btfids: fix OUTPUT leakage from kselftest causing corrupted build paths
Date: Thu, 16 Jul 2026 16:57:33 +0800
Message-Id: <20260716085733.1761196-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When building kselftest-all, the kselftest Makefile passes OUTPUT as a
command-line variable to each test directory:

  tools/testing/selftests/Makefile:
    $(MAKE) OUTPUT=$$BUILD/$$TARGET -C $$TARGET

GNU Make automatically exports command-line variables to all sub-makes.
This OUTPUT propagates through the entire build chain:

  kselftest/mm (OUTPUT=.../selftests/mm)
    -> gen_mods_dir -> page_frag (kernel module build)
      -> tools/bpf/resolve_btfids (host tool dependency)

The resolve_btfids Makefile uses a conditional assignment:

  OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/

However, ?= cannot override a variable inherited from a parent build's
command line or environment.  The inherited OUTPUT points to the wrong
directory (the mm selftest directory) and lacks a trailing slash.

The tools/build Makefile.build system concatenates $(OUTPUT) with
filenames without a separating slash in its pattern rules:

  $(OUTPUT)%.o: %.c FORCE

When OUTPUT lacks a trailing '/', this produces corrupted paths such
as ".../selftests/mmmain.o" instead of ".../selftests/mm/main.o".
Meanwhile, the resolve_btfids Makefile itself uses $(OUTPUT)/filename
(with an explicit slash), so the HOSTLD step produces the file at a
different path than where the LINK step looks for it:

  HOSTLD produces: .../selftests/mmresolve_btfids-in.o  (no slash)
  LINK looks for:  .../selftests/mm/resolve_btfids-in.o  (with slash)

This results in a linker error:

  ld: cannot find .../resolve_btfids-in.o: No such file or directory

Fix this by checking the origin of OUTPUT.  When it is "command line"
or "environment" (indicating leakage from a parent build such as
kselftest), use 'override' to reset it to the correct directory.  When
built normally via the kernel build system, OUTPUT is set by
scripts/Makefile.include with origin "file" from the O= parameter,
which is correct and remains unaffected.

The fix can be reproduced and verified with:

  make -C tools/bpf/resolve_btfids clean
  # Before fix: fails with corrupted paths
  make OUTPUT=/path/to/selftests/mm -C tools/bpf/resolve_btfids
  # After fix: succeeds, artifacts in resolve_btfids directory

  # Also test environment variable leakage:
  OUTPUT=/path/to/selftests/mm make -C tools/bpf/resolve_btfids

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 tools/bpf/resolve_btfids/Makefile | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 7672208f65e4..eee88c73fd7a 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -26,6 +26,22 @@ HOSTAR  ?= ar
 HOSTPKG_CONFIG ?= pkg-config
 CROSS_COMPILE =
 
+# If OUTPUT was inherited from a parent build's command line (e.g. from
+# kselftest), it points to the wrong directory and may lack a trailing
+# slash.  The tools/build Makefile.build concatenates $(OUTPUT) with
+# filenames without a separating slash ($(OUTPUT)%.o), so a missing
+# trailing '/' produces corrupted paths such as "mmmain.o" instead of
+# "mm/main.o", and the linker cannot find resolve_btfids-in.o.
+#
+# When built via the kernel build system, OUTPUT is set by
+# scripts/Makefile.include (origin "file") from the O= parameter, which
+# is correct.  Only a command-line origin indicates leakage from a
+# parent build and needs to be reset.  Both "command line" and
+# "environment" origins indicate leakage; "file" (set by Makefile.include
+# from O=) and "undefined" are legitimate and must not be overridden.
+ifneq ($(filter command line environment,$(origin OUTPUT)),)
+override OUTPUT := $(srctree)/tools/bpf/resolve_btfids/
+endif
 OUTPUT ?= $(srctree)/tools/bpf/resolve_btfids/
 
 LIBBPF_SRC := $(srctree)/tools/lib/bpf/
-- 
2.25.1

