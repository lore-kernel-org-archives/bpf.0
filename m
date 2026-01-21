Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC092BCF4C
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768957556; cv=pass; b=eTQciKwIpJe8ihP3kcbOFnUHh0PGVenucoDVyKPqattfaXSCaAoYRSe3cYfGSSK2sDcgi6rmOYkfO5tJ5rSEEa6x42Hz9SDNSwYthQBpi1uN61cyP3tmxlsViR46IEUc7XFCnFmh1pUXIGWHsqCcLdOSPCI7pxpO3PqtQMlXPzI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768957556; c=relaxed/simple;
	bh=8pqa8OYjP+H2tR1BiFys92JI6YisCfB390EDUyM1WRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MnTctHhTrpmDsi2iSnNxLv6sgDiPwdt9vSGvP4j/nqynptfixMSP9P/sdfDd4916UDuecThqQW73nD2D8YxNLCanMeH1PXgQXWFbciWuOme4OfMLFKA8yNeiv3hiiGA2OotL2+3BaOr2xpgEIF9dZEjrS6N9TmreedjLdTGPIqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W42p5o1n; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W42p5o1n"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2a0d6f647e2so58378115ad.1
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 17:05:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768957554; cv=none;
        d=google.com; s=arc-20240605;
        b=aAbSb4J68/GwZtGhDAZz6Nn8BNZ+6n5tmMKYEZfoF6qOy12D5/PQ5Y4ZGVIMOacRLq
         abogjr4Qt8DOzO9YTPk9OLPW4WhOKIlTfES02dLrnZSf603MtkNqr9FKijn2C4q5/cmd
         3pzGeRNDq6Q5NMt5KzxlAtF8AwrGCBjNRhtxXXJodl9GZ4c0sPpf9Hvjt0Ui3Ce0Y+LV
         pmeCobxD2OCOBjeJCzMRlwywBspyEHc0r6NloVmOkchK2K5npKIkD2s4PizotnfpruXY
         7F/NX7Xm0Q8/ZY102OE6BVxqXtD4hs3WR26wtRe2Npy5kQlM4d+fTXgPLpR+4qH7bZod
         tNKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1a7S46mgXCuKnRd5PdX0m/bRNgh1wac44gddSPH2LfI=;
        fh=/vxkbvGZTxVRQOVJq+BZE4dFqc2993vqMNjkWGOdE/s=;
        b=RumHfSIsJzphmtqA0iLsrPuCZxmq6hZ+1IJWk0UF7pamXTHIOAiSxCG/ZJJypRWXAe
         3Rk+iMxTCwbw14wocY0zw601Z0N8P5v+u2vwzzW2zHekeEeMj5PSzwqLzkgzwEwXWWGl
         oyMljaoqJLp0FWnyJI6N+CxqdXtI3/CTrfL3LUfV6caOIF/MRHXKTMBx0O99IBLzpiV9
         LWOGuQ+xv7bXMh4jGVyjU7//qMSLXz+8g6PCvp6s1n2dVFfqcRESWkShEIA673KnG2SH
         CDmP2Fsxp53hOtNd7XR+8dQHuh7uqX6mr0H3kgq0bnH6uIPejZ9Ji7fUCwJSqDPdfxfe
         50rA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768957554; x=1769562354; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1a7S46mgXCuKnRd5PdX0m/bRNgh1wac44gddSPH2LfI=;
        b=W42p5o1nHPSQpoaK0IJBSSLyySjXHyKLfNEE5sAViaNnHBk3vt9VUKXezBYP67iBWY
         nmkS//o/6iL9trXQBdvZ99sRwzF6Jo6LWGmvFhIiD6Dy1J12+Ye85UqWbKM8WzCQY8UC
         QOCYFT9o2eOYd/ndoIGB3yIoHc0p+TGcL/Dj8sPkWq24r4VT+iqz1kNscfOi1jKiRGOX
         Xjo8hpNhKD6voa2CeXjr7MuG9RF9ctgJ+nVu+e9QmNEqHMH4IxcGQLERpRhJxM0oKvTP
         FepClyia8+0JetAQalbPs1PtzRXKuWiyJeO+/XWsYY0D757lgkiMm8Jc6fXMvoDH+hO6
         JrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768957554; x=1769562354;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1a7S46mgXCuKnRd5PdX0m/bRNgh1wac44gddSPH2LfI=;
        b=rWY4Ey+T4h8nM+3AVxxaO7ilS+gvcTZVQJ8iP8vbY/q+29IDD/La8niQVLBVmfXdnc
         IzImhypSxOtV4eHWwRAO8QwEobiXza48xkvBn04drxJ3lv7YgbXLEAHU4DNfvwvQlii4
         G0YUc/9HHmhd0TDtxDqdKCl44uHtERhAWYo5pARwn3VS/5ERgLhsexrrPDF9xppu/9av
         tr+7K60gg984RYS8+kGVFDRW90CoyobXaEVaIteruTqt7sAmWP/BzCV4IILjg6VtMFPj
         BassHWW0mmFqeGk44c88+Z3MurNI8VsrpeDbe1kkdva7FgoIcE1qDkkY8KYqKcZ7Meno
         iUcw==
