Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1644A1AA797
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 18:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787336759; cv=pass; b=p9yXce5OEYpsyVY4o5/4fCHCMIvHaOSLecVmT7tIoZGlK7t2XjsHByY8PJKiX2ing8zzOCO7XodTe/a8qqH0v+gm7col/qDfmPRDDPbLSyaKdg8BzDw8RHV4sO+Pczh0aXst+76X/7T/6ytFbv0orEMQpEvQPXgymvkm1J/iq20=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787336759; c=relaxed/simple;
	bh=vkwmU7QmuMbUknl8LQ5dS8mPWtB1CkGH6jSFMPngqQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SdgHgpRtKxbaFXe7FJXv1EhQRHT42ulKMeF/n5pqHjlqn2iY3ZBIV+ZZ9GtpjYNDFwOQwjm7wvG7EgC8UYPDS5F6MbpN/EKYaeBIQNcgjD/5mCUmeikoSMuv7cNzG2aILxHP6l1C8Ij/OPFqU66dKaSSQR40B9GcYNi+CcYjk1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aIbeJJdE; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aIbeJJdE"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84f38f3b36eso909743b3a.1
        for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 11:25:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787336754; cv=none;
        d=google.com; s=arc-20260327;
        b=rA7g5t3HKnz69ppSApP4I58wjah8kouUzFLlaR6TNgykt8ALGIo65QPVKGgIviFug1
         T5sD6+raulGlyowqmBjs+0+jjFWwmfAYRc3CMC5QsABmSk9LsJQP0Ht8Eyze6sS+CiiO
         +Ob/VGx1z/97+V8DHEwJe+NGWmQkYfVZW4al/6Xz4O94FmtLn/isdCOQAZ3NyOnQTLsc
         X5JkIhnCm0Lpmb3kjo1vFXJ0mlSISn3TlAa9qRJNBYoUws4D0wknks+rxlNS9v0oBPSl
         nXnJN+oqsd7Uf7rWth+l/6Y9pz9Pray3+iTK3pam9bBNPuv12uFzDyH793akTHfNYk8i
         haxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XmUjmQVfPc3LMyQ2C8V8PY5qiw4aGEkjYag9UJZl0EI=;
        fh=PXjkjKoXoELKwyfEWrVsluGrx/T+TwHFdgPOdcyDcwM=;
        b=kVpPHleeKWAeekGfDWNUOv/9JlDqXWEoJpm/g2Rfl58FFKNMpMyblcpPBglpZs7NYw
         pej5NR8VZg+tqeBCTcz6ELFVKKM3kHw16KkKrdAm8R/wJWylwSGtyT68XLIwPZxCAyOB
         TkoIVmnggTDH1YYEDWJVxYhdAM2pywn9DAuGLjZ7sq9iPJy21PiIV0zaKphOIRkVbpY4
         cZ5zC5ppHGGNaUiQqSIBJRhBPyuCBwcIZNn41jdJgj6g6dmTCrxod7YuTK+btkE7GL/Z
         WXzPl+f3/pA1Laz6562znV8z7gUlB5n3ryVboSIEqxGuu7aLlowTFIsJXSQiLqH+nMzR
         sVNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787336754; x=1787941554; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XmUjmQVfPc3LMyQ2C8V8PY5qiw4aGEkjYag9UJZl0EI=;
        b=aIbeJJdEJAq+jS1MJzzbLi2bISnHz8UJ1SG386ARmdiVBXqA/2g+tX2P8i039/DlT7
         Vp12g0DCj894w9jJoLKXLZe8BbFpYGnyRMZQHz8LhDNlA8Y5+cjA9v90bxk4ZHRA3O9Q
         CtzFnJH3+S/xHRi2xA5hQ9zT3drUeYgENTusBstQW+7+w/hiYp7khd6TnTsH6kYkT4no
         uyK7xBhQSG2+UHpgD8N106bPyMYJw282TegN2M/EyzJnqwFXx5kE0oI/VcDaWsDCjf3p
         Uwohsb1qbk/aqczZrRM2lW/hS2G2OtP7qW0uhaDuAF+9FrGDZnSYrjpTnVxOu26hZQot
         eNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787336754; x=1787941554;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XmUjmQVfPc3LMyQ2C8V8PY5qiw4aGEkjYag9UJZl0EI=;
        b=p/JjyZ3Z21yb5R4mu034oVDi1hrsF7zbel0ibcW7iJsJbElRbrB8e41nkMhQG6jonA
         SSlTx06SRcRxTbjoHcjcY+61CLi16A+Nc/msxPnA0WZWtT3Zw6UvBFXZmyqyzlzXhH+N
         dh5GUnGDrao/SEKNYHA+XkGNfdfCKjJlZDC9Vs/Wxs5h+iUoCEyPh8dxCKFIU/x3ejoA
         vjkWcZmZRlI6ujC1UUzZuElECYjQZDMlpsj4UsIh5eKWnktbOUWmcQCb7vhtNKXEnb7L
         Niy7zWRcslz5ck0n51H0+edVowI8+vGBSDBe0GyO9RBYm2oxFNQk9tRpOhv+n6PHTAVV
         gFoQ==
