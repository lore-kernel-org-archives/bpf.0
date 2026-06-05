Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B8E3FBB69
	for <bpf@vger.kernel.org>; Fri,  5 Jun 2026 18:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780685918; cv=none; b=qJKFKpO2cXgqpvKE0VrD+0q0tTMtplex6gwWs6rt5AioSWiyOsDd5DAHlIs4iyiY+tc5m8ADLMt9NK0C28ngBmc9RfquANUCZcJingrzi1fHV+dOr9r6TDjh9QLOTEhem7jyOHmVr7NtZQ+fFKk1eHjZEs1I3IP9mEAhFd1OlGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780685918; c=relaxed/simple;
	bh=QRTO/ds3X19THFXMt/1wBmzXJpE6TFgNc2tZvqUGBuM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OzPXfv/kwW/oV4Vny0gpfnBmVU8y7QyIvLWxe6ItBcFK7cKVjkm/wWrtnYzkRQenZdo8ccs/taTprZrAA9ih48Boa6dbyhVwn06tQrJovWi1xdIl6ebbBNQe9t0mmhJGynCnymOIYcPfTLTB8xZgdbsf04z3E/L9iLmWukNMO+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQIKirGv; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQIKirGv"
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-304f0039c02so3925570eec.1
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 11:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780685907; x=1781290707; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ID3M+t0DZEUr7RcxSqu9QkyNxH6bBZKOIOfWlezxanY=;
        b=pQIKirGvg37Mg7bacD5nPqP0KVIdlB+AQZvSZ9IavxskXTJEaKDhLtRGmXl1lPIk2y
         sInMKdWw7JZV91I81IQ4TcJKayQPo4K1p31OvaLLuLDRfX6viN1cgT8rp2eyQjlVuXEZ
         4TYCk/Nq8VHVZfLWFGO+0jcg4EkwcFDVGdVuZN+TuoXfo1JRW+GP0tcktvUMRtNndYEX
         IZBmPXE3Jo0aXXLcdfOx3C0v0bgTXgoS+cNG8RChFNaz1KntourawyTEK5E7yEneedAJ
         D1jvBq/nEDxpPoxadGPPOIKMOvYdrQvf0weHFlqgFdCUy+DD/tv86f6G8GnopEwXXUWw
         W9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780685907; x=1781290707;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ID3M+t0DZEUr7RcxSqu9QkyNxH6bBZKOIOfWlezxanY=;
        b=k25IXSoCHyNdHO21xkUKe6mHpH3jAl6/lRc7IXzfdhMpUAXPcBRt8vdYCnUuMDRD5A
         4dTi/kyyA7D1O1iGx8CqCiytBuMuUi+tBnctltCBpRkI4/St1FxBbY9pPz/SHvtH7viv
         vqPiO6YP8qcCPz6BHYE8LpRncUmFTyOjlXLEAw9jTApNJ1I8dgjQusSVC8l9KKnjYU6J
         X5Vev5kYb7XIDPDLqdLCVByrqs+scNi1oFt9inOOJZnvGqz0BY0Orq9mmdlGYtkyENZA
         wIbsFqnoyw/D3Ly39qEaHDg7gJmL097qYyZyGdktDn/lP8iBvRkzsGLaD4vWN/fDxcWA
         Qaiw==
X-Forwarded-Encrypted: i=1; AFNElJ/XletZB+56vylKEOZa8c7xlG2RQQuKVqavfg0g8XUXmNicT8XbJ36qWHjgnGYy8jLfxCQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUJl3ngwrNoxsbHJowa1/0+T0GS5BOEjSq/O6RFr9+1SgScmrO
	E14JfW1l1kIlgNf5Uc8OoyfgP++bosOFFq17mHqtbrv5qgXoIM/qz74P
