Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486625;
	b=pIpm/aq7kSJNk9l2m+lihvQoP7Pj6YaLaD+Ic8jhC0XUgl0Dvp2TD9AHe6JUctA7zht4
	 BS4mjkC7SIfvv5FBnIqg2973nW+MVwlUUjyIH1wyDBhrd/NKXrWfMhIsrvONv0h75geRu
	 K34/3p+VVShOtoIBVCiLhGfuoZMlkMzrUyCn64HnEQZBL1C7H0AYlYKWJ9Swmpg+TgLXe
	 RMbom8B4oaF9QDgxBw5NjxgmXrex3Qqjk8crAgig5N8pabVfJJS1nC5sOYlkzlc1ivKAT
	 lsPCGMkzddWSIPgZS9VfcjFvGeEjOpVnLU580RlI4z5bpi5TYJ8u9MoVxwYYfxCeFDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486625;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=V1r8ySmspY3io18/7hgI6wKZ8+7BchFXpfiySQBIFao=;
	b=KTyYV+Hl8jMcY1PLoirSN0TOK0y/PRfcWjzilj1I8C8D9eV/hqksJOm/vbYHPNto3Xvl
	 2YNPMK3S3TILZphjbIUGppHLIhqdfSVt9gpEvo7ANoI5ZbHEpT79eNXVhHtL/rWSRgCus
	 zOO6oVC3P97TPU7yj6bQ6JR6pLlzXnxdPvGZ93nY+bxaiYWcHNVZcIvbd3KusDQbjVBs4
	 bhq9905HlEphRGU8xYNM3GoI9LLN5rg3+SupYCYOzoV2PyVBdS29KOsbRPAbVn4b3y3iL
	 MK9KeSYPDvN5WT+xqXO78UoRowjHpo6lzEgbgIbLJFuxRAjD2X242dVU+BNXuz7dxEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fL7MJwny;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B466606A8A4
	for <bpf@vger.kernel.org>; Thu, 12 Nov 2026 12:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fL7MJwny
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FD651F00A05;
	Thu, 12 Nov 2026 12:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794486624;
	bh=V1r8ySmspY3io18/7hgI6wKZ8+7BchFXpfiySQBIFao=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=fL7MJwny2rRdwJbQ488Uz7V8uwAzsL/inTUdCxsSMM2v+0EZmTMuICCTVvAqYMCC4
	 dq+wAhZCc8zOor6mLrm2PRCz+I4jf82lQTE3PVg9yShVSI6Mu/mf/ocjXhHdvu1eKN
	 vQ6SiD11kRCQafxJYTAZ+8BsSJ8mYxiJDMGRyiQtddmY2jxENSXSGUeFH/PDuLayDu
	 Zu6Vlz5H7GdiO96qQIpoNgQwHlm+Z3p3ATl0CnO4DtsweveYlxd/nN/6qp0v5669bM
	 usvdFMBvoKrCYtV52qszf8eLTZWENolyv+nnkpskeBl9QE1X82Xhd6pxDikFXK63nC
	 Dc08zNzfGzvOQ==
Message-ID: <sashiko-outbox-211089@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf] bpf: Fix soft lockup in fd_array_map_free()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Li Jinyue" <jinyue.li@linux.alibaba.com>, bpf@vger.kernel.org
In-Reply-To: <20261112122015.3356106-1-jinyue.li@linux.alibaba.com>
References: <20261112122015.3356106-1-jinyue.li@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 12:30:24 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] bpf: signed integer overflow in map iterators [1]
--

commit be46454b32f6f3b215fec94602410fee2a07b5c7
Author: Li Jinyue <jinyue.li@linux.alibaba.com>

bpf: Fix soft lockup in fd_array_map_free()

This commit adds a cond_resched() call to the entry check loop in
fd_array_map_free() to avoid soft lockups when freeing maps with a large
number of entries.

> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 133f189bf6d27..b975ec3c39e57 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -924,8 +924,10 @@ static void fd_array_map_free(struct bpf_map *map)
>  	int i;
> =20
>  	/* make sure it's empty */
> -	for (i =3D 0; i < array->map.max_entries; i++)
> +	for (i =3D 0; i < array->map.max_entries; i++) {
>  		BUG_ON(array->ptrs[i] !=3D NULL);
> +		cond_resched();
> +	}

[Severity: Critical]
This problem wasn't introduced by this patch, but can i overflow here when
array->map.max_entries exceeds INT_MAX [1]?

Because i is a signed int compared against the unsigned u32 max_entries, a
map created with max_entries > INT_MAX (when bpf_bypass_spec_v1 is
permitted) causes i to wrap to INT_MIN after reaching INT_MAX.  The
unsigned comparison then stays true and array->ptrs[i] indexes memory at a
large negative offset.  The same signed loop counter issue also affects
bpf_array_alloc_percpu(), bpf_array_free_percpu(), and
perf_event_fd_array_release() in this file, where indexing with a negative
i corrupts or reads out-of-bounds memory.  Should i be declared as u32?

[1] https://sashiko.dev/#/bug/linux-4e93eb71-24a1-4040-b74f-c1c6d5ae58c8

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112122015.3356=
106-1-jinyue.li@linux.alibaba.com?part=3D1
