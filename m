Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2C330F7F3
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 08:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773908317; cv=pass; b=BKVNTGYkGaJziu7jqeGDlzY5Jg+wzD6ynqPUjKYDPYea0m8TXVxmbGX+ftrC95G/zNO1wRVHTizPU+RsdX9YPF/YLX9ZIQcr/cSZEgJDxIuaQPlVZig03NJ63J+HmZH0EiDuxxA2aMza8qn8aXXcXjaN9LGaSXLuQmzb02dMc/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773908317; c=relaxed/simple;
	bh=2IHwFvo5ODXCF3BXenUGNRckEOwpm2xZLVmBrs8p8vI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FURtDGvd1Q6bGUpc4BlFOBujKjKa0U/6jwLxJ5nPaJgXluVz7dMeyIVCzLJkcXXExwDso578guXMSU+BBfOvTNicCuUUxNvd70Ut+VUV1LdrGkn6cMhs+d3zINaGBtKtt666559/SGh7qMIzgA8tZTj9X6mrJ1os23/Gc4XGuzs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XREMS2S2; arc=pass smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XREMS2S2"
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-439b9b190easo464098f8f.2
        for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 01:18:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773908314; cv=none;
        d=google.com; s=arc-20240605;
        b=dMKTr2yPyiJDEKC9f1JWOWfO3foV0PevfGaFbcbXpN1EesWsZ9iQBFkONcG6xjKWLl
         TmbRVNWuEOPb1hS66cEbj+APowmCFIaNM3+6XfXD5jU9Aus18ULawjkGvhJgJzjSmdjL
         UNZnUY30MH4VXX1WPmdDeekr8F52soogzZd10bZuAgZrA+hXgfHefpWK3ifyI5Up8rzM
         gsDy7VMnxMK4GZjYPV6n/GeiAwjoKmwnbV1ytmXoiwWdre/gmo2Ti0jhzp55aVhDBYe6
         SdDiwpfpCX6CEtnQJ78iGfsnybqjAxkomqUo0qfw4ZaXHuTWalpdYyGkbVg58CAiXc3i
         lHjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dMea0cLcR+bq5eog5HCdmyyYrMoP2dhwrdfoT+SDABU=;
        fh=1xipXt001SbTq83vS3Dyn4fOtCA8egZMqbbldN+8+B4=;
        b=DSwctFxvNbfhGCbGpD37XKHAvUysmRhj1eQdeDrd/ju2KOtdEWsqCWmeHe77eDzBLp
         eUtyjHh+Vrr8Q3PRruyW32QPdFH1pJ1X3655JDv79vVrMjHBQmnZOZ7h9rJ3aY7IQjgC
         /RtSAtf8V60DF2RDCtLKpQWGbktFf0/eoXTXekeaNHDnhzSi3UPb3zwrF/x+8ywulGG4
         oKP5PHK32AFxjF5Ewhr6jzhqHQAmhl3iCMNT7E/5D/Z2GxUd2wGMtE8qCuU6CcjJ6xl2
         lFcPCiN5usK97B1jipAi14waOl4FkgfaEJoTMHEEYWwHLeugh7TBRPwKfdif7Maep8Ah
         vNiw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773908314; x=1774513114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dMea0cLcR+bq5eog5HCdmyyYrMoP2dhwrdfoT+SDABU=;
        b=XREMS2S2w9qSCCDwghah+TIz9RKTxaHO98j4tlY1tv1YUJI8Zd7gve7lEqSNhW1kd+
         i3OEh1K5sn+ADtO2n+uiy5K8FrCYpYPx/lbFxbyp0Ns96jUx8SgoXx6MgIqVPgcpVIqW
         dIWLlgcEZ0ufXRgMA7tLNqLptPz561ksmuoKeuOqHkhLvl+As3IvBVOfHLe7qCiY8Z5m
         AoTcEhU/9Qz2vIKIfzSQX/sJ8s6CM5us6GVrKXb7oDqwrSVPbiN5/guykcjCtBRIbOwb
         n0YysDkapqxruA1xQ48z9CfbfE1ZQG4z6ROfq2vyrhcU8irBPlH9blj36owwA2ielEkB
         Yl9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773908314; x=1774513114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dMea0cLcR+bq5eog5HCdmyyYrMoP2dhwrdfoT+SDABU=;
        b=KdOC89MIHUfhsmG5Ef8JfEgFuHr13DprKHEOa1gqc5bzDnwrS9HiY1cicW7OvGrY2y
         RSdtsCkvDc+pIKHfuAgwnEN0PYQPwyo9x7CtyrYbBiCm3EANVDKnkCOKG2Uuihb+C1tK
         ucnDBX6N80hopVRii0CAJda4YUON2p3lMkdFudJjW7jykPVjkC+lJvavw2ZGH6rAZjuU
         ZYUWMKA0Ew7583qLpZT3PZTSMwH3+SNK48/u4U+huV5JgJ4/Cq/Fn7VFQA6ZwvdcFcQP
         YFBEwWLR6n2FxFku5dyrqHn8Df4aVO+wCYOxjX/e6O8nrGs/JIPGWEatGm0hUOYqE5NG
         id8Q==
X-Gm-Message-State: AOJu0YwLmvBoewY8QIFHuJt8y45sp3QTM348bzZ/mmnL0SADTTsgZEL3
	dgP1GppEnbvCvDIn3S/Yf9snSuIy+V21w777q/rQej9CVp1mx5BoIEpe1n9ep3cHhh9eeDANorZ
	fDjPHG+oz0twiOsBHdbojZKMzlSByesw=
