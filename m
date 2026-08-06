Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8684D1F2B88
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 04:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785991932; cv=pass; b=Qwfc0nVkTkfdM3+SXi2kpSvFz+qN08wOJ2SFeLi5xOVJZbriXGgV9i8TvV/vhf9KY/K/mheQNP8OxvUKQQ6Z4TeoQcI6WlxQfUmqyhgAARKrBxm9gCkaZE78hkz4ev5HW3eoiwmTV5RgutFFCRpQbvN1FC0PEx9ZMGVAu20Ui9c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785991932; c=relaxed/simple;
	bh=Z1CU70FtpGuR7M13onqRGUzx4pHdtgU2M/oWpaonjdE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cpTfC79hfv8g3ozRtrvLooyF9YnnW1COjQnfi4Bf5rE0L6TmBUj7ciJH9A1LFK7Pw8rOds2fG+j0Ja2JrW3cyfue5EkKMQq+G4AjckW5FF6uDXLOZ58yhpyNTeuob+/bzDSKHcy/0rz3T5wW5coebtO58XvlBaxI+YCwY5UIeww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fCeawrJI; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fCeawrJI"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a156627e22so820659a12.1
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 21:52:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785991929; cv=none;
        d=google.com; s=arc-20260327;
        b=cCIXVTjnTiKELqhkVnWxuJoQa+G/mrzkIBF18dMyimeSeQkCLxLuRqNwESIO2VruBR
         31Vdrh56CXhwKQFkiYoDkjRCcuwvMWLJYXBpJ14n0iy2x9wG50Ot6j2JUFSSKJJNhuUV
         6m48vLNL4UhvrwsRCazI6gwZ6iACAdSBf9kl5yokg3TcYcEbM1Y8WdnQcwIAwfqvqYVV
         fyerHXi60s8NX2MxtVFaUrSUxYiw4e7L11JM4WwA6WUF/YcikNPV3IMu4BIepHIUjVxP
         9M33QhPrAvV1zaQ3ek0Jm8NSASPyDqiRNTIxOd8fwMrYgINJEEPQsY9KZV9LpaNIwiUq
         txWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DPrxEo4OsAt9Vk33DsaPg6jTrwxEAz+PJXjoP4cmi1M=;
        fh=FthGvuR3K9/4OOpgmQJp7FB64mSmSiZB6V3xeZ/77Q8=;
        b=V08SW30/EdJbooAXfCWMgfc8GC3Ul1SvTUngzMVYT8Tl6GkGfZZo3Ho7y48y0pqDJL
         c0YmeiVDKIOydkagIn/11zNkK6rVTNTvoJCHe8D2+yDtVBnqX77bzHNhiFoUXowjc0cJ
         y2oOtHCwQ/0cldMZ5XXXmnmM9tssNtbo7tLbE6H5lwLFXzjzu/H0hnwuE21MepPnHxiA
         cg4Zr4P2QBCmNCinC5BMxWm2t4y+VJ3Aozrf97qg+K6RgY7kNgBI6HYkQAQNx2cmRPYG
         bZb7EH+SHUSzhdEpDs1uVmp+1a1ExC+Vpcri+MJGWT46SZL9DOQ+4uldDkdvFaCLrCji
         WkGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785991929; x=1786596729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DPrxEo4OsAt9Vk33DsaPg6jTrwxEAz+PJXjoP4cmi1M=;
        b=fCeawrJILbb3S00wwwoZE9P9sFSsEyK+RbvQRmu9bu4GTuUjzfbhspUuaHEyYSymOP
         yTaX9ASHB0qV9pbrv2b2tMa1B0/suPB4NHbApCGQ3XE5uDB3AZVjsgxpthkvuQEhomEC
         UX7OhSQM6uRwMPfxo5HXslXkRwunm/fRGDb1NqD/TZmG0RacOw3sUTNzAOkCGjXh9iRw
         m/+UYmrtBHvf4vXt/FfoYInjgHVILlgnjuNtvfVdRJNVEhhtH5AvL5Lt5QDPjxdcWY5n
         IpXCGG7oNfblQ8Hvm0NX8rH+TxrvisPSdRs9DgCk6bmVpcuIIlEjhRJt/v30MmkZY8N9
         VVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785991929; x=1786596729;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DPrxEo4OsAt9Vk33DsaPg6jTrwxEAz+PJXjoP4cmi1M=;
        b=MNM5nwDJ0Va7jSnGurSBsAXCfftleQ9ItVe+a0r/8UJ+h8xUc3l6A1aHOY8hHucS3f
         fcQx+jQrA94cahoFH+ooDVTJOlNGWMfx6Kj6e2EDIRU05msc0dblvUMdI8gX7ePxX8MO
         7nBRChDbZBOIjzBf4HlZ2YWksSDh1kgA2D4vELk1hkoomI6pk1yIdG7bUD9hqouOdsZ5
         Z9Hzbdjux3zPL2YoWQHlMishuPuK8TSVl6hNpvV2GEnmDpVhNBX3LwkfTkQbZ06CeR2R
         6ha1z6v6mpf2Sa7BBEGeB6OnC7HjoYojGXKeB5qXImQoaR7oKeFJeRwQNXQD9AIj0ocf
         2eqg==
