Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.160.49
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1794873355;
	b=s1XV2aETQKFhOzaSsqk8YicUFkdEZ+W07J2SYj43PvnEpv4gexM48fA4CZmrLcPbyrvP
	 98Eh+J5Doe9J/8eOjwATVguLqMSmLd5+iNjnquGNnwi1OKsRnjHwidqyW4+nP0Kzle1gX
	 41dul90nUs42v9T0oZkRwub9WN/ZtBmjdi/6UymGa8g3mK14pzXIHm1WXSOoKtnodB/EY
	 b9/VsH247VD5jcTVgaH9HLg9l4HXft2IEZ0v8yMjGMSQk/A2mENRZjUhzn8jvr+hW6USe
	 1R1UsDUsdJNvuwjwbv3i5NYPufhOFRXFIWzBvwuZw7XtUDCMzj0OXm7HzUi9EZ2qaGw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=pBcsIqN5fGPsZcVWkz3kK83U3k9KWzXvm7Zsz1tEHJk=;
	b=Ny7bLzqps2v/HV+g3qYFtEL+0Tb4eJB9bgEIzn06rn6nbHIL6v/uR2COamPVZ0+8PXhv
	 oW1VUqbTETAFKNV1HDsTf4NZ8CDzD4HVsh2JifMrtEsr0sLZtSkR6Q8Ehah6kTz30XSrA
	 oIpX1E3W+VG28gM5Jt3lQUkMs7ZqlVvwQxvVBioDTaXTv/nB+Ba3w/tw5lK+O0vDjo7mN
	 +6Ab49wojNPwnFGIL0ktuJbvXluWzZOttaAm/SvAeKvhamypncglxcWwyRWCgjBEYA9pT
	 WcxjEpzikjkB2Z7EMe6k2Xwt/04Gl8HMx6MCYGT6ZpEcZ2ojbXkAIFMS3aLPZxx+dkA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=JAkvmEBC;
	arc=fail smtp.remote-ip=209.85.160.49
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBB1606A31C
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 23:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CBBB1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=JAkvmEBC
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4877837890fso2574999fac.2
        for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 15:55:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794873354; cv=none;
        d=google.com; s=arc-20260327;
        b=ff4ufVZ8AovUnEGmQwuBzFwdTn2hA+HGAJRqO8Fy2w4UV1+OioGZnhqlFh5MEaXQxq
         9S+mdZ/RzLvMYdFkkM8QUR1kGSViCBYZxNe4mG37AwEjSTx79YTWh2OeMJPrdxqbN9J5
         m3ILb6ZZEmyqvPVK98aLhkocFY+gqj7tNwjpdO9hNUFODLH4hxlC6S1W9zfFN55KsURG
         5LsRKZvkliUnpxeVAib5fHkZVGsqF+ZBwoIxtursvDDzThLTXzD88YbGuuVuKA7RHmqr
         +vgu22Hdl9STY9NIHJrzDqqoRFnpwkDKbVuE2nQoe5CPDBlqZNj6LsoieR1Vd6c7PSen
         Uudw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=pBcsIqN5fGPsZcVWkz3kK83U3k9KWzXvm7Zsz1tEHJk=;
        fh=j/S5H4XHONWiN2LTzyJC7ygOGFd70IHSNy0/BTl9GwM=;
        b=ibAXTiLw9c7d7lSUM0QP2MhwAMb+8D3d97N2rzzjKg/dzC9DBwL0V3yZk59fDwiQFR
         2RF58Nq4ZUCD/fImzNiSFrh2zA7ZAFm+RUOOCWDRJv3onqMTaGvgbvqaJuN/Y9JescuJ
         eJIO59txhUS1QvRL2EBDGeLQs9MrUaWQ9PeA52qgt5Pv5lSNcXg2mQ/TPyMgmnW/H+mL
         AYy1aSB6tJJdNxTJ/A/1qrKrOmhKDTLpkMLLabiq26mLitBJrNIn3MJTiYYQo20WDAW1
         GwnrYyMrXzCHxEl4A822hJyNQEoSp/kTVyOQPJRb2rbWmJMg3hRJP+oh/v/HRQSWpVL0
         ONIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794873354; x=1795478154; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pBcsIqN5fGPsZcVWkz3kK83U3k9KWzXvm7Zsz1tEHJk=;
        b=JAkvmEBCaNDQqwC/zKowMzj6cpiI7lgA6iaz0LI7B90FIdYKT+zfc8mHOfbT+8rfmy
         SkxZwQ9E/3nRcFpOdPfK4YkO31ptJrj017y76GEN9o+sriJn2LpPhsvGdy4+6ZVs7P7b
         gWmNIxbWSERHhTKd2zkL1m6C4vu+dM8FCwNbEDFmf98bujAm6BesiHJVeKB6Mv37oIXE
         DWAm2yXQzqAAVjsc+DybarNPT6YXVie4MGJHRFFkjGvmOyHEShJDDqv0maNaWckg64Z2
         L/XJP7qjo7r7unFg1B4QzrVD6lfR0b+R5Old5lYIyjznlmAyd2cbZ0Uxx0FLIGVM4o9N
         a3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794873354; x=1795478154;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pBcsIqN5fGPsZcVWkz3kK83U3k9KWzXvm7Zsz1tEHJk=;
        b=nlNYU1fVhbTVcCKdq7aE8eaQZK4g5G0wPhPcDkIu8yY78+K9QZHCDWoRGlRGWBtiPZ
         Uis2PycA3dRBgIfTbe/Od31zyPOZ1HYzq+JJhb+Tf853rXyFez25TxwIOy3QWGsxua4u
         jMSLrhN4fQ7uV6LQgoUcR/KqW6GqhwW/EndjnbOTdsKF5vpAKDSc86Y6e8chfASd56GQ
         mPzAZfC/xUI5bC8VWkXMiZ+Imnqp9IpE9uBaczqyCHS1b4/lS9mJfO8HkhqYIrhShTX/
         P5EvH0TGC7giuCPpF5Ykc/bpHP5xD4ScdPkit0chmyV8bINcKcp/V6JQ27gfGCh+kSOi
         qkkg==
