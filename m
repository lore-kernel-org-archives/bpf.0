Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2EBD4AB1C2;
	Mon, 12 Oct 2026 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791821521; cv=none; b=j1TC5R7P1hP3mcL8UymDdC98hAicp2w1Q9LnzQPWvf0YzJvxIeF+avXpiuunvHndS0RtP1MvMzynKEEt/LIr7fTvtSf9jOmX63gtV7qQq21Ew5bxXTPeWQ1bmEiVX6Hn5lggWEtJhyVOOd7wC7fBncuUOVn3xGyOToKM1/3whEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791821521; c=relaxed/simple;
	bh=w8q9iJyPWbtVtE2tleQnnZpd26qb3UTvq3ck14FcaoM=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=r6IyU2ZEFPt1i+QhYQj46EC4Y6ZGfhFc3wnselY4KqY/zEc/WG0MPO75YkaGTS+s6ytEb8WRxBCg9eq/yZwgyBGO3P+imNaZjleOXSyBA8YPOCsGTMkhryfNNYsWGIT5sCiO+YV4dIs57jLOhp13CFET12BpiWORLQ7InODKhi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mwnkiSKn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mwnkiSKn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F611F0089B;
	Mon, 12 Oct 2026 16:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791821518;
	bh=iHAQh7YtJAMZUxMTAyAXDIESpkS3iC6FqJPJReS+Cak=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=mwnkiSKn19r2V0c+PKSNMx5nb9JW8M5LZt0fZEfhgyuFf84wLzb8NPxX6f3DVfkKN
	 B//aLWUT/FrOg0XAApxYpyv/0RSh9BE8HxgLI/kTTXq6t7/1/rzYs1SpOpph7Tcajj
	 jagW8h7+sasdAUn/dYWSvyw6ryGCwYgzi9iIO6zGAKvOv2gtmBJRaX6Z1Ow2CVNv7q
	 9eX52uorYmdaKVb7TY1Tp1pIjpradtNV7ksoARp04nfvGg2wDfg/ZKDwG9zYm0q8Bx
	 xHofgPwpraA9JD14VfWwceYQz7r/0jneqheDmf/e7ZCXVFmUkEoKcFzH1zkHQErLCV
	 M46muitrh3LEg==
Content-Type: multipart/mixed; boundary="===============2774668723812264744=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6ce8106423344022020501feecc7c257ecd3cb1cfe7004e72e202e97c3f6970d@mail.kernel.org>
In-Reply-To: <20261012154024.29423-20-leon.hwang@linux.dev>
References: <20261012154024.29423-20-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v2 19/21] selftests/bpf: Add tracing_multi bpf prog link info test
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,qmo@kernel.org,shuah@kernel.org,leon.hwang@linux.dev,yatsenko@meta.com,avinash.duduskar@gmail.com,a.s.protopopov@gmail.com,ameryhung@gmail.com,jordan@jrife.io,rongtao@cestc.cn,eyal.birger@gmail.com,pulehui@huawei.com,tanjingguo@huawei.com,malin89@huawei.com,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 12 Oct 2026 16:11:55 +0000 (UTC)

--===============2774668723812264744==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Add tracing_multi bpf prog link info test

TL;DR: Nit only: the new <linux/kallsyms.h> include in fill_link_info.c may be
unnecessary, since trace_helpers.h already seems to provide the ksym helpers
the test uses.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> index 0918321c8e63..422e94f13409 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> @@ -3,11 +3,13 @@
>
>  #include <string.h>
>  #include <linux/bpf.h>
> +#include <linux/kallsyms.h>
>  #include <linux/limits.h>
>  #include <bpf/btf.h>
>  #include <test_progs.h>
>  #include "trace_helpers.h"
>  #include "test_fill_link_info.skel.h"
> +#include "tracing_multi_bpf.skel.h"
>  #include "bpf/libbpf_internal.h"

this isn't a bug, but is <linux/kallsyms.h> needed for anything here?  The
ksym helpers used by this test (ksym_search(), ksym_get_addr(), struct ksym)
seem to come from trace_helpers.h, which is already included, and nothing in
fill_link_info.c appears to use KSYM_NAME_LEN, kallsyms_lookup() or
print_ip_sym() from the tools/include/linux/kallsyms.h shim.


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/38273555988
--===============2774668723812264744==--
