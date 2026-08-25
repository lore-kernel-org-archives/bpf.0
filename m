Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9DC2E06E4
	for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 13:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787666366; cv=none; b=QtBoCg6UJQRt4kdJ5uQhKwq3rfBlgRwODDV14VSurC5mSu/HEbEJ+JYMvAGqmySQBKFsd6DV0NvnayRvYwTsB4DzEDtq092QOfRFspKyUcNAjYBbFUeIhqmTz1ufOIYRNWIVfMfUIK8MR/CC4fRgn53aR5qk4MVd77cZgA2eSro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787666366; c=relaxed/simple;
	bh=4vd6obfqTMYr11P9zYdWfKYzbJgihAcbwByJq7w+X2E=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwZp+FFiKvWdH2iYgXAEHympSiB6tjBTzXg2XfiFeHFgVl9ozHphF7T3TaPhRvfmsY+gTFSxqD5e/wuCffbk2n9eQCBf8trgzqGOXXQnYoZPcnaAy2NiOtr43xoxwzpK3OQRocsRREMIYZTtS6W5XSEwPLG57w8+lT8zv2lYuyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IozaizFt; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IozaizFt"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a374bea882so8845661a12.1
        for <bpf@vger.kernel.org>; Tue, 25 Aug 2026 06:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787666363; x=1788271163; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nZIWU3ntEK9p1MoYkrmimBKP574yOWGur1kHI3QlAkU=;
        b=IozaizFt9R75zLTE5aK+mIbBPIDfc8RbSOdQ3RWkwg/ViBNDkTgJ8spnKVjKO3QV0u
         L33MHwt7LUhBMBKq6PY7QCQdf8vb4gCNYn1gBWPxXSkST9p3ISFFVs81UBTVH5Ife97l
         A765Xag40Sc+FOmckHRgV8h5hD2KyhrsyL6Q2p0Qh5VD/gf4TFTYYphIC0XNPZd53v72
         56mWO3kHn9Y2ZNg72OqPLaNpe/zL/lU6H9RrJ0SdC4tNoW75HI9ZTpTJ7R9sft7E92Lv
         5Fq8DhaZhGL7fNaOWm6CyuNdtKKzDxGw+tGblJ7r6RPdOUEbYO6LJQQ7o6mEIWKnpgRR
         dOCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787666363; x=1788271163;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nZIWU3ntEK9p1MoYkrmimBKP574yOWGur1kHI3QlAkU=;
        b=d6bZ6+pSWBaYPprW5p3e9i63t38XwX0V+Bi7JO3Px1ZOR1ZBeVNXWywz5rh6Rd3sXh
         fxwkmp5JAb5Yggs4VWEJwAZDyMBA3tnQ4XSDUbhczJNjxQMV7y+PkkwdoWq93joC/aYU
         FqLFN512p0+I0k8TzD7axBCiUavtwVHhFiViV54+LILtAoryX6yGFLgqGAk+9NNWsm9V
         S59t+46sj911XfJ2Guw/hGNdBhvvaDE5ChCfwYc7zpoTUiU14wvvESXuvCwNotNHLHyM
         F+6jZKLWePtYJc59O/Ec8M/bwUCa/1/TUfSbYNYBTjnuFQUBtViF506nQg8CzvoxCxmn
         FwSw==
X-Gm-Message-State: AFuF++lkElL+U5Fw5pOp5FMCoyIhGYU4Cb8yF0itdzT8jNym2qat2mlI
	MpqtAvxwLTPEVj1MFQP+CEAQosJ8fEYbgINlZ1PF+SwyHF1TNEGVFWYE
