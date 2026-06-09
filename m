Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC4B43DA2C
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 17:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025734; cv=none; b=Qu0ISYSj8YRwAq4b0Cb04p9eMhuqZeUOFSDX08CCxR7MNsALZy+V2ARn/3+5tk3GfMRC3rEypBCOY1bAHkOSsdRmZ5xIzstIKjrSLoHsswo3DnsZ5xat1ZKJ0aZC9rOCU2jBBOozvILdFpIFop5KQVP/rmIOdYu4wPnVfpMIhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025734; c=relaxed/simple;
	bh=EAoIaV9pNUjobuXUO1ePSeJoEsKaKZUvgUq0xCcWJwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyIvFWy/QgvLF9wt1KhW004hy2pjIty16m3ookViggiKkT1Xyq3SDxy1DjlvpN68tumfrMM6b5zZY4jPyMyy3+pEiVYBC6snQoCwFYYCoRJAyu1PxpExGCLiFL2MCs6RcQ7kV8zOALKk4McXhx/448xxddvQ8/3D1LWS44iV7YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=Q2XumI+s; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="Q2XumI+s"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36b900f350fso5165862a91.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 10:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1781025733; x=1781630533; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ce4y9KqIyAjhQ6PxfVsDJXSaJXhk3BB5Jl2BkdFmxQk=;
        b=Q2XumI+s7PiJcVemIXJ1aONkvFkfaHnVplgbOxj4xZ0iLYzpqf+A/RoRuHAHdTJTR1
         6XNdxdOmCljF+crs5Actzofs2AxmZvdcMWPMrCYBjfW2awBus3MGZxABreZ4YPdsE1WZ
         TT9++opAPgypJXOpmzi58g0i2qBLwdh2dGvGr0uAQ2hJX0F/92CxdCTJddxPAppWo79j
         fkJ7wYUeAV7c5I26wK5/Lof6mmHqqVBq9iIGaUSI7BWy9UQPHTjfdMoGq22ivNADOXkn
         fJAiwRHvzMiieIbA8R+rAQv6MgtWKMGFxKJcI8W57pOG1iobm78fk3f0cjvQKoyDEIkz
         S69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781025733; x=1781630533;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ce4y9KqIyAjhQ6PxfVsDJXSaJXhk3BB5Jl2BkdFmxQk=;
        b=NaARTCEute6Uxjvj38yaB7q+vrG5iVDxyPLr8UntgMn3IsTCW/CSdiJ8gF/MkB6oGP
         GTEFM7ghLK6A9V1eRHISTljfTrU/xqMC/Kkyem1B+7dHFK8tDZ0h6w7TF+Kal6XsqOdy
         xRagTBC2VlhHwnZ6ZsDiLiOu0ExoGnBvbrVbZhxHH88k0vrSCDQyFLYs/qi5knr8TLx1
         sA9xRnPu4gTnAKYy/b+rmVa++vYUKCiCoZpoUk+V+JvBDX82Ds6kwTNsbb/h4p3G99Gj
         wQuWH256SgpELnk2eCzxLIyCdQrG0SqRCJhpOhhNlmauyR38K0HwuUc5EhdHwE1HnHfM
         qPeg==
X-Forwarded-Encrypted: i=1; AFNElJ/0B4VtLw/h1NdQQs7Gvrxl0vpUiQTVs/i2wQklbow9cX7u7MmEI4BMQxZK2thBWZlZFS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YznsM07ETJRbACAaT5hJz7rEMjR3O3CBplcTQANuXiLqzFzCc0q
	wvKmfWHGpuKKLm4j+q7SFv5bgdv9D/JRqDlc7rfr2ucoTWFKHSBoQrOjq5p7R5RyAe0=
X-Gm-Gg: Acq92OFPopTc/UN2OFqZdR1Qmtdx6tphL6uRDM3SxWr2kBEfPOu0ew4dOPUyxuE7tJE
	IgGi2Alm32cBhl7AYLaVhP5h+0hwXPNJhnORbCLVv5c1w/f7LFk+jiFKHCldDUJHxSP6fl7e+9E
	qZl7oTcFgHXDGIljHnlBezH7XZRuWJsUw5p5RePa7UWMaFFzRtg4KrvGGgoOrSnbWRPRg/uogTd
	NIMO2nUBNvAFeKbPhOtaZqSdprMdRVTrU++nnZF8kBb+mhO3y8w7lgKk4q/YRXgoT5npf1L5gpw
	cmgb735tKR8Ukjzyey4Ufg6aJHX7NQ15RYRhgfTnJPFCrmZ25JP0ntsnFiAfQJzQMn0TRFSicxz
	jeVwUmV6dwXvVkUo2GTTBiotvvIuCVkQ/pxcIG706yZWhz+oPgDgMFhoeE2jWnFF5Hkrg4GR6tj
	lc6rwizhPP1jVcoTQDihwdwN5v+Q==
X-Received: by 2002:a17:90b:3d01:b0:36b:b3f4:d578 with SMTP id 98e67ed59e1d1-370f0095c8emr22699988a91.15.1781025732705;
        Tue, 09 Jun 2026 10:22:12 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4d::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36f6bf830b2sm18483208a91.4.2026.06.09.10.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:22:12 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:22:11 -0700
From: Joe Damato <joe@dama.to>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] bnxt: fix head underflow on XDP head-grow
Message-ID: <aihLw8yR6Vu5B6lS@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Andy Gospodarek <andrew.gospodarek@broadcom.com>, horms@kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260608203129.920104-1-joe@dama.to>
 <CACKFLikOyMh3Kbee-AifLXQryyPt-CftW7VYHeeKWoCuMoXj8w@mail.gmail.com>
 <aigoUdgW/icfFwvh@devvm20253.cco0.facebook.com>
 <CACKFLinzaJr8EjXx7yME5cKv9LR1+pF+2iY43V+GeYdEjbUo+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLinzaJr8EjXx7yME5cKv9LR1+pF+2iY43V+GeYdEjbUo+Q@mail.gmail.com>

On Tue, Jun 09, 2026 at 09:44:17AM -0700, Michael Chan wrote:
> On Tue, Jun 9, 2026 at 7:51 AM Joe Damato <joe@dama.to> wrote:
> >
> > On Mon, Jun 08, 2026 at 09:22:07PM -0700, Michael Chan wrote:
> > > On Mon, Jun 8, 2026 at 1:31 PM Joe Damato <joe@dama.to> wrote:
> > > >
> > > > To fix this, we need to do a bit of math to recover the offset if this
> > > > is a page fragment since it is not passed into rx_skb_func
> > > > (bnxt_rx_multi_page_skb, in this case).
> > >
> > > I wonder if we should add an offset field to struct bnxt_sw_rx_bd to
> > > simplify things for page mode.  Struct bnxt_sw_rx_agg_bd has the
> > > offset field for a similar purpose.  Thanks.
> >
> > I don't mind doing that, but I wonder if that's better material for net-next?
> >
> > In other words, we get the minimal fix in (this patch?) and then do the
> > cleanup and struct tweaking as a follow-up in net-next?
> >
> > I could definitely be wrong; I had just assumed patches for net were supposed
> > to be as minimal as possible.
> 
> I think some minor refactoring/struct changes to make the fix
> cleaner/simpler should be fine for -net.  I think the total number of
> line changes should be about the same either way.

OK. Are you OK with changing the signature of rx_skb_func? I was going to add
offset as an argument so it can be passed through.
