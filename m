Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB28F318146
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 10:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789985263; cv=none; b=BphgpdKi4RlOETNY83jD/+tWMOy39lj7shmq86Ll6KJGIwgyE+eA4AolYP9gtQMJ3MmMwmeCzh8x3xlQ3y3Em6gb0pKOaE6b8r8HrQyJInE38wEnbzBHSJKcf5N07kyXhVJRYfg0183gifznl4B8yd3lb/C1uTpEtnEKMpEuenA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789985263; c=relaxed/simple;
	bh=8EsRu5SgbU6BrRmG1fjYUk+QXy2eVr8PXPXFExgBezc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=htG1qlqW+vAn0wEwagqnqiya1rD0Iq3IZvcbZU+SPkCqfkz6LS/mxET5hXFENphCtTHcI4MSmQRchl9yQ4zVvIBmsu0jHpnlpYTIoiVBd9BFLiUNE2shggOobPkek7rSIi6GUptSLqr0LOYHRAvo0WFgdY3ngXQdOJ6vQpgiDmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lqjhmfrt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lqjhmfrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DF2E1F000FF;
	Mon, 21 Sep 2026 10:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789985262;
	bh=dVENwTzVei36fMOF4Z86OYJA3B+/DIrzQzwnp6Pw1c8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LqjhmfrtYWg41Mc80ELSQXPTcjPFXav4G0g0CeQ00ZId6icFJ61d4rJW/nghPOJRz
	 3v5a0UY05QTfzhCwrGOMruPopaANKh4wyGqCnMUG8WCuYZ5jgmt2Gw8gwzQ05iagz6
	 0k9gjHZo0VR0b2x6O3kaM/SpeTVcGTanqKmKVoDOpoWZdB0EU4CaHnKPYkN+sxX927
	 klOVLF1i8CQy4qNPsRU2xBiudmv7HfjRwQZs/1bYqGZeQNcA1VClNdrneQW5o6KwzN
	 VbOyoSmJjoDK9D2q+8qsrDGbIsCG4weRLqfrw4Jeho2Gj96hiPAWgUg5JwfJ4ecMbz
	 vtMTm5ljRqf8A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 4/6] netlink: specs: rt-route: describe
 lwtunnel IP options
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260920-ynl_rt_encap-v2-4-c664a3e726f6@kylinos.cn>
References: <20260920-ynl_rt_encap-v2-0-c664a3e726f6@kylinos.cn>
 <20260920-ynl_rt_encap-v2-4-c664a3e726f6@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 10:07:41 +0000
Message-Id: <20260921100742.3DF2E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] netlink: specs: missing multi-attr: true for geneve array in rt-=
route
--

commit feeb3960dd5418925dfc5011791a483d8533a2c6
Author: Hangbin Liu <liuhangbin@kylinos.cn>

netlink: specs: rt-route: describe lwtunnel IP options

Replace binary opts in lwtunnel-ip and lwtunnel-ip6 with a nested
lwtunnel-ip-opts set. Add attribute sets for geneve, vxlan, and erspan
IP options to match linux/lwtunnel.h.

> diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/ne=
tlink/specs/rt-route.yaml
> index 86fc52f856bff..4b12a8a586521 100644
> --- a/Documentation/netlink/specs/rt-route.yaml
> +++ b/Documentation/netlink/specs/rt-route.yaml
[ ... ]
> @@ -560,6 +562,62 @@ attribute-sets:
>        -
>          name: link
>          type: u32
> +  -
> +    name: lwtunnel-ip-opts
> +    name-prefix: lwtunnel-ip-opts-
> +    attributes:
> +      -
> +        name: geneve
> +        type: nest
> +        nested-attributes: lwtunnel-ip-opt-geneve

[Severity: Medium]
Will auto-generated userspace Netlink libraries fail to generate requests
with multiple GENEVE options?

The kernel strictly expects multiple distinct LWTUNNEL_IP_OPTS_GENEVE nests
on the request path to configure multiple options. This is parsed via
nla_for_each_attr() in ip_tun_parse_opts():

net/ipv4/ip_tunnel_core.c:ip_tun_parse_opts() {
    ...
		case LWTUNNEL_IP_OPTS_GENEVE:
			if (type && type !=3D IP_TUNNEL_GENEVE_OPT_BIT)
				return -EINVAL;
			opt_len =3D ip_tun_parse_opts_geneve(nla, info, opts_len,
							   extack);
    ...
}

Without multi-attr: true, auto-generated clients will treat the geneve
attribute as a singular scalar nest (max-items: 1) and restrict requests
to a single option.

Should this attribute specify multi-attr: true to avoid a functional regres=
sion
in expressiveness compared to the legacy binary type?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920-ynl_rt_enc=
ap-v2-0-c664a3e726f6@kylinos.cn?part=3D4
