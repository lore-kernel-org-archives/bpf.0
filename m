Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3FDF7260F
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 23:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782172026; cv=none; b=KbVTkB5sGLPcaxnF3Y5F4jwtUIqJZhWQgshiSWRRgWsHOpctZmipr5JLbmXe5iMzBbfB7D1DfOCkGgSQZhKVfTdc7DGWssYrIIzakWdZjzw3sq8aD6BdTWB3tV1v+Udsgs9a3v+lkmXJBEVqM0gx4JbQ8Z5iJ3fT9H9G6BD4F6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782172026; c=relaxed/simple;
	bh=nTohXCT2pw1rexM/JHYpmf5DhqpsHocVswUcs8M8ZoY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hc6gFpyJylZ6zIeCvNuYDGabO8C1d6ICqTgKarzc1KXoknU2ZhCGf0gWTs2/FWfcAnz98Z7FgYGBbMFtCKcPAioDBKmp86S99d4SkuA5rVf6KMQcmccdYpmVUtfIq8N3IsTG6oguFBDRGJZ4QhMN67+Wj6nC7zQFYRDjc3vXj/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m5UIGLqu; arc=none smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m5UIGLqu"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30c52f96f60so1299497eec.1
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 16:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782172024; x=1782776824; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=es7XTptiI09gd7CcGJvznBy6A35Oho4vTeoHFdeWRVo=;
        b=m5UIGLqu4atU7AHbdT8X+D7N7VeqRWQIY4hYLvPbLRJZNssOp0eXdEdrgY9IVEXamY
         IJcN0BgNzWD3UWat8DmqOU8/KzL/OxH0+2jigT1kBaSvxWExsrBDjBlmJyRTtyFdMyXt
         sJnckXVTOkX88OPbGsGWqMg/v8nWAIZMb/cbRAGAfFNXLyg+J3NMmWsp6otWdafZfi+c
         x4agRkUk5BDcx+wQIJ85v6J2aIQl1bkfmJM6mFh4xWIlGYHVt+/wL0XLOtGyMHxpTFrS
         r2sVFBDYjvPzdzzSULV1ai05YD/rib7p6gGcKc9XKI07ICUwU0mi59fUZFGJOGkFcFpn
         v9zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782172024; x=1782776824;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=es7XTptiI09gd7CcGJvznBy6A35Oho4vTeoHFdeWRVo=;
        b=ekp525ddynh2bmLa7kfkGH/olJL4E59IPiVM4JCI2OBLZs2GFmQ6Me8sKtiLhAYjFK
         OLy+ggXFRqdO6Xfe1NvksQ+NZie7kZ6FL1m0l8QmPynWdh9AuBN3fhoJDLfhKdtdKDrE
         3Yc3S2sSBXeWq6qIKgg2VnS13irclDe3+pzqidwcwzQ2n6hdT/ga1DNWZAlg9s3WZUaM
         YVJmHmkPX4mZGILFkeHM6N4h1v8ybLFOjleBSiWcAO9A+IqeMzR2IuLPMsxrcTBN/v0F
         UrDtm7g3FbfNm3bWNbiB8bgfjhZ7yc5cwfBr5RQz4dmZqf8XefS/OQUAJYERZkpY5eiX
         wTMg==
X-Forwarded-Encrypted: i=1; AHgh+RqxxQjHJI+IczOy6r1clZfWp3mX4/sy6ADwDBlqOS1WD2AvAvttJkOhrAkshMXQiM0pP7Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOkK4OI3U2uW0f0Pa6siK9U+DzdCoAkYWrRh8+C8141a3nAey
	UzEfWGETbWOzwMgxo2FWLWTagYRkosurk6Wd+Rgv0oHew+Dmn87A9T6R
X-Gm-Gg: AfdE7clZRKFr02FBSPUGLilWAUER4n9hGlCjM2msVU13suWLEi3VZBvArATiQgWYUWo
	CKm2nbYCB6hcwSU0Zg/GlGglPvDo5LdYd5FJmKyTt2QTlqk/iGTKizXihdZ1KAEVIlWSap4ehct
	BDUxkZJfQ6AlRUJ/+z/WCSwO/JH8F9+zR0JhbAzqTzoc/WruIy0NWf8ElxFSC3NLDiujWl+cdoP
	v3Vu8XX3doQccnPQXGRjiyL473vtrsp6RE6G3JWQaVM42tvzo90HMzjpegGacSQB/FXtwYs2ENS
	5lqDgPbhiVtL7rBoGkZUcKrLx/L+0dlxC2p7Qt/IgVPHcWH8iel/VfXkBW+SCdpXlCsjwOCl8bk
	cAv967ryl2Nzay2OIlJ09+4Yz+B3R+fY1heOdYx3DCNFIqyTq7QL4r7ZEtl5m+A2glUbKuFY3XS
	bAiSep9dxxKXp3hS11WvtqbFdF8aQPBBd9fx1vuVBxVHj6I56vxt4+i1OAC3ims2n6FQQUhA==
