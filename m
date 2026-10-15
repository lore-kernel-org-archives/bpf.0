Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C6F3A0E80;
	Thu, 15 Oct 2026 08:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052309; cv=none; b=C9zwhjASc4ocjioAB+bsObbK3GV69Q1WWOmuD7NS0yVR//p3ZKPo+LEFOZqkHc4dH6KNwM1FTdbGkS83mohyqoh5ig+ws86AeglSwyqDdFjGqNCpfbXBzKmKDkvBDPMmA2AZoG4M5K+4i6OzPU+HJ1ZQ02HspJ9uQDSDSpD3HDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052309; c=relaxed/simple;
	bh=BwxE6RsL/PjM9CcEB+CvdbwUBreqVvKr22WP7X7Nw/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VDEeYu5fMbjJohxgZW32PqZNaJKSITdpKL1yGnMaQjW6qPI5aetwhmP3300qJ8kS6hbplBbrPj2Pm5fAVG39W5H2a5XDmfHwveGOOFEZgthePUQAxpeK2qlM1nPdTnTBp4OXDT1Sr19xOsVZqKtsis4Iq73ZNkYIO5GysJJHn48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gjTRYx5p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gjTRYx5p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C27DB1F000C4;
	Thu, 15 Oct 2026 08:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792052308;
	bh=BwxE6RsL/PjM9CcEB+CvdbwUBreqVvKr22WP7X7Nw/c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=gjTRYx5pgGrVJe1/ZX+4Fu65Q95J+pADloo0EVWH+fPmTHb9XrlaKa8xJNohGoOMj
	 XNvaQ+cMaa+AhLVM8b5cKpaP828ZcVKL2GcagpsNAHfSXnelUagWF2zc0DuiBnKiha
	 2GSzQl/gafl0K6QdA2SohVo9aHQMWbyf7xz89+TMdgN7Rt8evD6jW3dwiNO4HxbWSU
	 AmTB/n151s9OfDWs+FAY+wRmRH+8rg3YVvoVszaxmbs63htbIVIJUymXm6rFUIvACd
	 uULuo4UV8t/t32Zo/TRD3vcVfJIoGn1zQUBtq8jpfzz+jZ5lzYfLIZRhMcH8BR9NR+
	 TyuiT9nAjpp+A==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v3 net-next 04/15] selftests/bpf: drop the test_progs
 AF_XDP wrapper
In-Reply-To: <20261014184539.774708-5-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-5-maciej.fijalkowski@intel.com>
Date: Thu, 15 Oct 2026 10:18:25 +0200
Message-ID: <87tsmn74xa.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> prog_tests/xsk.c runs the xskxceiver cases inside test_progs, driving
> the TX and RX sockets of a veth pair from two threads. The following
> patches turn each endpoint into a process of its own that can run
> against a peer on another host. Keeping the wrapper would mean rewiring
> it at every step of that split and teaching test_progs to spawn and
> synchronize peer processes, so drop it. BPF CI loses the ns_xsk_skb and
> ns_xsk_drv entries; the same veth coverage stays with test_xsk.sh,
> which moves to selftests/net together with the engine.
>
> ci_skip_tests[] held the cases that the wrapper left out: flaky and
> slow ones and those that need hugepages or HW ring size support.
> Nothing runs only one of the lists anymore, so fold ci_skip_tests[]
> into tests[]. The test IDs do not change.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
