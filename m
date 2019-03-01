Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EB5BC43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 19:56:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BD2320848
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 19:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725944AbfCAT43 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:56:29 -0500
Received: from www62.your-server.de ([213.133.104.62]:34854 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725934AbfCAT42 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 14:56:28 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzoGg-0005Le-Cu; Fri, 01 Mar 2019 20:56:26 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzoGg-00086D-2f; Fri, 01 Mar 2019 20:56:26 +0100
Subject: Re: [PATCH bpf-next v2 5/7] bpf, libbpf: support global
 data/bss/rodata sections
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "joe@wand.net.nz" <joe@wand.net.nz>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "tgraf@suug.ch" <tgraf@suug.ch>, Andrii Nakryiko <andriin@fb.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "lmb@cloudflare.com" <lmb@cloudflare.com>
References: <20190228231829.11993-1-daniel@iogearbox.net>
 <20190228231829.11993-6-daniel@iogearbox.net>
 <1e21ba74-f236-60b8-f33c-f3f060419197@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <95425cff-6c25-91d6-f8e6-5fbfec7b4342@iogearbox.net>
Date:   Fri, 1 Mar 2019 20:56:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <1e21ba74-f236-60b8-f33c-f3f060419197@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/01/2019 07:11 PM, Yonghong Song wrote:
> On 2/28/19 3:18 PM, Daniel Borkmann wrote:
[...]
>> @@ -1412,6 +1568,24 @@ bpf_program__relocate(struct bpf_program *prog, struct bpf_object *obj)
>>   						      &prog->reloc_desc[i]);
>>   			if (err)
>>   				return err;
>> +		} else if (prog->reloc_desc[i].type == RELO_DATA ||
>> +			   prog->reloc_desc[i].type == RELO_RODATA ||
>> +			   prog->reloc_desc[i].type == RELO_BSS) {
>> +			struct bpf_insn *insns = prog->insns;
>> +			int insn_idx, map_idx, data_off;
>> +
>> +			insn_idx = prog->reloc_desc[i].insn_idx;
>> +			map_idx  = prog->reloc_desc[i].map_idx;
>> +			data_off = insns[insn_idx].imm;
> 
> I want to point to a subtle difference here between handling pure global 
> variables and static global variables. The "imm" value is only available
> for static variables. For example,
> 
> -bash-4.4$ cat g.c
> static volatile long sg = 2;
> static volatile int si = 3;
> long g = 4;
> int i = 5;
> int test() { return sg + si + g + i; }
> -bash-4.4$
> -bash-4.4$ clang -target bpf -O2 -c g.c 
> 
> -bash-4.4$ readelf -s g.o 
> 
> 
> Symbol table '.symtab' contains 8 entries:
>     Num:    Value          Size Type    Bind   Vis      Ndx Name
>       0: 0000000000000000     0 NOTYPE  LOCAL  DEFAULT  UND
>       1: 0000000000000000     0 FILE    LOCAL  DEFAULT  ABS g.c
>       2: 0000000000000010     8 OBJECT  LOCAL  DEFAULT    4 sg
>       3: 0000000000000018     4 OBJECT  LOCAL  DEFAULT    4 si
>       4: 0000000000000000     0 SECTION LOCAL  DEFAULT    4
>       5: 0000000000000000     8 OBJECT  GLOBAL DEFAULT    4 g
>       6: 0000000000000008     4 OBJECT  GLOBAL DEFAULT    4 i
>       7: 0000000000000000   128 FUNC    GLOBAL DEFAULT    2 test
> -bash-4.4$
> -bash-4.4$ llvm-readelf -r g.o
> 
> Relocation section '.rel.text' at offset 0x1d8 contains 4 entries:
>      Offset             Info             Type               Symbol's 
> Value  Symbol's Name
> 0000000000000000  0000000400000001 R_BPF_64_64 
> 0000000000000000 .data
> 0000000000000018  0000000400000001 R_BPF_64_64 
> 0000000000000000 .data
> 0000000000000038  0000000500000001 R_BPF_64_64            0000000000000000 g
> 0000000000000058  0000000600000001 R_BPF_64_64            0000000000000008 i
> -bash-4.4$ llvm-objdump -d g.o
> 
> g.o:    file format ELF64-BPF
> 
> Disassembly of section .text:
> 0000000000000000 test:
>         0:       18 01 00 00 10 00 00 00 00 00 00 00 00 00 00 00 
> r1 = 16 ll
>         2:       79 11 00 00 00 00 00 00         r1 = *(u64 *)(r1 + 0)
>         3:       18 02 00 00 18 00 00 00 00 00 00 00 00 00 00 00 
> r2 = 24 ll
>         5:       61 22 00 00 00 00 00 00         r2 = *(u32 *)(r2 + 0)
>         6:       0f 21 00 00 00 00 00 00         r1 += r2
>         7:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> r2 = 0 ll
>         9:       79 22 00 00 00 00 00 00         r2 = *(u64 *)(r2 + 0)
>        10:       0f 21 00 00 00 00 00 00         r1 += r2
>        11:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 
> r2 = 0 ll
>        13:       61 20 00 00 00 00 00 00         r0 = *(u32 *)(r2 + 0)
>        14:       0f 10 00 00 00 00 00 00         r0 += r1
>        15:       95 00 00 00 00 00 00 00         exit
> -bash-4.4$
> 
> You can see the above, the non-static global access does not have its
> in-section offset encoded in the insn itself. The difference is due to
> llvm treating static global and non-static global differently.
> 
> To support both cases, during relocation recording stage, you can
> also record:
>     . symbol binding (GELF_ST_BIND(sym.st_info)),
>       non-static global has binding STB_GLOBAL and static
>       global has binding STB_LOCAL
>     . symbol value (sym.st_value)
> 
> During the above relocation resolution, if symbol bind is local, do
> what you already did here. If symbol bind is global, assign data_off
> with symbol value.
> 
> This applied to both .data and .rodata sections.
> 
> The non initialized
> global variable will not be in any allocated section in ELF file,
> it is in a COM section which is to be allocated by loader.
> So user defines some like
>     int g;
> and later on uses it. Right now, it will not work. The workaround
> is "int g = 4", or "static int g". I guess it should be
> okay, we should encourage users to use "static" variables instead.

Agree and noted, and thanks for pointing this out, Yonghong! I'll
fix this up accordingly in next round.

Thanks a lot,
Daniel