X-Received: by 2002:a05:7300:641b:b0:30b:b65d:ef87 with SMTP id 5a478bee46e88-30c1d9c69femr9077838eec.9.1782172023768;
        Mon, 22 Jun 2026 16:47:03 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:c4f4:7a34:78e2:a600? ([2620:10d:c090:500::2:e8d1])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c1bd8d799sm11577221eec.19.2026.06.22.16.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 16:47:03 -0700 (PDT)
Message-ID: <d2acc2bf23e00ad30a7e14bf127e1cffd9b7ab34.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 01/17] bpf: Add verifier diagnostics report
 helpers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Mon, 22 Jun 2026 16:47:01 -0700
In-Reply-To: <20260619205934.1312876-2-memxor@gmail.com>
References: <20260619205934.1312876-1-memxor@gmail.com>
	 <20260619205934.1312876-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-19 at 22:59 +0200, Kumar Kartikeya Dwivedi wrote:
> Add a small diagnostics renderer for verifier reports and wire it into th=
e
> BPF build. The initial helpers emit the common text structure: a failure
> header plus reusable report sections.
>=20
> Wrap report prose at 100 columns so Reason and Suggestion text stays read=
able
> without changing source or instruction gutters. Keep reusable formatting
> scratch storage in the environment-owned diagnostics object.
>=20
> Gate the helpers on normal verifier log output from the start, so
> BPF_LOG_STATS-only loads do not collect or render diagnostics.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

[...]

> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> new file mode 100644
> index 000000000000..a18fd5aa395d
> --- /dev/null
> +++ b/kernel/bpf/diagnostics.c
> @@ -0,0 +1,170 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> +
> +#include <linux/bpf_verifier.h>
> +#include <linux/ctype.h>
> +#include <linux/slab.h>
> +#include <linux/stdarg.h>
> +#include <linux/string.h>
> +
> +#include "diagnostics.h"
> +
> +#define BPF_DIAG_CATEGORY_MEMORY_SAFETY "Memory Safety"
> +#define BPF_DIAG_CATEGORY_REGISTER_TYPE_SAFETY "Register Type Safety"
> +#define BPF_DIAG_CATEGORY_CALL_TYPE_SAFETY "Call Type Safety"
> +#define BPF_DIAG_CATEGORY_RESOURCE_LIFETIME_SAFETY "Resource Lifetime Sa=
fety"
> +#define BPF_DIAG_CATEGORY_EXECUTION_CONTEXT_SAFETY "Execution Context Sa=
fety"
> +#define BPF_DIAG_CATEGORY_PROGRAM_STRUCTURE "Program Structure"
> +#define BPF_DIAG_CATEGORY_POLICY "Policy"
> +#define BPF_DIAG_CATEGORY_VERIFIER_LIMIT "Verifier Limit"
> +#define BPF_DIAG_CATEGORY_VERIFIER_INTERNAL_ERROR "Verifier Internal Err=
or"

Nit: since these identifiers are private to this file it should be ok
     to drop the BPF_DIAG_CATEGORY_ prefix.

[...]

> +static void bpf_diag_print_wrapped_prefixed(struct bpf_verifier_env *env=
,
> +					    const char *first_prefix,
> +					    const char *next_prefix,
> +					    const char *text)
> +{
> +	const char *prefix =3D first_prefix;
> +
> +	while (*text) {
> +		const char *line =3D text;
> +		int prefix_len =3D strlen(prefix);
> +		int text_width =3D BPF_DIAG_TEXT_WIDTH - prefix_len;
> +		int len =3D 0, last_space =3D -1;
> +
> +		if (text_width < 1)
> +			text_width =3D 1;
> +
> +		while (line[len] && line[len] !=3D '\n' && len < text_width) {
> +			if (line[len] =3D=3D ' ')
> +				last_space =3D len;
> +			len++;
> +		}
> +
> +		if (line[len] && line[len] !=3D '\n' && line[len] !=3D ' ' &&
> +		    last_space > 0)

Nit: line length limit is 100 (multiple occasions).

> +			len =3D last_space;
> +
> +		bpf_diag_log(env, "%s%.*s\n", prefix, len, line);
> +
> +		text =3D line + len;
> +		while (*text =3D=3D ' ')
> +			text++;
> +		if (*text =3D=3D '\n')
> +			text++;
> +
> +		prefix =3D next_prefix;
> +	}
> +}

[...]

> +static void bpf_diag_vprint_indented(struct bpf_verifier_env *env,
> +				     const char *fmt, va_list args)
> +{
> +	char *buf;
> +
> +	if (!bpf_diag_enabled(env))
> +		return;
> +
> +	buf =3D kvasprintf(GFP_KERNEL_ACCOUNT, fmt, args);
              ^^^^^^^^^^
              neat, I didn't know such thing exists.

> +	if (!buf) {
> +		bpf_diag_log(env, "%s<failed to allocate diagnostic text>\n",
> +			     BPF_DIAG_TEXT_INDENT);
> +		return;
> +	}
> +
> +	bpf_diag_print_wrapped_text(env, buf);
> +	kfree(buf);
> +}

[...]
