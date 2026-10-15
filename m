Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBD243BDA3;
	Thu, 15 Oct 2026 08:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792053278; cv=none; b=lCgEgIwx7Q1P3FCzI/0C0/WPGXEl9hb7YSF89+nSmJ+7fHRCAPZa2YWNhkPW2erEeoAaQy/LPhXRy85//fYL3aJjfzo8YPuzeMKpi2/HmOAqxUVC7F3jdGedUuu2wxlnvbFB/Esi1fa18h5DNnRcAErQWNMRhi98pFAYfyZhFhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792053278; c=relaxed/simple;
	bh=B0JeAqgS05G61VP/7q/RIJutRiDOFlT2EVkqUApQL48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HKRYrYJpnJgi0+dVTQg6A4eu2qGEfisJVIIcROIjU0DuEacVOvUB56xI9Xv0mII7kL7BYBFlMCVpJdtkiUuMpTxKCKBuP0djkg19OQr9//O+o1eRsqIs164lG+0PdIVo2589T4rsEEqK0yaUUZV2l2DezdrODAHewISQr9g44LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EwBCIuk7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EwBCIuk7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06BF1F000C4;
	Thu, 15 Oct 2026 08:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792053277;
	bh=DCrRlqnuXbkzVitUEv7JIXxCTOZv2vqo921pf1/GWDc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=EwBCIuk7FgSFxMtZiB7KB34q/IU9KiVjghb2RG4Kx8c2VXQGzRVP7IxoPPTmaf61x
	 8vEJz2HL3xdOwKhlkJhX53fAdfT7Y6meFFaVWZums65DF709MNylooIqZcjWUCAANQ
	 JRuo/xttbA9lSn9Qe74k+M3dNthv4fuKRNY0VqaaU2+TmPVDQvGpvLn4pig+eq8pqm
	 qzVtsYbinSBNkZk6xpJAk4NOecPZ3ZhhfQ67SI+/QoAx7rpxTkcaoyPalEi2MKIQli
	 whMJRztMllOnaCpdpchiBFO9Wwpv9VrUD42TkyAZfDj/pJNzyu7FUiHDVKB/Ru39eR
	 0W1PZ0uC26yNA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v3 net-next 09/15] selftests: xsk: run one test case per
 xskxceiver invocation
In-Reply-To: <20261014184539.774708-10-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-10-maciej.fijalkowski@intel.com>
Date: Thu, 15 Oct 2026 10:34:34 +0200
Message-ID: <875wz3746d.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Replace test_xsk.sh and xsk_prereqs.sh with test_xsk.py, which runs
> xskxceiver once per mode and case, so that every case starts from a
> fresh process and a crash fails only its own case. A single case is
> also the unit that the next patch splits into RX and TX processes.
>
> xskxceiver now requires -m and -t, runs exactly that case, reports one
> KTAP result and exits with its verdict. An unsupported mode skips the
> case instead of exiting with XFAIL.
>
> test_xsk.py uses the networking selftests Python library, as does the
> hardware test added later, so every case is a KTAP case of its own:
> test_xsk runs each case that xskxceiver -l lists in skb and drv mode,
> e.g. test_xsk.drv_SEND_RECEIVE, and test_xsk_busy_poll runs them again
> with busy polling. The usual -t and -T options select cases in place of
> the script's -l, -m and -t, and -v and -d go away, as the output of a
> run that does not pass is logged. Each case runs on a veth pair of its
> own, so an MTU or an XDP program that a crashed case leaves behind
> cannot reach the next one. The pair stays in the current network
> namespace, as only the initial one has the net.core.max_skb_frags
> sysctl that xskxceiver reads. A case is killed and fails after two
> minutes, and the test skips when xskxceiver was not built.

This timeout might need to be easily changable from the cli...
follow-up!

> test_xsk.py reserves 32 huge pages for the UNALIGNED cases, restores
> the count when it ends and leaves those cases out when it cannot
> reserve them. ksft_run() exits on -l and -h before the count is
> restored, so test_xsk.py rejects both. The huge page, busy-poll and
> endpoint wait helpers, which the hardware test shares, go to
> net/lib/py/xsk.py, which joins the AF_XDP entry in MAINTAINERS.
>
> test_xsk.py leaves out two cases that test_progs skipped as flaky:
>
> - XDP_ADJUST_TAIL_SHRINK_MULTI_BUFF: bpf_xdp_adjust_tail() frees the
>   trimmed fragment as the memory type of the XDP RX queue, which veth
>   and generic XDP leave at MEM_TYPE_PAGE_SHARED for frames that they
>   copy into page_pool pages, so the page leaks from its pool and the
>   pool's shutdown stalls
> - XDP_ADJUST_TAIL_GROW: it skips in skb mode, and in drv mode veth
>   copies each frame into a page_pool fragment that leaves no room to
>   grow the 128-byte frames of the case unless it is the last one of its
>   page, so the XDP program drops most frames
>
> Drop the xskxceiver.c note on enabling packet dumps with -D in
> test_xsk.sh; xskxceiver has no such option and dumps packets on
> validation errors.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[...]

>  tools/testing/selftests/net/test_xsk.py       | 140 +++++++++++
>  tools/testing/selftests/net/test_xsk.sh       | 230 ------------------

Yum! Nice!

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
