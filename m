Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D829E36EA89
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774788284; cv=none; b=PnU4nR7UXiwgmc7fCwA/8BJ0eEvq8MHXMcFmYWORUZsCvFPsv0CvjmkUgmnpqoQAt7W0VjjBUV5kk4Y+tE/Rm2ooVR7A1JrOsdycvVgm9WrDOofaT8DlFTr5cNf7BD48+ZZUB3r1RaZ0j3a0T5sq98B0ktHKoHGercZXsty7Xp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774788284; c=relaxed/simple;
	bh=PK/B5/m+1XQGZ0PZNEKpdGr3Ft9QtYAnnK49vqVqLmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujSq2atwV2gdNFMvdO5qtyiwqVmes0+3riUrsj3n5jIoeBn106bb/AOqnKMAM14ogHllPHDkyM2fO14iIFeJjTF2bNOnWDL05psQuSsD1WdUu876spZm4N2imWpLlZemuFl9HTEIvgIIkbhiVC5z4R7zCghZxapRrJuDWX4ZY20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=aDUkx+7d; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="aDUkx+7d"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-486fc4725f0so34481335e9.1
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 05:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774788280; x=1775393080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NWxT1mr1oAa3CoP2awZCKRtoQ2TWsw9MoC7aj8WH2Q=;
        b=aDUkx+7dXiXMMjziQURSZ5yJt75XR4baGnL3eturjHTolghhIl7qReH3VgekdVxcge
         DhNtKApdDI3ZDVXaYYHATF++dK6MrOcENGYUtKsxSRr2qW+mU+PUEkbVqnrSAMwf1OGX
         6kfbDVHiNoHwI7BXQiOcFxJbEshgFRSFAArLR9cZOqGejOihc3r1xe5ArbTcPnCnGe5U
         OBioUf3U+YjSeB5xlECMHMSo3KcCCzvnp/CAgQwKLTzu0x6v2MEQ9Awlv9U60P9/tRL8
         COqoi6AIn25awW5DPFdBRDf+RaZgSBBf/dzbzklo1FkT8xcRBUju3XczFyyBoBR/nqFy
         dxGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774788280; x=1775393080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8NWxT1mr1oAa3CoP2awZCKRtoQ2TWsw9MoC7aj8WH2Q=;
        b=WpCh8ymHPIF9/fZ7CXrzTwXSbKConOvN2tBZdwJuhqNYRaYOKNRU2r24Kl2uF/eP6l
         HpZyGp6U0/eUk9zEKtQQsHV4tiX4qtkNTC8rI8ChYjeqWuhFpkUj60AoPr2NDOS0RZyU
         A3lNChR6nPRgDVx3o32GYR9Vb4AJ5PDXeThjrmqj3ghbe7hrHjY4I63Cr/4T71i8m00e
         vKLYqHC2eEu1JIPYsy24D6EqW2zycV/A6YRRrQ//7j5N1YzSJa6bxXVW4lUbaGNDo2xq
         VBKAKZydQzoCbMclNBwagl7gX2wze/QwNmFjzE4vHEKqucNKYgPSGpNYz0Qe+rngWW/C
         uQ5g==
X-Gm-Message-State: AOJu0Yz69n2sXAez0iKxe1Zq9GbxQr28eNn3UW5mqFanmIG04aGmNyZm
	LoU4Jt9DV/SdYfShwtJnec4s1DTi8NzBSuPYipB7130fFu3YQxyUS3Kcn6XlB2VKtzCU6VMeGOe
	/holubxY=
X-Gm-Gg: ATEYQzzEi7kyDy+p7K83SbZ9CKCxsJt9YaMdi44BujEYFcsnhojQSUpfkDhdWCQc/n6
	dcIIRJgKD9kM9kMDmASy9fVfUHzsC7TcgHjBEbdBSVksyd6Wc5Af6oEVst/MG+UDtEVtoahEipO
	HLUYOGY/xK5yeu8Z5sSbhh+3L/JVTre7GPPFI5YGR0WnMtnTxRyRbLy9XNSEXh+OOIdZkuWlOFL
	GTNgzu+NDtKY03Ow9uPm8Nw7GS8sjE4/4K0quqQPkXnif7nBqzwx1+Ib67HW6PW/D2ZYv5lNooT
	ADrRIwEpyDyBxFP7OoiO7zJejg3qnb+4sH961dTu3afecsmtC0cglzj8ax37bq7ZvPfhewwZvZO
	yz4jaTca0d0yJgRNJbm9jEuja8FPobjKQXYlod0NdCh+6OZFBGs4R59tZy8VJDfMj735WTZqWdK
	wLfC/gv/AWf1IXpqwm+5B+Cc3bXX80lTB4siL5I9/kgb9gKsHPq9Uw9j+8gc2rDA==
X-Received: by 2002:a05:600c:638e:b0:485:3c09:843 with SMTP id 5b1f17b1804b1-48722be44b4mr223675595e9.9.1774788280515;
        Sun, 29 Mar 2026 05:44:40 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76916da892sm3700321a12.14.2026.03.29.05.44.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 05:44:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 1/2] libbpf: allow address-based single kprobe attach
