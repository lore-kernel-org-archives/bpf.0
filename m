Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2572F362121
	for <bpf@vger.kernel.org>; Thu, 14 May 2026 16:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776487; cv=none; b=JveAMevE+21wHX1F5rRhPjE0scWJT9NbhZXjaTexoEvheJSgKH20ONBn5vMSr8rnYDkLkCkPpxyawhdfnxN8EcBkRBtZnSXWoNum5XnHa9Td8Xje6dPdDtpQJsV2yU3kiFrQ3L8cfVRp/cOAclLfJ/xNO+d61J5QwL/E16xthKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776487; c=relaxed/simple;
	bh=AJwnR+lAKW1np28RhLpF3ZsQLx/y1KNA7lXTPkvhHgQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=hgK+8aEWrKKI+1ap/7DcjPMN+GtlTL7bO4oFXqLrb4I8pDrFK8w+CIjjFPsSvnl2kyGab5VyihIbK1pEq8HD8pHLBTlF2u4zhKw3TfIB7R0YOYOWWMBiUvJdELv3Ejpw3yADP9gkAMZqUA47CuP+IOPKxdlIGovrkOP2ip97e4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pi26ZQNV; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pi26ZQNV"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-13312be8a31so6022998c88.1
        for <bpf@vger.kernel.org>; Thu, 14 May 2026 09:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778776485; x=1779381285; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=N38Q9ydqZGeVcFYSzFov0y5a5aAtSUelDrIknLwNZe4=;
        b=pi26ZQNVhND17qzfWYKp/c7iediSrX2KQrufnZ1jdARUni3+WC7X8BKZA5g8NMRxNR
         rgjmELQi1o7IKJhMn7pQagby58cdfCQp1EeoJFCHV5etPuXwDotjBNw80WFuGAqUtjf8
         VCe9IglL9csmwPgQvBDAey5ivsR32umxSYepIPFcp39KfQzMa11gUpDecweWNtfLAIp1
         c10kubNXKk0Wy1yXAsjyLuaj7Q+y6xcMd6HgjmRiJjp8MQLqPvXdtTc9aUWXGsKMVIYB
         Vrv2jpM4jKtIFnNBFhWW3tmdlBzcjFzHmjw5JnflVEbSqgEBqSA6MaYyIrmq+ifsbroj
         ymsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778776485; x=1779381285;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N38Q9ydqZGeVcFYSzFov0y5a5aAtSUelDrIknLwNZe4=;
        b=BUC6iX9i7afLcYUkSI8kAt/nUxGNInJAQbhPn6JnshQs174wo9frAGIrwIuy8KxqzB
         k97CGK/THHnjk6h9C1l8XEGMvO6lhW3JKJ5HKgJprnyD5jUHxePgRKPOet7EdJ5IvjFq
         CpEwMCF4YsdE46v9MUkJwGkSkuNiEg8vrpkGKtldvYgDgrowbH1I89enspWEF5NQf8pT
         74aZ2h527FcdhAjcaUABdhqxI2RXKkdKkQeqNgATuk6obSje/yZE9JD1DnZIWdAqVtYT
         Vf+fnj/ewZ8ZAmtkzTIDWu2v0emZbZ/W3ZC62UScytbQu+0t9zkc83uJnAIxC47MT6j8
         xFzQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Fh3WlUUNhLX3x8AHYzQ+230Njbyb1idpi2ijjn/ZPGecxcA5a13Hbhy1uv+3WjuIsyrI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvP0Y88//UyyobouJIA927I0AYIvkzQDUv4sGEohoVaiuNpu/I
	Kdlj7SfobXgLgVK+R7Ffjl7uARFmfgCgUC+QwRsoM8VrpWNDW9+s7X0q7Ib7gyKC9F9TwRovzta
	Vy8pVM8l4gA==
