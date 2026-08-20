Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C70239B959
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 21:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787261127; cv=none; b=V+dOJMqp7iPIlgG+/QTSXz5RpGb87ae4o2hTgRh4nJtsgle/UlZv3OXOxcc0oqp4sFVoMZP6TKgXEeIzIKWNw4/qJISNU5lPDge3yT15GDTLJQw7TLKFyzHVd7J+yJ3kuzigYkPUzcwXhQ0oXg//4mfsTX8jD1t2jkwSb5npkbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787261127; c=relaxed/simple;
	bh=iCbRXmqF0Y2aYW2NyPnvIdgWZk7MUpMyV9k9fq4acVY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MkEzzSWIcjGfBdIdE+xPwmmznBxN1/cclAW4PiHEx+684uf14zYoZrcK6VNK4iZMdfD5AakUXEmEokN9eePC5XGhSx6eY/YUaCXEjPQSttuF6buk44V9bcWdjykW7gVUWDY+QB1NVTVs4IheqbZ6vg+9bl5QKg3QnDJKnS63XoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ESAsK3U6; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESAsK3U6"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cace91f112so4146665ad.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 14:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787261125; x=1787865925; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+jBaaW3/7DV61ofOtSS2599nkFP/ZDCkv5PJcbwy+K4=;
        b=ESAsK3U6WzIG66pgra60nzJL/x62PEQ03YKOx3B5DZkQZm3johClTDoz7migpCxMol
         tz558R/cQSWwo1BetetoEoIazu2LgJV2eUUrTWP9Q83ZCTT6C2bmQrUpIMIUD7EkLd1H
         VJTkLFa080n7w8wLpDbYPDHaHf7DPt1CEwLEhxJNtokW3RmHPbzVZWhvGejPfGcQcpmI
         Fo3tBfrq32IkYfTAPiVB65HBn0qPnBHiPL/VwLbkBi893z6vr5sbpNJ/rYa6InHD/2dD
         5DZQkX3mBkNxmKjvAKJNZ/Kk/49sQiOG6u/Z2p+YdeMHqkAmRGRkDwO8gE/XpCm/srUq
         af4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787261125; x=1787865925;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+jBaaW3/7DV61ofOtSS2599nkFP/ZDCkv5PJcbwy+K4=;
        b=WcCjk8BQ49TVJ4U1DM9unErOdKJExSqgF+CHIcNTaA7+rcARnOTt6sB8ytETu61xL1
         86t4nWUksdlD5r1tJjy9xygCBRAd8+6wiLIv+kQyptRrua58X7ZMP2bnKUb2NlMPPfAX
         VUzXUY9WPzhpXDkGixgHFGa2TThFeBI4xh0FSBSqfSIv/uy++qzUJPeyFP2vUT038otH
         YjwH9cNgFxjjULaaA1gynBlerZrBf9Ly25P3gUjvdf+Iid0fWrFMqeP0a/okfGNNHNfn
         eHyTJiIo6UcUi1dfKVaUeF7mFdYjiRqA1Peo1cRZJKce0oVt3hh15khcK7PT65oGw/MY
         qEIg==
X-Gm-Message-State: AOJu0YxLxSRYDUT3J3X/WorKvqmw4dK12oEC6c0MRptk5QYdvKo9u4wu
	ak3064IgDV6P18euPuUT5co/YrjDrfU5cMP7joOTFjfYy4QmxgLPt0yi
X-Gm-Gg: AR+sD12j4C9IQnrhBJyO1EDfRfLvrjdLs32+5LdpJ7MFV22KjXt08dgClPFtDH51A7Y
	5dJjjISg3XT7LPnsZHdm1WTZsLE85buUKfvp8U1SYP283BUdv+/UH6Nzxtby8uvcsrGCdIfdlUm
	oa2LdGIRmAcPgoC/3aXjnnJjTUMV5MJx2pSZ+mGAr5vrU5I3T26ajlbDxChH6AwbwmiIYrNVVLb
	B8c3O+fYHMCU6HEk8DXMgoIEImFvz6puU35k1Nlz9Vrbz6xk6ZF5W9NKKUQlUhlcwdLUYJp5ygr
	LL1To1mBQ1FJw5VslQFIe4R5u7DWhEL/Dh0T9XmhumXnqLSnAp+F/YgF3rXx7flNhYDvOty2hWa
	6Zizz/EIUQxxL6ENoWvgzdS1Ohc7upLZfhgNDHLvOiiM/cSkcgq7EBL4Fx5IWofoklTF1SF3Zlo
	Pfieg4VuOgbV0F7M5PjzfysPPQ+zq0JpdUm8ZpJypwYvhCAVbceolrfIcYr0++l2yD2kF3G36vR
	D4lCKfiQIepulYQT/F4tFU8U9gProUsKdT9TfzuDoi60aWzVKOhRsF/
X-Received: by 2002:a17:902:f645:b0:2d6:3c2f:6a4 with SMTP id d9443c01a7336-2d64b0e23c8mr30255865ad.13.1787261125376;
        Thu, 20 Aug 2026 14:25:25 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:89bc:48d2:9457:6223? ([2620:10d:c090:500::6:c5ba])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3cde4sm23161107eec.4.2026.08.20.14.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 14:25:25 -0700 (PDT)
Message-ID: <edf5e0536ce02a97579e16f16dcdda9537111472.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 4/4] selftests/bpf: Check that sorting
 preserves types in bpftool dump
