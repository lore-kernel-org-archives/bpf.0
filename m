Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794153711;
	b=mJwCdWA358sBD4a5NYMVM5WvDEoNwxiBrW4TAHd5ea7eDUK8N9ns0LbA6QME3972ZUeB
	 RPQbt8gMkNm5sRkW/tr80PVTOf8Xxcu7RIuTF4zZ/OHIw9hm5WutrhZl2HQj3XQaKdFlP
	 rS5wcS0XR3s1uM5Q8ZSU1+iHqOpPAvwP9mTZ53wml8WhdkMtgSV/VuP5hwll9UYJIR04P
	 DlESz0fS3c5D7flLeDzskbAiiquTbUiSV6NyYpjEH4HNUTZVQ56NfpEvy1D3WCrTXbHKB
	 GwFIUIPwl0ryBN5XnaEkwX6kSTVTLS+uI42eXq4VCIQ7fy2w1YbHs08hiNqorKDCIgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794153711;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=Azpi+SpQ7aX0d6Qz9au8jZneE9hkAnVCxD3GNAvo+aw=;
	b=kHUqRRuqXq+1Pb1XV37e2Aq5Jg1DXZi9o4wexBNv95tE72BmYrOBeDXR4MKDuXR2E3V/
	 3hPIQMATyJyjbH5790oOX9f9+DVchr121Lb2HVVGobBXG5eRT/Z5eTieR3AqkGyx3w8FW
	 3GTaScvFPlrjLhRpyNl95yWN1OoxXS+TQQBnwH2GWjb0PxDJ/cLZke8QwhveREazHLpLE
	 x6OcJspL+JINlJsQ+JIdLmnsVjROMdNMX8ChO2Q8sRW2+IZ5+u01mntU6QfaywIrZ3bjL
	 lB69QCT7cAPTpvHZxg0Dv6y7duBbPfQbwf5VsnzjnP3V7xd7Zb337QM7aAm091EseyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjxA7Dxc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AF6606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 16:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FjxA7Dxc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AED7B1F008A1;
	Sun,  8 Nov 2026 16:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794153711;
	bh=Azpi+SpQ7aX0d6Qz9au8jZneE9hkAnVCxD3GNAvo+aw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FjxA7DxcAL1PdgZDrUaj58789ZScGwgVAqJ7JAyQY7Abcr1/psQ6RwFNNV2mLuVik
	 n+ipvrECJxYYaXLaqNEVHE2GP9VSQnTfoQWQC72v7lgy8paOFbdZHxFraqA2ON9Q5a
	 HHXZwDDc07SYs8bQVer++ad22Bv4k8Ee3sC0fUfFEV5aeHdim1OP0166d9JD/6ZGkn
	 E5CxMMHemqwKILaFJTJxV6HRgaFHQbVePgMZZimC56ikjqfu1aNjAMacX59g2WAFx8
	 E92sgwkEqziPhV6fD6sBgEbuejrLDjBVAkAAlb+J7/WLeP6tMs8YaO2W4r/wSDSbeX
	 l1HLLDq4as+QQ==
Content-Type: multipart/mixed; boundary="===============5516011137544202973=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <e53166ce029ec6fb8b95c71bd0a056dd55f9a525ddc24e309aa9cbc970c78088@mail.kernel.org>
In-Reply-To: <20261108152941.7363-1-shlomojune6@gmail.com>
References: <20261108152941.7363-1-shlomojune6@gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Check variable-offset accesses against special fields
From: bot+bpf-ci@kernel.org
To: shlomojune6@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shlomojune6@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sun,  8 Nov 2026 16:01:50 +0000 (UTC)

--===============5516011137544202973==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Check variable-offset accesses against special fields

TL;DR: Nit only: the constant-offset loop in btf_struct_access() duplicates
the variable-offset loop, and the review asks whether it could be dropped so
one loop handles both cases.

> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c

[ ... ]

> @@ -8091,15 +8106,28 @@ int btf_struct_access(struct bpf_verifier_log *log,
>  		if (!meta)
>  			break;
>  		rec = meta->record;
> +		if (min_off == max_off) {
> +			for (i = 0; i < rec->cnt; i++) {
> +				struct btf_field *field = &rec->fields[i];
> +				u32 offset = field->offset;
> +
> +				if (off < offset + field->size && offset < off + size) {
> +					bpf_log(log, "direct access to %s is disallowed\n",
> +						btf_field_type_name(field->type));
> +					return -EACCES;
> +				}
> +			}
> +			break;
> +		}
> +
>  		for (i = 0; i < rec->cnt; i++) {
>  			struct btf_field *field = &rec->fields[i];
> -			u32 offset = field->offset;
> -			if (off < offset + field->size && offset < off + size) {
> -				bpf_log(log,
> -					"direct access to %s is disallowed\n",
> -					btf_field_type_name(field->type));
> -				return -EACCES;
> -			}
> +
> +			if (!btf_field_is_accessed(reg, min_off, max_off, size, field))
> +				continue;
> +			bpf_log(log, "direct access to %s is disallowed\n",
> +				btf_field_type_name(field->type));
> +			return -EACCES;
>  		}
>  		break;
>  	}

This isn't a bug, but the two loops over rec->fields[] are near copies of
each other, including the same bpf_log() message.

When min_off == max_off, btf_field_is_accessed() gives the same answer as
the constant-offset loop: first and last reduce to the plain overlap window
around min_off, and imod(min_off - first, reg->step) is imod(0, step), so
the result is just first <= last.

Since btf_field_is_accessed() returns the same result when min_off ==
max_off, could the constant-offset block be dropped so that a single loop
handles both cases?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42495726162
--===============5516011137544202973==--
