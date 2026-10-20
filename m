Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524625;
	b=jWLz+CQcZ/5Ew/kTWFXsoVAgj6xVEVSZ75EIGKhMnFqYpRp3KVSkhUsvlvOCocAt/5yc
	 QUqGa1mu00KJ5KLf/ZSuoXfA9Di60MtyZ3TGjCiQgZ/UgBU0C0yqVYnFWPOJ4QGkiO3xc
	 XADQpdWsD/ParHz4zOZ1Qh5v60TPe1STmCq3Eu0RFBmoiNpd39DADvgkN0i5Z1aWqSx76
	 XVt4orMB/do5ks086g7oNMhjcaQ+OMBcloIB4xZ2eQeg2VsQ2sq7V32atqcU3tMzeXP3R
	 uI17gfikRO/c/fwddNp3hf/Zg1MTLoZa7XxU2CstsyuV7xCn1Og1aDsVHhHcsxh02HQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524625;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fA8NmMcCUM69tmGM3phS918ewacyRr6rhiWhDJJ8Fzk=;
	b=nvynbQ5r4AyqOjTAGmXg0hkjTEiRgS+MUtnxrz+psGj96lXW0SCjU16fPHYlsvWB3yG4
	 f0hkUkdAac5uJb1Pvoh3wXZBPXqZiOOVsAajfJmxBTw4PTWIxw7qGbscdLuC/LYIizsRC
	 WR0RABtskZzDno0LXhCw0+Elx/riyCXQFMSEaiHNeHQxtyhjzAcM8WIYamkL/9hQXYXeV
	 WygnwsFmcCr+UbtiAd7fTVeQe9e5gIhQ1y/PhhUmiVObS3dJoacQjNZifQAy7YFmz2+PW
	 Dec7I2FDwMuKbSc7XDIn1UZQSINUawHv9/OCYvqOzzONqO5nnniPVmhDEQuuQ9+OeqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dR85apWi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59DEC60A2617;
	Tue, 20 Oct 2026 19:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dR85apWi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E7C1F000CC;
	Tue, 20 Oct 2026 19:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792524625;
	bh=fA8NmMcCUM69tmGM3phS918ewacyRr6rhiWhDJJ8Fzk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=dR85apWi/gh/GTS8LvuRBJzIGbPY9JsgAZa3H5lzy4QEmS2qo+ckN69t3DBiDbRT1
	 cPgqRATnn227MZNaJQ4r4I6KwbH1pCybD1gMgsTULzW7b5ulSvvVjY/aKFjdoR21j2
	 0Haemu8/RZGC8J6HAEzuV4P9AipdJgfS22DKZs/xVenB4apKUmhqd20iQgztV+23Yl
	 oyhIhkVyvqv6WMsISHPi4c68DJ/bdwssPpF3zdWycXYdD2qaAzV9BrFNBcj4miv7IX
	 ZddjroPZ6Drje0e6YrqMY0AZoey+0O8aGa7LOQcvr6xZJFTmeUWoPKh15uZpZnxWqf
	 rEu/7F98+6d+Q==
Subject: Re: [PATCH v4 net-next 08/15] selftests: xsk: split xskxceiver main()
 into setup, run and cleanup
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Tue, 20 Oct 2026 19:30:24 +0000
Message-ID: <179252462414.3135.14132946402715622104@kernel.org>
In-Reply-To: <20261016174338.787135-9-maciej.fijalkowski@intel.com>
References: <20261016174338.787135-9-maciej.fijalkowski@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In tools/testing/selftests/net/lib/xsk/test_xsk.c,
  xsk_reattach_xdp() attaches the new program with…
- [Low] Baseline decision: not a valid finding at the end of the series.

--

selftests: xsk: split xskxceiver main() into setup, run and cleanup

This splits xskxceiver main() into the bind_iface(), detect_mode_caps(),
mode_supported() and cleanup_iface() helpers, to prepare for running a
single endpoint per process. run_pkt_test() now returns its result, and
main() gets a common out label for teardown. ksft_print_header() is called
right after parsing, so stdout is line buffered.

> diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> index d82224a4fa4b0..97eece4c57f89 100644
> --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c

[ ... ]

> @@ -317,26 +332,43 @@ static bool is_xdp_supported(int ifindex)

[ ... ]

> +static void cleanup_iface(struct ifobject *ifobj)
> +{
> +	if (ifobj->xdp_prog)
> +		xsk_detach_xdp_program(ifobj->ifindex,
> +				       mode_to_xdp_flags(ifobj->mode));
> +	xsk_unload_xdp_programs(ifobj);
> +}

