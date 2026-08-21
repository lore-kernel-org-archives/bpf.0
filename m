Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27152222D0
	for <bpf@vger.kernel.org>; Fri, 21 Aug 2026 00:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787271010; cv=none; b=ox7cN2GYFFD5in7Suw5YYlTvDRLkO3SPBfHNZskYsxjoW4ldiiGfGsg/XTfOPrcTAzld4/SH+EjAMmfrUntcVnm3sUtAkQrgm70UCZTearbbjf3JVq+KToLaJ0QY5tdsiC2jMrGJjfDvJLEQripeeOlWzVcFS9qirXTOQXxyczo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787271010; c=relaxed/simple;
	bh=YvHQ3miz97Wxhsdl2DC3IX66HonwlBnObtoGpVg9ojw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=k12CvR0bbQlZ+utQx/ymdtV1kJin1muxw7BKqatlEXcIzG0ml+3Z44b7I9Mi1H6b0fZjVTGOVEQb5W3o0Wn5nZB8EkYpFQ2NxFQceKHa3KDC8y73iBWqghKm/J60thsw+gMexsvZ0HRrydoyLFWaqxzxp+UMM7g9lNw9wNgy5EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kdk8XnHE; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kdk8XnHE"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e3efab7e0so274379a91.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 17:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787271008; x=1787875808; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=mnGSxAPxWvCyoRHnoU9zYBh0C+WPKLEGOxSgVj9dJH4=;
        b=kdk8XnHEqzDjcwYb6Ml1/DdqRWebguNo/dSTGG/PAO2ZoJPY1ojAphLKgOA+dkP7aO
         FvawOX3CSk/ExuKhbttSCaKW+STGv/sstGHx6xivXcQ6+RpiBBDgH9xnw9BLoPeHZAfj
         3LQTt600MlW38I5s+ckIGE4V33WoWLhmreMKa+6mtMFFNIHUJnom62Mk3Viu/IoIBRsg
         gFyKQXye3OMtQwOZWa1y+Rz1rdI/sDzlw3sNvjlPOzWYTFg97w026WaT8XfKjDtZnCYZ
         8PnPETnSMFQvZnTAYxFciz31Ul26DACsdT0N1vZ7LGiBXeZBXLQqwfEd3NzUaOn7z9mA
         C6mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787271008; x=1787875808;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mnGSxAPxWvCyoRHnoU9zYBh0C+WPKLEGOxSgVj9dJH4=;
        b=MJ9XCb+lCJON4TEMRGgAjcj2MD51MaL3/0GkLGUv2284ktwHCOsJGzUdetW8ersUBA
         BSUi4JXmiJKOgdaY5syuex7kOdjK/YNpY0nqDCIDqJ7SgUdN2mLZCBONJQsjiODQ8Hiv
         Fbkvo2egHmDmFGUo7gzQyEzyNk1KWqU7JXWZlXq9lbnoUgFJMC02lYVHUVbJjEndAMdR
         M/4VVe//N6MAwaJhW2KIA/24pNuiPu9aWWL6/s2/U6pYoqXkwFf4zETak46FDjvLi77y
         fGgH8pBf7iI1rX3zfBw8xWXBg8mX0ZspsvMXd0E+3pOlHB87/yaS3YeJZbR5bf6IeB5W
         r26Q==
X-Forwarded-Encrypted: i=1; AHgh+RoaFG/JRdncsarbdrbW2VWrPm2compN9CkGIIsjgP2RyJzyP47DyZvKZVXhT+aZ/rrbIAg=@vger.kernel.org
X-Gm-Message-State: AFuF++nAsw+Hum11lVQcbTm2iC1iQOQ/97DjEtEgbdCy+NA2AtsgwT+Y
	Ovqd+TarcQ3mPrB+gGtcpofL0FjFGDWzUC8r0PBMioGf6dP9Ayhfveit
