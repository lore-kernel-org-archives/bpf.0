Return-Path: <SRS0=GR7L=RI=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3375FC43381
	for <bpf@archiver.kernel.org>; Tue,  5 Mar 2019 02:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAE6B206B6
	for <bpf@archiver.kernel.org>; Tue,  5 Mar 2019 02:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kVWmWDvo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfCEC3C (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 4 Mar 2019 21:29:02 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:39360 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbfCEC3C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 4 Mar 2019 21:29:02 -0500
Received: by mail-pf1-f194.google.com with SMTP id i20so4442901pfo.6;
        Mon, 04 Mar 2019 18:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+KkfnrRPzKEaVvK6hQX2VOG2vZ21cCOdw4HHZb6qdt8=;
        b=kVWmWDvoOjZAvbW0/fVkFVBZJ2myyRoNDAzrTUfHgKJC+qaLlYCUzb1xEF1hKPxer/
         WOMigKsQehl/iIjRerL/MDACafLVcQeV9BQT2HFj2kYeCp145GohkYVnuB7CaeW1AM51
         r0egOnAQ1xrpiX4Am+A+SgqHgr7LGB0JeV2rTSARKLWv1Q/6F4LLF90xyjka42ebxr2v
         2MYZJ1XDhlZazWwZyW0LzY5MFZ892+etWse/SiN7fhrVzjN/51Yqff148ASbORlXvc4V
         QeA9RgQl7EatjsZEAaDiWCb6WwyAI3GDFjmOwNnYOyhMIHYnCo+vMm+BvDtj+0Pg0lf7
         rpKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+KkfnrRPzKEaVvK6hQX2VOG2vZ21cCOdw4HHZb6qdt8=;
        b=qxdW5r9DBZpVZI8c2D9PoY+r0yJSik7EJp7LJeneuwqIeawI4y9CD1HeMn2i8I6Vdg
         DYHaF9ougM4LW1WyOyyg8GObGXce4G8a9/7w1pG9uVNOgyirsi/n91FeWJjaGGwTNs8A
         Kbd0klQTNzCziwK4XfEoKxYjHUynjxrwysualm0x9LZ7F5qUUb/Skz7B7f+tGE17QMnK
         L4lJ/snvvR32QVptlnVf6qf6T8VQQqM43sXeI5+Ve0qDlfiztGbCZB0VTlUPPLzaBPEd
         BJwlkMY0iIUSW2YyoaqvSnwh5HJjoj9zb7yTVjM6wNwXnCj/zz/O+7iFTzksZtTLhriD
         6psQ==
X-Gm-Message-State: APjAAAUYVLsErHgVeSfWoK5E7HtH0bo2LPWb0raX11pzhaOuAOfbq9iE
        SJf/Ypns+fLpLezrg6btoGI=
X-Google-Smtp-Source: AHgI3IaCI8+9FnwD5Q5UMqqlOPxymj4rlCkbdj8Ny9/mRypCNnRL5ISTpHsXM++4qq4CoY+zNKiVjA==
X-Received: by 2002:aa7:8205:: with SMTP id k5mr22742526pfi.86.1551752940836;
        Mon, 04 Mar 2019 18:29:00 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:200::1:c0b5])
        by smtp.gmail.com with ESMTPSA id n18sm14181843pfh.93.2019.03.04.18.28.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 18:29:00 -0800 (PST)
Date:   Mon, 4 Mar 2019 18:28:58 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
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
Subject: static bpf vars. Was: [PATCH bpf-next v2 5/7] bpf, libbpf: support
 global data/bss/rodata sections
