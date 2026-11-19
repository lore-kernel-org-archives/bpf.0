Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795129372;
	b=fo2EU1LL1NOBL/TqkN2KhRjWTY4WKMCa01cnxegXVphbxJ03s0TMGV6ARCJIt06lXDEx
	 KL9d6vxEsTPA8FjcvHjmdQsflfppPXC1a34EWUNFkFL4dXayiRkqakE1zAaRwXh3DMJNf
	 +8Rx+ggZsfX/PDq03n0r0iDFr6oiZ8oDkUwdgItQVVFAbxtbo31rTpYTN8fSVdoCow/Dh
	 VmnJxdw69hGfeWYz/v7Dg5XcRiUjiTjPhtFdaf8UWvAVfD8SPD59HjHbY/RFz8nO6H1cd
	 m+KTIo/QXPMUIEUoo7+qY5GkjRNzKaHKnMJDcICT1bPGWy/uR2EN2lv0kKL0wqCr97A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795129372;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LeDUuB6pp2r0/aUfVH5+Lf5XfVlnFXL55VUhlnL8YWQ=;
	b=w0Wltrwl1cmlGL+pT7NcS/xTCokqNPyCnWkfhncdGOw1O0fG7rFKoutrlJ9Hh4O5GUW9
	 0l9FfVeJqzOdvzOQ/Tsv7kYLdS/xR3XrQar+z2YyW8AXOS8ctOHxBgVB8uqU8567GMQw5
	 882vfZeoUfzYX4EAnT2alQ7rzZ58ew5LpwR4L8dECIrZ9k9lHW6Wsc4Oggf7isHsJV1R0
	 HZPy1lfwztQi0EW6WQYhzCYzekdYnkW0QORliPpt0W3X4xv3ZJA9+aK7VTnmBJEYHOZX6
	 9K3rnTBrNlqFGolDjp5a96du4U2L+huckTAtto6Q0KU1/PY/TSd4ihZMJbjMg/GZOFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N9gGK2BN;
	arc=none smtp.remote-ip=209.85.222.173
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23E6606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 23:02:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C23E6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=N9gGK2BN
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-94960131b30so35940585a.0
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 15:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795129371; x=1795734171; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=LeDUuB6pp2r0/aUfVH5+Lf5XfVlnFXL55VUhlnL8YWQ=;
        b=N9gGK2BN0VRB3qHFXUa+vdJF3hcnov6X3nJx/b3rKZJrwng+pkWmXsK6at1DTTN6Lm
         mF0FVKNn+rOKcZUhm76eaWkWcRS8Y8DsTbrEf8Qh4nYECd976v1b5XJkzwlAcmssqz4j
         V3oYn5n8i6YxegPBfLTie3V2453mLYjEqrxzDt8A3Eidio6IqokkeP47C4nLRm927Nnt
         GQqABGT44M7NVRYmneH17Z1fOkRIDuhvIy9ujK0uQ0jDhfW0bx4jpHztcrB5rD+T9K5n
         vVG+hwBMupRhDi3+hPTU7vo33HD9islOqCNYUOLTr3B2nIVwTwzqGs8sZN7Y9FzYEWB3
         F+2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795129371; x=1795734171;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LeDUuB6pp2r0/aUfVH5+Lf5XfVlnFXL55VUhlnL8YWQ=;
        b=yVKUTLDy6EQdE5uHg+FU7oux8UbKas7DxK+Svh2xWpPOa7nXJb77LoNHlQz2H+eJd1
         dAdCdukS5L6uUNhHYqGiG9sottl7bjfx1exwyCRagO9gFB67oFhueHq8RRH/BFnTFTQ2
         O3yX7G6w/ueoIZd9xYDBkAcQ9O1HiIn2ZXBQHAoADxrqb/jrPhk8/h0xgGSqABpji9Ft
         tMVT+NqulSHRmW8Y7AYp/DBg4XvkEmvvEHmtyYKs2xdA0wC25wgRrcYI3QwkzfUS5ep7
         LLoW4hpCaAExKhYeLAZ117aWr8MBrqx2TG9XDBZqZXmPAPUXQPyMTkyxiAw1eEKuMpM3
         mpVg==
X-Forwarded-Encrypted: i=1; AL+hErHZp9z+6gHVxwctm2mEUI92vLGkWzMqiwW2PQJqhmWPmG+B8hfeb1K9lef4iG7IQHfVgrk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+A2wwTt+CjCCzGipfcCDh9/C+BLCKI76MhpZi1uV/7uel9K5oY
	8fDkEOoTO9g02+ARJ7eheGhtMH0L0R0m1c/LfiHunRA/jPSQyMjnOSMM