X-Forwarded-Encrypted: i=1; AHgh+RpnLKvNeaGFWLqXyxnz08MqvlqC1MRVLz00nGyQYRpiI5x1ptnZD79qOtkaP4gC/aGSHEE=@vger.kernel.org
X-Gm-Message-State: AFuF++mWD07//CjZvqeZqAg2QqLvFgN81ymS8yrJy+0K+H6gE3MU7DaS
	ORaN8QTH96ZACB36IuScLPrj01xmKdJOj5Wp1dpTKa60FJwSnwmGgX6QVPcMcALxpI8urEmu0I8
	RxCGnv/T0Fo7a60Y8xoiAlmsNzb2C1NE=
X-Gm-Gg: AR+sD10uNIFOZ4yTYi2gzhKnrBovRuX9/PhLW0dnw98znyg/Vz6auAMHw/o9Tqqv67T
	OyWctNdqpN++n0sVLryI/hM944i+b/Z4FdR45Gafe6hqqtKRC4X+RoosqrvB9S7RlUOhKYcJsDs
	l/hJcrHOAzie+WkZ5STg4x8XiiZxDpEwZkU1xASkpC6utQSkV2IXAB5SsLfISYS/4PlpWgtHk6/
	SKyYg5cpi5PhpeXDX97ZtTqthDR+Tefi2RFPoUA9LbZmJyzewFeyvO0MUffYDw4jBaunBCIGTkr
	vd9HzP1Ayp7GUKmoh6pKmeSTepJCkatA6mXIlXiZzCpMeDAhY7AvY8f/zbMrOQ9BC141O/iz5Uu
	DZAd82dsEMIz56UXayWMeyvG+vFJm7mGg9Mf3
X-Received: by 2002:a05:6a20:4324:b0:3bf:9b61:f7ae with SMTP id
 adf61e73a8af0-3cd300caf9cmr14808453637.14.1787336753370; Fri, 21 Aug 2026
 11:25:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260820084643.35489-1-meishaoming@xiaomi.com> <20260820092246.61338-1-meishaoming@xiaomi.com>
In-Reply-To: <20260820092246.61338-1-meishaoming@xiaomi.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 21 Aug 2026 11:25:38 -0700
X-Gm-Features: AcwNN1XtLDJ0uHnGsM0yF-Tq1ezeqKp-F8qDU8d39dwq2Lej6yO4vmOmfHorOSU
Message-ID: <CAEf4BzbiH44Y_KHpHuT_mZ1RD2_-b0ngPKZNepqWauYXUe2HPA@mail.gmail.com>
Subject: Re: [PATCH v2 bpf] bpf: array: reject max_entries > INT_MAX to
 prevent signed-iterator overflow
To: meishaoming <meishaoming@xiaomi.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, 
	martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 2:22=E2=80=AFAM meishaoming <meishaoming@xiaomi.com=
> wrote:
>
> BPF_MAP_TYPE_PROG_ARRAY (and other array maps) take max_entries as a u32
> from userspace via bpf(BPF_MAP_CREATE), but array_map_alloc_check() only
> guards value_size > INT_MAX and leaves max_entries unchecked.
>
> When the map is later freed, fd_array_map_free() iterates the ptrs[] arra=
y
> with a signed int loop variable:
>
>     for (i =3D 0; i < array->map.max_entries; i++)
>         BUG_ON(array->ptrs[i] !=3D NULL);
>
> On arm64 (and any LP64 arch) int is 32-bit signed, while max_entries is
> u32. With max_entries having bit 31 set (e.g. 0xFF00000A, observed from a
> syzkaller run), the loop runs past i =3D 0x7FFFFFFF: i++ wraps to 0x80000=
000,
> which as a signed int is negative. The address computation for
> &array->ptrs[i] sign-extends the 32-bit index (sxtw on arm64) into a
> 64-bit negative offset:
>
>     array + sxtw(0x80000000) * 8 + offsetof(bpf_array, ptrs)
>   =3D array + 0xFFFFFFFC00000000 + 0x108
>   -> wraps to an unmapped address, level-1 translation fault, panic
>
> This is reachable today because the existing overflow backstop in
> array_map_alloc() lives inside the `if (!bypass_spec_v1)` block. Since
> commit 2c78ee898d8f ("bpf: Implement CAP_BPF") renamed the old
> `if (unpriv)` guard to `if (!bypass_spec_v1)`, the semantics inverted:
> a root caller with CAP_PERFMON (or mitigations=3Doff) takes the bypass
> path and skips the -E2BIG check entirely, so the raw attr->max_entries
> is stored into map->max_entries unchanged and the ~32 GB vmalloc
> (overcommit) region is handed out. The earlier unprivileged-path fix
> for max_entries overflow was carried along into the bypass block, so
> it does not cover the root path described here.
>
> Reject max_entries > INT_MAX in array_map_alloc_check(), the common entry
> point shared by all callers including the bypass path. This mirrors the
> existing value_size > INT_MAX guard a few lines above. The cut half of th=
e
> u32 range (0x80000000..0xFFFFFFFF) cannot back a usable map today:
>   - a prog_array at the lower bound already needs ~16 GB of contiguous
>     virtual memory (and ~32 GB for the 0xFF00000A value seen in the field=
),
>     which either fails allocation or drives the system into OOM/softlocku=
p
>     long before becoming a working map;
>   - legitimate prog_array usage is bounded by MAX_TAIL_CALL_CNT =3D 33 an=
d
>     typical array maps are orders of magnitude below INT_MAX.
>
> No valid BPF use case is affected; the change converts a deferred
> whole-system BUG_ON panic (or OOM/softlockup) into an accurate -E2BIG at
> creation time.
>
> Fixes: 2c78ee898d8f ("bpf: Implement CAP_BPF")
> Signed-off-by: meishaoming <meishaoming@xiaomi.com>
> ---
> Changes in v2:
>   - Rebase onto the bpf tree (base a13307e97d5c) so Patchwork CI can
>     apply it cleanly; no code change.
> ---
>  kernel/bpf/arraymap.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index 248b4818178c..868bc9f66cdb 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -74,6 +74,9 @@ int array_map_alloc_check(union bpf_attr *attr)
>         /* avoid overflow on round_up(map->value_size) */
>         if (attr->value_size > INT_MAX)
>                 return -E2BIG;
> +       /* avoid signed int iterator overflow in fd_array_map_free() */
> +       if (attr->max_entries > INT_MAX)
> +               return -E2BIG;

