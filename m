Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794427693;
	b=GHFxBOqUAlwVwq5dHGjcP+H4q+7m8pfNBPA2f/EoKwmQs7GM6xPMT1oEGhMcOUo9WjP6
	 5WSMD9a8f1Y+gX/Gry4eM3Lh4RlQE2G7Om5hNN1X0DmXQR1hfySlhudRc2og6QuF1tCg1
	 LTuMuiw65PUAbaa8crlmqBmk0vn/hxZO5/HfrLFBoE6o3iJwtJDYw2LpLXhYeJVA7Y/9m
	 BME7pIevwOz6BZZFWhoHkDIcu2Utlskc+JpHCUqzxbi6dTqE40BfDzUmnfsYkaJKU+LcC
	 oBhElT6wLjbiTry2BIzeqkBf1PpVzaVbPAeEiQMuPmav1LqbL8PpF8UwHQPpVEgj9bg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794427693;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=21eCwXfXPFUzZoM2u/q0ArEzbrXYJijompIaapRnAhA=;
	b=eVvi5XjMWmseoo4/qDQ1yOZ5aBUaDt15+eXilqzVzBDLubU+moZ0mMgfCLAO/aqnGRez
	 l/n57vSGon8O+YUMOw2M7IJxd1+7CYA+pwNKSsljivxyuWFBgIcEU9FG8URo5tNg8kYQq
	 gQzTUj7mJ7F6RyBbW188eJ5Dq5nVsbDJWnfztfT5czS/QNIrebWIuxczUYTwi+51ZC0xF
	 yb8vRa9SoF9QKp//YZs4ElsZUOwpZbH+rU46fPAX+S1KbK/9tiIN+xUVbpEjjFd2Wvo0K
	 fWsot8ACAReHaLG+AVanjb5brIKbHWK9nMoYgEJa5VAjf3siWTBssdZbQHEUXsjIwhg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dh8xc9Tv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2B9606A321;
	Wed, 11 Nov 2026 20:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dh8xc9Tv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B271F00A05;
	Wed, 11 Nov 2026 20:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794427692;
	bh=21eCwXfXPFUzZoM2u/q0ArEzbrXYJijompIaapRnAhA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dh8xc9Tvv0NQPXjBJANsMkJeqAM+q0b0te7GWhh5lUE9FyaYcUYeDDyGi27+F3gAc
	 RH6Zuyqoee4psSjfkxqfcf8eW29SyoOEiAZdi+Gh5u0mGNriNGiEroD/6DtbUrc8Sd
	 GIadHjhbenoOeA8N8kHe5QVE8VTk/xCAg/t3d15xp8/qpuaKIP5czKOqp48TeodfN5
	 2UexNK6PB2Th8ClvbpQmGnRDOxZAUVCikzMhpCXYFuehxgNS/5Rjpe8a10pjPb9Nx5
	 nTyMAycoRPxF1JzWQoNItp3A+h5WMpVfTdPtHECD6Vk4ujYS8y/Yt78tdPYCtrDJx5
	 kGI6Mtvq/abLQ==
Message-ID: <sashiko-outbox-209608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 4/5] selftests/bpf: Add trampoline and
 raw_tp preemption recursion test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mike Bazov" <mikeba@sentinelone.com>, bpf@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261111-bpf-preempt-v2-r2-v2-4-9d8f6b952ad2@sentinelone.com>
References: <20261111-bpf-preempt-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com>
 <20261111-bpf-preempt-v2-r2-v2-4-9d8f6b952ad2@sentinelone.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 20:08:11 +0000
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
- [Medium] selftests/bpf: raw #pragma unroll in fill_stack() breaks
  bpf-gcc build
--

commit 85924bc5107b6604b6bb8852a70f1660aa030b1c
Author: Mike Bazov <mikeba@sentinelone.com>

selftests/bpf: Add trampoline and raw_tp preemption recursion test

This commit adds BPF selftests verifying preemption, private-stack
isolation, and recursion rejection across trampoline and raw tracepoint
program types.

> diff --git a/tools/testing/selftests/bpf/progs/trampoline_preempt.c b/too=
ls/testing/selftests/bpf/progs/trampoline_preempt.c
> new file mode 100644
> index 0000000000000..78ed74627a79d
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/trampoline_preempt.c
> @@ -0,0 +1,265 @@

[ ... ]

> +static __always_inline void fill_stack(__u64 *buf, __u32 tid)
> +{
> +	#pragma unroll
> +	for (int i =3D 0; i < 8; i++)
> +		buf[i] =3D ((__u64)tid << 32) | (0x5a5a0000U + i);
> +}
> +
> +static __always_inline void check_stack(const __u64 *buf, __u32 tid)
> +{
> +	#pragma unroll
> +	for (int i =3D 0; i < 8; i++) {
> +		if (buf[i] !=3D (((__u64)tid << 32) | (0x5a5a0000U + i)))
> +			stack_corrupt =3D 1;
> +	}
> +}

[Severity: Medium]
Does raw #pragma unroll in fill_stack() and check_stack() break the
test_progs-bpf_gcc build with -Werror=3Dunknown-pragmas?  Including
bpf_compiler.h and using __pragma_loop_unroll (or
__pragma_loop_unroll_full), as introduced in 52dbd67dff5d ("bpf: Abstract
loop unrolling pragmas in BPF selftests"), avoids the bpf-gcc build
failure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-bpf-preemp=
t-v2-r2-v2-0-9d8f6b952ad2@sentinelone.com?part=3D4
