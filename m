Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795726521;
	b=GoFNDOxC9gbaD92HtGpJDhEREbrUvdDimIaXt3qxlKfsSR44sCQG9xZ6mzb1dEkvXlwU
	 LZvoXbeWm8q0Cmn9j1Rpjh7o3SGL2eMRMTH0gBQ67jTN5A5iHxIN7qr6VUfKfbJkKpfpL
	 C/i3OMJkIjId1CXoyz65C/zw5mdvrgkBpZuSbnuqMex66eCUqTCOP/aWBbOUttMxjdCmR
	 gtlzrWZVtDwE20dEobVQ23HDASWeMHrSNfGSU+boBQlC84hhSm3OGOet7K9wI6myf4x1a
	 +XVVfjwSjDw0EtA0RSKD0P0DRbPrIpslUBQWE7TmrNjua/xLIiBT8w6OYLJs1dHMk/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795726521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=WG8u27/WmbWF6C9WqnFdauWWHkIDT4nMCSatNf2Dopk=;
	b=4UWNzcwORj834iUmYdf05YGHeJl0kCGpQaJ+RhkBGyZId6NrxR2qQgoAVNeDdDIk0hmH
	 oNT/hRxHeAiZ/EkjcpwIcNqPPYGBDEvfxuZwAVNoPrzmGbCAheJTerHbmAGhsnBZJQap9
	 u+1VTx7MITjePf/FvV3EVD11qy+Z9EjjJ8A+f0Mt9HJvDyVVaisk8nZrbW8M+ggc/9Lue
	 vxKf5+iqf5u+uiDIGfIlco6l/SpcfYQHfH+kvxsRhXwW8eYzpLZMGGfNgaRiVpoq16P94
	 eqxjbN8bRjiUDQbmYFyDCjzg2ecrGsvcJboBhpLZbObgefS26BJ2RDV7IlcEE8lynCw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZRk9pbpx;
	arc=none smtp.remote-ip=209.85.214.180
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D07606A31E
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 20:55:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79D07606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZRk9pbpx
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2f02f04a426so59595755ad.1
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 12:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795726521; x=1796331321; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WG8u27/WmbWF6C9WqnFdauWWHkIDT4nMCSatNf2Dopk=;
        b=ZRk9pbpx1qYIlFNLdBpTk1l5ax99IpkBgvxNndr/7zOBPE6nwy4dYpgboyM6myBcfh
         Mi6xXUv3+6WgJDwvQwrPwgFzyk9MtzD/rI3kxjQIdCGy9DoJ8BjUgOlrri1ZmEUwaiZf
         GhaPLezWmjAbMscLibq+ydYSoMaq3aVttbOp/ZKZpLswK4/QVdl4WFEEsg5DKXMC6+1U
         y+2P5zEzVaqP3Vju4lAasWaBFSECJWxeHJRlQ7x3rlCK609SjbO5ErXa3VRVUYBnkYU/
         c4o8lMyCUXE6bprS76giqjnE5nQCcW1iw1M8Q6SAshZ6wIl6nn8AQT8HNllqw84pqxwE
         qXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795726521; x=1796331321;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WG8u27/WmbWF6C9WqnFdauWWHkIDT4nMCSatNf2Dopk=;
        b=v39slKPZOWNIGmVo1fCZ2l3Duyuli8zdJZsM+VLXnTPoyhJln/nTG0q3hF+EhI9tJB
         KJQ0BSVXjUn+Z/v9nztE8QnIV7jo9VN/esendYwaE6D+UhSz0oE81MWzMKthhqozW4N2
         qYQWMwVp+zKfwRQvOHzxmZVnDzALiOXCtyLIeNhZDZOR02IjwqlLVMlzoxr/nmeKCfeW
         eEP8qknB5qrmKzfvVVdoih9StNSpKTxXLVWVZrxIjE5r/r4ZuQ9fbcSAFx4NLDtAALPf
         oKCo1GgqsliyVOe/ekENnuzHVqY/xbKjtyBr+STD10geAbcFZZ1asTLg+tKXvxAaxxbl
         ad/w==
X-Forwarded-Encrypted: i=1; AL+hErG3P/X9psfe5GywcJQme6keSNKtLupDl1UFaqkoC5S7zyClCnaIO06NjQWBMFiMifGuOa8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+K0ErOAhu+xc7ErG5l1c3eQT4i0b9cYDwkFSP4KEJ400A7Ob6A
	67DVwCztPEL1ulatMlkr47wy/qO54jl3gCMI2GaZ+pir2CATRqg2cs7z
