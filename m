Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA39253951;
	Fri, 18 Sep 2026 06:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713509; cv=none; b=NRuSEERRVuAYVtc7Nx7FhQGLxbv2YQ+D0CcV2pwP5BIJkQU0C2CO85VpTbCEb/DvHmcchopLQx39oTVHVCwVN+ku8uaJOFRSRqadDHPmVXyTQlq4wRjhNsGDzzbsXxZ0iwQ/yCbYLETpMK+WRHERAxZDzM30qu+x78Ol0lSUaEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713509; c=relaxed/simple;
	bh=EvREG//rprTPwzkjU3xlpNpW9eqUNwyIliraATJKrZ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Subject:Cc:From:
	 References:In-Reply-To; b=Qn5fwTj0sscYKonTUiwDoFXYUxT6bxUdRqtpZihaEPFh0IrjCjgIIt2j/sLx4xuIKHe38HI0z9oomiska9385waDLIVUoawCqqeO9tctMOA2G0UbaKhlrQEAXUHbNRYn6mxltJQe7Iae/XsEPWk148lUaFSgIRZuH79OghbKLUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jPH/TTPb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jPH/TTPb"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 02D7A4E4081C;
	Fri, 18 Sep 2026 06:38:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C4D2960649;
	Fri, 18 Sep 2026 06:38:25 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AACCD11C7B021;
	Fri, 18 Sep 2026 08:38:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789713504; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=RyoX66ARo1jdjaeeIXDPztqT4qPSKypJMdksTTMQhHc=;
	b=jPH/TTPb9FOoRC5kvu6MMqiNDyg9OvecsolVYtmZiPny5z+PQmJ9B5g3grgQ2mluezmDxI
	pl6eoQAlSEbRXNVjNgEgh8y0yb0/HntnH1eEZH5BDzqjY+czOGwL4cXp2SVmJJWh965kZ8
	V02bAl8UTVmrWFad/eAMbHbA+7IRVeg8UufqosZd0N/H+Z3nNOMlarzCWwNmxyg6hz0G8L
	m7ZeGkioDDOW1TrgGx+lut6d2AQmjBCAGNWwwmKpV2rm7LUfYMPTkCoYWKpPw4VRGzWykb
	EOB+SCdbJ0Tta3pMAxAQG531DR/pGxvYwFb7Qd107TwYuqglFCptBMp3cLCLKw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 18 Sep 2026 08:38:17 +0200
Message-Id: <DLI8HIES5WAV.3A4W5G22Z6I1H@bootlin.com>
To: "Madhav Khosla" <madhav.khoslaa@gmail.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrii@kernel.org>
Subject: Re: [PATCH v2 bpf] selftests/bpf: Fix csum_partial() dropping
 trailing byte on odd length
Cc: <alexis.lothore@bootlin.com>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan"
 <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, "Jakub
 Kicinski" <kuba@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>,
 "John Fastabend" <john.fastabend@gmail.com>, "Stanislav Fomichev"
 <sdf@fomichev.me>, "open list:BPF [SELFTESTS] (Test Runners &
 Infrastructure)" <bpf@vger.kernel.org>, "open list:KERNEL SELFTEST
 FRAMEWORK" <linux-kselftest@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>, "open list:XDP (eXpress Data
 Path):Keyword:(?:b|_)xdp(?:b|_)" <netdev@vger.kernel.org>
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260916112554.413933-1-madhav.khoslaa@gmail.com>
In-Reply-To: <20260916112554.413933-1-madhav.khoslaa@gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

Hi Madhav,

On Wed Sep 16, 2026 at 1:25 PM CEST, Madhav Khosla wrote:
> csum_partial() computes num_u16 =3D len >> 1 and only sums that many
> 16-bit words, so the last byte of an odd-length buffer never gets
> added to the checksum. RFC 1071 says it should be padded with a zero
> byte and summed as one more word, not dropped.
>
> This backs build_ip_csum(), build_udp_v4_csum() and
> build_udp_v6_csum(), used by flow_dissector_classification.c and
> xdp_metadata.c to hand-build packets. No current caller builds an
> odd-length payload, so nothing fails today, but a future one would
> get a silently wrong checksum.
>
> Also bump flow_dissector_classification's TEST_PACKET_LEN from 100 to
> 99 so this actually gets exercised instead of staying latent.

Great, thanks for the update.

> Without the fix and with TEST_PACKET_LEN=3D99, flow_dissector_classificat=
ion
> fails under vmtest.sh:
>
>     test_flow_dissector_classification:FAIL:test third port unexpected
>     test third port: actual 0 !=3D expected 10
>     #137/6   flow_dissector_classification/ipv6:FAIL
>     #137     flow_dissector_classification:FAIL
>     Summary: 1/0 PASSED, 0 SKIPPED, 1/6 FAILED
>
> Kernel just drops the packet over a bad checksum. With the fix, both
> flow_dissector_classification and xdp_metadata pass.
>
> v1 -> v2:
> - comment style: opening /* on its own line, per BPF selftests style
> - Retarget the Fixes tag to bcc00987bc56. commit f4504af68575
>   ("selftests/bpf: move ip checksum helper to network helpers") moved
>   the helper, but sizeof(iphdr) is always a multiple of 32 bit words /
>   4 Bytes (iph->ihl counts in 4-byte words), so the odd-length path
>   was never reachable through build_ip_csum(). csum_partial() first
>   gets called with a length that isn't guaranteed even in
>   bcc00987bc56, via build_udp_v4_csum()/build_udp_v6_csum().
> - TEST_PACKET_LEN 100 -> 99 so an existing test catches this instead
>   of the bug staying unexercised

Could you please move the patch changelog under --- so it does not end
up in the commit once it is merged ? You can also drop the Link tag, one
will automatically be added on the latest revision once it is merged.

Up to some extent, you could also move the ./test_progs sample output in
the comments under --- as well.

> Fixes: bcc00987bc56 ("selftests/bpf: add network helpers to generate udp =
checksums")

You chose to use bcc00987bc56 rather than e2a46d54d7a1, but I guess it
is ok.

> Link: https://lore.kernel.org/bpf/DLG5TIIHIMC2.2YCCY0UX86YQF@bootlin.com/=
T/#t
> Signed-off-by: Madhav Khosla <madhav.khoslaa@gmail.com>

Thanks,

Alexis

--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