From: Eduard Zingerman <eddyz87@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi	 <memxor@gmail.com>,
 Quentin Monnet <qmo@kernel.org>
Cc: bpf@vger.kernel.org
Date: Thu, 20 Aug 2026 14:25:23 -0700
In-Reply-To: <0c5148f0-f251-4c62-b903-bff81b8594fe@linux.dev>
References: <20260820000627.3826188-1-ihor.solodrai@linux.dev>
	 <20260820000627.3826188-5-ihor.solodrai@linux.dev>
	 <6a0a841f4b41032cf69f5ba7d80189cfe7f4c4ab.camel@gmail.com>
	 <0c5148f0-f251-4c62-b903-bff81b8594fe@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-08-20 at 13:58 -0700, Ihor Solodrai wrote:
> On 2026-08-20 1:42 p.m., Eduard Zingerman wrote:
> > On Wed, 2026-08-19 at 17:06 -0700, Ihor Solodrai wrote:
> >=20
> > ...
> >=20
> > > @@ -87,6 +90,36 @@ static struct btf *mk_btf(void)
> > >   	if (!ASSERT_OK(err, "holey_tail"))
> > >   		goto err_out;
> > >  =20
> > > +	for (i =3D 0; i < 3; i++) {
> >=20
> > Testing this locally, a single enum suffices to showcase the bug,
> > why the complication?
>=20
> Hi Eduard, thank you for reviewing so quickly.
>=20
> For the bug that was fixed, yes. But in general, I thought it's good to=
=20
> have a couple of different things in the test sample.

We have a good set of tests for libbpf's BTF dump logic (not bpftool).
Given that, I think it is better to keep tests focused.

>=20
> >=20
> > > +		char name[16];
> > > +
> > > +		snprintf(name, sizeof(name), "E%d", i);
> > > +
> > > +		id =3D btf__add_enum(btf, NULL, 4);
> > > +		if (!ASSERT_GT(id, 0, "anon_enum"))
> > > +			goto err_out;
> > > +
> > > +		err =3D btf__add_enum_value(btf, name, i + 1);
> > > +		if (!ASSERT_OK(err, "enum_val"))
> > > +			goto err_out;
> > > +	}
> > > +
> > > +	id =3D btf__add_struct(btf, "s", 4);
> > > +	if (!ASSERT_GT(id, 0, "struct_s"))
> > > +		goto err_out;
> > > +
> > > +	err =3D btf__add_field(btf, "f", 1, 0, 0);
> > > +	if (!ASSERT_OK(err, "s_field"))
> > > +		goto err_out;
> > > +
> > > +	id =3D btf__add_union(btf, "u", 4);
> > > +	if (!ASSERT_GT(id, 0, "union_u"))
> > > +		goto err_out;
> > > +
> > > +	err =3D btf__add_field(btf, "f", 1, 0, 0);
> > > +	if (!ASSERT_OK(err, "u_field"))
> > > +		goto err_out;
> > > +
> > >   	btf__set_pointer_size(btf, 4);
> > >  =20
> > >   	return btf;
> > > @@ -95,6 +128,42 @@ static struct btf *mk_btf(void)
> >=20
> > ...
> >=20
> > > +static void test_sort_preserves_types(const char *path)
> > > +{
> > > +	char *sorted =3D NULL, *unsorted =3D NULL;
> > > +	int n_sorted, n_unsorted;
> > > +
> > > +	sorted =3D dump_c(path, true);
> > > +	unsorted =3D dump_c(path, false);
> > > +	if (!sorted || !unsorted)
> > > +		goto out;
> > > +
> > > +	/*
> > > +	 * Count definitions by the closing brace in their first column. Co=
unting
> > > +	 * "struct"/"union"/"enum" openers instead would also count forward
> > > +	 * declarations, and which types need one depends on emission order=
.
> > > +	 */
> > > +	n_unsorted =3D count_substr(unsorted, "\n}");
> > > +	n_sorted =3D count_substr(sorted, "\n}");
> >=20
> > This does not include e.g. typedef. I'd just match for presence of enum=
.
> > Or better yet, compare full expected output with actual one and tailor
> > several BTF definitions, each for a specific sub-test.
>=20
> I wanted to avoid committing a sample generated header. I think the
> exact string check will also be too sensitive to the changes in libbpf
> dumper or bpftool.
>=20
> Presence of enum only tests the concrete bug, and I wanted some simple
> proxy to a more generic sorted vs unsorted output check.
> That is, "did we drop anything while sorting?" check.
>=20
> Ideally we'd need to parse the headers and compare the full set of
> emitted types.. An overkill here, I think.
>=20
> We can just add counting typedefs as well.
> That's an easy improvement. wdyt?

I don't think bpftool output changes all that match.
I won't block on this, but working with text is simpler in case if the
test fails. One can get the 'diff' output directly pointing at what
went wrong (and it would be nice to have a utility that shows the diff
in case of mismatch, btf dump tests do that, but it is not abstracted).

>=20
> >=20
> > > +	ASSERT_GT(n_unsorted, 0, "types_emitted");
> > > +	ASSERT_EQ(n_sorted, n_unsorted, "same_type_count");
> > > +
> > > +out:
> > > +	free(sorted);
> > > +	free(unsorted);
> > > +}
> > > +
> > >   /*
> > >    * Check only what the selftests build cannot:
> > >    *   - bpf_helpers.h defines __ksym and __weak as well, and no prog=
ram uses
> >=20
> > ...
