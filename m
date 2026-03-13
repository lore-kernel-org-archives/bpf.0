Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 082F13A2560
	for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 14:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773411641; cv=pass; b=raF4QUa2omu4U1DugnyezaUUKbcZ3zJbI4s1+BIz033ssL8uV0beCtKwLrYmigTEtjconlZzM4L2AsF2g5jp4mnMLgxKsNsj350v1VBB2jynb9GiywQk482L+AjeAIFjPOEqXG5zaZSBRNeF5G9qFdM6gkLlBb4bnS9JQCIuPbg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773411641; c=relaxed/simple;
	bh=BcGrGeHXe2jO7d1iGFXYIT6nIOBt21TcAx873DkzSmc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ldYRdrR64u3c43AEjyt52yfknuil3e371hT//exwf3NgPqAIFnFFW5G4YWw4HKF6k9RrYtG2MBwHC0eIJCGV8fr+B5cgoMv3MGe/Gircju3n8xVOrcxoXo4s7FMdjSXWcfNtp1hh4CJZexnrp6lNrGXp9hU+gXQU8vOlLw/1bLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kG3HQbER; arc=pass smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kG3HQbER"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-439d8df7620so1678670f8f.0
        for <bpf@vger.kernel.org>; Fri, 13 Mar 2026 07:20:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773411637; cv=none;
        d=google.com; s=arc-20240605;
        b=lQtWnnFt/xYpYtZ7ewYW+PxvwrKzkMRQTlqafRGe6T6XNs7lNYqb8+njFZOnbAqW03
         WC8yN7BTHKZpIxh389T55zFPyuzqfEh92nYKVPOcX77zundwkGCgnD0h32xeQRtIwbRC
         z2lbinlRwj1eg4Gd69xfouOkHhkey4dI/XWOD1olv+Iqu7TXV22FowNPyRQ3O81DnDyl
         slvYEoi1HzFUMriffPdANIfAgtr5pZEsLrBiPYcZ2xNMl5Av+n2OUwSgk92pie+IjKgR
         hrwzcNuTPPkdToe6RitzimM7wxFMyTbHqSGZ6xzp4yk5uMUepmhndSPSfM/e9kCxBPhA
         qWHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bWchfiAssZCYRh2ybEE9+73QVqevcBXDejsJHQ9I4ag=;
        fh=xQtsLQihPqtJvb71PsuAF1pNQRd8f+9AxjHcMCc8DQw=;
        b=By/hfIW8DEPmyToUZUKtO203PK3x2b481g3AFvXfo9SXTSkQ30KGGsYNWw6cQT77nS
         sav2xfvYrI5iulB61G2dx99YrmtvzaF3h+pjlS2DXuP50+VnRyB5FfRsXU6UjSb58ZgK
         pnKgpDX8DeSfcXDpABmrbsCl1s4VLD03viS8QVq8505WEbc/nfvwtwB2qrxIR6gOnTwP
         7hs6YA+Hs/lcRmCRw7DF/CfHIbvLe6SqHsyrXjygzHUJ+pTAw3Z0KjS8CuBTnxDl0FN0
         3uGi28Kz12h3KjAL8nyuNcKg5gC7tWPB8TLICaYui4jdIyGWZMdIeMZWhRda/Z+ap2W8
         ibEw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773411637; x=1774016437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWchfiAssZCYRh2ybEE9+73QVqevcBXDejsJHQ9I4ag=;
        b=kG3HQbERLbJYaeuTD9m/kguBCv5zI+Mq+aWyiXKCA3R9iPTVQGA+nuQzt+uyA5O6By
         M6dRitgyWHk+3zw9mbz157+RGAR2UUZnU+xdTYukCIJfM24F5fr+Bm2BMRsAanZlreJM
         CJLsihgB5/f6xcAXxGvEjaHb0xeM583mveFAiGBb1Z3M9KovKTRC8M5/uHLG2P2GMJMF
         mAN54oATyO8LQCn/RQcVEyVpAoT+qHebTROoXCvaHxPj3HM+1bjlqBMIr34Cheho/k8Z
         3YiBWjsg5D0aOKT4lAb7pERgpoGD7+Kj/lyKWRQobX3/GqM9Ipt6Hf5Bn8ZeyTeMk/4g
         IWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773411637; x=1774016437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bWchfiAssZCYRh2ybEE9+73QVqevcBXDejsJHQ9I4ag=;
        b=V7UIcOQBntzFcsfbTkLds6cJ0CE5M6i+C8oLUdn+nA5Csp9jYMN0hHIfV0IHwBpxsW
         Hrf+0SXpJjccu6Zgbd0jmzRzxjhBuGhdI6f5SvLgCbJkcel1quz2/2e+8Br3hJsa2VAX
         omfPN+PNsW8G3cUR+MrwJCHZ48JZFwCdn8owqtY5vPL55k63Gricax9PeowqCvZ7PTKy
         sRVE/It4+KNZGrZ+UEjMGFyouyyCKMVjt+QiEvAgDirSdkbxK60fYqnew+DeIxoo6rMT
         wezz0koz7Gn12ThrNGFhsOZxvcktzzrVGaHM+OoNu7gkMuErUAB2yC1ne7G2yZILsun0
         zboQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4lOFWHqhtRXNOd49wzM1JveggJ/Yt+uSNJV3ZgNbY1XvaQZeew1cgiO4XmzuALZjMI5g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwatpIIJM8foz6TjMt5hcymF/1XKu6ReAIKWzmec7eebjhubEP+
	TVvXRlN2RvoZ8TiaJVsmeMQov4FKqJLXxKK65+91Fjd1sseIIgr60h7nM8ENOdGvW5Vofaxzdjb
	e6tE0vPbsKIf6us/SJnpURUrycK9swOc=
