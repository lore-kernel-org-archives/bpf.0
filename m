Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F3731E858
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 22:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772491342; cv=none; b=LlkPwWc3+cohfkJ/mBwnzCoiYSj84tZqc7UsqW3bKnNq9qOb9TQ/Nkbhtv/0+c48c0N1xkPiTqSlNC6/k0B3XrsfIWU0oL0QPJ5rEyw/x61G6NEbXwXIaUurIh62xyhx5N5ihcvCARY1DqEcCwDsehB6PdJfMdwzXdpivR4NyUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772491342; c=relaxed/simple;
	bh=uIXxlCxM8K3KnIfXGOIzqjKsZTq3mjFUNPh4aMH4+eM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pv93VtrjQfkxTnpBkrkCa+2memoUFCPiDwscbAEVtkSi31PO5J6GeX0wyTAKF2cOZKcQo6OitLYCRy6shx27vuMnGgJgbMn7st2DGPd5cM5uj74cgMHcAgDQCvFZGt2IwCSjdukSUvEcnCCMdkhjyUPkTg8P8sDxKqUUugOIG9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PZNeNCNM; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PZNeNCNM"
Message-ID: <de42bb10-dafd-45da-97fe-b59be487f30b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772491338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hGo15nkryHUBkHLvQKlc3e8ZpSUBd+CCPOefqDJ25zk=;
	b=PZNeNCNMtO+jzv87j1MV/ETBDAwHXuqaspsSLVEI2WpHy5e+DOMa3+DncMn82JQocJnPZE
	DrmlgSABp599yyHY6g8URW3QQ9sN/h27Dz6nVc3PSNoJ+bz4dshcTv/UFIJKj2oCQuBhJ1
	ko6z0yOqQaLWLYh2RzUlACh58QgepKU=
Date: Mon, 2 Mar 2026 14:42:11 -0800
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
 <d6fda426-b59f-48d6-bbe7-b2069a7e352e@linux.dev>
 <aaXwaMCIm9UZUx9O@altlinux.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <aaXwaMCIm9UZUx9O@altlinux.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 3/2/26 12:27 PM, Vitaly Chikunov wrote:
> Ihor,
> 
> On Mon, Mar 02, 2026 at 10:01:59AM -0800, Ihor Solodrai wrote:
>> On 3/2/26 7:22 AM, Vitaly Chikunov wrote:
>>> On Fri, Feb 20, 2026 at 08:23:51PM -0800, Ihor Solodrai wrote:
>>>> On 2/20/26 2:57 PM, bot+bpf-ci@kernel.org wrote:
>>>>>> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
>>>>>> index 1733a6e93a07..ef083602b73a 100644
>>>>>> --- a/tools/bpf/resolve_btfids/Makefile
>>>>>> +++ b/tools/bpf/resolve_btfids/Makefile
>>>>>> @@ -65,6 +65,9 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>>>>>>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>>>>>>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>>>>>>
>>>>>> +ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
>>>>>> +ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)
>>>>>
>>>>> The "|| echo -lzstd" fallback makes zstd an unconditional link
>>>>> dependency. On systems where libzstd-dev is not installed, pkg-config
>>>>> fails and the fallback provides -lzstd, but the linker cannot find the
>>>>> library and the build fails.
>>>>>
>>>>> bpftool handles the same transitive dependency conditionally via a
>>>>> feature test:
>>>>>
>>>>> tools/bpf/bpftool/Makefile:
>>>>>     ifeq ($(feature-libelf-zstd),1)
>>>>>     LIBS += -lzstd
>>>>>     LIBS_BOOTSTRAP += -lzstd
>>>>>     endif
>>>>>
>>>>> Would it be safer to drop the fallback here so ZSTD_LIBS is empty
>>>>> when zstd is not available?
>>>>>
>>>>>     ZSTD_LIBS := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null)
>>>>>
>>>>> This would still link zstd when present (needed for the static linking
>>>>> case where libelf.a pulls in ZSTD symbols from elf_compress.o), but
>>>>> avoid breaking dynamic builds on systems without libzstd-dev.
>>>>
>>>> [...]
>>>>
>>>>
>>>> So, while AI may be technically correct that the build will fail if
>>>> libelf is installed and libzstd is not, it seems a far-fetched
>>>> situation, given that libelf depends on libzstd.
>>>
>>> This is not far-fetched, and we have build failure for v7.0-rc2 due to
>>> this.
>>>
>>>   ld: cannot find -lzstd: No such file or directory
>>>
>>> Even though libelf is linked with libzstd, this does not imply
>>> libzstd-devel (with headers and so library) is there when building.
>>
>> Does AI's suggestion make sense in your case then?
>> That is, make ZSTD_LIBS empty in case pkg-config didn't find libzstd?
>>
>> I'm happy to fix this, the build shouldn't fail unless it must.
>>
>> But I am curious how and why an environment building Linux with BTF
>> (requiring build and run of resolve_btfids), which needs libelf-dev
>> and presumably its dependencies, would exclude/avoid installing
>> libzstd-dev?
> 
> Are you providing -lzstd just to link with libelf? I don't think you need to

