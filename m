Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F207C3A382D
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 23:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777419967; cv=none; b=dk9dfxo2zHcbfB3mN9konYdmXpkrPz5sKhmG4CsQFnn8TP9+COOXo/wG9Wg+81l6yioT1LV5S9DmEJkyOdzZILc/plmheG7kXjJWhEoio2XhZpljoHAWvnB2TTPH4ELpTtkikm7F42chVFCULTeb9Ixj5MwNWXJM6DSwDVGt7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777419967; c=relaxed/simple;
	bh=/izrmfoNTErOF0QoJyqRR2oNNCmtADhmsCqLhuVNNYw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OkszPuzi/LIWTGUzP9W1TKZeDh51omrWJ6Xs3DPm9z4g0hpG3fYVyEOS8EZ6IoZEhaAHmm+MAQCWQGO5TxfL1Gdd4FxYdcZLHUav7Y3uqGZKCwpgKwo6NV9SErLsXx83pwf9tIJfiSO4n1gOUCwIMSbubs8Q2j2Cvk5lAQCE434=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=gdMO4g1h; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="gdMO4g1h"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso123493015e9.1
        for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 16:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777419964; x=1778024764; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hR7c8YMvP9LQvNeuTjxfIeyv3ZVfJWeQnEPeA75OGwc=;
        b=gdMO4g1hpgqkCryRhK89nOLyjNiabDxgNL9B33laTn32NgmNk+kMEQyKuwBWnectOA
         bZjF+ncZSv0/S4PmSt/cSjBC4ZRSNzPR0KGmGRaBghmwDayWkZyMkAKGFjaXLj6Wsi2a
         WTJjOI7xZimimQg26ChNBlPmN4nRJ8D1WqVwg6LJasVrEdiEd29KDtrwf7wvyD0Vy9Yd
         jgyOW3Co4weu8vpnp9GuC5fmjTtnDfCYZfEU9iAuvqUY9FTrZ/ZPzdzpTzp+oVrN20gt
         jXbxGBGDebB47qy02jP/mIz9uhr5RAJZvv5AX5iwJAoGSYN9cYCitN0tRp8F0796C1Hh
         T+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777419964; x=1778024764;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hR7c8YMvP9LQvNeuTjxfIeyv3ZVfJWeQnEPeA75OGwc=;
        b=oJqo5p3YWlB/Mw1OTstkJJpQ8Gl98dLINkixd1L1yynHHmQuqepY/vFVmmGXO3FjIo
         ZZFrRvQnN80WaAegEUdiyGkXWb8bH7j82+DrGXx034LnNZfFUqN9IlOVDiRK65me3CG6
         nWl3e/EhCeqnswZDMLlPtzZjTYibL+4m3bcVjUHp9Q1J5eA8dm4oTU2p77unq11yrNns
         +qrmfaBM92BQSVphLDryCyl6zPlAQOdjef35cbOvMLYX9ac2T+IvzaWzI0cdAmqWoE3h
         yWh/AiGwNNhVwga7lju6UnJ5EYNBKHNIoC7HVkVslBPGswOw8SOtODLGjRt/4YdurB7W
         jCxA==
X-Gm-Message-State: AOJu0YzzSSRA2pUVRXogbsGZWdYXHqUQxrJwobqiouUUc1vgC183Ufpu
	C8GoTnjlP4U3NWSIQdaJb5J+ssjTkrjjaUPJKV7IGYI+DObD6OItjlhEWR+bz/bMw7g=
X-Gm-Gg: AeBDievgiQcuqmCpwXamqb+qKcaqjGE1AoRQpqCICu9xIfw0GbrQQSD0taZM1UeHEWb
	Uw6LW7UDC/FyMG63B4WuDVejOL0uz1q8JOBX6dllOSVT0dV5D2hm9AI6ejBMRfiiHV+lRz7ZJkF
	xxALM+hxP+O+0WtC74DjlpbuDX7J9tDrzUorH+e7wzClSdmrHJeLpEFG/6b6i//OWfGpenSJkDR
	ZnBSMKKIdcy1x5uOnYg9pbHF+8KtMAV4MvjpkVl/zvFyfqcn7wvzjxr/h1RNdy/k2pGa3uAei+k
	fDFZ0wWaWkgRggWrLhYuQBHYwVNQ13n+QNRxM1xKNHJVDjP3g2jHjGTw09ZZ34Vi2pB0IBZ2frW
	oQHkgrTGOcGPv/2/KAVfe2W00Q6Hi59rCmXk4oBx9LQuebKQkuh2SPdFtQN9GyLYI4MRFuh4otm
	ZOoaQWl9PFfjVLKhq07FCSKXIT
X-Received: by 2002:a05:600c:4e91:b0:471:700:f281 with SMTP id 5b1f17b1804b1-48a7b54b1c7mr24789895e9.25.1777419964535;
        Tue, 28 Apr 2026 16:46:04 -0700 (PDT)
Received: from localhost ([2804:7f0:b765:105d:ce28:aaff:fe86:149c])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-573b6953946sm271414e0c.0.2026.04.28.16.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 16:46:02 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Tue, 28 Apr 2026 20:45:12 -0300
Subject: [PATCH bpf-next v8 11/11] selftests/bpf: Tolerate missing files
 during install
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260428-selftests-bpf_misconfig-v8-11-bf02cf97dbcb@suse.com>
References: <20260428-selftests-bpf_misconfig-v8-0-bf02cf97dbcb@suse.com>
In-Reply-To: <20260428-selftests-bpf_misconfig-v8-0-bf02cf97dbcb@suse.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1777419912; l=2156;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=/izrmfoNTErOF0QoJyqRR2oNNCmtADhmsCqLhuVNNYw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBbgjXwVu2unS8JglD6UCKZJvCJEJAlmSjrzgmiYPCBRyG9YG5E/X2CY352VvtcvIUf+weYBF79
 DIYd08L56eQk=
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
index 461e2d9416fc..3c3234a2ce15 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -1017,12 +1017,23 @@ EXTRA_CLEAN := $(SCRATCH_DIR) $(HOST_SCRATCH_DIR)			\
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