X-Gm-Gg: ATEYQzwaASG3SHQ4WnjF8NZ4GBIZByaFO5gdnPcotO8nEHUjyhsH27fGEkRq5XGKQ9i
	y2ayAGzaX/8bBQ+PrbkocEdd/73kRja4sAGRMxRhC2h2h9q5ousSA/dG5acGt+R8k5ZFv6QDTu0
	yUsVUsZQAG4oZEElirDPpRuoGtw5lAQ0q78PvfnL9+hJaEN0B/rpDlkTFtPV5T3xU2Ys/2JJ4Lu
	JMcYTZJUHjqogN99YP+cvnMo65d98hrASF9qmeZq1L8lRtRbAE/Tv+XKmqyl2UXAinFwzjvHdk1
	ZojOor645VBewKh9nTkHKCnhCUshaPAcZ3u70Yw1075QkUQ2SNJasriFvGcQkR05/RA=
X-Received: by 2002:a05:6000:186f:b0:439:b629:42d7 with SMTP id
 ffacd0b85a97d-43a04dcbb39mr6923759f8f.46.1773411636611; Fri, 13 Mar 2026
 07:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260312080113.843408-1-hbathini@linux.ibm.com>
 <02e68ebf-5782-4632-aed8-0026a3aab96b@linux.dev> <ec4e7ff6-55e3-4889-b507-fee71fab99f8@linux.ibm.com>
In-Reply-To: <ec4e7ff6-55e3-4889-b507-fee71fab99f8@linux.ibm.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 13 Mar 2026 07:20:25 -0700
X-Gm-Features: AaiRm523Q6Wteh_7o3CKQT5m-0--e3n8H5bS0Ist7DgivFI_rPZYAXRBWJjbods
Message-ID: <CAADnVQK--hKVH=FBMLiF7io2kBLfqwkXM9porBS1T--og=R4Yw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: improve test coverage for
 kfunc call
