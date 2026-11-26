Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.145.95.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795704705;
	b=awtWXuIWb/Rhhw8YTpjyHWIYNzNV6VwzTh4AlguED1XHlO5RZKLBv3Xmwd0221eZzxXO
	 kcodM/03rjrF4np/oBB23cafKzGdzA/k+Fg4F2L/5ec5z5SQSZVIAZEA7q+4bew9Vp/av
	 yHPeDufNQk3bIwunbbuLzA/5ZetVm6+FaQOZF8s3B8eTsX5a1F671KO0csVpGvv4d+rpJ
	 MZ27R1SbGp+dC5ezUdHN3kKjFZtgS4NepimF9WfJrof59i064nRUZokW5rCdzu3Wdue9M
	 lERmyQS3G4DjPh0sYbONfLgs33f49txQpI+EkP5jvYF5Kko+w0by8o8QpjSvsIkvssw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795704705;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc;
	bh=O5Krgxih3e4KsXY4bzJER4aWFwuSUMh46+o8BkgE19I=;
	b=Mh8UqG7EvUXfBA5DSFw38ErF4rsYrm7f03V8+DSa3WxA368VF5UDwKx2j99ql9LA84Jf
	 rSfP26cCMQjEBGNBpuYKQ0g0gH8pqJCgkzaDuAJlHZ4XNaUgkCjKK4JvMSRT3RgcWw0y3
	 jpIFLQ+jlbTjvdhb3wt78cb+30Nc/6Tk8PgxRA9YusWv/MrjSow4iufZKYwqTIs0ayXul
	 UA1123ZxD0zluRyyJhUsDekM/dMsU1Rs7HkI9ESMNxyDNQ6bVeYqLCFjpnJSiiWW97mLA
	 1SWhK7gQZ4BBEtWd0mLEPfG9YN26KNV7VM6W7I4k9j10GhSBUKWRDNMS0bFnbAMgFTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=toke.dk;
	spf=pass smtp.mailfrom=toke.dk;
	dkim=pass header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=M4jL5jo2;
	arc=none smtp.remote-ip=45.145.95.4
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 757EA606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 14:51:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 757EA606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.a=rsa-sha256 header.s=20161023 header.b=M4jL5jo2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1795704702; bh=7Dkfj0+qQfDl+W2M99G5T+dYIy/icfsRqprPJWixbhw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M4jL5jo2BxnQayaSB0+xe5VICKBlWk1Gr5RrxUHNwyn0nPEdGnAoCVPfQv2CqXi6/
	 AOsDr33r8Cv09WhYsYamkE6BOy7UwIKn/RMDqi0uegVd++y1w5I8dLAY5dyfa6UHvp
	 MCto6evFg5urjb+z/6kzoVLH/pv5fJPi1QZgRLQ/XWzbRkTdrfYNGCaxS8CPCiQQJ/
	 4j7fCCBQxfJ+oPse6kPJuODhk+w3x5zh3JQztP/TWuXX7p2P2nhLLhLWcyU8LYb+K/
	 mWQVaycIioRk46fHU7fiYq7US3c+wp9qjvbb3C4hpZbcOtap8tu7Qh4iYkn85RnBD9
	 fHcTFqjp1OHnQ==
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Date: Thu, 26 Nov 2026 15:51:39 +0100
Subject: [PATCH bpf-next v3 3/7] libbpf: Automatically set BPF_F_TOKEN_FD
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
Message-Id: <20261126-bpf-relax-get-next-id-v3-3-338e1d3077e7@toke.dk>
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