Message-ID: <20190305022856.uynexxxywfixzvl7@ast-mbp.dhcp.thefacebook.com>
References: <20190228231829.11993-1-daniel@iogearbox.net>
 <20190228231829.11993-6-daniel@iogearbox.net>
 <1e21ba74-f236-60b8-f33c-f3f060419197@fb.com>
 <CAEf4BzYx=05UXSkOpRdKzhXenXJpRYrukgnG7fGjTSR30wLz-Q@mail.gmail.com>
 <e8678d06-20e0-5501-7cff-62de57a2cdf2@fb.com>
 <CAEf4BzZWZmTFj0Xqf+_1QoT5E6tt7ijmzk39khgZ2zYfe0QFUw@mail.gmail.com>
 <e6157f2f-80e4-6a99-2053-498e0581a0db@fb.com>
 <93e20522-cafd-ee1f-1dc1-3cebab122588@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93e20522-cafd-ee1f-1dc1-3cebab122588@iogearbox.net>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 01, 2019 at 09:06:35PM +0100, Daniel Borkmann wrote:
> 

Overall I think the patches and direction is great.
Thanks a lot for working on it.
More thoughts below:

> By the way, from LLVM side, do you think it makes sense for local vars
> where you encode the offset into insn->imm to already encode it into
> (insn+1)->imm of the ldimm64, so that loaders can just pass this offset
> through instead of fixing it up like I did? I'm fine either way though,
> just thought might be worth pointing out while we're at it. :)

1.
typical ldimm64 carries 64-bit value. upper 32-bits are in insn[1]->imm.
I think it's better to stick to this meaning of imm for encoding
the section offset and keep it in insn[0]->imm.
Especially since from disassembler pov it looks like normal ldimm64 with relocation.
Later libbpf does PSEUDO trick and can move [0]->imm to [1]->imm.
Or it can use [1]->imm to store FD to pass to kernel?
Another alternative is to use 16-bit of 'off' to encode the offset,
but the limit of 32kbyte of static variables is probably too small.

2.
I think it's better to only allow 'static int foo' in libbpf for now.
In C 'global' variables suppose to be shareable across multiple elf files.
libbpf doesn't have support for it yet. We need to start discussing this multi elf
support which will lead into discussion about bpf libraries.
I think we need a bit of freedom to decide the meaning of 'global' modifier.
So for now I would support only 'static int foo' in libbpf.
llvm supports both and that's ok, since that's a standard elf markings.

Also were these patches tested with 'static struct {int a; int b;} foo;' and
'static char foo[]="my string";' ?
I suspect it should 'just work' with proposed design, but would be good to have a test.

3.
let's come up with concrete plan for BTF for these static variables.
With normal maps the BTF was retrofitted via BPF_ANNOTATE_KV_PAIR macro
and no one is proud of this interface choice. We had 'struct bpf_map_def'
and the macro was the least evil.
For static variables let's figure out how to integrate BTF into it cleanly.
LLVM already knows about the types. It needs another kind to describe
the variable names and offsets. I think what we did with BTF_KIND_FUNC
should be applicable here. Last time we discussed that we will add BTF_KIND_VAR
for this purpose. Shouldn't be too much work to hack it into llvm now?
I would even go a step further and make BTF to be mandatory for static vars.
Introspection of BPF programs will go long way.

4.
if we make BTF mandatory then the issue of map names will be solved too.
The <obj>.bss/data/rodata might not fit into map_name[16],
but with BTF we can give it full name.
"<obj>.data" looks great to me especially from introspection angle.

5.
I think it makes sense to keep .bss vs .data vs .rodata separate.
I can imagine a program using large zero-inited static array.
It's important to save space in elf file, save time to do map create
and map populate. With combined .data and .bss it would be much harder.

6.
as the next step would be good to add two new syscall command to read/write
individual static variables. Something like:
bpf_map_read/write_bytes(map, key, offset_in_value, buf, size_of_buf)
would allow user space to tweak certain variables.
With mandatory BTF we can have an api to read/write variable by name
(and not only by offset).
Such bpf_map_read_bytes() would be useful for regular hash maps too.
It's convenient to be able to update few bytes in the hash value instead
of overwriting the whole thing.

7.
since these 3 maps are created as normal arrays from kernel pov
the 'bpftool map show' should not exclude them from the output.
Similarly libbpf api bpf_object__for_each_map() and bpf_map__next()
should probably include them too. There can be bpf_map__is_pseudo() flag
to tell them apart, but since it's a normal map in the kernel
other libbpf accessors bpf_map__name(), bpf_map__pin() should work too.

