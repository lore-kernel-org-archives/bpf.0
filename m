Received: from mail-dy1-f202.google.com (mail-dy1-f202.google.com [74.125.82.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC973E8332
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 17:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778866757; cv=none; b=I+tABPYD4VIulE474oaIYy022rqoEVwFRRUXcxdw/tzzKUihLdrzOYdET2J3IHlDABTSVVMPRPmaUedm4l171OcZxGQVkDavPTc9gFPnEDF3gKpVtvIbkClQcfFN9iQ3ehR0gzAKR119bZpAFlSyH+9kqEFwFhHdb8qgCnkN1ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778866757; c=relaxed/simple;
	bh=+U/Ns4U0n1I6K6DVg25733xbH6/xIUj21YSyt3UqYhY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=EEPxuxQu8fCBKld4L/C5+PjdDngVZF62/Pr7+ybzG450AFwKHImh7/wlgkP7xwCBclXwPF1zzDQ1VkYD9zlLIZatR+bEB/+Jrff5gr6G6uIbzBpAeAI1iYccSmK6e1TuDvgETzodK6pVHsbfqNU5oyrHNgrLOUciVteFj8JS7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o+SGTzgK; arc=none smtp.client-ip=74.125.82.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o+SGTzgK"
Received: by mail-dy1-f202.google.com with SMTP id 5a478bee46e88-2f3eb8f3419so436574eec.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 10:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778866755; x=1779471555; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCHaIawCxnCGNrWb/mE/uud5GJuFlh4Rbz9NZTl4E9Y=;
        b=o+SGTzgK+niM/7cHEWoZCCc7+HQbgruhXS+EFPlVldVm7TJ7gWcs/XAx45KsjRVbCl
         leeTtqvz5WQmupFycvSkC+lZtu5ECkN3P6FqOfOXJIcpeWlwFVIfSWskRPv2O6RLI7o6
         LTL8T6uThpKn/tpVIgpWq0Z/E9LaEAjF6bozdWQUB8NCkufdeblHYdf7+TGrGecK8+o0
         4zjqQbtTMX7bfeIbU7p7nSWoIJfScoYi2qrMUkLOaS6aKH88cl8SdahRUcTQLtNSf8ak
         XV8XZM8kguiEJKr+Z9J12bJVmdisMHTa7b1gqSxFc/1HkjN1zmCWtZVnn7F03nAivJ/O
         nO1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778866755; x=1779471555;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MCHaIawCxnCGNrWb/mE/uud5GJuFlh4Rbz9NZTl4E9Y=;
        b=okSF6Rypr8SWdCbLNm5spaaWqA4l9fFWukggu6ODLtDXlKtR5HUGIxBZosAHPKmr9m
         yrKsVz/idLtTMGhYMVNrZ06OPDWQ7xUOYz+WtnzEK3D8ngQLdyrCv+ccQAr9eIzzp2r+
         Frj3bZo1bID2qZeBTtAK4QfnZzHg87bRSeAc0gPg44aYWHF9LR9z1/7my/dtYE5R8fnC
         ZD3LyzUyVBa9HoVGrx9StFiPelDpR5KMNNB+ClOnstbz7srka8qTzSrLTT3wf3P7siLE
         n2p+7UA2tf//PxaenZx64IKfWyYGhujScYxVjrF/rjBzoLCbBIAGYFyUY2dKxd6jSNns
         2wcg==
X-Forwarded-Encrypted: i=1; AFNElJ8i3k7aqWYOr4zrVCTQLMS/P4S0dN2qwyPxpnErpFBUx5MAZoxxwj2b38UR9dCEtpAdWgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx23T8apZbN9zlVUSPMkeOm5vLQ/9oyBpvbRhAXHHZMrhix4Cjt
	E+vGa/Gg9W1r8RDq1SZK2A0xtlawQ5onQ+6OoCHZVRdInfvvl6/Iz42GQ4gpApgJkcmeUqT9rrx
	5vgrOaVNpgw==
X-Received: from dybkf34.prod.google.com ([2002:a05:7301:3aa2:b0:2f7:1410:b095])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7300:6429:b0:2ed:e15:c927
 with SMTP id 5a478bee46e88-303986e075amr2730763eec.35.1778866755149; Fri, 15
 May 2026 10:39:15 -0700 (PDT)
Date: Fri, 15 May 2026 10:38:44 -0700
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
Message-ID: <20260515173852.1378571-8-irogers@google.com>
Subject: [PATCH v4 07/14] perf build: Pre-generate BPF skeleton tooling during
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

