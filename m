Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6047F783
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 20:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786049567; cv=none; b=e/mE17Ies5rApb0lRBw3siRLwvj0sD0p6WrItVKqhtSeQeMJ+edwNnlPnC4D1FE/EPvS2UDWCilQI/qsGF53n50AR9iIOJk5u7J1eREwz3j27FndXcM6Wi4yjuUvBIL6pTQWtmYHN74WI/SD6XU10lyOVqkdpQCRiiEjL6b2x4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786049567; c=relaxed/simple;
	bh=RGKSsLZzAv57zPIj0nqZv2oGer2X6Wd2qP4YmmUbhI0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=K1sKhxOF1BCD4KVeIKJMHfbssHnlNpeSyDu9pRaL7HmFDK4n/3TJqsIOKgaklOIn0IVopp5XnjLrvaMIRZn9nYUpR8VP2OAueEtbZGBa3qxi+AA/bihIahSEhWVgCYZK6bpLxI1UfmROJK5ABnPYBq7nSg4B/n1QcVPyaxycD3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rkOIhANZ; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rkOIhANZ"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-848761b5897so1950058b3a.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 13:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786049566; x=1786654366; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=RGKSsLZzAv57zPIj0nqZv2oGer2X6Wd2qP4YmmUbhI0=;
        b=rkOIhANZ6zExtM8bMIg0pWQIfQpmLJq8Cc77kpqn1j4Hto4YiI8nSY+1VitsTzKdYY
         t6awgu/XfsMA3bURclDURvjhV+M2h7zRVHLyoVAQIRIz3K1l60EiAeetdcwbygmV+lfy
         2BfbNMHOAodia+K9/yVJndi06e33R05GNk1lAxn4OAbjrKuo3no/2HcrKfq72lb5GfTt
         6HYJIOV5v9DmBBxlHsVwp0UFL5sNZr+n+UZS5xGXa8irs4IekQReQquz/byZxdSZ1EMY
         6oM8b004p+NVZypxieSTjpjotYtrrhnBtHb9XZtRyxucOEroENr07CjyAauc3d01/+kM
         994Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786049566; x=1786654366;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RGKSsLZzAv57zPIj0nqZv2oGer2X6Wd2qP4YmmUbhI0=;
        b=WgeS2uQlfFvuELvYboHOgBfkHV35SlWdQ7oLJfhe/yi263Rg46Tc+2GGAjMsZP27iX
         sTzfI3SpWpHwHYyHoUBm8GxuDwOldnPOdQr+mW3VlVYuuZF7eA9EvdUUmlhsFYkRyax5
         7TpdED4IMaDzRbAg84oBSm0UvqzneYu3sczMGlfpk5VAslo8GnOx9BwKyCbJxpIErQDc
         IXM5t81x/Gh0uH4usV/oMsezEpf+wqQVqJKHsqnRM8DQ/f+tiQDRmhuLHIA2r8pntbkQ
         ONBjqW0PmRqa3iwSpz6QaMMn5C8DM/dXiNw8vRYC/XEea1KMgWRbP5rRNFgSyBmDLrae
         CXag==
X-Forwarded-Encrypted: i=1; AHgh+Rrc5XgE1wIqU9DukDdh5MRcwj8v0WocBz0lijY14d90ZpSXLDWFPuSMfSh9Sm5cHcs/v8o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwDD084pHyXGnKO338+omPgdfahKlzOMw9cjLoKgK6WxqBE2FDM
	cpv+7I3/fe7YmhF8NoQXaG03l+Jeq6lWYhcqnNSIRQ2f990I5+9bWWDm
