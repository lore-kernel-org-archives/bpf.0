Received: from mail-wr2-f0.google.com (mail-wr2-f0.google.com [74.125.225.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479653CB548
	for <bpf@vger.kernel.org>; Wed,  5 Aug 2026 16:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785948636; cv=none; b=cVxshuIMEQ/PxUzlx1IcpoWekmj882txbL/fWRS58IOABCF4nHqAgpNpPc+tluvjy5/99kMdTtqnYC1SijhqnZcp54NCCdRKqbK+OzBnjJNVO5hDp4tAJcuutW5P+9xR8X/11xXPQy3b3WtncC7ZWu6fFSvFGYWFD4iSDmEvBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785948636; c=relaxed/simple;
	bh=BszZ6KBeKZ6Qg3CtgvJEAnRrVNmYR4/7gcB+znjO7EI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZpXd/NU1Rq5sAAcjhfdCQ3G9LDjl1ukEbZdw2+/fEQ1X8PRVjdWwaZAThNIMLp03AYdT/VHT25v8XQS2d50YnJsv3MLH7Hvk/zhEmWcchv+pN87mre7FJcMLdO3NEq2JEr7B+fYZqV4nLusnsuvlvGKaAC6OzWb3Z+2oA+v/qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ZHVUv/NU; arc=none smtp.client-ip=74.125.225.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ZHVUv/NU"
Received: by mail-wr2-f0.google.com with SMTP id ffacd0b85a97d-47f4c92d1b3so255172f8f.0
        for <bpf@vger.kernel.org>; Wed, 05 Aug 2026 09:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1785948632; x=1786553432; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d+VuNurPstAmXmltuo2GrH5As/aKoCfWEX/g2T2jGFE=;
        b=ZHVUv/NUYJ33hELhK5Hk0kFOaOTBBPuQSkD29UmYqwP/PK8SDly698gOYsvBZlbWDU
         fYisgUfxVg4bXXYMHKHtVpSHTYwtAXEV/TZ7WPAmiH1CpCGhVDfCxx+eDGpdW65MhH0s
         z9tjGEQwkOtnIW1f0GyVIJwDn8xfdeGu6gIvnw/QZuvw6KX5Q/ZEGWm2qecMri4yomyd
         hENIKhRIT0tQMFohErC2B8eqqDy62QIUrtytuy5sjCME+gShmummldnvQsGYX6JnRhSY
         KrRFZLdlTyP8bCOi3SFMszApBpE8oZxLH4l+ZLC16t/eXVznNlrQ7VwKQg7i++7lWDaI
         T0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785948632; x=1786553432;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d+VuNurPstAmXmltuo2GrH5As/aKoCfWEX/g2T2jGFE=;
        b=AMOwqUsHVxT+xQxXEmIdcoIPF/SJCXmo9Ytt2nL+gy54eegHvx5o8BYG5UaOSEg9yo
         ejF+2x0rgfrqIaDaC2t5BU5JgCzMFYPaYCZfNnz53T2srnN7QJmXCMTBZoGGDOyH2sKl
         IjCCug0LIBinnhCcGhzSDvnOiLjkPzK0ZB8xG/TyrczC5I3wo3PW84b7i5iUlW/6AjcW
         d1RGM3WAh5M5Sg++aCQ2Q8fw9V6Phg83bkpfYzL9UlB8Jvh6p+I9LjJnF6j+k5bbG8MV
         f+GgK8OgJ+/vLBVO0sHJAfRiVrOtFetFBUzqDAM5gfsjz7BZ4i34QyEwKmI8MBuvwllV
         Bv0A==
X-Forwarded-Encrypted: i=1; AHgh+RrymertrX10Hd0N0EpZnc5pqP7HkyQVRoO+ua7Va+xtafsD1t86yEaI5sbhiqvEEXalgHE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwwqkSFaONw11IQP/cUsjypVW6h56CMNFs4aWL2zza9mnTiHxTM
	Qbt9h1IFvYEppSZySup/VBgG39ZzX0V/Pi2j6Q2C6ejZ6KsoRLWDKHdzUoaPxK1dhxI=
X-Gm-Gg: AR+sD13lfVw3Zw+3dm88t99qdVr23umCzaQMTqEqjYmZMoVeYscjtVfMWBMGh0y8cDW
	/B6arScScMvP/aos36TIEEDphZdKYg6ffUu1KLyqoBAFpXbmvpEHMtkmrpGHDIPcM2Eh7iwcWXV
	b4Yg4iFy1c2NUhyoSbzgpsXapQpF4aX/NVVu47m8Y3L7mRcRPlBgDx8QHv8a1LSCi0hqg+9xC18
	jSoag0yje+GUM6uFCSo9TvO3EvRxaqkgvwA97clylf4S1FkCCz+/uSNTlvirxZyLMwgdCLaC9ZX
	+5K16KFPM1sX5mjSOMqRkeGAKXR/RK3iaVCNna2SmGWgM7vlL9DM17OCZRCKzpzPxK+VZRFEfOh
	y+vsUu0xO/Nd0LmRy5rxpA+pOAQxz9S50Ll1/Ob+jLn+2227zT+Rf+mDB+p40ITTq1f38heu15c
	WvGNMsKQH4YFw/SCU121f93Zh2zdLxQMZHTS9yUXDZs9zJ3DNsnudOTTCWIPAwDf0b
X-Received: by 2002:a05:6000:d4f:b0:47f:9d0e:f8f with SMTP id ffacd0b85a97d-47fec627a65mr12452020f8f.26.1785948632621;
        Wed, 05 Aug 2026 09:50:32 -0700 (PDT)
Received: from localhost.localdomain ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47febf7e5bdsm9821153f8f.0.2026.08.05.09.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 09:50:31 -0700 (PDT)
Date: Wed, 5 Aug 2026 18:50:30 +0200
From: Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>
To: cgroups@vger.kernel.org, containers@lists.linux.dev, 
	criu@lists.linux.dev
Cc: Kamalesh Babulal <kamalesh.babulal@gmail.com>, bpf@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, linux-integrity@vger.kernel.org, 
	lxc-devel@lists.linuxcontainers.org, fuse-devel@lists.linux.dev, 
	=?utf-8?B?U3TDqXBoYW5l?= Graber <stgraber@stgraber.org>, Mike Rapoport <mike.rapoport@gmail.com>, 
	Christian Brauner <christian@brauner.io>, Adrian Reber <adrian@lisas.de>, 
	Kamalesh Babulal <kamalesh.babulal@oracle.com>
Subject: Re: [ANNOUNCE/CFP] Linux Plumbers 2026 Containers and
 Checkpoint/Restore Microconference
Message-ID: <anNn1INJrRef2ViZ@localhost.localdomain>
References: <7959ba0b-c39d-4cb3-8269-482d1d593257@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7ozpukrxhw32oga7"
Content-Disposition: inline
In-Reply-To: <7959ba0b-c39d-4cb3-8269-482d1d593257@gmail.com>


--7ozpukrxhw32oga7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [ANNOUNCE/CFP] Linux Plumbers 2026 Containers and
 Checkpoint/Restore Microconference
MIME-Version: 1.0

Hello.

On Thu, Jun 25, 2026 at 09:25:58AM +0530, Kamalesh Babulal <kamalesh.babula=
l@gmail.com> wrote:
> We are pleased to announce the Call for Proposals for the Containers and
> Checkpoint/Restore Microconference[0] at Linux Plumbers Conference 2026,
> taking place in Prague, Czechia, from October 5 to 7, 2026.
=2E..
> Please submit proposals through the LPC 2026 abstracts page by August 7:
>=20
>         https://lpc.events/event/20/abstracts/

Just a quick reminder that the CfP for the MC [1] topics is just around
the corner. There is a chance to bring up topics of _your_ liking.

Regards,
Michal


[1] https://lpc.events/event/20/sessions/267/

--7ozpukrxhw32oga7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJEEABYKADkWIQRCE24Fn/AcRjnLivR+PQLnlNv4CAUCanNp0RsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIACgkQfj0C55Tb+Ajh6gEA+JVKvBO47pbrAwGAdZKn
odfo4fAHSl0NLd8LTjOZA9ABAPg+Z9QFz4yhF4juz/IqW3AL7DcP/4GylW4G2PcG
K90I
=KTnA
-----END PGP SIGNATURE-----

--7ozpukrxhw32oga7--
