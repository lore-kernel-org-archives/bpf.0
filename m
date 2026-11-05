Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793889915;
	b=NU+AePXvRl6AGIJcE/ehChQntKKNN9tZwUYgKGO0gPb9QKz88SVZPwbBECSYW8P7ZDoX
	 J6HYPWYnZ0gpwftM9moOP0SfT6bPlQWYS0Kxj7G3IXwp+tbyeFcmrYUQbxrdTT4bMXD6A
	 WiVmjBXEcZNVPO2PJ3b4G7qJhJyIJYkFQJNDHwZDcrZ4oUyq9JL0Qdhwz7y0EGDF6AxHW
	 PqH46iNBwcM9KXQpQ8eHyxpO2fkc+dWcXdhpajMrZYHO8FL91QIT0L39mmcxq86BllSgM
	 k5exuiyVEmkbYHWTSKGbK/ssx15ffg7wbpKRSRxX/6R2ucA3m3BqN0xldIaxokz9PJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793889915;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=i7BrofaPOZ9C35pnwUvUQZbjQnwmUAOZMnHWHwRv8+s=;
	b=3DXmiZ0pjDM9Hgp4i69sIZgPv2jeYMe3P5unxME6xxeyHhlaiVjYjR2825odLUFrfG0F
	 NoFW9l91zkMslFnSBTnYeg3p1CZlyXStdP4eABQmRDt50V+3H0Y7UrKAT6C7GIGJEliP/
	 3/4VpwBjIUIcY30hCLCix3ITFljCAG3KkBqPdcH3xTP6RIUnC/+TcN+zMpr6DTk4YdILa
	 9cGgJOjXq5qj+iHHYaRb2plJ7fy9bBBGrUDyqjnQYF2/uFecZ7zPnwizLpFqAxd+GoTHg
	 tqCsGrjXLxqY2z7rJ0ugaRjTLEvWtX+IY6rchJPcCoNrW58dg0uk4qYYI01SC4ar6QQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DOtb7DVA;
	arc=none smtp.remote-ip=209.85.208.46
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDEA8606A32D
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 14:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDEA8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=DOtb7DVA
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6b2237b596cso3975688a12.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 06:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793889913; x=1794494713; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i7BrofaPOZ9C35pnwUvUQZbjQnwmUAOZMnHWHwRv8+s=;
        b=DOtb7DVAE1KdSwUcKf+S7HY+4uPzSKWdw20wVji3De+y7UvPOcW1G3cyx4+Xjr1TSX
         6uqn80eBvev/J1PyQz62Ck/u3AtHmahePqGSnhEXTR5kuMMs+e0kSitH/ILh0FWiu1bE
         fhWQfaB8wdZg3/0yZkDYGizm2JtEiIrqbGVN7XTy53zADb869v6geSVzOf6J0x2/MFwK
         CdWm+eyVIoAdA0qQuv1YylicA6WrKNyq/9+q1M1IntexK9UrIQrDRsMlH2wSnYMEZJMD
         SD1Hgt8ND5lz4ooYUjbG3mxQMxPnkxem3PvvXlPHDSnNOzhyoKoCubfXAfuk6D+WSnv4
         xmJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793889913; x=1794494713;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i7BrofaPOZ9C35pnwUvUQZbjQnwmUAOZMnHWHwRv8+s=;
        b=gOCupiKZ2wwhW3kOzCrRM7ifozwUR86we1m939vvd3RbtK45kfIduBa6zh9c+B5f8G
         3qETK/ix++q/1mZ8uFGVTCPx2fI7UFF+hVCe1wPRZ8WQ7IreOJM8dv6TayrkA31K/YCR
         5L1RWNHC92Q2BHEg3xbSUK7IkfXOKm3ruY412V3O6THO7jdIsy/uvcBdIpYdNAdEZ8dZ
         +FRbFl2GUBA5LDG910yImTid+x4wNW5ejuGQy03wv368JsN9Kwsp4ULTdTzMbpS1dqV+
         +Q/+JjyQp/XfRNN718UmG1qb8l2fs7u7jUsaDyfv9KuOCVFGYJy+8hwwCeFjed7ePEI3
         PYaw==
