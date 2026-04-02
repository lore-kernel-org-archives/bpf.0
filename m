Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C903242D7
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775162104; cv=pass; b=DEGzEqhpzpFBqt5DXfsaIbiqCXmhlNM7ZzUxWFc3vgkKC/pP2jsqmPBsPRkTubUx1bnczFJcplvE+YCx9W1nPPmNCn23qJtgE+1Wxv0fuG75q0lzst/29I6RRpgKSAAeJ3c0/jxrFhMGD0SwOw67b/1MH97aAnMti7c25zkCNac=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775162104; c=relaxed/simple;
	bh=HYdTpVv9eNRR+zcQf91aaRXW81rdrCsgIjR0JkssmdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVb2iYGaqKx46WogySTULBB7CVhZC41ZU9rcQkyYz6Es83iIHK59YAhKN2d12XJ4Wg594FqrSbswo7FIWmODn3iNTyn5gLVrmG7oqf87hFh9g/dSHu2wUqE9PJkzV+SFQhxpz58dI/7n0uo00g2SdoZj+CGdWK/2+HoX7VtQlsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmqP79YY; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmqP79YY"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82748257f5fso1514155b3a.1
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 13:35:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775162101; cv=none;
        d=google.com; s=arc-20240605;
        b=iixtyf7zT5NCkpNtvGE+1nRuHXaOi9VCiojLnjWrTinI0P86wFxiOJ0Zvon6Dfgy8Q
         pQ7qVjY9Y0zO3fBlMA+KJnz+tAH1dI+LF5OYfEeijXn7Hvu27w3t/f1oa9fpTWQjOnxq
         /RzVXM3+viiFTT+NgE78mpdMO1modIhNEMgpHF4tgPW49+mLEVDfvvJzPZ6+dqXbEMFU
         BWtSG/z6m0nC1Erlrz0kaIH270S4BAbA87AJXaFQF5st5yk59Nfs+rlFDam+YngjW3YM
         glrkn9uCKUr2X7Bq338KGhivcAeYg+3ORrAYqL9VgtBNqlf0BxHmTOcAXvCCUC5aUVcj
         +lSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sT4ErTbyK3L79X6F9nqmvUSoks5ZmZ96P1eUQm5LzR8=;
        fh=2TDLiPR6zi8P67UZMssrnd3KSdDg/6ZLTvVVgw6gXng=;
        b=G93hIVuvUmZ6eurdDGM4trPzyQgpN74RmcLMXBiGzfp79ZNWCfl9pHf3PsGyenq67b
         6xtn6tIJHY/xAZ4euFuRUbdJablWg3t+WE4YMR/dFDf5NQ+GKnOLrnpsHDfDzjZMZ7K6
         YFVnKlaCKxppfhbvdgYPcmOu18jgGvJuvfedBx+0MiihwR3IBQg0Sv5pxEaFhkcfcqvR
         T2pwXWPHm45TpYl+B5WlANTFvF0mQLtYQFbkaZDtPK7Rb+w3MwUAX8Pt2hXY5Hixyqbt
         30GQHhiwuXf+VeBvIkFs9slPqEKIf8luL6GEZpz7rYa8A/GhyaEb0pqfASEZZirWup/k
         Wnsg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775162101; x=1775766901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sT4ErTbyK3L79X6F9nqmvUSoks5ZmZ96P1eUQm5LzR8=;
        b=fmqP79YYEEp3wW1YQ4nKyzJ/z5ceq+GZWofFF6VWX5KAKdBGs5VX3wQW5cB3jvRoF4
         VvzfRAv4+ellKblnRNvfYI7tXb4r3n78RBFPeXrSiLY/RI6w0JZzVh6HwJpwyPxOtq8T
         laDSw87IrgRjhcG8eBISjlC6S8mEgp2b7f+l9HL4KmtXMiOg6RG7K8oVWS/A8ZjiI/mk
         EwiZZWPB6jrY2/wZiwaOIap24DoJv1TgWMhAwmT/GYKmMSrK+YrCMcNr7GA+KA8/YXwF
         ww7NgD0fKyFVJXP8WUx/I5sI0VOgSkNueEYqjrPYrg7/J1SqtYe+S9EfksbsEmKWxUPH
         0a1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775162101; x=1775766901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sT4ErTbyK3L79X6F9nqmvUSoks5ZmZ96P1eUQm5LzR8=;
        b=XrIk1OOo9o4J6flgTvnCvUiArwnmB6hxnjrtVr660yGng4iNwrbp5NoVnBJl6uYE0F
         xMk3NwbOqEtyL2qqrk5pnN3ZOmj68AbW4/SSfAP6gIgXkwpjy2+JAO3fmRwfmddXbh+L
         BFCSTcQcpMVcxKoyUITl8hYM7bqmZzJg/LHlrRCqb8JUrC2THHMzsod2yMEULxqvKN80
         91YdaadaXXWcHVEvjmguNE2BBaR0Sx+INy4OIY+EI+H5GCB29jS/07tXaBL1agfKiTm1
         I+H0TKKkSmH66FczhpZnDxcEopGWudEunIyLmdYziL0QRnN36u6qhJ3VuD+5EtWwkisV
         7Rug==
