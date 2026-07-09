Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED94449983;
	Thu,  9 Jul 2026 19:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783624159; cv=none; b=tome9x6oP5SXRf6/fj+nhIcs7ml3jcpYtVBibZEzYH+UKQwUS+m+6DHuRY48FXnKO3T5l65DnQMlqLaXgEEY4zH3pKf5oX6UaxNIwtZo//QWNF1NUarYkJvnxLfpt7+J8rpJy9vevvRVgCJxyylaQaOVKxWFOiR4VL8llo3cqnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783624159; c=relaxed/simple;
	bh=R7HWf3GJUlv5P0O9wSsR8LMDaiyKoH5T4uuupZQaexw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=ofw0J29wSVhAEPXHQKV3KgzR60+RYYODLzmoU4Gj6fWjGUW5av9apA763IW4jOyfsoCnDvswlm7mHeAU6mhaU1QrLHYjUI0WB0euyOEzJZ1aFURLsGAm44lOqtfB+n/W0rqnS67PGiXIi762zhZRzsyzz9GZUpUTwYU/5JJQrcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RFY1KXs5; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RFY1KXs5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 21E3A4E40D24;
	Thu,  9 Jul 2026 19:09:15 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id DE42960340;
	Thu,  9 Jul 2026 19:09:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3D2A111BD1D5A;
	Thu,  9 Jul 2026 21:09:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783624153; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=R7HWf3GJUlv5P0O9wSsR8LMDaiyKoH5T4uuupZQaexw=;
	b=RFY1KXs5ObjKOmwaNBRfBJ0IgZJ0Hhblb8SoyJxuHyBorCM2G4twAMMyHbAul8ad4nKwpd
	xxJ/yOEGiH/p2KZ08ttpV4EQijwKvoqJQad6mLtidOzAXBwA6UTsPHGfk2wU1fCL5f3uBw
	Fcj61+AzcK/9ytTLGJVys7pKTtZKYaON5qfk/3++l8E6txp2RjjAu6lSebMGqdCGOyB1cT
	ty9fqqdMEVFcre30bAsQcEMRCqqSesVPrI2KIncaaU1gL6ABIKOlim/2wQWxTBa9NMt4zO
	eZLNeG2zuqpIoM03cixcnW5osgBmgz6uOMc+8vd9BGZIZbd2eVn7grSJ3y71/Q==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 Jul 2026 21:09:07 +0200
Message-Id: <DJU9ZPPQAX50.27PV0Y22APNXI@bootlin.com>
Subject: Re: [PATCH bpf-next v5 00/10] bpf: add support for KASAN checks in
 JITed programs
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "John Fastabend" <john.fastabend@gmail.com>,
 "Andrii Nakryiko" <andrii@kernel.org>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Dave Hansen"
 <dave.hansen@linux.intel.com>, <x86@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Shuah Khan" <shuah@kernel.org>, "Ingo Molnar"
 <mingo@redhat.com>, "Andrey Konovalov" <andreyknvl@gmail.com>,
 <ebpf@linuxfoundation.org>, "Bastien Curutchet"
 <bastien.curutchet@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Borislav Petkov" <bp@alien8.de>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260709-kasan-v5-0-1c64af8e4e1e@bootlin.com>
 <20260709185359.GAak_uRxyxfsSjCSyA@fat_crate.local>
In-Reply-To: <20260709185359.GAak_uRxyxfsSjCSyA@fat_crate.local>
X-Last-TLS-Session-Version: TLSv1.3

On Thu Jul 9, 2026 at 8:53 PM CEST, Borislav Petkov wrote:
> On Thu, Jul 09, 2026 at 12:01:41PM +0200, Alexis Lothor=C3=A9 (eBPF Found=
ation) wrote:
>> Hello,
>> this is v5 of the series aiming to bring basic support for KASAN checks
>> to BPF JITed programs.
>
> Can we slow down a bit here please?

Yes, sure, my bad for the noise. I may have been a bit over-enthusiastic
here, while iterating on the many issues raised by Sashiko.

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

