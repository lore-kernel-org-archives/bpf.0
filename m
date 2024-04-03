Received: from mail.ietf.org (mail.ietf.org [50.223.129.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078E2154458
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 19:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=50.223.129.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712171613; cv=none; b=TEOpSUkE0D9RJyFNlvbGjCnEhikSOAXm//gS0TFIOlik7gXpak5N5pq15niQyqSJmXavSSWM+8wAAN3yeG3noqLN2vZP8Nipvur8IYiB0OtYK+2ml6LAfHamm4QU85nbuoUhKkQY+bntlMWO7DTCFIJc7v2ZjPKOUup5eZR7w5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712171613; c=relaxed/simple;
	bh=LoK8D0vAxv8dIilTzZzgICzC88q/wki0N31AsJLi+Fw=;
	h=To:Cc:References:In-Reply-To:Date:Message-ID:MIME-Version:Subject:
	 Content-Type:From; b=rNmzdNPwq5YnMNO+RBCgp5DbMyAh3rQJJSS6IRdCBZmsiTvbLS89kUKDe+JtCr3BDiQa2ir/h0aIuaSsaqeTJPYjkucM0ATnTCLuYtvyGwCx1Bh5h/9JYvgG5tLQ3EPce2KebmkMTP9ns7gn7W5lcBn1qCeIRaKLGwOTsb+5/5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=xBW0XfX8; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=npN455fh reason="signature verification failed"; dkim=fail (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=IZgK89zz reason="signature verification failed"; arc=none smtp.client-ip=50.223.129.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="xBW0XfX8";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="npN455fh";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="IZgK89zz"
Received: from ietfa.amsl.com (localhost [IPv6:::1])
	by ietfa.amsl.com (Postfix) with ESMTP id 5E0DFC1519AC
	for <bpf@vger.kernel.org>; Wed,  3 Apr 2024 12:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1712171611; bh=LoK8D0vAxv8dIilTzZzgICzC88q/wki0N31AsJLi+Fw=;
	h=To:Cc:References:In-Reply-To:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=xBW0XfX8vXV9t5D5NetplRtdustR1/jcss7Ta3dzfNGIVoEjK+Y0EeJd2N5OmxW3k
	 pdWgG6K7PLzsZkFmIYS303f1g1mod/ctBlYf8ZDZchh//DMuZE0uqKB6yvbL97tEP8
	 aSoev2tQA3SdD4VJTA+YdjeNEvTiy6X/senmIDaw=
Received: from ietfa.amsl.com (localhost [IPv6:::1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1880EC14F73E;
 Wed,  3 Apr 2024 12:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1712171611; bh=LoK8D0vAxv8dIilTzZzgICzC88q/wki0N31AsJLi+Fw=;
 h=From:To:Cc:References:In-Reply-To:Date:Subject:List-Id:
 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe;
 b=npN455fh4IV2zdW8blBTYIq9kpZSh3NUdFmsMy8q9xpk0qDf8N+oul7DYh/g3JMDS
 OSMeOpN7IrfRb3Jj+dw4MRRs7CVz5LkiSJG3EHiq0SaZHSZch8SXk0VT4qsBWymUaT
 ZWBxcFMTT2pH6+0kcnkrAU1+I8Rn3tWEg7qGyrl8=
Received: from localhost (localhost [127.0.0.1])
 by ietfa.amsl.com (Postfix) with ESMTP id 1C48AC14F5E3
 for <bpf@ietfa.amsl.com>; Wed,  3 Apr 2024 12:13:29 -0700 (PDT)
X-Virus-Scanned: amavisd-new at amsl.com
X-Spam-Flag: NO
X-Spam-Score: -1.845
X-Spam-Level: 
Authentication-Results: ietfa.amsl.com (amavisd-new); dkim=pass (2048-bit key)
 header.d=googlemail.com
Received: from mail.ietf.org ([50.223.129.194])
 by localhost (ietfa.amsl.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a-E0dlTjje5B for <bpf@ietfa.amsl.com>;
 Wed,  3 Apr 2024 12:13:25 -0700 (PDT)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com
 [IPv6:2607:f8b0:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by ietfa.amsl.com (Postfix) with ESMTPS id 08109C14F6A9
 for <bpf@ietf.org>; Wed,  3 Apr 2024 12:13:25 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5cddfe0cb64so187285a12.0
 for <bpf@ietf.org>; Wed, 03 Apr 2024 12:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1712171604; x=1712776404; darn=ietf.org;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=YX3/O9R+I+AYLkKf6DhJG2HMAQ5Tp4vivB/8rAMnrzw=;
 b=IZgK89zzIB4Nf2PFYfcpO2obBIJWoThWmv1HHoKKLXCyO+drQdLyIJT8gXdSRQrq5S
 To4gJcHilbjDGyYQwNdASn4kMdnKI6hk8qn15lSpjgbG0xj/gtBBbNzs81zwTLh4Iuc8
 OJZQt4pYD2KUcXdPSyeEx91yfX6hMgcii8Ty3j3oe1AsrCs2gI+xBOm5/jiWWgEwcLNC
 EMV5k0vxsoxWC9rTUhZS9cfZukYz+MxgBLpJ/PYN5mJE/J5W0bzi1TJCI+8whAHDigie
 Z6x2M092c8wnMSt9qPbfC+IMFYtaNRb5YoEVPX2b/T9BnoeO7LNEEj5yrvyJtD1YvUVg
 QmSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712171604; x=1712776404;
 h=content-language:thread-index:content-transfer-encoding
 :mime-version:message-id:date:subject:in-reply-to:references:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YX3/O9R+I+AYLkKf6DhJG2HMAQ5Tp4vivB/8rAMnrzw=;
 b=MhVOOlBsNNZEwojp2cjMjj21pnVIRcXT6UAP464kU0A1sUm1g9bhsTN7Z6Sr7SI382
 SxGgWa4nrQNphbZVyD+cRTJFmJ5bVhpF2KNG+jxXzBykTawrjo21sNQMHbM5ndXokyAT
 ujcveKuzPc1WvkPcu4k+r0UJUwDfyEid+RFMN/jd9JK6aE5wdTeuLCMVUhqeg9Q6/WtS
 CpZyBA2Y64XMG7yiz8SmL9H48wuxDO9Oibl2N7OacCtDw1R/mOoePEw37pUQkf1AiBH9
 g2ZZiV67G5Y/0cu++FUsP2vrOP60q60B78MAk+wghlGfmTFbZq1r1IJI/T9K+du/XY4p
 /5mg==
X-Gm-Message-State: AOJu0YyfzwzdeBeiyDXY8J0suEOTo1jOPoYtabvn7Fp42FMQYKsFN61c
 TJbXEJ7KajdwK3ZYglEXn/umWStWw8U9+lz1lwJIkRwv2DD7GY4N5tt7M2PsKac=
X-Google-Smtp-Source: AGHT+IFXJuDjpUuoDzYBli3gKYD2pCpf5sQUYKanGFV5zdbK6caGG//fideYy+ZOYLisEnQb6D2ElA==
X-Received: by 2002:a17:90a:f510:b0:2a2:8065:899f with SMTP id
 cs16-20020a17090af51000b002a28065899fmr371303pjb.41.1712171603989; 
 Wed, 03 Apr 2024 12:13:23 -0700 (PDT)
Received: from ArmidaleLaptop (c-67-170-74-237.hsd1.wa.comcast.net.
 [67.170.74.237]) by smtp.gmail.com with ESMTPSA id
 cu24-20020a17090afa9800b002a28c14232esm36929pjb.55.2024.04.03.12.13.22
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Apr 2024 12:13:23 -0700 (PDT)
X-Google-Original-From: <dthaler1968@gmail.com>
To: "'David Vernet'" <void@manifault.com>,
 "'Suresh Krishnan'" <suresh.krishnan@gmail.com>
Cc: <bpf@ietf.org>,
	"'bpf'" <bpf@vger.kernel.org>
References: <89A0EA46-36E7-4E01-BC91-D07307A2291C@gmail.com>
 <20240403181608.GF2250@maniforge>
In-Reply-To: <20240403181608.GF2250@maniforge>
Date: Wed, 3 Apr 2024 12:13:21 -0700
Message-ID: <004901da85fa$fedc7570$fc956050$@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIQU/G14BwUxtC3bI+wb9EliJzWnQJKOcausNj4aVA=
Content-Language: en-us
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/wQ3bnAhKYc7jEMX92G6GKOxzuiY>
Subject: Re: [Bpf] Provisional registration procedure
X-BeenThere: bpf@ietf.org
X-Mailman-Version: 2.1.39
Precedence: list
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf/>
List-Post: <mailto:bpf@ietf.org>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: bpf-bounces@ietf.org
Sender: "Bpf" <bpf-bounces@ietf.org>
X-Original-From: dthaler1968@googlemail.com
From: dthaler1968=40googlemail.com@dmarc.ietf.org
Message-ID: <20240403191321.K4HdxZNt4MikAOYEmlfSs15VCMj7CUAN5KDWczuf9SM@z>

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

-- 
Bpf mailing list
Bpf@ietf.org
https://www.ietf.org/mailman/listinfo/bpf
