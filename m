Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3963D75D3
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 16:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308268; cv=none; b=I/W/67H6NLakgwYHxV0wPLyGSzdGwR4L0bjXp4FeClswMz8mGvc77h7f8/Qu8VXdDbG7kVKVBYMRceXHjIfd9w4ZZvOf8QKcCiqGrg08Nd9I3Bdbu71T6VPHVVsF4EZ4I1oz39MQT0VP4vkC2IEni0dd0Wr8e1kTrmYUQ65cehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308268; c=relaxed/simple;
	bh=/5B+nT+VII1QG+UPQ34825UPZg9p6CaGmiyrAbPurII=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IuKCzotnr1iBgnIYW9hqIVHdW3VyPzjyuHUdtK+1W/tAVeR2frkTVmp9tY5WDEyMnpW+wYNX0Ct/S815N+oEW9HSd5NcHA7x+xtCfAajDlqXO/S/Cf0Soa/fkfQVBFIGNZowflzYKfwrN/npczeomx/FT8Ewuyy6EbTFIuOoTtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iqi/kphS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iqi/kphS"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4852b81c73aso87498465e9.3
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 09:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777308264; x=1777913064; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=XOemiNyVqs+ekn52g39qizfmeGZs2CUhA5GCh2RWNnM=;
        b=iqi/kphSWmO2qoTCFFU0/1e05IAzGTRy9If8eZAb9htJebF55fjqvBDoGxjr7Yx3NZ
         NUHFXconHXaGEfXVQzWMJUvLnrT0qKeJDt1i8+1xZmWf5Ac6OdRPUTi/Z6NBwSvdekPA
         BVtvGx7Ae0pVCHhiN7QTtTxrvwmUwpvOVlq5HsxSQsucx7omMbLI9bLfIvdZmtCC17qZ
         Ts2VMzy7Pvk11p7nFOxTs+toicpKpvhRDX++7hZ4o2fN5hytKfI2dw8dHewN5Mb+yiT0
         of6moaamqh+QWglZXpw82vq6vrEdbbPkv36FRDJdn4OLg0OansD+3ucKJ8Z5O7jHkkcD
         gYVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777308264; x=1777913064;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XOemiNyVqs+ekn52g39qizfmeGZs2CUhA5GCh2RWNnM=;
        b=Fe83hhVHFOi7+HQl2AeBXwCOXMIyfxMIkIxtoUKm3KoG4kZ3dMnW4Vt9rH1facYv8V
         jAmKqgEpie86T7QMOwH3Mnwjp97XY+yZThnSgsDC34o9LBW49Xg20chyyLIINUBMu0dA
         zHXCiEp2Gjt1C1qUONyDH4dv5FlQysbt1WtVfljRC4As5cSRjWGd7zDWFwhfvJEBjIWm
         4ZVLCOJ2K6VV7oU75lkWojbH5luW2VysJHOja8qRNwUB4gqd6HVKERSyMz6KtS5ozvQu
         6QwASItMVNdP0axAHYIo/0XmcRTuW93HPvlf4mKRjHUZd0K32F4USC/fYZeu1J6hrZa4
         l6QQ==
X-Forwarded-Encrypted: i=1; AFNElJ85fgk5LLSCHyjUjgBKeUrBnzicCf2HK7QpsmhaerP+aNG5rER+rGqWNLhpuFif1MvMZbE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCnOcpH59QbigI7uq6ooK/1hUBlv4ztTMZaYd3gNfriwLuKl0z
	gTAhk6YFoNUcUWPGpHplqzbTKFUAThSrRSlVJ5By+mU1k6EquQIXKGlr
X-Gm-Gg: AeBDies+MSjnQpKmd+H/SYCSa/beLMwaK5Qyexg2qas1zAoKQua4saN90NancyDKifN
	FxxuSoqcg/OApiCAI8qjz8qmbeXbT18kOruyRqVwjZgiDBKAQYWdscJR1uDZ2/aK/htbuByp23T
	6SqjzCOqbBvIvlYFVhFNHO/NqBZVfi+lZCFE7ZnC1OJYVO+bS/lFsFkETpW4bbQ/82jgs/j4cXG
	yTaJ5Tzb+pzDveVFY2BO1qxSFdN+JV4iM3IWPyuFiKjk7vSkEwx142CYfIT8i5g5sbZ1NpavEV3
	MrRuq0D6UQShkfwskzq/PC/4I+4/rJ8dtZseA+CebCJG/BJhl8heOEerMaxnSQb4z5GiJpyFarW
	Z2oiSbdMvSPg7nWvTBq9eC3mTx/UANkb5v0lMSSLr5fkCd0mXfeyHx5hu2NgUL1+/YhkIho6KCV
	hfr7xdF7jRp3m8qYhgDbToGsL3jEZxkQ21gKLmwUZD/1I4lVUC7wVvd9XqFwTAf0cK8Yh1yJjHO
	HMaY2ZcB4HXztNUee4=
X-Received: by 2002:a05:600c:c4a6:b0:489:1f08:91b with SMTP id 5b1f17b1804b1-48a76f7b485mr1693265e9.16.1777308264351;
        Mon, 27 Apr 2026 09:44:24 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:1126:4:e3bd:e018:b2be:4bf5? ([2620:10d:c092:500::4:2374])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a773ba261sm647015e9.8.2026.04.27.09.44.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 09:44:23 -0700 (PDT)
Message-ID: <686d51d3081a3c34ce644ac6d52c8b8e41864192.camel@gmail.com>
Subject: Re: [PATCH bpf-next] Fix undefined symbol references for module
 build post cnum changes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, 	bpf@vger.kernel.org, Kaitao Cheng <pilgrimtao@gmail.com>
Date: Mon, 27 Apr 2026 09:44:22 -0700
In-Reply-To: <20260427112205.1346733-1-alan.maguire@oracle.com>
References: <20260427112205.1346733-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-04-27 at 12:22 +0100, Alan Maguire wrote:
> Seeing the following on bpf-next:
>=20
>  DESCEND objtool
>   DESCEND bpf/resolve_btfids
>   INSTALL libsubcmd_headers
>   INSTALL libsubcmd_headers
>   MODPOST Module.symvers
> ERROR: modpost: "cnum64_umin" [drivers/net/ethernet/netronome/nfp/nfp.ko]=
 undefined!
> ERROR: modpost: "cnum64_umax" [drivers/net/ethernet/netronome/nfp/nfp.ko]=
 undefined!
> make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> make[1]: *** [bpf-next/Makefile:2089: modpost] Error 2
> make: *** [Makefile:248: __sub-make] Error 2
>=20
> Further investigation suggests nfp indeed does pull in those symbols,
> likely due to references in include/linux/bpf_verifier.h:
>=20
> static inline s64 reg_smax(const struct bpf_reg_state *reg)
> {
>         return cnum64_smax(reg->r64);
> }
>=20
> static inline u64 reg_umin(const struct bpf_reg_state *reg)
> {
>         return cnum64_umin(reg->r64);
> }
>=20
> ...
>=20
> Export symbols for these references.
>=20
> Reported-by: Kaitao Cheng <pilgrimtao@gmail.com>
> Fixes: bbc631085503 ("bpf: replace min/max fields with struct cnum{32,64}=
")
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---

Hi Alan,

thank you for the fix, apologies for breaking this.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
