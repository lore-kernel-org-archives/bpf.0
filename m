Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 593104F85BE
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 15:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790783711; cv=pass; b=OSjVCaQgTsuO+Dq1EdO/QMVjp2Bdq3O0tU0lfRqBjTuHVrSiB9ZEK1m8ZPVRDMgQNRpbH+4l8rx4Db1pFLR0SoCe44bhTj8pQPjMpg+TLcvLAzlf4phLpZjOynJb9fL57GrkuTdsG+1q0d16HQYnhpVWfhhddCFKcbofkb8pzvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790783711; c=relaxed/simple;
	bh=R4Q9kST2fKyPZcf28pPVfrlZhTiZCMyaGq+/7TCxRsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hAPLWLaEGCBd2ggwCXII0nuKFA2iEqo5z0Ad8qP1EtC/nxzUhHErFaH+eRE/lwg4eBI6Cl/WIeOfofG2Y61pHRUm405qDab/tUWTSn3vNqdOrua0F4K7ZeFzrWbqk4+YUaYjE7D4OA6qh7JU71ZkxzGKUubLf8n23Cw93nxqvas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FMbLnN97; arc=pass smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMbLnN97"
Received: by mail-pj2-f39.google.com with SMTP id d9443c01a7336-2e2c7eb3b8cso10070025ad.1
        for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 08:55:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790783701; cv=none;
        d=google.com; s=arc-20260327;
        b=Os0JTu+q44CYLBPSye7ApjAZ/LuFSxd+PFKDK8KSNp809czv5C8VcgD+X8+zh/3Mex
         oomKM8lwoXNZFCVcTTiVmurzxwog54y1Du4V/JvqIkxIAMJkDGSl3R6LRM4rQRgPSVQy
         y56pBsgMog05dhJMDHFuTT/J4tILr2vtJXqck++OOg2ijwmVPelExa9YNG3vE6+ydMlM
         v2rdUgugalRub8PKLZ58MXtdYre539fNhRhU0NNDs62aVAetItppJvvK9+d5zJJWHV+p
         EL3iKC0956GAyoiLE+Sa3SmfpHu3NdzKdRELXkRa0za3j1QVRQ1aLhXwxPkNdDzXU4hG
         zxFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AzYpaD+uTPvrogD/aZ+s9EWcQbyRUEaKyQXD8umEsLo=;
        fh=oYKEm7v7V+NgZJdnRCuQHpGzn4nh7OWj0T5DwFBNLyM=;
        b=XgMl1EXU9oRt9PcRCESi05I0JnKWMjRXLaDc2vkBirT+pvEf8ceUaZB4rsbp45Nz9X
         ruDQFLlaa4J6NttajhPxH9yBUpN1HXTTsymPEY2n59c1NLY+Lkjt1RHvXlwnKbVjAj1X
         YKjJEDxssDkmmiobXmUFFCIsmGTBjhYvDFYJf9qV3K9kb6X0VTBkuDtVOQ8LDoaTc5lV
         Xc16tX5krXOvS2Tx0rdbmwq/6n49vpyZ5bJuub5/6eM9KCuRTAf0QC160qr38jqCDR7s
         oIH6MllzW+/tf/2S0HfWYaITicCpnFRG71+0MU8OF8F1jvvRhEu2BZHXVtoDkcPg9In0
         uUZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790783701; x=1791388501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AzYpaD+uTPvrogD/aZ+s9EWcQbyRUEaKyQXD8umEsLo=;
        b=FMbLnN97rof8pVyql3pYRF0Gnvk3EwNSzNWGM8bjHAtz48AKR1UWxjdTun8ocpEc96
         NbLDnKFHjYzcGithV5oWS7/bvGcsf8X2JexhWzw3siJRhK3Z6Evi/vMgCHcY8s3Fb9Rn
         hfxUz5tYIVkpAL14eRKXdUisTTjxIblU7JjhYC2/A0ZieSyvcqGSkQgioqKDD7mY7e/G
         Mr8lOw6m/mbtSAHq5HeKP0Xmg9hraZHkKiZuNGhpowqb9mUa7SdF3ihUcNV+FqzZ0JBY
         jPN/llR4kAkvQ3ai6NNCbbbeKY2BKVxmhq5ZI/TfEvchAzUlF3i9NxzUF/1zHrhFbS3m
         HgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790783701; x=1791388501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AzYpaD+uTPvrogD/aZ+s9EWcQbyRUEaKyQXD8umEsLo=;
        b=LKtnqOcJ2367oXttGDlF5+f6Ie1zh+FzE0RAfVay2MiOcQKxeh8xCYjCcNETrEXukt
         HKGTwEVW/nDHnjCC9wNlp7Iufwwv0ZvxaJXfnW1yqYoETLPcrtsPRATPNxObrC/Jdv4x
         qPIdfrzkpkp+/+o98/KWKeVcEYRGCr4FjZXn+TOt9obUXKNMdnjNJlPB6wQP/YI4CuSY
         huEh0VHrOr0KzwryLQcrlXYo56VRZS6We9UyQRurpxllLFwPAJXXbKMt82bIKrttGSKm
         9rCARQIdpHk5tT2hKNkR4MY02kTMi8K7A2z4ystZJNbxz8qTu7kKy1xJ21uhu0tPyxu4
         gkPA==
X-Forwarded-Encrypted: i=1; AKwUvBza1dEK/ILe0AvvrRLyjoal7Y6R91hJ56goHUeZYo2DnJr3C8i+nvd3U72uUm/umpOIRAM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLak270rC2Zr8qiEC7u6n29chM6L9cAecNsHNqapMFBBWUsIxBz
	8CMc4QWnQVNjwYjrq0X1AJRzesXgMWsnSRP0Ksrv8nCj4DweE/jPQRVHLbBc/yyfWCJH/QKIzy0
	rQyyIMNjmQKKRbcLS5dtK3GFEdoGa2mM=
