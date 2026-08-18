Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94C736E477
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 19:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787082535; cv=pass; b=Ezaz7Sa9ocWq9dc0RT/nKGdxgdbAE+BoiRbigyaqkNmf/n+PWTGdJhRNahyEY3r7tfFscq6+mEK3p1ki+dGM9YzD7DBZ+DNAlD9Tt5rJZVg70f5m6jpTEzQJO/CTnK4B69SKqOnv6XwBm7xeYOgWuAnlkzkeyzHrH7HGBvNCzOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787082535; c=relaxed/simple;
	bh=NbL96y2dar0Pc04P73sZM2+RnuWRwl1qoFF81IVnwW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c/NhFMZdJr5uLUltsqpORee1ZNSlDFAreqzy8LuQwJ82sU9aIpvHW7E8l2zCkBF0ZuVUOKcnqTrBQKyO3XKFivg55jAoxjLRIBrtZWkw+OyKK0Y+E8eceFvgI9jwibSKFvvikg6qALJoUSFBcSSH0wd4QCbkr2vhnZPXjTaRD7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a9rVZkJT; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a9rVZkJT"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ce7d2adef4so2778245ad.3
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 12:48:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787082533; cv=none;
        d=google.com; s=arc-20260327;
        b=aAFEsXuAhSYWKy6RYnxDHyR/ey5xBTmCh/zK5Y1trD0v1EiLYmrHQdwnq1mVok5hY5
         vFIoxeUG1HReunfFOQyFkd6eBQNhnJQ4PeJXs8rX81yNQ7nj1fWDhDo86ID7w2xCSyE+
         LLihOydRe7XoDYnsx876dQhdmZPPvx67ZsSzH3J2fn/c/4jvFo9bsv75jYqeRIsmE5pS
         8IRj2RiZaSG2pUkA4YmrjhXgDkjth4v57IEWQ9PM+8qDVw/tXpwWREcp9OkzMLXzeq02
         otDMt+e+4Trl8jWSANJ/aiO+Mz/gxmaSZ73rmW/ls2T1MqZ7X2xwXEplpj11I7AX3c6e
         j/xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NbL96y2dar0Pc04P73sZM2+RnuWRwl1qoFF81IVnwW8=;
        fh=Fo+Y59NjWfIckoR6V0lpxSTYrcuk105G7CIObKvhom8=;
        b=Mh2DU/Pt5FkYbktBs6gPJzgM/yu7J60+otiVXSzqV/vhatQsZKLrL4WPP/H4zY90nj
         +heUu57cRtHoix33HJoo7f1A85ISya94AS/T3y/YqeEnczEoOMob2sPhbq3EV9Mo5gvn
         LEa2DPwo06kcLMaemvet81eiNG8w92xwFJNHxs1793GC3GXKJG2u1CcfW2ELmi0sxgKJ
         TDpTo2nO3awqgu2c3ulg5rPvOin2rzH6BeJAGsi712jpnPahfpgf1TR/LEmopV74bPIf
         hLsQJ3sepcJqXFt1IK7JWQVxK2RwcYJxSzkpX+vrODI6bAAR0x7FW5qxQBLQ6gCadksK
         mcFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1787082533; x=1787687333; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NbL96y2dar0Pc04P73sZM2+RnuWRwl1qoFF81IVnwW8=;
        b=a9rVZkJTJ06y1ZMTrkPrCkpzUZQXF8YY34fl1+XTOtVNPL793lwmCHIz0GvFfj2e/H
         pJHV5UOG9wnuDNzjfSHS7nxqwf4Aw14YZdh6FuqxTGCAHtONsu/QUlD5jkAxRIUri/UJ
         Xyn4rZZ+OrJFH4pGExflMQIKnH7bcYLIT9uQ9fksREuj7UqnSlSI1pk7YTljaCgx/lou
         F5bNdac5JfyMpqMKNDh6BqmLBOEaoeIqtH9qNgwyFJ9lR7ydpgpLbDrVqelFK9WQSoN7
         gjBY8x/fbVVeb/Jiid2NQUgTsA0b7NJqSIaIHQiBTocE055To4GTItAhRADIWFUiCxBn
         uJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787082533; x=1787687333;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NbL96y2dar0Pc04P73sZM2+RnuWRwl1qoFF81IVnwW8=;
        b=HBzI5UUyHRZWt4uE9cKy/li4P/JqGaZcmNcwq2S1c9I8IfbjfhkNTVCGW9pBzNF0OL
         k4gt5kHuc7/DvK9V8DVaW6jVAuTjtT5lBG7Yi2sH5Lwza29aNtZYAPYXisPVSJi5cINL
         VV+uO6Xi+LJ+vKuCWLUjOtI3PJ9OEyto/iJ5lF1eXAPRQc4mV/AfPkO5sKY7Mjy4A7ez
         zMMxniPtZkmCFtU468LznQVbjP2hpx0tlD+BlePGpgzfPhhJxP3rae+xfozlA/MaCSYJ
         Tk/GCpJTbxpBIK4HP+Hd1WJvJcUUa1VpA6ghn5kFCBNV/YW+6zTKjyEhs6N+8AhsBDVA
         CaGg==
