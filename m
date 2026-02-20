Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC63A13FEE
	for <bpf@vger.kernel.org>; Fri, 20 Feb 2026 00:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771547778; cv=none; b=Pp+BEOPldhUb+uqVD0U1MtuoBvcqkBha6DIxM+EGDiMm7BqhBkL9XpBCRTtTVxXkneGY8LD+fPb2sR3Y+bj7KLnuYR3NC226hMa9MZ2q/Dm6NiG+LqsT0S7De07XpkuJN2YFqDsfGuIWUbIFrBu3xH2P9vyUmp0OfU+dhb86nHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771547778; c=relaxed/simple;
	bh=A0MAPiQYVDMW3RhATshGKPJHmNGNM19hc3gYKN9JAWE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RpYzFY5TVw79wDOhRRowc/h3cpXeedDJCC/s4Qp5wnBXImlT/E4cl8LLsXzN8L9rawULMhJYvo/k7whabchTj0e2O0hu4bayrkTPkH0v9NLb6VVehy8y0+arZH57CMea2RPpqGTVN2m4CLWbWkmSDVflE250Iam26c0E77WkPIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqhZ14Rj; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqhZ14Rj"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3562e858da5so674104a91.2
        for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 16:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771547777; x=1772152577; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YkGvPx+K90ehvO/fjwy2/54thuEFALpI2jco2nWtLIk=;
        b=ZqhZ14RjdZN4LYaZwi1Fkz7t/0fErAAsu1LKpLWhOe89jH2FpLdIQC9d64cN5ZFhut
         4ScPfeJmBPuCTtCZBL4wtuUDLUHWHc5WIIfOYVpc48ZkhLwWsXHinhhyBxFyYCCC3U3G
         Yw0scwHXQuVj6KThk+D20Qo7BLaAOcTvpLDUMnzR3pQva+/nfdwaC+tfIKUahwJS5dtE
         FQQyBb5vnyoxHufY7s+kplKE6Ls9vmmvg2s9BJwWQ2HkM+mbnEM0KTiOg17IuYZi/KLh
         0iHyTdlo08/mbUpFRIx41f8UNA2S8OhP91h5/ys6rmzAt+KqOj87Jj21BVKTbFWYDZ/l
         96lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771547777; x=1772152577;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YkGvPx+K90ehvO/fjwy2/54thuEFALpI2jco2nWtLIk=;
        b=BZX7Nr0j6x3LtIh5ZFsqlrToBHxCrzm3PYIt0PHPqwZIS+JNnAnazWzlzjaz7FpOPB
         CHRQifAs4IpqUkdsQPYQE0aGvZUX6NQ2PBbWyOaif8DsPXyVMzKm5gcW9XeIEG0ytqS2
         s5c3Pg8alL02SAafNvyZrJYYA+IwQ9oDRxOsSDYo+ZMHhtDNAM/HxAEZ+7lGjbpev5E2
         k7OlpidvLIueQgh2w/tUOw9bq7eBfo7ZcyGKQY2Op6AZSpwI6JrLECZd3daji+PX7FOo
         GtfGi/HEYd2hx46PndbDPFWpvM/g+5p1GmbXdMqoUe22K5A/kejIGYVZEQXJqeVjy1YL
         Ms5Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2NmGhTbd+AaxosNKBRO4rdnxdqll1YID7YzDuLZnlhuMIG2/28AKhzwUz7mES3C3acP4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywh319yv4WTZHFR9FP/LQErkcYgJTt5VFwOKPwVjDcMSLcNOdRB
	7bT0ooBdYVEz7STtUNNc/MT1QPcV528Yv7uBRtlUteC9RmQOqClj4/Vz
