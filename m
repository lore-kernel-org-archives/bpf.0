Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B819E426EB3
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 21:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769029673; cv=pass; b=UyXkTMHcr6gmHTPV9ApwpXL/wzdVrtT6omRduBrL0rHxgXQIKKhX1VK5pP45+gGLz1IWkblWkQr99sxnIlz7wLGJq6wcXLSvQzlSiArLC5dEy3uNI6CfVHynIgB96hZHTHEpxdx534BT2QDhc+E8fPGcbcueUGi4sStMUAP4IT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769029673; c=relaxed/simple;
	bh=vIrtZLlR9y3VX65/B/Uk/Cvhdyt5IYMtPMqdkwsTUis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=au5vrUPb3S4XMUQcsHkowoAL/8BGA7megQLcVGurjcuG0LQ12iAs4RbSOFAjGOJtDUyKFkOJ1L7sgg6zbAsCqvv3no/nu97qH7Kmejt/DYHoPjcxCsBCaFD/W/SQH29F9PIPVX6aLMyoK1EQGH27YQh0tGNx/e6IbO0xyfG/kgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SQeqyJeM; arc=pass smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SQeqyJeM"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-5014b5d8551so130851cf.0
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 13:07:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769029667; cv=none;
        d=google.com; s=arc-20240605;
        b=FT8R1TbUiCUaUSwNzC7WgsMhOIR2O/EvIxo9sa5henJP4qTAgV9v83xRynr2KA9Hw7
         EyussN1xvY5FoQB3a7Ckga1Ie/zaM8NyKRgqink01dOus+zsyMP8BWQPe4MneMoWCShz
         ymSgc7RwMLSuAw/gEamXID/YUrh3o5kkiUqwOdUeGjgl6aXjO3uFcWKtUISGhZyBtsfC
         hne5uYRdXuSfY1bhm+MKqgQBNBXzIFv/viamyY/J+fWYKVt2bpRU5kK0sxdAZZIos4PY
         vh48A1Mp0559pZZHTfGdT9DBJUcik/LUzIsi6MvZZdeogIvO3ysyAMMkGWydHULw7ctc
         50rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vIrtZLlR9y3VX65/B/Uk/Cvhdyt5IYMtPMqdkwsTUis=;
        fh=qEoOrn2g4sDMAPULfYB4pjRsitCzdORBirWT/Kq4JV4=;
        b=PmY/Yb2cSIwXHiXb4boimXPfbPYWL3Mq4ee9X2evwvPfvyqXPzkKXckhPtf8Sobe3C
         8lOxBBVwxOvv0iLL8sCS5329BkFGsSfdZ6vMkzkoWu1QNGCovy9p2tZJFCJmKxhIVrdi
         Gg9H9G9hZtwH++921jJkoVcs3JkzQp4sER00pYEErymnBSaPBizGRjzlci7HAYNUfKfb
         CwueF+fP015lNyf93CuDMva6KQSixrv5YKkClGEz8AGvzRRvue3Nlre0xD02v3EK0Grc
         TlGvGoCgmWmkByHtdL64wjgqwldRg3VmWoFypjcPmRiND8t/fUifE5zDN8LR//3YMLnH
         46TQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769029667; x=1769634467; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vIrtZLlR9y3VX65/B/Uk/Cvhdyt5IYMtPMqdkwsTUis=;
        b=SQeqyJeMzhPwZVMwezMEbd/Zhg8Dp6ruPVSwYPG/XOz1e5uRFg4ksHfL9QtwxIXHfV
         ptsIQ574V8qsD33A49aSXeEswthUWZu5q6OQztfVTUw7XbIFmX846CwEnmrdARgi0BjU
         zW+RSaH54PmqgSyE94iTpD5KkQkJuB7dTvgCBAZrBsTukd0VDNS4AAz8vhsmKBCUi1w8
         1ifEVM2pldEUht8y33DONlblUvkvItE8LdsGiEAalcWBpOdcJwEgFFB1fPfsK9/Xauwa
         nLv/48DFgjdTL2tP+n9XWtHP7ZtH+5DEbrDkDmTKHv7LvY8Q/2pTKlCTs+gyEPbrygm/
         tJow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769029667; x=1769634467;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vIrtZLlR9y3VX65/B/Uk/Cvhdyt5IYMtPMqdkwsTUis=;
        b=A4YQ026JjPR5QLh1DgxtMsVvPSDctueumV6miU2rIQAIxpfz6DdpnHDMTM+MFNip5x
         OCIxiGEyJU5uGyntH29SlZGWvGG/Fn+StngXqtsszpVhoEChgYKenXml1YEVzPT77T93
         r8WQJn55tKeLlUusRyDkrLE9HXfXbABU1eSfTmnR0MU9GiG7SBI+u6cefBJtwMxUMB2M
         30TXj0x3Rm46qhaPqf8rnCdZVKFt+DHzvyhNEEgTAEWalvMgfC+o1+UehgNcax3t8Th4
         MrgaSIlAhwmdGh/8fX8dv29MWaFXco6cXLGwKUJHVrDYcbPKEMsdLQlm3S/sCihyKALV
         Mx6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXCO7G9oNEsqitH+0xDk2hItRA8iP0TOWNY+xpy2+taCoaRj3b7CEjdUWe4i3HCg3ovFNs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfVyeTHIhcT2Pb1z5RhNWbq9Cxn4dmhLx1bdGfCZecKSNcN53k
	M3yT/59XWI6Ui441QSt8DMYR2RPoI/96Qutsaa284KoW5uFLCPLijmNO+Envw6XG0ZN6OVlbIDd
	1vaG4K8Muea5B4JycdCwpAU96f0zLd8xNmegVOPgS
