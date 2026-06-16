Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE743563E8
	for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 22:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781647575; cv=none; b=suMIx0Kk8+hP1Gjtaz9EVCsQNu71bgJoOXgYAulHnxceFDhVY2g50abqKKjcIDfpZ/sQhV6eDiS3rkKnv3v+e+XXy+x9gNXjixFwar7WTd/KN5dFyUG7fgMDzXwJ9vhV0hidnox5EG2OYUR1ULbGDBdmXmkQY51F7tZYegZF6eY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781647575; c=relaxed/simple;
	bh=SIl3T/y6XKz2CSlLjTLbn53bB4naiteyTJvlcUtHyS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SuDTfx9CtP/TbXkUlA136BcgnO8VeLFsezlQ1lqBvkA1PDNMcx4l3y5M+j0XpaJlB+7BFvaHxMde3cNphuFGH8VVUVfoMeI2XNI2NuND6Cba7javIdeAqNqsGuQnNG5w/H8OIxO9zazAGu/PFvysbX+W6QvCkvbdxW3kqKvF2Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qa32olrU; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qa32olrU"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-490ae94a89eso44457455e9.1
        for <bpf@vger.kernel.org>; Tue, 16 Jun 2026 15:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781647572; x=1782252372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Qjc2krrqahq+APUkDAlJCVHal69icYfN/Ux7mYOZdFA=;
        b=qa32olrUm5hksv6d18/YPAqoaRz2NeanXAfe4AK4sVsqNv4Yni+CWBg4IgUp4kiWKe
         yjDmJqB2Vcy9SkbxuAqL7GVUl/weBIqIj1MQEj5G9ExJyuQwLUjTXMB4wSAnfhtT7OnH
         w/iDtLXPcUSZbT0vP5dARzkMDKli/UivUGfHEjKIpcM2enpyLtG8Zn/Ax1KOl1+GKtTZ
         x9ZBxfGWdBpjrR72oA3Ag69DSPQZuMQdRs9avNl9wbCYUT23T3uhP0U5vjGVcIVzxyjX
         RdwZe6zByoFLZp5KLnZDVoe25Wf1e36cWvoZM57H14xrPJ3yPWTDmWFUo+iiIlQ/Q778
         OXwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781647572; x=1782252372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qjc2krrqahq+APUkDAlJCVHal69icYfN/Ux7mYOZdFA=;
        b=Ajh5IWdNFwCmdsonYzEVtmo0suDHToY0F0M3BTJpH+ba1C1jasb/AtWJAQ06L8Kv89
         bjCwudD53rLeR6dqhRZnjd87fJu+uqGeWh+qEglRqD6rMMSRho5WnFZdaI8rV9aJbT7l
         YZbkq41/V7YTxFGHPk+E2FykNV4JknIB8vQCR71UC3Wi2d6g8OGIlfnnRe6n9V/tdVp8
         C98pKhHMFzJb8xYWxVaXbeOQ9EhNbEdqFMkG9Co7vUDkvzPvsk7mBo+rHoiR9JsQ64Ia
         GYcT6PR3K9HeaehfrRPvKvLCt4nvTZ6Mhv4piC6FFgGcz/YZv3v+xaxf+yZq28it8n0x
         mQMw==
X-Gm-Message-State: AOJu0YwC0KpUjJYD03b/SyVKCDEFF7hYqmIWGS6mWeKancbKOx75vUVN
	6HNFKbIcgFhjzPSoQN6M4MyXdiL9gyl716t50WKwXcSR6ck48QLnBEcK
X-Gm-Gg: Acq92OHnMigZv9qRVxPf4HUxcPiqKw1gZOdvc3soFWaJQN3ePOXYwiSVCO8qCcidQJA
	0qOs6dL8jxliJJfZgCtKAzY3SJ4vEZX9JOY1FOBfam4FcDe2h/x51IHXM2HFg1h7kOVOyiDQyzb
	wkDrj5ZUSckrtnOaT7M9okV6oHc1RXM2+oN/zfBX7DS0UWQUM8ybZi3gp0RbtnKWJTx8qVwclM3
	GUbkg6CSTuiiGRt76F07B97OJlJ8Fi+5VoGtqjhYzXL8NhC/UhpzEDp7xi/tSbjcMBdZmz4GQNj
	eP7bdumGpzCNN5XAMeRyxwrELbs2lDcRouiPT0ngbVzncto0jRMUcEU6gn/at3TK/PoXV9eH/TX
	2TfDlgYzYHvcIgqHUMuXeF01v89MESBkejAxuQOt2G9LNthvoW9s9OcsxJcT6hlGWPtHvaoJQZ5
	y3vOYur/ARS63Nl6V4Wg99gusbpfOX910/0IEBJp6N5oTHFzx/JTl5j58MPEyZ7FON2cE8T6SAs
	8riM5q4FinN6Sv1HMsDA081GYcuRKTWHeWvFidUT+dKWAtmvg7KkaVX2epNDmJYf6GUBJfURCOC
	euj5GVrJeqtvnyqOySNXWsNeeJOoc1opqN6s8wUiCtw=
X-Received: by 2002:a05:600c:e557:20b0:490:e5c1:b8bf with SMTP id 5b1f17b1804b1-492333bfa01mr15869775e9.13.1781647572241;
        Tue, 16 Jun 2026 15:06:12 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e004325bddd753d2e35.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:4325:bddd:753d:2e35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49233be5901sm10431785e9.1.2026.06.16.15.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 15:06:11 -0700 (PDT)
Date: Wed, 17 Jun 2026 00:06:09 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Jordan Rife <jordan@jrife.io>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH v1 bpf-next 0/2] bpf: bpf_redirect_peer egress redirection
Message-ID: <ajHI0eUUqJpAmKvb@mail.gmail.com>
References: <20260613183424.1198073-1-jordan@jrife.io>
 <ajAXF8Nvg91xU4f2@mail.gmail.com>
 <CABi4-ogYKX9T_gWcXsKSs5-y=3GA_WqwfyjobmCxexTtQ_H86w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABi4-ogYKX9T_gWcXsKSs5-y=3GA_WqwfyjobmCxexTtQ_H86w@mail.gmail.com>

On Tue, Jun 16, 2026 at 01:49:26PM -0700, Jordan Rife wrote:
> > IMO, calling it BPF_F_EGRESS would be less confusing. It's a shame we
> > can't have the same flag API between bpf_redirect() and
> > bpf_redirect_peer(), but this is creating inconsistent semantics for
> > the terms egress/ingress across the two helpers.
> 
> Yeah, one annoying thing about BPF_F_EGRESS is that it would only
> apply to bpf_redirect_peer, so you still have inconsistencies across

Yes, that's what I meant by "we can't have the same flag API" :)
Alternatively, we could define BPF_F_EGRESS as 1ULL << 1, for both
helpers, but I'm not sure it's worth it. Maybe Daniel will have another
idea?

> helpers. Perhaps this is less weird than having BPF_F_INGRESS perform
> an egress redirection though.
> 
> Jordan
