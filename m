Received: from mail-dl1-f73.google.com (mail-dl1-f73.google.com [74.125.82.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0193439A805
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 19:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873625; cv=none; b=RuRdsAq0TR1/ZH+nLZg+BFWvuKr/2qYi2RJitINkpPMC2taoytmARfWxQo6lElOKJMnv3R9blBRa+S2FR5ude20UJgM0nAEugNJIyWT7uK0U6iBeLWNeBmg+N7WxLnpdCS0KlMccdXWYLGc2yDUr+PCGs9Eco5CzZFTigttVESY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873625; c=relaxed/simple;
	bh=+U/Ns4U0n1I6K6DVg25733xbH6/xIUj21YSyt3UqYhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mG1+BEz6M/k8/dUj4dgVw2KFLIjFVPThaj8xtaYvxG7By60YsftB79S7MklsqYEgYvICXtAgScWlbzPhWQaZhCCeNMbQ1CJtyO0UPOBkh573l3KknStGEGmXmIAEz5+3aGjh41HGV8Rr3jEuliMM3OWDWnpyG5iBNFPpZ2q8yac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AdIELJwe; arc=none smtp.client-ip=74.125.82.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AdIELJwe"
Received: by mail-dl1-f73.google.com with SMTP id a92af1059eb24-1353a6f29deso784037c88.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778873622; x=1779478422; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCHaIawCxnCGNrWb/mE/uud5GJuFlh4Rbz9NZTl4E9Y=;
        b=AdIELJweMz7YlhH+Q8GCis5CrzNX5XgritcRXfqk2QogFC/PXW0ejuWyTGh131WyJG
         3F4cpyr/dwYjLbQi0WXM0vKI8xsaozFXuTNT+cUx2FIPb4kNytx7IngXTeyxV0TlPuTc
         lN4B8EyukbrRXlmzspw0YIxoBV15nmJf0ZsMwSNnUGucWf1tYyMNevTdfgZJqiuzYmZ+
         yUN3A83yi1misfVrpDnCULVLm+woH3ERfnW6EEMhs++hXytV7a/YzpVSubtbJb+1VCiV
         6OvJHSY493DLAbCePJJbqVOcxBr4VIncvLurzDoKNQ5U8GCmVdzTKMgwdol9+piXlIh+
         KJrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778873622; x=1779478422;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCHaIawCxnCGNrWb/mE/uud5GJuFlh4Rbz9NZTl4E9Y=;
        b=fS/q7r20pST1CJO/kr3PWtb4QwTG9UxQbZ+ylQhNvgrbZKI7qfTsux4HxuXcbAzILZ
         HAqnoSQgnsVSkPwo78yzx+eblRwpF7TJBsTmtxmGRO1qFKcNqsmk+bUsE7AH/ywBYnya
         LMHD2fRRPVb0Y9ZfdO7DNT963dXA16tWGjCke9nmml60BJyz05a6z/lvjSH1NtNxuV5p
         nb0j3fGrhqCLXw0TpO0veCERdzfJGyHhCn+ZyQyq4O7P6/UBcquUDcaPlQFI20FfcvKS
         teSi0/w9g2ZSnf6fqUBFFHl+48mowPxEa5kfFhhUPCPAJ2jLCnIMwgEsz113vq7LvGh3
         d2qg==
X-Forwarded-Encrypted: i=1; AFNElJ+Aul/Ivt8pdpKcCg8oZeNcXSzJchkvHR/N0j6mXr4LCNDpjoZ+MmAZiW4xSOPiqjHPqr8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/E7GBykOzK8upuNWDzjs8NVV0nRo0tGQ7TKoS4uzLmH6ym133
	EUlTtZ04BRL+SDkSn4Zqwy4TeadIN81Pia7jN4kkLioDhY37ZF3Ne+Hl2ZH4rFus+ftpW9XxlBj
	cWKd0bW1T4A==
X-Received: from dlbqd17.prod.google.com ([2002:a05:7023:b11:b0:134:ab40:cc73])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:ff42:b0:132:7ab5:6cb6
 with SMTP id a92af1059eb24-1350451da55mr2503977c88.2.1778873621793; Fri, 15
 May 2026 12:33:41 -0700 (PDT)
Date: Fri, 15 May 2026 12:33:07 -0700
In-Reply-To: <20260515193314.1593560-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515173852.1378571-1-irogers@google.com> <20260515193314.1593560-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515193314.1593560-8-irogers@google.com>
Subject: [PATCH v5 07/14] perf build: Pre-generate BPF skeleton tooling during
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
index ec0e91bedce1..876065a02de6 100644
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
@@ -971,7 +975,7 @@ FORCE:
 
 .PHONY: all install clean config-clean strip install-gtk
 .PHONY: shell_compatibility_test please_set_SHELL_PATH_to_a_more_modern_shell
-.PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare
+.PHONY: .FORCE-PERF-VERSION-FILE TAGS tags cscope FORCE prepare bpf-skel-prepare
 .PHONY: python_perf_target
 
 endif # force_fixdep
diff --git a/tools/perf/bpf_skel.mak b/tools/perf/bpf_skel.mak
index 30924ad140c4..7704e7e635d8 100644
--- a/tools/perf/bpf_skel.mak
+++ b/tools/perf/bpf_skel.mak
@@ -15,6 +15,10 @@ ifeq ($(CONFIG_PERF_BPF_SKEL),y)
 BPFTOOL := $(SKEL_TOOL_TMP_OUT)/bootstrap/bpftool
 VMLINUX_H := $(SKEL_TOOL_OUT)/vmlinux.h
 
+.PHONY: bpf-skel-prepare
+bpf-skel-prepare: $(BPFTOOL) $(VMLINUX_H)
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

