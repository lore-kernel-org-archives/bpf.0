Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB4F265623
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 02:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781317851; cv=none; b=mOqeslBdltFg8Ao02oiVGG9iXJqPSWJ71rLRdynjowrZs19kkxu+64s/kFLhq3JF6Z+sIeRg6pcyBOQsk2XUZyZPaz97+jl9CqLQQGNAjus7hyZ7rRN936U8aQOmLr3sPxrz29kTss8t6PaJsKJWlL56alGfnFgqwnTbYlYDv6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781317851; c=relaxed/simple;
	bh=HgbZyHvGeCzljg7Sr9TXApppcDGF9vIDEw/qZU2nt/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a1gNR6uJ6L/JYAhQ0m+8ZadcPGzLt2gy6zHG9wjdOHvOXfQf7LRnXn7rs/Yh/cqEJ6b1TiYD755YTFGL6/ZcKHsnKdRCGcNEHWt3hY8Pm+uJGYL1sNZEpVvLb4rjDzeqWj8uzULfei5LWr4lf31ncSNOf/dfQQtt3z2k2OHm2mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=abNE/kxG; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="abNE/kxG"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-8422524cb38so712328b3a.0
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 19:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781317848; x=1781922648; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=64T+SialQZ6697/fNGFMpzn29D2cLqJP0AzHPR78vug=;
        b=abNE/kxG4jFrmvT+x4EyYoOkMxu8RF+7qYCjxIQq7kzrGVNJvTvpllxX1RwqMl27bn
         FVEH7O8alCnS1mvbdhIf7aZhwwOn7YsG8F3BKVfWx7n4spcb7CDptJqKDazt0+O+OThw
         3m9qyotXWUT/wQed6jf4fVU+fzpKnc1ZdUQQ5Ap1eTyKXb1ifQL8aN95bzpcCEgEtPxU
         WBcYLHemZTFB4PJj0JjOoFN4f9PeCSm27u3KlRgOKXgKQ3QTVC67RD4VLkN6EQLT7fI9
         +pwAooyaPI7kOsBx6S8DAWTks/4B7dT46X1S4r5kV4k2LBZbcOJphNuA8thRwkVNYdtD
         kzxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781317848; x=1781922648;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=64T+SialQZ6697/fNGFMpzn29D2cLqJP0AzHPR78vug=;
        b=DwvyYkBby1y3PDTQLAlRVc5qX6hOUOaLK/7Y3uoFXnoURymTQqMktN9oqQscDbAsyd
         fxLMemWw4Q4DaNGEc11HHPq3hPpZ3X6JgqcytDz40c4eevY5qCYWRM9MyBDRZ+e3DFDb
         P/uib7cn23Hyyza6VOJRy3XUwiyo6FUWPkj6378zyxZQtR7s6o2+IcN3xV4tQ+SkRRQB
         PQdX0SwVI6/nKWeMCgYFPn8XPHz7fp6tEzVGjig1vP53i3ekJQIUx3DGA2iPivcyN8Bj
         Tahy2Gm1fI+QbN9RNuR7TRyFOhZuC30nlyzAnmHxebQLe6BgMXRPF5DYBpZqXOj5Qzvn
         Vv+A==
X-Forwarded-Encrypted: i=1; AFNElJ8wtgRyLZzCYrpZ9eKgCFlFdgTX3rsXGkCIjOTrsjhRvrGl+bHgn2M0Pu7BuKTmY+RAZqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgjWfLSchcXKl3rFHjzWAWkZTvjC45IT8+LvlTLoojSc3ZMtTD
	cTwLISXi33u5d1zVd8mOlWbMnaPsLMnLH1zP2I6W+VWPoSNp2Bfb+BKj
