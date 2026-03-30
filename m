Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FAB3C3C08
	for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 11:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868468; cv=none; b=irIx/7YDRYosF250YtBvYr8a0BQWybCSdtKEVf/cD7ie8dE1HQS/jSjE46aZ8IABDcqG+WphEJotkfuLefwB5OKFRvLBPa/uvNXg+aqvh/MDNFU0OLrqGL7Ld+6KI37+UWK98M0sfyEjCqS4+bS4Gd75GGokj2FxExlAUSJb0SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868468; c=relaxed/simple;
	bh=ykB6GqSoBDVF8sQ3aMY5L/RsBwNhVVVqpjKX0IM3w4A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=upWdX3qCRrvoQWRK1RUW0gO/y1WfgeyIGh+Gc4tAdus/CN0HSWKWhXDdEbzTgmpKVQKchBsDZevQxyj6vCwHnVUgEX4IggUS9Zi3SBhnri/gHGjs09OW7ZgC9njSVQbJ9nPAEUeP9nfO8wLx5Xml1EVth3T2WO/FRpqGvRNpuiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cmDkcxLe; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cmDkcxLe"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c74244dc0b3so2759329a12.2
        for <bpf@vger.kernel.org>; Mon, 30 Mar 2026 04:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774868463; x=1775473263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NZsO2ED3NriQaWk6RZB1AOBG85387YAVdW0BG1uStGY=;
        b=cmDkcxLeZm+7kdfglxqXlANRCSG99/UAucFFMt7tCANxpHEa74+7unJFin1bxXdnEP
         kzyxDpyLkeI01D54cAsH5bcHL6BDzzsu2WjfYVI+/6Nz1xa3RzetTh3zxqUXmXz0f3QG
         h5yJTux28odn6L7P5lvHnr5KbwBCdOjCU/oRI904c6KqCvsHfT/cCT1klZprLYLsWp7Z
         8DktjT7mMn9c2tRgNXjv79klKLb+P4JxPqCvkd9q4vIXIGvtVNywunY2bQZDnT3t3WnJ
         FQ1cUh1yClLq0ut70wq7OsapOAHldNNx1Y+2UaRTkExrflIQZSYPRrO48kXa1CvjsB9G
         gN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774868463; x=1775473263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NZsO2ED3NriQaWk6RZB1AOBG85387YAVdW0BG1uStGY=;
        b=NXpoIHl/eFgQ5jBmFhici0cPlx4oPxGHbLAX3YPeOlLt7n2snLo1W1wTCyi7hKgCRt
         MdGb+KTrDUqfmKMNrhf8bULCFuv+yA5YLwnbOTMz04r/jnHwoRx6Z1qWgX2NXJLA37Iq
         WYDlXC03AWW0PAfBHctQSKUGYSj0v21ea7krL2SBzKalTCBjWmeGi7nAsNqSDDLGdQYq
         kzTv5V5v4tKWkZE0wDp8HFywb5q5IY2ElbioPBRrkSzqIlnx6/Wa1M+gbErPfnO00xwT
         qC29rpMzyMzQrckM+WhEVwBxxr9Jf+AtIVxTOXlq2MKERCKXWwQzzLLc3xQgBa1dX2xs
         Edvw==
X-Forwarded-Encrypted: i=1; AJvYcCVoYAIrWW73nuCyqivz7+0FhczFA4VAaU3ica2ppU84zoB8jwAQbhBt9o9v/NEBE9X+AtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0X1J3IuLj0fxsxSIKnEFHVoe99k5GdUj0GaE8K3F77ZZalLq5
	EYIUKjghG6QD+cUAsloZPihFHgNhmPA8ivHuKpMw99kALI7VaSrldma3
