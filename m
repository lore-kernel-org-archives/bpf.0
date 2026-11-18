Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794962587;
	b=lzKEPsa0FhyxTJRwBdVbt68sfc21OOq85AbwfUicWxoCswhvV7mmxXxuuA/sy69pP9tg
	 KYCwx2KlWctTAf949BiVgXwofS02TEGW/bV51Ivi267JydlkInTDyl86QBR2hzjpB9Up2
	 w3uKlPXO+2o3+inX4wC6S6u7qgp0GZmMexByq099nbJIsqcJAG/TO1uWre60zkL3FqDzA
	 q9EMcnwvSyM/vtcfqVjYiFpA4r7live4FluNZrKVm3xUZV21WagSJb14cKvRfPpWnhruG
	 6bC8v2ZKZh/mU3ohZcHdr8si/F8f5WzxlGtCY/62GS4TpgUKRxbL3qzrFp7L0KXNq1w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794962587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=puGtQjs5QpcXV8o0ei3pWVAJkBqePYnUROGDguXC5No=;
	b=Ejf8c5fb5MaDQwxWpLBVxrJOuwrfkswK4yscP8d00TMr3opD9rBH1GIRlJNQzyxb2ixn
	 xlLfdnDXWY+50tDBhtnWdAM2/hcq7ZI6gnrfQZr9hQ/SPNWFlJyKXS5aOV26oEXlRzU+R
	 Ezt5xSWMNQObkgGPR/LYTIG0XL9PORDGkekaArjsWZhag9kDX+3DYuDxbyy5vdAkVA+jd
	 1B3BOpqquXOY3QFsuLUBaEQwXhFomdkDMgOv0AsesvotYtiZoe5xSqwJ+QXtVESHDvDsM
	 BEHvRy+nrwxAsQmJSpD9HnMUlvXjBbIZmBgK4LNpz2U5uroHNIVUorMyMWpBuMqTmHA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=QoQgSM7k;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.54
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F072606A886
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 00:43:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F072606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=QoQgSM7k
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-48eee44b908so264819fac.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 16:43:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794962586; cv=none;
        d=google.com; s=arc-20260327;
        b=RD1ZUJOu7di2+t2ixKwnjumIrr5hooVnL96ebtKTedbl2N4LX0vjAbdg3iUvJFhQsT
         xveUqvYqnN5E5qihA18lQJATIG+PuDQu0Got8GszBebNd7AexFKTs5q7JuOqO5Q6ia9P
         utvOMFrXVLt+GGlhmmO4PnIIvoGAFvUF3VXZs0TA8/dMbB9JX6pY6EdNDzqr6aKtVtpa
         UZEOVAq79k618f2BGhgE5bs8LBeklJHHloEZoTyzGbvHppn0QGpWkwXiUCssr9lMuOrp
         bKXbLhFWyr2oCT8YyWYT9vl3xnUPkE89bYTFioxtwHmvMYSdEFcApD7aOJoqfSbOvFtt
         /YIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=puGtQjs5QpcXV8o0ei3pWVAJkBqePYnUROGDguXC5No=;
        fh=SCPCvGrDnObqt2tUXLsqnp05PlBxlEwB244ee2Hev3g=;
        b=VQJBx/xBWJOP2zhL3kWxtvWehPsZf+hG31iuE6w6HYQOKdptflYnk1V5YL8UEsVHl/
         Cl2l8bB2St1plzNeuOPz9owNekWa/RJYSo7VQQKMy5q+yjlc5TzhmQCfEHHK0cW1KvxG
         AOpL8yJvhPu7JFen2wJe6TnB7tMVjXQHZMXmY2yXRLgr8gYn/jcdX0QEX0RWm4fFV6bN
         eal+5FR0LdjMXnZ/JI6fVWRgGbSzfc9LO1jEFeTtwlWrxdyHH9+8ylG/uf0969R565Sf
         m/KH4wGALVHs9+r8dJL6qBSUzmJX6EyEL1nMdgeR38Qr8FC5ZEUTLkOcajJFqPjReYiN
         PWMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1794962586; x=1795567386; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=puGtQjs5QpcXV8o0ei3pWVAJkBqePYnUROGDguXC5No=;
        b=QoQgSM7knlmQduEbalOghi/sOtbUt1RV5d9sPkjYyyVMIE6R1Kp7b4wimTkhe2Yx9I
         bQMdOzdqMed+XivU6bq71iIaeaVoVc7sZyWfap2u6yi7mll11YX8P49J3lvA0YXdc+nX
         ZTDSbaBadvIpnnxmFa+Tri/OuLybsQtUe8BaIEz6Et+INEWS1J9mO6tqyrP5pRBfS2ys
         K8BEF2IqiQQrqxBY/1lNDNLhABCxpAGq06QUY+MXEHZICS9TzjnYQKppfWjSpaRhGIBF
         ogBWvrfRSzVZPHTPGNTRNdjyZ58WBn0UWOcANINrg0lCJV4LPen6qxERF29IH31qzMuS
         ngZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794962586; x=1795567386;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=puGtQjs5QpcXV8o0ei3pWVAJkBqePYnUROGDguXC5No=;
        b=y3mUqNlYpwLJk2wshS0iR90KUHwO1FyJL/xK0G6eA6+Fa4zEFhm6aKflW2BwL1Wwpg
         fVmo0H5zGZYnHbvbeZ1IfeVZfbvucgWTGkJYsXULsr4Zs68LUWHbUiv6KtvjVj4O3JNO
         bN1SxJ4iu8CwSRw0v0DbhbCSNKU32BZTuFBi5RCY50cYM/EQgISMwcjhn2vejFWMIJKs
         90kmWASQ+dCvVrJMG9rBvzu+bTEfh/lLFv95YQDo//6EEHNunTeGxcZaaviRNQGIoeY3
         1tzoFz/St/T38prPfZif3tZB7TTvn2SPaXEBDN/5bJThMolWNI+gnfK/MA3sjixS5Jzj
         UaaA==
