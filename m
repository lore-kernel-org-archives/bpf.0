Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793400002;
	b=o0E8pplLTipX6hVuit+CefFcgwrY8iiysWGBhCs388tGvvdVoO2mIMzCvY4Y+x8f7AXZ
	 TpX+ZgpBJ5IDPEZv9XVU5Y/G19A2v44jBTCzByjAAiIrY/DT4MLRk51gKOuy8KESS5+LJ
	 FNZr7TRHsqNOpmQGqsBnCbQLK9mS98t+F+uP8pwB76SFOBWE6XgbIhIctBBboDiKK4kip
	 iysdb3FoqUGq8+uY0ZkMxCAhCnSc9i/yx+c4svJF1zAUB6Yq5M9DVmkENQiBPYS6ZyyWV
	 DSPGun9ifkK2i/RHSQR4yajHY4gWlgS3TWvUvxfrXBzN0Y+eVpMsF7yZpP1WgAnVYFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793400002;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=IvrYDsDGEINT4IrEgoyRx8W+HsklNrTpgW57vKvyOhc=;
	b=xfgjifmNfD+CZkVFQ2aGLcAuP3V9lEM7QxDIGh0lGxOQg6aYjwciJC71yurUNzrursh5
	 WgO01tbqZ0kMJm1RPwSxv4hOBsb1PGxXmeIbV0lMjdSJRsqKcHxe/hF9ClvrFwBny2fda
	 DtjQ8fiaw/G0s2BfogZseaO0Scdj/8z6fyX73A0PRQsFHGeTomwtkq7HhoY7NxAgBmF8J
	 PYdurU9FAPOXMukCcVBp+eOxae2A/fHpTnuqrD4/zNwQzbgnU37qLm0ZsIFWIT4rvNd5H
	 QQCE+Wlcfm70+7r5apkbEeFGjqJCgBKfcli4Fz6qnMGB+8dXpQngGcE0KQD1tT1lYpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=kroah.com;
	spf=pass smtp.mailfrom=kroah.com;
	dkim=pass header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=Kyw+Dpe6;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=q4dDQMk0;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAAAF606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 22:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAAAF606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kroah.com header.i=@kroah.com header.a=rsa-sha256 header.s=fm2 header.b=Kyw+Dpe6;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=q4dDQMk0
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id E5575EC01E4
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 18:40:00 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Fri, 30 Oct 2026 18:40:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1793400000; x=1793486400; bh=IvrYDsDGEI
	NT4IrEgoyRx8W+HsklNrTpgW57vKvyOhc=; b=Kyw+Dpe6+YZRH4pHG0jjawoEvP
	4bXVynfOt/ZZFHuyqc/naJkmXLfuekkgUnANDH7YRy/EyDxOM/pTk6B4eQbEJ8Pd
	B2969zvQVIZ7bCBgCr4rvA7qiC8ho+EaCV41/FcT321i6+zfbRakJJQHzX08gAE6
	VjcA28x03XmQWUO9zCM0Ng+RkutaQR78s50oqr8eZRAb92rZxoKpiPxoiB4bPBtk
	ACB+QixGOAgMuJV70PRtGNithdy9o9t5x0N6Y/48yBR9YZwDRcmOtxA4PBExT/qa
	r1blNPEmLOCs5AnqwO50NGD+lO9LKiqMLKSvxy45ZtptH1/TXDT8W4mgmFzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1793400000; x=1793486400; bh=IvrYDsDGEINT4IrEgoyRx8W+HsklNrTpgW5
	7vKvyOhc=; b=q4dDQMk01vaA1P6KeWba0PtoVK1l6xqcoop0Lqiwig/TQMP/MnL
	y/y2yUKIco0yzMn/Wn0fb/77am3xDTXcJf9FJGOBL3d3lTsAKNnqwLoLfb6BVfGW
	wncVDiO0vwSkZcnMdb7WinjsIu1LvCWa8GDQvaRL5HuHMIeiIClIgDP3SdMk3HG4
	4PUEnYsKpOeM3alsHRCHK1A8v2UJV1IkOwwrC6xs+dCvBMtJcCRLoQgkf03gGdeb
	ij7BjsmtZp4I9P/t3YleItP4hAUl4N1ZCqFiyHpJqM8naEaH49JPwo4DVTmSH2Vu
	UYCVzkUiyhR/tmy/z6U6aWG7CjM/s7D1D5g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=kroah.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793400000; d=kroah.com;
	mf=PGdyZWdAa3JvYWguY29tPg==; rt=PGJwZkB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:Km6VLyIjLwTtkuRkwahHvYs6F8IbJnBPFQbmGGs98TR2moA
	KuRoPKRxEbmSjWw2KQDwRY7v83OfbgI10YQVjvXjaJ/OQj+72B1YROq6js9q8PVX
	Kt+pcneVd5R/M/HJW9SXSGssXJwwgLNSU9zb1pudjedPseDhw70SIQDsHGv4fpk1
	BonN1bE3EcNfMN0Ar+qtOPKZO0O4l2XGu+IAhe8puyUIXCzyzKuldemF9jkwVECJ
	fx0OoOpNK5q/nwMr76ZYgWLeQVaK3jbQf76uO4hNrxQjprhFDkPgYZ0QYh7LvMNb
	8ffwnfSkWS7QqciFchXWtBElPxrA1kLPkbLpXBw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-disposition,content-type,date,feedback-id,from,
	in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:rKeJFYxtM7sOmW/uzwYK217Em0jQdY6bhp/btz9jINw=:IvrYDsDGEINT4IrEgoyRx8W+HsklNrTpgW57vKvyOhc=;
