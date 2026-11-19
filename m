Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795101850;
	b=FaN8yY7JOUD/U/zLf+f2VFe2uJw+Jx9sLi7FJaxX7Z7eouxaVWN0H1M9hGMbKjgsjnHp
	 m+lO6appMnX7/SgdJBTPU5V0xt98pwK/kBs7K7GmuycTel70dJQzPXd01Wm3vjn+p5wgr
	 1FPGInZbhYwGZJbg9wYKA9v0WiqXoAPwIcL/wnBRiixGXs7mhks/AUhGMUiNx9DjzT/E/
	 YBLpLC0qwQxHhTMHJFi/PF6VSWslPm8m+CUwtj4Me4S6IK0qxR/uzu2XksBCaMBTENXDP
	 w+v1An+nVEvQF44Ps43ZrL0CMzFgpo6Kd86QkndQ7v5QWpFzDLlrNEVcq5zBI7yBCeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795101850;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=2axt5vu0NQUoXMUudKN7SE3TreXhSEj62FHJAyuTVVI=;
	b=eVx5lE8s5hxp2zuUcvXQ7Q3riYtqmAzGEZ3L7l65ZsOUxA/a5CM/Zq55DE5Y319hmHKG
	 qVOwExC4+uY6b4KaO4twCjwToR5PbXrQ9Wliwak/2WAVdKF7kWkPihZcB+hgQ13NF3mWP
	 9rNrCPJ+huXXqMiaiY2g49G3X6+gbSbCGlmyEcONaGozs2aUYE5n/wPmtLxiaNtN4XF4V
	 xFnDoXVsPViR++Mt0d1Rs2kCIJvTP1KLPYlxxiKuBz/0ENkM0Mn3qfkiwqvaCOHzXZ8qk
	 6Ngejo++YMdnrMIlGq2TuW1f5hIl9lrg5v+osGYWXjcPDiILbrAdJO2NxU+/GITLsIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEZvF1UF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2C8606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 15:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NEZvF1UF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CC31F000C5;
	Thu, 19 Nov 2026 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795101850;
	bh=2axt5vu0NQUoXMUudKN7SE3TreXhSEj62FHJAyuTVVI=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NEZvF1UF846AmeBEJswQ/X+XU3bwj53k+XDvfd2tDjzVEG3XiJxEw6je01mM5tGdh
	 0dCimpuLefe7ymzKPCexoOoGoaBH5py4hzU2c3E3X3SvQMFtyASBjwI5r9ao/EhaU4
	 2+UFrDJn6NGvdBx9m5fy6ETzrTX+Qu79Xr7duScomJCUD+Sf8lI4Ny4Eg4ingA7+GR
	 AOqDK1X7S24Tm1hxsxfKc53FnGcCKPA7XYq0g1wlGXvri0SHXdDS3bXMWFkrNkzv8g
	 P4OgzhgKaV0S5neNss0VoKhIqmBfnc3XDaQgoKIqGdtzcsT9OMKpcbt9SRQyQbTh3n
	 Zdirrx8wvDSlA==
Message-ID: <sashiko-outbox-223378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 4/8] bpf: support SOCK_RCU_FREE sockets in
 bpf_sk_assign on egress
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nikolay Aleksandrov" <razor@blackwall.org>, bpf@vger.kernel.org
In-Reply-To: <20261119142231.2612515-5-razor@blackwall.org>
References: <20261119142231.2612515-1-razor@blackwall.org>
 <20261119142231.2612515-5-razor@blackwall.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 15:24:09 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential
issues to consider:
- [High] bpf: BUG_ON(skb->sk) in skb_orphan() via bpf_sk_assign() in
  bpf_prog_test_run_skb()
- [High] bpf: cross-netns socket leak on tc egress in bpf_sk_assign()
- [High] net: uncharged sock_wfree() on frag_list after egress
  bpf_sk_assign()
- [High] bpf: sock_pfree_ref ownership and sk_wmem_alloc corruption on
  egress
--

commit e7a6cd63b8b9259d47c7f6ec283ab9c14f268028
Author: Daniel Borkmann <daniel@iogearbox.net>

bpf: support SOCK_RCU_FREE sockets in bpf_sk_assign on egress

This commit removes the sk_is_refcounted() restriction in bpf_sk_assign()
on TC egress so that full SOCK_RCU_FREE sockets, such as TCP listeners,
can be assigned with an skb-owned reference.

> diff --git a/net/core/filter.c b/net/core/filter.c
> index feeb752f7a008..4dea2cc84712a 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -8123,8 +8123,7 @@ BPF_CALL_3(bpf_sk_assign, struct sk_buff *, skb, st=
ruct sock *, sk, u64, flags)
> =20
>  	if (!sk || flags !=3D 0)
>  		return -EINVAL;
> -	if (egress && (!sk_fullsock(sk) || !sk_is_refcounted(sk) ||
> -		       skb_is_decrypted(skb)))
> +	if (egress && (!sk_fullsock(sk) || skb_is_decrypted(skb)))
>  		return -EOPNOTSUPP;
>  	refcounted =3D egress || sk_is_refcounted(sk);
>  	if (unlikely(dev_net(skb->dev) !=3D sock_net(sk)))

