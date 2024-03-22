Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4620DDB
	for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711113171; cv=none; b=U8QcAcg8gEY2Gy6XxnCB+6LB+F9O3aJjz6zljRV8AmqmnZYbNHF0EkVtjtiDAyVvRit2YK7d+HrGyAEInoGZOL9bd6Yi7jkBg3wOpuZvwJw/K9V/fDJb6KLom69crArLijdeVKUhxxcsTVPx8AsFZREoLfcjbvlfY8DZlZtwsEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711113171; c=relaxed/simple;
	bh=7uF7abAvXl+HbMzbfFgPd7Jwydg482Hw/LY69nRzkOc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iCDEhYPrrxtClniGBxa2ApHDq6w+mRRHYlAjYOViRW0W0qi1HCVAxdpdx6hC8ZRcf4nskSeE2A71nUxCHR5hG5J2MSxwLFBnG7+SLpLUJG1fhCGXFgeLypljDM5X7rAzbOlJvVsdU+1a3zuq2BP6c3xfEZwx75xGx9XpuYIxGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjulQIgD; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjulQIgD"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-341808b6217so1188580f8f.3
        for <bpf@vger.kernel.org>; Fri, 22 Mar 2024 06:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711113168; x=1711717968; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E+KyyORmP+hR8/apWlN0TyNMOKHdA/Q0YcHGzlW0pgY=;
        b=MjulQIgDoC7uVfnsmBqxqH5YbFmWphKYUdbqjz1nZarp2qGUhpQNbA9DwwrB9xlnko
         3Q6/x9fq8RypwWNYNILfsUOdpqqtj2TsAX96fz6Vlcoe+IJlsSNg97z7/OqcOEH7Zc6P
         THegxQnhSJwr8c/XqiWRUqpWcaBFy5GaOdDzMiFCakHyfzELv0lI8hOQinOw1Gvd5Cig
         pY7sxVQEyfoFmr/tvUsyGmZBREOE2zZWNqsxDu5PdbFcLE4+Yn7NzvLunAmkrtvaKQsK
         ZMNSGhifXbSo/Z2M+B+WPeq8dFf6i3fvoX0ttkEf2jF+x3ie335pfB3b6xtJImw0Hovm
         bawQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711113168; x=1711717968;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E+KyyORmP+hR8/apWlN0TyNMOKHdA/Q0YcHGzlW0pgY=;
        b=qKjzOIlXvGuWbZ6Zf7lDmjbZAdhAFgFxKfHWQ9wmuVTkcecVBuwjpatzNkiLgEDEK8
         IT/uQIgZFwBxZiCciyUvDtFkRgV+sQDzUPeqtBpkhW7wMrV+m0R7ErK4+ma0hJwyAEQm
         JCrQO3vIpls3lXCIg9BOUVHMf5vP8IPB+gUB6Q55l+hvhhVBLnhyHk7+80311EYeNbW8
         0rVU29s2DiZv1g/effjMw9BC4oWIi/+2v3s4EsgXPJ2X223RGpzCUR8AxHGegnMLGsr/
         hA9jyIkRPt2BMXDXmVoStxAMWOPHbj/kTuHAJOJ5Iaxjd+HVFn1Ub6UO/HmEraE1BWQY
         FmyA==
X-Gm-Message-State: AOJu0YxjMbRVC3hiXjZg/ijTQ+rzgBOBImeTYS06pv+86kisfKsv2oCa
	PJoSpVH78l2LRydE8uAtcySEwuubAxfuIhnGj1f47ImfOJg6GOgdgwbZ8lsE
X-Google-Smtp-Source: AGHT+IE8rKbHiabcDD0P6E3ZWirnxWd7ppzr8f4GbTor47vvA57hTY+G641C7g6MV0v50pKmkzdQAA==
X-Received: by 2002:a05:6000:ec6:b0:33e:7b3d:8efa with SMTP id ea6-20020a0560000ec600b0033e7b3d8efamr1580515wrb.49.1711113167711;
        Fri, 22 Mar 2024 06:12:47 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id v22-20020adf8b56000000b0033e22a7b3f8sm2068117wra.75.2024.03.22.06.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 06:12:47 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 22 Mar 2024 14:12:45 +0100
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@kernel.org, kernel-team@meta.com
Subject: Re: [PATCH bpf-next 5/6] bpf: add bpf_test_tp() kfunc triggering tp
 and allowing error injection
Message-ID: <Zf2DzQmhI2e8UGrx@krava>
References: <20240322000041.2919948-1-andrii@kernel.org>
 <20240322000041.2919948-6-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322000041.2919948-6-andrii@kernel.org>

On Thu, Mar 21, 2024 at 05:00:40PM -0700, Andrii Nakryiko wrote:
> Add a simple bpf_test_tp() kfunc, available to all program types, that
> is useful for various testing and benchmarking scenarios, as it allows
> to trigger most tracing BPF program types from BPF side, allowing to do
> complex testing and benchmarking scenarios.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

I'm getting compilation fail with this one:

  INSTALL libsubcmd_headers
  INSTALL libsubcmd_headers
  CALL    scripts/checksyscalls.sh
  CC      kernel/bpf/helpers.o
In file included from kernel/bpf/bpf_test.h:34,
                 from kernel/bpf/helpers.c:30:
./include/trace/define_trace.h:95:42: fatal error: ./bpf_test.h: No such file or directory
   95 | #include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
      |                                          ^

jirka

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
> +	TP_PROTO(int nonce),
> +
> +	TP_ARGS(nonce),
> +
> +	TP_STRUCT__entry(
> +		__field(int, nonce)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->nonce = nonce;
> +	),
> +
> +	TP_printk("nonce %d", __entry->nonce)
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
>   * inside its own verifier_ops->get_func_proto() callback it should return
>   * bpf_map_lookup_elem_proto, so that verifier can properly check the arguments
> @@ -2549,6 +2553,14 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>  	WARN(1, "A call to BPF exception callback should never return\n");
>  }
>  
> +__bpf_kfunc int bpf_test_tp(int nonce)
> +{
> +	trace_bpf_test(nonce);
> +
> +	return nonce;
> +}
> +ALLOW_ERROR_INJECTION(bpf_test_tp, ERRNO);
> +
>  __bpf_kfunc_end_defs();
>  
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -2625,6 +2637,7 @@ BTF_ID_FLAGS(func, bpf_dynptr_is_null)
>  BTF_ID_FLAGS(func, bpf_dynptr_is_rdonly)
>  BTF_ID_FLAGS(func, bpf_dynptr_size)
>  BTF_ID_FLAGS(func, bpf_dynptr_clone)
> +BTF_ID_FLAGS(func, bpf_test_tp)
>  BTF_KFUNCS_END(common_btf_ids)
>  
>  static const struct btf_kfunc_id_set common_kfunc_set = {
> -- 
> 2.43.0
> 
> 
