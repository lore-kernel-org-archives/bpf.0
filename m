Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8F26339708
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 17:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309653; cv=none; b=WlSBFC0iwXBrbH0DxwGGCV8fmoEJRc0FQCvQivqrSMGIuI7pZi31FPOMU1+4+F4pl5FcGCoyF1cdVpgdNm9Bg24tVeR/vXO8LymlC/o3G8NxK9ix0prXibkeM1YLZIzhCtObck8CJv/4uDs4yA+X/t7mN37QTRRotEbMlMRB1O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309653; c=relaxed/simple;
	bh=qXdAmuNLkMFrxJCyc5B0BvupucBr98TCZNZoRCqVo7A=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZHQ1sc1v6mF+L83wFooN4zlyHGvUY7LntiinYO0yVj5SdJyey3vZ79F+FJOwMHRp+UL681QesPvZo+OZoo/ZOF7a+zQtCbuesQmdrigJfNRon2qDohu2iJNOTe4l0crJAsamns1LdxqsHfoxZ5bizL+1mMRwRAP6YNuTKeFoNgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pl0dm7MH; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pl0dm7MH"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ba5b107eaa2so1091596766b.3
        for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 10:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777309650; x=1777914450; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9/UY0hiI/oYEHW5Xi3D/aXPaJQhTIPC4knKGMmLIzWI=;
        b=Pl0dm7MHBPjoEy3ypeemBLjXFHoZeS75NGqTJpbCXU68Vo/w4GHUAfpniWd/knzBsp
         S2FQzkKObaTJX8WJbMYD97OEZgsjnbU2UIZQct1ETkvNw3fbmq+8/QqH5Nz1ZxYe53qT
         fyLvQW+XRvuXiNXvdImyK7c2NCqw5vrD2xiG3JaNZrVaaQi41CbspGbfVML3FBeQkqeI
         cTgKzA4eAQQaReSv2L8iNNf+Wl9JXl1a7ar+NYIUzG51URa3JmvLqfLrpQPLRnf0Xd8h
         rWmwGKTy0I6vQYZaOIYCZhsXGY+bIlp/8bgKisyblHyd5dWMxf4B1HbVN4zrxDOznUu/
         0R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777309650; x=1777914450;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9/UY0hiI/oYEHW5Xi3D/aXPaJQhTIPC4knKGMmLIzWI=;
        b=Cqiui+v2c6sgnmUlHkVehVxSrLjIhy7OxR48lBqdY4L5wX9YgpogMNKFP5aPzP3LcY
         dl6ty7p1vAIkal0o48k0vhOTNjqtFgNHTs/D6+1gHZ4gm+c1eUhoReP60p3PPQ0pB4+f
         0eogsHNHFwXCpWuveURMtzbTXay/+3PNAQsUfTtSufE5RPLiWqmJjyIw0qx4leI7JK4t
         lm83TNsW1yZqjQIL4hKxza442JtaHymUMqPKptMqwmiNnG2aYjvaosGMwZHPKk1RaGPf
         mxo1o6H6r6bRz4DzrdP+yTBEw/9nSfg/mTCLqcFgwQuZ7S44jbUGquPEdai5H5pKcOz0
         zotg==
X-Forwarded-Encrypted: i=1; AFNElJ9i/PMXhFvRFTD6JWbcOfuG6gumqP/n/Rn1o/jiOyQgsih1JHaYjBQ2J9dqSRsufY2tXIg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8jAhdPCAUatqZEUVahLr50lVzDdLpPIIbO0dIokQ8AARz0klP
	h6T9QeydDBQA4HeyLyR7Xl8zW3o4tiVzU/+ypq2aJB2EwHMm1kJuRAjV
