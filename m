Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6666D5D474
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709710791; cv=none; b=aDYcjkF3uYy3lmqNH55RQRDl8poW/OfntRqtJA19W3uO++WTkdsALUI6YruuYWRtTZy/wFb6WiAd1mYu00tsm2o773fmWNAPNtTqcWTVC7svMYJNJ4E9cKJdbN05/BEXc0ZRGW/eYKlxQT0ZH6JaqHQ7Tvnrww5VLpWwSzHG+9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709710791; c=relaxed/simple;
	bh=j0BU+hdZp/Ekkgm4kRDElt6pVQ3Oqng2XJrJl/gH0ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ihx9TXN7pUlmLz0MWAs4Jmirue61Nc+u/kJDjo9flh9vXUby2jLCtUoDPTM2CPd0NzpG3Wtq4Um5o951l9QqGXf/g5UhE6Ly+MNgBMftjAXp+Eza92wryjopsC0OSRoMLaAlKb4xPXg1bpSX7rRy+gNBzJTiF9e1lGVQ/K9Rr04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TnklPJAL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="TnklPJAL"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a458eb7db13so75630566b.2
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 23:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709710787; x=1710315587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EfIYbSjn/LFCJX5yYTnie0A0VZaeiLz17KaDnMsDNwk=;
        b=TnklPJALs6vNjzjwHvQEZjhVjEYR4eV1HuBmzpk3Q76Nu3rtK6Jwqjhg0pZnIXkQB8
         TfoEYF+wBgl46heLTC7mmIgZbfl38NoMJQcgYXekCkZr8bsJnfohDJt5mMu77AEN7ALB
         3mUO0zLcfEf/N487A2b0sOIE+9jM06AUgFc5tCchqFQNbvp18wQ0RMpO3ftL1Xbv1PDX
         jBfM2kZcvk9wV2JxKi06psf0Uccf3ou9nL+JcFIA3iNiB0LLfXIEgLEvO7BjlADQ5YlZ
         3B44MaaVUapfHLhq9onuak3kj9ZjtVanzO0S3fl99ZNPSnArO6vCKf5EDXdWPBjlBeJi
         yK0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709710787; x=1710315587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfIYbSjn/LFCJX5yYTnie0A0VZaeiLz17KaDnMsDNwk=;
        b=mbsRDIlow7ZdlsABzm3bkk7XLGuAM1DthLDc3lYD21bNEEKnTnTkKPd4pifl8Hmauh
         9FhVZ5PKXKXdWdXjTTlzeU2K+MSNg22e1tPSBeaGm49rARQFjIs2Ykdra3L3rjhz1bKG
         iwga6i4q7P1LkAOt5RlxdAZ4UUIYbv+iOHg0iH3G8w9ncEEgq6DkJ40StlNfFvkEsrhV
         Nl7P0PpQmHtk9N1u4lG5z33KdfqUxYKsYM55ANqhPxotuCzyXrKh17d1NQ2KvErzkf4O
         ORXkGfwJDOTC/5oArOgFCqTUblQBxPEeRh+D+exclwNaF5xuLHW3/WbN0M/qdI50T/4u
         z0Tg==
X-Gm-Message-State: AOJu0Yw2OURqu5cXfRn8eM/53WKxDTW78ygJma31ybLHvXrc8NeLxteE
	0EwWF77WReDu0LXaaa1OqXyq+CQ3TsW9u77kZLhn+GkNN9fyIbKRSVY4GdIL7YaEGI6LLzC/UAA
	CmQ==
X-Google-Smtp-Source: AGHT+IEGm8Yg+W/a57m3eOInaBG+TLKqaXf+oNU0QTYTrMYCDZOVdkycqurZRK7OmHpVAX/4OSlN2A==
X-Received: by 2002:a17:906:f108:b0:a43:e63b:2ecc with SMTP id gv8-20020a170906f10800b00a43e63b2eccmr9777081ejb.67.1709710787504;
        Tue, 05 Mar 2024 23:39:47 -0800 (PST)
Received: from google.com (12.196.204.35.bc.googleusercontent.com. [35.204.196.12])
        by smtp.gmail.com with ESMTPSA id k23-20020a1709063e1700b00a42f6d48c72sm6909943eji.145.2024.03.05.23.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 23:39:47 -0800 (PST)
