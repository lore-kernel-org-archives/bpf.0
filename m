Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78478176FBC
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 21:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712353852; cv=none; b=XgFRFXNH6nT6/IERvyS7hTMD+FKvOCHz2m3cyrvrZ7pWtm9ZbWK/N2y6RBfD0zXMgzlGTxj/ZbHuo5dx6u9tYXPZp6zwvijuBFMbwQRoLrMtJmrHQWfL1mBTO6alDl1RYQdrj3RGkeHrbEL/rjkUoRwk2/0xGL/UOJnwNgEkXNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712353852; c=relaxed/simple;
	bh=qfEjwQZMCKf4FXCQPTIV6hdwdyS6tnHICZTHM6VWgBk=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=mAjxh1pAz54384prjVbVb1rEyPyVmdam9o8uK1jSOGpRk2S6w+RS6RbjB55YJtc4gbHiQBPfAMRGhw9pkJ9kH2PnKe22lhEtvB/hUXMXG8kE3iq1/K4WKHaOaw2NqQaMjSfZI03r3fgJ23iSQ34fjN6s8oCOsYeZ6QT2C/z86j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=XHsMrEwN; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=XHsMrEwN; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="XHsMrEwN";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="XHsMrEwN"
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id E64CCC151998
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 14:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712353848; bh=qfEjwQZMCKf4FXCQPTIV6hdwdyS6tnHICZTHM6VWgBk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=XHsMrEwN9FPb7muMkVfBM2J1tZqMye5glBMc+rVVVuBkH24Gc+MK3Bd/ZO6yvEbHh
	 VV8YfwVpqH1NK55WSejtgDdc9Ss3aEkKxMdtFSLfA51IOBcG4AKnOjlFBIHMFj/chY
	 2S0/llI2KzGhmafeA3lLmVWYXuW7BNMl8Eo4rK3M=
X-Mailbox-Line: From bpf-bounces@ietf.org  Fri Apr  5 14:50:48 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id BBEA1C1654FE;
	Fri,  5 Apr 2024 14:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712353848; bh=qfEjwQZMCKf4FXCQPTIV6hdwdyS6tnHICZTHM6VWgBk=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=XHsMrEwN9FPb7muMkVfBM2J1tZqMye5glBMc+rVVVuBkH24Gc+MK3Bd/ZO6yvEbHh
	 VV8YfwVpqH1NK55WSejtgDdc9Ss3aEkKxMdtFSLfA51IOBcG4AKnOjlFBIHMFj/chY
	 2S0/llI2KzGhmafeA3lLmVWYXuW7BNMl8Eo4rK3M=
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 478A5C1654FE
 for <bpf@ietfa.amsl.com>; Fri,  5 Apr 2024 14:50:48 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -6.649
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wh5wIVsiH3jj for <bpf@ietfa.amsl.com>;
 Fri,  5 Apr 2024 14:50:47 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com
 [209.85.166.179])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id A9389C151998
 for <bpf@ietf.org>; Fri,  5 Apr 2024 14:50:47 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id
 e9e14a558f8ab-36a1255a5e7so3194955ab.1
 for <bpf@ietf.org>; Fri, 05 Apr 2024 14:50:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712353847; x=1712958647;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6SVa3x1GQyzgKUqSL9XUk4vxsCQq4oEEq4beU1TxGWg=;
 b=aG6KHsz1y46j49fYxbIh+6XeVojQRqdDFkWkIlz48LDFL31iA5ORMkGqLDu1DtdBwO
 wLlZ/pJXVk8P19eoZucslbspBA0jUCKIxCQzUTOglt2/Ow//ZSREoJ8VzUrRapIlRM3D
 m+5qg2EdszOlX9OOZPOIUXwkus12e9tPpuPCWB5M3qz6kR7prsmkRkJa+Za9j/BPiI0q
 Ziv0jeSVqHTntJEF3zi/F10W3vNXM8Gv9IXUSGhenvUN3+Iv+697F/4kErFxYtPKsACa
 by6YsUjtDFlNkodAWB2WJFcH2r6YjIlDhezd/4/wqSAOqiW+rzJwbNqWNuMhtWQ56pbe
 feoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2zOsxGkST5HvIB8+7GdtVcLhslmA4znF2SoACmJepNsFFEPfZVeSz8GxSRW6U8dmqPH8R4tPcTgdDo2Q=
X-Gm-Message-State: AOJu0YyZhskSsOuatO4S/3nBIifpeMTwy8+9CO1YH7Z9b2J+kbJtwP/2
 18NHG9/uEXeTxdzo/m7q8MaOPJsVVZAeWIoouRyHD1539h7IxGs9
X-Google-Smtp-Source: AGHT+IG3iRCx54aL+kmC2Hhp/p/XJ/S0cqmY6DfxbQGj2b+6f2mhS2baks5DILYlieiQukzXgysi5Q==
X-Received: by 2002:a05:6e02:13ad:b0:369:f2c1:28d8 with SMTP id
 h13-20020a056e0213ad00b00369f2c128d8mr2848732ilo.16.1712353846660; 
 Fri, 05 Apr 2024 14:50:46 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
 by smtp.gmail.com with ESMTPSA id
 i6-20020a056638400600b0047eccd4ba7fsm799815jai.7.2024.04.05.14.50.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 14:50:46 -0700 (PDT)
Date: Fri, 5 Apr 2024 16:50:44 -0500
From: David Vernet <void@manifault.com>
To: dthaler1968=40googlemail.com@dmarc.ietf.org
Cc: bpf@vger.kernel.org, bpf@ietf.org
Message-ID: <20240405215044.GC19691@maniforge>
References: <0a0f01da8795$5496b250$fdc416f0$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <0a0f01da8795$5496b250$fdc416f0$@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/Fpq_MN3gtCfMZRFf7DnhowrkwZk>
Subject: Re: [Bpf] Follow up on "call helper function by address" terminology
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============3694394705358073822=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
Message-ID: <20240405215044.IF3cjY7FVDcscH2KM-fUrJ0HaFvquyFCrfjSgTe93W4@z>


--===============3694394705358073822==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8BPdU16yO81BDdLs"
Content-Disposition: inline


--8BPdU16yO81BDdLs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 05, 2024 at 01:10:38PM -0700, dthaler1968=3D40googlemail.com@dm=
arc.ietf.org wrote:
> At IETF 119, we agreed that "by address" should be changed to
> something else in the ISA.  The term "legacy ID" was used during the
> discussion but Christoph (if I remember right) pointed out that such
> IDs are not deprecated per se.  Hence "legacy" may not be the right
> word since we use that word with legacy packet access instructions
> that are deprecated. We decided to take further discussion to the
> list, hence this email.
>=20
> We need some term to distinguish them from BTF IDs, so another
> alternative might be "non-BTF ID".

Non-BTF ID is fine with me. Any objections?

Thanks,
David

--8BPdU16yO81BDdLs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZhByNAAKCRBZ5LhpZcTz
ZGi1AP98naPlv7LtEB+U0LxQXD175yVQyGAbcvCs1ZnatApA9gD8DmqDH8syjafk
wGeFVpEFsNb1KdvKMFVHOIG9ZBBDxwo=
=JLbQ
-----END PGP SIGNATURE-----

--8BPdU16yO81BDdLs--


--===============3694394705358073822==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============3694394705358073822==--

