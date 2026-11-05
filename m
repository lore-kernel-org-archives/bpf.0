Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793890609;
	b=t2GSfZXcondZ4D4TTbqqjGWeyVUkil2n7PiD8wqHndAW5e28L5lokFCAtVjpl/zFEvhb
	 sYwa2f5s/eb3dvaosNwHAMwGn5wIZ8G3f3rd1NfrKEyUrK2g2RgaHkYp2Ko81sUCF/KWC
	 YKcSp94L017e3i1JeRvcohQbu0caURHYntxbDgux4GN5RJ4PjAexcNtvX4ih14cuZDnbz
	 wjYfpK2Spl36rBSZ+6L/naIeNGNuN5Q+o3U4WJVY563+59RxF8o0ab0DPviiv2vT0r5Lp
	 Qd+igb8XJ2QhfscHxtmlG4Ne/7Znu0daIhsm3U3kuIPryYtAwxoEECsoB/3jCSoo6Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793890609;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XdIGjSypKUaCNpXtgJvDoI2MzXbGDdXv7M653onSpWM=;
	b=MoWwVqWyeOy9Tu/wdU+7v93xgwbTqjBdNyTKBQNGZwpbFSmPWjaXwqFxeeNNJD6JnSpe
	 5cYYl9hbbF8X9S8ebclFjcsutgo42xdht71WUcmx7gp4KUYVpJ884iXD+yr0RaTQwurEd
	 Yt7GXCGup9hmwDsMQUHuQZxXiTeJh6m6naMT+MfnGgKhvSrG642QFzx4iQkD5kdY6APTx
	 /wjZN1C6ZfAX+ZylRJaZecRrzO3HlzM1x76S6qED3xRB1q/SXyBdqIZN9bHR1DOhzJuY6
	 v7xlNhmOx079ruDTZM2jpVRCN8zo86maFANawnwXJC3hHHqFpiYjFjJ2Uczs5nApFDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K09GrKVZ;
	arc=none smtp.remote-ip=209.85.221.178
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB712606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 14:56:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB712606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K09GrKVZ
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5eabf7d5bbeso724414e0c.1
        for <bpf@vger.kernel.org>; Thu, 05 Nov 2026 06:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793890607; x=1794495407; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XdIGjSypKUaCNpXtgJvDoI2MzXbGDdXv7M653onSpWM=;
        b=K09GrKVZGpnmEOusUYD3XJ6HGHMm0wV2MYGeXqZkxJ2rRkOVsbw4opg6w3HRO7zr7h
         IRz3GYummmfhsxEDCObU5l6LOQH4Zn7iIcMpyWo+nVkxSmMv0+AOIvBqDr9l0N/PAsda
         8OdkWaGsyPs7SrfsIDpbXTDqexgUfNVrb2i3+VgJhFC0eI2RTn2+vfX+l+SrlxWL5fDP
         KytVST1yDdjWfUKppJ+F/sBMQXbGNDGrYoUP5xbc2Ik1Cvm3D22ambKcahqy4WjDU2jx
         rXtbWxjnuF7Y7dWQTWKcD4oX/1tldcpK0VDDP/2TB1evFJd51+H//Jy3X+lOIpMenBaQ
         Z/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793890608; x=1794495408;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XdIGjSypKUaCNpXtgJvDoI2MzXbGDdXv7M653onSpWM=;
        b=UspTuYKQQhDvWZ6Y4ubmbSd1IzNNJDrx7HZw6RODuIOCdQqFISpWXrpswI7qY06V9u
         CHacKE9Jp/tJSoEk0iXRMNhHGDikCPK7KxyHgsjv8degUA17TVUu5FuhE2ZtO7YlzRAC
         s/TqBKmfOwD38OyJQLY1k1oPz+Uon3VhqTCrei8aLi08vNsGY8fesTorjfYB8KC1v91V
         tajNm9IN3OiRC1gYCpjiDQ0RS5YjHzSeapg2oA46hcfvXtqB6iWTTHtNplIU0mJWBWjJ
         4MY7tcD90BVeankHEzqloRKYj6ZVT4HKd/ItEJWli/B3QjMlvMtdRxJYz9owBSz5sCYP
         cjOQ==
X-Forwarded-Encrypted: i=1; AKwUvBwq0KLQi9okeJ85bkgL8lG2bZfNc8or4kXlWkPCFy1hdgJrihV0FvLkHX15NzE9XvVNmp8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+iiEYb9KeNTQ6PxnfqFfZQZm0NMQFsEYLIQUKUbMlfxfySFRDX
	K/LYGzgk5HaHE8wbTj4hO+ozbrCp7mPgVLH/qeSw33faqVgiUt7SmcHj
