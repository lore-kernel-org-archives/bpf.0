Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D61154C05
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171877; cv=none; b=qRKRfQAO9bWxi/lgDImK3OT6BlTSFdqnJ3bQcXuNcN1IkujLPktMkxlQbBcgR84G5PbX/3TEIUowO5R/W/ld+6KUeFRy8z76dur4umAixjpbgdDP6PR8gIadK4RnA8VcccnGtt0GaXgqQrkImlFywznLa60oEzc2ATUMoIjg25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171877; c=relaxed/simple;
	bh=2VXDB2+/ZU2pYWSdd37cCuIGc2qzUxhgvv435gbafYI=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=nZZRQz7RvwzxG8hl63U5DXwHsWaTBNhOfvpXpAP0UAXB7pZ6WZl9tgd94tYC+vKvsj9QPLCVhEA8CCC0Mv7FC2owJYLkLgFmmkwlkjcveUlF6rk+6go58ZBm9HTcD+W/q7VfnSO1Fy2849ipM0igTVtEWklh0F+ydrs7yV3nSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=ZEgBI9/y; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=TqLsXF2j; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="ZEgBI9/y";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="TqLsXF2j"
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 14384C151084
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 12:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712171875; bh=2VXDB2+/ZU2pYWSdd37cCuIGc2qzUxhgvv435gbafYI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=ZEgBI9/yjFpAHJdKo6hN2BuvGv40HIVgy1xMmMkv1ATV8YLcfnKtQk6eRJZDAIDUc
	 LHkQX63xfn553UEMO5XF+LIt8y57YjyTVF4S0zKp9l/xMi1r9dvuZJMgPhPCeWsT/B
	 xnWwZSkGHyj2BI7oVq2oAanE+W3rT2hrfBvNbgyE=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Apr  3 12:17:54 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C1C71C14F71B;
	Wed,  3 Apr 2024 12:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712171874; bh=2VXDB2+/ZU2pYWSdd37cCuIGc2qzUxhgvv435gbafYI=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=TqLsXF2jjbJ82M3A7dbJvhShPGouxnbdsarT7z5yk6QkofZC2UBdlOCYB4jqgVVFH
	 GJMoPd9Toq0I7kNN0UEDD6BAbZJOHQsi+KRhx9zLZrn4LDDgdnC0xaCJ1e01iZ1i29
	 HMnF3pIAHY+oh13zjTZ5GLsG3xymzs9e0jxtHxtM=
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 5F0E5C14F73E
 for <bpf@ietfa.amsl.com>; Wed,  3 Apr 2024 12:17:53 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.646
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Nxz3qV0r3pX for <bpf@ietfa.amsl.com>;
 Wed,  3 Apr 2024 12:17:49 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com
 [209.85.166.43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id A05A1C14F71A
 for <bpf@ietf.org>; Wed,  3 Apr 2024 12:17:49 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id
 ca18e2360f4ac-7c8ad87b2acso5631139f.3
 for <bpf@ietf.org>; Wed, 03 Apr 2024 12:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712171869; x=1712776669;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6O8x5XbMosvHgx3XcJNw9fafYnyRxardz6tUod9ZJNg=;
 b=cVZ1mhE6DBlA/8wzRMnJYjQd8F6QmnbbKlMJyeAxDjRtDMVvKRBk6WGvwz+249xMDn
 /jLYKm5YIdWD//RG/1zufykaHudUhf3iVEcNWeYIPfbssmHdYY11I9a1kZ18H3k5Hn5d
 a1pXN6U94Z37Juh02+bzhXMjxQOOVD+izmFKqLazDgepJvbcE9kQTaa3Gw6g5lUQh1gQ
 NykMkLsUUyhD4ErxFaHV0ltYnZ+NA6JktgNDMQNRVUoXfJSjgEyyjmJa93usD5AnNIJY
 0l+UOukCbxU3DTWmgx9zIqLh7TREZWt7/YZMRP2y2vEQjx6tHSLe7vg6HSrnUxBrSwWU
 fzIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWw/znA4HE2RRghoJ79VW6YQ0pmI1EOKNJMDCNHvdPbm/yuLmkx/V1yZZz1bo6wGpxkDUcbUZTx2YtPhqI=
X-Gm-Message-State: AOJu0YzkGYDNOWwVr8hPp7IOY4oUcAiFfQiaVoO9oYTjEVQFpYkGZEns
 WAgUdEK0WT1Z/gepM9RkNJVhlnulwCNdewTNzttYCH8CSAxYeUbi
X-Google-Smtp-Source: AGHT+IGYwS3t+ElxeCIv+L+JVlsy9KR/Z8u4Dm5h8RNowzkn1msldMNg/In55MCVcasz/roeAHBKUg==
X-Received: by 2002:a05:6602:24ca:b0:7d0:d13c:a6b2 with SMTP id
 h10-20020a05660224ca00b007d0d13ca6b2mr524335ioe.21.1712171868852; 
 Wed, 03 Apr 2024 12:17:48 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
 by smtp.gmail.com with ESMTPSA id
 125-20020a6b1583000000b007d03b532743sm4193660iov.15.2024.04.03.12.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 12:17:48 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:17:46 -0500
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: 'Suresh Krishnan' <suresh.krishnan@gmail.com>, bpf@ietf.org,
 'bpf' <bpf@vger.kernel.org>
Message-ID: <20240403191746.GG2250@maniforge>
References: <89A0EA46-36E7-4E01-BC91-D07307A2291C@gmail.com>
 <20240403181608.GF2250@maniforge>
 <004901da85fa$fedc7570$fc956050$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <004901da85fa$fedc7570$fc956050$@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/BWFJaJUPi36zYKO0_W15Hlz2lwg>
Subject: Re: [Bpf] Provisional registration procedure
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============0735478857291168927=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
Message-ID: <20240403191746.XB5QrrFD290E8hmYXU9ZO8omxxC3uRHa-ca_Jvjo-ow@z>


--===============0735478857291168927==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oDFByl9o6uUERTVF"
Content-Disposition: inline


--oDFByl9o6uUERTVF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 03, 2024 at 12:13:21PM -0700, dthaler1968@googlemail.com wrote:
> David Vernet wrote:
> > On Tue, Apr 02, 2024 at 10:50:02PM -0400, Suresh Krishnan wrote:
> > > At the recently concluded IETF119 bpf WG meeting, I had asked a
> > > question to Dave about the Provisional registrations for BPF
> > > instruction conformance groups. Section 5.1 of draft-ietf-bpf-isa-01
> > > talks about Provisional registrations, but does not elaborate further.
> > > Specifically, I think it would be good to cover the following cases
> > >
> > > * Do we allow conversions from Provisional to Permanent? If so how?
> >=20
> > Would you mind please pointing to examples of other RFCs we can look
> > at to see how this is typically specified? My assumption was that we
> > would just initiate a standards action or IESG review to change the
> > state from Provisional to Permanent (meaning, that it was sufficient
> > to simply define the registration policies for Permanent and
> > Provisional), but it sounds like we need to be more explicit in our
> > language. It seems that RFC8126 section 4.13 doesn't specify a
> > standard method for converting between states:
> >=20
> > 4.13.  Provisional Registrations
> >=20
> >    Some existing registries have policies that allow provisional
> >    registration: see URI Schemes [RFC7595] and Email Header Fields
> >    [RFC3864].  Registrations that are designated as provisional are
> >    usually defined as being more readily created, changed, reassigned,
> >    moved to another status, or removed entirely.  URI Schemes, for
> >    example, allow provisional registrations to be made with incomplete
> >    information.
> >=20
> >    Allowing provisional registration ensures that the primary goal of
> >    maintaining a registry -- avoiding collisions between incompatible
> >    semantics -- is achieved without the side effect of "endorsing" the
> >    protocol mechanism the provisional value is used for.  Provisional
> >    registrations for codepoints that are ultimately standardized can be
> >    promoted to permanent status.  The criteria that are defined for
> >    converting a provisional registration to permanent will likely be
> >    more strict than those that allowed the provisional registration.
> >=20
> >    If your registry does not have a practical limit on codepoints,
> >    perhaps adding the option for provisional registrations might be
> >    right for that registry as well.
> >=20
> > Hmm, and looking at RFC 7595 [0] section 7.3 Change Control as a possib=
le
> > example, it specifies the following:
> >=20
> > 7.3.  Change Control
> >=20
> >    Registrations can be updated in the registry by the same mechanism as
> >    required for an initial registration.  In cases where the original
> >    definition of the scheme is contained in an IESG-approved document,
> >    update of the specification also requires IESG approval.
> >=20
> >    'Provisional' registrations can be updated by the original registrant
> >    or anyone designated by the original registrant.  In addition, the
> >    IESG can reassign responsibility for a 'provisional' registration
> >    scheme or can request specific changes to a scheme registration.
> >    This will enable changes to be made to schemes where the original
> >    registrant is out of contact or unwilling or unable to make changes.
> >=20
> >    Transition from 'provisional' to 'permanent' status can be requested
> >    and approved in the same manner as a new 'permanent' registration.
> >    Transition from 'permanent' to 'historical' status requires IESG
> >    approval.  Transition from 'provisional' to 'historical' can be
> >    requested by anyone authorized to update the 'provisional'
> >    registration.
> >=20
> > [0]: https://www.rfc-editor.org/rfc/rfc7595#page-9
> >=20
> > Dave, what do you think? I guess we should add a paragraph(s)
> > explaining the processes for this state machine?
>=20
> The ISA document says Permanent requires "Standards action or IESG
> Review" (the latter is a typo, should say "IESG Approval" to match RFC
> 8126 section 4.10 terminology).

