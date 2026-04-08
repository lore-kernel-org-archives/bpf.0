Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A20A3BB9E7
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 12:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652816; cv=pass; b=B6lsEWVScKHRylxf/ZKmPT9wDMypg17DuO+ti0Dvge8ZeAVJxkaVEZTJKXjnywSc28oUXYh1hKBGX/PrYHIfzIQ1wlMwouidz74HU3cC3iSdbT+zvhEVZ+Zo71UFEI4YOgFPwVsbPeIH3zPU4ZHDx60NbmsGIjEGM2NeshzI2Vw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652816; c=relaxed/simple;
	bh=yeS7jHV4JVc+nUtYyIJXT90laJTfzGdlhhyxLeqxdoc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VVWqYMbjk6H0goqizrCFpNJXMQxcNR36wQSm17M55m1tMSLeBh6Er81QWHLUvi+GZdg29i29Jud4HQftaOyiclvqN1MymR9uEfMbsPylkw6uqIJyH77mgCx6vBk3LdKhnnwxa+E3qr7ExqZ+Ugr6fztiORI0yj9vhErHk2B4AR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nP3aEjih; arc=pass smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nP3aEjih"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c76ffd06593so1288867a12.0
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 05:53:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775652815; cv=none;
        d=google.com; s=arc-20240605;
        b=fWiJtsyoE+WmzaEAPmG7D2LTBfOIsZxBA/mCg9vOb7FLEhDHXtBSe5gqUTtJUBA+Ni
         Jz89pRRG7dv1wOxEqSJ26QocpgmLWHcVsyRZpIlFrwUa9ufVO5t4Cz+YRyTG437khTpC
         GS/rQpnLwcUnSnOBl/nIH2YOsB5uZELWpV2z9swt90iou8YPuG1O+eVBcJDdRlWG3cU+
         CzaOyh1yfZkfBiEECUkwAwG9uh2dAFTQThhjNlVprEmGILZf7ZY+CzsaZV0s501+Xkyk
         MRHngHkVbg8zEYPtWdSzOQ1NjUyup1h9jE96L9JCDAr5wqy5Q3QnF+mU6VyMH+7kImmU
         bFzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tXup5YBzVAlg6/HdojpZUjRgQHZwZkCPN2ErnlaSkJ4=;
        fh=ApIlLOUIbxK9wlX4VpiWbSQQRjN1ATdWU8tV5cZgvug=;
        b=QLaGzhiE5gNYyxv21BdEb+HakTHpFg9neMZRvt0EfcuoJCDYk0I2Dvj6EDionKCjM+
         +HS/fPXMWdf8cGDND0hV2fCatYUg6kJvfUTa4KEo/lPcM7PwmgjCJ0cFBC/sXAm86Wk6
         GpyfI8fd39jzwnahf05iOwO9h1BC88oCgl7/Xehr+hCcl4axWdTHKxSXUDgd++xJ52Hx
         CMv4Qw44Olcnvo3/5VYD9NpSXrq6i6x2jatGi7ijHrjFOY80TFXtVZKyYSs9P+EuNUzd
         BJtEzRm1WUs8tO5BuuRyHY/wsvVcqOhOyxHE/UyNs9QcLChommhZqEa9/DXfak9yVSbF
         /zOA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775652815; x=1776257615; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXup5YBzVAlg6/HdojpZUjRgQHZwZkCPN2ErnlaSkJ4=;
        b=nP3aEjihKYmY1dmF+pClXnXIj9HQnDroDU639crqyrfqK4okrk0nyRx/H/Y91ZiGeB
         N11IJyxY9gbQ2DKswJA4S8UHCoTFW9DzmDo2cZlqDJ0dFSc9XiEKEG4OVZLSgDZ7Wyad
         6YddLwlQ3BNwOoWefxwl6W5z55HaGpa71gk69m7qkA3BkUGCb4rGaJ2q/BZit8s+3i8y
         bplAn4AJZdjVkfnXxjdoh40EzFBoFgCRNe+i0u5YrwHKXZDGcJOiHkQFP0UYJ4E9VX3Q
         mJhd7rPZ8zXoOuvVz91zf2eLbvdvBy8zbAZDZG5FyfOU9bM47FYKdFnW10XmHFwvsXVr
         U8fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652815; x=1776257615;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tXup5YBzVAlg6/HdojpZUjRgQHZwZkCPN2ErnlaSkJ4=;
        b=pMmYvis9G9PBaIRkz98shPm03RbrPaX4xQRjCPXSby2/dUrfhv2A3H4iz/1kf2KmCu
         yqngOEzt8zEB00NJBGUQUjZN+PvZBX1cnpERwf/aT5oDB5bcsKUt0+DhG3vZYJUZ0PB5
         d/1HERzP20FHxj2cfuawyHY2SH6vYvaxZsV+8wvH2ZPlm7Solrj6YcoGb5Neez7nWJyC
         +LZXLxp22cPamXDHPkWptnRD/yROKdVuEIxSMThc8wPAyNSPYkOxYNYPR7LboUAm0x6N
         vi1avA6nhsB3MwTffb+OIlxuZwTnHllqzc7eX8bYIsVXTnYIg3mWqAevrOL18yuLkVOP
         TsOA==
