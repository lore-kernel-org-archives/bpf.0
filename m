Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792795195;
	b=t5EmmncvPjHclo1ea+CmDcGeXbJGzbp1FfD3qzCJMLZS5JYX0Z8C/rVDTId2ZU6MoACo
	 OYA+DFPW5AICetg1ePHLDkDnYus4CrT+mGmy9CYH/W9yz+7E1jOF3z5VHWgLjzuQraj0/
	 2DZTg9hyuDlpuBDHh+m7OB7uuK44hV6wAjx371dYHtOEG6xz0l2VXdwGaKHXTcQ/wxuue
	 MVy43ud5LuhtOVboW8K2tMJ3DJgeuTRSWfeSxUIJxtGjdwj+0f5nQg5jUIRiEhiI7IYfk
	 p5WPn26I0gnz7KdkSKKmxTiRx1ZSa78LkoQDY/XADzIiS9HhnRq0NmBqKhOlDU9nmDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792795195;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MIiAtjEErB3ya4h+aFmQeF8V9i1u1wWUI7h5Xtk8D/4=;
	b=LynocyAIBtjMjzIpkwwZaP0n7Gv+eVxgmgaHbG7/3W82OC0FBNElB3sfv4A2+dDr/Z3A
	 V4H3KBwNFJN8Dy7mPBCIbIo63GVHWjcBRSlCrwSR/nBGJUaUNunUKuv5ZVvpmeV5sHlaw
	 19HDzU2YU7zpg1T0yDOD32nkc8Y4IVOql63WEXfNcUQsItgEx9YNLsEmpAiGHSVPC2r0A
	 Aq6vRvG/weWeyzLByGvYW5IX0DrFjvJQjBdXmRKsvaSUq3EWnYn80X0GXJN81LzS99MVN
	 Dn74y9BPcc1lQ+aUgyZNxefX/nIhifsmWCTGpniLNx3s1rTQw9vM2G3T/Dg/mFO/83w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqVlhxkW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827C7606A31A
	for <bpf@vger.kernel.org>; Fri, 23 Oct 2026 22:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IqVlhxkW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE6021F031E1;
	Fri, 23 Oct 2026 22:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792795195;
	bh=MIiAtjEErB3ya4h+aFmQeF8V9i1u1wWUI7h5Xtk8D/4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IqVlhxkWx1vTlYO+TEdWPppsVlMV5k6VNwwjOPvt/EXCh/HL1xOjgnIIQ60wZmgTD
	 +iP2yi2FhJ7n0fnKXrFTng1nN4qTk17oMXNogNByupo6vALfQn55upMQLnmdfD4hG3
	 aFfCfsFk+sj9Dgli4cQ9w8u/kFk9vRVwXwPDuYmtKSgpLA7RVqtYx3EKL8wOjnZIVn
	 krczVc60utYaQkfX3TbiEqLEy07RCrqGiCT05bzGkZamX391ZBU6NbhRv5uIPOuH7O
	 oEetpECiaU4KBsZffYGjyNqlDN8q/wNwhNZHVGow1zIapE7t0a73riWP/iy9NwvvX+
	 OeUngPWOKH6pA==
Message-ID: <sashiko-outbox-183298@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/8] libbpf: Look up BTF strings without
 making BTF modifiable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ihor Solodrai" <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261023222652.3927736-2-ihor.solodrai@linux.dev>
References: <20261023222652.3927736-1-ihor.solodrai@linux.dev>
 <20261023222652.3927736-2-ihor.solodrai@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 22:39:54 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] libbpf: non-standard multi-line comment style in struct btf
--

commit 0c3dbaeec612c1bd0bf2896a8ba4e0a1a8431c92
Author: Ihor Solodrai <ihor.solodrai@linux.dev>

libbpf: Look up BTF strings without making BTF modifiable

This patch updates btf__find_str() to build the string lookup index via a
new btf_ensure_strs_set() helper without making the BTF instance
modifiable, and updates btf__free() to unconditionally free strs_set.

> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index d2ff6f5d6d5b6..d8907281c0efd 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -153,9 +153,9 @@ struct btf {
>  	 */
>  	int start_str_off;
> =20
> -	/* only one of strs_data or strs_set can be non-NULL, depending on
> -	 * whether BTF is in a modifiable state (strs_set is used) or not
> -	 * (strs_data points inside raw_data)
> +	/* strs_data points inside raw_data until BTF becomes modifiable,
> +	 * then strings live in strs_set. Before that, strs_set may exist
> +	 * as a lookup index for btf__find_str().
>  	 */

[Severity: Low]
In struct btf in tools/lib/bpf/btf.c, should the opening /* of this
multi-line comment be placed on its own line to follow the BPF comment
style?

	/*
	 * strs_data points inside raw_data until BTF becomes modifiable,
	 * then strings live in strs_set. Before that, strs_set may exist
	 * as a lookup index for btf__find_str().
	 */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023222652.3927=
736-1-ihor.solodrai@linux.dev?part=3D1
