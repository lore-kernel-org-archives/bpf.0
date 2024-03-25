Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07FAD272
	for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388233; cv=none; b=Xvyu+YOkQNlI0IobufNNpherC9GASjxMr5hmzfFmgYH40cjjewn1jgy8V38suAhK5tTieBV/JT2k5IRm5wWwwwVP/KhOeczbNu3pdDKX6wTJ7626DypQBKFdaVsqAyygNnkIj1LK8CM1WwILrie9t8NUdiyLGhd+rnFR31dy+2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388233; c=relaxed/simple;
	bh=dGEH6ynhPNzXD366SZ6UEgZ+XmAaTiHv6IM8eucJA/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEE2aSiUqfqxRAMI5GgQbqEcypm06ds2HxDC8B0uhGfYdy3/7nyjhQsZZgxMhnWaZOHgHmxuCXKzRE1DIZNtBxa3dJzXjfahHf6Ry0/eG15GjS7Oj2ehYYFUADBrCwmKJNBmIpktN/Xex66l/qJI1b6D/E51GgMdE79IG1gGFRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RSc6I876; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSc6I876"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41488e17e1cso6648115e9.0
        for <bpf@vger.kernel.org>; Mon, 25 Mar 2024 10:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711388230; x=1711993030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPre1Nxs7VHxBUWMbZV8gUw3g0sVLsFVu0PpZDCkjP4=;
        b=RSc6I8762v7QTQpBrp92EdL/nKnx3ofD9I/cItwMwt2SjSJvcUArtdJEzB83d7EB4E
         3B5WMuqLE/l9/yAUR4y9CcRo7115qMjFNErATDOCQAbfNwrr+kMBGoC1NjBWikYZqB7K
         2lIgOnEFqsQ/jrTq1R7oRLX/wWPOA3s6Vrp6xKzhWZwH8H/Yh7CRgZcba5PZm/HWAhq+
         bv9T27qEbKFjCu3dba5fls8QRO2if7jqS7qS5n9PENT/R2ehCkDEG0OrrychXkCMjKq0
         KcHILObfKz1bfRCQbsAKtflX71zJ0SOoC0w35pePlUuSU1pPXUDI0s/VunP6PNiB9Bdu
         M0LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711388230; x=1711993030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPre1Nxs7VHxBUWMbZV8gUw3g0sVLsFVu0PpZDCkjP4=;
        b=iAuSPSd4lXHvHYQMV5cfElYkWAeW+MDBIDSxAqT+qQsMiodSxfL85Q14JGNF5WFazH
         cg28vztdiyBATnMX/3+vqUn7yLSGwydsl40f2+Hi1dwlaNfgFLgyQ8/WEWAKDiWWFdJg
         DB2QJz2vT4EzQz3K8Igyy3MfOzZRb9SB0gajrCIKBbbOgCKwOlYwqQ0KruWv0of4Qs3c
         BbDy0bPw0HJbPO9Ax4+7agL8JlW9u6r2B15ojfb+7JbH2c9Ye5wAWfwIEl8zpTC/eaHJ
         82MlZ22D3CfpIJ8kEVVIe2gPWYf+UhbzPpeQQ7DCZeAcVHqfqG218prEfIbXeUR8jdgs
         4A7w==
X-Gm-Message-State: AOJu0YxHUz3Qrkh1ytLpGFqz13/DAnI6iTz2laEUJVptUAJOkYccWfTF
	JmkSFWnHzV4xjPNU20cLcejwmPNeu68m6X6D+eHTN/Cq8xOtQW5VW7UDOE0dsG9tUPOVpactJ2M
	XwDzciuZL11gGyvQ3F4b0qXvydX0=
X-Google-Smtp-Source: AGHT+IFm58Xdl2kJ/G9+geG50Ls1tdgbQ360EOVpcDznu7Ew8NIGJ8icGsLYcPItSa1+RdWL3k5+iPVoGpdotpgeqw8=
X-Received: by 2002:a7b:c347:0:b0:414:7db2:8c04 with SMTP id
 l7-20020a7bc347000000b004147db28c04mr206274wmj.10.1711388229939; Mon, 25 Mar
 2024 10:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240322000041.2919948-1-andrii@kernel.org> <20240322000041.2919948-6-andrii@kernel.org>
