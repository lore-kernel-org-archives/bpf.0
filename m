Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BA535C694
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 17:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072638; cv=none; b=dR5WwkTskIWu4ar2G2cmUAt5f/UK2dWX+FwUXTN7qzImVPVP2SwvlGsdQZNl+KwwMVwcTH6Rmyia/7NDY8rF3aRNPWrsIfo+7NCfphERlRnKvnuy3eMWoSkVIo6v4yQnKYa69WqVsWO9SthceLVYWRnIwdOoAn2gxePR9oOUg6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072638; c=relaxed/simple;
	bh=08GCpWBt+z4DejZQ9YX8rfyawTv3wwnrM8KFHn2j+YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aan0c+vLZBrX5i9L8f7q1ucaUigYZtdnSfqLO5v3ImHiw0YnXr9Tzj7pOLfdm45x9k6NXdHSFqDglVyIQQxBnczwHN49ZdgNa706ZbWP/hCv2HKwbQfi/iWlqbm01hgQBLSdqHKPfnFC2EPiym76rOmdOf8AR2eCgW3Bm2021zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CIB6du8I; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CIB6du8I"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-ca80d708489so1004304a12.1
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 10:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787072635; x=1787677435; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LARP5bmG64wd0GpLVR0nEMY/+zhPU+0Nmo0aQ8UdxmY=;
        b=CIB6du8ItoTnpe0+1vB0+nqdDaoSb6gIkX5fqUhNaWOomS+EF4RxaWPYEOOQCoDmfC
         SiQhCeiKeb2lPJIzuL4aJOCAaXUEc6oRZtHI6+h6rG9wjAd1ZFapQoyLl5y+k2g4R+KN
         t/dekYcEgK9A4QbX/dv1Q4kavkBUfDTcADjS8cAY/HY+aDIMHUQZI+ybx1fIeZMLjAIM
         gIBsZG47uWiRZL0d9dgl0bXE2loF0/MH1YePeV21Dkn6sMGvOb2xyitaEu0kVUskf5S2
         zCJzakCQogldTbNW/SIbyI/L3LG3S8VE20LVKnUQrbYB6Vetx6MjchF/orqDpJW9jH44
         mmLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787072635; x=1787677435;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LARP5bmG64wd0GpLVR0nEMY/+zhPU+0Nmo0aQ8UdxmY=;
        b=oXghoMhgkt14fc7gXLrAvAPs33mSyCxPlf7Am/z8bxgE0kMYNHRWYwbk84MTADdRcz
         plE+uhPYSeR3d1r35wcMd2P1vS6JZ3yrxHFPCoC8CD0ScaZxyNB+a6pFd0DH6l1Ya1+z
         g/lrOaNyx2xBOTf4pFmdmTqGAjeqBrG8fEy6qlA5Ghq6re/WtjbAeJaI/0Gu+82SIbv4
         itRibr68X7YitXOgJj8tvnKPzKhxGamtvZm1m0sQUym9pyaCxqVwtC0hvPAhM6QxrgBS
         ySnRAD7LHg34Z/iuiEUPHQEJ82MP57NQOxp6x5RdD2YhS7twcfXneL/DIr5SQD8NrK6W
         ctaw==
X-Forwarded-Encrypted: i=1; AHgh+RrxY4BpuD7jR29WEUuAGpkovY0gBrUfQAuUO5PrTQp9dj96u5mTWnsWXtNCIcwtSxItkvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh8Uh3F4nanf2tPbnkCuT70Kjn1xKUPsmNoHKgSc2SKmxvlxZR
	yemxisVlFMEQLjUIKt19xCdju0EX2izw1h1Hk1mY+O2W30Azd4Y1ELzb
