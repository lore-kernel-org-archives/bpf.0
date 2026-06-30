Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 838902C15BE
	for <bpf@vger.kernel.org>; Tue, 30 Jun 2026 19:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782847300; cv=none; b=Fpd3t0oxZ2rFcUkXR+NJNPCz0y+y42T1kc/nnrcNuHlIJHknOzPjSCEkIa+sDQlRc/qplE0Q7vBDSTs/YDQnSFWL83/YHV5HR46BQIswCDcSWovBzbEyz1nZ8ONOmmOECBkkDVQMt7riif9emapy6aDQ9b5ppHD0B1yMKKkrR2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782847300; c=relaxed/simple;
	bh=SMTNcIi2VF7syRC7mEVSHMJrcRudFcZNCPHDTbtQqpQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNYHY3+cZQnFJuavgwquLON2+Wt2bapasy/OYvGi/XYeHY4cX2cuJi6MSyfGbQFxR7Z8Uid1fgCr5Y9ByCiY8ZNzMHfHs1LdJpyxhfiaa3ekmxIyjIfhIr/CIzCMFIogz3NY22pPYCSTD9Ii2AY4BWTmUGS90NnZimQ3EWCInE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=JoaHV8Rg; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="JoaHV8Rg"
Message-ID: <9fc9896b-cd48-4df8-a311-b2d4d266fcdd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782847295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sQGjZ5cG+erdn23Xc3+xjJJzVzU1eBkQUBbLot/ULEs=;
	b=JoaHV8Rg9gjUE9CkL7128fsOLh4UpWof4KccQOYNRpC6zB+j/jFvvc4T88ZCOKn5sO076o
	ZvP8PXeZzP1S4qihmDt9gFw2ow8q02iwdDC6Oo5l9a6rsVupppCBlkFPPc/6SkKNvotj+h
	BuyhcEXHb6uDbI3J71Hi6lPHaQJ5j/o=
Date: Tue, 30 Jun 2026 12:21:02 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 1/5] libarena/selftests: Replace leftover st_
 prefix with test_
To: Emil Tsalapatis <emil@etsalapatis.com>, bpf@vger.kernel.org
Cc: ast@kernel.org, andrii@kernel.org, memxor@gmail.com,
 daniel@iogearbox.net, eddyz87@gmail.com, mattbobrowski@google.com,
 song@kernel.org
References: <20260618085626.19633-1-emil@etsalapatis.com>
 <20260618085626.19633-2-emil@etsalapatis.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260618085626.19633-2-emil@etsalapatis.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/18/26 1:56 AM, Emil Tsalapatis wrote:
> ---
>  .../selftests/{st_asan_buddy.bpf.c => test_asan_buddy.bpf.c}    | 2 +-
>  .../libarena/selftests/{st_asan_common.h => test_asan_common.h} | 0
>  .../bpf/libarena/selftests/{st_buddy.bpf.c => test_buddy.bpf.c} | 0
>  3 files changed, 1 insertion(+), 1 deletion(-)
>  rename tools/testing/selftests/bpf/libarena/selftests/{st_asan_buddy.bpf.c => test_asan_buddy.bpf.c} (99%)
>  rename tools/testing/selftests/bpf/libarena/selftests/{st_asan_common.h => test_asan_common.h} (100%)
>  rename tools/testing/selftests/bpf/libarena/selftests/{st_buddy.bpf.c => test_buddy.bpf.c} (100%)

Acked-by: Ihor Solodrai <ihor.solodrai@linux.dev>

nit: An empty commit message is weird.
The short message is self-explanatory here, but still...
Maybe a brief comment on *why* this is done?

> 
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
> similarity index 99%
> rename from tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
> rename to tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
> index 686caba2c643..256d62a03ce7 100644
> --- a/tools/testing/selftests/bpf/libarena/selftests/st_asan_buddy.bpf.c
> +++ b/tools/testing/selftests/bpf/libarena/selftests/test_asan_buddy.bpf.c
> @@ -12,7 +12,7 @@ extern struct buddy __arena buddy;
>  
>  #ifdef BPF_ARENA_ASAN
>  
> -#include "st_asan_common.h"
> +#include "test_asan_common.h"
>  
>  static __always_inline int asan_test_buddy_oob_single(size_t alloc_size)
>  {
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h b/tools/testing/selftests/bpf/libarena/selftests/test_asan_common.h
> similarity index 100%
> rename from tools/testing/selftests/bpf/libarena/selftests/st_asan_common.h
> rename to tools/testing/selftests/bpf/libarena/selftests/test_asan_common.h
> diff --git a/tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c b/tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c
> similarity index 100%
> rename from tools/testing/selftests/bpf/libarena/selftests/st_buddy.bpf.c
> rename to tools/testing/selftests/bpf/libarena/selftests/test_buddy.bpf.c

