Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4AD32DA775
	for <bpf@vger.kernel.org>; Fri, 28 Aug 2026 00:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787876024; cv=pass; b=k85/xePBE5NeesCfr8odO+QIwHZtumdFVhl1dewfJ3+m4fNWZFTM90gZXHrR9GMd0jwoOCdYWRAYXDG5h1XLKqg66bRO7XkPb6Q06dhiCnsGgdHueBBp0onEL9tgR74CC30IVztwhJEKDnKEt1LxBxKOchjBdqO3AfsRTVQvoCM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787876024; c=relaxed/simple;
	bh=E1QcKcZX0dO9IpRwuW2dCrJpFeF1oRlsd94emG2RLLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CGm02WTxdraVLkBldbNBNfap3xJlXbLmRsIOPLRqRQjMZ+BKaTKauJqkot6Qcnuo4Nv2IhfjlPc/VVxibRWoVnooD9YhXXgzROdj7ZGEHd61lEubEWCVMAC3LBeaU0gCshig9mqovvAQ2ygRB07lB++kmenE+HRnRnqhwObEUMw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o8Qb1ikR; arc=pass smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o8Qb1ikR"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso234275a12.0
        for <bpf@vger.kernel.org>; Thu, 27 Aug 2026 17:13:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787876009; cv=none;
        d=google.com; s=arc-20260327;
        b=UUePmcvd+iM/IJ+edtg5iXPGHKN6MHfZhAs1u+4E6zrbEMZluZlKwFA2E5pohKdN7N
         wNJrfif+SYHMZiTR9ThNfLV8KZggE2Ma5ARYGQSAlEmrnWPSSltWjsmI3X3/DjmbU0zL
         Kru7UxrjVAGzw7rQdpPEuqCcp9UhIaZElFJPfRvuJzbl011MWCrKXIdT4NUad4XnoEFQ
         XnWJ16/nJVNEr6tRHtegp6InN72aR56PsN7a5C6AszuvWerrayw5mJ9fFi9Du7tUmb1w
         rywWLPdcdgVCmb0LhkSdVsT9X2/QNN/vzI39LAPDRhQLtVwfnpDhCWm9T/FsUumQX7jM
         y7+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3jk3lSAsHimrtftzM+YzpuGvQOcMvP2KTdSs9MbMdfQ=;
        fh=nqcOef/kywzr9d9QbNsogATk3v5A+nXOrN5Mrs0wZkk=;
        b=jFEGAFmSQ4eYXNMIoigG/Y6pTeYILGQX0WmgYsTtCpP4fRYIQa4SYUZImElE0R5xHQ
         14vc+IB4vhSGfuecujPqg0OuuTc5Zi7sYL78dgX0L96+IZ1/oPHDoaKY77fb9LBciiun
         coQcnEI9b3rujHuV8zzYfUfsBJ4USypmsEKACfDTY0P+YC2mD1OhJ/TxAox9lbY0xR4j
         fi7AJDIQDwbj3j+mTj7xhvGEm0gmaIPgktoukGWPW1TaPL7gwGSZjRDvS1IKLtaMLZ4V
         Ti514pW0dP8Z49BnHkYdmojgl9Jx+suQ1mHqWfKB5KWHjE0eFJu+x+1GGObuyJRK3y0T
         CvuQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787876009; x=1788480809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3jk3lSAsHimrtftzM+YzpuGvQOcMvP2KTdSs9MbMdfQ=;
        b=o8Qb1ikRf7pATvX2ddHcve0VkZRhFoVPq2NByk/dSrSze9slfiUVyF/9W+v1q9AP9P
         eFxA99xk6TKEefXoD2UJYTb81oYXwfS2wQj70VxchLLUOdd21MtZELAhxwAbOJGlOx+O
         FPsFmuMuvYTg3qHJTI7+Rh0spPz3q+xzpubNgYijJTxxYoxR5j7+mq8jIht6mjSVSE3c
         kO8ZW7mkn3dD1dD6H5jkpin/1iHYOk6NLuzDm/UchFQAhNOMjMACgvWUCjJ5AtaOdPc0
         rayBht2dDM97yvH/w/OZ7qzUcYL86s4CSgncwcUpJkvJRL4PtURoXIDqLGAHSHLsBnUe
         ee/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787876009; x=1788480809;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3jk3lSAsHimrtftzM+YzpuGvQOcMvP2KTdSs9MbMdfQ=;
        b=bDyGklHDSXfHMFxh4DIBTJEL0+9H5xMsXKps+JrIL2+vw4uYLtGhUtqRk0l3WANDJs
         qSD0j9sIS1R6LmpNj+xUjfvvSydswC3b6ikRb6Cnzh4hnvdlEo+9lb4lj7Yj8A/cUquZ
         3U/ZfLE1synJ22rw7uW2bJbSPv7oCoqB43J1nSRFLhxKs4z3SIrFgSn3XJWpcHTN4ToB
         Z4ZOfsDpbdqWHe2EMUiPBZ3VgMi55nA5Ms00LNtYEhqXEV+RY/UteJ014VA/oXT/m6SM
         4AjkjswAoUAGKfboyQQAwaZeHo1adNTdwoydzVUJ6QvouWfeeo//z1GZDoncQo7Ra/1X
         lJng==
