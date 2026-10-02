Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBF04734E5
	for <bpf@vger.kernel.org>; Fri,  2 Oct 2026 09:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790932470; cv=none; b=OQx5joD3nBERlTAzN34nVDEEOAy8paxk85OAI9whUQvRNypj74xtQ9y9vAmSt2l8Ydftu9EQVrqt8aqom7y/aOHD2nlr0ZeV5T1p/fZjVJ+E1ck30ofN9uLda7XZDraPoWd5EuS2j6F8pPKa2lmmnM47bjSSo/WWsf1ujBN//Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790932470; c=relaxed/simple;
	bh=5rJsBMw7vDKWCs2PxnIex87WPIuK+P1IZxA6+fyNWBs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Kh7+Ss/HdvahTqMMfV/i48h8G61ST8J6Nlu7VEQ8YrioTByh5PBvl4k1aptG7FbNtMrr+CAV5Zzj3szQ+XwoA4g3lul9Mvfh12X2qDzv5UAQzE0FbUaR8yTrcR0aXHm8RfC1g5XQScB0Kdaf/IgeUUXIaN7I1XUWLBou5yiVw2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OYgPm+Bs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OYgPm+Bs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041811F000FF;
	Fri,  2 Oct 2026 09:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790932469;
	bh=8p3cWqnFJYmg3geBScTsx21ZdQfrifa7V27h/M7hy4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=OYgPm+BsOk/n6KL230e5lVexBR5GongeAJPPfEIRjIjpPlzoqxX+CS0VUn27Lcszx
	 Mxf575oN/g92Jhh5oAu9n8ZNSt41T6IT34yb4QEVJJw6jZH10moxV9RIM9eiErurar
	 ZqvOItmz9ATCgxTNiP/PpFXypoD5dt9WnSy9wtFeNdNsCjX/7DhbZoOfYLnDysGj2b
	 kwX/9y+yAUZ5NBy8R8i+lmvz4vQOpjkZfnFHO1E/U0genvoOO36ukdgXaWOsRs5t62
	 O/JBj9ahXw9eLsaxu0mpbRjoAwYSkM8VP+oOGevIDkXVGmftL1eWDpTdwOuWkv4O8i
	 lFVzYb4KPORgw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2] selftests/bpf: add XDP test for per-flow
 LRU_HASH window updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anil Kaushik" <anilkaushikwireless@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261002042201.3483076-1-anilkaushikwireless@gmail.com>
References: <20261002042201.3483076-1-anilkaushikwireless@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:28 +0000
Message-Id: <20261002091429.041811F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: xdp_lru_window parses TCP header incorrectly ignoring IPv4 =
ihl
--

commit 76a8e18822036a1270d2ff9fde06bd760faa505b
Author: Anil Kaushik <anilkaushikwireless@gmail.com>

selftests/bpf: add XDP test for per-flow LRU_HASH window updates

This commit introduces a new XDP program and BPF selftest to verify bounds
checking of value-internal arrays and per-flow key isolation. It simulates =
an
LRU_HASH map updating a rolling window based on TCP packet lengths.

> diff --git a/tools/testing/selftests/bpf/progs/xdp_lru_window.c b/tools/t=
esting/selftests/bpf/progs/xdp_lru_window.c
> new file mode 100644
> index 0000000000000..27aa1509e6c02
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/xdp_lru_window.c

[ ... ]

> +SEC("xdp")
> +int xdp_lru_window(struct xdp_md *ctx)
> +{
> +	void *data_end =3D (void *)(long)ctx->data_end;
> +	void *data =3D (void *)(long)ctx->data;

[ ... ]

> +	iph =3D (void *)(eth + 1);
> +	if ((void *)(iph + 1) > data_end)
> +		return XDP_PASS;
> +	if (iph->protocol !=3D IPPROTO_TCP)
> +		return XDP_PASS;
> +
> +	th =3D (void *)(iph + 1);
> +	if ((void *)(th + 1) > data_end)
> +		return XDP_PASS;

[Severity: Medium]
Does this parsing logic incorrectly assume a fixed 20-byte IPv4 header?

If an IPv4 packet contains IP options (where iph->ihl > 5), taking (iph + 1)
statically advances by the size of the IP header struct instead of the actu=
al
length specified by iph->ihl * 4.=20

This could cause the flow tracking logic to extract the source and destinat=
ion
ports from attacker-controlled IP options rather than the actual TCP header,
potentially allowing flow pollution.

Should the calculation advance by the dynamic length using iph->ihl?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002042201.3483=
076-1-anilkaushikwireless@gmail.com?part=3D1
