Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5C2363C72
	for <bpf@vger.kernel.org>; Thu,  9 Apr 2026 03:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775704369; cv=none; b=oVwOeGSzCgS7ABajBTvtfsGwTjmOTyYnBl8zXCfy35ayYgAVGCL3oJdDOZzTg8QKJH4z56rtDz2yRdQgvBF3CU9Ll9tvnS0DPTFWDhbsO4/WwtUmswixnzIl5YDmu75AsQt5T7lCuKwN7G9W854gwWiszHD6nT6tQ3nZCp5FUnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775704369; c=relaxed/simple;
	bh=NmXwYXgS5NhY+HfYGWSMuq4HwcAqN/5Ic0etOAfT088=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=myHU8XHpDzoEpj58LOfvguvDKMp32TManfBAoXwY1ITKzB0mbBeqa97VwpZ4e3rF459OC1kUnHImX2rmx2CtviomY81uWZpvgq1J8HD5Jswkxb4L2s9rSDiwS//Y+vnmP25pCaR3wDsJW2aKEXxibH1QQaNufxNJmSYu5nUmvAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UG+1V7fz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UG+1V7fz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 823F1C19421;
	Thu,  9 Apr 2026 03:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775704368;
	bh=NmXwYXgS5NhY+HfYGWSMuq4HwcAqN/5Ic0etOAfT088=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=UG+1V7fzaqF0HebenCq8TagkT1fSHZt+9bZoEgbK8IfuYDXLzgrxfbgCcK8LRWzu+
	 yR2NhhjEHwTSplVGMZnUFUuson8u/PuyWirPJO/lpRjwGd2LR/9681prQR15+grjSb
	 m/FrLilMv0FeUqUfIuqTlE5b/dngHxrvtfjFBxdn2h3PfBS5D8FM03Gbj8YuP94lQ7
	 E7QDL/DrFaY8y3V9zSOGDMsObt3VUcmncQsGcWIQ8Fsrw0iDjwu7XR86ti+eUMHib3
	 8PqJq9L9f4+xSXqbFDCOLUa1tNfWCTOepJ1M6Te4kg1p5HYwaBcC5yofzIfroB0FWH
	 j2pt4lTMbTXOg==
Content-Type: multipart/mixed; boundary="===============6946961242110826903=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <bebd6ee70784d72f6b6d36e1cf6cec12bada144fb5b15f0acf5a234be1fc0616@mail.kernel.org>
In-Reply-To: <20260408-patch-set-v1-3-1a666e860d42@gmail.com>
References: <20260408-patch-set-v1-3-1a666e860d42@gmail.com>
Subject: Re: [PATCH bpf-next 03/14] bpf: Add spis_*() helpers for 4-byte stack slot bitmasks
From: bot+bpf-ci@kernel.org
To: eddyz87@gmail.com,bpf@vger.kernel.org,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,martin.lau@linux.dev,kernel-team@fb.com,yonghong.song@linux.dev,eddyz87@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Thu,  9 Apr 2026 03:12:48 +0000 (UTC)

--===============6946961242110826903==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 410939d7b325..64361cb49073 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h

[ ... ]

> +static inline spis_t spis_xor(spis_t a, spis_t b)
> +{
> +	return (spis_t){{ a.v[0] ^ b.v[0], a.v[1] ^ b.v[1] }};
> +}

spis_xor() does not appear to have any callers in this series.
The same applies to spis_set_bit(), spis_single_slot(),
spis_msb_half_slot(), and spis_lsb_half_slot() -- none of them
are used by any commit in the series up through "bpf: poison
dead stack slots".  Could these be dropped, or are they intended
for use beyond this series?

[ ... ]

> +/*
> + * Return a mask with only the MSB (higher-addressed) 4-byte half
> + * of an 8-byte SPI set. This is sub-slot spi*2+1.
> + */
> +static inline spis_t spis_msb_half_slot(u32 spi)

> +/*
> + * Return a mask with only the LSB (lower-addressed) 4-byte half
> + * of an 8-byte SPI set. This is sub-slot spi*2.
> + */
> +static inline spis_t spis_lsb_half_slot(u32 spi)

If these helpers are kept, the comments appear to have the
address direction inverted.  Later in the series,
clean_verifier_state() documents the sub-slot mapping as:

    half_spi 2*i   -> slot_type[0..3] (closer to FP)
    half_spi 2*i+1 -> slot_type[4..7] (farther from FP)

Since the BPF stack grows downward, closer to FP means higher
addresses.  So spi*2 is the higher-addressed half and spi*2+1
is the lower-addressed half, which is the opposite of what
these comments say.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/24168298083
--===============6946961242110826903==--