X-Gm-Gg: AR+sD102Lp4r/vvdlV5cDaEH0fA5iJ9k9vDOoGHrkS3e1cDUqt4Yruudi5EjRrpNbe1
	CceS3FbkIDzAyOufGeIln+McrqRbMZhLHrm165EPaqyJVAcbMOPS7gzlz+vIwVj9T66iSXSZZMZ
	UnOLJdmd8JMqaEqyUhq2nNuJ2LeCd3RI0xIhDMV1bNPrbAQ9XrFMWMYtcXg1pK56oMI9i0+ynB+
	BDaf6zNSNcSH9ZuRhvTYCEr3mH2V2R8rggiLpQ2c0JVMHNK/PmCdNKKDf6T+UT/BFXKA8FZXF/H
	a2XZ/fWqCVNRvDZ21vWlsniOipkq0tJsliOC8HXJ/M9y+NAG3ReQSGKMdgPOMqZIQ+kA/LBcd3E
	NmU/5siFahn/T/+8rW+MQAhePsWrR4AyK4oweglmkPtH3vbmjZJzehhjO0kg0j35LZoOgH1tojD
	xOlz5KqD9TfyNNpd2kYGwuUmRtPSbaulasszDAuT47d8zrCSUoIl0+W6cYAxPLhubdgZ024WxxN
	25+cnYNayyCLdZ2otVIj+5EW4CoJ0m4Bw5QWZ4kIPrI0Q==
X-Received: by 2002:a17:90a:e70c:b0:38d:eaed:4adb with SMTP id 98e67ed59e1d1-395a074d955mr13842390a91.20.1787271008165;
        Thu, 20 Aug 2026 17:10:08 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:89bc:48d2:9457:6223? ([2620:10d:c090:500::6:c5ba])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ac3d1bfsm19054586c88.0.2026.08.20.17.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 17:10:07 -0700 (PDT)
Message-ID: <67d62b1943b093ac1eb16c9cc1ff38e0d5eda72b.camel@gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 2/2] selftests/bpf: add tests for
 selective kmod BTF loading
From: Eduard Zingerman <eddyz87@gmail.com>
To: Fuyu Zhao <zhaofuyu@vivo.com>, bpf@vger.kernel.org, 
	andrii.nakryiko@gmail.com, alan.maguire@oracle.com
Cc: andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 memxor@gmail.com, 	martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, 	emil@etsalapatis.com,
 ihor.solodrai@linux.dev, shuah@kernel.org, yatsenko@meta.com, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Date: Thu, 20 Aug 2026 17:10:05 -0700
In-Reply-To: <20260819090426.267-3-zhaofuyu@vivo.com>
References: <20260819090426.267-1-zhaofuyu@vivo.com>
	 <20260819090426.267-3-zhaofuyu@vivo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2026-08-19 at 17:04 +0800, Fuyu Zhao wrote:

...

> +++ b/tools/testing/selftests/bpf/prog_tests/kmod_btfs.c
> @@ -0,0 +1,196 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include "kmod_btfs.skel.h"
> +
> +static bool btf_skipped;
> +static bool dup_ignored;
> +
> +static const char btf_skip_fmt[] =3D
> +	"libbpf: skipping module BTF '%s', not in kmod_btf_names\n";
> +static const char dup_ignore_fmt[] =3D
> +	"libbpf: duplicate kmod BTF name '%s' ignored\n";
> +
> +static int libbpf_print_cb(enum libbpf_print_level level, const char *fm=
t,
> +			   va_list args)
> +{
> +	if (!strcmp(fmt, btf_skip_fmt)) {
> +		if (!strcmp(va_arg(args, char *), "bpf_test_no_cfi"))
> +			btf_skipped =3D true;
> +	} else if (!strcmp(fmt, dup_ignore_fmt)) {
> +		if (!strcmp(va_arg(args, char *), "bpf_testmod"))
> +			dup_ignored =3D true;
> +	}
> +
> +	return 0;
> +}

Idk what Andrii would say about this, but I'd rather add an internal
function akin to:

  size_t bpf_object_btf_module_cnt(const struct bpf_object *obj);

in libbpf.c and expose it via libbpf_internal.h (*not* via API),
instead of intercepting log messages.

...
