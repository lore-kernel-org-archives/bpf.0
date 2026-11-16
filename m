Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794843811;
	b=enMJZ19VCM0FCy4lb2x6bMiMSneb+9GiOqFL8eRByeUnUnrKvILVpat8WGdK/bwOeEGm
	 9p19pJ2AqvdztrIbg95VAB+yoHLUgnSJ3WKWOxm/V0HG32VL3kph/p3eb9qFWqHe+A4Fo
	 DuFUDsx35QKQ+T5OUaRajtM7RzvaIZ3bU6ntGwqmawxf86oxc4T9iTgORKbi3elFF+6+A
	 g60egGXjsSnjZx3pnpAHAE40T7ClQ5Smi2L/sa49zYm/gLBjsKGVSJiNHtThoTjRcLw2/
	 nKwif9nDt5XkIlQMvPVopnlqIPXeF+Ki5UciOCtnj/V3i3JQSstlQbbDqChEjSU6v4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794843811;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=sMpwlgIA254zxEV/NYN8JgBT7BlDFMozhjYDwTjAaB4=;
	b=1zkENAbWVcoiPf6JEd/x7nmY+C4vMfx6b4RB9e4ch49ic31fS/TVGuaE6D06VOoEfKeA
	 SNByavNfFQRj4JtMSxCVesCRdYa3F5AYy0tR3KPzs3zrB7jOT+V8iooPMFvKmpBBldYlV
	 90vJU21GmAmWNgmH9tNQIxIk1uvOFxV0vZpXvX5CRhg24r1pmC3xZTElrnErNxeyWsOcb
	 gkP7KkDclGl7Xuo2u06WWcnXsdToRHKAvMcsjp8rz+WjAki9A0wTt6KpVqLEmd2FpkMeA
	 pfu5n0PwrLlAHlAsW5aJvZWwP2E+RmlbKEJGSP8LG0CVUU0dHPa/IPiGYbvKAfsz2Kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mA71D1LW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B33606A322;
	Mon, 16 Nov 2026 15:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mA71D1LW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CE2F1F000C4;
	Mon, 16 Nov 2026 15:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794843810;
	bh=sMpwlgIA254zxEV/NYN8JgBT7BlDFMozhjYDwTjAaB4=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mA71D1LWDMFFCnTL2BFgJ0DmsAHG10HapEgN3rLfA9XFZ2cAKJhxDZuFtecXZOAxT
	 9Ng3Ld+z2HCmk50slHxe/yJ+Ski0QdZIBpzoj/Pe5DdTViVsATbt8Ec1ucNLC6Ftz+
	 hOYUuFShgMnAkak+CkozH6YFPHqTG+fgtOv4WVmedVtzaYZe4LBuU+QXszRqmFhtOw
	 DdQMyW4M2sA8vJ3lunwnEtYHxsC9wwXNCrEv7DsyaSVVFGc9MPX+gn0Oc9p/gTO/PD
	 ruPRlssP23Rk9HesqyG2xQPFOqaoIkFD0hFtWMWMNm9pIfW4K5U3hoCv8a3UwMMTTZ
	 LIm3zeL8nH3tw==
Content-Type: multipart/mixed; boundary="===============0547861428020528411=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <71941ec27b3bbadc76cdd36b00a4ebc33425b04f3e64a7ddc1431dcc5697856d@mail.kernel.org>
In-Reply-To: <20261116145318.34084-1-shijing.wuqi@linux.alibaba.com>
References: <20261116145318.34084-1-shijing.wuqi@linux.alibaba.com>
Subject: Re: [PATCH bpf-next v3] bpf, mprog: Defer RCU synchronization until peer reuse
From: bot+bpf-ci@kernel.org
To: shijing.wuqi@linux.alibaba.com,daniel@iogearbox.net,ast@kernel.org,andrii@kernel.org,razor@blackwall.org,bpf@vger.kernel.org,netdev@vger.kernel.org
Cc: martin.lau@linux.dev,john.fastabend@gmail.com,sdf@fomichev.me,eddyz87@gmail.com,memxor@gmail.com,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,kuba@kernel.org,pabeni@redhat.com,edumazet@kernel.org,davem@davemloft.net,andrew+netdev@lunn.ch,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 16 Nov 2026 15:43:29 +0000 (UTC)

--===============0547861428020528411==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf, mprog: Defer RCU synchronization until peer reuse

TL;DR: Commit message nits only: rename the "v3" column in the benchmark
table, and move the BPF CI link and pass counts below the '---' line. No code
issues raised.

>     bpf, mprog: Defer RCU synchronization until peer reuse
>
>     [ ... ]
>
>     A/B on the same bpf-next base (8835113107b2), identical configs apart
>     from LOCALVERSION, lock/RCU debugging off, 64 vCPU KVM guest. Average
>     operation latency. The attach rows use 30 samples each. The detach
>     row measures close(link_fd), excluding the first detach in each run:
>     35 samples across five runs of eight links.
>       scenario                 base        v3        speedup
>       first link attach        14.377 ms   268.4 us    54x
>       first prog attach        12.411 ms   290.0 us    43x
>       clsact qdisc first       11.562 ms   116.2 us    99x
>       detach after detach      6.2 ms     5.2 ms     ~1x
>
>     [ ... ]
>
>     Functional checks pass and a 300-cycle attach/detach churn under live
>     traffic shows no splats.
>     BPF CI: https://github.com/kernel-patches/bpf/pull/14821 (39 passed,
>     0 failed; x86_64 gcc-15/llvm-21, aarch64, s390x).

This isn't a bug, but could the "v3" column in the benchmark table be
renamed (for example "patched"), since a patch revision label means nothing
once the commit is in git history?

Also, could the "BPF CI: https://github.com/kernel-patches/bpf/pull/14821
(39 passed, 0 failed; ...)" line and its pass counts be moved below the
'---' line so they do not end up in git history?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/43894793326
--===============0547861428020528411==--
