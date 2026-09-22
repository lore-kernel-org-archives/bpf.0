Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774983A641D
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 20:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108261; cv=pass; b=n9c8CrpSeVIJBmQzbaX7zE3Rv2SCdbdxwQTTYo8k9y3IU/+x/wHmgar+f4WmdWKTgdy1ocxtQeY+UhoAVYBN2DzdQZ8KbipUv30H+tILSAvide/0oHruq6FFbxip32Pw1XSiiYc8SDH1E4x+dZq+P/7srP0Kdy0A0tfIw4FKxzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108261; c=relaxed/simple;
	bh=9V3KVTiyZVv6wI40G1w3QCcbEG+arVAbC65vd6l13bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p3phJQgaTMyTJgWU0HufzraTXXfBrTPjQgUQDQO8iAH5MqzldxGGV67IXQYi5r72dsbl74mZUwdH/HkkdEGyAdcsLt4Fp7cpAZwtWzwKSouq5S2a4mz0gGnCaUBZOjoYtLJ+3DnSpAKYPBAd9w+xroUl/nJ8MtbLQPqHCAX2Pw4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hq3oTguv; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hq3oTguv"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-46accbdfb21so263080fac.1
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 13:17:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790108234; cv=none;
        d=google.com; s=arc-20260327;
        b=fsWjy13tagxU8tKHoV39MjeG3rfTIBKKIW/RxDjwoOYndu/Sp6ZDPYR6U2aFaGZ/jh
         ev5vCah2wNgdG9OyLgBm/n4GohY8vLfBQS7/D9c3nULU8b0r4sF+LULL4voANiOtp8Zc
         VVo4oGZixnTNWk6J0ge8AFCxUMDb/rNhHHNL67sREqUNo/MEW+23Bq34GX2Fl6moWayV
         1G0URn4qDgovD8j7yJWwpD1X/LdaLcQLh6F8wpY+Z+AdyvdHtrK+tgJTjajfzHAqea8E
         j6JVR6m4CPaIJdfzRvp8/DtEoOGuDhmB/EqGuX0UwN9+Q6Aqa0CWZ9xBakZA2jCQ3ZnA
         Xk/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=QcJg5n7sOOPwVaLZ6LVxB6ocMORc9n4O7Z2iUI9KKlU=;
        fh=nskOhJawYMy+x9WfuMLfoXmPVtAcOID6DogK8RiSaQk=;
        b=sxZDz3K2v5DdnTws11s3EJCEwXsthTVIMu9Lu4Dyd0MUiYKwqAQ7F6QmPLMyP+Yerz
         /YII3ecASZAzbHZJcbBs8EeBNikE6NOcFvd4NrDDUwti8KDmteMOT8hp2NbRHXhrQ+L8
         LPDHlPQagxaApLtqynITsM3zVi67CziSJBQDWfwASFV/ragACj+NIvohbYWLwHiap4FH
         NnCgOP0DDXzzklbvnoiGKD8JqNoK1Vokbh3gA9D40CHbB8fee6C8U5uGPI/msyCvctvs
         fYjBEStlE8+uQusIG7LI8G2zwseK+rpfiaToh5wf3JlSN3Z7sOXvYUJtjrwqUBo7rgiW
         4erQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790108234; x=1790713034; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QcJg5n7sOOPwVaLZ6LVxB6ocMORc9n4O7Z2iUI9KKlU=;
        b=Hq3oTguvc69DIA1IK9Dt/hXfKDIP2jJraAlmln35Hw6OEZ8niOUvVy/1g8pyYhAv/K
         zeE1FB+oepqaHnQMUa192kcXjMoyY2YxRBDhjS9T0i4Gu5C8FGEOEbdIjHfhf48Ft6EP
         1ee3XYzgbt2yaaQybkGgr1Kyp1hzPjAYBvghgP2BjN6vmqoPL4qeQZUy9YEhZyM9M6Xj
         0FXf+31QSTMqXJyyTa4VN9znpLW79JTj8OCFMJkppPHe8P7OlbRPdfoal6se6pa4ja6x
         htEB1ROUMFa9Hxa35Gap17GuOr6LEwNP0JHB7T3o7+axuRN1kcCZxdiZ64dTrpCzzQcA
         AOEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108234; x=1790713034;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QcJg5n7sOOPwVaLZ6LVxB6ocMORc9n4O7Z2iUI9KKlU=;
        b=JtWqCal2ILgmlRA3pzMNVDPsOpnPWccxpzr6XinbdEgUa2FpjvPPE6t2oe8LkHQdm9
         LvoE8wnaf68mnDX/W9B9CbBDPDqxoUJcUoz1mFE8Q9kdTsQvOiSeJ7/ZH5H2rNyZl6E6
         NAtbf04ubRWgZ9lssoBfuoxzmPQ7w98Ss/9gxVlKWEsSA/LIx2zs0i3BP/BhLKsr60Jx
         /Tj6NTbmIhAsswOLE0tIcNTFplz07EW51M2nxwrkvn4pRndB5qHwLYVwdxbH1ocHrJT4
         6pA4w2w/pFR2B+3y+teiKuv+Z8zGT/bRehoWkEX/4Un9pwoTV68Wrbf2C4j6H5dCq+p9
         ByRw==
