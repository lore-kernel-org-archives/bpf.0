Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795487800;
	b=4y+PeXYQhJ1XHnMXV6RjcALO2axRqT4Ig6OEg5BYOAkVva7iCcgwlxpQ+Ziyhp6HS4Ea
	 idwYDVDQjXn1dqEMv6+YGHtXyB8YMlFvKkhVwRjN1LkbeB74YSrLUvfqebra1m4nOjQcU
	 qcg0ZQrNYzlyvX/Kc8Wiz+3vrw1vWLY90JJ74K1EfXCSvqix0q0gAOA9DKHClI8j0dmAF
	 7TZolw1U4keSM1mA5yHRNh6AkpVPrzMpsGcLtMV7SJ73QMTXiUnYEHX/SNlyPXosgAyOV
	 aBSoWLSWhyYEeSA6Lt7qtqQxQgJsP0ejaGMefkziIWJigkgUGjp7S0/tZj7uCaS4GkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795487800;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=r+8Ngo0gK43HrNVOTTX+GCIR7fu3LWCqYzJwfEwKm9k=;
	b=VuxOQuv+0yj8Vuh7ckdxLlzuPlNTxi3lmlFWs6uExOzfgi9sBfhRhLOip18mI7k1TR0u
	 2UeifOMTsgpWe3A3y/S9gP8Hvryp1qjYfaM+SIppnk2gL6A0QoS5fc1Ca1+Fi2li5Wte5
	 gJXTNXqpFjAbmZLKUJFpPgMfvK/x9vtTvusmgmF7oantEA6GwemOXczeyVKfA51f27q5y
	 FGyORTcvbgZ60wBiUbN+9+SguoBiow45mJ18X9cXO9a25sTNlK6XjgIEtRsaYHkCgiuvt
	 j7iG7wqTFSVP9oweh0uIg3KNWBrctaL8N6ngKfZdTSY+aEvRwf28MswEJxobJHURKLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W4lX+Gt1;
	arc=none smtp.remote-ip=95.215.58.246
Received: from mta1.migadu.com (out-246.mta1.migadu.com [95.215.58.246])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A11C606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 02:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A11C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=W4lX+Gt1
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=RVldUkVQy9+eJanimaczsU6B9NEYR39s/tQb0uSpwXY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795487798; v=1; x=1796092598;
 b=W4lX+Gt1lDDTMqAt6abzg5S8ORq9trJR43ccrD9rrflOfwQndER1y5dMohbCdWdDMhGO09wZ
 kruRcB4wdvfEGXfFVr7DR6leOarqfTAz9coO0DK6aUMDY1EdMqSH56+3xchL4W0EX7NJkneCC0b
 K9fh3HB01uKq31fSYgDnlFkY=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 3975d8e5a96d4352;
	Tue, 24 Nov 2026 02:36:37 +0000
X-Mizu-Trace-ID: 3975d8e5a96d4352
X-Migadu-Flow: FLOW_OUT
Message-ID: <9469ded7-6a6b-4753-9165-a5224660529f@linux.dev>
Date: Mon, 23 Nov 2026 18:36:30 -0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] kbuild, bpf: Remove pahole version checks
 below v1.24
To: Alan Maguire <almagui@kernel.org>, bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman
 <eddyz87@gmail.com>, kernel-team@fb.com
References: <20261123231053.2538168-1-yonghong.song@linux.dev>
 <20261123231058.2538362-1-yonghong.song@linux.dev>
 <a29d9ea3-1d36-46e8-914a-32753afb0725@kernel.org>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <a29d9ea3-1d36-46e8-914a-32753afb0725@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/23/26 3:18 PM, Alan Maguire wrote:
> On 11/23/26 11:10 PM, Yonghong Song wrote:
>> The previous patch makes CONFIG_DEBUG_INFO_BTF require pahole v1.24, so
>> the Kconfig checks for an older pahole always pass with
>> CONFIG_DEBUG_INFO_BTF.
>>
>> Remove CONFIG_PAHOLE_HAS_LANG_EXCLUDE (pahole v1.24), which is always
>> set with CONFIG_DEBUG_INFO_BTF. Drop it from the dependency of
>> CONFIG_RUST on !CONFIG_DEBUG_INFO_BTF, and always pass
>> --lang_exclude=rust in scripts/Makefile.btf, which is only included
>> with CONFIG_DEBUG_INFO_BTF.
>>
>> CONFIG_PAHOLE_HAS_BTF_TAG (pahole v1.23) is still needed, since
>> btf_type_tag is only used with clang, but it no longer needs the pahole
>> version. Every user of it also checks CONFIG_DEBUG_INFO_BTF, so make it
>> depend on CONFIG_CC_IS_CLANG only.
>>
>> The pahole flags and the resulting config are unchanged, except that
>> CONFIG_PAHOLE_HAS_LANG_EXCLUDE is gone.
>>
>> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
> one suggestion below, but
>
> Acked-by: Alan Maguire <almagui@kernel.org>
>
>> ---
>>   init/Kconfig         |  2 +-
>>   lib/Kconfig.debug    | 12 +-----------
>>   scripts/Makefile.btf |  2 +-
>>   3 files changed, 3 insertions(+), 13 deletions(-)
>>
>> diff --git a/init/Kconfig b/init/Kconfig
>> index c8a7cfa60a6e..ca7f20462d0c 100644
>> --- a/init/Kconfig
>> +++ b/init/Kconfig
>> @@ -2065,7 +2065,7 @@ config RUST
>>   	depends on !MODVERSIONS || GENDWARFKSYMS
>>   	depends on !GCC_PLUGIN_RANDSTRUCT
>>   	depends on !RANDSTRUCT
>> -	depends on !DEBUG_INFO_BTF || (PAHOLE_HAS_LANG_EXCLUDE && !LTO)
>> +	depends on !DEBUG_INFO_BTF || !LTO
>>   	depends on !CFI || HAVE_CFI_ICALL_NORMALIZE_INTEGERS_RUSTC
>>   	select CFI_ICALL_NORMALIZE_INTEGERS if CFI
>>   	depends on !KASAN || CC_IS_CLANG
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index 9479034afe5a..c6123d52576e 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -409,22 +409,12 @@ config DEBUG_INFO_BTF
>>   	  DWARF type info into equivalent deduplicated BTF type info.
>>   
>>   config PAHOLE_HAS_BTF_TAG
>> -	def_bool PAHOLE_VERSION >= 123
>> -	depends on CC_IS_CLANG
>> +	def_bool CC_IS_CLANG
>>   	help
>>   	  Decide whether pahole emits btf_tag attributes (btf_type_tag and
>>   	  btf_decl_tag) or not. Currently only clang compiler implements
>>   	  these attributes, so make the config depend on CC_IS_CLANG.
>>
> While we're in the area, should we fix this to reflect that gcc has BTF tag
> support now?

I am not an expert for gcc BTF tag thing. I guess some testing are needed if
we want to removing 'depends on CC_IS_CLANG'. This can be a follow-up.

>> -config PAHOLE_HAS_LANG_EXCLUDE
>> -	def_bool PAHOLE_VERSION >= 124
>> -	help
>> -	  Support for the --lang_exclude flag which makes pahole exclude
>> -	  compilation units from the supplied language. Used in Kbuild to
>> -	  omit Rust CUs which are not supported in version 1.24 of pahole,
>> -	  otherwise it would emit malformed kernel and module binaries when
>> -	  using DEBUG_INFO_BTF_MODULES.
>> -
>>   config PAHOLE_HAS_INLINE
>>   	def_bool PAHOLE_VERSION >= 132
>>   	help
>> diff --git a/scripts/Makefile.btf b/scripts/Makefile.btf
>> index 02ff1702e1e8..8cd8c88d4580 100644
>> --- a/scripts/Makefile.btf
>> +++ b/scripts/Makefile.btf
>> @@ -20,7 +20,7 @@ pahole-flags-$(call test-ge, $(pahole-ver), 131) += --btf_features=layout
>>   
>>   endif
>>   
>> -pahole-flags-$(CONFIG_PAHOLE_HAS_LANG_EXCLUDE)		+= --lang_exclude=rust
>> +pahole-flags-y						+= --lang_exclude=rust
>>   
>>   btf-inline := $(CONFIG_DEBUG_INFO_BTF_INLINE)
>>   ifneq ($(btf-inline),)

