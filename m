Received: from mail-ot1-f66.google.com (mail-ot1-f66.google.com [209.85.210.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99FED1A3160
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 19:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771011482; cv=none; b=lTgDqFoZG6yy3YFRRklp6iLMqyxx154xK+TKbMLl/pNuuSqqWtbYrtftzPaWxtRE96BQAYPEUIOQwZ/yDxyx1iXwvSlVzivwnu9+hpFR4hu9Yep19S8oOmQ3fkcfT4Oqs81q3BYIEQ9xcJxD6ftHOGN6w8KBHGklJE0um/pIEnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771011482; c=relaxed/simple;
	bh=U7sI/xkyuRgahYXuvR8Vo0aIoYwBUu+TTBHsxFMgfCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aLLd7cz3jDisw+ou6qwPxpoPkHp/M6fM/AhtndrEVrnVqn7UqDSJvNIYY7v83QbvajjgNhyyh6C/qQlycjjj82/krxLCiXuVvXcThjKTtce1idjQK1YRAyoxJ/5PTTGmfFtFYmMJ/ckVYNANhy78YRsFb66jh63V6SCo41xb1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=K6clRyHi; arc=none smtp.client-ip=209.85.210.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="K6clRyHi"
Received: by mail-ot1-f66.google.com with SMTP id 46e09a7af769-7d15b8feca3so1332219a34.3
        for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 11:38:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1771011480; x=1771616280; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fxY2oKY9sqeIWzMz/A1TUVWjLExOrW3QXCJCx5a7Wm0=;
        b=K6clRyHiND77dZ6nyw1tTZlmvwcxhDEbXTr+w16Rrm9SSbq8r2Ko8zEVC+HdJcJsT2
         2CLp9flmIwHi80BaS5qk54BBPQwEG9EcgyvVAo1k9Em+bdmSe285fzD3hfriX/PVRSxJ
         wBMCy2btaOaM/MrOvwT5Th6WUiHxrCOqvtfC1n54Y0QZNny5z7jU3WX6WFvMpvNwVAFH
         w2A+hongkc3l5XKGC+HdU9p5aqPJmcoxSNP8sCNipaTZvUP+J/oeRz3NnNvAvK9eDqbK
         udN7en13MPOXsXtp/+L0wSwRBkza+U0Yax4+xe9JN8LpAyZYY3CPMTIbrL1MMfKw5SHi
         KqGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771011480; x=1771616280;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fxY2oKY9sqeIWzMz/A1TUVWjLExOrW3QXCJCx5a7Wm0=;
        b=cwwhuR+Bz7WolnHjdDUHmCZjr2UUVe9qwg2cf+aBj66CztjjJW5MCl15f/ioGG7M1S
         wHFyCIxUXbswi0B74POEp0ELN7pU/9rffE8yWiWRyTZbr99hcaeN92g/ekbf9OTNekvy
         WEv27F8qZwkRpjm3VsCBeY/4AJpKVh6mqjwLp6rxBDAmMW788DEGxiZc1R4TwKfT150y
         o8qejtLtEMqEuaoAwzDMAlwM9r6/CzxteAWABDSDdjLVgKCgm5XfXNC7FD0Q/DUP8AlT
         r3t+bV6iBnbJm71IpcjJMTTK6+Lx8vULrbOYV1c3kHgT3H0aaHHFOMbAramr7mp4meOD
         IbCg==
X-Forwarded-Encrypted: i=1; AJvYcCUgPs8CBGq1tbQYUAwRLAPAiCRKVeF79NXkyKPShCZ0ngf0bYyXt7MNXytWAO133F3p+cU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc4BgD5+dTpDth1v6XpreuK+nJHv+YcQzrTZXpnfJ3p0hLJ/J0
	iqeZuBh0ufm/DG2omk++rzNV/0P3mMlMoKCGfdyXQ+/dRVIJBxv2TqI6a1G2MuFcplE=
X-Gm-Gg: AZuq6aJoQFN4wtmKWdZjpRFM3nI9o0DoPlFJBoSjEcGHf4tUEB+D2MrwpwFYDvxEFGj
	ULEW4ZwrajOGH+8QC4vsXj3nL5L4ksH7C7Y9odCeG+Y+DwIiWLFBZtDF8fTWwP42OHY3UHIVn48
	+5mWuuzcXiFASfgzCyUKHgtR00J3n3ZrQy6k8yXMVy2d5eAzFlel2uEY3bs79H94AQ5XZ+pjnh4
	6yLbmo0GuFd/Uuchkdj0PLb3mNxv1N2LrLss9S9xnsRNnC49c/FuLXtIyoQ3SRFZFg5vLAtRO2p
	lCJhsodRt6B8Xi+zyYXg5vWKRkO7cAAOswNdwDBZ1qSkQVdEukETH/U3rJacaQMfhkYjCzukg/u
	tB/468B5J1QSp3TNjmuXwzyVVm90PUZObWoKC7ttlg7ELODOLTK+WHFNGNeQpXLVivJQc17RUwM
	CqVABZ3w==
X-Received: by 2002:a05:6830:700e:b0:7c7:62d0:b462 with SMTP id 46e09a7af769-7d4c49fbff3mr2239479a34.6.1771011480505;
        Fri, 13 Feb 2026 11:38:00 -0800 (PST)
Received: from 20HS2G4 ([2a09:bac1:76c0:540::499:50])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d4a7530a8bsm7240663a34.4.2026.02.13.11.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 11:38:00 -0800 (PST)
Date: Fri, 13 Feb 2026 13:37:58 -0600
From: Chris Arges <carges@cloudflare.com>
To: michael.chan@broadcom.com, pavan.chebbi@broadcom.com, hawk@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: kernel-team@cloudflare.com, jbrandeburg@cloudflare.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH 0/2] bnxt_en: Add XDP RSS hash metadata
Message-ID: <aY99llj2HmFNrR_5@20HS2G4>
References: <20260213192449.1294830-1-carges@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260213192449.1294830-1-carges@cloudflare.com>

On 2026-02-13 13:24:26, Chris J Arges wrote:
> This patchset adds the ability to use an XDP program to extract the RSS
> hash of a given an xdp_md context.
>

I see net-next is closed: https://netdev.bots.linux.dev/net-next.html
I'll re-send with proper target after Feb 23rd.
--chris


 
> For example this XDP program extracts hash and rss_type:
> ```
>         ret = bpf_xdp_metadata_rx_hash(ctx, &hash, &rss_type);
>         if (ret == 0) {
>                 bpf_printk("XDP: RX hash=0x%x type=%02x", hash, rss_type);
>         }
> ```
> 
> I was able to test this with a Broadcom BCM57414 NIC and verify that the
> rss_type and hash were correct for IPv4/6 TCP/UDP and ICMP traffic.
> 
> Chris J Arges (2):
>   bnxt_en: use bnxt_xdp_buff for xdp context
>   bnxt_en: Implement XDP RSS hash metadata extraction
> 
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 29 ++++++++----
>  drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 +
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 47 +++++++++++++++++++
>  drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.h |  9 ++++
>  4 files changed, 77 insertions(+), 10 deletions(-)
> 
> -- 
> 2.43.0
