Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D8E1FDA61
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768935555; cv=none; b=gDciW8ztPMKMd7ONYXhyz+Ukb8oV2Jgg2drhnywCGelIQtUbnY+GDAydwe+uYeGh07IPEMt7jn4q5f/ke00rwSlExQknLcwX8t/hA5HFqZhy0zT0dt5Mr3sUIuK/SFuiyj9CHwYaKc+zi2AWSTnI7FFDtdSKAlEdcekdS/2CTYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768935555; c=relaxed/simple;
	bh=Ta27cmPUr9U6KYn68SgfQJZDlRR8kgDyO1DzrKY4nn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kFlAFcZg8oA+fZiIRxH1Wb6rXJ6RSGbTS5JMBon7DzazIB5KLZ+4EjeaCyXosngV6Lg3h/ABDbf+45QEylqCxhW8CkkCyyk//yWgEUtzxrvNI+lm1aqc+4wBVvws8fo47emEU/PIUsHk1H6HG3pFMIsmiQgF1mnxbyUnC2e8yis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hSyEHjj/; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hSyEHjj/"
Message-ID: <b53ee085-d9d2-4365-a5bc-d61e2bce97f8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768935550;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzSGa4fk8ZToFJf/TRU+xKf4WcJa5YezEBW6JkV0l2Y=;
	b=hSyEHjj/V2Pw3FaA3O4SwuRNxlcKF1AhXZIB7yifbJ+FDBQxgwJS6c64Izk72DlQSap1jX
	LT93waZ+MH2qZapd5V99OaMulGNPRn8AUYN2IkMj+vDXYoEjEPi3CadUu3DwwSLsS4PGQm
	Yw7GPOogmCU/763bYPmIXP42B+/vHEc=
Date: Tue, 20 Jan 2026 10:59:03 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] scripts/gen-btf.sh: fix shebang for NixOS
To: Gary Guo <gary@garyguo.net>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260120182034.3647092-1-gary@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260120182034.3647092-1-gary@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/20/26 10:20 AM, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> NixOS only puts /usr/bin/env and /bin/sh at the standard location as
> required by POSIX, but not other shells. Other program that kernel build
> depends on is supplied via PATH, so shebang needs to use /usr/bin/env to
> find them.
> 
> This has been done to a few other scripts already, e.g.
> gen_test_kallsyms.sh or decode_stacktrace.sh.
> 
> Fixes: 522397d05e7d ("resolve_btfids: Change in-place update with raw binary output")
> Signed-off-by: Gary Guo <gary@garyguo.net>
> ---
>  scripts/gen-btf.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/gen-btf.sh b/scripts/gen-btf.sh
> index be21ccee3487..4cd3159f2ddb 100755
> --- a/scripts/gen-btf.sh
> +++ b/scripts/gen-btf.sh
> @@ -1,4 +1,4 @@
> -#!/bin/bash
> +#!/usr/bin/env bash
>  # SPDX-License-Identifier: GPL-2.0
>  # Copyright (c) 2025 Meta Platforms, Inc. and affiliates.
>  #
> 
> base-commit: 053966c344dbd346e71305f530e91ea77916189f

Hi Gary, thanks for the patch.

I'm guessing this came up because gen-btf.sh is part of the vmlinux
build, and link-vmlinux.sh has #!/bin/sh (not bash).

But I wonder if all of these need the same change then:

$ git log --oneline -n1
24d479d26b25 (HEAD, tag: v6.19-rc6) Linux 6.19-rc6
$ grep -r '#!/bin/bash' ./scripts/
./scripts/check-uapi.sh:#!/bin/bash
./scripts/decodecode:#!/bin/bash
./scripts/extract-fwblobs:#!/bin/bash
./scripts/gfp-translate:#!/bin/bash
./scripts/git-resolve.sh:#!/bin/bash
./scripts/mkuboot.sh:#!/bin/bash
./scripts/objdiff:#!/bin/bash
./scripts/objdump-func:#!/bin/bash
./scripts/prune-kernel:#!/bin/bash
./scripts/tags.sh:#!/bin/bash
./scripts/tracing/ftrace-bisect.sh:#!/bin/bash
./scripts/livepatch/klp-build:#!/bin/bash

