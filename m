Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9933CB568
	for <bpf@vger.kernel.org>; Fri, 25 Sep 2026 04:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790312150; cv=none; b=VnZSAJ/P1MnCZm5bR/+BNMYCtC+BE3I/b7fQrmbXoHxq3HD4Bsodjvdl45jiLGqQoli8KA2GkzV/uDHz5Qwi847u9prMIZ9awOOPUsdOR0dkXlT9wTT0aqBlnKUjkoMX2mslbkwT6hvZG7RvrMoTmzxZJyDaQUlHoc+0TNUSxUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790312150; c=relaxed/simple;
	bh=9j4/hJzuGbSy56wRpsLnkjePWU2iaLUv31v/Tzv+pCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oz+Z0zpEOJfKKwDV5/km1/LgaqyV4dxlhUyQ6XC2yWoBPZMVsWCfVnzVIr5hwUfpl7HkDI69C1LFIBHUSUqj7BJ7xMbYVOvuHWNLQLVHfzNl6QL0HV6AFt76M0oLSrPCBUv7TM2gOzHLPsX69mh9tK1SA3gH/NHjpTbxVV6cdtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3R76rJ4; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3R76rJ4"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49e78a58e17so2431415e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 21:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790312147; x=1790916947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EOJ7M/CjjvxXoYQyYuWICfDfquY9ox9MDXSbxZEno7E=;
        b=l3R76rJ487WHRNVJ6rtyndVa6QVu5RaKefjAd7ZjdBq8dXUdFYehjVlPPlTLnhnLKV
         RJ4lwlIYQiAuXfJGJtY2a6zkRjZUI/o67pz7+fl+M4x+eimFjhP37HXRAxjF4UPeUFDk
         rIlPY7nU99bd8sJIbqLL4hNVx9ud1PyfjW6XIpqjQ1cZdBnoiDQxoSP6PmIHnohj7A9f
         UJ7tdXTcLRBlO4RBFStSmNM4K3ln7yaxH5YTV6epa5OMRt3rBg8l5T5zhDmkyytnZnRm
         mCq+QvcV2Gqen5qq8TeqnrYdu+bAXLpDwqvY6v/tcFTzeA4uc55sb068bVDIYdfCZfPD
         d5Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790312147; x=1790916947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EOJ7M/CjjvxXoYQyYuWICfDfquY9ox9MDXSbxZEno7E=;
        b=o3Ve+fWdA+xbjBnxTSe8LeFJjbgr0M9/ib3fj6veZHWxTG0a57KC3VZhdlLkruKaR7
         601tPuxFq+5f7kp5Gv6Gr92/lZkdn/TAXEuIuRLnQHjNaYkzmHRNuDeRJqD7hiP02oeO
         MKnkEITaNWqjPOYyjM/bG9TXhXc874lqCEpVzMBQ2VDvVPZvBkfs5SakCV0rvqJ5/9Nv
         TuYnSPSagZHL31rsxNNnio3IiKRMjlQfRVcj8KrHVEePf7eJ8AtqU++SV+OFplKlwoe7
         9R1k1sMnCvomTNsppmP5UL5U5vd5ZNAjs38fBDP9qyAffl7g98ZxAAzCPhztwqi0Bqk+
         4IpQ==
X-Gm-Message-State: AFuF++lQY+Z7hs6Wv7weBcwIIasiNSxcAJVaJEQg7HieKGgwR/gRlzy1
	7cCyoQY5lzjQkyivozTgVKLu1QOFuWB+4I1sph8O/LlzUGlH6RPNcePp4YHGethVPZU=
X-Gm-Gg: AYBFou3+fguSdz3AEmKaf2umne/ONuTc4CBCRkrnCwyfJz691IxwkjzcPwoYpCr4rl2
	8T1NqJTF+/Mp9LjKlW8tSzjTpI2qL71PmA7IB8kNOAGm9eg/VR4J7dXgr9KceFK6EXeDspcrT2O
	KdFwN+LgXkTgDn2v+HHC8Hra3yXfCGAKY8LL+GVH+rza23kNsOFYeE0dIWaNL8SMxITihLVRePd
	ZtXsserMRoe0ph11j5axoGAvmhEJtDB7rM0cAOgPe9nwGIl/konapkrHztamWFv82FFFNlhQSgd
	9kjrQKznQni9euie7WqybhmpWkhfzqUaMRT9zzMNaOw6UpaEUWU0Fmcp/48rCQOR/cKJraGbsqu
	G/DfMBHDIJLoF47RVI8V7TF9sBqC+wvEiO3Iv3VWVhxQTlOnDkhCtAozO4GSEf6ETOciJeAiMx9
	MI66bOAWrubzfRJVpR9G7RWiTWJLcVAuyutbPybKSphWaXJ5JJ0k4eug4ZSJ6jalm6YmVecieqe
	Q8BiKb+tHXTS1jvFESAyfzR0GhZHdjt1bXQseoE5O4AoWEzQ2Q+qNN9xTm+k9Ah+OY2vs3YSCMm
	i+dLGfya5rrYEs2l6fzDiDazdlpVlrFctP5wQl4oXS//ZHUB
