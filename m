Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4F2E888C
	for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773251195; cv=pass; b=bVVbSOHmxnYYCJrkASzjNDq49xJvIcn59H7Df80Q9X4+KTs+3iyvaDDQ3u53uTATN48Vo4zfTJjblU8xrAch3sVk1ffGHxg5c4OLPi603vOBrMa4Rx/SDaAOAqoLPdTmPYbM31CfJLnAmXMZS6BZ6/ken4GQIr7kCRUtKHmNbkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773251195; c=relaxed/simple;
	bh=TONfdr6j71FOAqr/zbM5g7QJ2rc/2cpK3YNXNiUbP64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TK4U+hcyFGQIB3408jhZ9yZVsLJO2JaQsv+BRVkHCl5Zw3cKrzooH2EOddI8xNWxgXn1eA0Nw7dEU1EmaTDeoES8yLJadmQTYZ64O9xLjk9YUMFVtk3otJADokuT7nVWRzAODexG55HS1pcSIK8SheczIm1DuXNLGf0IWUFDTSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HGx18DzP; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HGx18DzP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ae41544dcfso2526935ad.1
        for <bpf@vger.kernel.org>; Wed, 11 Mar 2026 10:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773251193; cv=none;
        d=google.com; s=arc-20240605;
        b=gVdBmbnOXxUb7FEfsWyWhm7/Q0NNsCzurradfFEqTsRLFcvynvO0PDoAnTqENSNVI6
         JpWKglfXln0HUuDpV55naMDVbPz7EK4EpfD642a1yL4dhlkaqLANlauPEhH8IOjfANZL
         PvZdauzpI9WDHWVfxs1LmdK449gMXh8a6JcSZCFsGZVxfGkFz/m/sBzfAfFVLHc4/I1q
         rPRA5AeA49F4ftTFwC1om23RgoS/eAsgbw3HwRMzoFIENXtUa7c7N82JdiVyJpGg88e8
         AxDL6o+r3pFiLRa2IVuZ/vMAzrikXJboBdxttQhFvzX6I9maJnb+Fk8pM/hlZHdvu3n8
         UdjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yBbbl+rYtduCAT/2aKHMXzgEnUwE1s6H/CjLlVRuVSk=;
        fh=bPRD2D+Ioib8aw/IwFoejB/40t6vEb5mu+hlfnkbnuU=;
        b=StLenOGGIF6BMdAcjxFywqlTrfCEAmROSyphXLDtfMXQAZVb0LQ4Wj/Jr1gPa0Aaem
         go/U1iLX+rodk7KK6NebPE3fH8FAGghaF91uTdV/hHDs8XwFZ4z1tgMlmX1VsQHOFSor
         TF9cCcc3BsgEb5Jtlybr4sPu6xqDO9SWC5vXOjsCqitw9soBCLWYzmE2CuGvEtxL5ikF
         4a8MQHwNdycD/FhNhwpRl1Ht+NUR0fESGUZ5clp8Dvbi/WgaD2wWMl6GmqGVSaK/Xglg
         UyFbEXBNbW+3MrvJucN66amGZRgzHfEtOOVrDT2Gc4mPQtHgnY+hu8NnnVVt56pPgpi7
         nRhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773251193; x=1773855993; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBbbl+rYtduCAT/2aKHMXzgEnUwE1s6H/CjLlVRuVSk=;
        b=HGx18DzPj58oWLLX1vyCXKep0IMqSDxyhkyg8xCEv4uWLHqUxMTdRtspv855TKhmj6
         AdkBx1Y1NlMH6iFcr01BAy17cJMDzHZFrzVKGbEIGU9Pv/QdHyuMvAtqZVohG6RpxXIQ
         FpIpNwz6i51w8VehvXtDd08HuMD0DC6cOf5tTVSVxPm7l+lTAIVk0Y5oKV+/1DjXIkEK
         c4dMJ5d6F5JcBlGF2brPfDIlfBAwNFH0kRsti/+ns1ira7M+KqB3y7JoOBf+Tw9Ug2mN
         pFYKpR2cuwntPyBYPTQnPXbhCvnS2wu4ddQMvKOY/4KEFCK4DWmqApN0e44bori2MGnZ
         lpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773251193; x=1773855993;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yBbbl+rYtduCAT/2aKHMXzgEnUwE1s6H/CjLlVRuVSk=;
        b=wGsRHiW8Y17f3CZm5L9bChcBh1qjZSMVBOo0UBvJXvMmMe9vZVJY9gfgwzvNpS9aIz
         5J+KAxwhIvIFftPlDwqOTrzHB0/5AjELfH/ScxaM2rVZ8IyUC5KbcqrQ9bKN3Vq3hZgH
         umRL8KmwKezjXCg+ZXljYAvii6NT4cuo3C89q3NJY7bB/RKUKfYIdh2wp2zNDIwI1Ctm
         vphMiHOOGSca1cEEccemsASR2jCJQ7K033arZBOb+Ppcj9WTeVbU8EZVCq1aQtObG+h6
         Q2iylKLF3lMxTo53TcnV+WqK7czutXUThCM2pJiwEbGE/cQOeU/a1LuHUSsUcDCePWAc
         h6WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGhXFegfRH6VmyKOHdo9kjzqnC/0EcQwNLsS0pfJHeytGcrENHPl5lG6aiB7xfQyh5lDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxboyostH50zch5xAMIwZm7JvjwfJqbQ9jIeR3nIZAE+QJHFcB3
	5o5tbcqq/X6Lrwo/uP+gd6LP+ikaRyV7CkmuLVxeWl9k73XVnzc3LLLmQoTXap2INEEwHyytMrD
	IfJs5vENoxkd3350UBvxJRcR9teUy98c=
