Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF04516148;
	Wed, 30 Sep 2026 17:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790789181; cv=none; b=ODMtqCb7XMiNk4AsfC/SW2AiBUqe+F2vA2cMC9CmHnPNcjt3CBaJ/ps9xUjMc3nNE2JLgfOnhBTGDVzK1WrjIBHFRPW++eGOCKYyJCGhnLWuQAwHQLUc2KqijiMlUSjmsrlOgT5IxdH/QP+cf1PpMD0wTgN9elpoZI98ziSAk3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790789181; c=relaxed/simple;
	bh=X+yKqhr9AUfYhBvk+Ta3nF7sM+59yJudX1hbD8yel1I=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=cpHhxlELAbAQ2SWeNPpMRbpUYuhLiclL2rylr4shHNmct72Q9IquMvD5+PMRp1pufq4px6wsjsrfVqIuYoWPiUQRN5rOXWXRt8sDqPIxq6e2rpy6Maj12UCR1VnA21tdvD9u/0RHqasQ6MOMAAwYL0mue0YzA0eYpGdNaLbu8Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPSpf1Ev; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPSpf1Ev"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2C21F00898;
	Wed, 30 Sep 2026 17:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790789179;
	bh=RT+FEqj8btCnhn1wWNlSl5S9TYVlgLOWvfvX50rJm0s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=FPSpf1EvKhPP8wLm/wGhpEwDyRK+JxwUa9SOGvBeAQTDt8bicIg/Cp520HCPqhr6m
	 LDubXiz2IsS+yGrBD0PytUVvSC5m2LQ4ox9bJGwxtqXEBEUTZFJHLNNUKC+QdzHVkw
	 mEfoLp9al9jwEO4qb+DKq1dsnjx3RiwjK374q9u5cAInBXXk45YVkd0x9QcJ5uvx76
	 Y7ZeLl6TPDp6v7vXpH/8mnYLDoNrfzcbl73K83pcSqXszOGTvIydFYxkkympiFlcSV
	 3KLYE9Tp/X4EPXIF53IC/jP1ihwnPopk1Paor+Gs3418kfBXGUuIIunX+rJ2+5PEsZ
	 /eiCxIYoVMOTg==
Content-Type: multipart/mixed; boundary="===============1708859807357407925=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <c904434ece0c4e6c712af199370e991c926e2c1f5a571d78ae7c06c94b9f6e2e@mail.kernel.org>
In-Reply-To: <20260930164020.41006-2-shlomojune6@gmail.com>
References: <20260930164020.41006-2-shlomojune6@gmail.com>
Subject: Re: [PATCH bpf v3 2/2] bpf: reject incompatible protocol changes
From: bot+bpf-ci@kernel.org
To: shlomojune6@gmail.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,davem@davemloft.net,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,horms@kernel.org,linux-kernel@vger.kernel.org,netdev@vger.kernel.org,shlomojune6@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 30 Sep 2026 17:26:18 +0000 (UTC)

--===============1708859807357407925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: reject incompatible protocol changes

TL;DR: The family revalidation looks incomplete: LWT ingress encap
(bpf_lwt_push_ip_encap, seg6) can still change L3 protocol and leave a
mismatched assigned socket. Extend the check, or narrow the commit message's
claim?

> diff --git a/net/core/filter.c b/net/core/filter.c
> index 173349bd2a3f..22e2ecb0cf2f 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c

[ ... ]

> @@ -3549,6 +3549,12 @@ static bool bpf_sk_assign_family_ok(const struct sk_buff *skb,
>  	return bpf_sk_assign_family_ok_proto(sk, skb_protocol(skb, true));
>  }
>
> +static bool bpf_skb_proto_change_sk_ok(struct sk_buff *skb, __be16 proto)
> +{
> +	return !skb_sk_is_prefetched(skb) ||
> +	       bpf_sk_assign_family_ok_proto(skb->sk, proto);
> +}
> +
>  BPF_CALL_3(bpf_skb_change_proto, struct sk_buff *, skb, __be16, proto,
>  	   u64, flags)
>  {

The commit message says "Without revalidation, this bypasses the
assignment-time family check. Reject incompatible protocol changes before
modifying the skb, including L3 encapsulation and decapsulation."

Is this revalidation complete?  It is only wired into bpf_skb_change_proto(),
bpf_skb_net_grow() and bpf_skb_net_shrink(), but another path can still change
the L3 protocol of an skb that keeps its bpf_sk_assign()ed socket.

Here is one concrete sequence:

1. A tc ingress program calls bpf_sk_assign() on an IPv4 packet with an
   AF_INET TCP socket.  bpf_sk_assign_family_ok() passes and the program
   returns TC_ACT_OK.

2. ip_rcv_core() keeps the prefetched socket:

    /* Must drop socket now because of tproxy. */
    if (!skb_sk_is_prefetched(skb))
        skb_orphan(skb);

3. ip_rcv_finish_core() skips early demux because skb->sk is set, then calls
   ip_route_input_noref().  A route with "encap bpf in" sets
   dst->input = lwtunnel_input.

4. bpf_input() runs the LWT_IN program, which calls
   bpf_lwt_in_push_encap(BPF_LWT_ENCAP_IP) with an IPv6 header.  That reaches
   bpf_lwt_push_ip_encap(..., ingress=true):

    } else {
        skb->protocol = htons(ETH_P_IPV6);
    }

   The skb->sk / sock_pfree assignment is left untouched.
   BPF_LWT_ENCAP_SEG6 behaves the same way.

5. The program returns BPF_LWT_REROUTE.  bpf_lwt_input_reroute() calls
   ip6_route_input() and dst_input(), so the packet goes through ip6_input
   and on to tcp_v6_rcv().

6. inet6_steal_sock() -> skb_steal_sock() returns the prefetched AF_INET
   socket for the IPv6 packet.  This is the family mismatch that
   bpf_skb_proto_change_sk_ok() is meant to prevent.

In-kernel IP tunnel decapsulation in the same netns keeps the prefetched
socket across a family change in the same way.  For example, with sit:

    ipip6_rcv()
        iptunnel_pull_header()    /* sets skb->protocol = ETH_P_IPV6 */
        skb_scrub_packet(skb, false)    /* does not orphan */
        netif_rx()

Should bpf_lwt_push_ip_encap() and bpf_push_seg6_encap() on ingress also call
bpf_skb_proto_change_sk_ok() (or orphan a prefetched socket)?  Or should the
commit message narrow its claim to the two tc helpers?

This is not introduced by this patch, and every step above needs
CAP_NET_ADMIN (tc and LWT programs).  But it limits the protection the patch
claims to provide.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36746681022
--===============1708859807357407925==--
