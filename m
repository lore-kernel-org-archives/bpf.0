Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0A447A87A
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 14:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051497; cv=none; b=uRW8HbUQ6wtRk88leTI4viTTYbDUfLkyQuzWE7Q/3L9T4HThKOYaUzJ3NMP219wdyb2PWumhg6/9/0SL9Dnrwa0QF3+BzsqKPyRW9SAEyBOE2Tq7wuAWcLB94VXEvvFxtvACRTwyc+XI+W2FhDRfv1Hw3PGtdvXKP52Zh1AQ3ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051497; c=relaxed/simple;
	bh=Dy8Z803XDfghR8/4ba3+M6AxpqqfANzGJm5UtJe3DVU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=digOMQztDVv107YeFmWdUdrjeUF6nmJiGQH3FklCZ09CC33s+OiemipElQ2f3X/QNDlm6DsY7WB40Z7KepsnMEmycKYz9V+w8SwPOP3s9/FgD7WFzT9AvcmKETHrEv0NVT1sVPUBC119u2rFXbJDohNBHYHP48ZGM8JXBQvdwig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbHLiNpG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbHLiNpG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7751F00893;
	Thu, 10 Sep 2026 14:44:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789051496;
	bh=o+NF4No6PjdHpjmQXfk++Obe57M5syCSgj5vN2Spl5Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TbHLiNpGMEjCfGjdfpOYJfzZux9O4wHvufmlh5akc3aGG7Ru5wIrurlsrMMs9xdwy
	 rTJeV+xreD40ikl7168rlX80eoPIq/dL6infgWBX320KTGXQ59qVv7lu1gvFe5jVJu
	 ix591yyq9AP50YpFlpJ+IA/zXvRYQOA2YcFj8zk06dzbz1w3SRja3E8XEyYZ9c2egB
	 K5+nHS4u8mDUOke3nwxMT89PQk3hE3v661QpGsUC8jppIGyRGnroa0eWA4v6CQzYIq
	 LuLgzXFP4PcCLnu3rKFN55sqbRiS1ma5sdbfW0tUxz6TjhY8VLUBVADw80vmkvyoL7
	 xkCsVIf8J8EJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] tcp: add TCP_ECN and TCP_ECN_OPTION socket
 options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Irlanki Sandeep" <irlanki.s@samsung.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260909144557.800676-1-irlanki.s@samsung.com>
References: <CGME20260909144437epcas5p282be513a761ca5aec3f2b0fefcd2ecfa@epcas5p2.samsung.com>
 <20260909144557.800676-1-irlanki.s@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 14:44:55 +0000
Message-Id: <20260910144455.CA7751F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Per-socket TCP_ECN configuration is ignored during SYN floods beca=
use syncookies validation checks the global sysctl instead of the listener =
socket's effective ECN mode.
- [Medium] Missing READ_ONCE() when reading `ecn_mode` and `ecn_option` int=
roduces a data race and double-fetch vulnerability, leaking the UNSPEC plac=
eholder (255) into TCP operational logic.
--

commit d87f9153f9de86df8e7de5798f8dffdac8f0e2fd
Author: Irlanki Sandeep <irlanki.s@samsung.com>
Subject: tcp: add TCP_ECN and TCP_ECN_OPTION socket options

This patch introduces granular, per-connection dynamic adaptation for ECN a=
nd
AccECN configurations. It adds two new socket options, TCP_ECN and
TCP_ECN_OPTION, which override the system-wide sysctl settings to prevent
connection failures or packet loss on paths with anomalous middleboxes.

> diff --git a/include/net/tcp_ecn.h b/include/net/tcp_ecn.h
> index 865d5c5a7718d..931e0877176c7 100644
> --- a/include/net/tcp_ecn.h
> +++ b/include/net/tcp_ecn.h
[ ... ]
> @@ -30,8 +31,29 @@ enum tcp_accecn_option {
>  	TCP_ACCECN_OPTION_MINIMUM =3D 1,
>  	TCP_ACCECN_OPTION_FULL =3D 2,
>  	TCP_ACCECN_OPTION_PERSIST =3D 3,
> +	TCP_ACCECN_OPTION_UNSPEC =3D 255,	/* Use sysctl default (per-socket) */
>  };
> =20
> +/* Resolve the effective ECN mode: per-socket override or sysctl fallbac=
k */
> +static inline u8 tcp_ecn_mode_eff(const struct sock *sk)
> +{
> +	u8 mode =3D tcp_sk(sk)->ecn_mode;
> +
> +	if (mode =3D=3D TCP_ECN_MODE_UNSPEC)
> +		return READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn);
> +	return mode;
> +}

[Severity: Medium]
Is it possible for the compiler to double-fetch tcp_sk(sk)->ecn_mode here?

Since the ecn_mode field is updated concurrently via WRITE_ONCE() (for
example, during a setsockopt call while handling an incoming SYN packet in
softirq context), a lack of READ_ONCE() on the reader side could result in
the UNSPEC placeholder (255) leaking into the return evaluation.=20

If that placeholder leaks, could it cause AccECN to be incorrectly enabled=
=20
later in tcp_ecn_create_request(), where 255 >=3D 3 would evaluate to true?

> +
> +/* Resolve the effective AccECN option: per-socket override or sysctl fa=
llback */
> +static inline u8 tcp_accecn_option_eff(const struct sock *sk)
> +{
> +	u8 opt =3D tcp_sk(sk)->ecn_option;
> +
> +	if (opt =3D=3D TCP_ACCECN_OPTION_UNSPEC)
> +		return READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_ecn_option);
> +	return opt;
> +}

[Severity: Medium]
Does tcp_sk(sk)->ecn_option also require a READ_ONCE() here to prevent a=20
similar data race and double-fetch?

[ ... ]
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 0f60a1dbf9274..b7dea787f8237 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -7463,7 +7463,7 @@ static void tcp_ecn_create_request(struct request_s=
ock *req,
>  	u32 ecn_ok_dst;
> =20
>  	if (tcp_accecn_syn_requested(th) &&
> -	    (READ_ONCE(net->ipv4.sysctl_tcp_ecn) >=3D 3 ||
> +	    (tcp_ecn_mode_eff(listen_sk) >=3D 3 ||
>  	     tcp_ca_needs_accecn(listen_sk))) {
>  		inet_rsk(req)->ecn_ok =3D 1;
>  		tcp_rsk(req)->accecn_ok =3D 1;

[Severity: High]
Does the SYN cookies path also need to be updated to respect this new=20
per-socket configuration?

During a SYN flood, this standard tcp_ecn_create_request() path is bypassed
in favor of syncookies. Currently, cookie_v4_check() and cookie_v6_check()=
=20
determine ECN support by calling cookie_ecn_ok(), which only checks the
global sysctl:

static inline bool cookie_ecn_ok(const struct net *net, const struct dst_en=
try *dst)
{
        return READ_ONCE(net->ipv4.sysctl_tcp_ecn) ||
                dst_feature(dst, RTAX_FEATURE_ECN);
}

If the system has the global sysctl_tcp_ecn disabled but a service has
enabled it locally via TCP_ECN on its listener socket, will established
connections silently lose their ECN capability during a SYN flood?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909144557.8006=
76-1-irlanki.s@samsung.com?part=3D1
