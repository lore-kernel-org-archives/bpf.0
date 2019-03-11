Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D09CC43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 04:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09463206DF
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 04:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qdGLiaBq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725802AbfCKEcE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 00:32:04 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33872 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbfCKEcE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 00:32:04 -0400
Received: by mail-oi1-f194.google.com with SMTP id g16so2589867oib.1;
        Sun, 10 Mar 2019 21:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Zo6O4FNVeO4vzitnD6AjxiZqgqO0vtdOBbf2JlQrJM=;
        b=qdGLiaBqg/KgIkPUeNFeDFqg11/pJY8GnlDbMmp1yS9MXr4DNeuqpm+ZMu+ByT+3hD
         JzBTKolNoRJXcQJ3ln/EVxcNtYg7LtLXLObu+/25gjFi22Cq8TLVMUXK3YwJyO/3kIeJ
         0sWI0mBjSeMWKJowhp6wtb6TOzsvYfUdSYBxwK+8pv9cdHQO3HKGMn9ovUAozavIRJuk
         eiirI3YBO4ufo6TtFKGk7sGp+n6cRPvTvybi3mX3B3+eDX2xqUo0S1ZjjEhwySMMXBtD
         AA/lrgGyA01oTROai5Vkx9UUsz7HIGYmcbchoeYdovhZWH5Cwrtr2KKhmHhcNvAjXHgf
         OKCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Zo6O4FNVeO4vzitnD6AjxiZqgqO0vtdOBbf2JlQrJM=;
        b=QNAh8SQc8+OyrRcBQCmGB4JZGD7NmkhNXCLqa88hRYWmJnl+60MYHsBdWzf225FyHa
         ZgbSs1BrwOKW8SbzZOOVRd5gbPSpRzrEngPosbgEUdwZ60lr76HVkb9sVnT4ur4iObpA
         nXmf+BX7to8lcXdRYd6yPU0xg/q1VFJ1VFQJdQJ0+qeMD6as6pZjGn3KecKQ07oAAJan
         H0odsGB+h2lrgdv0nWNji0VwwfusUsDYH8I579yRN0mvJQPP+87XWKZTXH/acegeJ1C8
         pr5QXmlin8uXMLRDv+Pgncmxm9IDE9GU2NytXDomiprsWQgIgFGxEg8zVmt0DqDgbKIb
         Vw4g==
X-Gm-Message-State: APjAAAVmv02M18KmBmObVpjmEiM+ovhZgjk+nQ+oegcqfx3yWSFbJmpE
        VEJtRxQiU+VmkZOxtkr0k7JqTljdj8yIsQq3syXbVIl4U8Q=
X-Google-Smtp-Source: APXvYqy5fsE/U2yjaFoz5Q3tnQsn9ytmaeXoINW1MH78AiP4sZIuPaDsjKijWNSaXGLYVmqUQ9qGc2Hg15EZ7bUuKPg=
X-Received: by 2002:aca:abcf:: with SMTP id u198mr14698332oie.55.1552278722773;
 Sun, 10 Mar 2019 21:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20190307002321.4071708-1-andriin@fb.com> <20190307140247.GV13100@kernel.org>
 <20190308002637.GF32240@kernel.org> <20190308184517.GI10690@kernel.org> <CAEf4Bzb__EgBCV4HRPTmgY2WwTmq=C+hdG0wDQOOJpZmMeeQ9A@mail.gmail.com>
In-Reply-To: <CAEf4Bzb__EgBCV4HRPTmgY2WwTmq=C+hdG0wDQOOJpZmMeeQ9A@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Sun, 10 Mar 2019 21:31:51 -0700
Message-ID: <CAEf4Bzb0SpvXdDKMMnUof==kp4Y0AP54bKFjeCzX_AsmDm7k7g@mail.gmail.com>
Subject: Re: [PATCH pahole] pahole: use 32-bit integers for iterations within CU
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, Alexei Starovoitov <ast@fb.com>,
        Yonghong Song <yhs@fb.com>, Song Liu <songliubraving@fb.com>,
        Martin Lau <kafai@fb.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 8, 2019 at 11:42 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Fri, Mar 8, 2019 at 10:45 AM Arnaldo Carvalho de Melo
