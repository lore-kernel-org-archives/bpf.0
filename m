Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793717096;
	b=tPYL0hj5ObJ54kH9Jegh3D1QFULodhIMZQ82grxnRab19Wslx31XPMsClDTN3AWrp9uk
	 dHLBu8qmc6hp9Tg+Z+ob5YcB9RsyJn9IX6fZnMZ4irWFVyofOBsFnuWqbRNrlTUjOirTl
	 lnoXZSzeBuxfKs2cGUIfPB3yKatoPQ83ANVXKnA0ox7XS5fdPt9E2rpMOJAZD4weuBrw3
	 GKcFwLMVYEgRRGYduKj0bbeg+jbM/+zJbdw3W7LYU7DaX+M62MDGRTQRivvXlfCObF4P4
	 t00f5rkcq9wf/NwAUwpRY+AFI2wTz1NVDUixYHNKEquQMtPE1J5ZzUPHBhHtp+Wo/HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717096;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Fk9maKmdigSs5TiKi8B9LmmVhFBWcWLU75j5fSDUu4U=;
	b=AuBeHJAxyVi7IjN1rSS+GUi2WNsCzzFyUuMsOSjMBeeJTcIGAUom0WoM/6Amxi0lUoI7
	 jx/Cvp9t2pKmk/EswHRgshDA1NXzfjO4VnYfpgQkEEGPNOuqtfiFy5JPiC2sfX95JFlmX
	 Urr9GTjroj5JLIrh1EsA25JoR1ZPJa+h4EyZvCTAd0XPWNgt04uzy7YhVUkgeOKkBjgYG
	 7jxgKYs6UZ5K0PaSMOO5Yc3bLFOGKaTzwvsiPAWqKq6ew7pB2/6/lNNxftAUhdhTO67ss
	 0LUMHOYAbLBt9Z0xZr6oshplTkKbF3l1nS8dii5284CJEtOw1495ng2gyRNbw1gqY0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5SJhljY;
	arc=none smtp.remote-ip=209.85.221.172
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CBC606A328
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 14:44:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03CBC606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5SJhljY
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5ec3561ad43so2422487e0c.0
        for <bpf@vger.kernel.org>; Tue, 03 Nov 2026 06:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793717095; x=1794321895; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Fk9maKmdigSs5TiKi8B9LmmVhFBWcWLU75j5fSDUu4U=;
        b=w5SJhljYINi9IL5EUUCQvEXxaLTFHdERPx3dAUFhHTAVjTrP2uYnI2B7thilGQWhkz
         v9GmtxE34L+qF4/GHZCRwBK1BDc/Ef/yuxYRAGnv91L9QtDAEo/w+vk/d8Cw4FvOT/0g
         xG+u+zL0A1dezzhM9BBliPUEz1dw4BnBnoOEWV0tPF+/WzisSstj9rOLR4O6zDQu4JPj
         KbwxOWeDaBzM4t2Do1fLqL3JSR2fGxZ3ORVSC5c/8P387g01BYjtcq7sKXPv6wqYSPUW
         bmNklFRfJlyguNggyadZUVSSDijdiamygbiWaVfDr3RjUmBCmYCKRrf3aRfGgYorIj0F
         r+NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717095; x=1794321895;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Fk9maKmdigSs5TiKi8B9LmmVhFBWcWLU75j5fSDUu4U=;
        b=UeO1UnaCU3UUyNEjvurjnFyX95xRkmZSBR2nJ4VbbdBmkHjPvWktm0Zx7MHxgMq3ZI
         KBQKEzbRqLKkpPsjnqvwrptTjJrzhd4KqvlNa61yrfoJkhNIeMlGZa846pWfsoCvNwyO
         sgAz9n4kcsOmleppleOg0VFLjzHjXY/77ggASVNu3Fxx52Vncjwxj7+Z1cbMTk1jzEv7
         yEQ7RYorrzIAEnurbajZawrVCZUxu6moD9QJCetMgH3hOC7CypOXiokYI2+GXlrElZqF
         KEPtl6MGmaQX+Jybgtlj8Pn1TEJ6QtyiBJPc1IdOwPleV+if5Kse8JujYhmILrDWR9qy
         K1IQ==
