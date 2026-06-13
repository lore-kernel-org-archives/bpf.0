Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD772BE655
	for <bpf@vger.kernel.org>; Sat, 13 Jun 2026 01:37:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781314680; cv=none; b=Ox+WxM25fV4ERBiiigQcyew53UivNDuqdaaAwuti9PIJB5NRYlkLzdI2UjgEaG6/GbCtsmnVx8b/jud22TILaPbjUkTll/OyjoJqBAbDEg7/sc970YEON0xcmDhQ81az64M6D65ogdHZzL8ZNUlhyUZyrhmsRfSW+8qmWfzynwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781314680; c=relaxed/simple;
	bh=wyRW+o+K9Uf+0kugpOd3omwV5O/TbuKRz09EC5B6QvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BY92UEa8+F5PbGRTewIDhvOjRy3v3+bQDJr18yWh2qKTtm2/CM8QBEKcnuBK2CoLmmpeDtVG8bkT63v3hGq/j2Dl7Yw8yAVwLSqvvKGZDEgbrMTfuhxJFaUI90NtJ/Zjbr3ziTD3sEwmLaMXQi1HwNHg/1nT6WWxIFemmN+oIPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wnsNuCAQ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wnsNuCAQ"
Message-ID: <1ea86cfa-14ea-474b-9884-86de6bc8c7d3@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1781314666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dWqJ+Yor9x1TVbO4K0fThHQuzGVz/l6QY0CQs8Lh+6I=;
	b=wnsNuCAQGsX2H/yjgHmaUtt/0+66qQg5KUVEYx5FBQ7I1uIwUVH/D0Qa37NMDygV+9FLav
	5BrWHRhZoZEdRvMJzwcnqE3C6iq4x/O1qln6Dh233LVTv3lumCIeqQt/JmCUMxV17CmKeV
	6EBAtSXwp9oeNjyvv75zylcBHVpLtBA=
Date: Fri, 12 Jun 2026 18:37:28 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2 7/8] selftests/bpf: Use common CFLAGS for
 urandom_read
To: sashiko-reviews@lists.linux.dev, Leo Yan <leo.yan@arm.com>
Cc: bpf@vger.kernel.org
References: <20260602-tools_build_fix_zero_init_bpf_only-v2-7-c76e5250ea1c@arm.com>
 <20260602172559.B3A1D1F00898@smtp.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <20260602172559.B3A1D1F00898@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 6/2/26 10:25 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Replacing CFLAGS with COMMON_CFLAGS for urandom_read breaks cross-compilation with Clang.
> --
> 
> commit 537d69efefb1121c195758d9362eba3f31c54f36
> Author: Leo Yan <leo.yan@arm.com>
> 
> selftests/bpf: Use common CFLAGS for urandom_read
> 
> This commit introduces a COMMON_CFLAGS variable to separate general flags
> from CC-specific ones that might be incompatible with CLANG when building
> urandom_read and its shared library.
> 
>> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
>> index bc049620c7745..1e47e29ba4214 100644
>> --- a/tools/testing/selftests/bpf/Makefile
>> +++ b/tools/testing/selftests/bpf/Makefile
>> @@ -51,7 +51,7 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
>>  srctree := $(patsubst %/,%,$(dir $(srctree)))
>>  endif
>>  
>> -CFLAGS += -g $(OPT_FLAGS) -rdynamic -std=gnu11				\
>> +COMMON_CFLAGS = -g $(OPT_FLAGS) -rdynamic -std=gnu11				\
> 
> [Severity: Low]
> Does this change break cross-compilation with Clang?

Please check this, looks plausible.

> 
> By defining COMMON_CFLAGS from scratch without including the pre-existing
> CFLAGS, this drops any earlier contents from the urandom_read build.
> This strips CLANG_CROSS_FLAGS (which is appended to CFLAGS earlier by
> tools/scripts/Makefile.include), depriving Clang of essential
> cross-compilation arguments like --sysroot and --gcc-toolchain.
> 
> Does this also inadvertently ignore any user-provided CFLAGS?
> 
> [ ... ]
> 
>> @@ -261,7 +261,7 @@ endif
>>  $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom_read.map
>>  	$(call msg,LIB,,$@)
>>  	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
>> -		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) \
>> +		     $(filter-out -static,$(COMMON_CFLAGS) $(LDFLAGS)) \
> 
> [Severity: Low]
> When replacing CFLAGS with COMMON_CFLAGS here for the shared library build,
> does this remove the required sysroot and toolchain cross-compilation flags?
> 
> [ ... ]
> 
>> @@ -271,7 +271,7 @@ $(OUTPUT)/liburandom_read.so: urandom_read_lib1.c urandom_read_lib2.c liburandom
>>  $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_read.so
>>  	$(call msg,BINARY,,$@)
>>  	$(Q)$(CLANG) $(CLANG_TARGET_ARCH) \
>> -		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
>> +		     $(filter-out -static,$(COMMON_CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
> 
> [Severity: Low]
> Similarly, does the urandom_read build rule also lose these required
> cross-compilation flags when using COMMON_CFLAGS?
> 

