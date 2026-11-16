Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794809630;
	b=mtGfYYlHdvfDq5uP3XXUz5zIh0xXFHd6cA2fR5JjgDiO6lXg6qjQ4E/RVA1VZQ8fQ4Oj
	 CmZk+rNXxKwR1Xev7vEe7OpOp8L7xNcJ0/HGAbfVzS/8C2fVNLgEUziOFVaLZFvu/x2q7
	 4fjHtjWAgyOTiAyf94WkI5AswDJCEVnem/3zX15XWEgoICJK5Q1uOOuZHtYVY849LBuap
	 iFTiHEJdyMMPwWvONyniP7tyuJiUEUAMkADQVx8cTHSiiITCVed/6EiUCL2SUwc/+XDt1
	 FiS+PrWiIwxE3zoTYXTPnsIhGrqvvIIjIWWpbItNaaEu0cKrgngVk89lXHV4UePS06A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794809630;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8LD4rrbf8XJhXhaT2IYZlnmBA4J/MuliZFG6fsPdkiU=;
	b=BA19IhnuIt6nMvVFV919OsDXMCFnT4wWZbgXJOoVTlpEvw4pklFSku1gc+egkgkIhvLT
	 KbmKhq5fhPVinISUFyNCEaaZh5DUMitnJu2J23hFemM4ANqExBG5blXmrNx1l2h7HA7iR
	 YHslP7PQrxul9kQN+ATX/lluCvrmHS0f2gcnJ444hW1AKpFSsRHqbczFFD9LOXYaoFTGz
	 OaKTiprwP70Kbcn3OK4ReQU3kQpZQJ2dC5CDQzuWvgH+JqWkqURj4aMnViMB2yFdSpjM3
	 pEcVyOIM1AM36clV6C9WtqtAOnq2rad7SST+GaPhWPQoTQ7JfKVHfykhD+U8rfvIj0A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lj2qoRMD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A922606A32F
	for <bpf@vger.kernel.org>; Mon, 16 Nov 2026 06:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lj2qoRMD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAAF01F000C7;
	Mon, 16 Nov 2026 06:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794809630;
	bh=8LD4rrbf8XJhXhaT2IYZlnmBA4J/MuliZFG6fsPdkiU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=lj2qoRMDRktluh1uKY0om252o0+8BlieguRV4H0AWutBR26DJUUkTC2Uh29brNERE
	 j38qnJhFvnj4gDOECp3EnaEkdXHiQUOYWZBY9s0P1tHwKjhLUoX3rzg3dgPqawNxNQ
	 VgZ/eKD+VrPAAib5my451u+dqmq1neAH3LNRFNqRLc+i5rGLSYVaXdi/eyuIVHRgcs
	 czryoVmtkLIPKjYvhO4q4hdffiOwAvB33t/wug/dii5HzDvrXwjce76tLMieRp/ZPV
	 fVYbv4zk7nX7ip+VRmnLagMVfftJYbjKBiJjzLkcZy5AzFZlJ19J4rfH8FXrBNsjZK
	 R8Tn0ySafWqbg==
Message-ID: <sashiko-outbox-216247@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 06/21] bpf: Resolve BTF structs and arrays
 first
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261116055638.4171529-7-alexei.starovoitov@gmail.com>
References: <20261116055638.4171529-1-alexei.starovoitov@gmail.com>
 <20261116055638.4171529-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 06:13:49 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] bpf: missing Fixes trailer for BTF cycle detection fix in
  btf_check_all_types()
--

commit d77c1abf46ef4e20941c0f4112b9fb3523e1d540
Author: Alexei Starovoitov <ast@kernel.org>

> bpf: Resolve BTF structs and arrays first
>
> btf_resolve() does not see this loop:
>
>   ptr -> typedef -> array -+
>             ^--------------+
>
> The walk from the pointer stops at the array and marks the typedef as
> resolved. Only the limits of the later walks end the loop. The walk for
> special fields is going to lose its limit.
>
> Resolve structs and arrays first. Then a type that holds itself is always
> found. Such BTF does not load any more.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

[Severity: Low]
This looks like a bug fix for BTF cycle detection in btf_check_all_types().
Should this include:

  Fixes: eb3f595dab40 ("bpf: btf: Validate type reference")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116055638.4171=
529-1-alexei.starovoitov@gmail.com?part=3D6