[Severity: Low]
Can a native XDP program stay attached to the interface after xskxceiver
exits?

cleanup_iface() uses ifobj->xdp_prog and ifobj->mode to decide whether to
detach, and which flags to pass. Both fields are set only at the end of
xsk_reattach_xdp() in test_xsk.c, after the DRV mode check:

test_xsk.c:xsk_reattach_xdp() {
    ...
	err = xsk_attach_xdp_program(xdp_prog, ifobj->ifindex, mode_to_xdp_flags(mode));
	if (err) {
		...
	}

	if (ifobj->mode != mode && (mode == TEST_MODE_DRV || mode == TEST_MODE_ZC))
		if (!xsk_is_in_mode(ifobj->ifindex, XDP_FLAGS_DRV_MODE)) {
			ksft_print_msg("ERROR: XDP prog not in DRV mode\n");
			return -EINVAL;
		}

	ifobj->xdp_prog = xdp_prog;
	ifobj->xskmap = xskmap;
	ifobj->mode = mode;
    ...
}

xsk_is_in_mode() returns false if bpf_xdp_query() fails, for example on a
netlink socket or recv error. That can happen even though the attach with
XDP_FLAGS_DRV_MODE succeeded. The error path then returns without
detaching the new program and without recording it.

If this is the first DRV/ZC attach, ifobj->xdp_prog is still NULL from
ifobject_create(), so cleanup_iface() skips the detach. If an earlier SKB
attach succeeded, cleanup_iface() detaches with XDP_FLAGS_SKB_MODE, and
that doesn't remove the native program.

In this patch, this only matters when the failing attach is the last one
for that ifobj. A later successful reattach in the same mode fixes the
bookkeeping. Later in the series, xskxceiver runs one test per invocation
with a fixed mode. Every DRV/ZC run then hits this check on its first
attach, and xsk_reattach_xdp() and cleanup_iface() are still unchanged.

The old main() never detached XDP programs at all. So this is a gap in the
new teardown, which the commit message describes as using flags "so that
they match the attach".

Would it make sense to record xdp_prog and mode right after the attach
succeeds, before the mode check? Detaching on that error path would also
work.

> @@ -371,90 +407,62 @@ int main(int argc, char **argv)

[ ... ]

>  	if (opt_run_test != RUN_ALL_TESTS && opt_run_test >= total_tests) {
>  		ksft_print_msg("Error: test %u does not exist.\n", opt_run_test);
>  		ksft_exit_xfail();
>  	}
>  

[ ... ]

> +	test.tx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> +	test.rx_pkt_stream_default = pkt_stream_generate(DEFAULT_PKT_CNT, MIN_PKT_SIZE);
> +	if (!test.tx_pkt_stream_default || !test.rx_pkt_stream_default)
> +		goto out;
>  

[ ... ]

> +	caps = detect_mode_caps(ifobj_tx);
>  

[ ... ]

> +	if (opt_mode != TEST_MODE_ALL && !mode_supported(opt_mode, caps)) {
> +		if (opt_mode == TEST_MODE_DRV)
> +			ksft_print_msg("Error: XDP_DRV mode not supported.\n");
> +		else
> +			ksft_print_msg("Error: zero-copy mode not supported.\n");
>  		ksft_exit_xfail();
>  	}

[Severity: Low]
The commit message says:

  cleanup_iface() detaches and unloads one interface and copes with
  partially initialized objects, as does pkt_stream_delete(NULL), so
  main() has a single exit path

Is that accurate for this patch? main() still calls ksft_exit_xfail()
after setup in two places, and both skip the out label:

  - when the requested test index does not exist. This check now runs
    after both interfaces are bound.
  - here, when the requested mode is unsupported. This runs after the
    packet streams are allocated.

bind_iface() can also call ksft_exit_fail() from parse_command_line() for
the rx interface. By that point the tx interface's skeleton is already
loaded.

None of these exits leaves an XDP program attached. is_xdp_supported()
detaches its probe program, ifobj_zc_avail() deletes its socket, and
process exit frees the skeletons and heap memory.

This is resolved later in the series. There, find_test() and
xsk_set_flow() run before any interface is bound, and only the local
interface is bound. The unsupported-mode case also becomes ret = TEST_SKIP
followed by goto out.

Could the commit message for this patch be reworded? Another option is to
convert these exits to goto out in this patch.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016174338.787135-1-maciej.fijalkowski%40intel.com