X-Gm-Message-State: AFuF++l9oPyqyUlIRJlB2hNWUwDOW+f3n6fSYDtBBmohPNH/d4nbfgR/
	cduxFdl93k3PDhcfwzqBFBMUnd4DcMxZ/yR6Pg7SykhiMN1dW0LudlF892d5/5r3Ehad/YalKJ6
	p0Ao62zXt8R1aPQErv8HQdiJFr/9FXIWCm049
X-Gm-Gg: AYBFou1+CcDw9PvbB+wqtre6Gv3+LED0j5eUJ8CEc6vUDrflrTQglJix15A+Zg6oSwm
	MVuvhUbL4f8jydRl8WH++rqsPU75hG7pEW2/9lHghfP1tT7M9WJQRdjur8yfhvfJppKeuhBvc7s
	zDTVQuizDm9O3GikrM7DSpRmo37dCID08mPTsOQRT0agrVPRsjum15erFKU8QCyS69TAmSl+o50
	BeeOfSdSa5JhXq6nGYvKJpYzJFSgeX6RMux2tYKA8cggnr1DUiEyBH0V3MtFm0u5KTSk60e5Ba1
	RhOKxUd4fQp//szsS48uxEZN3HygbhC64ZCDvu7SvEzsR8fHkb/QdnjahlcRN2WcHlEuMrY=
X-Received: by 2002:a05:6820:81c9:b0:6c9:80d8:a207 with SMTP id
 006d021491bc7-6d2d2622351mr445563eaf.68.1790108234294; Tue, 22 Sep 2026
 13:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922172028.6269-1-emil@etsalapatis.com> <20260922172028.6269-3-emil@etsalapatis.com>
In-Reply-To: <20260922172028.6269-3-emil@etsalapatis.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 22 Sep 2026 13:16:57 -0700
X-Gm-Features: AcwNN1XiYZPnaP5SRicCGj5AlCNONGjzkq8fstgTnhVQRWjQxe7fEQGRoeX3cmM
Message-ID: <CAMB2axOg4d9BtEiSe8f_gRK8HW71XcxCJZhw207evsB+cyn_nQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 02/11] selftests/bpf: Test dynptr slices past end
 of skb
To: Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, 
	memxor@gmail.com, daniel@iogearbox.net, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 11:37=E2=80=AFAM Emil Tsalapatis <emil@etsalapatis.=
