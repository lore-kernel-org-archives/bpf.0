Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330E023373D
	for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 17:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771436339; cv=pass; b=NIafKYqebnWEWvgSY+Iljs9p2hd1eMeKTB+Zc2wcbI9XrqqdlwXg0kWcnnEw8XX9ikdMLIiCPBMsv1EGh3WY2N8TXopUNzOSfpAF0qcrJak2vaxxU8V6OvM+QRliZRYi4WJCo9hDP9Bi0cWMp6X3V6IRIgWoTwDQRUzJLNudYQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771436339; c=relaxed/simple;
	bh=6lp76ntItgkRFNuYX8LLjndtaJyahFUUTiYuvYnuNzA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F5VZpFXxV1RtC8oVVPDWcnd10WpShhyh6L8riTtGrj4QSLE4cfQXZhRuYKLyI9qjnL8//qgnOLZ8CuAcyRUAcGuzYaQdNec4dDiskweGVUndquZuz+8AHMHVvpbaCS9UzRrGqjtkfGwQDHyFBf5SYZ71fHw4PhqD2utwG9rHGp8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDTavb0C; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDTavb0C"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4837584120eso715625e9.1
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 09:38:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771436336; cv=none;
        d=google.com; s=arc-20240605;
        b=aNgBUf8s+N9eVuExnH8I5JQ/An6UmNTkCuvRFh23CgkV04YmllMXtEevHrbFOrHmYI
         3wpNg7VffH2ycnMnHZVihQEXiHNZuuilFqwLe+cVG8DkeRuYgK50BzpcBkP4UjtfiXfc
         QSFjjDDFRVQvTTOfsfxb3cJAzniPY2NHRTHC294pPVILFQkFDm1c8F5MtKnSBn5zBmgM
         d86r2vp1DnBITMEprDzzjJCsNrpgaT28t3uSHFhuxA7TiDH0om132OkV8Qw5SyP5OXem
         qlygMq63JeNGw90FgvgdGZ3xDhKshBzHrTahgBhOGmVo2QVkDtw+sEyYzOOHHX4pw5iB
         +FDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=YmR53MbGSEuTWt6FOuck5GI3JxJDHM473LdKNKqtnY4=;
        fh=9d2NCAhD/C449aJmM4xt8smjaXteZ90cqU5iTF3Sybw=;
        b=HBjNHyQI4eQlQ3+3S3NqQt1mGiT90849Dnybd0n6pA9vdygpCI90KvQUar95g2tXq7
         G7nVboXm9MNV4ZTF8siQqCA3BXzdPPl1GeCo3Vue4d4nXRgZUDfOgpSe+1hW2wCBoNHp
         VoFCLG5+eOHgdDBmyRSbMXWxI0vwrh9pAZO1nA5jZ5iwyma79X8N62myBmKgaavTj19B
         xXRRlc7svEEmGoaealNgohH50t4en9TlsyWkpHguwgSwkbmh4dvaMl012YqKSnp3JjI3
         GDnXodRrtJEdcSk9HNePEpNDd+WakiXoXsleqIXzD/ukYR7qD6dN7JTXutR08G9aKJnf
         PsGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771436336; x=1772041136; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YmR53MbGSEuTWt6FOuck5GI3JxJDHM473LdKNKqtnY4=;
        b=bDTavb0CZXAyaYZGt9sy/+btYhR3d+Sm+iK8CpoeII0ABhEsUwIgLPRJjIb+QKJaMF
         NvCWfrN6EWni2VTMkmtk1dCWjs90tXzcWiZQHiSiAOxgghPp+kTJtt/lQd/GxMoODHPG
         +FJqznmTOWRO5ZPLd3dcMW6BcHLqcXN+6ym8Oygx4uih5zsagZpT5Cz8y4t5GMZlHF2i
         NLBwjzlunbJuqgUNumjQtUXQyuAp6PG3ZI79BkLFn7F5yvkOmxuCQnfETHHTlS1PcYZc
         CxxSCUGBQhUiFX5DgTB4mL5p/8q3edAqQiNuro1Fr0InmuiS+q0CeZqQHW5JPZOpoLsO
         ZJnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771436336; x=1772041136;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YmR53MbGSEuTWt6FOuck5GI3JxJDHM473LdKNKqtnY4=;
        b=oLvaohG5alHLqp7LIVAjbIiDco8tdbfn5c+CCTkoNure3MUr19OheWzW1TJxnVnCvs
         X2647XN8BhENKJbgMMT+ii0VrBWDt9PDUiyevS/xDfxXPnXGL/EAEUgETXpVMFBm1Y6b
         3eWkrptqzOdUqPDkQhO8+LI1pyfLo+SgE+7a/AxkONILRmMtMh1TRlt7TM18I7UCxXHt
         hmttuh60/iaIC07M0cvLkGHso5StBbUg4121deD7dsnsAdCK/5gnlnsfgMorxfl2FOK/
         SwICviV2dleQCjyu8vkwguqurL8NUuEqWeE9EkFnOFZYFyPVWCg4FTg3g3UnyYC4r9TE
         XnTA==
X-Forwarded-Encrypted: i=1; AJvYcCWhOM+Lk884BNe77oIa57eOhZIwOLeLZyiVTkr/Kkr5yoQY939TQWvlRLtvT6ZSpia9A+o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1ij7MNoQmDij5+gRBqidNhOuSfZMf3S9Yws4RedrF3QUSk/P4
	qJSD0jUsLSjXtC/qWk4iCe8acnn5z3YiJxS3tR7l3CV5t31CZ2kBYgtEoiW3IUBKqrJzTPJ2uoo
	CTFnGTpTi4tosOEyxUB+ZwiDmBJPv+HQ=
