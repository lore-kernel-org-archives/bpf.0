Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795631491;
	b=H7Xe3pLJuUqaQS3p1d9u84TqMUzPHafhN/7GfWGSSef53fRbQAY6Y/7snU0k/MKPnx+F
	 FRslfaHlq+zGl3QWfDSKZc3/tPli1C5hUvt3+OZevrS+bgnztDG8AJtiaFx0E6RaEoYFM
	 Cy088V7htfPlL0d5OLTXZpyPgBD+1zKghGfPNlwFpx/UwOlhYbO6C7URjMj10TXiRzQz/
	 +51LBXO578BL9D0c3at9KyeODQkZ8LX48xsHGxVAm4Ef0Z3sqJ+wy2qq2bRHteXleFf1d
	 ZKKn9d3EtTZuJ6UQ/lZiHqkH3Ie8jLYeBn07YTpckHTpeP40WCwc4tkiJMZOL0wK/7w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795631491;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=STTtLXq5+/n9y3MejjIsIXIM0gPeibgiGm8B0JO8L2c=;
	b=u0tx1PPUJ/vd/1pP1kFPP+B4FzYT5DBl3xMqHGoCnL4u4991NojzOD9ksa708Fqi+i98
	 QhA7DXrKYVawMLjLA6nDSJLll6hxn9t1jcFpPmLDw+KEt7GZ3KTkPhioT1Fn6P9zVZrWc
	 X8O8D/YOw0Pyg5C5uVdyn6A+SlsPvfPYrlJGHQMFD+/RzBEOkRIn84nsdwNxU2LqsvUYm
	 WuPmIEdcYV7RP0WL9i1AKoI92w4ffqT+gP145sikvbtGGmZ+lvvXYI1la18FCaWWPt2ig
	 hgIfz65ypz39oleDxRfaagI8WHmsaHHZ6HgLoDw71VU8Hx5qTmdugal0YZirVcSHi0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=U0fQ5UNk;
	arc=none smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFB4606A321
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 18:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAFB4606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=U0fQ5UNk
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b8a52db5f9so7658144a12.3
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 10:31:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1795631489; x=1796236289; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=STTtLXq5+/n9y3MejjIsIXIM0gPeibgiGm8B0JO8L2c=;
        b=U0fQ5UNkA6Zrr+wSvFJqZGwFFw/zFL7+DM+gTh+Kw9jGsW92+FMtijYT0KW9hESeUu
         OBBmIBF4IuXXpCkBFjAkQgtA3hUZDawDP57FGhyEVI1Gj5ZaIzptRe1dR0whX2KGSjjN
         w2ywtCVbv7fjfi/t8R9yrQXi9IqQhwdHYTuB+tlUcNPeKXrr8HGns/DoHPIHAcwpv0R3
         HTah4eTEBii8Glu15ShD/ijjf4ZRulZvW5z97ZE7CJH/w6kC6Rseeucz4G2TV6UE80c1
         W5Vy6v4PzjCfNF2QxdFW+bFwa8JUbqw9f/xEdpT6THhuAXK4ZNQbAODrXJnHk78FPY9D
         rPGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795631489; x=1796236289;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=STTtLXq5+/n9y3MejjIsIXIM0gPeibgiGm8B0JO8L2c=;
        b=YymmYveO+S3zNA3VNoRxJg2w3m0z+GqaKP94M3IAXLEDxCWnfRe7YSQQz1QoCBYjGY
         lmmrkFQy9pc/FQTUBKieuEHVUKuUPOD1peSXV6vFVKIO+HltCnHKV7ZDyLFzQ8WA4FQh
         TJYIW+CRTl1y+raFcVMYuNlvo+yg0psGSMmjhVVMVwGOugMCXn6B5FOJTXzmQZx+Mixh
         DxHz5Ti51U/O7SC0g6COF8qQoWH4NJCxJNuq5Ds3B7IM3CrPylJPq0ETMkb0UmT94LPI
         ny3iomoFJ1FNeFGoBgnn17H62QSKjalB1Kgp/f68KTB32I/YaCuQzAjj5XsPXclS6YpX
         a4XQ==
X-Forwarded-Encrypted: i=1; AL+hErFdhHfBLh8758yMVX1vROnul968+km4YKVEl5eCBrEcUKXumUBJDLWi2j0xWnZ9vvrllC8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8ZgEqkPh0wSCaCyHWEHZj+weZD8YdFce8ivGHqAXI7IhDTWwQf
	rosKQaP6gpxHJ/AJo7X4tHxFYcoNpG2qcWhfVwxSaWNf7+onFjHqEqSX8EJ61m/Dg34=
