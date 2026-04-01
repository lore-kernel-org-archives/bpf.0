Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0037947A0A7
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 16:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060144; cv=none; b=DvCRyCGF2kq+FTIKhpGLV3I49gBzphSRtmwSAoVo6ChbbwkY7PMFj9m54uynzzeBD/U17bHEjmaLTslwoLWXWlbti7aqAnBYs8hHAlQPhAZW87bUKBCN3MkrsBecUZb2MubHkOPU/vxjCr1QlFM1L3yMMc0q/WY6v06svuAOtno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060144; c=relaxed/simple;
	bh=6womnhNkPVIMC9BJtbyzHpcUSwPDJFVk2MnEcmHSrI4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YuHOjk6yoKNim9gOUp2QThNPRVmydPacyk9E0emIyOottlMLknRJINVYEI3dsqLGCsBUjCHkalQ61bOGvVzuzCkhs90wHl+UX+k/3smYAgNHVFQhIqD2D0gV5z5l7tB8czH6i466hkzfb9wRsb4ZGqiMJHNscvWRsEce3boKqUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=I45/T1KR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="I45/T1KR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-482f454be5bso12015865e9.0
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 09:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775060141; x=1775664941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6BE6rCgLm4ycfO9rARPfewZKzJOvUfIcBPg9sKbASzA=;
        b=I45/T1KRR74E7Fyk8KlW20dnoresVwCnFlbfotkxgdA9PL3e3xnsRPXVu8rFS82tRh
         ssx/eAttHDH3EXEyGr6rIww/aNlRweiqzmrky6smNPErkOpJbV12fce+7AGyOKTO6kZ6
         nvHeYcA4uRmjMjC0egC5mPjsH3HRYPLtBekfJk9JpFiXXK4tqIgv+G7HYdUU7meNv96Y
         emRYuaRyD6Z+KqA3wB3rMxc5WMWlSlQ8ippbqjKt/IzOV+/zro+yBKS5BDTi60UjTcbu
         SzrxABRYQcafQN0VSnLU+Zc9nBxPV6VD92zUdtGoYeQO1LjSOuODs3w0T4MxPrFjvobS
         VyLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775060141; x=1775664941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6BE6rCgLm4ycfO9rARPfewZKzJOvUfIcBPg9sKbASzA=;
        b=i5eOkNJpUpdbGtWKWCZVuHaWp4WhvaR+QFr1cNj9zXyYqk/TTn11R75SBD0d6yGJv5
         uYlxHIKFHZCKY20legiBXOlpJchn3nMgg3zuVeHGdke+bN6Y1EM0Q6MVyTQIzUK5G6yH
         rcNjtbsl2C3j6DYdSbS5pdxxEDbCQoEcp5xTL83Wk0jildY5NryN7NeuGd0/jVqPGs03
         bQe/0hoF2CTI803w+4T9PP2/35RKGZmmfuOCFLF1yu5XxRycpXtqHpB0f1BSlKI2x/M7
         PomUX3aIho7VrPoDjGVOvrGIUJFmNjWcUyhAvWq9oOKLbrGlMtevFOFigqTRGgq4t2dl
         JXSQ==
X-Gm-Message-State: AOJu0Yw5aqjMmxXvaesy9cwIO5WmuUFHkYxd1R5NNWNUn8ddBh3r6C/D
	v2QAO3fxqmLSIp8U227Ve9J5cHAyUZ7OroRiHf9DCoHgtQlJVJ6HahkOCB4/OINtyR/CHmaIJls
	0P7F6vHY=
