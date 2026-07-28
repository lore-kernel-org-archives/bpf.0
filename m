Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92B13128BE
	for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 15:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785254349; cv=pass; b=VXZpnH+1+R8bwX5H8tv+cldL4yJWkyRWRCS0PmznnVtYeetXFbpNmzjCg3X6DZ2Xh7KHGYxV/A3Z7g4Y4ja8kSDQU+pkiEd7lYRBGxH/J+79AUq30uZFJ4+EsrmlHPDF61tgjkrlk++Pjh5dW2VXU645HDYRc1MTlo16lsBLbwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785254349; c=relaxed/simple;
	bh=ePdzYx3Dv7RqO6ZInXv59a+0v2AEvDZHfhcy+eoz+Hk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=otBZlv+dr4y7J3UI97HT2fFNXp/3adTcbnbSP/Bc3LdLP3F0UVx4EuhQkJI3OEzMitk9akak6SMf0t5OWiyuMumRNy0jwLdEn6CXhU733DzM69TdJJocnaZlEK+2WeJqftJMwWVQ8fGOnm7nxq/2HakUdC33DngZ3IIUheyfTgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sgxACY/K; arc=pass smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sgxACY/K"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-848593533cbso3035106b3a.3
        for <bpf@vger.kernel.org>; Tue, 28 Jul 2026 08:59:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785254347; cv=none;
        d=google.com; s=arc-20260327;
        b=A9e1JWXMoECr8BpOup2XrZKrCWtAkanAhWk/LTt9sTrmmrh5O1Y5m4n3C3wbUGEZ8Z
         Z0A8s36RMROarJi2ENjwmozLGNL4Lh5+KeF9lR+/ymqujIpZ+mHm54NE/WpleChy5A39
         DGYPXoA2KFTZBbnqH9WYpaWtphJKONYb8VnCqJYrG/zTe6dojtwzuDtjrLuizjnmGITI
         gAUMVzm5MnYjmTLZY3FccyFnSoP1V9dIZvb3+btxRtKpE7n+QRgqUSVgFlUoWpz4UWn7
         gHDRdRGb1VJ7w9udHHzN3Ad+gLwznwiexRyVxDkjVxc96xa6G2hUXSCddQtkVIGknBac
         PbEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LI8BHo8dg9d3Los4oEWkJj6jH8UFcrTJLqvb7BOjjfI=;
        fh=QeoNk8Lfl75rS/yoMdhXzmt/NoC2OEGEAw3WaiGeSF4=;
        b=PmpF/kEi81N0Q6mAAWO/VCfl+Ud2eeJc8jUW9Qjq5VNKbUpUnP1HklKjifnt7ADYkw
         wBxR/Ju59KAzaVRZp2INXFWqZ16OXolZFjEoKLRtjjaFm6hdYWfLlTfGvAv8vMusyRba
         lsnNYDF1f7E+wFWLaM1Zr9BNJcGSw/6ldax8b3P5/h7fZ1/r/Wp/yqkzcBOAKDuCZPtJ
         PfTojMMTBf+CFkapnc3bz+4G604k3LFzf+1C2ukx+n3Nvhi1SG1eCd2NPXMHYvBUdK9r
         tTH5Fpwt6gPQhZTj1pjWAtjnOm4V1CS6eZ4JJBQNLxyvMOLVUbd22UJCMFl6jzG4g8k0
         DcdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785254347; x=1785859147; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LI8BHo8dg9d3Los4oEWkJj6jH8UFcrTJLqvb7BOjjfI=;
        b=sgxACY/KwMOpmVtf9Au2GHwnFBIuY+n3iEdQnWyOrQqhIfySb+HQwXHYvkDWuhWYV9
         rPZ/V/g5GezwszrRXtV/qXbtDkYGFbh8E8PsUjrzV66zMvxLr2/5KdbgKt8RW1hSdNcA
         F/H7jwcmHf9w6B5jSvfNB2VPTEj9mz8GePssEaeR5fsWWFoN22OtbMo3HbMRLK3RiO/x
         4dWqVkcRMUTbmhlbbmjhtKhk8cmAZ0azFYwJCwC4uabS23lJx7T9xl9OX/uV6VDRDcSM
         +Vt2DG4ujzvpfL88ypcJzm8aJO7pEKkYHiPSNkZDbmr//YIZ2eAo2exja9808V75/OE0
         A1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785254347; x=1785859147;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LI8BHo8dg9d3Los4oEWkJj6jH8UFcrTJLqvb7BOjjfI=;
        b=V2r9LTFj8uYUces8pmxkPT+1p1+NAGc/LX6MZBvZu2sRYIJriMfCVAOXm6aINes0St
         IyUEqV6xS8FuoAUXRCCOwQpuRfQZXGKSvl3lhGvtE60a4NfMQnj1ER2zCrmn704z3JLP
         GHFpi6wb2XrlOZfSKVJAjRN8x3ElO1ckeNY/1BNM8PI2OFqezmFjToEzt3v0xLJcv87q
         8p7xmcnbHL7ab5Bm8kiDbGJrLqe0Ti1qjEYUgp69tDd3aoSUEd43muMp17s9AQKYvFAG
         HhBhRaVFi9kZB5dAwdsS39gf9t6jxEnoVe24x7QuSttTJQi+uAZjUahmm+qoXD/SwHsf
         cDVQ==
