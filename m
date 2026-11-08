Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.74
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794151762;
	b=nBKYOl++lLpPQcNhQkjttbzf79UUvZP/lxSfPY0PqncbyI5ilgjDCrkzcHmWu+TwAAMT
	 VY4vVhYesS54K55ji1rkz4OmxtCe1pJRuygO+ov5T3Wc4yFh9WsxFbYSRD6SNZXmq40o1
	 RSctvfIVKS7uzZvycXnQ29m4OE5M/Dr9zX+KYwwJLY5EpMjSOBtl/EzA5zY2K+F4guHz9
	 aBHta7+cmidCu73LvndAES42Dnx3ItubrK6pS9nB6rJvXbGyRmOHSPIjTgjjeBKgwrCz4
	 SikaLd0xYqxJR06DjfOHCmiQHkuyzQIuoc4bwcsllPiuyRckyLR8ynTu4xS/AuN+hxQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794151762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=XD5dIdS5uh0CV3gpIfb2MNY/50x7izzcf/NiFrLXOKw=;
	b=2LugNpdxQzw8nHpcysuNqBK/y4YoC0KtGIMNr6N0QdU5BNvP+nG3VFxZ5vplaJUkeGi/
	 2obnVAipsOjLhMXez6RC2Z9X0BcbwI8gTjuRKMnsbFdzPRwSE1CbJaDx1VH1FPpHyOpgz
	 Q3mdxMl7oLbwScI0iUxYeUNcstjFabyeogOeDcPf1uxVoHfXerwVWJ4lqhEmpwjcfRiZ/
	 Bj1IATv/t2d5WWtBOh3GjdTM/37OqtpX7zjiJDGXt7zAgijqJS421qM59aLIncy47Eyyd
	 Qz7zCmkhBRDWKVEm5nJC0tNgY2bdzthXFZXz4/MzBClF4nWofGbpvyci0Ts0eM27/NQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vKtcUz5t;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.230.74
Received: from mail-lr2-f10.google.com (mail-lr2-f10.google.com [74.125.230.74])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C2B606A31C
	for <bpf@vger.kernel.org>; Sun,  8 Nov 2026 15:29:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95C2B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vKtcUz5t
Received: by mail-lr2-f10.google.com with SMTP id 38308e7fff4ca-3acff0d1090so1537911fa.0
        for <bpf@vger.kernel.org>; Sun, 08 Nov 2026 07:29:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794151760; cv=none;
        d=google.com; s=arc-20260327;
        b=Uwas2Psy+N8TaRd7mbrm6ce3xwZBHC5lpmDHENAqzTiwHVjxgtbIducWx2fe6OEWue
         /5Samdvi0dnF1pbMVTB5Nb9Su7UtyK7FCSFFnpdinjZYC02HM4EjZ6W6UME4N7x47co4
         34JrC/qJ+CA2DOdW9MlZegIAcZyZpVCk4miS3+3dsbZKkSHXcoez9d5H/FrK5nYWu2X0
         uMxWPF5SHTW1qwzmt7zAmvCultR9vl1GX9kZf8MwhXYOCK4bxCYcSU4mn4f1wRUOg6jy
         TBx3zoNRUlTKigWRapJEv5iO1GYsIEB10rjg+aImlclMv1l/an9QskBOUEzyUP4nplyi
         iJcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=XD5dIdS5uh0CV3gpIfb2MNY/50x7izzcf/NiFrLXOKw=;
        fh=t8fSlha0kbvYnp344UcqxpAoQjsWz96gblH5i935t7c=;
        b=KWeJ8M1q7Cfppu9CiARbAfTC/MB9hYbTgrjE78R3KZA6ZV+kYVrMQ9zrfhu9bnE4bo
         NYlS5W2mDOBbOvUiprYaiseF22eDxkERF36OUSQ8qkF6NKTK5Xz9VKBSP2mhloUfXt7G
         W+ql8WGXjEnRSu0K4+z26P8dYiNy+YHzTGBgTtGoV0q7TNjtgWmou6S2qoTPxMm5y3B+
         ncocplcRapEWiAJzAO9rm2S7FzBaaS0LorBZNM3RduFzjW9r2reFKhIDkRFsLokxroA1
         xXTiooK5ssWdMoNh4ScBS10J9vy88JO1ZV1iOzZKjveN0E0U41CaUH6D6O8AFNHypXT2
         E+Bw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794151760; x=1794756560; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XD5dIdS5uh0CV3gpIfb2MNY/50x7izzcf/NiFrLXOKw=;
        b=vKtcUz5tpbla9oZ3FOYtRWT9dcLtMf9ZC09vK+yGnOWcjNqBYw5arfxGJGSq7gCgdj
         msKdr2VrrDzS9guB11bcYMPvzYjtSxXqiPPkMk/k5p1mjp3YjZePwJVAmCPeiCMKp1NJ
         AWdb3uLcnBzKR4gMQciZOwzIleQwYg3Z9muCmL2qpSDm8uj7+gUULrna68zKUM3k0+qV
         VwNgFq+VU9R8f1TcF7koGke3wwsdR7NeLm05emsaR5HriN7BxsZQxdanVlYhRFhqzYMv
         G3SXaJDqD1agCEdY8UQqYXURyYiijI1ZrS41d1M+hGkNC+XRwn7FET4JBHCu/LnUHnIV
         7z+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794151760; x=1794756560;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XD5dIdS5uh0CV3gpIfb2MNY/50x7izzcf/NiFrLXOKw=;
        b=Lo0RnJeRRvRYOJkenepQmpEPeumnw9QgBNzBggg8L/PoLcyySIzqMhDj97JffCbUoT
         +R8GvVRpg+AtL6VhKgC9BjHI22T7c+v+PqsRhNoZs+991gUTEkyzUU3WQqz2DlF6uULn
         I8k3KIIkPaQhBdGzp2Ur3l6CaoC3drRbdx3lPOqEOBpsaRjI4A4LvBTjgf7EKFabd/A6
         Ww+UlUxTjGu31oRxPat/JgI4NsDqmX/cwYgL+ryEgvs7H/z7GQIEGoCRl56Ap+yxYPei
         ojL4q/Ly0wlUwZEN/7LYkE8OZMcjXIX1zwqCV6H9dX+tYtWSJ735rnNYCK7d42fXCV5j
         0zJw==
