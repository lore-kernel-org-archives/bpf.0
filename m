Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704707;
	b=OZe6elScK5Gvr0wnkdOSvDHBuPHhBgxIHWQT5ubrW6v+PRnY6kvSZInbsxwcdyvK5BTO
	 xe+W2xCEwBmbNydN6JOgTCDLZ7wkhPz+7B5vFkm8F01Fh5udsnG81pft2ecxZ2G2SBzaz
	 ZK2AQkm+V/yWqUdBZqbdLRhWJCKp3xseCeoGCrNG7ssTeWkKx+OqG2o0djbsvSd9kpqpP
	 2sCheJb2KOQP3ieYsYDXwEHi7rw+7at1ozYczkVwH0n265yMgER6AlKPtTh5a01u9j6Ut
	 uZvED6nrfIXqwNg744QyYJrv3y6ZB9urQCw/hgmW5/IY1T1IzpMVC33/2Pr5W0yr/Qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704707;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=nlkDmI8ZiL6GFJsi2qhFf/ia4WBgHudWp4E5MNym6QA=;
	b=Fnll5iKu30qRYuYq+ScpKtpgmgLw/NA8nnCNPKiHsabqO7BAM5itZTFK7b4BoTE9RVap
	 gHj4crsJH52CyUKcUVEukjK/w5ULjoOkFclzqmSXdziQq+mDumyyxG3zNNYVccWBJImvy
	 MR/5igluHj8MpTbXZUjQmCrJupL7aqSWN6DXvWkcpVXwc/7WwBp/6T41uh1pxvfI+f5GJ
	 Z++oRmOFhOWykNpX+DJr1HzoJimayota578VX70TApqbTBE+HzH+noKYupRAI3lCNSyBz
	 OwUk/riTPf8WAY5Cb0QhsQuikIpjPpNqiNlt0xWS1b6mmpS5IPlWeCZ7SucCVO6n86Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=lrb4HUsU;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1121F606A68F
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:51:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1121F606A68F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=lrb4HUsU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795704703; bh=xzpbabfX6GyrnKO1C1rGheeEZh7BgRyCWMi+Nt6V1hM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=lrb4HUsUfxwCYsS8dVPF8YbAD9ayIviGEQV8/eDxjAAw2kIKx+Hkvw9QbaYiblwZJ
	 XotZe/o4EBmnu/1zNRwVE+nDX3IdnF5bl4z4lT83ZWcObVrl793pxMqgsTebYjjeFM
	 J23kDOBvHOlQh5QNO7fNSLNmva1aRxWU7xTmesqjRCveikVF8Ml3/boS4q6bUjy3RE
	 /mTAfZnq2T36A65bmE/ASCoPAxzx1ld06cPX23HlnqfdgYLKIkr1glUjuwuApv9fkO
	 G/Yl6BJrsZVolxVJJCsGYQ7EeXCe/APOQwjcwzRgXHO9KiIKJPHPPA9P5THkwuZ4om
	 R6LCsZ5YhwiAA==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Thu, 26 Nov 2026 15:51:38 +0100
Subject: [PATCH bpf-next v3 2/7] libbpf: Add bpf_*_get_next_id_opts()
 functions
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20261126-bpf-relax-get-next-id-v3-2-338e1d3077e7@toke.dk>
References: <20261126-bpf-relax-get-next-id-v3-0-338e1d3077e7@toke.dk>
In-Reply-To: <20261126-bpf-relax-get-next-id-v3-0-338e1d3077e7@toke.dk>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>
Cc: bpf@vger.kernel.org, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>

Add opts-based variants of the bpf_*_get_next_id() functions which allow
passing in a token fd to add to the bpf() syscall.

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 tools/lib/bpf/bpf.c      | 43 +++++++++++++++++++++++++++++++++++++------
 tools/lib/bpf/bpf.h      | 16 ++++++++++++++++
 tools/lib/bpf/libbpf.map |  4 ++++
 3 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 38dcb31e8c0e..773efb585bca 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1149,14 +1149,21 @@ int bpf_prog_test_run_opts(int prog_fd, struct bpf_test_run_opts *opts)
 	return libbpf_err_errno(ret);
 }
 
