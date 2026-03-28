Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68E29CE1
	for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 15:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774711666; cv=none; b=JiQ5qAIN+6AobK1uu5PUy+NPywPls4r9KOrmnT+qobpenoSTQ774IvQyM6fqsuBa7yB7eYVOBHbSSzdbd2DxVqgTYjNk3HzT2KDf7RVvZQPgKDkLiN2CmcW4dj6kPgESMIO19EWTgmcQBufcPsCe6Cwbq2j6RwidAgtH13utYKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774711666; c=relaxed/simple;
	bh=yL8Td9UZA88O3o7r3JW+BpHaCJ4yxltbSa4UhiL9gIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lddjHKIMnZIkOtUNnfiTRqVZxCw0lgevYcgyYl3BoA//l6+ICVJpHQGH8EBCI3T0dWHvUYPRZGLhsHNQoGFhuxmPbsiMkj2ybHkEGMI3aNm6XPKSHDTw/Q1dUb7eT9A7+F5GC9yqW+4N1GojP3OQJ0DB3vQd7ZI2qotPnyki+LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=GClIRyJQ; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="GClIRyJQ"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-66ba9898ae8so270613a12.1
        for <bpf@vger.kernel.org>; Sat, 28 Mar 2026 08:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774711663; x=1775316463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPuSW6pRsFeFjtweuNOAKbGLGRJBOpgP+7O/NYd7b34=;
        b=GClIRyJQVYE9BE+NxPVo3sYZLnnuYB3CDHYlrr0uwZanUO8BgH/VnzEVUnYbdvz+3r
         7UFogOanMVxOfMi/5sxVoJkyuqQp11EJYyoeKyaezj04AnlVEY4ELdpho5cyKeO9KFUC
         T4QAaD+luTnfAP8bukpDhNIecELRphRB/gCGQ4ZXCHx59V6AAAdury2jUgSBW3O1odsM
         bPBG6K2Lvoz8IMU+vy4qoI1eDlVqpU+HKUUUruThKSl46UMxfoMRd8c0i39cVMNN4J62
         6D+AVueFGaIbdrms3cUDlN6U1ttbL4x5/taqT4Jwlmw3dwKdF3P0Vrs9MYF7V2fL3iQX
         ijCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774711663; x=1775316463;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lPuSW6pRsFeFjtweuNOAKbGLGRJBOpgP+7O/NYd7b34=;
        b=Otv/KhXBMRkCOktBrNi1zH/kps6LEr7cDirxKDhWjjFvFP0LRxErQgHlC35KntrgMN
         pZokY61f4eqw0rl4et/Rx96RjXih7mYIy0hNl5azHY5j4XO4oAC835yH4bH0iAXS7AoD
         YuhJ/CUiYjLUO6u73K/1N5M57M/XqpW++FhKtoc9GSRno+h+M5dGKlEpmhILgAwGeLX1
         zseqKrBw6jiPeHsuSMJ2ed+SnfeW9kB7VlXDXAiBuJq9vPG/7qMWHSCgTxkbrt1WQ01a
         4TqgMKhx/RE0U3GwSA3/y8hl6/IcogTeb3cgaKlc4fNJOFHcEcQiu8VTHcHAr1ieEZzB
         +7mQ==
X-Gm-Message-State: AOJu0Yyaw7eJEyPwe1gUs0FlH0WAiofqelOayNyw5zaPVC18Bct3JoUj
	Xre6WhNGnBD+xt3Bxb5vh07Xlv6750ejDhm+ecB5VyIP0m9+A8NaP5z/fyp8ISnBsqi21WSPU0h
	vunqJlcw=
X-Gm-Gg: ATEYQzz7z59gelL8vwo8aG+Cpou7y76DyOTfyYAkbEqpscHqHPovb7oNEAdvHmQETWo
	qpVN69xSd87zxptC7nNNjN8p4BkZTvGDEOb1ApOeh5Cu7Tt9dfzQKSHoPsA++x6AFLPHx5V/k0f
	7Vu4CG2Uns7fE3Yr7IQD2oSA4RhxFeWL6coKP4e1BWrvhMMXNkUQnHzCC8kx7a+e37n5ZE5WcTQ
	j9MC5Dj2aKxkBFR5JxnB8hJINcZOZw2YdgnEX4rBUqzUREEAAZVwy8ah231TsFOFCB9/NErA1+d
	bfeloWYdJGEWEVns0BGDH3K0b0fvN9D8SEbp7Lttl1Bzq48ya4a5ztKrqUZTWvDsAXglFeWS3i0
	XiA2kEyNCxg7O9/mVSTDD32kcMjVw7ZV6MVFtVt54Ye1TdEl6IjhuT/xjqfDxSPMla9LeYhWUVR
	C5/ySTMQruosWWQubpz8DIJXxAGtQULWif3a4dar+vB79KrSFusIpOaH9GX0aj3A==
