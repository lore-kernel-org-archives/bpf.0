Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C87C28725B
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 05:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777094320; cv=none; b=J6u7gt7eOfH8Fx99tg1mOvbE1lOE9fnJpOQMNRIjrlDWZ1DqYXjbpaEhVtlka6kFxBFaPRttrooX1kzAfljBjEA33NsduSH4DjrsE9MEI0yXn++R+jYMIcqdIfLOU6URTuKzJPZUWCIxSlH8eqTQ+IB8iLzSEIncw5SU1YuOBdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777094320; c=relaxed/simple;
	bh=VBmvoAEGPX+jO0hRPw8ewOS4CBxYTJoHpvtxXo/bTkY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kDy8T6ghLN8TEJ8DOYkzILKargu9CbqlVG9HnnEHUtjzDdZE4woxbM4eYmsUu8RU3+qwyHX/vEKbsXkzazjsCX/hxlo0+g5PvcAK++GGOf7IRalux8kMvWllACFjHdFWC2jfeNgqWOKQvumd5sN/AbUtMZ8v7QNK/swOD9VkBcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HDEKz2vw; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HDEKz2vw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E7C1C2BCB2;
	Sat, 25 Apr 2026 05:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777094320;
	bh=VBmvoAEGPX+jO0hRPw8ewOS4CBxYTJoHpvtxXo/bTkY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=HDEKz2vwSuCULyD5GaxhdwELkL+FeDS8WFse677s3eGj22fqMAQPZZwrkFzscmhCY
	 LZN7ibEViwh3ecWbSlc5WeT8YCM1JwxIvAtxDaIfFTubGOgW+xtN4GdZtcS/6nyRTN
	 p06SIPOke6knEG3cm+4wYN6et2KVGC7Cjr0hffKU7GvtzZCGEf1dkp6c84VIZe5c5A
	 9AS92pu19TwxMU9rpyNAypOr3oLAHXiV7yxbimrY2P2S14aBPmy5ruTK/6PTwmWuuT
	 vw/9iOIQsvE8xA4bv/n9eJwB5I1yb4CmMoeESCcnFXr2jAPsWwiJJHnWspC8W8hS4F
	 BaBqUDwQUQ4ww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC bpf-next 3/8] bpf: add BPF_JIT_KASAN for KASAN
 instrumentation of JITed programs
Reply-To: sashiko@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260413-kasan-v1-3-1a5831230821@bootlin.com>
References: <20260413-kasan-v1-3-1a5831230821@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Apr 2026 05:18:39 +0000
Message-Id: <20260425051840.1E7C1C2BCB2@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 2 potential issue(s):
- [Medium] BPF_JIT_KASAN is defined as a hidden config, preventing users fr=
om disabling it.
- [Medium] Mismatch between commit message claims and Kconfig implementatio=
n regarding KASAN modes.
--

commit db39a97fa52b06c5f7f9fee25e7e76e2302a4e9d
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

bpf: add BPF_JIT_KASAN for KASAN instrumentation of JITed programs

This commit adds a new Kconfig option CONFIG_BPF_JIT_KASAN to enable KASAN
memory access checks for JIT-compiled BPF programs. When supported by the
architecture, it emits shadow memory checks to detect memory safety bugs at
runtime.

> Add a new Kconfig option CONFIG_BPF_JIT_KASAN that automatically enables
> KASAN (Kernel Address Sanitizer) memory access checks for JIT-compiled
> BPF programs, when both KASAN and JIT compiler are enabled.

Does this description accurately reflect the implementation?

The commit message states it is enabled when "both KASAN and JIT compiler
are enabled", but the Kconfig implementation restricts it specifically to
KASAN_GENERIC. It appears it will not be enabled if other KASAN modes
(such as KASAN_SW_TAGS or KASAN_HW_TAGS) are used.

Could the commit message be more precise about which KASAN modes are
supported?

> diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
> index eb3de35734f09..28392adb3d7e3 100644
> --- a/kernel/bpf/Kconfig
> +++ b/kernel/bpf/Kconfig

[ ... ]

> @@ -101,4 +105,9 @@ config BPF_LSM
> =20
>  	  If you are unsure how to answer this question, answer N.
> =20
> +config BPF_JIT_KASAN
> +	bool
> +	depends on HAVE_EBPF_JIT_KASAN
> +	default y if BPF_JIT && KASAN_GENERIC
> +
>  endmenu # "BPF subsystem"

Since this config is defined as a bool without a prompt string, it acts as a
hidden symbol that is forcefully enabled whenever its dependencies are met.

Because KASAN instrumentation emits shadow memory checks, it can significan=
tly
inflate the size of generated JIT code.

Could this code expansion cause large BPF programs to exceed the strict BPF
JIT memory limits (bpf_jit_limit) and break BPF functionality?

If so, would it make sense to provide a prompt text so users and automated
testing systems have a mechanism to manually disable CONFIG_BPF_JIT_KASAN
to work around JIT limits or isolate bugs without having to entirely disable
KASAN_GENERIC?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260413-kasan-v1-0=
-1a5831230821@bootlin.com?part=3D3
