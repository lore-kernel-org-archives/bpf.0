Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792521802;
	b=k9ne+pWK7JXVFJEPGnvsPDVs778/1wJ7nUa0Gh+KmDFMDqCoIGKa3K/spcEsq/05CfVy
	 o9zPnIyrzehVZyKwqfNec++2KgxfBeXzJGcildxZyRofcUo6Wn/Z2X+LGqhRlS4I8HS34
	 RKA9b5UADGTxtDWUnJzUjn+qX7vF9ChXR5rW+8GxYrus3j3Iex//Mnie3bOrKt+q2CVH4
	 qxd+DbOANMf7OPg933NMpfiL+LEtYJ4ytVOTLB2OOOCP/v9uCTmcDbQaZKbyd6jX8HyYr
	 puBF2twdJNRM7xdj3LQVqmEXUelOiOr6bGCf8HLOi0oPjn1xKD4rQkyMW4prfCWbUVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792521802;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Cg5i28eI8ZmgAEQYGaNmNXxb4FmSuruGqb2BKhaEY1g=;
	b=RnmHOFTzvl6gxUwnSGW4MFjybnagwIShA0VbDe/eG+3fuoHsC/24Jk0laXn5rhpkX24o
	 idx9lCxiIqBKmyxHcqf4N15ElEdQVmNXVeQq0Q+F/z0sGQSYKouWsCfSjHP9MumkB72SF
	 cWESAm2s9iwvw/LYRYtDyCFa7Elj1lDwVUzJmNwxSLg1IZoMjiTqLue7bib1pJ/OCK0jw
	 5jjaNTdXmDTQvmdqxIuffr94CS1ULcEzOTuFpz4A/hEqNI786y7U7OKS+MNk9nuf2r8N5
	 /O9nIhFHDgTmvMM2bGhBzulJwH4T4wVrAPvFH7R4TDl1Jjr6K7ULbJUrLUDBnpGE9ag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+jRGeKM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95162606A31D;
	Tue, 20 Oct 2026 18:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=H+jRGeKM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6551F000C9;
	Tue, 20 Oct 2026 18:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792521802;
	bh=Cg5i28eI8ZmgAEQYGaNmNXxb4FmSuruGqb2BKhaEY1g=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=H+jRGeKMfGRWKUtlHBGIdLEHaq5YucF5IvOpzpz2lyiHEKg4uplaXyzx+1Y/HCef9
	 U0OobKH0D8VOS3fa92ErsElC0y0s/S6zb3wZ9LotduqSn1qYqbqLVuhzQIKKDESb+H
	 5SP/e/f6Qe/K8igdgz3OeQkdUG9JnOm9TFh7isYa6l5pf/jY0HMTsbsvMmJlggSmTH
	 9X7gMKoXEp6IWvni/b/p5XkznwfsU1imXCv2JY2NkSR7hQ9NgZ2XO2StClqNqgZH53
	 pF+mKgUbV58WK6kofBTrouuXZXuy2uJ6U9eSTfLUVb1HKvLMXf37SucGH6AbxfM5G/
	 kvGG7haFlF3dA==
Content-Type: multipart/mixed; boundary="===============8583768830564627741=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <8e8c6aaacd577f4daa13c8e97702e38c9982a98684f964fc564880bfcd624413@mail.kernel.org>
In-Reply-To: <1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai>
References: <1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai>
Subject: Re: [PATCH net 1/1] bpf: reject raw iteration over managed sk_storage values
From: bot+bpf-ci@kernel.org
To: zhilinz@nebusec.ai,netdev@vger.kernel.org,bpf@vger.kernel.org
Cc: davem@davemloft.net,edumazet@kernel.org,pabeni@redhat.com,horms@kernel.org,ameryhung@gmail.com,ast@kernel.org,martin.lau@kernel.org,daniel@iogearbox.net,leon.hwang@linux.dev,mattbobrowski@google.com,zhilinz@nebusec.ai,menglong8.dong@gmail.com,kees@kernel.org,bestswngs@gmail.com,memxor@gmail.com,vega@nebusec.ai,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 18:43:21 +0000 (UTC)

--===============8583768830564627741==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: reject raw iteration over managed sk_storage values

TL;DR: Fix only covers sk_storage iterators; the bpf_map_elem iterator in
map_iter.c may still let programs read or overwrite __kptr fields via raw
value buffers, as agreed in the v1 review.

> diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> index ecd659f79fd4..b4936f2e5918 100644
> --- a/net/core/bpf_sk_storage.c
> +++ b/net/core/bpf_sk_storage.c
> @@ -865,6 +865,12 @@ static int bpf_iter_attach_map(struct bpf_prog *prog,
>  	if (map->map_type != BPF_MAP_TYPE_SK_STORAGE)
>  		goto put_map;
>  
> +	/* The iterator exposes values as raw buffers, bypassing field checks. */
> +	if (map->record && prog->aux->max_rdwr_access) {
> +		err = -EACCES;
> +		goto put_map;
> +	}
> +
>  	if (prog->aux->max_rdwr_access > map->value_size) {
>  		err = -EACCES;
>  		goto put_map;

Does the iter/bpf_map_elem path need the same check?

The sibling attach callback in kernel/bpf/map_iter.c validates only the
access sizes against the key and value sizes:

kernel/bpf/map_iter.c:bpf_iter_attach_map() {
    ...
	if (key_acc_size > key_size || value_acc_size > value_size) {
		err = -EACCES;
		goto put_map;
	}
    ...
}

Its value argument is also registered as a writable PTR_TO_BUF (HASH,
LRU_HASH, ARRAY and the per-cpu variants), so a program attached there can
still read or overwrite special fields such as __kptr in the same way the
commit message describes for sk_storage.

This was raised in the v1 review, with a request to cover that path as well.
It was agreed to extend the fix in a respin, but this commit only touches
net/core/bpf_sk_storage.c and no later version has been posted.

Should the bpf_map_elem iterator be handled as part of this fix?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39475541232
--===============8583768830564627741==--