X-Received: by 2002:a05:600c:5956:b0:486:fe08:639a with SMTP id 5b1f17b1804b1-48722b813a4mr110789345e9.4.1774708012383;
        Sat, 28 Mar 2026 07:26:52 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76916da892sm1874017a12.14.2026.03.28.07.26.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 07:26:51 -0700 (PDT)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Feng Yang <yangfeng@kylinos.cn>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 1/2] libbpf: allow address-based single kprobe attach
Date: Sat, 28 Mar 2026 23:26:08 +0900
Message-ID: <20260328142643.627560-2-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328142643.627560-1-hoyeon.lee@suse.com>
References: <20260328142643.627560-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_program__attach_kprobe_opts() currently attaches a single kprobe only
by func_name, with an optional offset. This covers only the symbol-
based form, not the raw-address form that the kernel already supports
for both kprobe PMU events and legacy tracefs/debugfs kprobes. Callers
that already have a target IP still have to drop down to
perf_event_open() or direct tracefs writes.

libbpf already exposes address-based attach for kprobe_multi through
bpf_kprobe_multi_opts.addrs. This commit adds bpf_kprobe_opts.addr so
that single kprobes can be attached either by func_name + offset or by
raw address.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 tools/lib/bpf/libbpf.c | 77 +++++++++++++++++++++++++++++-------------
 tools/lib/bpf/libbpf.h |  5 ++-
 2 files changed, 57 insertions(+), 25 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9ea41f40dc82..a49ea01288ad 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11523,7 +11523,7 @@ static int determine_uprobe_retprobe_bit(void)
 #define PERF_UPROBE_REF_CTR_OFFSET_SHIFT 32
 
 static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
-				 uint64_t offset, int pid, size_t ref_ctr_off)
+				 uint64_t offset_or_addr, int pid, size_t ref_ctr_off)
 {
 	const size_t attr_sz = sizeof(struct perf_event_attr);
 	struct perf_event_attr attr;
@@ -11558,7 +11558,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	attr.type = type;
 	attr.config |= (__u64)ref_ctr_off << PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
 	attr.config1 = ptr_to_u64(name); /* kprobe_func or uprobe_path */
-	attr.config2 = offset;		 /* kprobe_addr or probe_offset */
+	attr.config2 = offset_or_addr;	 /* kprobe_addr or probe_offset */
 
 	/* pid filter is meaningful only for uprobes */
 	pfd = syscall(__NR_perf_event_open, &attr,
@@ -11633,13 +11633,14 @@ static const char *tracefs_available_filter_functions_addrs(void)
 }
 
 static void gen_probe_legacy_event_name(char *buf, size_t buf_sz,
-					const char *name, size_t offset)
+					const char *name, uint64_t offset_or_addr)
 {
 	static int index = 0;
 	int i;
 
-	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%zx", getpid(),
-		 __sync_fetch_and_add(&index, 1), name, offset);
+	snprintf(buf, buf_sz, "libbpf_%u_%d_%s_0x%" PRIx64, getpid(),
+		 __sync_fetch_and_add(&index, 1), name ?: "addr",
+		 offset_or_addr);
 
 	/* sanitize name in the probe name */
 	for (i = 0; buf[i]; i++) {
@@ -11648,13 +11649,27 @@ static void gen_probe_legacy_event_name(char *buf, size_t buf_sz,
 	}
 }
 
+static void gen_kprobe_target(char *buf, size_t buf_sz, const char *name,
+			      uint64_t offset_or_addr)
+{
+	if (name)
+		snprintf(buf, buf_sz, "%s+0x%" PRIx64, name, offset_or_addr);
+	else
+		snprintf(buf, buf_sz, "0x%" PRIx64, offset_or_addr);
+}
+
 static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
-				   const char *kfunc_name, size_t offset)
+				   const char *kfunc_name, uint64_t offset_or_addr)
 {
-	return append_to_file(tracefs_kprobe_events(), "%c:%s/%s %s+0x%zx",
+	char probe_target[128];
+
+	gen_kprobe_target(probe_target, sizeof(probe_target), kfunc_name,
+			  offset_or_addr);
+
+	return append_to_file(tracefs_kprobe_events(), "%c:%s/%s %s",
 			      retprobe ? 'r' : 'p',
 			      retprobe ? "kretprobes" : "kprobes",
-			      probe_name, kfunc_name, offset);
+			      probe_name, probe_target);
 }
 
 static int remove_kprobe_event_legacy(const char *probe_name, bool retprobe)
@@ -11674,24 +11689,27 @@ static int determine_kprobe_perf_type_legacy(const char *probe_name, bool retpro
 }
 
 static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
