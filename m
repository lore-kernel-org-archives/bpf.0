Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792473013;
	b=0MvgKRxPq57Hh63Yrrtk5VZPHx5hhynZXzffeg8C2IgEk8aI27/w87A2h0kYRKTuhak1
	 3d9K4/umhivPtL/YKeawp3nIhVpaC/Mynon1prSC2QaiFxp7Wl+7U8ZIfLqEKc1bvA8uu
	 /z4o1W1BQb9pkjL7QA+dvKSIbHIJRzIssFt6BLJWp/Kmxkp9/+jOAWJr76JrVA/ASY2XV
	 PShSds0lr5mGjj7JYNvMMf9LIFeTjlXaHrqVzjuZlUrpj5BSLELa88coQBX+UGC82NeYa
	 OsNK2eVKrX0oWuQwyGtkbLZb0ruWgDDgKZPlKuYazpIeg6GeEKBAEhhxrQRaUqu1PKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792473013;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=cIi8ZEtaczM0JFNSbjeBuBEwW/vrTvEsiSS87yPe30s=;
	b=hhLSwfkHIG/8e7AjIZQHTm/DSJHB7H3xasp6iSQSXea2tMZZWfT2l56OS+FlYD0EOUeb
	 8H1ZoBtR/9hfk2340rdUMtg6vVyoCZMyttbG+o8xLe1pMYG8uM0r86yiOHTiypC0Jbher
	 udDX4LtwoBLBk5wnv1GpmXiXuyUioiHrCsPsdaxcwh5TnsBGsoA6Y2Q5OjNmuCU0AQzNV
	 nWNsDMzAodWQ8/+The3LGhRy+Ru32xof2G1Nuf6/kE3RQQqP/xbmvGepqC4FCT+Eipmcy
	 QrQ9L3OA7fkGUwUdpUc/jJXQM6h9fRmpKeL3vB6ougNbODmexa+RzgqH5fxwWLDldJg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=canD16H5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C25606A319
	for <bpf@vger.kernel.org>; Tue, 20 Oct 2026 05:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=canD16H5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B91451F000C4;
	Tue, 20 Oct 2026 05:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792473013;
	bh=cIi8ZEtaczM0JFNSbjeBuBEwW/vrTvEsiSS87yPe30s=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=canD16H5yFrL8O8S/aIVRisZtpnWUUwV7nGqU0XE+48QhOxod7d43Kl8+TumV7A7a
	 j/8QxyvwjVUa3OR/MvZeIMu5pP9SQiumQrsLU6fczbmdI9e2ws+zG3hfQr7Bkpyn3B
	 /FWSAY/Id5lcOwMPsuCrq7dHCx7+XxKaOwhJ14qoPR3+kaTKfgW+JgLyH3oBPL3j3v
	 MRd4mZNP8vw/GF3Mpsrv7dmnqFoXJ4DWB1hHZXlsfzqT6/MYOb4NL9CfDGJ9ZyVtal
	 0jkUThdi2rWUP7HG/PbI9i4KGRw9zDD6EEAzlxUScshdw50VU/mfBsa/hh4za8Cg7f
	 8v43au9m+DNKA==
Content-Type: multipart/mixed; boundary="===============2401158712173401905=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <f272e441c3d8f8bd54b7fc9fac70ee4911ef1ef6008fb581bc8d8f82daf993a4@mail.kernel.org>
In-Reply-To: <20261020043319.3031996-6-alexei.starovoitov@gmail.com>
References: <20261020043319.3031996-6-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 5/6] selftests/bpf: Add a C++ prog with exceptions
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,yonghong.song@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue, 20 Oct 2026 05:10:12 +0000 (UTC)

--===============2401158712173401905==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add a C++ prog with exceptions

TL;DR: Nit only, in the selftests: the local ENOTSUPP define in unwind_cxx.c
(and unwind_attach.c) is redundant because test_progs.h already provides it,
so it can be dropped.

> diff --git a/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c b/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
> new file mode 100644
> index 000000000000..36e52766022c
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/unwind_cxx.c
> @@ -0,0 +1,76 @@
> +// SPDX-License-Identifier: GPL-2.0
> +#include <test_progs.h>
> +#include <bpf/btf.h>
> +
> +#ifndef ENOTSUPP
> +#define ENOTSUPP 524
> +#endif
> +

this isn't a bug, but test_progs.h already pulls in the same
"#ifndef ENOTSUPP / #define ENOTSUPP 524" block through bpf_util.h, so
this local copy can never take effect.

Could it be dropped here, and likewise in prog_tests/unwind_attach.c from
earlier in this series?

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/39371273420
--===============2401158712173401905==--
