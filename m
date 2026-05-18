Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C2A385509
	for <bpf@vger.kernel.org>; Mon, 18 May 2026 04:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779079676; cv=none; b=kWqRle5KsJxImjnieRwu1o1+fIrJgKm+KA+0dWa69Ra+4QcnnPZ3NJx02ZXW3Wl6abIy8geQ2AcmL0vEj99V1q0ImVzlJ1w4Y5HGCfH1MCyXuEDR3FuaqZALHqX1W/8rFdSW7dZvZ+0zDyUjxVNnMrg2xa2EvRNdnFDNsE4JsvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779079676; c=relaxed/simple;
	bh=M4TALmiKZilb0u+lhPWRfGvMJCr+kBUrEvnnlqnUv2w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gdvKk2CLEaGfsRKXfQV+vikBDfTFI4KvNMOvyHFwQMds51UIOBczwuITShGcAtQi2kaoSGO1Rul0T3oLFJQrKptcHoGTNHGRsiuI5GbRlQsyBVhLirhxc8qnvNAAMakav9Phinvd5jv38QZ+2SToo5cY+Gfg4/YvCTagaH0WD+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aQueClA/; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQueClA/"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-2fe1cf409a1so3732154eec.1
        for <bpf@vger.kernel.org>; Sun, 17 May 2026 21:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779079675; x=1779684475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy1UTgDV/XpXNGsXM34DAoH9zJ9hy0otqwfOVYZUB1U=;
        b=aQueClA/3EWlBeoH7vEQTCdUs1umh8j6soeiXfVR2EeUhHd+g5IAkvbSNWC6AQoalI
         f+w9ts+Jtr+qlnDfiUf1pqvfvXnpJAPm4wAq1qHZEdnmC/7QVWlr10kEM2MMjdQt4Yuc
         XTKMdkNYj46IfewCILNnxQdjLKOgubrv1nSUk77hXz5CwYhdA3JBdNWrNR+va338NRSC
         Cyy2zuavao9mZ0iu7OBOgRzwYPxIZvV9UrxSbWQ4SF6mMb2hUSkSeVzaXg2Dxvsf2Izc
         kYMFsXMbN0R4ns+UmhhBLNYbuCCUbrGjllqkkbw1p/vftNzK83ybtMrH+lzZouJrubJK
         SExA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779079675; x=1779684475;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xy1UTgDV/XpXNGsXM34DAoH9zJ9hy0otqwfOVYZUB1U=;
        b=pJmGRynSrxH0JeT3+VX4ptZ1kMBzd1rdpbAhykcCqmGmW8V5BG9qAX/bbgPSkbi5dU
         yVjhLnZU6b8hAqZse7c3oFe+p5JhDPD1ssMXY+WcFeDqsv3hlFBmltyQTsaQXCq7Ff7U
         EIcauhvIEoFkB4EOBLqJC+fYTwUnU/nVJ/uPBPF73dKiKpId4qEqgymw+4ggFmAPwBIh
         2pCyBAs6o9lavSUeJJK+lB3qvbXIyDcLXLsXA/H0AqqSKdF1nL8qc64PwqGQHXkySYTe
         +pE0DY8VvM6fBSnFcZ0KsxTbSba/e1bu0+/Y4yw1V/tdxWa3UZlVJi6YZ8TAY1GYXpNH
         up1w==
X-Forwarded-Encrypted: i=1; AFNElJ/BBY2tNlu3UFM5PYF8zFxDJr7F8pn+JME1asSF7oaFlSW7GCvT7jvHiFREWYJlFNlbArc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjhhWshYeDMNJCjkwywj4r1pjmmj6qbyS3nN7vPISHKmB9/FMl
	YkSfBtd0/92HBTPoVzIw4+oaIMsHvP+niOsWmH6+IWqvwylAQARbUQhMYx59X22QADTmtSfiPjs
	Y4Z/V2I5QPg==
X-Received: from dycak13.prod.google.com ([2002:a05:7301:1c0d:b0:302:4f05:e74b])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:3d1a:b0:2da:1a81:588
 with SMTP id 5a478bee46e88-303983c6515mr5286792eec.14.1779079674284; Sun, 17
 May 2026 21:47:54 -0700 (PDT)
Date: Sun, 17 May 2026 21:47:27 -0700
In-Reply-To: <20260518044740.2526802-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515193314.1593560-1-irogers@google.com> <20260518044740.2526802-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518044740.2526802-2-irogers@google.com>
Subject: [PATCH v6 01/14] tools build: Fix feature checks to touch target
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
index 4e4a92ef5e1e..9da5a4fd956a 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -72,7 +72,8 @@ FILES=                                          \
          test-file-handle.bin			\
          test-libpfm4.bin			\
          test-rust.bin				\
-         test-libopenssl.bin
+         test-libopenssl.bin			\
+         test-bpftool-skeletons.bin
 
 FILES := $(addprefix $(OUTPUT),$(FILES))
 
@@ -379,9 +380,9 @@ $(OUTPUT)test-libaio.bin:
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
@@ -393,8 +394,8 @@ $(OUTPUT)test-libopenssl.bin:
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

