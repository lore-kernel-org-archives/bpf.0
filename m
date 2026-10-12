Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39063BCD05;
	Mon, 12 Oct 2026 08:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791795027; cv=none; b=csdnGENWRK4mCrHWlq5x7zprg03m/zXbZ1Nh05Lhjrl4lNzKX9siQdBIRDlSUb6h4KAbHDVg5L1Eq/Yt9CXRvlmWdUUBOej8Brj5CHH7I6uTSwOuW2fVMCzlAgXnpuojYPXtPqx2ZmWHEsTaCHIvT1VpRwUKkGrDAhUoXKW3X/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791795027; c=relaxed/simple;
	bh=nQEYO9o/Cla92gQrDGp/1U2SAz5xYrIcpTJWMX+YVGI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tCNzdwnuZMQ4KqhbSs56rSiCbPOCF+r4Gp6L16gud+ZqPE1qn9NWtSg/GqABoJojzcpYzbgUFYanjR/dASxqzHAezvD66NIrC4Gp1ou+hUzgBSNPwu1tLvfxRugjruhFZ2OwKDWYlw3xFa3JEBLZJWXZsd6w5xl0SdR0rbq5+/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bOOq+uL6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bOOq+uL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261941F0089B;
	Mon, 12 Oct 2026 08:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791795025;
	bh=+F63QYMduTSBfVTbTIvyKdI37Zd1fHY4adSrj5jwhQs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bOOq+uL6YNgvgdstp4hXvRrWURAUusOenc3aHDlj59n/pBa0dW0RdbRp+2u94y/aO
	 KKb6jdrx7T/T2xtqPXCrW2t+bk6PxywcoFZvHW7b/afF9Uyk2LOqDuj7JTai3+WjHq
	 7qiYfpw4oxHayK2NBVJ41A0BYWKX5QMmcobPZYty2LYeGFDo44A78nhhaYF0fRg9fy
	 rc85mcRqzryhR1oOZ1U7yrOHciyP4G0jC3yK3z8g0PuWb0ceU4ZZ3cZs8dUNH4Cd8R
	 r1SvtiaMUpoi1q066/gxJUwwPTE3adDfZzGK1Yd9gfLSbIDZ+v9kO4nZotX1jDaGyH
	 UPsGRI5qYwgNQ==
Subject: Re: [PATCH v2 net-next 08/14] selftests: xsk: run one test case per
 xskxceiver invocation
From: netdev-bot+sashiko@kernel.org
To: maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com,
 stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com,
 tushar.vyavahare@intel.com, kerneljasonxing@gmail.com, bjorn@kernel.org
Date: Mon, 12 Oct 2026 08:50:24 +0000
Message-ID: <179179502473.434549.7438284569003594662@kernel.org>
In-Reply-To: <20261008114909.734364-9-maciej.fijalkowski@intel.com>
References: <20261008114909.734364-9-maciej.fijalkowski@intel.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, the jumbo MTU set by a multi-buffer case
  carries over to the next case's xskxceiver process.
- [Medium] Each case now runs in its own process, and XDP state a crashed
  case leaves behind affects the cases after it.
- [Low] `./test_xsk.sh -h` runs `./${XSKOBJ}` with no arguments, so what
  the user sees is xskxceiver's print_usage().
- [Low] The new summary in test_xsk.sh counts skipped cases, but it only
  changes the exit status when there are failures.

--

selftests: xsk: run one test case per xskxceiver invocation

This commit moves the mode x case matrix from xskxceiver into test_xsk.sh.
xskxceiver now requires -m and -t and runs a single case per process. An
unsupported mode now becomes a skip instead of XFAIL, and test_xsk.sh
prints a summary of passed, skipped and failed cases.

