Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6AA3B4E8C
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 20:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792183802; cv=pass; b=pIpp0uReEWIGJLLp1eathOoZgCWT/pJehNU5m2eCR+MOMdcKS2fTbS+sNO9bRU8ar7tuY9hiMvB9c0mxlyQIv2oKmJf0FUxKBIN6rIoSE6Rzpm4D1n1AbNuUM4Vq0BujTG8MSrcTEOAXMmoHVNLEIrOuTPbZzvxuSTGgkf8Po9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792183802; c=relaxed/simple;
	bh=6GJ45C0RD5GXr91xUYZPSAQ37i/pcOONesN2xzX2DLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rMMQ92wnrKdqdvqV54GbwC7GmHTuWuJpxnZ5O7Th7wU7ocOUFM5KwrLN4BWPw20Mni7vnzsxu0RisP/FFlwrmujqPbQLLjpUcrBdrPx3O8jPLNoZLS7cchZ5ywBLG1n7b7bE0q5rwDf4kvSqr0OlpIvaPga9ZAiNpInVG5rTvzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DlnjagEm; arc=pass smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DlnjagEm"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-43bf9548df4so340990fac.0
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 13:50:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792183800; cv=none;
        d=google.com; s=arc-20260327;
        b=g/qB7R8L6EkJR25qrxbst2q4ame+t7e4//Z42YQloQ9wbYSGRI9AshcnXOh7Re+HgG
         DUm/sIOOVn0UCEZIvgeX3IGiAq2sOkb9D84qpHTSGgCtzFzn1yliKtTK9zLDOAXexHuV
         saoRLy/XqRtL61VsMdZiUPnKulkW/jeVLR4lnCol6XuadvTj5qa/0MdJcEkdvFxthtbg
         3BMVn01tpfhi1sVXlQiryaECHS1i8+TJbK7SBoT93Nx1HmXKOC5PxeMNgyFG4gIPQFQ3
         pjC7Dj+jnc78/ImPp2s+0oJgHLvnXg+2a6g7q5rJPzSqjS3EuGBXWOfvEui0QxP8tSZO
         rV1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=HuN9JhFHSgD0AI17sHkiTKKDtmKFK6f5ghoUZR3heZs=;
        fh=H7PUGgErKEOKfhACVyb6Mmfhz6NsYGYq/gKr97ebI/E=;
        b=aQLqkQEX/81LJLufU/nhJ6EynGL/yeI1u/k05WhhxYAslcF0/DH5VXW2KOzZ5JJhwh
         u4FTjSNFjVZMhjz7aFE3R9GvvC0y3tx6Ahw3c5416n42mM4sZ5rA/9cxaEPO9tQbZiTy
         ZaJxS8BQDqvkGUWN9HnW/3v2shgm+o4ubc1aVE3OPN9OUnp7v1wbOfkXr6bFnKUNK2of
         PpglekVS4p+Hfsv1I5GdiPxNNwDfE7ccNtDah+wz8xyNDZ7scxJS1riz4wYFen0xLrxi
         9WUx1Kf73MUqG1H4GD0T7X9/5pFpAwhy7PPfi66fF7PHOHu2hwCPHOoNBys0BymxRJzj
         z79A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792183800; x=1792788600; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HuN9JhFHSgD0AI17sHkiTKKDtmKFK6f5ghoUZR3heZs=;
        b=DlnjagEmQljtjuIe9Dw+rV9cuK0amR+i0WLhWNxRE6pb/Z/QeTefPogRChxj6UAiSz
         FCpum2MtX1ycYhvl6/pfkqKC4R5YJoYo3pbvFGPWpIfZWjrAKtrsl4fEUeWjLLXxX5W8
         Kz89bJR1j5Idc8TFSkqWWOZ4lT7CefJbpajA5wAOoBqVWYQ1LVV2rs8Vm5M2cfrtBkdx
         XCHTRG5O34e4kLJgEPLLxCc2mBF5OdW3X8r+HxCRrkMWnwO9YcP0XOXSBBCElR7Y4W4w
         8W4T7I6xVMvUCIXMA5tDBxCgET/ZNOt9XwHp4ALqVha4S0ZQeQL7LN5GO6K/SK7D77iv
         bV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792183800; x=1792788600;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HuN9JhFHSgD0AI17sHkiTKKDtmKFK6f5ghoUZR3heZs=;
        b=SG+nU6EEDG7xjTVfPfW4YISX+KFHdhPywPNLMWoVVJR3DIk8uETVf2LtfsPdDQBLnJ
         Jkvru4LzWZP61bepEvhiYilzxfKL7H32/gxjysdgwv2BUVA7ZYyQmnXpXGJbNvd65Dhr
         qXzSHpolXAh8sXKowXbRxulVsYhnG0PIZ8JNLUZFSy9i6Znczi3APPch4LMJ2qFaTset
         UjGbdtqOlAl/kAaeZtfLD2phdPuZ03egdB0PFlGr5uZLVt1uEJBmGuTAFNQ1CwIpi8kS
         Gu+JGwJJ0YHda1stGaEgSYsxhOxh3IwaRTqaW18fqZGwx6TrLxog55j4ijPtyTCP4hYR
         gVaQ==
