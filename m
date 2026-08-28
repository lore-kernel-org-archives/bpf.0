Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4D9175A5
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 00:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787875954; cv=pass; b=mFepS6qoak0IJIRUWIK0abX2cCD7kqsPvKBGQZReHxa+4VIAyR6t+Db2ZKNJcNgg1qLIRT02iukpBFCR34h0iwRfcaV3T+X4K2Cu/rZ2Yy9iyiR0XDRx48/aPeApQ6vTM0rLQal8Iv/BOZT0KfP+bAGtTTgA++KomY1hfeJPUZA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787875954; c=relaxed/simple;
	bh=YckpOCUA9dDGjql1IWRsBuR2aNelwoRf8WIUV853Zek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B9RntTCmkQs7BBcIcHWawwX2bmib9Vf/sZxEyc0l0B2RFvMSgC6m+UbECVbmZniLBF8iOjpL1iBuuJIy14YsDur/amB790u8WWfjLHt88vOxMD17N8zElh8Fi3gLl4yIkItGi8OXFnqn+ek6EnWiTYXkusFRdRNeUqkusR1m/R8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCyl2R8b; arc=pass smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCyl2R8b"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-855d2bfae95so834728b3a.1
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 17:12:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787875952; cv=none;
        d=google.com; s=arc-20260327;
        b=elPsNWg1wdvMB3S2dv4O50xeIGcNSEg8bBG8MeSgXoZnJzcI/IUQ3OsMksEHcJOSzp
         WF9C6Ruvfbzj9xRJCnSPJeqvyFPemek1GJQeQoQTMpb5Jnjkv9sl1NDO7kORU8r8bhxw
         IrmEdNRjI0Wal3EambarQuSC8WNPNTB2OCEyBF5giFvk8QUvfHcr2BayUdl3Kx07H6Km
         q+8lNbQ2Zm88zZAK5T7iQNoOSfVYzh6r+vZRJRUdnV/vxxieTFGRsfVBVUb+x7ssmsQK
         gTzmsDqoCZZBcaVn3drOR6m6j7r5IL97IUL1KEiaiTsSRt8buHmgVyZMTP0WhOhZ2DKX
         D0uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YOJNi9+BWKv1E0cMWt+OxsRlBQled+q8mdMaLPcigek=;
        fh=nqcOef/kywzr9d9QbNsogATk3v5A+nXOrN5Mrs0wZkk=;
        b=sQFRbzL6HDJWgEJje+Tj0yEoSqhmrvQVW5OJCepWWcJT14bou2TzFMTvOSWNexXIQc
         H1xqzoNAcYSEIquADdP55PNlZjabi7BvZbWi7EcsI2HJl9Ov7HdZ73JR3lkr0/31wj0A
         g5jbXUnBB7Y8Kddw8wK5lhbgU6Xec2Fst2a8t8QKNxqYhzRZVAgWupMafNd8iWB88Zsj
         UMzPX7AWOmjoZJJUH4kJeQUTtwUc4UWL9hOFROhgXTxJsHiFAZfRelqoRdz4kxjIJE2r
         3gBjVWtal2lHpnN53MbSA/r/RY06NUjeHidIq4Gaa2h8rCdiUkdeQfWos40xOGc7QhEZ
         Twfw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787875952; x=1788480752; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=YOJNi9+BWKv1E0cMWt+OxsRlBQled+q8mdMaLPcigek=;
        b=TCyl2R8beh+ItZqTFx+nurOuUPu8k/TSclSGkbz5LqyRFD4etVEfkeFD29zePDhahe
         RQ14bSl93yeQAsMs3DfeguaZ24LKpLnqqFOLOSowUYA2kTYo+Rxa9kFqaQhAtI4Alp6d
         8YjyvL4XBPgzaeZZeBCz7XMDYywRkT5a1kMItfj0JBxnYyA5sd/vy3Zd3RiZ62p0MrRZ
         Lb00U2sNnWQ9MS9kwC1wQVjQEwSfWIHvBhUraVD+UhS3jTRiO2n8n7rc0wW2f/D144V1
         1CNov/WZ9musUdwYnAGdHpbrpr8XJI2OBxqu70J7Nmxp+Bds8UglRoeSaiEpuo7pizW8
         38lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787875952; x=1788480752;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YOJNi9+BWKv1E0cMWt+OxsRlBQled+q8mdMaLPcigek=;
        b=QRA0TmzQ/Kh95YqXevein624oOHEs21rH/sbqlWQNXB97kD/vWhD4GalR2iYPFw8uT
         Cz3UUq9fs/if5ib2xnuXDjoo9sTGo2uf0tWs6ZzSkvXUajeqyIaIc/9sHzPOTuIiuQcT
         ujI1h/LaCE4nr579atJcngqzL8vjcmfmIVkZlYfd4qptdNJv2o3x8Yyb8lotVaAaEZT4
         3eOAu8aD1o72RFPSEirzFKe8S77XuscFmbImhAC4bSU89NpDb4FDPTZyMAm/rGZWlUV2
         MvxdsZPWdJEuQeZqPQbhYBkJRXB9vkX3B9rPjQ0q6xaeAiGZJ8WNHaTjQRanMwXq6scy
         F3Ag==
