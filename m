Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F895397E76
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 12:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220285; cv=none; b=Dbj9hdYxjDb8DWjfq+xP66SmWYnzUsuBSpyISeHnD0BfsGCXuJ/uzl5Ydsqljyt+/mWnV013UFNlw3eFERWxtlLWDc6BOJoyQFtZyM4u2UtafEC5tNF38oI53Jc5WvuVp3Ou7vPRt51bug4UHoKOu30rq7eXd92PipBNE+Qma3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220285; c=relaxed/simple;
	bh=eYjKVYfzybQe+jxVsJmjY9ny8NiQl/98X514K3TLT+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NRVosM09fh6M5R4mLKpjdGeEL3FPYF/ATgFCdp2BbNEp0Ov24xYuBNv3PztVx1Q5dCqj+QqxZZ8RnNqWDr6QdOKMnJAOn1jLKP0Awou3c8CujIW3rUcMaCZGL4VSevNMJLDogA5SBuKU8bSnHD+vCt+YHmR5g0qGCT7rbjmBWMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s5Tcc1Pw; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s5Tcc1Pw"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-35d971fb6f1so1607040a91.0
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 05:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775220282; x=1775825082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kYq4HbaySt1VUvMx+E+B5KGWRejftYj4KcJChzS3H2o=;
        b=s5Tcc1PwPhOLpZT0euiiuvGyOJvMX0s1hEVoohnFYNDZXJRe9Le/fzeBPZk3Umr2L7
         MD0rzBgc1LBv53Aumag0hbkfcT72kdL7i4ZYmtAUNLJOxX/KYTrERFd4aQ6x2PnAAMVP
         OExk95mdNMbvvRrjBGm/p8B/1Y3JwjFHZqY3mGA0HCImgCo5fIGH5VYsf4YdqGrBknjW
         74G10ZnElkc+/MdxiI+V5GJnxbsyQF9oRRp4KUxJhfIDR4Nt1/o5skY2tfYl6ru33NlX
         zdIzFx2Ht3ARHMUHFBWE15v9Z+blOhKu5hay7GJC4J7W0j6uJ8+KNDawh9uS4GJajtKE
         owUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775220282; x=1775825082;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kYq4HbaySt1VUvMx+E+B5KGWRejftYj4KcJChzS3H2o=;
        b=hxVlQpB0gyqMGkqA6JammXW5EzB7Mlk0UDzbrX9X49HqtoXunUDNtmaKf3jKTmZDUk
         vTTzKlhALFqvy61G5Oe9XN5tKL9qhjxRfIF5IhnLa1rvATBvFA/MMUtDQ42PJ/nkQ6tM
         0Xw6e/cl8bDi17T2/xpI7pp5y6p6w7rAwBf4GMbt+gAG2K8wQIvgPea0qwKJvqEKVdEd
         PMzE7LqD+BZpYNVnkAdbCIs7VP9GNVj6W8MN42a92D07W2gtFay0ps5CumZvyD/vL6HB
         5r8VvorkeKn/vr9/U0UQjgxOzLvN9LAu4gmLo41aTmJ8mkJS2aholjrfpiG6o3yZ7+tg
         vy8g==
X-Gm-Message-State: AOJu0YwyEuOG54S6V8njzRzIqTMq0CWyPvJPC2lqF5Oaxgf3dCz8kOtZ
	bSUMt5OXe/DB8a4tGPFdN1OSkiaHyoCS3hhGAcdaRxY/Ck/8cyQU0cTkGbVZ+8i4Wd0=
X-Gm-Gg: AeBDievUhic+Qu8oTAGfbydeOaXrM4XSfoiuzCa+D7DwHL3LWJhIF21JtZqtp/+9puN
	/bRaApGCzAsaekVzP8jBgONoXZHbqP77J9Q58ZT6rXbI04lZNwN5zb2DnJZb6f0nrsR1Ufio2oC
	Srvj0gUtitkPuDUK/iSgQdCG3PgtjYLgJAUYqBsbx0I3wyNSshBGS9H2+fLwiEgu/g/bsse1OOu
	9IdorKSi2tuQSShgiaK6STQVhwYz0KNz5W6qC57zzxOG7bHXekOUoy1bjqxgIMODOGKh5OAJtTh
	3MAmZAwDFqPQNUl6RhdwJ+HweXV5cw08kEdrZoiHgJ9g6p0/mEbpUAZEEdbAIm+BYMRScRUWNTm
	mHbqX4cEphOzuMiCyw4TudveJKg9Lx1y3V8hsZnua2gq1ucAIEBSbqc0MS07DE/gNU8S7I5817f
	/sxA5qcUZ+PsmAvPwqFpoCsnwVtM1TUNuADYl9m/YDCdLc/W0oLIDAR9Y029hfh/hIia6v