X-Forwarded-Encrypted: i=1; AKwUvByioHdfDvWEEgFsgFs1X7P+dEm5Ky3kbj2j+vagg4c9W9Utb2CBc2DtEADTsoHXdeUdQQI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDIeGuImr62xNse1Oj1xK/j+s1lhTSkmZb0S7R8PfNIqfSqm3i
	IBgKxOeatuR00rTX2l97imJ62ujR772VlvR+CsCzHAWQV+m2lNgXzS3j1ESn44QEQouXxT8Urw+
	6bVaIQb6hDsqlPPf2IhPPWl/OOW6oqjM=
X-Gm-Gg: AYBFou1imMQ8tuEt/oAuuvWYbK9qEpOo09/1lBMmhutVGy0u3qABZhPJC/xj4wPE+zB
	rkUhPu6TAs72AcBVtpq0TpdVX2/CWQeTIEIR3C8JL78INdUYyJ+XmBTKGA+X+pqcDvsPbPeW2r9
	xv3uOCef5XvfqkvIBcnmFfFjew+sCdXVZuhLLn5Tch2tqHX26OCPXlKggFA5w/nxVvHgKa7fWQW
	+TxjMeDlrPBAU9ChokR+LJQ1y7ClIZRJL/gT1pj1lPIPDhHKvYg85GEawsNyJk7azl8EB7ns5Rh
	RzM/XG30/K3kOIGVXzLgZ9OnqYTSBCtMDq1RE5y1zNTKpCKcxDhzjqI=
X-Received: by 2002:a05:6808:1645:b0:4ea:1854:b949 with SMTP id
 5614622812f47-53ccd9ba710mr669164b6e.33.1792183799790; Fri, 16 Oct 2026
 13:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1791980149.git.zhilinz@nebusec.ai> <1fa798d444efac579e91ee0716e228902a8f9afe.1791980149.git.zhilinz@nebusec.ai>
 <CAMB2axNZ=Js_-jGodWE22VoeVmR=9AL2V8jr_t9G38eAaMs_ZA@mail.gmail.com> <CANB6i5wK87uZ+jYqVVy4pM_jW4We5Tey4rGmzb9Kx567U473Dw@mail.gmail.com>