X-Gm-Gg: AR+sD12r2HxxWtCPbXZ/mr4TpWBy9iT7tQV1aCCjb5OHOu3zZHIlWUEORP51gwr7E6U
	/Y9o261SLqxJ0j2Rose9Phtl2xFAmsh4mc004XA8KBaRk0uKltf3hSf3BCP2GxsAktQlSjUDRjk
	PDoAZE2ziPNZyhi0BSM2tOSZZoFQaKRydpDcDNvQZCI4cetHbeRzf+ml2YmfLllxgXF8KaPzYuM
	Vdc11HNccKlJUghkuWPvETgIVixyjEPKDo/cCM8OLI8FOruRT3fdaCPiJ5yVVOTFx3lopKsqifs
	rsQ0AFHhradLfHELqvJ8tBV+3pMfJ5fR2272PA7IDs7C9OhEAvfCi+pk8js2miC571feYVYPOwm
	/oqRTDqOr4KajeZ3tvExD6zVMS53LaF8YF53PmBoP81QMpRhIQcwZGTlVzkHlRYUWQUdNF7tWET
	B7A2bYQ8PQvtNfv18JhTMhYeAg2CP1uJFO+NIvYVB4lGh+2BbWi3HqoyvNy/+xFrfm13of6luxu
	Jany+Hq1pdp+Y1SqqbMTGAcqN8=
X-Received: by 2002:a05:6a00:bd0e:b0:847:8b0f:2508 with SMTP id d2e1a72fcca58-84f2dfc8c37mr21772973b3a.13.1786049565643;
        Thu, 06 Aug 2026 13:52:45 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f4538ba6dsm2110654b3a.5.2026.08.06.13.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 13:52:44 -0700 (PDT)
Message-ID: <7e8052e45978c70daf1d3c4c1b9dcae3c660033b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] resolve_btfids: Deduplicate BTF after
 btf2btf transformations
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Date: Thu, 06 Aug 2026 13:52:42 -0700
In-Reply-To: <986e6f4e-4b51-4440-a37c-9624906d7370@linux.dev>
References: <20260805230648.2354989-1-ihor.solodrai@linux.dev>
	 <20260805230648.2354989-2-ihor.solodrai@linux.dev>
	 <8225c3b4b2077c0fc5a86678d410e68ac6939017.camel@gmail.com>
	 <986e6f4e-4b51-4440-a37c-9624906d7370@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-06 at 13:48 -0700, Ihor Solodrai wrote:
> On 8/6/26 12:05 PM, Eduard Zingerman wrote:
> > On Wed, 2026-08-05 at 16:06 -0700, Ihor Solodrai wrote:
> > > btf2btf() adds new types to the BTF: the KF_IMPLICIT_ARGS transform
> > > synthesizes an _impl FUNC together with its FUNC_PROTO and copies of =
the
> > > kfunc's decl tags. Nothing deduplicates them afterwards. pahole runs
> > > btf__dedup() on its own output, but that happens before resolve_btfid=
s
> > > sees the BTF, so any type the tool itself creates is emitted as-is, e=
ven
> > > when a structurally identical type is already present.
> > >=20
> > > Call btf__dedup() at the start of finalize_btf(), so that base
> > > distillation and the by-name sort both operate on the canonical set o=
f
> > > types.
> > >=20
> > > Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> > > ---
> >=20
> > Hi Ihor,
> >=20
> > I'm curious if you had a chance to measure how this affects the
> > resolve_btfids running time?
>=20
> Yes I did. tl;dr is +30-40% runtime for resolve_btfids:
>=20
> =C2=A0 0.18424=C2=A0 +- 0.00174=C2=A0 seconds time elapsed=C2=A0 ( +-=C2=
=A0 0.94% )=C2=A0=C2=A0 without dedup
> =C2=A0 0.257003 +- 0.000473 seconds time elapsed=C2=A0 ( +-=C2=A0 0.18% )=
=C2=A0=C2=A0 with dedup
>
> So that's the bad news.
>=20
> The good news is that it shouldn't grow, because most of the dedup
> time is just walking BTF. We emit very few types.
>=20
> I think it's worth taking a hit, because a non-normalized kernel BTF
> is a petri dish for bugs.

Thx, not that scary then.
