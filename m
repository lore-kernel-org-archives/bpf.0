Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048838;
	b=f4Bu3DXBFzrIplxWep66uZwlXwFQ+1np37iSA7zgNTQS62z1FtZX8xtIYSIRKDVYvFAr
	 QpGv79YJ8yoY38YWAdbDG9Lbbwn4NvvE3z7g1vncAL219i9k4nymSNLPQm8bnCQHwQtDX
	 K6fRzw2Bb5MLnwNxgQTVuMRulNBukwOabQGeOMWVsPNZflU+1vzWY6SgWxtBfzbVGIyxo
	 wU1BqY9z2zi8wpq6xHos9nOUuG25A1t3qW1ShLVubcFoGJzf0pX6yBdimvezQ5n4JF68N
	 3TffHOUoCyDiPvzMw6kBsNG6vKkIVDuit1EFZnAqSE8iIL7llwYgVJW84WG6l5xaiww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048838;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=mo1q4jEE8kXYGn1pEvjW3f9A0Zb56qipOWRIn9i/1Ow=;
	b=V0LJmL9lJuGPHNm2CNKTbvg71hy1H2MfkfKxy83wbsLQ2P7IsvMytDCVburEW9/gWuo9
	 QnpmgG+tWBPwqtXX/rV3QEs252TA2U35epR3+ztWXfZc7Ce21dhEoIVXF9N0gtg7qo25W
	 BKfRqcaPpTU8A//II23IlPeYjaZqlNznoVTQwurlhPgSBvk0+iaNjA1bGvre02gcCorRK
	 XF4qTt3sN76XBVULM4wGbz0bMgFxjNidxMfk5h9hQT0a8SvhsRTDhPzUbVkOQb7WmCGee
	 JdDI1K7pcPOlDgWCV25Mcm1Tu14kzXKpv4fOCkDnv5yee0pN5OQLgDjAcyn1Cf1mU6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIDQHr1w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24D606A31C;
	Thu, 19 Nov 2026 00:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QIDQHr1w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A3941F000C4;
	Thu, 19 Nov 2026 00:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795048838;
	bh=mo1q4jEE8kXYGn1pEvjW3f9A0Zb56qipOWRIn9i/1Ow=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QIDQHr1wqbeXEA1vWkJOJWOE/Iu91Y6XqJ63ia3ZPqQl4p36JuOUuo9IIsKDJSgZ8
	 FqOhHkw0bWDAw+IugRVQAdSNotrqICWPnXvWLYrrTq+0fXEaEYB5PlB5h+IdLz17td
	 tDxrsKUMJlMORObMqkAEuBPb1CU6xPx9/uFoeApMKGRIcuukiSYrVqSRpaFBL2Zp3K
	 3eIyrAKu1aYLld9IlyzXSO1ORCfB3rj5Ie0V6L/1LMJFql2MqN49SCjzbUnDEk652j
	 /O23E+FYplNDTOfZ+95OGwnhd534QDMrknZnDLjLr5y6to0mCJXlv8FrJBydWu7HX/
	 H1qdsSAK3lj8A==
Subject: Re: [PATCH net v3 1/2] selftests: net: veth: propagate channel-check
 failures to exit status
From: netdev-bot+sashiko@kernel.org
To: emmaonana18@gmail.com
Cc: tianyi@cloudflare.com, hangbin.liu@linux.dev, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org
Date: Thu, 19 Nov 2026 00:40:36 +0000
Message-ID: <179504883686.3136.13611151498828489972@kernel.org>
In-Reply-To: <20261116084107.6675-2-emmaonana18@gmail.com>
References: <20261116084107.6675-2-emmaonana18@gmail.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch adds `ret=1` to the mismatch branch of
  chk_channels() in tools/testing/selftests/net/veth.sh (line 133).

--

selftests: net: veth: propagate channel-check failures to exit status

This commit makes chk_channels() in veth.sh set ret=1 when the observed
channel counts do not match the expected ones. With it, any channel
mismatch makes the script exit with a non-zero status.

> diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
> index 64c2a5a59821d..5c1dbe1516bb4 100755
> --- a/tools/testing/selftests/net/veth.sh
> +++ b/tools/testing/selftests/net/veth.sh
> @@ -130,6 +130,7 @@ chk_channels() {
>  		echo " ok "
>  	else
>  		echo " fail rx:$rx:$cur_rx tx:$tx:$cur_tx combined:n/a:$cur_combined"
> +		ret=1
>  	fi
>  }
>  

[Severity: Medium]
With this change, can a check whose result depends on the test environment
now fail the whole veth.sh run?

The "setting invalid channels nr" check expects a request for CPUS + 1 TX
queues to be rejected. CPUS comes from nproc:

    readonly CPUS=`nproc`
    ...
    ip netns exec $NS_DST ethtool -L veth$DST tx $((CPUS + 1)) 2>/dev/null
    chk_channels "setting invalid channels nr" $DST $CUR_RX $CUR_TX

The veth queue limit is num_possible_cpus(), capped at 4096. It is not the
number of CPUs the process can use:

drivers/net/veth.c:veth_get_num_queues() {
	/* enforce the same queue limit as rtnl_create_link */
	int queues = num_possible_cpus();
    ...
}

veth_get_channels() reports dev->num_tx_queues as max_tx. The ethtool core
in net/ethtool/channels.c only rejects tx_count > max_tx.

nproc returns the number of CPUs the process can use. That can be smaller
than the number of possible CPUs on machines with hot-pluggable CPU slots,
or when the test runs under taskset or a restricted cpuset.

In those cases the request is valid. No XDP program is attached at that
point, so veth_set_channels() accepts it and real_num_tx_queues becomes
CPUS + 1. chk_channels() then sees cur_tx != $CUR_TX, and with this patch
veth.sh exits 1.

Before this patch, the mismatch only printed a fail line. The later patch
in the series ("selftests: net: veth: propagate bad-settings check
failures to exit status") does not change this check.

Could the out-of-range value come from the device's advertised maximum
instead of nproc? For example, the "Pre-set maximums" TX value from
ethtool -l, plus one.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261116084107.6675-1-emmaonana18%40gmail.com