X-Gm-Gg: AYBFou1gpHmB3Pa7Nu88sr6JSXkb3KWUVGRpgd2x+3GcFSULN8dz0tAk5bXLGge7X4A
	srTV120Xc9OuxEytip1tGzEFBu3MJeCQVvfzX2fWOI8sJosIepAvw/4LtjdVYtBP/BlK7EneWMr
	7fT1XkvTzdJFdGW/w1kdkBmQpSLbmxiGW1/HcC6rjU9MD/W9ysNk1XtPxCRMnYazBDU6YsazVA7
	dmHyycTpkbeMLybH46D4nn7tL5rS95n68qk1Pjc5K6CSpfF+B9nd2IZK8OeJ625FFL7zd7YBRSI
	zoEANNTYDXcn8+xlEc+tub46XDT82ad/INIdYsId8wcluSfWvuWSTYBUip/Ca4Cskt408Z7luSn
	3T7WDdo1UauEVjItiWCzmZQDEr7yCHv3ZPt2aUnJ+9G+RYOmTbWEm651NApHU5bsm3CsN041+Al
	TOoxjRfaz6TE4eVYiT66g3Z5ouzlB1tAK4vIkE0ZBsboOYcmpzzhMeX98DuvRRC1Nik20SQ9hg6
	d2UXfbNJQhKRBmXHDWnRkD8VKkn2JLJRnLvzvDgv+S4qeQgAg/j0nmHGd2grefpLOFqS7C5KJWG
	IU43HcCY7MWFNBccjEqr3qRS1UUh7WauYPuFjIJkQyusegnHgy0amhpCXEHdQ5CyzHO/Ou8w2R0
	z9KDJDpmbqEU8IjoCm85d5O4DUdTcaEJR7tNcsaT1bvYc3ehkH4C1W/FVjMm6+IyQXwWOE7Y=
X-Received: by 2002:a05:6122:e248:b0:5ea:d2de:eff4 with SMTP id 71dfb90a1353d-5ec689edd4emr9688175e0c.22.1793890607584;
        Thu, 05 Nov 2026 06:56:47 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d774dcsm4395072e0c.5.2026.11.05.06.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:56:45 -0800 (PST)
Date: Thu, 05 Nov 2026 09:56:45 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Stephen Hemminger <stephen@networkplumber.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 bpf@vger.kernel.org, 
 dsahern@kernel.org, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.192ba63c82bdd@gmail.com>
In-Reply-To: <20261105154509.1cedd84b@stephen-xps.local>
References: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
 <20261103092226.2e8ab229@stephen-xps.local>
 <willemdebruijn.kernel.a20ae72714a7@gmail.com>
 <20261105143049.51af15a1@stephen-xps.local>
 <willemdebruijn.kernel.213e1d84478e4@gmail.com>
 <20261105154509.1cedd84b@stephen-xps.local>
Subject: Re: [PATCH net-next] docs: netdev: fix iproute2 process documentation
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

Stephen Hemminger wrote:
> On Thu, 05 Nov 2026 08:46:22 -0500
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > Stephen Hemminger wrote:
> > > On Tue, 03 Nov 2026 09:44:53 -0500
> > > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > >   
> > > > Stephen Hemminger wrote:  
> > > > > On Mon,  2 Nov 2026 22:35:56 -0500
> > > > > Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> > > > >     
> > > > > > +
> > > > > > +Patches are tracked in patchwork under the netdevbpf project and delegated
> > > > > > +to 'shemminger' for further processing:
> > > > > > +    
> > > > > 
> > > > > Minor nit. David Ahern (dsa) handles the iproute-next patches.
> > > > > I stick to only iproute.     
> > > > 
> > > > I know, but there is no separate delegation in patchwork to David.
> > > > 
> > > > I assumed all iproute2 patches would get delegated to your patchwork
> > > > component. Is this not correct?  
> > > 
> > > Right now we correct it manually. Often patches target the wrong tree.  
> > 
> > This is not about the trees, but delegate on patchwork. There is no
> > delegate dsahern in the dropdown menu.
> 
> David is dsa in patchwork

Ah. I assumed that stood for Distributed Switch Architecture.

A convenient homonym perhaps? :)

Will send a v2 with that part revised. Thanks!
