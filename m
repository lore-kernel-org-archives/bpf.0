Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017E376BEC
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 19:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873612; cv=none; b=ZC8wBuLO9MCyi9BGo4hxIo3bd+hKzpmilAft4mKuAWRT87OwtmCGHDN/ipqg1AytrxleGzAR8LFZT1JBHIHNVMQuYyMynGvVBI13nlnxyN/gmhCxqUOhTr1x82kkDEgwYq4RD+fZkiDL7Q5zPWeMCRLANWs2HCoOzeyJAwk1I9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873612; c=relaxed/simple;
	bh=y5n+j/JeEhFGBisFMiGeKyIiGnqs2N+0QKru1BCTK8k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ocvTzChDw9ZHOz2Gn3t5DfIkrxkUxSJLYdT8hPA/W64/74sZI1pH6JXESMKdr2/42du9N4YczSptaXZADdBXClbQWATeL7FNd69fLeAQbapfNPu9uA54fN5MpcmMDw5WITVMRTlOrWOxDRPeyW0eT7fiWNqGalkMcf3DNraOK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eterku+u; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eterku+u"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-132d631edaaso1234950c88.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778873610; x=1779478410; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=eddZQ/1y9VI7vUXMgQrDm7/w5wbycye3Ng8n/fz/gX0=;
        b=eterku+uFKTOWC+lrDNmFWmQ9vp6/GtVBkCL7WRPSoEk1X+k/OduGRF7VfgMZDHJ6h
         oYkjU7hVITY69mofS8Oeujlmg6Kiuga4y0q3as4KXTk6tdPy1wPx1OwM58Ff4AkFQS3i
         mKeGPKHbJGPkeaAjYmaAinGJKEJMSJxfsSQHr0gxdhSmoKmTYt9VzmTy7tSx+FSYbMph
         vnpG2IIhTabS0vMcq2ALiaiC2FiGlhdHfLS35TQOiD3gVch6ohZKq/JCVmnXyUQrcmwH
         WgBePVw5claXntJTkB8us9762QSjyY2Ik3Q7+g+MsYZzzsvhvWYVcMKyGPvwtvS138k0
         sePw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778873610; x=1779478410;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eddZQ/1y9VI7vUXMgQrDm7/w5wbycye3Ng8n/fz/gX0=;
        b=hFgq1vDw4vqQWx8ZA4knYpuOmAKHh8RpYO335Mp3iHlUW3rhBKVPqL5LcFPnF6aI71
         xzcwGkc/IJAozdj+sHx6mjKxPpmtqVBlGTfdKgTfMYvQGEhZnahiJNI3ql0NZN0rWU90
         4a46RE10T+HGNEhqvcvIJlGzx8Mu8QLsEaTZ60DmE14LEiaxzH3+1/t4rFuQdz/eYOsM
         7HHvddtsRCDVudvkxsaitNjJ3UlYBrhTvKgkPDbElMSaU+38ZwGtEqBPR3AnSwVMWiZx
         McbtmXyrDxbVByo8jxdNfacJnIsxE2ImrSy2h7VFAq1nhIKJv9l2jdAigI8Cn+UIWMOp
         EAnQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5J6EoM/UrfYjzlAUaDdAwGVp+EAA0MFlUmTBvCGvjLFxjFGHEbwB5YnwvHaQimdf5Q7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA83fKf6CezFeSFD7N62ptchSJDPnjYxNvVV8wUQK3cxFCaUEu
	frZ+LPauZKbMzr0ltON/Jl+BWmoyDlZrJqlI4mHtbw00qtQI4e+6OO9c4NCetJbp82rEz2YDG4O
	/CeoTJAJ+Iw==
X-Received: from dldz1-n2.prod.google.com ([2002:a05:701b:4181:20b0:12d:bafb:54f6])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:f9d:b0:119:e56b:958a
 with SMTP id a92af1059eb24-1350451e343mr2536671c88.15.1778873610153; Fri, 15
 May 2026 12:33:30 -0700 (PDT)
Date: Fri, 15 May 2026 12:33:01 -0700
In-Reply-To: <20260515193314.1593560-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515173852.1378571-1-irogers@google.com> <20260515193314.1593560-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515193314.1593560-2-irogers@google.com>
Subject: [PATCH v5 01/14] tools build: Fix feature checks to touch target
 files on success
