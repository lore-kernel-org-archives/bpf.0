Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795684764;
	b=3Bpp2r3MGAVpGkUJ4BgXAy+BPVcQoskYeKO0p+pwAWZbBuny2MqYpdohYUoMNd3OEQB9
	 byqnKyHQqQzqRolXgf3sOp0nLw6OHopPLvhLQYA6hLzPL7Ie3//gj3ZNGqVXIEpd1B/Wb
	 0/YL8Ta0lLQqnwyQsRCvCYUztj+9Yq+hxKgwvinD2aEpTmSvCJ3IoeP9eHxOtPauhXPUY
	 kC32rHNlvVohaYsEmrG+b90NCa3s9XHAWznK8SLjcI5lV0afdr2Ic97bZVb0iB69KvYCu
	 kf4EoyQRz38l4Rsdatd+XMJsuICw7l05Q42tXS/u/OdBP7e7sq6Z6iUqkdlO+4IPRqw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795684764;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Q8yqgBgzTDJmfW5A1DWYJIHW8nL4dwX5V+usI6LVyyo=;
	b=Sm3KxKKTDweSLN4PNWO1idOBFd6uCqDH+o5qcF8e/v0h1OidooOLrtfEAxEq93pmQuRS
	 y4NA8WKeozTnZ8a3gYTQAMNjU2NNqP/GWQI0HzN1AoS3peSESH9XRjkm9zWMPfI4sbdJ3
	 e/jmUGcNl6R0o1fwr8NSRRMTqRmf/YuePYhuTzuzXXQU4z7YZlS9x5qpgHZs3+WB5kxKW
	 ySqSUTF9exzcabngyqWNszfMKpHvY7OASwlwEuLDKsMvEYIL+a+D68r6BW80tnLwLUXW5
	 0TKHuQcQC2eJu+aifhsm0/qW7MBuGPMMrFmd+oBkZQVEUx9dBnvuNWyCQjE3K8Cj3pQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2eWfEDc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C5C606A31C;
	Thu, 26 Nov 2026 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=m2eWfEDc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CC961F000D0;
	Thu, 26 Nov 2026 09:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795684763;
	bh=Q8yqgBgzTDJmfW5A1DWYJIHW8nL4dwX5V+usI6LVyyo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=m2eWfEDckBiV4URE17VXZMhzfxL8BBTiDuHqWG7oji0R8xam1bnn93Y4ZKGUc2B1j
	 wJlaw1uFL9zNDd0+4s5sBHAEdC4PjJToOvhMTv2qMyKoguJVMOH9pGj5jV/0262Jxj
	 5F7KLJRSx1PLWPMG1Df6RPSaj8nfrV2uESimdttsVM6GJPmfs2UNL/uXl7P5CdDHJ6
	 Hf4dx19Py7sc9NZdX7E7V3jXTCqKLN8BUSAJXyvpPFq4e4xpd0dz4AKp5PmeCHnVth
	 Qd16UOqdiIl3H0DljYQH/Ypdusb7S5WiwVwulP2KZwscFIr1F/eWfwE0Hu9AQZnGXj
	 USnYjonUnVm9g==
Subject: Re: [PATCH net-next v6] selftests: net: veth: derive invalid-tx test
 value from kernel max
From: netdev-bot+sashiko@kernel.org
To: emmaonana18@gmail.com
Cc: tianyi@cloudflare.com, hangbin.liu@linux.dev, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, skhan@linuxfoundation.org,
 kernel-team@cloudflare.com, tianyi.gao@linux.dev
Date: Thu, 26 Nov 2026 09:19:21 +0000
Message-ID: <179568476191.3135.16062946746480831699@kernel.org>
In-Reply-To: <20261124211645.5751-2-emmaonana18@gmail.com>
References: <20261124211645.5751-2-emmaonana18@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] chk_channels() in tools/testing/selftests/net/veth.sh (lines
  175-196) prints " fail ..." on a mismatch but never sets `ret=1`.
- [Low] The commit message says that once "failure propagation" is fixed,
  the false failure "fails the whole script".

--

selftests: net: veth: derive invalid-tx test value from kernel max

The "setting invalid channels nr" check in veth.sh used to try nproc+1
TX channels. It now reads the TX maximum the kernel reports through
ethtool -l and tries max+1. The old value can be valid on hosts where
nproc is less than num_possible_cpus().

> selftests: net: veth: derive invalid-tx test value from kernel max
>
> The "setting invalid channels nr" check treats CPUS+1 (CPUS=nproc)
> as an invalid tx count, but the kernel allows up to max_tx, for veth

[ ... ]

> the ethtool -L call succeeds and chk_channels() reports a false
> failure. With failure propagation fixed, this fails the whole script.

[Severity: Low]
Which patch provides the failure propagation fix mentioned here? In this
tree, chk_channels() only echoes on a mismatch and never sets ret=1:

tools/testing/selftests/net/veth.sh:chk_channels() {
    ...
	if [ "$cur_rx" = "$rx" -a "$cur_tx" = "$tx" -a "$cur_combined" = "n/a" ]; then
		echo " ok "
	else
		echo " fail rx:$rx:$cur_rx tx:$tx:$cur_tx combined:n/a:$cur_combined"
	fi
}

So before this patch, the CPUS+1 false positive printed a misleading
"fail" line, but veth.sh still exited with 0.

Suppose the failure propagation change is applied or backported to
stable without this patch. Then veth.sh would fail on hosts where nproc
is less than num_possible_cpus(). veth_get_channels() reports max_tx as
dev->num_tx_queues, and ethnl_set_channels() only rejects
tx_count > max_tx.

Could the two changes go in the same series, or could this one name the
dependency? Could it also carry a Fixes tag for the commit that added
the CPUS + 1 value?

Fixes: 1ec2230fc721 ("selftests: net: veth: add tests for set_channel")

> diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
> index 9496b599d722c..bd0d19c49b7cd 100755
> --- a/tools/testing/selftests/net/veth.sh
> +++ b/tools/testing/selftests/net/veth.sh
> @@ -569,7 +569,9 @@ fi
>  ip netns exec $NS_DST ethtool -L veth$DST combined 2 2>/dev/null
>  chk_channels "bad setting: combined channels" $DST $CUR_RX $CUR_TX
>  
> -ip netns exec $NS_DST ethtool -L veth$DST tx $((CPUS + 1)) 2>/dev/null
> +MAX_TX=`ip netns exec $NS_DST ethtool -l veth$DST |\
> +	grep TX: | head -n 1 | awk '{print $2}'`
> +ip netns exec $NS_DST ethtool -L veth$DST tx $((MAX_TX + 1)) 2>/dev/null
>  chk_channels "setting invalid channels nr" $DST $CUR_RX $CUR_TX

[Severity: Medium]
Can this check ever change the test result? The other checkers in
veth.sh set ret=1 on failure, for example chk_napi_ids(), and
chk_channels_carrier is called with "|| ret=1". chk_channels() does
not set ret at all.

The script ends with exit $ret. Suppose the tx_count > max_tx check in
ethnl_set_channels() or ethtool_set_channels() regressed, and
ethtool -L tx $((MAX_TX + 1)) were accepted. veth.sh would print "fail"
and still report success to kselftest.

The same applies to the other chk_channels() checks: "setting tx
channels", "setting both rx and tx channels" and "bad setting: combined
channels".

The commit message relies on failure propagation being fixed. Should
that change be part of this submission, so the updated check actually
affects the exit status?

>  
>  if [ $CPUS -gt 1 ]; then

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261124211645.5751-2-emmaonana18%40gmail.com
