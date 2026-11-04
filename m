Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.200
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793766622;
	b=VwLmQ0bu48AZXd4kUPDTc87XQ8DYaDfhXlZN/7/ofdgyANSh0FmkKp7WRfP/DrsJOfRa
	 9aqH6+SUmSqnVg8etjKYieOQDAZyuYbdbgElUO17Lbfwl5yE6ypyNL7kzP2z3Gk3qlvsj
	 D2NL9HZ6SgsjTWf/A5++Cy7ibGSy73zQLDVuhBUf7DjY29LE9Zh6nIx2dwa+UgwG+7NpZ
	 CC2EqHt7qz1o6VI4xeuzjtRBoENU4KhxYbvseFmF/Cz3Rj9UmF6H1kCWhlKYSmDv8wQlt
	 kajflf03Cm3gYtaSgQEroDShyK7vVFNkupdQsyMD/EBWq2XwwLaNGc0b8mheuLVwMJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793766622;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=M5ouklrHE4cf5TDEAMF9SCkJTPVvWGYITZBVBfks0c0=;
	b=3htGN35L0BKJBUzpY8Pw+nKG+o62yHBHiylS72Qsjr6OgY9GAJfRbAj22sjuGFdPxmjH
	 7OHEyu+mCnGmDDPfCAbTs1i4KMWPNoYW9lyJ/wGtHa4ZYB1v1Jlz3iAk9u2oZFCc6ux2a
	 GN4xdZWCyD1Zd21ANVtzR+okWGvDIMqd3lHp+cpVYOWaN1VOMxvZyaMmwbq0WhRGO6kk3
	 f3Ik9rm0TsPwJ447rvHNSgUEwy5SEtEZ3IgQ5T7kVHp/OxmaGX+mqbHsBMBfQ2Ijyzuxd
	 5r/DTZwanOBy1Tx43blIaIbQ9DjTnfYvFB1bJ/9opgLydi3hXG9bTk9Krc47ptz8ezQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--irogers.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=czilwe2O;
	arc=none smtp.remote-ip=74.125.82.200
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0617606A331
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 04:30:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0617606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=czilwe2O
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-36a3451ea93so410996eec.1
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 20:30:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793766621; x=1794371421; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M5ouklrHE4cf5TDEAMF9SCkJTPVvWGYITZBVBfks0c0=;
        b=czilwe2Odw0EpbtqJ70KyBch5voX2iTsy+BMWaReFKuQgizgGG2bviH9enO9I6b9/f
         GFFUc654HhEkI8r5+LZ32DmnV3OrFgZxzKeQB1weYfmjEY8Z+ZkozCC/ZkvCGt9zrILY
         R8W+R8hwz8YA0xw/7OZObDs72UQi/Q3Ieh8fU30l9+LNJACXudz7pHXSybvBubMt/uGd
         1qbge9uLm72l0xRzhvu0pNVhPzxyYbpx7oh1zE4rp+eYXupVJUuOFagrR4Ny+fWe1vRV
         x9ZZ2tEsaGHhCVmIus/G+mUxIL/vpx56/usCbwK8XenwjAmgInYWStRHgBh89T2T5Qs4
         PoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793766621; x=1794371421;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=M5ouklrHE4cf5TDEAMF9SCkJTPVvWGYITZBVBfks0c0=;
        b=k3ctwhKksLJ4YfyA1T1imaYWBikwNggh0sp7HZBCaI0g/N4Ubyj2mc5r8u0k23D7OE
         iluoHSWkolK6MQ+02LE4862K5K+1axMAU0splvUttzSXHAaJipSTw4X3x/xxdEGpu972
         AMpHaR68vBY1gcRpqaEB/VumEIBHh+d3uXyV9ZtvkIJqYwzvBu0EHSaVmiNL3fEvFTt0
         XhNin1HVFc3b0o743B/yohtbUsZv60AuBnhJ2knPsKeg+xlF/0/tVra0vftRWAoM4mdt
         PYXmuAi2RMZDTbOFL4sLbtE0fVi1sGQjqUqzEwngRBJOdtbdh5voGk3zl6HIc9adjbfN
         5SHw==
X-Forwarded-Encrypted: i=1; AKwUvBxwVWizJ6NFaYksMgd8Dkq0aP0ms0uEgczOO87POYuBO5LstFhbjbBrPjs2Yq/SurzAJME=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3Nx803fnAEPmWZp/9v8S3NN/DuARIUykebDh3jHv0Ee4SgxHb
	3npT14cgXq4jIwoKGuw1FQqZ+PBTRlLd8NIOvFHd6KmsuTFTbpTxE1E9NSSDb/hQkQrrTm/1oKL
	6CTMwBUZW0Q==
X-Received: from dlbsi11.prod.google.com ([2002:a05:7022:b88b:b0:1b1:f02b:2321])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ea57:b0:196:c1ca:3489
 with SMTP id a92af1059eb24-1ac50799c22mr20080907c88.0.1793766620259; Tue, 03
 Nov 2026 20:30:20 -0800 (PST)