X-Gm-Gg: AYBFou3ayjgSEmAUdVBRepl5J+vqVe4oPrsxxcBEwum0wuw8Y6PVdn+nPiwoQdt7iSR
	V2gWRv94P/l2JtufKG3ZenEWNQebMByu6azm8sARiJ7YZpZtPdwyG0+TOCEk7gzFzfCTm/xaZ+1
	3/7icjWzsSLA2XKb7NpEcJNnIVk9fCweqYHTYVNEZlkRVjWYVwyYTK07y/7jhdRp6Zmob/9tp7D
	BnOivSV9p36QAcKBSkV9qDOjNh5Nzct1528EUDhxc05m6R6L6ws8Cimr/0ikfJVjm7G/P25hU65
	GpxlZXIZk0yykJhmXztxWY2vhMWKpyLJmkM2ul0sx+U8YalfEsT97Z6qtL2tM6sN/N+gVto+mZO
	AY2+SMJL/iU6w5UDpqvZ8Rm1rxcVf9IPyqlnxPLlxwW51P3iwXA8Pqve9X6Lzm21VYuylZdX2rA
	oA/JLNcBbEXTP/DBO4SfkS6TEh2r49EmnhMGx7XZTDrvGCcHGPdvwmCsgLHQ4yFZtcKe2jZSTJS
	ZYkGeXA6a2FxHdDTsdNm/uJsxibZyLkGf3Ud8S/2P9YHviS27Qu7bfID0u7R5Jf/JPS9TYgmBBz
	elhiiN04nettZMcgbBt0A3Y78Jat28cV+TfiV9FAV/4jStSTrhbNvrQqCjfWEgxPJVat5rl6x3j
	Cm27Ax4qMFtfoJEsVpD/gMnXYLLC2Uq2Pby7+ksvNCJEPo473xaoWQ0Cw3umBIWY=
X-Received: by 2002:a05:620a:1a0e:b0:93e:618e:a2d0 with SMTP id af79cd13be357-949ba9fdf21mr206335185a.60.1795129370563;
        Thu, 19 Nov 2026 15:02:50 -0800 (PST)
Received: from gmail.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-949bb40ea12sm64050085a.35.2026.11.19.15.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 15:02:50 -0800 (PST)
Date: Thu, 19 Nov 2026 18:02:49 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 michael.chan@broadcom.com, 
 manishc@marvell.com, 
 joshwash@google.com, 
 hramamurthy@google.com, 
 tariqt@nvidia.com, 
 saeedm@nvidia.com, 
 daniel@iogearbox.net, 
 hawk@kernel.org, 
 sdf@fomichev.me, 
 willemb@google.com, 
 przemyslaw.kitszel@intel.com, 
 bpf@vger.kernel.org, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.32986341d4816@gmail.com>
In-Reply-To: <20261118232315.3593731-5-kuba@kernel.org>
References: <20261118232315.3593731-1-kuba@kernel.org>
 <20261118232315.3593731-5-kuba@kernel.org>
Subject: Re: [PATCH net-next 4/8] net: state the "XDP excludes LRO" rule in
 the core
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> LRO is the older take on the same thing as HW-GRO. And similarly to
> HW-GRO XDP cannot be handed post-LRO frames. Drivers open-code
> the exclusion just like they did for HW-GRO, and disagree just the
> same: mlx5 and netvsc refuse the attach, bnxt and ixgbe clear the feature
> from ndo_fix_features(), vmxnet3 writes dev->features behind the core's
> back, and atlantic only minds single-buffer programs. Clear LRO next to
> HW-GRO, with the same ordering and the same refusal if a driver insists
> on keeping it.
> 
> atlantic loses LRO under a multi-buffer program now as well. XDP_TX and
> redirect can't carry the GSO metadata of a coalesced frame, however
> many buffers it spans.
> 
> Drop netif_disable_lro() from generic_xdp_install(), like the previous
> patch dropped dev_disable_gro_hw(). The core covers the device itself,
> and LRO no longer stays off after the detach.
> 
> This changes the behavior for lower devices. netif_disable_lro() walked
> them, dev_disable_gro_hw() never did. And unlike HW-GRO, LRO is in
> NETIF_F_UPPER_DISABLES, an upper which loses it clears it from the
> wanted_features of its lowers for good. bond and team carry LRO only to
> hand it down, so a program on a bond still turns LRO off on the slaves,
> and they don't get it back after the detach. Making sure lowers don't
> coalesce is a separate problem, for HW-GRO and LRO alike.
> 
> LRO state with the program [attached / after it's detached], netdevsim
> as the single device, bond of two vmxnet3 ports:
> 
>   program on    device   w/o patch    w/ patch
>   ------------  -------  -----------  ---------
>   dev, native   dev      on  / on `1  off / on
>   dev, generic  dev      off / off    off / on
>   bond, native  bond     on  / on     off / on
>                 slaves   off / off`2  off / off
>   bond, generic bond     off / off    off / on
>                 slaves   off / off    off / off
> 
>  `1 netdevsim ignores LRO under XDP, real drivers turned it off one
>     way or another
>  `2 vmxnet3 clears LRO from dev->features by itself and nothing turns
>     it back on, bnxt slaves would get it back
> 
> Ideally we'd want [off / on] (XDP disables LRO, LRO comes back once
> XDP is cleared). But the two "off"s after detach on slaves are not
> worth the complexity IMHO.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Willem de Bruijn <willemb@google.com>
