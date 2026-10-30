Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793336071;
	b=uC831iLh8Bn5mc7dIb9nUSatFYX7AzkoNJOeqQPknrbI7xhBe6brZF6LMHhW5rduZuH7
	 +4+ZuhYKnzsIiAyd3GYQVEqX1B0S/BrZFF5w5w8hEWjpTmB9D37qGw84NFmwxFUwiz547
	 Buzju+3qwcdy2hzH98/P01oq4c3I5Gkz6gpFBJn2SnDkUZ+4hBbPNvHSbUEMn52ZWC8ey
	 LSiVnhqA3eVMZ2Di2LfK4VpuT02JtFmwup4l5TjV2OLFUKpziVN0XEfxFj9uTbAUmOIUx
	 4m1elHEY+QuVcCunN/6QCnKemn13TlMOAJiQx9QNoOs2Yz3NFwDBnefuaM3tDfcCRyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793336071;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lnaRr1x2pXORJ8K5W4iu6OOkUasvS073P3gMyN9X08E=;
	b=eWVJmmm8i7hQFhKl6TeW8RgPpsvQI/Np3e53Qo4oyLTEpM/uHvF0qt8syK/VwWO+SIDo
	 4RUBe4LM5Bdfjmw4dCX4HklHI1iQC+40Ur9V7DdTUJfk+RxzOS5ffTe99lb82p9Vdq611
	 AKB2XEkC1QSi7cxy3RjgzkM2nw2tldHCfPy7O29JUh3eNC0Tou/J0Pkp3M/QKVZd9XKEO
	 3FDZoJ2s1J+D0r9Jon/aGoXYr2yfNMkrCaQeZthVFdxDt8RnsnChHZg6D9686Z7iaoZ57
	 IGsY+IbH6PpsmN1nAX1Pu2WNE05fgcC6PxqJ7YOQ0EAfpkbmZv7Yq3LzT7rkptaCotA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQPNpZJv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053D3606A31D
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eQPNpZJv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758781F000C1;
	Fri, 30 Oct 2026 04:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793336070;
	bh=lnaRr1x2pXORJ8K5W4iu6OOkUasvS073P3gMyN9X08E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eQPNpZJv/VxN1Ba1CNeipTxRF8KypgM4qNw8tgJSDtORk8sXtKKB8BTQUjYuarSL7
	 JXrHiIcCiDvyW64+IZS21d6OD6nt6XPO/vjRCfpDhfFlCaZV1dl7KecufOh3BZ9w/u
	 8Jz7y5Ko/G02skaCm6fqhB4u6H8uluczSQGfo88w74NnCNXg2FjKbzBLlIJP13ib+u
	 JHQuR1i+jj+BKvugirlokzW9aDXn5wdsqhNCS+Df19IMWyblV8K3eXluM8d2NKWzHu
	 KY1xh7vcnOacoap7T0C8WcESJqqifE4BOfHQf6djXc+uxe2EyDcbVy1i8RJmegq+c7
	 G7+PUgwyjkX6A==
Message-ID: <sashiko-outbox-190470@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/13 RFC net-next] net: tcp: move protocol agnostic TCP
 functions out of tcp_ipv4.c
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fernando Fernandez Mancera" <fmancera@suse.de>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260712013941.4570-5-fmancera@suse.de>
References: <20260712013941.4570-1-fmancera@suse.de>
 <20260712013941.4570-5-fmancera@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 04:54:30 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Disabling CONFIG_IPV4 completely hides `/proc/net/sockstat` and =
`/proc/net/snmp`, causing a total loss of global TCP memory and SNMP metric=
s.
- [Low] Unused static structs `ipv6_mapped` and `tcp_sock_ipv6_mapped_speci=
fic` trigger `-Wunused-variable` and cause undefined references when `CONFI=
G_IPV4` is disabled.
--

--- Patch [4]: [PATCH 04/13 RFC net-next] net: tcp: move protocol agnostic =
TCP functions out of tcp_ipv4.c ---
commit 75343bf3b73e175ff640d8d0645b680b7c8368bd
Author: Fernando Fernandez Mancera <fmancera@suse.de>
Subject: net: tcp: move protocol agnostic TCP functions out of tcp_ipv4.c

This patch moves generic TCP functions out of tcp_ipv4.c into tcp.c to allow
compilation with CONFIG_IPV4=3Dn. It renames tcp_v4_destroy_sock() to
tcp_destroy_sock() to reflect its shared usage and guards IPv4-specific
code in the IPv6 TCP implementation.

> diff --git a/net/ipv4/proc.c b/net/ipv4/proc.c
> index bfc06d1713ecb..b7f4e5ecf64d8 100644
> --- a/net/ipv4/proc.c
> +++ b/net/ipv4/proc.c
> @@ -50,6 +50,7 @@
>   */
>  static int sockstat_seq_show(struct seq_file *seq, void *v)
>  {
> +#if IS_ENABLED(CONFIG_IPV4)
>  	struct net *net =3D seq->private;
>  	int orphans, sockets;

[Severity: Medium]
By guarding the entire body of sockstat_seq_show() with CONFIG_IPV4, does
this completely hide the output of /proc/net/sockstat when IPv4 is disabled?

Looking at inet_init() in net/ipv4/af_inet.c (around line 2062), the call to
ipv4_proc_init() is already bypassed entirely when CONFIG_IPV4=3Dn. This me=
ans
ip_misc_proc_init() is never called to register the sockstat and snmp procfs
files in the first place.

Since the IPv6 equivalents (sockstat6 and snmp6) do not report shared TCP
global metrics, does this unintentionally leave administrators without
visibility into global TCP memory limits (like orphans and allocated socket=
s)
and TCP SNMP metrics?

> diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> index ebe161d72fbd0..7f2ec3dfd2f07 100644
> --- a/net/ipv6/tcp_ipv6.c
> +++ b/net/ipv6/tcp_ipv6.c
> @@ -217,6 +217,7 @@ static int tcp_v6_connect(struct sock *sk, struct soc=
kaddr_unsized *uaddr,
>  	 */
> =20
>  	if (addr_type & IPV6_ADDR_MAPPED) {
> +#if IS_ENABLED(CONFIG_IPV4)
>  		u32 exthdrlen =3D icsk->icsk_ext_hdr_len;
>  		struct sockaddr_in sin;

[Severity: Low]
With this CONFIG_IPV4 guard, the references to ipv6_mapped and
tcp_sock_ipv6_mapped_specific inside tcp_v6_connect() are compiled out.

However, the definitions of these static structs at lines 2055 and 2068
in net/ipv6/tcp_ipv6.c are left unguarded. Could this trigger compiler
warnings for unused variables when CONFIG_IPV4 is disabled?

Furthermore, because these structs reference IPv4-specific functions like
tcp_v4_md5_lookup, could this result in undefined reference linker errors
if the compiler does not fully discard the unused structs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712013941.4570=
-1-fmancera@suse.de?part=3D4