X-Gm-Gg: AZFdTZdDEuIinX4FikhJ7ciV3XOL8fKCohozosTn9VkGpvJx7CMOcgJuyPx9gPpadLN
	GH2XXW2sZpQAFFCKOz3gpC4zIW1OL56NEdyGFy4Ez3HfW4RRs9IKUpFCvF5B3W7cnmzsT5bQNFk
	OV5U6pU6PBEfeeZZUP9RtHYvVFLSpd0KmHqnrM+iENMhrGGi2ys+0vpleMWNysciTm7XqfeguCh
	wP8mXaqZLjrlRkkT+HoUdPsaoFdGn4A9hzlDQY9wcfaHbxANEsa3XGaH1wmxDsmHm/dmOQP9KUJ
	892s1kyLPNKs3yLewerwHid+RaeE5bx0skoM6Rrgng+Wx7lxtXNLT+/1S1Hu38UpY65r8fFiwIY
	/U3G/l6PrPN0M3LRZ2RIvCJXqRPrh5kqS2xDsno4tnPL3PNlqH1VxaFN+V5y2BG2W+6a1ekviO7
	qPOnCoshMEZc8JeQ0b7exOsmDixvypCkxV/RI04JUjYVicKWTfZdmEdDtDJeEdNDdFT7U4gVWSo
	k7Rn87WviqQZAJgTlC1ElXE1rXTPqHCmwnGXe+HJzTfAljRuFkgjiYFFzB8l6V00hgDthB8+c0f
	OK3XmoYfhsWtBytp2E7uPM+rDZutaDo1A37pKm3yaPp9SsFyIph3VZcqBNRqX5vO9eV6g9Pbc+j
	feZTjA2NLlNpPY+2SY3sO3lqdQ/oWPNn17+VyPt8d3Vn5tPhiV4T0zkc=
X-Received: by 2002:a17:903:230a:b0:2ef:e755:bba2 with SMTP id d9443c01a7336-2f03f2b6004mr227987945ad.62.1795726520672;
        Thu, 26 Nov 2026 12:55:20 -0800 (PST)
Received: from localhost ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f04913a77csm100950515ad.34.2026.11.26.12.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 12:55:20 -0800 (PST)
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Nov 2026 20:55:19 +0000
Message-Id: <DN5FXAJD2B7T.26NBT62PWILGJ@gmail.com>
Cc: <jiayuan.chen@linux.dev>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "David S . Miller" <davem@davemloft.net>, "Jakub Kicinski"
 <kuba@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "John
 Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, <bpf@vger.kernel.org>, <netdev@vger.kernel.org>, "Tianyi
 Gao" <tianyi@cloudflare.com>, "Octavian Purdila" <tavip@google.com>,
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "Alexander
 Lobakin" <aleksander.lobakin@intel.com>, "Ilias Apalodimas"
 <ilias.apalodimas@linaro.org>, "Lorenzo Bianconi" <lorenzo@kernel.org>,
 "Lorenzo Bianconi" <lorenzo.bianconi@oss.qualcomm.com>, "Magnus Karlsson"
 <magnus.karlsson@intel.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Eric Dumazet" <edumazet@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "Simon Horman" <horms@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH v8 bpf 0/7] xdp: fix page_pool leaks
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Maciej Fijalkowski" <maciej.fijalkowski@intel.com>, "Slawomir Stepien"
 <sst@poczta.fm>
In-Reply-To: <awbq4F8pF3YSGX2D@boxer>
References: <20261124104016.532341-1-sst@poczta.fm> <DN3QVHST3PUQ.3NINFUW0FL9IW@gmail.com> <awa0fvxzngTtIYVd@nr200> <awbJFmKWy50Dp0yS@boxer> <awbq4F8pF3YSGX2D@boxer>
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

On Wed, Nov 25, 2026 at 06:04 AM Maciej Fijalkowski <maciej.fijalkowski@intel.com> wrote:
> Nothing leaks with your diff, it is only about recycling, so I'm fine
> with keeping it out of the fix and following up in net-next. On top of
> the on-stack rxq it should be small: for skbs veth copied (what pp_cow
> tracked; an uncopied head is usually not page_pool memory), keep
> MEM_TYPE_PAGE_POOL in veth_xdp_get() and take page_pool refs instead
> of page refs. Unlike the RFC, which keeps skbs as skbs, that preserves
> the XDP_TX/devmap bulking (the RFC loses 8-17% there [1]).
>
> Would you be OK with that as a follow-up?

I'm not sure whom you're asking :)
but makes sense to me.
net-next is the right place for it.
