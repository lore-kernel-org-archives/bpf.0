Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794605903;
	b=pCGGx5U2VcuUSxavggbo+JQpoNnKxWqLk9wK1QIFcaiUW92svlhHD/8IBRu7r0VTM4al
	 PRm9gYwOed3F539+nrkg1O9nW+AubbRiXz9dYxftcfeUx57uhpyFcQBGkNJYDlgD9G5IQ
	 7Mkm8MQ8gHqP6WbCP+znHhvlmCUsZnb4ihRiaQ18QNF/XusGK6YKG3cFw+h8d6c2BSiJf
	 /xxqSliLPLMtMHCyfPYRWNuNDBjeyBtWHz24ZYbqPhZJ0XmG+v7+yq4NvQ6sjXh0xhs79
	 OTyQI6ggbn42w/unvl89svD8dFlqqGV+dlaGqNr5/b3GNTvVJPBIK5ZDQGd/tI5yb5A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794605903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=kSo+RrjixMPnbCe+AKfecj0PaiqrU/cwlSSyvU2w8T8=;
	b=C44ZARRmC0d751VmeSkOyCEF17RxDB1EPO9qg3VklbCaXrD2j8BXCa6+thYSquccWF7t
	 Ip+hV44Up0qhch/4n8O+0ie8TvmL6tbn4Rd0yFkYbw06ILfhG3TmTUXZ2bpGezrkq6FPp
	 JbJH7W//HGCsFIEXRKXBzqaVQKklqf68bZ24JuR+9rwF76fX18eIm8SiFCKduntyoIR8P
	 +gPCnPWKNY03c4Ot5mh21ZdMMAP7SLGbWDx03QIDdtBa0cpJst5kdTIi52JlQ6S3Xf/GC
	 45odcyEfQ90z1V41yLsw6qAqHR/8f53YrUlwRc+hPyvxqKvcDZx7jt1OiEQiWlDPPmw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cePiIa4L;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E03606A32D
	for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 21:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 54E03606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cePiIa4L
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-491aaed7565so649314f8f.2
        for <bpf@vger.kernel.org>; Fri, 13 Nov 2026 13:38:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794605901; cv=none;
        d=google.com; s=arc-20260327;
        b=AX+ZzsLpu71/+LBSxn9+CprCbJmnLlWoG9WcIcv1lrw4h11qG1GN7VlU7Xb01Q9RfG
         5hiJUwdOKA5+x1Dd8QPIiA4+io9e3Dy4PDtk53V8eU9W6KgyKQkbUS8xnKpXMEkOw0tn
         Blr2M2kFMmIsFJ6Y6ejtXwrGQZ752F/hxOAO1QlWRdBTIykp+eJJu+YZM2aJ939A836F
         ZwT86ev8VYKlGNi27jsg/cVh9QeIPSvNY4TIiHPOZJILRpQgJfO3Cf8gk2/UMaE/Kgqt
         YAW0pgjFPV+k9J5YeRcVGTjE8S5dN/MrmetrnbhhMd4lzXvga/DvxorKbiMVf8q+ToBx
         TwNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kSo+RrjixMPnbCe+AKfecj0PaiqrU/cwlSSyvU2w8T8=;
        fh=CLmOe1/VhrLVvdZIJpu8MBiLM11hFOEBPDSMl9eLTGI=;
        b=dRL5woDk2ixK/ymG+x05zQdrkQ8NewteAKP7n4gXFWlReC18Q3H6K0c/oTHFrv4icq
         0P4NRY3Ag49dfkRNFKVz6kUmTy8wnsBecCEwIUNmPm9NGGoenaWZn06iuUnfhLWE3wne
         rQ+4nHQpzMhWjsWbt8/nDXoGL6e/plqWL7GbbU6jmVTdmKE7ZBV1KxQxD7dtmmlO8V6s
         F2N9FAR0pH6hKVHP+57MXXeBGhVGcCubsSbIXP4dWl6nW333qFuDEzJZ2HRCT7NBXfLX
         LcM+YXKrs2ljjutv6VIs9TQ7YjPIZRticnL/l9DkTm2GS2SVFLMRtLzx1qEC10z7Yp2l
         Ybsw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794605901; x=1795210701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kSo+RrjixMPnbCe+AKfecj0PaiqrU/cwlSSyvU2w8T8=;
        b=cePiIa4L9uug6R+eHjEYOWK0eJiGclGhDzh+XOy0lundvBVwI8d8TIztno6kNMmpov
         mZSl28IMU1dDXQ15YcTk3ThNpeQQ50g0USKn/WtpVhTh+0A0o274rPxwMsXRqw8bxBfr
         sB3C7MhKVmG8K04tqBS8hzDJjPnUhtiv0CQx5xmszvb3uljQCfoJar8E0lXE7/I0XIKw
         MifFPd7l/m2KAghoe4OgaS+VNjGdCEuZyF+kXve2QQ3YutwiphTJe4/kvGtwFSzl0qgP
         3lqPjZEtn08gBuSqyODoCOPs02IEpW11aJaJxr+WEBCzozPTbEW2Yfo3YlTpq2pD2cL8
         Iu0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794605901; x=1795210701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kSo+RrjixMPnbCe+AKfecj0PaiqrU/cwlSSyvU2w8T8=;
        b=D5UdMnAjLv+fp4KOSm0s8hcjCyHehxsOyPdJt9mguqpy0usmlaB522EEdWk/fVoHkG
         knf2IsZ1oZphpGY0RmAvIPtJksvyve+H+FGsPhb7Aa0ODXm1RqsBm3nWwCcVjSIA2fEE
         TRyh9Z0Ew4nMl9CJPjLXzhNEfP25q2c2GU/5nmThcfS0j0krl5nsmQVUydMlAqoSRdjK
         sTQnrZLMWVM7TTkC7cqKVlIVW0DocNjgZnbeTdJoZ9RqWBIHgb1+f63KNoDEStzUnOJ+
         GaJqL/OwvMAztEMpPJyK1wGs3JvpTv1UNEVYvm7ZlVUrQZCyIlk7VsT3tegxq8BH4qU1
         FSTw==