X-Forwarded-Encrypted: i=1; AKwUvBx9gMZOLZm94ksU/jYJauApkepMb6b6X7yrDAWkJfr63G8FDxe3xuCUIJhbt3PaZRLYVpU=@vger.kernel.org
X-Gm-Message-State: APuU4Z9+wr7MOLoUQI8qyJXX50mqGJ+XgMKCH2pPebpqoPT/VDAta9c9
	RfYcb1HcsQPOlWQU/lJtWahb6x2qi49w7kxxtpzRiA5/3Uxtn8whl96OmtWUmg==
X-Gm-Gg: AYBFou324LBgRhS1OwjnM8t64kkE2HZ4i9i4/38IRgzzAJomxErk0QTnYGqMnPSudkH
	N1Hl6JcL6EjuX7MNGKz+G0mSFuoVeLHxe5MkGNYTnFsXyzUyh6W8Q6DbT3QHTmEp2thcUJ8Q0cB
	cgeKz9FEkBXOfdt4ywCQxXr15s5H2HYkufcog3jQrZUsoZG3BcnhOBSAdbdeNnpDe5IpufvjFsW
	HnvQgIgZ2OZ7azGhL/RIZisa51pmYOM09NnqI1kGwISyG9tWQcCOlrdmAXVd+z0cjaqmrkx2lz3
	au0hJaBpY6WhaoNlZZ4oFJ7awPKKTMLOmAYtD/i1RIqkuDgz8siERsRh6UChCKiHOSC7dhMK9ez
	rYKOsHFJN+HvDybPTc0DBrm5VpE+lzaew8WaezpbZxxXIC26nAehLYxxu0zkgY7d4JGzNhMVVXn
	bB9T6q4PalPJovvPch0YQInLQRoBjJCcIEQrsNMYwuv7yF8nJUBI2D57vd3JPUz3MY94vIYhPgH
	BvC3TOvKYjESZQ2SJkbW+gAvPYPIZmo+nv0TqLJmX9XdANtGsasewmYgodMSW3ib1xgf1jEYpCf
	pvpmo5LX9rP8NuJXsFHvtiW7AHAgCz08SxWtliDqS6nyuMvHmCTdngN4GX7p76zSBDfNd9U100s
	TVj1ObepEVVrkUwFzDMCLlxZUGkZ8vtBu+qAmIn4pIjB56G55dTO7ODV1iI85b/3biIfzfI0F36
	yIW1FUhU+nuhWddO+I
X-Received: by 2002:a05:6122:469b:b0:5ea:b972:1403 with SMTP id 71dfb90a1353d-5ec68539420mr5451827e0c.3.1793717094974;
        Tue, 03 Nov 2026 06:44:54 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ec69c4cbabsm12828137e0c.11.2026.11.03.06.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 06:44:53 -0800 (PST)
Date: Tue, 03 Nov 2026 09:44:53 -0500
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
Message-ID: <willemdebruijn.kernel.a20ae72714a7@gmail.com>
In-Reply-To: <20261103092226.2e8ab229@stephen-xps.local>
References: <20261103033611.949104-1-willemdebruijn.kernel@gmail.com>
 <20261103092226.2e8ab229@stephen-xps.local>
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
> On Mon,  2 Nov 2026 22:35:56 -0500
> Willem de Bruijn <willemdebruijn.kernel@gmail.com> wrote:
> 
> > +
> > +Patches are tracked in patchwork under the netdevbpf project and delegated
> > +to 'shemminger' for further processing:
> > +
> 
> Minor nit. David Ahern (dsa) handles the iproute-next patches.
> I stick to only iproute. 

I know, but there is no separate delegation in patchwork to David.

I assumed all iproute2 patches would get delegated to your patchwork
component. Is this not correct?
