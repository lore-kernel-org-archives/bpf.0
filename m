Return-Path: <SRS0=L7vf=RB=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BBCC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 01:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6BAD21848
	for <bpf@archiver.kernel.org>; Tue, 26 Feb 2019 01:03:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIw942Pd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725963AbfBZBDa (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 20:03:30 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34487 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbfBZBDa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 20:03:30 -0500
Received: by mail-oi1-f196.google.com with SMTP id g16so9008209oib.1;
        Mon, 25 Feb 2019 17:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zPaTISK1LnyeM0h1K9R8De0x3+CWdc+qhZIYqKMjblQ=;
        b=FIw942Pdile1Qo7oYw9Bym5xI0RFUlT1qODXHU7VFqtNh8Hf1GA4koQQjKx7QCUpoz
         EbUaRAwFaQE9MqwskjWdelUNrblPp9ExDjiiUSulksvEOyryz5dy8y41D05Hoa9/y/+3
         x+ZchRz240NZG0+Zcuc2YPYss2gDXpBnbRKLgvoXfejofoKpYyoU0NFAuqDRKqnA599E
         L9fddhdLLvaHy/HNu4xI8H5inI9qHJTXMOLHsDuzhSwjozmdOpex2aJ1KjY3spSv5bDz
         4yboUvGU5eoLwKfdpGPT0N9QKKVeV9AkGREOSGWmqKx2QFGRISQ4JD/WKAK05wmZggsW
         Ubqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zPaTISK1LnyeM0h1K9R8De0x3+CWdc+qhZIYqKMjblQ=;
        b=MRwkUM7C88AWHqoHCnEWurygU1bp2VeKicPreh97hT5iv3uV7s774tUMUZe0ti1rNo
         hfeBnAbPkayd091CxtiwDKf9l3rs5hx6PXYt2aShOKDVT66J0T17tV3pItjmMPmvSjrs
         CsigMM9xlwzM1RNlhTY5WKpyUegDJd25ksJwDNRlUpGL+NV2+haZ5KHEuP04ROyppO1S
         NPIhbnPRuC4FItK19RFX8W4MZSlbQkNcL1rU7tuiM0gr+RJ7cvRnkASXEU/PaOP1hNgh
         IrQvlE+Ta6gQfu0C7Nq+xl5S4Ojpkdzp0UivSxpHCAMGtITYSmEMfbGKTWR6NGaDgaAj
         oKQw==
X-Gm-Message-State: AHQUAuYd+65EzsTU0PlJycM5LCxImNAbEUex4NpP63US/vdhxtLyZiPF
        K692bOQrqphmPy90+3k+Y9+RLs+LbPpiUxJlqfA=
X-Google-Smtp-Source: AHgI3IZyl0bDwCO0N4Cyu+hgpbFOs43/84z0uwetqZzZR7j3CqE+hP/eXsnisbsZY/f+mj8M2F18dC/7GG2QAj9x4IU=
X-Received: by 2002:aca:d6cc:: with SMTP id n195mr746790oig.27.1551143008888;
 Mon, 25 Feb 2019 17:03:28 -0800 (PST)
MIME-Version: 1.0
References: <20190226000815.385229-1-andriin@fb.com> <20190226000815.385229-3-andriin@fb.com>
 <5096f3f4-7d1d-4f11-9ac7-bd23fcbf1e75@fb.com>
In-Reply-To: <5096f3f4-7d1d-4f11-9ac7-bd23fcbf1e75@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 25 Feb 2019 17:03:17 -0800
Message-ID: <CAEf4BzZkMqPzxV8rM75RkyBJt+YqqnrMq62Thf=zxpjobFoiqQ@mail.gmail.com>
Subject: Re: [PATCH pahole 2/2] btf_encoder: don't special case packed enums
To:     Yonghong Song <yhs@fb.com>
Cc:     Andrii Nakryiko <andriin@fb.com>,
        "acme@kernel.org" <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        "dwarves@vger.kernel.org" <dwarves@vger.kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 25, 2019 at 5:00 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/25/19 4:08 PM, Andrii Nakryiko wrote:
> > BTF data can represent packed enums correctly without any special
> > handling from pahole side. Previously pahole's own `enum vscope` would
> > be omitted causing problems.
> >
> > Repro:
> >
> > $ cat test/packed_enum.c
> > enum packed_enum {
> >          VALUE1,
> >          VALUE2,
> >          VALUE3
> > } __attribute__((packed));
> >
> > struct s {
> >          int x;
> >          enum packed_enum e;
> >          int y;
> > };
> >
> > int main()
> > {
> >          struct s s;
> >          return 0;
> > }
> >
> > $ gcc -g -c test/packed_enum.c -o test/packed_enum.o
> >
> > $ ~/local/pahole/build/pahole -JV test/packed_enum.o
> > File test/packed_enum.o:
> > [1] INT (anon) size=1 bit_offset=0 nr_bits=8 encoding=SIGNED
> > [2] STRUCT s kind_flag=0 size=12 vlen=3
> >          x type_id=3 bits_offset=0
> >          e type_id=1 bits_offset=32
> >          y type_id=3 bits_offset=64
> > [3] INT int size=4 bit_offset=0 nr_bits=32 encoding=SIGNED
> >
> > $ ~/local/pahole/build/pahole -F dwarf test/packed_enum.o
> > struct s {
> >          int                        x;                    /*     0     4 */
> >          enum packed_enum           e;                    /*     4     1 */
> >
> >          /* XXX 3 bytes hole, try to pack */
> >
> >          int                        y;                    /*     8     4 */
> >
> >          /* size: 12, cachelines: 1, members: 3 */
> >          /* sum members: 9, holes: 1, sum holes: 3 */
> >          /* last cacheline: 12 bytes */
> > };
> >
> > $ ~/local/pahole/build/pahole -F btf test/packed_enum.o
> > struct s {
> >          int                        x;                    /*     0     4 */
> >          nameless base type!        e;                    /*     4     1 */
> >
> >          /* XXX 3 bytes hole, try to pack */
> >
> >          int                        y;                    /*     8     4 */
> >
> >          /* size: 12, cachelines: 1, members: 3 */
> >          /* sum members: 9, holes: 1, sum holes: 3 */
> >          /* last cacheline: 12 bytes */
> > };
> >
> > Notice how pahole's log doesn't have a mention of encoding 'packed_enum'
> > (anonymous integer is generated instead), which causes 'nameless base
> > type!' output above.
> >
> > Fix this change:
> >
> > $ ~/local/pahole/build/pahole -JV test/packed_enum.o
> > File test/packed_enum.o:
> > [1] ENUM packed_enum size=1 vlen=3
> >          VALUE1 val=0
> >          VALUE2 val=1
> >          VALUE3 val=2
> > [2] STRUCT s kind_flag=0 size=12 vlen=3
> >          x type_id=3 bits_offset=0
> >          e type_id=1 bits_offset=32
> >          y type_id=3 bits_offset=64
> > [3] INT int size=4 bit_offset=0 nr_bits=32 encoding=SIGNED
> >
> > $ ~/local/pahole/build/pahole -F btf test/packed_enum.o
> > struct s {
> >          int                        x;                    /*     0     4 */
> >          enum packed_enum           e;                    /*     4     1 */
> >
> >          /* XXX 3 bytes hole, try to pack */
> >
> >          int                        y;                    /*     8     4 */
> >
> >          /* size: 12, cachelines: 1, members: 3 */
> >          /* sum members: 9, holes: 1, sum holes: 3 */
> >          /* last cacheline: 12 bytes */
> > };
> >
> > $ PAHOLE=~/local/pahole/build/pahole ./btfdiff test/packed_enum.o
> >
> > Also verified on pahole, kernel and glibc:
> >
> > $ PAHOLE=~/local/pahole/build/pahole ./btfdiff ~/local/btf/pahole.debug
> > $ PAHOLE=~/local/pahole/build/pahole ./btfdiff ~/local/btf/libc-2.28.so.debug
> > $ PAHOLE=~/local/pahole/build/pahole ./btfdiff ~/local/btf/vmlinux4
> >
> > Signed-off-by: Andrii Nakryiko <andriin@fb.com>
>
> Thanks for the fix.
> Maybe add:
> Fixes: b18354f64cc2 ("btf: Generate correct struct bitfield member types")
>
> In commit message, add what Commit b18354f64cc2 tries to do
> and why it is not needed any more.
>   It tries to generate correct struct bitfield member type if the
>   member is an enum. This is dated before kind_flag implementation.
>   later kind_flag supported is added and pahole always generates
>   BTF with kind_flag = 1 for structures with bitfield,
>   where bitfield size is encoded in btf_member,
>   so this workaround is not needed any more.
>   Removing this "hack" can make handling packed enum correctly too.
>
> With this change,
>    Acked-by: Yonghong Song <yhs@fb.com>

Will do! Thanks for providing context. I was guessing this must have
been done before BTF had good support for bitfields.

>
> > ---
> >   btf_encoder.c | 9 ---------
> >   1 file changed, 9 deletions(-)
> >
> > diff --git a/btf_encoder.c b/btf_encoder.c
> > index 9cf0831..d8dc368 100644
> > --- a/btf_encoder.c
> > +++ b/btf_encoder.c
> > @@ -116,15 +116,6 @@ static int32_t enumeration_type__encode(struct btf_elf *btfe, struct tag *tag)
> >       struct enumerator *pos;
> >       int32_t type_id;
> >
> > -     /* if enumerator bit_size is not 32, generate an int type instead. */
> > -     if (etype->size != 32) {
> > -             struct base_type bt = {};
> > -
> > -             bt.bit_size = etype->size;
> > -             bt.is_signed = true;
> > -             return btf_elf__add_base_type(btfe, &bt);
> > -     }
> > -
> >       type_id = btf_elf__add_enum(btfe, etype->namespace.name, etype->size, etype->nr_members);
> >       if (type_id < 0)
> >               return type_id;
> >