X-Forwarded-Encrypted: i=1; AKwUvBzsiKkiXd+PeJysJiwG/F5QZTD5w4splTXH93mCHJFVa0QclReTpNSO4/11EKWiRNmFCLo=@vger.kernel.org
X-Gm-Message-State: APuU4Z99E7fCps1TiYTKHDI8MyI59l24EyMYeNw5HiO1CARLALcqNjIL
	U733n9Zz2jcyqjkm+ykMVfA4+/u7g0nBAjBLRQCiAO6sfsT6BuhfyHIwA6LlvXCaszU=
X-Gm-Gg: AYBFou0KqEcnqLXnCGOAJkTZvGnLwev/01Q34EW9D3A1w1CJ4Svg2cqXQ1Nqk6dqz0v
	XuHFRB49xkLDMhEi/KQn2jKlaxMbSl/4XJRDtfFu48rrUWi3EWkTs2IbL/yXR50BOn1JvRT3hsx
	4MHD05ayFQjMKSr8QeAiP3S6HxprJJE/nEbksxZ3kyPSmwrHvFVTBRwOuxI/ha7pr/LqhxSw9np
	vSfoc0SjkFiBTKROz2K5u2FW6eBxUwsHnaMTVWypRL0MIDf268axAf/iPSaLfbiUXFTaqHAsyGM
	/GQGKW0+OAHNeGXZE2BDnUKUUwTGAYHqas9hjGbETUuu7cDaF5bZTyvs5R2j+HrX9/0gmBjwSdk
	QgSa2K5tiRJiEaNcI0+++DsLg5a9+QG5PmgPhT4A8lHXCQtmagRwq/gV1ZG/RXFxqbQw3wCHUdi
	8epxvsXLSVkiFFYU10FyzA3b0uiydfvEPXpb+5uV+Aj3aJrcNb/g+8kTaATbnf5i710uM/h/NOY
	AiYRh8mPg4YcMm/sT1ERa7N91a+z1ktnqTaHTn96wfby8LlpDSMO/93qHmITyWVfi6JSy8G6ZNq
	v/TLFulF++aG/3OMc9WoffG6SNix4CoX7/jSJrfok6yHKdMDWkgPrMqO1zD+WOmjWHU2hnDM/r5
	heKlDblxKj41vHVbZkFBc+w9T+1xNaBx8D7XE
X-Received: by 2002:a05:6402:4010:b0:6b5:82ad:18a4 with SMTP id 4fb4d7f45d1cf-6b582ad1997mr1243917a12.40.1793889913024;
        Thu, 05 Nov 2026 06:45:13 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be. [194.78.224.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b55ac94e8bsm1697782a12.35.2026.11.05.06.45.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:45:12 -0800 (PST)
Date: Thu, 5 Nov 2026 15:45:09 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bpf@vger.kernel.org, dsahern@kernel.org, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next] docs: netdev: fix iproute2 process
 documentation
Message-ID: <20261105154509.1cedd84b@stephen-xps.local>
In-Reply-To: <willemdebruijn.kernel.213e1d84478e4@gmail.com>
References: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
	<20261103092226.2e8ab229@stephen-xps.local>
	<willemdebruijn.kernel.a20ae72714a7@gmail.com>
	<20261105143049.51af15a1@stephen-xps.local>
	<willemdebruijn.kernel.213e1d84478e4@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 05 Nov 2026 08:46:22 -0500
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Stephen Hemminger wrote:
> > On Tue, 03 Nov 2026 09:44:53 -0500
> > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> >   
> > > Stephen Hemminger wrote:  
> > > > On Mon,  2 Nov 2026 22:35:56 -0500
> > > > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > > >     
> > > > > +
> > > > > +Patches are tracked in patchwork under the netdevbpf project and delegated
> > > > > +to 'shemminger' for further processing:
> > > > > +    
> > > > 
> > > > Minor nit. David Ahern (dsa) handles the iproute-next patches.
> > > > I stick to only iproute.     
> > > 
> > > I know, but there is no separate delegation in patchwork to David.
> > > 
> > > I assumed all iproute2 patches would get delegated to your patchwork
> > > component. Is this not correct?  
> > 
> > Right now we correct it manually. Often patches target the wrong tree.  
> 
> This is not about the trees, but delegate on patchwork. There is no
> delegate dsahern in the dropdown menu.

David is dsa in patchwork