X-Gm-Gg: AR+sD10wUTVsXyRpbbDOjY8ZyLO+lpIfcW46hZXO1f8lkrXagDWiODqxFTY39+hm35Z
	K52q9RYNCMS4uj+0MtsRBAo+Zo8Gc/quA/BKtR96cSgekvodNnz6nP198C5oxvCbMJ6W3d5JJu9
	lq2SY0RiOd1wj1AldR2B5DczjyK1UybBuwHQPzpnrXWTLytzyCgZUVaHyIkiR8x3PmzU8yZ7RCl
	b9AIyAY28ccBIeDO3uqcn9CVkjgJXkjFW1Xaxl3Jjxeuq95+N3V07TMltueIN1QDVExTjsokbQe
	FdYRcApjKPXS3BIcBEzkSplnsWGJ92WL7bsD83b3BDgYB2mbEdD5At2eIpn0Usx2rH/5CB7wRm7
	al3jSz/FKlri/9loMjeDGJzb8xGlOQBnVuBxEge47rpaDE1iI/ETVEod6o+x2NlFQAr1fAI+Wn+
	1ZxNPmi0e67L+5QnPl5LDDGlRbJ3rrHPAVbsx39latSBEPXiG+ljXcCDawGWHQf5Tg
X-Received: by 2002:a05:6a20:2446:b0:39b:bc11:9ec5 with SMTP id adf61e73a8af0-3ccded40c3emr7581611637.13.1787072635279;
        Tue, 18 Aug 2026 10:03:55 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:56::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc13c0445c6sm2311742a12.32.2026.08.18.10.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 10:03:54 -0700 (PDT)
Date: Tue, 18 Aug 2026 10:03:38 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Netdev <netdev@vger.kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Anthony L Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	andrew+netdev@lunn.ch, Saeed Mahameed <saeedm@nvidia.com>, 
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Simon Horman <horms@kernel.org>, magnus.karlsson@intel.com, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, witu@nvidia.com, 
	Martin KaFai Lau <martin.lau@kernel.org>, yoong.siang.song@intel.com, rohan.g.thomas@intel.com, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org, 
	Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH net v2 1/3] xsk: align TX metadata layout across ABIs
Message-ID: <aoSQWPGrYEBfZUnP@devvm7509.cco0.facebook.com>
References: <20260813190800.222527-1-sdf@fomichev.me>
 <20260813190800.222527-2-sdf@fomichev.me>
 <06f8153d-2156-4e7d-9d49-006db4b2cec4@app.fastmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <06f8153d-2156-4e7d-9d49-006db4b2cec4@app.fastmail.com>

On 08/17, Arnd Bergmann wrote:
> On Thu, Aug 13, 2026, at 21:07, Stanislav Fomichev wrote:
> > Add explicit padding before launch_time so xsk_tx_metadata has the same
> > layout on 32-bit and 64-bit systems.
> >
> > On i386 and m68k, the old native 32-bit layout put launch_time at offset 12
> > and had a natural size of 20 bytes. Using sizeof(struct xsk_tx_metadata) as
> > tx_metadata_len was already rejected because the length must be a multiple
> > of eight, so the straightforward use of the interface was broken on those
> > ABIs. Userspace could still register a padded length of 24 bytes, though;
> > mixing the old and new layouts then silently reads launch_time from the
> > wrong offset and misprograms packet launch times. This intentionally
> > replaces that incompatible layout while the interface is still new.
> >
> > Fixes: ca4419f15abd ("xsk: Add launch time hardware offload support to 
> > XDP Tx metadata")
> > Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> This is probably the right approach, given lack of alternatives.
> In the changelog text, it may be worth noting a few more points:
> 
> - A few additional architectures have the same issue: csky,
>   nios2, openrisc and sh.
> - the commit that introduced the mistake was part of linux-6.15,
>   so the 6.18-lts release also needs an ABI change. I don't
>   think the "while the interface is still new" wording
>   makes sense here.
> - what actually saves us here is that none of the affected
>   architectures are likely to have notable use cases for
>   xdp that would care about the ABI break.
>   The one that is most likely to have affected users
>   is x86-compat, and that is also the only one that is
>   broken right now.

Will try to add that to the commit description, thanks!
