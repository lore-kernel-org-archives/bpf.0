Return-Path: <SRS0=GR7L=RI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2534C43381
	for <bpf@archiver.kernel.org>; Tue,  5 Mar 2019 09:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC9D520684
	for <bpf@archiver.kernel.org>; Tue,  5 Mar 2019 09:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfCEJba (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 5 Mar 2019 04:31:30 -0500
Received: from www62.your-server.de ([213.133.104.62]:59682 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726098AbfCEJba (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 5 Mar 2019 04:31:30 -0500
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <daniel@iogearbox.net>)
        id 1h16Q1-0005h0-BQ; Tue, 05 Mar 2019 10:31:25 +0100
Received: from [178.197.248.17] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1h16Q1-000Xaj-0b; Tue, 05 Mar 2019 10:31:25 +0100
Subject: Re: static bpf vars. Was: [PATCH bpf-next v2 5/7] bpf, libbpf:
 support global data/bss/rodata sections
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "joe@wand.net.nz" <joe@wand.net.nz>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "tgraf@suug.ch" <tgraf@suug.ch>, Andrii Nakryiko <andriin@fb.com>,
        "jakub.kicinski@netronome.com" <jakub.kicinski@netronome.com>,
        "lmb@cloudflare.com" <lmb@cloudflare.com>
References: <20190228231829.11993-1-daniel@iogearbox.net>
 <20190228231829.11993-6-daniel@iogearbox.net>
 <1e21ba74-f236-60b8-f33c-f3f060419197@fb.com>
 <CAEf4BzYx=05UXSkOpRdKzhXenXJpRYrukgnG7fGjTSR30wLz-Q@mail.gmail.com>
 <e8678d06-20e0-5501-7cff-62de57a2cdf2@fb.com>
 <CAEf4BzZWZmTFj0Xqf+_1QoT5E6tt7ijmzk39khgZ2zYfe0QFUw@mail.gmail.com>
 <e6157f2f-80e4-6a99-2053-498e0581a0db@fb.com>
 <93e20522-cafd-ee1f-1dc1-3cebab122588@iogearbox.net>
 <20190305022856.uynexxxywfixzvl7@ast-mbp.dhcp.thefacebook.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <f6760fc2-9cf9-eadb-eba9-c7af953a703f@iogearbox.net>
Date:   Tue, 5 Mar 2019 10:31:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20190305022856.uynexxxywfixzvl7@ast-mbp.dhcp.thefacebook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.2/25378/Mon Mar  4 11:47:26 2019)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 03/05/2019 03:28 AM, Alexei Starovoitov wrote:
> On Fri, Mar 01, 2019 at 09:06:35PM +0100, Daniel Borkmann wrote:
> 
> Overall I think the patches and direction is great.
> Thanks a lot for working on it.
> More thoughts below:

Okay, thanks!

>> By the way, from LLVM side, do you think it makes sense for local vars
>> where you encode the offset into insn->imm to already encode it into
>> (insn+1)->imm of the ldimm64, so that loaders can just pass this offset
>> through instead of fixing it up like I did? I'm fine either way though,
>> just thought might be worth pointing out while we're at it. :)
> 
> 1.
> typical ldimm64 carries 64-bit value. upper 32-bits are in insn[1]->imm.
> I think it's better to stick to this meaning of imm for encoding
> the section offset and keep it in insn[0]->imm.
> Especially since from disassembler pov it looks like normal ldimm64 with relocation.

Hadn't thought about it from this angle, but yes, from debugging /disasm
point of view it makes perfect sense to keep it as-is.

> Later libbpf does PSEUDO trick and can move [0]->imm to [1]->imm.
> Or it can use [1]->imm to store FD to pass to kernel?

My preference would rather be the former as it's consistent with how
we do it for normal map fds as well, so I'd keep loader side having it
moved as it currently is; I think it's fine.

> Another alternative is to use 16-bit of 'off' to encode the offset,
> but the limit of 32kbyte of static variables is probably too small.

Yes agree, and I've also reused both off fields now for optionally
allowing to select an index into the array based on Andrii's feedback.

> 2.
> I think it's better to only allow 'static int foo' in libbpf for now.
> In C 'global' variables suppose to be shareable across multiple elf files.
> libbpf doesn't have support for it yet. We need to start discussing this multi elf
> support which will lead into discussion about bpf libraries.
> I think we need a bit of freedom to decide the meaning of 'global' modifier.
> So for now I would support only 'static int foo' in libbpf.
> llvm supports both and that's ok, since that's a standard elf markings.

Makes sense, we first need to have a better understanding on how semantics
should look there from BPF pov. I'll restrict libbpf for static vars for
the time being, and throw an error message otherwise.

There is one more semantical question: a BPF ELF file can have multiple
program entry points in it. Both programs from there could refer to static
global variables inside that object file. My thinking which this patch set
also implemented is to have both of them refer to the same .bss/.data/.rodata
map (and _not_ separate ones) as I think this would also naturally be what
the user is expecting when referring to the same global vars in the given
object file.

> Also were these patches tested with 'static struct {int a; int b;} foo;' and
> 'static char foo[]="my string";' ?
> I suspect it should 'just work' with proposed design, but would be good to have a test.

+1, I'll add more tests. Iirc, I tested it back with the original prototype
from LPC which worked same way from high level point of view, but good to
have it explicitly in BPF selftests, agree, will add.

> 3.
> let's come up with concrete plan for BTF for these static variables.
> With normal maps the BTF was retrofitted via BPF_ANNOTATE_KV_PAIR macro
> and no one is proud of this interface choice. We had 'struct bpf_map_def'
> and the macro was the least evil.
> For static variables let's figure out how to integrate BTF into it cleanly.
> LLVM already knows about the types. It needs another kind to describe
> the variable names and offsets. I think what we did with BTF_KIND_FUNC
> should be applicable here. Last time we discussed that we will add BTF_KIND_VAR
> for this purpose. Shouldn't be too much work to hack it into llvm now?
> I would even go a step further and make BTF to be mandatory for static vars.
> Introspection of BPF programs will go long way.

We can make that mandatory, nice thing would be that such BPF_ANNOTATE_KV_PAIR
macro hack wouldn't be needed at all. From BTF pov, that would be some sort of
BTF_KIND_SEC as a section 'container' for all BTF_KIND_VAR variables belonging
to it, so map could use its id to describe its map value as such?

> 4.
> if we make BTF mandatory then the issue of map names will be solved too.
> The <obj>.bss/data/rodata might not fit into map_name[16],
> but with BTF we can give it full name.
> "<obj>.data" looks great to me especially from introspection angle.

+1

> 5.
> I think it makes sense to keep .bss vs .data vs .rodata separate.
> I can imagine a program using large zero-inited static array.
> It's important to save space in elf file, save time to do map create
> and map populate. With combined .data and .bss it would be much harder.

I'm fine either way, but yeah, this approach as also taken here means less
fixing up from loader pov, and it would probably also make BTF handling
easier. So, sticking with separate .bss/.data/.rodata then.

> 6.
> as the next step would be good to add two new syscall command to read/write
> individual static variables. Something like:
> bpf_map_read/write_bytes(map, key, offset_in_value, buf, size_of_buf)
> would allow user space to tweak certain variables.
> With mandatory BTF we can have an api to read/write variable by name
> (and not only by offset).
> Such bpf_map_read_bytes() would be useful for regular hash maps too.
> It's convenient to be able to update few bytes in the hash value instead
> of overwriting the whole thing.

Definitely useful, there was also the suggestion to have an mmap interface
which would work at least for array maps, though haven't looked yet into
what would be needed from buffer mgmt side to remap for processes that just
got the fd by id or via bpf fs for retrieving existing content.

> 7.
> since these 3 maps are created as normal arrays from kernel pov
> the 'bpftool map show' should not exclude them from the output.
> Similarly libbpf api bpf_object__for_each_map() and bpf_map__next()
> should probably include them too. There can be bpf_map__is_pseudo() flag
> to tell them apart, but since it's a normal map in the kernel
> other libbpf accessors bpf_map__name(), bpf_map__pin() should work too.

Yeah, I'll integrate it there in libbpf, as long as we have something to
tell them apart from a user pov it should be good.

Thanks,
Daniel
