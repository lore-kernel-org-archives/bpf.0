Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A4543304E
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785192992; cv=pass; b=fRdrSNGAJKy76S0SbVh3kvLvnGUY5xyg4iEyV3ShjtYuZBM2xGwS4cxotc+HfReaRM2Kt5Dg7H4QhopPruqm8ZO/GHZNrKwzX9/mt2UssD23fOSwwFyfnLWkiu08BJJesRH92kn0TGWoKUtjeRuleubnPnxaQhOXBjLDBy7fxxY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785192992; c=relaxed/simple;
	bh=lDRePanPTV11K2Z+08yVQKWAXDh2XC33OhI+xhcEdeU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BtNeKrPSWvOdm9/Jq1NamvHJ57ePteITmDqz1uJCNGFFzKoAWcOvDcClWVixFVZuGdIuPmN/mZddK7KzMwoqWc545XvhqTQZWs4Su4HQOmUAcYHIBTXxoqWFQs5xVRMqK/EKoaxL8Ke9KkqfQ+VHx6zvfDrxv8aBNeqleEALyLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WWzFOut3; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WWzFOut3"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84830c774a0so3363018b3a.1
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 15:56:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785192989; cv=none;
        d=google.com; s=arc-20260327;
        b=mhQy1aMKaOERiDEgLIfN7Vv4XyzQ1ohMyKLznoEQBCV4jWdZkglGA1yi3jgYO89UsH
         RSR3TeZRGJUXgosG/YPXOXwedH6in0+DN83PLZS/OWAASb8ja08hIvxKK1xth96VXhTC
         9ogqPI3Jx/5TIn8xMCloBYINwamArXICWg0o4wZEsQkXF0FehzEZEZ81bVjUFtT4fE8Q
         qiwsrpiqRvUMECpthbFTApbdOBbRYRWASqMf1+NEoEyOA1DYi1xaUtsCkXPfbaGImdTB
         iNHzWyaHDop16rMyFdzyJ8W9tW0hwjlWA7Wc7E93Jbzn7W/gJQJg5fmT+8W8W10tpt32
         N+ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DarHj0Bq3F3tMYkSeAITMeTVDj8Ip/fyH2VQU4C//Eo=;
        fh=rFSwaIZsEZLYZeS/yw/zfOdx9u8o+vqaF9aw9pfAYYw=;
        b=IwSusNs6ZjrMZT0h3qd6kfAsQm62OVv7y2RLyoltp9o3YoTqd4pvK44plKA/F4gTj3
         XTpDHYjWwEtnNEQlEy+1PUwc0Xy7DCTzE6o1yGEwCnjG5yLdXnNm7icumZM+yUsMB3kC
         7rKIGLKAmJpCDcOmQxZBvXwqZfBDhUUaFrPdwGjtycIIHFKjuK4Hyyv1zjww+1/Y6ocW
         4N+DHmJpRwQRn7Zf9ohoZY+1VjG9GvcpxrDZ79CFJ34xSYP5JglFb7ImUydE/fpCh/te
         kxOvtxOS624Anhxkw/xenh0QpQjtFFKwrLB8SXLc4AV/ClDl+6Sqk7ff6LHq+xuZ24+F
         HKug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785192989; x=1785797789; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DarHj0Bq3F3tMYkSeAITMeTVDj8Ip/fyH2VQU4C//Eo=;
        b=WWzFOut3bR3SRz/JTAfq+oP5iFC8LAkfchzKfCjfGWkPttuwb6h0mMKnzuIrkbV7D4
         Nit+Vpa8iLr0BIQw1tbt71VY5WUPQAen3SgCZbiGBpkTAIgORMsHaTqrFkAKtthGLqkP
         0q69bfN5G3jk8vY0w2WPdwURZPUivk/VrkjtI2UloPq1zR92JoEPzA4HS2LDGoeyQFUF
         LZtGsW4IrzSVe6ruaJxaOB3Gew8ok9Tc+gw2ZZelCQmmV4suCZB8p/6wZWpZQ2Uh3Y42
         GMo2cKyeq/NXslwp5kH4DsiKPci20rrhEm4ITbfCRwiHOFvfyRfQ9n01aqawyZOC2tt4
         /4cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785192989; x=1785797789;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DarHj0Bq3F3tMYkSeAITMeTVDj8Ip/fyH2VQU4C//Eo=;
        b=fXZWdRqCkr7Lt7wxNl7n4dZwZeshfKPxhbZNplpaFsTw+uGfVMrxIUSyq1y8NwkHkl
         MBfQOFsjs5pV/psFc6YBqvEAZbi6XoGEyMaQyjgAmzH5g9RQCVGxam/Ugf/Kz14VBmHg
         IcIa/6n8SIFEodQ2EuDJeoZ86jL2DoJmNhSxrg9sz0F4Aj1IC7++zZFGiBXxQH2k+9JF
         2BQO2kwJALKakx7Gk9FYxe2eM2SQlljavmHDT8Y4tI0t7Vx4TVTZFX1VnN8bZA0o/H0b
         goTQhQaNjS1/xI3QYEQpvqROLGd61xPVOnKuRJiHrWNt/XFV4qOx0iQSuxW/jYzA1cN2
         ay8A==