X-Gm-Gg: Acq92OEHL4PgiCLw8y7fhLoJjcSPxc7UCNKsCCbPNB9QGVkdRUbsJ0zeelp8/Xhnkbr
	SmXRtMsxAt8Sk9zmyF0KWHpahBNdcwXfvyHI73tqA2/08udVI4TEnVCdk32zt9DhApA6rhdx4X3
	ODDNQx19sCLJbZ6yhK/TpdLOlgumB1ZHB1GLboGFLQ4Hwi58zmCK6oUKXkkCEjSWAFDCzKJBlGg
	f+wEkGa6adlKQFxCSfY2WtlBuFh4RknwigXsEZAZ1FAVnyH4B6QziHJcl/BiKoVBLD3MdaM+NWR
	3F7oxTJTORWn2IAj3N2zAbASrVJFuQ6duJVBIe5kQGvVzRq7cFq+zBUWIiMTh2N3qRp6fFUGrlj
	9nY7RzoPL/YqSRHmtjVIJa9m4bqDZM+Ksi0tLW/LsNmwzRa0xxTJZRvJSplK32qCvOFfYMOdGO5
	qhCZh2KFcTyhLX1/2n
X-Received: by 2002:a05:6a00:288f:b0:837:a211:4ee2 with SMTP id d2e1a72fcca58-844e1a83861mr2129907b3a.38.1781317848278;
        Fri, 12 Jun 2026 19:30:48 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4f::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b04808dsm3630627b3a.52.2026.06.12.19.30.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 19:30:47 -0700 (PDT)
Date: Fri, 12 Jun 2026 19:29:05 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Stanislav Fomichev <sdf@fomichev.me>, Andrii Nakryiko <andrii@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next/net 1/5] ethtool: Introduce
 ETHTOOL_MSG_TSINFO_SET for virtual interfaces.
Message-ID: <aiy_eV7RP2nPlxmJ@devvm7509.cco0.facebook.com>
References: <20260613010039.1362312-1-kuniyu@google.com>
 <20260613010039.1362312-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260613010039.1362312-2-kuniyu@google.com>

On 06/13, Kuniyuki Iwashima wrote:
> Before enabling SO_TIMESTAMPING, applications typically try to
> enable hardware timestamping on network interfaces via SIOCSHWTSTAMP
> (or ETHTOOL_MSG_TSCONFIG_SET).
> 
> The timestamping capability on an interface can be checked via
> ETHTOOL_MSG_TSINFO_GET:
> 
>   # ethtool -T eth0
>   Time stamping parameters for eth0:
>   Capabilities:
>   	hardware-transmit
>   	software-transmit
>   	hardware-receive
>   	software-receive
>   	software-system-clock
>   	hardware-raw-clock
>   PTP Hardware Clock: none
>   Hardware Transmit Timestamp Modes:
>   	off
>   	on
>   Hardware Receive Filter Modes:
>   	none
>   	all
> 
> These operations rely on the driver implementing two callbacks,
> dev->netdev_ops->ndo_hwtstamp_{get,set}().
> 
> However, among all virtual network interfaces, only bond and
> macvlan currently implement them.
> 
> As a result, most virtual interfaces cannot advertise the
> capabilities of their underlying devices:
> 
>   # ip link add ipvl0 link eth0 type ipvlan mode l2 bridge
>   # ethtool -T ipvl0
>   Time stamping parameters for ipvl0:
>   Capabilities:
>   	software-receive
>   	software-system-clock
>   PTP Hardware Clock: none
>   Hardware Transmit Timestamp Modes: none
>   Hardware Receive Filter Modes: none
> 
> While these callbacks could be implemented in each virtual
> interface, this approach is limited to those directly linked
> to a physical device.
> 
> Not all virtual interfaces are tied to real hardware; for
> instance, packets from UDP tunnel devices eventually pass
> through physical devices and can be hardware-timestamped there.
> 
> Let's allow configuring the hardware timestamping capability on
> virtual interfaces via ETHTOOL_MSG_TSINFO_SET.

I don't have a lot of state on this, but when adding xdp hw timestamping
I remember fighting a lot with those apis. Now we are adding another
one, but (seemingly?) for sw devices. Can you explain a bit more about
why can't existing SIOCGHWTSTAMP (or ETHTOOL_MSG_TSCONFIG_SET) fallback
to your new dev->tsinfo.enabled codepaths for the devices that
don't implement the ops?