X-Gm-Gg: AZuq6aIvMMFRAvAfIoxTcXQR0UpdOEHP1miSAiQaoe31u53SlA9rSvcmLePz1b7Wzku
	SARIHk5cjXjMxNt0/AlVT6kXbRkI6gMUj7Nn5dcGDO/gdxuarUvOZ+ssNt9P6RsBFKl7xrUAoM7
	oeF9FCBZyBN+dZrcriMTByc7y95daKJl/eVN0XFClY3XjgcYZaANEW+Wm9eEkvBRam5NAFVkMKy
	/uszIrxBfxEybWs4L2SAW7G4fYc4zkey/u5Dia/FEzjW3igvtK9yF/5SBeMPNPjhve2z5/b4QeF
	H4iX/LlU3Ei2apV2nxIhVu21VUFasp6o/rG7GK7T5oqLHBp93Kf5NEkHaypM
X-Received: by 2002:a05:622a:10d:b0:4b7:9a9e:833f with SMTP id
 d75a77b69052e-502ece23329mr407501cf.7.1769029666268; Wed, 21 Jan 2026
 13:07:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121143215.14717-1-chia-yu.chang@nokia-bell-labs.com> <20260121125504.32ea788c@kernel.org>
In-Reply-To: <20260121125504.32ea788c@kernel.org>
From: Neal Cardwell <ncardwell@google.com>
Date: Wed, 21 Jan 2026 16:07:29 -0500
X-Gm-Features: AZwV_QjMA9pxvIgwt5ruSX8S6CumDWx8tec6mJvW5t5NdsFW525cQ4qDlmi2IZ8
Message-ID: <CADVnQym58ujAwozxSgMNxcCBvTf5JVYrzEoDuBFTjheY-PoHHQ@mail.gmail.com>
Subject: Re: [PATCH v10 net-next 00/15] AccECN protocol case handling series
To: Jakub Kicinski <kuba@kernel.org>
Cc: chia-yu.chang@nokia-bell-labs.com, pabeni@redhat.com, edumazet@google.com, 
	parav@nvidia.com, linux-doc@vger.kernel.org, corbet@lwn.net, horms@kernel.org, 
	dsahern@kernel.org, kuniyu@google.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, dave.taht@gmail.com, jhs@mojatatu.com, 
	stephen@networkplumber.org, xiyou.wangcong@gmail.com, jiri@resnulli.us, 
	davem@davemloft.net, andrew+netdev@lunn.ch, donald.hunter@gmail.com, 
	ast@fiberby.net, liuhangbin@gmail.com, shuah@kernel.org, 
	linux-kselftest@vger.kernel.org, ij@kernel.org, 
	koen.de_schepper@nokia-bell-labs.com, g.white@cablelabs.com, 
	ingemar.s.johansson@ericsson.com, mirja.kuehlewind@ericsson.com, 
	cheshire@apple.com, rs.ietf@gmx.at, Jason_Livingood@comcast.com, 
	vidhi_goel@apple.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 3:55=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 21 Jan 2026 15:32:00 +0100 chia-yu.chang@nokia-bell-labs.com
> wrote:
> > From: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>
> >
> > Hello,
> >
> > Plesae find the v10 AccECN case handling patch series, which covers
> > several excpetional case handling of Accurate ECN spec (RFC9768),
> > adds new identifiers to be used by CC modules, adds ecn_delta into
> > rate_sample, and keeps the ACE counter for computation, etc.
>
> Looks like we went in the wrong directions, multiple tests are failing
> now:
>
> https://netdev.bots.linux.dev/contest.html?branch=3Dnet-next-2026-01-21--=
18-00&executor=3Dvmksft-packetdrill&pw-n=3D0&pass=3D0

Looks like the first two are failing because the v10 series has a
different layout for tcp_info than what packetdrill currently expects:

https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill/results/483641/3=
0-tcp-accecn-delivered-updates-pkt/stdout
https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill/results/483641/5=
8-tcp-accecn-delivered-falseoverflow-detect-pkt/stdout

Chia-Yu, can you please post a patch for packetdrill to make it expect
the new layout from the v10 series?

For the third one:
https://netdev-ctrl.bots.linux.dev/logs/vmksft/packetdrill/results/483641/6=
9-tcp-accecn-client-accecn-options-lost-pkt/stdout

... it looks like the test line that says:

+.002 ... 0.052 connect(4, ..., ...) =3D 0

needs to be changed to:

+.002 ... 0.102 connect(4, ..., ...) =3D 0

It seems like running the tests before emailing the patches should
have caught these 3 issues?

Chia-Yu, can you please make sure you run all the AccECN packetdrill
tests with the latest kernel and latest packetdrill binary you are
proposing, before posting a v11 kernel patch series and packetdrill
patch?

Thanks,
neal
