Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7AE834404E
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 14:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775053892; cv=none; b=B0duR3ym2P2SRlJcOSYDI4s3gybsecqoJ1ntb2UdjMTrghkeuyWf5GpH2lXOZxJDu/0NZVkrwJhnk4OqEKJJB9o9sSyZ2r1YJjEsRxaMqLPVXNYEq5EVn3Tpit6UgiauuXd8fqmyRnqXa4RlUp7mkCyr0EOrFpU02Dh0rOThuB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775053892; c=relaxed/simple;
	bh=HP2K0MyLrfe+AsyxLn/Wacw/MVV8JD/vRaJarcE84rg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dWwwScdKxeME4dm56fs+c6d5/DstuU9dL+IwJ7GS+vxuDElAqh9H4QSg6McDTpf0CuHBNwO6Bt2OwIWWI4Rw8r4de1L3MiNopme4LsGNbAI8RdihR4wTRBfcbBmRNYKjVCKL5jwsmWDT8ZXwZOiWcP5nQ3n9QvWOxxsYcZjUVto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Flmf45sm; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Flmf45sm"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66dece07f3fso493990a12.3
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 07:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775053889; x=1775658689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HxiPrvpqH7118QkqrxrVkR44ZtadZ7EsUhuBxmrRAk=;
        b=Flmf45sm+lOdm9bnBOqe4ocMoLTZsPdL8Tl6TAkiPkHCh0xNXU0g62hLRCasuuXCvR
         oKAJXj08FjC4P8/etnQZP+8lJFkpTXa7Q+exKExo/pys3tLelD5zV+2uXEXAu3KvG7E6
         2JC3kCy7lqgGo6FsysYyvkxruL5SnbpcFIVgmiMQt9zbWkh3bQ8F91M0NxaXkTyT47RU
         lKfhFDiUxZAWWxiW36YbCPxtcFZE7qJFu7rfil+Wa6nC4SfSuTKiGPqqWCdKodUjhQcy
         k7KWgigJWSwjUFAu7omHprbVxLHuVpY/sidSWEutOtS90Zc3qfzidp5w+tQ1UDhLBc6x
         qyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775053889; x=1775658689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4HxiPrvpqH7118QkqrxrVkR44ZtadZ7EsUhuBxmrRAk=;
        b=cv52NdW2Xvf9ik6X/T8e9rUi98o+VmrN+IpjN9nivBB0qnfOY36udLkvO1T7ka+Lee
         LhfksY20G6jCXqABYgoPB2HtNYuoMX7fVYSNcrgNnyiJOfRqjBZTXG6r7j7A8qwapZse
         P4c2lvwhFsuejOHOAUZVCtUdGZOOC29L+fWkiytRMDb6fjtfzI/YKbge+T0pDcxvvMvM
         kle/MWRge9qEkLROC3AO72KxNXtVf1eKwlwUUaEQreFcygQApIjzQgj0zuR+0y6bt8Ki
         HUqVmElJW7/t5LN+EAIvjSMifxf1N0FMa5v52lrOXrxm2w0+MJI13NJtFAMOJ7bXInge
         A19w==
X-Gm-Message-State: AOJu0YzfB1KsOOJ2YWSmWYmcmyS+1aHmajzhLlr2HH7jte4N5F7D7sGx
	oabe+PlbP8Qiry/Ylqi8JIkklP/SGCEBPggn1t8fWs+VI1RN08RVUX/haA56y4TOCr9XmeXoGcT
	gke2ALSM=
X-Gm-Gg: ATEYQzxn6qyKvDH4tJOjYR3M4VU3Nu83fQJrWcYTGLfLjI+povcAzPcpwpDVU/rkMjp
	wPp/aDkvjH9wgZmFR5WZyF5G9oYZKo24avajyF5/9cgE1Fu3ButLG9r3Fcz3mLoY4vVEo03awWC
	mAvdDdxq0n1FGSWZtdUW0/FJ678X6zYgwsdmXtigqxQP5MRGQveF4fH0S7iuAx4kyIoKeBCfg0G
	/dXpRVuiNB3vBkkS2wBpcFg/3WNJEHy46mXuPCpuXtjyTyilRZ2XT/iim/t62aIwctwCDPn/yFK
	hMXLplE63n9PvLBXZ6SZogUTZeD+jwZOCmlrgw4cN+LhrztFOAuZTT0JC2GzlBDwQS6xdCtHJuR
	mQTPLYsNg9YpOlidxe0cTeRlcpPwRyP9U9OCqfWkzXGVR3OVVhWCYSjbjGuj0NxGg4oHCn7qEb4
	DVtfuVsPN2A2mUsqDfG4LGwjDStrAVM5bXU4xXvAIZpa2Jv0Mmc9s7kJe1bZ1+4w==
X-Received: by 2002:a17:907:e105:b0:b98:4b8:1046 with SMTP id a640c23a62f3a-b9c13af90bfmr196794166b.31.1775053888733;
        Wed, 01 Apr 2026 07:31:28 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427658e4sm199047295ad.48.2026.04.01.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 07:31:27 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 2/3] libbpf: clarify raw-address single kprobe attach behavior
Date: Wed,  1 Apr 2026 23:29:30 +0900
Message-ID: <20260401143116.185049-3-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401143116.185049-1-hoyeon.lee@suse.com>
References: <20260401143116.185049-1-hoyeon.lee@suse.com>
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
Acked-by: Jiri Olsa <jolsa@kernel.org>
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