X-Gm-Gg: ATEYQzxiZVKKbna9ptcrqrQ9p714czM7uPLiSSZDfIwynD07nPZ+1iY5wMWOFSOLVcy
	VKpqQx4dZhlqJtYOTJjCZTMiwZdZhJaGHmPfTq+nhjZ/+7pHSN+1KbSyD2qogu440Lr9qp9uFEj
	F1bK1LSJm0j7MMD7jviy+5LdAqyHRU5F82kP9FPzXBESET4UqyV67A08q5cZIAsxyFf6XE4yVJe
	XdlvlqzVbtSTt2EOtFg34nzkjt9l/OZBd21SAcdVAdNOwjMkbWu3vX54+yv9oSfw89Vf05uCYow
	GhIEdFF0gdrvop188ZPt1m3k2Mh0O7HUKJVsZWBH6jLfTH4KOJtPpuHfm5ZQXDS+1comMCNlslr
	309J0Ui8KoWC9k1sNzcV0PU1NTq0Wtd+rMtz8B+M3f6Tv5ro/P5/692mfD+ujlJrmqGEn2a8cKw
	6/LP0hXYmS
X-Received: by 2002:a05:600c:8509:b0:483:6fe3:bb49 with SMTP id 5b1f17b1804b1-4887810ff5dmr180289275e9.0.1775060141179;
        Wed, 01 Apr 2026 09:15:41 -0700 (PDT)
Received: from localhost ([189.99.238.3])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-60582e73126sm238531137.4.2026.04.01.09.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 09:15:40 -0700 (PDT)
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
Date: Wed, 01 Apr 2026 13:15:09 -0300
Subject: [PATCH 02/10] selftests/bpf: Tolerate BPF and skeleton generation
 failures
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260401-selftests-bpf_misconfig-v1-2-3ae42c0af76f@suse.com>
References: <20260401-selftests-bpf_misconfig-v1-0-3ae42c0af76f@suse.com>
In-Reply-To: <20260401-selftests-bpf_misconfig-v1-0-3ae42c0af76f@suse.com>
To: Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
 =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openssh-sha256; t=1775060128; l=6534;
 i=rbm@suse.com; h=from:subject:message-id;
 bh=6womnhNkPVIMC9BJtbyzHpcUSwPDJFVk2MnEcmHSrI4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgguRCc5X8/UX9M40lkMnr//aFGOhce
 x5ezt8MFNUFlqYAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QH3ZNAn2TKD4/dRXoJ/Bm3zjfawXZ12IOscGRX2I45gtK8Q4McVeaZjj7fo0SSx/x/FUfTB2ega
 lrV+E1Nckxwk=
X-Developer-Key: i=rbm@suse.com; a=openssh;
 fpr=SHA256:pzhe0fJpYLz+3cZ33FFPhIfaUElk9CXPFFXmalIH+1g

Some BPF programs cannot be built on distro kernels because required BTF
types or features are missing. A single failure currently aborts the
selftests/bpf build.

Make BPF object and skeleton generation best effort: emit SKIP-BPF or
SKIP-SKEL, remove failed outputs so downstream rules can detect absence,
and continue with remaining tests.

Signed-off-by: Ricardo B. Marlière <rbm@suse.com>
---
 tools/testing/selftests/bpf/Makefile | 77 ++++++++++++++++++++++++------------
 1 file changed, 51 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index f75c4f52c028..6052bba2c157 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -470,22 +470,26 @@ $(OUTPUT)/cgroup_getset_retval_hooks.o: cgroup_getset_retval_hooks.h
 # $4 - binary name
 define CLANG_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v3 -o $2
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v3 -o $2 || \
+		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2)
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with disabled alu32
 define CLANG_NOALU32_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v2 -o $2
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v2 -o $2 || \
+		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2)
 endef
 # Similar to CLANG_BPF_BUILD_RULE, but with cpu-v4
 define CLANG_CPUV4_BPF_BUILD_RULE
 	$(call msg,CLNG-BPF,$4,$2)
-	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v4 -o $2
+	$(Q)$(CLANG) $3 -O2 $(BPF_TARGET_ENDIAN) -c $1 -mcpu=v4 -o $2 || \
+		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2)
 endef
 # Build BPF object using GCC
 define GCC_BPF_BUILD_RULE
 	$(call msg,GCC-BPF,$4,$2)
-	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2
+	$(Q)$(BPF_GCC) $3 -DBPF_NO_PRESERVE_ACCESS_INDEX -Wno-attributes -O2 -c $1 -o $2 || \
+		($(RM) $2; printf '  %-12s %s\n' 'SKIP-BPF' '$(notdir $2)' 1>&2)
 endef
 
 SKEL_BLACKLIST := btf__% test_pinning_invalid.c test_sk_assign.c
