Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921464DA9A4
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 21:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790025716; cv=pass; b=quQw4Jf4lcy4EeA1ID3cC3yuUylKuEysf3ZAlOSiEwnXqcHuKgfePm1XLPQy6V5t7WJrXqv3kTAP/ZbQVmC0bhMLtIdx+uJkO81qL95hmWwf6DfJUJzT4OerBMTwwp936aztvnuF3eFxB3UXarMPVibXop7wHdinMl0Hr+jhNjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790025716; c=relaxed/simple;
	bh=AV1BUzrX1AeKorD9vs62eiulrZw+UpP9wmqdbCMjK9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tq4UBFNNWyx1UNruS04ZtzqIz9OcGL+QuoJevxBqnJsJUxM10ka69RRrI2MLLMEC11jp8lFRTqTwb6Pw/OWJBuXdt1CAD9iaFI+ZvdBAMJtOgCr0XQuDGidFa+d7lIqcHBYsytwHx7T3Ov+aHxttF3X0EMEPLrZhJ3lWDAuD7Vo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoHhbBKe; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoHhbBKe"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747f01363so28347615ad.2
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 14:21:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790025714; cv=none;
        d=google.com; s=arc-20260327;
        b=PkUou8k7lhEXi1jr4LzBN5dCt9M3v+I6FtaEmwwpTMTzcqHGwMiT/8nu0MHWeRvq1Y
         797IEkdRSeOUphRfxrnILfs+/5WwCOe8tpGJx0Zh8XM3QKSGDj//OURnSrF5pHLvm812
         kPCOngj4PuwJdRKq6G1JzXQ0EYwrhNCvNDAmR79B9yKqz28GA5wTUsRUCEVRI+DUUtqO
         95hUWkKs6+hTcKtxr9F7Ay75YHLzpTaptdyBJ6mbHF2enR5OgWAfmVsoelLas6i6Za4r
         9Pnk6pdG+JRp34nmqDlSFxmr8rwTrG41KrB6Sl7mSnDjlwt1kMCfgBn3fKv1YuB/AnY4
         633Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tHRHhDpk3/uEQmuDP9Wz5eIXg6/pMCpvv5Kn9toDyoM=;
        fh=r9GLFIJI1LzIAld/wE9Ks0yc2S49JQKvchjr69D5c8E=;
        b=UrWq3WE6307cj08wh0r9gfzdnLwVoj2KD3L4ronB6fsEoZ49lQrGWYPJsUzIHUrTCu
         raQh8g/JlPpJsvjBUVwUwx4ej0Ak1xCMRjUaqxkuqyvpJ/FJGzqtwC7UfF5B0IMhZ+v0
         rjh/CzWHtcmEcCiWYm+D09RK7pz3EGoQpGT6GxOCWb+lXpfGbbx6+jdHsHKODbaGaeZA
         DBBfkyotyXBikih9QFBGQt5aA1SQ1fVPmncEt7AyPKm/B5wtNbfEe1VXQDx+ET0zaAgj
         ++WaadIafh5q0L/J7DgYdFE5jTpHUA0zGfecWKr8WMHJHugW4aTsH3cMJ36CFQcgaaxH
         98iA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790025714; x=1790630514; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tHRHhDpk3/uEQmuDP9Wz5eIXg6/pMCpvv5Kn9toDyoM=;
        b=VoHhbBKeiDgVzcSUupWiY9zPqG8cfEhNQYUY8Q+DORh1tXcGymJg7gSQA/7ZR/lwA+
         HB9AfAqCTjarGqI3h3UDH/tlOtK5BIwHJiLA3fBURTDwFxOKHu4+9v1PA4KqGSW1ggz9
         VIY+k91r/kNb9ThyrBIjTg9SkGiyEdb3uIlLBvZB6F6U8G70fOCcyVhYx7xRv40ObHsF
         Nke0v0ZZ6JdxWsj8oMIyfFfIjAF4J5QHF9oB10uGLCuGpbH2lPYHfLJvyfrvU+gQtSuN
         SHBEZXSeiLg1x5ibzJpuLfuMgr4YMG9VMoaLYDJECD2C7tvjYoWZWx/Fb67Tmf8n0D1g
         gcsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790025714; x=1790630514;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tHRHhDpk3/uEQmuDP9Wz5eIXg6/pMCpvv5Kn9toDyoM=;
        b=I5H4Tnh0TQHoruCRu9vJ58b1GLeguD46sOFjkdQxAo13sMXfVGe5WLIlMz34hkFTNn
         gHWA+kwHF+FpN3AtVU0vQw5Z5F4WnVeU3+skwbnBoOk4GgEifUvsyLZQq4H67dSfpuSO
         1DRq7PxowTchL+0NkXT2nLgRqQp4fYGAEaOUl4jXAtcHt73ed5tZziv58quaapDHVN0r
         6PLSeDtcKbTxC9t1+9q/GRWzrKWiS+kKquVHji2kbNhc/sC6nj5gCwDFUPhNL7JzjzLF
         cZ/zM+6iL9id+vL2+pICY3pfNPgLdBW6yBJX4zikFo4WETQaG6QdpjYMbBZ9AXqrvA6a
         /7Rg==