X-Gm-Gg: ATEYQzyC2ctP9UmgL+RPMG3PHh2zDhmZAOHXXEOhb1UvM81qITIZXHY9G7V1ETHvTYb
	F0+vwasAuzK0K4ovi6eLck9LMrfLIcyThw6CtyR7Fd4yCaYabIfwGBdRo32RmGZkgofZ7McLYFF
	i7atJ8/JWw2beuf3sHFllYfgEyEEUBfG5qU7fR35Ko/D3uG4T3ZkNUUT3Cp+6OD566w25GzweBY
	2xV/BPpdaB2RWQFNcFFBO9EyxM4ar/uGc8UNdZ56PhziEowdN298+5bN57W8iLjYWRi2odzM8rK
	kNlyDi0xUXZNqb4h6k2BJuwGCxa/ZSX/cnvqMX13xYC0gPFojJsjbu2JN4k=
X-Received: by 2002:a05:6000:40de:b0:439:b539:787 with SMTP id
 ffacd0b85a97d-43b527cb618mr10783071f8f.53.1773908314296; Thu, 19 Mar 2026
 01:18:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318171906.53174-1-hao.sun@inf.ethz.ch>
In-Reply-To: <20260318171906.53174-1-hao.sun@inf.ethz.ch>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Thu, 19 Mar 2026 09:17:57 +0100
X-Gm-Features: AaiRm51-tJU74sOhTPntFT5FV2BpzFD1DObR_ht9yd2vcBKJ2DdmBO-j1OTtQuM
Message-ID: <CAP01T76ZazpBriekA+82aAFHKSoa+XvnvOOnQRz3XBTvBErygg@mail.gmail.com>
Subject: Re: [PATCH] bpf: Simplify tnum_step()
To: Hao Sun <sunhao.th@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, john.fastabend@gmail.com, 
	martin.lau@linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Mar 2026 at 19:21, Hao Sun <sunhao.th@gmail.com> wrote:
>
> Simplify tnum_step() from a 10-variable algorithm into a straight
> line sequence of bitwise operations.
>
> tnum_step(): Given a tnum `(tval, tmask)` where `tval & tmask =3D=3D 0`,
> and a value `z` with `tval =E2=89=A4 z < (tval | tmask)`, find the smalle=
st
> `r > z`, a tnum-satisfying value, i.e., `r & ~tmask =3D=3D tval`.
>
> Every tnum-satisfying value has the form tval | s where s is a subset
> of tmask bits (s & ~tmask =3D=3D 0).  Since tval and tmask are disjoint:
>
>     tval | s  =3D  tval + s
>
> Similarly z =3D tval + d where d =3D z - tval, so r > z becomes:
>
>     tval + s  >  tval + d
>     s > d
>
> The problem reduces to: find the smallest s, a subset of tmask, such
> that s > d.
>
> Notice that `s` must be a subset of tmask, the problem now is simplified.
>
> The mask bits of `d` form a "counter" that we want to increment by one,
> but the counter has gaps at the fixed-bit positions.  A normal +1 would
> stop at the first 0-bit it meets; we need it to skip over fixed-bit
> gaps and land on the next mask bit.
>
> Step 1 -- plug the gaps:
>
>     d | carry_mask | ~tmask
>
>   - ~tmask fills all fixed-bit positions with 1.
>   - carry_mask =3D (1 << fls64(d & ~tmask)) - 1 fills all positions
>     (including mask positions) below the highest non-mask bit of d.
>
> After this, the only remaining 0s are mask bits above the highest
> non-mask bit of d where d is also 0 -- exactly the positions where
> the carry can validly land.
>
> Step 2 -- increment:
>
>     (d | carry_mask | ~tmask) + 1
>
> Adding 1 flips all trailing 1s to 0 and sets the first 0 to 1.  Since
> every gap has been plugged, that first 0 is guaranteed to be a mask bit
> above all non-mask bits of d.
>
> Step 3 -- mask:
>
>     ((d | carry_mask | ~tmask) + 1) & tmask
>
> Strip the scaffolding, keeping only mask bits.  Call the result inc.
>
> Step 4 -- result:
>
>     tval | inc
>
> Reattach the fixed bits.
>
> A simple 8-bit example:
>     tmask:        1  1  0  1  0  1  1  0
>     d:            1  0  1  0  0  0  1  0     (d =3D 162)
>                         ^
>                         non-mask 1 at bit 5
>
> With carry_mask =3D 0b00111111 (smeared from bit 5):
>
>     d|carry|~tm   1  0  1  1  1  1  1  1
>     + 1           1  1  0  0  0  0  0  0
>     & tmask       1  1  0  0  0  0  0  0
>
> The patch passes my local test: test_verifier, test_prog for
> `-t verifier` and `-t reg_bounds`.
>
> Signed-off-by: Hao Sun <hao.sun@inf.ethz.ch>
> ---
> The original algorithm is not intuitive to me, let me know if you
> spot any inconsistency.
>
> A Lean4 proof for the correctness of the algorithm is also available
> in case anyone is interested:
>         [1] https://pastebin.com/raw/czHKiyY0

IMO it is worth it to include this proof inline in the commit log,
since links are fragile.
It's not that big, and I think it's more useful to have it inline than not.

[...]
