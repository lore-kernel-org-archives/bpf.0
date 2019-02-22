Return-Path: <SRS0=sv//=Q5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DD2C43381
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 23:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A88742075A
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 23:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCxQllPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfBVXYG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 18:24:06 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33560 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbfBVXYG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 18:24:06 -0500
Received: by mail-ot1-f65.google.com with SMTP id q24so3360075otk.0;
        Fri, 22 Feb 2019 15:24:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+i8SReYwZcaD0xQZZOafaxz8Sf4bpLARD5ygIMYYYfc=;
        b=JCxQllPoLLJ9LkWv9RHefcKlZqnRa88RPO1n00korI1cgRQYhVSV/+X28HaDC868WU
         csUf6vtMuJFvW7r8DQyn5dYLJGYLev4UJO3Zl4W8CQNlXJdNY2LzV+5G7lnYpjdOrVJO
         vXlxzr/gBeGcknZoRJDKaVitzL+Aw1Trvi7T6j4H/EdFexucCLyFla0o44VdsBKn1ium
         YbORzG6bhEik7MTZA4lLgWej+8xY6ePTq/7LMn7L7R9xszgQPcNKJkcHazzdEZgdDdi/
         /QJqWekHkzAEozqlg3A6t03kwlfE+kYhQp3g+R1hufAfASD/+XbVzedy0R0MU5iJXvlP
         6WBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+i8SReYwZcaD0xQZZOafaxz8Sf4bpLARD5ygIMYYYfc=;
        b=Ay90xE1vD0ddhfbyDyonE4TI7cfg4MoEGevi0VbqhuxeVraXWR9OOCz5K7xWYCnAXK
         YL8ma3eeeVKusHpmOuqNRxzLRoi4/QR3gumZlF0jw+yuTe72VHb/qts2ryuZfhCvK+Xm
         tU4N7xRWMXufMxNmLrNPVWXRDbW2kjDom4c3VFDz4QWyVS30zM11GXvKVW3AMftTB2NT
         dlpj5Ip6jBv+d9z1BmH8Cj/dMRxZqODjLQR/e12B272Igy/bP1r3YqCxFFmtQEX7XlSH
         Huc2XEMPwjBrh2543ANsivI8b/o2hgRkcajXCan9IIsjMsCjP5qrqj2NwCSdhsLmCNOJ
         1UoQ==
X-Gm-Message-State: AHQUAuY0TFnEAAOLA4NkOzgZAmAn98/GHjf7azS7EKogphLBNxtf9NBl
        P/LyjbPB33GdpeJS0aMFzUSn9pCXUftl3umKqlw=
X-Google-Smtp-Source: AHgI3IaupX5U75+D+yKej9uoaJULp7EKeL9qh5KNzKdt5l8YAfEox6mxVqrIUCvcE72WInuH256H33BUD4HQnueYq+c=
X-Received: by 2002:a05:6830:149a:: with SMTP id s26mr4336548otq.206.1550877844735;
 Fri, 22 Feb 2019 15:24:04 -0800 (PST)
MIME-Version: 1.0
References: <20190220205732.2514975-1-andriin@fb.com> <20190222220243.GI26132@kernel.org>
In-Reply-To: <20190222220243.GI26132@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 22 Feb 2019 15:23:52 -0800
Message-ID: <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
Subject: Re: [PATCH pahole 0/3] fix handling of bitfields in btf_loader
To:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Cc:     Andrii Nakryiko <andriin@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Feb 22, 2019 at 2:02 PM Arnaldo Carvalho de Melo
<arnaldo.melo@gmail.com> wrote:
>
> Em Wed, Feb 20, 2019 at 12:57:29PM -0800, Andrii Nakryiko escreveu:
> > This patchset fixes the logic of determining bitfield_offsets and
> > initial bit_offset when using BTF type information. It eliminates all
> > the remaining discrepancies, when doing btfdiff on vmlinux image, module
> > two instances of incorrectly reporting struct member type name when
> > bitfield is the very first field in a struct, which is only happening
> > when using DWARF data.
> >
> > Patch #1 makes btfdiff script easier to use during local development.
> >
> > Patch #2 fixes list of known base type names to handle clang-generated
> > type descriptions better.
> >
> > Patch #3 fixes bitfield handling logic in btf_loader.
>
> Thanks a lot! Applied.
>
> And here I see no differences in my vmlinux:
>

<SNIP>

>
> Which ones where these: "module two instances of incorrectly reporting struct
> member type name when bitfield is the very first field in a struct, which is
> only happening when using DWARF data." ?

