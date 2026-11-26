Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699269;
	b=uwdfbu6KQwHQXOVJYawI1eoqoQitlq9g4yruNhfiiSFP/HUJErB1RIjp/Syw4Gg6Gxwg
	 h3DcoujLQVWjVxBJTKS1MeoL3Rs8fQNjJ2w1p1miEX8oxsdEeqCjYlTU+ULOGyx0KhhEX
	 GcmcvgffZQh3KF9gfIznJkWJouCInjzjyeuG/IV8AtdEub7zAoT1MNuFutxEFn00n4yfL
	 oPphl/0qQt19niLQM6hISjJhfu/tL5kCzFIYeKdkDhZ1J/A1PwzQMWEUO3Ap948ZcktVS
	 BwH/idCQ8waHSu1aWPjKO7cLc0Z+BmLfgpR0C1DvtHf5SD7jwgobJii3BbSK3S9AJgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699269;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=UTUUcT/7L2700NzDXIKy1q+MUtNyZGf4JTtHtb0Va1w=;
	b=NsiNamVCCDkz0AXEtwiiPzBFY+3Obg2imB6sNZ+D0O8bB98ueHN2ocIxeFqvpfbVI0xj
	 Vn8ckeYGtOClfdQZMBLmZTowUQ2Qf5eybH8Z+wVRGv6jZNAi2nzpHD34Bvh/zkho+uOdB
	 Zpij8T11QnpIxk7TizG9OFg6WXm4ypDjqRJbPBoiam7uRREa+ZvEURJUXpJASN3o945S3
	 OdJN1R3Gw9YemfE02m1MytXH7xz6S4adBb1sTc4Lu9/OVyrimREkX+VKj8olovqmWpuYp
	 GjIQvjkqwi9TjK+JoVo/nfpSgT6btUxJaWxY6L6e/X+gtx+9/fyV/xiOXTKtPcQXk2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=agb1L7qL;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 739B5606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 739B5606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=agb1L7qL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795699266; bh=dkUfooYISzmKnk5P0bc72xIXEWgrKzJY0K9qkurHRXA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=agb1L7qLpqIQ6pa8ZhaqFf1ymIu//w1JFm0G4rEYFJqaSEiLlqFlCLyEq/wB/40rC
	 mTw/YOQupOnVI0UJFN32I3fOMvhaT4ig1Q9ELzZS9tYvi1ZUqGKYmO7dtGI2Disoii
	 Ozx839m7qPmIVwmclrprNJhlAi4G7KtxLMV8X0Pp7YVr+Z0ilCcQkbLusaUXpYmEZA
	 HsafYNH2b2VzQAoDF+LrbL7PdLPyttUhtSXp7ilMKWaahvin1Ylps3YLR0VqXZvDaq
	 2qFuDlwOKNLni8FPQ9CMW5hY3FcusRnDd6DuVOK2Up2XegubnfJ0cxQGqTx9wlP0Yf
	 B1ljACBjGe74A==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Thu, 26 Nov 2026 14:21:02 +0100
Subject: [PATCH bpf-next v2 4/7] libbpf: Move bpf_object_prepare_token() to
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
Message-Id: <20261126-bpf-relax-get-next-id-v2-4-039e92757f9c@toke.dk>
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

Move the automatic acquisition of a bpf_token from object prepare time
to object creation time. This ensures that the token is available for
any probing done before loading the object, in particular for BTF access
in bpf_program__set_attach_target().

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 540daf7752b4..6d0e71aff3e1 100644
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

-- 
2.56.1

