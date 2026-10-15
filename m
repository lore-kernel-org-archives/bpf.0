Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB94738C421;
	Thu, 15 Oct 2026 08:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052160; cv=none; b=tDv3i+4GSCB1umgEytHVy0bHh4xMlYFVvCgwtw+cNjIdolJmSTPL676h5+qPYJGsLxnqafQYL7XfLdKm0xM3ybdTT6OLNGOKRJbazO6cRd8Rd62M+KhAnMNtqC1K+VlnupBfjMSM+8ASGKZNB1K/USN5rexLVykmWHPCqFo5Cg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052160; c=relaxed/simple;
	bh=q2u2xRSdL3HoVQMTqEJ/RIleIT+F1sJVsSKd4l0Btes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FE66HQP4ZWZ9C3lFmGcBiGOOwUaoxUAIsw/5faNw2m+SpgesoL/Zad3TR3T3boq2sJWSzmawjUxIGkW8lozPbfNL9hMGP++wQ4+wgJK0dPJcJHFQEM63lg19jBCG4d+kpUV4+1YRd8lyTbxlVRICqf2YVnZ7oftu9+AU3CFDG0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDsncdV7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDsncdV7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606B01F000C4;
	Thu, 15 Oct 2026 08:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792052159;
	bh=q2u2xRSdL3HoVQMTqEJ/RIleIT+F1sJVsSKd4l0Btes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=iDsncdV7srtDn/ZF+1ezqfImPYkMXs/Or5MgmEyESmOgPMno0vwPK82U4+YSUU1GG
	 /YtygL/oHK1uE78gQvMqtI4lvJfQKCcKcBW74m4Y6XqKtUQOAlb0r1jLF/KnMkmYmS
	 iRP+rs9/BrdmQ35UCNiWYvM/tBmQcDaSFDuFIqBqLlS8jZNKwbFb22AlYM0STsu+3C
	 ImJQzUGlQDBhMBoqfiG5ObGDxTkJfwxcPXY6c1qmp7EA4fMCVxZ5ZbFn/aXJv/ytHM
	 dkiicSYWIPwZutstbeSqly0gp/ElXftX9zfjgufl6kp2eRmCdHeb/1n2jPW3mk1GUD
	 VrjV4Av2GxBjA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v3 net-next 02/15] selftests: xsk: size the TX UMEM in
 HW_SW_MAX_RING_SIZE
In-Reply-To: <20261014184539.774708-3-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-3-maciej.fijalkowski@intel.com>
Date: Thu, 15 Oct 2026 10:15:55 +0200
Message-ID: <8733u78jlw.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> HW_SW_MAX_RING_SIZE gives the RX UMEM 8k frames and 8k rings, then
> sends batches of 2k and of the maximum HW TX ring size minus 8. This
> only works in the single-interface mode, where the TX socket uses the
> RX UMEM, and veth, which cannot change its ring sizes, skips the case.
> With two interfaces, TX has its own UMEM of DEFAULT_UMEM_BUFFERS (1k)
> frames and 2k rings: the in-flight limit in __send_pkts() turns
> negative for a 2k batch, so TX never sends and RX times out, and the
> second batch would not fit in the TX ring anyway.
>
> The next patch removes the single-interface mode, so size the TX UMEM
> like the RX one. The shared UMEM setup copies the RX UMEM over the TX
> one and is not affected.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
