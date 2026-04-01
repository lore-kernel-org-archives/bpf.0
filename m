Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434FC35BDA8
	for <bpf@vger.kernel.org>; Wed,  1 Apr 2026 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775045525; cv=none; b=ILjn7z537EUqWgTph34tYxs7MTKb4m7WSK293zFAinKHgHivMk7aTwuuKZSiljlZa8ugZf+QQoogh03H+Cdi/4YlBhiWiug1zDZjdiwe1cTl+8+G+m3kVjhkkBLZ2Yk8rjlkM5c+Z419AIHdDS2OsJcA1B+/UZtF0vDK+O5YlMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775045525; c=relaxed/simple;
	bh=RRbaxAYXdv2fiqKy2vJkyf1F8zK3ArPwza9TbqSNda4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=f4aHofS6RFBcJ4TeuMEWP5RPKDVZrtT1HsaQOM0727cSRfdsflQASmD+o5XHySVEtm7MtS+WHla3YkmaVDct1gw6EA539WoUu3aCoNazEqyG08IIuvf+GxnkG+OtDwtyHH8pc0gym0a6gvGjZ0HVpZ2jQj0EIuJ2XQCTsoN3ltw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RwfY36we; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RwfY36we"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-48700b1ba53so62865175e9.1
        for <bpf@vger.kernel.org>; Wed, 01 Apr 2026 05:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775045522; x=1775650322; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xA8xkB+x68FQ2GGpQjIcEOEvx2XB1iVTerDmhnNuTjY=;
        b=RwfY36weLstqHNFD5sXJSP1AB1LTuVmueLvSJhXPayrhWbwq68z/wEzMhV4c1dAn2p
         lX4yxZoRTfeoLfVy5SFes12OQ5NTDHloZj6fvQ6CQNH0Uqo1kbOYPD5b8uNBzVuQxwEj
         zw1kxcpaCOy1f+dD1aibwdlq5zk6sr3H0TOG9+eQSjFfakYD0AmOZL5o44gxy1Pq/zUA
         TZb2JGi3QIp7g7nC0lpfn/9OK2x4VhFhlyj6wGIwOgbYyIyV4KCNtJmy/EKLRQEL6ssK
         NlzZq9EdRcZ0h3rfNX2BR2Lw9G71uT00LMB3OvoA6RqLCmTW0dgMqrRr1sC3BeM76rTN
         NZ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775045522; x=1775650322;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xA8xkB+x68FQ2GGpQjIcEOEvx2XB1iVTerDmhnNuTjY=;
        b=HAhWP/ao1hzDbLhvPr5F6kf7+AJoL92mt/AEIu36iYDN9e4Z3bwpnVya3J7VvBb4jp
         s8aqdP+yNPFJCiupA5Spr+3RpHhoUHJ9GCOWG51jKHp3u2CdPprNylLwmRp2yk549sTp
         hvEntsMr34i2THA8CtcU7MP1+Pa/+DrZFFhAtROx0LNGThQPuXwCcmgW4I19EQ9gYeRw
         +R89cLjDVgYeN9oPoCVmr+OIotD4MnvyPCbX0tpcXLeEHnFJed/J9yeTfmsBV8x7ruO4
         zPu5Gh/0+hlxIV6p35OaQ5FOkpgINHPhYMvYHGeB/HKikqlYNxUKgcpbhCc+USJA/TLY
         oUEw==
X-Gm-Message-State: AOJu0YwkC0v60Dmql7gckm3MR15GW1hFna7ZNHAjw/XanNgWXSVmFuPf
	TDFaYa0ZdHxozrnITp4eo64/z1TsLvmXOqOVLZrCfbDmUGFgJvW1itdh
