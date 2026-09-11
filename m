Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE6937D118
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 20:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789159597; cv=pass; b=chhzYx9VqYaDmK9r4E1vhdV3Ruqt5TWDMoye9U0RtEKocXu0evdTqIFFhYyXEAw8MpW+CdbjMwUg6HGbE+naYRFhRzvHHcfOzNvwvHZD4NhK1Fv87LZxlg3nFsWnuGnFPQStvcE1J9myVM8reP3qiQfAD+nEG7Le5xZq8Es+bk4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789159597; c=relaxed/simple;
	bh=pgwhRLCLSRiHCfZ6Q4DWcrC2j2S41ntskCgCclN/KPw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekKNBK7URSANhuGdKcZ3qNiUnvts2+Qv4j2jFsvMwqtnxDN3+mqmEZu3+ALSPmVi8F0viiITm3/+h5hbuC2FHHld+Htvw4PWvIJwx2X9qLaeVAZXxxCUZfRzgohDceJDesYW98YbXsC9BOSnujE76Tu79FBGiGZaFZXMlF9OUio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lYxj9eB6; arc=pass smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYxj9eB6"
Received: by mail-oo2-f42.google.com with SMTP id 006d021491bc7-6c197ff1f53so199775eaf.1
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 13:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789159595; cv=none;
        d=google.com; s=arc-20260327;
        b=nAlgaoru4ZgZ0N4ibivydr2QIJHQMqYiUWtUvq3BHyA7XTJH32KPyMwjzH/w/6pIv1
         Fy05Xa2Zdn00TlOKIV/o/Og+1VG2mD9BkmJRtc05SF2ZCLYFn95I4hFK4zPLO2QPGG6W
         EKVkKqb13PK54H27HmA7SNZT0qVeD6K608RKD6azmWiu8+y0EeTAwE/FwKmcqhM6mLyH
         mTpyxoqhs3Sl7zZ6J/hgMrh2l4y/v4BwnbuVGvkpczZtFZDaj7OZO+0/NXQES5F/5J4y
         WGcN9IdOR8E6Ks/qjCRqQIola00h3mgrbBx0JjMaRZjyDYe6vAAZEmnKLdcjKxjaeNCd
         SaWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RR0RcXEnr6mtTig17fEytXD1zbKJdvDf+b0apNmu1qw=;
        fh=+iofH7kLhUIpDUAo/a2rUbKulXCH8Go9n65YHAt0kP0=;
        b=N1U0fTEHoclm+g6MKNc1KAacIq1ItQJ4ept/KK+7h+uHRFvaujwGd4RzpcHlWlMyHQ
         J1oqGUr++5MefjQDByvs4Oxa7tmxEC2/JzAHLG5oSkoh8PgMrPFtuAohLzXsMHjMvP5j
         FVl8odSjXzXRsVojD0XPO4HpS+Aq4hraUyV4aSVhEWwsCJEYa4DJUtH0Iuw+lQRDtJPT
         FYY37R47PMpUgNyBUfIwuCjzdrE/+fs6bpTdGeJX3UWQgEfQrFuvt7nWS94IUvUNTbPW
         x2UnXQcRHXz7XaqcQtQUtq6x/XL0wSweivTr+APi3n23Bpyeu0MfY27+oHdMkuOjoaQ1
         KHfA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789159595; x=1789764395; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RR0RcXEnr6mtTig17fEytXD1zbKJdvDf+b0apNmu1qw=;
        b=lYxj9eB6goizYul20hfBbF7R/wJ36olmQtdyY6qAAvS7KS9iu3YhuPwoUq0WuBqJZQ
         RC90+LSDqrPHdaWro+8DEazCXpSzR+gEroMQMJRE4JXk106XA1QQYxrBMJ1QfSHZaM/d
         hOHV3b5o1gsqW0y+VPLN0uCAEQp76kclGq6Y5zHPyOmtt/ddyepMpiF94k/U5D37J27f
         ClgIQcBnlg7F1mF+wm05y+C9x9hJe7VTr0AYbg1JL2y+EosEDBpcpqWKEO4noGwQm41y
         lYe+jfXpHveQgheXXD3Uub4+J7WWGGjwbArDQlfWr0KxvuVETgfQMfTB+8xxTgnhrNtT
         n49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789159595; x=1789764395;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RR0RcXEnr6mtTig17fEytXD1zbKJdvDf+b0apNmu1qw=;
        b=NTPQkyYMZxKdMk5ecJk3kUaHVvFaB+j7EPsHEpNGD9gamDDQeiB3yuors7fnHvfN/k
         zbfSPzbBuLbvc6i1PyocOBuXtl1GXePVXRqVv6yRqXp1sQMcMD0SRaU7bqJWeIyvXFFu
         z0sNqmv4547PEsfN7qOOUkRahW+gPBZ/GMoTlFrRqfQ1pW3sswcG99TUOREyujfBkYrk
         0SKs62CrUnyna3TAXdHiw8M/q9vt+DqXCHqwASoYu7S3HaYiY8+IQWYaMuIwcx3ZVb4L
         oqmSxjH0YRK5rdeIEKv29VmG/MQ3n1wbodgVtd2oYny0qYd3BNDfYKeJNkQ601lzHlBA
         fxjA==
