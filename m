Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97134A2F
	for <bpf@vger.kernel.org>; Thu, 21 Mar 2024 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711063824; cv=none; b=GzAaEljbX/wXEgV653EJkozosz+otW/NNFWjxDiA9H8pwdcuUI3nkxzOzQIJe94MQkV4yoIeiE1NF37UPQu6w2zgev1KBrX832/OIr7X3htXHVkcu6MghQg3eS0OqhLkmyaIRT9AwNBttWFePb6JM+A0wwgySVAADhYm4B/ZCdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711063824; c=relaxed/simple;
	bh=+iwbmtAJP90jjSvoeQzy7BhGDR7QGKSXSv//kR6Y4Ok=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BE0PqiYEhHNqxTeWQJ+gE4/uf06isqqQiz9ygAY5dzA5WY6ZLKrRP25z2lMpwCxlMS6rsf8Nk/oPsWS2LrziCbGhEgvYB80qD4oOqu7Q4y81S0XV03T/vI8bIMXsuVNNX3fFDHqiPD2jvP8ATwM4KIG6t0Yuv45T1cSnoJZnKSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MZNSEQs5; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MZNSEQs5"
Message-ID: <0be8711f-31cb-4bfa-8501-4ad11e34b09a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711063819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JUKRlKfRws+/FxXAEZkSJcbbjD61bO3gnsZWEBPgNek=;
	b=MZNSEQs5otXzS0VjwkryDeKsKBQQ9QbgQN+uBW+PB5poxTPY396E4EAYBaI8N63JGrC43Z
	zncO/c6ofwcBjM6bXLlpx+v+4Q/KBPGdxpSMEEUI/SALRwjbn+EqS3SJglHdM0DEHWAPGn
	WwNZJlsyGGyc0BGqpktbEgkpemfG7Dk=
Date: Thu, 21 Mar 2024 16:30:11 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v2] bpf: fix warning for crash_kexec
Content-Language: en-GB
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Hari Bathini <hbathini@linux.ibm.com>
Cc: bpf@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Kexec-ml <kexec@lists.infradead.org>, Baoquan He <bhe@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, Jiri Olsa <jolsa@kernel.org>,
 Stanislav Fomichev <sdf@google.com>
References: <20240319080152.36987-1-hbathini@linux.ibm.com>
 <CAEf4BzYpbQdjt+QBpbOPWr9tqErOhtMjb8gi_gZewubpUPgWGg@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <CAEf4BzYpbQdjt+QBpbOPWr9tqErOhtMjb8gi_gZewubpUPgWGg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On 3/19/24 3:56 PM, Andrii Nakryiko wrote:
> On Tue, Mar 19, 2024 at 1:02 AM Hari Bathini <hbathini@linux.ibm.com> wrote:
>> With [1], crash dump specific code is moved out of CONFIG_KEXEC_CORE
>> and placed under CONFIG_CRASH_DUMP, where it is more appropriate.
>> And since CONFIG_KEXEC & !CONFIG_CRASH_DUMP build option is supported
>> with that, it led to the below warning:
>>
>>    "WARN: resolve_btfids: unresolved symbol crash_kexec"
>>
>> Fix it by using the appropriate #ifdef.
>>
>> [1] https://lore.kernel.org/all/20240124051254.67105-1-bhe@redhat.com/
>>
>> Acked-by: Baoquan He <bhe@redhat.com>
>> Fixes: 29fd9ae62910 ("crash: split crash dumping code out from kexec_core.c")
> I don't think either bpf or bpf-next have this commit just yet, so
> landing it in the bpf/bpf-next tree doesn't make much sense. It
> probably would be best to land it through the tree which does the
> CONFIG_KEXEC_CORE -> CONFIG_CRASH_DUMP change in kernel/Makefile.

With bpf-next, I found the config at kernel/Kconfig.kexec:

config CRASH_DUMP
         bool "kernel crash dumps"
         depends on ARCH_SUPPORTS_CRASH_DUMP
         select CRASH_CORE
         select KEXEC_CORE
         help

...

> pw-bot: cr
>
>> Acked-by: Jiri Olsa <jolsa@kernel.org>
>> Acked-by: Stanislav Fomichev <sdf@google.com>
>> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
>> ---
>>
>> Changes in v2:
>> * Updated changelog.
>> * Added Fixes and Acked-by tags.
>>
>>
>>   kernel/bpf/helpers.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index a89587859571..449b9a5d3fe3 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2548,7 +2548,7 @@ __bpf_kfunc void bpf_throw(u64 cookie)
>>   __bpf_kfunc_end_defs();
>>
>>   BTF_KFUNCS_START(generic_btf_ids)
>> -#ifdef CONFIG_KEXEC_CORE
>> +#ifdef CONFIG_CRASH_DUMP
>>   BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>>   #endif
>>   BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
>> --
>> 2.44.0
>>