-					 const char *kfunc_name, size_t offset, int pid)
+					 const char *kfunc_name, uint64_t offset_or_addr, int pid)
 {
 	const size_t attr_sz = sizeof(struct perf_event_attr);
 	struct perf_event_attr attr;
 	int type, pfd, err;
+	char probe_target[128];
 
-	err = add_kprobe_event_legacy(probe_name, retprobe, kfunc_name, offset);
+	gen_kprobe_target(probe_target, sizeof(probe_target), kfunc_name,
+			  offset_or_addr);
+
+	err = add_kprobe_event_legacy(probe_name, retprobe, kfunc_name,
+				      offset_or_addr);
 	if (err < 0) {
-		pr_warn("failed to add legacy kprobe event for '%s+0x%zx': %s\n",
-			kfunc_name, offset,
+		pr_warn("failed to add legacy kprobe event for '%s': %s\n", probe_target,
 			errstr(err));
 		return err;
 	}
 	type = determine_kprobe_perf_type_legacy(probe_name, retprobe);
 	if (type < 0) {
 		err = type;
-		pr_warn("failed to determine legacy kprobe event id for '%s+0x%zx': %s\n",
-			kfunc_name, offset,
+		pr_warn("failed to determine legacy kprobe event id for '%s': %s\n", probe_target,
 			errstr(err));
 		goto err_clean_legacy;
 	}
@@ -11784,6 +11802,9 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	enum probe_attach_mode attach_mode;
 	char *legacy_probe = NULL;
 	struct bpf_link *link;
+	uint64_t offset_or_addr;
+	char probe_target[128];
+	unsigned long addr;
 	size_t offset;
 	bool retprobe, legacy;
 	int pfd, err;
@@ -11794,8 +11815,18 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	attach_mode = OPTS_GET(opts, attach_mode, PROBE_ATTACH_MODE_DEFAULT);
 	retprobe = OPTS_GET(opts, retprobe, false);
 	offset = OPTS_GET(opts, offset, 0);
+	addr = OPTS_GET(opts, addr, 0);
+	offset_or_addr = func_name ? offset : addr;
 	pe_opts.bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
 
+	if (!!func_name == !!addr)
+		return libbpf_err_ptr(-EINVAL);
+	if (addr && offset)
+		return libbpf_err_ptr(-EINVAL);
+
+	gen_kprobe_target(probe_target, sizeof(probe_target), func_name,
+			  offset_or_addr);
+
 	legacy = determine_kprobe_perf_type() < 0;
 	switch (attach_mode) {
 	case PROBE_ATTACH_MODE_LEGACY:
@@ -11819,26 +11850,25 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 
 	if (!legacy) {
 		pfd = perf_event_open_probe(false /* uprobe */, retprobe,
-					    func_name, offset,
+					    func_name, offset_or_addr,
 					    -1 /* pid */, 0 /* ref_ctr_off */);
 	} else {
 		char probe_name[MAX_EVENT_NAME_LEN];
 
 		gen_probe_legacy_event_name(probe_name, sizeof(probe_name),
-					    func_name, offset);
+					    func_name, offset_or_addr);
 
 		legacy_probe = strdup(probe_name);
 		if (!legacy_probe)
 			return libbpf_err_ptr(-ENOMEM);
 
 		pfd = perf_event_kprobe_open_legacy(legacy_probe, retprobe, func_name,
-						    offset, -1 /* pid */);
+						    offset_or_addr, -1 /* pid */);
 	}
 	if (pfd < 0) {
-		err = -errno;
-		pr_warn("prog '%s': failed to create %s '%s+0x%zx' perf event: %s\n",
-			prog->name, retprobe ? "kretprobe" : "kprobe",
-			func_name, offset,
+		err = pfd;
+		pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
+			prog->name, retprobe ? "kretprobe" : "kprobe", probe_target,
 			errstr(err));
 		goto err_out;
 	}
@@ -11846,9 +11876,8 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	err = libbpf_get_error(link);
 	if (err) {
 		close(pfd);
-		pr_warn("prog '%s': failed to attach to %s '%s+0x%zx': %s\n",
-			prog->name, retprobe ? "kretprobe" : "kprobe",
-			func_name, offset,
+		pr_warn("prog '%s': failed to attach to %s '%s': %s\n",
+			prog->name, retprobe ? "kretprobe" : "kprobe", probe_target,
 			errstr(err));
 		goto err_clean_legacy;
 	}
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 0be34852350f..526d44111e81 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -563,9 +563,12 @@ struct bpf_kprobe_opts {
 	bool retprobe;
 	/* kprobe attach mode */
 	enum probe_attach_mode attach_mode;
+	/* kernel address to install kprobe to; mutually exclusive with func_name */
+	unsigned long addr;
 	size_t :0;
 };
-#define bpf_kprobe_opts__last_field attach_mode
+
+#define bpf_kprobe_opts__last_field addr
 
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe(const struct bpf_program *prog, bool retprobe,
-- 
2.52.0

