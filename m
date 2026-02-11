Received: from mail-oi1-f195.google.com (mail-oi1-f195.google.com [209.85.167.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C1B345CA3
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 18:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770833581; cv=none; b=cA9DHeODGKd79jzXpxgQKWzKq2A1D41QKoA+PgS9FdcIp/hLWBWi7kZL5P78wZ2vDpTHIZYkDGQLl8c7clQ7sbNeegtY198aeP/6Aq3a5T+JZTeG4YGgNN9mWVGkhydYqk5vEXkxQEQZKiEkH0o+UL0F/5hGqmDRQMXRM2MiiwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770833581; c=relaxed/simple;
	bh=mSjoy8IXniDZgIas8nhoNJbvEg8LhPsnxq0UHb2D3og=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LaZhzryMgF6ntwf/kf9RsIQlp3xpIxV+vFsOX41+7trFPwwzTp/bSg5PpyRY9abT+zsnerFyLDLWKdn4au8yxgYTq5TZ1Mi+vgZakuLFXoAfoRe9ypRgo5uREqiZH7bZW9VNlT820nxpLU36ZKZ3A2DkXqrpmAkpryGWZTYskCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2xDw5Uo; arc=none smtp.client-ip=209.85.167.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2xDw5Uo"
Received: by mail-oi1-f195.google.com with SMTP id 5614622812f47-45f09874c4cso4349652b6e.3
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 10:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770833578; x=1771438378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=riP3JlXdVe0r+SPxFBx1GJVex0sNNScNIoQnYFKrHEI=;
        b=L2xDw5Uom1lA3bTYBhaysh2NTVudNuZ52251hEPc8QJcBQYF43tHT+xZAE4yR27/y3
         3BYCjUit1zlXT0X57rplzJgGcpg073XQJacBE1iAmmm/JYjUhae2qwJ9rxaPZdLn4Mbz
         +rXWaQdr3kRBkdInBaTJfh9QTcG5/vWAfdp7oiyfppEuFm4og2PO8CzgY2Ly3lB80zVl
         q1BDEuckv8HZWETpLQz/4e1m1OkjgrDsvX76eLatkkNZBvW8MlrrPA4LDmiFAnQv+/U7
         yRGfhID2u7MHwFSEdRVfMIabZHefDcPrrrkAvxTZAkUw2ePuEl7SCoP/RNlv93Fh8S4Q
         OxTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770833578; x=1771438378;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=riP3JlXdVe0r+SPxFBx1GJVex0sNNScNIoQnYFKrHEI=;
        b=EFPhzH6S5aMVbXdr7s+FKRHINHRlmZCPlkfMZlPUWCzLAE7zXS/zP3SqvHBdM1xxED
         VH0xpnc/Y2N12+KPZQ4v9DBUEAXiwYqqhDyjyUqRyobDFj8lsRSbzPrHRARHZ1oWCvSg
         GqbWfflOvxEjpfzekeG667WmoIeQbAoT1QIF4pUNNi0RGs4sVhKLC+EeiwYujZ+PGlF6
         cJrEkuzPVfg+avVAac//iLd+V0r7OGvzB4XN6jpmoqBHN06W68LesW/qOcRI6Bt+1S98
         mnGHpMIGH8OewvEDI084GpZRWylSshy7+cUBrcIHiCa02XNSiKvm3iAV3SNsYJ4KPVPj
         HvEg==
X-Gm-Message-State: AOJu0YxE/EWQLa8WqkBOo91wzu4Rwnhj+uuTEan/z2UXnEThdqtbkWLF
	JxCniOSaTmelZVn57ta09UYiK4n9V/1HtGT6MYAmhJvCjrVhJamxSDSPLejS8x+wjQLX+Q==
X-Gm-Gg: AZuq6aIMhHcC1G5AwlGqW0JqRfDKIium2A55ZU2ZaEfuNjvYia/Hrpvvaq5m2wNSSxE
	+L8PaEdTpHE+SCtZDfWRb5fE7tJ4uYPprIRItXdeVHc+WBcDYpxVCZfLTu4z3LuJDFpXFLJTNn9
	KCgqBUmxs4dTYUup1RiMpXFcy0HpV97Do42U2zLBpJYSkOUAJzom6VJ2yfnUgjs4Ob68Raks81p
	Hif6gzGNWhZi/1sgsrha79YXNT8dnAw0lL5VuqNCD0PEa0O6GvxnC7/zOgZ/Bm2/6F0yPTRgj6e
	YQRDMLK/5DrvmBtW9LxyR1KRpfzNjX0lSH6ofcIAlysjuRcpjAICjCLal09C2QQUciUIp4GE5d9
	BvPM5K0fu4Jn7jcAYQSwFY2je6OMFCYLyU2vCGu8U7MT3LGs0Dkwyrk6FBWyuwPD0XEXQ95AHsh
	oML9Vra7+9c97dHHGfa9lXj96oRowXw6TNeOyin6UHg6U=
X-Received: by 2002:a05:6808:c1d8:b0:450:caf8:ebc8 with SMTP id 5614622812f47-4637b90893emr109003b6e.55.1770833578275;
        Wed, 11 Feb 2026 10:12:58 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:8::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4636b064cd5sm1406463b6e.10.2026.02.11.10.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Feb 2026 10:12:57 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [RFC PATCH bpf-next v1 6/6] selftests/bpf: Extend conctest to wq and task_work
Date: Wed, 11 Feb 2026 10:12:46 -0800
Message-ID: <20260211181248.3040142-7-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260211181248.3040142-1-memxor@gmail.com>
References: <20260211181248.3040142-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7635; h=from:subject; bh=mSjoy8IXniDZgIas8nhoNJbvEg8LhPsnxq0UHb2D3og=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpjMUfD4cPhIAG87kLtZLcpNcGeRXTjmY/L2HHsTj+ QOP+FFOJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaYzFHwAKCRBM4MiGSL8Rysw2D/ 9pPMI5EOZeM9LpLeLLAR8+kh8fbyPveITjm2nG2hw94X0wnSTGL3F81EXCufTy2xTXCJlLCEdrv1lN j1x6nSexXGVjYYsX2YgNUllPXSYsyquhoskFQbb5PZX5bbcBk3gyJLSSAd8nW8VLzXt4+x2MwSYq7I KeawXa7TF2uEZYvHmxWJYmVIv2X3rVj+eN8rfYjcOXAvT7yQ80b6pgv0WfK8AQfamEehCvvlArZCfa edp0uHC1AM/6afBlM4pZR5j/zP32ClJ1I+GfTyrMv3d6pvFMuhEMjVsbY5PLQJUVn7EY/hJQVQHwLi 35qUJN5exYWbKCP0yykl25aROvp9UhFuE5bXE+T9MWeghNEpIObqI1nY3Kn06t0eIC5W4lbspefgbx L+MMYWOQ6qB1eHAJVWJ61dIQnSTyTVuc3iT3bGecBcyBI/NpH2XxXLzUvxj0f9jvYUYfcfftD7MA6o /iOBZaL9Xq2fmW1AiYeM9gyiYSfAGl1Cz9XZGq1nY8VzSl1/JyP3TTfD4eX2kFKkpWtDsSz5OkUaMN S6nrbj1rHC1zY1ZpVPXdJoSg7krS/yiiZJ/ZCVVGjhtQwBFeBePBTWm0ITd4ZZi+JWnrsgqbV/Ks2b MmaGXiKe5uj58kjYfTooinbD4oPp0cGDOcixlHlwS7Q8FjTxi85Wkq9owyGA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Extend coverage to various operations for wq and task_work.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/testing/selftests/bpf/conctest.c       |  46 ++++
 tools/testing/selftests/bpf/progs/conctest.c | 241 +++++++++++++++++++
 2 files changed, 287 insertions(+)

diff --git a/tools/testing/selftests/bpf/conctest.c b/tools/testing/selftests/bpf/conctest.c
index be6d3864d455..f1f9b0e9a78a 100644
--- a/tools/testing/selftests/bpf/conctest.c
+++ b/tools/testing/selftests/bpf/conctest.c
@@ -421,9 +421,55 @@ static struct conctest_suite timer_suite = {
 	.max_cpus = 4,
 };
 
+static void wq_init(struct conctest *skel, struct conctest_test *test)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, opts);
+	int fd;
+
+	fd = find_prog_fd(skel, "conctest_wq_init");
+	if (fd < 0)
+		return;
+	bpf_prog_test_run_opts(fd, &opts);
+}
+
+static struct conctest_op wq_ops[] = {
+	{ "start",  "conctest_wq_task_start",  "conctest_wq_nmi_start",  CTX_TASK_OK | CTX_NMI_OK },
+	{ "set_cb", "conctest_wq_task_set_cb", "conctest_wq_nmi_set_cb", CTX_TASK_OK | CTX_NMI_OK },
+	{ "delete", "conctest_wq_task_delete", "conctest_wq_nmi_delete", CTX_TASK_OK | CTX_NMI_OK },
+	{},
+};
+
+static const char *wq_extra_progs[] = { "conctest_wq_init", NULL };
+
+static struct conctest_suite wq_suite = {
+	.name = "wq",
+	.ops = wq_ops,
+	.nr_ops = 3,
+	.init = wq_init,
+	.extra_progs = wq_extra_progs,
+	.max_cpus = 4,
+};
+
+static struct conctest_op tw_ops[] = {
+	{ "signal", "conctest_tw_task_signal", "conctest_tw_nmi_signal", CTX_TASK_OK | CTX_NMI_OK },
+	{ "resume", "conctest_tw_task_resume", "conctest_tw_nmi_resume", CTX_TASK_OK | CTX_NMI_OK },
+	{ "delete", "conctest_tw_task_delete", "conctest_tw_nmi_delete", CTX_TASK_OK | CTX_NMI_OK },
+	{},
+};
+
+static struct conctest_suite tw_suite = {
+	.name = "task_work",
+	.ops = tw_ops,
+	.nr_ops = 3,
+	.init = NULL,
+	.max_cpus = 4,
+};
+
 static struct conctest_suite *suites[] = {
 	&rqspinlock_suite,
 	&timer_suite,
+	&wq_suite,
+	&tw_suite,
 	NULL,
 };
 
