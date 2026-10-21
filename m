Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792620107;
	b=h0grXauRcYprKZ4SZC3vDyubcgYWxWZeuQwA+tiUQBYXfl7dq0wdlsG1Y8PbLwYcuKet
	 TxkAmdQzs0gNhEyAGAnGwKYAA7bYXSXBB83mQi/Ym1rrqg8Moh2hlvNX2TnDz5C38kLq7
	 0gtjF/KdzxWJgPaqbn2TQWuW21eOtGN0n0kMW+EXqiGBIDI4CukCIslgQbhpF8+NK2uqH
	 ee0dKXeLLE+flhR+NnGlJ2ORVYefl7Bgwmit+ilstPkxgy7mD7BnuuzgALFUpY8qsjDnK
	 +ThqCF/hO+Tg/KazOws+mtb7T4yGfLoSMJXkgbRafKAmw59FE/0NxisbelR+j9VlyUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792620107;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JyaVYtrytA0eaLcHL4hmliuZFXquyT9c4Y2ZvnCIqBc=;
	b=CxIH0MZ/SVO+kbdtwS7FysIWrHAyGImJ5O09Wr/Ewfa/HiKzKZUeDNinHrfGunNGyme3
	 n9lohM866rPiXaRre1HYRBiitJ/1q1u02IY1gdRtymubSmGP/WyrXfww+fAm8piomnfPq
	 qY5W+5Zo77GyFmkRSyUJxg3TZ+CepTuVZc5wlx7vmw6EC9RqYcefnQGOT8/vKnIMUmWC7
	 78JXGrTEpamAc5RB7WgmsmMHPni5hRqkGLoeF8VmqipbtPH3hQu8NYEPHKOLa10vl3EI1
	 THCet9l2fETjDkSSHuTZnjMPATX+XwV0M8Z777EcvclA8cCZ4PvOqRyGkn1fuuk/mwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="l+/ePMc2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0170E606A319;
	Wed, 21 Oct 2026 22:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l+/ePMc2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 355FA1F000C3;
	Wed, 21 Oct 2026 22:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792620106;
	bh=JyaVYtrytA0eaLcHL4hmliuZFXquyT9c4Y2ZvnCIqBc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=l+/ePMc2pas9bGoAqSfUokAb0f8FZAZLx+G9xwNpw17vswhhu/6hMgjaoPnouoY5v
	 txabJjv2mQLzq68Om6aOOv2LC6O4Bx+YpDR1sehiw8hoW+Pl8VtGI1/6Hq4+gb+qIA
	 fGYc6Nc0g4uDUcZ/81qTvk/Lz9msbDQpYsU33yqXkilKal41n+/HV1PmC+W+ezj3Be
	 BGrhEtUpvx9h8l9W+gFSo/I6UMqW4mMqnP5qzSahPnMd+eFhhuwzsgEDPWhA3lzeeL
	 HLvqTi3p6k+NV+iJAhIfNgj3MhbNnY0tWCOLqA4Wld5284k8JWiBQEcUy/lTR3dE8K
	 +YKJ3rscod4Wg==
Date: Wed, 21 Oct 2026 15:01:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, bjorn@kernel.org
Subject: Re: [PATCH v4 net-next 09/15] selftests: xsk: run one test case per
 xskxceiver invocation
Message-ID: <20261021150145.65a22a61@kernel.org>
In-Reply-To: <20261016174338.787135-10-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-1-maciej.fijalkowski@intel.com>
	<20261016174338.787135-10-maciej.fijalkowski@intel.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 16 Oct 2026 19:43:32 +0200 Maciej Fijalkowski wrote:
> Replace test_xsk.sh and xsk_prereqs.sh with test_xsk.py, which runs
> xskxceiver once per mode and case, so that every case starts from a
> fresh process and a crash fails only its own case. A single case is
> also the unit that the next patch splits into RX and TX processes.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1fc9eaedd744..6985a42bc09c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -29784,6 +29784,7 @@ F:	include/uapi/linux/if_xdp.h
>  F:	include/uapi/linux/xdp_diag.h
>  F:	net/xdp/
>  F:	tools/testing/selftests/net/*xsk*
> +F:	tools/testing/selftests/net/lib/py/xsk.py
>  F:	tools/testing/selftests/net/lib/xsk/

pylint has some complaints, about main(), I think?
Could you make it clean?

> +++ b/tools/testing/selftests/net/lib/py/xsk.py

Really not loving the amount of "library" code added here.
Do you need this just to run it over veth in net/ and over
real HW in drivers/net/ ? Are the test cases very different?

I wonder if we could solve this by parameterizing the env
class to use veth instead of netdevsim and then have unified tests?


> +def xsk_wait_endpoint_exit(endpoint, label, timeout):

odd, the existing cmd() / bkg() stuff doesn't work for you?
It works for many other tests...
-- 
pw-bot: cr
