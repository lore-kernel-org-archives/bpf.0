Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CE13EB815
	for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 16:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790267211; cv=none; b=D1SLpCZPaEBzVu3RTO2DkhJWFf6e8by4KTLGhdXvz4rWqzmLGxrG9pZF+AjX/6y1AWnQKpIn+PYeLgVrc0gmLyL/g8vlzxqPf8ajbCVljbdNJSzZqFnkV1+Zo6pwYKgAtC+TAcZTmf5zkkV26x/pzzlDKimri7KZ/h69kvYEP3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790267211; c=relaxed/simple;
	bh=9j4/hJzuGbSy56wRpsLnkjePWU2iaLUv31v/Tzv+pCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a/FhBsQrOZZG0/DY5JaUzdiwrd5BQV1KGXjPgdr/O1TyA6+QGQP2B1uvhGZK5Ff0XF67/MDYhPQwodl0HrRY9pVrehgk/+doRCXR8Ofivyf3oi87XzQnVfkg47JfTQ4bsN7N2VLG/vdrOd5ZcCaLtUNBeOfYb5Ii35S3TILYn5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jD2sLAsP; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jD2sLAsP"
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-49fe4ca1052so85775e9.0
        for <bpf@vger.kernel.org>; Thu, 24 Sep 2026 09:26:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790267208; x=1790872008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EOJ7M/CjjvxXoYQyYuWICfDfquY9ox9MDXSbxZEno7E=;
        b=jD2sLAsP2jjFw1aDTVg8Vizgb+wM3f9Qz6SqeFzkKocRXVZWY7qVs494eBOsHC0png
         4Zru4PqCMDl6nx+KhfRkF/vG/V3+C/E96zwIZlVNCv/v30vHbFD2CvxWZe1l9I0G1Gni
         hJXaCPkbl9DblYhLg+lFTC/JqMlt7W5JsjyJtshCQD+dmSinNAWPh5HxiYb9KCikO2t8
         bj3bOVprPejIUy+D95YqmqjzMBDRpmrclDmEyI2lRy+d3qMEd+w5edLlg3oICBBQUHvD
         FT+0esypxnHjxRdE80r4kvBDUOc7sfJbgX7KvEMQc5IHwxbYbU4PIs/ORBDj61iLrkH8
         JHxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790267208; x=1790872008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EOJ7M/CjjvxXoYQyYuWICfDfquY9ox9MDXSbxZEno7E=;
        b=qDUwINBe3tlpLhsmpXDHBGTpdAhhRxtnhHhTFvOVrirSKLxRFw9D8DgOtVryz3lW+4
         gTEXtg6Yg6cm2yAsOj4BJvQPYn20H768AynFeSEW8VLOODJRj7GrU220zYn6zaKIsP/o
         97v8krBSBtpp61HxM0rKh3V3BlPtwrczEJm6T63KDEWK3Bo+a/dagq47AEUTU21NkARG
         j5n1430Ge8NZ7i/Nl2+2ERXReJ/BO3GOMr9SwJng9FMflJVrAZr+WeBU8fGOIU8xZCk3
         7xwmdzKJHV0g+vvzd5a6ga3dN8qrvC11UYeWRgaOClVFmG6TH5qsayROa50K3L6kdBda
         aHHg==
X-Gm-Message-State: AFuF++nnmRuv5b/uCkBSNGj+79GJHQQIJ5UPs5vGFI5MSqnV6ZrokhGK
	XYPd7R3Iv7E/LTqoNoz0XbMbkqzS5rO7lef8MbE3E1ceAMHuvSmvIkL3L7brBChT
X-Gm-Gg: AYBFou2KMBvM2k9lAp1qkuciZyAdKLskYNcEYQxSidOVzV6Im09ijImUUb3iWcuWstJ
	Sm0mh4IG+BQJuRJcsXylixuSpduqri5x5C0W9K46Wa5t7WhVeGZx6P9FFf+CAU9bNolHU7tuTMf
	aGEuSbGu7KdzMu4lA5WKPojqt+WILotF2KJzbeek9ZfPudWqVOyoOOiy1ZdeP+zyPbnxu0mKYDX
	GTu31qek6YHQLiQ4ltq1dJX0z51t9jio2jRMN+KULqqljgcTcrPLxtUtt7xi4+U8x628bgiwX2g
	XaX9hjLhsJilVL2XIoJcpaMG1wDF4Wt5tQtdYTq+ohyXnTfKnuPizP9VpaPglQxKUiMuIDhLbFX
	4fz3tHJfIPQxc22pzaNlh9/vIHmWw9mrMFbv0+mJkMjWX0wRGsgUPqYBAMBK7N0WuLs3NtFuGrO
	6TxZO5dGHA+gLaUOlWJ1YY7652VcZgbutrsUgz02+mfEE98qT4sbjAnHO7L224KSvrK6MWQEAOS
	UlkRiFJ6QD7wd+RKszTh0FVxHJvtdR0w10cYXkRvIu5AVDJBtwL3BeN5GVosmpr4d94qR+jwSm7
	4qo2WtOgvb1YgRP5XQqQY5udhM+HeskUJPNQJQ==
X-Received: by 2002:a05:600c:468c:b0:49f:bcce:13f5 with SMTP id 5b1f17b1804b1-49fe66f5020mr49824565e9.24.1790267207918;
        Thu, 24 Sep 2026 09:26:47 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5dff204sm114272965e9.14.2026.09.24.09.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 09:26:47 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 3/5] libbpf: Add bpf_prog_stream_open()
Date: Thu, 24 Sep 2026 18:26:35 +0200
Message-ID: <20260924162641.1922423-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924162641.1922423-1-memxor@gmail.com>
References: <20260924162641.1922423-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3310; i=memxor@gmail.com; h=from:subject; bh=9j4/hJzuGbSy56wRpsLnkjePWU2iaLUv31v/Tzv+pCo=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWur7x4Lw6OfDzlW1vzrdNz2pX/HQ6OuDTJJ+9dw2X7os Tn8YqJWRykLgxgXg6yYIkvJ/31MxicqfwfaLuOGmcPKBDKEgYtTACbCP43hN/vH4J535epT5P4I zD5Rd3iv2v9nPS9W+8ndPtlwrPOn2EeGvyI7upYKRBz6+OZqZdHcarELUnMTXIvDnzJPNuI0PHf 0Ny8A
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

