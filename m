Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793872460;
	b=Bq2V+6b7WH6ImWOUI2LhgseudSjsl9M50upomXYAmewWwKIaEJ/bUcvk3t+lF9XBVun7
	 evfKtq79RX5ZO/mH0fl0vX20dRyggVX/9D68L2AyEC0RhOR1I+yUNc4jln9ZJlhP8cQ80
	 Eqg7KaYAPqAvc/m60Mc52RKhbEXFBh/twODdDiDnwE92dFNCpjYU25PXo0KyF8AVtYFQi
	 g3yZ6tIJAB0dW1x9tXc89nqVG5XD/YQpd8unb6H4S2xsQj7BnojvnpQZJ6lF+kc5P2V/d
	 KuhQ6vJ6mDLayPFOk1KkfDekp2BNvaEjtoUjQePlfHDAGZkmyZWavOeZobAkNozhM4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793872460;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:Subject:Cc:
	 From:To:X-Mailer:References:In-Reply-To:X-Last-TLS-Session-Version;
	bh=V6R4Z5QNn1TmY3Fb9b2cmHECgOA3rdSKsC6p62jeDtk=;
	b=yFW6AHd19JMCgT8/5AuQEN0lXFeE1Ek73dFOGhM0m7zHSjw/lttjwRU1Y6ov359aKkQs
	 12BniQZw8ghv438jSABATPBPiuyqihXpkxh3/XN24c5RKuIwBdBvD8u03kCtVyjkB4Fze
	 q4WyAppM2r8s4vckeVMMj9RFOQKVx5OR4lx6t7SF355T1KUkAZR29/k7xT9Wgd3homrue
	 et+RljBsWA3Ez020/18fXjwCz6oq+qoRqtpZD++L7Q+GgBZNywDjsHoFIis7pX2cmVmzg
	 b2qUBcznhvrNC5/zwYClXl0kRyVIV4QkT54d6fyAXz+drPX7T74A9y3guRFJueeqVgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Drud5Bh2;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46965606A31B
	for <bpf@vger.kernel.org>; Thu,  5 Nov 2026 09:54:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46965606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Drud5Bh2
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B91AD4E40774;
	Thu,  5 Nov 2026 09:54:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 72EC15FF85;
	Thu,  5 Nov 2026 09:54:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4A14A10328E77;
	Thu,  5 Nov 2026 10:54:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793872446; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=V6R4Z5QNn1TmY3Fb9b2cmHECgOA3rdSKsC6p62jeDtk=;
	b=Drud5Bh2kSmQFCtnnvVRBf9Bpw/2pvB6u2mFtC6kIBwe6l/lvVAABTN9MUisRt8dR8oay5
	aYfk922o/+l+N+kukaDg+AwrL/pFqsQs0Hly8htVtM9x/9bO9YlofGTYafqV5KorPhIT5Z
	+FiLICdmBKFIaOjNtXH+XT9IRaNw9xl7+YR1Mfqg7dqPAeGnz1mocGfIcbakHMLN4vKHPF
	4q7PyuN7EsmOTeVhc43D0a1MC9+Hg1WjQBZZywg9EDJpLnBaPnDgqwXztVmcizl/XElOKF
	4HRY5RITniyt7rrY097BUozGfWDDfcWlyiyPU+wkHICAd2wy5UYte9HbAUICmA==
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
Date: Thu, 05 Nov 2026 10:54:02 +0100
Message-Id: <DMN6PJC05X2R.2PXWV13VGT156@bootlin.com>
Subject: Re: [PATCH bpf] selftests/bpf: Look up unpinned maps by ID in
 bpftool_maps_access
Cc: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 <qmo@kernel.org>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <ihor.solodrai@linux.dev>, <ast@kernel.org>, <daniel@iogearbox.net>,
 <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Tianyi Chen" <hi@tychen.cc>, <bpf@vger.kernel.org>
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261104183323.409412-1-hi@tychen.cc>
In-Reply-To: <20261104183323.409412-1-hi@tychen.cc>
X-Last-TLS-Session-Version: TLSv1.3

Hi Tianyi,

On Wed Nov 4, 2026 at 7:33 PM CET, Tianyi Chen wrote:
> The unpinned subtests pass "name prot_map" or "name not_prot_map" to
> bpftool. Both maps are used by programs attached through trampolines,
> which are freed only after RCU grace periods and hold their map
> references until then. A run's maps therefore stay in the map ID table
> after its skeleton is destroyed, for about 300 ms in an x86-64 VM.
>
> If the test runs again within that window, the name matches maps from
> both runs, bpftool fails with "several maps match this handle", and
> the unpinned subtests fail.
>
> Look up these maps by ID instead and drop the now unused map names.
>
> Fixes: 2d96bbdfd3b5 ("selftests/bpf: convert test_bpftool_map_access.sh i=
nto test_progs framework")
> Assisted-by: LLM
> Signed-off-by: Tianyi Chen <hi@tychen.cc>

I've reproduced locally in my VM the mentioned issue (and saw the
"Error: several maps match this handle") with:

  while true; do ./test_progs -a bpftool_maps_access/unprotected_unpinned; =
done

With your patch applied, I don't see the error anymore. The fix
looks sane to me.

Tested-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.co=
m>
Reviewed-by: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.=
com>

Thanks, Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

