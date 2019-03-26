Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FDD9C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 19:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E327420823
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 19:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="osBrIN7Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbfCZTsE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:48:04 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:35969 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731531AbfCZTsE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 15:48:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id h18so14315020wml.1
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 12:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=22tJ2iM6FWcdoR30dBAKaL6Xs69dZkeqTc7NMub0+qA=;
        b=osBrIN7YPcJeHOq1hEb82UAw1NKpbBYK7dmBtEhc24ZWXpv1m9HZN9a1PlAqdvg1Ml
         aMZiBKmNoZmVAdEY1mJ5GwwXp6/d7gtE8QNZ/d6BGPooZ4IjAQVAKFlWOyqPuiL7nrg8
         md784OEZlBXVol6c7EPOB/jvnXSm5T9tW29QRdMEjvhrtrT6OgObiu9s7S8Xw6fR4JPH
         u2sjJXl5ne4vmwhRKAJkGjIDWMjjcJ7IoAZ0+stqdZm0A6fmJ/tcF4ehpd1bCI0U7Bw0
         lNtvBp0sGTJB0z3MmFp8defrPK5flPEJLKz0ogXeDK0idAkIRu7uLOzYDyOF/LXqI/bh
         898Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=22tJ2iM6FWcdoR30dBAKaL6Xs69dZkeqTc7NMub0+qA=;
        b=TLpXuDAfeXOM+TpxW7HkNyFBIOq+jCBhzHJMhl0csx9uhcAVqTFBXA8v9lbetkd+Do
         ZZ00ytJ6ho5nc8gxE+IjXF91kuVShRJ6BG1TXtZYleBg/HEISFJoUtAfB6SvLwkNGdvw
         Hk2/h20T9pqYlQ3LE5V/mZOTJTsCvlhi+43+yRgGj1qbDeO9QG+sDwdXAdwQIImG4zFi
         mzr5JEGfyClx1OILQ1YkvSZiVnf4N+YsE/zrk179U4oVF72tJgLuNMC1+aQtCDmGYM7P
         nbtxke7csHQEe14oziwShZaUs0k73FSdHf4LRNuj1PGKJIElL+LyCATI4r5/1kNFWiBs
         pTbQ==
X-Gm-Message-State: APjAAAVLswB5XyHYrxlj/5xNF7MWSLsirSLyh9ElarYJky3eNdHVhjSa
        6A0wOvQ2QPaAVI9LGb9AEYY+2w==
X-Google-Smtp-Source: APXvYqxL4qSa+Whhx1ydEU3GCZew7Z86lPhe7y5EtjA24qgxpFtAL9O6FJOjLBu9vHoIYhMZeteOnQ==
X-Received: by 2002:a1c:44:: with SMTP id 65mr15085814wma.127.1553629682452;
        Tue, 26 Mar 2019 12:48:02 -0700 (PDT)
Received: from [192.168.0.10] (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id r16sm9718600wrx.37.2019.03.26.12.48.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 12:48:01 -0700 (PDT)
Subject: Re: [PATCH/RFC bpf-next 04/16] bpf: mark sub-register writes that
 really need zero extension to high bits
To:     Edward Cree <ecree@solarflare.com>
Cc:     alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-5-git-send-email-jiong.wang@netronome.com>
 <4a397d16-2ee4-e58e-0091-9df7a20b07b9@solarflare.com>
From:   Jiong Wang <jiong.wang@netronome.com>
Message-ID: <6aee61fc-063d-e7b0-4779-81492a7b5031@netronome.com>
Date:   Tue, 26 Mar 2019 19:47:58 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <4a397d16-2ee4-e58e-0091-9df7a20b07b9@solarflare.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 26/03/2019 18:44, Edward Cree wrote:
> On 26/03/2019 18:05, Jiong Wang wrote:
>> eBPF ISA specification requires high 32-bit cleared when low 32-bit
>> sub-register is written. This applies to destination register of ALU32 etc.
>> JIT back-ends must guarantee this semantic when doing code-gen.
>>
>> x86-64 and arm64 ISA has the same semantic, so the corresponding JIT
>> back-end doesn't need to do extra work. However, 32-bit arches (arm, nfp
>> etc.) and some other 64-bit arches (powerpc, sparc etc), need explicit zero
>> extension sequence to meet such semantic.
>>
>> This is important, because for code the following:
>>
>>    u64_value = (u64) u32_value
>>    ... other uses of u64_value
>>
>> compiler could exploit the semantic described above and save those zero
>> extensions for extending u32_value to u64_value. Hardware, runtime, or BPF
>> JIT back-ends, are responsible for guaranteeing this. Some benchmarks show
>> ~40% sub-register writes out of total insns, meaning ~40% extra code-gen (
>> could go up to more for some arches which requires two shifts for zero
>> extension) because JIT back-end needs to do extra code-gen for all such
>> instructions.
>>
>> However this is not always necessary in case u32_value is never cast into
>> a u64, which is quite normal in real life program. So, it would be really
>> good if we could identify those places where such type cast happened, and
>> only do zero extensions for them, not for the others. This could save a lot
>> of BPF code-gen.
>>
>> Algo:
>>   - Record indices of instructions that do sub-register def (write). And
>>     these indices need to stay with function state so path pruning and bpf
>>     to bpf function call could be handled properly.
>>
>>     These indices are kept up to date while doing insn walk.
>>
>>   - A full register read on an active sub-register def marks the def insn as
>>     needing zero extension on dst register.
>>
>>   - A new sub-register write overrides the old one.
>>
>>     A new full register write makes the register free of zero extension on
>>     dst register.
>>
>>   - When propagating register read64 during path pruning, it also marks def
>>     insns whose defs are hanging active sub-register, if there is any read64
>>     from shown from the equal state.
>>
>> Reviewed-by: Jakub Kicinski <jakub.kicinski@netronome.com>
>> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
>> ---
>>   include/linux/bpf_verifier.h |  4 +++
>>   kernel/bpf/verifier.c        | 85 +++++++++++++++++++++++++++++++++++++++++---
>>   2 files changed, 84 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 27761ab..0ae9a3f 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -181,6 +181,9 @@ struct bpf_func_state {
>>   	 */
>>   	u32 subprogno;
>>   
>> +	/* tracks subreg definition. */
> Ideally this comment should mention that the stored value is the insn_idx
>   of the writing insn.  Perhaps also that this is safe because patching
>   (bpf_patch_insn_data()) only happens after main verification completes.

OK, will add more comments for this.

Regards,
Jiong