X-Gm-Message-State: APuU4Z+JSdfKU+uCvfjp1qmHX2zAjtFmIk7iQILDq8+a/6cpCIXw43EG
	ugfJiJ9mEUrDfW2tXo/d6WvbkLLbnod9bAasYhdu6gxSkiCkJvBN5CUH5IsvMglOLhIcMfpoZY1
	eLnfdLn13krZ7Pw5wqMba+S9aiUwiMV4=
X-Gm-Gg: AYBFou2rUcWbZsBg4sL7rGU6FfblUONgkpJfSFy9wgf5K32xowxyL98/zKEEPp4i3Dj
	ggxHO52nc2DlKJn9G/4NNV7aiMUDeAdKlfPcPEhfDHafpoXLM9RTteA9ISv/7gpWkhxfdB5SKOa
	pb8WwuqwtTMV0Tqe6cL4X3eWDpQI8c9CNwfGWAilWkxzN6/26rr1MwHE8/qx4KykL0BMi8HSi+7
	lGxc2hxKjd9/TxYaXbezYmtONLDEUeNhEAhjoBK5WvTAC1zGVm7wesGBzLkU8nqyL2m+qUTGZB3
	fLMOAwXDPs9iwMjvQYXLvWyRaO8znOHKVYpyGpYou4UecRJc3pC/56AfMEZoT8nL7pC+Juu765+
	QDKS+mIK9QGCKcFhXQrIsDzkr2IEtP1FGALIf0w==
X-Received: by 2002:a05:6512:4402:b0:5c1:4c4a:f026 with SMTP id
 2adb3069b0e04-5c14c4af0c8mr343875e87.4.1794151759470; Sun, 08 Nov 2026
 07:29:19 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261107135419.81491-1-shlomojune6@gmail.com> <DMP4ZP50NN1A.3CMXK8Y0G0YO2@gmail.com>
In-Reply-To: <DMP4ZP50NN1A.3CMXK8Y0G0YO2@gmail.com>
From: J4f J4f <shlomojune6@gmail.com>
Date: Sun, 8 Nov 2026 23:29:06 +0800
X-Gm-Features: AclHuK9-F4EovTPpk0JWgypYXddFCBYw42HYVqgiVkR3iyO_CqGKHd1JkbMxDsg
Message-ID: <CAE_LbwmXuXZmBj8VDxDTKrnmYs_vtTLNKmUb4Q+5SKRNqqD=jQ@mail.gmail.com>
Subject: Re: [PATCH] bpf: fix special field check with variable offset access
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Nov 2026 at 00:58, Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Sat, Nov 07, 2026 at 05:54 AM Shihuang Liu <shlomojune6@gmail.com> wrote:
> > btf_struct_access() rejects direct access to special fields (kptr,
> > spin_lock, list/rbtree nodes, ...) of program allocated objects, but
> > for variable offset access the check is done at min_off only, while
> > the whole [min_off, max_off] range can be reached at runtime. A read
> > leaks the pointer; a write corrupts the refcounted pointer and crashes
> > the release path (bpf_obj_free_fields -> bpf_mem_free_rcu).
Right.
I'll rewrite that part.

> Not the whole range.
> The code at check_variable_offset: keeps the access inside one array.
> reg->step has to be a multiple of the element size.
> Every access lands on the same member of some element.
> btf_repeat_fields() repeats the special fields for every element.
> So with BTF from a compiler the check at min_off is enough.
>
> I think it takes hand-made BTF with members that overlap:
>
>   struct node {
>           u64 arr[4];              offset 0, size 32
>           struct foo __kptr *p;    offset 8
>   };
>
> btf_struct_check_meta() only rejects offsets that go down.
> A store to arr[i], i in [0, 3], passes the check at offset 0 and hits p.
>
> Is that how you got there? Explain in commit log.
Yes, exactly. The PoC uses

struct evil {
int a[4]; /* offset 0, size 16 */
struct foo __kptr *p; /* offset 8, overlaps a[2..3] */
};

> Also drop "A read leaks the pointer".
> check_ptr_to_btf_access() allows these loads with CAP_PERFMON only.
Will drop it.

> > -                     if (off < offset + field->size && offset < off + size) {
> > +                     if (min_off < (s64)offset + field->size &&
> > +                         (s64)offset < max_off + size) {
>
> This rejects a prog that loads today:
>
>   struct elem { u64 data; struct foo __kptr *p; };
>   struct node { struct elem arr[4]; struct foo __kptr *q; };
>
>   n->arr[i].data = 1;      i in [0, 3], step 16
>
> pw-bot: cr
Agreed.

Sending v2 shortly.

Thanks,
Shihuang