From: Ian Rogers <irogers@google.com>
To: irogers@google.com, acme@kernel.org, james.clark@linaro.org, 
	namhyung@kernel.org
Cc: 9erthalion6@gmail.com, adrian.hunter@intel.com, alex@ghiti.fr, 
	alexandre.chartre@oracle.com, andrii@kernel.org, ankur.a.arora@oracle.com, 
	aou@eecs.berkeley.edu, bpf@vger.kernel.org, collin.funk1@gmail.com, 
	costa.shul@redhat.com, daniel@iogearbox.net, dapeng1.mi@linux.intel.com, 
	dsterba@suse.com, eddyz87@gmail.com, howardchu95@gmail.com, jolsa@kernel.org, 
	leo.yan@arm.com, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	mingo@redhat.com, mmayer@broadcom.com, nathan@kernel.org, palmer@dabbelt.com, 
	peterz@infradead.org, pjw@kernel.org, qmo@kernel.org, ricky.ringler@proton.me, 
	song@kernel.org, swapnil.sapkal@amd.com, terrelln@fb.com, tglozar@redhat.com, 
	thomas.falcon@intel.com, yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

In tools/build/feature/Makefile, test-clang-bpf-co-re.bin and
test-bpftool-skeletons.bin redirected grep output but never touched or
created the $@ target file upon success.

Because the target file was never created on disk, Kbuild could never cache
the result of the check. Consequently, Make treated the prerequisite as
missing and continuously re-executed the Clang BPF backend and bpftool
feature checks on every single sub-make evaluation during build startup.

Refactor both feature check recipes to group the shell pipeline within
curly braces and redirect both stdout and stderr to .make.output before
touching $@ purely upon success (> $(@:.bin=.make.output) 2>&1 && touch $@).
Grouping the pipeline ({ cmd1 | cmd2; }) ensures that compiler stderr is
successfully captured in .make.output rather than escaping to the parent
shell. This perfectly matches standard Kbuild feature check conventions,
allowing Make to cache positive detections and avoid redundant sub-make
forks during incremental builds. Add test-bpftool-skeletons.bin to the
FILES list so that make clean correctly purges the generated binary. For
test-clang-bpf-co-re.bin, add explicit source file prerequisite
test-clang-bpf-co-re.c and simplify the Clang recipe using $<.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/Makefile | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 704c687ed3ad..5b4a984973c4 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -75,7 +75,8 @@ FILES=                                          \
          test-file-handle.bin			\
          test-libpfm4.bin			\
          test-rust.bin				\
-         test-libopenssl.bin
+         test-libopenssl.bin			\
+         test-bpftool-skeletons.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -383,9 +384,9 @@ $(OUTPUT)test-libaio.bin:
 $(OUTPUT)test-libzstd.bin:
 	$(BUILD) -lzstd
 
-$(OUTPUT)test-clang-bpf-co-re.bin:
-	$(CLANG) -S -g --target=bpf -o - $(patsubst %.bin,%.c,$(@F)) |	\
-		grep BTF_KIND_VAR
+$(OUTPUT)test-clang-bpf-co-re.bin: test-clang-bpf-co-re.c
+	{ $(CLANG) -S -g --target=bpf -o - $< |	\
+		grep BTF_KIND_VAR; } > $(@:.bin=.make.output) 2>&1 && touch $@
 
 $(OUTPUT)test-file-handle.bin:
 	$(BUILD)
@@ -397,8 +398,8 @@ $(OUTPUT)test-libopenssl.bin:
 	$(BUILD) $(shell $(PKG_CONFIG) --libs --cflags openssl 2>/dev/null)
 
 $(OUTPUT)test-bpftool-skeletons.bin:
-	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
-		> $(@:.bin=.make.output) 2>&1
+	{ $(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons'; } \
+		> $(@:.bin=.make.output) 2>&1 && touch $@
 
 # Testing Rust is special: we don't compile anything, it's enough to check the
 # compiler presence. Compiling a test code for this purposes is problematic,
-- 
2.54.0.563.g4f69b47b94-goog