X-Forwarded-Encrypted: i=1; AKwUvBw8I4oIlBwmo2jn/qaX30o9PS/a6+bEgwx3tUM4uBFMwck3v1LzBCcGw+kI5Mud/uLxnms=@vger.kernel.org
X-Gm-Message-State: AFuF++mDFbKjLAAUljf/dqwAmcR+ODGIap3K49VclqTB5Ka1j18RrhND
	Tx74DC6H8ZHENALuhsOMk6PFUN2yzVgl1y2p5SLm2cw6A4FjL6wQ8uLKCnuNBxNHVRTJhFlg/eg
	TCDDenm8In0R1NAKuVQ65rp/k67xBF5I=
X-Gm-Gg: AYBFou1kndZGZQ6jbdF891EJ3A0K+5P7ru6L3Xr8DWxvSRQVJYymjzuL4deqAD2+T9A
	jkhNIefRRLGAtpT2f/k3VOE66sjk9qO6qkiDyNZl/JRvQ3WfmSqCWVBLNvdoWc6WQ4S2zzjGaap
	gG7oBfgfNKtx7Zc+1krH9dysXR5jbNB1HLRn8L0iFn4rMJblbWIN6FtxxoYRGvwsyme1lNBFNM5
	4ZRg6zoXiYiTkslXkR5uHdk/kC9adKqyvGXQI4Rge2S+z0SGu3gmSwGrrNwHBMjcsATwc6LruaW
	/0FzAVjhzNrJR9drU1pn6bgRlyxtnyMqyMBC3sFg4hqxCn3rhHMbxTnNjGV0esYjESNjI/XBUQS
	+qrC7/q8pA2MZYYBKERe5i7b3i7ZWFOVoMNVIshOc2BLVv4uSp/5Y
X-Received: by 2002:a17:90a:d64f:b0:39e:4c80:44b9 with SMTP id
 98e67ed59e1d1-39e54dccbb8mr18606149a91.28.1790025713935; Mon, 21 Sep 2026
 14:21:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260916-libbpf-elf-entsize-fix-v1-1-cf181da33eab@gmail.com>
In-Reply-To: <20260916-libbpf-elf-entsize-fix-v1-1-cf181da33eab@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Sep 2026 14:21:38 -0700
X-Gm-Features: AcwNN1XzwqtWdeJgbuV9zPdlVdvjEoesg8GnBTaO-nRymcMgrDnquh4ZrZ7CKM4
Message-ID: <CAEf4BzZyqEFtxhPUxmWyBO_gEW6UXY033VnHa2qk1dcfNZjjEw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Validate ELF symbol table entry size
To: Luis Vieira <luisflavieira@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 2:23=E2=80=AFPM Luis Vieira <luisflavieira@gmail.co=
m> wrote:
>
> elf_sym_iter_new() calculates the number of symbols by dividing the
> symbol table data size by sh_entsize. A malformed ELF file with a zero
> sh_entsize causes a division by zero.
>
> Reject symbol table sections with a zero entry size before calculating
> the number of symbols.
>
> Signed-off-by: Luis Vieira <luisflavieira@gmail.com>
> ---
>  tools/lib/bpf/elf.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/tools/lib/bpf/elf.c b/tools/lib/bpf/elf.c
> index fe136d025967..ba0b3df37a59 100644
> --- a/tools/lib/bpf/elf.c
> +++ b/tools/lib/bpf/elf.c
> @@ -118,6 +118,11 @@ static int elf_sym_iter_new(struct elf_sym_iter *ite=
r,
>         if (!gelf_getshdr(scn, &sh))
>                 return -EINVAL;
>
> +       if (!sh.sh_entsize) {
> +               pr_warn("elf: symbol table section has zero entry size in=
 '%s'\n", binary_path);
> +               return -EINVAL;
> +       }
> +

modified as follows and applied to bpf-next

-       if (!gelf_getshdr(scn, &sh))
+       if (!gelf_getshdr(scn, &sh) || !sh.sh_entsize)
                return -EINVAL;

-       if (!sh.sh_entsize) {
-               pr_warn("elf: symbol table section has zero entry size
in '%s'\n", binary_path);
-               return -EINVAL;
-       }
-

>         iter->strtabidx =3D sh.sh_link;
>         iter->syms =3D elf_getdata(scn, 0);
>         if (!iter->syms) {
>
> ---
> base-commit: 10c4f610b215bf961235141161992f010cf7e451
> change-id: 20260916-libbpf-elf-entsize-fix-a0f9440e79c7
>
> Best regards,
> --
> Luis Vieira <luisflavieira@gmail.com>
>