X-Gm-Gg: ATEYQzxJsCmr0NbY8bqcRiAvt+jM41//f6Fga3QIVbfB58uAZNh1I52b9cETMO+OhWA
	HZnOFB33NxwnPEAFqX17g26t+I9UYemiwxo7V326Im8pFKtcMbHL4K8w+WTMqypidkbgeqNOakR
	WQ+ZwLQkpWJ9iqCM9G7g7JrmjWX9916vzLgGzU/1CMESCQ+glMwihIW5NDagdanpdyzogo/ZFty
	hwxqmOtv09eiglL5F0PK/qMHnD+OVezOWRvaDu7pvbLLBp5Qyt6LQGnyW6E/+UxilPyA/2hZb6a
	L7J8lG66jvsxLaDrufZW3ZmOoSLRE5jW00PtmrUnIUI2DwiPPz+hIyW/gqWKM4IrDxZQxvftcFZ
	BWxgdzAwUmeywV09U4i/+BmEfO3EET5FvfEsZd9Su2uqMslpHx5pDeXzPL38uxl/zJL3k5Xf57A
	XaisQREl6EiGnraJV/aVm4YcgDZNlRiH3dQZDo2ORgR3zdmOOJpHE0O0r2UE1/2sdyb9nw1c2BQ
	Q==
X-Received: by 2002:a05:6a20:a10d:b0:39b:c686:630c with SMTP id adf61e73a8af0-39c878bbaf7mr12969034637.22.1774868463171;
        Mon, 30 Mar 2026 04:01:03 -0700 (PDT)
Received: from eris-fedora.iitr.ac.in ([103.37.201.189])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76917d843esm6806615a12.29.2026.03.30.04.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:01:02 -0700 (PDT)
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
Subject: [RFC PATCH bpf-next v2 2/3] libbpf: Add FEAT_KPROBE_MULTI_LINK feature probe.
Date: Mon, 30 Mar 2026 16:30:18 +0530
Message-ID: <20260330110019.549079-3-varunrmallya@gmail.com>
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

Add FEAT_KPROBE_MULTI_LINK, similar to UPROBE_MULTI_LINK
by loading and creating a link for a small BPF program with
BPF_TRACE_KPROBE_MULTI as the expected attach type, and
then checking the success of the operation.

Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
---
 tools/lib/bpf/features.c        | 37 +++++++++++++++++++++++++++++++++
 tools/lib/bpf/libbpf_internal.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
index adcad221c601..13227c9ea69d 100644
--- a/tools/lib/bpf/features.c
+++ b/tools/lib/bpf/features.c
@@ -424,6 +424,40 @@ static int probe_uprobe_multi_link(int token_fd)
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
+	link_opts.kprobe_multi.cnt = 1;
+	link_fd = bpf_link_create(prog_fd, -1, BPF_TRACE_KPROBE_MULTI, &link_opts);
+	err = -errno;
+	if (link_fd >= 0)
+		close(link_fd);
+	close(prog_fd);
+	/* if kprobe_multi is supported, link creation either succeeds or
+	 * fails with something other than -EINVAL due to permissions,
+	 */
+	return link_fd >= 0 || (err != -EINVAL);
+}
+
 static int probe_kern_bpf_cookie(int token_fd)
 {
 	struct bpf_insn insns[] = {
@@ -658,6 +692,9 @@ static struct kern_feature_desc {
 	[FEAT_UPROBE_MULTI_LINK] = {
 		"BPF multi-uprobe link support", probe_uprobe_multi_link,
 	},
+	[FEAT_KPROBE_MULTI_LINK] = {
+		"BPF multi-kprobe link support", probe_kprobe_multi_link,
+	},
 	[FEAT_ARG_CTX_TAG] = {
 		"kernel-side __arg_ctx tag", probe_kern_arg_ctx_tag,
 	},
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index 4bcb6ca69bb1..633106a687c7 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -388,6 +388,8 @@ enum kern_feature_id {
 	FEAT_SYSCALL_WRAPPER,
 	/* BPF multi-uprobe link support */
 	FEAT_UPROBE_MULTI_LINK,
+	/* BPF multi-kprobe link support */
+	FEAT_KPROBE_MULTI_LINK,
 	/* Kernel supports arg:ctx tag (__arg_ctx) for global subprogs natively */
 	FEAT_ARG_CTX_TAG,
 	/* Kernel supports '?' at the front of datasec names */
-- 
2.52.0

