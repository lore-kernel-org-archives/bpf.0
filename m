Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2B1346E67;
	Wed, 12 Aug 2026 10:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530797; cv=none; b=PFIOlJNXT0rKO9Ivw16Rbk1bcixtHrrC3Qveh7In917LRy1pNOocKvwlMWyC1HqZgclDJRf89/eIx5kgZOwz0DQrC0NiJOg5SAFVACDynlKoL85a6jYvUZd+YXyYuKcfCnbGzYEtPA29/bKvjT9z6vdEX89UO4ov0/D/k8jKD7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530797; c=relaxed/simple;
	bh=xTnmAe1Hevf7pVr3gVXfaHVG3DHDNqEZzlv809J/9E4=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=d33OYQdzRl1wt8pWlHLgPTrC1aP+STZmLxnzs+jn08RmZD9kSNgzXJGlxb0JqqNSowr6AdBiJY3Rw0BHhMPiGMbBOXftbmrGIuLwIBiXAYmuMCqSU/EwmGIlpC0UrUhAPwIF7TrfMyuAHFQgo7CkyQ+zjNW8UF7l1nBBjhj1EuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSj+5Ebl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSj+5Ebl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F9CA1F000E9;
	Wed, 12 Aug 2026 10:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786530792;
	bh=2aoSjh2sidedn/amOEXCUvS+EGtJSRFn1UMbDUdBHoI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=QSj+5Ebln2WDfZW+ElU1OZgPPn3zqzSuJ55oizaAUSVYpdkUrRSEdAHjpHs5xtEgR
	 C/hJdCKXu9iRKeW19Yi0pL0cllPkRpbrJaXkzdRJVBPODkMeUkyOPIp+0Z8EpTdphq
	 nfzuUldYe7uvqSjMpjtDYfnhHaiCtzDNB8LowbWH2oh7E+vqf9s3EIgHZERPoDMFg3
	 4c4t0pDtoEkcyjH19bo6MmBO3bTY+v59xaxZKKEj0kV8xiyFmWjQEI0Rxb3jZ6LXxl
	 iY1YTNfvE5Q1SJR7Ewk3DMFfWeDgSWO/s6u0GpaR1RCebGJHqq+VAbaOWbvBI9La0M
	 gUndOKwLLymQA==
Content-Type: multipart/mixed; boundary="===============8002230123592158658=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <088eba49857b5cab3fce1b0b917ece4594464be28c7ec4c1e0a551089f1a81a7@mail.kernel.org>
In-Reply-To: <20260812083115.73100-6-nhudson@akamai.com>
References: <20260812083115.73100-6-nhudson@akamai.com>
Subject: Re: [PATCH bpf-next v7 5/6] bpf: clear decap state on skb_adjust_room shrink path
From: bot+bpf-ci@kernel.org
To: nhudson@akamai.com,bpf@vger.kernel.org,netdev@vger.kernel.org,willemb@google.com,martin.lau@linux.dev
Cc: nhudson@akamai.com,mtottenh@akamai.com,aglasgal@akamai.com,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Wed, 12 Aug 2026 10:33:11 +0000 (UTC)

--===============8002230123592158658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> On shrink in bpf_skb_adjust_room(), apply decapsulation state updates
> according to BPF_F_ADJ_ROOM_DECAP_* flags.
>
> For GSO skbs, clear only the tunnel gso_type bits that correspond to the
> requested decap layer:
> - DECAP_L4_UDP: SKB_GSO_UDP_TUNNEL{,_CSUM}
> - DECAP_L4_GRE: SKB_GSO_GRE{,_CSUM}
> - DECAP_IPXIP4: SKB_GSO_IPXIP4
> - DECAP_IPXIP6: SKB_GSO_IPXIP6
>
> Then clear skb->encapsulation only if no tunnel GSO bits remain, keeping
> encapsulation set for cases such as ESP-in-UDP where tunnel state remains.
>
> For non-GSO skbs, there are no tunnel GSO bits to consult, so clear
> skb->encapsulation directly when DECAP_L4_* or DECAP_IPXIP_* flags are set.
>
> This keeps decap state handling consistent between GSO and non-GSO packets.

This looks like a bug fix for the DECAP flags added in commit 0e08a219f910.
That commit added the BPF_F_ADJ_ROOM_DECAP_* flags and documented that they
would clear GSO state and encapsulation flags, but the behavior was never
implemented in the code. This commit implements that documented behavior.

Should this include:

  Fixes: 0e08a219f910 ("bpf: add BPF_F_ADJ_ROOM_DECAP_* flags for tunnel decapsulation")


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/31584739682
--===============8002230123592158658==--
