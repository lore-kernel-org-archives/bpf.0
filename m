Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AC5420E702
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 03:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782358676; cv=none; b=hmELQTeeckhka9bsmsVQOXTtOBL+9dqELpo310uYTL+B25yhCZnLzHJlqOUQFVgn8+6NLn8aSz+odGhMHwwjF7qUNbyBXCyTitsZiibLGFPcSKVNRwD9zcUzRjBw2w/Fp9W/0ZpGVa8KwcHy2jWlJRmprCGkR4Jkj2+MyaYWAtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782358676; c=relaxed/simple;
	bh=yNSdL2jeXaw2zEU4y1EU+2q083XD+wgFTn/Us9DKqYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XcgCEffwfhUCc4UcNNu9bjUEg9Dp6tmA9VM1bUGzYikuEOKWHjR+0K5EdZ9qmfOYb9PJH5tSRz9iL7hUHARmpTMpAoUVlS99LB8KMquAL2cVhhIzvqJtpjMKbHJweKrXxwHX7+J+fy6wMxMctEqGRF+1L8rUdO0e3qqwChi/7og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uUz9NM0r; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uUz9NM0r"
Message-ID: <184b1d3c-a9cd-436a-b2b2-c5bac488859b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782358662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LLC4woZWpOCsOMgiHjNXcQjJ+5Cp5MOUCJPQZtPdNEA=;
	b=uUz9NM0rIBIUkVy0lZ1yq98dfh9Bb4qcQ/qVXyjzQ9uTOBV8xI7sySzY7waZ3kGlQn/BPu
	4p+WvsJZCP1DHHztVdGkwAM8rCn/2WNxv3aUhlGjZ0hWcb1+vpyhN8eI5raWTgHQU2w/0N
	+a61XEi7DRYZlT2/+aXrAMHnLyolTlA=
Date: Thu, 25 Jun 2026 11:37:34 +0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 bpf-next 1/2] bpf: Support BPF_F_EGRESS with
 bpf_redirect_peer
To: Jordan Rife <jordan@jrife.io>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev
 <sdf@fomichev.me>, Jiayuan Chen <jiayuan.chen@linux.dev>,
 Paul Chaignon <paul.chaignon@gmail.com>
References: <20260618182035.43811-1-jordan@jrife.io>
 <20260618182035.43811-2-jordan@jrife.io>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260618182035.43811-2-jordan@jrife.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 6/19/26 2:20 AM, Jordan Rife wrote:
> We have several use cases where a pod injects traffic into the datapath
> of another so that the traffic appears to have originated from that
> pod. One such use case is a synthetic flow generator which injects
> synthetic traffic into a pod's datapath to enable dynamic probing and
> debugging. Another is a transparent proxy where connections originating
> from one pod are redirected towards another which proxies that
> connection. The new connection is bound to the IP of the original pod
> using IP_TRANSPARENT and its traffic is injected into that pod's
> datapath and handled as if it had originated there. This can be used for
> mTLS, etc.
>
[...]
>
>    [ ID] Interval           Transfer     Bitrate         Retr
>    [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec    0       sender
>    [  5]   0.00-60.00  sec   272 GBytes  38.9 Gbits/sec            receiver
>
> In this test, using bpf_redirect_peer(BPF_F_EGRESS) for the hop from
> [iperf pod] to [pod b] led to ~18% more throughput compared to
> bpf_redirect(BPF_F_INGRESS).
>
> Signed-off-by: Jordan Rife <jordan@jrife.io>
> ---
>   include/uapi/linux/bpf.h       | 19 +++++++++++--------
>   net/core/filter.c              | 12 +++++++-----
>   tools/include/uapi/linux/bpf.h | 19 +++++++++++--------
>   3 files changed, 29 insertions(+), 21 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 89b36de5fdbb..c91b5a4bda03 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -5079,17 +5079,19 @@ union bpf_attr {
>    * 	Description
>    * 		Redirect the packet to another net device of index *ifindex*.
>    * 		This helper is somewhat similar to **bpf_redirect**\ (), except
> - * 		that the redirection happens to the *ifindex*' peer device and
> - * 		the netns switch takes place from ingress to ingress without
> - * 		going through the CPU's backlog queue.
> + * 		that the redirection happens to the *ifindex*' peer device. If
> + * 		*flags* is 0, the netns switch takes place from ingress to
> + * 		ingress without going through the CPU's backlog queue. If the
> + * 		**BPF_F_EGRESS** flag is provided then redirection happens in
> + * 		the egress direction of the peer device.
>    *
>    * 		*skb*\ **->mark** and *skb*\ **->tstamp** are not cleared during
>    * 		the netns switch.
>    *
> - * 		The *flags* argument is reserved and must be 0. The helper is
> - * 		currently only supported for tc BPF program types at the
> - * 		ingress hook and for veth and netkit target device types. The
> - * 		peer device must reside in a different network namespace.
> + * 		If the *flags* argument is 0, the helper is currently only
> + * 		supported for tc BPF program types at the ingress hook and for
> + * 		veth and netkit target device types. The peer device must reside
> + * 		in a different network namespace.
>    * 	Return
>    * 		The helper returns **TC_ACT_REDIRECT** on success or
>    * 		**TC_ACT_SHOT** on error.
> @@ -6336,9 +6338,10 @@ enum {
>   /* Flags for bpf_redirect and bpf_redirect_map helpers */
>   enum {
>   	BPF_F_INGRESS		= (1ULL << 0), /* used for skb path */
> +	BPF_F_EGRESS		= (1ULL << 1), /* used for skb path */
>   	BPF_F_BROADCAST		= (1ULL << 3), /* used for XDP path */
>   	BPF_F_EXCLUDE_INGRESS	= (1ULL << 4), /* used for XDP path */
> -#define BPF_F_REDIRECT_FLAGS (BPF_F_INGRESS | BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS)
> +#define BPF_F_REDIRECT_FLAGS (BPF_F_INGRESS | BPF_F_EGRESS | BPF_F_BROADCAST | BPF_F_EXCLUDE_INGRESS)
>   };
>   

Thanks, BPF_F_EGRESS is clearer.

Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>

