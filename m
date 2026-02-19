Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26A7CA6F
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771465205; cv=pass; b=UNcEoyIQ1Mg9j8BxTvAawjF4dS9A2c6B0/53MDC7M7MrQP+7EOo/ixc9FTv7NNJ0VJLPZNPVo5F9KyF+BjBqglLaNnDRidsbyRQzNN1M/DWMLOID6P2gfjYqFwQ9FQI77OOB1oUXHSY6xM1AovUIaTEu59FI4jbRBgryxjZSucY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771465205; c=relaxed/simple;
	bh=2kChsDWjUMxHG3MVsq3yBuQrHVJtmXor5w4mPPtz23E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LlKUiGk9qJQhR6apbK7QZGKA0E59hbUlE3wLug0/vujECMaW811YI00WBlaUvAnc2u2JcXMIyVZ7At8aDoR8Qc8FHoqRPCBG6LNCxOnfnISfzEGEve2DplQLnO2lzQuo/9HbXwtg4Qj2gmUPDDiollVlBh4REXwPr8tp+lWU5q4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5k6yraZ; arc=pass smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5k6yraZ"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-4375d4fb4d4so279704f8f.0
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 17:40:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771465202; cv=none;
        d=google.com; s=arc-20240605;
        b=jTAnZRl3qF3TiSvqjl2E+VxPviYitxuxl8fAqREttGnl+d574/DGz6hs3JDFWz7iHt
         u9AmKA+nPXbIsrauInjhj1WGagHERSqOVC0zZXz3Uz5/Prhum7y5sgAHqAWvrNOYFjlR
         5PL4xYj8PHDEILIai6twk+nT2M3qiZvXm80pXFd4LQqFD0bc7lMGDWOqU7l1lYXF2E9F
         QPSnuRQxACHx86+hSg2mFQz2u14a+lIS3HCbzIAvhbg3D/mQDk7q9zT1sXX26OW+PuXD
         LqANssqOj1IYS9gIW1dPraC2t5kt+4NaNyvuBvXLpAey8209hGOz5kX++83ceXO40qqq
         0yuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nU9RtEbN6URuhwMkDQy4Pbi4D7cMlCZhTJLxfysEM0Y=;
        fh=NvnGXsAunX/My/8u+QJWXtcLhMTfcvoym6o+rZGJo7o=;
        b=CTAuxdgyinUFTAJy4duZWFYTrQcgohYfgbcsbrdB2xN3JzJ9INAn7P8pNBnjKc/As4
         gytSc+hYSchD9XewfJl8xiZfxOgB0CWgxUGDxCyu0xOBgfUwQawCQrffeZ0nWajlZFfJ
         6eQxRw6RdcHtj5CBZ6w/QN0LC2Qq1rvcULKBgJdqYhExWiKz7g6pH+bZjerP6uOned2Z
         QSbUw4kXYjK3FVYkxlTY4m92Thg9G7IrtL+0HWeMyfKrciDqaX3XPxKkbhS7nJthHHcA
         5CIAfrsr5XPgT+2mUXgxR/MMrVkvAbfYOY5Nu1HsNsxyiyW2LURMdh9MQfrOvHYS7qjs
         bV+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771465202; x=1772070002; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU9RtEbN6URuhwMkDQy4Pbi4D7cMlCZhTJLxfysEM0Y=;
        b=D5k6yraZK1oHXRyWb5p4iFj1uKIxGz7YAwbQqhFYjKiUsEMIbxGgBIzNV0ZkcjVKoV
         qrW6POcZGGHzsKUKyn8uWTKqit0PUU0mTgQCY7uS2CIwSnSArvWCJ16ukLOI8t6g/q4c
         ynnvxio5KPNHmQ9oyYud/oK1T4kzflIEok+hS31VZFgmNFPoe4m63JLNUWXv6n28fDUs
         99tIrMYInFdVb0dp1O0x3T96LTVTmnGB6DUTJYjIuliNVxoUFQKGrhcvtwiym6Hy3lQQ
         oSlPAnTTddzPl1LeTxbvheDrwbQ4u18XQEVqfrK8KLghwfdBJxTKU0xiRmWPP+xZb7ZC
         IvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771465202; x=1772070002;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nU9RtEbN6URuhwMkDQy4Pbi4D7cMlCZhTJLxfysEM0Y=;
        b=phAeABTeUG34pHMMSswYi8nT5eixM+yJNOViT2IjNA6d0F7UtgWYnETEnROWF/NqA6
         /nOITBnxDF/pHGizcIKHTs/HAyeMGubxQrHKIuutOiViwpSHiXN+nSKa2nrkwzueGrko
         rF7UuBi/FvdLLyI+m/STT2IPgSvI5Fu8UAEMjXmACWTH6KKPIfj6NUaFpHXLbBRsKO4q
         CQlP88oPX88DiY8wNpPj2oevzvzK0VGlOwX7ZhNGMoF/1R2hFiomq4yRA6zlqALGq+ps
         IUM0S9TnEHdN2pfMk9/ml271bno1X7CtO+al8RSu3/MUuzWONhfwP7a8mEcY8NPF/aTk
         ZmUg==
