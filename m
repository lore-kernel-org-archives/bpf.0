Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A4E439F8B
	for <bpf@vger.kernel.org>; Tue,  4 Aug 2026 23:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785886802; cv=pass; b=Y2WJhglTs9IBrr+NzwTD8Fv733Ted7GR02e/biU9feBp+rmVfOPE6fhAkbdjmNNxUhshFXmO5n/4BslXXOVZ93jhBkDLrxwVTTdxwCoZFm7htbAZ6eR8XEg8KVxJ6vzgxF1ji2/yuQecMR0OwSX9AJvcRwMXnAGXtcXfo9ZKqWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785886802; c=relaxed/simple;
	bh=uoWCewIAZ9hyxMRAN9wvtPH2p06arJIF2GepBNWFaiU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fFRDWECXBlidoQd4z3Oa5or0mSBXCdnsvri8/kwQgp+6B+HF10hxxDhPA+o02TJtW1sY5EZ6imfUAIg+D6rVxIzxtWpuxPWlsDRhVkzL6HaHCiMtmsU1OajouWIEucjzSuRcIVe0NslQXQQqj1VB84QZAaCL0xChvQLs35k9N/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sgN4ihYa; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgN4ihYa"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc73e322dbso4802275ad.1
        for <bpf@vger.kernel.org>; Tue, 04 Aug 2026 16:40:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785886800; cv=none;
        d=google.com; s=arc-20260327;
        b=TOApkKvRNFCc+j+028nTqvVZT030URU//7s7HquhAj6e/fWWeC7x2SYw2n52kPUuab
         U5n5iN66dnSIAsAIk/UW+3rFlatnhW4flOIQrFfbUS4MiYG+VaODadfj8oGfD+gGh+g6
         a9z0EtJwGgTTHlKx64ptt0SjALGwkfGJEtSk5CA1W8gmq+psROMolcKod+wDPitVDwGi
         uTWVxICVnGp5Mwbm8hv/pOdcx9S05zt78pMxY7z/IJR2HLEz4UpxYLzkIga/rryU9OFH
         QzTHUI6wR9tuBj20SNwEN/pXu6v8vFiNnh/7lCZ0IQNQX0wqEHxhxW/mE1ckRs17rRXv
         C02g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PRVM8hQUlMTlXsPIs4erLL1+dRInZl3+7seIzd4uNV8=;
        fh=ZD+TWjvdVv6CQAJ03pcYJ5YB24ceDiblC/Zer5CxQ0A=;
        b=C3URePEK5xzfblzOUPb9OlP8J+w9exL3apePk0Du6cTfEo1sAVV2sApbus9ZTyX8pm
         mW93Y63EyjSg2+1du0O+u4nPrwZVPFMd0b8EPwSA+eHjeSFG7sVIp8kqwzVpjNRTKOib
         oJGbPgQ2xKapvLFJiarLsmRmpiug8uM1nEHQMweNx6xIOstQn7PjliDNkGCaFu6va5iz
         1aYuUIsACGbeiEuKflrWehNXCJpIOOmQzyBQ6l8drxbye106gKopztihCHBeKMElXEo3
         VZAbVwMAwcei4TtMvB4fSgm+7+Viz+cZGLJgVH8Pr8jFdNqG6uQjCwdUuJi/OLGvmyWP
         QFKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785886800; x=1786491600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PRVM8hQUlMTlXsPIs4erLL1+dRInZl3+7seIzd4uNV8=;
        b=sgN4ihYagqnkBGz0+ICStRp9gi+GUDtvg3F5Mbo/cdEZAGr09gLesahGSo/2aLxznP
         kEYFia/Ce7Qit49nangIUnpdB0VJLRhLc78wY4NCnPzPYpucQyHk92Uhh+U6Uxx4r21y
         Q5ezAhEwQlFk0NthXkB7u2OLLr10uzKP5ZZeeELTfuIOPcnF2WLaCnFKiuUTdXCduTfi
         jfJHOFBEap/OLh078EkucT5UV6YAeQymxtybebZJhdrP04MlxZAr5aKqWIi7NVweUJVo
         w1qvVI03rhIgMfflygEyc7lG0W28Rw9w8+4dD4xwj5ZkEGx0BYRmaRaUw6ipWyN3/4vU
         q0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785886800; x=1786491600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PRVM8hQUlMTlXsPIs4erLL1+dRInZl3+7seIzd4uNV8=;
        b=XE1F++Vy6Byz1GyFMiVlmyyxEW9D0BW/K3gLyWe2v32zwqysu8ANjZnkLFAiCFuFRj
         jFn31H9z6nNURZjkXK+WFjUncoCHKFyOzlpZiEp0WcrBa6LBTOyX5V6tIyBfkZ939pK3
         A34Y0ByMQAUCyiJ9tfnProSANQ692OyBm+49zbt8hrYTwnLIgQfLrS3A4I9oEaaqIvE1
         YU6V6wGcr+HMidtWX0hZClcPNPP8XX60D/bIfeZGtiABLjNJGZ2sulfdI1X0kLXj+Ug/
         kk606xp4ikZLxey0myVboB/Zc1rujnE4DyTfY4MPnkVdcohaI6j9TWqFrzZNgSItycNE
         IWng==
