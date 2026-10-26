Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793033654;
	b=rn2tPmL2iCL3Uan7LOJJcjTbE33Yiwco3mk+zZ3Wp+ISicLEBrKUWxNONoE6F1hDBKCK
	 YXwthm22xa7NO5LxF0ym/ymc4rCjiDE8BvSUhHmzD+HD8K9qmwG7nYdJOybAvECTkuzIi
	 HrEaB+2nYUxSxJqq+ux/5oWL1Onod7z6zAcz/M2pmFNBbYgqWkGK3h0gtEtRlaTMo1SV3
	 J5+VmPSpwcscP8VxQIOsV/xnDapStEqDRncwi4m7PLAE9FtoiWz26Ru0WnN647EGQJ7Vg
	 p89IRxra91dkw1WlEOi7fmqKmXdQyj+wVZUP/dmSzsIFM9+dFCrLKgrzk8KRQNJI6JA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793033654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=pUCzC1JnHO92OgM+auSqMks9n6RMr04kDUdUsaiOXYo=;
	b=GXsGqopyRyemtorOThV/WiICN5SbDXWypgCCgtpRlKcjfS/EEs0nW9HZTEaTthCRDn8Q
	 O+f8iNBwVM2LoK2FlRIIohpOMz2xwbQtU0WM3uX/ShxM1Oss21VIpFo4gqnRe+fqWIzbG
	 KvrqFWGvLDTFVjfDgqIyDoM+FGu46o4cO6AP8cuVO1krbIcb9YfbEpI4Unr9uHK4MHkpy
	 qRIrIVH5oyo1QzXT2QYL+1+eGwWXHkvpgvPUPrPe7LSWkv5b7Qp2Kchn7v5d8aXW6qXXw
	 sB30r5WF1yO7rQifm08YmSjuQnl6v95FoCREBP8duI6bVNvjcepM+f9J8aA0jJ+H1wQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cfBeBFYw;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.216.54
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404B4606A31A
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 16:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 404B4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=cfBeBFYw
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3aded3c6103so999498a91.0
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 09:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793033653; cv=none;
        d=google.com; s=arc-20260327;
        b=UZWI1TzcUs/XxMCXM8qLg/Z8eoEue7j2LDtfYO84WLiqv/ZzKV0uXKjlnJ/HqW8eia
         ezyc9kGsu3RSDpEdSZ05b6g6/aS8A+qHzOfLa95EDxcWy4itxN7wlTJeVAXY014KGvPV
         NoAq+fjii/bH9bajGvOhqeVb8NhIfZntRxNgu1nR1KKrAicSAEddSRx78dzbG8NBCMuw
         R44pOHecnBmrNvS1pUIzrs9b35tT7aFKRddLcUfi+oA0iHMTYMj7ysTE2cexJKcaBgJf
         jpj0dtXqFIHIejaPwgs24kYTy9B1EEAT5mtD97QgAS14XLuZoEtJlYWbvAs06r0N5eg+
         R1iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pUCzC1JnHO92OgM+auSqMks9n6RMr04kDUdUsaiOXYo=;
        fh=R8BU2yF4CrhD2szyM+OdVFJqHyACMniUSKqaOjdXodo=;
        b=OG7Cv1nZIWRP63XJ5fvDDKsIKu36sC9Pt/tUr0OtFkx41b/BxxXCzlwLtJx73/Xl07
         KlroW7TxmZf1aVqkeZYqSw/7JEMEVYILk6wEya3+qocLDkVNh+U6ccixMoHCpSPdn7bm
         7o+CycS0hp3VdLZz2eDd+bGnqXAlnJghJb3WNumM7hBhTGAiTJbgpSP+03AVV2hr9Dw1
         IpegDFqq1hxKd40DtWCpYlwNzda4h+pSZjpQPPS9kZlUVo5baPK2nK/SvB37Ya9K0xlf
         yNxhZxanKWlqp+MQi4tal9MWgjS8oS+ps4MAbN5ULteRoZ8tGzNdWQU90+mBipp9s0Bx
         E1tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793033653; x=1793638453; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pUCzC1JnHO92OgM+auSqMks9n6RMr04kDUdUsaiOXYo=;
        b=cfBeBFYwqeKObrzwuBymt3BPTcobR2OUXKdyUoJF3H7pVuW4i2zxstdU3CNrg48FYp
         ItBbk/1se7g7iWAEYhyLU/t6AIVLGe3BPS2tfx4ib5VVfXVESkB+rI0IRulF4fEBr+vE
         gnq5T/qBnHPtmn42IPYtN/fEcnvCdMC9Wl8MJ6EEyNMja2TC3e4gkBLK6nFp7MGX9Iac
         wxMvdcu5giN/FRfJnnj+ELERfMpQGxN1Nk4Mgj+nscTFrzUXPth3i7nUFaedmDWgB5if
         1KwsH/TIWmraO3W5PekiDdfxSyQ84IB400dAmiHlYHURM4gUdX8vwHPDspqpZ6AWgM8e
         ncsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793033653; x=1793638453;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pUCzC1JnHO92OgM+auSqMks9n6RMr04kDUdUsaiOXYo=;
        b=Yd51uqpbgNbFBpaF7u3UvGqVUsZS1/z4OTbck4IOMgOD0sg9uy4P2bEuGwriQVGRb+
         qJsZtwk8IdDpBRWOsN7vcD3KPB3SS14OMcKJP/3ixya+vDrT74/wSGBdioX0JLc1Pcvt
         7V70VqrXQp4LezUtw24wFz2HXH4KTZFWy/p7XpFKgHebCJnRw9lKZDdHL6D8amkxiAE7
         78LdwVSB+kiE663Zs+PQ3LdVcgK4HW2fygJx5uBjo1Ym9QLMdaXBTxiawOIidKYWPIUV
         Z4N0mNF0e7f6muKgormX6Md7e9HJfCvskK+pW86E83yu7GQj1xdtP/00lF+ZR1EG7l33
         1xNw==