X-Forwarded-Encrypted: i=1; AJvYcCUAVzCsH1Q1qFNmjw7XuT0iPFk2gQM9jDmWuZVI9tEmlQuMzo9JUW3y4xVkuXoC8u1mqmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwInJ7ayRAkQCQHfvItfIQ36g1zcDf+F9XJwE2GZAoGqgIEogEM
	KS38NcbePLADsDCXjR+9JB3dSxSKUfJJkKYd/tlTqgpLiLoyH2birfFf7sbNoFJVtBPqiCAmAM5
	TQjbQ7FNQ4oI4Jp4pXHBX5TIt756TLCg=
X-Gm-Gg: AZuq6aJ50StIDeYr/l7LlV+A6CGo2d6IIYjtk7orQlckC4T5Dwi5UDosdgaVF9gro8u
	v2L2lMIV6K37WMYcqlHmFjP6ZfISUov+7qaPUzcv5OML3o/Bng5/Kf65kCHPndzkSM/XCbFXifU
	YiGXscZzp4wmSJrzaoGeLYg5JTEkn/CygeduXWzQlR/tZnGjlLdwsMlDkBcU6xaFzyGR6qBYK6S
	fe5/5uHyO6lH/kadkT21A1QawBn59Tist3xVKfGYYMuQdm7YMx48NwGYxV7iD9yJlMjBNlbsVA1
	TsdcrYY8T0wDeeqnZW3zmlAdyE9ctENQHZmjCEYWETFi081iBhfF7JHihBvFuEml1OgbK4hYWVD
	HAEd+lve+UObJ0umiXMge7g68SA==
X-Received: by 2002:a05:6000:40db:b0:437:6efe:94d2 with SMTP id
 ffacd0b85a97d-43958df3f95mr6850034f8f.4.1771465201688; Wed, 18 Feb 2026
 17:40:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev>
 <20260218003041.1156774-15-ihor.solodrai@linux.dev> <CAADnVQLOONuA3omz1ZRoT5T39PpYfut3vXnH1Oxdh84pJA6c-Q@mail.gmail.com>
 <84ba9764-5ba2-4e9b-af81-3fea2682d161@linux.dev> <54cffd1f-df2f-4a01-a07d-0509425558d9@linux.dev>
