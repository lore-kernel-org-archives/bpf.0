Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B12329C49
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 07:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775027292; cv=none; b=G4YdOlrU3PYW3lbFFVVql7/cEag4h0dRd4BEUeseN4tHQOOjEMM39y/3F6UQGSq/BHMJX34Lmmir7yKtFM4W71+mmEtqHGIVEvrIZNMw1qpZ/NFJFs5QI/PIPbHJY2PNTu+CXeCFer+1a6haCSr9TFGN8X5D6LJXKHuJHHlmFA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775027292; c=relaxed/simple;
	bh=XW6QKLjAIwFHt0ljUA68HIAeEhmiSgn9ZUZsdX5Ug9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CXkGmHujoKd41WvZba1/s6XVbGT2GJz0l1lA2uuJ4T+X9cR6WEf+h6w62lKlXvfam5F+AD/nLpwRgU/pd5sqMrWecwiPGvK0b1SIq/niBarAJ5AU3zwdm6JWguV57j5rHSkS46KyW8a+YQXA1iREZbT6POqcojx5B4WDseU8PNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TMG1EeMA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TMG1EeMA"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-483487335c2so69220275e9.2
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 00:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775027289; x=1775632089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CJQ4d+lVRTubXv0cnafhKoYOY7oXfEJc77p4cwVsmxs=;
        b=TMG1EeMAXyK3bJfr9Z3iU/BIa6o02boFA8e46eG4ueR2/CkUPlYijCpR+1ZFLt9OHm
         UjVIWxioEyJC6rykq26OjdbdaUVxPPaOLAO6N6VspkXGP7smJm3E+vzPDIGogqaYisQe
         IQYadTH7UTxyA0VzZk5vVLvUb9Dv2dpTJVLjj0R/u1FHzp+hnP5/Qn+jD3jhtVK4nYFc
         Mru9Dz2y6riW/6OqzbftrEbtzVhvYlcHJiuU7x2u13F/M3S+GjMRaPTSuFmzwKDDq1n2
         rWFE4pvatuEiHGlwHckNS2r2U+Wn4DuFs5cmjz/Kz+sCwx6kk/6ANb64pthadARHP+Yt
         UEmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775027289; x=1775632089;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CJQ4d+lVRTubXv0cnafhKoYOY7oXfEJc77p4cwVsmxs=;
        b=JWG6XDQJsFPhB83752+i2YSKne1nlypFhAO/yk4Bss7ZXfA4VO4SsD53+DTOI0OG8G
         vCg92/P3irG1rxPNX5aopNrRbejFmNmI/8LaOCagkSp/z3Jitz9oK3hilk1D7Ia0fhG/
         VR0Aj1xSUJXJbGwmXQlEDWwYIYK3oTX+hX6g2k3xLK2OIL91QL0fwIzr/Eld0N8n0Ary
         cJdEZYkmTYx8vMDMfgaAc1nTFKPz/dO7tan+qmAqLrMAsyYmM8TcH2/1blym8iwNTrxh
         JVDNgKmHA6gCwyBBG6wTSNBVKZI4MKo/W3FW9m3Zbx/oxIvyoCEUhXaHjnGZqi4QnXLh
         SEmA==
X-Gm-Message-State: AOJu0YwMN4n6S12UCuKeVgUQGj/VO9PFYw/SaLHTSELkMMlKMWV2kQoS
	rkmxfBNUc9Ve/XNoLvGLLFuvop0yePQWTN5c+ALMoQfy0TiI3oJhtKWpxhj9xnYTyGWWCOrBrbe
	kMmjMriw=
X-Gm-Gg: ATEYQzxmPHmQeilDMA8xSDz1qRMxGduG1LVpdvRrI0zRwUnJQBigJyrDMEwfDcg32sC
	nTeqqVX+lsDMGROGv3VpubVM9QNs9jLoAtNcNAtnSHroifuTe8dn48vXfFXRIDnD6iMLnMZr7B3
	gfjFtU633NEJeo36Zv66vKWhdrTgu7kHXuND1m7N3Qz0DCsxRrzdKzmbpBSyaowzARG1Z3uroPK
	JR5uUBESzPAZS27RTLFz8mLfeBE2NyVRhQs/aSiqPPXfwrzIAmC6qfIOi0EzL1s0ojJGXuz5jln
	Zlk4JKTLaqmqRkfry7/iLfZSNTu7aCJq4nuIXvgI/9GVSmtuqAnKXYZbop3q319zQkUFc9FZDTt
	iXmjLoXwjCfslfBeiVurbkU+WomRg+TZZrxQtDsvhzd24jXS0pomx0LwdlAD7s6o0BO09RBIs+m
	uvkexy+imyKHqQu8V6Tcdrjfs1WQd4h3C+0V4LAE+F5LS6RIJRP0KWn8eP