X-Gm-Gg: AZuq6aJ+UlGADrhR5MDdSMQZZebTHNQg6urN4XXnhqm3/eVZ7gl02EDd9SR+42U4KyB
	oty2rAMNGbq7w0jL6wOS7EsFZMLCQqMP0Dkm99j7mKqrxk+JJY6rHGwokvD/2QX/UMmmGAJEruK
	t/iKeAAIBhHI0R/f1MChkPT8UHt9kmxhBHNEgKWRjMU7/xupxu5p8TEUDSSq7ktTCXNXOusUpJQ
	bSEMn4qj9noBjgAiEKWeTylCibo6oSdoPEB0tVElOYbj5nxmhcjsatNt+wGxBDxY9bk5CrmPvGM
	czvg2tYnnq4U7mpV9kRebaBiWRKe53s+hfs6rxPRyQV867Z0MM3MwbN9uaafgxhlTYknGJKN2Gd
	jmaEegp2d8fHRsMzmLEzrUatdOD65gDL41+Qt2pzmp/RQ6RY9R9SB2leHNjQbfMo4wctd/IN0ma
	kHhVEEWWqK1+Gllzgs0cQaQ/6niMkiq9ct7zY3WrRyXnjKxThTV7w=
X-Received: by 2002:a17:90b:58ce:b0:33b:b078:d6d3 with SMTP id 98e67ed59e1d1-35844f85caamr18409475a91.23.1771547776985;
        Thu, 19 Feb 2026 16:36:16 -0800 (PST)
Received: from [192.168.0.56] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3589d8c622dsm1154743a91.11.2026.02.19.16.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 16:36:16 -0800 (PST)
Message-ID: <ba46ee9253091fd8c83ae5c5a96b85615306a93d.camel@gmail.com>
Subject: Re: [PATCH bpf v2 15/15] selftests/bpf: Don't override SIGSEGV
 handler with ASAN
From: Eduard Zingerman <eddyz87@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, Ihor Solodrai	
 <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, Andrii
 Nakryiko	 <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jiri
 Olsa	 <olsajiri@gmail.com>, Mykyta Yatsenko <yatsenko@meta.com>, Alexis
 =?ISO-8859-1?Q?Lothor=E9?=	 <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Date: Thu, 19 Feb 2026 16:36:13 -0800
In-Reply-To: <a017dd5b-eb7e-4724-8f8a-cb6a6c970118@gmail.com>
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
	 <20260218003041.1156774-16-ihor.solodrai@linux.dev>
	 <a017dd5b-eb7e-4724-8f8a-cb6a6c970118@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-02-18 at 15:12 +0000, Mykyta Yatsenko wrote:
> On 2/18/26 00:30, Ihor Solodrai wrote:
> > test_progs has custom SIGSEGV handler, which interferes with the
> > address sanitizer [1]. Add an #ifndef to avoid this.
> >=20
> > [1] https://lore.kernel.org/bpf/73d832948b01dbc0ebc60d85574bdf8537f3a81=
0.camel@gmail.com/
> >=20
> > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > ---
> > =C2=A0 tools/testing/selftests/bpf/test_progs.c | 8 +++++---
> > =C2=A0 1 file changed, 5 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/tools/testing/selftests/bpf/test_progs.c b/tools/testing/s=
elftests/bpf/test_progs.c
> > index 02a85dda30e6..b533cede933d 100644
> > --- a/tools/testing/selftests/bpf/test_progs.c
> > +++ b/tools/testing/selftests/bpf/test_progs.c
> > @@ -1944,13 +1944,15 @@ int main(int argc, char **argv)
> > =C2=A0=C2=A0		.parser =3D parse_arg,
> > =C2=A0=C2=A0		.doc =3D argp_program_doc,
> > =C2=A0=C2=A0	};
> > +	int err, i;
> > +
> > +#ifndef __SANITIZE_ADDRESS__
> > =C2=A0=C2=A0	struct sigaction sigact =3D {
> > =C2=A0=C2=A0		.sa_handler =3D crash_handler,
> > =C2=A0=C2=A0		.sa_flags =3D SA_RESETHAND,
> > -		};
> > -	int err, i;
> > -
> > +	};
> > =C2=A0=C2=A0	sigaction(SIGSEGV, &sigact, NULL);
> > +#endif
> > =C2=A0=20
> > =C2=A0=C2=A0	env.stdout_saved =3D stdout;
> > =C2=A0=C2=A0	env.stderr_saved =3D stderr;
> I think this is reasonable for the use case. We may try dumping logs
> in |__asan_on_error(), if that proves useful.
> Acked-by: Mykyta Yatsenko <yatsenko@meta.com>|

Agree with Mykyta, crash_handler() can be split in two parts and
__asan_on_error() can be defined, calling the part doing
dump_test_log().