X-Received: from dlbuy7.prod.google.com ([2002:a05:7022:1e07:b0:12d:b319:ccc4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:322:b0:12d:de3e:86a8
 with SMTP id a92af1059eb24-13436bb194dmr4732714c88.38.1778776484933; Thu, 14
 May 2026 09:34:44 -0700 (PDT)
Date: Thu, 14 May 2026 09:34:02 -0700
In-Reply-To: <20260514163409.927816-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260512174638.120445-1-irogers@google.com> <20260514163409.927816-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260514163409.927816-11-irogers@google.com>
Subject: [PATCH v3 10/17] perf build: Pre-generate BPF skeleton tooling during
 umbrella prepare phase
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

Currently, BPF skeleton generation rules (bpf_skel.mak) are evaluated as
part of util/Build. However, because LIBPERF_UTIL_IN explicitly depends
on the top-level static libbpf archive, Make completely blocked the
execution of bpftool bootstrap and skeleton generation until libbpf
finished compiling midway through the build.

Since bpftool bootstrap compiles its own independent copy of libbpf.a, it
does not depend on the top-level libbpf target.

Decouple early skeleton tooling generation by attaching bpf-skel-prepare
to the umbrella prepare target, exporting CONFIG_PERF_BPF_SKEL to ensure
accurate feature propagation. This allows Make to compile bpftool and
dump vmlinux.h in the background at build startup, eliminating the initial
sub-make startup bottleneck before BPF object compilation while keeping
100% of tooling rules perfectly encapsulated in bpf_skel.mak. Provide an
empty fallback target to ensure builds succeed when BPF skeletons are
disabled.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/Makefile.perf | 8 ++++++--
 tools/perf/bpf_skel.mak  | 8 ++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 30114a31ca76..a0426e914253 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -275,7 +275,7 @@ ifeq ($(PYLINT),1)
 endif
 
 export srctree OUTPUT RM CC CXX RUSTC CLANG LD AR CFLAGS CXXFLAGS RUST_FLAGS V BISON FLEX AWK LIBBPF READELF
-export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT
+export HOSTCC HOSTLD HOSTAR HOSTCFLAGS SHELLCHECK MYPY PYLINT CONFIG_PERF_BPF_SKEL
 
 include $(srctree)/tools/build/Makefile.include
 
@@ -629,8 +629,12 @@ endif
 __build-dir = $(subst $(OUTPUT),,$(dir $@))
 build-dir   = $(or $(__build-dir),.)
 
+bpf-skel-prepare:
+	$(Q)$(MAKE) -f bpf_skel.mak bpf-skel-prepare
+
 prepare: $(OUTPUT)PERF-VERSION-FILE \
 	arm64-sysreg-defs \
+	bpf-skel-prepare \
 	$(LIBAPI) \
 	$(LIBPERF) \
 	$(LIBSUBCMD) \
@@ -967,7 +971,7 @@ FORCE:
 
 .PHONY: all install clean config-clean strip install-gtk
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
+.PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare bpf-skel-prepare
 .PHONY: python_perf_target
 
 endif # force_fixdep
diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
index 30924ad140c4..1fbd8dfefa5e 100644
--- a/tools/perf/bpf_skel.mak
+++ b/tools/perf/bpf_skel.mak
@@ -15,6 +15,10 @@ ifeq ($(CONFIG_PERF_BPF_SKEL),y)
 BPFTOOL := $(SKEL_TOOL_TMP_OUT)/bootstrap/bpftool
 VMLINUX_H := $(SKEL_TOOL_OUT)/vmlinux.h
 
+.PHONY: bpf-skel-prepare
+bpf-skel-prepare: $(bpf_skel_deps)
+	@:
+
 define get_sys_includes
 $(shell $(1) $(2) -v -E - </dev/null 2>&1 \
        | sed -n '/<...> search starts here:/,/End of search list./{ s| \(/.*\)|-idirafter \1|p }') \
@@ -93,6 +97,10 @@ $(SKEL_OUT)/%.skel.h: $(SKEL_TMP_OUT)/%.bpf.o $(BPFTOOL)
 
 .PRECIOUS: $(SKEL_TMP_OUT)/%.bpf.o
 
+else # CONFIG_PERF_BPF_SKEL
+.PHONY: bpf-skel-prepare
+bpf-skel-prepare:
+	@:
 endif # CONFIG_PERF_BPF_SKEL
 
 clean:
-- 
2.54.0.563.g4f69b47b94-goog

