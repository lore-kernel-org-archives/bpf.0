Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDFF34F483
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780982294; cv=none; b=QsYdmy8sopIeIJemchFPIPXkCZrl9CTf1QrEqn11Iwr19dppJ6nUnucAXzErdgkGIqi3ksfSqjGzP3Bz+FCryiaCE7u1qOHWAqueGkS9LBeImnzJDj8r/ANtj/mwP9XzDxOt4oCSIR3ecOrEK0/jjEkg2I/sK2IUcmmIMEVoEVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780982294; c=relaxed/simple;
	bh=NKmS4ymSwfQxEWIzJPKOkiYUhGinMxmelF5ZgEfuqp4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Content-Type; b=fLWin84yAnxdbzAOcf8WRdvLA1VbG7mJtvrV5yRE+Beyzs2sfax9SKoHmCEqAqCUksBIvKTXHldPmh3Rf0jGCfexNfJpxGlJEhUMDPsHcC5Aq/mGbdSWuX/MrQSmMcltJagzPWNCB9KhY4sX3tjrppz5IW0eLfjJxvWfpD+gPww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gwJBb1jw; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gwJBb1jw"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13709ab38a8so6120255c88.0
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 22:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780982292; x=1781587092; darn=vger.kernel.org;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bUtXIOfKKY0YQV5gh85yfIsJQMQSXMy9or8FO6Z2WOk=;
        b=gwJBb1jwHQNKxDFU37ZEPUJ+xW2pYKBIkUQPWrAnLdFLaLGl43iyiQ9Hv4oG8Kmt2q
         /0UWqr4L/FH3elBqExgb9E76alxhwITRmLbFGygViEMuatKXbWERr1YbElEkW0YE1Inp
         avFhYPyB193/kxqNQUqQX403oGVqSXmD3GLrWkmZcpZe1fRRSPrD/G5GzLOXAfi43joM
         PXwEPP21VdjvyMmFkTu9gb17Y4OD8MNIz6mrVn7SQdvX+DwBO3Rkm87XP6YRBZxRvPdP
         9HNcHt+moXx/s4Vgkm6o3W7iXE7YnYk4LexehbVV/OLu1sW9tHRuaWVUF6Ryd5Zh1c/s
         ouZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780982292; x=1781587092;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bUtXIOfKKY0YQV5gh85yfIsJQMQSXMy9or8FO6Z2WOk=;
        b=LzZdSnD+rBvzoOc35mkOYMciHrhmvmbamAboMHAVikC12eLSZZMZwv0b/vsHnA1M62
         RDxekYdheM5Dg0i81Irma2g/WTy4YWIwhsJ4/yWVGGyq7ht+heZKYGs+GU7v0hsSTYBL
         o2N51H3fm1LMu3DH+RpoSa0Uy8Cm9EOD6mefWn853Nd0o8vhatAtz7XE9GHmYAcwCxOm
         ccBK6HTeBsYsfr1eQEVHOeD2e/kXQJMW7lCwaEoMEvtK0N/08zk4qKO6JaxYCUlEB3wU
         glG3Dig23EReu+jCrqF0V2+TtFDQU/HcaHD8xWwOy5DYQTqj1t1qhE0dNbFsbnsd3AgS
         k6wQ==
X-Forwarded-Encrypted: i=1; AFNElJ8a6NPSkK1G8sopzbFIcloe02Ri7QE5dGhYATvt/Ma2aZQTGeXRehxfRJszpLjMheSC8bk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjuFej6wt2aY5sm85S8m2I9hTj8PZfoghlKzYTVPnNYzAHs5+K
	AMpDNqIvRGjFvY8RJQmtbNvXnlzcMwMOe0MEW+j9D8NO3FvYZB+qcesGzGyVaedmdt1wD0E+cRI
	x8urmzUEkUg==
X-Received: from dlec14-n2.prod.google.com ([2002:a05:701b:428e:20b0:136:23d8:d537])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:4a7:b0:136:5631:bfed
 with SMTP id a92af1059eb24-138066fd564mr9176894c88.20.1780982291305; Mon, 08
 Jun 2026 22:18:11 -0700 (PDT)