X-Received: by 2002:a17:90b:4ecc:b0:359:7c55:c166 with SMTP id 98e67ed59e1d1-35de67dcbe1mr2574521a91.7.1775220282341;
        Fri, 03 Apr 2026 05:44:42 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f52c8sm5463525a91.5.2026.04.03.05.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 05:44:42 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org,
	jolsa@kernel.org,
	leon.hwang@linux.dev,
	andrii@kernel.org,
	alan.maguire@oracle.com
Cc: ast@kernel.org,
	eddyz87@gmail.com,
	martin.lau@linux.dev,
	daniel@iogearbox.net,
	linux-kernel@vger.kernel.org,
	memxor@gmail.com,
	song@kernel.org,
	menglong8.dong@gmail.com,
	varunrmallya@gmail.com
Subject: [RFC PATCH bpf-next v3 1/3] libbpf: Auto-upgrade uprobes to multi-uprobes when supported
Date: Fri,  3 Apr 2026 18:14:10 +0530
Message-ID: <20260403124412.37449-2-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403124412.37449-1-varunrmallya@gmail.com>
References: <20260403124412.37449-1-varunrmallya@gmail.com>
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
 tools/lib/bpf/libbpf.c                        | 42 ++++++++++++++++++-
 .../selftests/bpf/progs/test_fill_link_info.c |  2 +-
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9ea41f40dc82..6f56bdc243eb 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -8294,6 +8294,22 @@ static int bpf_object_prepare_progs(struct bpf_object *obj)
 
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
+			if ((strcmp(sec_name, "uprobe") == 0 ||
+			     str_has_pfx(sec_name, "uprobe/") ||
+			     strcmp(sec_name, "uretprobe") == 0 ||
+			     str_has_pfx(sec_name, "uretprobe/")) &&
+			    !strchr(sec_name, '@'))
+				prog->expected_attach_type = BPF_TRACE_UPROBE_MULTI;
+		}
+
 		err = bpf_object__sanitize_prog(obj, prog);
 		if (err)
 			return err;
@@ -9955,9 +9971,11 @@ static const struct bpf_sec_def section_defs[] = {
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
@@ -12783,6 +12801,27 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
 		func_offset += sym_off;
 	}
 
+	/* This provides backwards compatibility to programs using uprobe, but
+	 * have been auto-upgraded to multi uprobe.
+	 */
+	if (prog->expected_attach_type == BPF_TRACE_UPROBE_MULTI) {
+		LIBBPF_OPTS(bpf_uprobe_multi_opts, multi_opts);
+		__u64 bpf_cookie;
+
+		multi_opts.cnt = 1;
+		multi_opts.retprobe = OPTS_GET(opts, retprobe, false);
+		if (func_offset || func_name)
+			multi_opts.offsets = &func_offset;
+		if (ref_ctr_off)
+			multi_opts.ref_ctr_offsets = &ref_ctr_off;
+
+		bpf_cookie = OPTS_GET(opts, bpf_cookie, 0);
+		if (bpf_cookie)
+			multi_opts.cookies = &bpf_cookie;
+
+		return bpf_program__attach_uprobe_multi(prog, pid, binary_path,
+							NULL, &multi_opts);
+	}
 	legacy = determine_uprobe_perf_type() < 0;
 	switch (attach_mode) {
 	case PROBE_ATTACH_MODE_LEGACY:
@@ -12903,7 +12942,8 @@ static int attach_uprobe(const struct bpf_program *prog, long cookie, struct bpf
 				offset = 0;
 		}
 		opts.retprobe = strcmp(probe_type, "uretprobe") == 0 ||
-				strcmp(probe_type, "uretprobe.s") == 0;
+				strcmp(probe_type, "uretprobe.s") == 0 ||
+				strcmp(probe_type, "uretprobe.single") == 0;
 		if (opts.retprobe && offset != 0) {
 			pr_warn("prog '%s': uretprobes do not support offset specification\n",
 				prog->name);
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
2.53.0

