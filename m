Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754E6208C2
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 17:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HLRjop5V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2FB4C433C8;
	Thu,  2 Nov 2023 17:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698947719;
	bh=iZ9T6Z4URaBGfslXP4gQjg+z7m72EdIIrLicW7ORk/Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=HLRjop5Va+a6e6gHwT340RBZUT4x2p3vyvbJSsYQt4UP7aqJRar1A+V4N2Y5wV7vS
	 +vZaFBShpDH5bQWZ9Q/+jSA9YBRyc3sQa0BJSHoYV58o0BSf+BRP7UgTiKCglrzAbK
	 iQUzSOk6hx/yZ48W1icd5HAYLuHZ9msknLz9EkXU7MiWhKtUH96LwxeVeV2TLBvv97
	 KItzX/Plx/vly+WOaKmZaaxFb1r11+SjYCZM2sO+egk5GZ5VYBgm8MlIWCpDdjLaHB
	 +Q+dhwjNXQAewFT6u+ztFJ0QwvEL9PY1MsoljnmLtLWOIh2KuNAgY6+m/sju8wz6uj
	 U/MAZWedr/4dA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 4EEDAEE6377; Thu,  2 Nov 2023 18:55:16 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org
Cc: andrii@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf] bpf: fix bpf_dynptr_slice() returning ERR_PTR() on
 erro
In-Reply-To: <20231102172640.3790869-1-andrii@kernel.org>
References: <20231102172640.3790869-1-andrii@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Thu, 02 Nov 2023 18:55:16 +0100
Message-ID: <877cn011mj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrii Nakryiko <andrii@kernel.org> writes:

> Let's fix it for real this time. It shouldn't just detect ERR_PTR()
> return from bpf_xdp_pointer(), but also turn that into NULL to follow
> bpf_dynptr_slice() contract.
>
> Fixes: 5426700e6841 ("bpf: fix bpf_dynptr_slice() to stop return an ERR_PTR.")
> Fixes: 66e3a13e7c2c ("bpf: Add bpf_dynptr_slice and bpf_dynptr_slice_rdwr")
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/helpers.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 56b0c1f678ee..04049097176c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2309,7 +2309,7 @@ __bpf_kfunc void *bpf_dynptr_slice(const struct bpf_dynptr_kern *ptr, u32 offset
>  	{
>  		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset + offset, len);
>  		if (!IS_ERR_OR_NULL(xdp_ptr))
> -			return xdp_ptr;
> +			return NULL;

Erm, the check in the if is inverted - so isn't this 'return xdp_ptr'
covering the case where bpf_xdp_pointer() *does* in fact return a valid
pointer?

-Toke
