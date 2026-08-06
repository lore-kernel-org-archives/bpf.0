Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4785485CF7
	for <bpf@vger.kernel.org>; Thu,  6 Aug 2026 17:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036967; cv=pass; b=ukFV9oiSmaO2ZvHVWpPQKz5VXiG1HKpDbcrKTxPJQtxrbebUfmgWE9ewbH4gxgMggd/9+KjCmkB8NdhFkKBCbHqiXuU36G82/oFgwFflF1pRuxzsNdV9lwmaduJmru4JZncJcnB+2VkQZBoZdJYsliu5NNqFUfW7slpOA2q2Kf0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036967; c=relaxed/simple;
	bh=6pPO7myojBmd3GsKjsQOGiu/Sh3uZD/65xy3n1yReF0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ozml3LeIFzthJKvODryKGUzt/eD9s6oIw20dmmNCKkxJOO9WpSq+EAik7dOLBwOmdNKQHJ8AQsdrCbF7zjVM9jJ6uXOXJ/vkapNUrz0/5gr4kihU1Yg1ecTHCZu+lkK+pUXQ4wDipVm2/Mww4GTbwpyP22garH9o1QpdjPrcq/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R7fPckSq; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R7fPckSq"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ed073fed0so32449077b3.0
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 10:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786036962; cv=none;
        d=google.com; s=arc-20260327;
        b=r28dTa7FKnhkzpF8RLthuoJ1kajO0lPHLmJaZRaCxLlahAJNYjOuaFkhNEYSH9xeWk
         5msKWV2DBBRpgGjaMPjVMj+j6CrFLku3EfEjh9hjgoRihjw6RUGVUUKoxiYv1mHXt51a
         w4TsmyiVLbAwyk9JaKNoLRGJIGRXleWkwf6K2TJ8AvfLQ3bbAkhccG1/a6Srs8PNcqDM
         m4V7QyWOYt4sEO7/IcdpoJN5IokVXUTA8wDBl/KKWWTXW3Br4jLTbOFVYQ42ME0thwkx
         y5XpEhMM37izU8pJ3Lt8nJqILqAcWWCpwunae6Bm55SerqyABUpi2s1EjU8nR9oSY+qM
         eT1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GaI2dMJHsaw/bCZftRtrPlc1TmafDjQhrqSofXLJlAE=;
        fh=7K2qWJ3mUiPSelnihIFryY3l1DriTibHaNVcRL5iMOk=;
        b=crtkF7jTsPy9AJmrEiZps3LWcG2788Ek8cwcU63uG929zpRIfxlWr1PfuH5Z8INXY5
         fdagllizZs+nC9yaIxcXr1Dkd4AWypN60JyIoiRKUdZbraBK2Xer8J0EphGwJYoK73Bs
         SZ/jXQBNWw33vZuaJzP4m11yNOKkwF4LCA6AUOHAoYd/nIMege/+H1B7ee3pnJSKIGpE
         cUkZgeBuZzQx9uUP0pEMe4p+JIOaIoIAvNtigtRH/H3dEKfXxYJIFPnqpFXsOX7LgQhS
         scXdMhu6oSeeT7JiAg72pylBrKOPAsARgY/M8MgGikZuuWCAFGhToWiPEJSHoh4zhDbg
         h8Rw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786036962; x=1786641762; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GaI2dMJHsaw/bCZftRtrPlc1TmafDjQhrqSofXLJlAE=;
        b=R7fPckSqSzs0H24JeAOdszMF5BfMCM9vaYYjvUXeXKG2qZMToD4JUbGgOpLIUbpAc9
         +QlybN50G14/BZGFjZcRwALZBHTGGoz7BGrX0IeIYGrLjsj2ZWxKb/b9Lk3WoqfOEIZ2
         00VK2+ucuo1KHIxG0QPs2UBi3GBCCWh9HVDRbDT9YrTGhK80on4AZ0G+aKYVv9SmWBiF
         wgvlgurEGUeIsYABLFRsx5e3iF1LVJCA1byi4OdXFM+hxB1kxqmNZg4fb2GOzydhyYM8
         9ZTUD3b/0NwYvpLEAnmpmiWOpCp4/7JHnlwJvBXv5/VE9cjroh4jGPvR8lFpNiQnpwbW
         2i2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786036962; x=1786641762;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GaI2dMJHsaw/bCZftRtrPlc1TmafDjQhrqSofXLJlAE=;
        b=rSyemC99kaaBSF4WGEZcQPemwhazAAjCnyODti6kkpjGFj0Nnurvb/F31qP1lG7k8s
         QbbKBOflwwTJ4qwbKWH9usC4WMLoVPNr6RYHW45IQTH3nRx9IwrgqR/Q6H7o918WYFp3
         Bn2DLeosE5dpJ4aZ54OwIsvBTbPaQb84oroHiGew+c+Nd8anW/MwivR9utFlMlQpLpAv
         7i5pEJ8uJRr8YmV9bMsEj743sNTGWgoAD6/yowpN1FvpIg+nvQT8GRP4im9gAXnEcymw
         nezEasrlgBKY9wZrK9iFaCQWcc8NBOsyYnH6qxHoOZmWYBSkHPN4IE/iZ+6jadI+yt5H
         Rkdw==
X-Gm-Message-State: AOJu0YwYqSfXSo4bBuLtCBxKa90qgVXB4SOURnvUVC8KeGO2lYd9x4eR
	jZW29cnx6l2sVOANvoeebXBe0AExxmH3h7YEdUCBVQo/zm/oVZ7sEfopyHwwf+GngiFUbp6D0HL
	QSrPVxmfF6C/hVta7m4xsMbhEwNm+oj8=
