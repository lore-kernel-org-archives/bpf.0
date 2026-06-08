Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3343F86F0;
	Mon,  8 Jun 2026 15:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780932542; cv=none; b=qEFdNq3ewbMHiicbX1/YQq46ImVWGpCbG7UYbPUmTlnJBDFQrF8AIRyxqMlUGDxphS+Kse3mRfsFQtN8R+lA9hEDoHyspF8c+gA83drxttpJUJenY5X7r7XwhqrWDwfQIdQDN+YsnfaFuBCBGJZh+AX1e8G4WHD32jCwKK1m6Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780932542; c=relaxed/simple;
	bh=ruOoPw8KSp1nwPQ+QqQCeHylpQlZOONgAyyZkL8UwWE=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=mscfYL+F8EZgNsnLCASSfJTn/vPGDMfzSB9l07qIJWaaclk1Of+ibEKqUeL1mtAnnTJDE7+OKuNJJEQgr5NKKvqiH7ambTmNywwt8wZ+OafrBpnF1kf91LDXsYPlnwEN8NjGcf3AHmL+v0LRtTJqzLD2qHYQg1No+UZAW9bM0Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K39J/HsK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K39J/HsK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CBF01F00893;
	Mon,  8 Jun 2026 15:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780932540;
	bh=Y7zUaafp4sH7EgWu88JE7CmhzxOdcagT03WiG0Hhjug=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=K39J/HsKTtU1zZOkisYAslGhwrKX7/v2POLYCvMKLN8Rl2azWwu/XNYYzeKdq4pQg
	 dDuSULhjfvtYXB+lSijcohN4+p1j2efQ9sUziq+cbQaSHjcA3M/Wt1rzc5l/vuvlxH
	 vW0xo9q+gUWp4uM3FJ/8q9Tu7oLn8mnDeEvPm/qIS4951QI3hIYOPrYn/eZ4ocwiXk
	 V8U7ppEPeRDhV0MeudFIQLS7LcImxmYTvvrLwHS+GYzOpECKCQuAAoTpffOn2uMmvU
	 Hm9I4jQ0VzuFe1BxL4uvY5BzpTwnq6zuoO34HovhyOzIWyXA2v4ImdanVBFY2d+ypY
	 E/mFceOWJy9GA==
Content-Type: multipart/mixed; boundary="===============6644831115638570827=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f7c7f1ea3da3115928819d4b4071cde9bda3786ffaf1fd60b06180719d64f625@mail.kernel.org>
In-Reply-To: <20260608145113.65857-6-leon.hwang@linux.dev>
References: <20260608145113.65857-6-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v5 5/9] bpftool: Generate skeleton for global percpu data
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,martin.lau@linux.dev,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,kernel-patches-bot@fb.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  8 Jun 2026 15:29:00 +0000 (UTC)

--===============6644831115638570827==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index 6ae7262ebe0c..e0c5c643fe9e 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c

[ ... ]

> @@ -254,6 +254,11 @@ static const struct btf_type *find_type_for_map(struct btf *btf, const char *map
>  	return NULL;
>  }
>
> +static bool bpf_map_is_percpu_data(const struct bpf_map *map)
> +{
> +	return bpf_map__is_internal(map) && bpf_map__type(map) == BPF_MAP_TYPE_PERCPU_ARRAY;
> +}
> +

[ ... ]

> @@ -847,7 +851,7 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
>  	bpf_object__for_each_map(map, obj) {
>  		const char *mmap_flags;
>
> -		if (!is_mmapable_map(map, ident, sizeof(ident)))
> +		if (!is_mmapable_map(map, ident, sizeof(ident)) || bpf_map_is_percpu_data(map))
>  			continue;

By skipping the .percpu map here during light skeleton generation in
gen_trace(), is the user-space buffer for .percpu left writable?

If a user modifies skel->percpu after the light skeleton is loaded, will
that silently succeed without actually updating the kernel per-cpu map?

The regular skeleton path appears protected, since libbpf mprotect()s the
percpu mmaped buffer read-only at load in bpf_object__populate_internal_map().
For the light skeleton, gen_trace() skips the .percpu map, so its initial
value buffer is never finalized with skel_finalize_map_data() and never
mprotect()'d to PROT_READ, leaving it writable.

Does the generated light skeleton need an explicit mprotect(..., PROT_READ)
on the .percpu initial value buffer to enforce the read-only constraint
described in the commit message?

This was raised on v4 (https://lore.kernel.org/bpf/20260414212650.4F89BC19425@smtp.kernel.org/)
where the response was that the mprotect(..., PROT_READ) added in patch #4
should be moved into this patch so it isn't missed. The v5 code here looks
unchanged from v4, and the mprotect does not appear to have been moved in.

---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27147120330
--===============6644831115638570827==--