X-Forwarded-Encrypted: i=1; AHgh+RpJpQLzTvXV7UqJwg/u6Qw6zg9KnEL75czTSzY9/rvlEYUlw8Jli/gln6Qxapsidb1xzaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYMO4o3sgPXug73TRk3xCr+8X/GRVZOwo3BMsUIYt3thXrM4rE
	wMp2o8sCdaprSBEpnWbogqD/tXJ5YnB8OWfcV8KbIo+rF6Rc8Nnx6yaDAMihFnOzb/hlAN1DYfB
	QYLM9xxWWaEJJBxYTv1aKaM5lQMjPDgc=
X-Gm-Gg: AR+sD12JEj/dhEhCWzbzCZP6xeITJQfY3MyCTNLjLzthWxNUv18HHYEtdTaNTkL4Hpx
	y0MbZAEIfKPjyO6EDmbQZGePEWu2vbQCA9xSehureGLsTXFoB36yO+UdiOvskwjP8hC8alZAg1L
	sFarXrsdFraxxxMWekiJFeBySyWzeaLTkQBfMx1usZi7NgfgbmJ6zyGiJtg3zqQF/vASOnOmaJy
	n7hbb2A78kTJLKKTBK19NcH67Q5Kciio2CWHvkaDksjl/k7+pDaAwF+RpRB8bGof8BEtMycPQIV
	MvOaMUOaKSE5bAe+9A0cKOGjLV85URXaW+tzzbpEVpRH1OTke367m8atnxs=
X-Received: by 2002:a05:6a00:1d8b:b0:846:7507:4e07 with SMTP id
 d2e1a72fcca58-84e9332c2d6mr3283061b3a.39.1785254347104; Tue, 28 Jul 2026
 08:59:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784695085.git.rtoax@foxmail.com> <tencent_60882E4BE4F247C5F6D564F41BF1C3004805@qq.com>
 <CAEf4BzbRvjT3X=Ds+YqLiZt=A0ujk1t2GCDcmbdT3+QX+DsQDQ@mail.gmail.com> <tencent_185F6B461110090D468588B2422E5955A409@qq.com>
In-Reply-To: <tencent_185F6B461110090D468588B2422E5955A409@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 28 Jul 2026 08:58:54 -0700
X-Gm-Features: AUfX_mx5_bBPCwgqJNnkpof7GPHnuwQRl83Ae8RTD7i_SajV9Ln5XUv-83bhiD4
Message-ID: <CAEf4BzY6RPkm0xv=RHAKoNphYxM_6GmyLdhDbbZ3nAqNhkdW_g@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/2] bpf: add bpf_strcat,bpf_strncat kfunc
To: Rong Tao <rtoax@foxmail.com>
Cc: vmalik@redhat.com, andrii@kernel.org, ast@kernel.org, rongtao@cestc.cn, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Shuah Khan <shuah@kernel.org>, 
	Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>, 
	"open list:BPF [GENERAL] (Safe Dynamic Programs and Tools)" <bpf@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 27, 2026 at 7:50=E2=80=AFPM Rong Tao <rtoax@foxmail.com> wrote:
>
>
> On 7/28/26 06:56, Andrii Nakryiko wrote:
> > On Tue, Jul 21, 2026 at 9:42=E2=80=AFPM Rong Tao <rtoax@foxmail.com> wr=
ote:
> >> From: Rong Tao <rongtao@cestc.cn>
> >>
> >> Add string concatenation kfuncs, prototype:
> >>
> >>    int bpf_strcat(char *dst, u32 dst__sz, const char *src);
> >>    int bpf_strncat(char *dst, u32 dst__sz, const char *src, u32 len);
> >>
> >> This differs from the glibc library functions strcat and strncat, whic=
h,
> >> for safety reasons, require the size of the target string's memory spa=
ce
> >> as a parameter.
> >>
> >> The src parameter cannot directly pass a string constant, such as "XYZ=
",
> >> otherwise it will throw an error "write into map forbidden".
> >>
> >> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> >> ---
> >>   kernel/bpf/helpers.c | 75 ++++++++++++++++++++++++++++++++++++++++++=
++
> >>   1 file changed, 75 insertions(+)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index c18f1e16edee..85afff60365c 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -4195,6 +4195,79 @@ __bpf_kfunc int bpf_strncasestr(const char *s1_=
_ign, const char *s2__ign,
> >>          return __bpf_strnstr(s1__ign, s2__ign, len, true);
> >>   }
> >>
> >> +static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
> >> +{
> >> +       int dlen =3D 0, slen, space, copied;
> >> +
> >> +       if (sz =3D=3D 0 || dsz =3D=3D 0)
> >> +               return -EINVAL;
> >> +
> >> +       while (dlen < dsz && dst[dlen] !=3D '\0')
> >> +               dlen++;
> >> +
> >> +       if (dlen >=3D dsz)
> >> +               return -E2BIG;
> >> +
> >> +       space =3D dsz - dlen;
> >> +
> >> +       slen =3D bpf_strnlen(src, sz);
> >> +       if (space <=3D slen)
> >> +               return -E2BIG;
> >> +
> >> +       copied =3D strncpy_from_kernel_nofault(dst + dlen, src, sz);
> > I'm not sure strncpy_from_kernel_nofault() is designed to work
> > correctly if dst can be modified concurrently. Which in BPF case, even
> > though we validate that memory is correct, it still can be modified
> > concurrently in such a way as to cause strncpy_from_kernel_nofault's
> > inner dst[-1] based loop logic to go beyond the boundaries of target
> > buffer.
> >
> > i.e., I don't believe current implementation is concurrency safe
>
> Thank you very much for your reply. There is indeed a thread safety
> issue. Let's look at a solution. I will submit v6. Thank you ;)
>

tbh, I'm not sure we need these new kfuncs at all. You should be able
to easily to do the same with dynptr for dst buffer and existing
strlen/probe_read helpers/kfuncs.

> Rong Tao
>
> >
> > pw-bot: cr
> >
> >
> >> +       if (copied < 0)
> >> +               return copied;
> >> +       else if (copied =3D=3D 0 || copied =3D=3D 1)
> >> +               return dlen;
> >> +
> >> +       /* The copied character count includes '\0'. */
> >> +       return dlen + copied - 1;
> >> +}
> >> +
> >> +/**
> >> + * bpf_strcat - Append non-null bytes from a source string, and null-=
terminate
> >> + *              the result
> >> + * @dst: Destination string.
> >> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
> >> + * @src: Source string.
> >> + *
> >> + * Return:
> >> + * * >=3D0      - Length of the concatenated string.
> >> + *
> >> + * * %-EINVAL - String @dst__ign is invalid.
> >> + * * %-EFAULT - Cannot read or write one of the strings.
> >> + * * %-E2BIG  - String @src__ign is too large or the remaining space =
in
> >> + *              @dst__ign is too small.
> >> + * * %-ERANGE - One of the strings is outside of kernel address space
> >> + */
> >> +__bpf_kfunc int bpf_strcat(char *dst, u32 dst__sz, const char *src)
> >> +{
> >> +       return __bpf_strncat(dst, dst__sz, src, dst__sz);
> >> +}
> >> +
> >> +/**
> >> + * bpf_strncat - Append non-null bytes from a source string, and null=
-terminate
> >> + *               the result
> >> + * @dst: Destination string.
> >> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
> >> + * @src: Source string.
> >> + * @len: the maximum number of characters to concatenate, the null te=
rminator
> >> + *       \0 of the target string @dst will also be included.
> >> + *
> >> + * Return:
> >> + * * >=3D0      - Length of the concatenated string.
> >> + *
> >> + * * %-EINVAL - String @dst__ign is invalid.
> >> + * * %-EFAULT - Cannot read or write one of the strings.
> >> + * * %-E2BIG  - String @src__ign is too large or the remaining space =
in
> >> + *              @dst__ign is too small.
> >> + * * %-ERANGE - One of the strings is outside of kernel address space
> >> + */
> >> +__bpf_kfunc int bpf_strncat(char *dst, u32 dst__sz, const char *src, =
u32 len)
> >> +{
> >> +       return __bpf_strncat(dst, dst__sz, src, len);
> >> +}
> >> +
> >>   #ifdef CONFIG_KEYS
> >>   /**
> >>    * bpf_lookup_user_key - lookup a key by its serial
> >> @@ -4958,6 +5031,8 @@ BTF_ID_FLAGS(func, bpf_strstr);
> >>   BTF_ID_FLAGS(func, bpf_strcasestr);
> >>   BTF_ID_FLAGS(func, bpf_strnstr);
> >>   BTF_ID_FLAGS(func, bpf_strncasestr);
> >> +BTF_ID_FLAGS(func, bpf_strcat);
> >> +BTF_ID_FLAGS(func, bpf_strncat);
> >>   #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
> >>   BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
> >>   #endif
> >> --
> >> 2.55.0
> >>
>