X-Forwarded-Encrypted: i=1; AJvYcCUecJoJPgV0DoDJiftjHbKsShQ0eyzOZSUWsBs2ocZg4kbj8vBKrVl3D1jmHvDMidOseis=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7CENei5SMV6/wPXaWgFaehm5B8SO4cjmhI2IgfTyicUXUcPuk
	4SRhnQSM9owENEo054FQx3G/zdCgsc581Rlb6txAV9ZKsJ9Aak28luzU8Ll6t4VblBSP+VTbh8s
	0SkQV0niG9WU7xeIYP55DiVQEDdQeVbA=
X-Gm-Gg: AeBDievGZqNh+yJl+d52s5Ks9nYhc/NfDZgKnwChHmUNPKiDevKMphHvNDMioB3rVfd
	hnJN5kLcOpvN74VEz/eh6ChIZZiH55sJn3v05+XBzSCCQaezZra4+UgFb9tU6EU1AlJ6H1J73rJ
	DuQItQ3Esd3C4XFp+9XB6ZRO8aembXhxLHgiKikwd4PhEhF8NolMuMYzHTjE3K7bd5Uz/7/P+9L
	H3P0YnyLLbH2O1QbC5adv8hG851mlcoHz2i3EJBWeguTzelMaG7W1QViOjJVE7mjbD1mOowx5Nt
	hhggJA==
X-Received: by 2002:a05:6a20:9145:b0:39b:c0b5:b0ee with SMTP id
 adf61e73a8af0-39f2ed784cemr24509160637.12.1775652814680; Wed, 08 Apr 2026
 05:53:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260408105324.663280-1-alan.maguire@oracle.com> <20260408105324.663280-3-alan.maguire@oracle.com>
In-Reply-To: <20260408105324.663280-3-alan.maguire@oracle.com>
From: Chengkaitao <pilgrimtao@gmail.com>
Date: Wed, 8 Apr 2026 20:53:22 +0800
X-Gm-Features: AQROBzDgGWgps8HuLBoLmbZqPM_t8XuWUsCzmMBcEAODWsNqdrBYhPPA65DVkXw
Message-ID: <CAAWJmAbQFCTyLoO_xoBtaf1ekhj853tx4hK8dEC4L8TW2-jEVQ@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/2] selftests/bpf: Add BTF sanitize test
 covering BTF layout
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 8, 2026 at 6:56=E2=80=AFPM Alan Maguire <alan.maguire@oracle.co=
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
>  .../selftests/bpf/prog_tests/btf_sanitize.c   | 100 ++++++++++++++++++
>  1 file changed, 100 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c b/tool=
s/testing/selftests/bpf/prog_tests/btf_sanitize.c
> new file mode 100644
> index 000000000000..470b29298cbc
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_sanitize.c
> @@ -0,0 +1,100 @@
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
> +};
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
> +       struct kern_feature_cache *cache =3D NULL;
> +       struct kfree_skb *skel =3D NULL;
> +       const struct btf_header *hdr;
> +       const void *raw;
> +       __u32 raw_sz;
> +
> +       skel =3D kfree_skb__open_and_load();
> +       if (!ASSERT_OK_PTR(skel, "kfree_skb_skel"))
> +               return;
> +       orig =3D btf__new(&layout_btf, sizeof(layout_btf));
> +       if (!ASSERT_OK_PTR(orig, "btf_new_layout"))
> +               return;

Missing kfree_skb__destroy(skel) here; consider using goto out instead.

> +       raw =3D btf__raw_data(orig, &raw_sz);
> +       if (!ASSERT_OK_PTR(raw, "btf__raw_data_orig"))
> +               goto out;
> +       hdr =3D (struct btf_header *)raw;
> +       ASSERT_EQ(hdr->layout_off, TYPE_LEN, "layout_off_nonzero");
> +       ASSERT_EQ(hdr->layout_len, LAYOUT_LEN, "layout_len_nonzero");
> +
> +       cache =3D calloc(1, sizeof(*cache));
> +       if (!ASSERT_OK_PTR(cache, "alloc_feat_cache"))
> +               goto out;
> +       for (int i =3D 0; i < __FEAT_CNT; i++)
> +               cache->res[i] =3D FEAT_SUPPORTED;
> +       cache->res[FEAT_BTF_LAYOUT] =3D FEAT_MISSING;
> +
> +       bpf_object_set_feat_cache(skel->obj, cache);
> +
> +       if (!ASSERT_FALSE(kernel_supports(skel->obj, FEAT_BTF_LAYOUT), "l=
ayout_feature_missing"))
> +               goto out;
> +
> +       if (!ASSERT_TRUE(kernel_supports(skel->obj, FEAT_BTF_FUNC), "othe=
r_feature_allowed"))
> +               goto out;
> +
> +       sanitized =3D bpf_object__sanitize_btf(skel->obj, orig);
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

--=20
Yours,
Chengkaitao
