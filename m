Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED7D333E1
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 00:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709684913; cv=none; b=b4bIWzpHtGAO8Vj80hexikaHK8niVUgRjc2uSrXVtbKzIo0NfuUDmB43MB3LgBwtq+nuWaeuT7VrcX4vwUcqnbe1dLdDTd5LWecoK3h8X33T/x/a1heDAWh2+P6F958wEDJOagXlndCjDKDswVD51ZSu19+sqt5h6ysq5L3+lGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709684913; c=relaxed/simple;
	bh=h/Au8L5YeoL9fED78DwehL5Hsk/plKN7M/bg+JuVhXI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n4U7f9gTWAh7BfonoPvD31YJIvrY7lpiCnPFtdTouGkZGYxceE7KRLIIxzagMWh2ywKHU2bcvAuZT81dxaL5i24fjgy6goBQCiJYkiR6n+22cebHm8+tsXW9SclFDalnuSzUiyxtNwav68k4iqDMYJ2Qd323ZrmQNn6JHpX/OIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6GEIbRP; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6GEIbRP"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a45bb2a9c20so5125166b.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 16:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709684910; x=1710289710; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iWRS+7rj7uLllWHAyajWzujzcsq4P3D4BYccj8BP5uo=;
        b=d6GEIbRPcguUN8nbLGvOM5VWdZ+UKgSovyoEZlv2qGcHcJEMPu6xAArpiRrN7nh+Fx
         UTJaCLuMoE1ieewXUeBVzbCAlK0o8H7Jlk7RLmP8sHkFfT1UhCsWkN8fY128FHyWXekl
         Z83WKcJ7Dbo2QRRl8akBnHiU1rcvfmQKyzry1SInuI1ZOLrfGzs5x9CPyPsVYeoKaGQz
         PVnlUZebh7OUNiAzWy6236tawDLz5V5KYaIxivkk77GkJ1GKqb7wTvcGIEIAdaMJOJ0G
         HCw7nAifXg2C4lsR3DAkQWTOZZ325/k//Wzf9O6dr4eTesl11p0x4j9+3Y9pA3vNXLZP
         Ekvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709684910; x=1710289710;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iWRS+7rj7uLllWHAyajWzujzcsq4P3D4BYccj8BP5uo=;
        b=JhuKJNDi9234zwMH2dStDz665acpJjSNyYmS/NmZYyboMAzqNzd7c+/g3be8QmoZjd
         39PD3YBbGhMkG2Lwpa7rzpB0VOygBY1kGXlh57nybhN20ZvrGi4P0Ml8L6MfbuCCKhQs
         KXy9lwzCdDKGCENvn4BYy2sd/8ZsIHWRybmkgynjP9fKbFQ3xNxMbAEzyUXa8SDt2p22
         /7frRzNTLbrPFBYqJ+gmGY8LwbvKr1C+VAsFOAf1kL36IskahFf6HbgiNG9EqrU4Kw2g
         wLfvkiY3U70sP4EisqTACvC6O0BJQB4Rt1oZ1N2S/LtcgHSkipUAmdqZ1e3zwArEfp8B
         qVYQ==
X-Gm-Message-State: AOJu0YwaLTi/UKD104ZmeG45JKJXAl0HmL5AEqIPKDJQWjlg8epvj07h
	8wtX3m8bXNhXGw/cwZS8cOHe99HYw3E10KeWePrToB1Gxqx7G9FS
X-Google-Smtp-Source: AGHT+IFGo1gKasnoUe4PEhkD3eRrIjUCa08HGl24482wZAci3uXfAwxlhv2s4NedI5cUdRTArSCMog==
X-Received: by 2002:a17:906:578c:b0:a44:1d7d:fb57 with SMTP id k12-20020a170906578c00b00a441d7dfb57mr10175796ejq.54.1709684910104;
        Tue, 05 Mar 2024 16:28:30 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id wk15-20020a170907054f00b00a4519304f8bsm3526984ejb.14.2024.03.05.16.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 16:28:29 -0800 (PST)
Message-ID: <079be23fb72d0e0b74868dc4a62a9fe6ca273806.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 08/15] libbpf: sync progs autoload with maps
 autocreate for struct_ops maps
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com, sinquersw@gmail.com
Date: Wed, 06 Mar 2024 02:28:28 +0200
In-Reply-To: <CAEf4BzYMJftu7S0AUZ2BdU6c70sVNX69kXS0kpWK2vheGMP7Qw@mail.gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
	 <20240304225156.24765-9-eddyz87@gmail.com>
	 <CAEf4BzYMJftu7S0AUZ2BdU6c70sVNX69kXS0kpWK2vheGMP7Qw@mail.gmail.com>
Autocrypt: addr=eddyz87@gmail.com; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-05 at 11:46 -0800, Andrii Nakryiko wrote:
[...]

> bit masks just for this to save a few bytes?...
>=20
> but generally, how about we keep all this much dumber:
>=20
> for (each program) {
>     int use_cnt =3D 0;
>     int should_load =3D false;
>=20
>     if (!is_struct_ops_program)
>         continue;
>     for (each map) {
>         if (!is_struct_ops_map)
>             continue;
>         for (each prog entry in map->st_ops->progs[]) {
>             if (prog !=3D slot_prog)
>                 continue;
>             use_cnt++;
>             if (map->autocreate)
>                should_load =3D true;
>         }
>     }
>     if (use_cnt)
>         prog->autocreate =3D should_load;
> }
>=20
>=20
> Sure it does a few more iterations, but we avoid unnecessary
> allocation/cleanup and keep things literally working how you describe
> in your comment.
>=20
> WDYT?

I like the version in the patch more but ok,
will switch to suggested scheme as it is a bit simpler.

[...]

> > +                       prog =3D map->st_ops->progs[j];
> > +                       if (!prog)
> > +                               continue;
> > +
> > +                       k =3D prog - obj->programs;
> > +                       if (k < 0 || k > obj->nr_programs)
>=20
> >=3D ? But a clever trick, I like it!

Yeah, should have been >=3D, my bad.
