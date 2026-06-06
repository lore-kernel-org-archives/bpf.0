Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A230569E
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780735923; cv=none; b=u9v/xltwzbkiLj50V9hN7R7tkIBriHlhVbIS4eJrXm77xcZrp2+bRdb+6X98b8QZhdm87j7O1CcgO2Cau9KTszB9Jhtty0/ySDp1UJVhYzyoH10Lv5ZqR0jkcY9Y0oyOJCy/CoC8yaJ8MwlUrWHK7x4rot9mZQ1YSeKBKkMZcLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780735923; c=relaxed/simple;
	bh=bt0Rpwdmhi3tP2g6vq+0m6jbqp4BA+UUcba7I2nnpu8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Subject:Cc:
	 References:In-Reply-To; b=ErsqHyNogsbwufSwRl7J1AEY1YSC5kB75bDDW5yAyVIeHVRbKQr6LL7XpOMH2MD9OC1Ddx/oha/B4XYoxc75DbJmnBOWerhVQREBANzvBtNd/keqt3NjeQBKruWcGnSDuaki1HH6Jmq9BFMTRFVFSYIb4qWzCLgyQlGXOIFo6vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XW/UZLAN; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XW/UZLAN"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D80B91A0A2E;
	Sat,  6 Jun 2026 08:51:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A7B285FF0F;
	Sat,  6 Jun 2026 08:51:58 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 95DEA106A264A;
	Sat,  6 Jun 2026 10:51:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780735917; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=bt0Rpwdmhi3tP2g6vq+0m6jbqp4BA+UUcba7I2nnpu8=;
	b=XW/UZLANsbxFOVp9pW/jMl3pmKtyerySaLVvM9tsqfgS9C2kdf8LpIjycJRE4qfj4dX/5o
	IiSMlIBRoLGreB7D9SIgo+GPxVN46Gipxojkpy5xpbWQ5HhXJfhcdMnd1fIG5rzFKZbuv3
	J32INZbh5I0MYcFCKlmZRtH3PPlolwUhQa5hKlZVF/Zpi/wBri8PakIn1876IzBPFKljC9
	hro6Nr2se1w1xIIxTxhMEKprKFjLqDK9kWzeBdy6D4ElHCIdPMGqicCR/JUMimKVWtGeDY
	/nHgoIPLN15A5tnOdC9igeSwywCgNlj0j1ViIKwQumFNc6Uapcdizf8glNjRqA==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 06 Jun 2026 10:51:45 +0200
Message-Id: <DJ1U71MEBQDQ.2PHD22ZTTV64B@bootlin.com>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Yonghong Song" <yonghong.song@linux.dev>,
 =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, "Alexei
 Starovoitov" <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>, "Jiri
 Olsa" <jolsa@kernel.org>, "John Fastabend" <john.fastabend@gmail.com>,
 "Thomas Gleixner" <tglx@kernel.org>, "Ingo Molnar" <mingo@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Maxime Coquelin"
 <mcoquelin.stm32@gmail.com>, "Alexandre Torgue"
 <alexandre.torgue@foss.st.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 8/8] selftests/bpf: add tests to validate
 KASAN on JIT programs
Cc: <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-stm32@st-md-mailman.stormreply.com>,
 <linux-arm-kernel@lists.infradead.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260604-kasan-v2-0-c066e627fda8@bootlin.com>
 <20260604-kasan-v2-8-c066e627fda8@bootlin.com>
 <13b87293-5237-43d3-9f91-33c13041cb43@linux.dev>
 <DJ18PD6QWGA2.2HOYGKU7RUB68@bootlin.com>
 <f73d0971-0544-4a92-bde7-b2fbfcdaf28b@linux.dev>
 <DJ1EYKOXV11H.25EJOUKFI81T4@bootlin.com>
 <d717e193-f3b3-4022-8b0f-5e94595dd69b@linux.dev>
In-Reply-To: <d717e193-f3b3-4022-8b0f-5e94595dd69b@linux.dev>
X-Last-TLS-Session-Version: TLSv1.3

On Sat Jun 6, 2026 at 6:09 AM CEST, Yonghong Song wrote:

[...]

>>> But when I am running another same test './test_progs -t kasan', there =
is no kasan reports.
>> Ok, I guess you are missing kasan_multi_shot on your kernel command
>> line: without this option, only the first report is generated, then
>> KASAN does not emit additional report until you restart your kernel.
>> Could you please try adding it and running the tests again ?
>
> Thanks! Adding 'kasan_multi_shot' to the kernel command line indeed fixed=
 the problem.
> It would be great if you can mention 'kasan_multi_shot' is needed in kern=
el command
> line in cover letter and in patch 8.

Yes, that's definitely missing, I'll make sure to add it. Thanks again
for the test !

Alexis
--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