X-ME-Sender: <xms:wBzlai2y3JYl6EufHhUvox6psc9R-Nmd9KB72LWBpK1l3oWFu9wFNQ>
    <xme:wBzlamqINv7lc3bXJ4uYPLVEFD6CDzV9FX0YA2KuJ4HPQ9Hx6ZkLkN40PBHYiIVct
    aP9dvuxB3-_aMatfDHtR0kOAEGM6wHhTeUJDCZMtdZhArvPIaw>
X-ME-Received: <xmr:wBzlaqLnCTDXJd2vFxMa4_UVVfHk7evugGHEa0Yx0x_huHHqKoyIzS0OTiOYN48FJpCk1fL7TeRgTgMmftIWNlV90KaSZxCD5ScF-uYVhy8>
X-ME-Proxy-Cause: dmFkZTEaLmNt6L7IJ40MVc9fCd3rtA8Onb2LlC3OVGETURzJf9Jvt2NWmdMPydwVDXms6I
    JlPJlfKVWms0T8D7zxFFAgkPEAyCIpjjkggAcp2tOQYlUKwYloyC+95xeYqTGycK+YgZ6I
    l2VDt6Y08FSBBXzhC8jwVOjqGOpX+Ilsgwb9SMZIr20CzofAbQQFpFxKGzPA+Y+Y0cmLyH
    6iiu4LCr4Rojex+KK7kvJnz8/Pp4MRi9Th0bgOrCGtV35Kf2yaNF/0XGpyK1roeBJaoubP
    4HKWEbLh8jkvVY2sJaTA8HCb33jaYxTJC46pYP/D5o9/9jnA6d0P3jkkg1dBflrDIOARew
    RRILDbqarhFg/0brlZOJMFfCfngAkenPC2Gx6Or7tNoVPQu/a98UUOtlyVtAbIUiyQkW0r
    xlthqU22iXGASivTgS/ieFPXUVlqruqqarmpqqCYchFa4BAOIfIaZETzV4n/4bulTkRamM
    NZDTj6pjmzSKwjNvWjonVoWNWVDECwBQoH1oyCSMX9kIx3rdd1q+XuJ5IQiZKjNYHo4ga6
    2bQKOocbbmusWRh3wErvDWaeTuRUtEozV88GZgkGMA3n1ORiTf6Eifwf0VsKDMyTpcrP8r
    B2FS3FbiY0Sjy40S6YksS8RDR7XSr9wDKQGBKEcmC4YLZIJrYDG9Gkz2sVlw
X-ME-Proxy: <xmx:wBzlaqT9qYoA3lcVlS_-xnt-VhqT8TAOoBmenKRkOpWm3wWkOixkwg>
    <xmx:wBzlaqNkC5nZEFki5XSwxMp7wyLYNU7_6IbcdW67fabS37SGCxXe9A>
    <xmx:wBzlavXJ8ti9O_UqIwW3VRjrSb5vGoo1xnsdyf0GVHs3r7NBG2xdEQ>
    <xmx:wBzlatg8nqHLH-XysxiOUGcqme37ZxxAFIKcUjkAA_4PLleqmCVL4w>
    <xmx:wBzlagXPeKFtjCcqDIIkk2F0aBvnIAe3ZMH8_H_-wxtpN3Q3EIsRfTok>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Oct 2026 18:39:59 -0400 (EDT)
Date: Fri, 30 Oct 2026 23:39:57 +0100
From: Greg KH <greg@kroah.com>
To: James Burton <jamesburton@meta.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, eddyz87@gmail.com,
	a.s.protopopov@gmail.com, security@kernel.org
Subject: Re: gotox/INSN_ARRAY cross-subprog fixes: request vuln-fix
 designation and stable tags
Message-ID: <2026103022-epilogue-coeditor-0029@gregkh>
References: <CAJgm7qNx6NBzfxQbwF0ZoMLoULquNpsnrYSL1F3EFf2tztES7Q@mail.gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJgm7qNx6NBzfxQbwF0ZoMLoULquNpsnrYSL1F3EFf2tztES7Q@mail.gmail.com>

On Fri, Oct 30, 2026 at 02:40:36PM -0700, James Burton wrote:
> Hi all,

<snip>

HTML email is rejected from the vger lists, and no need to get
security@kernel.org involved in something that is already resolved.

thanks,

greg k-h
