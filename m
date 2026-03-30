Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0E33C50D
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 11:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868461; cv=none; b=F4sv5nBpKAWcslef3ZodZyX3uiCUNG8pJOnl/vpRCL4nf0q3ZQ9XuEfgTgrd2ydsDoVCep0GU8FCbP4kVBVr7fXlsOVfUTj2KD5zYlKVakpTn61oLj+4KHV5gDB51x80VERx8+iW+LdG/rxPeZqU2Ihuc+260t8AhFzeaOQtGDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868461; c=relaxed/simple;
	bh=BeYgyaBVMNH2YkkmIL4dka2nySItV+VavSBb7RGud1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvQE2/mTN4iqisvUkxXpbXDAmn1CcCqJel+9gseam5BPmeEsFp3lS64ecmNN9oTNDd0+POlUUFTaeDapYhIhGFDpRocp6zI8NfmRDIHsnlewmw8wazwgp8plhh8DPXxN/rFwjJzUiRGshjM2VRdPkKLfIMhIM/C+B/xhy5oqm48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dI/lEc2/; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dI/lEc2/"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c76864f4e58so1179247a12.1
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 04:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774868455; x=1775473255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tiAaielosONeq8lfjBldJ8eg8rZvO6xA8Ahk7S8YwtM=;
        b=dI/lEc2/kBwloVOfEUgc+XnVL7MXykZJ9WuINJQlaDeqfE3dRYI9j9g/jPK61CVyxQ
         P7C/c3hsBvSr9OKO/ZIIUyo84tBkH8kHTGOsw5Goil7n1EV7WjhuM2MNyuw0dYUq7JtX
         QOCM0apREQ14H+mrSlUFZ1txa6SwLzIc2Fkfh8o9KXqoH6FCJkNTgOoi/ui5/Ge/5g0w
         3F+wBJBGt8At4T4oEE1/IltU6usjM+6eqA2nPzEA2DLYyg76TCBe0yDv9ped6BfgD0/a
         Hc1QBYZZqi31JLPw6aU/3uO0x8OVSNwMvMDEWNbWPQD25T+b2C7Oo+NE4OjG2I732jxh
         FcWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774868455; x=1775473255;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tiAaielosONeq8lfjBldJ8eg8rZvO6xA8Ahk7S8YwtM=;
        b=Gg6BK21aXFA80oeR0xhV+0FCJeeYyMekINCpXFeFeMXLpDmsGMLxGSmf7c71ZvJh54
         zEdlb5ELnP3KDy/TLolf2eP5Ui+rOlkJ19VXwMYtVM9JitH/g5Bq0gFrdR+jHbklHimJ
         0Z5zi6S2cZ6KDu5RKxspibLO5j5YUe3jZOTa3OL8MyBDR7jUvrLiI7JUZhsu7Ukc76BD
         tIfUqC/WruSS0jU/dtHYFJXJnZYvk33nrRbuytEbyGUbAZmhn9OIP2K5LizH3Wq/jXsL
         /LK3ZH3DxHD2xcH1kT1IPVLtnqlHek0QEqSV2iRwyXEyoJ62PEZ9D29N81wi6yNPIGN1
         /gug==
X-Forwarded-Encrypted: i=1; AJvYcCWi7FF4RL3SCXGU5qiiZjJZN+xQ45NhAWikqQKqIhOhJa7lChwZQsiY2VxxMeXijjZmtJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBezQ5FN1sm84FvR+zshryMrezueDc5F+MTt5EqiZBqg9ScqCn
	UOZlToEFpgCIR6arE/SJkst1QpYBeKL2NWqB/iLwhlBb0z2N5kEp2psG
