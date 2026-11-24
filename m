Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795542269;
	b=4BDmiU4+A0ncMSS74G+juhHKAvNYGJFH7+r6d3U+odrr3HlgZzNjipzIrJ8sgNDGhIza
	 HH2Ejn8hfMocvwbQt/Gbrb3ipJSO6gxV6JG1qTAr7nxEV/In2AHhjMW4iYCwAtWaC8F62
	 1URTJ2moZH+f+SV/PQG58Y+KxWikke4PVuYP/eP9/m4d5KW5hYFzQv74XmtbRgq1WuWHO
	 gWqyQjFTRHprYXWjN43Hy5Kpy27l3npYd9W6fG14LI1MqaJGhtnYygfnf+hMEzF0J6GDj
	 v6iLdXRB+VxXqj5wpLqd79OdN41agUd52kNQIryBWBLDRlf7j1EDJ1BombFGrgCk1DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795542269;
	h=Received:DKIM-Signature:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=U0Ww0YNDvue5htUEQPbc7FQJtiaht83pORC/Tbf+oJE=;
	b=j12iBAt34Y3z4IAdeUB3hKODM/Igt2Q/0Lng/ISAwnHaxYfDq1x9h4BENVeejgx7W9od
	 vBWELKJ2J36JUGKqt9LNgdBzOGYQirQ3lSu4BWjJ4M38nwGZCJQ5s079+WfS6jDIYURq5
	 XwQ6b9uo26oDNloxuC4KNCqAl0dgg6XqJ4JT4iwpf9R2Loe84m3BtBFSY4pu6t6z3nrZm
	 oOJ6gn/q7L17FenJVQWV/hGdRcb3Khwxo2ljcIQid9SH9cz+hk5ePSnuohZ7/A8t8ZJXE
	 JIOoBC1KtRPsjYHgimlxsxT5TeyxySnPtlIBhWSeL3XHNw8ZI9YmENV2oBQXPOc6N/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ox/MZCd/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9899F606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 17:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ox/MZCd/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB831F000D8;
	Tue, 24 Nov 2026 17:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795542269;
	bh=U0Ww0YNDvue5htUEQPbc7FQJtiaht83pORC/Tbf+oJE=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=Ox/MZCd/LaYUaOiipbGz8yUvpDHraHs4nCc5r5DBgQ50YFu/c3BOLKCdw8lvqxHSj
	 mGKHzFJ4GjkpGPwH6YH9b95/57Yd1lvrqmGoGiiKEd+SSP68vNHahtGIg1yKKpEIls
	 BYnLzciGuQJ3xqNTBA0s4RmGgwTo4xcspW2ky/BqYYuJwzDQ5r2DxUx9bBWuniBLHh
	 NbgThXl8GM4YQVEdy2Cap0UkLWCLJ0QfR3lVR533xIl+z3yAS34EcG+S0m0OibZscz
	 JpjtPuKpBYNNhlNFR63d7SftMuG8zeBxnAa9mtzqJbdAaEb5BauAH/lYE7MvlRbvRt
	 XPaSBvBP/KR9w==
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
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH bpf-next v1 03/10] bpf, docs: Document the overwrite
 mode of BPF ring buffer
From: Tamir Duberstein <tamird@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Xu Kuohai <xukuohai@huawei.com>, 
 Tamir Duberstein <tamird@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
 Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com, kernel-team@meta.com
In-Reply-To: <b9243eaf40e91eb71994fce04d45ca91f1740c86.1795467315.git.memxor@gmail.com>
References: <cover.1795467315.git.memxor@gmail.com>
 <b9243eaf40e91eb71994fce04d45ca91f1740c86.1795467315.git.memxor@gmail.com>
Date: Tue, 24 Nov 2026 12:44:15 -0500
Message-Id: <179554225568.72201.6485146828309390541.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=tamird@kernel.org;
 h=from:subject:message-id; bh=o0WEuwGDsoIApgkDYfgTX6lsZthwYT6o9FMBCCHNTA4=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDNmsZz6vOnqha7fs+2v++zZfc5+T+ujlOpdnG0Mn7SpKS
 S7eFb79UcdEFgYxLgZLMUWWRNFDe9NTb++RzXx3HGYOKxPIEGmRBgYgYGHgy03MKzXSMdIz1TbU
 MzTSMdAxZuDiFICpPrCPkWFaKveU3OjID/1Vt6//YNYPl4l89vriDFGONY+n3vwsKn2SkWHut1X
 lnMYBl1j9PFTLgyVTBP9lHty2Y+LkZYc/9YYvOMMJAA==
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

> Describe what BPF_F_RB_OVERWRITE does, where the overwrite position is in
> the producer page, and how a consumer has to read records that the producer
> can overwrite at any time. Consumers that don't use libbpf need this. Also
> list BPF_RB_OVERWRITE_POS for bpf_ringbuf_query().
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  Documentation/bpf/ringbuf.rst | 44 +++++++++++++++++++++++++++++++++--
>  1 file changed, 42 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/bpf/ringbuf.rst b/Documentation/bpf/ringbuf.rst
> index a99cd05d79d4..9715d4335d5b 100644
> --- a/Documentation/bpf/ringbuf.rst
> +++ b/Documentation/bpf/ringbuf.rst
> @@ -120,12 +120,14 @@ reference-tracking logic, similar to socket ref-tracking. It is thus
>  impossible to reserve a record, but forget to submit (or discard) it.
>  
>  ``bpf_ringbuf_query()`` helper allows to query various properties of ring
> -buffer.  Currently 4 are supported:
> +buffer.  Currently 5 are supported:

nit: drop the count to avoid treadmilling this each time the list
changes.

>  
>  - ``BPF_RB_AVAIL_DATA`` returns amount of unconsumed data in ring buffer;
>  - ``BPF_RB_RING_SIZE`` returns the size of ring buffer;
>  - ``BPF_RB_CONS_POS``/``BPF_RB_PROD_POS`` returns current logical position
> -  of consumer/producer, respectively.
> +  of consumer/producer, respectively;

nit: end each bullet with a period. this is both correct and produces
less churn on later updates.

Reviewed-by: Tamir Duberstein <tamird@kernel.org>

-- 
Tamir Duberstein <tamird@kernel.org>