-static int bpf_obj_get_next_id(__u32 start_id, __u32 *next_id, int cmd)
+static int bpf_obj_get_next_id(__u32 start_id, __u32 *next_id, int cmd,
+			       const struct bpf_get_next_id_opts *opts)
 {
-	const size_t attr_sz = offsetofend(union bpf_attr, open_flags);
+	const size_t attr_sz = offsetofend(union bpf_attr, get_next_id_token_fd);
 	union bpf_attr attr;
 	int err;
 
+	if (!OPTS_VALID(opts, bpf_get_next_id_opts))
+		return libbpf_err(-EINVAL);
+
 	memset(&attr, 0, attr_sz);
 	attr.start_id = start_id;
+	attr.get_next_id_token_fd = OPTS_GET(opts, token_fd, 0);
+	if (attr.get_next_id_token_fd)
+		attr.open_flags = BPF_F_TOKEN_FD;
 
 	err = sys_bpf(cmd, &attr, attr_sz);
 	if (!err)
@@ -1167,22 +1174,46 @@ static int bpf_obj_get_next_id(__u32 start_id, __u32 *next_id, int cmd)
 
 int bpf_prog_get_next_id(__u32 start_id, __u32 *next_id)
 {
-	return bpf_obj_get_next_id(start_id, next_id, BPF_PROG_GET_NEXT_ID);
+	return bpf_obj_get_next_id(start_id, next_id, BPF_PROG_GET_NEXT_ID, NULL);
+}
+
+int bpf_prog_get_next_id_opts(__u32 start_id, __u32 *next_id,
+			      const struct bpf_get_next_id_opts *opts)
+{
+	return bpf_obj_get_next_id(start_id, next_id, BPF_PROG_GET_NEXT_ID, opts);
 }
 
 int bpf_map_get_next_id(__u32 start_id, __u32 *next_id)
 {
-	return bpf_obj_get_next_id(start_id, next_id, BPF_MAP_GET_NEXT_ID);
+	return bpf_obj_get_next_id(start_id, next_id, BPF_MAP_GET_NEXT_ID, NULL);
+}
+
+int bpf_map_get_next_id_opts(__u32 start_id, __u32 *next_id,
+			     const struct bpf_get_next_id_opts *opts)
+{
+	return bpf_obj_get_next_id(start_id, next_id, BPF_MAP_GET_NEXT_ID, opts);
 }
 
 int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id)
 {
-	return bpf_obj_get_next_id(start_id, next_id, BPF_BTF_GET_NEXT_ID);
+	return bpf_obj_get_next_id(start_id, next_id, BPF_BTF_GET_NEXT_ID, NULL);
+}
+
+int bpf_btf_get_next_id_opts(__u32 start_id, __u32 *next_id,
+			      const struct bpf_get_next_id_opts *opts)
+{
+	return bpf_obj_get_next_id(start_id, next_id, BPF_BTF_GET_NEXT_ID, opts);
 }
 
 int bpf_link_get_next_id(__u32 start_id, __u32 *next_id)
 {
-	return bpf_obj_get_next_id(start_id, next_id, BPF_LINK_GET_NEXT_ID);
+	return bpf_obj_get_next_id(start_id, next_id, BPF_LINK_GET_NEXT_ID, NULL);
+}
+
+int bpf_link_get_next_id_opts(__u32 start_id, __u32 *next_id,
+			      const struct bpf_get_next_id_opts *opts)
+{
+	return bpf_obj_get_next_id(start_id, next_id, BPF_LINK_GET_NEXT_ID, opts);
 }
 
 int bpf_prog_get_fd_by_id_opts(__u32 id,
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index fe3b7fd8512b..cb5104734710 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -524,6 +524,22 @@ LIBBPF_API int bpf_map_get_next_id(__u32 start_id, __u32 *next_id);
 LIBBPF_API int bpf_btf_get_next_id(__u32 start_id, __u32 *next_id);
 LIBBPF_API int bpf_link_get_next_id(__u32 start_id, __u32 *next_id);
 
+struct bpf_get_next_id_opts {
+	size_t sz; /* size of this struct for forward/backward compatibility */
+	__u32 token_fd;
+	size_t :0;
+};
+#define bpf_get_next_id_opts__last_field token_fd
+
+LIBBPF_API int bpf_prog_get_next_id_opts(__u32 start_id, __u32 *next_id,
+					 const struct bpf_get_next_id_opts *opts);
+LIBBPF_API int bpf_map_get_next_id_opts(__u32 start_id, __u32 *next_id,
+					 const struct bpf_get_next_id_opts *opts);
+LIBBPF_API int bpf_btf_get_next_id_opts(__u32 start_id, __u32 *next_id,
+					 const struct bpf_get_next_id_opts *opts);
+LIBBPF_API int bpf_link_get_next_id_opts(__u32 start_id, __u32 *next_id,
+					 const struct bpf_get_next_id_opts *opts);
+
 struct bpf_get_fd_by_id_opts {
 	size_t sz; /* size of this struct for forward/backward compatibility */
 	__u32 open_flags; /* permissions requested for the operation on fd */
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index a45666f546fa..4a87b3500741 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -476,6 +476,10 @@ LIBBPF_1.8.0 {
 
 LIBBPF_1.9.0 {
 	global:
+		bpf_btf_get_next_id_opts;
+		bpf_link_get_next_id_opts;
+		bpf_map_get_next_id_opts;
+		bpf_prog_get_next_id_opts;
 		bpf_program__load;
 		bpf_program__load_strategy;
 		bpf_program__set_load_strategy;

-- 
2.56.1

