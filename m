Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD829154458
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 19:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171606; cv=none; b=LW3uxS/Lk8/BRTKUizSZMeCpUUofyiEaRz6AAOtb9vGiCjzq3/QBnp5czoeKmKdaD97cVsFNuFcuWbGXYV8BdyuCD7tK8h/vJes6avBu3ZAQlOACXVVoHUPYwjIdPmOz3dsg/SK4PRVe9zx+y3JWdqQHgurEc1TqK67Oqkjdx2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171606; c=relaxed/simple;
	bh=P5JLL1wZALoFAenInh9If+l3tD2RNSqag2DEIo3rvvY=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=oInEd+aowGeVsFT0xoEJGBYvrKWaneOUiJAcR0l4r9/Gs2vDuhu56KES+3q8ljrwucd+TI7bN5YJZk0wkPBMFqc8D//sVKxgJIkiZe1ANvG+n8DhVXIbNnMMk4H7PxBVJdQdk57kX0fN7ajQiEJhYJ1SUM2Jml7ctGe6h/FhZSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=M6AIwJ0Z; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="M6AIwJ0Z"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2a226f8e44aso110460a91.0
        for <bpf@vger.kernel.org>; Wed, 03 Apr 2024 12:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1712171604; x=1712776404; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=YX3/O9R+I+AYLkKf6DhJG2HMAQ5Tp4vivB/8rAMnrzw=;
        b=M6AIwJ0Za8O+v6B4/3zAPCXZFPqocQEGxQ7DISyRVlxzp/X7Z/6DJckmKz5lEMBmAJ
         JQsrwrm0ycJiI9UKW6QS6d0+hJQ7SbQ/ljp+26YJZTwC4Oio1P8YWfCpyRc7aZ2NuxSN
         HcyNxpeua6Jdh7HGSiSMZzMxMOckI+aCE2a59q0Bu2VbD7WZCToZzOBR3/dF4nfflPMW
         vDNoqM9GIfJtvVP09DYLfBUnqctNrjhAT0BJbTfic4eEniOI5k+FdFBoHr/VHDJbF/jK
         vcwkEW9MTHhctH6QVRVurqe3iat6xU0UfveP9yCrMy6g0o8D66fUgZcck7vlxct3dqPX
         3xgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712171604; x=1712776404;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YX3/O9R+I+AYLkKf6DhJG2HMAQ5Tp4vivB/8rAMnrzw=;
        b=WFCgX/xPAHVLv6gKVnvG8tezTtd7aLhRRp73W2/aq1AGLV+jlaYZjBQDl25qy9QzlT
         m6RoLZE5RGeYwe35+7KWaj/wDwBe0nUvvfbzVfVe857mGNOGe4VgaCljgbksNHgdEyO/
         KWcetSwIGgwnNpYBK4zL8CkWzqWx24UpY9YagnU8GGES2AgYSPePKG05tYEZ4Twt218m
         Blpcm92XNzW1DWCFGOs7lcq8Pr+D7B7BeMzY2rY3lR3X5lqlVaVdKvJGyIqcHlfSBqrh
         pLa6we9ALzjje2gY7mmm/D9KakC7RJAaDsNAFkg7j5Cf8K7YSqw54tRw/7ezubJRdPk+
         /KiA==
X-Forwarded-Encrypted: i=1; AJvYcCWag6kh6/kBucrcthrEJOgiWcqsgQlm0Ajc710MOK/fCzanFxiGQM4m0Tos2DLoiueeGXD5NBTlR7xnBYu1g3Tn7lk6
X-Gm-Message-State: AOJu0YwIiI9epGE62zo/FO23ww8N35/ek4zM+Uvb1dkX9cE2V/YmRMqO
	nL7aoVgSLL4rOPufdExd/SMzr+Vl6wK1CFNcdBRywqwPEbcXObY5
X-Google-Smtp-Source: AGHT+IFXJuDjpUuoDzYBli3gKYD2pCpf5sQUYKanGFV5zdbK6caGG//fideYy+ZOYLisEnQb6D2ElA==
X-Received: by 2002:a17:90a:f510:b0:2a2:8065:899f with SMTP id cs16-20020a17090af51000b002a28065899fmr371303pjb.41.1712171603989;
        Wed, 03 Apr 2024 12:13:23 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net. [67.170.74.237])
        by smtp.gmail.com with ESMTPSA id cu24-20020a17090afa9800b002a28c14232esm36929pjb.55.2024.04.03.12.13.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2024 12:13:23 -0700 (PDT)
From: dthaler1968@googlemail.com
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>,
	"'Suresh Krishnan'" <suresh.krishnan@gmail.com>
Cc: <bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>
References: <89A0EA46-36E7-4E01-BC91-D07307A2291C@gmail.com> <20240403181608.GF2250@maniforge>
In-Reply-To: <20240403181608.GF2250@maniforge>
Subject: RE: [Bpf] Provisional registration procedure
Date: Wed, 3 Apr 2024 12:13:21 -0700
Message-ID: <004901da85fa$fedc7570$fc956050$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIQU/G14BwUxtC3bI+wb9EliJzWnQJKOcausNj4aVA=
Content-Language: en-us