X-Gm-Gg: AZuq6aLg+Bbz0GwJMrFc2mc0RbucnpMrNwsQpgeWH2+qXDt9156cSUlGi+3xdXZXkQd
	PtIDDYlX7nQThsKe7n84/cIVcX6zouSYdVgI7wCJzUqsbxinI857ePxmEWfBYddxqPIlH8UF/VN
	o7iF+SWVc1qNP8IEWfSz06TDz4DfJaJWz3faP1OSYK7n/oSv3JLWnzx4uubYPpsAlm+xRfJGNZa
	RrYxJnnfs2ER9pFJVCSQFTziCIHbjgOIRdJCx9lhXGpU0SSdZJWmL+ickrg/eTiybJ/rWr68BXq
	lKX80yR/FxPU7SjGUP13cVYKRjQyCxz5VDaL9k5/76icq09mSOR/e1eUp3lgWAxY3Ardw4Owsd2
	r6+0jPLAdlxJq2rrlJuNI4dYXCTHj1Xd/L7ad
X-Received: by 2002:a05:600c:820d:b0:47e:e20e:bba3 with SMTP id
 5b1f17b1804b1-48379b8bffemr269214045e9.7.1771436336339; Wed, 18 Feb 2026
 09:38:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218003041.1156774-1-ihor.solodrai@linux.dev> <20260218003041.1156774-15-ihor.solodrai@linux.dev>
In-Reply-To: <20260218003041.1156774-15-ihor.solodrai@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 18 Feb 2026 09:38:45 -0800
X-Gm-Features: AaiRm51VgzJjgQ3unojEtMY29h9Gnld2nkGEOSWIDrimpU3P0XCJSjOtw2jWv3k
Message-ID: <CAADnVQLOONuA3omz1ZRoT5T39PpYfut3vXnH1Oxdh84pJA6c-Q@mail.gmail.com>
Subject: Re: [PATCH bpf v2 14/15] selftests/bpf: Check BPFTOOL env var in detect_bpftool_path()
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, Jiri Olsa <olsajiri@gmail.com>, 
	Mykyta Yatsenko <yatsenko@meta.com>, =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>, 
	Amery Hung <ameryhung@gmail.com>, bpf <bpf@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Kernel Team <kernel-team@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 17, 2026 at 4:31=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> The bpftool_maps_access and bpftool_metadata tests may fail on BPF CI
> with "command not found", depending on a workflow.
> This happens because detect_bpftool_path() only checks two hardcoded
> relative paths:
>   - ./tools/sbin/bpftool
>   - ../tools/sbin/bpftool
>
> Add support for a BPFTOOL environment variable that allows specifying
> the exact path to the bpftool binary.
>
> Also replace strncpy() with snprintf() for proper null-termination.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  tools/testing/selftests/bpf/bpftool_helpers.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
>
> diff --git a/tools/testing/selftests/bpf/bpftool_helpers.c b/tools/testin=
g/selftests/bpf/bpftool_helpers.c
> index a5824945a4a5..d810e73da6c8 100644
> --- a/tools/testing/selftests/bpf/bpftool_helpers.c
> +++ b/tools/testing/selftests/bpf/bpftool_helpers.c
> @@ -1,5 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  #include "bpftool_helpers.h"
> +#include <stdio.h>
>  #include <unistd.h>
>  #include <string.h>
>  #include <stdbool.h>
> @@ -12,13 +13,24 @@
>  static int detect_bpftool_path(char *buffer)
>  {
>         char tmp[BPFTOOL_PATH_MAX_LEN];
> +       const char *env_path;
> +
> +       /* First, check if BPFTOOL environment variable is set */
> +       env_path =3D getenv("BPFTOOL");
> +       if (env_path && access(env_path, X_OK) =3D=3D 0) {
> +               snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", env_path);
> +               return 0;
> +       } else if (env_path) {
> +               fprintf(stderr, "bpftool '%s' doesn't exist or is not exe=
cutable\n", env_path);
> +               return 1;
> +       }
>
>         /* Check default bpftool location (will work if we are running th=
e
>          * default flavor of test_progs)
>          */
>         snprintf(tmp, BPFTOOL_PATH_MAX_LEN, "./%s", BPFTOOL_DEFAULT_PATH)=
;
>         if (access(tmp, X_OK) =3D=3D 0) {
> -               strncpy(buffer, tmp, BPFTOOL_PATH_MAX_LEN);
> +               snprintf(buffer, BPFTOOL_PATH_MAX_LEN, "%s", tmp);

I guess it's ok for user space, but

git log --oneline|grep "snprintf with strscpy"
ad789a85b163 mm/cma: replace snprintf with strscpy in cma_new_area
674fb053e95d sparc: vio: Replace snprintf with strscpy in vio_create_one
2dfc417414c6 genirq/proc: Replace snprintf with strscpy in register_handler=
_proc
f46ebb910989 block: Replace snprintf with strscpy in check_partition
b66215e7b780 media: verisilicon: replace snprintf with strscpy+strlcat
a86028f8e3ee staging: most: sound: replace snprintf with strscpy

and many others...
So.. should we introduce strscpy() in selftests/bpf ?
