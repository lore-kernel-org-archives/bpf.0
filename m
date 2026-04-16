Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3631F3E5594
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776367887; cv=none; b=CtVpYYxbPTwsR98DDALgIm1UWKxxvl5NII1Db3VQk2mXcwW1wx4RvrLBLaM2gngo9+JZlDYVq3slZHXIJJZ+6bg1Y/GscY83zdqOLtXKbwgc7bQGT/b0bAoF9uRth8+M2qQk6yOlJoa0nJQYSqTv9OLcAcZrGJqw43xMgC8GUcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776367887; c=relaxed/simple;
	bh=DXqH+tS5C79NJ+J0fc2RdGELwdh06ZOzO/YLsYIRLlg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RKDHCuwqDLh7d6sk2a2KG4oWwKXiJctoY9y2BywN3GOdAhYH11HdeCbdp8R+p0+gJmHF5DxD8Vf4fyk7jkC4Oe3gUGjeLksBxZNZudLL9zQpkJ9wMlj2mHTgA5dKJXOPTK4paOJPTquI6/LraX+7p6pnapx9yBHQrBALYYO55VQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=H4qHn3q1; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="H4qHn3q1"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488c21c636dso51572175e9.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 12:31:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1776367881; x=1776972681; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yTWGN6AOI1k/C39wxoz1HQGoi2yZHDMyrh0AH1c9Jig=;
        b=H4qHn3q1cfKprzjTQVYzDaUkD+5NgutRvBRZ8lw9ynjfPrP0DWHTRsZ1dY19tHSvML
         ujeo1siEkr3V/6D9oKQkRaXwq6HfihXr7C02COYESRqUfSKwAvcjgUokNZ2Np6XZ5ciD
         lxnWTJj4PNttaEU6Q3Y9sJxxk2vqth/bUA+6n8TV1tKYHmELfQVc0EmF87BS+z1VIZw0
         rNzQv6SBLp8OqfRZWyenJ/ZvNyYJtvpFUnLjklcILXR8tb0eXRl7wgi7jMSqS9dMvu7U
         t49MiKk3kVlDcsb7Nyv6qiuYYCqZz7c6l2exkRcWXngVj3lms4mGFgFqUnLxBsjeAy9f
         zBJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776367881; x=1776972681;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yTWGN6AOI1k/C39wxoz1HQGoi2yZHDMyrh0AH1c9Jig=;
        b=p/B/hOn4ykMJiHvQw0V/lNHfI8kNI8mqi/3z8vgNaAloWnL4TpI6SO6aNkNhun9Cyn
         xsPvDisz6/YAE20AyxbMY+MRlBvIzKp4bRm5BqPfzFL9U+eOIKhGsb2kihId80QbUUBi
         xkz4P78nKBN7DSmi+DaKdWGlTM1RXff4Mu+kydrrhD0PoTxJqDUu/1HPuzNdSQpzawDH
         +dWdHcgcCAwHKH3JNsG7rUuwAPYZMMdvHP0x80zkNZQpOhyBUX1HzRGa0UIb6DIQ9Eww
         hQ2qAO9tHJCgVvwPlGSZRjPJjJKNh8rco5PGISW20pPPGW3vEqroWkhW8X7KksEXGHOU
         BMiA==
X-Gm-Message-State: AOJu0YzzcNKsPbAwLhXMII6QmiyrtOGO4I6uvR8asiBlX3k7kWsI51Ck
	riYRP5hp/CdqYObOcR/SyX1vAjQbvGSt0isES7waUmEl2d6AtlmW3r2NlkjrXFpMxkA=
