Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C3D5390C84
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772569075; cv=none; b=t0HQCKcsY3KfHlxzTO4EuhSP/5Q2lrgEg2TUgEO/v1CWVf7VF27XYpxS0V77HHVNad0GBzuibP6HknJ7moTmj6AoXcVAKRbLBT3QhA69VTSHPGOMeIxiUVE2buJWihpBh2aGjMqiSBI2/WYq+6XAenyT9kTRKI4PaOXr47sU7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772569075; c=relaxed/simple;
	bh=NQbsMGmf5+ykUmsC0KXPVoOlpRSjg8unR+tV/T0jsOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NYGGMfJvm/MzQd1HCQKd/cTl4Ldv7v3SHmMqkPiV3/dB0q7DDz/v7K2f1H3W4LjuCAwRFoCj6mBdhVjealrThNDP7j0dLKSPCK/jCXczQWbviIYZ0OIPIJ4lX17YQMGqoMgEjImIdYAsfX0xByCjLnejZOvcea7nSzXKJX5CW0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VnDTEp46; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VnDTEp46"
Message-ID: <609c1db8-e674-4d65-8082-43e9fa4fbc9a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772569071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UlP8bZ45vbIWhoTp733e81PmNEq8zFu8uoAFbKeun4w=;
	b=VnDTEp46bC8nA2iCfPvlW+p/2IuCd9diM7L3ZQvh0EK7v4tBdil48svdWDBEkFkb2olBcS
	a5jzyCdK8BPaz/spZrlth41bo0FkUodPFQZ9wup2HZZ9Y7ExNlboaBi6uIMCAJy4eunouP
	6F7nBuUsXIcdUYq3jVS69H+8z10syXI=
Date: Tue, 3 Mar 2026 12:17:43 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf v2] resolve_btfids: Fix linker flags detection
To: Vitaly Chikunov <vt@altlinux.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
 kernel-team@meta.com
References: <20260303193954.1879948-1-ihor.solodrai@linux.dev>
 <aac-hefhJ8znydSb@altlinux.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <aac-hefhJ8znydSb@altlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/3/26 12:06 PM, Vitaly Chikunov wrote:
> Ihor,
> 
> [...]
>>  
>>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>> +
>> +ifneq ($(filter -static,$(EXTRA_LDFLAGS)),)
>> +LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs --static 2>/dev/null || echo -lelf -lzstd)
>> +else
>>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>> +endif
>>  
>>  ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
> 
> Perhaps, this line is not needed either, as `pkg-config libelf --libs
> --static` will add -lz.

The -lz has been there forever too [1], and a duplicate lib flag is
harmless here.  We also want to have reasonable defaults if pkg-config
is not available.

That said, the same can be achieved with the diff pasted below.

I don't mind either way, let's see if maintainers have an opinion.

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index 7672208f65e4..a7dac1587344 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -66,13 +66,11 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
 LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
 
 ifneq ($(filter -static,$(EXTRA_LDFLAGS)),)
-LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs --static 2>/dev/null || echo -lelf -lzstd)
+LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs --static 2>/dev/null || echo -lelf -lzstd -lz)
 else
-LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
+LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf -lz)
 endif
 
-ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
-
 HOSTCFLAGS_resolve_btfids += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
@@ -81,7 +79,7 @@ HOSTCFLAGS_resolve_btfids += -g \
           $(LIBELF_FLAGS) \
           -Wall -Werror
 
-LIBS = $(LIBELF_LIBS) $(ZLIB_LIBS)
+LIBS = $(LIBELF_LIBS)
 
 export srctree OUTPUT HOSTCFLAGS_resolve_btfids Q HOSTCC HOSTLD HOSTAR
 include $(srctree)/tools/build/Makefile.include


[1] https://lore.kernel.org/bpf/20200711215329.41165-2-jolsa@kernel.org/

> 
> Thanks,
> 
>> -ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)
>>  
>>  HOSTCFLAGS_resolve_btfids += -g \
>>            -I$(srctree)/tools/include \
>> @@ -76,7 +81,7 @@ HOSTCFLAGS_resolve_btfids += -g \
>>            $(LIBELF_FLAGS) \
>>            -Wall -Werror
>>  
>> -LIBS = $(LIBELF_LIBS) $(ZLIB_LIBS) $(ZSTD_LIBS)
>> +LIBS = $(LIBELF_LIBS) $(ZLIB_LIBS)
>>  
>>  export srctree OUTPUT HOSTCFLAGS_resolve_btfids Q HOSTCC HOSTLD HOSTAR
>>  include $(srctree)/tools/build/Makefile.include
>> -- 
>> 2.53.0