diff --git a/tools/testing/selftests/bpf/progs/conctest.c b/tools/testing/selftests/bpf/progs/conctest.c
index 703fd65c6ce3..4995846731ac 100644
--- a/tools/testing/selftests/bpf/progs/conctest.c
+++ b/tools/testing/selftests/bpf/progs/conctest.c
@@ -514,4 +514,245 @@ int conctest_timer_nmi_delete(void *ctx)
 	return 0;
 }
 
+struct wq_elem {
+	struct bpf_wq work;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct wq_elem);
+} wq_map SEC(".maps");
+
+static int wq_callback(void *map, int *key, void *val)
+{
+	return 0;
+}
+
+SEC("?syscall")
+int conctest_wq_init(void *ctx)
+{
+	struct wq_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&wq_map, &key);
+	if (!elem)
+		return -1;
+
+	ret = bpf_wq_init(&elem->work, &wq_map, 0);
+	if (ret)
+		return ret;
+
+	return bpf_wq_set_callback(&elem->work, wq_callback, 0);
+}
+
+SEC("?syscall")
+int conctest_wq_task_start(void *ctx)
+{
+	struct wq_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&wq_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_wq_start(&elem->work, 0);
+	conctest_record(CONCTEST_STAT_SYSCALL, ret, true);
+	return 0;
+}
+
+SEC("?syscall")
+int conctest_wq_task_set_cb(void *ctx)
+{
+	struct wq_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&wq_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_wq_set_callback(&elem->work, wq_callback, 0);
+	conctest_record(CONCTEST_STAT_SYSCALL, ret, true);
+	return 0;
+}
+
+SEC("?perf_event")
+int conctest_wq_nmi_start(void *ctx)
+{
+	struct wq_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&wq_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_wq_start(&elem->work, 0);
+	conctest_record(CONCTEST_STAT_NMI, ret, true);
+	return 0;
+}
+
+SEC("?perf_event")
+int conctest_wq_nmi_set_cb(void *ctx)
+{
+	struct wq_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&wq_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_wq_set_callback(&elem->work, wq_callback, 0);
+	conctest_record(CONCTEST_STAT_NMI, ret, true);
+	return 0;
+}
+
+SEC("?syscall")
+int conctest_wq_task_delete(void *ctx)
+{
+	struct wq_elem *elem;
+	int key = 0, ret;
+
+	conctest_begin();
+	ret = bpf_map_delete_elem(&wq_map, &key);
+	if (ret == 0) {
+		elem = bpf_map_lookup_elem(&wq_map, &key);
+		if (elem) {
+			bpf_wq_init(&elem->work, &wq_map, 0);
+			bpf_wq_set_callback(&elem->work, wq_callback, 0);
+		}
+	}
+	conctest_record(CONCTEST_STAT_SYSCALL, ret, true);
+	return 0;
+}
+
+SEC("?perf_event")
+int conctest_wq_nmi_delete(void *ctx)
+{
+	struct wq_elem *elem;
+	int key = 0, ret;
+
+	conctest_begin();
+	ret = bpf_map_delete_elem(&wq_map, &key);
+	if (ret == 0) {
+		elem = bpf_map_lookup_elem(&wq_map, &key);
+		if (elem) {
+			bpf_wq_init(&elem->work, &wq_map, 0);
+			bpf_wq_set_callback(&elem->work, wq_callback, 0);
+		}
+	}
+	conctest_record(CONCTEST_STAT_NMI, ret, true);
+	return 0;
+}
+
+struct tw_elem {
+	struct bpf_task_work tw;
+};
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, int);
+	__type(value, struct tw_elem);
+} tw_map SEC(".maps");
+
+static int tw_callback(struct bpf_map *map, void *key, void *value)
+{
+	return 0;
+}
+
+SEC("?syscall")
+int conctest_tw_task_signal(void *ctx)
+{
+	struct tw_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&tw_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_task_work_schedule_signal(bpf_get_current_task_btf(),
+					    &elem->tw, &tw_map, tw_callback);
+	conctest_record(CONCTEST_STAT_SYSCALL, ret, true);
+	return 0;
+}
+
+SEC("?syscall")
+int conctest_tw_task_resume(void *ctx)
+{
+	struct tw_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&tw_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_task_work_schedule_resume(bpf_get_current_task_btf(),
+					    &elem->tw, &tw_map, tw_callback);
+	conctest_record(CONCTEST_STAT_SYSCALL, ret, true);
+	return 0;
+}
+
+SEC("?perf_event")
+int conctest_tw_nmi_signal(void *ctx)
+{
+	struct tw_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&tw_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_task_work_schedule_signal(bpf_get_current_task_btf(),
+					    &elem->tw, &tw_map, tw_callback);
+	conctest_record(CONCTEST_STAT_NMI, ret, true);
+	return 0;
+}
+
+SEC("?perf_event")
+int conctest_tw_nmi_resume(void *ctx)
+{
+	struct tw_elem *elem;
+	int key = 0, ret;
+
+	elem = bpf_map_lookup_elem(&tw_map, &key);
+	if (!elem)
+		return 0;
+
+	conctest_begin();
+	ret = bpf_task_work_schedule_resume(bpf_get_current_task_btf(),
+					    &elem->tw, &tw_map, tw_callback);
+	conctest_record(CONCTEST_STAT_NMI, ret, true);
+	return 0;
+}
+
+SEC("?syscall")
+int conctest_tw_task_delete(void *ctx)
+{
+	int key = 0, ret;
+
+	conctest_begin();
+	ret = bpf_map_delete_elem(&tw_map, &key);
+	conctest_record(CONCTEST_STAT_SYSCALL, ret, true);
+	return 0;
+}
+
+SEC("?perf_event")
+int conctest_tw_nmi_delete(void *ctx)
+{
+	int key = 0, ret;
+
+	conctest_begin();
+	ret = bpf_map_delete_elem(&tw_map, &key);
+	conctest_record(CONCTEST_STAT_NMI, ret, true);
+	return 0;
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.47.3

