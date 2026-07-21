Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC51243C04D
	for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 23:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675065; cv=none; b=k7NGvBzId5lcJnPSVZSpX+oJKKe9bwVDvkkeHGQPDTtKWEGA6kU5cd9ryoS4bcQAbIDZm1wZ38JIHH9HDy5/N72niXVcf0xaF7P3nsn6or6L3yK/Cn3//G4K37mAUyYQ1nfkiEogc4pEalMk1ppFOZjK9qp9GHPkaOPVfpPYJsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675065; c=relaxed/simple;
	bh=bsBDcaEWHfWi9EnHhLs/antnWvm8UXtXCT476zF8ObA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLK/WkXPC76MVimrG3xiSNafpC7sBvE8vb71Ml4i7hFbYpnJeO3MLOVhVV8ymOSV1lL5tmBG8eQtjnvbJgE+14yAoO/hUseZQ0PFjiwNJ4wW72zk6gDtaQwv/vYXdkCt1DKfQlx+zuiN0X85Ykm/YPe1F1rFBrsca+jhXG8bY/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/yU6Voj; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/yU6Voj"
Received: by mail-pj2-f7.google.com with SMTP id 98e67ed59e1d1-38dcd98e5easo5996423a91.0
        for <bpf@vger.kernel.org>; Tue, 21 Jul 2026 16:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784675063; x=1785279863; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=78htSqZa+5pBteZG4UB1DmemzqB0eVW2EvSwVDuZiqs=;
        b=W/yU6Vojyn0IQ/2Dj7hxKhuzvUJFNOt8u6KUXfTzVkwHb3bPt3a667VzXTwGk9Fjwl
         ncyUYCHOsoUljIQ2aDlEgtRCRhSd9qyd9CF++enHIu9ctuxj1zGOW7WNqIxxhf6jjvQ4
         6R7w6FTOY9URCMrhyBCWqMWq2oVCD3HaAWYYP6j9kr/EwnA9e6FxE92i0uQvO6AyWD5i
         lCN5l40DbKVagHnPq19q+Efzamrui6PyPccwl+um9Dd7h5mrMO+vAIN3w5/M9JcMcpNn
         BKkItXp0WGGOL8uXrlyO2vpXAuQWpG8uR6+V8MvBjJyQiYLhoIpnewVf+oQ5OB+hKSWq
         OKRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675063; x=1785279863;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=78htSqZa+5pBteZG4UB1DmemzqB0eVW2EvSwVDuZiqs=;
        b=HGJaS1hDSHFfLviBm/BRnMWiYW6Hg96FCoN8yjaiDTk0OZ1UspKPLlJ9kpbuI3HLcb
         UDO3/2zDKffKRFPE1iExLQRtV+HpnuDHO2slLHj6rH0eissAp1bViUbVs8vTmL2ycqcl
         zyfnAz2YbWlC0xGyCvlfFpqHc7jzuIWhoGtWN+x7xovLDUMLilW6FO720kmeUz8awO+X
         OYJIqLnPTL5gQTrotqTpuYLXJMFhLJKEC24GoB2jcUPWiNu+cOFoKUSrGGDcFr+xivcq
         x+RhvERarlfBsJs9SnAh50BVClHxr9PzaaRQoWHg0Vq5iZXRDXbGJZYfKV/ZEFcm/am5
         5Wyg==
X-Forwarded-Encrypted: i=1; AHgh+Rr4qaj3kiwFe7I1E5iS3wZ2ACb8Gp2WKcgCwiOxFJWhRKLKkbW3/rMBRr+rSjt6k0eN+ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2y9cA0ZMY5iZlw8tybopq+vTQRuAyLc//JIfLObnNGShDfhUu
	kO+6mvV+BDmEx2/bnwNChfeneHtxBn6tV6HbKtQOgZNqrQoZb5ycfu3yCcZclyws
