Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414D33B27ED
	for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783668352; cv=pass; b=dkvmlpyT/OvQDn/OYqmNKiagYQgsreIFQH4o/xGKMAZYRWFCSP6aC+JN0uLXYfEb5WADQ7dKYskdoKA5xL3vKo1PbhEwrpx9kdEAp+kjt4UxYXG75yK548q8NRBx2F6p6+gKeoNi2GE/kZmzg2L/BkfUILH5PEzq17vxzd2h3YA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783668352; c=relaxed/simple;
	bh=mh9wE6hVtejwpqaCnWH4G3lR/r6ymmL6RvQu7O86Nl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fUvhf8jFakMrds7bvgikrvopO0A/xnmByoe/j2OGMqac8LJSo2peSETB6Gz8hrrDUr2Nu2+CUdFtTHQazgl6S+Tr/umhH16irq7lXlOiGb7y+34yiocBcUZQJ3syxgFnto/MrVmtSM/Sa8+kaeIgBxxWyd+kT0v+HxanNzWKzFY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YBik+sEs; arc=pass smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBik+sEs"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81dfdbd86d1so6226447b3.1
        for <bpf@vger.kernel.org>; Fri, 10 Jul 2026 00:25:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783668350; cv=none;
        d=google.com; s=arc-20260327;
        b=WRS6O8rVXoB0ZBLWM/TJvTHGrcRwJvzd2CD0fv4ItbByS5fLCJsjbxfMAQGR0u8Jtl
         xpdR0YN+IXP/9bJ44LRV0upnZGUiLQhyHC73V+bAOGF4ldQS53yDnRfZ0I/oymjMbTJo
         QhgblNzrt935T1kD/lVAs/AWYVJUvkiLH0quu/5ZVoPbyHRjy8e4ZZEQBJr6mdth32rD
         tPwerSyxs0nqy12wK+s0xffB3SgZXGWU8CbjeImmIFb03OyQZDO/ajpQTjZQz766k8d8
         BO1kjsZYrqeHzJ+aQi8Q8qVST3ZMzPOJ9QOLyM3yg1y+ojjmN7v6hxN0Phqc5bPEisTp
         u1hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mh9wE6hVtejwpqaCnWH4G3lR/r6ymmL6RvQu7O86Nl4=;
        fh=2I4jl2koYt1NlMMq6LugbmD/PErzTQk51NRrWJWV2/I=;
        b=iCgfgmcbi4K+fGCPpzYz22SGLyCVdxOb4v/JOnjpK2Yf9kYjdLIE23Rlg0daWbimDl
         MjQIox2RO8g67/RphDP81Z9XOsiM6ElI12UsKxmfqd/14fJ0071QAx7t0XpcZW/BJSgu
         QKYtQ3OhGwgJBoXL/QPIY/CA6et5lzc2T4nJLo+QUHlAaReNkMEmlj0xu9aJbprwuWfq
         nwa1xSmSXRrOK7Q+jyH0HRDlq2uaRyYm8VzvU0WwC1p9FmLeXREd5wafZkEKQnpMyelY
         ntANojJAHEMGJOY/CE7d4Z5kKYaPAIc8xYtPbeNtawis3A3sEcvN1Te10wa/tQc3hhcm
         7lrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783668350; x=1784273150; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mh9wE6hVtejwpqaCnWH4G3lR/r6ymmL6RvQu7O86Nl4=;
        b=YBik+sEsrE3WCU+KxB991u6zQ72Ve6Fdhzdj0CsaZBArzOQfDRclZo3wYYRE8NyAmD
         pMFP5wxMO38WJaI+XeVlta3Wj0axrJ97Rq02PXGobb2Rp6qNY/pJZQtNg++JaqiUZE0y
         7lerNZCc/aDCDfntKC3xLOeEFojhfBscH9+5c2RhAD+QN/Ba9LgblK8sQx0AL9AMqoQ7
         g2xEc8jnr4tbrsDvMG4ns2Qw3l0io2xZ4AZQgZ/xRRIgXvRXrz2jHA9EE1i2UdhbXWVS
         arQIsZhmwOYEnCOuvWXF00xcXcFbI0+3q+/F9GtN2MqwqbsTKZ7xrU1j2sY/jNb4ggvK
         Muxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783668350; x=1784273150;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mh9wE6hVtejwpqaCnWH4G3lR/r6ymmL6RvQu7O86Nl4=;
        b=p/6oBKAPXHqMAz7zvr3eGqStaBGIx11pTtKCpB/R2mGLi/VgPTAxAT4EU/8zzlwsb4
         PKOCsF16Uq1hjvxgLj0hJU8AcbReYSFlzsVhR7DZlAm0uE6HLPMtapi53Lkj3LHUMWGU
         TruvEcw4gRntKDJCWH0ph2cBr+uxW3JT5DlG2+wcHOJGNYK0z+/NzMt5d/H3Tk7a8hgQ
         zzwyMcwthBaHqqbjLVLdlzZV8fZxfzw2n4+15BwyCSurGcXotmMrLOj8LJOQxQJnbrQk
         4xFwYUn6+3NQyMejSgJ7X2nFj3lsI006KMxdYkXfOnIzWbJZXvG4b9Y77YaCZIxaQ1B6
         fIWA==