> <arnaldo.melo@gmail.com> wrote:
> >
> > Em Thu, Mar 07, 2019 at 09:26:37PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Several looks similar and the low hanging fruit to investigate, seems to
> > > be enum bitfields, and the others may as well end up being the same, in
> > > miscalculated stats for structs embedded in other structs:
> >
> > I had little time to further look into this, but from what I've seen the
> > good news is that it seems the problem is with the DWARF loader, the BTF
> > one producing the right results 8-) I'll take a look at a fix you made
> > for packed enums and probably use the same thing on the DWARF loader.
>
> Yeah, I suspected it might be related to base_type__name_to_size()
> logic I removed for btf_loader. Ideally we should take the size from
> DWARF data itself (assuming it's there) and remove
> base_type__name_to_size() and related parts.

So I got a chance today to verify your changes from
tmp.type_id_t-as-uint32_t branch. They look good to me. I've tested
old and new version of pahole on few of my kernel images, both typical
one and allyesconfig one. They both produced identical binaries after
BTF encoding and deduplication, which seems to be good indication that
nothing is broken. I hope you can push those changes into master soon.

I've also took a brief look at btfdiff differences for allyesconfig.
There are not that many of them: just 16k of output text, which given
200k types is not a lot.

I've noticed that there are problems for packed enum fields, which are
not handled properly neither in DWARF, nor in BTF.

Here's one example:

 struct myrb_dcdb {
        unsigned int               target:4;             /*     0:28  4 */
        unsigned int               channel:4;            /*     0:24  4 */

-       /* Bitfield combined with next fields */
+       /* XXX 24 bits hole, try to pack */

        enum {
                MYRB_DCDB_XFER_NONE = 0,
                MYRB_DCDB_XFER_DEVICE_TO_SYSTEM = 1,
                MYRB_DCDB_XFER_SYSTEM_TO_DEVICE = 2,
                MYRB_DCDB_XFER_ILLEGAL = 3,
-       } data_xfer:2;                                     /*     1     4 */
+       } data_xfer:2;                                     /*     4     1 */

        /* Bitfield combined with previous fields */

        unsigned int               early_status:1;       /*     0:21  4 */
        unsigned int               rsvd1:1;              /*     0:20  4 */

-       /* XXX 4 bits hole, try to pack */
-       /* Bitfield combined with next fields */
+       /* XXX 28 bits hole, try to pack */

        enum {
                MYRB_DCDB_TMO_24_HRS = 0,
                MYRB_DCDB_TMO_10_SECS = 1,
                MYRB_DCDB_TMO_60_SECS = 2,
                MYRB_DCDB_TMO_10_MINS = 3,
-       } timeout:2;                                       /*     1     4 */
+       } timeout:2;                                       /*     4     1 */

        /* Bitfield combined with previous fields */

@@ -324624,10 +324641,10 @@ struct myrb_dcdb {
        unsigned char              rsvd2;                /*    87     1 */

        /* size: 88, cachelines: 2, members: 17 */
-       /* bit holes: 2, sum bit holes: 16 bits */
+       /* bit holes: 3, sum bit holes: 64 bits */
        /* last cacheline: 24 bytes */

-       /* BRAIN FART ALERT! 88 != 83 + 0(holes), diff = 5 */
+       /* BRAIN FART ALERT! 88 != 86 + 0(holes), diff = 2 */
 };


Both DWARF and BTF output emits BRAIN FART ALERT and both can't handle
2-bit enums.

Here's source code definition of that struct:

struct myrb_dcdb {
        unsigned target:4;                               /* Byte 0 Bits 0-3 */
        unsigned channel:4;                              /* Byte 0 Bits 4-7 */
        enum {
                MYRB_DCDB_XFER_NONE =           0,
                MYRB_DCDB_XFER_DEVICE_TO_SYSTEM = 1,
                MYRB_DCDB_XFER_SYSTEM_TO_DEVICE = 2,
                MYRB_DCDB_XFER_ILLEGAL =        3
        } __packed data_xfer:2;                         /* Byte 1 Bits 0-1 */
        unsigned early_status:1;                        /* Byte 1 Bit 2 */
        unsigned rsvd1:1;                               /* Byte 1 Bit 3 */
        enum {
                MYRB_DCDB_TMO_24_HRS =  0,
                MYRB_DCDB_TMO_10_SECS = 1,
                MYRB_DCDB_TMO_60_SECS = 2,
                MYRB_DCDB_TMO_10_MINS = 3
        } __packed timeout:2;                           /* Byte 1 Bits 4-5 */
        unsigned no_autosense:1;                        /* Byte 1 Bit 6 */
        unsigned allow_disconnect:1;                    /* Byte 1 Bit 7 */
        unsigned short xfer_len_lo;                     /* Bytes 2-3 */
        u32 dma_addr;                                   /* Bytes 4-7 */
        unsigned char cdb_len:4;                        /* Byte 8 Bits 0-3 */
        unsigned char xfer_len_hi4:4;                   /* Byte 8 Bits 4-7 */
        unsigned char sense_len;                        /* Byte 9 */
        unsigned char cdb[12];                          /* Bytes 10-21 */
        unsigned char sense[64];                        /* Bytes 22-85 */
        unsigned char status;                           /* Byte 86 */
        unsigned char rsvd2;                            /* Byte 87 */
};

I've checked raw BTF data for that struct:

[12835109] <STRUCT> 'myrb_dcdb' (17 members)
    #00 target (off=0, sz=4) --> [12832925]
    #01 channel (off=4, sz=4) --> [12832925]
    #02 data_xfer (off=32, sz=2) --> [12835107]
    #03 early_status (off=10, sz=1) --> [12832925]
    #04 rsvd1 (off=11, sz=1) --> [12832925]
    #05 timeout (off=36, sz=2) --> [12835108]
    #06 no_autosense (off=14, sz=1) --> [12832925]
    #07 allow_disconnect (off=15, sz=1) --> [12832925]
    #08 xfer_len_lo (off=16, sz=0) --> [12832933]
    #09 dma_addr (off=32, sz=0) --> [12832946]
    #10 cdb_len (off=64, sz=4) --> [12832929]
    #11 xfer_len_hi4 (off=68, sz=4) --> [12832929]
    #12 sense_len (off=72, sz=0) --> [12832929]
    #13 cdb (off=80, sz=0) --> [12835084]
    #14 sense (off=176, sz=0) --> [12835110]
    #15 status (off=688, sz=0) --> [12832929]
    #16 rsvd2 (off=696, sz=0) --> [12832929]

off is a bit field offset, sz is bitfield size (0 if not bitfield).

Notice how data_xfer has correct sz=2, but off=32 is totally wrong and
should be 8. Similar issue with timeout with sz=2 and off=36 (should
be 12). So there seem to be some problem when doing DWARF to BTF
conversion. I haven't had chance to dig deeper, I'll try to create a
small repro and dig deeper when I get time (it's really hard to work
with allyesconfig anything due to humongous sizes of data/log/output).

In any case, what was your plan w.r.t. new release of pahole? Do you
want to iron out these obscure bitfield problems first and add
--progress before new version?


>
> >
> > - Arnaldo
> >
> > > $ btfdiff examples/vmlinux-aarch64
> > > --- /tmp/btfdiff.dwarf.81KCPb 2019-03-07 18:20:13.153319625 -0300
> > > +++ /tmp/btfdiff.btf.g1QkcZ   2019-03-07 18:20:13.928328675 -0300
>
> <snip>
