Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE2D48C41B;
	Thu, 15 Oct 2026 10:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792060175; cv=none; b=lhs0WHAwQkumt/l36QZkdsUIiw6cxannW6bJHMEQw587+bd5nxDLc8cTONZMRE0yUCxWOdSIyB3eBqiPbdUWHMn2NPdY+BUinnzSALsU1yt17lLptg7CkyMeHmE7YJRDZXEeYnBuwSm3JL6MFyDfhr/RmaJF7X3uZBlmAT9HKVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792060175; c=relaxed/simple;
	bh=+gp9W2HjvkTvPbYIFY7CuaxOyO8m2XTrZqpcWgKBzi0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O1x21LxI4zw+OMNtTU2FUV+cNv6PyTPVZx1muh0S3z422nPZ40Q0fEjqqDrdZuqPy3grJ69gZs72Yl0TBuul21bIzhzyLM5/uU5Q3L0YpSLQn2sVt3YcA4qVlLhuZsfs/K/TjuCJgrBKFSj9Iq0ZAoGVmYzSVJuq8MfS1EMrkh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOCdXnFf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOCdXnFf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EF2A1F000C4;
	Thu, 15 Oct 2026 10:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792060173;
	bh=krtsqP9HVq82+t6vS5sSiaQFrwSgNYHXkfB8BbMCijI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=ZOCdXnFfU2EBs7sZ+792qES1kj3cYliEVjjFguOhwELR3sELcHqT8KsLUCHxTu5ED
	 Wv3gr7CwnFap7Gdpi0DVvKhi22kwJUnIMFEItVaWUF6NLzcrnXX+zzLOyqr5onVYQK
	 C1HNFhmrDr+F1JKmOLISzEU1+i5M3Uwm0BfylJGVA1Tq7dFQG9PkYX/fO23e7lpbVs
	 od/pk3DkvOvFZsIeIgOfC+WSdBekm/EriYMOyEowghAXrVAt9s9scJy6+Al15+6Sqr
	 sntlsX9SUjENaTCp/Q7Ej0dIS8/PpjYuh2pVRb1QLvXkEWTSBeMA/HGNYVNywyqq6n
	 rV0O64V13b8Nw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>, netdev@vger.kernel.org
Cc: bpf@vger.kernel.org, magnus.karlsson@intel.com, stfomichev@gmail.com,
 kuba@kernel.org, pabeni@redhat.com, tushar.vyavahare@intel.com,
 kerneljasonxing@gmail.com, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>
Subject: Re: [PATCH v3 net-next 14/15] selftests: drv-net: test AF_XDP
 zero-copy with an SKB peer
In-Reply-To: <20261014184539.774708-15-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-1-maciej.fijalkowski@intel.com>
 <20261014184539.774708-15-maciej.fijalkowski@intel.com>
Date: Thu, 15 Oct 2026 12:29:30 +0200
Message-ID: <87jynj5kad.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Maciej Fijalkowski <maciej.fijalkowski@intel.com> writes:

> Run the AF_XDP cases that a physical link can carry as pairs of
> xskxceiver processes: a zero-copy endpoint on the DUT and an SKB-mode
> endpoint on the remote, which needs no zero-copy support. xsk.py runs
> the cases that xskxceiver -L lists, in the DUT directions listed with
> them, as KTAP variants named <rx|tx>_<CASE>. test_xsk runs them with
> the DUT socket driven by interrupts and test_xsk_busy_poll with it busy
> polling, after xsk_setup_busy_poll() sets napi_defer_hard_irqs and
> gro_flush_timeout on the DUT so that SO_PREFER_BUSY_POLL keeps its IRQs
> masked, as on veth.
>
> main() sets up what the cases share once and undoes it after them, as
> defer() works only within a case, so xsk.py rejects -l and -h, on which
> ksft_run() exits without returning:
>
> - the DUT endpoint binds the last queue with both an RX and a TX ring,
>   which is taken out of RSS with ethtool -X equal and handed back with
>   ethtool -X default; a TX endpoint fills no RX buffers, so in
>   zero-copy mode its queue drops what it receives and TX cases need the
>   queue out of RSS as much as RX cases do. A DUT with fewer than two
>   such queues skips
> - an ntuple rule on each host steers the test UDP flow to the receiving
>   endpoint: the DUT queue in RX cases and queue 0 of the remote, where
>   its endpoint binds, in TX cases. A host without ntuple support skips.
>   Setting the rules once spares each TX case the ssh round trips of a
>   remote rule and toggles ntuple-filters, which resets some NICs, once
>   per run rather than per case
> - huge pages are reserved on both hosts, and the UNALIGNED cases are
>   left out without them
> - both endpoints get the DUT's xdp-zc-max-segs for TOO_MANY_FRAGS,
>   which is left out without multi-buffer zero-copy
>
> A DUT that does not advertise AF_XDP zero-copy skips the run.
>
> The remote endpoint listens on REMOTE_V4, and the DUT endpoint connects
> once the remote says on stderr that it listens. The control connection
> shares the tested link, where the XDP programs pass it to the stack.
> Killing an ssh client does not stop the command it runs, so timeout(1)
> bounds the remote endpoint, and the runner waits for it to exit before
> the case ends. The endpoints are waited for with the test_xsk.py
> helpers, so the output of one that does not pass is logged, timeouts
> included.
>
> The endpoints detach their XDP programs and restore the MTU and ring
> sizes when they exit; the runner detaches the programs and restores the
> MTU only after one fails or is killed. Each endpoint sees only its own
> device and mode, so one may skip a case that the other runs and then
> fails once its peer is gone; such a case is reported as skipped.
>
> xsk.py runs the xskxceiver that net/lib builds, which drv-net already
> installs, and copies it to the remote with cfg.remote.deploy(). Add
> xsk.py to TEST_PROGS and to the AF_XDP entry in MAINTAINERS,
> CONFIG_XDP_SOCKETS to the drivers/net/hw config, and the xskxceiver
> helpers to the drivers/net/hw library exports.
>
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

I just skimmed this, and it seems like it needs some scrutiny on the
cleanup side. The LLM flagged a few cleanup issues. Could you check
these paths?

  | main() only restores shared state on the normal path. Exceptions
  | during setup can leave RSS, steering rules or hugepage reservations
  | changed. Would a run-scoped ExitStack help here?
  |
  | _steer_udp() enables ntuple filtering before recording its original
  | state. If rule insertion fails, that change isn't tracked.
  |
  | _unsteer_udp() stops on the first error, leaving subsequent cleanup
  | undone.
  |
  | _run() waits for the remote in finally, but doesn't ensure the local
  | endpoint is stopped/reaped if its wait is interrupted.
  |
  | The fallback cleanup restores XDP/MTU, but not ring sizes after an
  | endpoint is killed.
  |
  | "-X default" resets RSS rather than restoring the original table.
  |
  | An unconditional SKIP when either endpoint skips can hide a genuine
  | failure on the other endpoint, including a crash or cleanup failure.

The defer ordering itself looks sensible: detach XDP before restoring
the MTU.


Bj=C3=B6rn
