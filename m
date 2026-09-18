Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1327047D957
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 18:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754521; cv=pass; b=MxbBlzXbKn++V6j7OKLWrVLBP/tdxDvfhtMxEDsY9Qpty8LgRWSqBvA318bvvyn0rXRaNzlj/T/zgZ6bq3JwhIjFD+CnfyENUKjp9w+sqCy90XB/JJQhkcKqat7YDfgXILoUPyurFgpZU2/IQwuhmelah4oTV2ywO9shTXXHT9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754521; c=relaxed/simple;
	bh=D4aV9/V2T0lgtI47jW3XfRAs3J354z+O1K6sl0PCO8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Tqaepzzw8TBtlTrXR/uLttxjQ5z31CjtHuaAoHC5cV/WbJvi9hC++2WSn6ZBsiMam1JSeXCvkkU966VYMbCbAT1nYldJzn6V3uwaao9NdVLNCB4C6UIPqrmvpzhNzA6Cta+8gMx3kz0l30M9BK/5zOlLmJKKXvcwvEyqajCht7g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oOCIQL8S; arc=pass smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oOCIQL8S"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4c206dc8b0dso836940b6e.0
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 11:01:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789754514; cv=none;
        d=google.com; s=arc-20260327;
        b=bXeObiFJQs4DfgNH7b+PU9EvCLH5XG+7D8wem26yMzWfRq+LNRvZjkoI7UQufyxcBM
         VHNKypxwDphyKa/JtDeL764jai9SuJhOJaSMPq8PgLu32//MtOz1IQMwQJfeGb92YYdA
         Q3+fXG2IE9eOxxSMUM54tjfjRnPdqG7/JGPbfK9bS1S/HZy7V+0vgyJsNuPIFJesGLkf
         ppXFCNHwo3VJIkb9Yf0VMidHLho4c1o6RB9Os20vhAeOGIs2R0WgpJeZVrDZKEqGHR66
         ZBrio5XUeIEhMKB8JdYAt4vzNd1KWHrWmlwonatVybOS12mbckN3w56OXPPlbh2FlbCN
         tUWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NplD+iyuQz3OMkbtlm4TrefJDG7gfBsma8gEJO4G/yk=;
        fh=OfhfGSfv7Y2SVLuwb/D9UgW55QAcbXhfdfbkGmNsq5I=;
        b=Y2l7Jh1eWN7YhdDxl9jGzd3W8bosarb5ZMZI3tBGwD/VFMyQVBq8WgevapG/dex+tk
         tHjBah+qzeit08By3uu+2n80P/Tnac1ihq0AUDvRhTIhfqLRakn/bonFnq8DUsPv9uUR
         +cjCAJefitFdTRciTyHJel3oKK25Hd1d9ECT5LwQshKt6F9KLeuL7PdVHVI5IOVm+iXT
         BfuWnLMa4iD/NDuqWuRNHT2TcetgljjcZQU2c9lB457JkmbyEAJSfDf3hHaR+VzyNQm6
         nG4VOFGvy2Kf2O+M8g2yRyorTJxfe8n9ZO8nl27IP2avj7O1WEueicgxbGBewpbusoRq
         IXgA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789754514; x=1790359314; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NplD+iyuQz3OMkbtlm4TrefJDG7gfBsma8gEJO4G/yk=;
        b=oOCIQL8S9av/vDBpA+F8dehhtu0MyFKO/TaMae/OosF9AiWgMIbQBwiYQtpJSDOMxk
         9wpBFDyYPGhWwtQW4/+PW3llhVZuDhR9e2p3u6mPOMmdq7oQN2vc0no88bWeEWf0ccfL
         bsYIzfgOmhnpksYtTuO2Jqmm6SbwLg879/B99oqnBaml+egIDLxMPhfsS27nXwrdLfal
         XjZ5EkUw+byJxakDDL7m1TQAOG7EIl8FXWMA5qRwxeR9s3BxYDMkv973SmcEgsYrAWIz
         7oqMAEaMAgsGD17294toB5WVAszEDy1phZvwnILvG8akLNUY0JXlVYzi4up2tx+N8gk+
         hg4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789754514; x=1790359314;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NplD+iyuQz3OMkbtlm4TrefJDG7gfBsma8gEJO4G/yk=;
        b=T/hDBoPZmBd4Sh7fDLdLi001SVB09ABNfLEHJVcqlbtknTFtGeeU8Aei/brtWivbZX
         vm/yjZiPdtI9wEQTwuC8mLuGjYSsKjrC6Mz16yYLhf8h1qTLBUYToKW/Ex3rFhW8/109
         DKQqCDn8PcBq7Bw+n67T9YhwUEhC8uBWmnk55eNouEBk5zQUhes5e/ToJ+PVsD1NNNNP
         XXdiw8u6BXPgqvlSi3J6gE0iErx6YlyKgDG33Oz+i1tsu3cluHe80xr6DW2vRir68X+C
         lcRq4FiUNFSfL/EdfIFFfCb09IelMdwGYpR+/tjQlHOOrR1cQoRVLmotKqnlY2Gvud8a
         3ztQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQKvNs3oGIVMgm4gFo7GQwivNLt45fPw/3DfC5J4r8+6iqCQZ3R88wP84D3ZMlEKwD130=@vger.kernel.org
