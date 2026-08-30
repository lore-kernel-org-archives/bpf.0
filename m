Received: from mail-wr2-f11.google.com (mail-wr2-f11.google.com [74.125.225.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD5A3A784F
	for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788082527; cv=none; b=fnOjfsYQcG9gZdmlrfew6+nYiac1vBomxdNHaCXRgD8Prm2MhXxpMjcXIKLgJFiF8c/khi+zdQQwcwZw6ufs/EIDEy61iQmrTQwoD1Vh0QHnJgPU0EdjdVC1Wi6GilVoOKpuZCvCMqtr2LNspcPNSUeXHgZ8yt0+ssfc80YzOzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788082527; c=relaxed/simple;
	bh=e89wgUDkmnbbCoI2NGthfmbiU/M4pSFJZwxvWT9Lu5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vBNctpyRerw66nD/EbmSFfzBkJNNMob1Ekz3SxVEzYZPnS2QvSXoufUNMtefyjPAWW8Vow7GCquzrIar7QO+vP9TVk67D0GiH1qzA9/dXk9v6Mh95Qlc+mBs7cxXnNlp6E/t6Uqq6Q/AIlUXOzOoKWOxYViMAy02JhLODtCNFM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eFt1o8qZ; arc=none smtp.client-ip=74.125.225.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eFt1o8qZ"
Received: by mail-wr2-f11.google.com with SMTP id ffacd0b85a97d-482e61db882so582737f8f.0
        for <bpf@vger.kernel.org>; Sun, 30 Aug 2026 02:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788082524; x=1788687324; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P8NmSt3coIHWlJ1HX74V3vc60yu3O0LDZEUsaNMNa2k=;
        b=eFt1o8qZBtQwRLCp5K2NnAqSpXkQemqODvTgDpoCNN2kIFwgIJd7wU+ayJz3Fc0BVR
         bhleVZZk+P5rg6FnFRlnwo/Y+KpXUtM+cJP6t2bR41lpm3mnEYWmx+HP2m7pPNMeOMTr
         yO6m5Q+CYc5pt3IqkIraHzle0j7lPTWmY9SvYENl6u+f3Hz7BguHkVuXrzfNjsbwGGRk
         MppDosJrtYDBfSrLbh5Hs3VknXN5bwxFTH91BfbQLjwNGi6pQEmfoPrXsFr5+FZLC7d0
         xxsaKxYCFmyQ5YfBKFZavNI9HZrck9vUxOhY7vc7kB2LdR9+iYNfoULocvjNiMIlW9i1
         kJLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788082524; x=1788687324;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=P8NmSt3coIHWlJ1HX74V3vc60yu3O0LDZEUsaNMNa2k=;
        b=NUx2cmMBzxBAkviPe4l/E8385BkaEGUHziNV9w+thsXn1m0gfNiEylMWRArqiTxHBL
         lW1JHs1W1D4o9s7iap4Syc+Ng6VwJ8xGUSm7oBsoE4j/HaxN7FWLfbLAp1uyG+AtD2Ba
         7YzIGg7aICpF1t5yPM5saq/dJ5YR35xCPxG8MEKSpLQQDsgSZ9rpEp/24atnJjXQsn4O
         Xw3DtXQ0qR8buM3ysQcKWsYJT0S8GavzhKZLQFecULQN8TI6ds3sEHzJtAqFnnIXEChO
         lij+g4hqp5cgGX+g1HxHzofIjclzpZc9N9Y1dk5Aex6qIOAuk76jb2m7ChfAZWXr8A+q
         0TAw==
X-Gm-Message-State: AFuF++l3yMltInivJi5v7Z05JXcPhXlyh/WSNBR/P8RM/h4geKXBELGE
	mGQmODPnIWU0eBWJomHRHVwOowZPU4PWEfi1bIZcg/zCGj8Ibvbi6vKkQ0RH+Kao/Zo=
X-Gm-Gg: AYBFou0DkdMb9u/gPGfdQ5zJDoYa33FFMEJgrclEo+y5RYHfEA3RZ2LH9ZjaFrMxPVH
	Jky/ZczSnr+A7/keezWKNCMSVw89viogDmGBLau1X1wlwOkTenbYnx5ExurUn4rhtVLuh2JxTL4
	vnsIY51OT70DXDdi7HrjUE73PalVD3M8kFTmH2EQ+qzy5X0tLqpPAaSo1vH05a6m5Bzu2QHGX+t
	GeKPNRBi0p156raumpovW9+oXs7vsnzRIEkJY7DPrPLo1gKdPVMJoN/XnOoiJO44bgupXK+BlHl
	gVuM2aXsU2EeFXWeOAPZb7EpRnh3FtAjRxa9jqbZotB2zxvXmn7KdUVRrP+ji6B4q289j7CEBAo
	oH+KsiiwN1S3OJt4xraKSOQnaJV755/85FPbzYovFp8TDLenLzqIWRzxwGSqRRlwFrt9dYxPisd
	BGEuCeXkzW62BCGDFtEu1HwUidLDofvJ+xulziVsAKaJaIddrFtGiR2eVIvfcySY1cAIgfw0w7v
	VI0pXA2U72GKthUehjt/SVDVt5zCroGnbZXC5bmkLEQd3b1CDDVwkJ1Al8qQUlH3GLLBSd8xLba
	GcIDphZJJ5yVa/VYDY17+jHaibWO
X-Received: by 2002:a05:6000:382:b0:481:5d18:eb9e with SMTP id ffacd0b85a97d-482f79f2bf9mr30617706f8f.17.1788082523769;
        Sun, 30 Aug 2026 02:35:23 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482fbb2e6e8sm16655316f8f.32.2026.08.30.02.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 02:35:23 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Tejun Heo <tj@kernel.org>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 4/6] libbpf: Add bpf_prog_stream_open()
Date: Sun, 30 Aug 2026 11:35:09 +0200
Message-ID: <20260830093514.4105972-5-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260830093514.4105972-1-memxor@gmail.com>
References: <20260830093514.4105972-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3225; i=memxor@gmail.com; h=from:subject; bh=e89wgUDkmnbbCoI2NGthfmbiU/M4pSFJZwxvWT9Lu5U=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWvyx63vGd9dPCx0ZG0JZ+UMrTssbj2fLn+cde5I4dsrb 5gcb0083FHKwiDGxSArpshS8n8fk/GJyt+Btsu4YeawMoEMYeDiFICJBP1l+O+UcWynwA3P/7MZ Z58x3b0xMtpoIVNrxfnp/xt2fMtdlbGd4X/4lId7JvGrxdW5KL+SsO1+515dW72W58DDxRx3xAX z27gB
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Expose the BPF_PROG_STREAM_OPEN command through a low-level libbpf wrapper.
The options structure carries stream open flags, including non-blocking
mode, while leaving room for future extensions.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
 tools/lib/bpf/bpf.h      | 24 ++++++++++++++++++++++++
 tools/lib/bpf/libbpf.map |  1 +
 3 files changed, 44 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 96819c082c77..5186f6245879 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1464,6 +1464,25 @@ int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *buf, __u32 buf_len,
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
index 7534a593edae..860c5644ec1e 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -758,10 +758,34 @@ struct bpf_prog_stream_read_opts {
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
index 08ab2ea881fb..a89e10811a73 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -458,6 +458,7 @@ LIBBPF_1.7.0 {
 
 LIBBPF_1.8.0 {
 	global:
+		bpf_prog_stream_open;
 		bpf_program__attach_tracing_multi;
 		bpf_program__clone;
 		btf__find_by_name_kind_own;
-- 
2.53.0