X-Gm-Message-State: AFuF++ku4pY7VtlXrqCkKbXKwpKi4UQ4X6gq93xE0BMsoMQghnM3LjUk
	Gceu0VgkuGMOiEzEWz/TEAuQIdgydXNdJFst0eM6e/UoQUOj/BeDKzwnKLQsv20apYXFPfhJ2WT
	upd5ZoCmQ2czBKxYBHvlUxjJh2fw2T94=
X-Gm-Gg: AYBFou2Heshcqp9/ZyP6atPHf0CISeDQu+FTdqOR/WOlPv792waE9KmbyGIT66VjGor
	qZW4+DZkQNpEw1v9eyZfMqfq2BCjQAQG3/LE1msM5HQ6gylRPoOUtUXEbOL6hdKEDuQhbr7fd6h
	tTKNTplbTxCM8PbWHR6KZ6Tzih9zR0ivfqfLJt2zDyaM6CCWKYwLDAgzGv923hwkG9c9sKjocS/
	2JNJmi25V0+ujW8CAbaR+cT5NdB8+rgNfVJfz/d3C6s0OLIOGzni4J+Beprej+KFoabhbnlXDj/
	/WeNs8Mq4sd+r1seKpF1FH1EMXbzjST+NaKAdkg3g1x2JK/xwC9UHqsigP7XQC7nWJGZE1weYiq
	E8GkXIA==
X-Received: by 2002:a05:6820:c452:10b0:6aa:cce3:ab61 with SMTP id
 006d021491bc7-6c0ba923c37mr6414656eaf.9.1789159594720; Fri, 11 Sep 2026
 13:46:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905220117.922028-20-ameryhung@gmail.com> <44341c2c66e3c9d2256dfdfbe10c7164152ea6ba3d45ef3aec833ddb7f468f8d@mail.kernel.org>
In-Reply-To: <44341c2c66e3c9d2256dfdfbe10c7164152ea6ba3d45ef3aec833ddb7f468f8d@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 11 Sep 2026 13:46:21 -0700
X-Gm-Features: AcwNN1WAiZcIjQtZnnZLhMxkoTOIaLwd6ceIo4buU5QonmLbOC1mlISXgIO-bOg
Message-ID: <CAMB2axOXtckkWsymKG9addof98sRV4_y8Wbcx9vbDJSihi0cbg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 19/22] selftests/bpf: Test kfunc packet memory
 direct writes
To: bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, alexei.starovoitov@gmail.com, andrii@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, memxor@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, martin.lau@kernel.org, 
	yonghong.song@linux.dev, mason@kernel.org, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 3:44=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/tools/testing/selftests/bpf/progs/verifier_kfunc_packet_ac=
