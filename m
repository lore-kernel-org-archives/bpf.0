Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF4F139D
	for <bpf@vger.kernel.org>; Fri, 13 Feb 2026 00:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770941345; cv=none; b=DxlIiU1madRD67lU//w70N/qUsBf5J6N1oh2Z5qCbKBqTrXieo3siKh1ol0eAlnWhaMSpHa46XTX7F9kouSTOD4ZK7PdBfzIAADKSyZOqzZXWaf5R5JP6ac4UQ8JFZyPTJ1P8VtTsx+rlid1Ed34/Xy2y4Es8nuxJEEz85iECSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770941345; c=relaxed/simple;
	bh=BfxshD/8Qw3e0EEI4TSJiQu622lsSbfnPddOLh/f07E=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V6PbjhqDkIfer1v5tbl860hl7jnYYvyqZ3B6wcL1iqh5eHZf/X1fzyDPhlamiNtVccPnA57038CgCgPOx/ZvKLVC/5nAD1L1/oePncrFwGet2lhIte9+79+u2/cRKd+Qw8x7Ess49fW3xVYenUdnZq/EJpysM4UUHb5CH/lAhzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=uykyuuSa; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="uykyuuSa"
Message-ID: <4ff82800-2daa-4b9f-95a9-6f512859ee70@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770941340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjFAFV3KTn4DijWIYNSZs0XZegqQRmCJ54QZtqZ1EUs=;
	b=uykyuuSagakxVxlzKHK+e+/+90/apI+NvMd/gHPE89K3J2pFdKgtMZJ8qWyWeMO25IErdb
	zplLvjRRQUs1D8uu/PhJ7gJOWoqV3AB7utHtkogSXzJVBkH/uY7L5qf34AJSXndwiPa76U
	02jH6grGB4RABdrVP9dvWV6MZ4rSzqM=
Date: Thu, 12 Feb 2026 16:08:47 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 01/14] selftests/bpf: Pass through build flags
 to bpftool and resolve_btfids
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, Amery Hung <ameryhung@gmail.com>,
 Mykyta Yatsenko <yatsenko@meta.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Kernel Team <kernel-team@meta.com>
References: <20260212011356.3266753-1-ihor.solodrai@linux.dev>
 <20260212011356.3266753-2-ihor.solodrai@linux.dev>
 <CAADnVQJLWTCoUFTP9Ox3ErhcJuQBEAcnpa_Tv-3n8jL9vj2dKQ@mail.gmail.com>
 <a93dd012-8c01-43f3-ac7b-befbc2a83341@linux.dev>
Content-Language: en-US
In-Reply-To: <a93dd012-8c01-43f3-ac7b-befbc2a83341@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 2/11/26 7:08 PM, Ihor Solodrai wrote:
> 
> 
> On 2/11/26 6:39 PM, Alexei Starovoitov wrote:
>> On Wed, Feb 11, 2026 at 5:14 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>>
>>> EXTRA_* and SAN_* build flags were not correctly propagated to bpftool
>>> and resolve_btids when building selftests/bpf. This led to various
>>> build errors on attempt to build with SAN_CFLAGS="-fsanitize=address",
>>> for example.
>>>
>>> Fix the makefiles to address this:
>>>   - Pass SAN_CFLAGS/SAN_LDFLAGS to bpftool and resolve_btfids build
>>>   - Propagate EXTRA_LDFLAGS to resolve_btfids link command
>>>   - Use pkg-config to detect zlib and zstd for resolve_btfids, similar
>>>     libelf handling
>>>
>>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>>> ---
>>>  tools/bpf/resolve_btfids/Makefile    | 7 +++++--
>>>  tools/testing/selftests/bpf/Makefile | 9 +++++----
>>>  2 files changed, 10 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
>>> index 1733a6e93a07..ef083602b73a 100644
>>> --- a/tools/bpf/resolve_btfids/Makefile
>>> +++ b/tools/bpf/resolve_btfids/Makefile
>>> @@ -65,6 +65,9 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>>>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>>>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>>>
>>> +ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
>>> +ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)
>>
>> The first two patches look serious enough and justify going to bpf tree.
>> The rest can probably go via bpf as well, since we're early
>> in the merge window.
>> Would be great to have some Acks first though.
>>
>> Why add zstd here? It's not used by resolve_btfid. Why add it?
> 
> IIRC zstd is a transitive dependency of libelf.
> 
> I stumbled on a combination of build flags that caused link errors
> because of this missing.  I can find or produce an example log later
> if that'd be helpful.

Reproduced the splat. See below.

Basically, the bug here was that building selftests/bpf with
EXTRA_LDFLAGS="-static" didn't propagate -static to resolve_btfids so
zstd and co were actually linked dynamically.

After I fixed the propagation of EXTRA_LDFLAGS, the static build of
selftests would fail on linking of resolve_btfids, because of -zstd
missing:

  LINK     resolve_btfids
/usr/bin/x86_64-linux-gnu-ld.bfd: /lib/x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_compress':
(.text+0xe4): undefined reference to `ZSTD_createCCtx'
/usr/bin/x86_64-linux-gnu-ld.bfd: (.text+0x243): undefined reference to `ZSTD_compressStream2'
/usr/bin/x86_64-linux-gnu-ld.bfd: (.text+0x24e): undefined reference to `ZSTD_isError'
/usr/bin/x86_64-linux-gnu-ld.bfd: (.text+0x272): undefined reference to `ZSTD_freeCCtx'
/usr/bin/x86_64-linux-gnu-ld.bfd: (.text+0x4ff): undefined reference to `ZSTD_compressStream2'
/usr/bin/x86_64-linux-gnu-ld.bfd: (.text+0x50a): undefined reference to `ZSTD_isError'
/usr/bin/x86_64-linux-gnu-ld.bfd: (.text+0x6e1): undefined reference to `ZSTD_freeCCtx'
/usr/bin/x86_64-linux-gnu-ld.bfd: (.text+0x708): undefined reference to `ZSTD_freeCCtx'
/usr/bin/x86_64-linux-gnu-ld.bfd: (.text+0x78e): undefined reference to `ZSTD_freeCCtx'
/usr/bin/x86_64-linux-gnu-ld.bfd: (.text+0x828): undefined reference to `ZSTD_freeCCtx'
/usr/bin/x86_64-linux-gnu-ld.bfd: (.text+0x8f7): undefined reference to `ZSTD_freeCCtx'
/usr/bin/x86_64-linux-gnu-ld.bfd: /lib/x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_decompress':
(.text+0xaf7): undefined reference to `ZSTD_decompress'
/usr/bin/x86_64-linux-gnu-ld.bfd: (.text+0xb02): undefined reference to `ZSTD_isError'
/usr/bin/x86_64-linux-gnu-ld.bfd: /lib/x86_64-linux-gnu/libelf.a(elf_compress.o): in function `__libelf_decompress_elf':
(.text+0xc37): undefined reference to `ZSTD_decompress'
/usr/bin/x86_64-linux-gnu-ld.bfd: (.text+0xc42): undefined reference to `ZSTD_isError'
clang-21: error: linker command failed with exit code 1 (use -v to see invocation)
make[1]: *** [Makefile:89: /ws/linux/tools/testing/selftests/bpf/tools/build/resolve_btfids//resolve_btfids] Error 1
make: *** [Makefile:404: /ws/linux/tools/testing/selftests/bpf/tools/build/resolve_btfids/resolve_btfids] Error 2
make: *** Waiting for unfinished jobs....




