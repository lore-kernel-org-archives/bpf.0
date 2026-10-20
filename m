Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792486125;
	b=MVT+Ei2/FL2m6eUHYhgCA7v+MIo78clBC7PgXp6MUxIbIwFPsKhGNnVJXiILPTQqCjNN
	 BiUIBXL7qOIfKwR3dfABUnFTSrNP2k+KoODsQsqcCEhaIlgfmfYAr0gSVZkPRkuTrJjDg
	 LDaWm9xk76kDtOui3umV1dVzgNO9RSZGrQNuQQr5uaBK6y/8qO14MKZbemp91XAVzny/X
	 Sd8BV4hIemqI3fCErdyDl3eOgQHmUtTYgsNSstEE25RehkFoL8zlqrcOGRFkKiOJ4zl6q
	 s5O26rOyJXNR2LXjX+YiODpCAn7yODfegRcUR6o5kJPWUMByMSgBlE8kt0KB/7gWt/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792486125;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:
	 From:To:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=OL7xSgnMDI1XhqtDCk/Z7BVGAq+sl8BFQtpkjDJSuxM=;
	b=MJfcZddV7tPfUOpY/8v+EcPhP/8zqBS58KBtgtseRnRYw6utBPasD1f9MJtX3EG/cuXC
	 we3vuzkilgzqoHjs8EbT1TUUTlZZplV1mRMfA0gnczLuny/YRbj8bzLIGh+g4EB5nTUt4
	 3eEt10X8bOPCK6ZpHa5YvLReoghi0KyjzXmp7ccPldz2+Yj0GYMPsvBa1xknYG49vZcfc
	 RiyOVwO6KtD0LhA4Zv1W9vKhlnqHJNsb3C+7QSI0JZIS6RlHPIHNWiZNuXw8GzrV7OOC9
	 w3ePBPVfZMnJCwMAfkloDzcfXx5A2Y680J3K75nQu99cK+AVPCj2+SGSFcWavzEgl/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=BXcTZoWS;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3A22606A320
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 08:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3A22606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=BXcTZoWS
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 66636C63454;
	Tue, 20 Oct 2026 08:49:41 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id ED09560393;
	Tue, 20 Oct 2026 08:48:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6176F1032840C;
	Tue, 20 Oct 2026 10:48:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1792486121; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=OL7xSgnMDI1XhqtDCk/Z7BVGAq+sl8BFQtpkjDJSuxM=;
	b=BXcTZoWSa4aBKdbD593+IjWSFMzaEBpqWmMhVbP7C3hoX4IBRh3tTnYzgq+Zzny7Rij1i2
	hHuIok/lc7zFrIqLHe/03WKgqMyqCa4S2Qa662GiS5m4gJbUfEBCsbRDX6C21rnOQkg8rY
	L9c4xKjoDbQttIUn+/NT3Sf3XRlHCRGiyYWa+uIOQldId84bSgyTEnMY1V4iArS3fRE+03
	S/nu/Pzd78WwipUx7nPkfQXnDMhyfST0vVW9mKFdM1IlCCBtbZUiupOCJwGfd9r1jDZfBn
	x1ywd7HdcC97OJgkHIPUOauc35w4z7E8DHMnt8LLqoIAP5whMB++O6la381mdA==
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Oct 2026 10:48:35 +0200
Message-Id: <DM9JAPNJ5TFS.2LY20LEDOU3MZ@bootlin.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Time tc_edt from its first
 packet with data
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Qiliang Yuan" <odys.yuan@gmail.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, "Shuah Khan" <shuah@kernel.org>,
 =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?=
 <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261019-selftests-bpf-tc-edt-serial-v2-1-41c3813e7916@gmail.com>
In-Reply-To: <20261019-selftests-bpf-tc-edt-serial-v2-1-41c3813e7916@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Qiliang,

On Mon Oct 19, 2026 at 8:35 AM CEST, Qiliang Yuan wrote:
> tc_edt sends 1MB over a TCP connection that a BPF program shapes with
> EDT, and checks that the rate it measures is within 2% of the target
> rate. The transfer takes about 200ms, so the margin is about 4ms.
>
> The measurement starts before send_recv_data(), which first creates the
> sender thread and accepts the connection. On a KASAN kernel, x86_64 VM
> with 32 vCPUs, that takes 0.7ms when idle and up to 4.7ms with all
> CPUs busy, while the BPF program spreads the data over 200.08ms in the
> median. The test also fails without test_progs -j where everything runs
> slower, e.g. on s390x and with ASAN in BPF CI.
>
> Have the BPF program note when the first packet with data goes out, and
> start the measurement there.
>
> tc_edt run 100 times on the same VM, idle and with 32 busy loops in the
> background, before and after this patch:
>
>                  before                after
>   idle           0 of 100 failed       0 of 100 failed
>   busy loops     3 of 100 failed       0 of 100 failed
>
> Fixes: b0f82e7ab6fb ("selftests/bpf: integrate test_tc_edt into test_prog=
s")
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

I still suspect that it will not solve the flakyness for every setup and
that it probably deserves a margin increase anyway, but the updated
measurement looks like a reasonable improvement to me.

Reviewed-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.=
com>

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

