Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A329334C35
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 22:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771885961; cv=none; b=mXBMEcb2JaBpYShYOBermw20QapQJ4ja3IcLsslNkJrxp+ILWVobXhCoZeprg6CPYz/01jxi30cpflOT7kLZNuKhNNT2qWpZAKfS3mhAtpvYjUGg8j9XM+a+jSvtWIUr73nZMHsFWPBLUQihNnY2SAPKWqi1kfTBT92H3DiBOu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771885961; c=relaxed/simple;
	bh=GKoZGl4SvMjI7mJZYLtzEvN9UEHm0W01NVVG0EYK/cw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=akE4zzTcaLileuZCvmCbulX+KomiCIOtALh5qbXLf9DewByM/w5oDi3AYflEJWHW0GNRAIVGJ8wxFIWtW//0FouVkl5tZm2rc0e8dWQy3j6U4aWi0fVpyN0/+pSLFpReXtxvixwP4sLRsGG7BhppdT61TCIQ+pf8X2Emw6AkykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fSy11OST; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fSy11OST"
Message-ID: <b76aa450-e3fc-4002-ba3f-c73c11c1ec84@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771885956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gOUzGH24v1tE/NOsj00qGvJRG/uLDcmIAwX4fz02AzI=;
	b=fSy11OSTKGL7KRrCqS2vvDAjK7ww5QPCPClZ1Bbt58YE5Szw9jruRwwt/Uzp+6cmJ6ijRE
	QDD9VXlip8Ws2DSnx62JtZTDZgD7DnubbYj8LQG56vWKe7Vo9Xh508x8TnfIRUaQgJflum
	PNCUnzIsQBcnH78+QbFBWh6ApCDMZUc=
Date: Mon, 23 Feb 2026 14:32:28 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v4 03/20] selftests/bpf: Replace strncpy() with
 strscpy()
To: Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov
 <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jiri Olsa <olsajiri@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
References: <20260223190736.649171-1-ihor.solodrai@linux.dev>
 <20260223190736.649171-4-ihor.solodrai@linux.dev>
 <8249f1439fa9ee4a1227da3f0707a9d0cfbad825.camel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <8249f1439fa9ee4a1227da3f0707a9d0cfbad825.camel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/23/26 2:28 PM, Eduard Zingerman wrote:
> On Mon, 2026-02-23 at 11:07 -0800, Ihor Solodrai wrote:
> 
> [...]
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/align.c b/tools/testing/selftests/bpf/prog_tests/align.c
>> index 24c509ce4e5b..841a166b8081 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/align.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/align.c
>> @@ -633,7 +633,7 @@ static int do_test_single(struct bpf_align_test *test)
>>  	} else {
>>  		ret = 0;
>>  		/* We make a local copy so that we can strtok() it */
>> -		strncpy(bpf_vlog_copy, bpf_vlog, sizeof(bpf_vlog_copy));
>> +		strscpy(bpf_vlog_copy, bpf_vlog);
>>  		start = strstr(bpf_vlog_copy, main_pass_start);
>>  		if (!start) {
>>  			ret = 1;
> 
> This hunk no longer applies.


Hmm... Applies for me. What revision did you try?

$ git log -1 --oneline 
6de23f81a5e0 (HEAD, tag: v7.0-rc1, origin/bpf) Linux 7.0-rc1

$ b4 shazam 20260223190736.649171-1-ihor.solodrai@linux.dev
Grabbing thread from lore.kernel.org/all/20260223190736.649171-1-ihor.solodrai@linux.dev/t.mbox.gz
Checking for newer revisions
Grabbing search results from lore.kernel.org
Analyzing 22 messages in the thread
Looking for additional code-review trailers on lore.kernel.org
Analyzing 103 code-review messages
Checking attestation on all messages, may take a moment...
---
  ✓ [PATCH v4 1/20] selftests/bpf: Add simple strscpy() implementation
  ✓ [PATCH v4 2/20] selftests/bpf: Replace strcpy() calls with strscpy()
  ✓ [PATCH v4 3/20] selftests/bpf: Replace strncpy() with strscpy()
  ✓ [PATCH v4 4/20] selftests/bpf: Use strscpy in bpftool_helpers.c
  ✓ [PATCH v4 5/20] selftests/bpf: Use memcpy() for bounded non-NULL-terminated copies
  ✓ [PATCH v4 6/20] selftests/bpf: Pass through build flags to bpftool and resolve_btfids
  ✓ [PATCH v4 7/20] resolve_btfids: Fix memory leaks reported by ASAN
  ✓ [PATCH v4 8/20] selftests/bpf: Add DENYLIST.asan
  ✓ [PATCH v4 9/20] selftests/bpf: Refactor bpf_get_ksyms() trace helper
  ✓ [PATCH v4 10/20] selftests/bpf: Fix memory leaks in tests
  ✓ [PATCH v4 11/20] selftests/bpf: Fix cleanup in check_fd_array_cnt__fd_array_too_big()
  ✓ [PATCH v4 12/20] veristat: Fix a memory leak for preset ENUMERATOR
  ✓ [PATCH v4 13/20] selftests/bpf: Fix use-after-free in xdp_metadata test
  ✓ [PATCH v4 14/20] selftests/bpf: Fix double thread join in uprobe_multi_test
  ✓ [PATCH v4 15/20] selftests/bpf: Fix resource leaks caused by missing cleanups
  ✓ [PATCH v4 16/20] selftests/bpf: Free bpf_object in test_sysctl
  ✓ [PATCH v4 17/20] selftests/bpf: Fix array bounds warning in jit_disasm_helpers
  ✓ [PATCH v4 18/20] selftests/bpf: Fix out-of-bounds array access bugs reported by ASAN
  ✓ [PATCH v4 19/20] selftests/bpf: Check BPFTOOL env var in detect_bpftool_path()
  ✓ [PATCH v4 20/20] selftests/bpf: Don't override SIGSEGV handler with ASAN
  ---
  ✓ Signed: DKIM/linux.dev
---
Total patches: 20
---
Applying: selftests/bpf: Add simple strscpy() implementation
Applying: selftests/bpf: Replace strcpy() calls with strscpy()
Applying: selftests/bpf: Replace strncpy() with strscpy()
Applying: selftests/bpf: Use strscpy in bpftool_helpers.c
Applying: selftests/bpf: Use memcpy() for bounded non-NULL-terminated copies
Applying: selftests/bpf: Pass through build flags to bpftool and resolve_btfids
Applying: resolve_btfids: Fix memory leaks reported by ASAN
Applying: selftests/bpf: Add DENYLIST.asan
Applying: selftests/bpf: Refactor bpf_get_ksyms() trace helper
Applying: selftests/bpf: Fix memory leaks in tests
Applying: selftests/bpf: Fix cleanup in check_fd_array_cnt__fd_array_too_big()
Applying: veristat: Fix a memory leak for preset ENUMERATOR
Applying: selftests/bpf: Fix use-after-free in xdp_metadata test
Applying: selftests/bpf: Fix double thread join in uprobe_multi_test
Applying: selftests/bpf: Fix resource leaks caused by missing cleanups
Applying: selftests/bpf: Free bpf_object in test_sysctl
Applying: selftests/bpf: Fix array bounds warning in jit_disasm_helpers
Applying: selftests/bpf: Fix out-of-bounds array access bugs reported by ASAN
Applying: selftests/bpf: Check BPFTOOL env var in detect_bpftool_path()
Applying: selftests/bpf: Don't override SIGSEGV handler with ASAN


> 
> [...]