X-Forwarded-Encrypted: i=1; AHgh+Rp5CWHEtY2AKI7uGBV3ZAVenruy+2JZaZc8MFI4tXvEHlSXZuzBgg/K3UzeFky+e2HoX5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrAcm7Q1nQF6GJgMsLIZmcTp9vLLkGPWwkuF8YQg8gRU//1x1s
	lusU2WUo78JCL0XFPmCou0NbEV0aYzzD9pmQm9mKSlLVCRLf+clADjdBUPKZ5Y3hFtLTMj50fMX
	gcCr2GG3gSDcRGAjrB4yTv6peyvRO7IcliSB2h4U=
X-Gm-Gg: AR+sD10MxJCGC0Oig088vjbifBbNNuf39k8tBPUdoJXjUEu9pZCcCdnaEFl4Pe39cSz
	zneYnTTm/4GrK/4VzJ6JDQihi75lHhQ3/ED0PNYnh4465XdlMkUpaO45jUOQggDvn9XKN5w9QI0
	f/sgqLBDt9944TAB7FnnMc7tHSAjzJTy2xMIbnhaD8UcVtcUoCalxVsqgr+jI7L48d6pnQEj7l/
	7pFDcGXnWeB/hCuYicWHcNEWNDlc9ZFo4VB4ILKDbRaIn/996+UEuzAm3tAVJAPROasbfdknDiG
	YBEUq/8ESzk2aiWdCmo4dH9JvT8NCOYUKgVnDhBagzEsrnRt0X1h/EN1Sw==
X-Received: by 2002:a05:6a00:2d83:b0:848:425a:4e31 with SMTP id
 d2e1a72fcca58-84e92a39d47mr15615b3a.24.1785192989485; Mon, 27 Jul 2026
 15:56:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1784695085.git.rtoax@foxmail.com> <tencent_60882E4BE4F247C5F6D564F41BF1C3004805@qq.com>
In-Reply-To: <tencent_60882E4BE4F247C5F6D564F41BF1C3004805@qq.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 27 Jul 2026 15:56:15 -0700
X-Gm-Features: AUfX_mxYUepXWJlS78C05FXNW-P_pl-3XLjjvKMCSviOnGTmJiXcgwwhBLFYn6k
Message-ID: <CAEf4BzbRvjT3X=Ds+YqLiZt=A0ujk1t2GCDcmbdT3+QX+DsQDQ@mail.gmail.com>
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