In-Reply-To: <20240322000041.2919948-6-andrii@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 25 Mar 2024 10:36:58 -0700
Message-ID: <CAADnVQ+SWwJMtdXj1s1RtzXJfjXU4Y41eNg+xzFXe2-DNUR8Ag@mail.gmail.com>
Subject: Re: [PATCH bpf-next 5/6] bpf: add bpf_test_tp() kfunc triggering tp
 and allowing error injection
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 5:01=E2=80=AFPM Andrii Nakryiko <andrii@kernel.org>=
 wrote:
>
> Add a simple bpf_test_tp() kfunc, available to all program types, that
> is useful for various testing and benchmarking scenarios, as it allows
> to trigger most tracing BPF program types from BPF side, allowing to do
> complex testing and benchmarking scenarios.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---
>  kernel/bpf/bpf_test.h | 34 ++++++++++++++++++++++++++++++++++
>  kernel/bpf/helpers.c  | 13 +++++++++++++
>  2 files changed, 47 insertions(+)
>  create mode 100644 kernel/bpf/bpf_test.h
>
> diff --git a/kernel/bpf/bpf_test.h b/kernel/bpf/bpf_test.h
> new file mode 100644
> index 000000000000..c779927d3574
> --- /dev/null
> +++ b/kernel/bpf/bpf_test.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM bpf_test
> +
> +#if !defined(_TRACE_BPF_TEST_H) || defined(TRACE_HEADER_MULTI_READ)
> +
> +#define _TRACE_BPF_TEST_H
> +
> +#include <linux/tracepoint.h>
> +
> +TRACE_EVENT(bpf_test,
> +
> +       TP_PROTO(int nonce),
> +
> +       TP_ARGS(nonce),
> +
> +       TP_STRUCT__entry(
> +               __field(int, nonce)
> +       ),
> +
> +       TP_fast_assign(
> +               __entry->nonce =3D nonce;
> +       ),
> +
> +       TP_printk("nonce %d", __entry->nonce)
> +);
> +
> +#endif /* _TRACE_BPF_TEST_H */
> +
> +#undef TRACE_INCLUDE_PATH
> +#define TRACE_INCLUDE_PATH .
> +#define TRACE_INCLUDE_FILE bpf_test
> +
> +#include <trace/define_trace.h>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9234174ccb21..67bf9659c447 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -26,6 +26,10 @@
>
>  #include "../../lib/kstrtox.h"
>
> +#define CREATE_TRACE_POINTS
> +#include "bpf_test.h"
> +
> +
>  /* If kernel subsystem is allowing eBPF programs to call this function,
>   * inside its own verifier_ops->get_func_proto() callback it should retu=
rn
>   * bpf_map_lookup_elem_proto, so that verifier can properly check the ar=
guments
> @@ -2549,6 +2553,14 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>         WARN(1, "A call to BPF exception callback should never return\n")=
;
>  }
>
> +__bpf_kfunc int bpf_test_tp(int nonce)
> +{
> +       trace_bpf_test(nonce);
> +
> +       return nonce;
> +}
> +ALLOW_ERROR_INJECTION(bpf_test_tp, ERRNO);

There is a better way with register_btf_fmodret_id_set().
Error injection can be disabled in config.

Also we have two such test funcs already:
bpf_modify_return_test*
and they can be exercised by bpf_prog_test_run_tracing.
Let's make it recognize 'repeat' argument and call
bpf_modify_return_test or 3rd such func multiple times ?
Exercise of test tracepoint can be there as well.
Asking bpf prog to call a kfunc to call a tracepoint
looks like extra hop.
Existing test_run facility should be able to accommodate.

I still don't get it how modifying the kernel is better than
adding all that to a kernel module.
When you want to run bench tool on a different server
you either need to build/copy bpf_testmod or
build/copy the whole kernel.
But fine.
All the test things in net/bpf/test_run.c will stay.