X-Forwarded-Encrypted: i=1; AJvYcCU1ojCtzpHZP5ZT1rbg/brY0wVBr+4eIJX8xAHYGw892uE15iNpEEdB/vKUJUM4Qm8xNHk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGzAS8wahABt/f0YmcJz/hp7/f+V6tUYlAt+NvkPUpUDzrJXyu
	h5oZkZYlCFHo1tNx1V72nAT8i/kh9d89CDdratxmKti5XoVIXE6I02JrZqUDfDaGfnkl8/eQoKI
	V0oczjR1iQuyB3cTF9Xo+zy55ywbYM20=
X-Gm-Gg: ATEYQzxTIrhMDhX7xtU20EjVj2B9C2eYOalaFzmHvkkC8SHYkUtbbMi5MKc4k6t1qN0
	BT6+yanbt68g0SoMSBFTbAdmxg7ERWklZHvbiewpSkLiq7pN+0KmYm/YpS1Fg+E9jeDaIKMlMhR
	DR5zugVgbmrJtG0Q3he+jzP8IUOEPhpc0z7w1+R9/B0kPKcUKWrFB7rTlJ/OHN9QIiKbBcwEzft
	Lsy1/3MWD5+kwy2QZdQWOhF+9kXDauqbxz+p3TICw1tuNrW9c9x0gKvi3OVm9nPN+T7DAFX2iq7
	RVhfoXg=
X-Received: by 2002:a05:6a21:6d9b:b0:39b:ff20:f4e5 with SMTP id
 adf61e73a8af0-39f16f3f5f7mr3782269637.12.1775162100816; Thu, 02 Apr 2026
 13:35:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260401164302.3844142-1-alan.maguire@oracle.com> <20260401164302.3844142-3-alan.maguire@oracle.com>
In-Reply-To: <20260401164302.3844142-3-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 2 Apr 2026 13:34:48 -0700
X-Gm-Features: AQROBzC5oQ0cTlCcFKNugDJnGt_IuAmoIIKC9X-K0m6QUiDFO41ClTbAexXAj8w
Message-ID: <CAEf4BzavmRrrPhyn8CyT0aQgJ+mg_+HPNpiCksv8CFp2S556zw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Add BTF sanitize test
 covering BTF layout
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 1, 2026 at 9:43=E2=80=AFAM Alan Maguire <alan.maguire@oracle.co=
m> wrote:
>
> Add test that fakes up a feature cache of supported BPF
> features to simulate an older kernel that does not support
> BTF layout information.  Ensure that BTF is sanitized correctly
> to remove layout info between types and strings, and that all
> offsets and lengths are adjusted appropriately.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  .../selftests/bpf/prog_tests/btf_sanitize.c   | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c b/tool=
s/testing/selftests/bpf/prog_tests/btf_sanitize.c
> new file mode 100644
> index 000000000000..c18e59f4a8b7
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
> @@ -0,0 +1,103 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2026, Oracle and/or its affiliates. */
> +#include <test_progs.h>
> +#include <linux/btf.h>
> +#include "bpf/libbpf_internal.h"
> +#include "../test_btf.h"
> +#include "kfree_skb.skel.h"
> +
> +#define TYPE_LEN       (sizeof(struct btf_type) + sizeof(__u32))
> +#define MAX_NR_LAYOUT  2
> +#define LAYOUT_LEN     (sizeof(struct btf_layout) * MAX_NR_LAYOUT)
> +#define STR_LEN                sizeof("\0int")
> +
> +struct layout_btf {
> +       struct btf_header hdr;
> +       __u32 types[TYPE_LEN/sizeof(__u32)];
> +       struct btf_layout layout[MAX_NR_LAYOUT];
> +       char strs[STR_LEN];
> +} __packed;

Do we need __packed? BTF layout is 4-byte aligned by design, we
shouldn't need packed