X-Gm-Gg: ATEYQzxCErIMr99/ZbzY9ydJivD7fksrLXSeyVxKJPbP5He8oRR5kHDuN2nG2ywSZ89
	pMFOju784WekZCDpR68hYy1H+KE7hgkPd5AbUhtTAN3UMqkGasG/hwv+ctYnFf+33+3c1Ntj0qr
	BDhuDZC0KAprQLjepnzhDi+nWS7HUFfh+FT3giIP9OXLtfOW6jGphX6WLJnUUmO2mpfl3zmAlXw
	m85sa0TTCkobRzjyC3pT79Ji4zzORyosBcB4xO9X8oXmvYFACmVs95gY9B1xrpY7vtnAuGBTJwR
	+UeJFjmSACoXVVD9+8Elkx+T0D/gkXU1pAB8F8e+oflm9Ce1WOGZKfAxlehOwPZfU/fPRgZhjhC
	ejwZC3rcLvx/YLLV1O1d5gD5802P5ATQGVFL8RwQaZKoWqZN+B4x4Gd5g4C9BSEU6LxKXZ/ZpsR
	pXDz5410eCdJY97lQ1kevL7PtnViU3bL+qLRbVP8sEmHWVrz/ldPOakjyHlbA2
X-Received: by 2002:a05:600c:4f53:b0:486:fb5c:3b20 with SMTP id 5b1f17b1804b1-4888358be65mr54013995e9.13.1775045522266;
        Wed, 01 Apr 2026 05:12:02 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1126:4:ff4a:fb29:5217:3697? ([2620:10d:c092:500::7:b4a4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4887e86ecf6sm119318805e9.14.2026.04.01.05.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Apr 2026 05:12:01 -0700 (PDT)
Message-ID: <3236c8a4-66fb-4db9-9a14-c7aaf519e73f@gmail.com>
Date: Wed, 1 Apr 2026 13:12:00 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v8 5/6] libbpf: Add section handlers for
 sleepable tracepoints
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
 daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
 eddyz87@gmail.com, memxor@gmail.com, peterz@infradead.org,
 rostedt@goodmis.org, Mykyta Yatsenko <yatsenko@meta.com>
References: <20260330-sleepable_tracepoints-v8-0-2e323467f3a0@meta.com>
 <20260330-sleepable_tracepoints-v8-5-2e323467f3a0@meta.com>
 <CAEf4Bzamw99OPiELzGysyYe-=Hq28-K_Q7n9Mkwf3kkQ11LHzA@mail.gmail.com>
Content-Language: en-US
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
In-Reply-To: <CAEf4Bzamw99OPiELzGysyYe-=Hq28-K_Q7n9Mkwf3kkQ11LHzA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/31/26 10:21 PM, Andrii Nakryiko wrote:
> On Mon, Mar 30, 2026 at 3:20 PM Mykyta Yatsenko
> <mykyta.yatsenko5@gmail.com> wrote:
>>
>> From: Mykyta Yatsenko <yatsenko@meta.com>
>>
>> Add SEC_DEF entries for sleepable tracepoint variants:
>>    - "tp_btf.s+"     for sleepable BTF-based raw tracepoints
>>    - "raw_tp.s+"     for sleepable classic raw tracepoints
>>    - "raw_tracepoint.s+" (alias)
>>    - "tp.s+"         for sleepable classic tracepoints
>>    - "tracepoint.s+" (alias)
>>
>> Update attach_raw_tp() to recognize "raw_tp.s" and
>> "raw_tracepoint.s" prefixes when extracting the tracepoint name.
>>
>> Rewrite attach_tp() to use a prefix array including "tp.s/" and
>> "tracepoint.s/" variants for proper section name parsing.
>>
>> Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
>> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 39 ++++++++++++++++++++++++++++++++-------
>>   1 file changed, 32 insertions(+), 7 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 9ea41f40dc82..a353dc7a4d41 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -9982,11 +9982,16 @@ static const struct bpf_sec_def section_defs[] = {
>>          SEC_DEF("netkit/peer",          SCHED_CLS, BPF_NETKIT_PEER, SEC_NONE),
>>          SEC_DEF("tracepoint+",          TRACEPOINT, 0, SEC_NONE, attach_tp),
>>          SEC_DEF("tp+",                  TRACEPOINT, 0, SEC_NONE, attach_tp),
>> +       SEC_DEF("tracepoint.s+",        TRACEPOINT, 0, SEC_SLEEPABLE, attach_tp),
>> +       SEC_DEF("tp.s+",                TRACEPOINT, 0, SEC_SLEEPABLE, attach_tp),
>>          SEC_DEF("raw_tracepoint+",      RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
>>          SEC_DEF("raw_tp+",              RAW_TRACEPOINT, 0, SEC_NONE, attach_raw_tp),
>> +       SEC_DEF("raw_tracepoint.s+",    RAW_TRACEPOINT, 0, SEC_SLEEPABLE, attach_raw_tp),
>> +       SEC_DEF("raw_tp.s+",            RAW_TRACEPOINT, 0, SEC_SLEEPABLE, attach_raw_tp),
>>          SEC_DEF("raw_tracepoint.w+",    RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
>>          SEC_DEF("raw_tp.w+",            RAW_TRACEPOINT_WRITABLE, 0, SEC_NONE, attach_raw_tp),
>>          SEC_DEF("tp_btf+",              TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF, attach_trace),
>> +       SEC_DEF("tp_btf.s+",            TRACING, BPF_TRACE_RAW_TP, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_trace),
>>          SEC_DEF("fentry+",              TRACING, BPF_TRACE_FENTRY, SEC_ATTACH_BTF, attach_trace),
>>          SEC_DEF("fmod_ret+",            TRACING, BPF_MODIFY_RETURN, SEC_ATTACH_BTF, attach_trace),
>>          SEC_DEF("fexit+",               TRACING, BPF_TRACE_FEXIT, SEC_ATTACH_BTF, attach_trace),
>> @@ -13109,23 +13114,41 @@ struct bpf_link *bpf_program__attach_tracepoint(const struct bpf_program *prog,
>>
>>   static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link)
>>   {
>> +       static const char *const prefixes[] = {
>> +               "tp.s/",
>> +               "tp/",
>> +               "tracepoint.s/",
>> +               "tracepoint/",
>> +       };
>>          char *sec_name, *tp_cat, *tp_name;
>> +       size_t i;
>>
>>          *link = NULL;
>>
>> -       /* no auto-attach for SEC("tp") or SEC("tracepoint") */
>> -       if (strcmp(prog->sec_name, "tp") == 0 || strcmp(prog->sec_name, "tracepoint") == 0)
>> +       /* no auto-attach for bare SEC("tp"), SEC("tracepoint") and .s variants */
>> +       if (strcmp(prog->sec_name, "tp") == 0 ||
>> +           strcmp(prog->sec_name, "tracepoint") == 0 ||
>> +           strcmp(prog->sec_name, "tp.s") == 0 ||
>> +           strcmp(prog->sec_name, "tracepoint.s") == 0)
>>                  return 0;
> 
> it makes no sense to hard-code explicit strcmp() literal strings here
> while having prefixes array. why not do what attach_raw_tp() does and
> use just prefixes uniformly?
> 
> pw-bot: cr
> 
> 

Thanks for taking a look! I'll fix this and other comments for the next 
version.
>>
>>          sec_name = strdup(prog->sec_name);
>>          if (!sec_name)
>>                  return -ENOMEM;
>>
>> -       /* extract "tp/<category>/<name>" or "tracepoint/<category>/<name>" */
>> -       if (str_has_pfx(prog->sec_name, "tp/"))
>> -               tp_cat = sec_name + sizeof("tp/") - 1;
>> -       else
>> -               tp_cat = sec_name + sizeof("tracepoint/") - 1;
>> +       /* extract "<prefix><category>/<name>" */
>> +       tp_cat = NULL;
>> +       for (i = 0; i < ARRAY_SIZE(prefixes); i++) {
>> +               if (str_has_pfx(prog->sec_name, prefixes[i])) {
>> +                       tp_cat = sec_name + strlen(prefixes[i]);
>> +                       break;
>> +               }
>> +       }
>> +       if (!tp_cat) {
>> +               free(sec_name);
>> +               return -EINVAL;
>> +       }
>> +
>>          tp_name = strchr(tp_cat, '/');
>>          if (!tp_name) {
>>                  free(sec_name);
>> @@ -13189,6 +13212,8 @@ static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf
>>                  "raw_tracepoint",
>>                  "raw_tp.w",
>>                  "raw_tracepoint.w",
>> +               "raw_tp.s",
>> +               "raw_tracepoint.s",
>>          };
>>          size_t i;
>>          const char *tp_name = NULL;
>>
>> --
>> 2.52.0
>>

