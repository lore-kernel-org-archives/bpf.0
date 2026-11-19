Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080084;
	b=Saa7jGojGVEmUlN/7vwc2BWoKgkHqjeRITUoFeEEPy5SvVyYSDt0kVn3D1BfwOlnr+dW
	 wEjQZt1jt+wuIx15IqaAW+nNPu6CphqavFedbWsPmzQpRViDknNkKMn9p4owsfDx4Rpac
	 Dz/qP0X1BrKoLr9aLDXa3JILR3A43PQkfYQGDc1Q3UeD4WyVq/70Htlc8dFbl9JXelgD0
	 PpQgCKxsdW53KcjmsD4uoA2LIOdFhYiZECbeEVrdK2shKDwT1wGF7yuGK5MrZL28nMhpm
	 J8mfGttxtSq95n5rA+687s6RREq5BOfYzYmhJrELhsvI0MRxFtnDCObWEfMMR93YXyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080084;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=jwlrWkiL6/bc8bt3jFA1PNWrJYj2IlYZaoWgGCfb8oM=;
	b=da+s3wKUI6SCTXRtfb1bZx/RACFxhdLD4tKxR3GcHw7DQg/MFrhoQe1Q+Xr3nV9HASQT
	 faOXsjyugnV3dcFswvKboxtyBkCRWmlsh5ImW6SevEmUVTEZ6H+XzQxEfhN2iPMKIJ5zg
	 nOaSip9eKTQHm850zr/mRYmrVAyr3OrNWFcAK+xkfR4jcoLDr+p5G7IF1dV5+tVcfklnF
	 rAZLjZvsxsYpuk6eFU4Z66AkUMBY+PSCCLRX33lAOU96VqCvHPAZ0kms8e4VNAfRfVtnM
	 SZs13RgMQ1wLoY+EU6UQxgmpA8tiB2SgkSoGK6L0+F2Gifr0LGgWNWsTZo6hjgNkIAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aWlX8672;
	arc=none smtp.remote-ip=95.215.58.138
