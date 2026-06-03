Received: from mail2.ietf.org (mail2.ietf.org [166.84.6.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44EBF346E6D
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 02:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.84.6.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780452343; cv=none; b=jLUdXWSnD5Y+qSfDRm+gk3EsYbVM8khW/45jKBBJRdpyZXUV03hJSbiwKXcdGLF4XQloCO5GW1anOY2rQLgCzqrAq6deCGrsdpiEwtdrsR3Zc4IWCTegrOyLZ/21bDEUXl+mKtqKQ8IqnZtCkgcss4SNDezBO4cbjkubwGMF5C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780452343; c=relaxed/simple;
	bh=jsrWcPlL2EI1Sx/N993KOFxkec8og0Vivt6K2XOW0OI=;
	h=Date:To:Message-ID:References:MIME-Version:In-Reply-To:CC:Subject:
	 Content-Type:From; b=OWqnVcKSC6/rqOQ2cVmTZPbZIRzMvkCZVbzxZU9QB81UuOu/Q3lh1LwVxo46O3jck3X33qWzclTx1UwbfpmDansCb/0RLxN6kP4VSlV7K1Qb+RgdF8aRC+f4/Q1cyign50ko9KkebGSdt8UbMjdvg5wftWbeB+1qiFK74+AO5ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org; spf=pass smtp.mailfrom=ietf.org; dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=j+0uY3bQ; dkim=fail (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b=NlpOhqQM reason="signature verification failed"; dkim=fail (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b=JaPrbiAw reason="signature verification failed"; arc=none smtp.client-ip=166.84.6.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dmarc.ietf.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ietf.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="j+0uY3bQ";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=ietf.org header.i=@ietf.org header.b="NlpOhqQM";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=manifault-com.20251104.gappssmtp.com header.i=@manifault-com.20251104.gappssmtp.com header.b="JaPrbiAw"
Received: from mail2.ietf.org (localhost [127.0.0.1])
	by mail2.ietf.org (Postfix) with ESMTP id 334BDF9BF5A5
	for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 18:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
	t=1780451915; bh=jsrWcPlL2EI1Sx/N993KOFxkec8og0Vivt6K2XOW0OI=;
	h=Date:To:References:In-Reply-To:CC:Subject:List-Id:List-Archive:
	 List-Help:List-Owner:List-Post:List-Subscribe:List-Unsubscribe:
	 From;
	b=j+0uY3bQXJjMS/ZBmcLORORAudc+Dxu8yK7UN70RxVoLWsUktNDen5+E07td1V9PU
	 Yh8BVPq44kmUDgx9OzL4XyORyBdudPNUXHNjyOs5xbttgDivqvUnIacptFVR0K/SPJ
	 rLeaIwpHV3+BZEvE6LNV4fPGj0IIuCTSDMYX2/Nk=
Received: from mail2.ietf.org (localhost [127.0.0.1])
 by mail2.ietf.org (Postfix) with ESMTP id 2CB8DF9BF5A4
 for <bpf@vger.kernel.org>; Tue,  2 Jun 2026 18:58:35 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
 by mail2.ietf.org (Postfix) with ESMTP id F089FF9BF4A7
 for <bpf@mail2.ietf.org>; Tue,  2 Jun 2026 18:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ietf.org; s=ietf1;
 t=1780451908; bh=3Is7N/1s9kesTV6NifnE11ZTm6dK8ik8AnUdJpZ9u1I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=NlpOhqQMB9O+DVUveIQct/y9CJ+erg03XfTdU1U6MTEDqdngWUvMpW9K3R7xr8x79
 wHqpGLmAjSgMYq1zAJA8LYoZHoKHm+5BYw9QmkY5FGR8+ZeSO51I7s8Y0YQOn+PuqS
 Hx3E9ZlMdkQWWb1mxK4i+Tb3XG98mBEMd3Ez32ck=
X-Virus-Scanned: amavisd-new at ietf.org
X-Spam-Flag: NO
X-Spam-Score: -1.9
X-Spam-Level: 
Authentication-Results: mail2.ietf.org (amavisd-new); dkim=pass (2048-bit key)
 header.d=manifault-com.20251104.gappssmtp.com
Received: from mail2.ietf.org ([166.84.6.31])
 by localhost (mail2.ietf.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cZGTzsMLnfSP for <bpf@mail2.ietf.org>;
 Tue,  2 Jun 2026 18:58:28 -0700 (PDT)
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com
 [IPv6:2607:f8b0:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
 (No client certificate requested)
 by mail2.ietf.org (Postfix) with ESMTPS id 79539F9BF49F
 for <bpf@ietf.org>; Tue,  2 Jun 2026 18:58:28 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id
 46e09a7af769-7e62b6163c8so3512619a34.2
 for <bpf@ietf.org>; Tue, 02 Jun 2026 18:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=manifault-com.20251104.gappssmtp.com; s=20251104; t=1780451908;
 x=1781056708; darn=ietf.org;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Is7N/1s9kesTV6NifnE11ZTm6dK8ik8AnUdJpZ9u1I=;
 b=JaPrbiAw5RiXBMvbbxY0b82e0oB11+x1Nc1pjDGmcGxv2mbePVmOfRT78TtVTuIrOr
 RYfx9TkjHhT1/Oo94TRmGVz/q3fPNYRpY90TtbgrjvDGuJMImj/zT+AmfN0U7XulaGwB
 MHB4sY9WZBdtX6/hLLGpVgqcuA+vbvcZ/JPj53y4Klo3gJZykfDKYZcYhtzr4ikd8rAL
 hVbyd3Spj97jGRLS1DdbHJnUlSx9gEN+zgdFrcVoDv+7lU52vIyVCx9p/azpCALc9LTL
 CKIJ1sJfk+4CXD9qbBUyssoSK+WMmd8jJ+dvH520DeySp8xJnPVASTLZeQd6+ZTEHi+F
 NQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780451908; x=1781056708;
 h=user-agent:in-reply-to:content-disposition:mime-version:references
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3Is7N/1s9kesTV6NifnE11ZTm6dK8ik8AnUdJpZ9u1I=;
 b=PFmOWLMxDILE6l+HscT0pyMNlXmkB6FihTvCWDhDG6xcOSQzoab0IH+n00KO3g/bqY
 jG0gXWj19fKvVMWfzaIYBA4PFl3VF9Q4evNPfrE+Sy24efRP/RQfa0oKKwezrNm+0wmT
 lcBx76ueyOIEt6KA8mx3hnieT2LOCSarcjY7dnbCqDKuRq8m+tY1cawQnycu79MK2RSp
 HqkuTTsm7kgobfIP7xloA3Yd9SHVGE2j4/7FuECCql5hLbG01XK1cmyWGrv36XpVAM8s
 KSovBaBkOhTJWfiXhTrFqJqHB5BLsE8Opu4krTRMVRZeyiHt89QBfj70uTZHGJy9SupB
 zLMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9hv//9K7rZlNxoKt3WrIvYi7QGoPkeE9yS4f8ukAJviZmVeVp4hLRWoruYnInKq2XBPSk=@ietf.org
X-Gm-Message-State: AOJu0YywvFRwiNMKZwNS3MspxpM5UkVPCtqg8iXCURwrhvL/aNn/uCZx
 CV4e3FjSy3VF1TibXPLImhwryhJZiSdYrqK1rI2QCee54xNo8/EZGAxIUVNz5ueKtMJH
X-Gm-Gg: Acq92OHNU6WYZ+/Od2TwlcZ87JnFSXEiB5ytVnH1rjWs1IaJ1G02hTEleqIEbtxHzO5
 W28dZSLbesVtJ9gQIz7/bdmotORRoglC8B6X/QYiX6TWRTadt5F2cllbGBbo7mIT+pARVN31k/M
 Oy/qXcpRG31ptE07eVtijcfXokcywo3U4M5Y91fNYOy4oQowP6DxiZ3tGiRnKQhr/PYi4Dedx+M
 RgD6ZhCfUa2mqWlMqWCwwvSlmMIjzTD1/bTb/aC37GqjRJL/JVs4n6dFhxT6+s5EytoPIRCm2F3
 y16WFttBjZQaNAMslEO620IPaHcyYRgIwicdPXUEiY+VeK+ev75fESteU6GqwecGnkR3B6VKyz0
 Z1i8bsOPyuvGc9ZFa3+Ac5kKyzW/j3yyW6SdWLDfSoFWLu0mj/LJoSvcSjYteaL7kWm2VEnyVLw
 5Iwlzir9rNOOkG9Z7AKMLJbiW2/4tYNJ4cSbpALVG7TYhhDhYvCPnGR7J3Mp2/5hrTsSvr/w==
X-Received: by 2002:a05:6830:6ae6:b0:7d7:419a:7ac8 with SMTP id
 46e09a7af769-7e6e9d3b2b0mr631893a34.15.1780451907761;
 Tue, 02 Jun 2026 18:58:27 -0700 (PDT)
Received: from localhost (c-76-141-129-107.hsd1.il.comcast.net.
 [76.141.129.107]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e6e75c5495sm791076a34.10.2026.06.02.18.58.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 18:58:27 -0700 (PDT)
Date: Tue, 2 Jun 2026 20:58:25 -0500
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Message-ID: <ah-KCqA0FgLcX4NQ@maniforge>
References: <20260521-bpf-insn-doc-v2-1-8c43c037d599@bootlin.com>
 <iulf7fwwvfrvvspg4e5xyx3tcxe2yonfjllnze2phgfgpynrlh@kodf3fy3l32q>
 <DIP2GAUG3O18.29B8U0FOVEVET@bootlin.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <DIP2GAUG3O18.29B8U0FOVEVET@bootlin.com>
User-Agent: NeoMutt/20260105
Message-ID-Hash: NYN5XLYSSSSUT2CLV4SB3T52LMLPSA62
X-Message-ID-Hash: NYN5XLYSSSSUT2CLV4SB3T52LMLPSA62
X-MailFrom: void@manifault.com
X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emergency;
 loop; banned-address; member-moderation; nonmember-moderation; administrivia; 
 implicit-dest; max-recipients; max-size; news-moderation; no-subject;
 digests; suspicious-header
CC: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 ebpf@linuxfoundation.org, Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, bpf@vger.kernel.org,
 bpf@ietf.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailman-Version: 3.3.9rc6
Precedence: list
Subject: =?utf-8?q?=5BBpf=5D_Re=3A_=5BPATCH_bpf-next_v2=5D_bpf=2C_docs=3A_add_LOAD=5F?=
 =?utf-8?q?ACQUIRE_and_STORE=5FRELEASE_instructions?=
Archived-At: <https://mailarchive.ietf.org/arch/msg/bpf/zqNWcup_aAdrUUx9ZU2K5pMXsCc>
List-Archive: <https://mailarchive.ietf.org/arch/browse/bpf>
List-Help: <mailto:bpf-request@ietf.org?subject=help>
List-Owner: <mailto:bpf-owner@ietf.org>
List-Post: <mailto:bpf@ietf.org>
X-Mailman-Copy: yes
Content-Type: multipart/mixed; boundary="===============2531198710670303513=="
X-Original-From: David Vernet <void@manifault.com>
From: David Vernet <void=40manifault.com@dmarc.ietf.org>
Message-ID: <20260603015825.lHnPAJAtvsxbBoQlKrNMGZvzbe-NJFLmyNhGK8HbJtk@z>


--===============2531198710670303513==
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="ezldfm6trmndxdd2"
Content-Disposition: inline


--ezldfm6trmndxdd2
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH bpf-next v2] bpf, docs: add LOAD_ACQUIRE and
 STORE_RELEASE instructions
MIME-Version: 1.0

On Fri, May 22, 2026 at 10:35:20AM +0200, Alexis Lothor=E9 wrote:

[...]

> I don't know how heavy/long the process is to submit this kind of RFC
> update, but your point makes it sound like it makes more sense to just
> go directly for the proper way, ie adding the conformance group and then
> adding those new ops in there, rather than updating the kernel doc as my
> series is proposing, and then later reverting to a proper conformance
> group.

Hey Alexis,

Apologies for the delay. My email filter was broken so I only just saw
this. Yes, this would be my suggestion. I can send out a patch that gets
this started later this week.

Thanks,
David

--ezldfm6trmndxdd2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRBxU1So5MTLwphjdFZ5LhpZcTzZAUCah+KQQAKCRBZ5LhpZcTz
ZB68AP0XZVyPSmVl/+Ql+/VELqAYsqSL+Iq1Wkure4rdMn3Y5wEAwxbBaowMElWS
MSr9V7Fqms8AHBV4LXZ24XslYEAK4ww=
=MHgJ
-----END PGP SIGNATURE-----

--ezldfm6trmndxdd2--


--===============2531198710670303513==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

LS0gCkJwZiBtYWlsaW5nIGxpc3QgLS0gYnBmQGlldGYub3JnClRvIHVuc3Vic2NyaWJlIHNlbmQg
YW4gZW1haWwgdG8gYnBmLWxlYXZlQGlldGYub3JnCg==

--===============2531198710670303513==--

