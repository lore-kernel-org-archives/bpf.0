Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D67B3F6C2F
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 16:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779985146; cv=pass; b=CJ0ZeGl1+CaXg0lBCogjvkeADfJX32RP2MkIXBrsbrrtU3tYh3X3JqNnqx1QzT3q+7hSgF3Z6+ZZ0nF09Hk7i2Gx8bVwK9fWrxjbUZLaZVh8JU+i7/8qjyPKOJNkEhFWG6sgEB9k5ymOM55BNzhW998iIIkbcrJps1eDL7xhgEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779985146; c=relaxed/simple;
	bh=2cE3e8QUtpQIKPo3dwPxuDOlqzE1WmRPLP72+IMItW4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SWpjamusLvzhKsZhNdBnM2HmUAkuApDhC5PFTIrw7INoVAXXa8CrgaKUYTs8T9GFXdBAu3ebRKqTYi2EaLKPeyTM3Vfhw/bzqMhqoKvVw/GdfptNd8IqN9Sy69NRrLQTVssUE0JWnkcthqrvCrbHOVzGm8jjZIz/UWnHlBcnvEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=La3S7RSD; arc=pass smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="La3S7RSD"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-516d6009380so1271cf.0
        for <bpf@vger.kernel.org>; Thu, 28 May 2026 09:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779985144; cv=none;
        d=google.com; s=arc-20240605;
        b=D/mpjBQcc+lEnkDNgsxzJ+fdCFj9/aCjDweWiX8kcTMQiC+nQ28aecrW3KtDobpXeS
         sWbO3naanhF8gydYY9uZP0FqIMDSDRA9LP7HG75HTGEDqbaUT6UpIYJiK1G7p/RlH796
         NQv01jfgdBGGhOgBmDEtdLeoVJqTqdTW8EMXw8qqsZ8veR50EZgttCA1zIzYChfTfgJL
         3kaMXGHvSQi7WvXbyugFYaPTkg5tjCw4LN6em7WtTT/eS3/nEireoifkB3OHYWuxtSnl
         5b1BoUlDcDycNJbixWe3ojBmZEfWwOGvoWtj/KVP2iXO1BWiSJZjqRjC7/2HKX6YlbvN
         WNHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=478/AxxorbjxlL+8D6YnRYxtGnmoIrfbdOmlHjfNrLw=;
        fh=Z7C1aKrXTf3/ZxHCy9Z3WQx8ZEc/362mUSo0ukZ60pg=;
        b=SCMTw0mtuBrGW2uYB5+MZ8QzWY7JZ5HeClEa6wqMG4KilJB43JVNjqL4Ww2m8Mq33Z
         gqYy5IVU1LBgrwXuI6+WJCQd6HCLeymhA9Wk97rl7kvuGfstEtJRTvEvq9U0S000tJ5L
         qEad/w0jHdby/db5uucWye5+guqloY+wABtVhujHogWWkymubWqR38xJLIywfnzptN6T
         DosJYWQU6eHy70KAaABereVmOKCx3C0uH5hvvnj9GTnIhmB/9Ws3gFbC/kgnD0f1GuVQ
         EJzBwzW8I+EPWTWwaehv2fjo1CUY1y058p2kcvkt9PFScPmx5k2nyjvidXv5YOjuBJnf
         FtfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779985144; x=1780589944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=478/AxxorbjxlL+8D6YnRYxtGnmoIrfbdOmlHjfNrLw=;
        b=La3S7RSDJMGaMLw5jnVAqR/vltkQGXt0kscfRO3bsMYYJmvImaOI7uumWRhYD8PHxZ
         LzfrpC9xxbyFQe5k52hu5VTvvHnLrIuPskzNkJ7rP1DRCUG035YnQq8xkBxOhnimhU4A
         jf1S91fK+487OQdzK3V1xEam2avtAqjF/1UxXwF5LPnR8kpYmQfdOQ0vQxx4yhTMGLD+
         n4zB16j31j9ek4G3FYiyE4bAbQ/JwpxPTHTCaBGXp1i2fuU7dp/ZgDc+6Dtegd5HFEy1
         AUAcWyvYMBgln45cs8bqJTM9mYeEr3754CaGoi1Kusdfu5lMXsEyWDe/AWg408dur31K
         ywxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779985144; x=1780589944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=478/AxxorbjxlL+8D6YnRYxtGnmoIrfbdOmlHjfNrLw=;
        b=do2c/rn5B4+rAsgLf4ld7Q7BaM7xSSPzWt5dD7aCle1g2zcX86H6ucCsORmewZgf5U
         YGtnVivIkjUpCF20nf038JRSQC3xAKavOBdLHmceujQ2b3upHuqO+gv4N0hcwm9ji00y
         zrTmzlIDMNCtONV1haJDtlf4GsrfTxCSKMecbEXQ3UzQJN1iBtKQ/CHcrwd31O6X5fNL
         frdqbaf3QTD5klzhdkr34ctbmI8YzRt8/b+KNTbhiLM7ZnT1b35iSS95GluthHTEc1Zn
         Ercj2exiRBo6a09u7u9YlfZT5pjBlcH4Mf1QPOyrEUsQLNPCO694CjB0TkM+VifHjlAt
         TzHg==