Date: Tue,  3 Nov 2026 20:30:03 -0800
In-Reply-To: <20261104043006.1199857-1-irogers@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261104043006.1199857-1-irogers@google.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
Message-ID: <20261104043006.1199857-2-irogers@google.com>
Subject: [PATCH v3 1/4] tools build: Add explicitly sequenced -lzstd to libbfd
 feature fallback
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	Quentin Monnet <qmo@kernel.org>, Josh Poimboeuf <jpoimboe@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, James Clark <james.clark@linaro.org>, 
	Leo Yan <leo.yan@arm.com>, linux-perf-users@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Distributions like Fedora ship a statically compiled binutils libbfd
that depends on zstd (along with libiberty and zlib) to decompress
sections (e.g. undefined reference to 'ZSTD_decompress').

Commit 89d001d48ec7 ("tools build: Add zstd to the binutils library
feature tests") added '|| $(BUILD_BFD) -lzstd' directly to
test-libbfd.bin, test-libbfd-threadsafe.bin, and
test-disassembler-four-args.bin. However, static libbfd requires
'-liberty -lz -lzstd' together, and setting feature-libbfd=1 when extra
libraries are needed causes callers (perf, bpftool) to link only '-lbfd
-lopcodes' without '-lzstd'.

Restore test-libbfd.bin to test only $(BUILD_BFD), add the
test-libbfd-liberty-z-zstd.bin feature test and
FEATURE_GROUP_MEMBERS-libbfd entry, and append the '-liberty -lz -lzstd'
fallback to test-libbfd-threadsafe.bin, test-disassembler-four-args.bin,
and test-disassembler-init-styled.bin.

Fixes: 89d001d48ec7 ("tools build: Add zstd to the binutils library feature tests")
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/Makefile.feature |  3 ++-
 tools/build/feature/Makefile | 19 +++++++++++++------
 2 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/tools/build/Makefile.feature b/tools/build/Makefile.feature
index 4d37d11f674c..c010049d9720 100644
--- a/tools/build/Makefile.feature
+++ b/tools/build/Makefile.feature
@@ -121,6 +121,7 @@ FEATURE_TESTS_EXTRA :=                  \
          libcheck                       \
          libbfd-liberty                 \
          libbfd-liberty-z               \
+         libbfd-liberty-z-zstd          \
          libopencsd                     \
          llvm                           \
          libbpf                         \
@@ -160,7 +161,7 @@ FEATURE_DISPLAY ?=              \
 # Declare group members of a feature to display the logical OR of the detection
 # result instead of each member result.
 #
-FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z
+FEATURE_GROUP_MEMBERS-libbfd = libbfd-liberty libbfd-liberty-z libbfd-liberty-z-zstd
 
 #
 # Declare list of feature dependency packages that provide pkg-config files.
diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 10340a537224..359da8b98bc5 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -20,6 +20,7 @@ FILES=                                          \
          test-reallocarray.bin			\
          test-libbfd-liberty.bin                \
          test-libbfd-liberty-z.bin              \
+         test-libbfd-liberty-z-zstd.bin         \
          test-cplus-demangle.bin                \
          test-cxa-demangle.bin                  \
          test-libcap.bin			\
@@ -249,18 +250,21 @@ $(OUTPUT)test-python-module.bin:
 	$(BUILD) $(FLAGS_PYTHON_EMBED)
 
 $(OUTPUT)test-libbfd.bin:
-	$(BUILD_BFD) || $(BUILD_BFD) -lzstd
+	$(BUILD_BFD)
 
 $(OUTPUT)test-libbfd-threadsafe.bin:
-	$(BUILD_BFD) || $(BUILD_BFD) -lzstd || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz
+	$(BUILD_BFD) || $(BUILD_BFD) -liberty || $(BUILD_BFD) -liberty -lz || \
+	$(BUILD_BFD) -liberty -lz -lzstd
 
 $(OUTPUT)test-disassembler-four-args.bin:
-	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -lzstd || $(BUILD_BFD) -lopcodes -liberty || \
-	$(BUILD_BFD) -lopcodes -liberty -lz
+	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -liberty || \
+	$(BUILD_BFD) -lopcodes -liberty -lz || \
+	$(BUILD_BFD) -lopcodes -liberty -lz -lzstd
 
 $(OUTPUT)test-disassembler-init-styled.bin:
-	$(BUILD_BFD) -lopcodes ||  $(BUILD_BFD) -lopcodes -liberty || \
-	$(BUILD_BFD) -lopcodes -liberty -lz
+	$(BUILD_BFD) -lopcodes || $(BUILD_BFD) -lopcodes -liberty || \
+	$(BUILD_BFD) -lopcodes -liberty -lz || \
+	$(BUILD_BFD) -lopcodes -liberty -lz -lzstd
 
 $(OUTPUT)test-reallocarray.bin:
 	$(BUILD)
@@ -271,6 +275,9 @@ $(OUTPUT)test-libbfd-liberty.bin:
 $(OUTPUT)test-libbfd-liberty-z.bin:
 	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz
 
+$(OUTPUT)test-libbfd-liberty-z-zstd.bin:
+	$(CC) $(CFLAGS) -Wall -Werror -o $@ test-libbfd.c -DPACKAGE='"perf"' $(LDFLAGS) -lbfd -ldl -liberty -lz -lzstd
+
 $(OUTPUT)test-cplus-demangle.bin:
 	$(BUILD) -liberty
 
-- 
2.56.0.385.gac671c819a-goog