> diff --git a/tools/testing/selftests/net/lib/xsk/xskxceiver.c b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> index afd6b242aa0df..b8a52846eaf86 100644
> --- a/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> +++ b/tools/testing/selftests/net/lib/xsk/xskxceiver.c
> @@ -169,7 +169,7 @@ static struct option long_options[] = {
>  static void print_usage(char **argv)
>  {
>  	const char *str =
> -		"  Usage: xskxceiver [OPTIONS]\n"
> +		"  Usage: xskxceiver -i TX_IFACE -i RX_IFACE -m MODE -t TEST [OPTIONS]\n"
>  		"  Options:\n"
>  		"  -i, --interface      Use interface\n"
>  		"  -v, --verbose        Verbose output\n"

[Severity: Low]
Should the option descriptions in print_usage() change along with the
usage line? The rest of the text still says:

    "  -m, --mode           Run only mode skb, drv, or zc\n"
    ...
    "  -t, --test           Run a specific test. Enter number from -l option.\n"

That presents -m and -t as optional filters. However, parse_command_line()
now refuses to run unless both are given:

    if (opt_run_test == RUN_ALL_TESTS || opt_mode == TEST_MODE_ALL)
        print_usage(argv);

Users also see this text from ./test_xsk.sh -h, because the help branch
there runs ./${XSKOBJ} with no arguments. After this patch, test_xsk.sh
rejects -m zc with "Unsupported veth mode: zc (expected skb or drv)". It
also accepts test names for -t, and it does not take the -i TX_IFACE -i
RX_IFACE arguments that the new usage line shows.

The mismatch is still there at the end of the series, where the usage
line becomes "-i IFACE -e rx|tx -m MODE -t TEST -p HOST -P PORT".

[ ... ]

> @@ -420,42 +422,20 @@ int main(int argc, char **argv)
>  
>  	caps = detect_mode_caps(ifobj_tx);
>  
> -	if (opt_mode != TEST_MODE_ALL && !mode_supported(opt_mode, caps)) {
> +	if (!mode_supported(opt_mode, caps)) {
>  		if (opt_mode == TEST_MODE_DRV)
> -			ksft_print_msg("Error: XDP_DRV mode not supported.\n");
> +			ksft_print_msg("XDP_DRV mode not supported.\n");
>  		else
> -			ksft_print_msg("Error: zero-copy mode not supported.\n");
> -		ksft_exit_xfail();
> +			ksft_print_msg("zero-copy mode not supported.\n");
> +		ret = TEST_SKIP;
> +		goto out;
>  	}

[Severity: Medium]
Can a multi-buffer case leave the veth pair at the jumbo MTU and cause
every later drv case to skip here?

For multi-buffer cases, __testapp_validate_traffic() calls
test_spec_set_mtu(test, test->mtu), which sets the jumbo MTU on both
veths. At this commit nothing restores it before the process exits.
cleanup_iface() only resets HW rings, detaches XDP and unloads the
skeleton.

The next case runs in a new process. It calls
detect_mode_caps()->is_xdp_supported(), which attaches a native program
without frags support, and veth_xdp_set() refuses it:

drivers/net/veth.c:veth_xdp_set() {
    ...
		if (peer->mtu > max_mtu) {
			NL_SET_ERR_MSG_MOD(extack, "Peer MTU is too large to set XDP");
			err = -ERANGE;
			goto err;
		}
    ...
}

As a result, mode_supported(TEST_MODE_DRV, caps) returns false and the case
is reported as a skip. The MTU is still not put back, so the remaining drv
cases in that pass would skip as well, and test_xsk.sh still exits 0.

The later patch "selftests: xsk: add a hardware mode to xskxceiver" in this
series seems to fix this. It tracks dev_mtu/orig_mtu and restores the MTU
in cleanup_iface(), so only the intermediate commits are affected. Could
the MTU restore be moved into this patch so the series stays bisectable?

[ ... ]

> diff --git a/tools/testing/selftests/net/test_xsk.sh b/tools/testing/selftests/net/test_xsk.sh
> index 69fac65f073c5..e476556eb05bb 100755
> --- a/tools/testing/selftests/net/test_xsk.sh
> +++ b/tools/testing/selftests/net/test_xsk.sh

[ ... ]

> @@ -168,29 +198,38 @@ if [[ $verbose -eq 1 ]]; then

[ ... ]

>  ## START TESTS
>  
>  statusList=()
> +nameList=()
> +
> +run_matrix()
> +{
> +	local mode case_id
> +
> +	for mode in "${MODES[@]}"; do
> +		for case_id in "${CASES[@]}"; do
> +			ARGS="${BASE_ARGS} -m ${mode} -t ${case_id}"
> +			TEST_NAME="XSK_${mode}_${case_id}_${RUN_VARIANT}_${VETH0}"
> +			exec_xskxceiver
> +		done
> +	done
> +}

[Severity: Medium]
The commit message says:

  "so that every case starts from a fresh process and a case that crashes
  fails only itself"

Is that true when a crashed skb case is followed by drv cases on the same
veth pair?

In an skb case, xsk_reattach_xdp()->xsk_attach_xdp_program() attaches the
program with bpf_xdp_attach(..., XDP_FLAGS_SKB_MODE, NULL). That is a
netdev attachment, not a bpf_link, so it outlives the process. If the case
dies abnormally, for example from a signal or an assert() in test_xsk.c,
main() never reaches cleanup_iface() and the generic program stays on
VETH0.

The next drv case then fails its probe in
main()->detect_mode_caps()->is_xdp_supported(). dev_xdp_attach() refuses
native mode while a generic program is attached:

net/core/dev.c:dev_xdp_attach() {
    ...
		if (!offload && dev_xdp_prog(dev, other_mode)) {
			NL_SET_ERR_MSG(extack, "Native and generic XDP can't be active at the same time");
			return -EEXIST;
		}
    ...
}

DRV is then reported as unsupported and the case becomes TEST_SKIP.
cleanup_iface() does not detach anything, because ifobj->xdp_prog is NULL
in the new process:

    if (ifobj->xdp_prog)
        xsk_detach_xdp_program(...);

run_matrix() runs all skb cases before all drv cases, and the veths are
only recreated between the SOFTIRQ and BUSY_POLL passes. Wouldn't a crash
in the last skb case turn the whole drv pass into skips? With a single -t
selection, the next case is always the one affected.

Later skb cases do recover, because xsk_reattach_xdp() detaches in skb
mode first. The problem is still there at the end of the series: the TX
endpoint's probe fails on VETH0 and it skips while its RX peer goes ahead.

Should leftover XDP programs be detached from the veths before each case?

[ ... ]

> @@ -198,28 +237,47 @@ if [[ $list -eq 1 ]]; then

[ ... ]

> +	case ${statusList[$i]} in
> +		$ksft_pass)
> +			passes=$((passes + 1))
> +			;;
> +		$ksft_skip)
> +			skips=$((skips + 1))
> +			;;
> +		*)
> +			failures=$((failures + 1))
> +			failed_tests+=("${nameList[$i]}")
> +			;;
> +	esac
>  done
>  
> -if [ $failures -eq 0 ]; then
> -        echo "All tests successful!"
> -else
> +echo
> +echo "Summary:"
> +printf "  Tests:   %d\n" "${#statusList[@]}"
> +printf "  Passed:  %d\n" "$passes"
> +printf "  Skipped: %d\n" "$skips"
> +printf "  Failed:  %d\n" "$failures"
> +
> +if [ $failures -ne 0 ]; then
> +	echo "Failed tests:"
> +	for TEST_NAME in "${failed_tests[@]}"; do
> +		echo "  $TEST_NAME"
> +	done
>  	exit 1
>  fi

[Severity: Low]
What exit status should the script return when every selected case skips?
Skips are counted, but only failures change the exit code. A run where
nothing passed therefore exits 0, and the kselftest runner reports PASS
instead of SKIP.

For example, ./test_xsk.sh -m skb -t XDP_ADJUST_TAIL_GROW skips in both
passes, because testapp_adjust_tail_grow() returns early:

    if (test->mode == TEST_MODE_SKB)
        return TEST_SKIP;

The summary shows zero passed and two skipped, but the script exits 0.

This patch also changes an unsupported mode in main() from
ksft_exit_xfail() to a per-case skip. So a -m drv run whose DRV probe fails
used to fail, and now reports success.

Could the script exit with $ksft_skip when passes is 0 and skips is
non-zero?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008114909.734364-1-maciej.fijalkowski%40intel.com