X-Received: by 2002:a05:600c:c48e:b0:49f:ce72:dfe7 with SMTP id 5b1f17b1804b1-49fe6710a41mr72363035e9.35.1790312147356;
        Thu, 24 Sep 2026 21:55:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ff0658747sm32856695e9.1.2026.09.24.21.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 21:55:46 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 3/5] libbpf: Add bpf_prog_stream_open()
Date: Fri, 25 Sep 2026 06:55:30 +0200
Message-ID: <20260925045536.1480933-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260925045536.1480933-1-memxor@gmail.com>
References: <20260925045536.1480933-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3310; i=memxor@gmail.com; h=from:subject; bh=9j4/hJzuGbSy56wRpsLnkjePWU2iaLUv31v/Tzv+pCo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvrv6kWhkc/H3KsrPnX6bjtS/+Oh0ZdG2SS9q/hsv3QY 3P4xUStjlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEykfgcjw4qj++fW193RM2vs vz2xNLpu2dKcw5f/mXA873krn3/j+2xGhrW7982bsn/eMf/i2ddl34RzBnValhovU36YX1CVdTj zNgMA
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Expose the BPF_PROG_STREAM_OPEN command through a low-level libbpf wrapper.
The options structure carries stream open flags, including non-blocking
mode, while leaving room for future extensions.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
 tools/lib/bpf/bpf.h      | 24 ++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 44 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index a9de7f107cf7..b49822d212ae 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1466,6 +1466,25 @@ int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 	return libbpf_err_errno(err);
 }
 
+int bpf_prog_stream_open(int prog_fd, __u32 stream_id,
+			 const struct bpf_prog_stream_open_opts *opts)
+{
+	const size_t attr_sz = offsetofend(union bpf_attr, prog_stream_open);
+	union bpf_attr attr;
+	int fd;
+
+	if (!OPTS_VALID(opts, bpf_prog_stream_open_opts))
+		return libbpf_err(-EINVAL);
+
+	memset(&attr, 0, attr_sz);
+	attr.prog_stream_open.prog_fd = prog_fd;
+	attr.prog_stream_open.stream_id = stream_id;
+	attr.prog_stream_open.flags = OPTS_GET(opts, flags, 0);
+
+	fd = sys_bpf_fd(BPF_PROG_STREAM_OPEN, &attr, attr_sz);
+	return libbpf_err_errno(fd);
+}
+
 int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
 			      struct bpf_prog_assoc_struct_ops_opts *opts)
 {
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 490e8cb4ba53..826d9cc9ab65 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -759,10 +759,34 @@ struct bpf_prog_stream_read_opts {
  *
  * @return The number of bytes read, on success; negative error code, otherwise
  * (errno is also set to the error code)
+ *
+ * For blocking reads and polling, prefer **bpf_prog_stream_open**.
  */
 LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
 				    struct bpf_prog_stream_read_opts *opts);
 
+struct bpf_prog_stream_open_opts {
+	size_t sz;
+	__u32 flags;
+	size_t :0;
+};
+#define bpf_prog_stream_open_opts__last_field flags
+
+/**
+ * @brief **bpf_prog_stream_open** opens a file descriptor for a BPF stream of
+ * a given BPF program.
+ *
+ * @param prog_fd FD for the BPF program whose BPF stream is to be opened.
+ * @param stream_id ID of the BPF stream to be opened.
+ * @param opts optional options, can be NULL. BPF_F_STREAM_NONBLOCK requests a
+ * non-blocking descriptor.
+ *
+ * @return A new stream FD, on success; negative error code, otherwise (errno
+ * is also set to the error code)
+ */
+LIBBPF_API int bpf_prog_stream_open(int prog_fd, __u32 stream_id,
+				    const struct bpf_prog_stream_open_opts *opts);
+
 struct bpf_prog_assoc_struct_ops_opts {
 	size_t sz;
 	__u32 flags;
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 18d27d20102e..53b7b591325f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -459,6 +459,7 @@ LIBBPF_1.7.0 {
 LIBBPF_1.8.0 {
 	global:
 		bpf_map__attach_cgroup_opts;
+		bpf_prog_stream_open;
 		bpf_program__add_flags;
 		bpf_program__attach_tracing_multi;
 		bpf_program__clear_flags;
-- 
2.53.0

