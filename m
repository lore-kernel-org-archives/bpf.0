Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0CD9152DE9
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171871; cv=none; b=l8F6g+PnkE257t8oBPQsfrU1VnoP+22R5MU3Ibq6t1qAei2pVw1oYIRRjs/xZJm0RT5cUncqeX9dOo9sBOW5ahWuIED7hBYcZMUnw8F/SahHhUqWxrivac7V5+uwhK0issQx1Rvx/HU/c5pZjYie/8DhXu0+VuC0n/2w/eJ/ztU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171871; c=relaxed/simple;
	bh=IAI0Rn8DzNvFDfsdemBE6epokGITqRlM/u7f8tNBO5E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nsPLGFe83BU0YBnh2qimwrcthlBrPE+pboS4ePvtrOyTM2E8Q7G4bJJtaenE8zee8mhU3JOOCKpYkNmCV/MhT7BGIAGG0zAdfNpwJxAY3t0A45lItlgYz7tr1av2djmAJdWspywRC4YFgt0NBCK0ycla+1yixlEGovXxOm6XVhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-7d33ccdb531so10418339f.0
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 12:17:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712171869; x=1712776669;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6O8x5XbMosvHgx3XcJNw9fafYnyRxardz6tUod9ZJNg=;
        b=pLBx672vZG6/cCpdHQscrb0JoMYEEq0zI6AI5ZehXXBSffp2GVmSKfJ4d4jadIagvv
         yMjOM8/lbv81zFdSX0F+VOuyJiicRPEYgBuCReek4sCqwhXqP8P+mk1zYZAawYriSaLk
         innz/bX86h4cy4DOlLai9e0IzZ33lNSlqN19/OnL8CbJmGN2amXF6XxExQCjkMmmPtBE
         Fwl2d67NlnC7bxuY2W0Q1CJvWWQN7/Gqypqluvm+6ieCv1sO4esSHWQr+iFtbL0Am4ZE
         ZPmzLwpPduhvp3lwyoFzYklbtGmR9zrC15F6m05XsV8yZIzesIvS/HKKfr/MkNs7UP+V
         EYXA==
X-Forwarded-Encrypted: i=1; AJvYcCW6cKjDt5wZXc5Q2P4IV3qD+9rHii6KKnePDbeHV5GcU/HzIlRL27cro1/LMs7BWl861+yiWGvwWw6Sbzbjm5CStgyg
X-Gm-Message-State: AOJu0YwjwKnoAzT/B8xMR9htIZViJz++5E8VRufKo1+saArkWJ04t7jQ
	aFzl2mudvPTsJDn7absQBT6aPeR6kUPIO5g9egbFrJvP/wGv9owc
X-Google-Smtp-Source: AGHT+IGYwS3t+ElxeCIv+L+JVlsy9KR/Z8u4Dm5h8RNowzkn1msldMNg/In55MCVcasz/roeAHBKUg==
X-Received: by 2002:a05:6602:24ca:b0:7d0:d13c:a6b2 with SMTP id h10-20020a05660224ca00b007d0d13ca6b2mr524335ioe.21.1712171868852;
        Wed, 03 Apr 2024 12:17:48 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id 125-20020a6b1583000000b007d03b532743sm4193660iov.15.2024.04.03.12.17.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 12:17:48 -0700 (PDT)
Date: Wed, 3 Apr 2024 14:17:46 -0500
From: David Vernet <void@manifault.com>
To: dthaler1968@googlemail.com
Cc: 'Suresh Krishnan' <suresh.krishnan@gmail.com>, bpf@ietf.org,
	'bpf' <bpf@vger.kernel.org>
Subject: Re: [Bpf] Provisional registration procedure
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
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="oDFByl9o6uUERTVF"
Content-Disposition: inline
In-Reply-To: <004901da85fa$fedc7570$fc956050$@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


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
