Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 781B1282F1D
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773671401; cv=pass; b=eiOHgl1xk5nPg84Y7PBhLVsT4pzqKFrhee3ps7zlp4DFbNX09T2MKXIIRBz668v7z3bTwgU6ZwiJ9g8t1Kr9mcwHMUQw4mBgAVz1fclgUB/8BSOf/aPWVie7R3umm5UT3eBkjDJosTnz/6VnVVTHplg6yLmvSiLW5vJ0t5N9ZbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773671401; c=relaxed/simple;
	bh=rJRFS+rK9leg5GTdMzhBulrcz4gOf+cJLikV/upD6AI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsCr9PTYZGPzjnui7uvRwJs+pmDMKAgmdZWjFPWHeEWriQUo+jWvjGpqmy2E27GNv1i8dplt7+dCLcTN9Pb496VzSbXEWzQJG6a48ny2ElbrKiDgb9xdGYdGmGSufBmmawX4mPQmNoiT6TK+18gwBztYsKwxOSKfgzrrnINQ8UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWghmkLH; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWghmkLH"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-439c5b40f60so3632284f8f.0
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 07:30:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773671399; cv=none;
        d=google.com; s=arc-20240605;
        b=kMV9tNbO38LepptOayJG6uNgb4P2q93TS2wko2j/VfBuRImwW3OodaMy/jnVLgADq1
         2tpfLBnZx/QcYX2F9kz/9GC1Wi3CpkKPiNDqt3DL/0XujSj5XtZU7nDZs483HQ34HSCb
         RvNPpXfbY5Ls0CEEuBfJVmGpGq1AWCNxEMGvppB/E3G2yXsZ8eTV/OoULIEP8OPo4icW
         rT1dMHHVYtRxtQajBvRIdibcPtNB2YamlujlRN/bS+DUd1piWtspTRMCkotxpRiqpbx4
         lRILnG+bGyq7DlEsqMF7jssunhT3wmdnlzm7nNm1yCwgqi0lFgRlaMji5eCQ2xnFaqpK
         PNnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b8O1jcNEYGgYscyDPYtdi391cu8OxzVlX8P/V5t1fLY=;
        fh=WtwE4fSxFvRJns8DXeS87bpoRiXwz8MXlfC9xIyBUw4=;
        b=Kq3gvwfLrJc63YyojJQVm4wVELRFvg07IOMi63TzoPhQW6t/cwVIpUfLowjnuMoIvb
         QlG3jj0MIZSoqGA5KZ81LpA+JAhDPA0rXo+FH0mabiBERKqm+wfOm4vzcVv6lngWmrad
         kC4QVofGUS9q/wGPF3tGmUa7InbQa/jMBsQ+Mfoea233IYSeX2Whzvewi2bOHHcwAGED
         +C/r4xqJxXMXPOWe+o6GF8wCr19CZ8Ls0tOAVG7y3FUzXi1VEkAr4dDMgywfA6FvhkFn
         uC5tGuziB38ZiJgIPvgHXsz5wNKOARCB76FUjfSLeWHMHX8DXi4lXTUkPgyMe9gZtbhz
         NVbw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773671399; x=1774276199; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8O1jcNEYGgYscyDPYtdi391cu8OxzVlX8P/V5t1fLY=;
        b=fWghmkLH9MDk/jsLw3gQlzKnzQ/FrP8v3FHykcCGHU8nMKLcDqV1GsL3hZsuF44RUH
         /seiDrM8IzRen6N1c1TfJIKQsqAz99kbrMkfxTPfPswtVMNB77ZfrG28uywbFkGNcQdp
         SIZ8vAaXcA2eIwcZOLCkD25ghgd8ftxmazqiFqWrdUQ5XDsLJkvzhNZLFBD5bw0GNFXZ
         I9nT+7veYlgugvho7eVe86nQcNEnAorkNNq9zF6uQKFJZdvNnBvEqFpWP6bfgdmLn3Pd
         l+FLxD+/WBH1aes90irKKXDoJpqCKOhz3EEBM2M7x1fyhdyRQRG4+DtbTYQZY6CuhqFw
         6TIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773671399; x=1774276199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b8O1jcNEYGgYscyDPYtdi391cu8OxzVlX8P/V5t1fLY=;
        b=dSyLWW9+IXbiTzdMZrYrPdODHJrTh++XHC9ToHbK2wZ4wDkpacqyyXEAnDROPxe2LQ
         /GuIl8wm3ta96vHUWZTsJrAmTD54PuKSqP8Kqa7RI+m8FBzhU2m/UPq0PAIbymlZlQqe
         xZd0pe1lZeqJAbDwGaBJy1eYnG5FXDZtEfXq7rGp8ZeqEkAaz7a27QlzYpoudaApQBxe
         UC35j0DnZ1E0nTIPDP8S4uqDxpIIwnjsL54i/r7dGJVHooacTYOZUgrCrJUm5Nbr57Nf
         KQ0DvbAUYUlKDbx+NA5E1srDTtqFP1z7/RfczAVCepk6utHIMa5ZfYgCMs5XjYSe8r0A
         sayQ==
