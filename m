Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620800;
	b=vxqhOxrJviE+Jruaenb/Vyx64q1Wz81f6zkpwLoIykejjMg7xk6WZboGEpzmdwswORGS
	 XRA2icgmgWW5+ZAa23rnq5d1a1Wq9lrWtWUozq+sRK4BZNDDEPmMCdGz0uAXS1Q430GPS
	 x24h/8GKsFDL8SISgEw48MOdXUNjrnJBTF5vg8viTBEcchaK4ihNZ+bKrmrVMip3MbNuS
	 zEnAG0qUMGOeFGY7pRwDceUz5lAyCVWG5XVTtZd3StEppCM52293bSilh78vWzaa5cZMj
	 tictSi+hDK33Cl35zYfOO3lXWr9fNwvPEDGNJt/aAPlnbgXB7WOW98lqFErEMxS3+uA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620800;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=lItV6E+P3mviqgLhTTuWeI66UF6CZJunGuuExwMKzx8=;
	b=cM+BcJIm1jY7oT0TPzEkBYtVuv4ycQRdTxUze11AlCPSiUB8kHp1e7ENV7OH8N2cR5Jv
	 lsfCOvYwlX7Y8yS/Kb1cc1/xKtSgsYb0Tv4Ys2QwLSjKcU8JFxZZHAH3Mnxgim5v4OgGL
	 rSgIKSmAI5zZvsUQeWB/2NI/EXBKJska5UJiCJFeduiApZ0NC78/98wlNqUoyII6YGO8D
	 fXu/Xg9Sfrox1DxBU7VSs+5qxrMVmnals4Mmz0VtjjMJxOypBHiGY0nGA78b4f852whnR
	 jUCoHHxBqsqSI0lDqTeoJIk6GMsErZ0dim6NcpDB/L70E81ShV5468MxO1zw7B9ctOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=Or7glrQl;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86494606A327
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 15:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 86494606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=Or7glrQl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795620790; bh=IiMzflmBBN3B0EoCmGjb2mExzjEM7SEOb7VZsUIEtCk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Or7glrQlRNUqu9PSmsOWbhayCxLC1jPpeDUHCfbC3WJdR1kjkZryAw6jQeqNDCjmc
	 M0SFh4SuGhyNCJReWqNoLHeauKdiKHqHgyFbIrtdA3UVEyMPULk7cmiZT74Dri6Lkt
	 Ni4+zZ0FSAI4CYX896uX8DcijGARqwjW3gNt+4yYEvgostRrBcmHcKu/UEQzBxsKkm
	 qN+BOJKJVsrBOe3ouMfQTLu06S0EL5rMm4FfEGvDJiJ5PwK96EWP5+J2+j+KyaDCKo
	 unvvJyR4Iq7YfKucrCFarBPmsY+cgwNUcg+L5JfUFd++ZcR5wpr/zslwqB0i5Xr0vr
	 6pz7TlwMSEQpA==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Wed, 25 Nov 2026 16:31:55 +0100
Subject: [PATCH bpf-next 4/7] libbpf: Move bpf_object_prepare_token() to
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
Message-Id: <20261125-bpf-relax-get-next-id-v1-4-49175227c8cf@toke.dk>
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

Move the automatic acquisition of a bpf_token from object prepare time
to object creation time. This ensures that the token is available for
any probing done before loading the object, in particular for BTF access
in bpf_program__set_attach_target().

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 1efc0dd37b2e..2ede3081a20e 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -9278,6 +9278,7 @@ static struct bpf_object *bpf_object_open(const char *path, const void *obj_buf,
 	err = err ? : bpf_object__init_maps(obj, opts);
 	err = err ? : bpf_object_init_progs(obj, opts);
 	err = err ? : bpf_object__collect_relos(obj);
+	err = err ? : bpf_object_prepare_token(obj);
 	if (err)
 		goto out;
 
@@ -9870,7 +9871,6 @@ static int bpf_object_prepare(struct bpf_object *obj, const char *target_btf_pat
 	}
 
 	err = bpf_object_check_gen_loader(obj);
-	err = err ? : bpf_object_prepare_token(obj);
 	err = err ? : bpf_object__probe_loading(obj);
 	err = err ? : bpf_object__load_vmlinux_btf(obj, false);
 	err = err ? : bpf_object__resolve_externs(obj, obj->kconfig);

-- 
2.56.1

