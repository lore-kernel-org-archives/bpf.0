Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795202230;
	b=l54obovdQQ9esiEypP6KdNg5sFvfe+vFhP3Daopu2vRmPhlrOIB2Osx/J7ZOta5vTde0
	 NOLwOgb3IQkc46teVxpwSo2jtUVyI+CZrig2LCzZ8CsFzRFpW7AHqjwbmTvN1lLQXeBhJ
	 oNWkFH+ISjPEtSnjrfle6RAutgHnbVVAcoz+ClzXlOkdBzax8PYhQ7tWnBphavvste39U
	 LZ97AzKky4fvvVmECa2ULXVjQetW/kAWeqLqGJzUVLV05wdIEDqQrVt+ibtRY9D/BQXKl
	 9/YiC8e60NEOEUhk5/9dOZobOn+PdDcKv0Fs5BHF6jmkH883l9lrm7uTIY5PG3XePIw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795202230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=5Iu/1w/LI0buVkR+aQF4itDAWB9ZbTOtkysWfOEOOGc=;
	b=YR2XzApjuWnC6Cm2MYe32jlzD7E5qRaVtfWagDA0Iac7WpJWR/SeIPYlxzimjWw3LowQ
	 5+lDiUvlI+3fo+YDY2EX/pg4+yZbolcydqpnK/MfeBqYyV9E7JZKjJ0tqSYewQQfvO2DI
	 nakAnqoOvcUrF6Ut92K5zijsBU8oIfYee+nswZTNfix6bJI1mnzCNSKNuOU/Goys7cJZj
	 ez9FI37+LSydGNip7nc8gPvrJ/GWa9dd5hXHUGzXs+TTx3CdHJkEvnezP6XuiXBNLbdGn
	 7pVzqynoFMQQV+reE5YSTf2YEGdOzFdiIyo3YYTNtzNcIlPxdhSmtyEi/iJ57zmBsgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iS9DAKA2;
	arc=none smtp.remote-ip=209.85.215.178
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A64D460A2609
	for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 19:17:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A64D460A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iS9DAKA2
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cde0daf3a2aso601355a12.3
        for <bpf@vger.kernel.org>; Fri, 20 Nov 2026 11:17:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795202226; x=1795807026; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Iu/1w/LI0buVkR+aQF4itDAWB9ZbTOtkysWfOEOOGc=;
        b=iS9DAKA22pBrxKuaIMLvTBi3iP0uQzx9apoMFxnN1ajW8P1+uthtNgOeaMPpmuD7Fs
         4J84WBU/iCFUgsev5fiozE98dq4NS2hBbxw8ZBvyZU51Wf9mXanbCWU6ithZeDf8+5I6
         YefDGoWR/7fY3S/iffZ0gMGgjxlxF/grERWv+SnZCv2YyLeo8ku61kvpzh8b3doetX6S
         YPTcn3EHvY60a2wx70MWemRecyb03Hm+u6mnEEofzgRqCkRGsmTops4t/PelBfJQPVoB
         8pJ9FJ2J9gs/IiguQ9+pg2kByfRVxedtVZr97u6dDgFPV393Vy6+24EHoYVs8L8g+4BC
         7OJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795202226; x=1795807026;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5Iu/1w/LI0buVkR+aQF4itDAWB9ZbTOtkysWfOEOOGc=;
        b=sCsDd7QFU57CLkulvQSZ8aPWh++eKho4HlXjrJhj/9uc/pReRHXslp6Zeu/lFrcXyJ
         ETH92K6TuA+3JQ/5B64FEcwFy5kJ7CnOgHMkfXhpL+y84Qt/JhEGL8eS0mlfT78OmtlH
         BN2zScFu2zj+Cmqt2kw3HyD+lZhjGygtzGlQk2g9kgg5zE3OgQ1c0RFcJ+KlLTQfhrep
         fHTvyrD8J3nSfpVCNDP+QFWCF8ZfAFqCrsBZWV25EE88PbVCJftKmSehIOOzgeoqENIg
         YvbwYnoQh6vHAiDt+HwqdbGxKROCrfQ8SGMNnVwfMx+10Vv4sbNvdcMtUJb3jwORn84f
         oQNg==
