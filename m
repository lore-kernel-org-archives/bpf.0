Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5323CDBD3
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 22:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783721394; cv=none; b=J2SfUfROCnDmnotwasLzq7+7wHCQHfLnP5Wyg7MayxEW9AHyH6S6Zg0U+XjKt6kg0LwcnFL06QQzLixzMZ6Mvf7du6B+1CSDnDsKuNTgODd6egjFsbu5/IPdmPgvq4v8NSfSojGeutMw66EbJRfqoGQKXCi5UC/WloQslwqOVnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783721394; c=relaxed/simple;
	bh=tSHM1fzZWml4hvRBo/K/fmUgOSujPMBP5FnsdjUmod4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QhuDTzcaQmy9J+I8bxfkHpX4mBmxoVRD+Xfonz+1ek7V6ucivfZgZ6+k/u6JsNl/PYaD1SIMd4L0w/1qJCx1ALwNDwzc1O/eiApnxJwMDgpXldG4skjZW253alhpWs1PKfwxfh5WVAuBhBA4RrDZI4p9zP6f6tYKNg1NwgZSmfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=QYSACreO; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="QYSACreO"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-493f431e317so10162125e9.0
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 15:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1783721391; x=1784326191; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OHCLKtsZSxT1o9uaoKtg6P7nReL02p8WrHLQzFP0vic=;
        b=QYSACreOjnryApI/z1xuKsg4cjOj+uM1Shu9/37ugbVn/7f2Dmpa+oNYvVurPfExfI
         45h3yZKYr5/ScztEr4b1Hy7R4uwOIS5qjlQMhKitIed1KIag6zgJ6H+XfS6ViQDXrE7t
         jvg8bH9XI6SeM6VBtnJAQs+j8B3BAj3hJgVyBedpae/2hS+AtH99pLR/NvsMrbBTrPNs
         lNk/10ejKLEYaLLcXTke7hEE5ZTVBg8eygrzzG8KnK23XFkvuoo20VddcyMnAP6vTtDm
         wF5SGb2VBfCXcIjqQZVF0konIec6IwZ1ecq05CuVh5e9PUXryheLLUGtZNCclH624ueW
         kThg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783721391; x=1784326191;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OHCLKtsZSxT1o9uaoKtg6P7nReL02p8WrHLQzFP0vic=;
        b=AfHgwm1Y+2Ly5u+AbUh1rbhHG65DSMcEN4MO0J6W0E93PE6e2ckCXaK23HbSRF1Cqq
         9hBSZ87BWR/GOE23Vt2BOYzM+8cGlIcuk6GVAnzols6TRGLhcAfDaQ9nVAQi43Z+KXT/
         91xs0X/p9i6iYFZ0FNcJ5LwQjyHBFFTs4nhQVtzSjlHxjHktD1FJjc6Z5YX3rhiDPI/6
         QmDXjtQfGnQEdxukRrccmVO+wzc43Izxdg92Guv/xZAftkojrrTSB1tD8Maq0DnOb0lw
         FJuhbl0vapym4EvuUdo7WppQSpMCs2arIRg6Rz9hKZWfB25P9KGsI9U+PFkhsxXs80SI
         v63A==
X-Gm-Message-State: AOJu0YzlSrfh6+nu/2JyHYmwscp2R5gKyRfl3yUeHcB4hgn9ZQ4//QY7
	ZkoPtuPLfekY83hUoqfEaEarST0R6Tv6B/nw01L515ArcVDTJrwt72ShmcOPrPRT99M=
X-Gm-Gg: AfdE7cn2aQBSa2TA5xnMfPOabc2mQh6w0XmVTqXAAGNxitdmYWNb2ga4QDjN/RFIcWH
	3hzNsN9Y4NiLujTTVFRQlgwL65sVCEjDTJ+n9mSNgoy0XN9lJYzqg4s1wWqdjT/tABQfGZBjOQ8
	VIlJy6fxAJ9RKnrzift6mECqAlkFU809j5jUHiPo7xvS5hWvM9xt9Yl7sGMn0G89wFisW1Qd3JM
	NFc2whIiGhJBs1tH9rSQGggD8HcKM5jvb9Jzczi5B/CMPFeXkEzAymnuwGkG1RPHRWorO/ML6kx
	gGGbCVEp3WdWMBdFdlSaKL+D8Pq579ROHDX2g6pCxDZVK9WAw20NIqxhZCVwSUdWGgFjNNUXpbE
	FnjrM+ZIKQdoB5jjK84ZYpQqfM50oE6Dm5S8woU4qvlrkG8271MK3Z8NjlQY26l1QuUM6wsC412
	ru9g==
X-Received: by 2002:a05:600c:4f8a:b0:493:bcef:565c with SMTP id 5b1f17b1804b1-493f87d5865mr4926455e9.1.1783721390847;
        Fri, 10 Jul 2026 15:09:50 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:157e:cc5f:6c4b:db0a:5d2a])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be8f5f0sm58832827b3.8.2026.07.10.15.09.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:09:50 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Fri, 10 Jul 2026 19:09:37 -0300
Subject: [PATCH 1/4] selftests/bpf: Install bpftool where test_progs
 expects to find it
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260710-selftests-bpf_fixes-v1-1-aa24dfd6f4f9@suse.com>
References: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
In-Reply-To: <20260710-selftests-bpf_fixes-v1-0-aa24dfd6f4f9@suse.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
 =?utf-8?q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?= <alexis.lothore@bootlin.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 Christian Brauner <brauner@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1783721384; l=1735;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=tSHM1fzZWml4hvRBo/K/fmUgOSujPMBP5FnsdjUmod4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJyOqeLJBjpflp5bJXcvLzRN2kz5zwZzn7BkwweDH03IvpDn7aETUYjdijCtI+lF/gZRkvY9SQM
 oTFw126pofgU=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

bpftool_helpers.c looks for bpftool at "tools/sbin/bpftool" or
"../tools/sbin/bpftool" relative to the running test_progs binary, matching
the build directory layout where bpftool sits at
$(OUTPUT)/tools/sbin/bpftool.

INSTALL_RULE installs bpftool through the generic TEST_GEN_PROGS_EXTENDED
mechanism, which flattens it straight into $(INSTALL_PATH) and loses the
tools/sbin/ prefix. After "make install", every flavor of test_progs,
including the default one, fails to locate bpftool, and bpftool_maps_access
and bpftool_metadata error out with "Failed to detect bpftool path", even
though bpftool itself built and installed fine.

Explicitly install bpftool under tools/sbin/ in the installed tree
so its relative location matches what detect_bpftool_path() already
expects, restoring the pre-install layout instead of introducing a
new one.

Fixes: f21fae577446 ("selftests/bpf: Add a few helpers for bpftool testing")
Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index b642ee489ea6..47911c9b4977 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -1055,6 +1055,8 @@ endif
 DEFAULT_INSTALL_RULE := $(INSTALL_RULE)
 override define INSTALL_RULE
 	$(DEFAULT_INSTALL_RULE)
+	@mkdir -p $(INSTALL_PATH)/tools/sbin
+	@rsync -a $(if $(PERMISSIVE),--ignore-missing-args) $(TRUNNER_BPFTOOL) $(INSTALL_PATH)/tools/sbin/
 	@for DIR in $(TEST_INST_SUBDIRS); do				  \
 		mkdir -p $(INSTALL_PATH)/$$DIR;				  \
 		rsync -a $(if $(PERMISSIVE),--ignore-missing-args)	  \

-- 
2.54.0

