Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDACE3A383C
	for <bpf@vger.kernel.org>; Fri,  3 Apr 2026 12:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775220295; cv=none; b=lI4Obxh5LY03oZ4pgxZwTyO1IQ+sGRw2OzahwM6ONVbUeCISQYMJuhEIoWZf00cVaTCAHzkuLvOKIXiePlaXynKYdcc+0yA/SoCVFjPvMN3SbezmNnynO1TOrYOP/JEeXWTfarExWJwXDNak/5Wx3Q3ytvsbJ6GYqnlWumqkXKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775220295; c=relaxed/simple;
	bh=+IB9jGf96wtUN84hD4VlbxFL50yw4CpCunL/Ed+wI8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFcozykACYg+RFrezobdiXeHuHz6rRrG5LDw+oYIJwYAxZn4Mj3OGGffV7B81hfMJNWEkraIVLsvzyRN1w7crl/R0rO4/LRYlb7wwJ3FPqGdWhr0WL+Za//3QrPjKXX8Cbr93/bdocOMBzFufKiOydee4jgDBtlXn2FFJkBnAkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=otDBfl0i; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otDBfl0i"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d932cc948so1165012a91.2
        for <bpf@vger.kernel.org>; Fri, 03 Apr 2026 05:44:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775220292; x=1775825092; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W1P/38vtQcdL49WePaJUfbCTK7MDyAg1D/z13BMMaG8=;
        b=otDBfl0ipz/OAhkKkciuOBe1rZcTtiRrQG08g+YVda5h+9+vyz+pusKJLSZeJ/QwFO
         bBjqR/IbtaGuuA/cnhJZCMRNaIXtwNSUXpDisNw+HV2FRLezGY9jC377Ebq78FbEXxEG
         Qn2BDkgYFqrxBscSNfqbyNLM5Xmh1EO5vkMw28xSl+X149FiTLmCv9jCAUsZhJKyArDU
         nMViJGGAtBXCmgb41Q/W03SbMxithCrQS+t3NhAIXSQFboDMgLK7SY+xfcMeMcGjh7U4
         UpkzJV+gDyBXrsZT73qW4PhGQgLiIxjqXYVfwlWZtMB9Fc/ua1gO11mjShEMdFPyYbIn
         XT/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775220292; x=1775825092;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W1P/38vtQcdL49WePaJUfbCTK7MDyAg1D/z13BMMaG8=;
        b=gj+cu4H0b8CYKPClXYGbomLaJ6NerM83wc52bicbA8LXTUjFvEftpWP6rkSP00cTq1
         vqr8EpJTrq9Gn5dcOJ361erJq5j1ncGxchofnmxXdXtheTRYeLidv8lFvtAgQc+2JeZP
         NxJttDoyOwwfWsHyHY/gpaOytXDPl5PVOT271qswp/PZ51WFkxxUICa2NupqitiQmwBz
         gWfI40QlUIU6P93NYTZWmNpN1Tpv40/WiB1SCLxRliFcp9Y8Q2tyQ4FjhVgGsF0wJJ3u
         LDvP9PUQeB2cuaste+1dYigc3OZS5QhgiSLtspYyBRABE7xYHm4XYRkKll9XI7eNEan/
         HmRw==
X-Gm-Message-State: AOJu0YxR58Bb4N4FwieS2zvziQdxwXo+rHCO2oE4CdwNgxwdCKTyLBCr
	LYT3Sdn9SorzjN088qP32UIE4KfKzke+wXrZsi6Z13ORwjRKia/XjWwgFPNePQcBriM=
X-Gm-Gg: AeBDieumKo5GzvN/cBKgOoxVmJKeXC1fIXkJ7+JubN1oxseIKhFy8FHu37p1z8TuozY
	fzfN9vij06xhhd5+yrSiR0nSvFj6J6Xm1qVXcQV/BWdybXjIwJlp7XKgRcTbdE/bYdmpThGBh+l
	6VQE5GZSmzECrO0UoPI65PI+OqmmsSTDLJniGCHg89XonRaGrctCxFI0jp/8/aPejGI3YoC4a62
	zYTfjOcngxwwF5P71wPBFfWMEJSR10+xX035B+5T88ULO2e1W3COsEhvdettMc7BcQJB/Cz/DW4
	leWYd3LVfDxBrNlJ4vgz4vvUl53W5YlTEZOFvj1ohhd4vKXWkGwE0ZCLrDPKVPgnlFt55onc9Pf
	gq8l2iJvTNpsPa0BCDUFFZo7b63+rLC35TMGBOtHBiAKJECevUouYKS1+GOcBwExc5hbQ3GBFao
	WjFZ6o8nB86xEmKu5vqbwmY1Mx8WNk+wcwmCN+7Ym/HHqlck49TeXR7NpRl7EGNlZdqMSSq7yJR
	1N7SJc=
