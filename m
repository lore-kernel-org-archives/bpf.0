Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2513E9588
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367905; cv=none; b=tXhl+/I1IyHFTgwb2iC4Zn6XG/Ekh3rhamgY9gcwVlyyM4ZmtPc4nBxnLw98+T9WhIRpQQbBy5H7A9qJVU829c1E/qwZY3XmvBq3WXuC373p8Bz33gysLow/9yuxa/lUsZPrda1FQ2mGss0rYm3e72RR/4kdEoWYu6qlzYVB7Ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367905; c=relaxed/simple;
	bh=u9LZEwi66b10OuzjwpSk5FjZx5A9K59bxx/PeiS2pIU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CczyGLX6fWFY5ytysl7P3B2QQxmmFtyLqrJvdOzeX/6cQIDYgg+T3q5V2+puqaROm7EN7aagRElkj1DSw2gAgjMij2M+AX58YUFv55B8K4mknmMoynt3tnuUEM2vFN3Yq/ragmYI5FfC60RKv1u8e2SH3Y9c1zE+ece1e2FIlVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Fg5oMCS+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Fg5oMCS+"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so129717085e9.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776367900; x=1776972700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJ3r37ogqR7olkqp+SapeMaeTv/V70MwihEzAcWCwTQ=;
        b=Fg5oMCS+e1rpHdpyXpaOG5XCyojqnM1qA2UKaoVEOwEfTdVspDrS/ozZ/Bt5h7sncC
         Y4z9tJg4V3OwRZdWqJFqlwuTygjfjbXy9AyY76Q13zNCeWo5uUsNQRLm1IZvVj9YXTZ1
         vU9Ba/1u9zlo6nAiB33hneCcrc9vrRcGaMJoU1B4ajiZm/JaLO5JI/4Z5ua8g43ehJrG
         3CoOIBIH9IAqNy1v1qpjp82jeUYiOLWBKxMRn1tZNuwZ3mdFjxH4TMoBV2+j047G4i3G
         fmrG5vZA3T3k66fmWDDCRqWGdWD+TyCuiB4vOfg03T3hlWdVcTsrzHXseuXfFnAydztY
         6jcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776367900; x=1776972700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IJ3r37ogqR7olkqp+SapeMaeTv/V70MwihEzAcWCwTQ=;
        b=PTWtZ5aX/Q54qZUVPdws/1g1HaATeHtY7M0QKi6J5jMgHy68uegYMqNsEwxh7b6th4
         Rj0E0MDtyBiuJiAPfyeJmvirCKbqBt8YFmYqUvL6w3UQE3+mgDPCh7ROT9yWKtUiajN7
         CX5fgFjju7PBna87Qp65lXSTQog4/Vt5CF84u8oSD4XOlNLLi5lnbtn9Xd72eRp9zZZS
         BaaoeSjDM2Tl/HPk5VEl00se9rrM4NRVCv9igFVNpiNy8L69dZMzVp9S//mGvK9INKoc
         0vbmJZo7+N9u9N3W9krAmr4O0Spnpcu31nKQ0sGzmYpj5cYYeZuEtzlcdJyOPr/BMXvT
         9Stg==
X-Gm-Message-State: AOJu0YxpqKwwYHC5DrVb/Xu298m7aPWDyxxgk+EP2sZ9sU3TVayf1hgl
	AL5+xzA0gtVswrW665ZlbR/EBd5PVUDtpIhjrvYaOI2xHh9ddlOu8aKw41NINbjFUtE=
