Received: from mail-dl1-f74.google.com (mail-dl1-f74.google.com [74.125.82.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6523D75B9
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778873631; cv=none; b=GOT2QP3DgCIxRqjQKAI2l4Q3ZxQZuor4DybdWCh2KiI+ig8tlZOZQibku6vlnZype/QUjCK/yTIgTKxPKww5LkvpfEoDtzl6bBxF2Sj+AoPTi6Qyww3wzyyWWR7coSnIgKhslIEx/mhswMRAZc0BnLDSDbUVIG0BndXY5Rx9LYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778873631; c=relaxed/simple;
	bh=hQlukLOZVHLrmaF7UJhnMMOJEFtrvOUvj8ak02rC+bs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bwfTZtAo7VW+/abzO4cmQ3Y3lsCGbNqQ6DjjIDGBIlc68LzAQUjZCDE74KXSDishQNSP35YF9SmY3jPNPZxUAQQXc3ozgmLp2CXAoJ2UYaDL5JSEyVHYODVww3InnfUUI2/xt/ruFYwuJeTIh5X8rXAxB9POG77rGEJA3q40aHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PbAYA0lK; arc=none smtp.client-ip=74.125.82.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PbAYA0lK"
Received: by mail-dl1-f74.google.com with SMTP id a92af1059eb24-12dece274b1so238465c88.1
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 12:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778873628; x=1779478428; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RnUwpkKiRATvP95xmLZOjUdMrUPtaTKbnsRX4E0c7tM=;
        b=PbAYA0lKas7brHJXDx7GpGz0J6RFMF2Knb0B06faXN+/U/XuyTGggNBh1B/d/aVlYB
         bbNKPgEf7gzv8DpPP0ohnhIN8MG056r7li00Wc8tesGPT5mykYXqmur3nARvJetkSPP4
         TrgVyz/PVyLcbvIsoCcEJkrjMneXHhVaEQdfvkB9AWAIOOOK6vyv8BDWolVLQgxQ++lY
         ZVwRWRH0whXiCgtLcXWp1qT8ZrW3f66DqD26bKzKW3Jn4OEl+HqYpk4Vf1GtONySJMlN
         shT+43NNKyax0IwDkg0FnY+J1gz4D9i2ylr8sRIKX2JvNq5oF+wBA7TL4oah4x26DSuZ
         YDRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778873628; x=1779478428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RnUwpkKiRATvP95xmLZOjUdMrUPtaTKbnsRX4E0c7tM=;
        b=onWOQwiZI1Jm78pNbE9XHh2oUzWzCUp63S88IpnWEeMw2337LR1HGQa9tPbA+7LF/h
         EBMtYXRDKY1f9JjDi1T5xhH52ziNsYpxPw3SU6HecuXKr6VVizgAFtZ8JLMF7FlOm1/3
         iSjZbcqht4ugvN6WaTkOlGQP5hOSeHnddzSipcWb7BQyhe2EiAHcVab6RKeJp4V1o8hV
         U6Uzi7XrwV7dR0kqT+Y/GT5DJN4DOm7TvTLPeiCuSaNo6UclWgFmXFjt0pxTkqpYcBE0
         SlJL4LJHm9TWKxdIjVR49yMgS+1unNTFhD3I16klX8vgHjXy9QNrbAKwZULrLchZZ36L
         p3Vw==
X-Forwarded-Encrypted: i=1; AFNElJ8ohsMg7WdfIv+vgaXD9HbgmTiw1QRHixkM7F09AvYe6qVOn1V086hNA1rcKUtgXVNmoHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEara6cyz9huKZ2k8MOGbMvOlFkClSnRzTaJyn5nJ2yTdm7uLe
	aBehcaSCiUSwpfhm+wqz0rWxvb+bWtC9L67ZyxzGQbldFPQ7xKOijAdRRUArxnI2seZGfvpnTXA
	Gg+/OmVZd7g==
X-Received: from dlai28.prod.google.com ([2002:a05:701b:271c:b0:132:8d92:4d7c])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:6720:b0:12d:b329:987d
 with SMTP id a92af1059eb24-1350473884fmr2468513c88.24.1778873628185; Fri, 15
 May 2026 12:33:48 -0700 (PDT)
Date: Fri, 15 May 2026 12:33:10 -0700
In-Reply-To: <20260515193314.1593560-1-irogers@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515173852.1378571-1-irogers@google.com> <20260515193314.1593560-1-irogers@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515193314.1593560-11-irogers@google.com>
Subject: [PATCH v5 10/14] perf pmu-events: Split big_c_string storage into
 standalone compilation unit
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

Currently, jevents.py emits both the massive 2.8 MB big_c_string literal
and tens of thousands of compact_pmu_event struct arrays into a single
pmu-events.c compilation unit. Compiling this giant file takes ~2.2 seconds
on a single CPU core during Kbuild startup.

Refactor jevents.py to emit big_c_string into a dedicated
pmu-events-string.c compilation unit. This allows Kbuild to compile
pmu-events.o and pmu-events-string.o simultaneously in parallel across
two separate CPU cores, preserving 100% string deduplication and zero
dynamic ELF relocations while cutting C compilation latency in half.

Add pmu-events-string.c to tools/perf/.gitignore to ensure in-tree Kbuild
runs do not leave untracked generated files in the working directory.

To guarantee 100% backward compatibility with GNU Make 4.0+ (avoiding the
Make 4.3+ grouped target &: syntax which causes older Make versions like
4.2.1 to spawn multiple concurrent jevents.py processes during parallel
builds), implement a robust dependency chaining pattern:
  $(PMU_EVENTS_C): $(JEVENTS_DEPS)
  $(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
          @:
This ensures jevents.py is invoked exactly once. If jevents.py aborts
early, Make's .DELETE_ON_ERROR: purges pmu-events.c, guaranteeing that
subsequent Make invocations correctly re-execute the script and overwrite
pmu-events-string.c. In jevents.py, defer closing output_string_file until
the absolute tail of main() to guarantee identical modification timestamps
with output_file, preventing redundant rebuilds during incremental runs.

Tested-by: James Clark <james.clark@linaro.org>
Assisted-by: Gemini:gemini-3.1-pro-preview
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/.gitignore            |  1 +
 tools/perf/Makefile.perf         |  4 ++--
 tools/perf/pmu-events/Build      | 16 +++++++++++++++-
 tools/perf/pmu-events/jevents.py | 22 ++++++++++++++++++----
 4 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/tools/perf/.gitignore b/tools/perf/.gitignore
index 0f9451a6e39c..3b968c5158b8 100644
--- a/tools/perf/.gitignore
+++ b/tools/perf/.gitignore
@@ -38,6 +38,7 @@ arch/*/include/generated/
 trace/beauty/generated/
 pmu-events/arch/common/common/legacy-cache.json
 pmu-events/pmu-events.c
+pmu-events/pmu-events-string.c
 pmu-events/jevents
 pmu-events/metric_test.log
 pmu-events/empty-pmu-events.log
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 96a68723109f..b8a81c9749a8 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -925,7 +925,7 @@ bpf-skel-clean:
 pmu-events-clean:
 ifeq ($(OUTPUT),)
 	$(call QUIET_CLEAN, pmu-events) $(RM) \
-		pmu-events/pmu-events.c \
+		pmu-events/pmu-events*.c \
 		pmu-events/metric_test.log \
 		pmu-events/test-empty-pmu-events.c \
 		pmu-events/empty-pmu-events.log
@@ -933,7 +933,7 @@ ifeq ($(OUTPUT),)
 		-name 'extra-metricgroups.json' -delete
 else # When an OUTPUT directory is present, clean up the copied pmu-events/arch directory.
 	$(call QUIET_CLEAN, pmu-events) $(RM) -r $(OUTPUT)pmu-events/arch \
-		$(OUTPUT)pmu-events/pmu-events.c \
+		$(OUTPUT)pmu-events/pmu-events*.c \
 		$(OUTPUT)pmu-events/metric_test.log \
 		$(OUTPUT)pmu-events/test-empty-pmu-events.c \
 		$(OUTPUT)pmu-events/empty-pmu-events.log
diff --git a/tools/perf/pmu-events/Build b/tools/perf/pmu-events/Build
index dc1df2d57ddc..95172a2a851f 100644
--- a/tools/perf/pmu-events/Build
+++ b/tools/perf/pmu-events/Build
@@ -1,7 +1,12 @@
 EMPTY_PMU_EVENTS_C = pmu-events/empty-pmu-events.c
 # pmu-events.c will be generated by jevents.py or copied from EMPTY_PMU_EVENTS_C
 PMU_EVENTS_C	=  $(OUTPUT)pmu-events/pmu-events.c
+PMU_EVENTS_STRING_C = $(OUTPUT)pmu-events/pmu-events-string.c
+
 pmu-events-y	+= pmu-events.o
+ifneq ($(NO_JEVENTS),1)
+pmu-events-y	+= pmu-events-string.o
+endif
 
 # pmu-events.c file is generated in the OUTPUT directory so it needs a
 # separate rule to depend on it properly
@@ -9,6 +14,10 @@ $(OUTPUT)pmu-events/pmu-events.o: $(PMU_EVENTS_C)
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
+$(OUTPUT)pmu-events/pmu-events-string.o: $(PMU_EVENTS_STRING_C)
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
+
 # Message for $(call echo-cmd,cp), possibly remove the src file from
 # the destination to save space in the build log.
 quiet_cmd_cp   = COPY    $(patsubst %$<,%,$@) <- $<
@@ -118,6 +127,7 @@ CUR_OUT_JSON	:= $(shell [ -d $(OUT_DIR) ] && find $(OUT_DIR) -type f)
 
 # Things in the OUTPUT directory but shouldn't be there as computed by
 # OUT_JSON and GEN_JSON.
+
 ORPHAN_FILES	:= $(filter-out $(OUT_JSON) $(GEN_JSON),$(CUR_OUT_JSON))
 
 # Message for $(call echo-cmd,mkd). There is already a mkdir message
@@ -224,6 +234,10 @@ endif
 # and inputs are dependencies.
 $(PMU_EVENTS_C): $(JEVENTS_DEPS)
 	$(call rule_mkdir)
-	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) $(OUT_DIR) $@
+	$(Q)$(call echo-cmd,gen)$(PYTHON) $(JEVENTS_PY) $(JEVENTS_ARCH) $(JEVENTS_MODEL) \
+            $(OUT_DIR) $(PMU_EVENTS_C) $(PMU_EVENTS_STRING_C)
+
+$(PMU_EVENTS_STRING_C): $(PMU_EVENTS_C)
+	@:
 
 endif # ifeq ($(NO_JEVENTS),1)
diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
index 3a1bcdcdc685..db5595457979 100755
--- a/tools/perf/pmu-events/jevents.py
+++ b/tools/perf/pmu-events/jevents.py
@@ -1422,6 +1422,8 @@ such as "arm/cortex-a34".''',
   )
   ap.add_argument(
       'output_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=sys.stdout)
+  ap.add_argument(
+      'output_string_file', type=argparse.FileType('w', encoding='utf-8'), nargs='?', default=None)
   _args = ap.parse_args()
 
   _args.output_file.write(f"""
@@ -1463,10 +1465,20 @@ struct pmu_table_entry {
     ftw(arch_path, [], preprocess_one_file)
 
   _bcs.compute()
-  _args.output_file.write('static const char *const big_c_string =\n')
-  for s in _bcs.big_string:
-    _args.output_file.write(s)
-  _args.output_file.write(';\n\n')
+  if not _args.output_string_file:
+    _args.output_file.write('static const char *const big_c_string =\n')
+    for s in _bcs.big_string:
+      _args.output_file.write(s)
+    _args.output_file.write(';\n\n')
+  else:
+    _args.output_string_file.write('/* SPDX-License-Identifier: GPL-2.0 */\n')
+    _args.output_string_file.write('/* Autogenerated by jevents.py */\n')
+    _args.output_string_file.write('extern const char big_c_string[];\n')
+    _args.output_string_file.write('const char big_c_string[] =\n')
+    for s in _bcs.big_string:
+      _args.output_string_file.write(s)
+    _args.output_string_file.write(';\n')
+    _args.output_file.write('extern const char big_c_string[];\n\n')
   for arch in archs:
     arch_path = f'{_args.starting_dir}/{arch}'
     ftw(arch_path, [], process_one_file)
@@ -1476,6 +1488,8 @@ struct pmu_table_entry {
   print_mapping_table(archs)
   print_system_mapping_table()
   print_metricgroups()
+  if _args.output_string_file:
+    _args.output_string_file.close()
 
 if __name__ == '__main__':
   main()
-- 
2.54.0.563.g4f69b47b94-goog

