Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DB8133420
	for <bpf@vger.kernel.org>; Tue,  5 Mar 2024 23:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709683121; cv=none; b=jzZhNciv0+we8LhOSasZb0Gxz8dRxmfEtUYHAudAcT+O18MVgEJqiEFdk7B+QqwuaBEhIKlLXoC1NeaQOMW0A1CrV9YQrpUaGwPE5rSwu9L00Kb+RIWPAP6i7BRGF5gTfQUAmwC023V15RTI3qBsZCgKHFb/y4bF7dxYooVP65Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709683121; c=relaxed/simple;
	bh=GqbWftIjsUY2/Bx8fkqLmZmxMwBbfiemvGssUz5CpOc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SP7oBqZ3jD8D18fEFg3mBjyNGlVH8LKZqm2pVn6/U4PvoYBSEmFzBI37Y/exrdLpyFii9L4bCSkvuDLJBPC59+G+89cqp3oUYqAj7DA5mowvKaK5h20vYvguj4B6gM6ehh0XwVg4dQOA6Den7vLys6ntSmBwNmLX2wYlMG/3cS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LwWqaU9A; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LwWqaU9A"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a452877ddcaso374878266b.3
        for <bpf@vger.kernel.org>; Tue, 05 Mar 2024 15:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709683118; x=1710287918; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jMLulJlaLGAqGg6qHewGgbNa0eK70dg5Jd7X3PfA6rA=;
        b=LwWqaU9AI7FxLGeWQQ7jujVDJl1S8US31xuWMt3De+mkVzfNot3Ee1oIqxOXH7F01a
         2+BtS0KYUJyi/tR9hpBNvBXBuA8gNQQz7/OyqTMNjBGNoFkPZNSKj2ui1YbPiiHkHvPl
         oTn7hkHxDrCg/LFK0s9hH+Jnnm8j7uX3I0agAZ8UHnw6A/c0QlFstAKZvrzH6aAaqaX4
         AdYloohArL9TlqYBBUqaTP68u1cci51UOIMwo3yVLC69g/tf3UgN5av5OPoiY8dqmMsM
         KgbkLzPrpboTnnzpI51YueWOuUsMhaeB3bll/Qadvjc471e9qVwqji+4ODlDlM+t1TD1
         uTgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709683118; x=1710287918;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jMLulJlaLGAqGg6qHewGgbNa0eK70dg5Jd7X3PfA6rA=;
        b=YT8ZPtdwQljiZe9t1hM/+qVXlnkS/tJ5GPe+CjXXmJ0z6Y+3KS4tUJnOC1EwrD1uZC
         jOaktxaiHWKziqi/Mg7l1KtxQ/eKi8t5UW9weoDt4PHW55VvaO6Iy8UwYYpV6+M3iw+m
         gWsJv858c6rka3/pFD48q5olSBJRxfNYbXBkdIZeOb7DaJAvmcP7f+6CEZGyFNa1GfPh
         UtWfkd5bOh3ISA8NoyysFItZP8qkCvejaCF/SW2QWlreMeVb4+Pg+8OQoQjgKYa6Qr3a
         DPucVdaSd/lv1CexNLUUq82odDalv1YBNo1eeltCTsvv2d6mWiSlAmHhs1EfavdrrlDr
         sj6A==
X-Gm-Message-State: AOJu0YxWS3vWdstM9U4fxUPgWBkwxKzsSEwtUOGIWsVpvrFrprVD4/vX
	/hqop/3xWNllYqWP+vGzYH6FA/KSECPtKmwjcTJWl7MdwaVdB+Vl
X-Google-Smtp-Source: AGHT+IHzHegj7+Ywo4dtM/XApnS1JKivlP2p/Fh+NVJz79jSUV81eQXUYm8nHV3cgZMlv9njQZKJlg==
X-Received: by 2002:a17:906:6805:b0:a45:b1e7:df8b with SMTP id k5-20020a170906680500b00a45b1e7df8bmr1047824ejr.64.1709683117838;
        Tue, 05 Mar 2024 15:58:37 -0800 (PST)
Received: from [192.168.1.94] (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id f11-20020a170906048b00b00a4380e85e5csm6451173eja.202.2024.03.05.15.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 15:58:37 -0800 (PST)
Message-ID: <078bb2659576c999fbfff1dbf4f9754e361b1fce.camel@gmail.com>
Subject: Re: [PATCH bpf-next v3 05/15] selftests/bpf: utility functions to
 capture libbpf log in test_progs
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net,  martin.lau@linux.dev, kernel-team@fb.com,
 yonghong.song@linux.dev,  void@manifault.com, sinquersw@gmail.com
Date: Wed, 06 Mar 2024 01:58:36 +0200
In-Reply-To: <CAEf4BzaxJ3w0-rpShqd5qAMMyHmfhYCOCqAUNKEO15sd0QCStw@mail.gmail.com>
References: <20240304225156.24765-1-eddyz87@gmail.com>
	 <20240304225156.24765-6-eddyz87@gmail.com>
	 <CAEf4BzaxJ3w0-rpShqd5qAMMyHmfhYCOCqAUNKEO15sd0QCStw@mail.gmail.com>
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

On Tue, 2024-03-05 at 11:24 -0800, Andrii Nakryiko wrote:
[...]

> > +char *stop_libbpf_log_capture(void)
> > +{
> > +       char *buf;
> > +
> > +       if (!libbpf_capture_stream)
> > +               return NULL;
> > +
> > +       fputc(0, libbpf_capture_stream);
> > +       fclose(libbpf_capture_stream);
> > +       libbpf_capture_stream =3D NULL;
> > +       /* get 'buf' after fclose(), see open_memstream() documentation=
 */
> > +       buf =3D libbpf_output_capture.buf;
> > +       bzero(&libbpf_output_capture, sizeof(libbpf_output_capture));
>=20
> please use memset():
>=20
> $ rg -w memset | wc -l
> 355
> $ rg -w bzero | wc -l
> 12

Ok, will do

> > +       return buf;
> > +}
> > +
> >  static int libbpf_print_fn(enum libbpf_print_level level,
> >                            const char *format, va_list args)
> >  {
> > +       if (libbpf_capture_stream) {
> > +               va_list args2;
> > +
> > +               va_copy(args2, args);
> > +               vfprintf(libbpf_capture_stream, format, args2);
> > +       }
>=20
> should we take into account verbosity settings? capturing LIBBPF_DEBUG
> logs probably isn't very useful (but will make debugging harder,
> probably)

LIBBPF_DEBUG messages are not necessary for my tests,
so I'll move this down after verbosity check,
could be changed later if need be.