In-Reply-To: <54cffd1f-df2f-4a01-a07d-0509425558d9@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Feb 2026 17:39:50 -0800
X-Gm-Features: AaiRm50J12RY81dN-OQVEBzWav658Pm2hQY_1mvBbJkT2yEAQ2S5ZUixvDA4PlI
Message-ID: <CAADnVQ+9uw2_o388j43EWiAPdMB=3FLx2jq-9zRSvqrv-wgRag@mail.gmail.com>
Subject: Re: [PATCH bpf v2 14/15] selftests/bpf: Check BPFTOOL env var in detect_bpftool_path()
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 5:13=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 2/18/26 10:17 AM, Ihor Solodrai wrote:
> > On 2/18/26 9:38 AM, Alexei Starovoitov wrote:
> >> On Tue, Feb 17, 2026 at 4:31=E2=80=AFPM Ihor Solodrai <ihor.solodrai@l=
inux.dev> wrote:
> >>>
> >>> [...]
> >>>
> >>>         /* Check default bpftool location (will work if we are runnin=
g the
> >>>          * default flavor of test_progs)
> >>>          */
> >>>         snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "./%s", BPFTOOL_DEFAULT_P=
ATH);
> >>>         if (access(tmp, X_OK) =3D=3D 0) {
> >>> -               strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
> >>> +               snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", tmp);
> >>
> >> I guess it's ok for user space, but
> >>
> >> git log --oneline|grep "snprintf with strscpy"
> >> ad789a85b163 mm/cma: replace snprintf with strscpy in cma_new_area
> >> 674fb053e95d sparc: vio: Replace snprintf with strscpy in vio_create_o=
ne
> >> 2dfc417414c6 genirq/proc: Replace snprintf with strscpy in register_ha=
ndler_proc
> >> f46ebb910989 block: Replace snprintf with strscpy in check_partition
> >> b66215e7b780 media: verisilicon: replace snprintf with strscpy+strlcat
> >> a86028f8e3ee staging: most: sound: replace snprintf with strscpy
> >>
> >> and many others...
> >> So.. should we introduce strscpy() in selftests/bpf ?
> >
> > I guess we can, but:
> >
> > $ grep -r 'snprintf(' --include=3D"*.[ch]" tools/testing/selftests/bpf/=
 | wc -l
> > 238
> >
> > The reason to prefer strscpy() is speed, right?
> > Can we use kernel implementation in userspace directly?
> >
> > In tools/include I only see this:
> >
> >       #define strscpy strcpy
> >
>
> I think we can add a simple implementation to tools/lib/string.c
> See a diff below: essentially a copy from arch/s390/boot/string.c [1]
>
> I suppose it's faster than snprintf(). However I am not sure about
> going through all 238 usages, as that would touch many files. But at
> least we can make actual strscpy available in selftests.
>
> I can add this in v3. Alexei, wdyt?
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tr=
ee/arch/s390/boot/string.c?h=3Dv6.19#n32
>
> diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
> index 51ad3cf4fa82..ca183a0e846a 100644
> --- a/tools/include/linux/string.h
> +++ b/tools/include/linux/string.h
> @@ -3,6 +3,7 @@
>  #define _TOOLS_LINUX_STRING_H_
>
>  #include <linux/types.h>       /* for size_t */
> +#include <sys/types.h>         /* for ssize_t */
>  #include <string.h>
>
>  void *memdup(const void *src, size_t len);
> @@ -12,7 +13,7 @@ void argv_free(char **argv);
>
>  int strtobool(const char *s, bool *res);
>
> -#define strscpy strcpy
> +ssize_t strscpy(char *dest, const char *src, size_t count);
>
>  /*
>   * glibc based builds needs the extern while uClibc doesn't.
> diff --git a/tools/lib/string.c b/tools/lib/string.c
> index 3126d2cff716..54c9163fa2b0 100644
> --- a/tools/lib/string.c
> +++ b/tools/lib/string.c
> @@ -239,3 +239,17 @@ void *memchr_inv(const void *start, int c, size_t by=
tes)
>
>         return check_bytes8(start, value, bytes % 8);
>  }
> +
> +ssize_t strscpy(char *dst, const char *src, size_t count)
> +{
> +       size_t len;
> +
> +       if (count =3D=3D 0)
> +               return -E2BIG;
> +
> +       len =3D strnlen(src, count - 1);
> +       memcpy(dst, src, len);
> +       dst[len] =3D '\0';
> +
> +       return src[len] ? -E2BIG : len;
> +}

Hmm. it looks a bit like strlcpy() which is also not recommended.
See Documentation/process/deprecated.rst
that explains the reasons why strscpy() is the only "approved" version.

Also tools/lib/ is too scrutinized.
Let's take sized_strscpy() from lib/string.c
drop all optimizations like word a time, page boundary tricks, etc
and only keep essentially this:
        while (count > 1) {
                char c;

                c =3D src[res];
                dest[res] =3D c;
                if (!c)
                        return res;
                res++;
                count--;
        }

        /* Force NUL-termination. */
        dest[res] =3D '\0';

        /* Return E2BIG if the source didn't stop */
        return src[res] ? -E2BIG : res;

and add it somewhere in selftests/bpf..

and only use it in these couple cases where we need to fix strncpy.
Further snprintf() cleanup can be dealt with later.

I mainly want to avoid more churn when people will inevitably
start sending patches to replace snprintf with strscpy.
