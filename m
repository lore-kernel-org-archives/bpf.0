Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3F49C43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 00:19:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99CAE20851
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 00:19:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbfCAATS (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 19:19:18 -0500
Received: from www62.your-server.de ([213.133.104.62]:59226 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729880AbfCAATS (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 19:19:18 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzVtR-0000vB-Oy; Fri, 01 Mar 2019 01:19:13 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzVtR-000Odv-IP; Fri, 01 Mar 2019 01:19:13 +0100
Subject: Re: [PATCH bpf-next v2 5/7] bpf, libbpf: support global
 data/bss/rodata sections
To:     Stanislav Fomichev <sdf@fomichev.me>
Cc:     ast@fb.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
        joe@wand.net.nz, john.fastabend@gmail.com, tgraf@suug.ch,
        yhs@fb.com, andriin@fb.com, jakub.kicinski@netronome.com,
        lmb@cloudflare.com
References: <20190228231829.11993-1-daniel@iogearbox.net>
 <20190228231829.11993-6-daniel@iogearbox.net>
 <20190228234101.GA10108@mini-arch.hsd1.ca.comcast.net>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f1b4a42e-12da-1a40-60c9-cc81c8926e40@iogearbox.net>
Date:   Fri, 1 Mar 2019 01:19:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190228234101.GA10108@mini-arch.hsd1.ca.comcast.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/01/2019 12:41 AM, Stanislav Fomichev wrote:
> On 03/01, Daniel Borkmann wrote:
>> This work adds BPF loader support for global data sections
>> to libbpf. This allows to write BPF programs in more natural
>> C-like way by being able to define global variables and const
>> data.
>>
>> Back at LPC 2018 [0] we presented a first prototype which
>> implemented support for global data sections by extending BPF
>> syscall where union bpf_attr would get additional memory/size
>> pair for each section passed during prog load in order to later
>> add this base address into the ldimm64 instruction along with
>> the user provided offset when accessing a variable. Consensus
>> from LPC was that for proper upstream support, it would be
>> more desirable to use maps instead of bpf_attr extension as
>> this would allow for introspection of these sections as well
>> as potential life updates of their content. This work follows
>> this path by taking the following steps from loader side:
>>
>>  1) In bpf_object__elf_collect() step we pick up ".data",
>>     ".rodata", and ".bss" section information.
>>
>>  2) If present, in bpf_object__init_global_maps() we create
>>     a map that corresponds to each of the present sections.
>>     Given section size and access properties can differ, a
>>     single entry array map is created with value size that
>>     is corresponding to the ELF section size of .data, .bss
>>     or .rodata. In the latter case, the map is created as
>>     read-only from program side such that verifier rejects
>>     any write attempts into .rodata. In a subsequent step,
>>     for .data and .rodata sections, the section content is
>>     copied into the map through bpf_map_update_elem(). For
>>     .bss this is not necessary since array map is already
>>     zero-initialized by default.
>>
>>  3) In bpf_program__collect_reloc() step, we record the
>>     corresponding map, insn index, and relocation type for
>>     the global data.
>>
>>  4) And last but not least in the actual relocation step in
>>     bpf_program__relocate(), we mark the ldimm64 instruction
>>     with src_reg = BPF_PSEUDO_MAP_VALUE where in the first
>>     imm field the map's file descriptor is stored as similarly
>>     done as in BPF_PSEUDO_MAP_FD, and in the second imm field
>>     (as ldimm64 is 2-insn wide) we store the access offset
>>     into the section.
>>
>>  5) On kernel side, this special marked BPF_PSEUDO_MAP_VALUE
>>     load will then store the actual target address in order
>>     to have a 'map-lookup'-free access. That is, the actual
>>     map value base address + offset. The destination register
>>     in the verifier will then be marked as PTR_TO_MAP_VALUE,
>>     containing the fixed offset as reg->off and backing BPF
>>     map as reg->map_ptr. Meaning, it's treated as any other
>>     normal map value from verification side, only with
>>     efficient, direct value access instead of actual call to
>>     map lookup helper as in the typical case.
>>
>> Simple example dump of program using globals vars in each
>> section:
>>
>>   # readelf -a test_global_data.o
>>   [...]
>>   [ 6] .bss              NOBITS           0000000000000000  00000328
>>        0000000000000010  0000000000000000  WA       0     0     8
>>   [ 7] .data             PROGBITS         0000000000000000  00000328
>>        0000000000000010  0000000000000000  WA       0     0     8
>>   [ 8] .rodata           PROGBITS         0000000000000000  00000338
>>        0000000000000018  0000000000000000   A       0     0     8
>>   [...]
>>     95: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    6 static_bss
>>     96: 0000000000000008     8 OBJECT  LOCAL  DEFAULT    6 static_bss2
>>     97: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    7 static_data
>>     98: 0000000000000008     8 OBJECT  LOCAL  DEFAULT    7 static_data2
>>     99: 0000000000000000     8 OBJECT  LOCAL  DEFAULT    8 static_rodata
>>    100: 0000000000000008     8 OBJECT  LOCAL  DEFAULT    8 static_rodata2
>>    101: 0000000000000010     8 OBJECT  LOCAL  DEFAULT    8 static_rodata3
>>   [...]
>>
>>   # bpftool prog
>>   103: sched_cls  name load_static_dat  tag 37a8b6822fc39a29  gpl
>>        loaded_at 2019-02-28T02:02:35+0000  uid 0
>>        xlated 712B  jited 426B  memlock 4096B  map_ids 63,64,65,66
>>   # bpftool map show id 63
>>   63: array  name .bss  flags 0x0                      <-- .bss area, rw
> Can we use <main prog>.bss/data/rodata names? If we load more than one
> prog with global data that should make it easier to find which one is which.

Yeah that's fine, we can change it. They could potentially also be shared,
so <main prog>.bss/data/rodata might be misleading, but <obj>.bss/data/rodata
could be.

Thanks,
Daniel