X-Gm-Message-State: AFuF++mdvy1avAARDytBC5GzFwTuV0ZlGWRzQWAzHZyeUjU0Jy/bmS15
	PCITGEx+rjlxGLHJgTAkVXCDk6O27Du4XLpBYcJi+lDY3Cz9yRcPVQoVlEhGnQW/m/htoL2dQlM
	ztBIOqeiwCLUSxY7CLbVKbakuZi9UJfb2hw==
X-Gm-Gg: AR+sD12HW26M37RdtWOC5tH1yitzFZW7NydjYRCuE1P8NiKZsIwoH0OFwrp6W5IaRVP
	jxSTHJSQ5Ypb6NV0MQurU+U9T3sdQKSSWCeCKspoZ9Zuxu14oNc9MWuSLqvcFCduVbZGAbeYXs0
	tTSLYQ6owf4LfDCDP4JkhNdTqHL6VbUtDsNsuH4bJvTUr6JEvw8SNK3L3Rh5wo5F2XaywcuPQ0+
	14F3MkOEdYuC7yCx/KwfIzGoERSYUGfXMn4Qn1NCQmYYxCuqpMfKWtETa+9w4mgaUc8s00/fkTB
	fmRJU+2TKfw3UQ8MJaALpt+7Pu0kexK71+PPumjte/ztTTpw9/QSEg+8fFvxAlOo+pa9jC3B7xo
	TT/hA/6jOv4ZpxQZH7O7Hvkd5ww==
X-Received: by 2002:a05:6300:220c:b0:3d1:5c01:e6cc with SMTP id
 adf61e73a8af0-3d26784f34cmr6233915637.10.1787876009110; Thu, 27 Aug 2026
 17:13:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827002503.1425820-1-tw19881113@gmail.com> <CAEf4Bzar-AZkR=j3NrJJu3ha-qokJ5nkr6_7F+jDu_4VCq5Dqw@mail.gmail.com>
In-Reply-To: <CAEf4Bzar-AZkR=j3NrJJu3ha-qokJ5nkr6_7F+jDu_4VCq5Dqw@mail.gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 27 Aug 2026 17:13:15 -0700
X-Gm-Features: AcwNN1UsIr5TA80AEAp-yZZD6uShQ77X_JQSftNqO-ML2V5ksRcE2_He_U1F1Cs
Message-ID: <CAEf4BzaHUuBnZPBmZ9TxFAG8UXsA=xe=mKk1M9KZ7kGvynYC=g@mail.gmail.com>
Subject: Re: [PATCH v3] libpf: Fix for the potential undefined behavior due to shifting
To: Tw <tw19881113@gmail.com>
Cc: bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 5:12=E2=80=AFPM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Aug 26, 2026 at 5:25=E2=80=AFPM Tw <tw19881113@gmail.com> wrote:
> >
> > When compiling libbpf with sanitation, ubsan will report the following:
> > ```
> > left shift of 1 by 31 places cannot be represented in type 'int'
> > ```
> > This may lead to undefined behavior according to the compiler implement=
ation,
> > let's fix it by casting to unsigned counterpart before shifting.
> >
> > Signed-off-by: Tan Wei <tw19881113@gmail.com>
> > ---
> > v3:
> >  - Fix a bug in v2.
> >