X-Gm-Gg: ATEYQzzNCvEFsyH5sM7Wv0qYJFUxWVmQ5amBumC2tU9qK7dm5nYabLFSNFGVpudHYUn
	tz4dYSwjQ8Yp1u9YHJRMZh+7Qf1EHwEHFFdcjFKZXlij5kYXu3o5Gei71aNSvBF4WCz45P+6+r2
	zLvLLokL0+cE4GP4JtPdZlQnQVduPY7KnR8P/VQoXIYFqwU8hTPFIDsiTmlpT7DcrecagQg2V2V
	PPDLYHk22HXMquaXZlmkLdBZtZy108eTZRVErpIf7BtEJuts2nT2/3/hjbu8tZefEeKtjXghxv0
	8CEfL4Z9OP9l0bkbKb+gqvY8Mh8NDgUtwR2JiQrurlBhvBDl2KIEKuV/hYcSQJnwHltNSUueJp9
	4HNEip8BIwLQGLB2J0SwLaCOjm53NKA8ROZD0Nd4prYixugtxv4T2Jew3odrgcD4ogX4mHvSwIh
	KejwSSzqqktdCJeuKUCQ+t4xmoy+8Ur0BuIgq8DT4w+ElPRQdjwee4rLKQJTab0yeuKhNB9xI/h
	Q==
X-Received: by 2002:a05:6a20:3d06:b0:398:aea8:a9c0 with SMTP id adf61e73a8af0-39c8780d9aamr12405100637.19.1774868455294;
        Mon, 30 Mar 2026 04:00:55 -0700 (PDT)
Received: from eris-fedora.iitr.ac.in ([103.37.201.189])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917d843esm6806615a12.29.2026.03.30.04.00.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:00:54 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: andrii@kernel.org,
	alan.maguire@oracle.com,
	yonghong.song@linux.dev,
	song@kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	puranjay@kernel.org,
	bjorn@kernel.org,
	leon.hwang@linux.dev,
	varunrmallya@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH bpf-next v2 1/3] libbpf: Auto-upgrade uprobes to multi-uprobes when supported
Date: Mon, 30 Mar 2026 16:30:17 +0530
Message-ID: <20260330110019.549079-2-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260330110019.549079-1-varunrmallya@gmail.com>
References: <20260330110019.549079-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch modifies libbpf to automatically "upgrade" standard
SEC("uprobe") and SEC("uretprobe") programs to use the multi-uprobe
infrastructure (BPF_TRACE_UPROBE_MULTI) at load time if the kernel
supports it, making them compatible with BPF tokens.

To maintain backward compatibility and handle rare cases where singular
uprobes are required, new SEC("uprobe.single") and SEC("uretprobe.single")
section types are introduced. These force libbpf to use the legacy
perf_event_open() attachment path.