X-Forwarded-Encrypted: i=1; AL+hErFTkgBIvxKVJtSp7t8QenPSyEa9GdRR5/e2La0HLp44FYiGiHZ3wZfFY88t0WCvBsTAeXw=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1cy6SXeE/iJZsDG9a32dXu2PtilZyro+tM2RlUGTG0tNl6iV0
	BM62w0cCR6pwD8qKBgeS0HUsNVhmyhMAZ+X/AalaJs2Reitl+92h20eBe4IVeXMJPvK2Nku4EDF
	1V9mi/mIi4hbO8eCGG+pjMMz7HeAn9QP2UnjhPnnUwA==
X-Gm-Gg: AYBFou1kSYqocl1IaRFeHKUqGy6nA637tp93Ytq91GSi9qqeEsK5BtFylmHPWu5K1xZ
	ToqFEL9drc4Q6R7LGXqE1X4mjEeBN+T+JqNgzHqbfh4BMfiFQzAm2FusEvQgXDYvHWrvhoJQ2jl
	xRlSMWv9Lh7UvYEGrM5EKocL6crEsF3c24tlaGRPPQqsInzRcIa38PYqmKoFc82nhnqInuKvjXi
	Tv8B9CUYsxpzRtnqhSZWzu+rd0/X0RB/hiTpnpwOp3ibcbp7lAmEKeQFmFmDWCQgunLILfVrgp8
	KAK8JkGevdh5v0EITeE4GkTgOSug4azE7fCqRWkhkqymIl3l/NWFMbaqIjqMaK+4U3Rb6XTmG4Z
	UdP0bsELnSM/Y/q+0RiizG2jaGqfYFdxOxUcAMiPJRqq1SSFAmlB6xiqiqPJzWO19vDszQnTrJy
	dk0wet8nrKGA==
X-Received: by 2002:a05:6871:b11:b0:491:47e1:6280 with SMTP id
 586e51a60fabf-4b75bb74ec7mr770348fac.15.1794962586147; Tue, 17 Nov 2026
 16:43:06 -0800 (PST)
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
 <20261116142710.347e8571@kernel.org> <CAG4wq-cDYa2GkpWSYeOLwEPv45BtucZk+r=N2b1Srd=gUUO4MQ@mail.gmail.com>
 <20261117161856.6f6c2ce9@kernel.org>
In-Reply-To: <20261117161856.6f6c2ce9@kernel.org>
From: Tianyi Gao <tianyi@cloudflare.com>
Date: Wed, 18 Nov 2026 00:42:55 +0000
X-Gm-Features: Aa3M54r-Qn1bATmm01-LGWkLr4tuoSPVNlK5FfS3xcLFtqloul4EQ0s5CX5Sq4I
Message-ID: <CAG4wq-cQVUJgizeowhr4s4Z2Q_o0_dWfAwzXthpBATBB-7edLQ@mail.gmail.com>
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

Hi Jakub,

Thank you so much. I am really grateful for your comments, and for
spelling out your views on this problem. I learnt a lot.

I would like to share how I see the problem. I understand that you
want the setters to mirror the existing getters, so that the metadata
stays with the driver. But I see a fundamental mismatch between
reading and writing the RX metadata:

- To read it, we must go through the driver callbacks, because each
  driver keeps it in its own descriptor format.

- To write it, the target is always the xdp_frame or the skb, and
  both are the same for every driver.

So to me it is natural to set it all at once in one helper function.
This also makes it much easier to support a new driver than
implementing three callbacks in each one.

Overall, I feel this has turned into a deeper difference in design
direction. The same question has come up in several earlier series
too. I will discuss it with Jesper, and we will come back to this in
the near future.

Thanks,
Tianyi
