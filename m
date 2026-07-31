Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D833854785
	for <bpf@vger.kernel.org>; Fri, 31 Jul 2026 00:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785456357; cv=none; b=Nh2ghzo1086SnQLBwLvGoUYih0oiEEApOiKB4Aj/J+b0URwcd8TJUlQ6P3lxL1cZk/uLSG8yD5lRsdEfVYHwjez4so7I9lM1c79yvI3xdOHvHRB/dBa5rL1cCSmy/nkMQojygfoD0Ql/OStdDcOwepfuvDcJ2mSJpNFQTBljIaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785456357; c=relaxed/simple;
	bh=QPDiUGvjFW0vZTG42ytTCKU24mANKY9MiXrQ0vmnRzc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QLNEDdD5peqnl0PMg9DDctWEhPgFtYL3pcEhimuYJ064lDpLkMJf92I7DpQ0fAAe2iJeP8TFI9REo6UjR9AZxEloRGm4t2HySjiY7ld2qovNy3bIjJd0yBM/BZqHGn+UFQZGZ/4RKZNDKpEa/vOzVAjTg12lL+S+C7t4OiujoDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHkAOamg; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHkAOamg"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15d3cd51b2so35053066b.3
        for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 17:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785456354; x=1786061154; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NUUJ+vbNcFU2fR4e/S5zRq2y6etr3MLWwvcK10d7QwI=;
        b=mHkAOamg9USPZzCbfVH81qf5f6GQ6IIXq/rmANGifGTBAWyIzZowz0WKXrlR5vpF8E
         co81J9F821fZ2Afs4wTcXcnkHSHD/wtriF/rkWtRsK7oaPNxoMlmo+BWhE7Ps2xOcFxY
         9u/ktnZjhbSjl58yr6NLnozftBtBC3iJHT0kNQn2v8Fsif7j4/sh4FwqmVYReLJTHnzg
         ICOeI083dfKzObP5tunNVEl5lEvNOVSrYdYVdt3o/KWH5gJffiamO65ZqvCzxtRqA/X7
         4CHg9M2qJmgQp/u0F55KjiAuT5ptGjxJ+QkFlwG5UbeVqu42eKYvQ5rVcmVRR61Z03uP
         9Q9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785456354; x=1786061154;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NUUJ+vbNcFU2fR4e/S5zRq2y6etr3MLWwvcK10d7QwI=;
        b=a2Zx+SPQiQxLrin9+g7MsrIeLCelZxbIh14eJRoRRrP2H4DnlGW3D0e0aVhr2tdOl3
         wrnrW6wM/s6ARYZI2uTC2mSROAR542QiVly26eRh77ne7AYCwrCbleY/OH4E1e4j4K3K
         h7dtFNlVSFChCdvfp16N6UCinAIblVOGZxv6msLulJ/QYKd4spMtCIjROhEeasFyFJGo
         qnLlfkiJJgsNblHo4kYC+dUGIO6ZvcgOSmFMczSGUSRKJ5/Sm0yxuYViX7OgsArQ9ZBT
         9TWYBrcxOGhODPtXEI+YcM7nbVOUrPaXi5jPy2awquOfSHnb1AZD4iwNAkPFoiXfL5vw
         RUzg==
X-Gm-Message-State: AOJu0Yxyi8kNOs4b6wNgpQq5plBcNONFqZ0S3pC3owlZkL4ayllw27lg
	zXUA5iAvLjvYJb4+1zZCCQhq++uXNlMM9JtpsGwJqkoQD0XoY86+dr8s
