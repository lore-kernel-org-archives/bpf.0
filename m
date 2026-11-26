Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699269;
	b=ovXt2t02XtY8xTEZm2kTit3pcUcZPCynSxKnphPxYAg2Y0lWivn9PzvW0G6icNCIjnk6
	 vw4mZ7RqgwWTdjCcfB9DJQAgseeZ4nPqTBojrgVgReFgISl8EqChfOmjT8ZswXISPTXY7
	 qI2hdacExmWlZEitKJfbbeXmKeTGV2R5LSD1kO9GN08RD+7//exme3E9BWueHvJ7Rw1p+
	 nkvOxduN2QxlxV4hF9yF5o1yfRNmGb4t5oFA4AvOQT393FuClX7e00YPCXhn0HKsTw0mo
	 IiABGhBI2RtDFxMfeLcDfyevK1pG9klP8nRxrJEu+e7XacpmRBUQG0om5V0/T0QV78w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699269;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=nlkDmI8ZiL6GFJsi2qhFf/ia4WBgHudWp4E5MNym6QA=;
	b=mGbQFNK2nIE2Qi+qcZmdZO6xZe/+Z2i515cS89O2MyZkD2qr7PUFR9gJJaNMdkNKIUwR
	 RqHBnMxPL9Y6Sg/XrPy1xyiKSlBpvkhkXuzShgvZq2WXFGCeMB3TWesNz0HzVSCNPuygF
	 jrZdZUOc3lOkn9vvdw90m62MtONU3vTWUyu2ekfmr2/MIEFscYaDVdYEj7hYHxXGNddzR
	 7OScK0Q8KKoQZ+gAYpda6VHlkfZ/+wJql6J1VBovmhoRliuIZ7r5G449fljCUdoVqsBjh
	 1oogonAJVfJ44/B7iuwKNMKk3aklZM8GcZWrFMLw879Dn0GjNqGlOD/mGiZ82mP3D7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=g0vAmY8N;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739E1606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 739E1606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=g0vAmY8N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795699266; bh=xzpbabfX6GyrnKO1C1rGheeEZh7BgRyCWMi+Nt6V1hM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g0vAmY8NTgt+pzkj6UgNU+Y8eywdjxeOFMez/iSGVEIiIbbGgT0Kmhj2bYIAl4rgo
	 od9A8kHfiICUHGiOoq6vDmDuevBF8WCKxZZy4Sj4nymxE7As0iTWHbJBi11GQ0UAUb
	 Vq48pASDTXjzkkOzZYmFzrG/x1FWauclBfvQdqR/6PEaCu7XSil/dJIISpacmcaoQ5
	 ENSy3EjesrYIqRX1xKcBv8864d8XZcK1onbd7SIuRruHZDe0lA9TqcMXEw/dF0Ke5j
	 Orq956ZUp8qDjL1NPyDNLfljXMf0zUtLrvxb2KHd8hDGICTq2qhnu8beBb7C5QL/uo
	 kRgYLngP+F1Cw==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Thu, 26 Nov 2026 14:21:00 +0100
Subject: [PATCH bpf-next v2 2/7] libbpf: Add bpf_*_get_next_id_opts()
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
Message-Id: <20261126-bpf-relax-get-next-id-v2-2-039e92757f9c@toke.dk>
References: <20261126-bpf-relax-get-next-id-v2-0-039e92757f9c@toke.dk>
In-Reply-To: <20261126-bpf-relax-get-next-id-v2-0-039e92757f9c@toke.dk>
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

