Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B30FA2877C3
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 18:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772474530; cv=none; b=WABLcniiQVEcvg+DDxJhDwbzHdV3lO9Nu+gQcu7aQrhwdkOHuOYBxz9DQo0Am+j632jbsFup8J/pVmCtjgrHaC7xrS+6NTdC1ZJDawnJxD7/lNc6+kXeW2g9OleqjfkuZnh5vOljirP4PymeE20Brw5T0Gm3l0ecM17D7+qsk8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772474530; c=relaxed/simple;
	bh=cDjmIGXV9EOYKQpoAVCypqaRk57dKfqdg3E9Hq2diH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZK01EgQmq/Vi5fglKCJ9IBqSV11qW6U40+IMY1cqJxcx4HqXPn1OYsVuHIf9QYc9rds8iUqS5eVN+3hfyhkD3rDUj3726dqyUXGBIjV2Sl+wuh09m5ijpu3rw1q/BE8BKiNjpCa4QaB1z5nVi1b5XQ7KT4akIhkMLjOsKF0LXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kpGRcjNw; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kpGRcjNw"
Message-ID: <d6fda426-b59f-48d6-bbe7-b2069a7e352e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772474526;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zh0woySBZuOpgvtIn9Jxdj4IpifRv6eNLtbIgZFC5/M=;
	b=kpGRcjNwLl++u0VFFylWfoMNj0w75gTEfaSQsP2qHbRh8RyGkUvm606Cjyajke+GuJp4tj
	BpN6lAy+pl8hYOGY3vK1akJNTyGH+WlLLrDeFC4/oZPBEoxScZd+kZEshKltu/3Wrnm2xK
	vNr7JJOuUwHIpgqlCwW3yPLtJaP54ag=
Date: Mon, 2 Mar 2026 10:01:59 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v3 01/15] selftests/bpf: Pass through build flags to
 bpftool and resolve_btfids
To: Vitaly Chikunov <vt@altlinux.org>
Cc: bot+bpf-ci@kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, eddyz87@gmail.com, olsajiri@gmail.com,
 yatsenko@meta.com, alexis.lothore@bootlin.com, ameryhung@gmail.com,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 martin.lau@kernel.org, yonghong.song@linux.dev, clm@meta.com
References: <20260220222604.1155148-2-ihor.solodrai@linux.dev>
 <edac02ca77865be9cc18b013f5209a8fb0d8a4c443ce16dce8ad368a9ecefe05@mail.kernel.org>
 <789af3df-291c-410d-89d8-ee7b12479798@linux.dev>
 <aaWqMcK-2AQw5dx8@altlinux.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <aaWqMcK-2AQw5dx8@altlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/2/26 7:22 AM, Vitaly Chikunov wrote:
> Ihor,
> 
> On Fri, Feb 20, 2026 at 08:23:51PM -0800, Ihor Solodrai wrote:
>>
>>
>> On 2/20/26 2:57 PM, bot+bpf-ci@kernel.org wrote:
>>>> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
>>>> index 1733a6e93a07..ef083602b73a 100644
>>>> --- a/tools/bpf/resolve_btfids/Makefile
>>>> +++ b/tools/bpf/resolve_btfids/Makefile
>>>> @@ -65,6 +65,9 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>>>>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>>>>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>>>>
>>>> +ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
>>>> +ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)
>>>
>>> The "|| echo -lzstd" fallback makes zstd an unconditional link
>>> dependency. On systems where libzstd-dev is not installed, pkg-config
>>> fails and the fallback provides -lzstd, but the linker cannot find the
>>> library and the build fails.
>>>
>>> bpftool handles the same transitive dependency conditionally via a
>>> feature test:
>>>
>>> tools/bpf/bpftool/Makefile:
>>>     ifeq ($(feature-libelf-zstd),1)
>>>     LIBS += -lzstd
>>>     LIBS_BOOTSTRAP += -lzstd
>>>     endif
>>>
>>> Would it be safer to drop the fallback here so ZSTD_LIBS is empty
>>> when zstd is not available?
>>>
>>>     ZSTD_LIBS := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null)
>>>
>>> This would still link zstd when present (needed for the static linking
>>> case where libelf.a pulls in ZSTD symbols from elf_compress.o), but
>>> avoid breaking dynamic builds on systems without libzstd-dev.
>>
>> [...]
>>
>>
>> So, while AI may be technically correct that the build will fail if
>> libelf is installed and libzstd is not, it seems a far-fetched
>> situation, given that libelf depends on libzstd.
> 
> This is not far-fetched, and we have build failure for v7.0-rc2 due to
> this.
> 
>   ld: cannot find -lzstd: No such file or directory
> 
> Even though libelf is linked with libzstd, this does not imply
> libzstd-devel (with headers and so library) is there when building.

Does AI's suggestion make sense in your case then?
That is, make ZSTD_LIBS empty in case pkg-config didn't find libzstd?

I'm happy to fix this, the build shouldn't fail unless it must.

But I am curious how and why an environment building Linux with BTF
(requiring build and run of resolve_btfids), which needs libelf-dev
and presumably its dependencies, would exclude/avoid installing
libzstd-dev?

Thanks.

> 
> Thanks,
> 
>>
>> I think we can leave the default -lzstd to have an explicit
>> dependency in the Makefile.
>>
>>
>>>
>>> [ ... ]