Received: from mta1.migadu.com (out-138.mta1.migadu.com [95.215.58.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA1606A326
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 09:21:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5ABA1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aWlX8672
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=mPiSiO8g+w2DpPp3GGR8IZ3wJAak28Y/ctpnaig1pAM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795080081; v=1; x=1795684881;
 b=aWlX8672Mj+HReGYIkiRRIhO2O6zkeJuL6VhFnecacKIcpMy2KcYJl0JkXPRJ0jF0WUoCHWX
 UZp2CZnznB6IlqTgWp6la/ZxlGdmw4GmoBiVritBCyH+02wWoB+Yb4mtGqT+mjjfUm/Hc4tgNEi
 T6rNUYUNQGTJDUl+RDKOLWU8=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 291b443669a991fd;
	Thu, 19 Nov 2026 09:21:20 +0000
X-Mizu-Trace-ID: 291b443669a991fd
X-Migadu-Flow: FLOW_OUT
Date: Thu, 19 Nov 2026 17:20:58 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>, Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
	David Lebrun <david.lebrun@uclouvain.be>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Mathieu Xhonneux <m.xhonneux@gmail.com>,
	David Lebrun <dlebrun@google.com>,
	Justin Iurman <justin.iurman@gmail.com>,
	Stefano Salsano <stefano.salsano@uniroma2.it>,
	Andrea Mayer <andrea@common-net.org>
Subject: Re: [PATCH net v2 6/6] selftests: seg6: add test for skb checksum
 with CHECKSUM_COMPLETE
Message-ID: <av6_eqt8yH5qmLYL@fedora>
References: <20261118150251.65-1-andrea.mayer@uniroma2.it>
 <20261118150251.65-7-andrea.mayer@uniroma2.it>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261118150251.65-7-andrea.mayer@uniroma2.it>

Hi Andrea,
On Wed, Nov 18, 2026 at 04:02:51PM +0100, Andrea Mayer wrote:
> Add a selftest for received packets with CHECKSUM_COMPLETE that the SRv6
> code processes before they are delivered on the same node. The test checks
> that, after the node changes the packet, UDP does not read a wrong
> skb->csum.
> 
> The test uses a host and a router connected through a veth pair. Since veth
> does not provide CHECKSUM_COMPLETE, a tc ct action on the router computes
> skb->csum in software.
> 
> The host sends a UDP datagram to the router along five paths: no SRH (the
> reference), an SRH with local segments, End.B6.Encaps with End.DT6, End
> with the next-csid flavor, and End.BPF. Each datagram is expected to be
> delivered, not dropped as a checksum error. Without the previous patches,
> every path except the reference fails. With them, every path passes.
> 
> The host also sends a control datagram. It checks that the test detects a
> wrong skb->csum after a change to the packet. After the ct action, a BPF
> program on the router changes the Flow Label of the control datagram
> without updating skb->csum, and UDP must drop it. If UDP accepts it, the
> paths above may report a false pass, and the test fails.
> 
> Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> ---

Here are some code style comments. You can decide whether to change them or not.

> 
> +print_log_test_results()
> +{
> +	printf "\nTests passed: %3d\n" "${nsuccess}"
> +	printf "Tests failed: %3d\n"   "${nfail}"
> +
> +	# when a test fails, the value of 'ret' is set to 1 (error code).
> +	# Conversely, when all tests are passed successfully, the 'ret' value
> +	# is set to 0 (success code).
> +	if [ "${ret}" -ne 1 ]; then
> +		ret=0
> +	fi

Do we need to reset the "ret"? It's $ksft_skip by default. If any test failed,
it is set to $ksft_fail. We can just exit with $ret at cleanup().

> +
> +cleanup()
> +{
> +	cleanup_all_ns
> +
> +	# check whether the setup phase was completed successfully or not. In
> +	# case of an error during the setup phase of the testing environment,
> +	# the selftest is considered as "skipped".
> +	if [ "${SETUP_ERR}" -ne 0 ]; then
> +		echo "SKIP: Setting up the testing environment failed"
> +		exit "${ksft_skip}"

if [ "${SETUP_ERR}" -ne 0 ], the ret should be ${ksft_skip}, right? Cause
we haven't run any test.

Then we can goto the following exit directly.

> +	fi
> +
> +	exit "${ret}"
> +}
> +

[...]

> +test_end_bpf_or_ksft_skip()
> +{
> +	local test_netns
> +
> +	setup_ns test_netns
> +
> +	ip -netns "${test_netns}" link add "${DUMMY_DEVNAME}" type dummy
> +	ip -netns "${test_netns}" link set "${DUMMY_DEVNAME}" up
> +
> +	if ! ip -netns "${test_netns}" -6 route \
> +			add "${SID_LOCATOR}::${BPF_FUNC}/128" encap seg6local \
> +			action End.BPF endpoint obj "${BPF_FILE}" \
> +			sec "${BPF_END_SEC}" dev "${DUMMY_DEVNAME}" \
> +			2>/dev/null; then
> +		cleanup_ns "${test_netns}"
> +		echo "SKIP: SRv6 End.BPF not supported"
> +		exit "${ksft_skip}"
> +	fi
> +
> +	cleanup_ns "${test_netns}"
> +}

Maybe move the `trap cleanup EXIT` here.

Then we can just `exit` instead of `exit "${ksft_skip}"` for all the
test_* functions. The cleanup_all_ns() will just do nothing when the
NS_LIST is NULL.

If a command missing, or test_* function failed. The report shows

SKIP: xxx not supported
SKIP: Setting up the testing environment failed
# echo $?
4

> +
> +if [ "$(id -u)" -ne 0 ]; then
> +	echo "SKIP: Need root privileges"
> +	exit "${ksft_skip}"
> +fi
> +
> +# required programs to carry out this selftest
> +require_command ip
> +require_command tc
> +require_command ethtool
> +require_command ping
> +require_command sysctl
> +require_command awk
> +require_command grep
> +
> +test_dummy_dev_or_ksft_skip
> +test_iproute2_supp_or_ksft_skip
> +test_kernel_supp_or_ksft_skip
> +test_veth_tx_csum_off_or_ksft_skip
> +test_bpf_file_or_ksft_skip
> +test_tc_or_ksft_skip
> +test_end_bpf_or_ksft_skip
> +
> +set -e
> +trap cleanup EXIT

> +
> +setup
> +set +e
> +
> +connectivity_tests
> +udp_delivery_tests
> +
> +print_log_test_results
> -- 

Apart from the comments, the test looks good to me.

Tested-by: Hangbin Liu <liuhangbin@kylinos.cn>
Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>