X-Gm-Message-State: APuU4Z/aSwSTvSJ7YnvskKb98Z53KOQD9LF0nSv9RsXJPenjSKXeGoHG
	k2keuri1PGGBG61ozUqLRF7S7qa8jb+mYW6JGix1SkNCufgpgbQmQa930eB6zLw6fCH5DjbaCvL
	Am9USiiUaYNZMayi2ij6HfCqxM/mKzqM=
X-Gm-Gg: AYBFou2AdfuzKPPd2VRPCXGi/WdeUPjN0rFwdvAw2M4nfCLIWhQ9YfOAPhBdE/DwEro
	1Ery0ZRXN6i4gcPdW/hNUjl3+iO6PAHhZ3QJlUCwLCK0euq/suvUd6cIglKkpKYnZtkAl+0DOWs
	TLMH/Px7udEjKkrBAiERPheKKVrc76glND3VexdmEY+lAaoIvdjMoezn26dI6U3H6Ju0hARnCux
	8H5AxlkeLSgBMRzAkQP4V0R9whO3cTvgev+6SfiPkEdTxsFFvC3cGubG7ZoSw+K/jJmJItv6q9U
	j4gWkZ3jeBZTNe2IY9eKvEGaUoz5oAoG8NIFvlSOJKZeEQSNfcmgXnampcdcHs/EBO4Bsa38WrY
	DYSq3qsqlGt0lb7ZSykLOs1u5bdGUwIOiK/QA8vIrSqgyVkq4nZYkWWW5LnM5k7WD4/1wiaO34q
	mKWjljIuOByHcbqJf345FWnLsAI0Ca9TTYJV34RhKzeTXG+SHZSheWvGg=
X-Received: by 2002:a05:6000:4301:b0:48d:fd4d:7fbe with SMTP id
 ffacd0b85a97d-49c6e68dce5mr10138174f8f.2.1794605900568; Fri, 13 Nov 2026
 13:38:20 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103032619.1378-1-gubin@cmss.chinamobile.com>
 <20261104025806.1693-1-gubin@cmss.chinamobile.com> <20261104025806.1693-3-gubin@cmss.chinamobile.com>
In-Reply-To: <20261104025806.1693-3-gubin@cmss.chinamobile.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 13 Nov 2026 13:38:08 -0800
X-Gm-Features: AclHuK9Mg3kvPp6V34Jilo9fByYzReQJWYdDm4CUeSMeHSLCv0EhyIMxZ6MGTJE
Message-ID: <CAEf4BzZg65BMYR5v20Gk0BB6E4fRgjQF+cmPcDue78Fb6-GLvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Add overflow test for BTF
 dump zero-scan
To: Gu Bin <gubin@cmss.chinamobile.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, alan.maguire@oracle.com, alexei.starovoitov@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 6:58=E2=80=AFPM Gu Bin <gubin@cmss.chinamobile.com> =
wrote:
>
> Add a TEST_BTF_DUMP_DATA_OVER() case that dumps an all-zero
> union bpf_iter_link_info with a data_sz one byte short of the type
> size.  Without the overflow check in
> btf_dump_type_data_check_zero() the zero-scan reads past
> data_end; with it, btf_dump__dump_type_data() returns -E2BIG.
>
> Suggested-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
> Signed-off-by: Gu Bin <gubin@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/btf_dump.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_dump.c b/tools/te=
sting/selftests/bpf/prog_tests/btf_dump.c
> index 35f214e254da..68f33f8a54ab 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_dump.c
> @@ -1156,6 +1156,15 @@ static void test_btf_dump_struct_data(struct btf *=
btf, struct btf_dump *d,
>                            "(union bpf_iter_link_info){.map =3D (struct){=
.map_fd =3D (__u32)1,},.cgroup =3D (struct){.order =3D (enum bpf_cgroup_ite=
r_order)BPF_CGROUP_ITER_SELF_ONLY,.cgroup_fd =3D (__u32)1,},.task =3D (stru=
ct){.tid =3D (__u32)1,.pid =3D (__u32)1,},}",
>                            { .cgroup =3D { .order =3D 1, .cgroup_fd =3D 1=
, }});
>
> +       /*
> +        * overflow test for all-zero union: with a data_sz one byte shor=
t
> +        * of the type size, the zero-scan must not read past data_end an=
d
> +        * must return -E2BIG.
> +        */
> +       TEST_BTF_DUMP_DATA_OVER(btf, d, "union", str, union bpf_iter_link=
_info,
> +                               sizeof(union bpf_iter_link_info) - 1,
> +                               "(union bpf_iter_link_info){\n", {});
> +
>         /* struct skb with nested structs/unions; because type output is =
so
>          * complex, we don't do a string comparison, just verify we retur=
n
>          * the type size as the amount of data displayed.
> --

I think this doesn't apply on top of bpf-next, can you please rebase and re=
send?

> 2.55.0.windows.3
>
>
>
