Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDCE2EC0A4
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 07:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786865832; cv=none; b=jbCFnAf0aM78EditVuxbenabSn8ahOhNb4upqNqrMPfqCBzoB+Z93gAyLHV+jBCJl0Ux7EcnJR+j/1ZwrMY8EjJ9oOB9EspCdXJ5Q5MP5+D+Qp6xHGHaAyOwR8wQfEDTOGXF3XSI1X6E2E2oZkmQVkkzD3zwnaymq7yRaBnj3WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786865832; c=relaxed/simple;
	bh=jPHJXjN4vmn/2WpWsBVJzZDcs7tnclRGBy0vFpXB+H0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FzwmKRiwlZcUkKPZBKTOSULfpdI+sZg2ARgQugQLjWPmkyAM/Dzkn+syhmEp/YNWGYE30CyRFeU6yF4vnrbGhCshcSRi/0J4uXJtNY5ZOlb9HZC71nIzrxwnQdgdaeywQw3sbOdhzpzG3jOwPwMgkLKjGtq85Sv/6PPHaOZ3NYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mrVKr+yq; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mrVKr+yq"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1911038a91.2
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 00:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786865831; x=1787470631; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=p42FHpUneL20s8sK2+GHyUce0yzEn6Z4vHVG2TE7X/w=;
        b=mrVKr+yqCe+vqrt6y3C7NDolEhOMhhDpcTJi3RfY0WlD4d012PNQ5KcDFru5GohpuZ
         GjH2DpLzBhX0dsfg/sTG/p57+jQ7PwVWx36bB94Mkmqe2DPuY1FsR1BYAJ9T1JAJAa9p
         0djt52BQTks5tMa5RjAYXdSrKPvdoUMDB5u2FZvRMTynbWRAMXRdoI/J8wiuIKfWQVSM
         QMGHPD8J0sMRM5zDar5rFSEKJgIvkd8bj5Q/+nLrgiJbi+HcXrWPATwYvsFKhsGjQIib
         rHdlShENpZYQsPU6T1wu9W13oE5RfTokUHhWsEKba7dkvgKNEpJ8MdxQijBSfxWPWQ5g
         1fUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786865831; x=1787470631;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p42FHpUneL20s8sK2+GHyUce0yzEn6Z4vHVG2TE7X/w=;
        b=bhjJ2W9xsrkHzh6y98yaLQIbFJpqm68Y20e+G+44rPWYRjnW5xM8Htr21qyg4et3Sg
         caqUbizC+VVzD9FJ20XPTCZkR6q/BFC9OTtCVdBQHWeTgZf14GIE7kLW8g4cK6zXOYKJ
         J6np9xRhrXPSo6PDjD2anEqe3F0AAJTGVillQcKKa9gB9CDdTy3OTsRkHaVlXsFaGihp
         v+wUWQXzx5bffi0Xg54bYdHSp84kuG7dUcxzBnvUczo5crcfw2gyN7cwvz2M+hKQnuKI
         GbVcCfUZCMdh4RFs2CDe02FlNp/9//HAiSe+UoHnGX5vKylsb8Pb95R8cHBuOnxdiXCJ
         aD5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpfQenvqCPFPxuWVEpeQoWLu5cIHVw5fogS/lIK7QoiCr/LNH/bkoXNu6tBGqhvTykNs8I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiREbMdeSY+J9Om7C5gYGJb5BZx/HBKfN564Lyt3RwqkuBdg9R
	Zvh7Rnr3a9nCPqTSsiftjkOQ6LCFq2CDEBDzPbjKgOkF9JFHST8uLQf5
X-Gm-Gg: AR+sD11KzP2X55H1GGEQ0uYfqKU9gdi09NFdVvNsJrCqrHN2GIFTVO4lZ+SpVVnTyxY
	k4nnq6KhyZeYQF0YQ64uXPoRVPzkUX43h8DEyfgCAW1jmFI8adNPSLRfzqCLiMDT1DdxFUuIyaw
	VggqgPAXL0nWjoAArJmmZaxpstzIM2UE8XlS0q7gFZoMhLyKipoITPnY7GGkgQpuwH4ch4hDQxE
	ETewglO8XxcbC+lQTQozuJgmY3SwNiLNv/2e335GTwgzJNBfFtSN6uJaPHRT1fiC6n6KdUi1Wzb
	ldY6ipVh0DjpApf7oMUP8rIQ8zjCvkbjvpRhoWvcwr0Y50lovHzc0sjZt0g2oReBW7TynNe9kuP
	o6cKjGfI5RuzOiad6XoVUP79YCrYQGjE7LNzTCqKB6Gz9ioVAB3dNYJamzNqodWl66hAdhfC3ig
	ZuLbhyFyififJPyICEGmscPNcCddocWOwyc16+39QpBIAfWiPT3rmFlu08knNx08cuCuzqTRftD
	y2uPkKyxfyCb9L2
X-Received: by 2002:a17:90b:510a:b0:38e:9ef9:eb97 with SMTP id 98e67ed59e1d1-3933ba87422mr18985735a91.16.1786865830930;
        Sun, 16 Aug 2026 00:37:10 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531ee7d46sm839997a91.16.2026.08.16.00.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 00:37:10 -0700 (PDT)
Message-ID: <9d5a272e06491517ed886a416be4d705283b915f.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 09/14] selftests/bpf: Test non-sleepable
 kfunc context
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Sun, 16 Aug 2026 00:37:07 -0700
In-Reply-To: <20260816015746.2632990-10-memxor@gmail.com>
References: <20260816015746.2632990-1-memxor@gmail.com>
	 <20260816015746.2632990-10-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2026-08-16 at 03:57 +0200, Kumar Kartikeya Dwivedi wrote:

...

> --- a/tools/testing/selftests/bpf/progs/preempt_lock.c
> +++ b/tools/testing/selftests/bpf/progs/preempt_lock.c
> @@ -6,6 +6,8 @@
> =C2=A0#include "bpf_experimental.h"
> =C2=A0
> =C2=A0extern int bpf_copy_from_user_str(void *dst, u32 dst__sz, const voi=
d *unsafe_ptr__ign, u64 flags) __weak __ksym;
> +extern void bpf_rcu_read_lock(void) __ksym;
> +extern void bpf_rcu_read_unlock(void) __ksym;
> =C2=A0
> =C2=A0SEC("?tc")
> =C2=A0__failure __msg("BPF_EXIT instruction in main prog cannot be used i=
nside bpf_preempt_disable-ed region")
> @@ -127,6 +129,19 @@ int preempt_sleepable_kfunc(void *ctx)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +SEC("?fentry/" SYS_PREFIX "sys_getpgid")
> +__failure __msg("program must be sleepable to call sleepable kfunc bpf_c=
opy_from_user_str")
> +__msg("cannot be used in non-sleepable program")
> +int non_sleepable_kfunc_in_rcu(void *ctx)
> +{
> +	u32 data;
> +
> +	bpf_rcu_read_lock();
> +	bpf_copy_from_user_str(&data, sizeof(data), NULL, 0);
> +	bpf_rcu_read_unlock();
> +	return 0;
> +}
> +

Tbh, I'd just add two tests: one with a call inside rcu, another from
a program context and match new messages. We are going to switch away
from those anyway.

> =C2=A0int __noinline preempt_global_subprog(void)
> =C2=A0{
> =C2=A0	preempt_balance_subprog();
