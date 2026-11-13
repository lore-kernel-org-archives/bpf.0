Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602799;
	b=SJqj2Q8+h78PKm8joXcELldwwoJXUF8hm2LmS7uKdUW+pFrR90htMHBG5qQmnBI4Vc00
	 pL7Z6yUOVKDi/ortQ4R+wJkQtjHUsX0BaQF8EOChHf/wV71KARVQOJO0IVcfV95GPanL0
	 LtyLu3DCZ7yQyGOl3Zv5RJH07RLM+OpVDC1kXueiLfKsMdTayiB2BhzlLNom8Mv/QybB+
	 nieo4t7j4Uoz9HBfnDvmujbrj0xXg9Y/UcUeOfy8eMcjhxyJ0Z5mAdAYB6JzMtnvys/V5
	 az/UZfvqR4/16RFTWrQcrgjuNGcmpjs4HvdJ75bf26L7ZQY7hj72VAgAbcWuJIilmrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602799;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=mvDC8AgZ3N1caSO2w8AjVA+n1IhC5yWLMz1RCK3jyqY=;
	b=3tU+WVHxlvCysKAtqazHNC+8y7+TC2pLtF76OEMaNXYwY8tyxYRfNgdPLyFN9MeubfH8
	 A8DT/kr799O/NsBV9YSHMZeHEfBqje+WPPpvEgs+UGa3+JWBc9xh/7rA1I7dprgS7LSPM
	 lmiKyAB306HhXLhvuA+y4mnLw3wkAbBZggSmZbsacclhseTRQZpZ70NR9Kx8nW5RcXnuq
	 zRqbGyRHRsn/3BoRSxPi+RUaaFQMJB4fG52NSMf41sxM+qJ5ltTZvmf7mSzShQ/AsNEBD
	 cspOJXwi1awiVHDsUVF7VaS/v3d18Sn+FizUSewSjs5BdbPAJn3vpaSfR/qmDEO0DDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0q+0SFk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B32C606A337;
	Fri, 13 Nov 2026 20:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0q+0SFk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36CD91F000C8;
	Fri, 13 Nov 2026 20:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602798;
	bh=mvDC8AgZ3N1caSO2w8AjVA+n1IhC5yWLMz1RCK3jyqY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=j0q+0SFkiBXQSraN4EqvJBROKR2mcquGuAPCbOw0DgeacG6PMuxZawuosKEih7CED
	 QgYF0XyOo7iFI+scNPKIIt6n8Afo9cykJo9eomLUGMFqoA0xLfxj/T5iF7VrbnIVR+
	 sSLp4D0Uz6whxGQcMJb95LXEe2yzgI/nIXooRk/GvHoCrpV38terTMDZ8kVLNjSxlZ
	 GKdZkpybhNC/aFTkS8vjFyZUpVLs+ik0tHxJ7BbgOGLVhJIunDkfuPzEJow1Ts0qxJ
	 OPh92ofxKEjSzJlTF+9roDgYqWIeuOEwDq0yQS9Buw2EYscKBOrrGQ957LKmjo/+nW
	 cInVamCDKEASw==
Content-Type: multipart/mixed; boundary="===============6062532438743464253=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <651acc6e21aae9067dd3b8ccce4aa38da032b57324836cc75a1fbaa959e2ef10@mail.kernel.org>
In-Reply-To: <20261113-cbpf-ind-nospec-v1-bpf-v1-1-764ac4c14573@nvidia.com>
References: <20261113-cbpf-ind-nospec-v1-bpf-v1-1-764ac4c14573@nvidia.com>
Subject: Re: [PATCH bpf] bpf: mask speculative out-of-bounds skb helper loads
From: bot+bpf-ci@kernel.org
To: datrujillo@nvidia.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,davem@davemloft.net,edumazet@kernel.org,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org
Cc: bpf@vger.kernel.org,netdev@vger.kernel.org,linux-kernel@vger.kernel.org,datrujillo@nvidia.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 13 Nov 2026 20:46:36 +0000 (UTC)

--===============6062532438743464253==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: mask speculative out-of-bounds skb helper loads

TL;DR: The nospec masking may be incomplete: inline classic BPF ABS/MSH loads
from convert_bpf_ld_abs() on efficient-unaligned-access architectures bypass
the helpers, so a short packet could still transiently read out of bounds.

> diff --git a/net/core/filter.c b/net/core/filter.c
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> +static __always_inline const void *
> +bpf_skb_load_nospec(const struct sk_buff *skb, const void *data,
> +		    int headlen, int offset, int len)
> +{

[ ... ]

> +	/* Out-of-bounds transient offsets select NULL as the load address. */
> +	return (const void *)(((unsigned long)data + (long)offset) & mask);
> +}
> +
>  BPF_CALL_4(bpf_skb_load_helper_8, const struct sk_buff *, skb, const void *,
>  	   data, int, headlen, int, offset)
>  {

[ ... ]

>  	if (headlen - offset >= len)
> -		return *(u8 *)(data + offset);
> +		return *(const u8 *)bpf_skb_load_nospec(skb, data, headlen,
> +							  offset, len);

This isn't a bug in the hunk itself, but is the mitigation complete?

On architectures with HAVE_EFFICIENT_UNALIGNED_ACCESS, a classic
BPF_LD|BPF_ABS load with k >= 0, and BPF_LDX|BPF_MSH|BPF_B, do not reach
these helpers.  convert_bpf_ld_abs() emits an inline check and load
instead:

    TMP = H - k;
    if (TMP s< size) goto helper;
    A = *(size *)(D + k);   /* BPF_REG_D == cached skb->data */

This is the same bounds-check-then-load pattern described in the commit
message, and nothing masks it.  An unprivileged SO_ATTACH_FILTER program
chooses k, and packet size controls the linear length.  After training the
branch with long packets, a short packet could transiently load from
skb->data + k past the linear area.  The value could then go through
BPF_LSH/BPF_TAX into a BPF_IND load, which reaches
bpf_skb_load_helper_*() and passes the new mask because the shifted index
is in range.

The commit message says "For indirect loads, packet data can determine the
offset", yet the patch also masks ABS loads that go through the helpers.

Should convert_bpf_ld_abs() get the same treatment (for example, always
calling the helpers, or masking D + k in the emitted code), or should the
changelog explain why constant-offset loads are out of scope?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43500835329
--===============6062532438743464253==--
