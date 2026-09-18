Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com [74.125.227.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94620293B75
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 20:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764709; cv=none; b=RFrH983iydQ1B0OvYj3t6bYDvq8Xf7NNa62wOJKz0xW5W8Cs5NTj6yaK48n9zNZUC7QYadChO5FZVpkYqRfPpPkFoV5skIAnZHXQN/LWIj2iJWhY8O6rzYiLGI0NIqnDug/DyuVtNUoCdfcUPnIbV7MH78b+Cj9YEKrQhZwlR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764709; c=relaxed/simple;
	bh=wbZQhcIGoq0h8i7KnrViZ2kPef4WkeFevZuXMt2Aqfw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DGdxzHefnQv8F0fKLKo1yi6tSB9JpAN0Xgpe73SypPH79icA+eVX4Wtq5FPau69PsIpdi0rqKo3E2H0fXBSxj1TGMQLaWT2jMv4URl2bluKkm8DWHjbn+Nz6JMvgMuKgXBGUuW29856TCoD7jFyMoXtQXrx0bFVwY+UpTPYmrl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHFFRPLr; arc=none smtp.client-ip=74.125.227.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHFFRPLr"
Received: by mail-pj2-f42.google.com with SMTP id 98e67ed59e1d1-396ccb65437so1020124a91.3
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 13:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789764708; x=1790369508; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=gko2vylYqR00Csv8Fc2JzTwZ9rPFN1mTwkGy+0pSt1k=;
        b=PHFFRPLr/58/5w0cyD8SkP3Uc9zy8Wj+qbCbVlvlc1LG0LzCGnPCckLRQ3GsBf2ZJ1
         odi2jyjHSyplJ/lWczBdMkT+mnBTrRya6Sm3umodMmO1fIA7R2yIJcKh6z2YCOORcVDo
         DBPvFEF1Epg1RWSYWNH95B7p8oDUPap2rMlJjBexI4IFi1R2QNr91Mi6fxT23r+A1jDP
         83YpQmgryjUmB4x3IeI5nPiUo91XEcKZnL31yBa0aglF8m5MeaOi2flvDZW6SQ8oRdDE
         RiD2Ro00ArtXYz1gfwXyba2tlTdkRTze+spZQV1X+GeFbRFNjGBXakyhUDw4CCOYSaIa
         Dv5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789764708; x=1790369508;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gko2vylYqR00Csv8Fc2JzTwZ9rPFN1mTwkGy+0pSt1k=;
        b=1N6IS18MTr9aMeHH/F91yuPlfa2jXsHkXZelJnwl6J0cBFqqwo42RicupVBczusupF
         wauvAT3GVmpcQ7bBuVfFrn2Zvuy4cO8Z+6l3lGj2MZK+uN5mDqLb7QpFuy+NBf1ok1i7
         e93o65jBr8oESdxb5mjHUFmXH84uIkNXKKNUb4Uc9s6Je1J8+GwYXqz0KWwMjVXqt3Dk
         YV4NridQ55DOUzQf6i/rUuyHxn0JdCMzkikZ1TYPcrYDavGa871H3VoFqtLQ8RiMXzcK
         G4MU78eVs41yUQHC5jSwwFJK+29wilgHmEDkPqrsZ8pudQi17obqyQuzlD6QKAK4oOft
         CKyQ==
X-Forwarded-Encrypted: i=1; AKwUvBxGwJ35jRjZb7FZVNvplBU3dAdMQtLxnA0qMTwdaoty10poz232ceW0EXXzwECjoaVCd/0=@vger.kernel.org
X-Gm-Message-State: AFuF++l072yKy7JR84xN2ENGBhaJU24Mv+1iVZUbn7OKuMRcUdtR1bWM
	Ra/MHPaQpifaEJX8oq60Q+Ww61ZAuQkGYQWpdKKoK26UFQfJte4vTvah
X-Gm-Gg: AYBFou11Zv+zAXp/bPdggL9kHdKxxCT9B6Ilf0tHqBcVw4Q6uZWypItM+BlMrEkr7Sg
	Ewtk0dLdy0j15MkqtwLfFxjUfRTPTvXTZzjbmr+KzUfUBReE7EM9Mrfxt5RmPE9D9PZPhIVPcsI
	I91Wc9A9JHqbbCZ1oX2wzeBw+kKi67KkkwStX6ARDh2dkOuJ11Vfujl4DCfaiyzBKmqdk+eCuLs
	ayJMxK9O0QBhHbCPLdOMPVoGowlMsnQ9ZxGDFv8Yf5ZJGZc8NjZeuRLAzcgHMOti1WW7lWbMXYB
	9Aezivu2XUXmFhJ+QlFxDnZN6rik8eP+2ymL9gixXdsHNJVZD4dvxfREu8FlqAWyIaqCHk0SPg+
	agZoSNRfiwipt/eJOWa/U1m7zgsFOitteKSN+OBxEwTwD8lDIsFXIsjj88dZlfeBFS4Ml5/Oihm
	DmWUe0bkfOicqizE7vPhhvmHBjwJxT5WJ7czVIOTvlnM5emFA1tBjav+xgGgOFjn35NPcw3HhjQ
	KK5hAv/oxFkNso+KO84U3AVyrGevicw1DF2gRMoahz+He7/UuG9NuqyYg==
X-Received: by 2002:a17:90b:1cc4:b0:39d:f351:8f0c with SMTP id 98e67ed59e1d1-39e54dcb193mr7567505a91.13.1789764707859;
        Fri, 18 Sep 2026 13:51:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:e136:8952:772a:93a4? ([2620:10d:c090:500::4:e681])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144d55bfec0sm1309886c88.7.2026.09.18.13.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 13:51:47 -0700 (PDT)
Message-ID: <a53eaf9758d1110ad7a2211b55533ffd470e083f.camel@gmail.com>
Subject: Re: [PATCH v3 bpf-next 09/11] bpftool: Add ability to dump
 LOC_PARAM, LOC_PROTO and LOCSEC
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
 andrii@kernel.org, 	jolsa@kernel.org
Cc: daniel@iogearbox.net, ihor.solodrai@linux.dev, yonghong.song@linux.dev, 
	song@kernel.org, qmo@kernel.org, martin.lau@linux.dev, memxor@gmail.com, 
	emil@etsalapatis.com, bpf@vger.kernel.org, nsc@kernel.org,
 puranjay@kernel.org, 	yatsenko@meta.com
Date: Fri, 18 Sep 2026 13:51:45 -0700
In-Reply-To: <20260916074118.1007116-10-alan.maguire@oracle.com>
References: <20260916074118.1007116-1-alan.maguire@oracle.com>
	 <20260916074118.1007116-10-alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-09-16 at 08:41 +0100, Alan Maguire wrote:

...

> +static void btf_loc_param_str(const struct btf_type *t, char *str, size_=
t sz)
> +{
> +	const struct btf_loc_param *p;
> +	__u32 i =3D 0, vlen;
> +	__u64 value;
> +	bool negative =3D false;
> +	char regs[32] =3D {};
> +	char num[32] =3D {};
> +	const char *op =3D "";
> +
> +	if (!t || !btf_is_loc_param(t)) {
> +		snprintf(str, sz, "<invalid>");
> +		return;
> +	}
> +
> +	p =3D btf_loc_param(t);
> +	vlen =3D btf_vlen(t);
> +
> +	if (p->flags & BTF_LOC_PARAM_REG) {
> +		__u32 nregs =3D (p->flags =3D=3D BTF_LOC_PARAM_REG) ? vlen : 1;
> +
> +		if (nregs > vlen) {
> +			snprintf(str, sz, "?");
> +			return;
> +		}
> +
> +		switch (nregs) {
> +		case 2:
> +			snprintf(regs, sizeof(regs), "r%u, r%u",
> +				 p->values[0], p->values[1]);

I agree with Jiri regarding the register names. It's not a huge table,
e.g. [1], 20 lines for x86 ~> 100-200 lines that would not really
change to handle all architectures that have BPF jits.
And it would be very convenient for those using the tool.

Also, it appears that simply enumerating all possible flag
combinations in a switch would make this function easier to audit for
not-handled expressions (like ADDR), or plainly reporting that the
flags are unknown for this version of the tool.

[1] https://github.com/eddyz87/inline-address-printer/blob/master/main.c#L1=
07

> +			break;
> +		case 1:
> +			snprintf(regs, sizeof(regs), "r%u", p->values[0]);
> +			break;
> +		default:
> +			snprintf(regs, sizeof(regs), "?");
> +			break;
> +		}
> +		i +=3D nregs;
> +	}
> +	if (p->flags & (BTF_LOC_PARAM_CONST|BTF_LOC_PARAM_OFFSET)) {

...
