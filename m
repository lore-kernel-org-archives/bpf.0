Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706355;
	b=lRZj4I7Q4dUT/kM4o//mDXVgGaOO4C6OLG6AibCySQK77G2VzuRQNIePXd/a2UF6wQKQ
	 gElKfDnPFGs+Wqk0vONYe/u6hgHa5i+1q7z+5PaNaIVhb+Q4dYwc4Zc016oBJ9UTGNIFA
	 XVJjV6N2xKDSf/KPOFIbl7va7pwMQfMUqWmVT/NOep7P284ig5JtYQ4aaTnpWchEDN5yL
	 HdHmRxW74T3uId9bofGxXScRCZbh1taQi38/BeBuJuBjnyoBH1k8o+7GXus2nKUlR+keE
	 YDVHXfithwVAzwSsjQ1egsdV+dksA6n0hrj/i7SQs6KF4FnfdIrWGbbCIpjr8byksUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706355;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=CFEWEjXQyyYWKAO9nu6+2AQO+AjLoJIW9TEel40Z+BE=;
	b=KzSNdTg4Lox27p0WG/2avdq7QYO8wtp4zLKBAb/KGR+yZqnZFU0vRGgxXmHo7/uciYNd
	 z2iGZsvjaRGGHGUwF/wHQvHTkL93hO0tt+ifap6Mw1VG+M3t4xqIEyoX8cEEK5NL6vd7/
	 zeGBWUuJ6hKUsCyygXcioHdE5uZg+f6g+Cy5rvJepCOjFAHovSoNPo60nCLoxRww+bnJN
	 Zj53dFOV82nEuvEwcBP/Dp7dQYJplm9t8q59QQ8UtS3A/UPnE2728Byk4YyxeEnL1iBoE
	 riClfxRHWRiE08GtsRQR/Rpf7qCCRA0Euq9a8FKGnu4f1EejHDZHwj4FGce74fDQg2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XI7aHEMx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDB5B606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XI7aHEMx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B42661F000CF;
	Thu, 26 Nov 2026 15:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706355;
	bh=CFEWEjXQyyYWKAO9nu6+2AQO+AjLoJIW9TEel40Z+BE=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=XI7aHEMx7zjDGJAt4acRgweYmnvUc26lz+BXNSLt5sfmSWHBEkHYnKfIrSvdCdsZx
	 ADL+nbVdFLbA4bnvNyTs9X47xhWskMUSICJvQPPrOSeipfMGoS6v4t3FSaBP69V/fP
	 y2A9lzKiC4Yb9BFR1mj1iTdGSj7Qkgei0dl2DTpDSNQG7WGAsNdHIqOp0hQkwjDL+P
	 /heXoemEer1RapFTnG6rvxnkpNQwUBKzXevEFpgdGZZuXFDjXoDYAHijQxgd4AL5WR
	 IqDQ9APTfDIYCdvDmTKw0C/SCpYWApxV24l77ASQNaWcl/jfDA4QD5kmy8m/jZAxss
	 OsHlRHj5Rj/Cw==
Content-Type: multipart/mixed; boundary="===============6898464612949323623=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <946e7c7d7e0426338ce4b1e3d7ab9df23fbd944fe7b992193d38a1dcff5ac996@mail.kernel.org>
In-Reply-To: <20261126-bpf-relax-get-next-id-v3-1-338e1d3077e7@toke.dk>
References: <20261126-bpf-relax-get-next-id-v3-1-338e1d3077e7@toke.dk>
Subject: Re: [PATCH bpf-next v3 1/7] bpf: Relax BPF_*_GET_NEXT_ID permission checks to CAP_BPF and bpf_token
From: bot+bpf-ci@kernel.org
To: toke@toke.dk,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com
Cc: bpf@vger.kernel.org,toke@toke.dk,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Thu, 26 Nov 2026 15:19:13 +0000 (UTC)

--===============6898464612949323623==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Relax BPF_*_GET_NEXT_ID permission checks to CAP_BPF and bpf_token

TL;DR: Nit only: bpf_obj_get_next_id() reads attr->fd_by_id_token_fd instead
of the new get_next_id_token_fd; works since they share storage, but the new
field has no reader.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4872,21 +4872,40 @@ static int bpf_prog_test_run(const union bpf_attr *attr,
[ ... ]
> -#define BPF_OBJ_GET_NEXT_ID_LAST_FIELD next_id
> +#define BPF_OBJ_GET_NEXT_ID_LAST_FIELD get_next_id_token_fd
[ ... ]
> +	if (attr->open_flags & BPF_F_TOKEN_FD) {
> +		token = bpf_token_get_from_fd(attr->fd_by_id_token_fd);

This isn't a bug, but since the patch adds get_next_id_token_fd for these
commands, should bpf_obj_get_next_id() read attr->get_next_id_token_fd
instead of attr->fd_by_id_token_fd?

The two names share storage so it works, but get_next_id_token_fd is only
used by the BPF_OBJ_GET_NEXT_ID_LAST_FIELD macro and has no reader.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45845510673
--===============6898464612949323623==--
