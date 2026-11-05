Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793885459;
	b=jeMnoBiR5prYoDr6O+lhC322cpNnXiMHQv3Gyd3OnsmLF1NWVvE/G5Xx4FZwLQe3ePwU
	 qpLLOcAVeUZxqstnHGkZWDArMRiFMd/g4F7maxN4upDLyAzIB2z8J83tzP01kE4/tfmsU
	 XNQYvm5AA6AJ/RAOxUylmBD/Bs0a4fNlA5zOvvcJKRo3CxIUAtI8VFV/1iEHK6SsaSHmX
	 qxCr2tBew3G5m9OFmtpwc2mhOCBLo6NlVXaqjg0xYH0gUjWRG36kZeqM543OZwBX8/OOi
	 7f7N3NmotLcZgBPG3SrR/2JoCR+uoBQJayQagdpbSpG4N1RS2Z65B6mOmGswYioWgVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793885459;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=zGgD8jFSgU9ZTP9p7BKM21Tg7V8OBfUDbvlCylduBuA=;
	b=ZlbyAMkkF/MT4kPwxKZ2DUGuGOlA+5FzvcEcmAv2rmHGfv+qoa2PZG1NuU6SmnlQxb46
	 2ZHtNQmLNbswJtG785bg/l6LPHHhWR8HZTDb6A+/5Pxk30oJxceSZv01/U3QpstFS1+uH
	 oVw2wCZDuBwy2/hOuqtOs2ik2Xvwc2QyeSUV+HIj726abMZ2WUvLSVELY5hnwTMpX+YUe
	 2xIFJz0twcQWanGKfsWXrUyS3IEHmaMGnmQILQdhEWVui8SCJdFqHy58Ue4Tzmvma8z0v
	 f9ZSFfb9lPlCR3dLevRYXKNKo2qyu9FfuFYmDviD2QlbKcvAt5CeSuAxQuGZKzr4gEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=networkplumber.org;
	spf=pass smtp.mailfrom=networkplumber.org;
	dkim=pass header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cDMa9Iwv;
	arc=none smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263AF606A32D
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 13:30:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 263AF606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=cDMa9Iwv
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c4d1b35dc42so137464766b.0
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 05:30:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793885457; x=1794490257; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zGgD8jFSgU9ZTP9p7BKM21Tg7V8OBfUDbvlCylduBuA=;
        b=cDMa9IwvPOyT3vhpOT3++hDSwtCIEIza18FdFLcHwzthwsi4C09ik/hsxCxR8NAel+
         T5hGuhh3hvjQJs+hxaIsdczKblQj06e0ZNLVyKieH6LPJ+RyPqUJpP5/DEHGT4W1fvHX
         NbdSD2jHtxxOR73lczf4ChnrQZ/53JfqSrRc1hOOno1s2EJM0+TVyRwor433+GJ3Ia1v
         wDSrbVlJAD04FgWle9cJUsOpY1EPiPBG6HilIDJiPgsnRWOrz46XUNJUO+/pQR+W7s/2
         XGyln919MqxaKZ1GhJ8R+5W2NYvEprm9GYHQSWLANm8mR4c9oVqGQitPaUCfkk9qMZ2Z
         gl7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793885457; x=1794490257;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zGgD8jFSgU9ZTP9p7BKM21Tg7V8OBfUDbvlCylduBuA=;
        b=pAD92j+F+RFztDJRV8Qr9aenjTUdGnk2pDuiFn7+A2ck9wJbPYjLmv29ynqadeQRHf
         /xSmsHMLvan1OzvHGekrWrKwNZSdt5jcK/dPJICVGY3d936JnRHiLIvNxvI47Wdv45k8
         qEbT0MubHC70ADWgPl5ybmo+XuT/ecuShjMftWvC11yRVi/ldYvfBcbUrQL46CumiwyZ
         niXZf184Iz6BZwy9yNn6QssjH5VfAB4ZbcVUPDSOnfnQznx2sZhGZEx8cB0+3cr5lbe7
         /NDnyp0XZ/NRUyoF6p7duEkMbIU3vwf1OniCAuoC/kQLq78TU7vSMjqvUsbMpu44MLF4
         JE9A==
