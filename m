Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA97332EAD
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780925493; cv=none; b=hMCvaWR4HkLbt4BsvNRWsAWR6k8Iz/yHVoSy8NQ6mYYPuOglFNL18CFMilqPjQ+MHpGyocl3ZC48eCSFISP2TETkQz/HN/eoqUaMdgR6hcJT0r9HH7AhrEgvZQEJv13oi0+i+bvUh2uPDesz4F1RPiUW5REcl/PxwEL6Nn1NXRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780925493; c=relaxed/simple;
	bh=0VosCxI+LsVudW1MIRgU/n6Ww1FcktX0naDLpjP3qXU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hrXQDcoXjzV/gVqzypmy51qm4dIT9CMK7STGaQ98MOPoIq0SWnd1OAaJGcs/5WDeg6vzCJjE/mKSfXSnoH8mcbaJnyp/NVp+zku56J/Nyvx9hMIbDUSo0BArF8GVQZOuctEBdWcEa4t+1b3BO9uaSCcKaJSU6e//zj87xqEwb6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m68hIbJH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m68hIbJH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD651F00893;
	Mon,  8 Jun 2026 13:31:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780925492;
	bh=gwvdpTt88zPpk+huF4lQCqOccxemF8HQ1P2BX8alpsg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m68hIbJHwCQtsfEcm5n5gn5wfdJ5jC3waTN5S00WCMPb2ta04sG74exwwSgieYLHk
	 0ceFuWc2AFWpiN343fV8d7xad1R7hi61vQ9iK8wgFwPklxQ/39dIGdcYTByKqM8dgP
	 cnMPoAtV04Hm/2Ea+S/YaSbZd3bmiOXcF+BUkOwmqBZV97en4uEB0pN6kYLGOrb6Gl
	 Fq5tUyEh/C+1mx4kFFkvcDXEou7r9DtRkdxR5QScCCdg6bZCiggNm1RSmTGpbT5lip
	 WdQfRmslUvNh0cGO4ohnGan+rQxTPVRNmzmg4Nb46NacXezCF0pM+5EDI/3WbhhJMU
	 gFJqgGa32uodw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v8 1/2] net: Validate protocol in skb_steal_sock()
 for BPF-assigned sockets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260608125846.157004-2-jiayuan.chen@linux.dev>
References: <20260608125846.157004-2-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 13:31:31 +0000
Message-Id: <20260608133131.DDD651F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The patch adds a protocol validation check to skb_steal_sock()=
 to prevent mismatched sockets from causing type confusion. However, it res=
tricts this check exclusively to 'prefetched' sockets. Sockets assigned via=
 TCP early demux (tcp_v4_early_demux()) evaluate prefetched to false. An at=
tacker can use a Netfilter rule at the NF_INET_LOCAL_IN hook to rewrite the=
 IP protocol of an incoming TCP packet to IPPROTO_UDP after early demux has=
 attached a struct tcp_sock. The packet will then be routed to udp_rcv(), w=
hich calls skb_steal_sock() and bypasses the check.
- [High] The protocol validation in skb_steal_sock() prevents mismatches li=
ke UDP sockets on TCP packets, but fails to prevent type confusion with RAW=
 sockets. A RAW socket can be created with an arbitrary protocol (e.g., soc=
ket(AF_INET, SOCK_RAW, IPPROTO_TCP)). Because the patch only verifies sk->s=
k_protocol against the expected protocol without checking sk->sk_type, a ma=
licious BPF program can assign a RAW socket to a TCP packet. The receive pa=
th will then dangerously cast the raw_sock to a tcp_sock, causing out-of-bo=
unds access and kernel panics.
--

commit 5523558843e68f090fac91db8bdd58ed67db17e4
Author: Jiayuan Chen <jiayuan.chen@linux.dev>
net: Validate protocol in skb_steal_sock() for BPF-assigned sockets

This commit adds protocol validation in skb_steal_sock() to reject mismatch=
ed
sockets, preventing malicious BPF programs from causing kernel panics by
assigning incorrect socket types to packets. It updates various callers to
pass their expected protocol during the socket steal operation.

Link: https://lore.kernel.org/bpf/20260403015851.148209-1-jiayuan.chen@linu=
x.dev/
Link: https://sashiko.dev/#/patchset/20260403015851.148209-1-jiayuan.chen%4=
0linux.dev

> diff --git a/include/net/request_sock.h b/include/net/request_sock.h
> --- a/include/net/request_sock.h
> +++ b/include/net/request_sock.h
[ ... ]
> @@ -103,6 +105,18 @@ static inline struct sock *skb_steal_sock(struct sk_=
buff *skb,
> =20
>  	*prefetched =3D skb_sk_is_prefetched(skb);
>  	if (*prefetched) {

[Severity: Critical]
This is a pre-existing issue, but does wrapping the validation inside the
prefetched check leave early demux sockets vulnerable?

Sockets assigned via TCP early demux evaluate prefetched to false because
their destructor is sock_edemux. An attacker could use a Netfilter rule at
the NF_INET_LOCAL_IN hook to rewrite the IP protocol of an incoming TCP
packet to IPPROTO_UDP after early demux has attached a tcp_sock.

The packet would then be routed to udp_rcv(), which calls skb_steal_sock()
and bypasses the validation entirely since prefetched is false. This could
allow the UDP receive path to operate on a tcp_sock, potentially leading to
memory corruption or arbitrary execution via overlapping fields like
encap_rcv.=20

Should the protocol validation be moved outside of this check?

> +		/* A non-full socket here is either a reqsk or a
> +		 * timewait sock, both only contain sock_common and
> +		 * lack sk_protocol. Since both can only be TCP,
> +		 * use IPPROTO_TCP as the protocol.
> +		 */
> +		if (unlikely(((sk_fullsock(sk) ? sk->sk_protocol : IPPROTO_TCP) !=3D p=
rotocol))) {

[Severity: High]
This is a pre-existing issue, but does checking only sk_protocol without
verifying sk_type allow type confusion with RAW sockets?

A RAW socket can be created with an arbitrary protocol, such as
socket(AF_INET, SOCK_RAW, IPPROTO_TCP). If a BPF program assigns this RAW
socket to a TCP packet, the sk_protocol check will pass, but the receive
path will dangerously cast the raw_sock to a tcp_sock.

Since raw_sock and tcp_sock have completely different layouts, could this
lead to out-of-bounds accesses and kernel panics when the TCP stack tries
to use it? Does sk_type also need to be validated here?

> +			skb_orphan(skb);
> +			*prefetched =3D false;
> +			*refcounted =3D false;
> +			return NULL;
> +		}
> +
>  #if IS_ENABLED(CONFIG_SYN_COOKIES)
>  		if (sk->sk_state =3D=3D TCP_NEW_SYN_RECV && inet_reqsk(sk)->syncookie)=
 {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608125846.1570=
04-1-jiayuan.chen@linux.dev?part=3D1
