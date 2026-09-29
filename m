Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 590492F9D98
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 01:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790646140; cv=none; b=uIdwSdrtYLX+YeRwdSbarBrdW+js/xlFIoXJGMXEImWgUjmZ8CSbErh6OY7ydeXL9sx+OHMisr7oYtuIKlsY7wpfJTUlgIFys9ic5XXmlCLUtoiITIaZqnspxTtVh5Gau061lXvBaWPDPGN2gP8VJfSfVHIrZATz5Ln0MzI1neg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790646140; c=relaxed/simple;
	bh=s5uqoUG7QDav+7ZWrcVDZitdoyc/biPAUBiOMwHCGpw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=D82LhiKFvmH/zDql8aPcBzOiMvnSqeY7DXJ0q8tJuGl/vcg38Q6NxxVl4unqR1+Q+NFFqPSPeLtfrQ8S9yvMsexvmBlwp5I5q/n9yVtAeeUadg+PpIaYS3yKW4up4kqA83+TSAHu8vDxcPd/gyDSVdR6cyj6oCvKqf/nqMStMQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DTCAvQLh; arc=none smtp.client-ip=74.125.82.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DTCAvQLh"
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-139b62317d0so1514642c88.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 18:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790646136; x=1791250936; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X58YJNIxUxKJ6QJtldaxa01wAToaRZxYcAz7pvIxPc8=;
        b=DTCAvQLhMDrqdPMABtw/Cu+IHye4O4CVC7PzAAZepnt22hLYFHgPVqeDUdZY2k8xga
         u28pPbAkjoh6k+RIF+u11lZw2q+MEbX778X50JbtBOB2v0nTZ6EC48UYOD5QYMFs8Cd8
         DArkaTpfymHiZG/TaSkp0bWrAeCHWlJeMcPDume1HRHK8MmQOm3AvbR5LwEv1olAbvO0
         2jLu3kI7rjBwo8ZJ+ffYtxw3aEtPaF9OYP3fnB6PLThpJ5w+RMfPfsG9v7GE7klwcatw
         GsXk4bE+66sRcnOJnivDwliD3OjgMc6/oOmTbslT4ea1VerHerdmlTv2ktiRxKL8J3Nc
         io6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790646136; x=1791250936;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X58YJNIxUxKJ6QJtldaxa01wAToaRZxYcAz7pvIxPc8=;
        b=FHP84RkN8sZ0DDqkZjs8rk+i8106ezLYZjvEUjyy0gTGj5oJGY7SEw212zKVczhir7
         RcBHl9Zapop9ZNJjqKmv+3PAPOsOCdsMfetptJLvgYFLZ8qBX/95WbY3u2grbBXMDCwV
         IHg2uFsetCvSZjHu4kaJKrzZg6y9WrVzSzJ6M2moADOYTGybK00A4+2C4idJvlyuf2yN
         0q9v5cwoXPFSj2wfWRIGhh4XUANC2ZI3hKz+WPfn5NgAWRavLGx2B6OWPbXvZeLcrWxc
         Pegz6NRJLhEaWQstDZDfRwQx/6Ds0okVRYw+f+gsOfVgdNVLxDlpiOvSZaa3+5WA55H3
         RdlQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlArSAZEHySoRqD2kDh+5qkPVrEuTlxJ7IQ1BgHSBQjughz1Kfo1DCBkanQjwpzGEAv0E=@vger.kernel.org
X-Gm-Message-State: AFuF++mJeBtowxzK01vKmlpuQbsk94PtjfTzb9/IzDUW2u4FU5KHg7fD
	h7zh4N8jr0O8reMZ4jM5A1GtxtqKW8My4ZUXIt6faJOTPOY4I6uuPpGoOBDuM1ZUll55DOPTelt
	pgXX/GktXMA==
X-Received: from dlbrn6.prod.google.com ([2002:a05:7022:1506:b0:144:dc56:6367])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:701b:4205:10b0:147:cd15:3eb
 with SMTP id a92af1059eb24-147cd1506b8mr9485157c88.6.1790646136078; Mon, 28
 Sep 2026 18:42:16 -0700 (PDT)
Date: Mon, 28 Sep 2026 18:42:06 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260929014206.4175245-1-irogers@google.com>
Subject: [PATCH v1] perf/core: Restore header fields in sideband output callbacks
From: Ian Rogers <irogers@google.com>
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	James Clark <james.clark@linaro.org>, Song Liu <song@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

perf_iterate_sb() invokes its callback for each matching perf_event on
the CPU and task context, passing a shared caller-allocated event
structure.

perf_event_header__init_id() increments header->size by
event->id_header_size. Unlike perf_event_task_output(),
perf_event_comm_output(), perf_event_namespaces_output(),
perf_event_cgroup_output(), perf_event_mmap_output(), and
perf_callchain_deferred_output(), three sideband callbacks failed to
save and restore header.size around perf_event_header__init_id():
- perf_event_ksymbol_output()
- perf_event_bpf_output()
- perf_event_text_poke_output()

When multiple events with attr.ksymbol, attr.bpf_event, or
attr.text_poke and sample_id_all are active on the same CPU, each
subsequent event receives a record whose header.size is inflated by all
preceding events' id_header_size values while only a single id_sample is
written, leaving uninitialized ring-buffer bytes at the end of the
record and causing userspace perf to fail with -EFAULT ("Bad address")
when parsing the sample_id trailer.

