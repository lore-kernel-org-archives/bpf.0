Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EEA81531C1
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 23:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769643274; cv=none; b=rHufbAcfGE35oO4PcMlPNnjM3oYaXLi3XruiIoAprZo3AVrZgQ6ODoSpGF+Qewxrm5mztArisETDjaPIy+S4np56HRGUZ3AmzNe6d+4wmjG61O2Dz/6r42S1Bl869kPsOnTofiAkyKj65mGexurNmoP1Xxi3VoeP5hXdOZXW04o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769643274; c=relaxed/simple;
	bh=mlKwL7TBGkUvL6dUgMoz6K88R0yB1USJrBznkiFY+I4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HE6xFrjM4K7tNhWBHtyMtWPnwI0KwQYN/RjT4ZCazYwVRlRAbg44WaPSpOZaHGf08VHck8Vb5KrSbuYLF0kQNP/dafkMmxEidOPEXW04iPuZQSpNaW8ql5AZ/rNJ9BokjNCt89cySnI6KIYYBQOXTl7r+oisPHZx4tOV29D8abk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MyWfc3GZ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MyWfc3GZ"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-480142406b3so2415465e9.1
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 15:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769643272; x=1770248072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=b3XsPPPqeG4FfwyI1rslc9pOlhMBsOpjNHNlNsRN5KQ=;
        b=MyWfc3GZEDdwzGw4arBD+ZMnaBP10DNflPO58WSE7MGplPE0uO6nomJegWazN5pYQg
         4tkL6f2kMgq1Y8ZpTgszUyXRCbWCeTZMbMBsG/PbFKQHJs+Cj5BuEDplc+4nWNccFUvZ
         8gfJb9+/wN6DgUgr4RAg/SX9BwsN2gGlrGrL/pTPbAmt5RDTJR3qZmlHZ8u215Sto9ND
         K/pUwOROe9UUlL5uSJrFum80lMUKDfK10Ogy2vDrkVinQONN3Njuzg8xikVaYcEYtG3s
         FQTWJe1WgXEKM9IxiTN9LGvnKJdQOZBP9iwth22qR+o+F4vTslcvbf9j9v0Dmmkau5R+
         U8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769643272; x=1770248072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3XsPPPqeG4FfwyI1rslc9pOlhMBsOpjNHNlNsRN5KQ=;
        b=TciPVEHY20Jwa2tWjLCwK657lCVNf3f8wckbkNhqYl3ifKS0AMzlR7AKCVJ3ADHa1P
         UXSmSZ0O1rgVECft9U6D+CMOUbAEl3lVPkGIR35KfyipoXea4FFIj8FTqqhn5ohcYkGE
         E1y1zRE8uG+bS5vKjXIvpS/cO9Dhe4O37pKTZ3Cw/RGZAVpKQekAbxddM8A1MjZYmu6x
         8HB6SGR6ERFKCIMJcH93RASmqqedI444V/xQn/GvbnkbnKb5hRfJm8YOYOetFUlu++VL
         ZkwfvAJSmLElfbPzBnubXXB/fuhAkajPFQrl7vEJb2ev/TqZKro6jduzhXePWuFxiC2H
         XbSA==
X-Gm-Message-State: AOJu0YybPPgQg3Bbq+VVMuK8T0gCtW48oceVhO4migT+6Th3h/MBAiB3
	RLYkKRXnUz0vZ6SeLFHqzmiLht1nKEgjpe/FVsgWft9Z8cSEb79XQTBNpGcL7g==