X-Forwarded-Encrypted: i=1; AJvYcCUucWxCrCTfYtoxjMZxpK9VNMBxS9f0HS7axEpFwZlLxDing/G/QHWiIMtiLxKGWmH0SV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGS31zLkdmqmuJoFowfZPw77r8u5FVtu+LKvnKMotq6G4/Hl4B
	nXx402FuuDdpJbQaFPoAYErAu8J8uRSIzamF9UCUPPp5N2HnAk99/I9hLLKbF0DuwNbN/4c4GBA
	4HCAlj4Lu5Hbogshw3cOJyEwV1+vxlf4=
X-Gm-Gg: ATEYQzw58lhxiRoXcr5D52vok4i14JxMbh2SMVD7CsvP7oA/VIdXQP9UgpPxn27Lg4t
	njKI43mLQISl6n8CQxhtjpgN2yk3AlujDkEDTYgSKCf+K9IewGqIoQVfcVH2MPwT6gYuphGX+oD
	aAy71ZPyfqi+CfRkBDZOdqRQyznv47X9xXGvdtb5YvU9tilVLZOLzA7b97esEw84oxhx08l+J+b
	gs3oME4IhoFXnxggATUWzRsaEJfBxhfB+YFu0peJ7cqjwlMUm9NFuUyKCWqh/FyIwWUXPWYLtF+
	Lnav7SAmlWVgMW2qGTnSSdDK/PA/Jli8F5veLPxffCk66N/jxRzxFS4L0lxeo8PJvto=
X-Received: by 2002:a05:6000:381:b0:439:d8cb:1392 with SMTP id
 ffacd0b85a97d-43a04d91a43mr25216111f8f.26.1773671398558; Mon, 16 Mar 2026
 07:29:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260316112843.78657-1-pilgrimtao@gmail.com> <20260316112843.78657-7-pilgrimtao@gmail.com>
In-Reply-To: <20260316112843.78657-7-pilgrimtao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 16 Mar 2026 07:29:46 -0700
X-Gm-Features: AaiRm52jfrG-QXxCpkn-e4a_CxQ3E_JeYlW7Cp4Cm58pDy-9uGQT9qrmcAXzcQM
Message-ID: <CAADnVQKLsC2=RcehL54yHQ-vv0poXydFkRDHW1JZxAEncE=SxQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v8 6/8] bpf: allow bpf_list_front/back result as
 the prev argument of bpf_list_add_impl
To: Chengkaitao <pilgrimtao@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, Chengkaitao <chengkaitao@kylinos.cn>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 16, 2026 at 4:29=E2=80=AFAM Chengkaitao <pilgrimtao@gmail.com> =
wrote:
>
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>
> KF_ARG_PTR_TO_LIST_NODE normally requires an owning reference
> (PTR_TO_BTF_ID | MEM_ALLOC and ref_obj_id). For bpf_list_add_impl's
> third argument (prev), allow a non-owning reference with ref_obj_id=3D=3D=
0
> so that the result of bpf_list_front() or bpf_list_back() can be passed
> as the insertion point. When prev is such a non-owning ref, skip the
> MEM_ALLOC/ref_obj_id checks and jump to the shared list-node processing.
> Owning refs (e.g. from pop + refcount_acquire) still pass the existing
> checks and reach the same label.
>
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---
>  kernel/bpf/verifier.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 98ddb370feb5..0a6f2e6a5d28 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -13737,6 +13737,14 @@ static int check_kfunc_args(struct bpf_verifier_=
env *env, struct bpf_kfunc_call_
>                                 return ret;
>                         break;
>                 case KF_ARG_PTR_TO_LIST_NODE:
> +                       if (meta->func_id =3D=3D special_kfunc_list[KF_bp=
f_list_add_impl]
> +                           && i =3D=3D 2 && type_is_non_owning_ref(reg->=
type)
> +                           && !reg->ref_obj_id) {
> +                               /* Allow bpf_list_front/back return value=
 as
> +                                * list_add_impl's third arg (R3).
> +                                */
> +                               goto check_ok;
> +                       }

This is too specific and non scalable.
Another kfunc with similar requirements would need a separate 'if'
with func_id =3D=3D new_kfunc and potentially different 'i =3D=3D N'.
Let's introduce a new double underscore suffix for this
or some other way.

pw-bot: cr
