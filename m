Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699271;
	b=O9coV870/Ma0FK4pWQdyh0vMMeqgnAGXOxDWwE/6hGu6y6FVOdI4vmNTjukdBom6001B
	 mZcIgOC6RedeMtzKi5/lF3aCqXBuT7apiWsOYeCbUVig+VGo8+bOU6HvQVMiPVRwVrr/f
	 Xvf6dqkw476BpreK3Gl8gNmbhOjE5ga5kqAqpZSfzDGjZIItjQ24DKWO6euroLluRSDr8
	 oxLlxo03Z1PNVh9ZFCzbyS9CDAEFG91pCZVk2Q2Dr5UoFHmba+Vwb9zSZTmGRUWCwow/I
	 5rQ7cHbvAT4SeMrz8g0FjIfpW1mYCJZ0fCTj/8CNmTzic8t7mfCms9tVt3zbPw3bNAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699271;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=fUmke9tSlFCwV23Ujt9zCCmlnmXUs/kvogA2VypNRzw=;
	b=VIlgJ8nYeGTHBddY02SMojgFLF91dFw/HMOa/Ed1Ph5IkKCzI0tercy3RPVs3c/lJ1bZ
	 UsHfBRWPyCRaEmheOnwREM579xWvqMZ8gV8F9vljhd7bTFBS9IG+F2vK8L98squJdYihx
	 Csl1ePjIwRovSq6xZ25oiivvRJQZPqURYbwbK0OwfeU0vKQIRyDrlj+ssv4smAn4H91ZF
	 sqm7l6qfzOe515KZTwrPANaBUofviihh4v8j8SLG+AI+hrFSTiutrkCRYSIx3qiq50qF+
	 yuY8g4wMJ/WliZTRAQy2jD7rMk6xwMXxfFJ7RSFe7IIfrzKGmNl2JSS1xuEwfRpyDXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=QrzVFjIr;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D16606A681
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:21:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28D16606A681
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=QrzVFjIr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795699267; bh=VViIhXw1gUemGgNjnQ1n8IGX3dEFthuqDaojbu7tzqw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=QrzVFjIrZxqWJ3DygsAED2BRiqFKJgyZecBI04pmfq+q51MBuByShxK6LswTPte3Q
	 pgQh+OpI1q/T21e4TiOCDArefrkSjxThdZvqF2pQUUMgwiFITlMJodWkPI9qbNjIqg
	 thDsk4IjFNYkWO1KCYGYHOLOkPIdShRewcKUjl7dvqHWdPaWUnVB1Or1iUqejpHQl/
	 JIVN/FBIyZAYd3vEXfx5VpMuLH0W/zGPCR7aLQNicGBjsZh1XjBb9GE9eglXAKsn+w
	 FM3iqF9kfs6X9rHJaT60HHnHY9MLErSvp5bTaQ/JG7y/2Ce296/cgW6e/09yfdSs21
	 SPGOhSaMhNVOg==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Thu, 26 Nov 2026 14:21:03 +0100
Subject: [PATCH bpf-next v2 5/7] libbpf: Pass in token_fd when iterating
 kernel BTF objects
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
Message-Id: <20261126-bpf-relax-get-next-id-v2-5-039e92757f9c@toke.dk>
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

When loading module BTF, libbpf will iterate through the available BTF
IDs in the kernel and try to load them. This fails inside a user
namespace because of missing permissions. The kernel now supports
passing in a bpf_token to BPF_BTF_GET_NEXT_ID, so amend the iteration to
pass in a token if it exists.

Passing in the token doesn't work on older kernels, so if we get an
EINVAL back when trying to iterate, we reset any tokens and try again.

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 tools/lib/bpf/libbpf.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 6d0e71aff3e1..6bfa5a9eb8ba 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6017,6 +6017,10 @@ static bool is_btf_mod_allowed(const struct bpf_object *obj, const char *name)
 
 static int load_module_btfs(struct bpf_object *obj)
 {
+	DECLARE_LIBBPF_OPTS(bpf_get_next_id_opts, next_opts,
+			    .token_fd = obj->token_fd);
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_by_id_opts, fd_opts,
+			    .token_fd = obj->token_fd);
 	struct bpf_btf_info info;
 	struct module_btf *mod_btf;
 	struct btf *btf;
@@ -6041,7 +6045,13 @@ static int load_module_btfs(struct bpf_object *obj)
 		return 0;
 
 	while (true) {
-		err = bpf_btf_get_next_id(id, &id);
+		err = bpf_btf_get_next_id_opts(id, &id, &next_opts);
+		if (err && errno == EINVAL && next_opts.token_fd) {
+			pr_debug("retrying module BTF load without token fd\n");
+			next_opts.token_fd = 0;
+			fd_opts.token_fd = 0;
+			err = bpf_btf_get_next_id_opts(id, &id, &next_opts);
+		}
 		if (err && errno == ENOENT)
 			return 0;
 		if (err && errno == EPERM) {
@@ -6054,10 +6064,14 @@ static int load_module_btfs(struct bpf_object *obj)
 			return err;
 		}
 
-		fd = bpf_btf_get_fd_by_id(id);
+		fd = bpf_btf_get_fd_by_id_opts(id, &fd_opts);
 		if (fd < 0) {
 			if (errno == ENOENT)
 				continue; /* expected race: BTF was unloaded */
+			if (errno == EPERM) {
+				pr_debug("skipping module BTFs loading, missing privileges\n");
+				return 0;
+			}
 			err = -errno;
 			pr_warn("failed to get BTF object #%u FD: %s\n", id, errstr(err));
 			return err;

-- 
2.56.1

