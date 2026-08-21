Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC56F386C36
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787333478; cv=pass; b=uh7Rkw9D1DgKjTnhdLRLFOywn+wl0PGGNZ7oyBMm3sow3GRPqlQvgDEVkMMAC9+Ru7khgMo4JZO77tfuwupsvxI8XxeBgZFAZxxgKQ/9CHYjrL9SxTZwFrzjyEy80kq215mqkadKKLvmmPWuJUjxuSSZ08UGyUw17gJhl3o/2MU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787333478; c=relaxed/simple;
	bh=71ETzD+l8/8KZpV9V//bdma2ToKvQ36gSqMPFnsxLrY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSpHyp6QstpuSnPRqOiPvzKCn6tP1lkQNYWT9D9J04nbYZnx1QvOKdWjaUCRb/UREOowjQiwnzhehyC1JbDSWpJ38IEpN8+WOcXOfQrXy7fvzShyCGnugFK7rIzJhcgiy67SFwbV8dxJcYj5gJxlE1QSa2keS8WIMEjqHbGoG/s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afG5T261; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afG5T261"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8485ef63b68so884345b3a.1
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 10:31:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787333471; cv=none;
        d=google.com; s=arc-20260327;
        b=DCP7SutxMlY9SRtLj8t56VJahN8Z1/YG4VXP/hwBj/Kv2I4JIHY/ycddh/76TVDnXD
         51LNOYc8OcAuohVhSQX7ikdoK8L3C/Eq0F2nliKHtsZIjKHMz47QQTcbjx62Sp27HhnK
         gbiPudR28gAq0Mcq/+2hRPVzj3baF/ufEzGlmaPmcMplYtPCSsjQYSy4h8HQgT4apuk4
         Gc63SxkofWZzW1d6rp7ueuQub+SeSyVD2ITN2oMJ5diGbPzheMiwGYyaYMInp9oylNqi
         NhMGWkIgpuooqYekdJyGvG/ETM489ztoE4Oa0DwzuWEPZhG92x9TgRAnGQCg9wCbPCPE
         pWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3xhJ4UndN0UWjHcsEFLyO5RtzUQ8hNLN4OHrW5zWtVM=;
        fh=kaBjKMHlv4BeS2Fvnn1k/wjBk4PsVkCFZm2GfzzOMvY=;
        b=nELnJCP44Sru5tHzZoYeLDbjX/p0AWSXP7AfhXav6ra70WHuCgWretVaj8GldbzCsv
         henQxxVuIjkA3MGhMomELi84xBlgauvAzSznWmx7RehbvVT3DKkF3xD01DZGuKfPWwnK
         qHwSs2FwXlemaHN72TS2Vma2N9lxUhByh14YyTXTqiyLhLi+kMDt1ccsApDMZZ3QJpEL
         uu9Lb78h+YPom1CiK/zrbndtRCIOKdoJ0cThydV6JkEL6X9HY4Pmsd6uHQ/f2QnDv4UA
         GN1WAgZtR/ClAv0DZ2xvQruhrXwJwTl7LxP3ST/wZ9uWQJC14Og3iF/RDm4Bm8zNAUry
         G7gw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787333471; x=1787938271; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3xhJ4UndN0UWjHcsEFLyO5RtzUQ8hNLN4OHrW5zWtVM=;
        b=afG5T261B1tH5P+vfHVr2EwMibpej48KG2Pp81h8vnxlfrOuyUIAn0zBkfcjQHUZti
         10jvijvP0HNhbMejo7Bi3yIyXejabl2mqjVci3ISnm5YB8+FoiaaRVkV8NruELhRRYq3
         gHw5RsXw4flz0kL+C8+fXlgXKew3uGj1twm4hFWSIWz6Hl4HYilzPurnc3ZvRF6joZKq
         Q4yQqazWQ0LwZLg5GbfqZ8BDJWfsFoos6rkuCMBaNiLc5PLpazh5ROmAXVg5iYzyMZsw
         z5K21EucjWuvjqycP6zuRD1eukBmGIF9VFnTtmiU4gb8hLWGEIIv0yqrFrE057ldd6Jb
         MFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787333471; x=1787938271;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3xhJ4UndN0UWjHcsEFLyO5RtzUQ8hNLN4OHrW5zWtVM=;
        b=Ea2gyEfm3cNLjoAu84sRp6Qs13PoOH6Z0W1tCDLVM7MiSj3xiB9sVshizzjorOsswh
         9Zgm3dhhiiIqJKjx+6JQulV/z4ajA0+KoXVwpbG3jKkc+pgQJYDefLX9PuG+4zM/PpKl
         pdf80SGPZUkj/AHZKNcLkpW846rxtknOH+eNgWVbBlfhQ1DP2/LGyIFdj/YYszR0SbW4
         GTWDyo+WND1TCo6GddvVunHa7NFPWVV3O5cNakkWvR/O47iOLDZWvP6F1fRCcfsfKX/e
         EuE+17l/8HbhaLmPB5evA0Cw8ae3BPt9wGmTFMKRaUVJs9KrhTBK6r/cYSVtao8acolb
         qB3g==
