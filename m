Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793311293;
	b=5ll7PozxPp6n+ACWgC1yLoLF1Rl3bDxE9NdOppUciw3BK5ZKkuID4oAulIOMV2Y2+rSH
	 S0kHktGw3yqoRbGXlDFZLUu0me25PAp/f4oqrYTzPeoMJIXIEyFLaB8pu6Ib1QXia52d3
	 rFvSMghgIGwBXi83ZRl/mkPIMzuFyNwp4vRF7Hjsg0CAAQU9HbI0pTM78rk9bZ53hcAgi
	 OHV/OuTkSgkY1mb8Ry99UU3kcfSDt/Dagy5/rfg2M7h21lFbPbb5bg/hhaAfrmGFKn3EX
	 PYiIvr05iV+odUFURU6jq2S5cNAFn1Y1zYS/fBuKJ85KBhOBZjObvYDptKeLFgfcJtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793311293;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=rWki7vE/miPR/Xe87Tbb6uEule/+hs/cjmC52gkJ2k4=;
	b=CBFemF4yaXaJaClOGrHLkWOA/XpMZQBLFKaJ4Zp1eAcLUH5PCCPkslmDcaTo+os/bd93
	 +c89YSAn+SnUSLD69ME7H3WFjvOpesvsMQ12prZUINEaK4SVw4rkI0mG9Z7Eq6gluvkjW
	 uw7JkunypeEOqtidDoVg+ZFdPoYvKVc8Wq7me7cpyAJazoU57D8p9sgwSfVhzUsj3Gp3y
	 cV3xpqYMPQlKC7NApT83AB7IAxfRuVB7r1WQf9hlEpZES2/DK2qE//yHnv6VzQAfQk+pM
	 QGRl4clG3wtLNy9esRC8MZ/0NOVfQHTbez8fWIa99kXJcHMTvSGebMvPFbKuEMdKq8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="ZOkl/cRc";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A0F606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 22:01:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C0A0F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZOkl/cRc
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b167ffd132so65177a12.1
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 15:01:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793311291; cv=none;
        d=google.com; s=arc-20260327;
        b=sHt0+izzHtRoScMC6VM6Q/GNT9KJ8IqLuNijT9Vpb9u7bX3rs4mBdDKKkvHazQLZaO
         8MQQmi4rIM9sRDQuVPxi0OpO8/DwwGtuGLG07dTbDJqqNs9sRxFrKNMCcy9Ik6NKh+XR
         iHZ3p4w+LDBgJi22+D8UUxNihlB+sK4oQFExB0wX+MLeL6+ULCNftAlQriXda1kIjeSO
         ObL8OBp1UsexyCIOXyZoypazrCM+HV7qy6Ax2luQl/XWpW76nMDQtYZG4Mb57ctOEpYh
         w4rN/9EJp4lvOJ7N+iJCLLDDL00ZPvgJvB3D4khV41Gy+ZoJgPjw00SGvwa/DABgiF/o
         n0ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=rWki7vE/miPR/Xe87Tbb6uEule/+hs/cjmC52gkJ2k4=;
        fh=zYrdYHSiEensa09jOZU6BIFnMfwD2LvRqZRMLLiw/Jc=;
        b=Wg1yEMP/0sBDUNx4/0cdQb3FCmhi9vJFqhvp0vZN0p6VInVVijRHrhiuG07BbthhXj
         jvLhrBs86rsGEqXz7xRWwKK/pmLLhYqWj8oCY4kkXjfMjPg73WR0KqqAk3mTf2b8T7iJ
         zTf8osBiAIo8i5r2tWSl1NZUf//xXRq89zq3WovgZvCezPJTyJNr60d1RgVK2ZuPMpUs
         oFUGfnVLbhw84fD1ZJc/ONV+Fjd0w81DDPRHx4OOCTzmMXPueaWWnnyljSuPchpCGmXZ
         7y9Ct71ueU3msq5lIm65JovsZsR36FYRYAvhbgrBoN6Zs7P9VQnR9uM2y9bHRiNGdYiy
         4wNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793311291; x=1793916091; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rWki7vE/miPR/Xe87Tbb6uEule/+hs/cjmC52gkJ2k4=;
        b=ZOkl/cRcixPfRZZGQXy2gSG3meu0mlL0dk31B1umi3UX+8tEXparKch1yqxg6t1iPa
         6q7oiMKdkqeDAOKLImcHKk9U5Nj490do9JKH1jxR4gEzzYX3uWV1SpLVUuaRVC+gYJrP
         anaVWo1Auh8qsjLPhijdPal9u4rzAUV3ssP30mG5GrSjDHtTfjLvXrPh0yJFnO+Sap+4
         3YEai8fGA4NAWMBnOSY4RJEVLQ4NYzsfdhiF3j52U6gVQ/Ph+q8nPb9HXBf8Vltnksva
         UL+dCSDG1EzprnE5m1zfV3PvZHisAA8POhZh9KFrV0JPp7Hr7Eudoo3lyZCJSs05RvBZ
         r+dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793311291; x=1793916091;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rWki7vE/miPR/Xe87Tbb6uEule/+hs/cjmC52gkJ2k4=;
        b=wCRVsFNfve7kS1vC8WANfKaEJWXN+BqnBdAVyAwu+xMPCi1/GVoiGb0tS9bv+lMyoL
         piK9KUiBW7Nzzael7wa1NvBE8sj2pOAkQ8FMTU6q53eUnocQYyscQlWgFIiTldczXwMX
         0MKiZXOjxMMS57frarPKW/yZ0s+SeUVAVJTfHVTP4lNqOL01/i+otfV5iE4Iei+Vjqjl
         Rax33QHXugvtsyQdIrYUS72k07vP4fuzvqq6lw87mLRwomie61S9buTyD6S55C4ZqgYh
         1tl29qwxV9CWd196nGZooEIw+uCxAGtNHbe1L4c4s/6m+4kgxB7kHq/k7r5uKRPCfT3i
         BIIQ==