X-Gm-Message-State: AFuF++kMSXtIrXFdq1HKtdNhBFfsHYesesvNWTS3HXH7p2+EXHqsVGsM
	wpqK/sq1RubHifWUK0uUekcnRzeHol1O0v0Ix8JSrye+ouofOdNPzNOx3UP8raYsB1RuZEWmEcs
	AVg4O0Ch8t27O2BDmSdkgYaPyoJZs/as=
X-Gm-Gg: AR+sD11hlMJMkp2oVhnzLlKiFb23Gif+ztkMHgXRoUelOG7LjHIUQ06S0u2tiDMUF/F
	vWTEWXSlk9tC8ODU/qagDGua17fSrfNgPUT+Oc9qFK5aUPCKGCzc4Xm+Kz1I07XPu23jbUqQPoH
	H0q49NYszUS9JK/YE+qRv2kxZ2b+TjnG/8DLtz0kEFJe2r0CFI3vxPjcPegj2Bv57w8oX3arCaa
	UnWx5tI9LXNqHE5sFT367oCyP4gnLrfTuDP/yDkpV2YhdRw9ZymwZ9U31KeOoWeNj2TZQDDK8Z4
	vbDYQc8Ym+2jKQyIivqPcnh9BvnM6Lswdo08gGEsWWpVK8qjETjYGUj8OkvvqlumkxhOYFacs04
	ThvvjWtcxYmGlXhjq71g7/EZkp/F3QbvsvTe4
X-Received: by 2002:a05:6a20:9396:b0:3b3:3506:cf3f with SMTP id
 adf61e73a8af0-3d0f43b68c4mr14736826637.1.1787875952078; Thu, 27 Aug 2026
 17:12:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827002503.1425820-1-tw19881113@gmail.com>
In-Reply-To: <20260827002503.1425820-1-tw19881113@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Aug 2026 17:12:19 -0700
X-Gm-Features: AcwNN1UGTLO9psBJCpcjV6tr3CKqqmUeJvWFNXXH8dGVAYsjR_eeJzj9drqAJR4
Message-ID: <CAEf4Bzar-AZkR=j3NrJJu3ha-qokJ5nkr6_7F+jDu_4VCq5Dqw@mail.gmail.com>
Subject: Re: [PATCH v3] libpf: Fix for the potential undefined behavior due to shifting
To: Tw <tw19881113@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 26, 2026 at 5:25=E2=80=AFPM Tw <tw19881113@gmail.com> wrote:
>
> When compiling libbpf with sanitation, ubsan will report the following:
> ```
> left shift of 1 by 31 places cannot be represented in type 'int'
> ```
> This may lead to undefined behavior according to the compiler implementat=
ion,
> let's fix it by casting to unsigned counterpart before shifting.
>
> Signed-off-by: Tan Wei <tw19881113@gmail.com>
> ---
> v3:
>  - Fix a bug in v2.
>
>  tools/lib/bpf/libbpf.c          | 2 +-
>  tools/lib/bpf/libbpf_internal.h | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b749c0174..f09cbfd8e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -11738,7 +11738,7 @@ static int perf_event_open_probe(bool uprobe, boo=
l retprobe, const char *name,
>                                 errstr(bit));
>                         return bit;
>                 }
> -               attr.config |=3D 1 << bit;
> +               attr.config |=3D 1ULL << bit;
>         }
>         attr.size =3D attr_sz;
>         attr.type =3D type;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index 4c46d34fc..cb4d96233 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -77,7 +77,7 @@
>  #define JUMPTABLES_SEC ".jumptables"
>
>  #define BTF_INFO_ENC(kind, kind_flag, vlen) \
> -       ((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLEN)=
)
> +       (((__u32)(!!(kind_flag)) << 31) | ((kind) << 24) | ((vlen) & BTF_=
MAX_VLEN))

see CI build failure, this change somehow breaks CI:

    In file included from
/codebuild/output/src243362886/src/actions-runner/_work/bpf/bpf/tools/testi=
ng/selftests/bpf/prog_tests/btf_sanitize.c:6:
    /codebuild/output/src243362886/src/actions-runner/_work/bpf/bpf/tools/t=
esting/selftests/bpf/prog_tests/../test_btf.h:9:9:
error: 'BTF_INFO_ENC' macro redefined [-Werror,-Wmacro-redefined]
        9 | #define BTF_INFO_ENC(kind, kind_flag, vlen)                    =
 \
          |         ^
    /codebuild/output/src243362886/src/actions-runner/_work/bpf/bpf/tools/t=
esting/selftests/bpf/tools/include/bpf/libbpf_internal.h:79:9:
note: previous definition is here
       79 | #define BTF_INFO_ENC(kind, kind_flag, vlen) \
          |         ^
      TEST-OBJ [test_progs] cgroup_attach_multi.test.o
      TEST-OBJ [test_progs] cgroup_attach_override.test.o
    1 error generated.
    make: *** [Makefile:894:
/codebuild/output/src243362886/src/actions-runner/_work/bpf/bpf/tools/testi=
ng/selftests/bpf/btf_sanitize.test.o]
Error 1

pw-bot: cr

>  #define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_or_=
type)
>  #define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
>         ((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
> @@ -259,7 +259,7 @@ static inline enum btf_func_linkage btf_func_linkage(=
const struct btf_type *t)
>
>  static inline __u32 btf_type_info(int kind, int vlen, int kflag)
>  {
> -       return (kflag << 31) | (kind << 24) | vlen;
> +       return ((__u32)kflag << 31) | (kind << 24) | vlen;
>  }
>
>  enum map_def_parts {
> --
> 2.54.0
>
>
