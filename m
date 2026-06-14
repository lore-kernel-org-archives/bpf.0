Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D202B175A9A
	for <bpf@vger.kernel.org>; Sun, 14 Jun 2026 08:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781424529; cv=none; b=OuQJ/ndMt5tDFHUckU0gvzi//1T9puxdn0tpMQzmxVIgXRZsOKwMGam5dfsuJknXoz46Bt4sIfd0RMrhnlJSNtY09pIEl9xLqCnU0q6P8kSQm67+w1exjDxk4UOuxVPCRQ0BTOvgIE03gSaHOka6x5gVv5swgSJIOrcQn+aOfmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781424529; c=relaxed/simple;
	bh=SruTDzHrszRAg/xVHGqD5ga3V+s8LHPqWRHNHiV3L88=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G7a6tUlCguDJrHCHPl46zN8ue8FApS+miVwUBcIa0RkGEeCCC5PKj+v+gnGZzxfpGJntj3Nj4faW24UTtY3oDJKrzmc6GAtbuRBD1MxJjF5Js2IA0dQ+WXRONAjZc1TIppSI9Dwh3oAjDP8S3LqquwD40bdQqJoZOLYGDv8L4mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KK/JAdsL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KK/JAdsL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0AD1F000E9;
	Sun, 14 Jun 2026 08:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781424528;
	bh=OnUxKiZshxBkLPX3biqZ4f5Bf6tBYllnsryPB7ZEENg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KK/JAdsLP/VcLYJ+LNV7wJ+BxGF7k74l3f9zJ8WjBhTGHQ7V3Ra4sQEpKinuUx+L3
	 IgPlhoxroBgV3BNJ/J4AUbGizrU9JRkXF/SSlU/brKVk5D4k7J/CdB/ScNK25HuRvX
	 5g4KopRXryr41fBkfSsIZYfu1GDWewifSA79irQLmdOaipacX3RN6depNuQIpeRI1z
	 3BbfnRjCwAbTH9VmNsUE2IcU6fMCGO/EWn9SEq5q/ezHvOf3j2PY6eYjaR20A4WZBl
	 F/gmtMXQT+6tCzI+rSHqAW/EQdzl2/h4E+/vM2o2rVxyiqli6t91UCbgiJ09UWhGsh
	 oPf3TRDGklnBg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 net-next 1/1] tcp: Replace min_tso_segs() with
 tso_segs() CC callback for TCP Prague
Reply-To: sashiko-reviews@lists.linux.dev
To: chia-yu.chang@nokia-bell-labs.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260613080831.236636-1-chia-yu.chang@nokia-bell-labs.com>
References: <20260613080831.236636-1-chia-yu.chang@nokia-bell-labs.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 14 Jun 2026 08:08:47 +0000
Message-Id: <20260614080848.3B0AD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing validation for `mss_now` in the `bbr_tso_segs` BPF kfunc a=
llows a divide-by-zero kernel panic.
- [Low] Missing EXPORT_SYMBOL for tcp_tso_autosize causes a build failure w=
hen tcp_bbr is compiled as a module.
--

commit 44d0693bc14ccae351456d523fdf83240793c554
Author: Chia-Yu Chang <chia-yu.chang@nokia-bell-labs.com>

tcp: Replace min_tso_segs() with tso_segs() CC callback for TCP Prague

This patch replaces the min_tso_segs() callback with a tso_segs() callback
to provide an explicit TSO segment number for each data burst, overriding
tcp_tso_autosize().

> diff --git a/net/ipv4/tcp_bbr.c b/net/ipv4/tcp_bbr.c
> index 82378a2bfd1e1..15536564246c0 100644
> --- a/net/ipv4/tcp_bbr.c
> +++ b/net/ipv4/tcp_bbr.c
[ ... ]
> @@ -297,11 +297,19 @@ static void bbr_set_pacing_rate(struct sock *sk, u3=
2 bw, int gain)
>  }
> =20
>  /* override sysctl_tcp_min_tso_segs */
> -__bpf_kfunc static u32 bbr_min_tso_segs(struct sock *sk)
> +static u32 bbr_min_tso_segs(struct sock *sk)
>  {
>  	return READ_ONCE(sk->sk_pacing_rate) < (bbr_min_tso_rate >> 3) ? 1 : 2;
>  }
> =20
> +__bpf_kfunc static u32 bbr_tso_segs(struct sock *sk, u32 mss_now)
> +{
> +	u32 min_tso;
> +
> +	min_tso =3D bbr_min_tso_segs(sk);
> +	return tcp_tso_autosize(sk, mss_now, min_tso);

[Severity: High]
Does this code allow a division by zero panic?

The BPF verifier does not enforce positive non-zero bounds on plain scalar
arguments. If a BPF program passes 0 for mss_now to bbr_tso_segs(), it is
passed unvalidated to tcp_tso_autosize(), where it is used as a divisor:

net/ipv4/tcp_output.c:tcp_tso_autosize() {
    ...
    return max_t(u32, bytes / mss_now, min_tso_segs);
}

This executes a division by zero, causing an immediate kernel panic. While
BPF programs require privileges, crashing the kernel via a kfunc violates
BPF safety guarantees.

> +}
> +
>  static u32 bbr_tso_segs_goal(struct sock *sk)
>  {
>  	struct tcp_sock *tp =3D tcp_sk(sk);
[ ... ]
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 26dd751ec72ab..14fde0aa14beb 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -2253,8 +2253,8 @@ static bool tcp_nagle_check(bool partial, const str=
uct tcp_sock *tp,
>   * for every 2^9 usec (aka 512 us) of RTT, so that the RTT-based allowan=
ce
>   * is below 1500 bytes after 6 * ~500 usec =3D 3ms.
>   */
> -static u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
> -			    int min_tso_segs)
> +u32 tcp_tso_autosize(const struct sock *sk, unsigned int mss_now,
> +		     int min_tso_segs)

[Severity: Low]
Does this cause a build failure when tcp_bbr is compiled as a loadable modu=
le?

Because tcp_tso_autosize() is called from bbr_tso_segs() in tcp_bbr.c but
does not have an EXPORT_SYMBOL or EXPORT_SYMBOL_GPL declaration, building
CONFIG_TCP_CONG_BBR=3Dm will fail with an undefined symbol error during mod=
post.

>  {
>  	unsigned long bytes;
>  	u32 r;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260613080831.2366=
36-1-chia-yu.chang@nokia-bell-labs.com?part=3D1
