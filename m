Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AFD3CAE76;
	Mon, 31 Aug 2026 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788162923; cv=none; b=lDyElg6K45vwJqEzr3MwPOL2px+/kQWkqtZVaU4nxBwSjmdWElfz1egfARCVAAvt0c4vUcecFs5mKOKGljzuwIaPLWNWJIjZQ1D/NUqLXoyi14Ki8y4p5YXVZoC/Fse4H1sC6kLisDq1N5DcVDySdn6MbYjHRei/mGOZd0kT+R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788162923; c=relaxed/simple;
	bh=yjHoKaQwu9MgYW9EUKxF8zoK02BCi/g8yi49iqfsHIE=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=sUximKhQarvnGD2WwUt0sWaIZFZXcGo6DwZ/Tg0ZGjmQy7KXO79vnGMLYtwfchXBq+mbSMhiStY0C/McN7t6kU+j262n7tfKs6e+H8asywNV1lGO8aleEZ+9ToFDbWAXL0W1baZLd7Z26BesiwAYZgdyotIv4jVq/9FOW0IJT3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UMV/Z+VO; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UMV/Z+VO"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 44D254E4145B;
	Mon, 31 Aug 2026 07:55:19 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 156DD601E1;
	Mon, 31 Aug 2026 07:55:19 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9660C11C78A32;
	Mon, 31 Aug 2026 09:55:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788162913; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=M/8EDX4ydfPxhtMVPvjbpWINZcbTB2snrWJzkNm34xw=;
	b=UMV/Z+VOmoWGsLkG5B6EGFOkya3xBI/Y36knXvWQzT7G5vkUr6rCmmsaKYWMYsduzVhpbf
	0Vued5LMKPpu2Q2K6WDXjGMwADCagI/5dU7kyO8A3nlPo1bS30ZE+3WA3kt4xECcnuudgV
	9jsCGf/p/tAZwcXtvNL9kaOOr7ew4F9JczRIFeW6pq6BjWxXj3yAKpQ8zZ1eILU2dDxkq7
	nA0NzU+2C7qHpH1MZ5X00Kc7ErEd8dhS/JgDKLDoeqBwbYr9DzV8cXo6dy4mpNmsTYQvre
	SnnUz/8epyT25ZI2AsLKMGnjYu3/Juva39I2ey9pWVvfCVHmgb1pY/jvNe17Rg==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 31 Aug 2026 09:55:09 +0200
Message-Id: <DL2YUKA3J3CG.1GUS47SLVPRNX@bootlin.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Track test_xdp_features DUT
 processes
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Eduard Zingerman"
 <eddyz87@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Jiayuan
 Chen" <jiayuan.chen@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Stanislav Fomichev" <sdf@fomichev.me>,
 "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, "Song Liu" <song@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, <netdev@vger.kernel.org>,
 <linux-kselftest@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Lorenzo
 Bianconi" <lorenzo@kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Bochao Cao" <bochaolucky@gmail.com>, =?utf-8?q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 <bpf@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260812-xdp-dut-process-lifecycle-gmail-v2-1-b03ef2aa1b97@gmail.com> <d4be160e-703e-46bb-9509-d3d90f6bc34b@iogearbox.net> <DKX99ZAP7GZ8.23U5EOSFB4VPU@bootlin.com> <CAHKNYVXN0DAUzv2Lwm=oQ_K=zhi2iNyTO2e99s5F4M+Kr7u5tQ@mail.gmail.com> <CAHKNYVV8gn-L_unjsxUZV=E+Rx4ouDBJX613_n4hevXP1rivyg@mail.gmail.com>
In-Reply-To: <CAHKNYVV8gn-L_unjsxUZV=E+Rx4ouDBJX613_n4hevXP1rivyg@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Fri Aug 28, 2026 at 8:10 AM CEST, Bochao Cao wrote:
>  Thanks Daniel and Alexis.
>
>   Dropping the procps dependency is not the primary motivation for
>   this change. I agree that Debian can remove the dependency independentl=
y.
>   The issue addressed by this patch is process isolation in the standalon=
e
>   test. The current readiness check may observe an unrelated
>   concurrent xdp_features process, while cleanup may terminate every
> xdp_features
>   process on the host. In addition, a DUT which exits before listening ca=
n
> leave the test waiting indefinitely.
>
>   Although this script is not currently run by the BPF CI, it remains
> useful  for testing real hardware,
>   so these process lifecycle issues can still  affect users running the
> test manually.
>
>   Would it be acceptable to fix these issues in the script's current
> location?
>   If the preferred direction is to move it under
> tools/testing/selftests/drivers/net/hw/,
>   should the move be submitted first, with this fix rebased on top?

I have no strong feeling about whether it should be moved or kept here,
I'll let BPF/netdev maintainers express their opinions here (Jakub
already suggested in [1] that there are helpers in net testing helpers
that could help making it move to the net tests). I've added Lorenzo in
CC, who is the original author of the script.

Alexis

[1] https://lore.kernel.org/bpf/20240914063828.7bd73c5e@kernel.org/

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

