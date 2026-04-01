Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12D23806B8
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 05:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775021157; cv=none; b=dzqSedIl71QjfefHoG+lI00lPuWbruKZEmBFJNUiFnQAEHDvVrADHXliEkhaRDyKAdmKcF8uOhUIlOojFyQ2oeal+/cC7l+KFVdSElSGfSjTmW/yZgYfPQpjutgPIUSU0ByVmh4KUMDto8w/W1GPPJN5zCUZfU03w67Ih1JAAhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775021157; c=relaxed/simple;
	bh=qmeQHRkGzK4lii5ZAyRn9mbpws0lEvcKha0BrFEw8H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPMTWfA+kApFZTPltxP8mk3UbvQRKGJoiG/PP1mv5KPfT/BoAGKuw4hUQuTWvZLIEwncLLiFyyPn0D1wZA5Ur9uLGjLgC2YyoooROvHD4NFGdn91TU+57XH+lxNbjRPrbnGq1aGUWULuzYDQO2NDcDMLtkH+NaRWP2Yoj0pQybY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Y5fUQ68p; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Y5fUQ68p"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48334ee0aeaso57206045e9.1
        for <bpf@vger.kernel.org>; Tue, 31 Mar 2026 22:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1775021154; x=1775625954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agD2j9lHJEiH0O0fE306beCiWzd2jKbZSkmxgbBvFK8=;
        b=Y5fUQ68p7FTx4FgxBYQq2M0MpOq4AIxi42KmcWYRnOFJO9pSENMSWW3LYsT2GdiOj7
         8OxhB5ggvxUVMyF8uu7dRK1ZvZtKlrBHR0q4rwrsHC5IwQSg1Rn0wXVgkHAkJIq3C1zR
         ZBC6MOXu3C4cwSImYnVnh++Xln7PxJ93TYsPr1DePLpBsATGakuzAxnxuVBKGPHLdjK+
         7x5/zYJQJB35iovFcLqZvUo7W7zxsAKlwLuxVrbuRXMj9n8EdOb7ePIOgD5CLtTDnDnX
         SGreWq4Z7cKpXPoGvVbCqXBu2nA8ifwPv9dD5rc3LimrxeNem4yZiYDfJyINqODeG3f+
         UtYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775021154; x=1775625954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=agD2j9lHJEiH0O0fE306beCiWzd2jKbZSkmxgbBvFK8=;
        b=s48hdm5i0dj6Ip9YB5YsTfEKKuP6GRLOPHwJxZXIOxoqCuk42E19qFZcXlYzB6lll3
         Nf4EYmAqsZsJMTC6CbH/T6gAlBv1Wzxxhnp1fOWdwZp76vE1PPFUIuArkUhdWaiharSI
         /2yOUOBWILe8GyWou1lKqR/zUel5liOtYNesIj9Kg+ZLHKa6y192sSwIvRAqhlGVWBr7
         5Chw5Apezcu+QPCZKHmFrbaYWG7Q2El6mTqFvUZepOPWwBsBEE8DhvPoZ7Pam5W+HGJX
         Wx7/sXucJb/ePDotnNNAfnFuSFqZ98C1ylCIS+7B8fpCcDOqNp3oRlLFElVaSYC8SpWl
         MnFQ==
X-Gm-Message-State: AOJu0Yy3gcDe/PtGTLzvxNHSgzAR8LUgnQiw3PCxZo3N/0qFGBWtdyNp
	mT/EZMrb1SQmc5AqUCvVgjb5t1L3gTRuZQa2tIAAjWt9/9XU/etrS9KVp2AxlonUlI0mVqpYshL
	r/ss7834=
X-Gm-Gg: ATEYQzzqonJoPiqa12vLslYQ7A/14xfW7Ek2i2jSnP8M2eRFUdnnAguW1HrMzHNjO8H
	whNzgFqJRJ9ymrKQPHChiVBe0fV6/SjFxoBIcRsAlGiW9rzaFZXWDFz+ua3vReG5a0keR2UFrAm
	p0mJIv6TTxOhJyPexqs5yHcuNbV94XVTFe4E2/Zt+OtlRtDkbqkxHFsBj4OE/PzKRIytdeXRRTh
	rbYAdkIj4D5kwt3GsIr92LlmSA7MDOnMgOIhqULcP6nCdN6whFznvxIALAJtO09WbIW+fK/UBvK
	qpnN+VpIWhtsm/JgIt1JlJ0MwIXGZFkBq5vLFpCnCrilcCBnE3XzbwfruzFu8i9lad609sV2xLV
	469nJ/Rddc8o6kO9DyH1zGPiU5SpeLbkx6THloQBhfUDqnO2DyDpQzmBP/mJUq6oRg/IFrI8Xwy
	WkwfCanbtop/qKxOwVEvaa2yZX1Eko9Jg+c1PU3IhBbB+extKeD/w8EwNwPoITMw==
X-Received: by 2002:a05:600c:3ba5:b0:471:700:f281 with SMTP id 5b1f17b1804b1-4888359db41mr30178075e9.25.1775021153781;
        Tue, 31 Mar 2026 22:25:53 -0700 (PDT)
Received: from f16.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82ca843b818sm15308214b3a.6.2026.03.31.22.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 22:25:52 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 1/2] libbpf: clarify raw-address single kprobe attach behavior
Date: Wed,  1 Apr 2026 14:25:10 +0900
Message-ID: <20260401052544.100968-2-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260401052544.100968-1-hoyeon.lee@suse.com>
References: <20260401052544.100968-1-hoyeon.lee@suse.com>
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

This commit clarifies this existing behavior by documenting it in
bpf_program__attach_kprobe() and bpf_program__attach_kprobe_opts(),
and rejecting this form explicitly for legacy tracefs/debugfs kprobes.

Signed-off-by: Hoyeon Lee <hoyeon.lee@suse.com>
---
 tools/lib/bpf/libbpf.c | 16 +++++++++-------
 tools/lib/bpf/libbpf.h | 29 ++++++++++++++++++++++++++++-
 2 files changed, 37 insertions(+), 8 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 9ea41f40dc82..b27832ff6051 100644
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
@@ -11835,21 +11837,21 @@ bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
 						    offset, -1 /* pid */);
 	}
 	if (pfd < 0) {
-		err = -errno;
-		pr_warn("prog '%s': failed to create %s '%s+0x%zx' perf event: %s\n",
+		err = pfd;
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
index 0be34852350f..f691f05aa68c 100644
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
@@ -565,11 +565,38 @@ struct bpf_kprobe_opts {
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
+ * opts->offset is treated as a raw kernel address. This form is
+ * supported with PROBE_ATTACH_MODE_PERF and PROBE_ATTACH_MODE_LINK,
+ * and can fail with PROBE_ATTACH_MODE_DEFAULT if libbpf falls back to
+ * legacy attach.
+ * @param opts Options for altering program attachment
+ * @return Reference to the newly created BPF link; or NULL is returned on
+ * error, error code is stored in errno
+ */
 LIBBPF_API struct bpf_link *
 bpf_program__attach_kprobe_opts(const struct bpf_program *prog,
                                 const char *func_name,
-- 
2.52.0
