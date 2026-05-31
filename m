Received: from mail-dy1-f201.google.com (mail-dy1-f201.google.com [74.125.82.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98C7282F22
	for <bpf@vger.kernel.org>; Sun, 31 May 2026 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780189677; cv=none; b=kVx/vm5uRE5oQPPpRWvARoR0ULUQ7WR7W5qOwn3iufcfqaWJB59Ng3tkEeCdO2H47xqOe9AYBZWwW/yXWF/AZDtHxFaEKLvKDdbWS26BE5bCT8fNpIwiQOYpKOLJvj7SEyL+8TqpLpicIR/eKlim/ruiQO5V15ymf9cGHEzXX1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780189677; c=relaxed/simple;
	bh=l/IOAmzqAWxn3px4qTqpAPWLw3OXzvVmnFcKE59vi9U=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jBIDgWvZ61nIPcIZESMHGSgLoYDRKjGGjuunglP6VUyFG30SRdzJcwcBErn1ildLCpOmZ5VnWw+bP+QPnQPGCOCd0saGfE54OL9BMQGEquBQc4yxDhzfqH0t1mo87/4NYVjGUtwxaZijj/t6hBUxn3fId3vCO0wNbLzQ9/d4UV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PIoMilmh; arc=none smtp.client-ip=74.125.82.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PIoMilmh"
Received: by mail-dy1-f201.google.com with SMTP id 5a478bee46e88-304ee7d1368so1686382eec.0
        for <bpf@vger.kernel.org>; Sat, 30 May 2026 18:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780189675; x=1780794475; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7kr1agsQxN7R+ckqIUhhb0WeLzMOoxPB09KTg0cF36Y=;
        b=PIoMilmhwPlDAjfufWhAR2h83+L+4XB9Z5yJ8zmbY/Ps0oP0bVl+UUc4pqzJm6eGdy
         m3pCUXwwhJLJDJdCviLBb0CjFaCjWS4Sg9JMU9vH7muKG265C7Tt5F9H5I0xAIaL6eyN
         592THnX+iE9+5V7PRM9fIsAWy9iF9LAay4y3gsTJAyjcXj2qJHwqoVLCkaRYS3/zQPE3
         oJG6jzuJt30Dq8gDgPpZImlpR/iRI+UVHnpdn6iVam6KUUZvxj1c/ju+aKOug7vLwV7p
         B6tk4+wb5rtSBIY03GEenrL5LhLn7cRWgxK41Yv1uTsZ75s3QGfX/LXaskn2UY+Y7Sat
         Nxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780189675; x=1780794475;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kr1agsQxN7R+ckqIUhhb0WeLzMOoxPB09KTg0cF36Y=;
        b=K2Uf5Xb+ZB02ZkkqnOCmC2Rb5SqoDQIMfmwZs9eH9ZoTrqWT6LKebjy8IFpYGSCRv9
         NLHABiWT/JcmYLQkxzaM1RyMsHsTz+YgRoCETJ7sHUsiDMCCy85IjvJnF1XAOpPotpUy
         II2KvUmvNEgcfBKrP5PioNXlqU7Cb7K9G5UODfbipbfP+jw1YMNotowzhOpOtIXoiy5T
         Z4rx6pjjNC7AcrbkA5+KGSt+jCX6ExBeVf3+sjGDu+sHyHdRq7KRKPrPhQh3C9RLWlOg
         vRBuK+kWS0hCIYTjUXJmXTUpVZOE9jgF+Xf6f+FpVIpfZOSR5qFEQ0HDZ9UqwjoJJxEA
         ezCg==
X-Forwarded-Encrypted: i=1; AFNElJ82Ad/iZKc7iZphjI8HFUN49LCor/Uh+7HDUMrrvGIq/eBt/nF5hkLAtHZSAPnqM74Bt94=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf1qJ90Nn9YGrDEU3FyjHAdRiUD6h9YJKNOUeF11mDCds9yXw9
	4Re52pheJPT5NEHBl58shDIZl4EpLfL3uaif2eNauRELE5vhvlHeYLkVXcXzpTqmWP8lTH5ccYe
	7VMb7HVzuLg==
X-Received: from dybmi48.prod.google.com ([2002:a05:7301:fb0:b0:304:d272:2198])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:578e:b0:2e2:4979:eb5
 with SMTP id 5a478bee46e88-304fa4d7a78mr2732026eec.10.1780189674615; Sat, 30
 May 2026 18:07:54 -0700 (PDT)
Date: Sat, 30 May 2026 18:07:50 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260531010750.525160-1-irogers@google.com>
Subject: [PATCH v1] bpftool build: Restrict feature tests during bootstrap compilation
From: Ian Rogers <irogers@google.com>
To: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Nick Terrell <terrelln@fb.com>, David Sterba <dsterba@suse.com>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Cc: linux-perf-users@vger.kernel.org, Ian Rogers <irogers@google.com>, 
	James Clark <james.clark@linaro.org>
Content-Type: text/plain; charset="UTF-8"

When the perf build executes 'make -C ../bpf/bpftool bootstrap', bpftool's
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
This patch originally appeared in the now merged perf patch series:
https://lore.kernel.org/linux-perf-users/20260514163409.927816-1-irogers@google.com/
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
2.54.0.823.g6e5bcc1fc9-goog