Date: Wed, 6 Mar 2024 07:39:43 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, kpsingh@google.com, jannh@google.com,
	jolsa@kernel.org, daniel@iogearbox.net, brauner@kernel.org,
	torvalds@linux-foundation.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH v2 bpf-next 3/9] bpf/selftests: add selftests for mm_struct
 acquire/release BPF kfuncs
Message-ID: <84fc8c3698b4ee83eece7ecef902a1a9a416eafb.1709675979.git.mattbobrowski@google.com>
References: <cover.1709675979.git.mattbobrowski@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1709675979.git.mattbobrowski@google.com>

Add a new mm_kfunc test suite that is responsible for verifying the
behaviour of the newly added mm_struct based BPF kfuncs. As of now,
these selftests cover the operability of the following:

struct mm_struct *bpf_task_mm_grab(struct task_struct *task);
void bpf_mm_drop(struct mm_struct *mm);

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 .../selftests/bpf/prog_tests/mm_kfunc.c       |  48 ++++++++
 .../selftests/bpf/progs/mm_kfunc_common.h     |  19 ++++
 .../selftests/bpf/progs/mm_kfunc_failure.c    | 103 ++++++++++++++++++
 .../selftests/bpf/progs/mm_kfunc_success.c    |  30 +++++
 4 files changed, 200 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/mm_kfunc.c
 create mode 100644 tools/testing/selftests/bpf/progs/mm_kfunc_common.h
 create mode 100644 tools/testing/selftests/bpf/progs/mm_kfunc_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/mm_kfunc_success.c