X-Gm-Gg: AR+sD13pf1rqPOQRl1xNDc7xvP6hERglpMiuO6N/sSFdXvqJNKKN4dwapOlOqE8VSpA
	XRDY0tbxwosTjcMXHbkhodjn5wbzbb7xjz7OzvkifWE0/klfQfkW8nfkeypD6INSWfDVRWdC7zv
	14HBDwVRhVM92EjaA8Ww3e5Vovb9wusw8i+ptn2gXjMM5QetKLITExuxlaqjXz75OfNmpvcw+CU
	ymfia9Zo+2AADF1FNdS1OnmhWx1crn8LvNtUmn3lFl51OIcoSyb9J092yOfLmqi1pxGP+CoQLYE
	uUStV82ar67L4uOr2sLLYXjg8op4pqcO9VOgPWel3dAMuhoUXAXTZXQ=
X-Received: by 2002:a05:690c:c504:b0:81e:8577:d044 with SMTP id
 00721157ae682-820228819cdmr95903857b3.35.1786036962354; Thu, 06 Aug 2026
 10:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805210427.3218326-1-memxor@gmail.com> <20260805210427.3218326-5-memxor@gmail.com>
In-Reply-To: <20260805210427.3218326-5-memxor@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Thu, 6 Aug 2026 10:22:31 -0700
X-Gm-Features: AUfX_mx925P_wPZ0lD92bDpFSss3O_fXaCtyDui3LQrwzdrzz8oTp5TRpcM3Uz4
Message-ID: <CAMB2axOdf7jXcF2+esZqwUVXY407yu7XnkioJXnSU3b0ZsPzUg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 04/13] bpf: Support __arena and
 __arena__nullable kfunc argument suffixes
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Tejun Heo <tj@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 2:05=E2=80=AFPM Kumar Kartikeya Dwivedi <memxor@gmai=
l.com> wrote:
>
> From: Tejun Heo <tj@kernel.org>
>
> Passing an arena pointer to a kfunc takes two steps today. There is no
> arena pointer argument type, so the pointer crosses the boundary as a
> bare scalar, and the kfunc then offsets it by the arena base and casts
> it before it can touch the memory. Every such kfunc open-codes the same
> translation.
>
> Add the __arena and __arena__nullable argument suffixes to make this more
> convenient. The kfunc declares the parameter by its real pointer type
> and dereferences it directly, with the JIT rebasing the value at the
> call site, rN =3D kern_vm_start + (u32)rN. No bounds check is needed: the
> u32 offset stays within the guard-padded arena kernel mapping, and a
> fault on an unpopulated page recovers through the per-arena scratch
> page. A suffixed argument accepts a PTR_TO_ARENA or scalar register,
> matching global subprog arena arguments.
>
> __arena rebases unconditionally, so the kfunc never sees NULL and a
> value with zero in the low 32 bits arrives as the arena base.
> __arena__nullable preserves NULL for optional arguments by skipping the
> rebase when the truncated value, arena offset 0, is zero. Keeping the
> plain form NULL-free saves the NULL test on every call.
>
> The double separator makes the annotations composable:
> __arena__nullable also ends in __nullable. Match the composite suffix
> first when classifying kfunc arguments and function-model flags so it
> retains arena semantics while carrying the nullable flag.

Since __arena__nullable will match is_kfunc_arg_arena() case and go
through JIT + regno check, and get its PTR_MAYBE_NULL anyway. How
about just keep it as __arena_nullable to simplify the patch?

1. No need to introudce is_kfunc_arg_arena_nullable() and changes in
is_kfunc_arg_nullable()
2. is_kfunc_arg_arena() returns btf_param_match_suffix(btf, arg,
"__arena_nullable") || btf_param_match_suffix(btf, arg, "__arena");

[...]

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index b62e77949542..2b7f6f6bbe76 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -10909,9 +10909,16 @@ static bool is_kfunc_arg_refcounted_kptr(const s=
truct btf *btf, const struct btf
>         return btf_param_match_suffix(btf, arg, "__refcounted_kptr");
>  }
>
> +static bool is_kfunc_arg_arena_nullable(const struct btf *btf,
> +                                       const struct btf_param *arg)
> +{
> +       return btf_param_match_suffix(btf, arg, "__arena__nullable");
> +}
> +
>  static bool is_kfunc_arg_nullable(const struct btf *btf, const struct bt=
f_param *arg)
>  {
> -       return btf_param_match_suffix(btf, arg, "__nullable");
> +       return !is_kfunc_arg_arena_nullable(btf, arg) &&
> +              btf_param_match_suffix(btf, arg, "__nullable");
>  }

No need for the changes above.

>
>  static bool is_kfunc_arg_nonown_allowed(const struct btf *btf, const str=
uct btf_param *arg)
> @@ -10929,6 +10936,12 @@ static bool is_kfunc_arg_irq_flag(const struct b=
tf *btf, const struct btf_param
>         return btf_param_match_suffix(btf, arg, "__irq_flag");
>  }
>
> +static bool is_kfunc_arg_arena(const struct btf *btf, const struct btf_p=
aram *arg)
> +{
> +       return is_kfunc_arg_arena_nullable(btf, arg) ||
> +              btf_param_match_suffix(btf, arg, "__arena");

return btf_param_match_suffix(btf, arg, "__arena_nullable") ||
        btf_param_match_suffix(btf, arg, "__arena");

[...]
