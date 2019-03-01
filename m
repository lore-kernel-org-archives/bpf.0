Return-Path: <SRS0=adOE=RE=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E0FC43381
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 19:51:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AA4320848
	for <bpf@archiver.kernel.org>; Fri,  1 Mar 2019 19:51:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfCATvQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 1 Mar 2019 14:51:16 -0500
Received: from www62.your-server.de ([213.133.104.62]:33832 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725862AbfCATvQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Mar 2019 14:51:16 -0500
Received: from [88.198.220.130] (helo=sslproxy01.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzoBa-000529-Tr; Fri, 01 Mar 2019 20:51:10 +0100
Received: from [178.197.248.21] (helo=linux.home)
        by sslproxy01.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1gzoBa-0005hA-JC; Fri, 01 Mar 2019 20:51:10 +0100
Subject: Re: [PATCH bpf-next v2 1/7] bpf: implement lookup-free direct value
 access
To:     Yonghong Song <yhs@fb.com>, Alexei Starovoitov <ast@fb.com>
Cc:     "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "joe@wand.net.nz" <joe@wand.net.nz>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "tgraf@suug.ch" <tgraf@suug.ch>, Andrii Nakryiko <andriin@fb.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "lmb@cloudflare.com" <lmb@cloudflare.com>
References: <20190228231829.11993-1-daniel@iogearbox.net>
 <20190228231829.11993-2-daniel@iogearbox.net>
 <9c363e12-fbea-03d9-c376-2feb45a5a973@fb.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <2a049a97-d012-1d98-5308-93a91d6b3055@iogearbox.net>
Date:   Fri, 1 Mar 2019 20:51:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <9c363e12-fbea-03d9-c376-2feb45a5a973@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25374/Thu Feb 28 11:38:05 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/01/2019 06:18 PM, Yonghong Song wrote:
> On 2/28/19 3:18 PM, Daniel Borkmann wrote:
>> This generic extension to BPF maps allows for directly loading an
>> address residing inside a BPF map value as a single BPF ldimm64
>> instruction.
>>
>> The idea is similar to what BPF_PSEUDO_MAP_FD does today, which
>> is a special src_reg flag for ldimm64 instruction that indicates
>> that inside the first part of the double insns's imm field is a
>> file descriptor which the verifier then replaces as a full 64bit
>> address of the map into both imm parts.
>>
>> For the newly added BPF_PSEUDO_MAP_VALUE src_reg flag, the idea
>> is similar: the first part of the double insns's imm field is
>> again a file descriptor corresponding to the map, and the second
>> part of the imm field is an offset. The verifier will then replace
>> both imm parts with an address that points into the BPF map value
>> for maps that support this operation. BPF_PSEUDO_MAP_VALUE is a
>> distinct flag as otherwise with BPF_PSEUDO_MAP_FD we could not
>> differ offset 0 between load of map pointer versus load of map's
>> value at offset 0.
>>
>> This allows for efficiently retrieving an address to a map value
>> memory area without having to issue a helper call which needs to
>> prepare registers according to calling convention, etc, without
>> needing the extra NULL test, and without having to add the offset
>> in an additional instruction to the value base pointer.
>>
>> The verifier then treats the destination register as PTR_TO_MAP_VALUE
>> with constant reg->off from the user passed offset from the second
>> imm field, and guarantees that this is within bounds of the map
>> value. Any subsequent operations are normally treated as typical
>> map value handling without anything else needed for verification.
>>
>> The two map operations for direct value access have been added to
>> array map for now. In future other types could be supported as
>> well depending on the use case. The main use case for this commit
>> is to allow for BPF loader support for global variables that
>> reside in .data/.rodata/.bss sections such that we can directly
>> load the address of them with minimal additional infrastructure
>> required. Loader support has been added in subsequent commits for
>> libbpf library.
> 
> The patch version #1 provides a way to replace the load with
> immediate (presumably read-only data). This will be good for
> the use case like below:
> 
>     if (static_variable_kernel_version == V1) {
>         /* code here will work for kernel V1 */
>         ... access helpers available for V1 ...
>     } else if (static_variable_kernel_version == V2) {
>         /* code here will work for kernel V2 */
>         ... access helpers available for V2 ...
>     }
> 
> The approach here did not replace the map value access with values from 
> e.g., readonly section for which libbpf could provide an interface to 
> fill in data from user.
> 
> This may require a little more analysis, e.g.,
>     ptr = ld_imm64 from a readonly section
>     ...
>     *(u32 *)ptr;
>     *(u64 *)(ptr + 8);
>     ...
> 
> Do you think we could do this in kernel verifier or we should
> push the whole readonly stuff into user space?

And in your case the static_variable_kernel_version would be determined
at runtime, for example, where you then would want to eliminate all the
other branches, right? Meaning, you'd need a way to turn this into a imm
load such that verifier will detect these dead branches and patch them
out, which it should already be able to do. How would you mark these
special vars like static_variable_kernel_version such that they have
special treatment from the rest, some sort of builtin? Potentially one
could get away with doing this from loader side if it's simple enough,
though one thing that would be good to avoid is to duplicate all the
complex branch fixup logic etc that we have in kernel already. Are you
thinking to mark these via BTF in some way such that loader does inline
replacement?

Thanks,
Daniel