Similarly, perf_event_mmap_output() sets PERF_RECORD_MISC_MMAP_BUILD_ID
in mmap_event->event_id.header.misc when event->attr.build_id is
enabled, but only saved and restored header.size and header.type. If an
event with attr.build_id is followed by an event with attr.mmap2 and
!attr.build_id, the second event receives PERF_RECORD_MISC_MMAP_BUILD_ID
in header.misc while its payload contains maj/min/ino/ino_generation
instead of a build ID.

Save and restore header.size in the ksymbol, bpf, and text_poke output
callbacks, and save and restore header.misc in perf_event_mmap_output().

Fixes: 76193a94522f ("perf, bpf: Introduce PERF_RECORD_KSYMBOL")
Fixes: 6ee52e2a3fe4 ("perf, bpf: Introduce PERF_RECORD_BPF_EVENT")
Fixes: e17d43b93e54 ("perf: Add perf text poke event")
Fixes: 88a16a130933 ("perf: Add build id data in mmap2 event")
Assisted-by: Antigravity:gemini-3.1-pro
Signed-off-by: Ian Rogers <irogers@google.com>
---
 kernel/events/core.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 33210aff3ee6..ea3697295bd4 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9029,6 +9029,11 @@ static void perf_iterate_sb_cpu(perf_iterate_f output, void *data)
  *
  * For new callers; ensure that account_pmu_sb_event() includes
  * your event, otherwise it might not get delivered.
+ *
+ * Note: @data is shared across all @output calls, so any fields modified
+ * incrementally or conditionally (e.g. header.size via
+ * perf_event_header__init_id()) must be saved and restored by @output,
+ * or unconditionally re-initialized on each call.
  */
 static void
 perf_iterate_sb(perf_iterate_f output, void *data,
@@ -9723,6 +9728,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 	struct perf_sample_data sample;
 	int size = mmap_event->event_id.header.size;
 	u32 type = mmap_event->event_id.header.type;
+	u16 misc = mmap_event->event_id.header.misc;
 	bool use_build_id;
 	int ret;
 
@@ -9780,6 +9786,7 @@ static void perf_event_mmap_output(struct perf_event *event,
 out:
 	mmap_event->event_id.header.size = size;
 	mmap_event->event_id.header.type = type;
+	mmap_event->event_id.header.misc = misc;
 }
 
 static void perf_event_mmap_event(struct perf_mmap_event *mmap_event)
@@ -10244,6 +10251,7 @@ static void perf_event_ksymbol_output(struct perf_event *event, void *data)
 	struct perf_ksymbol_event *ksymbol_event = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
+	u16 header_size = ksymbol_event->event_id.header.size;
 	int ret;
 
 	if (!perf_event_ksymbol_match(event))
@@ -10254,13 +10262,15 @@ static void perf_event_ksymbol_output(struct perf_event *event, void *data)
 	ret = perf_output_begin(&handle, &sample, event,
 				ksymbol_event->event_id.header.size);
 	if (ret)
-		return;
+		goto out;
 
 	perf_output_put(&handle, ksymbol_event->event_id);
 	__output_copy(&handle, ksymbol_event->name, ksymbol_event->name_len);
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
+out:
+	ksymbol_event->event_id.header.size = header_size;
 }
 
 void perf_event_ksymbol(u16 ksym_type, u64 addr, u32 len, bool unregister,
@@ -10334,6 +10344,7 @@ static void perf_event_bpf_output(struct perf_event *event, void *data)
 	struct perf_bpf_event *bpf_event = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
+	u16 header_size = bpf_event->event_id.header.size;
 	int ret;
 
 	if (!perf_event_bpf_match(event))
@@ -10344,12 +10355,14 @@ static void perf_event_bpf_output(struct perf_event *event, void *data)
 	ret = perf_output_begin(&handle, &sample, event,
 				bpf_event->event_id.header.size);
 	if (ret)
-		return;
+		goto out;
 
 	perf_output_put(&handle, bpf_event->event_id);
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
+out:
+	bpf_event->event_id.header.size = header_size;
 }
 
 static void perf_event_bpf_emit_ksymbols(struct bpf_prog *prog,
@@ -10496,6 +10509,7 @@ static void perf_event_text_poke_output(struct perf_event *event, void *data)
 	struct perf_text_poke_event *text_poke_event = data;
 	struct perf_output_handle handle;
 	struct perf_sample_data sample;
+	u16 header_size = text_poke_event->event_id.header.size;
 	u64 padding = 0;
 	int ret;
 
@@ -10507,7 +10521,7 @@ static void perf_event_text_poke_output(struct perf_event *event, void *data)
 	ret = perf_output_begin(&handle, &sample, event,
 				text_poke_event->event_id.header.size);
 	if (ret)
-		return;
+		goto out;
 
 	perf_output_put(&handle, text_poke_event->event_id);
 	perf_output_put(&handle, text_poke_event->old_len);
@@ -10522,6 +10536,8 @@ static void perf_event_text_poke_output(struct perf_event *event, void *data)
 	perf_event__output_id_sample(event, &handle, &sample);
 
 	perf_output_end(&handle);
+out:
+	text_poke_event->event_id.header.size = header_size;
 }
 
 void perf_event_text_poke(const void *addr, const void *old_bytes,
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

