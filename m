Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D91C42189A;
	Tue, 26 May 2026 14:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779807285; cv=none; b=IdfTOCchUnRMofQvdiav32HlE2JSphiCi+rDvdjFNozshJtPJxAqsQXIGdMc5w2aHQP0A9lzEwBXcRd/+QCSK1pCrY7KmDYnuXcGOQCPXoAHZWQfV04FoxxNvfCGNG5joAviwoiJWd5axq6GBaGG3eywdtgcwSBeSQdHBCY0T0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779807285; c=relaxed/simple;
	bh=KaPde4oJRvgJHrQUXbU7KWoz9/3pUypCdAAHx8Pk0/I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Bq3vJmvJj1lC8gD/+CcwpjHXzGbG3t9oQWGGLIWsiRIfE3Fml7ZmfkHKfYTr/4ATH2IQm7iR+a4RtqpC4GjjliHmqemNDMDfd/lYSGMafxyLy9tAjQfzhrQ4COcC6mOZUIWmygFkkz13oSFCioCHcAWeW8l9L5KMFq5+csJDbVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ids3dL2H; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ids3dL2H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B04451F00A3A;
	Tue, 26 May 2026 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779807283;
	bh=wMfMtI3a6AL/wAGBSzB8GbUgbluOBzDjXpW0K62HWY4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=ids3dL2H7Ibuz5m5fVEb37X8lgTS59uNZcVv4VgtJIxDRSOjxb/uWQ9W5nG2OH99r
	 A4FNNw3+C+pwGCx3FRxS6TK+EWj7IUI9CKAtBZsxI2ObmngDU+Xf+WG450xb7tqSzX
	 75idNZxlpDgxJpzR4P3b1pXq+yTfYEbZi9ZzPcG6SWQFQ1zx03mW+JNwjBD57lUVIJ
	 axaUQUUnileh2o9oK3YpaeE/2CZLvsYXr/Sz7TrIGNd9OKS0Hi494vcZJI5lmaUq17
	 Hhm7r9IgABb40l3lUGQ8l6mscODzIekiAdUO40idTJRHd8M985vgouWc5GEdCUiYpN
	 GWtZjW+2f5qyg==
Content-Type: multipart/mixed; boundary="===============0799950893653064814=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <633233be752e73e35dec1b16e1cdb8c0a3edf3264ab5080061f6899433cd1806@mail.kernel.org>
In-Reply-To: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-3-5b4fa2a5e1a4@google.com>
References: <20260526-libbpf-load-vmlinux-btf-in-gen_loader-mode-v3-3-5b4fa2a5e1a4@google.com>
Subject: Re: [PATCH v3 3/3] libbpf: plumb btf_vmlinux_value_type_id and btf_fd in gen_loader
From: bot+bpf-ci@kernel.org
To: sidnayyar@google.com,andrii@kernel.org,eddyz87@gmail.com,ast@kernel.org,daniel@iogearbox.net,martin.lau@linux.dev,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org
Cc: bpf@vger.kernel.org,linux-kernel@vger.kernel.org,gprocida@google.com,maennich@google.com,sidnayyar@google.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 14:54:42 +0000 (UTC)

--===============0799950893653064814==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/gen_loader.c b/tools/lib/bpf/gen_loader.c
> index 9478b8f78f26..b0d8551272f2 100644
> --- a/tools/lib/bpf/gen_loader.c
> +++ b/tools/lib/bpf/gen_loader.c
> @@ -525,13 +525,14 @@ void bpf_gen__map_create(struct bpf_gen *gen,
>  	attr.max_entries = tgt_endian(max_entries);
>  	attr.btf_key_type_id = tgt_endian(map_attr->btf_key_type_id);
>  	attr.btf_value_type_id = tgt_endian(map_attr->btf_value_type_id);
> +	attr.btf_vmlinux_value_type_id = tgt_endian(map_attr->btf_vmlinux_value_type_id);
>
>  	map_create_attr = add_data(gen, &attr, attr_size);
>  	pr_debug("gen: map_create: %s idx %d type %d value_type_id %d, attr: off %d size %d\n",
>  		 map_name, map_idx, map_type, map_attr->btf_value_type_id,
>  		 map_create_attr, attr_size);
>
> -	if (map_attr->btf_value_type_id)
> +	if (map_attr->btf_value_type_id || map_attr->btf_vmlinux_value_type_id)
>  		/* populate union bpf_attr with btf_fd saved in the stack earlier */
>  		move_stack2blob(gen, attr_field(map_create_attr, btf_fd), 4,
>  				stack_off(btf_fd));

This looks like a bug fix for STRUCT_OPS map creation in gen_loader.
The bug was introduced in commit 992c4225419a ("libbpf: Unify low-level
map creation APIs w/ new bpf_map_create()"), which added
btf_vmlinux_value_type_id support to bpf_map_create() but failed to
plumb it through in gen_loader.c's bpf_gen__map_create() function.

Should this include:

  Fixes: 992c4225419a ("libbpf: Unify low-level map creation APIs w/ new bpf_map_create()")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26454419965
--===============0799950893653064814==--
