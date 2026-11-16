Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865803;
	b=ginaVK4Z59tvW7RP7+AlcFadLZ9OnMwfCSkw71LfJdfKrkP/nj3VbKXqfxEZGpZyH2rK
	 yWC/R9FOJGSRp56kOD3hJGuRR+X6uk6h1q+7NBahFSGjTTwHKMBEr9wVWxAlrRnFGqjmH
	 z0jkQYZ65WauJIObhy9DNcRpifo1FnelO1i7Dj2cOa8+1puYfC7J5eqep+SfN2SP1sDsD
	 Vx82ZGWZ2qBTyAAddlrGeL1Q1yHmMjYIzg5tbamsi/bQZmOYGwgZ0eLqt2uis500ykYot
	 rubXA4Qjj2He3rfkkrYsrFE7DMhfZsQNagSdrstZvWbc4bXwAqm7EX+7FYBMF5ht/tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865803;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+jsFqFzKZSD9MdsyE3tmoUMLAK/UTPTcstylH2JUgu4=;
	b=xlCVtH9p2PHmtG/Z92wZSENW+93MWdobb3BRblIUvbRCQeyK7CIs11O7SbwJCKWjRcwo
	 cGit9/hXHPdxYpogQkLp7QQ/FzFdIT66u57m5eOpBLJzXiVEoZPThPTy65xK0os1LgOw4
	 hN/hY9AoJ9ClrFIBv5OBsnZBSlapjSo53m2mLZBB7Hbi+Y5yTn8MMCJKeM5H9bocdJIKF
	 mldrEj2tZ36gCb7eEVCl0cclmOMfFnUOnEmw2G1gD/y7HotwlCpDtTDw9wyqXwZ2KmLAl
	 cUUIhVeqvvbCir+9mQn4vcMLcBKUGN+wsgKKOnu5lEg9ZwP37d/FqGMgZAnSU2x9R5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k37Bv7TF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A04606A31C;
	Mon, 16 Nov 2026 21:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k37Bv7TF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1A821F000C4;
	Mon, 16 Nov 2026 21:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794865803;
	bh=+jsFqFzKZSD9MdsyE3tmoUMLAK/UTPTcstylH2JUgu4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=k37Bv7TFoT4Ul1KmSwB7KupyTlwJNzDlOaHHOeihdzkaaSpkbBcZ3J9+etgSXHsCW
	 LQPigaHIBGR7hoYVXT2xaoqFHPdWDdujpYFYva0wTUU3lr4AGFhLB3IMZhZwtzrKop
	 gcQRKcVKGVWTqi/LPmeXnMSGUGg4UHhuhjOEtT1QTXOhXupyWUDGWf/YfAtSk3sMNV
	 A2XH1dMEIqloIxM/jZ6tUTM9+Mt6Ts8tiOvU9LF1MvRDzcA0HGe21JXIxRuI6FMHi+
	 i+t1Gp6HE5HHQKZa8U26AHQwcpsMuUQZolpeeWyClydnidWS5tHg0W9efrQ32wgE4x
	 I8A8gHaXPZ2NA==
Subject: Re: [PATCH net v2] selftests: net: veth: propagate channel-check
 failures to exit status
From: netdev-bot+sashiko@kernel.org
To: emmaonana18@gmail.com
Cc: kuba@kernel.org, tianyi@cloudflare.com, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, skhan@linuxfoundation.org
Date: Mon, 16 Nov 2026 21:50:01 +0000
Message-ID: <179486580141.3136.15559598598860423821@kernel.org>
In-Reply-To: <20261115214702.50817-1-emmaonana18@gmail.com>
References: <20261115214702.50817-1-emmaonana18@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete.
- [Medium] Because chk_channels() now sets ret=1, the "setting invalid
  channels nr" check at tools/testing/selftests/net/veth.sh:467-468…

--

selftests: net: veth: propagate channel-check failures to exit status

This patch changes chk_channels() in tools/testing/selftests/net/veth.sh
so that it sets ret=1 when the channel counts reported by ethtool do not
match the expected values. A channel mismatch now gives the script a
non-zero exit status.

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

[Severity: High]
Is this fix complete?

The commit in the Fixes: tag, 1ec2230fc721 ("selftests: net: veth: add
tests for set_channel"), also added three inline channel/XDP checks to
veth.sh. Each of them prints a fail line but never sets ret:

	printf "%-60s" "bad setting: XDP with RX nr less than TX"
	ip -n $NS_DST link set dev veth$DST xdp object ${BPF_FILE} \
		section xdp 2>/dev/null &&\
		echo "fail - set operation successful ?!?" || echo " ok "

	printf "%-60s" "bad setting: reducing RX nr below peer TX with XDP set"
	ip netns exec $NS_DST ethtool -L veth$DST rx 1 2>/dev/null &&\
		echo "fail - set operation successful ?!?" || echo " ok "

	printf "%-60s" "bad setting: increasing peer TX nr above RX with XDP set"
	ip netns exec $NS_SRC ethtool -L veth$SRC tx 3 2>/dev/null &&\
		echo "fail - set operation successful ?!?" || echo " ok "

These checks test the queue count limits in drivers/net/veth.c:

veth_xdp_set():
	if (dev->real_num_rx_queues < peer->real_num_tx_queues) {
		...
		err = -ENOSPC;

veth_set_channels():
	if (priv->_xdp_prog && peer && ch->rx_count < peer->real_num_tx_queues)
		return -EINVAL;

	if (peer && peer_priv && peer_priv->_xdp_prog && ch->tx_count > peer->real_num_rx_queues)
		return -EINVAL;

Suppose a kernel change lets one of these invalid configurations
through. The script prints "fail - set operation successful ?!?", but it
still reaches exit $ret with ret=0.

The subject says channel-check failures now reach the exit status.
Should these three sites set ret=1 too?

[Severity: Medium]
Now that this sets ret=1, can the "setting invalid channels nr" check
fail the whole script on hosts where nproc is lower than
num_possible_cpus()?

The test gets its CPU count from nproc and treats CPUS + 1 as an invalid
tx count:

readonly CPUS=`nproc`
[ ... ]
ip netns exec $NS_DST ethtool -L veth$DST tx $((CPUS + 1)) 2>/dev/null
chk_channels "setting invalid channels nr" $DST $CUR_RX $CUR_TX

The kernel limit comes from num_possible_cpus() instead:

drivers/net/veth.c:veth_get_num_queues() {
	int queues = num_possible_cpus();
	...
}

drivers/net/veth.c:veth_get_channels() {
	...
	channels->max_tx = dev->num_tx_queues;
	channels->max_rx = dev->num_rx_queues;
}

ethnl_set_channels() in net/ethtool/channels.c rejects only
tx_count > max_tx, and the ioctl path does the same.
veth_set_channels() has no upper bound check of its own.

On some hosts nproc is lower than num_possible_cpus(). Examples are QEMU
with -smp N,maxcpus=M, firmware that lists hotpluggable CPU slots, or a
process limited by taskset or cpuset. There the ethtool -L call
succeeds, ethtool -l reports tx = CPUS + 1, and chk_channels() takes the
else branch.

Before this patch, that only printed a fail line. With ret=1, the
selftest now fails even though the kernel behaved correctly.

The commit message says:

    all chk_channels() call sites expect the check to pass

That doesn't hold for this call site on such hosts. Should the test pick
its out-of-range tx value from the kernel's reported maximum instead of
from nproc?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261115214702.50817-1-emmaonana18%40gmail.com
