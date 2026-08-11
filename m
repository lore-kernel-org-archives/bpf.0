Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A73C41A77C
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 09:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440398; cv=none; b=VUWHO6Nf9d9bAC0XXDJoUgJlOAhnhtYLz7VnUrfU5dWwLoyHAdtLNwYR0YpJ9wf78jO5y9iBQiiOCVfTMs12bLU/XzPlMxwprtJpKrETnoYF2OSUPPnf9CZ76p3JU8UUEmz3cSsl1e1sYVX0BUMQz89RRsYuK8/e40+tp84ZZm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440398; c=relaxed/simple;
	bh=ye1JmpnFsah0nMZAa2/YoN3aVc8Jj1wDHPpkwuj/9P8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e6gbT+mhImUHAPjnTk7xabODLoZ7dje3bhBxLZ3xyboBGHHmoRgasYtYZPKUeAinynUoyxCVFKxk9rVjpNbc2VVXHmHikus5NM1qw+ABKhDsZiTlSDgP60TxpsZgkKfJ1YxYmUUnvJ/NTDpX2neJH7sp/ACBak4aXDG6T9dHvFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mEsAkk+g; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mEsAkk+g"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84eb992a881so2118331b3a.2
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 02:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440397; x=1787045197; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ye1JmpnFsah0nMZAa2/YoN3aVc8Jj1wDHPpkwuj/9P8=;
        b=mEsAkk+gp5Bxwj/guF1sQeqO4DPhHWWYsXf2axFe/m/17JjlpofWn8dHAkrvpw1izA
         P3kA64bO3zwQr/gwkt0ZN9SB9alWAd9y+ceHnjd5WiZGA59sefJIFQ4bwTKuyrghgC3N
         hhoQm9iTEouF/EP67+NAfLXY7VwfO2MGqM79Q/N6vtaX5ctOiYjG1ERf3PqCx+1UJz8Q
         gy5kqpWdEfR7Jd0Yyu3RPtfjye/EKCg+NC76IlPbcGnBfVMm3IJJsj/iWHiMHBSYw87u
         O3sAUqp4hJAWR90T6uDRN7yuLB58h5i79N2B/z6y8se9mK2i/PIhB4DJRu3zU9ebJWqe
         HIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440397; x=1787045197;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ye1JmpnFsah0nMZAa2/YoN3aVc8Jj1wDHPpkwuj/9P8=;
        b=FKlytMd13zUpfbvecQPciMBhwXSwHXhZTrnHosZld9USEVRIdPa6QtP5bbcvYZvI08
         ySLJywOQNdWJmnFPWIWIHjYpjpoSy15cOeGqEjQ1cjg+037uavaEtBriRsb0H1Gbjkcv
         OnNFWN2ShhJId8Li7IX8EJReR/ut7U1+UKQNawndDjeRiereyGEoM5WKcTxneWTHmkJj
         BlH5H0WvWnE8LUNq5L0C/aP/3I3LcWjdstmE3U9TkKLqSSmReTZh2mVKUEgX/YoN0G4n
         KiKJV7WjsaoLBn+9A2CC4pDKqzJqs3c41rdRtM4K6yb0WV7fv2NeZ/cF//NnN5d+4dRs
         t79A==
X-Forwarded-Encrypted: i=1; AHgh+RqPqZzeV9cxpq3qPr8n4ihNu4rdOIcxDhjy0lCQB9bRvlUCJt8Ok+moCg+wK1ubBTaaSlo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwlReXwvH8ccFCNCld4a8VjcpuxpZT1hTBTFW/JLAZu3NSEoZB
	IvblKe8GBt82AyAODry5iR7sdWsqJ75dewtGEgKjrQU0pYoQ4fh2Ph00
X-Gm-Gg: AR+sD11cZe1ErLIF4SFJvlSb28baQY/wEtUN0OmW2lc873uDqQSqIP24MA29ZPGy3EY
	ca/bpigFTvIucbGNzIEumBXgOa9E0+2ZlgshvPRxoNTc80gUVFYIwp1XbKU/e8F3NQ8wWwWrxPk
	+M+FmyjR+MMVasLIgeJWDwxlfNK9CC/TEbxJ2xok6slYIjvuK6GQatNjcNkL/T1t4Hvbpzol5Tx
	cfam7kpmZLop71iSwvgnI25YIEYcUK8Ggh/dg4yXlLovhwqif/kWkylxDtkvR4PT+MgEa0E6Zt5
	7mdU9T53wmg4MSfdItRDegSMI8/pwQ7o3BjJSxtazROYAQwmnrCr6L5MBVLs7/PkJiVyF/fGQfD
	ZK/3j8mKFfwlzExE+4dVgQpaIdX1+i1Zv/5v5wizvmGfGPbo9i6xsl/9YylNEzHvZMLpp+pDo3F
	jAie+8u+JnHGOpr52iNNX8yVsv68r1yW1gd0jJftIqi97DK7CW2rxMoqT7VRzy9CfkiZPlpFUxA
	jf/F1HCcf+AVMDY
X-Received: by 2002:a05:6a00:398c:b0:848:8445:6956 with SMTP id d2e1a72fcca58-84fa887879bmr1517446b3a.18.1786440396756;
        Tue, 11 Aug 2026 02:26:36 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fa91af9efsm409984b3a.13.2026.08.11.02.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:26:35 -0700 (PDT)
Message-ID: <e4fa5e33b9fcc4583b0ae37f430dd8753a70889c.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] bpf: Derive the atomic load register in
 one place
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, memxor@gmail.com
Cc: puranjay@kernel.org, bpf@vger.kernel.org
Date: Tue, 11 Aug 2026 02:26:32 -0700
In-Reply-To: <20260810221811.481040-1-daniel@iogearbox.net>
References: <20260810221811.481040-1-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-08-11 at 00:18 +0200, Daniel Borkmann wrote:
> check_atomic_rmw() open codes the mapping from a BPF_ATOMIC to the regist=
er
> it reads the old value into, the BPF_STX case of insn_def_regno() open co=
des
> the very same mapping a second time, and BPF JITs need it as well to know
> which register a faulting BPF_PROBE_ATOMIC has to clear. Having the
> derivations sit in different files is how the JITs came to disagree with
> the verifier in the first place. Add a small helper so that all of them c=
an
> share it. No functional change. The BPF_LOAD_ACQ case is there for the JI=
Ts,
> which do walk all instruction classes.
>=20
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