com> wrote:
>
> Add a selftest to ensure dynptr slices cannot include
> past the end of the linear area of an skb.
>
> Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
> ---
>  .../testing/selftests/bpf/prog_tests/dynptr.c | 10 ++++++++++
>  .../selftests/bpf/progs/dynptr_success.c      | 20 +++++++++++++++++++
>  2 files changed, 30 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/dynptr.c b/tools/test=
ing/selftests/bpf/prog_tests/dynptr.c
> index 5fda11590..439656036 100644
> --- a/tools/testing/selftests/bpf/prog_tests/dynptr.c
> +++ b/tools/testing/selftests/bpf/prog_tests/dynptr.c
> @@ -9,6 +9,7 @@
>  enum test_setup_type {
>         SETUP_SYSCALL_SLEEP,
>         SETUP_SKB_PROG,
> +       SETUP_SKB_PROG_NONLINEAR,
>         SETUP_SKB_PROG_TP,
>         SETUP_XDP_PROG,
>  };
> @@ -32,6 +33,7 @@ static struct {
>         {"test_ringbuf", SETUP_SYSCALL_SLEEP},
>         {"test_skb_readonly", SETUP_SKB_PROG},
>         {"test_dynptr_skb_data", SETUP_SKB_PROG},
> +       {"test_dynptr_skb_slice_non_linear", SETUP_SKB_PROG_NONLINEAR},
>         {"test_dynptr_skb_meta_data", SETUP_SKB_PROG},
>         {"test_dynptr_skb_meta_flags", SETUP_SKB_PROG},
>         {"test_adjust", SETUP_SYSCALL_SLEEP},
> @@ -94,7 +96,9 @@ static void verify_success(const char *prog_name, enum =
test_setup_type setup_typ
>                 bpf_link__destroy(link);
>                 break;
>         case SETUP_SKB_PROG:
> +       case SETUP_SKB_PROG_NONLINEAR:
>         {
> +               struct __sk_buff ctx =3D {};
>                 int prog_fd;
>                 char buf[64];
>
> @@ -106,6 +110,12 @@ static void verify_success(const char *prog_name, en=
um test_setup_type setup_typ
>                             .repeat =3D 1,
>                 );
>
> +               if (setup_type =3D=3D SETUP_SKB_PROG_NONLINEAR) {
> +                       ctx.data_end =3D ETH_HLEN + sizeof(struct iphdr);
> +                       topts.ctx_in =3D &ctx;
> +                       topts.ctx_size_in =3D sizeof(ctx);
> +               }
> +
>                 prog_fd =3D bpf_program__fd(prog);
>                 if (!ASSERT_GE(prog_fd, 0, "prog_fd"))
>                         goto cleanup;
> diff --git a/tools/testing/selftests/bpf/progs/dynptr_success.c b/tools/t=
esting/selftests/bpf/progs/dynptr_success.c
> index e0745b6e4..b668ebd61 100644
> --- a/tools/testing/selftests/bpf/progs/dynptr_success.c
> +++ b/tools/testing/selftests/bpf/progs/dynptr_success.c
> @@ -10,6 +10,7 @@
>  #include "errno.h"
>
>  #define PAGE_SIZE_64K 65536
> +#define TEST_SKB_LINEAR_SIZE (sizeof(struct ethhdr) + sizeof(struct iphd=
r))
>
>  char _license[] SEC("license") =3D "GPL";
>
> @@ -211,6 +212,25 @@ int test_dynptr_skb_data(struct __sk_buff *skb)
>         return 1;
>  }
>
> +SEC("?tc")
> +int test_dynptr_skb_slice_non_linear(struct __sk_buff *skb)
> +{
> +       struct bpf_dynptr ptr;
> +       void *data;
> +
> +       if (bpf_dynptr_from_skb(skb, 0, &ptr)) {
> +               err =3D 1;
> +               return 1;
> +       }
> +
> +       /* Ensure we cannot read past the end of the buffer. */

nit: maybe "end of the linear area of an skb" to be clear?

Reviewed-by: Amery Hung <ameryhung@gmail.com>

> +       data =3D bpf_dynptr_slice(&ptr, TEST_SKB_LINEAR_SIZE + 1, NULL, 1=
);
> +       if (data)
> +               err =3D 2;
> +
> +       return 1;
> +}
> +
>  SEC("?tc")
>  int test_dynptr_skb_meta_data(struct __sk_buff *skb)
>  {
> --
> 2.54.0
>
>
