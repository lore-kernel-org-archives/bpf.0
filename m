Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704706;
	b=EeGYhRO8q+wRPqLKIdtoULggT3toLhk4g5ht7sntJN9vcvHogP1HiC6R/M6aTK6E42zP
	 IUIw7nEALrC7gGUyI7R4YRY3sSdI5T+grK4nWu38Ikcm+npQVaLmoUoQWacuClPtvhp8O
	 tbu5HgWw7NxtdCtDA/hlMeEx+EAHfieond0GXpKzQAsm8TOo7XNkXhGPBSjGboM5Sewhs
	 S+x5z1HKFfe5zEqW+EH+FBFlRXgu0UtCHy235vsHmz0+z53IsCW0S+fb+o+3ivYkzrfAn
	 hQ8fouwtKu4bOs9onxgQHe/abzxfwf3GwWbjSCsQITs2sxm8j4Y3iiVIOryREtUiN3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704706;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=J+wStp+cY2J3LC7OQa1S7BrFp/C3NfDFBbxIQeERK2c=;
	b=DtLM9LW3y5j6HGNfTrCLse02ulVpSJzx6sTkB7ziZT5FvGpFwhC8r41cc0j37h7jNb6M
	 7GZ+9jOcoeD5ZBClTVIvsbgyX5zlou5KFIrAImOgV8EzM/kBax11emlLjYavvRs/x/Nl3
	 /1W7lEXWIpn90Nd4UFDKINn+1RySDJZ+mVJw+FH5m+LQU+oBSXXPZISepFjLoDczWGGEE
	 YR5955koeZ2dcnvfXLPQchXGNPLu7jeFwljIeLrlOVYre+7ojwv5pkG2q8xCZfD9pLIJF
	 MxwomKBZdUZtYZwP1tJz3HssjkFD1kOnHKtiaGlzfmnzNywIlQy1oKrb6IlcOkty2dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=saF3swNF;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7574C606A31C
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7574C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=saF3swNF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795704702; bh=f2+fsRpOJ1ggDg8DF1sBAHX1vaoIQ7eV7e7SzLgcMh0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=saF3swNFWIZw0G/lKtEjodDUq5XIjnBHqxzIjhqHRtfcVf4JMxlYMZb/FTpEd6DJ6
	 qHXIMDDf6qjoMXF0xLSj8f/eNAjIHur2chmRbc/0oHhfF6UVIBDjqMWvruvICmWvBg
	 Pmw51NY0dFHK66oDl0y1moHB1zvQaQIAqiLEB/BAI4C+5gPOqtWMDYqx+6pNnrVO5l
	 BYuwCal24wUh49P24J29Gd6/dmGZ5mndWkVMIM0YEgf1vV4/wHAfqNu2t/mBKo7MJr
	 IPKSVAcX3kBgvJqDcP6EwLIaO72NbqynxAHYQ1mUbyTPBOGfF/U23MFNlTLSjize5D
	 j4I7ai1mdh7PA==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Thu, 26 Nov 2026 15:51:41 +0100
Subject: [PATCH bpf-next v3 5/7] libbpf: Pass in token_fd when iterating
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
Message-Id: <20261126-bpf-relax-get-next-id-v3-5-338e1d3077e7@toke.dk>
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
index 1f1569a35f92..2f4370623a42 100644
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