Date: Mon,  8 Jun 2026 22:17:53 -0700
In-Reply-To: <20260609051759.405027-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260609051759.405027-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.1064.gd145956f57-goog
Message-ID: <20260609051759.405027-2-irogers@google.com>
Subject: [PATCH v1 1/7] tools build: Add feature check for elfutils libasm
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Nick Terrell <terrelln@fb.com>, 
	David Sterba <dsterba@suse.com>, Nathan Chancellor <nathan@kernel.org>, Tomas Glozar <tglozar@redhat.com>, 
	Blake Jones <blakejones@google.com>, Dmitrii Dolgov <9erthalion6@gmail.com>, 
	Alexandre Chartre <alexandre.chartre@oracle.com>, Costa Shulyupin <costa.shul@redhat.com>, 
	Yuzhuo Jing <yuzhuo@google.com>, Michael Jeanson <mjeanson@efficios.com>, Leo Yan <leo.yan@arm.com>, 
	Tianyou Li <tianyou.li@intel.com>, Zecheng Li <zecheng@google.com>, 
	Rong Bao <rong.bao@csmantle.top>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce the build-time feature check for elfutils libasm library
in the shared tools/build system.

Assisted-by: Antigravity:Google Gemini 3.5-flash
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature      |  2 ++
 tools/build/feature/Makefile      |  9 +++++++++
 tools/build/feature/test-libasm.c | 19 +++++++++++++++++++
 3 files changed, 30 insertions(+)
 create mode 100644 tools/build/feature/test-libasm.c

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index ed1374af31c1..422329dbc20a 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -118,6 +118,7 @@ FEATURE_TESTS_EXTRA :=                  \
          hello                          \
          babeltrace2-ctf-writer         \
          libcapstone                    \
+         libasm                         \
          libcheck                       \
          libbfd-liberty                 \
          libbfd-liberty-z               \
@@ -150,6 +151,7 @@ FEATURE_DISPLAY ?=              \
          numa_num_possible_cpus \
          libpython              \
          libcapstone            \
+         libasm                 \
          llvm-perf              \
          zlib                   \
          lzma                   \
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 62909a9c799d..f0f39a2ab203 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -47,6 +47,7 @@ FILES=                                          \
          test-timerfd.bin                       \
          test-babeltrace2-ctf-writer.bin        \
          test-libcapstone.bin			\
+         test-libasm.bin			\
          test-libcheck.bin			\
          test-compile-32.bin                    \
          test-compile-x32.bin                   \
@@ -184,6 +185,11 @@ ifeq ($(findstring -static,${LDFLAGS}),-static)
   DWARFLIBS += -ldl
 endif
 
+ASMLIBS := -lasm -ldw -lelf
+ifeq ($(findstring -static,${LDFLAGS}),-static)
+  ASMLIBS += -lz -llzma -lbz2 -lzstd
+endif
+
 $(OUTPUT)test-libdw.bin:
 	$(BUILD) $(DWLIBS)
 
@@ -311,6 +317,9 @@ $(OUTPUT)test-babeltrace2-ctf-writer.bin:
 $(OUTPUT)test-libcapstone.bin:
 	$(BUILD) # -lcapstone provided by $(FEATURE_CHECK_LDFLAGS-libcapstone)
 
+$(OUTPUT)test-libasm.bin:
+	$(BUILD) $(ASMLIBS)
+
 $(OUTPUT)test-libcheck.bin:
 	$(BUILD) # -lcheck is provided by $(FEATURE_CHECK_LDFLAGS-libcheck)
 
diff --git a/tools/build/feature/test-libasm.c b/tools/build/feature/test-libasm.c
new file mode 100644
index 000000000000..f3598ad1cc9e
--- /dev/null
+++ b/tools/build/feature/test-libasm.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <stddef.h>
+#include <elfutils/libasm.h>
+#include <gelf.h>
+
+typedef struct ebl Ebl;
+extern Ebl *ebl_openbackend (Elf *elf);
+extern void ebl_closebackend (Ebl *ebl);
+
+int main(void)
+{
+	Elf *elf = elf_begin(0, ELF_C_READ, NULL);
+	Ebl *ebl = ebl_openbackend(elf);
+	DisasmCtx_t *ctx = disasm_begin(ebl, elf, NULL);
+	disasm_end(ctx);
+	ebl_closebackend(ebl);
+	elf_end(elf);
+	return 0;
+}
-- 
2.54.0.1064.gd145956f57-goog