X-Forwarded-Encrypted: i=1; AHgh+Rps8DXN7mKOsrHOWFBBPFJAyQFHyE2YBJm19NCpepTQeek7hDHeMBMhBZFmBL5+mlpXAUE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPAKfBgWGWB0VQrBVRGMv2a7mlVQBqj+MTlduBL9suJjbVA+R7
	Iwy9eWREBAdO3OUxgwqxXesKENFFqYisaB2eD2xlcEhhWf7N7lBgww8nOiqSbeLWSNN7Y0cntzu
	jrzBVfgI+0LJunEcppiaWLpD8BZxhZlc=
X-Gm-Gg: AfdE7cnfpd4s8TjhepyRR43SULJqAt47XmuZGCDCxsFaFS+0RkJr0u/6q6u4/gTUdRM
	qvAd0JlaEmJkcoz5fV4dUhTTby97OFFAtB78p0hUqrHIRncu7XzY79CYnBQLiJb81JaAT23WJ4b
	gbQSOj0FlBFQ/1FeUABK2EhuIscBDMRaoINPMYmRvI5lS7Ytm3sKkG5bRT0AaYZcGXwryKEKvJY
	Y84kWf41VPvdc7cJ7rLQm47wCtNVzit9B2NRwbRpciBhT1DRj2AZdwc5Kar+jqwKfctmdisgNV1
	6jX0BXO70XbFs9A680oXYXbMsjenFWA2GL4uDVCF
X-Received: by 2002:a05:690c:650e:b0:81e:7034:2ec7 with SMTP id
 00721157ae682-81e70343a1bmr37581077b3.50.1783668350063; Fri, 10 Jul 2026
 00:25:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708090151.151729-1-sun.jian.kdev@gmail.com>
 <20260708090151.151729-2-sun.jian.kdev@gmail.com> <ak5HLLrYK3R_g2y_@u94a>
 <CABFUUZHpPwuTk69hb54WugJwssFuvoqFFPv34dZRbKLLc1PwwQ@mail.gmail.com>
 <ak8XSRiLKx5WcIQw@u94a> <1f8aad47f61fbf85eb55276e4bb01bfcff61393e.camel@gmail.com>
 <CABFUUZEXYduca34g22YZ1ESyYe3Yc3kYQrTEWLMxB5X0ZmYn8w@mail.gmail.com> <4349d987d34f9426bdbb09a5d02de61da8f3e746.camel@gmail.com>
In-Reply-To: <4349d987d34f9426bdbb09a5d02de61da8f3e746.camel@gmail.com>
From: sun jian <sun.jian.kdev@gmail.com>
Date: Fri, 10 Jul 2026 15:25:38 +0800
X-Gm-Features: AVVi8CdDId0qAQuJjxIMlDaRDt9TMr1o0P2SW2pz0fSqjQyJjET2634wzxh5uAc
Message-ID: <CABFUUZEropo5ROshFt+mD+AtF_6VRGcyaOES-wUjasL5J2W4eQ@mail.gmail.com>
Subject: Re: [PATCH bpf v4 1/2] bpf: Reject negative const offsets for buffer pointers
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Shung-Hsi Yu <shung-hsi.yu@suse.com>, bpf@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, john.fastabend@gmail.com, andrii@kernel.org, 
	memxor@gmail.com, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com, 
	shuah@kernel.org, mmullins@fb.com, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 10, 2026 at 2:23=E2=80=AFPM Eduard Zingerman <eddyz87@gmail.com=
> wrote:
>
> On Fri, 2026-07-10 at 13:52 +0800, sun jian wrote:
>
> [...]
>
> > There is an observable effect on the target bpf base. I tested it with =
a
> > temporary raw_tp writable test_run reproducer, not part of the series. =
It
> > attaches a raw_tp writable program to bpf_test_finish and triggers it
> > through BPF_PROG_TEST_RUN. The program does:
> >
> > r6 =3D *(u64 *)(r1 + 0)
> > r6 +=3D -8
> > *(u64 *)(r6 + 0) =3D 0
> >
> > With KASAN enabled and the BPF JIT disabled, on the bpf base without th=
e
> > verifier fix, the program loads, attaches, executes, and KASAN reports:
>
> Could you please identify why the behaviour differs between bpf and bpf-n=
ext?

I checked the current bpf-next, but I could not reproduce the difference.

Both the public cgit page and my local bpf-next/master and bpf-next/for-nex=
t
point to:
a4553044d1af ("Merge branch 'bpf-bound-rdonly-rdwr_buf_size-kfunc-return-si=
ze'")

I tested that tree with only the selftest patch applied. The staged diff
only contains:

tools/testing/selftests/bpf/prog_tests/raw_tp_writable_reject_nbd_invalid.c
tools/testing/selftests/bpf/progs/verifier_raw_tp_writable.c

The negative const-offset case is still accepted at load time:

#637/2 verifier_raw_tp_writable/raw_tracepoint_writable: reject
negative const offset:FAIL
run_subtest:FAIL:unexpected_load_success unexpected success: 0

and the verifier log only shows:

processed 4 insns (limit 1000000) max_states_per_insn 0 total_states 0
peak_states 0 mark_read 0

The current __check_buffer_access() in that tree still only rejects a
negative instruction offset and a non-constant var_off. It does not check
the folded effective offset, so this case still has off=3D0 and var_off=3D-=
8 and
is accepted.

So, at least on a4553044d1af, I do not see bpf-next rejecting this case. If
you have a bpf-next commit or verifier log where this case is rejected, I'd
be glad to take a look and reconcile; I may well be missing something in my
setup.

Thanks,
Sun Jian
>
> [...]
