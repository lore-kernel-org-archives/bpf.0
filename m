Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7147933B6F1;
	Fri, 21 Aug 2026 19:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787341496; cv=none; b=itfihkyYDxauYTnpSxyUQDx53vMWhqJdWezQqQORLAnc03WZ3OM6X1QTUF7cKe1KN+KnmAzhKAF0+FDH4saFY3RNi/1qT7X4gKZeZgQ4/S8p0m8n86vQ1olWD0/j8FbwregLb4/reAJZb66KakLaFCL7DIoIugbCfoFMOoMeRhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787341496; c=relaxed/simple;
	bh=jlk8PzIlwv08XQcQKFV5+HhK21pjto9iZHRQG3r4gQM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:From:To:Subject:
	 References:In-Reply-To; b=Ky+h4f380HzZnwtpoAebLaL/72ciu19SeR6WH4xVKHKo7pTAT2l6xooAHalTrLTA6KWS1a6U6nQjW48mTIUnkYhMnSIe3wZT3M3PK4XRgFpgeMDRG1rioWd8dWwyJTqqvzu0E0JBZCtcknZhIURF9kqSHRADgO/bGCPC/PpvlEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Bvzcelrx; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Bvzcelrx"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 16F4E4E41303;
	Fri, 21 Aug 2026 19:44:51 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D3C64604AA;
	Fri, 21 Aug 2026 19:44:50 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E822811C775A9;
	Fri, 21 Aug 2026 21:44:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1787341485; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jlk8PzIlwv08XQcQKFV5+HhK21pjto9iZHRQG3r4gQM=;
	b=Bvzcelrxi2W2pcRvv1+ezy9CuCwbtb84lDw8dlH3EnxnC8FWwfp/cIAoiWR7XN/elZNM9I
	zFJbpNyWZYslFVaIbeNB0N1HUuGSEqoL2CdZLO0Kvw5ihNsTstFBvb3xIckC8ngKMWrcF9
	wCjwaJ0z31+EltctmDeKrNygvr0YkwX7GTjAWOggHuPlgLfe+4QAzS38993ojvdTWnlBqr
	WwFTY8l8pCTlscypc9qX6sa3S9Of9tXmLsllrYPYbnm4n3WWiLh9Lg2NNxb0MTrjllbf4h
	W4P5qJMGkw9zbvwvLFxpgchCFirhwnklh0BhusbSK2uH/tTMcDWHle50ScKj8Q==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 21:44:38 +0200
Message-Id: <DKUVOBRD2ZVK.2JEQG467DH95D@bootlin.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter
 Anvin" <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Andrey Konovalov" <andreyknvl@gmail.com>,
 <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
Subject: Re: [PATCH bpf-next v6 0/9] bpf: add support for KASAN checks in
 JITed programs
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260804-kasan-v6-0-549ef845f491@bootlin.com>
 <CAEf4BzZHMmfKTAxq+eo1Muq16EveZrjO_ONdFvWTs1rwrhh3oQ@mail.gmail.com>
In-Reply-To: <CAEf4BzZHMmfKTAxq+eo1Muq16EveZrjO_ONdFvWTs1rwrhh3oQ@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrii,

On Fri Aug 21, 2026 at 8:59 PM CEST, Andrii Nakryiko wrote:
> On Tue, Aug 4, 2026 at 10:45=E2=80=AFAM Alexis Lothor=C3=A9 (eBPF Foundat=
ion)
> <alexis.lothore@bootlin.com> wrote:

[...]

> Alexis, please resend your patch set rebased on the latest bpf-next,
> it has a merge conflict. Hopefully we'll get around to reviewing this
> after the resend, thanks!
>
> pw-bot: cr

Sure, on it.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

