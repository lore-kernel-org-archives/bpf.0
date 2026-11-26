Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704705;
	b=GdH2JdztACjT/rm6t5IIEraME3lB0FmcieA09blAJbnU5Q/eFJrRPFYOqgC2CnP7Gprs
	 LOHEQ+J8fGg4j8fUPFlfueHhV13l9sFgvw0WrulqjwLcYgxkbnlIupny3++50QmqGK/Cf
	 8rViis8xu3f2J3Wt7HXZG62XUdD3WNcIqiLfe6yHLJy2/+y0LPCuqlnqngXRiQ8UNA8EX
	 JgBntRoOY9mHdo7tanOh/3c79yMgyGdY7Q+YQW+0HgoysD3eh6qhUT3KFGoogYqNSHCIS
	 IVZvGMvg23/82ajoRYeO5EBqTdE17mvbg8FGC9DGoLMrzy2/QXhlQAp1mWwD1CDYGoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704705;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=IGnDONoodJNq9AhalceE8gWCLIGMe+tCDoPS7kPTZ/4=;
	b=AD/m6HV2/DZ54V/74e0bJR4o4PD+npa1duQbV+bonj66wwDjXj/k0JGh2saX4880HftT
	 NUoE06iiGlpoRk/9G8qYtxoHs+J1DOL12Ag7tr5bppOU0zWHcImRmUIzJzZwNqFFH52jF
	 kXhSsNtIP388WIfRYalUrhe49Ud38pm0HW2xg338LDoSssRj1MpTPKr5XXJbQ6vxQ2Cyf
	 +SttDruVW+XEEaTuNXF2d8wC8plO/Md8YqbGFTa9WCJqTZZv7mmoUCbJanwkZVSiQ5YHk
	 YJNmTARgyBdqTcqW5+UJhEqmTe3/g0X8y2DJMCIWtaGYgXca0TXiwtu/9S+jrqgGDMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=Yy27RZRL;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75971606A323
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75971606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=Yy27RZRL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795704702; bh=4oga7aOqhwHQ+hyoQDJ7/qwrpXTBz9Nv3lSeN94a8vs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Yy27RZRLGNyOuI/qXg0qwhGEZ2AlVErK2uQlbTUL7GoRu/8M7JJ5Uo0oms8GB4EPO
	 4xhC3fvR1NQKBUUlQZrl+ONKP73IAJ3SOJstl6I8A54IEX/LfW+NPif0unz3XKIAw+
	 VMc81h6/WA4WF4TeFz+taaUm3qjn4HwgTRVOJQ/dhSxU9LknO45+UOFnm6Jkt97K8+
	 /pqb1VmUXGOOLz/AdDYcM4P6kjbrXdEO5oCPmCMdhhl3u+hg3ACiEkqZbHe2MHtRK/
	 M7hgWQMDZUmF44AWUrIuDb1lYuNfzp4t8zfAbQISfupLFSC6DhA4/6aIszeDJvsXTE
	 Q4IfT8YkfmV3g==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Thu, 26 Nov 2026 15:51:40 +0100
Subject: [PATCH bpf-next v3 4/7] libbpf: Move bpf_object_prepare_token() to
 object creation
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
Message-Id: <20261126-bpf-relax-get-next-id-v3-4-338e1d3077e7@toke.dk>
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

Move the automatic acquisition of a bpf_token from object prepare time
to object creation time. This ensures that the token is available for
any probing done before loading the object, in particular for BTF access
in bpf_program__set_attach_target().

To avoid the move re-instating the token fd into a generated loader,
clear the token fd in bpf_object__gen_loader().

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 tools/lib/bpf/libbpf.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 540daf7752b4..1f1569a35f92 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9281,6 +9281,7 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	err = err ? : bpf_object__init_maps(obj, opts);
 	err = err ? : bpf_object_init_progs(obj, opts);
 	err = err ? : bpf_object__collect_relos(obj);
+	err = err ? : bpf_object_prepare_token(obj);
 	if (err)
 		goto out;
 
@@ -9873,7 +9874,6 @@ static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_pat
 	}
 
 	err = bpf_object_check_gen_loader(obj);
-	err = err ? : bpf_object_prepare_token(obj);
 	err = err ? : bpf_object__probe_loading(obj);
 	err = err ? : bpf_object__load_vmlinux_btf(obj, false);
 	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);
@@ -10543,6 +10543,11 @@ int bpf_object__gen_loader(struct bpf_object *obj, struct gen_loader_opts *opts)
 	gen->opts = opts;
 	gen->swapped_endian = !is_native_endianness(obj);
 	obj->gen_loader = gen;
+	if (obj->token_fd) {
+		close(obj->token_fd);
+		obj->token_fd = 0;
+		obj->feat_cache->token_fd = 0;
+	}
 	return 0;
 }
 

-- 
2.56.1