tools/testing/selftests/bpf/progs/test_fill_link_info.c has been
modified to use SEC("uprobe.single") as it asserts the program type to be
`BPF_LINK_TYPE_PERF_EVENT` and checks properties related to uprobes that
use perf.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 tools/lib/bpf/libbpf.c                        | 53 +++++++++++++++++--
 .../selftests/bpf/progs/test_fill_link_info.c |  2 +-
 2 files changed, 51 insertions(+), 4 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1eaa7527d4da..bd7b6f486430 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8248,6 +8248,23 @@ static int bpf_object_prepare_progs(struct bpf_object *obj)
 
 	for (i = 0; i < obj->nr_programs; i++) {
 		prog = &obj->programs[i];
+
+		if (kernel_supports(obj, FEAT_UPROBE_MULTI_LINK)) {
+			const char *sec_name = prog->sec_name;
+			/* Here, we filter out for u[ret]probe or "u[ret]probe/"
+			 * but we leave out anything with an '@'
+			 * in it as uprobe_multi does not support versioned
+			 * symbols yet, so we don't upgrade.
+			 */
+			if (((strncmp(sec_name, "uprobe", 6) == 0 &&
+			      (sec_name[6] == '/' || sec_name[6] == '\0')) ||
+			     (strncmp(sec_name, "uretprobe", 9) == 0 &&
+			      (sec_name[9] == '/' || sec_name[9] == '\0'))) &&
+			    !strchr(sec_name, '@')) {
+				prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
+			}
+		}
+
 		err = bpf_object__sanitize_prog(obj, prog);
 		if (err)
 			return err;
@@ -9909,9 +9926,11 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("kprobe+",		KPROBE,	0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uprobe+",		KPROBE,	0, SEC_NONE, attach_uprobe),
 	SEC_DEF("uprobe.s+",		KPROBE,	0, SEC_SLEEPABLE, attach_uprobe),
+	SEC_DEF("uprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),
 	SEC_DEF("kretprobe+",		KPROBE, 0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uretprobe+",		KPROBE, 0, SEC_NONE, attach_uprobe),
 	SEC_DEF("uretprobe.s+",		KPROBE, 0, SEC_SLEEPABLE, attach_uprobe),
+	SEC_DEF("uretprobe.single+",	KPROBE,	0, SEC_NONE, attach_uprobe),
 	SEC_DEF("kprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("kretprobe.multi+",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
 	SEC_DEF("kprobe.session+",	KPROBE,	BPF_TRACE_KPROBE_SESSION, SEC_NONE, attach_kprobe_session),
@@ -12737,6 +12756,32 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 		func_offset += sym_off;
 	}
 
+	/* This provides backwards compatibility to programs using uprobe, but
+	 * have been auto-upgraded to multi uprobe.
+	 */
+	if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI) {
+		LIBBPF_OPTS(bpf_uprobe_multi_opts, multi_opts);
+		unsigned long offsets[1] = {func_offset};
+		__u64 bpf_cookie;
+
+		multi_opts.retprobe = OPTS_GET(opts, retprobe, false);
+		if (offsets[0] || func_name) {
+			multi_opts.offsets = offsets;
+			multi_opts.cnt = 1;
+		}
+		if (ref_ctr_off) {
+			multi_opts.ref_ctr_offsets = &ref_ctr_off;
+			multi_opts.cnt = 1;
+		}
+		bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
+		if (bpf_cookie) {
+			multi_opts.cookies = &bpf_cookie;
+			multi_opts.cnt = 1;
+		}
+
+		return bpf_program__attach_uprobe_multi(prog, pid, binary_path,
+							NULL, &multi_opts);
+	}
 	legacy = determine_uprobe_perf_type() < 0;
 	switch (attach_mode) {
 	case PROBE_ATTACH_MODE_LEGACY:
@@ -12830,6 +12875,7 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
 	char *probe_type = NULL, *binary_path = NULL, *func_name = NULL, *func_off;
 	int n, c, ret = -EINVAL;
 	long offset = 0;
+	bool is_retprobe;
 
 	*link = NULL;
 
@@ -12856,13 +12902,14 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
 			else
 				offset = 0;
 		}
-		opts.retprobe = strcmp(probe_type, "uretprobe") == 0 ||
-				strcmp(probe_type, "uretprobe.s") == 0;
-		if (opts.retprobe && offset != 0) {
+		is_retprobe = strcmp(probe_type, "uretprobe") == 0 ||
+			      strcmp(probe_type, "uretprobe.s") == 0;
+		if (is_retprobe && offset != 0) {
 			pr_warn("prog '%s': uretprobes do not support offset specification\n",
 				prog->name);
 			break;
 		}
+		opts.retprobe = is_retprobe;
 		opts.func_name = func_name;
 		*link = bpf_program__attach_uprobe_opts(prog, -1, binary_path, offset, &opts);
 		ret = libbpf_get_error(*link);
diff --git a/tools/testing/selftests/bpf/progs/test_fill_link_info.c b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
index fac33a14f200..8e47a818462f 100644
--- a/tools/testing/selftests/bpf/progs/test_fill_link_info.c
+++ b/tools/testing/selftests/bpf/progs/test_fill_link_info.c
@@ -28,7 +28,7 @@ int BPF_PROG(kprobe_run)
 	return 0;
 }
 
-SEC("uprobe")
+SEC("uprobe.single")
 int BPF_PROG(uprobe_run)
 {
 	return 0;
-- 
2.52.0

