Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB5B3939C9;
	Tue,  2 Jun 2026 18:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780425357; cv=none; b=lLdlbV1SGhaNWuZnxFzdvMLL8bserY8QVH/ioyWt0q6Ejo2if8cjgSwNhTUpxLcL+7qZWhnv6VLd4W6P0099yFtc2RAufOuxPfDSLTbsS+Viy17wcUyP1SV7u4LSFUm0Jmwxb5IWYrVFWtIZwaHTyYRjoaj8Mi6p9eM7H//UFGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780425357; c=relaxed/simple;
	bh=YKMVzLv2nwJbwNV2Qf9pIUSkAh4/gzIbJ1LACKVTlWM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=DcfzkUGqvirZ9GIP/K/hEKB5uyqlRJwuHMdg5raKg+Bfd0J+xCIVud9CT1C7anwGhhtCWn3fJFxo6vQFiebgXIclJsjcUWzUMbgYQY7RLRN/SOBQ7jecTN16tcpxPSIV5zpLhrcBlna7NVdCNHGX9piW7M19HN7VZtDK3drMcP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bHAyxxAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bHAyxxAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0CF41F00893;
	Tue,  2 Jun 2026 18:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780425356;
	bh=Pfrgict5G66lw63P1xz2cLq6BXoxDGuE39jBmt317Iw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=bHAyxxApfOfMF3epiITWy2Xb/EkjlSVreCLnlTZ9rmtOEYwEJshQxogZXt5OxS3Ny
	 k8tAbhCV0NnVnh14nhVRn8ZPxhOXLKgH1iAdbGBLUXo46+2AAGlO7ec2TnDfGCwgIM
	 LCoXxM+rHRdLJ/1dxY+5TBrF8ZWSU28iaoEvxb9oFNgFzNizyTQu9MKGceZB/OX9+h
	 /bG9W17gd6sw21GtCvB649PH/S7q0TIRthdUngyaobZAptLN6LmmrnFEwS+sU4CDba
	 /bw5Iv727MksRqu0FLNxWThNaa63hOtNYDbKZjo3+QGctE5FynQqRhEG5mXNM4jr90
	 C2AFMAJt4pBBw==
Content-Type: multipart/mixed; boundary="===============5845776007157322852=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <8ac88be59633fbdf71337c80ecad1a268a989440e8865df3ef6906d33bbf0837@mail.kernel.org>
In-Reply-To: <20260602181428.2318919-3-ntspring@meta.com>
References: <20260602181428.2318919-3-ntspring@meta.com>
Subject: Re: [PATCH v11 2/2] selftests: net: add local ECMP rehash test
From: bot+bpf-ci@kernel.org
To: ntspring@meta.com,netdev@vger.kernel.org
Cc: edumazet@google.com,ncardwell@google.com,kuniyu@google.com,davem@davemloft.net,kuba@kernel.org,dsahern@kernel.org,pabeni@redhat.com,horms@kernel.org,shuah@kernel.org,linux-kselftest@vger.kernel.org,ntspring@meta.com,bpf@vger.kernel.org,martin.lau@linux.dev,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue,  2 Jun 2026 18:35:55 +0000 (UTC)

--===============5845776007157322852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/net/ecmp_rehash.sh b/tools/testing/selftests/net/ecmp_rehash.sh
> new file mode 100755
> index 000000000000..ffaacf1d9513
> --- /dev/null
> +++ b/tools/testing/selftests/net/ecmp_rehash.sh
> @@ -0,0 +1,1066 @@

[ ... ]

> +tc_filter_pkt_count()
> +{
> +	local ns=$1; shift
> +	local dev=$1; shift
> +
> +	ip netns exec "$ns" tc -s filter show dev "$dev" parent 1: 2>/dev/null |
> +		awk '/Sent .* pkt/ {
> +			for (i=1; i<=NF; i++)
> +				if ($i == "pkt") { print $(i-1); exit }
> +		}'
> +}

These per-device tc filter counters match all TCP IPv6 traffic on the
device, with no isolation by port.

[ ... ]

> +test_ecmp_syncookie_path_consistency()
> +{

[ ... ]

> +	for r in $(seq 1 "$ECMP_REBUILD_ROUNDS"); do
> +		local port=$((PORT + 3 * ECMP_REBUILD_ROUNDS + r))
> +
> +		ip netns exec "$NS2" socat -u \
> +			"TCP6-LISTEN:$port,bind=[fd00:ff::2],reuseaddr" \
> +			- >/dev/null &
> +		local server_pid=$!
> +
> +		wait_local_port_listen "$NS2" "$port" tcp
> +
> +		local srv_base0 srv_base1
> +		srv_base0=$(tc_filter_pkt_count "$NS2" veth0b)
> +		srv_base1=$(tc_filter_pkt_count "$NS2" veth1b)

The baseline is snapshotted here, after the new listener starts, which
handles leakage that arrives before this point.

[ ... ]

> +		local srv_tcp0 srv_tcp1
> +		srv_tcp0=$(tc_filter_pkt_count "$NS2" veth0b)
> +		srv_tcp1=$(tc_filter_pkt_count "$NS2" veth1b)
> +		local srv_delta0=$(( ${srv_tcp0:-0} - ${srv_base0:-0} ))
> +		local srv_delta1=$(( ${srv_tcp1:-0} - ${srv_base1:-0} ))
> +
> +		if [ "$srv_delta0" -gt 0 ] && [ "$srv_delta1" -gt 0 ]; then
> +			path_splits=$((path_splits + 1))
> +		fi
> +
> +		kill "$client_pid" 2>/dev/null
> +		wait "$client_pid" 2>/dev/null
> +		kill "$server_pid" 2>/dev/null
> +		wait "$server_pid" 2>/dev/null
> +	done

The client and server from each round are killed at the end of the
round, but the loop moves straight on to the next round.

Can asynchronous teardown traffic (FIN/RST/ACK) from the killed client
or server of a previous round still be in flight after srv_base0 and
srv_base1 are snapshotted for the next round?  Since the counters match
all TCP IPv6 traffic on the device rather than the current round's port,
would a late teardown packet on one path plus the new round's traffic on
the other path increment both srv_delta0 and srv_delta1, satisfying the
srv_delta0 > 0 && srv_delta1 > 0 check and recording a spurious split?

Would a short quiescence wait or filtering the tc counters by the
current round's port make this check more robust against late packets?

> +	if [ "$path_splits" -gt 0 ]; then
> +		check_err 1 "$path_splits/$ECMP_REBUILD_ROUNDS had split server path"
> +	fi

The same pattern appears in ecmp_dst_rebuild_loop(), which also relies
on these global per-device counters across rounds.

This was raised by an automated review on an earlier version
(v9, https://lore.kernel.org/r/20260530004914.C05121F00898@smtp.kernel.org)
and the counter structure is unchanged in the current version.  It
affects test reliability rather than kernel correctness.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26839485409
--===============5845776007157322852==--
