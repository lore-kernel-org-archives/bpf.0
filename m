Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D2037107C
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769628747; cv=none; b=a1eNJAH8JmBclJsj3rvnuyamMxiF16ANnm3IK38bb4Tu/GGjU9BL2DotpCKVFWMTZctzqqjsCNGZMckuGzCdjTdQ/Cp8vWhH8Td3Sv4wFWbyhkhrMMeR2JNVqRBO8HGmZvzGA+OQe7cFd4dmfPXH2cTkYQY6C7fDRx4NdN7HOfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769628747; c=relaxed/simple;
	bh=IiwbjnmVlSFLLrr2f6Lv3b3fMnBrMPaG/Tsycyd1dhw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m7NGrjlpugBjmquU1CGg6/H3KO6LSo89nKyEZFP6vzylbhAZAv6uGFjcOViPCStSgMHenNHcvndN8nDyxNqAUy/+JMMZMH7yi4S6/Zg2SPHw6ZVcwpKulBq+bsCEeB+Yf4VTLCt/3LDblHXSuKdKqdFsHn2Um18W3KBlzyUtQWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb+HaArR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb+HaArR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6029DC4CEF7
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 19:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769628747;
	bh=IiwbjnmVlSFLLrr2f6Lv3b3fMnBrMPaG/Tsycyd1dhw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Kb+HaArR3As0IcZgqbCe+RnxV2EHO9zDCjJVspz1Gyu8t4fLAV2MFdEME3Q/jLAzI
	 J2XxBHPZ8ZIEEA0kSvX7Sc5LcHqQyrW8TZMOI+m+fsQ7P3SFRW0GLznGSyRHnO8poP
	 0fNHarOjwQgy3kYg406g817vo5xceHtpKf8TqEAcaqK7TtR58CkSx73TdRNsebqbpt
	 shc6ulsSEgK9+P9OhmItB9cOT+1uTw+8QQqSH9LnN8xNqRCepVOaNY2CgS/IcIT8C7
	 VUN9pE/7ZlSActDkW/xSdbij3TvhsOdarYoXTeM1ejfREh4Z/NQrRuxTnbNYzzR/O2
	 g/r3xB72zmNdw==
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6581af9c94aso495241a12.1
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 11:32:27 -0800 (PST)
X-Gm-Message-State: AOJu0YzQ4FLJtHct3Tmq1ojojjjFYugt5IyhOOMktdqVaYmqHtl8ugwu
	RioWnMa2wJIHBSO9WE2ZOprOPYiOJooPp5yf2JHhMwnAJnClmSp67PVK973LspTLN0wIFyFCxGW
	8SbAwLkGGGnM8b02RLL3mAPWumPKLG/c=
X-Received: by 2002:a05:6402:3481:b0:653:9849:df10 with SMTP id
 4fb4d7f45d1cf-658a60a2a1fmr3733526a12.26.1769628745986; Wed, 28 Jan 2026
 11:32:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260128150112.8873-1-leon.hwang@linux.dev>
In-Reply-To: <20260128150112.8873-1-leon.hwang@linux.dev>
From: Puranjay Mohan <puranjay@kernel.org>
Date: Wed, 28 Jan 2026 19:32:12 +0000
X-Gmail-Original-Message-ID: <CANk7y0j-RYyRRGOe+twJxebtW+mW1bPPWjR32FFQwtLZYgqbMQ@mail.gmail.com>
X-Gm-Features: AZwV_Qiswo9Qd3heR-XulOgpYmPZU3b8UEXHtqM39bOgPFTkq8gNQ7vCrLWrxoc
Message-ID: <CANk7y0j-RYyRRGOe+twJxebtW+mW1bPPWjR32FFQwtLZYgqbMQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 0/3] bpf, arm64: Add fsession support
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Menglong Dong <menglong8.dong@gmail.com>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 28, 2026 at 3:01=E2=80=AFPM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Similar to commit 98770bd4e6df ("bpf,x86: add fsession support for x86_64=
"),
> add fsession support on arm64.
>
> Patch #1 adds bpf_arch_supports_fsession() to prevent fsession loading
> on architectures that do not implement fsession support.
>
> Patch #2 implements fsession support in the arm64 BPF JIT trampoline.
>
> Patch #3 enables the relevant selftests on arm64, including get_func_ip,
> and get_func_args.
>
> All enabled tests pass on arm64:
>
>  cd tools/testing/selftests/bpf
>  ./test_progs -t fsession
>  #135/1   fsession_test/fsession_test:OK
>  #135/2   fsession_test/fsession_reattach:OK
>  #135/3   fsession_test/fsession_cookie:OK
>  #135     fsession_test:OK
>  Summary: 1/3 PASSED, 0 SKIPPED, 0 FAILED
>
>  ./test_progs -t get_func
>  #138     get_func_args_test:OK
>  #139     get_func_ip_test:OK
>  Summary: 2/0 PASSED, 0 SKIPPED, 0 FAILED
>
> Changes:
> v1 -> v2:
> * Add bpf_arch_supports_fsession().
>

Please fix the commit message issue detected by AI and then

For the series:

Acked-by: Puranjay Mohan <puranjay@kernel.org>
Tested-by: Puranjay Mohan <puranjay@kernel.org>