X-Gm-Gg: AeBDievgLeippkhCWt9n/gWEzaQEIDcJBXkRSLw/R9rM0FytIQkNRtq7hkvS6clR632
	cBtDSaMkr/khsIVM8HcwqCZlwWNwUMEvUnYwkaBCnC5sMCO4noVd54JPRnVC+QjBzE7iVJs70Ar
	W5wiU9BFEmVFa2xT5f0QMXAqim8NndbYPNHidoxavZFar1ovx9Gsslrr5+XTWcczTYlFdLq+dCc
	W0/Wpg4e5T6xMpAWxEpR4OP3Kjhzymr0neNgnWXXfSse6TMCzYWtDUPAwYU5x4RP6izct7z0UY/
	j5Kcnc8pgfmjiDxYWMZ96B27lpyiWuuB/YluyxYaWezrT0vhX/SOOguP5GqTYLGbpCFAR0yLI2G
	gbjAyiJbalog8ptDy4uHvBSy/mpgTYr2FnIvAkSW5s8qY/6yUWcnBbcUG48dw8oA7xoPICszdWB
	6D4oqUqNgAlfu3ubIur6sH3yanHLtbkmxewNconArUPB6oabVrJNiKGNq288At+BxENnXoAlv56
	5LDDmTZ/VCut/U3xTcTX0/Kgaq5GQ==
X-Received: by 2002:a17:907:3f1d:b0:ba4:b8e6:74d4 with SMTP id a640c23a62f3a-ba4b8e67505mr2149668166b.46.1777309649895;
        Mon, 27 Apr 2026 10:07:29 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:1126:4:e3bd:e018:b2be:4bf5? ([2620:10d:c092:500::4:2374])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455533b79sm1149651366b.54.2026.04.27.10.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:07:29 -0700 (PDT)
Message-ID: <81b78478b1345151539578cd486b7c656249b441.camel@gmail.com>
Subject: Re: [PATCH bpf-next] Fix undefined symbol references for module
 build post cnum changes
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org
Cc: daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, 	bpf@vger.kernel.org, Kaitao Cheng <pilgrimtao@gmail.com>
Date: Mon, 27 Apr 2026 10:07:28 -0700
In-Reply-To: <686d51d3081a3c34ce644ac6d52c8b8e41864192.camel@gmail.com>
References: <20260427112205.1346733-1-alan.maguire@oracle.com>
	 <686d51d3081a3c34ce644ac6d52c8b8e41864192.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2026-04-27 at 09:44 -0700, Eduard Zingerman wrote:
> On Mon, 2026-04-27 at 12:22 +0100, Alan Maguire wrote:
> > Seeing the following on bpf-next:
> >=20
> >  DESCEND objtool
> >   DESCEND bpf/resolve_btfids
> >   INSTALL libsubcmd_headers
> >   INSTALL libsubcmd_headers
> >   MODPOST Module.symvers
> > ERROR: modpost: "cnum64_umin" [drivers/net/ethernet/netronome/nfp/nfp.k=
o] undefined!
> > ERROR: modpost: "cnum64_umax" [drivers/net/ethernet/netronome/nfp/nfp.k=
o] undefined!
> > make[2]: *** [scripts/Makefile.modpost:147: Module.symvers] Error 1
> > make[1]: *** [bpf-next/Makefile:2089: modpost] Error 2
> > make: *** [Makefile:248: __sub-make] Error 2
> >=20
> > Further investigation suggests nfp indeed does pull in those symbols,
> > likely due to references in include/linux/bpf_verifier.h:
> >=20
> > static inline s64 reg_smax(const struct bpf_reg_state *reg)
> > {
> >         return cnum64_smax(reg->r64);
> > }
> >=20
> > static inline u64 reg_umin(const struct bpf_reg_state *reg)
> > {
> >         return cnum64_umin(reg->r64);
> > }
> >=20
> > ...
> >=20
> > Export symbols for these references.
> >=20
> > Reported-by: Kaitao Cheng <pilgrimtao@gmail.com>
> > Fixes: bbc631085503 ("bpf: replace min/max fields with struct cnum{32,6=
4}")
> > Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> > ---
>=20
> Hi Alan,
>=20
> thank you for the fix, apologies for breaking this.
>=20
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>

However, Alexei raises a valid question.
Netronome code uses the following accessors:
- cnum{32,64}_reg_umin
- cnum{32,64}_reg_umax

However, this patch also exports the following on top:
- cnum{32,64}_from_{urange,srange}
- cnum{32,64}_reg_smin
- cnum{32,64}_reg_smax

Why export extra accessors?