X-Gm-Message-State: AFq9FYKuRVldg6oVuZUWbAxBg2t6SNrcjjefSI3xZ21eauijNcYhpVvC
	zaKc+OLJsWLV44+XJJj0LT1L8R3Jr/FmaPNsig1F6ZI5sqAFCA6uYWxrjQnFDYmRF2YuSEv4R+s
	hW7VjZJ9AU7m/mKj30KVeZMI6KzgBhPk=
X-Gm-Gg: AYBFou23Q+7d63xGIZekg3OcOE4I9Y6AeTmimr1Aw7HKzwB9mVL57RbNsO5ftvmxnlq
	oLEOglMQa/H4kq+tYHJv/sJ02U5Fm7qYTPHPdMEH6lv/KRaq6tfZIswuvNdgS87KeKabpDeS05I
	LvPl+hQQ6OmWReJHyLD2gRL6ybWd9JAg04YIZf61RtquQyuL4xI34VuCeAIFjlYbtGU7jHesoGF
	2L5dGvfEOjkJioeI7Fratv/FHpErGpYQP3GlNveXyLp6EjxAZf0QvxS592Y7JLMe8aW5n4wEJ3z
	sEGzQ22kNdacUKykImhxgnU9WggklouPwj/ZToo/OydEsxy4c+3WtX9mEW1VMRHnZhIIA0KXd9L
	Z9RHO0Dcz9f/AMVGf/caaV3OgDKp3pfiADP7DET9szLn4QI9+IrXATOVdj0wjikpwLdL5fs7Q0X
	AoZ6XQUAurHdmnVF4GI9bxoNquNDhqkxjsxJc=
X-Received: by 2002:a17:90b:4a44:b0:3ad:818f:3da2 with SMTP id
 98e67ed59e1d1-3adeb195cfbmr5351189a91.63.1793033653373; Mon, 26 Oct 2026
 09:54:13 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026025943.404450-1-alexei.starovoitov@gmail.com> <20261026025943.404450-17-alexei.starovoitov@gmail.com>
In-Reply-To: <20261026025943.404450-17-alexei.starovoitov@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 26 Oct 2026 09:54:00 -0700
X-Gm-Features: AclHuK8JvXQpCb71Z_NInGpv_WnyvLbP7oDusLRtUesBXyyR1uEEiD5XKimNR-Q
Message-ID: <CAEf4BzYrpYHS1V=VXF0PTRXkXQo6FnseWirR-ka-O9wKTv_GcQ@mail.gmail.com>
Subject: Re: [PATCH bpf 16/81] libbpf: Make arena 1 Gbyte when max_entries is
 not set
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 25, 2026 at 8:01=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> max_entries of an arena is its size in pages. The kernel rejects 0. Thus
> each prog must select a number, and the same number is a different size o=
n
> a kernel with a different page size.
>
> A large arena has almost no cost. The kernel reserves 4 Gbyte of kernel
> addresses for each arena, small or large. Only allocated pages use memory=
.
>
> When max_entries is not set, make the arena 1 Gbyte. libbpf calculates
> max_entries from the page size.

Why 1GB then, why not default to full 4GB size? And also why not teach
kernel to accept max_entries =3D=3D 0 and treat it as "max allowed size"
and set it to 4GB (as of today)?

>
> libbpf maps the full arena into the process that loads the object. Thus
> VmSize of this process grows by 1 Gbyte. If the process called
> mlockall(MCL_FUTURE), the kernel populates all these pages.
>
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  tools/lib/bpf/libbpf.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fb8a1f07c5b6..1d4f04aa35f1 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -552,6 +552,12 @@ struct bpf_struct_ops {
>  #define STRUCT_OPS_SEC ".struct_ops"
>  #define STRUCT_OPS_LINK_SEC ".struct_ops.link"
>  #define ARENA_SEC ".addr_space.1"
> +/*
> + * The size of the arena map when max_entries is not set. It's in bytes:
> + * max_entries of arena is in pages and the size of a page depends on
> + * the kernel. Only the pages that are allocated take memory.
> + */
> +#define ARENA_DEFAULT_SZ ((size_t)1 << 30)
>
>  enum libbpf_map_type {
>         LIBBPF_MAP_UNSPEC,
> @@ -3148,6 +3154,8 @@ static int bpf_object__init_user_btf_maps(struct bp=
f_object *obj, bool strict,
>                         return -EINVAL;
>                 }
>                 obj->arena_map_idx =3D i;
> +               if (!map->def.max_entries)
> +                       map->def.max_entries =3D ARENA_DEFAULT_SZ / sysco=
nf(_SC_PAGE_SIZE);
>
>                 if (obj->efile.arena_data) {
>                         err =3D init_arena_map_data(obj, map, obj->efile.=
arena_data->d_buf,
> --
> 2.55.0
>
