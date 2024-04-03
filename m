Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F7152DE7
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168173; cv=none; b=PdKMrcWMUcL/QcmrvUFxwlW5R+KB4HE6T26mq87WjBNtNMIj6uhXKHNKDkCfv/stTZHI2pLXjfWlCMXcDzid8OUxxZ81O9eejXVeQeXJaY9dv089FmGA/D35z1RdhMeaQB1H2FJxTFgEunpZ5TlPkXX1+iNd7n+bx9OwLizxA9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168173; c=relaxed/simple;
	bh=9e5yHmxMzlQKCThGo3pSqzpK0TqTf2az6I1GePU4v1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BYU232GLQUpYuCteGNHIPt0wrU1uXcK0u6WvZZosOUv/biSPY0bL4te1bpRrxnL8WSnngk7qb6QJ42l1oOJCawMxEIDVbIUj6ErxiQCoyJgpc8MwLaUhyCDuDyGT78DpBNAscKc+CYGb7xULZ4tiytqVgASz98nxHt7AF6h+b2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7c8dd755793so6075339f.0
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 11:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712168170; x=1712772970;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+8Ps8W7ruMBeIYslHjVNrxzyqmX81txJxIlFRlmu2EY=;
        b=huEJ7OXkbALkhohNh11Fy7xKaJIQy2CW8DsUFNtk6nTwWqnh0tu2yu+LOLR66kvn/I
         mUD819ungswPtBpmPpTPUI5Otz7kuW2n2nYmwhRAg3scf4517MeALfWBtaCyQ8meOoaO
         3bwIHFZbiVDLpEt7Vmm+QG4DV6YWf+5YGuBOJcyyOfoWUOHdAeSsyRcgqc0qyiB1c4ng
         cZ8pwUyr4hxtw8fS49eZ+RQtSj6fKZCmubZ0/c/wlfTaz/HE+j8Cymq5DRM7hwzPyxFy
         Hj95dayAfnRS3skqOo707Wg/1iPIPasLSolAokr+7o/yFOWTgjMD45bbybpoA1JDLyDq
         kajw==
X-Forwarded-Encrypted: i=1; AJvYcCWfEWSnc85TFcnTtwdz9ipIMyexBKI8je8gS7NuG+hoYykPnpv3VvtFtMCBt+4p6Rc8yI6OeG40EtI9Yc1W3cVY2Rhy
X-Gm-Message-State: AOJu0YwbpmhVYB6gATFtjVhcSL8WgkjD+VraVm+IL9vxdnL3W/NmXtEK
	sq/4nEAP5sRVRzIL6sAoBXkwC9yMajPULi5aT4nvl5KIsKMPy83HnuJPvXTx
X-Google-Smtp-Source: AGHT+IEzbAgf9GS7pYefvOAhUzGOPi9cWkA6FmaVK36St6jNp9UTmoUwj4N5iiRKvL+lQZPucu6rtA==
X-Received: by 2002:a05:6e02:3683:b0:366:bcbd:ed84 with SMTP id cj3-20020a056e02368300b00366bcbded84mr620807ilb.15.1712168170434;
        Wed, 03 Apr 2024 11:16:10 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
        by smtp.gmail.com with ESMTPSA id i15-20020a056e02152f00b00368825f7a15sm4010350ilu.72.2024.04.03.11.16.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Apr 2024 11:16:10 -0700 (PDT)
Date: Wed, 3 Apr 2024 13:16:08 -0500
From: David Vernet <void@manifault.com>
To: Suresh Krishnan <suresh.krishnan@gmail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Subject: Re: Provisional registration procedure
Message-ID: <20240403181608.GF2250@maniforge>
References: <89A0EA46-36E7-4E01-BC91-D07307A2291C@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jTilkmgf0kWnvbB+"
Content-Disposition: inline
In-Reply-To: <89A0EA46-36E7-4E01-BC91-D07307A2291C@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--jTilkmgf0kWnvbB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 02, 2024 at 10:50:02PM -0400, Suresh Krishnan wrote:
> Hi all,