X-Gm-Message-State: AOJu0YyUpMV4RgnE/8yBm/RWzLnlNOLjcypyZ05fohw/6pEpZKIfR3Eo
	pPFE0GQQF7E9abEE+QphJnZVcKCUILYwCDjtYktpWTiUI587kQCeNFJwG7/Fjy9kTF3ur+sFRwE
	5/M/8kC6aLGvlEGFvHOjQTD97PgvpjnY=
X-Gm-Gg: AR+sD11cANaQ/COeHDJSyLPfAKN5xv6c3UYH3LUAVlmYLcrVY0bxFYw1VdSkX/K2Pwx
	FIloMzznuj8CtcMu4u331Lhwb+3G2P2LN3lPCuHfNWPjcFdJoYTU953K/BXt+SpDDBj1+oRmhGV
	hoP/s7PG6gA8MGO9IcTthPe3oo4cvZzEMQGttjFDitZqfuXolh1SfSDXju/Xytf4TPCZL4EjvaQ
	0RU6qxJvqMSAvBKxjWpJKVHAf1S0vkvGOVWmE6itJsnGLu8BTVpFhDHDpWtwdDtW8ce3iTSW+B/
	/SdNQdC/R/F67LHiD+IQEWoTRbk/7tPJLKL9fHB76XYl9uzQ87ZdV2T6CpewPObzqLlyrNRHIGD
	Szg==
X-Received: by 2002:a17:907:a714:b0:c15:a7b9:2ae1 with SMTP id
 a640c23a62f3a-c2063558f86mr72081466b.6.1785991928343; Wed, 05 Aug 2026
 21:52:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804170156.1709916-1-nickolay.lysenko@gmail.com>
 <20260804170156.1709916-8-nickolay.lysenko@gmail.com> <9a2504bb38bd0760448fe483829c14e697a9b650.camel@gmail.com>
In-Reply-To: <9a2504bb38bd0760448fe483829c14e697a9b650.camel@gmail.com>
From: Mykola Lysenko <nickolay.lysenko@gmail.com>
Date: Wed, 5 Aug 2026 21:51:55 -0700
X-Gm-Features: AUfX_mxzRltIxybQMoyL3KWOyeeos-g2uS9lLxXH05L1ZFdT1ZS6Z1DCskOQrZc
Message-ID: <CAMtxOX27udJdM0JWDrLHn=pWzQpCTxgVTv462vS+XYt3+8t5xg@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v5 7/8] selftests/bpf: move shared build
 definitions into Makefile.buildvars
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 4:34=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com>=
 wrote:
>
> On Tue, 2026-08-04 at 10:01 -0700, Mykola Lysenko wrote:
>
> ...
>
> Thank you for taking time to reshuffle the diff, such that the
> Makefile.buildvars preserves the original relative order.
> Much easier to review.

Thank you for taking time to review!

>
> ...
>
> > --- a/tools/testing/selftests/bpf/Makefile
> > +++ b/tools/testing/selftests/bpf/Makefile
> > @@ -3,60 +3,15 @@ include ../../../build/Build.include
>
> ...
>
> > -GENHDR :=3D $(GENDIR)/autoconf.h
> >  PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
>    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> It seems this can be removed as well, all uses are after
> Makefile.buildvars is included. Or is it needed for one of the other
> includes?

It is not - none of the earlier includes reference PKG_CONFIG (or
srctree), and the remaining uses in the top Makefile are all
recipe-time, after the include.

>
> ...
>
> > @@ -220,21 +151,8 @@ ifeq ($(feature-llvm),1)
>
> ...
>
> > -HOST_BPFOBJ :=3D $(HOST_BUILD_DIR)/libbpf/libbpf.a
> > -RESOLVE_BTFIDS :=3D $(HOST_BUILD_DIR)/resolve_btfids/resolve_btfids
> > +include Makefile.buildvars
>
> It appears that this include can be moved up, to the lib.mk include.
> In this case the duplicate definitions for `srctree` and `PKG_CONFIG`
> can be removed (and both can reside in Makefile.buildvars).
> Wdyt?

Agreed, will do in v6.

>
> ...
>
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/Makefile.buildvars
>
> ...
>
> > +PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
>
> ...
>
> > +ifeq ($(srctree),)
> > +srctree :=3D $(patsubst %/,%,$(dir $(CURDIR)))
> > +srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> > +srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> > +srctree :=3D $(patsubst %/,%,$(dir $(srctree)))
> > +endif
>
> In case if shuffling includes around does not work, can we export
> `srctree` in the main makefile and not copy it here?

Not needed with the above. Thanks!

>
> ...
