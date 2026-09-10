Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6DF513576
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789064329; cv=pass; b=GhGI6Mw9KWEIMJSny6YRaft+BZLK3QTUKiPyXm/FVA/tI/srTWGj/yMsmGqdVEEIgRYBwd7RTsuCbbZgT5aV9uEHQNG6lOOHJKS3PrlxLRtu6On97Zeuwy2OS9UrMVJS390E6JyOlHGR5IP3VRNMPrCjbxxPw/NFzpRB5nJh188=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789064329; c=relaxed/simple;
	bh=ISIfoa1VRwTQjIpK+hxvC4tDAoHyveatCbi/M+4SjQM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t2ouSqSJ5+x0F4GAvBw5aQGCItqtJMHZarwxzC0pziWRSsqp8MCQQa5b3fs1FXmx83IgAf0fFKK0swFxUYC80wRsO2X/61XHQ92DB7ZAlJ9vfXWBG2PWV/tF++m84wX+48PAOtl9ERgHuil6EDl6+FNZ7RRpTpI7YDTTVt/KR30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aqSAR0Fc; arc=pass smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aqSAR0Fc"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-6bd07679624so160303eaf.1
        for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 11:18:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789064326; cv=none;
        d=google.com; s=arc-20260327;
        b=e28pOt5wuOXP+C4U9jq2VYI5mJ+UnjNPf4LdRLnfz0wwq5XF5CwaB4EHhe6CysAd4c
         ad1Trq1dIP3I6A582Lv1H2h4a/cCHIYkvwKbfEqipw3BAbjIB6Gg4pQ+tRT/KD4Skm2H
         2jhk8nHL2pJFtGeviZGVS9QHLYAyroBLT1iqRnxHC4NJcq22DXUObgRSZXSbIRphheF7
         kTrotQ+uzeHUzlSo9H1bG3U6d4MumZX9XDUW5yt0r5HN5PJ570cHUdNebutBSRJTsglY
         mXlMUAKF06P+PjH+uEYq+kTsJo9hvKKaWMBNpE5UmURvFDMTcn6D6yaRnbut9yp8bvKj
         BPjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HdWlLgJ8/V7xB2th0sWe9mpqwZit9bzE41yesMRMbK8=;
        fh=b0nTke/dWNZNVxYYun7OzhjBPrEmqbca3P2CX/fBOFk=;
        b=TmgMvsOxMjAchCYthi6YOIX4rjynL6YalrbjEe2SphU1Esj+G5yjZovmJiPhGJlP6s
         +OQr3/K3zbxTvMRuF3gRGAVyJ0T5WUTRL8QXe3as80xg84OKGUjmN8b2MLeQIWBWve9E
         7nKkwhi/DaigIMCApEa6F2qzQfy0N06VAlsY1czGNsgBMK0mysaHjB7CgHIQbGWyEhqO
         SuGW1xVegp1ED4/4gY3QnBPwKyhY1WcE/6YJ15puKzJhwzz4Gz+SmTjPyRNeZTfjdZFn
         5jBPJfGMreRt/pjzAulfmz/+kaEQbxICY2yqIzSE2Xh+3FDY4Nvj0yoTTgLgVBFRDpzC
         g5RA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789064326; x=1789669126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HdWlLgJ8/V7xB2th0sWe9mpqwZit9bzE41yesMRMbK8=;
        b=aqSAR0FcOIDL7qqXVzlHl6TgUswyZM9OpQUJVTAfsNUUDUeJSq56PattsuSu3cctod
         nXfcnYJ8aVfbNGUkGplB8NxEXhTE6z/2oWUVGdnffJjQqQmrpvYMJ/tQohCNRaSlCIrj
         1Km0/kqX+oF/fVwQVYJYsMTAckm1alJWeytsdH7YPOEU+l4381l9Vf58XCuQGQ2ITGib
         qWn5iLXLs3c2EJAIDKZfZD9J09dZjuzvl+6Z6FGSedAaaCPEwvNIlEptYo/XTToOmlbN
         bYmRkJq5Y6cpy7a3SgRWAeO9ZJWnX9lT+0FaUFoAMfyQv3Nk8Pq6ozdlw+/3pS5p2xgE
         wOjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789064326; x=1789669126;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HdWlLgJ8/V7xB2th0sWe9mpqwZit9bzE41yesMRMbK8=;
        b=rKfzWh7Fq33BwGWLb0vxn/AjxGZ+4tgJVm7zosVbxhdQLwlqVWZi5vlFUIQ2QOVM6D
         YCon12fCFlCUswiz2l1wTIq1IGDRZ5WzBHOQmhkK1j1ZL5ethGXSFr1CZ81t6Y2Jy/iF
         WJ124kBSQkBEl4iRq0Z17wkELO1RmbwJSQB8GYl9LKOvqk6Nd0xVr+yfBhtZg78PlLmd
         7iltVmpdNfnEsODL37Scs1hc4N54yKSJoRhgqso6B+EXotosc9xHr6VQXesv8hq65//8
         n0pKreof9dqyWvtNGvyn2JF8Cyfgii/7eJy26SOM/+YooleX/GZPc9D566SuMxCTEw9c
         35zA==
X-Gm-Message-State: AFuF++lysr1WcFUIC6MAugxTW3UkvIYUHDeSS7E1K7AW4du1JTH8Wii5
	e+gNmvM25haGvl1BZwA8bMc5M3HMapUVLGrGn1S+PXgcl4v2mMqKqgLyDVRN4DOT3bq6a3ne34f
	yiDWihcR5W+nAZuFbjdmrP9XhAOaFXvY=