While uncommon, I'm not sure there is anything wrong with allocating
3000'000'000 single-byte entries, if necessary. So if there is enough
memory, why would we artificially limit the allocatable capacity?

value_size guard is more sensible, IMO (and there is a specific
practical reason because of round_up).

should all the places where we iterate over all elements be fixed to
use u32 instead?


>         /* percpu map value size is bound by PCPU_MIN_UNIT_SIZE */
>         if (percpu && round_up(attr->value_size, 8) > PCPU_MIN_UNIT_SIZE)
>                 return -E2BIG;
>
> base-commit: a13307e97d5c54b65720bb71fa379960ded1e51a
> --
> 2.50.1 (Apple Git-155)
>
> #/******=E6=9C=AC=E9=82=AE=E4=BB=B6=E5=8F=8A=E5=85=B6=E9=99=84=E4=BB=B6=
=E5=90=AB=E6=9C=89=E5=B0=8F=E7=B1=B3=E5=85=AC=E5=8F=B8=E7=9A=84=E4=BF=9D=E5=
=AF=86=E4=BF=A1=E6=81=AF=EF=BC=8C=E4=BB=85=E9=99=90=E4=BA=8E=E5=8F=91=E9=80=
=81=E7=BB=99=E4=B8=8A=E9=9D=A2=E5=9C=B0=E5=9D=80=E4=B8=AD=E5=88=97=E5=87=BA=
=E7=9A=84=E4=B8=AA=E4=BA=BA=E6=88=96=E7=BE=A4=E7=BB=84=E3=80=82=E7=A6=81=E6=
=AD=A2=E4=BB=BB=E4=BD=95=E5=85=B6=E4=BB=96=E4=BA=BA=E4=BB=A5=E4=BB=BB=E4=BD=
=95=E5=BD=A2=E5=BC=8F=E4=BD=BF=E7=94=A8=EF=BC=88=E5=8C=85=E6=8B=AC=E4=BD=86=
=E4=B8=8D=E9=99=90=E4=BA=8E=E5=85=A8=E9=83=A8=E6=88=96=E9=83=A8=E5=88=86=E5=
=9C=B0=E6=B3=84=E9=9C=B2=E3=80=81=E5=A4=8D=E5=88=B6=E3=80=81=E6=88=96=E6=95=
=A3=E5=8F=91=EF=BC=89=E6=9C=AC=E9=82=AE=E4=BB=B6=E4=B8=AD=E7=9A=84=E4=BF=A1=
=E6=81=AF=E3=80=82=E5=A6=82=E6=9E=9C=E6=82=A8=E9=94=99=E6=94=B6=E4=BA=86=E6=
=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=8C=E8=AF=B7=E6=82=A8=E7=AB=8B=E5=8D=B3=E7=94=
=B5=E8=AF=9D=E6=88=96=E9=82=AE=E4=BB=B6=E9=80=9A=E7=9F=A5=E5=8F=91=E4=BB=B6=
=E4=BA=BA=E5=B9=B6=E5=88=A0=E9=99=A4=E6=9C=AC=E9=82=AE=E4=BB=B6=EF=BC=81 Th=
is e-mail and its attachments contain confidential information from XIAOMI,=
 which is intended only for the person or entity whose address is listed ab=
ove. Any use of the information contained herein in any way (including, but=
 not limited to, total or partial disclosure, reproduction, or disseminatio=
n) by persons other than the intended recipient(s) is prohibited. If you re=
ceive this e-mail in error, please notify the sender by phone or email imme=
diately and delete it!******/#