Date: Sun, 29 Mar 2026 21:43:38 +0900
Message-ID: <20260329124429.689912-2-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260329124429.689912-1-hoyeon.lee@suse.com>
References: <20260329124429.689912-1-hoyeon.lee@suse.com>
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
 tools/lib/bpf/libbpf.c | 88 +++++++++++++++++++++++++++++-------------
 tools/lib/bpf/libbpf.h |  5 ++-
 2 files changed, 65 insertions(+), 28 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9ea41f40dc82..8e1e99ba38ad 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11523,7 +11523,8 @@ static int determine_uprobe_retprobe_bit(void)
 #define PERF_UPROBE_REF_CTR_OFFSET_SHIFT 32
 
 static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
-				 uint64_t offset, int pid, size_t ref_ctr_off)
+				 uint64_t offset_or_addr, int pid,
+				 size_t ref_ctr_off)
 {
 	const size_t attr_sz = sizeof(struct perf_event_attr);
 	struct perf_event_attr attr;
@@ -11558,7 +11559,7 @@ static int perf_event_open_probe(bool uprobe, bool retprobe, const char *name,
 	attr.type = type;
 	attr.config |= (__u64)ref_ctr_off << PERF_UPROBE_REF_CTR_OFFSET_SHIFT;
 	attr.config1 = ptr_to_u64(name); /* kprobe_func or uprobe_path */
-	attr.config2 = offset;		 /* kprobe_addr or probe_offset */
+	attr.config2 = offset_or_addr;	 /* kprobe_addr or probe_offset */
 
 	/* pid filter is meaningful only for uprobes */
 	pfd = syscall(__NR_perf_event_open, &attr,
@@ -11633,13 +11634,15 @@ static const char *tracefs_available_filter_functions_addrs(void)
 }
 
 static void gen_probe_legacy_event_name(char *buf, size_t buf_sz,
-					const char *name, size_t offset)
+					const char *name,
+					uint64_t offset_or_addr)
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
@@ -11648,13 +11651,28 @@ static void gen_probe_legacy_event_name(char *buf, size_t buf_sz,
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
+				   const char *kfunc_name,
+				   uint64_t offset_or_addr)
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
@@ -11674,25 +11692,29 @@ static int determine_kprobe_perf_type_legacy(const char *probe_name, bool retpro
 }
 
 static int perf_event_kprobe_open_legacy(const char *probe_name, bool retprobe,
-					 const char *kfunc_name, size_t offset, int pid)
+					 const char *kfunc_name,
+					 uint64_t offset_or_addr, int pid)
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
-			errstr(err));
+		pr_warn("failed to add legacy kprobe event for '%s': %s\n",
+			probe_target, errstr(err));
 		return err;
 	}
 	type = determine_kprobe_perf_type_legacy(probe_name, retprobe);
 	if (type < 0) {
 		err = type;
-		pr_warn("failed to determine legacy kprobe event id for '%s+0x%zx': %s\n",
-			kfunc_name, offset,
-			errstr(err));
+		pr_warn("failed to determine legacy kprobe event id for '%s': %s\n",
+			probe_target, errstr(err));
 		goto err_clean_legacy;
 	}
 
@@ -11784,6 +11806,9 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	enum probe_attach_mode attach_mode;
 	char *legacy_probe = NULL;
 	struct bpf_link *link;
+	uint64_t offset_or_addr;
+	char probe_target[128];
+	unsigned long addr;
 	size_t offset;
 	bool retprobe, legacy;
 	int pfd, err;
@@ -11794,8 +11819,18 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
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
@@ -11819,37 +11854,36 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 
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
 
-		pfd = perf_event_kprobe_open_legacy(legacy_probe, retprobe, func_name,
-						    offset, -1 /* pid */);
+		pfd = perf_event_kprobe_open_legacy(legacy_probe, retprobe,
+						    func_name, offset_or_addr,
+						    -1 /* pid */);
 	}
 	if (pfd < 0) {
-		err = -errno;
-		pr_warn("prog '%s': failed to create %s '%s+0x%zx' perf event: %s\n",
+		err = pfd;
+		pr_warn("prog '%s': failed to create %s '%s' perf event: %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe",
-			func_name, offset,
-			errstr(err));
+			probe_target, errstr(err));
 		goto err_out;
 	}
 	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
 	err = libbpf_get_error(link);
 	if (err) {
 		close(pfd);
-		pr_warn("prog '%s': failed to attach to %s '%s+0x%zx': %s\n",
+		pr_warn("prog '%s': failed to attach to %s '%s': %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe",
-			func_name, offset,
-			errstr(err));
+			probe_target, errstr(err));
 		goto err_clean_legacy;
 	}
 	if (legacy) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 0be34852350f..a5ad174d9add 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -563,9 +563,12 @@ struct bpf_kprobe_opts {
 	bool retprobe;
 	/* kprobe attach mode */
 	enum probe_attach_mode attach_mode;
+	/* kernel address for kprobe. If specified, offset must be 0 */
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

