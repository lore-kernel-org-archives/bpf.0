Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A597115351B
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712168196; cv=none; b=oO4RvzxiIn2Bf7XWbX2guu23x1TzuLtXbKnAyfZyylXrnX5cj7osK1Vb0UP8PPpyRhHt8KnkYmn4GLtFzHHIQIy4Y9ECcNIli1lKYSklYalAaE8Hi9nl1L/zse08FGbCYAbNTzggnVVIxo/x9AfJ1UJCgbXXy/qUz1J4JverS24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712168196; c=relaxed/simple;
	bh=9TrjIG0azVxAMgoB0YdgrgOi3PkTRxE46LX23chitOM=;
	h=Date:From:To:Cc:Message-ID:References:MIME-Version:In-Reply-To:
	 Subject:Content-Type; b=ZRTxfhMvHF737EZB3NQnPl3fXFx+u9RsW52huhw04yGjKE+W2AL9sMBbM9daJz4yAlsPmBpQnWfxCzWcPZJ7b5wCuTGVCUNS/arjzwxN+nRCi/U/efeR8BefyAd97KFllNygxyE3AZIem1zw0QS/p+NcH6wxmwaajMaHAw69s74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=QgBq28qm; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=OA1yu4JK; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=manifault.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="QgBq28qm";
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="OA1yu4JK"
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 0D38BC14F714
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712168194; bh=9TrjIG0azVxAMgoB0YdgrgOi3PkTRxE46LX23chitOM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=QgBq28qm9PAyTkotOibziumwMyvGFIeuVOl8px+0aQ3hwtfVTH0UoIztVCY45vT3e
	 twKNBtzNsc+ot7VcShK73P4JxK7IxvRQi3N1xKzszRneQIRmB5pM46f7WdOwOLBPkc
	 pzDr40euHMMWTcKNrdzG0QA7sjMSIwuww0aEjim8=
X-Mailbox-Line: From bpf-bounces@ietf.org  Wed Apr  3 11:16:33 2024
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id C52E5C14F6BD;
	Wed,  3 Apr 2024 11:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712168193; bh=9TrjIG0azVxAMgoB0YdgrgOi3PkTRxE46LX23chitOM=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
	b=OA1yu4JKVrXksz+JAYiENp8NIhrzWEle5lCDxQLckjt+MpqDk7YG3FqmQWjCbyDzd
	 LBKLVPhaMjzw9YmATyoxe11HGZ3P6bpl4GPj9r3kaPxWl2Skoo8BLIrZYuOxdt7U5g
	 uBDnUDH7B5Zld6BiPo8lhRzNYrT1ofwceHcP/4gA=
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id BDFCEC14F5FD
 for <bpf@ietfa.amsl.com>; Wed,  3 Apr 2024 11:16:32 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.646
X-Spam-Level: 
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5IVi8WdVPVQm for <bpf@ietfa.amsl.com>;
 Wed,  3 Apr 2024 11:16:29 -0700 (PDT)
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com
 [209.85.166.179])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 70209C14F704
 for <bpf@ietf.org>; Wed,  3 Apr 2024 11:16:11 -0700 (PDT)
Received: by mail-il1-f179.google.com with SMTP id
 e9e14a558f8ab-369f3082524so363915ab.1
 for <bpf@ietf.org>; Wed, 03 Apr 2024 11:16:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712168170; x=1712772970;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+8Ps8W7ruMBeIYslHjVNrxzyqmX81txJxIlFRlmu2EY=;
 b=Q4cw1UMUB9doTTf8SXULK0LNE8PAxob+21/891ugkH5P5qNPqU8sJCwxusNM1C+CGc
 J79rlmVCI0JYgowbYgjl9P3KjWg3W8L4tu/GxDNzQHoN8p0LU5iiFoPUyp9hoAs76KGf
 O4bDcqUGU4UNx8JplJQdEII5MFNqBOE4uZuD5FfCwrI/jgzTlL9l0t+taHhUvU/gxKgk
 FqibIVDCEqaQfFy3iUiKHp0sWmQ0N2z84bolT4UpJapo6hgwwftQPjU5B6GKuI8jO3C0
 cYYNc9wiW5CJeDtphHRrBuV9N+4pAqQC2Q7UgrXbgjbTfzPVwUfBbzhBADkgE44Kcg2b
 D8Zw==
X-Gm-Message-State: AOJu0YySGyo9ZEpi3BhnU45gxgPmxdnbaURbhaAVJH+LscD8dANHDCJ7
 JEJo0Wmj8W1kcwDut0Sx9s38rMbErzB31VlKW4gNB7zncl0R7NGi
X-Google-Smtp-Source: AGHT+IEzbAgf9GS7pYefvOAhUzGOPi9cWkA6FmaVK36St6jNp9UTmoUwj4N5iiRKvL+lQZPucu6rtA==
X-Received: by 2002:a05:6e02:3683:b0:366:bcbd:ed84 with SMTP id
 cj3-20020a056e02368300b00366bcbded84mr620807ilb.15.1712168170434; 
 Wed, 03 Apr 2024 11:16:10 -0700 (PDT)
Received: from maniforge (c-76-136-75-40.hsd1.il.comcast.net. [76.136.75.40])
 by smtp.gmail.com with ESMTPSA id
 i15-20020a056e02152f00b00368825f7a15sm4010350ilu.72.2024.04.03.11.16.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 11:16:10 -0700 (PDT)
Date: Wed, 3 Apr 2024 13:16:08 -0500
From: David Vernet <void@manifault.com>
To: Suresh Krishnan <suresh.krishnan@gmail.com>
Cc: bpf@ietf.org, bpf <bpf@vger.kernel.org>
Message-ID: <20240403181608.GF2250@maniforge>
References: <89A0EA46-36E7-4E01-BC91-D07307A2291C@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <89A0EA46-36E7-4E01-BC91-D07307A2291C@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/i8bmysZbaC514MC0abApqn6Z3Tw>
Subject: Re: [Bpf] Provisional registration procedure
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: multipart/mixed; boundary="===============8294365112633858510=="
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
Message-ID: <20240403181608.xhbHosf_qGsZxHu9Lf46q26pgmjBNLj-5LhsdeVlIBs@z>


--===============8294365112633858510==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jTilkmgf0kWnvbB+"
Content-Disposition: inline


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


--===============8294365112633858510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf

--===============8294365112633858510==--