@@ -591,32 +595,53 @@ $(TRUNNER_BPF_OBJS): $(TRUNNER_OUTPUT)/%.bpf.o:				\
 					  $$($$<-$2-CFLAGS),$(TRUNNER_BINARY))
 
 $(TRUNNER_BPF_SKELS): %.skel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
-	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$<
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked2.o) $$(<:.o=.linked1.o)
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o)
-	$(Q)diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
-	$(Q)$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$@
-	$(Q)$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h)
-	$(Q)rm -f $$(<:.o=.linked1.o) $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
+	$(Q)if [ ! -f $$< ]; then					\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
+		exit 0;							\
+	fi;								\
+	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2; \
+	$$(BPFTOOL) gen object $$(<:.o=.linked1.o) $$< &&		\
+	$$(BPFTOOL) gen object $$(<:.o=.linked2.o) $$(<:.o=.linked1.o) && \
+	$$(BPFTOOL) gen object $$(<:.o=.linked3.o) $$(<:.o=.linked2.o) && \
+	diff $$(<:.o=.linked2.o) $$(<:.o=.linked3.o) &&		\
+	$$(BPFTOOL) gen skeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$@ && \
+	$$(BPFTOOL) gen subskeleton $$(<:.o=.linked3.o) name $$(notdir $$(<:.bpf.o=)) > $$(@:.skel.h=.subskel.h) || { \
+		$$(RM) $$@ $$(@:.skel.h=.subskel.h); \
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
+	}; \
+	rm -f $$(<:.o=.linked1.o) $$(<:.o=.linked2.o) $$(<:.o=.linked3.o)
 
 $(TRUNNER_BPF_LSKELS): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
-	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY),$$@)
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$<
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o)
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o)
-	$(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
-	$(Q)$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
-	$(Q)rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
+	$(Q)if [ ! -f $$< ]; then					\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
+		exit 0;							\
+	fi;								\
+	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY)] $$(notdir $$@)' 1>&2; \
+	$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$< &&		\
+	$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o) && \
+	$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o) && \
+	diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o) &&		\
+	$$(BPFTOOL) gen skeleton -L $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@ || { \
+		$$(RM) $$@; \
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
+	}; \
+	rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
 
 $(TRUNNER_BPF_LSKELS_SIGNED): %.lskel.h: %.bpf.o $(BPFTOOL) | $(TRUNNER_OUTPUT)
-	$$(call msg,GEN-SKEL,$(TRUNNER_BINARY) (signed),$$@)
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$<
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o)
-	$(Q)$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o)
-	$(Q)diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
-	$(Q)$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@
-	$(Q)rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
+	$(Q)if [ ! -f $$< ]; then					\
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
+		exit 0;							\
+	fi;								\
+	printf '  %-12s %s\n' 'GEN-SKEL' '[$(TRUNNER_BINARY) (signed)] $$(notdir $$@)' 1>&2; \
+	$$(BPFTOOL) gen object $$(<:.o=.llinked1.o) $$< &&		\
+	$$(BPFTOOL) gen object $$(<:.o=.llinked2.o) $$(<:.o=.llinked1.o) && \
+	$$(BPFTOOL) gen object $$(<:.o=.llinked3.o) $$(<:.o=.llinked2.o) && \
+	diff $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o) &&		\
+	$$(BPFTOOL) gen skeleton $(LSKEL_SIGN) $$(<:.o=.llinked3.o) name $$(notdir $$(<:.bpf.o=_lskel)) > $$@ || { \
+		$$(RM) $$@; \
+		printf '  %-12s %s\n' 'SKIP-SKEL' '$$(notdir $$@)' 1>&2; \
+	}; \
+	rm -f $$(<:.o=.llinked1.o) $$(<:.o=.llinked2.o) $$(<:.o=.llinked3.o)
 
 $(LINKED_BPF_OBJS): %: $(TRUNNER_OUTPUT)/%
 

-- 
2.53.0

