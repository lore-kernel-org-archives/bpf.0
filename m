Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620802;
	b=UzTnpKCxemuFHZZPvL8XuQTILXMC0NXU3YjYxh1nJo05zCfssPDOjw7/+E6H251je4J4
	 JN8XWWkU2L+2HZ1MiwMXZS0qkvYFTj8sqXRbgqPUt8Ijo7nqCHOCaXw7Kwc0a0Y0tJH/w
	 TCa1nKd1MA6wrhmjs9YiN5pQhrNpVva5hXCHnN8uXd6/zia1uUPxfSMoQ5WQywZ9SLvph
	 2E8ifejvGTK3MyHoK98/v82krKX0VqLZvbH22MUanHugrmasFbwd3uTtwQcYZWkSTuDb5
	 LZuorZhnnEXW6oirDk94CalZFO76W8XB6+OacvpRXlPHyrbXTVRfVxVeMZKjx0LsPdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620802;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=cJyrgdlkQKAC6AGWVfFqWyibxHPEJVSRAVkJT3ciB38=;
	b=KbHQ3VVwmFbWhk4NPePQ8PYWLmcjuC7Kt3HccATPGO63uTlP1W/3TomP8gUhdJj+FfCO
	 58yw5UHQquV2MGdec3H0mEDmUaWK2zQEtFVIHvaFnrhFUx2kzdQyXhDuXOO/Ia2LnpXuD
	 FjrPa7oThcmKQLyw4Lc07HtilE7PYyfHwnlHxNydEs+ToXytoRBufD7XEznuZJHP7V7Cq
	 hd5eUNqxZA2Z3KEqV8looaxPVlldVrLDL2+CHOcRSV7gqFoRzee55DX8eSPXrvL7fIC6x
	 ePPsjGm9P4FvDyHtbV5zCT1Eu2d4rM+IX3mh6/1EpYpsLsTKqMMiGQPCr3mTDSmQ/bw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=voRoN6yh;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ABA606A332
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 15:33:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5ABA606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=voRoN6yh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795620791; bh=nM9d+E0UCsqlFgq+S4hcqc5EQlLI0d4Dgd0mu1vRG10=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=voRoN6yh93HvigGDgeAw5x3+MbM3OZ2CTt5RijaywdhpBRXmCEo22Gs4tZKy6yqRl
	 TeeWoHessEsd9lFZ+VhZHcdJA2QNVSCcl9eGbAymRQzfWjs3IAy/BGZTJk7C15khyX
	 xGeGCDky66huoOm3ASES/L56vu7DmXRMBb6L4hvoe5wwYMCL3duzITuT2PfusPMLzQ
	 gJQqdcKtN/EdrGDwSx40Ceznc1G33EDqdomPngf+JqSJ4cHktbv6seJNI07NaOkWKL
	 m+qlBFqi45ybF4Fu7iN89FHLF/0GRxreBraVB5a8HP2UhToNFNArw0hdNE57yepPBr
	 bkWqzTfIGn1KQ==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Wed, 25 Nov 2026 16:31:54 +0100
Subject: [PATCH bpf-next 3/7] libbpf: Automatically set BPF_F_TOKEN_FD when
 getting BTF fd
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
Message-Id: <20261125-bpf-relax-get-next-id-v1-3-49175227c8cf@toke.dk>
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

The bpf_btf_get_fd_by_id_opts() function allows setting the token fd in
the opts, but leaves it to the caller to set the BPF_F_TOKEN_FD flag.
This is error-prone, and there's no reason we can't just set it on the
caller's behalf when an fd is supplied, so let's just do that.

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 tools/lib/bpf/bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 059c358c9744..3331524344a3 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -1276,6 +1276,8 @@ int bpf_btf_get_fd_by_id_opts(__u32 id,
 	attr.btf_id = id;
 	attr.open_flags = OPTS_GET(opts, open_flags, 0);
 	attr.fd_by_id_token_fd = OPTS_GET(opts, token_fd, 0);
+	if (attr.fd_by_id_token_fd)
+		attr.open_flags |= BPF_F_TOKEN_FD;
 
 	fd = sys_bpf_fd(BPF_BTF_GET_FD_BY_ID, &attr, attr_sz);
 	return libbpf_err_errno(fd);

-- 
2.56.1