X-Gm-Gg: AZuq6aK8pRlpY47SNL3pXC1L0H9HcVLsoKhp0NtQrJzPN8rffRhuUbBdInf1ByD1WlV
	8IN5okEpwbQdVTthhb4JsGXDvxZM2/bDZu8q3eplW1WYwSHbzR+11HFrh+AZWFYRwM9OtUk5kYC
	BIoYMMlCs8JdjVL5/y0KlXZztgk+oI7HhgC7e7ESpG7QE7s+cs6gnts9urc8n5dYBScNATHHhzj
	3ycDo/i2Rd9SjBHxsFHfi/AYdEmOHrLSGgfEYgey4PpXEgLsNmjNadL30CF6vs2KAv5wArsbePP
	JJaCQuZg3M2tc9dKaK3F82F20nTCxMGf/WZ9pyzRW/0ATmPNY6+ami+KNG4OnZUdCYnjZoHcemg
	Qac+5dI4VIzSj35gSdu/kiFH4pSOF6AzCjmPxRtPlv+KRFHNJsYZeGwFCxSb5oc337afyl51XJa
	MvhSaiT7K+wnIEfw==
X-Received: by 2002:a05:600c:4f0c:b0:477:9cdb:e337 with SMTP id 5b1f17b1804b1-48069bfaa18mr103564255e9.7.1769643271652;
        Wed, 28 Jan 2026 15:34:31 -0800 (PST)
Received: from localhost ([2a01:4b00:bd1f:f500:e85d:a828:282d:d5c7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-481a5d582d3sm1462305e9.7.2026.01.28.15.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 15:34:31 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	qmo@kernel.org
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v2] bpftool: Allow explicitly skip llvm dependency
Date: Wed, 28 Jan 2026 23:34:25 +0000
Message-ID: <20260128233425.374535-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

BPF selftests depend on the bpftool. In some environments we may link
bpftool to llvm dynamically and then try to run somewhere where llvm
library is not available.
It's simpler to avoid llvm linking altogether in those cases, this
change allows to do it.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/Makefile           | 12 +++++++++++-
 tools/testing/selftests/bpf/Makefile |  2 ++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 5442073a2e42..f2448e247c5d 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -97,6 +97,11 @@ RM ?= rm -f
 
 FEATURE_USER = .bpftool
 
+# Set SKIP_LLVM=1 to build bpftool without LLVM dependency. When set,
+# bpftool will fall back to libbfd for JIT disassembly (if available),
+# or build without disassembly support.
+SKIP_LLVM ?=
+
 FEATURE_TESTS := clang-bpf-co-re
 FEATURE_TESTS += llvm
 FEATURE_TESTS += libcap
@@ -150,7 +155,12 @@ all: $(OUTPUT)bpftool
 SRCS := $(wildcard *.c)
 
 ifeq ($(feature-llvm),1)
-  # If LLVM is available, use it for JIT disassembly
+ifneq ($(SKIP_LLVM),1)
+HAS_LLVM := 1
+endif
+endif
+
+ifeq ($(HAS_LLVM),1)
   CFLAGS  += -DHAVE_LLVM_SUPPORT
   LLVM_CONFIG_LIB_COMPONENTS := mcdisassembler all-targets
   # llvm-config always adds -D_GNU_SOURCE, however, it may already be in CFLAGS
diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index c6bf4dfb1495..4dfff1cfacb6 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -331,6 +331,7 @@ $(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)    \
 		    OUTPUT=$(HOST_BUILD_DIR)/bpftool/			       \
 		    LIBBPF_OUTPUT=$(HOST_BUILD_DIR)/libbpf/		       \
 		    LIBBPF_DESTDIR=$(HOST_SCRATCH_DIR)/			       \
+		    SKIP_LLVM=$(SKIP_LLVM)				       \
 		    prefix= DESTDIR=$(HOST_SCRATCH_DIR)/ install-bin
 
 ifneq ($(CROSS_COMPILE),)
@@ -343,6 +344,7 @@ $(CROSS_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile)	\
 		    OUTPUT=$(BUILD_DIR)/bpftool/				\
 		    LIBBPF_OUTPUT=$(BUILD_DIR)/libbpf/				\
 		    LIBBPF_DESTDIR=$(SCRATCH_DIR)/				\
+		    SKIP_LLVM=$(SKIP_LLVM)					\
 		    prefix= DESTDIR=$(SCRATCH_DIR)/ install-bin
 endif
 
-- 
2.52.0