X-Gm-Gg: Acq92OGCBW5zP7mipGFkzy7kc9fFbjA2moViwHTJd+nIQ+fuHDzWDZWII5w6+033aZ0
	7chOuqrI2VGjwsFAxoB0WcgSU+rcsEvMbAKtB4GMOSkUrs8HOlW2C0GRO97X/odzNp2P/ZSLiRW
	KUxSRZR0Jgk57u9U2wvloEQV2L+SLELmE4UHc6ke7f0nYW2I4N6soUWrYrRoLqrJPEJ8SfCGoSD
	MBulSQ0gQzbearenrOzdBLD6vjBZmhee8zB9p2ef9lVm85DB/XJhHDVvxMc6/V6WoNqeC3ty4Kv
	sucnlShaePuLwkJJelG0J0ymhIXd1XLOa9rR6bVesrbxTLgFgclRn7tQzoBn2Ga9bbpi2WZjAD/
	O3HgqleoqdxzXkHqeprnDS1zqvaKvb1JVhnbj+oRZPvLj/xQjTRQjbc4lSLm03rkGJO7SfCxdhw
	SALAk76cbJ0oF76VgdAh1KVrd4BrvHfCXS9MSV0LO49fRsQnedyj1Gd9UG4Lv6adZszHklb5y0l
	+X4oDj5x6hFmc0bXGvNvCxUOqfn
X-Received: by 2002:a05:7301:1e84:b0:304:c520:4e0c with SMTP id 5a478bee46e88-3077b2707b0mr2532486eec.6.1780685907131;
        Fri, 05 Jun 2026 11:58:27 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:de9b:77c7:f63f:9d5? ([2620:10d:c090:500::1:feb2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3078c1ac378sm871731eec.1.2026.06.05.11.58.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:58:26 -0700 (PDT)
Message-ID: <86463af46333247cbce1c6e5b69ebf0748bcfda5.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 01/17] bpf: Add verifier diagnostics report
 helpers
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>, Emil
 Tsalapatis <emil@etsalapatis.com>, kkd@meta.com, kernel-team@meta.com
Date: Fri, 05 Jun 2026 11:58:24 -0700
In-Reply-To: <20260605063412.974640-2-memxor@gmail.com>
References: <20260605063412.974640-1-memxor@gmail.com>
	 <20260605063412.974640-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 08:33 +0200, Kumar Kartikeya Dwivedi wrote:
> Add a small diagnostics renderer for verifier reports and wire it into th=
e
> BPF build. The initial helpers emit the common text structure: a failure
> header plus reusable report sections.
>=20
> Wrap report prose at 120 columns so Reason and Suggestion text stays read=
able
> without changing source or instruction gutters.
>=20
> No verifier call sites use the helpers yet, so existing verifier output
> is unchanged.
>=20
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  kernel/bpf/Makefile      |   2 +-
>  kernel/bpf/diagnostics.c | 110 +++++++++++++++++++++++++++++++++++++++
>  kernel/bpf/diagnostics.h |  19 +++++++
>  3 files changed, 130 insertions(+), 1 deletion(-)
>  create mode 100644 kernel/bpf/diagnostics.c
>  create mode 100644 kernel/bpf/diagnostics.h
>=20
> diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
> index 4dc41bf5780c..90255d80e5be 100644
> --- a/kernel/bpf/Makefile
> +++ b/kernel/bpf/Makefile
> @@ -6,7 +6,7 @@ cflags-nogcse-$(CONFIG_X86)$(CONFIG_CC_IS_GCC) :=3D -fno-=
gcse
>  endif
>  CFLAGS_core.o +=3D -Wno-override-init $(cflags-nogcse-yy)
> =20
> -obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o cnum.o log.o token.o liveness.o const_fold.o
> +obj-$(CONFIG_BPF_SYSCALL) +=3D syscall.o verifier.o inode.o helpers.o tn=
um.o cnum.o log.o token.o liveness.o const_fold.o diagnostics.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D bpf_iter.o map_iter.o task_iter.o prog_it=
er.o link_iter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D hashtab.o arraymap.o percpu_freelist.o bp=
f_lru_list.o lpm_trie.o map_in_map.o bloom_filter.o
>  obj-$(CONFIG_BPF_SYSCALL) +=3D local_storage.o queue_stack_maps.o ringbu=
f.o bpf_insn_array.o
> diff --git a/kernel/bpf/diagnostics.c b/kernel/bpf/diagnostics.c
> new file mode 100644
> index 000000000000..a6684adc0c31
> --- /dev/null
> +++ b/kernel/bpf/diagnostics.c
> @@ -0,0 +1,110 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> +
> +#include <linux/bpf_verifier.h>
> +#include <linux/stdarg.h>
> +#include <linux/string.h>
> +
> +#include "diagnostics.h"
> +
> +#define verbose(env, fmt, args...) bpf_verifier_log_write(env, fmt, ##ar=
gs)
> +#define BPF_DIAG_TEXT_WIDTH 120
> +#define BPF_DIAG_TEXT_INDENT "  "
> +#define BPF_DIAG_MSG_LEN 512
> +
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
> +		if (line[len] && line[len] !=3D '\n' && last_space > 0)
> +			len =3D last_space;

