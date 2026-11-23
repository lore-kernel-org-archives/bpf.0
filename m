Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795445751;
	b=VaVH+n3tIdRHXEz2YI5lHfZcoZdc9saiIDOllUdjtF96oZcf/XYLg1as6J0CAs4RwxM0
	 AbfDy5R2ZhHgbN9NxZUolfIbZxVGUaMMheLw/2XEYP9aEskDz9CNvXqzf+zP9+0LYYyxa
	 M8k/QPxXad6cXwc8Hq0v5f0AHMSnMwCdW8xPweuoTTF9pAjBmBiUgqowZZ1+JdEl/Q5un
	 fnmj6yO1dzg8myZMe3FIxv7DtW6bU1BcipHZK+wjm+Vhz/I8vcfXmqnaMPIVfhUxDDT1Q
	 e0V+UQQTKS6iphzZxkDz7PlkFMg5skveurUN4MtyXITL4mQjG9RUDoRuj748Zdu+72w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795445751;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=j/h5+InIgw+oRV5XVGghF+dc8gVnvSCX4IyDa2vlatQ=;
	b=2Q564BsXx5EuHyrK1+2k0BFa70fFR7y+o2ES3Hbytjl/Ebi/jCAC6WKbZjCRZqGqpsdY
	 ap9/NLNrvFy1XNqcc/wcMNaN7oaMp9/OPc74R9hzI8pZ7cVA/8DpydYf1UiIJjaxwW8ee
	 SohbE4+SLPGh4Iz4EX3GX0nrgh93nmnQjRkNgTNcT+Alo/CCXPjySawuPj7XFstELlxUP
	 me82xwPgYo65V2q4wLzfMpPXU+uPlbb4sU248wep7YJ63T2pUm0dj6O7CpPg2IvwGKkY7
	 GcTgXcPFUwiDJ9gcePoj/5fhbOVkWq3hQrZ+UhpftL7tpFEa/i5mf6NkHxA8Ni4MXCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g15yqKJ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBA3606A33F;
	Mon, 23 Nov 2026 14:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g15yqKJ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6A91F00ADE;
	Mon, 23 Nov 2026 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795445751;
	bh=j/h5+InIgw+oRV5XVGghF+dc8gVnvSCX4IyDa2vlatQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=g15yqKJ104GfUNSAW0Qb//DcC3LHnWolXoi53f4U02ZcvIeTcxEt6WV9PtNY1lacF
	 X3mGSF4kQfKwcr0HmD3wsvEY7EVKmjBBngjKOWs2AMXX2ORccqhVar879FYZVBqeuj
	 bu/Fshcx8THuutvlpkggKcNxnK74KToG5Sc/yaSNw2UoHVYj5zpkKMTa4uJFclFXMk
	 Zis0D74nrRQsIXHlL7KrELKwlj03pkpACiYpKzYeQIauVhpGeb2wqR5yWoNW3uBtgA
	 Wse/jXCTY1/NMyVJrzcYYgELA9KIBuHSqNQLhM4wUT34Vg+LSjhEDx5WnzQWibO+3H
	 6TGfpAOfyqt8g==
Message-ID: <adf5a84b-5d80-4c02-91f5-12def2c37304@kernel.org>
Date: Mon, 23 Nov 2026 14:55:47 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v2 1/6] libbpf: Separate interfaces shared with
 in-tree tools
To: Ihor Solodrai <ihor.solodrai@linux.dev>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, Jiri Olsa <jolsa@kernel.org>,
 Song Liu <song@kernel.org>, Tejun Heo <tj@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev
References: <20261121003403.2928928-1-ihor.solodrai@linux.dev>
 <20261121003403.2928928-2-ihor.solodrai@linux.dev>
From: Quentin Monnet <qmo@kernel.org>
Content-Language: en-GB
In-Reply-To: <20261121003403.2928928-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

2026-11-20 17:33 UTC-0700 ~ Ihor Solodrai <ihor.solodrai@linux.dev>
> resolve_btfids links libbpf statically and uses its BTF header
> accessor, field iterator and SHA-256 helper. libbpf_internal.h
> also defines logging macros and poisons kernel integer typedefs,
> so resolve_btfids wraps the hash helper in a separate source file.
> 
> Move the shared declarations to libbpf_tools.h and use them
> directly in resolve_btfids. The header is for in-tree tools and
> stays uninstalled. No shared-library symbols change.


Hi Ihor, the change in bpftool's Makefile looks OK and I understand the
motivation for libbpf_tools.h for resolve_btfids. But I find it a bit
confusing to move away from libbpf_internal.h only partially for
bpftool, and to have a split dependency on both libbpf_internal.h and
libbpf_tools.h. Have you considered moving the other objects that
bpftool requires from libbpf_internal.h to libbpf_tools.h as well?

Thanks,
Quentin
