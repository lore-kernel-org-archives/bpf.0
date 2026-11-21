Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795222686;
	b=Kas8p/fjIhS8PQN0ruHXYOU74FROrYxtsFKx2ufQruv9nKUAB0W1UhXDJtMuIxlIFZgO
	 zOAZLaqOaf7W2CvJJOa9oyphyCAmovz2xQYMo0veiY9PvA9kuLyU001sOlkl56KfUtBpA
	 F9Idb4W0nDPPcmarJq68RjeTgiaBlY1eUCSUEn2+fDeM2SX+0Hq4ANWOvZMFse7iA67ED
	 RfxOYVlg+I6lMULv3VmPQGpP2ShotY04eUXSFntPvdC18ZKLkk/+LXna9e7F1xmqlm1hw
	 X7wPX5jGF+Sw+8/whhSLSSAWYuEXyvP84tzyveTwP29GOHeDO27Uda6UFhCP9bExsIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795222686;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=uJD1XLuBURDcDFcsq3Mtzf+oZvN5DWxXiHNPxVkYQY8=;
	b=0Ao7Lxp7uvsZvZBLChMgcIEh4+07xGcL6/azJldfcVNgu2ELHWXH/gSCvPFn9b5NNJP+
	 KLlax3IZg3WKtyP6smKtpLpSooLRs4GtLeGkxWe1JSDxSpW37x/rVp4kjRPi8Is1CT54y
	 uQ6EisEvHp/hERYKXTPylo0AAmQkhYN97lKepO5SCb6FxPjI4Eu8HUitJcoXBnuBkloLd
	 OxylO+R0Mz/0hFLDoG2hLMYFQJyubIXN/UvW4VNnFMwN6Bq2BA050S54S0PewktHXJT8w
	 oL+hxsg6lI02ABGovgyUe6WO0cmnqW/EWjdsQEYXSUW5+BTQwnTFayjSG3h05iJGJvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZVWm02M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E45A606A6A3;
	Sat, 21 Nov 2026 00:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MZVWm02M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8FB1F000C0;
	Sat, 21 Nov 2026 00:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795222685;
	bh=uJD1XLuBURDcDFcsq3Mtzf+oZvN5DWxXiHNPxVkYQY8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=MZVWm02MunIUmEWxlkJ9/vwf1UXCEj7SLP28Ol5YAUsxEN5iUPWKkFbyVdzc/rZPj
	 zML/isG4jsZzPuMHFAC0nS2MGjVkBblNWY+RxeNEsARRkIK8KaLnETb4K//3felPUn
	 spdWiXR+/2AobLeD7AgDLWiq4BfXN2YSO2EuNCUMivEQ/LNlZNX2Qt/SEvJCoA8/hQ
	 MeLoG7GQKurMXWFSagPVnJeUd4I0nJZLm13tDERBtfUvYbpokjkAvPylVToTzHxdPa
	 B0yxv9jZsexPew7Ko/OTsH4nESOUjKegvRDrW1bnwHesOcpblIQHQjeDwAb1482m49
	 HVxSZfkE578dg==
Content-Type: multipart/mixed; boundary="===============6578065974918263349=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <54e84c02a7b6c83300c6b3cebb35098208296cb592cf3ad506ff4cda9ad64fd7@mail.kernel.org>
In-Reply-To: <20261121003403.2928928-7-ihor.solodrai@linux.dev>
References: <20261121003403.2928928-7-ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next v2 6/6] docs/bpf: Describe how to change a kfunc's prototype
From: bot+bpf-ci@kernel.org
To: ihor.solodrai@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,eddyz87@gmail.com,memxor@gmail.com
Cc: alan.maguire@oracle.com,emil@etsalapatis.com,jolsa@kernel.org,song@kernel.org,tj@kernel.org,yonghong.song@linux.dev,bpf@vger.kernel.org,linux-kernel@vger.kernel.org,sched-ext@lists.linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Sat, 21 Nov 2026 00:58:03 +0000 (UTC)

--===============6578065974918263349==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> docs/bpf: Describe how to change a kfunc's prototype

TL;DR: Docs-only question: the kfuncs.rst paragraph warning against renaming a
___vN kfunc for older libbpf seems to contradict the statement that older
libbpf can't see it; which case does it protect?

> diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
> --- a/Documentation/bpf/kfuncs.rst
> +++ b/Documentation/bpf/kfuncs.rst

[ ... ]

> +Only libbpf 1.9 and later look for ``bpf_foo___v1``. Older libbpf and light
> +skeletons see only ``bpf_foo``, as after an in-place change.

[ ... ]

> +Don't rename a ``<name>___vN`` kfunc while older libbpf or light skeletons
> +still load programs that call it by that name. libbpf 1.9 and later bind by
> +prototype, so a rename doesn't affect them.

This paragraph seems to contradict the earlier statement that older libbpf
and light skeletons see only bpf_foo.

Older libbpf strips the last ___ suffix from the declared name and looks up
the exact remaining name, so it should never resolve a kernel function
named <name>___vN, whatever name the program declares.

If so, can a rename of bpf_foo___v1 break programs loaded by older libbpf,
given that they could not bind it in the first place?

Is there a case this paragraph is meant to protect, such as a program using
a differently named declaration?  If so, could it be described, so that
maintainers know which renames are safe?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/44845964556
--===============6578065974918263349==--
