Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9D1A50
	for <bpf@vger.kernel.org>; Wed,  6 Mar 2024 00:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709685610; cv=none; b=ooDEPBamNhzZPNxeGMdB9CGgZ85TdlLXugAJKn3njkwhK2/6wHJhGS8IQ/7RT2L930d7arWa/oNHpU9EYxU7Bh57x3m1SaV6MYnqty63vBORjqaWhXMeXKYwfyj7D34AGggnOCXXGJAiwjV2qlqD9BaJOPz5XfphAK+uuQPFF7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709685610; c=relaxed/simple;
	bh=y1Ha5KGsAMnOKHThOMzizcTdjxY/w3VcPDxU/SsvN6E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GD3MqOWh4HcSy1Sgy2MuTJGxHk3kskzFhHsyzR92QewHYCjAeC7ZiXVeLymi+4pZTPKKEt9x9NOciTQPrp29Zt9srXeosMobWQ2whGOAW3Do0W4zXsAQBrCROUHu6W0iRNklKInO9ZeK6UIHxQYsDeBa0C+9oYU+DqL+fXzOt4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TSh1riXU; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TSh1riXU"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5131a9b3d5bso7180645e87.0
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 16:40:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709685607; x=1710290407; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ty+blqihoruAByIbt+rxtJvZ6XaFnnF7IseATIgNMss=;
        b=TSh1riXU8ucPQwm2dAiBhA8hJZkHqMMDUrbA/elh9Idk0p6NydCUf+J80TZUvC0crc
         4dos4pT9SuYgl6V1/qGg7llejR7ydCjhCRKJZ34RlNW8WIfIYYsJDkIkcmyCTcqlpVGu
         qd49q6LVSS/0sZbhIavNXb65QWPlA/8LN9Bor+zcUeIPafrGf/aWWz1w/kEWLgSVSxXc
         TNQFhQGcZzZD+ds8WGecQ2YzZiWTwoTGE0e07jHHLq1SsRDCHF97ORqMIF/00nBJrr4T
         /JKAVEKe2lZFSN8vVUWIXpJl7lGZ/k0DvEt3dZy5hUD3wxPkHCbr58lYSiDEjN/6s19T
         Rnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709685607; x=1710290407;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ty+blqihoruAByIbt+rxtJvZ6XaFnnF7IseATIgNMss=;
        b=bSKr4JHbGfmNeu/HJ26wWJA101sKNJOVD/hpYlfGqIVpdtZhcxB4Se/m32GPI033f/
         iqzoCzIAsRFwy0y+L6V+rmQWzVsI+G/PdEaXFRaENMXuyLiUKtYoX+9L4yhSQ0hO398/
         omgdvFXOwXLneJvQNcTwi86SthcnhmxEmtsPIHLgOxC/RcVHhoL07gb09nQR9XDwDhZp
         6STWVVmCnGbQana+tABJYd2V6ypIsnz/KFPtjYesN/ZA8TLEVsQ54HAEa+nlVgXyv92L
         4KCP9HTSoMbvTcwEnulFOokthxg91xL31rbmVRuH4nL3C2EbUsBVzDkCdbHSDLxr0zxe
         VRuA==
X-Gm-Message-State: AOJu0YxsL/ANWap2RWPN5GDwCpU2ESbR8UjpF500UIjEnFH4TMqVFn92
	N5UoP9M5LYZm3WHU1W1WukKeeirnPkr6VruXsVkZRgiiVYeeVMjT
X-Google-Smtp-Source: AGHT+IEs+6I+X6ThQFZM3UhKgnVT+uCqkV0wf8TG8IhOLOcJZ7mMhIm2Bt8dabX4+DmW7u7XJ1QPBw==
X-Received: by 2002:ac2:46cc:0:b0:513:1804:9359 with SMTP id p12-20020ac246cc000000b0051318049359mr2139163lfo.17.1709685606743;
        Tue, 05 Mar 2024 16:40:06 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id i8-20020a170906698800b00a43e8e76825sm6640453ejr.149.2024.03.05.16.40.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 16:40:06 -0800 (PST)
Message-ID: <6d8e530f5b063451e2c0abbb037f07f76a8002a7.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 09/15] selftests/bpf: verify struct_ops
 autoload/autocreate sync
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com, sinquersw@gmail.com
Date: Wed, 06 Mar 2024 02:40:05 +0200
In-Reply-To: <CAEf4Bzai=sr9yNareReh6bcEWXaHQQRnGzkkXSdvyu4z3M5p0g@mail.gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
	 <20240304225156.24765-10-eddyz87@gmail.com>
	 <CAEf4Bzai=sr9yNareReh6bcEWXaHQQRnGzkkXSdvyu4z3M5p0g@mail.gmail.com>
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

On Tue, 2024-03-05 at 11:48 -0800, Andrii Nakryiko wrote:
[...]

> > +/* Swap test_mod1->test_1 program from 'bar' to 'foo' using shadow var=
s.
> > + * test_mod1 load should enable autoload for 'foo'.
> > + */
> > +static void autoload_and_shadow_vars(void)
> > +{
> > +       struct struct_ops_autocreate2 *skel =3D NULL;
> > +       struct bpf_link *link =3D NULL;
> > +       int err;
> > +
> > +       skel =3D struct_ops_autocreate2__open();
> > +       if (!ASSERT_OK_PTR(skel, "struct_ops_autocreate__open_opts"))
> > +               return;
> > +
> > +       ASSERT_FALSE(bpf_program__autoload(skel->progs.foo), "foo defau=
lt autoload");
> > +       ASSERT_FALSE(bpf_program__autoload(skel->progs.bar), "bar defau=
lt autoload");
> > +
> > +       /* loading map testmod_1 would switch foo's autoload to true */
> > +       skel->struct_ops.testmod_1->test_1 =3D skel->progs.foo;
> > +
> > +       err =3D struct_ops_autocreate2__load(skel);
> > +       if (ASSERT_OK(err, "struct_ops_autocreate__load"))
> > +               goto cleanup;
> > +
> > +
>=20
> let's assert autoload state here as well?

Good idea!
Did not occur to me to check this after load for some reason.

[...]