X-Forwarded-Encrypted: i=1; AL+hErFAVSArV5k1JqBJw0ANzRQaHz7pxlSYMNPjJRo1ca8HtiSfCVtpkx9PPt3DXwegEjZPSrk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9jsWiWMGyklKR+jHBZWL0GXKABNICTBrZW54S98aUlPSOUKAKX
	l40MoINPBLJEey78R1J8z4oclHaNtZAWsVOtkPYq95KKzMIkEDNkRQcBIvYoszz6WQ1z3I9KFaq
	QHPg7t/cpwWgEmuvXXAVM9nYf/vyckD/Y1EbL0THNe2aoCherC9eMP2LCYfxV
X-Gm-Gg: AYBFou0FjnBhm9/OS7De11vptg0aIGOfsPJJMaDrzOU/zLNrmeTEv4JDb80xwst/CN6
	csTv+a7B2L0ZtODqgWDMMh/ICJeFNAzgZdtvtvTZl785GgZ2ToDTU6a4h+deGQyY59MPN4JOvfE
	UiJ84PHQ/m/RUVKNho85XVx49Fk2zDO+MR3M50blp7D4bJygv5/R3sgKgluRBEAeuK2c/4h/SPa
	4g1hmx3FsLHPK/5l4QTlIvMOR+c2AGdoIv/354vEoJzL3Fxr/ywFPznPwddtCPcFBfchQWwAE16
	TBJV0SPPQNRjIzd+JBVcSLB6QZ6YbsXZxRDlylm49fuhf3fX5G0GblbfM/451ujNoHt9gmWvYN4
	GyeqwV1okYn+ZkuLus7mo3GWZPuLqzwu7pHFM6bB0iIgClxghKHBv/VG7i2QzYKeoM0nSWG4uK4
	ateshKeplfDg==