pw-bot: cr


> +
> +static const struct layout_btf layout_btf =3D {
> +       .hdr =3D {
> +               .magic          =3D BTF_MAGIC,
> +               .version        =3D BTF_VERSION,
> +               .hdr_len        =3D sizeof(struct btf_header),
> +               .type_off       =3D 0,
> +               .type_len       =3D TYPE_LEN,
> +               .str_off        =3D TYPE_LEN + LAYOUT_LEN,
> +               .str_len        =3D STR_LEN,
> +               .layout_off     =3D TYPE_LEN,
> +               .layout_len     =3D LAYOUT_LEN,
> +       },
> +       .types =3D {
> +               BTF_TYPE_INT_ENC(1, BTF_INT_SIGNED, 0, 32, 4),
> +       },
> +       .layout =3D {
> +               { .info_sz =3D 0,          .elem_sz =3D 0, .flags =3D 0 }=
,
> +               { .info_sz =3D sizeof(__u32), .elem_sz =3D 0, .flags =3D =
0 },
> +       },
> +       .strs =3D "\0int",
> +};
> +
> +void test_btf_sanitize_layout(void)
> +{
> +       struct btf *orig =3D NULL, *sanitized =3D NULL;
> +       struct kfree_skb *skel =3D kfree_skb__open_and_load();

this is doing too much to be used in variable initialized, please move
it closer to that ASSERT_OK_PTR(skel) check below

> +       struct kern_feature_cache *cache =3D NULL;
> +       const struct btf_header *hdr;
> +       const void *raw;
> +       __u32 raw_sz;
> +
> +       if (!ASSERT_OK_PTR(skel, "kfree_skb_skel"))
> +               return;
> +       orig =3D btf__new(&layout_btf, sizeof(layout_btf));
> +       if (!ASSERT_OK_PTR(orig, "btf_new_layout"))
> +               return;
> +
> +       raw =3D btf__raw_data(orig, &raw_sz);
> +       if (!ASSERT_OK_PTR(raw, "btf__raw_data_orig"))
> +               goto out;
> +       hdr =3D (struct btf_header *)raw;
> +       ASSERT_EQ(hdr->layout_off, TYPE_LEN, "layout_off_nonzero");
> +       ASSERT_EQ(hdr->layout_len, LAYOUT_LEN, "layout_len_nonzero");
> +
> +

nit: extra empty line

> +       cache =3D calloc(1, sizeof(*cache));
> +       if (!ASSERT_OK_PTR(cache, "alloc_feat_cache"))
> +               goto out;
> +       for (int i =3D 0; i < __FEAT_CNT; i++)
> +               cache->res[i] =3D FEAT_SUPPORTED;
> +       cache->res[FEAT_BTF_LAYOUT] =3D FEAT_MISSING;
> +
> +       feat_cache_set(skel->obj, cache);
> +
> +       if (!ASSERT_FALSE(kernel_supports(skel->obj, FEAT_BTF_LAYOUT),
> +                         "layout_feature_missing"))
> +               goto out;
> +
> +       if (!ASSERT_TRUE(kernel_supports(skel->obj, FEAT_BTF_FUNC),
> +                        "other_feature_allowed"))

nit: single line probably fits under 100 characters? same ASSERT_FALSE abov=
e?

> +               goto out;
> +
> +       sanitized =3D bpf_object__sanitize_btf(skel->obj, orig);
> +
> +       if (!ASSERT_OK_PTR(sanitized, "bpf_object__sanitize_btf"))
> +               goto out;
> +
> +       raw =3D btf__raw_data(sanitized, &raw_sz);
> +       if (!ASSERT_OK_PTR(raw, "btf__raw_data_sanitized"))
> +               goto out;
> +       hdr =3D (struct btf_header *)raw;
> +
> +       ASSERT_EQ(hdr->layout_off, 0, "layout_off_zero");
> +       ASSERT_EQ(hdr->layout_len, 0, "layout_len_zero");
> +       ASSERT_EQ(hdr->str_off, TYPE_LEN, "strs_after_types");
> +       ASSERT_EQ(hdr->str_len, STR_LEN, "strs_len_unchanged");
> +       ASSERT_EQ(raw_sz, hdr->hdr_len + hdr->type_len + hdr->str_len, "b=
tf_raw_sz_reduced");
> +out:
> +       /* This will free the cache we allocated above */
> +       kfree_skb__destroy(skel);
> +       btf__free(sanitized);
> +       btf__free(orig);
> +}
> --
> 2.39.3
>
