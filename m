Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCFD267B07
	for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 16:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776788957; cv=pass; b=BtpI/3LLPBWtlO4Hmkpf7ietWawJXwOtpX0LIoGY5972trs+ou9pApeIihe9nkUxTM8xg126+wV7IMy/C6YIDbM9m/mIw9tkldkadypopBhN+nV+asVgpCZ4r6OKtYS5ZjQHbSgdU3XFo4kq9OVBIR9j/+rUkDdtOzNibaZJWDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776788957; c=relaxed/simple;
	bh=nCF+1un+lGenxIgZVRGeii/JzzuN9IQd1W11H+yrdes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jOtPhXh0DjoEIxQK61/6/ep6ttrkfcTb4XxiU0iF4FQoLBWUrBhnlb3miCPjR9NkOv02l4kSfO+u958DI5HPUsn0k6O/6gI4hHXAbFPk8w6vBuiGQZCqK6uqG7wOsDaobWlp23IPIHGV3SrsBiCuOTN+1xML0waGLm79WbDl1io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=phoXAwmz; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phoXAwmz"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79db5e18ac6so55705387b3.1
        for <bpf@vger.kernel.org>; Tue, 21 Apr 2026 09:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776788955; cv=none;
        d=google.com; s=arc-20240605;
        b=aGlbNQuZzbb7TZfk+5eRH6pzCdVsQj0QDFVbfvUK0mOy3rRcAK8el9/LTDgoq9172x
         nMO0+2gXAT0TDed7nWNRyOdBg6Vh9A9h8QavEc2NUuT4VE7ABBh8Bw3/caHCuQ/ts1Qi
         haAt8tdt3blIQC3PkCUS5KrY86mLx/T3Mb5vUPxmuaNoR0I4/dfGdG+s21ZPKNp3MCIf
         jM5crTazdE7VgRXyM6h996Aa7kSPOK5VyEtSRqM1zj+6ck31j2zHZwlIoZnIZva1Tnti
         Mj4T9zTnqfJGiXRHOZD9zk4Bk05twtf0Mh/R6jnQkEv+HFpes66NO4O11APLS0oy8sHi
         YUjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xaRQcetDxlzLKskdLR137Weekycfdm7Q7GRuYQIPPqU=;
        fh=yD4UMK0L47/I9dQQcEHBnD6tDn3jQHaZlSuFA9/a1u8=;
        b=LJVgvpDp7cw1NZuwfD0DLGrHO+ugHL9BTpNYq3p1+E6sO5foJXQ/T3ZDeW4wCIFtZg
         fkTbgwKKBK/ciRhGx8jt9orsy/wzf8t4GKFfTYShwsMPI91THZgK22o1U7VgJ3p3HipL
         vufapWKzppv1MKP7bDmOec5MNTnLsr503sZvMOP5oSCWbgIxt3E9g5ll9NgbmnEl+ogA
         JTS1g0ksMjWqxkUz1qmelBexvcg+B/UO+G/BXAFCVDcGtxA4te5+qx+t2Wf7LLoJTU5U
         NeSPrH8dxdEUtlU4g6qngwYm0h4u74fdSvK7MYRcsCaSN3DRZ4K8i00tUqE+Ybpyyg0K
         3aEQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776788955; x=1777393755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xaRQcetDxlzLKskdLR137Weekycfdm7Q7GRuYQIPPqU=;
        b=phoXAwmzYg6qvzarMt49/30aRAa4xLFI836iLr664Z8XCH+KdN5T/3elpa3E86qk97
         MVWjUPx/ccPgBGUewsHw+EOZ/xkSftAtaXqiZiwH4Q/gxhitT7O37WrVgEGekZJiThNC
         BdXVz5WO571o2SvWz0NBaqWjkcViXVOwFIrt3ozAGbiosIlM15uKTW/YWEODYEO69hR9
         WOz7ei+gxidWdtNbF+EfuU4MQSYHq05XmSYmrp65dLtL7uRskO8G27XUCvUQHmofGLAZ
         f9cXpj6Jh4m6ySL3vQbBMIsLaA9PcszH8MODTr5rzBKuhK8hIhoirTveBK0qPBlNtI5c
         XLmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776788955; x=1777393755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xaRQcetDxlzLKskdLR137Weekycfdm7Q7GRuYQIPPqU=;
        b=ITOtiLQ23Bbld8aQAgOaGqgCUV3UoawBYJhAPphcav4PvdjH6rS6MnnfIo59SkXKp2
         HPwO7mgq6/o76A+YS92NCIBsYKY/sSEfHXwMUeYcq3Ir+OfabbD1128XRQdkgbsyveye
         /xe5ZUN/OgqN78MgytLcNp4ybiZneNkfelojWwUOwsaaLP/4qR+bjwfPQKlfGmQUOILZ
         seWX8i9hOXRGc1DaLBfG9YVuxRmcyismNyPeqk1EXWFBSlWbgjvukdqfWWKtjw5jMXKE
         HaXLPgOK40wL70F8r62ENdYxF7Hf24pVCMKc2x8ztzYQ9TMb6zYutQHy+PP6lCIa/8wo
         bmEw==