X-Gm-Gg: AYBFou0jInyN2A2D42sBJO975XYHZYdgOjX8zDiLO5a6PaGDEEpTYhrzUk64viBB/rD
	P/tfSOII/F2WNJ6TY3s+I/ebH7bQ4HuxsMq8SM5ZnwC436K+Ebt3RDv0GYn+7rLMCMZNNp9pnwM
	NtoZ5BGnp2/krXONmTQBkXIf0WuI1O8/S6NyZCYq5Vl3inv46mM2IURMIxIKr99nH7WmUxpKump
	lzNbye70XIoiQLlkMN0ZRt8WsqrTGPlxbZ9nejc6PBzJmYBYotRgxlr/4cvKmnmm+Xld0l2g78m
	TH9k8x/+WWqkVYZpagWTkwmFxdYh3aA2kKIFWJpfkgA7RvQSavEUC42tfcgKmUMKLk58J+yhPCg
	gAH8mPRRBO7crI0+Jk5Ikugyja9EsMNinkM37CPVKfbudww==
X-Received: by 2002:a17:902:f691:b0:2dd:c100:b2c8 with SMTP id
 d9443c01a7336-2e2e4b8b0b2mr15413965ad.51.1790783700945; Wed, 30 Sep 2026
 08:55:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928-libbpf-btf-enodata-fix-v1-1-56dae4cab778@gmail.com>
In-Reply-To: <20260928-libbpf-btf-enodata-fix-v1-1-56dae4cab778@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 30 Sep 2026 08:54:48 -0700
X-Gm-Features: AclHuK91g6yBjzv5Wydmwd7HcTJSbYJJfGMPfHuF7wf05VbALjgbejhsjOtOctA
Message-ID: <CAEf4BzZDFm-RH+wj=Lf_7MQ6wVnYuNEyiEMGgpLm6uyqPEt0nw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Fix struct and union zero detection in
 BTF dumper
To: Luis Vieira <luisflavieira@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 4:47=E2=80=AFAM Luis Vieira <luisflavieira@gmail.co=
m> wrote:
>
> btf_dump_type_data_check_zero() uses -ENODATA to indicate that a value
> is zero. The array path handles this sentinel correctly, but the struct
> and union path compares the return value against positive ENODATA.
>
> As a result, the member loop returns after examining its first member.
> A nested struct or union whose first member is zero can therefore be
> treated as entirely zero even when a later member is non-zero.
>
> Compare against -ENODATA so zero members are skipped while looking for
> a non-zero member. Add a regression test with a nested struct whose
> first member is zero and second member is non-zero.
>
> Signed-off-by: Luis Vieira <luisflavieira@gmail.com>
> ---
>  tools/lib/bpf/btf_dump.c                          | 2 +-
>  tools/testing/selftests/bpf/prog_tests/btf_dump.c | 5 +++++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/tools/lib/bpf/btf_dump.c b/tools/lib/bpf/btf_dump.c
> index fa995c02a170..dbf9f17e4b37 100644
> --- a/tools/lib/bpf/btf_dump.c
> +++ b/tools/lib/bpf/btf_dump.c
> @@ -2474,7 +2474,7 @@ static int btf_dump_type_data_check_zero(struct btf=
_dump *d,
>                         bit_sz =3D btf_member_bitfield_size(t, i);
>                         err =3D btf_dump_type_data_check_zero(d, mtype, m=
->type, data + moffset / 8,
>                                                             moffset % 8, =
bit_sz);
> -                       if (err !=3D ENODATA)
> +                       if (err !=3D -ENODATA)
>                                 return err;
>                 }
>                 return -ENODATA;
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_dump.c
> index fe04a955d46c..dd1241fcdb01 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -886,6 +886,11 @@ static void test_btf_dump_struct_data(struct btf *bt=
f, struct btf_dump *d,
>                            "(union bpf_iter_link_info){.map =3D (struct){=
.map_fd =3D (__u32)1,},.cgroup =3D (struct){.order =3D (enum bpf_cgroup_ite=
r_order)BPF_CGROUP_ITER_SELF_ONLY,.cgroup_fd =3D (__u32)1,},.task =3D (stru=
ct){.tid =3D (__u32)1,.pid =3D (__u32)1,},}",
>                            { .cgroup =3D { .order =3D 1, .cgroup_fd =3D 1=
, }});
>
> +       /* nested structs with zero first member and non-zero second memb=
er */
> +       TEST_BTF_DUMP_DATA(btf, d, "union", str, union bpf_iter_link_info=
, BTF_F_COMPACT,
> +                          "(union bpf_iter_link_info){.cgroup =3D (struc=
t){.cgroup_fd =3D (__u32)1,},.task =3D (struct){.pid =3D (__u32)1,},}",
> +                          { .cgroup =3D { .cgroup_fd =3D 1 }});
> +

can you please split selftest into a separate patch and send as v2?
the fix makes sense, that missing - is definitely a typo we missed

pw-bot: cr

>         /* struct skb with nested structs/unions; because type output is =
so
>          * complex, we don't do a string comparison, just verify we retur=
n
>          * the type size as the amount of data displayed.
>
> ---
> base-commit: ea9358e1270ab2c3ba6f36bd9bdda68617665516
> change-id: 20260928-libbpf-btf-enodata-fix-ac6381645ab8
>
> Best regards,
> --
> Luis Vieira <luisflavieira@gmail.com>
>