X-Forwarded-Encrypted: i=1; AJvYcCXmD7SmGl1zI7XNe5stoaTQFL9/LX+CyKfWmKadY40GH+86edWR5FfDbZZJLETKHJzZvMA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjUqsO4Ht+VJBe9LLjLyhLuOv/iK6qBW60LFM3KYJeCL73YqPF
	w9yGCXMSI3PXb6Od8scoEXRfm74R8frvXHpLVIGPtiLBrTv0RxYT4dFE98pXZB6LBZg3zx6/DIR
	sBTY3SR453iO5GeV9r8ahu+V9kRIvGQ8=
X-Gm-Gg: AZuq6aLyYpHMQ47iM30zHKep/mMdT3+Y303pJaI1BYbqaP3ghlekzsnnc/BWHzDsVZs
	emZKKMwoL1RG4WQWZmNvGMbpsM2vreqTDR+HGB28EK4QNoBHntb/1AE4VuQMY9wgnYilJ2QEmuA
	Mk5JAmvY9/zyzhxVnbplQpQBPnjed/5J8oPgQfF4UhZIowOLpB5maqs4XlAnqiIHuwOAg3QaS6O
	o8JX5rP8sjhz29hSKE2EPXEoVcIJ4LN3WwDmj+uKoOoPfUfyaGhLw3YexG1+TqeLHVRlkUrs2XH
	NSY+e5fepOg=
X-Received: by 2002:a17:902:e842:b0:2a1:14dd:573 with SMTP id
 d9443c01a7336-2a7698f3e16mr31237755ad.23.1768957554251; Tue, 20 Jan 2026
 17:05:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120070555.233486-1-dongml2@chinatelecom.cn> <20260120070555.233486-3-dongml2@chinatelecom.cn>
In-Reply-To: <20260120070555.233486-3-dongml2@chinatelecom.cn>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 20 Jan 2026 17:05:42 -0800
X-Gm-Features: AZwV_QhHH4eFAffWBHjf2jaxTKvjTuSmLWouBdzaCGqxpzoDbl1L3nV1kK1LavU
Message-ID: <CAEf4BzYzT2OUQ37BvzTRyo5Ah_t_CXv=AJixtAmU_pgr8eLpLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v6 2/2] selftests/bpf: test the jited inline of bpf_get_current_task
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, davem@davemloft.net, dsahern@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev, 
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 19, 2026 at 11:06=E2=80=AFPM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
>
> Add the testcase for the jited inline of bpf_get_current_task().
>
> Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
> ---
> v6:
> * remove unnecessary 'ifdef' and __description
> ---
>  .../selftests/bpf/prog_tests/verifier.c       |  2 ++
>  .../selftests/bpf/progs/verifier_jit_inline.c | 20 +++++++++++++++++++
>  2 files changed, 22 insertions(+)
>  create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline=
.c
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/verifier.c b/tools/te=
sting/selftests/bpf/prog_tests/verifier.c
> index 38c5ba70100c..2ae7b096bd64 100644
> --- a/tools/testing/selftests/bpf/prog_tests/verifier.c
> +++ b/tools/testing/selftests/bpf/prog_tests/verifier.c
> @@ -111,6 +111,7 @@
>  #include "verifier_xdp_direct_packet_access.skel.h"
>  #include "verifier_bits_iter.skel.h"
>  #include "verifier_lsm.skel.h"
> +#include "verifier_jit_inline.skel.h"
>  #include "irq.skel.h"
>
>  #define MAX_ENTRIES 11
> @@ -253,6 +254,7 @@ void test_verifier_bits_iter(void) { RUN(verifier_bit=
s_iter); }
>  void test_verifier_lsm(void)                  { RUN(verifier_lsm); }
>  void test_irq(void)                          { RUN(irq); }
>  void test_verifier_mtu(void)                 { RUN(verifier_mtu); }
> +void test_verifier_jit_inline(void)               { RUN(verifier_jit_inl=
ine); }
>
>  static int init_test_val_map(struct bpf_object *obj, char *map_name)
>  {
> diff --git a/tools/testing/selftests/bpf/progs/verifier_jit_inline.c b/to=
ols/testing/selftests/bpf/progs/verifier_jit_inline.c
> new file mode 100644
> index 000000000000..4ea254063646
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/verifier_jit_inline.c
> @@ -0,0 +1,20 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include "bpf_misc.h"
> +
> +SEC("fentry/bpf_fentry_test1")
> +__success __retval(0)
> +__arch_x86_64
> +__jited("      addq    %gs:{{.*}}, %rax")
> +__arch_arm64
> +__jited("      mrs     x7, SP_EL0")

I was confused to see this, as your patch actually implements inlining
only on x86-64. And then it turned out that on arm64 we inline this in
JIT. But Eduard also noticed that we actually SKIP this test on arm64
because of missing LLVM dependency, so that's not great.

So we should do something about silently skipped tests at least...

> +int inline_bpf_get_current_task(void)
> +{
> +       bpf_get_current_task();
> +
> +       return 0;
> +}
> +
> +char _license[] SEC("license") =3D "GPL";
> --
> 2.52.0
>