An explicit -lzstd flag was added to enable a static build [1].

> care about zstd in that case. libelf is already linked with libzstd. If you
> don't use libzstd functions yourself you don't need to link with -lzstd.
> 
> Example build without -lzstd:
> 
>   builder@x86_64:~/RPM/BUILD/kernel-image-7.0-rc2$ grep zstd tools/bpf/resolve_btfids/Makefile
>   ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null)
> 
>   builder@x86_64:~/RPM/BUILD/kernel-image-7.0-rc2$ ldd ./tools/bpf/resolve_btfids/resolve_btfids
> 	  linux-vdso.so.1 (0x00007ff8b2329000)
> 	  libelf.so.1 => /lib64/libelf.so.1 (0x00007ff8b2287000)
> 	  libz.so.1 => /lib64/libz.so.1 (0x00007ff8b2269000)
> 	  libc.so.6 => /lib64/libc.so.6 (0x00007ff8b206e000)
> 	  libzstd.so.1 => /lib64/libzstd.so.1 (0x00007ff8b1fc8000)
> 	  /lib64/ld-linux-x86-64.so.2 (0x00007ff8b232b000)
>   builder@x86_64:~/RPM/BUILD/kernel-image-7.0-rc2$ rpm -q libzstd
>   libzstd-1.5.5-alt2.x86_64
>   builder@x86_64:~/RPM/BUILD/kernel-image-7.0-rc2$ rpm -q libzstd-devel
>   package libzstd-devel is not installed
> 
> lib*-devel/-dev packages only required if your source is directly using the
> target lib, in other causes this is already handled.

The issue that AI has raised is whether to leave -lzstd link flag by
default or not. I decided to leave it on the assumption that the
environments building Linux with BTF (hence building and running
resovle_btfids) would have libelf-dev installed (because -lelf has
been a requirement forever [2]), and libzstd-dev is its dependency.

I checked a few recent distros, all of them have libzstd-dev as a
direct dependency of libelf-dev, which supports my assumption:

  # Fedora
  $ dnf repoquery --providers-of=depends elfutils-libelf-devel
  Updating and loading repositories:
  Repositories loaded.
  elfutils-libelf-0:0.194-1.fc43.i686
  elfutils-libelf-0:0.194-1.fc43.x86_64
  libzstd-devel-0:1.5.7-2.fc43.i686
  libzstd-devel-0:1.5.7-2.fc43.x86_64
  pkgconf-pkg-config-0:2.3.0-3.fc43.i686
  pkgconf-pkg-config-0:2.3.0-3.fc43.x86_64
  zlib-ng-compat-devel-0:2.3.3-1.fc43.i686
  zlib-ng-compat-devel-0:2.3.3-1.fc43.x86_64

  # Ubuntu
  $ apt info libelf-dev
  Package: libelf-dev
  Version: 0.190-1.1ubuntu0.1
  Priority: optional
  Section: libdevel
  Source: elfutils
  Origin: Ubuntu
  Maintainer: Ubuntu Developers <ubuntu-devel-discuss@lists.ubuntu.com>
  Original-Maintainer: Debian Elfutils Maintainers <debian-gcc@lists.debian.org>
  Bugs: https://bugs.launchpad.net/ubuntu/+filebug
  Installed-Size: 385 kB
  Depends: libelf1t64 (= 0.190-1.1ubuntu0.1), zlib1g-dev, libzstd-dev
  Conflicts: libelfg0-dev
  [...]

  # Debian
  $ apt info libelf-dev
  Package: libelf-dev
  Version: 0.192-4
  Priority: optional
  Section: libdevel
  Source: elfutils
  Maintainer: Debian Elfutils Maintainers <debian-gcc@lists.debian.org>
  Installed-Size: 420 kB
  Depends: libelf1t64 (= 0.192-4), zlib1g-dev, libzstd-dev
  Conflicts: libelfg0-dev
  [...]


Of course it's plausible to have a system where libelf-dev is present
while libzstd-dev is not, as demonstrated by you running one.

Anyways this is easy to fix, I'll send a patch shortly.

[1] https://lore.kernel.org/bpf/4ff82800-2daa-4b9f-95a9-6f512859ee70@linux.dev/
[2] https://lore.kernel.org/bpf/20200711215329.41165-2-jolsa@kernel.org/


> 
> Thanks,
> 
>>
>> Thanks.
>>
>>>
>>> Thanks,
>>>
>>>>
>>>> I think we can leave the default -lzstd to have an explicit
>>>> dependency in the Makefile.
>>>>
>>>>
>>>>>
>>>>> [ ... ]
>>