X-Received: by 2002:a17:90b:3c0c:b0:35b:9d97:63ac with SMTP id 98e67ed59e1d1-35de684cf9dmr2339910a91.7.1775220291774;
        Fri, 03 Apr 2026 05:44:51 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:1f])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dd35f52c8sm5463525a91.5.2026.04.03.05.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 05:44:51 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v3 2/3] libbpf: Add FEAT_KPROBE_MULTI_LINK feature probe.
Date: Fri,  3 Apr 2026 18:14:11 +0530
Message-ID: <20260403124412.37449-3-varunrmallya@gmail.com>
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

Add FEAT_KPROBE_MULTI_LINK, similar to UPROBE_MULTI_LINK
by loading and creating a link for a small BPF program with
BPF_TRACE_KPROBE_MULTI as the expected attach type, and
then checking the success of the operation.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 tools/lib/bpf/features.c        | 38 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index 4f19a0d79b0c..01ded8a1e3c4 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -424,6 +424,41 @@ static int probe_uprobe_multi_link(int token_fd)
 	return link_fd < 0 && err == -EINVAL;
 }
 
+static int probe_kprobe_multi_link(int token_fd)
+{
+	LIBBPF_OPTS(bpf_prog_load_opts, load_opts,
+		    .expected_attach_type = BPF_TRACE_KPROBE_MULTI,
+		    .token_fd = token_fd,
+		    .prog_flags = token_fd ? BPF_F_TOKEN_FD : 0,
+	);
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+	struct bpf_insn insns[] = {
+		BPF_MOV64_IMM(BPF_REG_0, 0),
+		BPF_EXIT_INSN(),
+	};
+	int prog_fd, link_fd, err;
+	const char *sym = "bpf_map_lookup_elem"; /* stable, always present */
+
+	prog_fd = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL",
+				insns, ARRAY_SIZE(insns), &load_opts);
+	if (prog_fd < 0)
+		return -errno;
+
+	/* attaching to a valid symbol should succeed */
+	link_opts.kprobe_multi.syms = &sym;
+	/* MAX_KPROBE_MULTI_CNT is defined as (1U << 20) in kernel/trace/bpf_trace.c,
+	 * so we create one more than the allowed limit to make it fail with E2BIG.
+	 */
+	link_opts.kprobe_multi.cnt = (1U << 20) + 1;
+	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_KPROBE_MULTI, &link_opts);
+	err = -errno;
+	if (link_fd >= 0)
+		close(link_fd);
+	close(prog_fd);
+	/* Fails with E2BIG on kernels where kprobe_multi is supported */
+	return link_fd <= 0 && err == -E2BIG;
+}
+
 static int probe_kern_bpf_cookie(int token_fd)
 {
 	struct bpf_insn insns[] = {
@@ -699,6 +734,9 @@ static struct kern_feature_desc {
 	[FEAT_BTF_LAYOUT] = {
 		"kernel supports BTF layout", probe_kern_btf_layout,
 	},
+	[FEAT_KPROBE_MULTI_LINK] = {
+		"BPF multi-kprobe link support", probe_kprobe_multi_link,
+	},
 };
 
 bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_id feat_id)
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index cabdaef79098..b3cb216aadae 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -398,6 +398,8 @@ enum kern_feature_id {
 	FEAT_UPROBE_SYSCALL,
 	/* Kernel supports BTF layout information */
 	FEAT_BTF_LAYOUT,
+	/* BPF multi-kprobe link support */
+	FEAT_KPROBE_MULTI_LINK,
 	__FEAT_CNT,
 };
 
-- 
2.53.0