X-Forwarded-Encrypted: i=1; AFNElJ/f7cs4RQOOuD+2s4rX+4mYIcgQVmQzk1CiFihcQBJlBxqyQrb3wTxx3G0ddr9Mc7SQbz4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqBNaxhPKvlmtbBvLGkMxgX9YkMfiaZWr6x+DoQnYUPaBgGV6h
	6m6vewMVGzkYBMqsiIMogVERv4Z+y3p0EIhLbhs/qhwTe/h1/hPp3UPF/HgDUQq89s3zfgTNKrM
	9Lgz8JsSwmhcgcI4hpm19KflvZnlCm/w=
X-Gm-Gg: AeBDievxl4D0U9ifjw0V6zzFSdBMPT6625IRArafMGRv439g4Jqgorb34vhgB43rv2C
	brl5LiZs4+PpZoUMCR8wIERAX6wc1frd32rM61w4Lect4F77kelDrIswgdHQNsGqh4fB4hJWAuB
	cFCIvGaR8OPYO8XbWzfxs+f2aKTy5N6tmciGkl/1XSSGeFjBbwW/g1t5b9HOQL8sb0/LFu3033Z
	5wDoiA3ppIUOozqZvM1PCr4e+YlaUqaycaW/kXAVp4I5MEGfHxmhZazITTsOmuuWMywbR38LEmv
	7KvOe2KbBItn+2uJOvjWeEdm
X-Received: by 2002:a05:690e:1914:b0:651:c41c:80ce with SMTP id
 956f58d0204a3-653119894a8mr14903838d50.16.1776788955294; Tue, 21 Apr 2026
 09:29:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421155024.997077-2-bestswngs@gmail.com> <cc500964d83d95307126b05cc7557309b498bafce0c514fa3f1656dd6413ce71@mail.kernel.org>
In-Reply-To: <cc500964d83d95307126b05cc7557309b498bafce0c514fa3f1656dd6413ce71@mail.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 21 Apr 2026 09:29:03 -0700
X-Gm-Features: AQROBzC0QupDF4QkVKXKjJ8cS1W-C8_sxM8tSkEEgO-pFajTN62MPAl8x7WV48Q
Message-ID: <CAMB2axO5rZP2bzj5X9uDsVZshXoxEXLZt64P0CuEvwGficHfBg@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix NULL pointer dereference in
 bpf_sk_storage_clone and diag paths
To: bot+bpf-ci@kernel.org
Cc: bestswngs@gmail.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, martin.lau@kernel.org, 
	ast@kernel.org, leon.hwang@linux.dev, kees@kernel.org, wangfushuai@baidu.com, 
	menglong8.dong@gmail.com, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	xmei5@asu.edu, andrii@kernel.org, daniel@iogearbox.net, eddyz87@gmail.com, 
	yonghong.song@linux.dev, clm@meta.com, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 21, 2026 at 9:24=E2=80=AFAM <bot+bpf-ci@kernel.org> wrote:
>
> > diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
> > index 14eb7812bda4..b2cd2b0292cb 100644
> > --- a/net/core/bpf_sk_storage.c
> > +++ b/net/core/bpf_sk_storage.c
>
> [ ... ]
>
> > @@ -596,6 +596,8 @@ static int bpf_sk_storage_diag_put_all(struct sock =
*sk, struct sk_buff *skb,
> >       saved_len =3D skb->len;
> >       hlist_for_each_entry_rcu(selem, &sk_storage->list, snode) {
> >               smap =3D rcu_dereference(SDATA(selem)->smap);
> > +             if (!smap)
> > +                     continue;
> >               diag_size +=3D nla_value_size(smap->map.value_size);
> >
> >               if (nla_stgs && diag_get(SDATA(selem), skb))
>
> Martin KaFai Lau pointed out in the v1 review that the NULL check for
> smap doesn't fully address the race condition. The issue is that
> diag_get() will re-dereference sdata->smap independently:
>
> net/core/bpf_sk_storage.c:diag_get() {
>     ...
>     smap =3D rcu_dereference(sdata->smap);
>     ...
> }
>
> Between the NULL check above and the call to diag_get(), smap could
> become NULL again, leading to the same race condition.
>
> Martin suggested passing smap as a parameter to diag_get() to avoid
> the second dereference. This would ensure diag_get() uses the same
> smap pointer that was already checked.
>
> Could the fix be updated to pass smap to diag_get() as Martin
> suggested?
>
> Reference: https://lore.kernel.org/bpf/2026420182243.zAiN.martin.lau@linu=
x.dev/
>

CI is right. Please pass smap to diag_get() as Martin suggested. It
will be the caller's responsibility to do rcu_dereference() and
null-check it. Note that there are more than one caller to diag_get().

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/247325=
81685
