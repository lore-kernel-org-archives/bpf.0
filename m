Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793629241;
	b=aZeX1PjFdCcCqChqHZ4qLpMrSFPgFwr/H8hkAnK5ldauQb2v80MNCFwLQy/kADqlC2Dy
	 JmZepy5JWQP4jTpxaC9QBid3z/MEmfIYvIURcALSsmhVq0ZJ70t+dO2335R8fukUvGs7I
	 FtbTjs5Ti7wLRrB/hoG32AlVDdDbB8geFZd3owwbD504vMVc8uEKS/G2AanptTlBIGUHn
	 PV0vfQSJJfIpkuDS+r+B5Jdw+Ie7a/RxXTG/CKX4b0HGsVLp2apb6ojxgPbNUjSJ7i8Pw
	 7HKqlRpjqJvx4UY9G3o/qMxNrnDiiI9Ld9mP3j2DkyF5iBc7OQP//1D/AX4XbMDadFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793629241;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=wTwURxusbU8u324ldLVkqqEv7Duiy7GS1EwcVI2k/8o=;
	b=mSXpPGsNXGEKtJ4aRJlRp9P7HeTfORiK7NswIstvVFYiUBcFQIjJEv0RG2USwTCj0oM1
	 8F0Q5qtPp0XA7P9F9Q78NAWLOA0u7BucHI7rFcY6yQ29K42PkPh9NPY6vPlvHzaRt7xPi
	 acHPYVVbhdWj5A+WRP4z24ejNBcFgtZ5U7qxjk4EtBAkg9wGrJaTBKLgJIIs9CTulSrOD
	 JSYMkESJmBP3M3YXzyhm5h72aQY5ZV2hs4hNI5sz4OFhB6xa15DiBlOnV17jelt/EPs2v
	 Xtl9AoCO8foD9KvuaqNGpowC1ifjCtB/DepsQuppI7QvrzOXwJ5YaaNQQnMxZgjTGYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MS/YjA6A";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D59BB606A329
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MS/YjA6A
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA891F00A16
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 14:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793629240;
	bh=wTwURxusbU8u324ldLVkqqEv7Duiy7GS1EwcVI2k/8o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MS/YjA6AMLGXuAthnGNbbe0MBVn8tjQEybVecCOWugzRr43ZALno9ES7/+yGM5ND6
	 AbV5IH9TWYANEfv9NWjuF5wZzsj1XYvi6sWXgjaPocQoR8Udjd2nARP80bYnmYKkEX
	 WpF8LUtX+Vd+dW2Wb3v5JtQ45IxNhMPK3APMgotMk2lVYv26oRUnlselZ4vZ2rVQ97
	 stVxenclw+CmXNhbC/wixzaNdASsfFqaiqtJQCWvJN9cPWX0/YNa5wNVB2NK6Wudjc
	 7IV6daGQXuTx3omntAyIfAS2dOFnytMrTMHjzyWVDD2V7WHvNicEP3leza9azlCdys
	 8ntglE65n9dlQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6af9a9451daso4935586a12.0
        for <bpf@vger.kernel.org>; Mon, 02 Nov 2026 06:20:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBydplRQOH1sSLg+4+sIp2I6YyAddWuz5BJlSsNu9wFH7xUn6qospPefEHhMhng8XGfEQoc=@vger.kernel.org
X-Gm-Message-State: APuU4Z+9giihLxwXmr1Wf4jmwD7KBEVxUg798NPWEnLSqtgfowCYcpzf
	u3qkJGoOxT2QW8fu3ozdN8Oci5pkvWu47EQfNZIJ7756iUpWYbC+Ic8vSA9Nb8Qsxw5HPPbKYCf
	e5qwYFYvmsKYzp1hiHyn8JpJ0ymkgnbA=
X-Received: by 2002:a05:6402:1d49:b0:6b4:1037:2bb1 with SMTP id
 4fb4d7f45d1cf-6b4d4d7ae69mr7279562a12.22.1793629238917; Mon, 02 Nov 2026
 06:20:38 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102072808.23080-1-yangtiezhu@loongson.cn> <20261102072808.23080-2-yangtiezhu@loongson.cn>
