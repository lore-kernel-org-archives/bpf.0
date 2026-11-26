Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795699269;
	b=tn3X18wu9dU3yccuoJ6sqAD38DFc9a6I1RFfgNWbPWh3alBVzOcerFp65EiGHYtaO3z7
	 3yOZXuCfWtYjMlniBPKtzeEndx6I5SVBh240V7i8waLAQm92Wsa/9a6r19qgSQzNy7HcI
	 UIE1nefV/xdmrOvc/4KM/HZUg2cXcgcU0Vmp2CNV9ZkoORGqtTeicI9p3WyiqJiHB/rGx
	 RXYWopgKCAb3dJg72xxFeiNOhkue9mYZNyVB2FKjIK9mb/WWBA48D3izFzWMvVvQRloMk
	 uXFggct7GDYZrq9CUZttoK0IYopB/9ZhhNrhunN2iRrFOZ/2rmSzx9wmXr7ZygKVI7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795699269;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=O5Krgxih3e4KsXY4bzJER4aWFwuSUMh46+o8BkgE19I=;
	b=IyCil69IQRTqcKvTjbGKxK48ZStLdqgE7PliNmPQP71heAVx64gUb9fg5A4fAuLsYPWX
	 m+CdI2nKvT/lc9nAATkFVJAbcNgUyGN7eSStN4npZKoy9AEW+reOrSYTnYsmZiJSfesJv
	 gVq2oCIbyGIQwGFJuedxRRfh7wH6s6Vx1tBD/si9h2wLQ+0g0WP93rnrem8WmxXYAL3AN
	 VOOU/sRREGyZEtkqD3HeO78F4HGpjAgkm9F+3ajAsY2qCB1IoXG7DSWVEXodyYB5BVa5k
	 XKPp5VhXA0BBXBE5xZmplY6FUzzN2/dKWulWJFCGN7Nz2iMrARobopnZ6gSHnC4s58Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=RWDSjs+8;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B51606A326
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 13:21:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73B51606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=RWDSjs+8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795699266; bh=7Dkfj0+qQfDl+W2M99G5T+dYIy/icfsRqprPJWixbhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=RWDSjs+8QVT/zFzjJm6ewu2xhse65Lsd06mpmX2ROKlHg7IEC3MDTYqf0EXWxnKLg
	 lsNNqwPrvWf+hUisEcQLcMRnFRmJGdPDWIRXzCk1f/0spDxL0cVJZQ6vaBQUZstiOs
	 b33i0y0ugw8MJxj6J3c2JUUJBHvH3EG3CeY77rJBDOKxSNTBbnxbXo39quLReA94v3
	 5rlE+5PFudeLRHRyXNGUl3Pi40LwJms/ktK9ZCC2yrBVKt4P8setmTDgnQK8MoLrlk
	 +y7vSA+ZZZEoi2GsyU55fNwNCNdzjl/aYSwvzgh4OcafA7cDbjxeBwAbPG/uqT7XkV
	 cnhE+8qaM4aRg==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Thu, 26 Nov 2026 14:21:01 +0100
Subject: [PATCH bpf-next v2 3/7] libbpf: Automatically set BPF_F_TOKEN_FD
 when getting BTF fd
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
Message-Id: <20261126-bpf-relax-get-next-id-v2-3-039e92757f9c@toke.dk>
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

The bpf_btf_get_fd_by_id_opts() function allows setting the token fd in
the opts, but leaves it to the caller to set the BPF_F_TOKEN_FD flag.
This is error-prone, and there's no reason we can't just set it on the
caller's behalf when an fd is supplied, so let's just do that.

Signed-off-by: Toke Høiland-Jørgensen <toke@toke.dk>
---
 tools/lib/bpf/bpf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 773efb585bca..3d2dbf6d5fcf 100644
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