On Tue, Jul 21, 2026 at 9:42=E2=80=AFPM Rong Tao <rtoax@foxmail.com> wrote:
>
> From: Rong Tao <rongtao@cestc.cn>
>
> Add string concatenation kfuncs, prototype:
>
>   int bpf_strcat(char *dst, u32 dst__sz, const char *src);
>   int bpf_strncat(char *dst, u32 dst__sz, const char *src, u32 len);
>
> This differs from the glibc library functions strcat and strncat, which,
> for safety reasons, require the size of the target string's memory space
> as a parameter.
>
> The src parameter cannot directly pass a string constant, such as "XYZ",
> otherwise it will throw an error "write into map forbidden".
>
> Signed-off-by: Rong Tao <rongtao@cestc.cn>
> ---
>  kernel/bpf/helpers.c | 75 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 75 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index c18f1e16edee..85afff60365c 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -4195,6 +4195,79 @@ __bpf_kfunc int bpf_strncasestr(const char *s1__ig=
n, const char *s2__ign,
>         return __bpf_strnstr(s1__ign, s2__ign, len, true);
>  }
>
> +static int __bpf_strncat(char *dst, u32 dsz, const char *src, u32 sz)
> +{
> +       int dlen =3D 0, slen, space, copied;
> +
> +       if (sz =3D=3D 0 || dsz =3D=3D 0)
> +               return -EINVAL;
> +
> +       while (dlen < dsz && dst[dlen] !=3D '\0')
> +               dlen++;
> +
> +       if (dlen >=3D dsz)
> +               return -E2BIG;
> +
> +       space =3D dsz - dlen;
> +
> +       slen =3D bpf_strnlen(src, sz);
> +       if (space <=3D slen)
> +               return -E2BIG;
> +
> +       copied =3D strncpy_from_kernel_nofault(dst + dlen, src, sz);

I'm not sure strncpy_from_kernel_nofault() is designed to work
correctly if dst can be modified concurrently. Which in BPF case, even
though we validate that memory is correct, it still can be modified
concurrently in such a way as to cause strncpy_from_kernel_nofault's
inner dst[-1] based loop logic to go beyond the boundaries of target
buffer.

i.e., I don't believe current implementation is concurrency safe

pw-bot: cr


> +       if (copied < 0)
> +               return copied;
> +       else if (copied =3D=3D 0 || copied =3D=3D 1)
> +               return dlen;
> +
> +       /* The copied character count includes '\0'. */
> +       return dlen + copied - 1;
> +}
> +
> +/**
> + * bpf_strcat - Append non-null bytes from a source string, and null-ter=
minate
> + *              the result
> + * @dst: Destination string.
> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
> + * @src: Source string.
> + *
> + * Return:
> + * * >=3D0      - Length of the concatenated string.
> + *
> + * * %-EINVAL - String @dst__ign is invalid.
> + * * %-EFAULT - Cannot read or write one of the strings.
> + * * %-E2BIG  - String @src__ign is too large or the remaining space in
> + *              @dst__ign is too small.
> + * * %-ERANGE - One of the strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strcat(char *dst, u32 dst__sz, const char *src)
> +{
> +       return __bpf_strncat(dst, dst__sz, src, dst__sz);
> +}
> +
> +/**
> + * bpf_strncat - Append non-null bytes from a source string, and null-te=
rminate
> + *               the result
> + * @dst: Destination string.
> + * @dst__sz: Maximum bytes of @dst__ign, includes the trailing NUL.
> + * @src: Source string.
> + * @len: the maximum number of characters to concatenate, the null termi=
nator
> + *       \0 of the target string @dst will also be included.
> + *
> + * Return:
> + * * >=3D0      - Length of the concatenated string.
> + *
> + * * %-EINVAL - String @dst__ign is invalid.
> + * * %-EFAULT - Cannot read or write one of the strings.
> + * * %-E2BIG  - String @src__ign is too large or the remaining space in
> + *              @dst__ign is too small.
> + * * %-ERANGE - One of the strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strncat(char *dst, u32 dst__sz, const char *src, u32=
 len)
> +{
> +       return __bpf_strncat(dst, dst__sz, src, len);
> +}
> +
>  #ifdef CONFIG_KEYS
>  /**
>   * bpf_lookup_user_key - lookup a key by its serial
> @@ -4958,6 +5031,8 @@ BTF_ID_FLAGS(func, bpf_strstr);
>  BTF_ID_FLAGS(func, bpf_strcasestr);
>  BTF_ID_FLAGS(func, bpf_strnstr);
>  BTF_ID_FLAGS(func, bpf_strncasestr);
> +BTF_ID_FLAGS(func, bpf_strcat);
> +BTF_ID_FLAGS(func, bpf_strncat);
>  #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
>  BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
>  #endif
> --
> 2.55.0
>