X-Gm-Message-State: AOJu0Yy9ImfsiAW2rcvsBdT14DPbPngHG2NGyq/Lh36G0Z/KM4MyWCaw
	87VNZzycghAC/5iqjJ7SfFT6DBzFJ3Jyfq04BqVjRJaxjpV3QnsTKAk4Pbbb3x1tWqJMUgyyVl7
	hw3Wofr4vHkSyCyZ6BIlrlRD1ZQU2Fd8=
X-Gm-Gg: AR+sD110OMIQtiXsMmVrWIUAC+DW7GyIdgyOvLcZQawF7+pVX0g9J3MRpV1W6GN9aCz
	HUJ2AUwfmpXAOkGPkJr/4d04evdgDC4HGQXAlB3F8NucLBVgdRrBuW9KYsQeTfQO+bgfIlARBhy
	SyqTdq8NWLP9YGa5drYPJXlFLl1fCR+YnNdSx4zG+UheMZ//Cb/Wnycbny7d+zX4qm8lRw84INC
	1OB6IOlx7d2YQcwv7eXjZfnU2Jwq66uruuKVsjU2nKscPOCiSOC0fG13q3zLpCddFX2ShGtQUa+
	CES1Rr7+OKF98VmkqEk4eh/fvf0MeJoEV2LftF1TdPnbcLMEAWVKvgqIGvazCGPSgyHFoQNN7EL
	rUYhYFUb32aa+1iC6rOMkqB/DExwu2h6lWtU5PmrKh6eRqqYBq1k2
X-Received: by 2002:a05:6a20:c79a:b0:3c3:af85:85e7 with SMTP id
 adf61e73a8af0-3cb860767d6mr2645020637.34.1785886799943; Tue, 04 Aug 2026
 16:39:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260804145710.43062-1-leon.hwang@linux.dev> <20260804145710.43062-2-leon.hwang@linux.dev>
In-Reply-To: <20260804145710.43062-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Aug 2026 16:39:43 -0700
X-Gm-Features: AUfX_mww-a-GnHSPAMD6NdZrovu5pLCa3Uv6H92muVbZPcm4_2Im8TywcmphJxE
Message-ID: <CAEf4BzY0=ZL5MD9j-tLewfuLhRVMipAYnRJ2CD5Biji9iiZG7Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: Fix sleepable check for tracing prog
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, John Fastabend <john.fastabend@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, Sechang Lim <rhkrqnwk98@gmail.com>, 
	Varun R Mallya <varunrmallya@gmail.com>, Viktor Malik <vmalik@redhat.com>, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 7:57=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> When CONFIG_FUNCTION_ERROR_INJECTION is disabled, a sleepable tracing pro=
g
> is allowed to attach to '__x64_'-alike prefix symbols.
>
> It is because the verifier does not verify whether the symbol is a kernel
> function or a bpf prog. That said, a sleepable tracing prog is allowed to
> attach to a bpf prog target whose name has '__x64_'-alike prefix.
>
> For example, a sleepable fentry prog attaches to a '__x64_sys_nop' XDP
> prog, and copies buffer from a user pointer with bpf_copy_from_user()
> helper. After attaching the XDP prog to lo interface, the kernel BUG
> could be triggered by 'ping -c 1 -W 1 127.0.0.1':
>
> [    3.460756] BUG: sleeping function called from invalid context at kern=
el/bpf/trampoline.c:1324
>
> Fix it by disallowing sleepable tracing prog always when its target btf
> is not kernel's btf.
>
> Fixes: 16d9c5660692 ("bpf: Always allow sleepable programs on syscalls")
> Acked-by: Viktor Malik <vmalik@redhat.com>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/verifier.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b274004fccfd..7bb541e343b2 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -19019,6 +19019,9 @@ static int btf_id_allow_sleepable(u32 btf_id, uns=
igned long addr, const struct b
>
>         switch (prog->type) {
>         case BPF_PROG_TYPE_TRACING:
> +               if (!btf_is_kernel(btf))
> +                       return -EINVAL;
> +

see sashiko reply, just move it outside of switch and disallow
sleepable for anything that is not kernel/module BTF, regardless of
program type

pw-bot: cr


>                 t =3D btf_type_by_id(btf, btf_id);
>                 if (!t)
>                         return -EINVAL;
> --
> 2.55.0
>
