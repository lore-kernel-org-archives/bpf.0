Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CAAE53384
	for <bpf@vger.kernel.org>; Mon,  1 Apr 2024 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711999051; cv=none; b=k0BZzwXTvexp3fYEVgDsEH3PsEwzOSzV11Uu4eEJ/7puPNDaEnKCR/BuP6RdO4nfsPXc5AP7mQlk0dYyTG7HtA06KplbI3V71lSy4KuSgC3t02HUOSz2+/swBgVQSE+VVqe6s/bSD6HgoTXRyRXYtBPe4IXeSlx8XPTn4UOF5+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711999051; c=relaxed/simple;
	bh=HulfUPQNpC+qxMLkipOzHkdsDRCw8iYcUldG308ddGU=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxXzWhJqf4GBVVnCBYdj95J09j6PK2K9VOOlqZCO4jMoNOJEJ0MnuR/sDm+iPG0n+8yZfMduu/9Vqzoch/tv+TywYWRh3pJipcI+HqKPuGExdAfAjpkmZFaSoseSMDV5ZBmny1OwV2e9+Yg8I9yoQmgggv1yE54D+fcDzg0sExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CqL5EzRy; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CqL5EzRy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711999048;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HulfUPQNpC+qxMLkipOzHkdsDRCw8iYcUldG308ddGU=;
	b=CqL5EzRyIocKv3/ft3cOzuL8ajzqTmX5l0sPBwSLNM/YPsEYLKScyYu7A/ftwNIOUpst5F
	hJfY2rwQ6Dw5JijXZkm4SJYEp93iXziOXyHX44fUqD9B3vp261V5f4Q/2E8NFwYqcm/vOU
	XnsogVNrsS3YLHwsBX8EMuJwKE9H358=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-B7MZbX6QNUGBrh6Shji3Fw-1; Mon, 01 Apr 2024 15:17:27 -0400
X-MC-Unique: B7MZbX6QNUGBrh6Shji3Fw-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5689f41cf4dso3668081a12.3
        for <bpf@vger.kernel.org>; Mon, 01 Apr 2024 12:17:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711999046; x=1712603846;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HulfUPQNpC+qxMLkipOzHkdsDRCw8iYcUldG308ddGU=;
        b=K1NypXzzOL3dRLZ8eHf+SeuKrBiknIXiOBbTFkSK7s4Sc9OolW8K/Ared6mWX2XTTw
         suOYQbKgoBd1fLQnW6VFiz58i+31k3Km0SpdmcCJSl/NgJxx18RZXftxz/Ca2t/CwovA
         Le6W2kL8BtBlcdvUWdBsdE/mXjbwo4Hb040ZsBb80SNpqPV3a2DtkjEj5yQgyXhLocP0
         Uzd98zszEDvcO08zIuTEnM1tXwNoDYtdTvcNsLAJsaqRD9Ih3KyY7x7DpoyIa53b5iCF
         rcQC0OuNSeospjLWY1o6MMgvREjv93B+DuXdBk3J/jvrMWc2GytAOQRA3YuRRVBIzlrk
         9I2w==
X-Forwarded-Encrypted: i=1; AJvYcCVGbdZhUn/RvKytNqDx6LNXRM2LSSF251Rf4qTprweVFQy4zb2LnoB6zlQQ91Y8fJT76NWdP18QneXO5cvI5URDuJ06
X-Gm-Message-State: AOJu0YyldcFjiNs3EBdex6wRBuVaHRWvluvVv+bbJy6bZS2LQ51rg3z3
	onlFOc2YQYOsD5AQTCjxViCbzB9sK85SA40UWlcgRsmMBApKEEhzbW8XEUZsDaKLUo3o/eodFwH
	egwG2YSIPuDQppAEcmW9+mQzULeybA2pq6CFvMlF6lATRwoduf5fuPTctQY/JCKjQgkZvS1wljs
	pgiT0mJ19yQUcr9jbCc9X0GN4m3l07HVtx
X-Received: by 2002:a50:d48d:0:b0:567:824:e36c with SMTP id s13-20020a50d48d000000b005670824e36cmr7000219edi.14.1711999046049;
        Mon, 01 Apr 2024 12:17:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOhbBukYqXLYWTftwKRHjLG6yHJ6cBm6u4VvEtvFvKjjF1MpNgvkMlxNSn0UPDrgNIES0COK4PcDqRIbFVSqk=
X-Received: by 2002:a50:d48d:0:b0:567:824:e36c with SMTP id
 s13-20020a50d48d000000b005670824e36cmr7000186edi.14.1711999045687; Mon, 01
 Apr 2024 12:17:25 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Apr 2024 12:17:24 -0700
From: Marcelo Ricardo Leitner <mleitner@redhat.com>
References: <20240325142834.157411-1-jhs@mojatatu.com> <20240325142834.157411-15-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240325142834.157411-15-jhs@mojatatu.com>
Date: Mon, 1 Apr 2024 12:17:24 -0700
Message-ID: <CALnP8ZZYF45uST4S68Y_-Sx_YirSfY9eNY8=bombEXm8+3W1Zg@mail.gmail.com>
Subject: Re: [PATCH net-next v13 14/15] p4tc: add set of P4TC table kfuncs
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, deb.chatterjee@intel.com, anjali.singhai@intel.com, 
	namrata.limaye@intel.com, tom@sipanda.io, Mahesh.Shirshyad@amd.com, 
	Vipin.Jain@amd.com, tomasz.osinski@intel.com, jiri@resnulli.us, 
	xiyou.wangcong@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, vladbu@nvidia.com, horms@kernel.org, 
	khalidm@nvidia.com, toke@redhat.com, daniel@iogearbox.net, 
	victor@mojatatu.com, pctammela@mojatatu.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, Mar 25, 2024 at 10:28:33AM -0400, Jamal Hadi Salim wrote:
> Co-developed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Co-developed-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Pedro Tammela <pctammela@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>

Be noted that I don't know much of eBPF code. But otherwise, things
LGTM here.

Reviewed-by: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>