X-Gm-Gg: AYBFou0R7nYFMBqSMT3cCr3lk2k33Iy3GAfOdSl6C3ty/xz6bX61jCIXjXBjKcuXv+C
	Ud67+5OGetClulZHboymdCytDhpJkLU5k5PUmR7CbXRxM8rBMz3mbU8Mqu1D1jsXmylBcWJncaf
	bzHlsyLx3pzhDfZA1VydcZJHlWNaGEeGjRrxZ9sKGN4EGlrTfO1ZEWuVDv1wikD9pRksJKABxZb
	XVRnWeeOh0mK2gKGUbJ+dbODkYKJNYZy0p2c1nqPuTnr7VaaxXY+pbNFt3tTt1Ck762Fw6u7npK
	6dHv99IzoiJrltkUUZhCifQSBL4nBUeIIEHx7uCRbCOV3fQKs1RIXbo=
X-Received: by 2002:a05:6820:4d04:b0:6be:7782:5a5f with SMTP id
 006d021491bc7-6c0ba245684mr184408eaf.5.1789064326133; Thu, 10 Sep 2026
 11:18:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260910044021.2279628-1-xyx2021@mail.ustc.edu.cn> <20260910044021.2279628-2-xyx2021@mail.ustc.edu.cn>
In-Reply-To: <20260910044021.2279628-2-xyx2021@mail.ustc.edu.cn>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 10 Sep 2026 11:18:33 -0700
X-Gm-Features: AcwNN1Wpi8VAzEUHWps3WWgehY76GZSBf_rJKmBEUCDgtxFqok1zotYvKd96K_U
Message-ID: <CAMB2axMV4rZ_Mb91OdzGH6T4Yym7nB+wz+EtxP_wUEniwA+EzA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/2] bpf: Invalidate iterator-owned BTF pointers on destroy
To: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Puranjay Mohan <puranjay@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 9:41=E2=80=AFPM Xu Yunxiang <xyx2021@mail.ustc.edu.c=
n> wrote:
>
> Open-coded iterator next kfuncs that return non-struct pointers associate
> the returned PTR_TO_MEM with the iterator's reference ID.  Struct pointer
> returns take a separate PTR_TO_BTF_ID path which omits this relationship.

I understand this patch ties PTR_TO_BTF_ID results to the iterator
reference, matching the existing PTR_TO_MEM handling. But does the
iterator lifetime correctly model these results?

Current PTR_TO_MEM iterators return iterator-owned storage that
remains allocated until destroy(). In contrast, several struct
iterators release the previous element when _next() advances: css_task
, kmem_cache, dmabuf and task_vma.

This patch therefore leaves pointers from a previous _next()
verifier-valid. Should non-RCU PTR_TO_BTF_ID results and their
dependent pointers also be invalidated on each _next() call?

>
> This leaves the pointer returned by bpf_iter_task_vma_next() valid in the
> verifier after bpf_iter_task_vma_destroy() frees the iterator's backing
> allocation, including the VMA snapshot.  A BPF program can therefore read
> the released snapshot through the stale pointer.
>
> Set the iterator reference ID as the parent of non-RCU PTR_TO_BTF_ID
> results from iterator next kfuncs. Preserve the parent across BTF field
> loads when the result remains fully trusted and its lifetime is tied to t=
he
> parent. This invalidates trusted vm_file and vm_mm pointers derived from
> the snapshot.
>
> Do not propagate the parent to MEM_RCU, MEM_PERCPU, or MEM_USER field
> results. Those result types obtain their usable lifetime or access domain
> independently from the owning pointer. Untrusted results continue to foll=
ow
> their existing fault-tolerant access rules.
>
> This issue was found during BPF verifier testing with an in-house
> runtime semantic checker.
>
> Fixes: 4cbee026db54 ("bpf: return VMA snapshot from task_vma iterator")
> Assisted-by: LLM
> Signed-off-by: Xu Yunxiang <xyx2021@mail.ustc.edu.cn>
> ---
>  kernel/bpf/verifier.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 72a3f5998dd27..55ba1be0b6a8a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6140,9 +6140,16 @@ static int check_ptr_to_btf_access(struct bpf_veri=
fier_env *env,
>         }
>
>         if (atype =3D=3D BPF_READ && value_regno >=3D 0) {
> -               ret =3D mark_btf_ld_reg(env, regs, value_regno, ret, reg-=
>btf, btf_id, flag);
> +               enum bpf_reg_type reg_type =3D ret;
> +               u32 parent_id =3D reg->parent_id;
> +
> +               ret =3D mark_btf_ld_reg(env, regs, value_regno, reg_type,
> +                                     reg->btf, btf_id, flag);
>                 if (ret < 0)
>                         return ret;
> +               if ((regs[value_regno].type & PTR_TRUSTED) &&
> +                   !(regs[value_regno].type & (MEM_RCU | MEM_PERCPU | ME=
M_USER)))
> +                       regs[value_regno].parent_id =3D parent_id;
>         }
>
>         return 0;
> @@ -14105,6 +14112,9 @@ static int check_kfunc_call(struct bpf_verifier_e=
nv *env, struct bpf_insn *insn,
>                         regs[BPF_REG_0].btf =3D desc_btf;
>                         regs[BPF_REG_0].type =3D type;
>                         regs[BPF_REG_0].btf_id =3D ptr_type_id;
> +
> +                       if (bpf_is_iter_next_kfunc(&meta) && !(type & MEM=
_RCU))
> +                               regs[BPF_REG_0].parent_id =3D meta.ref_ob=
j.id;
>                 }
>
>                 if (is_kfunc_ret_null(&meta)) {
> --
> 2.43.0
>
>