X-Forwarded-Encrypted: i=1; AHgh+RprXoEEwFCgPY9McGBtNQq6JJMLrhu0burSG2cXZEFEbTr+TOKSlVhguU2l+Kyz4wfX6jw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZb9Dt080AWYs8vtcJUCzzaOVDOucnSrs1TJlT6OGQjdTzv4cO
	ygIqkrh3O3fhqHHT15h97puOGIjepdv8Knqr2VYshQA/sQAaO8ptS5fXEtuMqgPwCiz9rwUVHm0
	ZdiuoI8Kp90+/H+R3fuSMdKyH0Ed9w1jv5STezIFv
X-Gm-Gg: AR+sD10GITUOcGH2+psvW3WZ1ElTYEKWN7jO3jBqOtAKmdmebXFtOaqbNmR1L3OHaKG
	+Sy3txcOFOFlUbP2Z7fbzl+AaIO0Ocd4z2SftxWkjde9AUogJaOcuvFUJMl5negbWHZD3WeJdZS
	y+3Bf4+cpWAPyzNKeUpQJ/Eu54PZJStKOMZ5nGW2Gnx7DAOk0ItrF1NHOD7jO/fjTGDeoG9apIy
	A4ERxl3jYuHXoHWqGxHzH01iiCys6TQch/PHdvWi8eG4FczVdhMPSvA/e5IHzx/n5X3LdWSvxpo
	KZJKqZQtNFT5iQrFA8fiBBDes/G6kaLu01EtgQK6Ahwx
X-Received: by 2002:a17:903:35c6:b0:2cf:84bb:1ebc with SMTP id
 d9443c01a7336-2d5f6ba5ad1mr3952885ad.15.1787082533074; Tue, 18 Aug 2026
 12:48:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260815112041.1248855-1-utilityemal77@gmail.com>
 <DKRYZPV04750.1V3UXL56PKB6@gmail.com> <CAEXv5_gT+xcZauKug-VsmqSBtuMPEPtw7hubxn6-0nv=D9aq5A@mail.gmail.com>
In-Reply-To: <CAEXv5_gT+xcZauKug-VsmqSBtuMPEPtw7hubxn6-0nv=D9aq5A@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 18 Aug 2026 15:48:40 -0400
X-Gm-Features: AcwNN1WUdAwPBQ6w2_WyV_dcHHbst9nZ7dsq9WTR3jGvtOxDRu0F7Wr4dM9TVgs
Message-ID: <CAHC9VhSs5noQexa5c5RiP_DEzUgGaZw1hwsP+T-HWRvvymB+3w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 0/2] lsm: give BPF programs a way to query
 locked_down state
To: David Windsor <dwindsor@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Justin Suess <utilityemal77@gmail.com>, 
	Alexei Starovoitov <ast@kernel.org>, Xiu Jianfeng <xiujianfeng@huawei.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2026 at 1:42=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
> On Tue, Aug 18, 2026 at 5:43=E2=80=AFAM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> >
> > Lastly, given the difficulties we've faced from the LSM maintainers, I'=
m not
> > inclined to waste more time in explaining again why this cannot go unde=
r
> > security/.
> >
>
> I'm still going to send v7 of bpf_init_inode_xattr series, even though
> it's a stalemate. Haven't yet decided where it'll live in v7, I'm
> inclined to leave it where it was (in fs/) since one side will NAK it
> wherever it lives. We can record NAKs and take it from there.

As a FYI, I'm not going to ACK any of the LSM changes with the kfunc
in security/bpf_lsm_kfuncs.c.

--=20
paul-moore.com