X-Gm-Gg: AeBDietvlrYPBrxNLKXepCyHTeurHwTNLexD7Mn5jGinETD56pP4rN/v+upHqNOhlBA
	9defpqSUl7vNckDU+aO1Bppp7dnUVuahQimstp4CMqhZU0MyeRFXSwkrqrN5ocTtOArTSEYSpBe
	aEyvJ69/k/fe3ucrZvjYLqDcM+lkAhgVB0WbwwdO7IH3C+OktLKxEwSYM0Bn0EeikAcVPBOD6gT
	j+WEkFEdaAM4inHwgAIoFABTJYAywc0agCIjSVpVmrmh6OIuxe67zQO9GDHCoNLa3QWXyjp5YVY
	190lSuDqEkRHD502f5czsapSHp6TKno+aJXlgP1pKUCKdqr4fXDoXPCarh/CFnbllQgsWeqk3Nj
	3sMk7BqMiU6sAV0Uj8tS2h+WwOeCkppPqCB8XlQKdNc8uwbLTwV4MfKtUaMqW8pXk30X0NIWLFg
	wYmR4yRLEvmf/Iunkry8O164QibcNSUypd6g==
X-Received: by 2002:a05:600c:8b32:b0:486:f634:ef1 with SMTP id 5b1f17b1804b1-488fb27fef4mr2800715e9.17.1776367880994;
        Thu, 16 Apr 2026 12:31:20 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:dc8:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c5e6a8496sm7077970c88.10.2026.04.16.12.31.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 12:31:20 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Thu, 16 Apr 2026 16:30:55 -0300
Subject: [PATCH bpf-next v7 06/11] selftests/bpf: Tolerate test file
 compilation failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260416-selftests-bpf_misconfig-v7-6-a078e18012e4@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1776367852; l=2121;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=DXqH+tS5C79NJ+J0fc2RdGELwdh06ZOzO/YLsYIRLlg=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIgMmMhaE8XS+X1UjOJf+TVsz24Bt0Sp7ClqyH5dO97kGSaeKzEEzZ3QFJbjD08OSD4LVRrGaJG
 0SzAB0kICWgc=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Individual test files may fail to compile when headers or kernel features
required by that test are absent. Currently this aborts the entire build.

Make the per-test compilation non-fatal: remove the output object on
failure and print a SKIP-TEST marker to stderr. Guard the BTFIDS
post-processing step so it is skipped when the object file is absent. The
linker step will later ignore absent objects, allowing the remaining tests
to build and run.

Use plain printf and $(Q) instead of $(call msg,...) in the BTFIDS block:
the msg macro expands to @printf which is a make-recipe construct and is
invalid as a shell command inside an if-then-fi body; $(Q) restores echo
suppression at the recipe level where it is meaningful.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b3eaa4a93707..5ad50d3ff2f8 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -708,11 +708,14 @@ $(TRUNNER_TEST_OBJS): $(TRUNNER_OUTPUT)/%.test.o:			\
 		      $(TRUNNER_TESTS_DIR)/%.c				\
 		      | $(TRUNNER_OUTPUT)/%.test.d
 	$$(call msg,TEST-OBJ,$(TRUNNER_BINARY),$$@)
-	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F)
+	$(Q)cd $$(@D) && $$(CC) -I. $$(CFLAGS) -MMD -MT $$@ -c $(CURDIR)/$$< $$(LDLIBS) -o $$(@F) $(if $(PERMISSIVE),|| \
+		($(RM) $$(@F); printf '  %-12s %s\n' 'SKIP-TEST' '$$(notdir $$@)' 1>&2))
 	$$(if $$(TEST_NEEDS_BTFIDS),						\
-		$$(call msg,BTFIDS,$(TRUNNER_BINARY),$$@)			\
+		$(Q)if [ -f $$@ ]; then						\
+		printf '  %-8s%s %s\n' "BTFIDS" " [$(TRUNNER_BINARY)]" "$$(notdir $$@)"; \
 		$(RESOLVE_BTFIDS) --btf $(TRUNNER_OUTPUT)/btf_data.bpf.o $$@;	\
-		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@)
+		$(RESOLVE_BTFIDS) --patch_btfids $$@.BTF_ids $$@;		\
+		fi)
 
 $(TRUNNER_TEST_OBJS:.o=.d): $(TRUNNER_OUTPUT)/%.test.d:			\
 			    $(TRUNNER_TESTS_DIR)/%.c			\

-- 
2.53.0