Ack

> So converting to Permanent from nothing, or converting to Permanent from
> Provisional is currently the same... Standards action or IESG Review.
>=20
> Yes I can copy language from RFC 7595 (which I was also the editor of)
> to make it explicit.

Sounds good, thanks.

> > > * Do Provisional registrations timeout after a while if they are not
> > >   made Permanent?
> >=20
> > Dave? I'm not sure if this has been discussed or what the norm would be.
>=20
> It's up to us, there examples that time out, and examples that don't.
> (URI schemes being an example that don't.)   There is no requirement
> in RFC 8126 to have any discussion of timeout.  The lack of such
> discussion at in the document at present means that there is currently
> no timeout, i.e., like provisional URI schemes. If we did want a
> timeout, we'd have to add language to say that.
>=20
> Documents that are labeled as "experimental" are supposed to discuss
> timeouts, but things that are "provisional" generally do not.
>=20
> My current recommendation is to not have a timeout, but I don't feel
> strongly either way.

I agree

> > > * How do we remove Provisional registrations? Are the codepoints freed
> up?
> >=20
> > Also not sure if this has been discussed or what the norm should be.
>=20
> Absent language saying otherwise, currently you can convert a
> Provisional registration to Historical via the process for Historical.
> In the ISA spec this is currently "Specification required".  In the
> RFC 7595 example, this is instead stated otherwise:=20
>
> "Transition from 'provisional' to 'historical' can be requested by
> anyone authorized to update the 'provisional' registration."
>=20
> Here I would definitely recommend copying the RFC 7595 precedent, which
> makes more sense process wise.

Makes sense and sounds good to me as well.

Thanks,
David

--oDFByl9o6uUERTVF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZg2rWgAKCRBZ5LhpZcTz
ZAQoAP4ppGfjrHj0MWUoo9HHYb79+2SvgrUZvma+eafyAH0AggEAtSDUXBqpnD7C
gHJYMD1WdWvv1vcQ96B/a/94M0AhXwY=
=stGX
-----END PGP SIGNATURE-----

--oDFByl9o6uUERTVF--


--===============0735478857291168927==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============0735478857291168927==--

