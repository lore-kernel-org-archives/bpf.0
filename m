Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.252
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793676417;
	b=JbnrMIVr6O7MZlTlTkuKtCq8pkE4cYL5BV2IMbnDBsNVhqeudeyX8OinhKuRN22/Dlrz
	 rKUvdA/+kK3dcAvgTNFISfDHerU0nHCO5aVGhwDSj5kC1M5dbB8bTiZSSMBPfpacecgWy
	 i6jxHF7AqV3jIlk40JkuuRPFtXCau2JtdgZl6IljfGXNEirc+X5SG31Qr1CRW1WRZUdZH
	 OoxMW3x7o6abOE5C721K+BPduIVqdmyFlX7s1LYGPdqWv9j6LjiWk03RAPkAyQk13tLtj
	 P1M8s+vEOb8AFSCGm9bhI20wVAeYIqG0EVaAW9A+eC/FB/4IQJb61Mu+rrxJVpNq9aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793676417;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Pj1JU03F9Laxq6eHx9zjcjJnN4EfO5e/haxBemgdWVs=;
	b=GMPQF3sc3mUmVuJf3k7bbrEZ4lQKRYS/PXD6/JpWFkEaKVxaHZ0pFB3Qh7VcPQqiWyKb
	 /474AGwH5c+XpiST1oeis/CIQXyJ0ByEIKTO4Vcb3rJ20W4QmO5GaFMqXcOAWs2z/+WZB
	 ORo7IZqJgaTfglfJvMMpSzq+VL3OCXGEt+w46c78s+JP+IawljuCmcVkODUpO1QXGgZUe
	 8n3J4V9bQ1dtxEbHEP7vRZJiMLyqZ0IxVfc/5nvb2P+vcyIRJFE6zVtamfhzgMnAQiTFe
	 a6AQ8RcLj82Dl7Qoh1Ld6P/Gq6sCRFm9WgJPC4Vdg0bNmg3wfF0RvIBT9KExmU4yXKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wZ3Vm7l0;
	arc=none smtp.remote-ip=91.218.175.252
Received: from mta0.migadu.com (out-252.mta0.migadu.com [91.218.175.252])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF92606A324
	for <bpf@vger.kernel.org>; Tue,  3 Nov 2026 03:26:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEF92606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=wZ3Vm7l0
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wtEVdOVSVnuKwh+DFugaJpr8wQGqhhMMSkFBirTr1Zg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793676414; v=1; x=1794281214;
 b=wZ3Vm7l0mlxhJDHMtn+MSeTkfra8gPRhQ/C9k1Ov7E5B2EKvdeEFGhRIzJ8empktpQHbZLSy
 sWaXtGmxIrM1ilcMcT5/WgFfmCwPB4DJNFpQ7m1N1/QT+Xt/mFQnCB+BUoBPZLv3cUTN8OaZ2W3
 c2PI4w6nCYlqu5dodVSmpQ2Q=
X-Envelope-To: bpf@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id e74cd1523336b06b;
	Tue, 03 Nov 2026 03:26:54 +0000
X-Mizu-Trace-ID: e74cd1523336b06b
X-Migadu-Flow: FLOW_OUT
Date: Tue, 3 Nov 2026 11:26:35 +0800
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
	Stefano Salsano <stefano.salsano@uniroma2.it>,
	Andrea Mayer <andrea@common-net.org>
Subject: Re: [PATCH net 6/6] selftests: seg6: add test for skb checksum with
 CHECKSUM_COMPLETE
Message-ID: <aulUayPCDOYwAm1e@fedora>
References: <20261031225033.64-1-andrea.mayer@uniroma2.it>
 <20261031225033.64-7-andrea.mayer@uniroma2.it>
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
In-Reply-To: <20261031225033.64-7-andrea.mayer@uniroma2.it>

Hi Andrea,
On Sat, Oct 31, 2026 at 11:50:33PM +0100, Andrea Mayer wrote:
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
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../selftests/net/srv6_csum_complete.bpf.c    |  65 ++
>  .../selftests/net/srv6_csum_complete_test.sh  | 642 ++++++++++++++++++
>  3 files changed, 708 insertions(+)
>  create mode 100644 tools/testing/selftests/net/srv6_csum_complete.bpf.c
>  create mode 100755 tools/testing/selftests/net/srv6_csum_complete_test.sh
> 

[...]

> +
> +log_test()
> +{
> +	log_test_expected "$1" "$2" "$3"
> +}

We'd better use log_test_expected directly, otherwise the log_test in
lib.sh will be overwrite.

> +
> +test_command_or_ksft_skip()
> +{
> +	local cmd="$1"
> +
> +	if [ ! -x "$(command -v "${cmd}")" ]; then
> +		echo "SKIP: Could not run test without \"${cmd}\" tool"
> +		exit "${ksft_skip}"
> +	fi
> +}

Then we can use require_command() in lib.sh here, which will call
log_test() in lib.sh.

[...]

> +
> +if [ "$(id -u)" -ne 0 ]; then
> +	echo "SKIP: Need root privileges"
> +	exit "${ksft_skip}"
> +fi

I wonder if there is any one run the selftest with none root privileges.
Cause almost all the selftests need ip configurations.

Thanks
Hangbin
