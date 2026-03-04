Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247713DA5C6
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 19:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652305; cv=none; b=s16sTl54hf5sPT/xmMF/7TrPy9GrhOkWlNjmCeXFU2cIpjjkpbnNSyxXMHModcipn+tnLdm/9bbEOr+72DNqHaMPI3a4IX3GcR+ZE+a7DMrQNQaiMbHc6j7VCDcCTsdh7vEsR13ygAJ9gDgrU4Vr+SmE3gBB6ZdmbYy4Ehk4Xeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652305; c=relaxed/simple;
	bh=klHlRSPUrcW19/cikqwSdg/fo8XZOOGT+82TaWVh2C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnRlfqUZBio/Dn0XAlGYmmdbOOnB3JJdQ65cUiThOP+i0xUSVRPjQYfxFwvG65KcCgRJWsRA4JKPfYC3QjNJLYAtq/kA4qzu+bUUFw3aSQxV7mLhM4MPFH+qmNl87K7ewe5c7xN5L+f82j6UmMGqaeEv1Gfy13Xn4kPybkxRBmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YhFfgKmF; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YhFfgKmF"
Message-ID: <073804ab-6180-4cd5-a0cc-7ab7680cdf5e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772652300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4E5nouG1FBOVXMudvOlFlS5ESes2e5w+Ttq5buwkCvA=;
	b=YhFfgKmFv3IbsPbxr+aigcDTqVbCSPTy0Wqt+pfJCdo/bv7v4oO9Iuj2oYQuK3r2yy3xhq
	ZgKBdMd09i0eXDP71CQUJ4CX15hDZQNzRRxdHjGylVfPD/5mEW+aqIIku6NxCiQpPKTIlI
	ePIVeLUAqARBY4dBTc5Amc+eaHHekvE=
Date: Wed, 4 Mar 2026 11:24:54 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v1] resolve_btfids: Drop -lzstd fallback if libzstd
 not found
To: Paul Chaignon <paul.chaignon@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Vitaly Chikunov <vt@altlinux.org>,
 bpf@vger.kernel.org, kernel-team@meta.com
References: <20260302231058.916946-1-ihor.solodrai@linux.dev>
 <aahqjs9v3PRmR6rV@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <aahqjs9v3PRmR6rV@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/4/26 9:23 AM, Paul Chaignon wrote:
> On Mon, Mar 02, 2026 at 03:10:58PM -0800, Ihor Solodrai wrote:
>> The "|| echo -lzstd" default makes zstd an unconditional link
>> dependency of resolve_btfids. On systems where libzstd-dev is not
>> installed and pkg-config fails, the linker fails:
>>
>>   ld: cannot find -lzstd: No such file or directory
>>
>> libzstd is a transitive dependency of libelf, so the -lzstd flag is
>> strictly necessary only for static builds [1].
>>
>> Drop the -lzstd fallback to enable builds on systems without
>> libzstd-dev installed.
>>
>> Reported-by: BPF CI Bot (Claude Opus 4.6) <bot+bpf-ci@kernel.org>
>> Reported-by: Vitaly Chikunov <vt@altlinux.org>
>> Closes: https://lore.kernel.org/bpf/aaWqMcK-2AQw5dx8@altlinux.org/
>> Fixes: 4021848a903e ("selftests/bpf: Pass through build flags to bpftool and resolve_btfids")
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  tools/bpf/resolve_btfids/Makefile | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
>> index ef083602b73a..5df897c881d3 100644
>> --- a/tools/bpf/resolve_btfids/Makefile
>> +++ b/tools/bpf/resolve_btfids/Makefile
>> @@ -66,7 +66,7 @@ LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>>  
>>  ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
>> -ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)
>> +ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null)
> 
> This change is currently failing in CI with "undefined reference to
> `ZSTD_xxx'" when trying to build resolve_btfids. I think this is

Hi Paul, thanks for taking a look.

I'm aware, I sent a v2 yesterday (with changed subject):
https://lore.kernel.org/bpf/20260303193954.1879948-1-ihor.solodrai@linux.dev/

Your diagnosis is correct, the HOSTPKG_CONFIG wasn't set.
I fixed that by adding a default in resolve_btfids/Makefile,
but your diff makes sense too, I think we should apply both.

> happening because the selftests use static linking with
> PKG_CONFIG='pkg-config --static' but then the same isn't done for
> resolve_btfids, so "pkg-config libelf --libs" doesn't return -lzstd.
> 
> So maybe the solution is to define HOSTPKG_CONFIG when building
> resolve_btfids, as in the following diff:
> 
> diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
> index 72a9ba41f95e..d5acbeba0383 100644
> --- a/tools/testing/selftests/bpf/Makefile
> +++ b/tools/testing/selftests/bpf/Makefile
> @@ -409,6 +409,7 @@ $(RESOLVE_BTFIDS): $(HOST_BPFOBJ) | $(HOST_BUILD_DIR)/resolve_btfids        \
>                 CC="$(HOSTCC)" LD="$(HOSTLD)" AR="$(HOSTAR)" \
>                 LIBBPF_INCLUDE=$(HOST_INCLUDE_DIR) \
>                 EXTRA_LDFLAGS='$(SAN_LDFLAGS) $(EXTRA_LDFLAGS)' \
> +               HOSTPKG_CONFIG=$(PKG_CONFIG) \
>                 OUTPUT=$(HOST_BUILD_DIR)/resolve_btfids/ BPFOBJ=$(HOST_BPFOBJ)
> 
>  # Get Clang's default includes on this system, as opposed to those seen by
> 
>>  
>>  HOSTCFLAGS_resolve_btfids += -g \
>>            -I$(srctree)/tools/include \
>> -- 
>> 2.53.0
>>
>>