X-Gm-Gg: AR+sD11YJu751UYAUs2SVp9VWP5UQUYLfvd4X7hxncrNk6Hn6jzxVOWiHydOrW/Pq03
	823/w9MtuWBSxum/wzUDVvMusOJs3Yi95RPPeoDs84zf6alQWjRxSJaO4EjPI6vzxw2doE7RGno
	g6lSqnz6OJCr7wBF/aEbQE8VMEu0asGABno7UdpDay/K7WC9K7IYdEyNsrR0eDjptaWbXWbNdM0
	JTrVhyIAdI4Hdrp3/D/Q/xDXY+I1x7zPdpGncFVAaCNJ/wERlFtB8eyIqb0ntRukUWAWbEEYTu8
	6UROq2qKrXSXmOIIO4dsCmAOEw9UFIUxzLODBuytdrh4g2dtRapNXxPG4t+DZVJf8EF1obt5GLJ
	TFWsQxvct8me7nV+hMwLx34xdwVsSID16Bjw5rQyKwJJCznLYCr351b0JLG9CVNqyANC72g==
X-Received: by 2002:a17:90b:38ca:b0:387:e0db:3d8f with SMTP id 98e67ed59e1d1-38e4b5b4fadmr19229906a91.42.1784675063089;
        Tue, 21 Jul 2026 16:04:23 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ea81b2c92sm24438a91.14.2026.07.21.16.04.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:04:22 -0700 (PDT)
Date: Tue, 21 Jul 2026 16:03:37 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, 
	Donald Hunter <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Vladimir Vdovin <deliran@verdict.gg>, 
	Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 8/8] selftests: net: add test for XDP_PASS
 skb checksum invalidation
Message-ID: <al_4VWS_EyyZLe8z@devvm7509.cco0.facebook.com>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-8-623d5c0d0ab7@kernel.org>
 <aljNR2sf8qJVKFgb@devvm7509.cco0.facebook.com>
 <alkBnI3XcH0XGjEo@lore-desk>
 <al53WS9FMTnu7tBI@devvm7509.cco0.facebook.com>
 <20260721082728.74142e6c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260721082728.74142e6c@kernel.org>

On 07/21, Jakub Kicinski wrote:
> On Mon, 20 Jul 2026 12:32:55 -0700 Stanislav Fomichev wrote:
> > > > (although for gve I might be wrong, there is also gve_rx_skb_csum that only
> > > > does UNNECESSARY).
> > > > 
> > > > I'd wait for Jakub to chime in, but it feels like we should just document
> > > > what we currently do as a recommended approach: for the drivers
> > > > that support COMPLETE, do not report it when the bpf program is attached.
> > > > Both NONE and UNNECESSARY are ok.  
> > > 
> > > I am not completely sure the UNNECESSARY case is different from the COMPLETE
> > > one. What are we supposed to do if the driver reports UNNECESSARY and the ebpf
> > > program modifies some fields covered by the rx-checksum?  
> > 
> > For unnecessary, I think the safe expectation is that the bpf program
> > will update the value of the checksum in the packet if it touches the data?
> 
> Documenting as expected behavior which no driver currently follows 
> is a bit silly. I thought the ask was to sketch out the plan of
> explicitly updating/invalidating the checksum even if we don't
> implement it today?

This is about current drivers that only report UNNECESSARY with xdp: the xdp
prog has to maintain in-packet checksum if it changes the payload. I think
it's a fair assumption?

In terms of documentation, here is what I have on my side, lmk if that makes
sense, roughly:

- TODAY
  - some drivers (correctly) disable reporting COMPLETE when XDP is attached
    - the xdp program has to modify the packet checksum value if it
      changes the payload
  - some drivers (incorrectly?) report COMPLETE for xdp-to-skb path -> unsafe,
    needs to be fixed
    - updating the payload doesn't update skb->csum, so the safest
      option right now is to only do UNNECESSARY with xdp for all drivers
  - the hw test needs to make sure that the csum is either
    NONE or UNNECESSARY, and will error out on COMPLETE

- TOMORROW
  - if we want to properly support COMPLETE, we need a new set of kfuncs
    to update skb->csum value in the skb

Does that make sense?
