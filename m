Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215DE24A06A
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 01:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781142314; cv=none; b=ktN+cpaCE7YE/sqq6Uqsmt6gXxUWe/yVhgjuk8f6h676DuIFts9zD9eBoCJ7ZSGmuORWdv8l+v+dIGxtszuP3ZSkVyj4MlfjUn/1JfIRyzhnu1TyZ3HhFGgz8zeHIC3gwuF8uW6Iv6wqHZgsQHawDqDF3Ytv4THV/UtSbtuSDx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781142314; c=relaxed/simple;
	bh=nkBEMvE+J83rAmQxMSAXJNQon9u+Aj1ftbCgwfCAZdw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pSI9lDmuzGwuZeQYDgijwQ2WHjTogyFBxoqCCpiGgBqh5RvSwmaitVrLWhagh8VIpbzaMGXyEBiZwwK0eRoOdBvlS49z+jPn8w6uOoAptbL1rk5HHz9QP6FUy3Cp+LNXtX6a7oCVumk4ZxrDvIp8ljUU6+G0i0vNWomttwtBXDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mV4SKICh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mV4SKICh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7281F00893;
	Thu, 11 Jun 2026 01:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781142312;
	bh=S6hHEjWvWaS6b2tf47kMLWX2sQCbh0O0QQa3GoaVg3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mV4SKIChqrE3oq6B2CUO3y/2YE/PlvKYRQS+v468H0SFWqaUj5xQs9kqMCOL75ky9
	 nDL3RffoD2UEx+tgb9ViwIZs4rGbJGUGQ4HXKBG+zDBHsJatf0jTMOaAFEkEKA/tdD
	 qYBw30x/wway1KZqGAXhBQjOtLo+0ku8VvNfLpkeh9QDu/mWbSlH9jIjlw5wrCfKEV
	 HADtmzDj48I76LBpK/xhdZzeDQA7NF2vV7q07ERVfYsahMOFxB3xHsa3ZsZBfmrm8O
	 Czq1TKokONMP6b9UQdTtaxVbBO1ZErv7Vnv+jEF61dmT6QmAwus9QNDFBlwGZF41p4
	 puUAHg60RGzew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 3/4] bpf, sockmap: zero-initialize pages allocated
 in bpf_msg_push_data
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260611013547.247039-4-jiayuan.chen@linux.dev>
References: <20260611013547.247039-4-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 11 Jun 2026 01:45:12 +0000
Message-Id: <20260611014512.9B7281F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch intended to fix a heap information leak in `bpf_msg_push=
_data()` but mistakenly modified `bpf_msg_pull_data()` instead. The uniniti=
alized memory exposure in `bpf_msg_push_data()` remains active.
--

commit 6cfebe959c2ffe911ff763388e942ea998f90682
Author: Weiming Shi <bestswngs@gmail.com>

bpf, sockmap: zero-initialize pages allocated in bpf_msg_push_data

The commit intends to fix a kernel heap information leak in bpf_msg_push_da=
ta
by zero-initializing the allocated page before adding it to the scatterlist.
It adds the __GFP_ZERO flag to the alloc_pages call to prevent stale kernel
pointers from leaking to userspace.

Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 3e555f276ba80..982d59cf659f5 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -2716,7 +2716,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg,=
 u32, start,
>  	if (unlikely(bytes_sg_total > copy))
>  		return -EINVAL;
> =20
> -	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
> +	page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZER=
O,
>  			   get_order(copy));

[Severity: High]
This isn't a bug introduced by this patch, but this patch completely fails =
to
fix the issue described in the commit message.

The commit message states the fix is for bpf_msg_push_data, but the diff
applies the __GFP_ZERO flag to bpf_msg_pull_data instead.

In bpf_msg_pull_data, the bytes exposed to the scatterlist are already fully
initialized via memcpy, making the __GFP_ZERO flag unnecessary overhead.

Meanwhile, the alloc_pages call in bpf_msg_push_data still lacks the __GFP_=
ZERO
flag, leaving the original information leak fully exploitable:

net/core/filter.c:bpf_msg_push_data() {
        ...
        page =3D alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
                           get_order(copy + len));
        ...
}

Could the __GFP_ZERO flag be moved to the correct alloc_pages call in
bpf_msg_push_data?

>  	if (unlikely(!page))
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260611013547.2470=
39-1-jiayuan.chen@linux.dev?part=3D3