X-Gm-Message-State: AFuF++n3OOkqNdILQj8hyFQB8Wy5GwWKqRQfzCH8BQl5MKrff6Rh0C5V
	3lfFbKkwaCqsWlApFJWsk7/8OCGm2v1n43hCmj060Xq9ABEvdUAWss996bSE5gWZ9Fhd8xKtwaA
	bOhCAUW4LL4oZKHA4yiaH3e48F+X6UBU=
X-Gm-Gg: AR+sD11xtO3l0ydh5JYsAVGRPz+7FPYMjEh8wqZC7D5GeD4NxWoN2q8b2QYaqT37Vgo
	j8q5LMwMjKuxD58t8TjPxz++TG3UdtgO7RSCtqE9SZfwNalKKqqh6wJfqQH2oeGgLhOiRoUlwf9
	jD1eo43qwYHl7PLbqPlFWRy9CKS/Ve80Siwrq8a93Mzmr3PUzes4ie9nMQWaIunN+JJfo9PR5EE
	gGD5oKnxWq9wbkF52nk5b8R1vaAVokCTMbmqQ9jfIfg9Wy14+u5jOjME4MFjbC2xr3/dNYXO95R
	WWjMwE94nf2RqVVi/uwo/Lo03qyxPyWKDPbi5uBJ//kLmPOzAbe7gofWq5yeqhlNKmh5aW4xoLR
	Wj25YdIc7N7xJReu+DZP+BXHT4g==
X-Received: by 2002:a05:6a00:1d9d:b0:848:67ca:bfd with SMTP id
 d2e1a72fcca58-851fa017101mr13222177b3a.16.1787333470987; Fri, 21 Aug 2026
 10:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820152532.621639-1-s.mahnur.a@gmail.com>
In-Reply-To: <20260820152532.621639-1-s.mahnur.a@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 10:30:56 -0700
X-Gm-Features: AcwNN1XANjk0n8jzavAweB4B0jx1QOPaM2D1vGwpdzDHxCe_LsEvJuMRqaxLGZo
Message-ID: <CAEf4BzZd7BDdJrNb+N3uktbwMJRHjUFzG1xfzmTDibEmAKX8gA@mail.gmail.com>
Subject: Re: [PATCH bpf v2] bpf: Fix NULL pointer dereference in bpf_sock_from_file
To: Syeda Mahnur Asif <s.mahnur.a@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	netdev@vger.kernel.org, andrii@kernel.org, 
	Emil Tsalapatis <emil@etsalapatis.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 8:25=E2=80=AFAM Syeda Mahnur Asif <s.mahnur.a@gmail=
.com> wrote:
>
> bpf_sock_from_file should not dereference a NULL file pointer.
> KASAN detects a null-ptr-deref when eBPF tracing
> fentry/fexit programs are attached to points such as
> __mmap_region and file_map_prot_check kernel functions. This can
> result in a NULL file pointer flowing from context to the helper.
>
> A minimal check before dereferencing can fix this.
>
> Fixes: b60da4955f53 ("bpf: Only provide bpf_sock_from_file with CONFIG_NE=
T")
> Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Syeda Mahnur Asif <s.mahnur.a@gmail.com>
> ---
> v2:
> - Added Reviewed-by from Emil Tsalapatis
> - Fixed name in Signed-off-by
>
>  net/core/filter.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 16845987b244..7c3caae4bafc 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -12182,7 +12182,10 @@ const struct bpf_func_proto bpf_skc_to_mptcp_soc=
k_proto =3D {
>
>  BPF_CALL_1(bpf_sock_from_file, struct file *, file)
>  {
> -       return (unsigned long)sock_from_file(file);
> +       if (file)
> +               return (unsigned long)sock_from_file(file);

given this is a legacy ARG_PTR_TO_BTF_ID, it can be not just NULL, but
also a) small value bogus "pointer" resulting from NULL + offset
calculation and/or b) just random garbage casted to struct file
pointer with bpf_core_cast() (maybe this hole we've closed with
explicitly untrusted, not sure).

Either way, this is not a sufficient fix at least.

But I wonder if the proper fix is actually to mark this (and other
similar) argument as explicitly requiring trusted PTR_TO_BTF_ID?

Thoughts?

> +
> +       return (unsigned long)NULL;
>  }
>
>  BTF_ID_LIST(bpf_sock_from_file_btf_ids)
> --
> 2.53.0
>
