Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B225436AB6E;
	Fri, 27 Feb 2026 10:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772187296; cv=none; b=iCk9U2dwVybazogcknBE8+ETLnG+Iq72g/bK0N+9GP8XHQ+lfgVpI+p4/5Zf/GTDrWMlyFBz0SAtK3PbLKU2e9oS28bMsIO0pZVmelJVtd9Pn8r/7ex2gx6hKEQRdMV9gpMIFBop56VcY90J+jA3/ZxUZdLYaRCz02yFj6e3+6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772187296; c=relaxed/simple;
	bh=SQ1B0cDL3jgSEBlNsMPFbuc2xYLONjjxJBSisxmjRvk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=KbOSKEF04r666m3oANhz96/HBG3yJNWxLyaEaT3vueRdffL2q97rLZCmm5PwJj5p/BwUYZn/EGjfVCxHD2mhM/KnghBegWkorBBTJw85oZzYnaottORI5v05zHes3tShkQJXvVmIMowjXreZAg3z1ch6XhdWKUV/CbehVdWG96A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=fCM8Pfa/; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="fCM8Pfa/"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id C6BE4C406A5;
	Fri, 27 Feb 2026 10:15:07 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E4E9B5FE46;
	Fri, 27 Feb 2026 10:14:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 89AD3103685B4;
	Fri, 27 Feb 2026 11:14:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1772187290; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=SQ1B0cDL3jgSEBlNsMPFbuc2xYLONjjxJBSisxmjRvk=;
	b=fCM8Pfa/5tkgyAM+PFMLrfnxJARIz59cbghHchjx+GEHAyMgjll8xjHzmdUhxmPOUdPIzb
	BW6hCbJ5re5wMcKP9HFIvK1RwXaLx1xiZ3SIDOlHeuiiUTee/iHrkroS3yF7yZig1GUgEF
	j7roB1TwlJmbY49PNfhkM/wv2O8UUsEcjZag6csOCuytop5pSdFITuDdeR1SNuRV3lCdUo
	kb/s3IhqAHeD4//cm9SLy0eR2fWt6RfuILZzzYe83zCNyCNIqg+4PS9Pvz+gJpKbhjQvy2
	lZEq6RVhyP59EXKRspVwvL54FLUGtXGkZR2tFHy9pA1/+OrIKwoFJJIxvIARLQ==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Feb 2026 11:14:44 +0100
Message-Id: <DGPNYNB5YCQJ.J5LKKGGGTB83@bootlin.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: drop test_bpftool.sh
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Quentin Monnet" <qmo@kernel.org>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "John Fastabend" <john.fastabend@gmail.com>, "KP
 Singh" <kpsingh@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>, "Hao
 Luo" <haoluo@google.com>, "Jiri Olsa" <jolsa@kernel.org>, "Shuah Khan"
 <shuah@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260227-bpftool_feature-v1-1-a25860fd52fb@bootlin.com>
 <8610334b-aa82-4fef-a9cf-41c0bfca4dbe@kernel.org>
In-Reply-To: <8610334b-aa82-4fef-a9cf-41c0bfca4dbe@kernel.org>
X-Last-TLS-Session-Version: TLSv1.3

Hello Quentin,

On Fri Feb 27, 2026 at 10:31 AM CET, Quentin Monnet wrote:
> 2026-02-27 09:08 UTC+0100 ~ "Alexis Lothor=C3=A9 (eBPF Foundation)"
> <alexis.lothore@bootlin.com>
>> The test_bpftool.sh script runs a python unittest script checking
>> bpftool json output on different commands. As part of the ongoing effort
>> to get rid of any standalone test, this script should either be
>> converted to test_progs or removed.
>>=20
>> As validating bpftool json output does not bring much value to the test
>> base (and because it would need test_progs to bring in a json parser),
>> remove the standalone test script.
>>=20
>> Signed-off-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@boo=
tlin.com>
>
>
> Acked-by: Quentin Monnet <qmo@kernel.org>
>
> Regarding the discussion on JSON: If you need to check bpftool's output
> in other tests, it's probably OK to simply look at the plain output.
> We've been discouraging people to parse the plain output because it's
> not considered stable, but given that the tests and bpftool itself are
> in the same repo we could always adjust any test that would break if we
> changed something in the output.

ACK, thanks for your input, I'll keep that in mind for the next tests to
convert (I still have some test_bpftool_synctypes that I did not check
yet).

Alexis
>
> Thanks for your work on this!
> Quentin




--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