X-Gm-Gg: AZFdTZe7PFEV0KL7btiLo2d/yTyo0eh3h2fi4oJHUNdGAsOAiGEGR64C04Y1eS/ncU7
	GfH/WlaDuS3+itI3Giu74BCcdg/tpSbafyfCQJ2rdmd7/LJcKzdxd3VXeSdM6NbINhwAgKUE9pk
	YYXF1n0xd+4Mg1J6tnUy9xs+5Nnt/AShy8SPjV13Kw+8Vg+zue1wnlT8/V0c8z/d+8Rtp/0RXWJ
	Z799L4UXMxghAPTyqa54vMYz17lm/Ry3e4v/Vcv3fUN40+X0fFi0KbVTp4McSMFKrac07LL6SV3
	bFlXAa1JoQA0UbnUUIMjB2Q6DttAi+T9Qf1L2aOwLwAa74AdsuVknNwVN+Gz8kEHAWMmlNUrNLk
	+B+QsyTyoh/hHuxBinLoqdyELnIEgKMVC8SXjBkKYZtWeMMH509oY7QXgi5GqYiedau19eLDiVX
	iqWz4W2+B5+5yPMDuKkriqWmBvqfhuwQfGrhIA2QYZy25IWzQzxxBH/PaNo8mGEUwk9cl7IihYU
	PUANAYQBt3TpGyd/CG3a1N0ZZaF16Eeh3ODAxzawlYmkxtu9N5Y0/7ry/pcg8tfAO8nuEWW1zgC
	0WJpvIMeaRvLSaUcxu7k6o5Q16qyr+hCiGT9b6WtabCTppg=
X-Received: by 2002:a05:6402:e05:b0:6af:80c4:8981 with SMTP id 4fb4d7f45d1cf-6ba37e890fcmr14784410a12.26.1795631489325;
        Wed, 25 Nov 2026 10:31:29 -0800 (PST)
Received: from L9JK9NPFH9 ([2a09:bac6:37ad:1e5a::306:5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba9b131d3bsm5877128a12.34.2026.11.25.10.31.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 10:31:28 -0800 (PST)
From: Tianyi Gao <tianyi@cloudflare.com>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: Tianyi Gao <tianyi@cloudflare.com>,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Paul Greenwalt <paul.greenwalt@intel.com>,
	Alice Michael <alice.michael@intel.com>,
	Eric Joyner <eric.joyner@intel.com>,
	Jesse Brandeburg <jbrandeb@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	bpf@vger.kernel.org,
	kernel-team@cloudflare.com,
	tianyi.gao@linux.dev,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH net] ice: do not report CHECKSUM_COMPLETE when an XDP program is attached
Date: Wed, 25 Nov 2026 18:31:23 +0000
Message-ID: <20261125183125.25801-1-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <CAKgT0UcFnSvTO6ATw76qVHYxRusTYXpRVi0_GR5QnMhhoXwXsA@mail.gmail.com>
References: <20261121012402.84848-1-tianyi@cloudflare.com> <3adef4b4d528780bae31f2fb02d0a08bf9c8ebd5.camel@gmail.com> <CAG4wq-f18SHytDb39SdJYzRPk-dzECjH_HCSiMGAQ721Zmfomg@mail.gmail.com> <CAKgT0UeWWherBt1MDcPF7R7jxt6E_3peo8VuxrgY3JdseM-0rg@mail.gmail.com> <CAG4wq-dizUz-6GB8Aj1wRTQBOzbHbT7pX9gom+AhR=5OWSyjzw@mail.gmail.com> <CAKgT0UffmbELMsGi8HRfu62MfC9VRYZ+TMNKFjZMWJyrV4t3jw@mail.gmail.com> <CAG4wq-cG1bseTFczZTjashN75J1Jsrv=u1ccuRsY-N1kZ=SXXg@mail.gmail.com> <CAKgT0UeNyyXKARjKR4nVVxNe3UB16WuXqxSz0cf4ZvCdb9A4_Q@mail.gmail.com> <20261125090732.69233-1-tianyi@cloudflare.com> <CAKgT0UcFnSvTO6ATw76qVHYxRusTYXpRVi0_GR5QnMhhoXwXsA@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit

On Wed, 2026-11-25 at 08:32 -0800, Alexander Duyck wrote:
> Realistically speaking there is an easy solution to this in the
> program itself. It would be to look at using something like the
> REDIRECT action instead of just stripping the tunnels and passing it
> back to the original interface. It would then take the frame and stop
> processing the remaining descriptor data. As it stands that would be
> the more correct solution as you could then just redirect it to the
> tunnel interface I assume you have stacked on top of it and have it
> receive the frame instead of having received it at the interface that
> just head the header stripped.
>
> It would also match up better with how the stack would actually expect
> this to work if you didn't have the XDP program in place.

That is exactly what we are trying to do. Our traffic will be
redirected anyway, to a cpumap for load balancing. We tried to keep the
RX metadata across the redirect autonomously in [2], but this has been
strongly opposed so far [5][6].

[2] https://lore.kernel.org/all/cover.1794281983.git.tianyi@cloudflare.com/
[5] https://lore.kernel.org/all/20261117161856.6f6c2ce9@kernel.org/
[6] https://lore.kernel.org/all/20250716142015.0b309c71@kernel.org/

Thanks,
Tianyi