cess.c b/tools/testing/selftests/bpf/progs/verifier_kfunc_packet_access.c
> > new file mode 100644
> > index 000000000000..9ae63c9eab02
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/progs/verifier_kfunc_packet_access.c
> > @@ -0,0 +1,47 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +
> > +#include <vmlinux.h>
> > +#include <bpf/bpf_helpers.h>
> > +#include "bpf_misc.h"
> > +
> > +struct nf_conn *bpf_skb_ct_lookup(struct __sk_buff *skb_ctx,
> > +                               struct bpf_sock_tuple *bpf_tuple,
> > +                               u32 tuple__sz, struct bpf_ct_opts *opts=
,
> > +                               u32 opts__sz) __ksym;
> > +void bpf_ct_release(struct nf_conn *nfct) __ksym;
> > +
> > +char _license[] SEC("license") =3D "GPL";
> > +
> > +SEC("tc")
> > +__description("kfunc packet write requests writable skb")
> > +__success
> > +/* bpf_unclone_prologue() */
> > +__xlated("r6 =3D *(u8 *)(r1 +{{[0-9]+}})")
> > +__xlated("...")
> > +__xlated("w6 &=3D {{1|128}}")
>
> Is this test expected to pass at this commit? Looking at the verifier
> code at this commit, the kfunc memory-argument path goes through
> check_helper_mem_access() for PTR_TO_PACKET, which calls
> check_packet_access() directly:
>
> kernel/bpf/verifier.c:check_helper_mem_access():
>     case PTR_TO_PACKET:
>     case PTR_TO_PACKET_META:
>             return check_packet_access(env, reg, argno, 0, access_size,
>                                        zero_size_allowed);
>
> This path never calls may_access_direct_pkt_data(), so
> env->seen_direct_write remains false. Without seen_direct_write set,
> net/core/filter.c:tc_cls_act_prologue() -> bpf_unclone_prologue()
> returns 0:
>
> net/core/filter.c:bpf_unclone_prologue():
>     if (!direct_write)
>             return 0;
>
> The kfunc_packet_write() program performs no direct packet store, so
> it won't trigger the may_access_direct_pkt_data() call that would set
> env->seen_direct_write. This means no prologue instructions are emitted
> and the __xlated() patterns from here to the end would fail to match.
>
> This appears to be fixed by a later commit in the series that moves the
> check into check_helper_mem_access(). Should this test be reordered to
> appear after that commit to avoid breaking bisection?

Yes. They should be reordered. I forgot to swap them back after testing.

>
> > +__xlated("...")
> > +__xlated("if r6 =3D=3D 0x0 goto")
> > +__xlated("r6 =3D r1")
> > +__xlated("r2 ^=3D r2")
> > +__xlated("call")
> > +__xlated("if r0 =3D=3D 0x0 goto")
> > +__xlated("w0 =3D 2")
> > +__xlated("...")
> > +__xlated("exit")
> > +__xlated("r1 =3D r6")
> > +int kfunc_packet_write(struct __sk_buff *skb)
> > +{
> > +     void *data_end =3D (void *)(long)skb->data_end;
> > +     void *data =3D (void *)(long)skb->data;
> > +     struct bpf_sock_tuple tuple =3D {};
> > +     struct nf_conn *nfct;
> > +
> > +     if (data + sizeof(struct bpf_ct_opts) > data_end)
> > +             return 0;
> > +
> > +     /* An invalid tuple size makes bpf_skb_ct_lookup() write opts->er=
ror. */
> > +     nfct =3D bpf_skb_ct_lookup(skb, &tuple, 1, data, sizeof(struct bp=
f_ct_opts));
> > +     if (nfct)
> > +             bpf_ct_release(nfct);
> > +     return 0;
> > +}
>
> Going back to the alternation pattern above:
>
> > +__xlated("w6 &=3D {{1|128}}")
>
> This isn't a bug, but does the regex match what the commit message
> describes? The pattern text "w6 &=3D {{1|128}}" compiles to the POSIX ERE
> "w6 &=3D 1|128" since tools/testing/selftests/bpf/test_loader.c only
> escapes metacharacters outside {{ }}. Without grouping, this is
> (w6 &=3D 1)|(128) due to '|' having lowest precedence, so the second
> alternative matches a bare "128" anywhere in the xlated dump rather than
> constraining the cloned-bit mask value. Should this be "w6 &=3D {{(1|128)=
}}"
> to properly match the endian-specific mask?

This did cause selftest to fail. Will fix.

>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/339954=
42755
