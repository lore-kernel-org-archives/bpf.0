Received: from mail-dy1-f195.google.com (mail-dy1-f195.google.com [74.125.82.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C783F6C30
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 17:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780420275; cv=none; b=sNv4WMdEHoBKoqJRUR3bnDCj/ZFztgcyMWFLINttlOtw3BNKaTITNkJL172PKJXvd4PqnX3TZWrZyGyuyGmNVjOSTOlSCX0cE4WSlSGv1vH6IbYTge3oeX52Gv+13X7/jFG74LL88WoGJ2hebxfzZyJsZbxj+rJSf9cbFR6jTzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780420275; c=relaxed/simple;
	bh=PNMcwBaq3HWYoO3KsicsKTXAF3/1eGOdICmPWCtyf9A=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=GtemgvWBEFz0WjLNArj1ij4wSaktJXKUN0SIGNeSRJfIjqbwyvE3wMjgZ1MTYX3FGGv2dYy2Z1GU6Qz2zod7Sp2NSfSgptSeU9pOvC4jQ/d42sy0yCTDSiFPFtUn8OXLlTmoCupjOBadheN/xEcdvFUYMtC0YQt+4vGluMsRIE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=nd7zPxXG; arc=none smtp.client-ip=74.125.82.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="nd7zPxXG"
Received: by mail-dy1-f195.google.com with SMTP id 5a478bee46e88-3045c195251so12097064eec.1
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 10:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1780420273; x=1781025073; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0j05WBgNKiBOQ3j1mPmoNzDYYpZls9Mm5jzp1fNRRDY=;
        b=nd7zPxXGdX+bnnaZZKs7yqrvNYLKEKTvox7fHrHIYM538vSdbmNbX4ciXg2nbpBqcY
         XDAcxVl+EDR0+VnBOfmQU3fvZA2ar9GEoUz+LbH4c15LLEZun0zbiknivHaCql43l2Xj
         1DdfDMVYFIjpLH52fRUr/iPL824e28Qq2JF53RtJVkoRC7xugt49fpQym9IDLoFSMx4B
         LNnN0ddmc5LkwOulXvSHUm0PEbPqFvxnxG8l9hNzmaUovz0gVCQiJEDN5QhYHUwUvMZO
         W3VvcpnDAab/gSSOy2BMFn9w+xYa9ULv5VmUOLDHNKUq9mdBHGZHSAonhufW9TikryyM
         yh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780420273; x=1781025073;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0j05WBgNKiBOQ3j1mPmoNzDYYpZls9Mm5jzp1fNRRDY=;
        b=GpZpJUKajod4NUJbBDOXJbdH1AGVHUU6UEibrZFtH4QF4LB2TKFtTBx0BOmqwL3/9J
         MjZ45J0Ha4Uu+QSr6hOm8EoSUEsNfHVgoga9KhIeP0dRUK2r7nAFzUYp1HUG6A3LhlA1
         YzZJs9552HEBVG6xyXM+KbEfd2BkZXGhMLg0ksxqTlujvlC7vStL1Qa6aWaRTlEOTIRc
         mDdrbM82+MAfYJIj/lepWwqR/WXdDRnY2jPJQi7k/Fdx2gIGmwEBmp0zK0erik/XypN2
         rAS3GcYavYG4X6aWvCS8DEUEoCKozRiydkZQsKsVOAXXDswCrjGt+I2vuTtQbbn1n5BE
         AI8g==
X-Forwarded-Encrypted: i=1; AFNElJ+5nPRUqmk4CIcGHP8ymiU4isvK/SsyAY4Hm0cLdM8LTr+P8nK3d+cllcOMnnIc3V36GqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3n+HklIWU5v5fKCjm0GAHXYlaQiNOvsPs9sprQBP7+2vxqoEx
	cHGfGVEp/wvisk0r6QaXuxOF2X+Sc9eDgo/fVscxJdrxDyhArtl6kG82/jPEY8gmReA=
X-Gm-Gg: Acq92OH4W3rihAjVncKO/Jm5V5NDVDgqdLHtYydKf4sbS5mNKK8mBSNGtBQiEzS2cxb
	zq3fuKM3EMU0+eG5t+YA4oTMyruA9BUXF35IvkAATQzW9hg4v1KXXgpqof8erqGpJoBNwCSYq/7
	ZqU8r9ANRca6efxDN0YfsOTyjw5TQM8kYYlzB7KXXhPlaEj9qw2dga7Hiue2ogOffD0tm5c5mYm
	C5JpCHiKf5h9AgHRZuhh8xgqb4nVaM7Yj6T/s64U1x1iKOMRksLNg6HAxlRHVLR42XGpHLg5Qpl
	Yj6kdyQdjcmMJzbpbHSexRh+lJrK3NF3LOdGHZmPI7JQHbzz5hsJ90qbQf//WZnwJ8/FICskXyc
	NWPoK+2LtXc4yHWwRmF+tb815t/i/5zQkK0eF88LEnE5+kh8BxKA3oeViMC4/loXaONQBiZGrbG
	zzqJTv/96lXvh5was8A/mpLPBdyUvIRbZWRw==
X-Received: by 2002:a05:7300:a44c:b0:2da:a813:a5fd with SMTP id 5a478bee46e88-304fa5a7ac4mr7756107eec.22.1780420273037;
        Tue, 02 Jun 2026 10:11:13 -0700 (PDT)
Received: from localhost ([163.114.132.129])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f54db05csm241990c88.8.2026.06.02.10.11.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2026 10:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 02 Jun 2026 13:11:08 -0400
Message-Id: <DIYQB8597KMS.2FSGCPOI9LPCW@etsalapatis.com>
To: "Ren Wei" <n05ec@lzu.edu.cn>, <netdev@vger.kernel.org>,
 <bpf@vger.kernel.org>
Cc: <ast@kernel.org>, <daniel@iogearbox.net>, <davem@davemloft.net>,
 <kuba@kernel.org>, <hawk@kernel.org>, <john.fastabend@gmail.com>,
 <sdf@fomichev.me>, <andrii@kernel.org>, <martin.lau@linux.dev>,
 <eddyz87@gmail.com>, <memxor@gmail.com>, <song@kernel.org>,
 <yonghong.song@linux.dev>, <jolsa@kernel.org>, <toke@redhat.com>,
 <liuhangbin@gmail.com>, <yuantan098@gmail.com>, <zcliangcn@gmail.com>,
 <bird@lzu.edu.cn>, <zzhan461@ucr.edu>
Subject: Re: [PATCH bpf v2] bpf: devmap: reject fragmented frames in
 clone-based broadcasts
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>
In-Reply-To: <21c2d153dd25603d359069a02bf06779b51f6423.1780385378.git.zzhan461@ucr.edu>

On Tue Jun 2, 2026 at 4:43 AM EDT, Ren Wei wrote:
> From: Zhao Zhang <zzhan461@ucr.edu>
>
> Devmap broadcast redirects clone the packet for all but the last
> destination.
>
> For native XDP, that clone path copies only the linear xdp_frame data,
> while fragmented frames keep skb_shared_info in tailroom outside the
> linear area. Cloning such a frame leaves XDP_FLAGS_HAS_FRAGS set but
> without valid frag metadata, and the later free path can interpret
> uninitialized tail data as skb_shared_info, leading to an out-of-bounds
> access during frame return.
>
> Reject fragmented native XDP frames in dev_map_enqueue_clone().
>
> Add the same restriction to the generic XDP clone path in
> dev_map_redirect_clone(). Generic XDP represents fragmented packets as
> nonlinear skbs, and rejecting them here keeps clone-based broadcast
> support aligned between native and generic XDP.
>
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support=
")
> Cc: stable@kernel.org
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Zhengchuan Liang <zcliangcn@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Assisted-by: Codex:GPT-5.4
> Signed-off-by: Zhao Zhang <zzhan461@ucr.edu>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

> changes in v2:
> - Add the same fragmented-packet restriction to generic XDP
>   dev_map_redirect_clone() so clone-based broadcast behavior stays
>   aligned with the native XDP path.
> - v1 link: https://lore.kernel.org/all/4b596825bccc64d03e0c2e0db4dceb12c7=
f5cf47.1780176829.git.zzhan461@ucr.edu/
>
>  kernel/bpf/devmap.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index cc0a43ebab6b..5b9eac5342a9 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -581,6 +581,10 @@ static int dev_map_enqueue_clone(struct bpf_dtab_net=
dev *obj,
>  {
>  	struct xdp_frame *nxdpf;
> =20
> +	/* Frags live outside the linear frame and cannot be cloned safely. */
> +	if (unlikely(xdp_frame_has_frags(xdpf)))
> +		return -EOPNOTSUPP;
> +
>  	nxdpf =3D xdpf_clone(xdpf);
>  	if (!nxdpf)
>  		return -ENOMEM;
> @@ -726,6 +730,9 @@ static int dev_map_redirect_clone(struct bpf_dtab_net=
dev *dst,
>  	struct sk_buff *nskb;
>  	int err;
> =20
> +	if (unlikely(skb_is_nonlinear(skb)))
> +		return -EOPNOTSUPP;
> +
>  	nskb =3D skb_clone(skb, GFP_ATOMIC);
>  	if (!nskb)
>  		return -ENOMEM;

