Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CD037AA7A
	for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 14:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777473285; cv=none; b=mMQ+E+Q+KIr428bwh2lJq1+Wh8dBf/Xo0oOLarnUBjrRddV6pU1xHkDfb2RR36C9z2VYJuA8AUcJfAy4B7ux4/UvV3k/wl7m4ndneEg4XKJCFQtSm4ZyLKLHSgOZ+hUo02jei0I0paDyMuPwmBgZcovgo+fnxlM7/HKBkatpv1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777473285; c=relaxed/simple;
	bh=QlnphXbIZwkpSF4vwnCRoGf/LwYmdqzZuMpKhZCGNVo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F/uj+M4jlIFx0VgbXdzkI/kEdeVu4yVIzuBnKKeUUFdYKkCcXDg81YRihXkRCycQNJZhChyJxNApVcsxCHkjW6/jWWOaGZG07RKyf89XtIcmvwRlnWl9GCuAyUxMhDXXyu000TDubmmsX8AuWbwQl1WFQDluejFUwci7wWh02EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ClcSAlIK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ClcSAlIK"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso9723395e9.1
        for <bpf@vger.kernel.org>; Wed, 29 Apr 2026 07:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777473282; x=1778078082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3pA8Vhc9DANl97GkJYN+mTuDBA8W99vr/NFCFT5xJ6I=;
        b=ClcSAlIKLzRAo/E2uYKp2V05eXi4aIku8Da3n6jsmoHLG6XiN97weVDgVOAJ0HCyBW
         hlKhjKXIMWi1MPLEbExUcgR5ALzEPpzzyL6pUAXhRpepFAah4pIWCVvHdyHbbWI141oQ
         RyJQQwV4Ia4rchZCnckhSeXvNQ42ZSl0LxkZuATjqw2EiNrYcuTSCw99Oe8OWN0RG2Vb
         b6PS7/Zo3F+AeUoRq3DoKFDxjrmxKBRigRWbiscuqg8lNjdnPPb0yxGFewDHwtbdiMgi
         N8BZVZPDqKEWYOZzNwRVK9bGWux9CeadGz5MFrAEziu4x1p9yhQU90jPj+73l54GhD85
         FzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777473282; x=1778078082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3pA8Vhc9DANl97GkJYN+mTuDBA8W99vr/NFCFT5xJ6I=;
        b=dtcxXnaZnnYpi59y+jHhb8l9w0Ai+mXqSPQ/5ACMoP9ECz9NYHhbCMH8bCUhCHgdI6
         LQP2c7Envd9NuFxTWFqTLfeajIpa/eHQFsZL9vrZWA1r0UndxMjuHLmmhcReSSXl/hpb
         g6eGA9BtZe9Pftk9cOxYo/Ui3fsROKukbDFNuurglVByK4sn/fKOs+IL12nY52ljRGuA
         5ZWgUcuwki1qXzzBd4SgmI5JHwTi3Wccwgrb6xt39zCBDMU5Wbaz9YCNcmG7VqiN+gnn
         7m++GKd6Z8e1dUNHnrnw3TA1XwjqJbmMW1PlWx2tzbP59dRaCksBe9mkhDUPZMduDonc
         Z+Yg==
X-Gm-Message-State: AOJu0YxGoekGGBuvUcZFOtwKbAIQVxro5AYdtq49ncOLeNOpxo9uo+yY
	f4/jJCwLDKEDq0lmV4hM/GglCjwg7JcbNHKbCtip8ft2N2qvfkAMiuczCn2+Ga8bL8d0Ha9yMN9
	6Tvv3P0g=
X-Gm-Gg: AeBDieseVwJ35B5oE6M5HkmHjuWQEae2zBc4vIc3T2cEKPDwtpGZ8f6bPsEAyewmayf
	xine0Gokeb0cuQ0gFPEpRdrD5kv1zBzLw5LdfzyZ9sfEldNxFCGPmVD2PiQSj05xASgE9S8GLW2
	Yw8vLlzp6YAjWeYpLOekSEBk+KkSuR+mdWoOiu0PIQ/uCrvs+dBZo4Sg/07deZD7szg9GDcduyq
	ddirScC+NGY2c6tg3w5RnKrKk/KaSB8lf5jkkWDueJ+97zqKEOkTVvHdEuR0JaVzCMXjYT+vYuF
	3mwhpdd5+glA2FJx17EcJWs8gzHQZw3hCqabPhMNDKabljBeWBq6BI/sPvlwLK8bUk9NlPmT8Ja
	Umh9dGt3Kq0u/+7wlvJjPwcdqiMMKeEA6xE5VLcFK61eGksjIBCObsfOx6XUZdokXGd5XbSUAdX
	Oav6K2Y25tY2sqIpTdkg/Qf0/G2l24jedEzj4=
X-Received: by 2002:a05:600c:29a:b0:486:fcc7:6811 with SMTP id 5b1f17b1804b1-48a7c81f998mr32567305e9.10.1777473282131;
        Wed, 29 Apr 2026 07:34:42 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-62982135e26sm1155487137.3.2026.04.29.07.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2026 07:34:41 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 29 Apr 2026 11:33:53 -0300
Subject: [PATCH bpf-next v9 11/11] selftests/bpf: Tolerate missing files
 during install
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260429-selftests-bpf_misconfig-v9-11-c311f06b4791@suse.com>
References: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
In-Reply-To: <20260429-selftests-bpf_misconfig-v9-0-c311f06b4791@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777473237; l=2156;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=QlnphXbIZwkpSF4vwnCRoGf/LwYmdqzZuMpKhZCGNVo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QLX4yiW64I6RKHzS/sib+IHUvxGgX3Dyy9/zjZ0Sn3ohSM5MHnNmurZMfXtcOsbXtk6ntUEtcGs
 inByZDTwzLwg=
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
index db4ff951fc88..2822f09c37eb 100644
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