X-Gm-Gg: ATEYQzzxSGAbvyZiyUkzPaNtk6VVdkRJduFTGnGPRE9+ALJ+5Ds7I7NJbziRK/YMjhW
	pcg2vnZvtHfiI7WE4Ns4+zf49WgQIyhcsN888jRGRgMZ3+VA0uGS/SoAJtBCsvY9n8j3q/dr4Ar
	VtCczTgsXn2JNoOsKqMTLse1hms/zsWDx2fH2lJPlyjI20HOautSh/0qgvoSBiusY0ptQAw6HtJ
	292sOnKvVzr+KK2lZkcqgTyjlvTRO38X9BJsFN6vnMNdW6vGg/mossRWv+QBLnIPvampcmNKx55
	U7AU3Qc=
X-Received: by 2002:a17:903:2a86:b0:2ae:3e4a:3cba with SMTP id
 d9443c01a7336-2aeae911493mr37426945ad.54.1773251193010; Wed, 11 Mar 2026
 10:46:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306113630.1281527-1-alan.maguire@oracle.com> <20260306113630.1281527-3-alan.maguire@oracle.com>
In-Reply-To: <20260306113630.1281527-3-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 11 Mar 2026 10:46:20 -0700
X-Gm-Features: AaiRm53ie_L3c5EybTPafMesmnxobM7Ooo_ynZUUASui0-hx75RviqMmmGswFpI
Message-ID: <CAEf4Bza_kJowGmin4Hh2iOpwXZVgNoeGNniidSpZEjRjqWnVyA@mail.gmail.com>
Subject: Re: [PATCH v13 bpf-next 2/8] libbpf: Support layout section handling
 in BTF
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, qmo@kernel.org, 
	ihor.solodrai@linux.dev, mykyta.yatsenko5@gmail.com, dwarves@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 6, 2026 at 3:37=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> Support reading in layout fixing endian issues on reading;
> also support writing layout section to raw BTF object.
> There is not yet an API to populate the layout with meaningful
> information.
>
> As part of this, we need to consider multiple valid BTF header
> sizes; the original or the layout-extended headers.
> So to support this, the "struct btf" representation is modified
> to contain a "struct btf_header" and we copy the valid
> portion from the raw data to it; this means we can always safely
> check fields like btf->hdr.layout_len
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c | 309 ++++++++++++++++++++++++++++----------------
>  1 file changed, 200 insertions(+), 109 deletions(-)
>

[...]

>
> -       memcpy(p, hdr, hdr->hdr_len);
> +       memcpy(p, hdr, min((__u32)sizeof(struct btf_header), hdr->hdr_len=
));

in all these cases where we have sizeof(struct btf_header), this
smells like a potential issue, tbh. We are silently truncating the
original header here, potentially. Which is ok for read-only case, but
do we error out if someone is trying to modify/write such BTF where we
don't really understand all of it? Should we?

>         if (swap_endian)
> -               btf_bswap_hdr(p);
> +               btf_bswap_hdr(p, hdr->hdr_len);
>         p +=3D hdr->hdr_len;
>
>         memcpy(p, btf->types_data, hdr->type_len);

[..]
