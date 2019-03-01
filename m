Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FF25C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 20:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73C6420848
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 20:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbfCAUCL (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 15:02:11 -0500
Received: from www62.your-server.de ([213.133.104.62]:35790 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAUCL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 15:02:11 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzoMD-0005iC-1f; Fri, 01 Mar 2019 21:02:09 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzoMC-0002sA-Lo; Fri, 01 Mar 2019 21:02:08 +0100
Subject: Re: [PATCH bpf-next v2 6/7] bpf, selftest: test global
 data/bss/rodata sections
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Alexei Starovoitov <ast@fb.com>, bpf@vger.kernel.org,
        Networking <netdev@vger.kernel.org>, joe@wand.net.nz,
        john.fastabend@gmail.com, tgraf@suug.ch,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        lmb@cloudflare.com
References: <20190228231829.11993-1-daniel@iogearbox.net>
 <20190228231829.11993-7-daniel@iogearbox.net>
 <CAEf4BzZBPS_QmHfCV-AQYNHQPEvo6kcAC4PC1SZ=ucG15jv1rg@mail.gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <cf6541f6-25eb-b858-3d4b-fbc68666cbba@iogearbox.net>
Date:   Fri, 1 Mar 2019 21:02:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CAEf4BzZBPS_QmHfCV-AQYNHQPEvo6kcAC4PC1SZ=ucG15jv1rg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/01/2019 08:13 PM, Andrii Nakryiko wrote:
> On Thu, Feb 28, 2019 at 3:32 PM Daniel Borkmann <daniel@iogearbox.net> wrote:
>> From: Joe Stringer <joe@wand.net.nz>
>>
>> Add tests for libbpf relocation of static variable references
>> into the .data, .rodata and .bss sections of the ELF. Tests with
>> different offsets are all passing:
>>
>>   # ./test_progs
>>   [...]
>>   test_static_data_access:PASS:load program 0 nsec
>>   test_static_data_access:PASS:pass packet 278 nsec
>>   test_static_data_access:PASS:relocate .bss reference 1 278 nsec
>>   test_static_data_access:PASS:relocate .data reference 1 278 nsec
>>   test_static_data_access:PASS:relocate .rodata reference 1 278 nsec
>>   test_static_data_access:PASS:relocate .bss reference 2 278 nsec
>>   test_static_data_access:PASS:relocate .data reference 2 278 nsec
>>   test_static_data_access:PASS:relocate .rodata reference 2 278 nsec
>>   test_static_data_access:PASS:relocate .bss reference 3 278 nsec
>>   test_static_data_access:PASS:relocate .bss reference 4 278 nsec
>>   Summary: 223 PASSED, 0 FAILED
>>
>> Joint work with Daniel Borkmann.
>>
>> Signed-off-by: Joe Stringer <joe@wand.net.nz>
>> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
>> ---
>>  tools/testing/selftests/bpf/bpf_helpers.h     |  2 +-
>>  .../selftests/bpf/progs/test_global_data.c    | 61 +++++++++++++++++++
>>  tools/testing/selftests/bpf/test_progs.c      | 50 +++++++++++++++
>>  3 files changed, 112 insertions(+), 1 deletion(-)
>>  create mode 100644 tools/testing/selftests/bpf/progs/test_global_data.c
>>
>> diff --git a/tools/testing/selftests/bpf/bpf_helpers.h b/tools/testing/selftests/bpf/bpf_helpers.h
>> index d9999f1ed1d2..0463662935f9 100644
>> --- a/tools/testing/selftests/bpf/bpf_helpers.h
>> +++ b/tools/testing/selftests/bpf/bpf_helpers.h
>> @@ -11,7 +11,7 @@
>>  /* helper functions called from eBPF programs written in C */
>>  static void *(*bpf_map_lookup_elem)(void *map, void *key) =
>>         (void *) BPF_FUNC_map_lookup_elem;
>> -static int (*bpf_map_update_elem)(void *map, void *key, void *value,
>> +static int (*bpf_map_update_elem)(void *map, const void *key, const void *value,
>>                                   unsigned long long flags) =
>>         (void *) BPF_FUNC_map_update_elem;
>>  static int (*bpf_map_delete_elem)(void *map, void *key) =
>> diff --git a/tools/testing/selftests/bpf/progs/test_global_data.c b/tools/testing/selftests/bpf/progs/test_global_data.c
>> new file mode 100644
>> index 000000000000..2a7cf40b8efb
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/progs/test_global_data.c
>> @@ -0,0 +1,61 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2019 Isovalent, Inc.
>> +
>> +#include <linux/bpf.h>
>> +#include <linux/pkt_cls.h>
>> +#include <string.h>
>> +
>> +#include "bpf_helpers.h"
>> +
>> +struct bpf_map_def SEC("maps") result = {
>> +       .type           = BPF_MAP_TYPE_ARRAY,
>> +       .key_size       = sizeof(__u32),
>> +       .value_size     = sizeof(__u64),
>> +       .max_entries    = 9,
>> +};
>> +
>> +static       __u64 static_bss     = 0;         /* Reloc reference to .bss  section   */
>> +static       __u64 static_data    = 42;                /* Reloc reference to .data section   */
>> +static const __u64 static_rodata  = 24;                /* Reloc reference to .rodata section */
>> +static       __u64 static_bss2    = 0;         /* Reloc reference to .bss  section   */
>> +static       __u64 static_data2   = 0xffeeff;  /* Reloc reference to .data section   */
>> +static const __u64 static_rodata2 = 0xabab;    /* Reloc reference to .rodata section */
>> +static const __u64 static_rodata3 = 0xab;      /* Reloc reference to .rodata section */
> 
> In the light of Yonghong's explanation about static vs non-static
> globals, it would be nice to add test for non-static initialized
> globals here as well?

Yes, agree, I'll add them as well and integrate the correct offset
for libbpf along with it.

Cheers,
Daniel