X-Received: by 2002:a05:600c:3b9c:b0:485:5812:bb9e with SMTP id 5b1f17b1804b1-48883302d32mr42072255e9.0.1775027289027;
        Wed, 01 Apr 2026 00:08:09 -0700 (PDT)
Received: from f16.suse.cz ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a887e3sm15355778e0c.18.2026.04.01.00.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 00:08:07 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 2/3] libbpf: clarify raw-address single kprobe attach behavior
Date: Wed,  1 Apr 2026 16:05:03 +0900
Message-ID: <20260401070738.122709-3-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401070738.122709-1-hoyeon.lee@suse.com>
References: <20260401070738.122709-1-hoyeon.lee@suse.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_program__attach_kprobe_opts() documents single-kprobe attach
through func_name, with an optional offset. For the PMU-based path,
func_name = NULL with an absolute address in offset already works as
well, but that is not described in the API.

This commit clarifies this existing non-legacy behavior. For PMU-based
attach, callers can use func_name = NULL with an absolute address in
offset as the raw-address form. For legacy tracefs/debugfs kprobes,
reject this form explicitly.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 tools/lib/bpf/libbpf.c | 14 ++++++++------
 tools/lib/bpf/libbpf.h | 27 ++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 536c19c14d21..ebb965230bb4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -11816,6 +11816,8 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	default:
 		return libbpf_err_ptr(-EINVAL);
 	}
+	if (!func_name && legacy)
+		return libbpf_err_ptr(-EOPNOTSUPP);
 
 	if (!legacy) {
 		pfd = perf_event_open_probe(false /* uprobe */, retprobe,
@@ -11836,20 +11838,20 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 	}
 	if (pfd < 0) {
 		err = pfd;
-		pr_warn("prog '%s': failed to create %s '%s+0x%zx' perf event: %s\n",
+		pr_warn("prog '%s': failed to create %s '%s%s0x%zx' perf event: %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe",
-			func_name, offset,
-			errstr(err));
+			func_name ?: "", func_name ? "+" : "",
+			offset, errstr(err));
 		goto err_out;
 	}
 	link = bpf_program__attach_perf_event_opts(prog, pfd, &pe_opts);
 	err = libbpf_get_error(link);
 	if (err) {
 		close(pfd);
-		pr_warn("prog '%s': failed to attach to %s '%s+0x%zx': %s\n",
+		pr_warn("prog '%s': failed to attach to %s '%s%s0x%zx': %s\n",
 			prog->name, retprobe ? "kretprobe" : "kprobe",
-			func_name, offset,
-			errstr(err));
+			func_name ?: "", func_name ? "+" : "",
+			offset, errstr(err));
 		goto err_clean_legacy;
 	}
 	if (legacy) {
diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 0be34852350f..bba4e8464396 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -557,7 +557,7 @@ struct bpf_kprobe_opts {
 	size_t sz;
 	/* custom user-provided value fetchable through bpf_get_attach_cookie() */
 	__u64 bpf_cookie;
-	/* function's offset to install kprobe to */
+	/* function offset, or raw address if func_name == NULL */
 	size_t offset;
 	/* kprobe is return probe */
 	bool retprobe;
@@ -565,11 +565,36 @@ struct bpf_kprobe_opts {
 	enum probe_attach_mode attach_mode;
 	size_t :0;
 };
+
 #define bpf_kprobe_opts__last_field attach_mode
 
+/**
+ * @brief **bpf_program__attach_kprobe()** attaches a BPF program to a
+ * kernel function entry or return.
+ *
+ * @param prog BPF program to attach
+ * @param retprobe Attach to function return
+ * @param func_name Name of the kernel function to attach to
+ * @return Reference to the newly created BPF link; or NULL is returned on
+ * error, error code is stored in errno
+ */
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe(const struct bpf_program *prog, bool retprobe,
 			   const char *func_name);
+
+/**
+ * @brief **bpf_program__attach_kprobe_opts()** is just like
+ * bpf_program__attach_kprobe() except with an options struct
+ * for various configurations.
+ *
+ * @param prog BPF program to attach
+ * @param func_name Name of the kernel function to attach to. If NULL,
+ * opts->offset is treated as a raw kernel address. Raw-address attach
+ * is supported with PROBE_ATTACH_MODE_PERF and PROBE_ATTACH_MODE_LINK.
+ * @param opts Options for altering program attachment
+ * @return Reference to the newly created BPF link; or NULL is returned on
+ * error, error code is stored in errno
+ */
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
                                 const char *func_name,
-- 
2.52.0