and you have a typo in patch subject: s/libpf/libbpf/

> >  tools/lib/bpf/libbpf.c          | 2 +-
> >  tools/lib/bpf/libbpf_internal.h | 4 ++--
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> > index b749c0174..f09cbfd8e 100644
> > --- a/tools/lib/bpf/libbpf.c
> > +++ b/tools/lib/bpf/libbpf.c
> > @@ -11738,7 +11738,7 @@ static int perf_event_open_probe(bool uprobe, b=
ool retprobe, const char *name,
> >                                 errstr(bit));
> >                         return bit;
> >                 }
> > -               attr.config |=3D 1 << bit;
> > +               attr.config |=3D 1ULL << bit;
> >         }
> >         attr.size =3D attr_sz;
> >         attr.type =3D type;
> > diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_int=
ernal.h
> > index 4c46d34fc..cb4d96233 100644
> > --- a/tools/lib/bpf/libbpf_internal.h
> > +++ b/tools/lib/bpf/libbpf_internal.h
> > @@ -77,7 +77,7 @@
> >  #define JUMPTABLES_SEC ".jumptables"
> >
> >  #define BTF_INFO_ENC(kind, kind_flag, vlen) \
> > -       ((!!(kind_flag) << 31) | ((kind) << 24) | ((vlen) & BTF_MAX_VLE=
N))
> > +       (((__u32)(!!(kind_flag)) << 31) | ((kind) << 24) | ((vlen) & BT=
F_MAX_VLEN))
>
> see CI build failure, this change somehow breaks CI:
>
>     In file included from
> /codebuild/output/src243362886/src/actions-runner/_work/bpf/bpf/tools/tes=
ting/selftests/bpf/prog_tests/btf_sanitize.c:6:
>     /codebuild/output/src243362886/src/actions-runner/_work/bpf/bpf/tools=
/testing/selftests/bpf/prog_tests/../test_btf.h:9:9:
> error: 'BTF_INFO_ENC' macro redefined [-Werror,-Wmacro-redefined]
>         9 | #define BTF_INFO_ENC(kind, kind_flag, vlen)                  =
   \
>           |         ^
>     /codebuild/output/src243362886/src/actions-runner/_work/bpf/bpf/tools=
/testing/selftests/bpf/tools/include/bpf/libbpf_internal.h:79:9:
> note: previous definition is here
>        79 | #define BTF_INFO_ENC(kind, kind_flag, vlen) \
>           |         ^
>       TEST-OBJ [test_progs] cgroup_attach_multi.test.o
>       TEST-OBJ [test_progs] cgroup_attach_override.test.o
>     1 error generated.
>     make: *** [Makefile:894:
> /codebuild/output/src243362886/src/actions-runner/_work/bpf/bpf/tools/tes=
ting/selftests/bpf/btf_sanitize.test.o]
> Error 1
>
> pw-bot: cr
>
> >  #define BTF_TYPE_ENC(name, info, size_or_type) (name), (info), (size_o=
r_type)
> >  #define BTF_INT_ENC(encoding, bits_offset, nr_bits) \
> >         ((encoding) << 24 | (bits_offset) << 16 | (nr_bits))
> > @@ -259,7 +259,7 @@ static inline enum btf_func_linkage btf_func_linkag=
e(const struct btf_type *t)
> >
> >  static inline __u32 btf_type_info(int kind, int vlen, int kflag)
> >  {
> > -       return (kflag << 31) | (kind << 24) | vlen;
> > +       return ((__u32)kflag << 31) | (kind << 24) | vlen;
> >  }
> >
> >  enum map_def_parts {
> > --
> > 2.54.0
> >
> >