X-Forwarded-Encrypted: i=1; AKwUvBzcD7Mcv+08mvVISDfEjpHpQV8M2W2sOh1sC70/UUQtqLeINvhiXebfOnulYAzEYnj29Fc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9OAJ69PmuTsDkjlxuGKOim4PD8gS9kKskUfOocVq+nliz32rxm
	g5WAe7W0zQ7X8iUjudokiagW2RssDYOczHJqNdBjgpgxzEf7whMVdih/EX3FPYLlmAr3RS0hOzZ
	Dq6L9bFM=
X-Gm-Gg: AYBFou0xB3K+4fRa1pMoe+EJrLsN9TgRd8/+y2sxKUMHgLpzj7tZyE6myRzJIo3GbPg
	3HSJBU3MRwG2MuuSJ57cDO3xe2FBIydD1usQ7/M/IVYQO8ZnaV1Rgb8tgVrcwr2si2am36bGXnK
	8DIWXHqjbP9zOG7zuuHPQATFuQJOqs4GYRZqWXe/+06volc9gK0+fuErJYZqx/RbHivcjWNTyZH
	Rq/o3yxrGVKdpYA2//BXKY0qlp2JoeyGbRAm7L+j8l+TVlpUCBEwLN4bQ1aRbXjw+dOFBkNbdDz
	NsOT+Cduhbi445yYVAl23QH4DvHAdRF8D7lZPRs0Tc3FAS2wL8YD5Kj2mICQ5TNSzbaAuz2UFh6
	sMe/r9Ba/VMyjeYIyA9XJfk8eMVZuBlYxGQgs/RkJVEKOmVseStCyKttJ41huHZq58P82I34lzR
	N05dXQhbFDrngM5vIQl3CqDUfFnPEKZJ5uMiiHWPWM6qJLyUriIuNRqdEh026xzFFKPUdil01eQ
	51pfXgBWikMQQnILY3hSYWzjYaVsPpDOaueNK66p9/mZSnMG++eOI5gs3gdHzoBkDuaHbJZg+YW
	Ouxwtr+7/C7dhujf25s8lreYessbqs+ayNFJw5wsR3xSuCZGaz4zTrSpujsmsDdGK3XBD5THqrt
	c259KuLgOQV9IFoY=
X-Received: by 2002:a17:907:ea8d:b0:c49:c3f5:8bc with SMTP id a640c23a62f3a-c4d2065af79mr209949566b.10.1793885457372;
        Thu, 05 Nov 2026 05:30:57 -0800 (PST)
Received: from stephen-xps.local (93.224-78-194.adsl-static.isp.belgacom.be. [194.78.224.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d0e46a44esm172684266b.59.2026.11.05.05.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 05:30:56 -0800 (PST)
Date: Thu, 5 Nov 2026 14:30:49 +0100
From: Stephen Hemminger <stephen@networkplumber.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 bpf@vger.kernel.org, dsahern@kernel.org, Willem de Bruijn
 <willemb@google.com>
Subject: Re: [PATCH net-next] docs: netdev: fix iproute2 process
 documentation
Message-ID: <20261105143049.51af15a1@stephen-xps.local>
In-Reply-To: <willemdebruijn.kernel.a20ae72714a7@gmail.com>
References: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
	<20261103092226.2e8ab229@stephen-xps.local>
	<willemdebruijn.kernel.a20ae72714a7@gmail.com>
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

On Tue, 03 Nov 2026 09:44:53 -0500
Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:

> Stephen Hemminger wrote:
> > On Mon,  2 Nov 2026 22:35:56 -0500
> > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> >   
> > > +
> > > +Patches are tracked in patchwork under the netdevbpf project and delegated
> > > +to 'shemminger' for further processing:
> > > +  
> > 
> > Minor nit. David Ahern (dsa) handles the iproute-next patches.
> > I stick to only iproute.   
> 
> I know, but there is no separate delegation in patchwork to David.
> 
> I assumed all iproute2 patches would get delegated to your patchwork
> component. Is this not correct?

Right now we correct it manually. Often patches target the wrong tree.