Hi Suresh,

Thanks for reading over the document.

> At the recently concluded IETF119 bpf WG meeting, I had asked a
> question to Dave about the Provisional registrations for BPF
> instruction conformance groups. Section 5.1 of draft-ietf-bpf-isa-01
> talks about Provisional registrations, but does not elaborate
> further. Specifically, I think it would be good to cover the
> following cases
>=20
> * Do we allow conversions from Provisional to Permanent? If so how?

Would you mind please pointing to examples of other RFCs we can look at
to see how this is typically specified? My assumption was that we would
just initiate a standards action or IESG review to change the state from
Provisional to Permanent (meaning, that it was sufficient to simply
define the registration policies for Permanent and Provisional), but it
sounds like we need to be more explicit in our language. It seems that
RFC8126 section 4.13 doesn't specify a standard method for converting
between states:

4.13.  Provisional Registrations

   Some existing registries have policies that allow provisional
   registration: see URI Schemes [RFC7595] and Email Header Fields
   [RFC3864].  Registrations that are designated as provisional are
   usually defined as being more readily created, changed, reassigned,
   moved to another status, or removed entirely.  URI Schemes, for
   example, allow provisional registrations to be made with incomplete
   information.

   Allowing provisional registration ensures that the primary goal of
   maintaining a registry -- avoiding collisions between incompatible
   semantics -- is achieved without the side effect of "endorsing" the
   protocol mechanism the provisional value is used for.  Provisional
   registrations for codepoints that are ultimately standardized can be
   promoted to permanent status.  The criteria that are defined for
   converting a provisional registration to permanent will likely be
   more strict than those that allowed the provisional registration.

   If your registry does not have a practical limit on codepoints,
   perhaps adding the option for provisional registrations might be
   right for that registry as well.

Hmm, and looking at RFC 7595 [0] section 7.3 Change Control as a
possible xample, it specifies the following:

7.3.  Change Control

   Registrations can be updated in the registry by the same mechanism as
   required for an initial registration.  In cases where the original
   definition of the scheme is contained in an IESG-approved document,
   update of the specification also requires IESG approval.

   'Provisional' registrations can be updated by the original registrant
   or anyone designated by the original registrant.  In addition, the
   IESG can reassign responsibility for a 'provisional' registration
   scheme or can request specific changes to a scheme registration.
   This will enable changes to be made to schemes where the original
   registrant is out of contact or unwilling or unable to make changes.

   Transition from 'provisional' to 'permanent' status can be requested
   and approved in the same manner as a new 'permanent' registration.
   Transition from 'permanent' to 'historical' status requires IESG
   approval.  Transition from 'provisional' to 'historical' can be
   requested by anyone authorized to update the 'provisional'
   registration.

[0]: https://www.rfc-editor.org/rfc/rfc7595#page-9

Dave, what do you think? I guess we should add a paragraph(s) explaining
the processes for this state machine?

> * Do Provisional registrations timeout after a while if they are not
>   made Permanent?

Dave? I'm not sure if this has been discussed or what the norm would be.

> * How do we remove Provisional registrations? Are the codepoints freed up?

Also not sure if this has been discussed or what the norm should be.

>=20
> I have opened an issue on the issue tracker for this at
> https://github.com/ietf-wg-bpf/ebpf-docs/issues/113 . Comments are
> welcome and greatly appreciated.

Ack, thanks. Whatever we decide, we'll update the GitHub issue
accordingly.

Thanks,
David

--jTilkmgf0kWnvbB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCZg2c6AAKCRBZ5LhpZcTz
ZBVxAQCbx9+gYxTWcVmAwpJhPdxLRnQgmOnkf6ZNVidz0q425AD/cISChjz3gyzg
IHaNUJdHkL+tipBJQ3/XqNn2EAqJbQc=
=7+7i
-----END PGP SIGNATURE-----

--jTilkmgf0kWnvbB+--