[Severity: High]
Can calling bpf_sk_assign() during BPF_PROG_TEST_RUN trigger BUG_ON(skb->sk)
in skb_orphan()?

In bpf_prog_test_run_skb(), the test skb is built with skb->tc_at_ingress
set to 0, skb->sk pointing to a dummy socket, and skb->destructor left as
NULL:

net/bpf/test_run.c:bpf_prog_test_run_skb() {
	...
	skb =3D slab_build_skb(data);
	if (!skb) {
		ret =3D -ENOMEM;
		goto out;
	}
	skb->sk =3D sk;
	...
}

Because skb_at_tc_ingress(skb) is false, egress is true in bpf_sk_assign().
With this change, passing any hashed full socket in the current netns
(such as a TCP listener or UDP socket from bpf_sk_lookup_tcp() or
bpf_sk_lookup_udp()) now passes the egress check and reaches
skb_orphan(skb), which hits BUG_ON(skb->sk) when skb->destructor is NULL.

[Severity: High]
Can assigning a socket on TC egress leak skb->sk across a network
namespace boundary?

When bpf_sk_assign() runs in sch_handle_egress() on a veth or netkit
device, skb->dev is still in the sender's network namespace, so
dev_net(skb->dev) =3D=3D sock_net(sk) succeeds and sets skb->destructor to
sock_pfree_ref.  When the packet crosses into the peer's network
namespace, skb_scrub_packet() does not orphan skb->sk, and ip_rcv_core()
and ip6_rcv_core() skip skb_orphan() because skb_sk_is_prefetched(skb) is
true.

In the receiving namespace, inet_steal_sock() and inet6_steal_sock()
return the prefetched socket without checking net_eq(net, sock_net(sk)),
delivering the peer namespace's packet to the sender namespace's TCP
listener or UDP socket (and caching the peer namespace's dst_entry in
sk->sk_rx_dst), while ip_forward() and ip6_forward() drop the packet if
it is routed because skb->sk is non-NULL.

[Severity: High]
Can IP fragmentation after an egress bpf_sk_assign() underflow
sk->sk_wmem_alloc on a frag_list skb?

bpf_sk_assign() attaches sk to skb with destructor sock_pfree_ref and only
takes an sk_refcnt reference without charging sk->sk_wmem_alloc.  If an
skb carrying a frag_list later enters the fastpath in ip_do_fragment() or
ip6_fragment() (for example, after traversing a VRF device with a TC
egress program attached), each fragment is given sock_wfree without
checking is_skb_wmem(skb):

net/ipv4/ip_output.c:ip_do_fragment() {
	...
			BUG_ON(frag->sk);
			if (skb->sk) {
				frag->sk =3D skb->sk;
				frag->destructor =3D sock_wfree;
			}
			skb->truesize -=3D frag->truesize;
	...
}

When those fragments are freed, sock_wfree() subtracts their uncharged
truesize from sk->sk_wmem_alloc, which underflows sk_wmem_alloc on a
SOCK_RCU_FREE listening socket (preventing sk_free() from freeing the
socket on close) or triggers a premature __sk_free() while the socket is
still in use.

[Severity: High]
Can egress paths that assume skb->sk is a write-charged socket corrupt
sock_pfree_ref ownership or leak sk->sk_wmem_alloc?

In skb_expand_head() (reachable after TC egress via bpf_redirect_neigh()
or VRF output when headroom is expanded), is_skb_wmem(skb) is false for
sock_pfree_ref:

net/core/skbuff.c:skb_expand_head() {
	...
	if (skb_shared(skb) || !is_skb_wmem(skb)) {
		struct sk_buff *nskb =3D skb_clone(skb, GFP_ATOMIC);

		if (unlikely(!nskb))
			goto fail;

		if (sk)
			skb_set_owner_w(nskb, sk);
		consume_skb(skb);
		skb =3D nskb;
	}
	...
}

skb_set_owner_w() replaces sock_pfree_ref with sock_wfree and charges
sk->sk_wmem_alloc, while consume_skb(skb) drops the sk_refcnt reference;
because nskb->destructor is now sock_wfree, skb_sk_is_prefetched(nskb) is
false and the receive path orphans the assigned socket.

Similarly, esp_output_head() and esp6_output_head() check
if (sk && sk_fullsock(sk)) rather than is_skb_wmem(skb) before calling
refcount_add(tailen, &sk->sk_wmem_alloc), adding write memory charges that
sock_pfree_ref() never releases and preventing sk_free() from freeing the
socket when closed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119142231.2612=
515-1-razor@blackwall.org?part=3D4
