Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7263C0A0A;
	Sat, 17 Oct 2026 03:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792206369; cv=none; b=P9Os7vQJZxKMo1l5ngNXjOE5fKiC+vOS1qnKnJohKqrAwZjzfu8mjIFL7887xnI6+ywEo4lFhjp3Uz998zriU+hWva2UuidjCphAWP9NBRbvtGGkwu1yFyVKId2BbWWeKuXw2HzXfGVIPJx3HzJqVC8GXNUV7qIIqQ5QQP4H7H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792206369; c=relaxed/simple;
	bh=Z2xidD7KcMmJldNcrcp4dYQA7QsZ8EivmwMPYXOh5ME=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MEOtZ9Y2pk9vd8MyiVJB97Ablfpt8Cp5QBzvylt8afbJbQtdRrWLvDzkwbXOkch0M2m2rKS4/7Zhgq+K3Ia9V8cdCkeWeBfp9GdS8p7qvANkgA7zi9SrP8nzIgrxD61GUmyZ/rg5AMjOezADD2v40gbyIgPpO3fGFcpJ1OZya+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FS42kjGE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FS42kjGE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B43CD1F000C5;
	Sat, 17 Oct 2026 03:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792206368;
	bh=fXAsF3XG2kcSSh2uiljLnl4J0iOlcqzypEF/5zBapm4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=FS42kjGEyFQzyOvU4N4DXUkgityFIKM5gy9uf7Vh+MCIaeOgLrm0BN9ZxbtSKE9ch
	 bPMrqpJdyEvFIel4ckmt0NMSSjL0La21stSQ2pm6uVMCPZYs5xdayrD935wZBca1Q+
	 rVGcLrz/m+Iabdt+WIWNMhZ3Ud+UGk1xi2U/Qn3ClQMd3v9oBRz1Iu92MqbikQS9hD
	 Lb39GEfJpywZ2kUGZ6PQSBwJ3CEwfe/R061PMxnB4TPbkQ+zQZgZg1Z1VVtWt9J/4h
	 tLWB/RUaQI/mfNoKc0CskCE7qGf9RL3oQ3ObLJIZu4JPAhK4QeDH3E/10HWxRpBaYP
	 aAbjQn7qY5umA==
Subject: Re: [PATCH v3 net-next 08/15] selftests: xsk: split xskxceiver main()
 into setup, run and cleanup
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Sat, 17 Oct 2026 03:06:07 +0000
Message-ID: <179220636731.434549.8598674043519949556@kernel.org>
In-Reply-To: <20261014184539.774708-9-maciej.fijalkowski@intel.com>
References: <20261014184539.774708-9-maciej.fijalkowski@intel.com>
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

- [Low] Besides restructuring main(), the patch fixes an existing false-
  pass bug in xskxceiver's exit status, but it carries no Fixes: tag and…

Pre-existing issues:
- [Low] cleanup_iface() detaches an XDP program only when
  `ifobj->xdp_prog` is set, and it picks the detach flags from…

--

selftests: xsk: split xskxceiver main() into setup, run and cleanup

This commit splits xskxceiver main() into three parts. Setup is done by
bind_iface() and detect_mode_caps(), the test loop counts the return
value of run_pkt_test(), and cleanup_iface() gives a single exit path.
It also makes hw_ring_size_reset() skip no-op resets and calls
ksft_print_header() right after the command line is parsed.

> diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> index 8b3e4d18e982b..02e54b026806b 100644
> --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c

[ ... ]

> @@ -317,26 +332,46 @@ static bool is_xdp_supported(int ifindex)

[ ... ]

> +static void cleanup_iface(struct ifobject *ifobj)
> +{
> +	if (ifobj_has_cap(ifobj, XSK_CAP_HW_RING))
> +		hw_ring_size_reset(ifobj);
> +	if (ifobj->xdp_prog)
> +		xsk_detach_xdp_program(ifobj->ifindex,
> +				       ifobj->mode == TEST_MODE_SKB ?
> +				       XDP_FLAGS_SKB_MODE : XDP_FLAGS_DRV_MODE);
> +	xsk_unload_xdp_programs(ifobj);
>  }

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. Can a
native XDP program still be left attached after xskxceiver exits?

cleanup_iface() depends on ifobj->xdp_prog and ifobj->mode. In test_xsk.c,
xsk_reattach_xdp() only updates them at the very end:

tools/testing/selftests/net/lib/xsk/test_xsk.c:xsk_reattach_xdp() {
    ...
	err = xsk_attach_xdp_program(xdp_prog, ifobj->ifindex, mode_to_xdp_flags(mode));
	...
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

xsk_is_in_mode() returns false whenever bpf_xdp_query() fails, even if
the native attach just succeeded. If this happens on the last attach of
a run, the new program is attached but never recorded.

cleanup_iface() then either skips the detach because xdp_prog is still
NULL, or detaches with the stale SKB mode flags.

Before this patch, main() did not detach anything at exit, so this patch
makes the window smaller rather than opening it. The code is unchanged at
the end of the series. The runners clean up there: xsk.py detaches the
programs after a failed endpoint, and test_xsk.py uses a fresh veth pair
per case.

Could xsk_reattach_xdp() detach the program, or record it, before it
returns -EINVAL?

> @@ -371,95 +410,62 @@ int main(int argc, char **argv)

[ ... ]

>  			test_init(&test, ifobj_tx, ifobj_rx, i, &tests[j]);
> -			run_pkt_test(&test);
> -			usleep(USLEEP_MAX);
> -
> -			if (test.fail)
> +			if (run_pkt_test(&test) == TEST_FAILURE)
>  				failed_tests++;
> +			usleep(USLEEP_MAX);
>  		}
>  	}
> +	ret = failed_tests ? TEST_FAILURE : TEST_PASS;

[Severity: Low]
This change also fixes an existing false pass in the exit status. Should
it go in a separate patch with a Fixes: tag?

Before this patch, failed_tests only went up when test.fail was set.
Several paths return TEST_FAILURE without setting it. One example is in
__testapp_validate_traffic():

	err = test_spec_set_mtu(test, test->mtu);
	if (err) {
		ksft_print_msg("Error, could not set mtu.\n");
		return TEST_FAILURE;
	}

The same is true for these failures:

- xsk_attach_xdp_progs()
- pthread_barrier_init() and pthread_barrier_destroy() in
  __testapp_validate_traffic()
- set_ring_size() in testapp_validate_traffic()

run_pkt_test() printed a "not ok" line for these, but main() still
called ksft_exit_pass() and exited with 0. In xsk_prereqs.sh,
exec_xskxceiver() looks only at the exit status:

	./${XSKOBJ} -i ${VETH0} -i ${VETH1} ${ARGS}
	retval=$?

As a result, these failures were reported as passes.

The commit message does say "which main() counts instead of test->fail,
as not every failing path sets it". Without a Fixes: tag or a small
standalone patch, though, the fix can't be backported without the whole
refactor.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261014184539.774708-1-maciej.fijalkowski%40intel.com
