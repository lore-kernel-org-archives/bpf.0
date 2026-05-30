Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0331B1DE8BF
	for <bpf@vger.kernel.org>; Sat, 30 May 2026 00:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780102156; cv=none; b=Uq1wP2Fm9kOcs29moXQnGkdnaDUxva+exSmjWzWokvp5FAzueQLIBmlXjB3lUwDKePYFjhh2LRttA8aQd1cCVWB/jm2rKDcsmjafQeHCp3sFkPhzwnsNhcc6aZql3bOBtrIXV2emUpgy/I7DaPmtFM09iG2H7c71zycGT0g8/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780102156; c=relaxed/simple;
	bh=h9DlYTLlncrppN3ThJVRn74hezHFg2ZH8M+duhJLl3Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=U9I4K+hN4yQiLnmTXNiPA/k9Hpq6iTYddlijVFtVkxYfsSKvTsogfOShRKixnMuvGNAf34D/C3YsVWOm1heDIjeHDD2AEbejvpLq5PnCaMSdKUVzKmxOAZUo1wcAWi4G4qmzsnoEBfuSyt23jt+y0eGrIpX8XGZR6IzywhuZha0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKqfoT+X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKqfoT+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C05121F00898;
	Sat, 30 May 2026 00:49:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780102154;
	bh=5f0HqaIETFkktWGGui8pHwmi3EvQmbA/ccaqv/IeJLE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IKqfoT+Xe0oX7AtUxOyiNChHWrt7VabvUhT4XdAHB1RL+7htHabLCl+iVjRI7LpbH
	 wpsoZhEet5spwE/aXErGqyQWoCORVrKDeNNpvhqLAsft+w3k2ljNiZ7cVGZMZwU9hy
	 zAFYiEaZ8IM6IVr7LyE8/xOux/f3ZmW2J2na9v53BglOSuscwJibJhfvDKW8xENGYU
	 hTsXzorzYUt1igEgs+EopUewNT/V3aejFkgxfj8gB+zVgNtjVJJdpHkhwc5AjiPowZ
	 5Gnvpl80Nwsr0a4kwLj5x5JeAjnLSYbj1/DUFI+VDbJpklwKTebb8nakOO6NWE7hhu
	 Mg6QmmfeXPnPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v9 2/2] selftests: net: add local ECMP rehash
 test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Neil Spring" <ntspring@meta.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260526203403.3517607-3-ntspring@meta.com>
References: <20260526203403.3517607-3-ntspring@meta.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 30 May 2026 00:49:14 +0000
Message-Id: <20260530004914.C05121F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Background TCP data and teardown traffic from a killed client/se=
rver leak into the next round's packet counters, causing false-positive tes=
t failures.
--

commit 91aeb9a922748989931f3671404ddb1db78d7769
Author: Neil Spring <ntspring@meta.com>

selftests: net: add local ECMP rehash test

Add ecmp_rehash.sh with ten scenarios verifying that TCP rehash
selects a different local ECMP path for IPv6.

> diff --git a/tools/testing/selftests/net/ecmp_rehash.sh b/tools/testing/s=
elftests/net/ecmp_rehash.sh
> new file mode 100755
> index 0000000000000..c2c1c14078e90
> --- /dev/null
> +++ b/tools/testing/selftests/net/ecmp_rehash.sh
[ ... ]
> +test_ecmp_syncookie_path_consistency()
> +{
[ ... ]
> +	for r in $(seq 1 "$ECMP_REBUILD_ROUNDS"); do
> +		local port=3D$((PORT + 47 + r))
[ ... ]
> +		local srv_tcp0 srv_tcp1
> +		srv_tcp0=3D$(tc_filter_pkt_count "$NS2" veth0b)
> +		srv_tcp1=3D$(tc_filter_pkt_count "$NS2" veth1b)
> +		local srv_delta0=3D$(( ${srv_tcp0:-0} - ${srv_base0:-0} ))
> +		local srv_delta1=3D$(( ${srv_tcp1:-0} - ${srv_base1:-0} ))
> +
> +		if [ "$srv_delta0" -gt 0 ] && [ "$srv_delta1" -gt 0 ]; then
> +			path_splits=3D$((path_splits + 1))
> +		fi
> +
> +		kill "$client_pid" 2>/dev/null
> +		wait "$client_pid" 2>/dev/null
> +		kill "$server_pid" 2>/dev/null
> +		wait "$server_pid" 2>/dev/null
> +	done

[Severity: Medium]
Will asynchronous TCP teardown (FIN/RST/ACKs) or buffered data flushes from
these killed processes leak into the next round's packet counters?

Since the test uses global interface/tc packet counters that match all TCP
IPv6 traffic without isolating by port, it appears delayed packets from the
previous round could increment the counter for the old path, while the curr=
ent
round increments the counter for the new path.

Could this trigger failure conditions like the srv_delta0 > 0 && srv_delta1=
 > 0
check here in test_ecmp_syncookie_path_consistency, or similarly in
ecmp_dst_rebuild_loop, causing false-positive test flakiness?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260526203403.3517=
607-1-ntspring@meta.com?part=3D2