Nit: len =3D min(strnchr(line, text_width, '\n'), strnchr(line, text_width,=
 ' '));

> +
> +		verbose(env, "%s%.*s\n", prefix, len, line);
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
> +
> +static void bpf_diag_print_wrapped_text(struct bpf_verifier_env *env,
> +					const char *text)
> +{
> +	bpf_diag_print_wrapped_prefixed(env, BPF_DIAG_TEXT_INDENT,
> +					BPF_DIAG_TEXT_INDENT, text);

Nit: line length limit is 100.

> +}
> +
> +static void bpf_diag_vprint_indented(struct bpf_verifier_env *env,
> +				     const char *fmt, va_list args)
> +{
> +	char buf[1024];

Nit: big buffers should be in the bpf_verifier_env.

> +
> +	if (!bpf_verifier_log_needed(&env->log))
> +		return;
> +
> +	vscnprintf(buf, sizeof(buf), fmt, args);
> +	bpf_diag_print_wrapped_text(env, buf);
> +}
> +
> +void bpf_diag_report_header(struct bpf_verifier_env *env,
> +			    const char *category, const char *problem)
> +{
> +	char problem_buf[BPF_DIAG_MSG_LEN];
> +
> +	strscpy(problem_buf, problem ?: "", sizeof(problem_buf));
> +	if (problem_buf[0] >=3D 'a' && problem_buf[0] <=3D 'z')
> +		problem_buf[0] +=3D 'A' - 'a';

Nit: ctype.h:toupper()

> +
> +	verbose(env, "\nVerification failed: %s: %s\n", category,
> +		problem_buf);
> +}
> +
> +void bpf_diag_report_reason(struct bpf_verifier_env *env, const char *fm=
t, ...)

Nit: can be static, same for bpf_diag_report_section() and bpf_diag_report_=
suggestion().

> +{
> +	va_list args;
> +
> +	bpf_diag_report_section(env, "Reason");
> +
> +	va_start(args, fmt);
> +	bpf_diag_vprint_indented(env, fmt, args);
> +	va_end(args);
> +}
> +
> +void bpf_diag_report_section(struct bpf_verifier_env *env, const char *t=
itle)
> +{
> +	verbose(env, "\n%s:\n", title);
> +}
> +
> +void bpf_diag_report_suggestion(struct bpf_verifier_env *env, const char=
 *fmt, ...)
> +{
> +	va_list args;
> +
> +	bpf_diag_report_section(env, "Suggestion");
> +
> +	va_start(args, fmt);
> +	bpf_diag_vprint_indented(env, fmt, args);
> +	va_end(args);
> +	verbose(env, "\n");
> +}
> diff --git a/kernel/bpf/diagnostics.h b/kernel/bpf/diagnostics.h
> new file mode 100644
> index 000000000000..f13a939722bf
> --- /dev/null
> +++ b/kernel/bpf/diagnostics.h
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright (c) 2026 Meta Platforms, Inc. and affiliates.
> +
> +#ifndef __BPF_DIAGNOSTICS_H
> +#define __BPF_DIAGNOSTICS_H
> +
> +#include <linux/compiler_attributes.h>
> +
> +struct bpf_verifier_env;
> +
> +void bpf_diag_report_header(struct bpf_verifier_env *env,
> +			    const char *category, const char *problem);
> +void bpf_diag_report_reason(struct bpf_verifier_env *env, const char *fm=
t, ...)
> +	__printf(2, 3);
> +void bpf_diag_report_section(struct bpf_verifier_env *env, const char *t=
itle);
> +void bpf_diag_report_suggestion(struct bpf_verifier_env *env, const char=
 *fmt, ...)
> +	__printf(2, 3);
> +
> +#endif /* __BPF_DIAGNOSTICS_H */
