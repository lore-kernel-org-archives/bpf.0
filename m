Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F8477E3F
	for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 16:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777564976; cv=none; b=Zec/+NZRay38/tV+rzxueHZ5jeONjy4tYxI9RgGoXGF8TgpB+ktAX7GfyXw2X6bZbJisRQ8QCjZLV/CWDo+utDRATDReQIgEHZZ58I7o33kHrilYaTKhEwKtYOduvNN3iEzfH8bE+gwlK6jZu7NWQTS/eq8oTavvlAjgK3ve4aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777564976; c=relaxed/simple;
	bh=0g4nJPTP+SRNnJ6VP5Kw4a/d4c+9xCSL8ZRFVgYSARs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YXYOiC2xodiJeuA5Q4z/G7ChLyL9BLGixYYtZiAAU5al2G3+1TiP0HMSqpIcNT9Qo8SCkpyRacpflGEz8QpFuZ9xliZ98B61g+LISDQduj8weGLwbQAKeIN+qhnAxqEMOpSvzTvKOTxiMRb2eYXfSWoWF3I1PnhoFNrXkHYmSVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AR+CsJmj; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AR+CsJmj"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-38e7bd07656so9038841fa.1
        for <bpf@vger.kernel.org>; Thu, 30 Apr 2026 09:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777564973; x=1778169773; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FrFlzMIY8dqFl9fL6+GZm8ewKnQP1m4Ik6n37xpccCw=;
        b=AR+CsJmjYqsNqqhjnEOBFw1ebkL99wjfEosDhiz7/9UxYaGZEo3eZGZa8yIanwOjCs
         JXRNyC9B9jvHHDexLPvReSyAhEylwLWFxy40cteroArORM4vE7N+5z597eXSThRyYApP
         xLXIaEczED/9zkHUj9O0Qh29x0dhvegP3z3RBxAj3PH/DeUh44Ff0wKbKxxDM+80hQlW
         73rbDRRh6BDFrwWGJIQTolozJbNigK3/TlOgKcMz9EfCZibfeanZQPBbK1gwEtIkTcUM
         cWuc2X1afQ8w/OkVKU7m1cK1pyU38ga9yefPQcbWDnpVEhJT9bNlqBkC1uC0580O6YNO
         cRWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777564973; x=1778169773;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FrFlzMIY8dqFl9fL6+GZm8ewKnQP1m4Ik6n37xpccCw=;
        b=E0IoRMcDN3R5Zx4Zq9x9IorAG7RZzTqaABUZCi/C6BJVzFmQ1So4jKuNyU4AC8oDef
         JG8den5P6h4Cns3oE3vuPn8LCmHWnNQS50wT3p4rVx302VoN3vgGPK2Ba9iWuKZuODU5
         KayW59dR5G8l3MVaiQoNm/12tAY1dcVRwCrRR2XwAGDGor0y1v08Bj287noyIoU7dFG9
         Am3EKeKFzmTiZw+pHZwRY0E+85ECORzbSPeHdlHUShD+8HhP1sBvugh2DH+MngX6pF0q
         xC5nphosWdoOTGP5W/lY0bQ9nSIstbzJQptEicOJQb9ZVQioYAFFzeQ3Q6BbaDoXNQOf
         n7tw==
X-Gm-Message-State: AOJu0Ywff8bcRPswNXCzLz/nmQO69vDhNmfu7WmqRQCK+tnYaAWhMLnu
	UqMSAI6cbd1iOQU7XLXuDz/gtpPWPrkwJ5ChKZIxe6oIS2v9r1HxSLQNhjiQNRCLeYo=
X-Gm-Gg: AeBDievwx026/peAIAMWO1jACBsCa3DgbV2QbwwGDkJYh4BZWBd0D1VL/0l4jBUD680
	QZTXUUtUaOsEJyspHuCH8PNLopot27z2KNWtipxCMXTM/5T30lKXspux1/B1TEWHfBg5GWG6CmI
	G88XoUB01OaePKNy5bZTAwSrIcVfqyOv08ZPgqs4mhaHN3Tr9VERxGSkNPMCh01XGyINwLPqgQr
	NpOM6AgaObvbub6/AY1f/iXdtcPK9M8oKJqdHGG0CqlYLP6/PrUfe6yJkj36SVrYYwFMFUN98uI
	L/KKrSuWkCpUn8ZRZqazV61ri+yoQHzGJGt1JeRxLXLbTJb/J0tbLZfq6E4TaEzDJoFYhfQlmoq
	zLrdkdTs+JQbh040+mkiK3B+/7DR0bAvG70vCROO2GFQsfeFsFzbKMCARODvVNrmPCjwlvg15Lb
	xeKlBvsUMMpIvA89238pIonPze
X-Received: by 2002:a2e:9dcf:0:b0:391:11de:dd6c with SMTP id 38308e7fff4ca-3934e27876fmr12461231fa.16.1777564973242;
        Thu, 30 Apr 2026 09:02:53 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee38d79eb9sm610895eec.8.2026.04.30.09.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 09:02:52 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 30 Apr 2026 13:02:12 -0300
Subject: [PATCH bpf-next v11 11/11] selftests/bpf: Tolerate missing files
 during install
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260430-selftests-bpf_misconfig-v11-11-e11f7a8c4fdc@suse.com>
References: <20260430-selftests-bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com>
In-Reply-To: <20260430-selftests-bpf_misconfig-v11-0-e11f7a8c4fdc@suse.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777564926; l=2156;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=0g4nJPTP+SRNnJ6VP5Kw4a/d4c+9xCSL8ZRFVgYSARs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBSctWHKemMRwsrUhGlHgWOBzzJbhHVoeimaKLPlrUVLkf+65H78hcts5/x+c9oZ8Ecuvc8yUz6
 YyMVNTWCMBgU=
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
index a460f2ad3cff..9948a0a02bb9 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -1023,12 +1023,23 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
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
2.54.0

