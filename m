Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EBF33EB10
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 16:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776463; cv=none; b=t6BukLnp4bJclOQMsdD9IPDnbctnpTcqwOBce/ZnN6bsWrkl230X54rJzJJ8d8YBNSIahOvqMERfH/mDJVDl/CC5fVGpIfx0y5AhFkXsUySUFArWCmoOmqaOLlc62ZlslpJNnxixxeuSlNmuqYHq0wjr69uuZr410E4ubzulKcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776463; c=relaxed/simple;
	bh=wwRoZKbj654sz4VrwUcykwLsN4Mk4H6ny+P/lIWtoWI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VJY/MpKAKYDiR4fMHVf77gNLBVMsGH1cS6GJl1k8kERWg5y7eQN7LYX7LPygtTA6r9mQvrpVqy2W00HJOq1ZCFpD/9y1zmV9yvwrAdIHs62V+RQqtOtJciB5fm23tk/IHaf0ZIVRMnmz8eoyGTU139MqRKSLiutznloCvMpriV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tXFTiR9m; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tXFTiR9m"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-134a9388abfso37592c88.0
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 09:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776461; x=1779381261; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5i6lHdemblE/gP7H567PkD83N+A+98X3bUfvUWyr9JU=;
        b=tXFTiR9m96uUxkBDTjW10KGSeIfFKznWj/LiSih1z7kd6r61pXWiI+U/8LrfeN85OO
         ZSrlH/YZ7nwpD0rHZx9BPOGBG4cIZOvtsRAE+lZzzFbIPMYaBnG35Sq+YflUdQJDsOIs
         gWlvI2XnVLLprxt/KEjiDyVG9duzOvhpgto9oA7X/smCReO/X2bUwUyheWndLRXcpUfY
         S2HLoPc+UDJdSggaCH0rlRy53cGlLUBU+NRDV2qNvlGNhTwiftJAs+hSK06kbmvG51+d
         fBZQECDT8/M6UuwiXeMI0Ba7nILiycFUbIbk6td6EYcb86Dl86sRT1ciJHCXGHIM6UCM
         /oFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776461; x=1779381261;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5i6lHdemblE/gP7H567PkD83N+A+98X3bUfvUWyr9JU=;
        b=akve2l+viBv2ajimJkVNp+9YxXPLTX+Qzfj0uU4aWwwJkKAEjufx4yNVA6RMPbww9+
         a0ASGQpQcjP2O4qI8G0VBMFxEvExmqLT1AaRLRCPnuUxl30mh4YlniWUBeuhe1xwJJHt
         jS7tl9WswFPInGj00XlQ7vTPXXFXRt1S0MG2auU8J6R/MHtewsuI1Ihrr3Bp16iJP9A0
         JXWUsgjrWBklOJ0O5cvBECNfDV7doFNzScRIVnC6+6rxTqaGaTefnub+qOBj30K5hNSs
         TcjXV0MVTCYn0SnZoZFPCuNDlGZe5qpjYvB30hzrMmhnLdZxuhFSn3gd/OznkPizaCxc
         BV+g==
X-Forwarded-Encrypted: i=1; AFNElJ+4gjjAJM81nt0R7T2dfqcq4XPZxszLenu6DzBAmqUszBk6upvu7jK1P8Yaso+CtVyVZGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx99XTkPm8d9GZFhF7PyAeMba9bTGYxQ/G+bkiP/Bnxwszfbrt1
	YYYOuMZ0Rsc51i2r/9QxVdZ65qF2buuWvP+Dg7DRbdb97xh9wrsctVZzX678Zduq1voVpjt/191
	g9qQkQ0N6vg==
X-Received: from dlbvg5.prod.google.com ([2002:a05:7022:7f05:b0:134:74a7:dae])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:439b:b0:12d:de3e:86b1
 with SMTP id a92af1059eb24-135000aa985mr153729c88.20.1778776461049; Thu, 14
 May 2026 09:34:21 -0700 (PDT)
Date: Thu, 14 May 2026 09:33:53 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-2-irogers@google.com>
Subject: [PATCH v3 01/17] bpftool build: Restrict feature tests during
 bootstrap compilation
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

When bpf_skel.mak executes 'make -C ../bpf/bpftool bootstrap', bpftool's
Makefile unconditionally evaluated feature checks for llvm, libcap, libbfd,
and disassembler libraries because the bootstrap target was not exempted.

Since the bootstrap bpftool strictly compiles minimal AST parsing and C
code generation logic without linking LLVM or disassembler libraries, these
feature check sub-makes are completely redundant.

Exempt the bootstrap target from non-essential feature tests to eliminate
unneeded sub-make fork overhead during Kbuild startup.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/bpf/bpftool/Makefile | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 0febf60e1b64..8f50bc163bb2 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -106,6 +106,10 @@ ifneq ($(SKIP_CRYPTO),1)
   CRYPTO_LIBS := -lcrypto
 endif
 
+ifeq ($(MAKECMDGOALS),bootstrap)
+FEATURE_TESTS := libelf-zstd
+FEATURE_DISPLAY :=
+else
 FEATURE_TESTS := clang-bpf-co-re
 FEATURE_TESTS += llvm
 FEATURE_TESTS += libcap
@@ -122,6 +126,7 @@ FEATURE_DISPLAY += libcap
 FEATURE_DISPLAY += libbfd
 FEATURE_DISPLAY += libbfd-liberty
 FEATURE_DISPLAY += libbfd-liberty-z
+endif
 
 check_feat := 1
 NON_CHECK_FEAT_TARGETS := clean uninstall doc doc-clean doc-install doc-uninstall
-- 
2.54.0.563.g4f69b47b94-goog