X-Gm-Message-State: AFuF++k+Biz60d8tuHSGeCPkMUCyCF6daC63snezXK5eUINxYxFMhoia
	3CTXoJ/3Y6ba1EhQh00Dq6C2zqCnRkSn4qODSxT2Kl+4fl5uKoHW5el324vSufXcEmv6h9it330
	rwCnYSqM6UuQb15O1HtniA5QS1EfVaNY=
X-Gm-Gg: AYBFou3hW/YI5x7UGshYq6qPKYGZHFZb0WpsEBRnGGgRhuF137HpeEnvgiDGCMVJLg/
	ri1kd+mDQdpmETKTTyoySqT/GY0mKbpCAn1AGMiE5foPZ++ZOYXFaOhfKRYqCnr94+7LEBwB0PB
	4Tjp8sFhFzevDZnQSpL1rlJNluJ+P9rAMEskHoG5KpXey4bMMW74TUjGNzROFdPYWAJOfe8f1Yb
	+ZFFlPHs6HPMVwIbhKKNq9ro+yRbqIu5w3zvAHd0EBQIQiD2UArRGcZgcqNHXf4IPgnHUOGbdgy
	OkIAkR4k0KB8YhlrOB/OOsR3108ztNl7xPtxS92i1FVf0sgoFQ7woa989iDTgZ9PJEwMkfM=
X-Received: by 2002:a05:6820:178b:b0:6b7:83c5:fdf7 with SMTP id
 006d021491bc7-6ca9c75016cmr3135671eaf.56.1789754514005; Fri, 18 Sep 2026
 11:01:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260918052906.12226-1-memxor@gmail.com> <20260918052906.12226-4-memxor@gmail.com>
 <20260918055038.1D4AE1F000FF@smtp.kernel.org>
In-Reply-To: <20260918055038.1D4AE1F000FF@smtp.kernel.org>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 18 Sep 2026 11:01:42 -0700
X-Gm-Features: AcwNN1Uab8kO1EQcD3nOtj9wZwXUV80qHQAweUeg6HNGFR-V75aFhIIx6sft2CY
Message-ID: <CAMB2axOVeCSWogRJn6z31J+4to6R2T7U97MEP-sAO6Zv1jeTQQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 3/8] bpf: Check read access for initialized
 writable memory arguments
To: sashiko-reviews@lists.linux.dev
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 10:50=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 1 potential issu=
e(s) to consider:
> - [Critical] bpf: MEM_WRITE without MEM_UNINIT enforces BPF_READ breaking=
 output helpers
> --
>
> commit aebadfb01a3b32540321fe2b60bcb6fb1c8673be
> Author: Eduard Zingerman <eddyz87@gmail.com>
>
> bpf: Check read access for initialized writable memory arguments
>
> This commit updates the BPF verifier to derive memory access types based =
on
> argument flags, correctly enforcing read access for writable memory argum=
ents
> that are already initialized. The change addresses an issue where helper
> argument checking previously omitted read permission checks on map values=
. It
> adds a generic func_arg_access_type() helper to replace the kfunc-specifi=
c
> access overrides.
>
> > diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> > index 1d5e4ee64fc00..21eb806b1351c 100644
> > --- a/kernel/bpf/verifier.c
> > +++ b/kernel/bpf/verifier.c
> > @@ -8886,6 +8886,15 @@ static int process_map_ptr_arg(struct bpf_verifi=
er_env *env, struct bpf_reg_stat
> >       return 0;
> >  }
> >
> > +static enum bpf_access_type func_arg_access_type(enum bpf_arg_type arg=
_type)
> > +{
> > +     if (!(arg_type & MEM_WRITE))
> > +             return BPF_READ;
> > +     if (arg_type & MEM_UNINIT)
> > +             return BPF_WRITE;
> > +     return BPF_READ | BPF_WRITE;
> > +}
>
> [Severity: Critical]
> Does this regression break pure output helpers that lack the MEM_UNINIT f=
lag?

This is a valid concern.

I still think we should assign BPF_READ | BPF_WRITE to kfunc arguments
when generating the prototype, and only BPF_WRITE for __uninit
arguments. This would also avoid the need for func_arg_access_type().

>
> For example, bpf_snprintf() is defined as an output helper:
>
> kernel/bpf/helpers.c:
> const struct bpf_func_proto bpf_snprintf_proto =3D {
>     ...
>     .arg1_type  =3D ARG_PTR_TO_MEM_OR_NULL | MEM_WRITE,
>     ...
> };
>
> Because bpf_snprintf() does not guarantee full buffer initialization, it
> cannot be safely marked with MEM_UNINIT. However, with this change, the l=
ack
> of MEM_UNINIT means func_arg_access_type() will return BPF_READ | BPF_WRI=
TE
> instead of just BPF_WRITE.
>
> Will this inadvertently force check_helper_mem_access() to reject valid
> write-only maps (BPF_F_WRONLY_PROG) when passed to such output helpers, c=
ausing
> valid BPF programs to fail verification?
>
> Additionally, for unprivileged programs lacking CAP_PERFMON, won't this
> erroneously enforce stack buffer pre-initialization by enforcing a read c=
heck
> requiring stack initialization in check_stack_range_initialized()?
>
> --
> Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918052906.12=
226-1-memxor@gmail.com?part=3D3
>