X-Forwarded-Encrypted: i=1; AKwUvBwvssh0j/fk5goVj5qcRu/j36ZURpABMtzsYRj6fZ6D0EE9viUAiwdIzCdpHZi7g/ce1sQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYLw09L0G+zUxZWQpoPeI+XwrV5b0v8t1IFjcbqn48c7PbCt5szu
	cOuvS82CiZkOGjC78R60hgJtza00gtOyDv/Epx8cb11/81jeejznfZurbuRIomLtLyezOCSy+6G
	J5VkKktUdqxYhJ6cMXWg+/JzBXy/gSKk=
X-Gm-Gg: AYBFou0tRhWxptZq3RNI1BOy57VD7VdUnD8dlNa/yOhYQOkspPHNEvdvr4y03o1amdz
	7+cZWTdOgU3kaVvG6cIhhKzff3ELw8j5ukipVHTpSv0Z5cPCJD9uPWj7y77y8YUgW3ku5gbmfSx
	iZtFpe8YHUXy/8/MZwcSvv724nzGxmkPj9oLPOHvpZlfXlMIkia//VASK3B8IU0Xe8XFHraORvC
	IBnBelr7dZL53YcO/SOrqn9sqzZQN/2+TxJXuUVj3YReO6ygrkPOr350PqsHGsDAY6U32P5XbAY
	ifE40d4l626oMWEFDWHVIZGk313lOZO+MUhIc01w2FF7PfvOzDBZkpWnTV2DajqTH+8+hj09wV9
	aMKbtc/YSMMHFOrwE+dBBk7dfFXpxPOiB8ZTNnlHTGq8Ai5X/udupbnoGxaOTlv0XtoOfA5harG
	sEP9gQ8PDqvASsLEBUs7WQzQg7Yzuq4pMNNw==
X-Received: by 2002:a17:906:ef0b:b0:c46:b9b0:8e8f with SMTP id
 a640c23a62f3a-c4ca7a9d96emr36300066b.41.1793311290809; Thu, 29 Oct 2026
 15:01:30 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029212551.56964-1-jolsa@kernel.org> <20261029212551.56964-3-jolsa@kernel.org>
In-Reply-To: <20261029212551.56964-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Oct 2026 15:00:50 -0700
X-Gm-Features: AclHuK-kOUOtQ-G-FVVktnJEDJ8Q5GaaNL0lIdZEWjSEGoZpsRYH87xNkw7hKcw
Message-ID: <CAEf4BzaAbWxWfjn4u8vieaWzhjE+Af+KV8sLFH9kfgGT5PtAGw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/8] bpf: Add user memory kfuncs
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Federico Di Pierro <nierro92@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 2:26=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Add sleepable kfuncs to copy data into a task's address space and to map
> or unmap private anonymous memory in the current process.
>
> Require a usable user mm for mmap and munmap. Register the kfuncs for
> KPROBE programs and gate them on CAP_SYS_ADMIN BPF token capability and
> the BPF_WRITE_USER lockdown check.
>
> Use FOLL_FORCE | FOLL_WRITE for task memory copies and return -EFAULT
> when a copy is incomplete.
>
> Rename the syscall info-copy helper to bpf_copy_to_user_buf to avoid
> the name collision.
>
> Assisted-by: Codex:GPT-6
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/bpf/helpers.c | 102 +++++++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/syscall.c |  10 ++---
>  2 files changed, 107 insertions(+), 5 deletions(-)
>

[...]

> +/**
> + * bpf_user_mmap() - Map private anonymous memory into the current proce=
ss
> + * @len:  Length of the mapping
> + * @prot: PROT_* flags of mmap(2), including PROT_EXEC
> + *
> + * This maps memory by calling vm_mmap() directly. It does not invoke th=
e
> + * mmap(2) syscall, so seccomp filters do not mediate this mapping.
> + *
> + * Return: The address of the mapping on success, -EPERM if the caller h=
as no
> + * user mm, or an unsigned-long encoded negative error code, as returned=
 by
> + * vm_mmap().
> + */
> +__bpf_kfunc unsigned long bpf_user_mmap(unsigned long len, unsigned long=
 prot)

bpf_user_anon_mmap(), so we can conceivably have a more generic
bpf_user_mmap(struct file*, ...) in the future?

> +{
> +       if (!bpf_user_mm_ok())
> +               return -EPERM;
> +       return vm_mmap(NULL, 0, len, prot, MAP_PRIVATE | MAP_ANONYMOUS, 0=
);
> +}
> +

[...]