X-Received: by 2002:a05:6871:b2a:b0:494:b8f4:9a22 with SMTP id
 586e51a60fabf-4afdf70bba7mr10365207fac.28.1794873353687; Mon, 16 Nov 2026
 15:55:53 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794281983.git.tianyi@cloudflare.com> <avOvI8xrHI0dwyHj@devvm16445.scu0.facebook.com>
 <CAG4wq-egD55NZDw+OKVKTKN2tQJ9oKEC504wFv=xoMXyJ-0z4g@mail.gmail.com>
 <20261115113902.4834dda6@kernel.org> <CAG4wq-dhd5a5zxQcSShaKifYd2z+pMpHaCYtZJRX1QCxEH4dfg@mail.gmail.com>
 <20261116142710.347e8571@kernel.org>
In-Reply-To: <20261116142710.347e8571@kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Mon, 16 Nov 2026 23:55:42 +0000
X-Gm-Features: Aa3M54oRvcr-c3A5HCcCKnOxqAqDaGkfnfsAP0Ey0SL0I7zgF2gu0s6ZsVqnle8
Message-ID: <CAG4wq-cDYa2GkpWSYeOLwEPv45BtucZk+r=N2b1Srd=gUUO4MQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/15] xdp: add SKB core extensions to keep RX
 metadata until skb creation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Stanislav Fomichev <sdf.kernel@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Vladimir Vdovin <deliran@verdict.gg>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Donald Hunter <donald.hunter@gmail.com>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	Tushar Vyavahare <tushar.vyavahare@intel.com>, Jason Xing <kerneljasonxing@gmail.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, Madalin Bucur <madalin.bucur@nxp.com>, 
	Ioana Ciornei <ioana.ciornei@nxp.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
	Randy Dunlap <rdunlap@infradead.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Chris J Arges <carges@cloudflare.com>, 
	Jakub Sitnicki <jakub@cloudflare.com>, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, intel-wired-lan@lists.osuosl.org, 
	llvm@lists.linux.dev, kernel-team@cloudflare.com, 
	Tianyi Gao <tianyi.gao@linux.dev>
Content-Type: text/plain; charset="UTF-8"

On Mon, 16 Nov 2026 14:27:10 -0800 Jakub Kicinski wrote:
> The question is _why_ you use it. Let's leave the cpumap case aside,
> you provided no legitimate reason why having an XDP prog in that case
> is a problem. With veth - you are right that attaching XDP causes
> problems for pure skb traffic. For veth cases, however, there's no
> strong reason to delay the skb allocation. Hence my question.
> Why not let the driver allocate the skb if we know that the
> redirect target will need to allocate one, anyway.

Sorry for not being clear enough.

On the setup we want to build: an XDP program on the NIC does the
decap for all traffic. The services run in namespaces, so the packets
must be delivered into them. Some services attach their own XDP
program to the veth, and some do not. The host does not control the
service's program.

For a veth with a program, the skb path has the problems you mention,
so the host uses XDP_REDIRECT. For a veth without a program, we want
to use XDP_REDIRECT too, so that the host delivers to every namespace
in the same way.

In a minimal benchmark, pktgen sends UDP, and perf stat counts the
cycles on the RX CPU. bpf_redirect_peer() from tc costs 3% more
cycles per packet than XDP_REDIRECT with the checksum status kept
(mlx5, one extra __netif_receive_skb_core()). So one XDP_REDIRECT path
for all namespaces is both simpler and cheaper.

> Since your patches are not a natural / clean extension of the existing
> infrastructure - we should step back and make sure the use case is
> practically justified.

Maybe I am missing something here. XDP_REDIRECT into a veth works
without an XDP program on the veth. To me, it is natural that the RX
metadata also reaches the skb on that path, without attaching an extra
XDP program.

Thank you for taking the time to look into this. I would really
appreciate it if you could point out which part does not look natural
to you.

Thanks,
Tianyi
