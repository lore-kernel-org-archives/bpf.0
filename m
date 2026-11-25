Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620800;
	b=ZVdW4TP9/uSoH0vSxh5OlF2xRb51W3uqHAG9K9l+sr7/IFYVaP2P733VFLTinzAJ6SCc
	 9zNbr7eYTN04cxVMrI7HHU5H7BuSkkRkdr43kXaLCF8Jy/YtaMynha2+wMQRAzYSxyten
	 uNZvL7m5R6knXEM0m5qlTa7HbDoZsx6wvfU8IfiTOuq8MCzmKCuXMGxnGTiPMqAYLCWiK
	 3KRhE4UqB2bYGlWpdUALxC28Tgd+Ff10w20emxXDCyjBYid5a7jA7JIt3bj40rtgkZY4p
	 /974hE94Pbhvso9a8RkPrsEDNNq2zrJfVJz/uVPSFJhddCNQJCN+3RHmK4Ix+JWWMrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620800;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=tWE9yJoeA/90t3S5/2FjyLZnSEveLvfy+MuzBCbioG8=;
	b=YGu1CGvb31x5Cef54M9C8DcneGTyQutL0vFyi9oZSoZNb07iVMrBGeXb1cQfqgb3Er9k
	 7bFgQFTbxzJrLlGrJk9R2subBaInMVqjkG+BzdzGXiG5JWkkpXo+EOlYa6HXgettmNb93
	 tOvZ7lDeujHwymD2YULfbVT1VX5X+P0m/6Ji69bH3+E6a+fz9RTkx5VgXdsfwpudn/xwc
	 vGzdBqd3iOt5oGb5sbz0+Iowv94F2w7xQi1ouSv84DflPSQOrf7l5eP2TK3hR9cotJove
	 q0ufGcMtlmjBPvrCXstuWWQXB6ibNrKKXFcPDsjw9HsZIMFrbPLis+DidIaH/Mu6dPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=upBFFKGQ;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864E2606A32A
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 15:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 864E2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=upBFFKGQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795620790; bh=nysplZJM/JoKZmGEVx+/kMxzn0aouXkTcqs2/gjFMqM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=upBFFKGQ96yxVhrdcQvMfaYFdNUYKwMW27Njq0B0iDhG8zzcvjoSDiSR5T2jTfVCe
	 99k/mNMnt2l8Bc1YpF22bmRaTfwdnAlZIEpK9ZCYjJIT3gHNB60PQjioX85xWCw7bW
	 CImulX5sxltLhy+cvcph0bVpGDGIMCBoyzQIwp+1tO24az8xRomwRl+3j/opydUnuG
	 3+jQAnlGAOPJd32fVNTuonm5DYONNd/MAk0j/8Z6/oK6KVfibStOl5/7Z6drrw+pr2
	 mDZSlJTAQjxImOoXj40vdPpY6SHpluzxLV2CVQwJYee8r4f+8q4E3Cl5WU0sjUPyQL
	 7whpAdfNZXc0g==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Wed, 25 Nov 2026 16:31:56 +0100
Subject: [PATCH bpf-next 5/7] libbpf: Pass in token_fd when iterating
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
Message-Id: <20261125-bpf-relax-get-next-id-v1-5-49175227c8cf@toke.dk>
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

When loading module BTF, libbpf will iterate through the available BTF
IDs in the kernel and try to load them. This fails inside a user
namespace because of missing permissions. The kernel now supports
passing in a bpf_token to BPF_BTF_GET_NEXT_ID, so amend the iteration to
pass in a token if it exists.

Passing in the token doesn't work on older kernels, so if we get an
EINVAL back when trying to iterate, we reset any tokens and try again.

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 tools/lib/bpf/libbpf.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2ede3081a20e..65c2af92db2f 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -6014,6 +6014,10 @@ static bool is_btf_mod_allowed(const struct bpf_object *obj, const char *name)
 
 static int load_module_btfs(struct bpf_object *obj)
 {
+	DECLARE_LIBBPF_OPTS(bpf_get_next_id_opts, next_opts,
+			    .token_fd = obj->token_fd);
+	DECLARE_LIBBPF_OPTS(bpf_get_fd_by_id_opts, fd_opts,
+			    .token_fd = obj->token_fd);
 	struct bpf_btf_info info;
 	struct module_btf *mod_btf;
 	struct btf *btf;
@@ -6038,20 +6042,26 @@ static int load_module_btfs(struct bpf_object *obj)
 		return 0;
 
 	while (true) {
-		err = bpf_btf_get_next_id(id, &id);
+		err = bpf_btf_get_next_id_opts(id, &id, &next_opts);
 		if (err && errno == ENOENT)
 			return 0;
 		if (err && errno == EPERM) {
 			pr_debug("skipping module BTFs loading, missing privileges\n");
 			return 0;
 		}
+		if (err && errno == EINVAL && next_opts.token_fd) {
+			pr_debug("retrying module BTF load without token fd\n");
+			next_opts.token_fd = 0;
+			fd_opts.token_fd = 0;
+			err = bpf_btf_get_next_id_opts(id, &id, &next_opts);
+		}
 		if (err) {
 			err = -errno;
 			pr_warn("failed to iterate BTF objects: %s\n", errstr(err));
 			return err;
 		}
 
-		fd = bpf_btf_get_fd_by_id(id);
+		fd = bpf_btf_get_fd_by_id_opts(id, &fd_opts);
 		if (fd < 0) {
 			if (errno == ENOENT)
 				continue; /* expected race: BTF was unloaded */

-- 
2.56.1