David Vernet wrote:
> On Tue, Apr 02, 2024 at 10:50:02PM -0400, Suresh Krishnan wrote:
> > At the recently concluded IETF119 bpf WG meeting, I had asked a
> > question to Dave about the Provisional registrations for BPF
> > instruction conformance groups. Section 5.1 of draft-ietf-bpf-isa-01
> > talks about Provisional registrations, but does not elaborate further.
> > Specifically, I think it would be good to cover the following cases
> >
> > * Do we allow conversions from Provisional to Permanent? If so how?
> 
> Would you mind please pointing to examples of other RFCs we can look at to
> see how this is typically specified? My assumption was that we would just
> initiate a standards action or IESG review to change the state from
Provisional
> to Permanent (meaning, that it was sufficient to simply define the
registration
> policies for Permanent and Provisional), but it sounds like we need to be
more
> explicit in our language. It seems that
> RFC8126 section 4.13 doesn't specify a standard method for converting
> between states:
> 
> 4.13.  Provisional Registrations
> 
>    Some existing registries have policies that allow provisional
>    registration: see URI Schemes [RFC7595] and Email Header Fields
>    [RFC3864].  Registrations that are designated as provisional are
>    usually defined as being more readily created, changed, reassigned,
>    moved to another status, or removed entirely.  URI Schemes, for
>    example, allow provisional registrations to be made with incomplete
>    information.
> 
>    Allowing provisional registration ensures that the primary goal of
>    maintaining a registry -- avoiding collisions between incompatible
>    semantics -- is achieved without the side effect of "endorsing" the
>    protocol mechanism the provisional value is used for.  Provisional
>    registrations for codepoints that are ultimately standardized can be
>    promoted to permanent status.  The criteria that are defined for
>    converting a provisional registration to permanent will likely be
>    more strict than those that allowed the provisional registration.
> 
>    If your registry does not have a practical limit on codepoints,
>    perhaps adding the option for provisional registrations might be
>    right for that registry as well.
> 
> Hmm, and looking at RFC 7595 [0] section 7.3 Change Control as a possible
> xample, it specifies the following:
> 
> 7.3.  Change Control
> 
>    Registrations can be updated in the registry by the same mechanism as
>    required for an initial registration.  In cases where the original
>    definition of the scheme is contained in an IESG-approved document,
>    update of the specification also requires IESG approval.
> 
>    'Provisional' registrations can be updated by the original registrant
>    or anyone designated by the original registrant.  In addition, the
>    IESG can reassign responsibility for a 'provisional' registration
>    scheme or can request specific changes to a scheme registration.
>    This will enable changes to be made to schemes where the original
>    registrant is out of contact or unwilling or unable to make changes.
> 
>    Transition from 'provisional' to 'permanent' status can be requested
>    and approved in the same manner as a new 'permanent' registration.
>    Transition from 'permanent' to 'historical' status requires IESG
>    approval.  Transition from 'provisional' to 'historical' can be
>    requested by anyone authorized to update the 'provisional'
>    registration.
> 
> [0]: https://www.rfc-editor.org/rfc/rfc7595#page-9
> 
> Dave, what do you think? I guess we should add a paragraph(s) explaining
the
> processes for this state machine?

The ISA document says Permanent requires "Standards action or IESG Review"
(the latter is a typo, should say "IESG Approval" to match RFC 8126 section
4.10
terminology).

So converting to Permanent from nothing, or converting to Permanent from
Provisional is currently the same... Standards action or IESG Review.

Yes I can copy language from RFC 7595 (which I was also the editor of)
to make it explicit.
 
> > * Do Provisional registrations timeout after a while if they are not
> >   made Permanent?
> 
> Dave? I'm not sure if this has been discussed or what the norm would be.

It's up to us, there examples that time out, and examples that don't.
(URI schemes being an example that don't.)   There is no requirement in RFC
8126
to have any discussion of timeout.  The lack of such discussion at in the
document
at present means that there is currently no timeout, i.e., like provisional
URI schemes.
If we did want a timeout, we'd have to add language to say that.

Documents that are labeled as "experimental" are supposed
to discuss timeouts, but things that are "provisional" generally do not.

My current recommendation is to not have a timeout, but I don't feel
strongly
either way.
 
> > * How do we remove Provisional registrations? Are the codepoints freed
up?
> 
> Also not sure if this has been discussed or what the norm should be.

Absent language saying otherwise, currently you can convert a Provisional
registration
to Historical via the process for Historical.  In the ISA spec this is
currently "Specification
required".  In the RFC 7595 example, this is instead stated otherwise: 
"Transition from 'provisional' to 'historical' can be requested by anyone
authorized to
update the 'provisional' registration."

Here I would definitely recommend copying the RFC 7595 precedent, which
makes more
sense process wise.

Dave

