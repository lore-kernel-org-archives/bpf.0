Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620802;
	b=Kxjkr4II1oISCy4ZhGi+QqXbK7eSHc8ze+6yEfxoPdvqOUVDE1e9B7MRc/udn66b8d4B
	 6CFL1XmvSeLjo07kklCI2O2W63tA8Aym2ElbBuh3vQZr3NkqRVgRsSQX3I1sguFKF6OUr
	 fKE2IvelaO8lRqgh66yFww8FCbSDFEjqID700faI4GoeO+0EgI3DPEqGRwxUgb1Cs29NB
	 8Nma0I5ffCoYvXiDXyKIkgktjNE2Xvx5ayvpaETaXu9BkjK7H4gqN2n/Caoh1eijMhOHD
	 ytNo+idqJXiHR/4hQ8fxQuEpsRNc7LkDTlGmn5zsrLM3KfPkChz4IO5VOKbwt+vPmKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620802;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=vj/ku91bRx/dxyuvprXSNLwVUvVoWcGh2XYWWvVnp2o=;
	b=AkC08P/2m9JwJrrajhprDQXeWbi7olBVdWgfu2FcQsOYr5JUTCcddPJCB0Vx7j+a0jg+
	 2ElQTZBTRWgIkSfwybJx52nU7cBjwLI2Y1ne9roYyKzBLKXK/uHoYCPw8ZWDAsNjlxtCB
	 tGEA9H0n2G2MqTUrjtIfTNWqxzC2oi4kywPMhQt8SlYihgZTpd8dniblu4bl9t1egOmnG
	 yfvL8KRCwXxCy6NZR6NXu45CrOaVHxfMDgpMTn6ez9/lMYPuK/KIj/m2eJwVgjq8i9N0o
	 jq/4i3QdSaVj2NQ1gL3RvuQPRaWWBXMNXwlZ/tJMtoJlKEmyIFXKxb+87dWIfZOGgsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=nrsAfbkM;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A88606A331
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 15:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5A88606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=nrsAfbkM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795620791; bh=6s/+Jr6FYDxCLvC8jQunnlbTncMNtT+leCsdooV6vVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=nrsAfbkMXmeZ9K/2Rt9GMRo0UnrSSF6tZ91SzreIRtUwqXZJ8AGv5Vb/bRD2MTfrh
	 Co7ZO4Yi1uY7kxJ5uRcAvBZfh1kyRDJ8/O/b/+Cta9R08wHGEIh3hCAWx55+9wIHSw
	 HoVRq2E+bK2Am6umj/g3DjgKZmgHHLOs4gSNVhMdO1hEvJp90iWAZ8+f2XgbR6PwIv
	 IBOUT4HwumVF5I/qkNc3A72HPrGAamvdZ9vOdad0O6UOjG+Ow9vkqPepNvBZTwvWaH
	 0yq8Jv8Ad+hHXXmvQpub8pw0XX8rC0zVJltd5Oya2zuCvwYn0BVl3t66fmciBSmVzZ
	 yEOo+OzcQktwg==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Wed, 25 Nov 2026 16:31:53 +0100
Subject: [PATCH bpf-next 2/7] libbpf: Add bpf_*_get_next_id_opts()
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
Message-Id: <20261125-bpf-relax-get-next-id-v1-2-49175227c8cf@toke.dk>
References: <20261125-bpf-relax-get-next-id-v1-0-49175227c8cf@toke.dk>
In-Reply-To: <20261125-bpf-relax-get-next-id-v1-0-49175227c8cf@toke.dk>
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
index 38dcb31e8c0e..059c358c9744 100644
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
 
+	if (!OPTS_VALID(opts, bpf_get_fd_by_id_opts))
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
index a45666f546fa..899264fbb42d 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -458,7 +458,11 @@ LIBBPF_1.7.0 {
 
 LIBBPF_1.8.0 {
 	global:
+		bpf_btf_get_next_id_opts;
+		bpf_link_get_next_id_opts;
 		bpf_map__attach_cgroup_opts;
+		bpf_map_get_next_id_opts;
+		bpf_prog_get_next_id_opts;
 		bpf_prog_stream_open;
 		bpf_program__add_flags;
 		bpf_program__attach_tracing_multi;

-- 
2.56.1

