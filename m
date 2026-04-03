Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE84F3C6A44
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 14:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775228363; cv=none; b=Hd7Ac0HgMZJeQuqBO4cLob24pCfRODqBXgaH2Z30UrnPon0uU9V8nVQfJhXkt+AdwjkLNE/yU1I7iCS+k3uGhamuC9Rcw3tPBp+Ie8oqFGnKzrth7KifogcgBLwuCwnOemzhdkic0O9bCrbBfdIZO39myN3fsrGPSJ6jZJArAxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775228363; c=relaxed/simple;
	bh=aUpES7Gc9kEPXxJ8Aaeynu09heHY8n8dzJ+eSENcNh4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GVR3ys+seUICXsxQt632dPfyKWjkduAcv1huT20UMD+wYDuEkycZ0iMHW4oGjvrSPLC1qUEgldNnLVsZj05gQ8bWv1rLOB1lnUDd6JWYOzS1seMpZ/YCHrMnwMoFSVpwXJxOJtdrADv1CVUggar5pplGy5DDoy60vT3t13w7AVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=AFYtEEG2; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="AFYtEEG2"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fd3a577eso17841945e9.1
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 07:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775228359; x=1775833159; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FH31e8AWCzEljZIdx40WqHOE1eMjOl08QVJ0UOLH5y0=;
        b=AFYtEEG2RfJGSx0VPjkQaorC/EI5ttHdUBd2HdU5Rq9+BsefoJwentJVYQgA/dlNLd
         GqWbskDcn8vz/gN40ovaGG8MWXO7XehVC5migT9/V9oOBsHeJtBEN7hjQIAwUqOH6J0L
         bx8Jlfzg58BU6YHvecteLZWpnDsgbx5baawVUVLS7ofXDM7p/VUh4TCwtaanKh+flCvp
         G2OHNMxTnuINv57jqL0X4cbg1VAVLKSG/lTamaxJEYYZ2BMpdmbtp9+8zivPD8q0J7Ie
         SI2iuLbG28zbuUwIWRvk6AXqpLILFJ1RLaTKO6hw0kmTHwDCt+L0e28LPquLJxu8qe+b
         VUHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228359; x=1775833159;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FH31e8AWCzEljZIdx40WqHOE1eMjOl08QVJ0UOLH5y0=;
        b=aSb4ALxfEJp8lbXR6LOgdItHyojweUKj0PyWyz3iLb7ZNg38JQIVzxAtFFXKpmOrqr
         905Pouh9Axw/rna24yR+9oGu7HlgzwJVCI8agDaZwjdfIoxioEq0vacNjHx1Ckn2fwFD
         eEkw4E739Nx6OeV+31dcJvr1xZKaAUSCuhonxX5z5n0K4okntomyUOTSUntVlPnNNUAg
         Qs8qkDD2Jkww0DE6JS7qzqj4TtmatI0bnEYfIRBekM2aDe1zADRy148Bl05OjlB9658E
         YyAVLn5z5ry4TvAn+6vWzX9cFCX8uqiQKQ06FHcLBbiKx8qP5YomrXSJjxZOwBnZT0PR
         GVzA==
X-Gm-Message-State: AOJu0YxF+h35GN9almxT5erXLuO8qiQhgA9gekEgy/zXCdFvxQgT42no
	pPCFb8n2+7Qip81oSM1pFZRarhHWU8oE/FmFyrNWizwTf2rwsw1h7aKgn8EyXohgdGs=
X-Gm-Gg: ATEYQzxJ57HCOWGtQoQftzcoFHOr3SDsFo7Al1ME8836tewTZSG1z7PNv53STZfxCLX
	HanqgBSk6nZkKVjb2B8s5Aw4+8DMljmO7eH/LTpS7L3QZviBrkI0bvSeEwsw/uCjAUv57cHTHXs
	vuSH8l1JhBLT1ONyym0/ZPiEgbouC61X1kHu6HvvwH7CccSeBEQ1vehhocbJu7twaf7g7HgY4Mm
	tG6xtgNT8lnoTpX8/hEYTeL9EHqiZGd03/4BV6iHbTPfDUY+iEeK158XRb8aqQXFvkqUHILPGuK
	TKFSB95MEmOJtRYuNmabGK6mvhlqWMeIKYUbHoqHuQStjAT652GOMLzDV1s2j8mUHz3oC7ltLgh
	31+FGnLlrPbP5PQBI5+XMj1ecmH/o7dBA2dfrn6EtRsxlYzHBxvFrJj3KWxw2vDpOSKiAJSS7ZS
	pL8bf3gwcD
X-Received: by 2002:a05:600d:8449:b0:487:1fbf:e0a1 with SMTP id 5b1f17b1804b1-488996a1e01mr40470055e9.4.1775228359261;
        Fri, 03 Apr 2026 07:59:19 -0700 (PDT)
Received: from localhost ([189.99.238.3])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9b8d22b4sm7057743e0c.0.2026.04.03.07.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:59:18 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Fri, 03 Apr 2026 11:58:56 -0300
Subject: [PATCH v2 03/10] selftests/bpf: Avoid rebuilds when running
 emit_tests
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260403-selftests-bpf_misconfig-v2-3-f06700380a9d@suse.com>
References: <20260403-selftests-bpf_misconfig-v2-0-f06700380a9d@suse.com>
In-Reply-To: <20260403-selftests-bpf_misconfig-v2-0-f06700380a9d@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1775228344; l=1031;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=aUpES7Gc9kEPXxJ8Aaeynu09heHY8n8dzJ+eSENcNh4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QHm0vdr2N5i6HZ4gffnwvQbcf2SfTzaga49ypwgLvh9I+uo+pRH9t5bZhXy6KgdapZF0ZhDvChf
 zV+dxXyN2Vwo=
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

