Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA43EBF36
	for <bpf@vger.kernel.org>; Thu, 12 Feb 2026 03:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770865718; cv=none; b=CfrpaCMSNdD6Dhi3Sey5kpC0VaXpfqD7/l6DYQBY9KOR+FHmGCMqVQYEn00Oh8gBF6J0dzmzbwCPNAa+SAG7XIW/7V4sNFqDePk6DZPOpE+huL9BHvcq+QV4ImL8fJDMk1NDRZWOTuSLNQUcyzAewurFm4JwH9W/0++cwKJZxtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770865718; c=relaxed/simple;
	bh=dOgP/ko1U+rY3EUlBEXa62ismysxFgdt+DOXLciunhs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hxw5hOenLZTb0MbCIIlYVWF5SvB618Xq+OuTdtfzRW5+3NwoCgrr8DHvQfaKYDjEeleCqwQWj4Tmo5vsePuEOfJ8r9DWkBYWoF00IJBxXiFmZJc+zAaCqWr9XuC3YoN8vzQPV//ch8RT/ogmpYCWuvsmoraKp2iKiMsJf+yfJYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XNDbGrxO; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XNDbGrxO"
Message-ID: <a93dd012-8c01-43f3-ac7b-befbc2a83341@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770865714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QoctJgPiWLWzP+Zq9tAn1lvI51PfuPdPpkQPguU0AKQ=;
	b=XNDbGrxOpmI0/WIRNpLeJ8BOfot055+nKtMi430I32aIL0lZjCxFj3CMOh87/Ipk+vOPW0
	621DI+mkXZh9ynVTnjhnyTh84jPm60k3VljXHaO65XBLwMqM/rjpOAQ59/wfzqPghe2URn
	IHn4tJVKN8ZmHAgZvuHRGmABVwHrnXU=
Date: Wed, 11 Feb 2026 19:08:27 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v1 01/14] selftests/bpf: Pass through build flags
 to bpftool and resolve_btfids
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
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <CAADnVQJLWTCoUFTP9Ox3ErhcJuQBEAcnpa_Tv-3n8jL9vj2dKQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 2/11/26 6:39 PM, Alexei Starovoitov wrote:
> On Wed, Feb 11, 2026 at 5:14 PM Ihor Solodrai <ihor.solodrai@linux.dev> wrote:
>>
>> EXTRA_* and SAN_* build flags were not correctly propagated to bpftool
>> and resolve_btids when building selftests/bpf. This led to various
>> build errors on attempt to build with SAN_CFLAGS="-fsanitize=address",
>> for example.
>>
>> Fix the makefiles to address this:
>>   - Pass SAN_CFLAGS/SAN_LDFLAGS to bpftool and resolve_btfids build
>>   - Propagate EXTRA_LDFLAGS to resolve_btfids link command
>>   - Use pkg-config to detect zlib and zstd for resolve_btfids, similar
>>     libelf handling
>>
>> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
>> ---
>>  tools/bpf/resolve_btfids/Makefile    | 7 +++++--
>>  tools/testing/selftests/bpf/Makefile | 9 +++++----
>>  2 files changed, 10 insertions(+), 6 deletions(-)
>>
>> diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
>> index 1733a6e93a07..ef083602b73a 100644
>> --- a/tools/bpf/resolve_btfids/Makefile
>> +++ b/tools/bpf/resolve_btfids/Makefile
>> @@ -65,6 +65,9 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
>>  LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
>>  LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
>>
>> +ZLIB_LIBS  := $(shell $(HOSTPKG_CONFIG) zlib --libs 2>/dev/null || echo -lz)
>> +ZSTD_LIBS  := $(shell $(HOSTPKG_CONFIG) libzstd --libs 2>/dev/null || echo -lzstd)
> 
> The first two patches look serious enough and justify going to bpf tree.
> The rest can probably go via bpf as well, since we're early
> in the merge window.
> Would be great to have some Acks first though.
> 
> Why add zstd here? It's not used by resolve_btfid. Why add it?

IIRC zstd is a transitive dependency of libelf.

I stumbled on a combination of build flags that caused link errors
because of this missing.  I can find or produce an example log later
if that'd be helpful.