diff --git a/tools/testing/selftests/bpf/prog_tests/mm_kfunc.c b/tools/testing/selftests/bpf/prog_tests/mm_kfunc.c
new file mode 100644
index 000000000000..aece5c25486d
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/mm_kfunc.c
@@ -0,0 +1,48 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#define _GNU_SOURCE
+#include <test_progs.h>
+
+#include "mm_kfunc_failure.skel.h"
+#include "mm_kfunc_success.skel.h"
+
+static void run_test(const char *prog_name)
+{
+	struct bpf_link *link;
+	struct bpf_program *prog;
+	struct mm_kfunc_success *skel;
+
+	skel = mm_kfunc_success__open_and_load();
+	if (!ASSERT_OK_PTR(skel, "mm_kfunc_success__open_and_load"))
+		return;
+
+	link = NULL;
+	prog = bpf_object__find_program_by_name(skel->obj, prog_name);
+	if (!ASSERT_OK_PTR(prog, "bpf_object__find_program_by_name"))
+		goto cleanup;
+
+	link = bpf_program__attach(prog);
+	ASSERT_OK_PTR(link, "bpf_program__attach");
+cleanup:
+	bpf_link__destroy(link);
+	mm_kfunc_success__destroy(skel);
+}
+
+static const char * const success_tests[] = {
+	"task_mm_grab_drop_from_argument",
+	"task_mm_acquire_release_from_current",
+};
+
+void test_mm_kfunc(void)
+{
+	int i = 0;
+
+	for (; i < ARRAY_SIZE(success_tests); i++) {
+		if (!test__start_subtest(success_tests[i]))
+			continue;
+		run_test(success_tests[i]);
+	}
+
+	RUN_TESTS(mm_kfunc_failure);
+}
diff --git a/tools/testing/selftests/bpf/progs/mm_kfunc_common.h b/tools/testing/selftests/bpf/progs/mm_kfunc_common.h
new file mode 100644
index 000000000000..043d74d4148b
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mm_kfunc_common.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#ifndef _MM_KFUNC_COMMON_H
+#define _MM_KFUNC_COMMON_H
+
+#include <vmlinux.h>
+#include <errno.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+#include "bpf_misc.h"
+
+struct mm_struct *bpf_task_mm_grab(struct task_struct *task) __ksym;
+void bpf_mm_drop(struct mm_struct *mm) __ksym;
+
+char _license[] SEC("license") = "GPL";
+
+#endif /* _MM_KFUNC_COMMON_H */
diff --git a/tools/testing/selftests/bpf/progs/mm_kfunc_failure.c b/tools/testing/selftests/bpf/progs/mm_kfunc_failure.c
new file mode 100644
index 000000000000..d818dfcab20e
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mm_kfunc_failure.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include "mm_kfunc_common.h"
+
+SEC("lsm.s/file_open")
+__failure __msg("Possibly NULL pointer passed to trusted arg0")
+int BPF_PROG(task_mm_grab_null_kfunc)
+{
+	struct mm_struct *acquired;
+
+	/* Can't pass a NULL pointer to bpf_task_mm_grab(). */
+	acquired = bpf_task_mm_grab(NULL);
+	if (!acquired)
+		return 0;
+	bpf_mm_drop(acquired);
+
+	return 0;
+}
+
+SEC("lsm/task_free")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(task_mm_grab_from_lsm_task_free_kfunc, struct task_struct *task)
+{
+	struct mm_struct *acquired;
+
+	/* The task_struct supplied to this LSM hook isn't trusted. */
+	acquired = bpf_task_mm_grab(task);
+	if (!acquired)
+		return 0;
+	bpf_mm_drop(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__failure __msg("arg#0 pointer type STRUCT task_struct must point")
+int BPF_PROG(task_mm_grab_fp_kfunc, struct task_struct *task, u64 clone_flags)
+{
+	struct task_struct *fp;
+	struct mm_struct *acquired;
+
+	fp = (struct task_struct *)&clone_flags;
+	/* Can't pass random frame pointer to bpf_task_mm_grab(). */
+	acquired = bpf_task_mm_grab(fp);
+	if (!acquired)
+		return 0;
+	bpf_mm_drop(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__failure __msg("Unreleased reference")
+int BPF_PROG(task_mm_grab_unreleased_kfunc, struct task_struct *task)
+{
+	struct mm_struct *acquired;
+
+	acquired = bpf_task_mm_grab(task);
+	__sink(acquired);
+
+	/* Acquired but never released. */
+	return 0;
+}
+
+SEC("lsm.s/task_alloc")
+__failure __msg("R1 must be referenced or trusted")
+int BPF_PROG(task_mm_drop_untrusted_kfunc, struct task_struct *task)
+{
+	struct mm_struct *acquired;
+
+	/* task->mm from struct task_struct yields an untrusted pointer. */
+	acquired = task->mm;
+	if (!acquired)
+		return 0;
+	bpf_mm_drop(acquired);
+
+	return 0;
+}
+
+SEC("lsm/vm_enough_memory")
+__failure __msg("release kernel function bpf_mm_drop expects")
+int BPF_PROG(mm_drop_unacquired_kfunc, struct mm_struct *mm)
+{
+	/* Can't release an unacquired pointer. */
+	bpf_mm_drop(mm);
+
+	return 0;
+}
+
+SEC("lsm/vm_enough_memory")
+__failure __msg("arg#0 pointer type STRUCT mm_struct must point")
+int BPF_PROG(mm_drop_fp_kfunc, struct mm_struct *mm, long pages)
+{
+	struct mm_struct *fp;
+
+	fp = (struct mm_struct *)&pages;
+
+	/* Can't release random frame pointer. */
+	bpf_mm_drop(fp);
+
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/progs/mm_kfunc_success.c b/tools/testing/selftests/bpf/progs/mm_kfunc_success.c
new file mode 100644
index 000000000000..5400abd2ee2d
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/mm_kfunc_success.c
@@ -0,0 +1,30 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC. */
+
+#include "mm_kfunc_common.h"
+
+SEC("lsm.s/task_alloc")
+int BPF_PROG(task_mm_grab_drop_from_argument, struct task_struct *task)
+{
+	struct mm_struct *acquired;
+
+	acquired = bpf_task_mm_grab(task);
+	if (!acquired)
+		return 0;
+	bpf_mm_drop(acquired);
+
+	return 0;
+}
+
+SEC("lsm.s/file_open")
+int BPF_PROG(task_mm_acquire_release_from_current)
+{
+	struct mm_struct *acquired;
+
+	acquired = bpf_task_mm_grab(bpf_get_current_task_btf());
+	if (!acquired)
+		return 0;
+	bpf_mm_drop(acquired);
+
+	return 0;
+}
-- 
2.44.0.278.ge034bb2e1d-goog

/M