To: Hari Bathini <hbathini@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 2:30=E2=80=AFAM Hari Bathini <hbathini@linux.ibm.co=
m> wrote:
>
>
>
> On 12/03/26 11:52 pm, Yonghong Song wrote:
> >
> >
> > On 3/12/26 1:01 AM, Hari Bathini wrote:
> >> On powerpc, immediate load instructions are sign extended. In case
> >> of unsigned types, arguments should be explicitly zero-extended by
> >> the caller. For kfunc call, this needs to be handled in the JIT code.
> >> In bpf_kfunc_call_test4(), that tests for sign-extension of signed
> >> argument types in kfunc calls, add some additional failure checks.
> >> And add bpf_kfunc_call_test5() to test zero-extension of unsigned
> >> argument types in kfunc calls.
> >>
> >> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> >
> > LGTM with a nit below.
> >
> > Acked-by: Yonghong Song <yonghong.song@linux.dev>
>
> Thanks for the review, Yonghong.
>
> >
> >> ---
> >>
> >> Changes in v2:
> >> - Added asm version of the selftest for consistent testing across
> >>    different BPF ISA versions.
> >> - Added comments clearly stating the intent of the test cases.
> >> - Updated sign-extension selftest to have additional failure checks.
> >>
> >>
> >>   .../selftests/bpf/prog_tests/kfunc_call.c     |  2 +
> >>   .../selftests/bpf/progs/kfunc_call_test.c     | 98 +++++++++++++++++=
++
> >>   .../selftests/bpf/test_kmods/bpf_testmod.c    | 54 +++++++++-
> >>   .../bpf/test_kmods/bpf_testmod_kfunc.h        |  1 +
> >>   4 files changed, 154 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c b/
> >> tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> >> index f79c8e53cb3e..62f3fb79f5d1 100644
> >> --- a/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> >> +++ b/tools/testing/selftests/bpf/prog_tests/kfunc_call.c
> >> @@ -74,6 +74,8 @@ static struct kfunc_test_params kfunc_tests[] =3D {
> >>       TC_TEST(kfunc_call_test1, 12),
> >>       TC_TEST(kfunc_call_test2, 3),
> >>       TC_TEST(kfunc_call_test4, -1234),
> >> +    TC_TEST(kfunc_call_test5, 0),
> >> +    TC_TEST(kfunc_call_test5_asm, 0),
> >>       TC_TEST(kfunc_call_test_ref_btf_id, 0),
> >>       TC_TEST(kfunc_call_test_get_mem, 42),
> >>       SYSCALL_TEST(kfunc_syscall_test, 0),
> >> diff --git a/tools/testing/selftests/bpf/progs/kfunc_call_test.c b/
> >> tools/testing/selftests/bpf/progs/kfunc_call_test.c
> >> index 8b86113a0126..5edc51564f71 100644
> >> --- a/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> >> +++ b/tools/testing/selftests/bpf/progs/kfunc_call_test.c
> >> @@ -2,8 +2,106 @@
> >>   /* Copyright (c) 2021 Facebook */
> >>   #include <vmlinux.h>
> >>   #include <bpf/bpf_helpers.h>
> >> +#include "bpf_misc.h"
> >>   #include "../test_kmods/bpf_testmod_kfunc.h"
> >> +SEC("tc")
> >> +int kfunc_call_test5(struct __sk_buff *skb)
> >> +{
> >> +    struct bpf_sock *sk =3D skb->sk;
> >> +    int ret;
> >> +    u32 val32;
> >> +    u16 val16;
> >> +    u8 val8;
> >> +
> >> +    if (!sk)
> >> +        return -1;
> >> +
> >> +    sk =3D bpf_sk_fullsock(sk);
> >> +    if (!sk)
> >> +        return -1;
> >> +
> >> +    /*
> >> +     * Test with constant values to verify zero-extension.
> >> +     * ISA-dependent BPF asm:
> >> +     *   With ALU32:    w1 =3D 0xFF; w2 =3D 0xFFFF; w3 =3D 0xFFFFffff
> >> +     *   Without ALU32: r1 =3D 0xFF; r2 =3D 0xFFFF; r3 =3D 0xFFFFffff
> >> +     * Both zero-extend to 64-bit before the kfunc call.
> >> +     */
> >> +    ret =3D bpf_kfunc_call_test5(0xFF, 0xFFFF, 0xFFFFffffULL);
> >
> > Can we just use 0xFFFFffff instead of 0xFFFFffffULL?
>
> Alexei, can you confirm if I need to respin with this change?

I prefer the explicit type when the constant is on the boundary.

I was about to apply it, but it fails on s390. See CI:

Error: #160 kfunc_call
Error: #160/13 kfunc_call/kfunc_call_test5_asm
Error: #160/13 kfunc_call/kfunc_call_test5_asm
verify_success:PASS:skel 0 nsec
verify_success:PASS:bpf_object__find_program_by_name 0 nsec
verify_success:PASS:kfunc_call_test5_asm 0 nsec
verify_success:FAIL:retval unexpected retval: actual 6 !=3D expected 0
Test Results:
bpftool: PASS
test_progs: FAIL (returned 1)

It doesn't look to be endianness related (which is often
the case for breaking s390).
In this case it could be an s390 JIT issue?

Ilya ?

pw-bot: cr