In-Reply-To: <CANB6i5wK87uZ+jYqVVy4pM_jW4We5Tey4rGmzb9Kx567U473Dw@mail.gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 16 Oct 2026 13:49:48 -0700
X-Gm-Features: AclHuK8Ws8y4Bsg87w4p53aNMmTvyPLIoFx8O1kRZMXMasDglrsChmADVt3UwQ4
Message-ID: <CAMB2axNzbr6SGBcGQV7O5ra-Dhjo-nbigopfK389BFCOOadu2Q@mail.gmail.com>
Subject: Re: [PATCH net 1/1] bpf: reject raw iteration over managed sk_storage values
To: zhilin zou <zhilinz@nebusec.ai>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net, 
	edumazet@kernel.org, pabeni@redhat.com, horms@kernel.org, ast@kernel.org, 
	martin.lau@kernel.org, daniel@iogearbox.net, leon.hwang@linux.dev, 
	mattbobrowski@google.com, menglong8.dong@gmail.com, kees@kernel.org, 
	bestswngs@gmail.com, memxor@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 10:24=E2=80=AFPM zhilin zou <zhilinz@nebusec.ai> wr=
ote:
>
> On Fri, Oct 16, 2026 at 1:01=E2=80=AFAM Amery Hung <ameryhung@gmail.com> =
wrote:
> >
> > On Wed, Oct 14, 2026 at 5:24=E2=80=AFAM Zhiling Zou <zhilinz@nebusec.ai=
> wrote:
> > >
> > > The sk_storage iterator exposes values as raw PTR_TO_BUF memory. Atta=
ch
> > > validation checks only the maximum access against value_size, so BPF
> > > programs can read or overwrite BTF-managed fields such as __kptr with=
out
> > > the verifier's ownership checks.
> > >
> > > Reject value accesses when the storage map has a BTF record containin=
g
> > > managed fields. Iterators that do not access values, and maps without
> > > managed fields, retain their existing behavior.
> >
> > AI is right. It also appears that iter/bpf_map_elem may expose special
> > fields as writable PTR_TO_BUF. Could you cover that path as well?
> >
>
> Thanks, Amery. Agreed. I=E2=80=99ll extend the fix to cover iter/bpf_map_=
elem as well
> and ensure bpf_link_update() validates the replacement program against th=
e
> attached map.
>
> > >
> > > Fixes: 9db44fdd8105 ("bpf: Support kptrs in local storage maps")
> > > Cc: stable@vger.kernel.org
> > > Reported-by: Vega <vega@nebusec.ai>
> > > Assisted-by: LLM
> > > Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
> > > ---
> > >  net/core/bpf_sk_storage.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > > index 1d295a8769fa..b54fd90d4bde 100644
> > > --- a/net/core/bpf_sk_storage.c
> > > +++ b/net/core/bpf_sk_storage.c
> > > @@ -863,6 +863,12 @@ static int bpf_iter_attach_map(struct bpf_prog *=
prog,
> > >         if (map->map_type !=3D BPF_MAP_TYPE_SK_STORAGE)
> > >                 goto put_map;
> > >
> > > +       /* The iterator exposes values as raw buffers, bypassing fiel=
d checks. */
> > > +       if (map->record && prog->aux->max_rdwr_access) {
> > > +               err =3D -EACCES;
> > > +               goto put_map;
> > > +       }
> > > +
> >
> > Could we preserve access to non-special fields of the value? Since
> > max_rdwr_access is an exclusive upper bound and record->fields[] is
> > sorted by offset, attachment could be rejected only when:
> >
> > prog->aux->max_rdwr_access > map->record->fields[0].offset
> >
> > This remains conservative, while allowing users to place special
> > fields at the end of the value structure and iterate over the
> > preceding fields.
> >
> > Please also add a selftest covering allowed non-special access,
> > rejected special-field access.
> >
>
> Agreed. Since max_rdwr_access is an exclusive upper bound and the
> managed fields are ordered by offset, I=E2=80=99ll reject access when it =
extends
> past the first managed field=E2=80=99s offset. This preserves access to o=
rdinary
> fields before it. I=E2=80=99ll add selftests for both allowed prefix acce=
ss
> and rejected
> managed-field access.

One more thing I noticed. When you respin, please change the subject
prefix to "bpf" as the patchset should go through bpf tree and the CI
first.

>
> > >         if (prog->aux->max_rdwr_access > map->value_size) {
> > >                 err =3D -EACCES;
> > >                 goto put_map;
> > > --
> > > 2.55.0
> > >