X-Forwarded-Encrypted: i=1; AFNElJ/ym4ZD+WiniFgEPL4Z4jlj+ysCy+mgS1wZXnf3awV3bUrYIYxbQgrhPVT8eXzhvMfr6UE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhu+qxUsqKW2T+OV3Nuw7ZSMPqvM+BrLd5dCURSoeDs6+0X69H
	U2SBjvIlwt+QPHireGytloa5z/vcQgEVur5Ceh/mbIeYkMmUjDnhNky2ZFFQ7zSozhBMRijKZf+
	RBzcsXlHAn3biSfsuGddRcqjAx1CeoTFEcgxP0tzo
X-Gm-Gg: Acq92OEGxFzowQVHo0Um8X5uANnWIIfB1XeWjDy34kfHvGdGm7tzbY55xDYsyYFwQVN
	pVOO8ATGLNaHmJ/vYG37EC1pCQFx7GFSSFaw4odKup1Rf+5DXlRn9dlSfnXMc2CAKR4/lVvje0n
	ZEe6qQRtyrxisQkQDZ7Db/fPuooOorIZmZFsuwVy1XjN1+pDMlZTFreJwQ2pOBaDM8927Mq6X8M
	Bl52f2/Dc2AeuLKTHyVcUVnGShUYtDWRk0sRSoxRiy6UaLF/2AlYI6SI4Kj6Plyq2DgYTvaa6v2
	4tqj19k9SkI2qlckCaxV8wqcXM+aQgPwKWIQr+nR3unQqdNKNaeH1gNRArpUKOsvmXPnP0YhJ6w
	=
X-Received: by 2002:a05:622a:5cf:b0:516:4f62:85ee with SMTP id
 d75a77b69052e-517223b0ecdmr7990661cf.19.1779985142931; Thu, 28 May 2026
 09:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260515071504.2054786-2-yuyanghuang@google.com>
 <2e08eb1ca27a9a2f8ad29e1c24f779b579621b0a648589f7044799d91c5e00f5@mail.kernel.org>
 <CADXeF1GVtFHNZJb8xwFh6aadR=H19S+kja8rF185XB5=fg0D0Q@mail.gmail.com>
 <CAADnVQ+42+Th6OFGq2KawzvyKUAykazb4fXh2_uqss-T+R8VCg@mail.gmail.com>
 <CADXeF1F=7RcxAsW38w_mpFeKCLxTAh5p_XYHd=x2Ru+oajoN3Q@mail.gmail.com>
 <34b18a3e-50c0-4b0c-8ee6-d7a291619231@linux.dev> <CADXeF1HRe=U7aWx2yx6RFZ_uH-mMbdsxMheofr2tMD9wae46oQ@mail.gmail.com>
 <6083831a-dc6d-42e4-a1c8-8b7f6b966650@linux.dev> <CAKD1Yr32VMefwq7Bo6_hmhFrDVsttNFwZJZcaXS4P-ACOwWobw@mail.gmail.com>
 <CADXeF1EWY0=TyvhFap3iyKdpHNkk5pZuHD-RDnXuqMa5LrNJ2Q@mail.gmail.com>