X-Gm-Gg: AR+sD105U5n9i+Pq1BejbEWm4TvaGb0/xlTX/aHOBGMi2RyU96xMQ+Jl6x+tT1mqPgv
	KuB3uISsLS8Onwouep05DHzeko0khrGJIPc4qRPbi/bCpRHibe9+ldPNGMKlHvURXGNCVMLAVg4
	b95CLm8nIm9J84h4CLVTNR/HjtqUHS1or+YvOCH8rujeBsyQCyklUc6wfDdN6tZBKs0PRivwnFW
	55XpxNZ3ceKfv89EGNKce3dnwiYVrVzODJDpGOT3aZAjC03tP13mAb0ZOKXv3vGouNq6kEb5Xhk
	R9mWulyi9Xd3KbbMa6Ds4cOkV7Lxt4Upb4LApKnUSuO2A1ytjwJSbHXyJlm9Z1cBnSLRZJaMVUe
	uXJQDvseQDVAK83G8y7L3Ef16I3tTld0YTgr30EZpji5RcZDwau2XdcPiIes2CwSrZk4e9rFO09
	6CYOtwjwvCrLkQJYvu3U8lgvQqHPH2THA8EahsBONrV48gIwOj
X-Received: by 2002:a05:6402:5406:b0:698:c13e:179a with SMTP id 4fb4d7f45d1cf-6a42f1bcdb3mr37817993a12.10.1787666362797;
        Tue, 25 Aug 2026 06:59:22 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e012f84sm20138332a12.8.2026.08.25.06.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2026 06:59:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 25 Aug 2026 15:59:20 +0200
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>, kkd@meta.com,
	kernel-team@meta.com
Subject: Re: [PATCH bpf-next] selftests/bpf: Resolve bpftool through
 bpftool_helpers in core_reloc
Message-ID: <ao2fuAn10J8GJBsU@krava>
References: <20260824195746.3070450-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260824195746.3070450-1-memxor@gmail.com>

On Mon, Aug 24, 2026 at 09:57:46PM +0200, Kumar Kartikeya Dwivedi wrote:
> run_btfgen() shells out to a hardcoded "./bpftool". That path only
> exists in the build tree, where DEFINE_TEST_RUNNER_RULES symlinks
> bpftool next to each runner binary. After "make install" it is not
> there: commit 0b236ac75d04 ("selftests/bpf: Fix make install target")
> dropped bpftool from TEST_GEN_PROGS_EXTENDED, which used to flatten it
> into $(INSTALL_PATH), and installs it under $(INSTALL_PATH)/tools/sbin/
> instead, matching detect_bpftool_path().
> 
> Running test_progs from the install tree therefore fails all 64
> core_reloc_btfgen subtests:
> 
>   run_core_reloc_tests:FAIL:run_btfgen unexpected error: 32512 (errno 95)
>   sh: line 1: ./bpftool: No such file or directory
> 
> 32512 is 127 << 8, i.e. the shell could not find the binary.
> 
> Use run_bpftool_command() from bpftool_helpers.h, which locates bpftool
> via $BPFTOOL, ./tools/sbin/bpftool or ../tools/sbin/bpftool, the last of
> which also covers the test_progs flavors. bpftool_helpers.c is already
> in TRUNNER_EXTRA_SOURCES, so no build change is needed.
> 
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka

> ---
>  tools/testing/selftests/bpf/prog_tests/core_reloc.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> index 08963c82f30b..80432c4656b5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
> @@ -7,6 +7,7 @@
>  #include <sys/mman.h>
>  #include <sys/syscall.h>
>  #include <bpf/btf.h>
> +#include "bpftool_helpers.h"
> 
>  static int duration = 0;
> 
> @@ -985,16 +986,15 @@ static size_t roundup_page(size_t sz)
> 
>  static int run_btfgen(const char *src_btf, const char *dst_btf, const char *objpath)
>  {
> -	char command[4096];
> +	char args[4096];
>  	int n;
> 
> -	n = snprintf(command, sizeof(command),
> -		     "./bpftool gen min_core_btf %s %s %s",
> +	n = snprintf(args, sizeof(args), "gen min_core_btf %s %s %s",
>  		     src_btf, dst_btf, objpath);
> -	if (n < 0 || n >= sizeof(command))
> +	if (n < 0 || n >= sizeof(args))
>  		return -1;
> 
> -	return system(command);
> +	return run_bpftool_command(args);
>  }
> 
>  static void run_core_reloc_tests(bool use_btfgen)
> --
> 2.53.0-Meta
> 
> 
