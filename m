Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC71449EB2;
	Thu, 15 Oct 2026 09:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792057377; cv=none; b=FGwlNYt39s9cgr87iIqztjr6tid8Js3qZHanx3TpjomEtO7hmqqGnMSnJFgzwCnDLCEdYD1EZg5RE+Rt3/WhGJ/lz2D1UcrIWpg7Jj5TlGy0zR3GZz5bUu3+PlAVLBwDuWjXdE+hU/idbbctIVSBnTQtTamVh1ZlELuVPufnJS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792057377; c=relaxed/simple;
	bh=znfCEwm3GWzKszFbNl1kkrBKuTB5GL0Po6X0Khp3RVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lpAZN9BO6lP0vrx6WjUXdfE+x/MWeI29qLpKiR1mVtFeDgidM1JTOYIEeLulATdcASR61bwW4vJthHfuHk4hYBE0jKaFxLFrqWwzTd9E+6loqrVf3Mc36xj/dNasqWdQV9oyHSV+eUVAXPw83TsX9cvqSozKOCcu9k75edqx1N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfIxfCLp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfIxfCLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 824A61F000C4;
	Thu, 15 Oct 2026 09:42:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792057375;
	bh=g4clIODsEca1+J5TLAYhHXBcWbPQe9okPUAhZ7vXAa8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=GfIxfCLp1ln7ZfLbUFRZ+biNEr58KuMWvP1gmR4En3e3MCyrVI2aEu4fJ7i4PmlPU
	 SsQQYi2JNbl3Oje3w4ArGmyr+VHQSNzRh5vwicSr1JCqCFhuPUqVlNuqQ/GAa0078X
	 9xfn9sMhDX/GZGm0XkGBGoF9SffRMI9Du/viCR3VJUcapwh0Bd8i+msqrY2pSD+t8k
	 OtPubR9bozTX2zFWIYChvLUzE/+eUcXE16g2bcY9gDE0Apkuz+IyTkOzESiwQ+qiXN
	 REJDjzjyDpiH8ooivpDIVIMBPRYi3Vvm+JoWicJCqpEMrWsMg/dUJjEGF72q5NNbvQ
	 7vB0Y+Qu/wnnQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v3 net-next 11/15] selftests: xsk: add a hardware mode
 to xskxceiver
In-Reply-To: <20261014184539.774708-12-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-12-maciej.fijalkowski@intel.com>
Date: Thu, 15 Oct 2026 11:42:51 +0200
Message-ID: <87tsmn5mg4.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> drivers/net/hw/xsk.py, added later in this series, runs each hardware
> AF_XDP case as a zero-copy DUT endpoint and an SKB-mode remote endpoint
> over a physical link, without negotiating capabilities between them.
> Add what such a run needs to xskxceiver:
>
> - --hw sends UDP/IPv4 test packets (--udp-src, --udp-dst, --udp-port)
>   between the real interface MACs (--peer-mac); XDP_SHARED_UMEM, whose
>   program picks the socket by a synthetic destination MAC, skips

This reads weird to me.

I wonder if we can avoid introducing a separate "hardware" mode here? It
seems to bundle packet format, link handling, and assumptions about the
endpoint modes. Those are separate concerns, and much of this should
work with veth too, no?

Could we first make the real MAC addresses and IPv4/UDP format common to
both veth and physical-device runs?

Then --listen could work independently, timeouts could be configurable,
and test selection could reflect the actual endpoint modes and
capabilities. For example, skipping TX_QUEUE_CONSUMER because hw_test
implies mixed ZC/SKB endpoints seems to encode the launcher's current
configuration into the test itself. "Real" endpoints could also run the
same mode.

If we need to keep both packet formats, something like
--packet-format=3Dudp would maybe describe it better. I'd prefer keeping
these behaviors independent rather than giving the combined mode another
name.

Also, we need IPv6 support here in addition to IPv4. You can't assume
that the DUT is onlink or IPv4.


Bj=C3=B6rn
