Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD7E45FFC2;
	Mon, 12 Oct 2026 08:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795026; cv=none; b=Hnck/pQ55eFXuz/RubOmOY+BerrV/o0IqaF8TpxTr/1aCg5x4Bx7aLsFw1Evh0lTqLavDC85C4vbPwI9IzLifXvrVnC90JxNrYjhgcxffF0zo46ppaZ7g550x0EyRjm49u+rE+dJOWZbOHoT0AzOqg7ZV+UWV31FBr3Q4B6oWXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795026; c=relaxed/simple;
	bh=7uGwet5vv8QvJLY3RhxVw9iHYoaAWz300rmlo6r+ZbM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gN/daDrNvmOs0+wIv0oXO3wjIuoC4ukj38Fum3+HMfktMsekhTgRt1CCAm7dMir8oQZhzm+0Pc8+5v2WL5/msvj5WLE5w6VIiobR+B5EDYD/6DAyUnsejukow0++JODVDoaeS3Qv+5YViYa+I9HhUPPVkcrzPk1Ue6BAexjxWt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAQ1Qmb9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAQ1Qmb9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF8941F0089C;
	Mon, 12 Oct 2026 08:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795024;
	bh=Ghncp4WAeQBGRLfL+k1KqZhm0oT4aXsC3khHbNyh9IU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FAQ1Qmb9hTIuOcZUfxzjlk7OMPg4QbiisURsYpSnamnSOetw9Hr5hMhmZxYv78bKi
	 MqZ9LZLOuLZsb4TfxNuFNaIiLug25XIpweW1kUAZLeqSSaza/368QXZedIrfM244eE
	 zzhFya3IWsk6rpsky+DyJCOzYCjPzBnxa/g6DKdB6ghqTv1dBDZpMrB5owcV2ahdUO
	 g3oWlYikc4RT8n5un2EJFZXhg8GGTsNVv1JDK0xTC0YFQ/61HLiNWBNhjRy/dX22Bf
	 nRmAVQ6Kga5qn2Eko7RpF7WVhYjAmm9hGzdF3TkDwnvPwE47Du7dhX+f09oIvT/yP+
	 ZoTEq4sFWlujA==
Subject: Re: [PATCH v2 net-next 07/14] selftests: xsk: split xskxceiver main()
 into setup, run and cleanup
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Mon, 12 Oct 2026 08:50:23 +0000
Message-ID: <179179502350.434549.10707133560104619595@kernel.org>
In-Reply-To: <20261008114909.734364-8-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-8-maciej.fijalkowski@intel.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] Concern: this patch moves get_hw_ring_size() into
  detect_ifobj_caps(), which init_iface() runs for both interfaces.
- [Low] In main() (tools/testing/selftests/net/lib/xsk/xskxceiver.c:439),
  the new ksft_print_header() call comes after setup code that can…

--

selftests: xsk: split xskxceiver main() into setup, run and cleanup

This commit splits xskxceiver main() into separate steps for interface
binding, capability detection, test execution and a single cleanup path.
HW ring detection moves into detect_ifobj_caps(), and run_pkt_test() now
returns its result. ksft_print_header() is now called before
ksft_set_plan() so that stdout is line buffered.

> diff --git a/tools/testing/selftests/net/lib/xsk/test_xsk.c b/tools/testing/selftests/net/lib/xsk/test_xsk.c
> index 22a81723d5dea..70a61fb511c8b 100644
> --- a/tools/testing/selftests/net/lib/xsk/test_xsk.c
> +++ b/tools/testing/selftests/net/lib/xsk/test_xsk.c

[ ... ]

> @@ -2332,6 +2335,13 @@ static int detect_ifobj_caps(struct ifobject *ifobj)
>  		}
>  	}
>  
> +	if (!get_hw_ring_size(ifobj->ifname, &ifobj->ring)) {
> +		ifobj_set_cap(ifobj, XSK_CAP_HW_RING);
> +		ifobj->caps.tx_max_pending = ifobj->ring.tx_max_pending;
> +		ifobj->set_ring.default_tx = ifobj->ring.tx_pending;
> +		ifobj->set_ring.default_rx = ifobj->ring.rx_pending;
> +	}
> +
>  	return 0;
>  }

[Severity: Low]
init_iface() runs detect_ifobj_caps() for both interfaces. Does the RX
ifobject now get XSK_CAP_HW_RING as well?

Before this change, main() only called get_hw_ring_size() for ifobj_tx.
Now cleanup_iface(ifobj_rx) also reaches hw_ring_size_reset() at every
exit:

    static void cleanup_iface(struct ifobject *ifobj)
    {
        if (ifobj_has_cap(ifobj, XSK_CAP_HW_RING))
            hw_ring_size_reset(ifobj);
        ...

That sends ETHTOOL_SRINGPARAM to the RX netdev even though the tests never
changed its rings. A driver that does not short-circuit an unchanged
request could reset its queues here.

The commit message doesn't say that ring handling now covers RX. Was this
intended?

The later patch "selftests: xsk: add a hardware mode to xskxceiver" makes
hw_ring_size_reset() return early when the rings are already at their
defaults. That would make this a no-op for RX by the end of the series.

> diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> index 8b3e4d18e982b..afd6b242aa0df 100644
> --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c

[ ... ]

> @@ -373,93 +408,64 @@ int main(int argc, char **argv)
>  
>  	parse_command_line(ifobj_tx, ifobj_rx, argc, argv);
>  

[ ... ]

> +	/* Line-buffer stdout so verdicts reach a capturing launcher live. */
> +	ksft_print_header();
> +	ksft_set_plan(modes * nb_tests);

[Severity: Low]
Should ksft_print_header() be called earlier in main()?

kselftest.h says ksft_print_header() should be the first call. It does
this:

    setvbuf(stdout, NULL, _IOLBF, 0);

    if (!(getenv("KSFT_TAP_LEVEL")))
        printf("TAP version 13\n");

By the time it runs here, main() may already have written to stdout. One
example is when read_procfs_val() fails:

    cache_line_size = read_procfs_val(SMP_CACHE_BYTES_PATH);
    if (!cache_line_size) {
        ksft_print_msg("Can't get SMP_CACHE_BYTES from system, using default (64)\n");
        cache_line_size = 64;
    }

The MAX_SKB_FRAGS fallback is the same. Anything printed from
parse_command_line(), bind_iface() or detect_mode_caps() also comes
before the header.

In those cases the '#' lines appear before the "TAP version 13" line.
setvbuf() is also called after the stream has been used, and ISO C only
defines setvbuf() before any other operation on the stream.

The placement stays the same through the rest of the series. There,
ksft_print_header() runs after setup_peer(), which blocks until the TCP
peer connects, so any earlier output stays buffered until then.

Would it help to move ksft_print_header() to the start of main(),
possibly after the -l handling?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008114909.734364-1-maciej.fijalkowski%40intel.com
