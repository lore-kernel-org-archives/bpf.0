Received: from esa1.cc.uec.ac.jp (mx.uec.ac.jp [130.153.8.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB44C410D02
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 11:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=130.153.8.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907638; cv=none; b=QaPXx7romFdabVjZHLkzztzMDqRWwtVsDnTjldky8mwhbGfFH8qcW8gJF0Ki0i6PFvXba2Zj8exvCXcEzUyMYyEoy4/BZQ4U3fU1X/jjze2aNP0ZP+1a1TEPToFjLlr3YNaCzTxbeeBqBsbFVGYCLtg+0u7K7lBUso/IStJFnho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907638; c=relaxed/simple;
	bh=6F88ogYghBA0ZXO7YJkn/yBBvDVCNQLsbwgs/PwRwDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=By1H5S5z+5E7yyfsaASu5VOMi3DjZv/IkkiR2oA1O34k1KHGK0xlAfk/jkFsX9KFhDvpVPncS+nvcFQtAgIZmbtPdOY7KWZGfanHlKHjZzqob/9W8WICGvo49V8ggkRugYPf2hH6jB17MJ9Y5Ey/AhoBZniatWozUaxZXnMpM8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp; arc=none smtp.client-ip=130.153.8.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpc.is.uec.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpc.is.uec.ac.jp
X-CSE-ConnectionGUID: scmvfH6MQHyhSJMMY9X7Mw==
X-CSE-MsgGUID: in5o7WsAT3OMRvqTZtBqBQ==
X-IPAS-Result: =?us-ascii?q?A2HwBABTYm9p/zYImYJagQmHAoRYkXegGQYJAQEBAQEBA?=
 =?us-ascii?q?QEBWgQBAYUHAox6JzgTAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBAQUBAQEBA?=
 =?us-ascii?q?QEGAwEBAgKBHYYJU4ZjAQUjVhAJAgsDCgICJgICIRIBBQEcBhOFdpJxnEeBM?=
 =?us-ascii?q?oEB3XotVIEyFAGBCi6IUwGBb4QAhHhCgg2BFTWCdT6BD4M0g1uCaQSCIoEOi?=
 =?us-ascii?q?3qHbiYJHQMHBw4NHkYPBRwDWSwBE0ITFwsHBWo5KAIZAQIBgQUjSwUDERkdg?=
 =?us-ascii?q?RkKIR0XEx9YGwcFEyNsBhsGHBICAwECAjpTDCOBUgICBIEwY3uCAQ+HEAGBA?=
 =?us-ascii?q?AUubxoOIgJBUgMLYgs9NxQbSpAAR4ItAYEJBhOCSo5eB4d3jw+hEYQmhFEfn?=
 =?us-ascii?q?QIzqmsumFijaSOFJDUSgUmBf004bAaCMFIZD44tFswGaTwCBwEKAQEDCZNpA?=
 =?us-ascii?q?QE?=
IronPort-Data: A9a23:VqWq+6llIQ2q/mLIilS+NJjo5gwZJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xJLDDjTOvrcamr0KIx+ao+/px4D7ZPcy4BgQQE+rH89Hy4T+ZvOCP2ndXv9bniYRiHhoOOLz
 Cm8hv3odp1coqr0/0/1WlTZhSAik/nOHfykVLKs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82AyaDt8B56r8ks14qyr4mtA5zTSWNgS1LPgvyhNZH4gDfzpR5fIatE8NvK3Q
 e/F0Ia48gvxlz8xCsmom6rMaUYDRLjfJ2Cm0hK6jID733CuDgRrukoKHKJ0hXV/0l1lrPgoo
 Dl5jqFcfC9yVkH6dETxZDEDe812FfUuFLYquhFTu+TLp6HNWyKEL/mDkCjalGDXkwp6KTgmy
 BAWFNwCRguIgvy44Oyec8l9hv8BCezabbNAn241mFk1Dd5+KXzCa6DaoNNV2DYui9pfW+vTb
 IwQYnxtdHwsYTUWYQ9RUc9l2rfu2yWXnz5w8Tp5oYI2+GjS3QV02ZDtKNGTe8fMWMhe2E+T4
 GDel4j8KkhCao3FkGbYrBpAgMfOm378B70JPYHj0dtQnkSv9HA5ETcvAA7TTf6R0BfkBI0Ge
 iT44BEGp7A83FKkQ8O7XBCipnOA+BkGVLJt//YS7RHIxqfQ4hiUHHldCCNMY5ovv4k0XVTGy
 2NlgfvyDjlxvp3LbEu957evjxaXCHklckodMHpsoRQ+3zX1nG0kpjD3JuuP/Yawnpj5FDXx3
 T2QvXF4mrgYy8cAkaejlbwmv95OjsWXJuLWzlyINo5A0u+eTNT5D7FEEXCBsZ59wH+xFzFsf
 BEswqByFtzi8q1hZATXGb9SQ+j4jxp0GCHcjBZyGZg/+i62+mKyNYdeqDx6KUx1KMFBcjjsZ
 VLVuAhY+J5UOmDCUJKaouuZVawX8EQXPY61BqCOM4EVOcUZmc3u1HgGWHN8FlvFyCAE+ZzT8
 7/FGSpwJR720Zha8Qc=
IronPort-HdrOrdr: A9a23:E1reRKBmhUJVCI/lHell55DYdb4zR+YMi2TDGXoBMCC9Ffbo7P
 xG/c5rrSMc5wxhO03I9erhBEDEexLhHP1OjrX5X43SODUO0VHAROoJ0WKh+VPd8kbFh4lgPM
 lbAs5DIey1I1w/osrz/RWiH8xI+qjjzElqv4rj5kYoYwVja6QlyRx4BAadGkgzYAVdH5I2GN
 69y6N81lidkL0sAviGOg==
X-Talos-CUID: 9a23:1tsUHG2LSBfpJPAANX1VIbxfAcsgbHP9klLpA164MkRMbYzEeQC15/Yx
X-Talos-MUID: 9a23:n3T0qwk7dXI5TokLPUJQdnpjMppvvJu1IXxWtrA8pdC4BzBaIh2k2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,240,1763391600"; 
   d="scan'208";a="106921456"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
Received: from mx-delivery1.uec.ac.jp (HELO mx-delivery.uec.ac.jp) ([130.153.8.54])
  by esa1.cc.uec.ac.jp with ESMTP; 20 Jan 2026 20:13:55 +0900
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	by mx-delivery.uec.ac.jp (Postfix) with ESMTPSA id 1AA04183E391
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 20:13:54 +0900 (JST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-78e6dc6d6d7so48176027b3.3
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 03:13:54 -0800 (PST)
X-Gm-Message-State: AOJu0YyoasT8Rk5InLHTygH+9wZhKrbmq0pQB3dfchYxn5Eba+9MhQUJ
	/kdHdWoPiY3+Jum6Hx9dCZlIsUN/ULKTN9Jt1cFeNZUjvmKKqiKAN3WplAKp8FvizG9xqjYmcaI
	XIk7VAYK2CnyY8Gn4tcKtaRBH/oWUqOQSe5dLWqgPKg==
X-Received: by 2002:a05:690c:6089:b0:78d:b1e9:85e7 with SMTP id
 00721157ae682-793c6835c04mr114523367b3.53.1768907632419; Tue, 20 Jan 2026
 03:13:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120110011.1805037-1-ishiyama@hpc.is.uec.ac.jp>
 <20260120110011.1805037-3-ishiyama@hpc.is.uec.ac.jp> <a91e5340-ec43-4801-b740-9b46766657e1@redhat.com>
In-Reply-To: <a91e5340-ec43-4801-b740-9b46766657e1@redhat.com>
From: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
Date: Tue, 20 Jan 2026 20:13:39 +0900
X-Gmail-Original-Message-ID: <CAJjCV5HuYA3xcQ04sO7b7UAv9VN9+q-+Q2cKzyurgJs6ACo_qg@mail.gmail.com>
X-Gm-Features: AZwV_QgNxQH6zNSSnGfDcEOu3C1rGUCkcTWAqvC8Rvf7cI4nXB5xrRT7tdPDtPw
Message-ID: <CAJjCV5HuYA3xcQ04sO7b7UAv9VN9+q-+Q2cKzyurgJs6ACo_qg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] selftests/bpf: Test kfunc bpf_strncasecmp
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, mykyta.yatsenko5@gmail.com, andrii@kernel.org, 
	ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for checking!
I'll fix that and send v5 soon.

Yuzuki

2026=E5=B9=B41=E6=9C=8820=E6=97=A5(=E7=81=AB) 20:08 Viktor Malik <vmalik@re=
dhat.com>:
>
> On 1/20/26 12:00, Yuzuki Ishiyama wrote:
> > Add testsuites for kfunc bpf_strncasecmp.
> >
> > Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>
> > Acked-by: Viktor Malik <vmalik@redhat.com>
> > ---
> >  tools/testing/selftests/bpf/prog_tests/string_kfuncs.c     | 1 +
> >  tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c | 6 ++++++
> >  tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c | 1 +
> >  tools/testing/selftests/bpf/progs/string_kfuncs_success.c  | 7 +++++++
> >  4 files changed, 15 insertions(+)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c b/t=
ools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> > index 0f3bf594e7a5..300032a19445 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/string_kfuncs.c
> > @@ -9,6 +9,7 @@
> >  static const char * const test_cases[] =3D {
> >       "strcmp",
> >       "strcasecmp",
> > +     "strncasecmp",
> >       "strchr",
> >       "strchrnul",
> >       "strnchr",
> > diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c=
 b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> > index 826e6b6aff7e..bddc4e8579d2 100644
> > --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> > +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure1.c
> > @@ -33,6 +33,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp=
_null1(void *ctx) { return
> >  SEC("syscall")  __retval(USER_PTR_ERR)int test_strcmp_null2(void *ctx)=
 { return bpf_strcmp("hello", NULL); }
> >  SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_null1(void *=
ctx) { return bpf_strcasecmp(NULL, "HELLO"); }
> >  SEC("syscall")  __retval(USER_PTR_ERR)int test_strcasecmp_null2(void *=
ctx) { return bpf_strcasecmp("HELLO", NULL); }
> > +SEC("syscall") __retval(USER_PTR_ERR)int test_strncasecmp_null1(void *=
ctx) { return bpf_strncasecmp(NULL, "HELLO", 5); }
> > +SEC("syscall")  __retval(USER_PTR_ERR)int test_strncasecmp_null2(void =
*ctx) { return bpf_strncasecmp("HELLO", NULL, 5);       }
> >  SEC("syscall")  __retval(USER_PTR_ERR)int test_strchr_null(void *ctx) =
{ return bpf_strchr(NULL, 'a'); }
> >  SEC("syscall")  __retval(USER_PTR_ERR)int test_strchrnul_null(void *ct=
x) { return bpf_strchrnul(NULL, 'a'); }
> >  SEC("syscall")  __retval(USER_PTR_ERR)int test_strnchr_null(void *ctx)=
 { return bpf_strnchr(NULL, 1, 'a'); }
> > @@ -57,6 +59,8 @@ SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp=
_user_ptr1(void *ctx) { ret
> >  SEC("syscall") __retval(USER_PTR_ERR) int test_strcmp_user_ptr2(void *=
ctx) { return bpf_strcmp("hello", user_ptr); }
> >  SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr1(vo=
id *ctx) { return bpf_strcasecmp(user_ptr, "HELLO"); }
> >  SEC("syscall") __retval(USER_PTR_ERR) int test_strcasecmp_user_ptr2(vo=
id *ctx) { return bpf_strcasecmp("HELLO", user_ptr); }
> > +SEC("syscall") __retval(USER_PTR_ERR) int test_strncasecmp_user_ptr1(v=
oid *ctx) { return bpf_strncasecmp(user_ptr, "HELLO", 5); }
> > +SEC("syscall") __retval(USER_PTR_ERR) int test_strncasecmp_user_ptr2(v=
oid *ctx) { return bpf_strncasecmp("HELLO", user_ptr, 5);       }
> >  SEC("syscall") __retval(USER_PTR_ERR) int test_strchr_user_ptr(void *c=
tx) { return bpf_strchr(user_ptr, 'a'); }
> >  SEC("syscall") __retval(USER_PTR_ERR) int test_strchrnul_user_ptr(void=
 *ctx) { return bpf_strchrnul(user_ptr, 'a'); }
> >  SEC("syscall") __retval(USER_PTR_ERR) int test_strnchr_user_ptr(void *=
ctx) { return bpf_strnchr(user_ptr, 1, 'a'); }
> > @@ -83,6 +87,8 @@ SEC("syscall") __retval(-EFAULT) int test_strcmp_page=
fault1(void *ctx) { return
> >  SEC("syscall") __retval(-EFAULT) int test_strcmp_pagefault2(void *ctx)=
 { return bpf_strcmp("hello", invalid_kern_ptr); }
> >  SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault1(void *=
ctx) { return bpf_strcasecmp(invalid_kern_ptr, "HELLO"); }
> >  SEC("syscall") __retval(-EFAULT) int test_strcasecmp_pagefault2(void *=
ctx) { return bpf_strcasecmp("HELLO", invalid_kern_ptr); }
> > +SEC("syscall") __retval(-EFAULT) int test_strncasecmp_pagefault1(void =
*ctx) { return bpf_strncasecmp(invalid_kern_ptr, "HELLO", 5); }
> > +SEC("syscall") __retval(-EFAULT) int test_strncasecmp_pagefault2(void =
*ctx) { return bpf_strncasecmp("HELLO", invalid_kern_ptr, 5);   }
> >  SEC("syscall") __retval(-EFAULT) int test_strchr_pagefault(void *ctx) =
{ return bpf_strchr(invalid_kern_ptr, 'a'); }
> >  SEC("syscall") __retval(-EFAULT) int test_strchrnul_pagefault(void *ct=
x) { return bpf_strchrnul(invalid_kern_ptr, 'a'); }
> >  SEC("syscall") __retval(-EFAULT) int test_strnchr_pagefault(void *ctx)=
 { return bpf_strnchr(invalid_kern_ptr, 1, 'a'); }
> > diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c=
 b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> > index 05e1da1f250f..412c53b87b18 100644
> > --- a/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> > +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_failure2.c
> > @@ -8,6 +8,7 @@ char long_str[XATTR_SIZE_MAX + 1];
> >
> >  SEC("syscall") int test_strcmp_too_long(void *ctx) { return bpf_strcmp=
(long_str, long_str); }
> >  SEC("syscall") int test_strcasecmp_too_long(void *ctx) { return bpf_st=
rcasecmp(long_str, long_str); }
> > +SEC("syscall") int test_strncasecmp_too_long(void *ctx) { return bpf_s=
trncasecmp(long_str, long_str, sizeof(long_str)); }
> >  SEC("syscall") int test_strchr_too_long(void *ctx) { return bpf_strchr=
(long_str, 'b'); }
> >  SEC("syscall") int test_strchrnul_too_long(void *ctx) { return bpf_str=
chrnul(long_str, 'b'); }
> >  SEC("syscall") int test_strnchr_too_long(void *ctx) { return bpf_strnc=
hr(long_str, sizeof(long_str), 'b'); }
> > diff --git a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c =
b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> > index a8513964516b..3ccfae4d27d3 100644
> > --- a/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> > +++ b/tools/testing/selftests/bpf/progs/string_kfuncs_success.c
> > @@ -17,6 +17,13 @@ __test(0) int test_strcasecmp_eq2(void *ctx) { retur=
n bpf_strcasecmp(str, "HELLO
> >  __test(0) int test_strcasecmp_eq3(void *ctx) { return bpf_strcasecmp(s=
tr, "HELLO world"); }
> >  __test(1) int test_strcasecmp_neq1(void *ctx) { return bpf_strcasecmp(=
str, "hello"); }
> >  __test(1) int test_strcasecmp_neq2(void *ctx) { return bpf_strcasecmp(=
str, "HELLO"); }
> > +__test(0) int test_strncasecmp_eq1(void *ctx) { return bpf_strncasecmp=
(str, "hello world", 11); }
> > +__test(0) int test_strncasecmp_eq2(void *ctx) { return bpf_strncasecmp=
(str, "HELLO WORLD", 11); }
> > +__test(0) int test_strncasecmp_eq3(void *ctx) { return bpf_strncasecmp=
(str, "HELLO world", 11); }
> > +__test(0) int test_strncasecmp_eq4(void *ctx) { return bpf_strncasecmp=
(str, "hello", 5); }
> > +__test(0) int test_strncasecmp_eq6(void *ctx) { return bpf_strncasecmp=
(str, "hello world!", 11); }
>
> One more nit and sorry for noticing this only now. You skipped _eq5 here
> so the last one should be test_strncasecmp_eq5. If you change that, feel
> free to retain my ack.
>
> > +__test(-1) int test_strncasecmp_neq1(void *ctx) { return bpf_strncasec=
mp(str, "hello!", 6); }
> > +__test(1) int test_strncasecmp_neq2(void *ctx) { return bpf_strncasecm=
p(str, "abc", 3); }
> >  __test(1) int test_strchr_found(void *ctx) { return bpf_strchr(str, 'e=
'); }
> >  __test(11) int test_strchr_null(void *ctx) { return bpf_strchr(str, '\=
0'); }
> >  __test(-ENOENT) int test_strchr_notfound(void *ctx) { return bpf_strch=
r(str, 'x'); }
>