In-Reply-To: <20261102072808.23080-2-yangtiezhu@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 2 Nov 2026 22:20:26 +0800
X-Gmail-Original-Message-ID: <CAAhV-H52mbZJX2vkgG_h=XfwHoio=asLjFdhTJwUYqDp4V5JMg@mail.gmail.com>
X-Gm-Features: AclHuK8eouGWl2Ju2BupUiXkLJR8d-YBXH4f10rwNZcSO6ZooS5wcrX91VkDbvA
Message-ID: <CAAhV-H52mbZJX2vkgG_h=XfwHoio=asLjFdhTJwUYqDp4V5JMg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] LoongArch: BPF: Make arena support depend on SCQ extension
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Hengqi Chen <hengqi.chen@gmail.com>, loongarch@lists.linux.dev, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Tiezhu,

On Mon, Nov 2, 2026 at 3:28=E2=80=AFPM Tiezhu Yang <yangtiezhu@loongson.cn>=
 wrote:
>
> When testing bpf selftest "jit_insns/cast_to_user", there are different
> behaviors on different Loongson machines.
>
> (1) Loongson-3A6000
>   $ sudo ./test_progs -a jit_insns/cast_to_user
>   #193/2   jit_insns/cast_to_user:OK
>   #193     jit_insns:OK
>   Summary: 1/1 PASSED, 0 SKIPPED, 0/0 FAILED
>
> (2) Loongson-3A5000
>   $ sudo ./test_progs -a jit_insns/cast_to_user
>   ...
>   libbpf: map 'arena': failed to create: -ENOMEM
>   run_subtest:FAIL:unexpected_load_failure unexpected error: -12 (errno 1=
2)
>   ...
>   #193/2   jit_insns/cast_to_user:FAIL
>   #193     jit_insns:FAIL
>   Summary: 0/0 PASSED, 0 SKIPPED, 1/1 FAILED
>
> This is because the arena range tree uses kmalloc_nolock(), which require=
s
> 128-bit atomic cmpxchg support, provided by SCQ extension on LoongArch. O=
n
> CPUs without the SCQ extension, arena map creation fails with a misleadin=
g
> -ENOMEM error.
>
> Make bpf_jit_supports_arena() return system_has_cmpxchg128() where it is
> defined, so arena map creation fails with -EOPNOTSUPP on CPUs without SCQ
> extension.
>
> Furthermore, given that the macro system_has_cmpxchg128() is only defined
> when CONFIG_AS_HAS_SCQ_EXTENSION is enabled, guard it with an #ifdef to
> preserve compile-time robustness and reject arena otherwise.
>
> With this patch, here is the test result on Loongson-3A5000 without SCQ
> extension:
>
>   $ sudo ./test_progs -a jit_insns/cast_to_user
>   ...
>   libbpf: map 'arena': failed to create: -EOPNOTSUPP
>   run_subtest:FAIL:unexpected_load_failure unexpected error: -95 (errno 9=
5)
>   ...
>   #193/2   jit_insns/cast_to_user:FAIL
>   #193     jit_insns:FAIL
>   Summary: 0/0 PASSED, 0 SKIPPED, 1/1 FAILED
>
> It is better to mark the test status as SKIPPED rather than logging a
> false-alarm failure if the feature is not supported, but this belongs
> to a separate bpf selftest patch.
>
> This is similar to commit 536b523b4073 ("bpf, riscv: Make arena support
> depend on ZACAS").
>
> Fixes: 4fdb5dd8aeba ("LoongArch: BPF: Implement bpf_addr_space_cast instr=
uction")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
> ---
>  arch/loongarch/net/bpf_jit.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 3ab039d0afb6..01c12da168ee 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -2489,7 +2489,15 @@ bool bpf_jit_bypass_spec_v4(void)
>
>  bool bpf_jit_supports_arena(void)
>  {
> -       return true;
> +       /*
> +        * The arena range tree uses kmalloc_nolock(), which requires 128=
-bit
> +        * atomic cmpxchg support, provided by SCQ extension on LoongArch=
.
> +        */
> +#ifdef system_has_cmpxchg128
> +       return system_has_cmpxchg128();
> +#else
> +       return false;
> +#endif
You can "return cpu_has_scq" directly.

Huacai

>  }
>
>  bool bpf_jit_supports_fsession(void)
> --
> 2.42.0
>
