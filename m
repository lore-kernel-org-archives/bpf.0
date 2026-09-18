Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B41547050
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789713417; cv=none; b=KWcMg/TNTjzlNP4y2I6QsmhyrK/CfFC9RPGNd+rMVhse6GTNfYZeNx0/+k72jDby7PZoIj0/i+XFsCh0h5cNKJRhJfMNfCtyBNfXDkXfvz9GZzbmk45OwppBi756E0Oj/qXkTITcFeyQ/6UURgfbmLWjbjY16do64ObB63Hoxt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789713417; c=relaxed/simple;
	bh=GZgjhgCaPmeJ/yCejezOTr4NoMOBskUwUa3CN8tqc7s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YHA0JZRZJD8CTcdOg7PLFPVkN5XbYu7mQ9ALaxOO8lDfLl+3+Ekh1EbqCpa6JbyRIWmhinQBCbNKZFyzgdd4N8PLjPAKx3DKQGTpYlG/+T7bBrxLDY0BS8s3G7BPb0VOlNK6ZFhxL3kJKQr7Bd9YKa38KT1O+mkT54cRvylS7Ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLp8pjsG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLp8pjsG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418681F000FF;
	Fri, 18 Sep 2026 06:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789713415;
	bh=q9Tun4Fd5OGAQwWeKDRPX/cD/T7g7hF3l2+5KMH7lY4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NLp8pjsGcn0hVzNv3gCRvexXi5a0Ui9U8cQbSdL0KLwiB8ourEqc5+I2m2zfNVE8G
	 omHvPxl0RfVFcaDsB4NI699HTBQUt9naH7HS+gdGwrPGQlGiF/BcihN7wgqGsr3b9t
	 4hVt3sAMOoRj8DFCq3tDRxp0Ll6kwfrZl660V1UVFcYV9ZnrWQyhDDiTZFDCHi9fNM
	 WIWAII7HInlnTLVIW7Y0ENkYwpoIqCYWRVQz+OMeVVwbM5HaRGgFjMWf4U3VyNc+22
	 IGZLLwzAbgNXwvh1n7ZY2AUcDBmyK9xoh29mNlQwpYE9ng0lVerAXNk1PkXRFzRB60
	 0iL6UPNuE+uwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 1/6] net: lwtunnel: change encap fill order
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hangbin Liu" <hangbin.liu@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260917-ynl_rt_encap-v1-1-fbbe6e680571@kylinos.cn>
References: <20260917-ynl_rt_encap-v1-0-fbbe6e680571@kylinos.cn>
 <20260917-ynl_rt_encap-v1-1-fbbe6e680571@kylinos.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 06:36:54 +0000
Message-Id: <20260918063655.418681F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] net: lwtunnel: incomplete rollback on fallback path leaves orpha=
n RTA_ENCAP_TYPE
--

commit b32da4e3fb34d0c2a7a1afb438a76ca410be21ec
Author: Hangbin Liu <liuhangbin@kylinos.cn>

net: lwtunnel: change encap fill order

This commit changes the order in which lwtunnel netlink attributes are
emitted. It places the encap_type_attr before the encap_attr nest to
ensure userspace YNL can decode the sub-messages correctly.

> diff --git a/net/core/lwtunnel.c b/net/core/lwtunnel.c
> index b01a395d9a966..f13dfa02e026e 100644
> --- a/net/core/lwtunnel.c
> +++ b/net/core/lwtunnel.c
> @@ -240,6 +240,10 @@ int lwtunnel_fill_encap(struct sk_buff *skb, struct =
lwtunnel_state *lwtstate,
>  	    lwtstate->type > LWTUNNEL_ENCAP_MAX)
>  		return 0;
> =20
> +	ret =3D nla_put_u16(skb, encap_type_attr, lwtstate->type);
> +	if (ret)
> +		return ret;
> +
>  	nest =3D nla_nest_start_noflag(skb, encap_attr);
>  	if (!nest)
>  		return -EMSGSIZE;
> @@ -254,9 +258,6 @@ int lwtunnel_fill_encap(struct sk_buff *skb, struct l=
wtunnel_state *lwtstate,
>  	if (ret)
>  		goto nla_put_failure;

[Severity: Medium]
Does this leave an orphaned attribute in the buffer on the fallback path?

If ops->fill_encap is unsupported, it evaluates to -EOPNOTSUPP and execution
jumps to nla_put_failure:

net/core/lwtunnel.c:lwtunnel_fill_encap() {
...
nla_put_failure:
	nla_nest_cancel(skb, nest);

	return (ret =3D=3D -EOPNOTSUPP ? 0 : ret);
}

Because nla_put_u16() was moved before nla_nest_start_noflag(),
nla_nest_cancel() only unwinds the buffer up to the start of the nest.
This leaves the encap_type_attr orphaned in the skb payload.

Since the function returns 0 (success) in the -EOPNOTSUPP case, the caller
is prevented from discarding the message, which results in a malformed
netlink message being sent to userspace.

Could we record the skb tail pointer before nla_put_u16() and restore it on
failure, or is there another preferred way to unwind the encap_type_attr?

>  	nla_nest_end(skb, nest);
> -	ret =3D nla_put_u16(skb, encap_type_attr, lwtstate->type);
> -	if (ret)
> -		goto nla_put_failure;
> =20
>  	return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260917-ynl_rt_enc=
ap-v1-0-fbbe6e680571@kylinos.cn?part=3D1
