Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 823D830214B
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 09:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780737560; cv=none; b=R4lXurBwNucSiGXoyT1gtQ5Dd5pA92p4OlVVvo9afrCQ85pAA0FPeR4dx+lImfU6RbwsyellpHWeNUi3XCQnn9jWSf62++58EPyG4BzqmmP/D+3NJVKp/0mcyzl5amezo0Fb8fSXhVV5FH2N1pumFnA6kWzlWBVWhl720hfc0Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780737560; c=relaxed/simple;
	bh=i0hUU1LR8FTs1GYt7XZtzOavAvG38zp6gVex4FUx7qA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwZT/5mCG/xh1EY/h4nKl2Je3+ZPXPl18vrvyqPaB7/N/cNP4Rc/IDJLNtsWG5ecJ1UILRrV2IS0drq+CbHG59dgzHpYYiboVqLQyiaxepPIvG8725LWonbrzs7LGiJg2l6YTzj5klJP2GEn7X6Akd5w3QCezW704zLsmmG1j3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=VJ24xs9r; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="VJ24xs9r"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-490b64c8311so30664465e9.3
        for <bpf@vger.kernel.org>; Sat, 06 Jun 2026 02:19:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1780737558; x=1781342358; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ADsY3VhcNaw2SJvXvxwxYC+avdiz5am5e2nVPliaeIE=;
        b=VJ24xs9rxLS91qhd7trXJOBUe0mNxRp7q3lWfqtTtbq+U0CulKyFCiHutPpcDkqw5S
         8SUMM2zDn/DSz4QYF35mgl65506COQGGBOpC7w1WPWKBSR/hLN2uHap301iKNdGeaYst
         UEYQAuO8LgF0ka5cRfHie5DmGtC+acsRdRGWSKYAV/vyD3n9ID9n6IxzHECBqfvNLnaP
         awYLwkPgRfrN2gYSabVAgMTRRWKdMYs/UE4XVpFCBtLUrwuW76VLnkKPgGsWwuaM2DG/
         8cs0OeGqB/K7tE8+f/8jlOL00v6RKCuuZ1tMhVain8wOHhi3vnQLXdDnxuSvOvnUy+42
         f+lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780737558; x=1781342358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ADsY3VhcNaw2SJvXvxwxYC+avdiz5am5e2nVPliaeIE=;
        b=mqHCVG7EL5/c8YWPPgDO+vU06UyFAG4wtgolkwZ/S9a/419SprjLHznIW32jNxBXzb
         h3j3BgvXIYkIlhUfNpUrmvQl3MHatfFcwBdmuipzrKmPEK+8JZL+4INfBQqifDqWtH9f
         ZyUz+7kZkFwo5adXMNOuloo16K1v87YNufKu22bZtRIbiKdiePRUIBI9H0b1eQxI0FyK
         I/KwI/R3zq4Ll0HgeniNLD4zNFBTWxra9iQOhL8VVVQhRNuYOmyHIDfvNvl309tLP4Ji
         B1Q8TxZHJG2hWknJxe6bpURiT4bjYac/6Ac4lFVid4fSnRFBEAlKLO+XpgBtFIaGyK+6
         qp6g==
X-Forwarded-Encrypted: i=1; AFNElJ8mAMm01nrYM8xRQ2ylXfvtIojjExFg0j8siYGHupkrTA9KZyp2aRKTUMu3yWulhuhxWbk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8LhsV/5wX0mO2MlkfqjTM9OjDxKCCysPOKVqPnJ7mLhyfe6bN
	snPMBM6gNIbYUMJWkKw6sNneXGVmxtDeLF4nG5yOwq0UBDgyhhll2svliBgcaqgkpWY=
X-Gm-Gg: Acq92OHKdcOQV919t4Xi3cUELeq3OQKYqkTjojGoWkF/ssKnT5yIm3lWFL26yzJ3LkW
	+ruScNaU1CXKdtOVwLtp1tBJIruU9yP2UKOSoDlc9pJtf4xeiPTvO7xcPUmOcqXCxi0UJHZKAOl
	GZaVBPS2Nvtuy7TdQ2HpFTDVi/PGEoB/JVM9e/Y4wHYE2qHm9DeFZEzAIITLr7DqX0LArFQq9j9
	ZkMAhh3V9CUco1lZUJraKvWlv4zMmWHi5ZAFWFuFEmsv/e68jUlD+TMdHDPPK8kGLhFuJM09aNe
	wmj5i+L7e0R4Mu+T3T1m3ettntjcXJ3z1JpBCj76KtO+opZBKKWOQLZUNowRIDU2qRRsorBKgIY
	1ewH6s8nrSFcjD+L9fI4Wl4cRJ+aX6GyZIc9fYkUobTFPN1LAeBMjPbC1OyEOVw7s08IlIpadR0
	TrlPhTJKINKQ4XdB9EwejSdOaH7aRvpiCOnloeExnRoNxuhOF0kRy/sVLB/3tuej8=
X-Received: by 2002:a05:600c:6384:b0:490:acb8:1490 with SMTP id 5b1f17b1804b1-490c2591e5cmr115838775e9.4.1780737557839;
        Sat, 06 Jun 2026 02:19:17 -0700 (PDT)
Received: from u94a (218-164-53-75.dynamic-ip.hinet.net. [218.164.53.75])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d2bbsm124256335ad.1.2026.06.06.02.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 02:19:16 -0700 (PDT)
Date: Sat, 6 Jun 2026 17:19:04 +0800
From: Shung-Hsi Yu <shung-hsi.yu@suse.com>
To: Zhenzhong Wu <jt26wzz@gmail.com>
Cc: stable@vger.kernel.org, Paul Chaignon <paul.chaignon@gmail.com>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, menglong8.dong@gmail.com, 
	tamird@kernel.org, eddyz87@gmail.com
Subject: Re: [RFC PATCH 6.1.y 0/2] bpf: backport scalar not-equal tracking
 fixes
Message-ID: <aiPlO4a8QnMFBqc2@u94a>
References: <20260601180400.1381736-1-jt26wzz@gmail.com>
 <ah5pf25fhVH9WuU-@u94a>
 <ah56iBM2P_9hF3_L@u94a>
 <ah6dLESn8tHAtxS9@u94a>
 <CALgi0X=qjiB756FnrYowor26sybA4z2jNCPrjieGcAA52KJS1w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALgi0X=qjiB756FnrYowor26sybA4z2jNCPrjieGcAA52KJS1w@mail.gmail.com>

Just want to send out a quick reply after looking at this.

On Wed, Jun 03, 2026 at 01:25:15AM +0800, Zhenzhong Wu wrote:
> Hi Shung-Hsi,
...
> I ran the suggested checks with the same reproducer, where BAD means the
> program ran and observed the unexpected error, and GOOD means no error was
> observed:
> 
> - latest 6.6.y, v6.6.142 (924b4a879cbb): BAD
> - bpf-next at b93c55b4932d: GOOD
> - bpf-next with the d028f87517d6 JNE refinement reverted: still GOOD
> 
> So the issue still reproduces on the latest 6.6.y, but d028f87517d6 alone
> does not explain why bpf-next passes. I'll do more narrowing and update the
> candidate backport set accordingly.
...

I think it possibly comes down to commit 4bf79f9be434e ("bpf: Track
equal scalars history on per-instruction level") added in v6.12. Without
that, the precise mark wasn't propogated (for scalars with the same ID),
and that likely made the state comparison (invalidly) go through.

Shung-Hsi