X-Forwarded-Encrypted: i=1; AL+hErEM/Y0qEV35rRaYtJnTgOh+E14rIgJ2MJAVZcJLRru8Cb3kwXeixxGmjMSvfMTqso1GR74=@vger.kernel.org
X-Gm-Message-State: APuU4Z/JYp5SyHfHk8R+Li6aR7bURiCen69kE3Mw+uOwmukey3MnlZUW
	NukKsKFCmOGaH2cB9g7Wokm9b+3daEHl1A8OZDvws4PuguhPIx13GZ3W
X-Gm-Gg: AZFdTZeki+XDc6MJccOWIMh4rwB4zQ8E3FStMoQwZ2Qbr+K9M/Epa5b7F0j2ko9pX5y
	34vDu56wbbpHgQY2+C5SDN+1yd6mjsvRKD607M2p75Q1vfnwnxAwcgePZS/qHotcKHP68irqeEn
	8FsefU+gWfas0TPjNOqiZk/6Vko5L+41UYW4PGQ9G+GyYo4rvMuB0YlROmX4CH3Oo0f6YuUjdnD
	d3inIUy8g23sh/K9WtjOSuvKtYTCRAK22/RQvRsu1yE10wHN006oqxvrOu0I4Sysj2OSM1s59Pp
	ScG5XygoagSiohV65p1ALfzvpJABepofegKWVSfmRYcYOTLobu/aD8GR/X5NCugLEQADhyEIfjN
	y52XQQoi78bNoTzeloYuZO4o/zZVU0lyff5BCmFIgS/emWrY88x38BYmc01ATWwWL8dYdCMgNzZ
	8xAWJcBOSG+jcKfWL9ZKOo552lw6cGxvTeqfHwoG1x2MnddyBJmGe22IgLjjaGPJGltR23rNq64
	J6OAGw/YVD18Ge7w31a46AGAXhxEbb8cmU6+IWe9roEPevh//M+vosKXfHRpcZYk5/PKDtSU9K+
	JssLAe2UWV/SJGX7jApItFH2zEpngfMqy21gophH0SuYtEAtZ9DJIkNBUNX6a59iRBNrLPDNPk0
	uQR9FAbzuEImlFlslG6vHEW1hI0MCyhbQFg==
X-Received: by 2002:a17:90b:1dcd:b0:3b0:bd53:8e5d with SMTP id 98e67ed59e1d1-3b41cb3e4b9mr3128974a91.58.1795202225858;
        Fri, 20 Nov 2026 11:17:05 -0800 (PST)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b405d639fdsm8535782a91.10.2026.11.20.11.17.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2026 11:17:05 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Nov 2026 19:17:04 +0000
Message-Id: <DN0A2SUOYS26.1M5IXC6G41RLL@gmail.com>
To: "Nikolay Aleksandrov" <razor@blackwall.org>, <bpf@vger.kernel.org>
Cc: "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>,
 "Stanislav Fomichev" <sdf@fomichev.me>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@kernel.org>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Joe Stringer" <joe@wand.net.nz>, "Paul
 Chaignon" <paul@isovalent.com>, "Alasdair McWilliam"
 <alasdair.mcwilliam@isovalent.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH bpf-next 0/8] bpf: add bpf_sk_assign support on egress
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261119142231.2612515-1-razor@blackwall.org>
References: <20261119142231.2612515-1-razor@blackwall.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Thu, Nov 19, 2026 at 06:22 AM Nikolay Aleksandrov <razor@blackwall.org> wrote:
>  .../selftests/bpf/prog_tests/assign_reuse.c   | 625 +++++++++++++++++-
>  .../bpf/prog_tests/sk_assign_netkit.c         | 586 ++++++++++++++++
>  .../selftests/bpf/progs/sk_assign_lifetime.c  | 182 +++++
>  .../selftests/bpf/progs/sk_assign_netkit.c    | 153 +++++
>  .../selftests/bpf/progs/test_assign_reuse.c   | 174 ++++-

1700 lines of selftests. Pls dont.
Tell your bot to make it absolutely minimal.

pw-bot: cr