In-Reply-To: <CADXeF1EWY0=TyvhFap3iyKdpHNkk5pZuHD-RDnXuqMa5LrNJ2Q@mail.gmail.com>
From: Yuyang Huang <yuyanghuang@google.com>
Date: Fri, 29 May 2026 00:18:23 +0800
X-Gm-Features: AVHnY4KqO-LYOyvwglTe5XXMvZnX3bL1FOeWTgsNanJEKjebhIA0UQKFOY71MtE
Message-ID: <CADXeF1EwaZ+a953KOW4d5cU7f2GWiTNn9LKbEgHHXa2XxmXNeA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: align syscall writeback behavior with
 caller-declared size
To: Lorenzo Colitti <lorenzo@google.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, bot+bpf-ci@kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	Song Liu <song@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, 
	Network Development <netdev@vger.kernel.org>, =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Chris Mason <clm@meta.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>The fixes tag should probably point to 053c8e1f235dc or a subsequent patch=
?

>bpf_mprog_query() and tcx_prog_query() were only introduced there.
>How come your userspace passes shorter uatter to query newer
>BPF_TCX_EGRESS attachment?

btw, If there is a strong preference for the BPF_TCX_EGRESS type,
specifically, that userspace shouldn't send a size smaller than the
newly added structure when using the new attchment type, I can modify
my patch to limit the fix to the BPF_CGROUP_INET_INGRESS type only. I
do agree newly added BPF_TCX_EGRESS and the existing
BPF_CGROUP_INET_INGRESS worth a different discussion.

On Fri, May 29, 2026 at 12:01=E2=80=AFAM Yuyang Huang <yuyanghuang@google.c=
om> wrote:
>
> >It seems you haven't convinced Alexei in that thread.
> >Attached below.
>
> Thanks for the test program. It proves my hypothesis: you had to
> manually unmap a page boundary to force that `-EFAULT`. The part that
> is still under discussion is whether there is a kernel bug or not. I
> think there is no question about the behavior of when the -EFAULT will
> be triggered.
>
> > To avoid such stack corruption, you should reserve enough space for the
> > query, e.g., by extracting union bpf_attr from kernel BTF vmlinux.
>
> I agree that your suggestion to extract the layout from BTF is good
> practice when writing a new program from scratch. However, our focus
> here is on maintaining backward compatibility for existing binaries.
>
> I think the core question is: **is a 40-byte query a valid request or not=
?**
>
> From my understanding, under the syscall ABI contract, passing a
> 40-byte buffer (at least for query BPF_CGROUP_INET_INGRESS which has
> been stable and supported since 2017) is 100% valid and legal. **The
> kernel must never break existing userspace on a kernel upgrade**.
>
> One example of a syscall that maintains such backward compatibility is
> openat2. The documentation notes it as follows:
>
> EINVAL size was smaller than **any known version of struct open_how**.
>
> If this bpf() syscall want to follow the same way to maintain the ABI
> contract, your `mmap` test actually let kernel return -EINVAL to a
> userspace program that passes a 40-byte buffer (declaring `size =3D
> 40`),  because the kernel unconditionally tries to write to offset 56,
> which happens to be unmapped.
>
> Are you arguing that the `bpf()` syscall does not need to follow the
> ABI contract to maintain backward compatibility, and that it is
> expected that newer kernels can break binaries compiled against older
> kernels? If you believe that all binaries must be recompiled or
> dynamically updated against the latest vmlinux BTF upon every kernel
> upgrade, please be explicit about it.
>
> Thanks,
>
> Yuyang
