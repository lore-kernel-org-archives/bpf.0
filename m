Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860DC47AF49
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060150; cv=none; b=uEyRzqX53qL/LoJDgPJCOIzgQooAHlLqwhnsty3G5BYaWQfcipIMYuHXUugb7zNf8ETalpqfq2bLNG2hALHO6hj8Iy3k8S9hRDm1xOxzVpaM+ASLXZYDX0U2b8aDLJ45APqobyMSL/ouseVNi5oFJalbME8q0jCMclMiVNHJ0uE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060150; c=relaxed/simple;
	bh=aUpES7Gc9kEPXxJ8Aaeynu09heHY8n8dzJ+eSENcNh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VFTEtrmnjbk4kuHvGTjV+jtxq7p2j8c38sNSrJ0a6oK5trbewMe3oAtt0tgu6g9TzLEYJz0mHNcoIlFUGMLRGnu/z+e6e88bswQ7bWg4VIHz7iG/rviYJABcqmooYuJHBrdQXG1jCZ/PdN4+m0T5IC5PIA4CMTKSN5VHiHy8pKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Sb+koR3b; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Sb+koR3b"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4853c1ca73aso74165145e9.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:15:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775060146; x=1775664946; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FH31e8AWCzEljZIdx40WqHOE1eMjOl08QVJ0UOLH5y0=;
        b=Sb+koR3bmpfLekNktSLXNu1jQdAXvz4oMZtiwizY7vEDay3E892bYxUh8JOYY4GNSD
         01jzklTtmmjHLDdUe6Dxvum6z5JzBCcHdSQet3ll1TDkmFqbVY14d3IkDsLbb240Yq5j
         f/x1/5BJuTwdtqSvcJce2gaY9ZNE6vxA92J0+YPK7QrSuLsr70NPxS0IzD2s/87C20YV
         d6Rx8yuZ1IUZTj102E6Pvl4gCsT9bioJI9FSX56+AhZ22hhhjW1VfiWSakqt1N0LULgx
         8UgOS8JrE0nov38FAhjXCNjrmeQVWqJAmg4HBJ/5FcfiEN2nzzGKQu2pA1DA9okDxm6Z
         0S5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060146; x=1775664946;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FH31e8AWCzEljZIdx40WqHOE1eMjOl08QVJ0UOLH5y0=;
        b=FRuRswFR+rXYBqQzXogBgRWFFEyero4XS3VCItHgXtCLpZg4UqQGia7DLRCpuk1k37
         Hi71hndhgo0orAAcn35QLzQW5zMpl0gumNB9f0NfujdnG43jOOY+pB80OWj0soExdYzk
         1Bk9AWA7XkMz8kWiHjg36WaCu+jS0vskHiP3WTqQkB2PxZRyvcmm+qs/ESfP0k0RQ2xc
         23jLXfOCNhV8vbpWX83c4ryp8gQZrfnO+auGko2nvniapUkaxbggSVsaGVDMdCelwC/e
         7s3BzVOgDEpfIIdxZdODiOR3wYeyk6/Zbx97tDcm24RXB0qgE11x81O7TvEY4+c9tDEV
         bRHA==
X-Gm-Message-State: AOJu0Yy6oJeX+b7I6afpnd5mFlSifXkKNIl07MlFPlT2H97AhECdKU1L
	D0bMRNptmJEsaXULVbWA08IBlZphdxHYpRJ7Fig1kn9r86p9bYrWAIagDQcRKE0YDLw=
X-Gm-Gg: ATEYQzwYY+5CtabGQsMNVBuWZvvR7KCL1yEU7xUUodnQGDAkwyw2BBlCygl6MfcyEFh
	wzLtQkReoEeK6k2eeCXRJqTcTk/SvQDZLMDKoppD2qrTbogNSCkx/K7FI9rR9foElIUD9MgUyFO
	CPZ95qJnlhK1Ej6Y0NdWtli2ZBVGmSA24Sja/gXZA9FncsAtqwf6kmULw5SRxBEhz7p3xDXLMCp
	PM2oEWaB3G036ON/V2JkbdtqGYu0stmQvlAWCCIW7c15GcSlsvKyx/+nxK2+Ss/c7cTK4ketwEX
	WQwo1yGNyp2kqHm26yWQaSZMNNn+AmqoGRw+IniCpoxEsx38Qd5xgPEQUoVomK0nxN9umzzmsxO
	0Zc6TVV4hg4me/ggPhOVp6GyOJ6REPNQOxmb0NGUcVOOMDQRdfJCAcInXaSkxcPbxT5CBCO63PG
	myquQWTZNl
X-Received: by 2002:a05:600c:848d:b0:485:3c66:e230 with SMTP id 5b1f17b1804b1-488835b78f1mr78263475e9.29.1775060145641;
        Wed, 01 Apr 2026 09:15:45 -0700 (PDT)
Received: from localhost ([189.99.238.3])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-953fb8515f9sm480658241.6.2026.04.01.09.15.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:15:44 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 01 Apr 2026 13:15:10 -0300
Subject: [PATCH 03/10] selftests/bpf: Avoid rebuilds when running
 emit_tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-selftests-bpf_misconfig-v1-3-3ae42c0af76f@suse.com>
References: <20260401-selftests-bpf_misconfig-v1-0-3ae42c0af76f@suse.com>
In-Reply-To: <20260401-selftests-bpf_misconfig-v1-0-3ae42c0af76f@suse.com>
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
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openssh-sha256; t=1775060128; l=1031;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=aUpES7Gc9kEPXxJ8Aaeynu09heHY8n8dzJ+eSENcNh4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMsJ69itcpfkywotPoUEtnEUJMnBYAIgSDZL85c3MrgvDq7t1aLeZLcV61FfzyM/1a0vB/wWLMM
 37EVYpHuMKgY=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

emit_tests is used while installing selftests to generate the kselftest
list. Pulling in .d files for this goal can trigger BPF rebuild rules and
mix build output into list generation.

Skip dependency file inclusion for emit_tests, like clean goals, so list
generation stays side-effect free.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index 6052bba2c157..781238152c4f 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -703,7 +703,7 @@ $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_BPF_SKELS_LINKED)			\
 			    $$(BPFOBJ) | $(TRUNNER_OUTPUT)
 
-ifeq ($(filter clean docs-clean,$(MAKECMDGOALS)),)
+ifeq ($(filter clean docs-clean emit_tests,$(MAKECMDGOALS)),)
 include $(wildcard $(TRUNNER_TEST_OBJS:.o=.d))
 endif
 

-- 
2.53.0