$ ./btfdiff /tmp/vmlinux4
--- /tmp/btfdiff.dwarf.GIVfpr   2019-02-20 12:18:29.138788970 -0800
+++ /tmp/btfdiff.btf.c3x2KY     2019-02-20 12:18:29.351786365 -0800
@@ -16884,7 +16884,7 @@ struct pebs_record_nhm {
 };
 union hsw_tsx_tuning {
        struct {
-               unsigned int       cycles_last_block:32; /*     0: 0  4 */
+               u32                cycles_last_block:32; /*     0: 0  4 */
                u32                hle_abort:1;        /*     4:31  4 */
                u32                rtm_abort:1;        /*     4:30  4 */
                u32                instruction_abort:1; /*     4:29  4 */
@@ -26154,7 +26154,7 @@ struct acpi_device_power {
        /* last cacheline: 40 bytes */
 };
 struct acpi_device_perf_flags {
-       unsigned char              reserved:8;           /*     0: 0  1 */
+       u8                         reserved:8;           /*     0: 0  1 */

        /* size: 1, cachelines: 1, members: 1 */
        /* last cacheline: 1 bytes */

For hsw_tsx_tuning, it is defined in sources like this:

$ cat hsw_tsx_tuning.c
typedef unsigned long long u64;
typedef unsigned int u32;

union hsw_tsx_tuning {
    struct {
        u32 cycles_last_block     : 32,
            hle_abort             : 1,
            rtm_abort             : 1,
            instruction_abort     : 1,
            non_instruction_abort : 1,
            retry                 : 1,
            data_conflict         : 1,
            capacity_writes       : 1,
            capacity_reads        : 1;
    };
    u64        value;
};

int main() {
    union hsw_tsx_tuning t;
    return 0;
}

Building same defition with gcc and clang reveals some more info.

$ cc -g -c hsw_tsx_tuning.c -o hsw_tsx_tuning-gcc &&
~/local/pahole/build/pahole -J hsw_tsx_tuning-gcc
$ clang -g -c hsw_tsx_tuning.c -o hsw_tsx_tuning-clang &&
~/local/pahole/build/pahole -J hsw_tsx_tuning-clang

GCC-generated DWARF/BTF exposes this bug:

$ PAHOLE=~/local/pahole/build/pahole ~/local/pahole/btfdiff hsw_tsx_tuning-gcc
--- /tmp/btfdiff.dwarf.khRiFg   2019-02-22 15:18:46.768858141 -0800
+++ /tmp/btfdiff.btf.jqdEsR     2019-02-22 15:18:46.770858140 -0800
@@ -1,6 +1,6 @@
 union hsw_tsx_tuning {
        struct {
-               unsigned int       cycles_last_block:32; /*     0: 0  4 */
+               u32                cycles_last_block:32; /*     0: 0  4 */
                u32                hle_abort:1;        /*     4:31  4 */
                u32                rtm_abort:1;        /*     4:30  4 */
                u32                instruction_abort:1; /*     4:29  4 */

But the one generated by clang doesn't:

$ PAHOLE=~/local/pahole/build/pahole ~/local/pahole/btfdiff hsw_tsx_tuning-clang

The only difference is that GCC correctly marks cycles_last_block as
bitfield, while clang optimizes it to stand-alone u32.

$ ~/local/pahole/build/pahole -F btf hsw_tsx_tuning-gcc
union hsw_tsx_tuning {
        struct {
                u32                cycles_last_block:32; /*     0: 0  4 */
                u32                hle_abort:1;        /*     4:31  4 */
                u32                rtm_abort:1;        /*     4:30  4 */
                u32                instruction_abort:1; /*     4:29  4 */
                u32                non_instruction_abort:1; /*     4:28  4 */
                u32                retry:1;            /*     4:27  4 */
                u32                data_conflict:1;    /*     4:26  4 */
                u32                capacity_writes:1;  /*     4:25  4 */
                u32                capacity_reads:1;   /*     4:24  4 */
        };                                             /*     0     8 */
        u64                        value;              /*     0     8 */
};

$ ~/local/pahole/build/pahole -F btf hsw_tsx_tuning-clang
union hsw_tsx_tuning {
        struct {
                u32                cycles_last_block;  /*     0     4 */
                u32                hle_abort:1;        /*     4:31  4 */
                u32                rtm_abort:1;        /*     4:30  4 */
                u32                instruction_abort:1; /*     4:29  4 */
                u32                non_instruction_abort:1; /*     4:28  4 */
                u32                retry:1;            /*     4:27  4 */
                u32                data_conflict:1;    /*     4:26  4 */
                u32                capacity_writes:1;  /*     4:25  4 */
                u32                capacity_reads:1;   /*     4:24  4 */
        };                                             /*     0     8 */
        u64                        value;              /*     0     8 */
};

I've spent a bit of time debugging this, but didn't get far, as I'm
pretty unfamiliar with overall flow of decoders, I was hoping this can
give you some idea where to look, though.

>
> - Arnaldo
