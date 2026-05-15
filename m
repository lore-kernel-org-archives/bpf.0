Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1824403137
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 17:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866746; cv=none; b=lMrmZ5TjbuwnmtPV3I2pvPoLkxLez3UIHOj7/spTEM4MWgS5JrNXexyX8UN4mba4uVrbaCW5BZSBVPeMq1+O66EgeGfQ/mFx8hrD24xDHtrviYhhk2eNOiXmrzCobJJQiDHQWotmTGz/ff8yT1NOU+gvo0hTGfnVgxWu8U13nh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866746; c=relaxed/simple;
	bh=QJWhGnFqUspUPqt/ZDCu0S7y6LbXz1284XXhAWWfSyA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jm5QLgfB8JwVkpUJ96DUPBBniSzwv3i6jbmXt/8a0uV7SNfmZPe/TjTkcPEpuZS5nYQrnrGSlcinHHIn/vpdu4QYqYFZdGvpcDYrnbQTbYktt5l2kszACNypx2BoaynVoeR7zESth3csAo1PMPxERf3Xqr5wktpx0d5w9kJIyOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cZiv/Wop; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cZiv/Wop"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-132d631edaaso30145c88.0
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 10:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866744; x=1779471544; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=995f1i5Pu7SDgq4PnZXVb1hHnnIiiWib94RWRsl+x6E=;
        b=cZiv/WopY4F9Q2vTUqZIcX3zYKNQgqy02NoYwBmN5PInE6HCkWnoeaLaUtRxuKCV5z
         2T1iSNbAFBA6gX5MM6oiag2l466WQdotlabsxjv8faPUtFw+jpvlt05FS8M8B6N4sAZk
         04hVLpgg7xEkV6E1TCDTw/CWb+FvLE4v38trJ/URLlbqMMJz1lFc3DY3K1fo4F8PQG4w
         l7MUeJ/5dSviovH7vkVvEIudCVQ6UlEGM1bBOS5beTVF1KBL427E7DAljkkvDrmh6ksp
         GpzadtlTbh7VZiamkNuo/Vh0TR0MAzXotJbz/BPFulNZBvDV7kQnCBZZlrTx/CICLmLd
         Hd2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866744; x=1779471544;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=995f1i5Pu7SDgq4PnZXVb1hHnnIiiWib94RWRsl+x6E=;
        b=jbHOifuJfWWfsBILsEedCY/6Ttk0jWexPHerXIDy+OwMn3qVb9L7NDLJx/a0bMuf9y
         RnZvOgjoXYOKBbIAepzCmubrW16vdfOLC3RxJC5nIchFdw4zix9LLAChErxTimn0ldGl
         02TRtP4Cms7nZh7qDY1W448JdZpMYmdBfH5Rn2sS0T3ifYSOX+qhHcHt4oAPGP1IQTPl
         93LUJDrVBLt4J2q8lKfQYHb9gD5hIKpnKqQ9zDMrZZUqE43tZvjr1Cdbt8PMlV2at49v
         59S47t2MKIr6yZkAK9onYuDf2ZGwFXPkI8CNp9h+K//wfOa5DrT9e0qRFLTLvyF9RJ39
         KeNg==
X-Forwarded-Encrypted: i=1; AFNElJ8fNi/o6Xpxndfj5OK1zCt7OKyKpt4GpasDs0NF3PAZVlhg7qFo5t5FwnQ+Nu380xC591g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+k+38VlrRtYnS7XDrItVibleWUNyI/HFfVkFffQoOeLLWHOQ
	Q97k9F97bQMI+adkq2ZBuHkR3ZP8BozAHj7NX9JeJCpb98rdw//4Yr/tHeQ0EvCKQ1G3Cf3EbPr
	uUWhSD3Ivyw==
X-Received: from dlbur22-n1.prod.google.com ([2002:a05:7022:ea56:10b0:12d:4be7:8b60])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:60b:b0:127:33e0:ea44
 with SMTP id a92af1059eb24-135049480a6mr2228177c88.29.1778866743389; Fri, 15
 May 2026 10:39:03 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:38 -0700
In-Reply-To: <20260515173852.1378571-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <CAP-5=fWfrGMV4EafqkwQO-R33c_szXcxVLgH0c4k2zt3zj4HdQ@mail.gmail.com>
 <20260515173852.1378571-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515173852.1378571-2-irogers@google.com>
Subject: [PATCH v4 01/14] tools build: Fix feature checks to touch target
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

Refactor both feature check recipes to redirect grep output to .make.output
and touch $@ upon success (> $(@:.bin=.make.output) 2>&1 && touch $@). This
perfectly matches standard Kbuild feature check conventions and ensures the
target file is touched on disk purely upon success, allowing Kbuild to
perfectly cache positive detections and avoid redundant sub-make forks. For
test-clang-bpf-co-re.bin, add the explicit source file prerequisite
test-clang-bpf-co-re.c and simplify the Clang recipe using $<.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/build/feature/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/build/feature/Makefile b/tools/build/feature/Makefile
index 704c687ed3ad..ea278becee2f 100644
--- a/tools/build/feature/Makefile
+++ b/tools/build/feature/Makefile
@@ -383,9 +383,9 @@ $(OUTPUT)test-libaio.bin:
 $(OUTPUT)test-libzstd.bin:
 	$(BUILD) -lzstd
 
-$(OUTPUT)test-clang-bpf-co-re.bin:
-	$(CLANG) -S -g --target=bpf -o - $(patsubst %.bin,%.c,$(@F)) |	\
-		grep BTF_KIND_VAR
+$(OUTPUT)test-clang-bpf-co-re.bin: test-clang-bpf-co-re.c
+	$(CLANG) -S -g --target=bpf -o - $< |	\
+		grep BTF_KIND_VAR > $(@:.bin=.make.output) 2>&1 && touch $@
 
 $(OUTPUT)test-file-handle.bin:
 	$(BUILD)
@@ -398,7 +398,7 @@ $(OUTPUT)test-libopenssl.bin:
 
 $(OUTPUT)test-bpftool-skeletons.bin:
 	$(SYSTEM_BPFTOOL) version | grep '^features:.*skeletons' \
-		> $(@:.bin=.make.output) 2>&1
+		> $(@:.bin=.make.output) 2>&1 && touch $@
 
 # Testing Rust is special: we don't compile anything, it's enough to check the
 # compiler presence. Compiling a test code for this purposes is problematic,
-- 
2.54.0.563.g4f69b47b94-goog

