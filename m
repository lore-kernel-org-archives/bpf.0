Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FBF3AD51E
	for <bpf@vger.kernel.org>; Wed, 15 Jul 2026 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784153301; cv=none; b=kFOxN/AqVeErttcPC/ZdlQlIu1IAeMVmwnNik+hkyT3FWqLxBbzTN0v4iChQiMXR2L06qiRXwb9JxyUvQFDe/8FuuK79KFySV+chXhtAphqwO1V08Gk0lvwM3DLP67voIQvmjK0mFdEDpbtA2BNYiZ1OrZ08N4vAerZNtuwWR90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784153301; c=relaxed/simple;
	bh=hrb4REJDSvfMlHrQ6uyGMXKaD0sovJSQpZ6Ne9pam2k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hT8MMBH6yTiZ8crH0LbFvcgeuLz9P9GPd6pV8T7qceX2nxRhMP1+wwMdmZdnXaUEZuPY/l0P0opvWD4LsrTCluMxIUP8YPzxY0M7MK8m9uo1r7D8qWWzY90rjuj2IAXe0HAkaWrnSlL38EY8HkVmt5ywjOfIQrToFbIo4nBHMFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBxTZeBj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBxTZeBj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39621F000E9;
	Wed, 15 Jul 2026 22:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784153300;
	bh=4dBtTBb3An3Ip0vkCGhvUEDxbyxYy2TZLrIUeOlEBTc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dBxTZeBj/aNiIiEntRsgoKQ1msDx41DtRBnXLFXYdYLSC1QWsFMU/jCh9Mt5dkdSU
	 ddnbo0Ruk1r/zxDUQv04VdZ2kSyWx82+xj8b6KUbxchaoprhTu7/XCksLX4leqF1N9
	 XxUyWUSU7cvjZoE2mS0NupVOzfsA0VtnzW6xgggDaPd6LiRBt9Rk6AMUUcHNAMOPKW
	 Ee9LOLWOLhSJEIgsbjFKoI7MFgSXKE7WEYrDWT+liOmWBbwh+CfwrDcI1RyRYbxZzI
	 ijyfVcL3xkhPp5hSamrkTPi/j2T1rpyfRdOzuONHkTrO2a8DwqhhX0FdZkxGkZt7Ix
	 l56sToiOkrcCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 7/8] selftests/bpf: Add test for
 bpf_skb_rx_checksum kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Lorenzo Bianconi" <lorenzo@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260715-bpf-xdp-meta-rxcksum-v5-7-623d5c0d0ab7@kernel.org>
References: <20260715-bpf-xdp-meta-rxcksum-v5-0-623d5c0d0ab7@kernel.org>
 <20260715-bpf-xdp-meta-rxcksum-v5-7-623d5c0d0ab7@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 22:08:19 +0000
Message-Id: <20260715220819.D39621F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The `csum_cnt` array map is sized incorrectly and explicitly dro=
ps valid `SKB_CSUM_PARTIAL` checksum states.
- [Low] Passing an `enum skb_csum *` to a kfunc expecting a `__u32 *` cause=
s an incompatible pointer type warning.
- [Low] The multi-line comment for `bpf_skb_rx_checksum` violates the requi=
red BPF subsystem comment style.
--

--- Patch [7]: [PATCH bpf-next v5 7/8] selftests/bpf: Add test for bpf_skb_=
rx_checksum kfunc ---
commit b45897a4d5ef22742e4af5ab8e7a00ba0c92d2f2
Author: Lorenzo Bianconi <lorenzo@kernel.org>

selftests/bpf: Add test for bpf_skb_rx_checksum kfunc

This commit adds a selftest for the newly added bpf_skb_rx_checksum() kfunc.
The test consists of a TC BPF program that calls the kfunc and records the
checksum type, along with a userspace test runner.

> diff --git a/tools/testing/selftests/bpf/bpf_kfuncs.h b/tools/testing/sel=
ftests/bpf/bpf_kfuncs.h
> index ae71e9b690518..d03572e26df2d 100644
> --- a/tools/testing/selftests/bpf/bpf_kfuncs.h
> +++ b/tools/testing/selftests/bpf/bpf_kfuncs.h
> @@ -64,6 +64,14 @@ struct bpf_tcp_req_attrs;
>  extern int bpf_sk_assign_tcp_reqsk(struct __sk_buff *skb, struct sock *s=
k,
>  				   struct bpf_tcp_req_attrs *attrs, int attrs__sz) __ksym;
> =20
> +/* Description
> + *  Read skb RX checksum info (ip_summed and csum_meta).

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the BPF subsystem
comment style? The guidelines require the opening /* to be on its own line.

> + * Returns
> + *  0 on success
> + */
> +extern int bpf_skb_rx_checksum(struct __sk_buff *skb, __u32 *ip_summed,
> +			       __u32 *csum_meta) __ksym;
> +

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/skb_rx_checksum.c b/tools/=
testing/selftests/bpf/progs/skb_rx_checksum.c
> new file mode 100644
> index 0000000000000..dc4e192905d53
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/skb_rx_checksum.c
> @@ -0,0 +1,33 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <linux/pkt_cls.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_kfuncs.h"
> +#include "skb_rx_checksum.h"
> +
> +struct {
> +	__uint(type, BPF_MAP_TYPE_ARRAY);
> +	__uint(max_entries, SKB_CSUM_PARTIAL);

[Severity: Medium]
Does this incorrectly restrict the map size? SKB_CSUM_PARTIAL is defined as
3, which means the map can only hold entries for 0, 1, and 2, leaving no
room to track the SKB_CSUM_PARTIAL state itself.

> +	__type(key, __u32);
> +	__type(value, __u64);
> +} csum_cnt SEC(".maps");
> +
> +SEC("tc")
> +int tc_rx_csum(struct __sk_buff *skb)
> +{
> +	enum skb_csum ip_summed;
> +	__u32 csum_meta;
> +	__u64 *cnt;
> +
> +	bpf_skb_rx_checksum(skb, &ip_summed, &csum_meta);

[Severity: Low]
Will this cause an incompatible pointer type compiler warning in
tc_rx_csum()? The kfunc bpf_skb_rx_checksum() expects a __u32 * for its
second argument, but &ip_summed is a pointer to an enum skb_csum.

> +	if (ip_summed < SKB_CSUM_PARTIAL) {

[Severity: Medium]
By using strictly less than SKB_CSUM_PARTIAL, does this silently drop valid
packets that have the SKB_CSUM_PARTIAL state?

> +		cnt =3D bpf_map_lookup_elem(&csum_cnt, &ip_summed);
> +		if (cnt)
> +			__sync_fetch_and_add(cnt, 1);
> +	}
> +
> +	return TC_ACT_OK;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260715-bpf-xdp-me=
ta-rxcksum-v5-0-623d5c0d0ab7@kernel.org?part=3D7