X-Gm-Gg: AeBDiet3JdYBX9OyOQyByFLBsw2TQ5xgkN0gn0L7x2m83o3DbioiTOG1ia+qsAfWjvr
	aUynO1f9UzfcXfo1Uc5mHc83zLWNmb1K/bX7oNqQaIaNbjhq10XyHLkpJFfjUxNI6kNOkRJBQ2j
	iVFIArHNoaY+F8PXnC+mgeo7C3cjejz/0jqfMZyMACKLl8dtBbsth9j9o5XvvaHMtd/DQ8/XG17
	rhsAYdg3svbA/1nH2p9DMpM+9pGsZ0vqNvL0lvOAw2pSiJcLWGMQCUm26oCcjwnQLhJ9W8iBnvE
	eTfiPj12FfuG9URGvJJ34JFygk3DhFLciIRhOtKOJx3KNKZxUDuRLL8YZWWXJVPqHs4zxFzpLHv
	MgZ+91VGCq0y0Y2blH8aCtKSJBC3N75mRmyT4MNLdnhtbcq4XWZeHa/sJvlrvYxxxvAZNnklaN3
	Xiyc4lqbymTfT73p3J0xBNXOttkoF7gqblZA==
X-Received: by 2002:a05:600d:1b:b0:488:9439:881a with SMTP id 5b1f17b1804b1-488fb26ea7cmr2836085e9.2.1776367900154;
        Thu, 16 Apr 2026 12:31:40 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:dc8:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb8443csm8751812eec.14.2026.04.16.12.31.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:31:39 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 16 Apr 2026 16:31:00 -0300
Subject: [PATCH bpf-next v7 11/11] selftests/bpf: Tolerate missing files
 during install
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-selftests-bpf_misconfig-v7-11-a078e18012e4@suse.com>
References: <20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com>
In-Reply-To: <20260416-selftests-bpf_misconfig-v7-0-a078e18012e4@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 Alan Maguire <alan.maguire@oracle.com>, 
 "Ricardo B. Marliere" <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1776367852; l=2151;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=u9LZEwi66b10OuzjwpSk5FjZx5A9K59bxx/PeiS2pIU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLClSdovgIOUa0JYPVPuFKo/leHFyBzCBLmZIgS2HtfJjjwxK/CInHHcGA7RUpCwe1HMzRr7f5D
 ND8qhfhM0qwA=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

With partial builds, some TEST_GEN_FILES entries can be absent at install
time. rsync treats missing source arguments as fatal and aborts kselftest
installation.

Override INSTALL_SINGLE_RULE in selftests/bpf to use --ignore-missing-args,
while keeping the existing bpf-specific INSTALL_RULE extension logic. Also
add --ignore-missing-args to the TEST_INST_SUBDIRS rsync loop so that
subdirectories with no .bpf.o files (e.g. when a test runner flavor was
skipped) do not abort installation.

Note that the INSTALL_SINGLE_RULE override applies globally to all file
categories including static source files (TEST_PROGS, TEST_FILES). These
are version-controlled and should always be present, so the practical risk
is negligible.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 88a03366f6aa..53c3808c0c88 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -974,11 +974,22 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
 # Delete partially updated (corrupted) files on error
 .DELETE_ON_ERROR:
 
+# When permissive, tell rsync to ignore missing source arguments so that
+# partial builds do not abort installation.
+ifneq ($(PERMISSIVE),)
+override define INSTALL_SINGLE_RULE
+	$(if $(INSTALL_LIST),@mkdir -p $(INSTALL_PATH))
+	$(if $(INSTALL_LIST),rsync -a --copy-unsafe-links --ignore-missing-args $(INSTALL_LIST) $(INSTALL_PATH)/)
+endef
+endif
+
 DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
 override define INSTALL_RULE
 	$(DEFAULT_INSTALL_RULE)
-	@for DIR in $(TEST_INST_SUBDIRS); do		  \
-		mkdir -p $(INSTALL_PATH)/$$DIR;   \
-		rsync -a $(OUTPUT)/$$DIR/*.bpf.o $(INSTALL_PATH)/$$DIR;\
+	@for DIR in $(TEST_INST_SUBDIRS); do				  \
+		mkdir -p $(INSTALL_PATH)/$$DIR;				  \
+		rsync -a $(if $(PERMISSIVE),--ignore-missing-args)	  \
+			$(OUTPUT)/$$DIR/*.bpf.o				  \
+			$(INSTALL_PATH)/$$DIR;				  \
 	done
 endef

-- 
2.53.0