X-Gm-Gg: AR+sD10P7SOLNEiiMWMmraX/Ef4sdVVFZe36QpHJk2l7oIz95Asv5o24No+FTDNIc8v
	3eREbpD3oXUYe3CtXNFAjGuL0EJuOCVxkNn1yA+xj8DasFMEKsTPz9QskTDwwB6RU/p7EDVSDlH
	1i4FtDP20qn7akn15a2iiRAmD5r80fhWFgLn50MNdvDRTTBhdDVnsNPixDfCemCPXqlpShHbykP
	aAii9sUTUfJo8HDExWdgNyXuuJyhbgomhSAfquudnCJbK3iZGDhnm2rhxPlxmj+XZTFw2s8sw6j
	eEqxvPx9uk/RlBuxUDIMujTWLVCI/dF7+YdZGQiQ6bYkAPGsO7YBJ6Rd5D48mLDGLDzYgie1b9A
	wReHWZ+wCrgw6YWvk8QgPM6W97oOXkPIDRdhs/YcSOGQgKthyUrFXGeGSPk8qCJInctfDUobEHO
	IrNFGURMc754Vuc9GrTsHJ09jMLFhyY1flEeYZiE09s9EQ9sWiExWJ/sg9eVtjD33SNi6Az9kzq
	2mlt75z5VpwjIv5XI7U5F01J+8cFzV4JesBIBfq4glc7gCv
X-Received: by 2002:a17:907:97d4:b0:c15:edb7:a74d with SMTP id a640c23a62f3a-c1fa53ed69cmr244126866b.12.1785456353766;
        Thu, 30 Jul 2026 17:05:53 -0700 (PDT)
Received: from ?IPV6:2a02:8109:a307:d900:76a7:371c:6808:eaed? ([2a02:8109:a307:d900:76a7:371c:6808:eaed])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1fa8b6ca74sm115278966b.31.2026.07.30.17.05.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2026 17:05:53 -0700 (PDT)
Message-ID: <f04757f1-c4ed-4c18-9095-43706f316ff7@gmail.com>
Date: Fri, 31 Jul 2026 01:05:50 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next] tracing: Make per-template BTF id lists
 file-local
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>, rostedt@goodmis.org
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, linux-trace-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, broonie@kernel.org,
 Mykyta Yatsenko <yatsenko@meta.com>
References: <20260730-b4-fix_btf_tracefs-v1-1-5f10b728f51e@meta.com>
 <CAEf4BzZXu=E-E+_DXukwuzdGAH6LwxhFuWkX5j6Os1YAn3Vtcg@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4BzZXu=E-E+_DXukwuzdGAH6LwxhFuWkX5j6Os1YAn3Vtcg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/31/26 12:55 AM, Andrii Nakryiko wrote:
> On Thu, Jul 30, 2026 at 5:52 AM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> DECLARE_EVENT_CLASS emitted __bpf_trace_btf_ids_<call> through
>> BTF_ID_LIST_GLOBAL, i.e. a global symbol named after the event class.
>> The class name is not unique across the kernel, so the symbol
>> multiply-defines whenever two translation units instantiate the same
>> class.
>>
>> Switch to the file-local BTF_ID_LIST: the list is reached
>> only through the event_class_<call>.btf_ids pointer, initialised in the
>> same unit, so tracefs readers never reference the symbol by name and
>> resolve_btfids still fills the now-local .BTF_ids entries.
>>
>> The handcrafted syscall classes are the one cross-unit consumer: give
>> them their own local BTF_ID_LIST rather than importing the generated
>> sys_{enter,exit} lists, which are now file-local.
>>
>> Fixes: eadc0725ab8d3 ("tracing: Expose tracepoint BTF ids via tracefs")
>> Reported-by: Mark Brown <broonie@kernel.org>
>> Closes: https://lore.kernel.org/all/ff58b01c-3f5e-4d55-be82-609d2faaf12e@sirena.org.uk/
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>  include/trace/trace_events.h  |  6 ++++--
>>  kernel/trace/trace_syscalls.c | 22 ++++++++++++++--------
>>  2 files changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/trace/trace_events.h b/include/trace/trace_events.h
>> index 09ad57ac4b73..45ffbe04b580 100644
>> --- a/include/trace/trace_events.h
>> +++ b/include/trace/trace_events.h
>> @@ -404,10 +404,12 @@ static inline notrace int trace_event_get_offsets_##call(         \
>>   *   [0] FUNC   __bpf_trace_<call>     (the BPF dispatcher)
>>   *   [1] STRUCT trace_event_raw_<call> (the ring-buffer record)
>>   * Exposed via the events/<sys>/<name>/btf_ids tracefs file.
>> + *
>> + * File-local: the class name is not unique, so a global symbol would
>> + * clash across translation units.
> 
> drop this comment? not super useful and file-local is default behavior
> for BTF_ID_LIST anyways
> 
>>   */
>>  #define _TRACE_BTF_IDS_DECLARE(call)                                   \
>> -       extern u32 __bpf_trace_btf_ids_##call[];                        \
>> -       BTF_ID_LIST_GLOBAL(__bpf_trace_btf_ids_##call, 2)               \
>> +       BTF_ID_LIST(__bpf_trace_btf_ids_##call)                         \
>>         BTF_ID(func,   __bpf_trace_##call)                              \
>>         BTF_ID(struct, trace_event_raw_##call)
>>
> 
> This should go into Steven's tree, not bpf-next, right?

yes, thanks for the review!
> 
>> diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
>> index 48ef1a93e576..9b5931f2f280 100644
>> --- a/kernel/trace/trace_syscalls.c
>> +++ b/kernel/trace/trace_syscalls.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/ftrace.h>
>>  #include <linux/perf_event.h>
>>  #include <linux/xarray.h>
>> +#include <linux/btf_ids.h>
>>  #include <asm/syscall.h>
>>
>>  #include "trace_output.h"
>> @@ -1305,13 +1306,18 @@ struct trace_event_functions exit_syscall_print_funcs = {
>>
>>  #ifdef CONFIG_BPF_EVENTS
>>  /*
>> - * BTF id lists generated by DECLARE_EVENT_CLASS for the sys_enter and
>> - * sys_exit tracepoints. The auto-generated event_class_sys_{enter,exit}
>> - * is unused (per-syscall events share the handcrafted classes below),
>> - * but the id lists themselves are global and reusable.
>> + * BTF id lists for the shared sys_enter/sys_exit dispatcher tracepoints,
>> + * resolved by resolve_btfids. Defined locally rather than importing the
>> + * DECLARE_EVENT_CLASS-generated lists, which are now file-local to the
>> + * translation unit that instantiates the tracepoint.
> 
> drop "resolved by resolve_btfids", and drop the part about defined
> locally because file-local, too much Claude style
> 
>>   */
>> -extern u32 __bpf_trace_btf_ids_sys_enter[];
>> -extern u32 __bpf_trace_btf_ids_sys_exit[];
>> +BTF_ID_LIST(syscall_enter_btf_ids)
>> +BTF_ID(func,   __bpf_trace_sys_enter)
>> +BTF_ID(struct, trace_event_raw_sys_enter)
>> +
>> +BTF_ID_LIST(syscall_exit_btf_ids)
>> +BTF_ID(func,   __bpf_trace_sys_exit)
>> +BTF_ID(struct, trace_event_raw_sys_exit)
>>  #endif
>>
>>  struct trace_event_class __refdata event_class_syscall_enter = {
>> @@ -1321,7 +1327,7 @@ struct trace_event_class __refdata event_class_syscall_enter = {
>>         .get_fields     = syscall_get_enter_fields,
>>         .raw_init       = init_syscall_trace,
>>  #ifdef CONFIG_BPF_EVENTS
>> -       .btf_ids        = __bpf_trace_btf_ids_sys_enter,
>> +       .btf_ids        = syscall_enter_btf_ids,
>>  #endif
>>  };
>>
>> @@ -1336,7 +1342,7 @@ struct trace_event_class __refdata event_class_syscall_exit = {
>>         .fields         = LIST_HEAD_INIT(event_class_syscall_exit.fields),
>>         .raw_init       = init_syscall_trace,
>>  #ifdef CONFIG_BPF_EVENTS
>> -       .btf_ids        = __bpf_trace_btf_ids_sys_exit,
>> +       .btf_ids        = syscall_exit_btf_ids,
>>  #endif
>>  };
>>
>>
>> ---
>> base-commit: eadc0725ab8d38c05148fce49f8d5c6a0e01f062
>> change-id: 20260730-b4-fix_btf_tracefs-fdafda5fdb5b
>>
>> Best regards,
>> --
>> Mykyta Yatsenko <yatsenko@meta.com>
>>

