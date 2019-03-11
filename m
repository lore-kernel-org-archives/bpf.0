Return-Path: <SRS0=tULY=RO=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03D7EC43381
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 14:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B22962087C
	for <bpf@archiver.kernel.org>; Mon, 11 Mar 2019 14:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HEQS5guV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbfCKOx7 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 11 Mar 2019 10:53:59 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34591 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbfCKOx7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 11 Mar 2019 10:53:59 -0400
Received: by mail-qt1-f195.google.com with SMTP id x20so5342578qto.1;
        Mon, 11 Mar 2019 07:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a4mliWS6Bd8pbSMeyvcO6AbggVA/SU0o3N8GLGGMdm4=;
        b=HEQS5guVyUJrf7KybOW5ZOnCAuUehzhXkYoBzujODeaRu8Lw4PsBsxmf5kpsh7RBI+
         QYWSQu8J18h5QSVk5yNulU8+ylYS0gTRB3NvGv6xrXA+DuK9tfN5SJxNDKiayWgx8/0S
         soaSJz9OJ+W/F/NEG9eZwM+Jz79pqoAiXCLSjDp1UXeFOPksRNaaq+z9S7g3RADgZDKl
         SMuR4MZmd1edQli8mxE1o9G3ZYDBbUNwpkb3hxQzu2w6vEYTUtyeQLrLyKFai2Bzfif/
         DLoFRH/X8waOP6iqFUwBsHYYwQPd8DHDwq4tQOK5U5f5LSRcEK4VYnw5rkuizQnGIjXg
         ZJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a4mliWS6Bd8pbSMeyvcO6AbggVA/SU0o3N8GLGGMdm4=;
        b=Rx76NEquK/YThRdWlBpIdeen1SNzVBY5TuZx+30V7keNjhrNB55DBanZHP8UGDNbb/
         RhmBFWorWIbmPJXFhu4nM7EhDRlu6JXVCoiOql30xeliva2U7w4KUPqeqQi//E9FpVDE
         LflU/YHzX0S/xxAu/jv7v12PTYkuQURgXz4cuP/mB2CUHQ7dxIIQgbkmvvY6YQ4TWzor
         vc2lLj7zVMgiKKl3zOPXZUxCLM1/sY/wC10eBhJ4l63LEnZreEVeH1TH5Ldg1TX6QTD0
         F2ELq8fjhPtu4p2FdBjzA+PDhy72X6ItLbgNI8meh7cL9KT5jFHWen78cxwXXWrqkpQC
         Z6TQ==
X-Gm-Message-State: APjAAAVDDc6G9rf3Neq33AByBQMOCarODwqEasa4WgAh/rOU/QuDEhWq
        JsB3jEIS5bAxT75Ozw3QZ7VoCF4F
X-Google-Smtp-Source: APXvYqyX2Y3dPCVlUclJBTY1P2Qv+Jvn7N02UIvo2/9h7dKuzie7+vRZvEpZNLNmLbN0ws0absJZNQ==
X-Received: by 2002:a0c:ae27:: with SMTP id y36mr26639648qvc.185.1552316037275;
        Mon, 11 Mar 2019 07:53:57 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id s20sm2917338qth.56.2019.03.11.07.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Mar 2019 07:53:56 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3C9114039C; Mon, 11 Mar 2019 11:53:53 -0300 (-03)
Date:   Mon, 11 Mar 2019 11:53:53 -0300
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>, Martin Lau <kafai@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH pahole] pahole: use 32-bit integers for iterations within
 CU
Message-ID: <20190311145353.GL10690@kernel.org>
References: <20190307002321.4071708-1-andriin@fb.com>
 <20190307140247.GV13100@kernel.org>
 <20190308002637.GF32240@kernel.org>
 <20190308184517.GI10690@kernel.org>
 <CAEf4Bzb__EgBCV4HRPTmgY2WwTmq=C+hdG0wDQOOJpZmMeeQ9A@mail.gmail.com>
 <CAEf4Bzb0SpvXdDKMMnUof==kp4Y0AP54bKFjeCzX_AsmDm7k7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEf4Bzb0SpvXdDKMMnUof==kp4Y0AP54bKFjeCzX_AsmDm7k7g@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Sun, Mar 10, 2019 at 09:31:51PM -0700, Andrii Nakryiko escreveu:
> On Fri, Mar 8, 2019 at 11:42 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Fri, Mar 8, 2019 at 10:45 AM Arnaldo Carvalho de Melo
> > <arnaldo.melo@gmail.com> wrote:
> > >
> > > Em Thu, Mar 07, 2019 at 09:26:37PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > > Several looks similar and the low hanging fruit to investigate, seems to
> > > > be enum bitfields, and the others may as well end up being the same, in
> > > > miscalculated stats for structs embedded in other structs:
> > >
> > > I had little time to further look into this, but from what I've seen the
> > > good news is that it seems the problem is with the DWARF loader, the BTF
> > > one producing the right results 8-) I'll take a look at a fix you made
> > > for packed enums and probably use the same thing on the DWARF loader.
> >
> > Yeah, I suspected it might be related to base_type__name_to_size()
> > logic I removed for btf_loader. Ideally we should take the size from
> > DWARF data itself (assuming it's there) and remove
> > base_type__name_to_size() and related parts.
> 
> So I got a chance today to verify your changes from
> tmp.type_id_t-as-uint32_t branch. They look good to me. I've tested
> old and new version of pahole on few of my kernel images, both typical
> one and allyesconfig one. They both produced identical binaries after
> BTF encoding and deduplication, which seems to be good indication that
> nothing is broken. I hope you can push those changes into master soon.
> 
> I've also took a brief look at btfdiff differences for allyesconfig.
> There are not that many of them: just 16k of output text, which given
> 200k types is not a lot.
> 
> I've noticed that there are problems for packed enum fields, which are
> not handled properly neither in DWARF, nor in BTF.
> 
> Here's one example:
> 
>  struct myrb_dcdb {
>         unsigned int               target:4;             /*     0:28  4 */
>         unsigned int               channel:4;            /*     0:24  4 */
> 
> -       /* Bitfield combined with next fields */
> +       /* XXX 24 bits hole, try to pack */
> 
>         enum {
>                 MYRB_DCDB_XFER_NONE = 0,
>                 MYRB_DCDB_XFER_DEVICE_TO_SYSTEM = 1,
>                 MYRB_DCDB_XFER_SYSTEM_TO_DEVICE = 2,
>                 MYRB_DCDB_XFER_ILLEGAL = 3,
> -       } data_xfer:2;                                     /*     1     4 */
> +       } data_xfer:2;                                     /*     4     1 */
> 
>         /* Bitfield combined with previous fields */
> 
>         unsigned int               early_status:1;       /*     0:21  4 */
>         unsigned int               rsvd1:1;              /*     0:20  4 */
> 
> -       /* XXX 4 bits hole, try to pack */
> -       /* Bitfield combined with next fields */
> +       /* XXX 28 bits hole, try to pack */
> 
>         enum {
>                 MYRB_DCDB_TMO_24_HRS = 0,
>                 MYRB_DCDB_TMO_10_SECS = 1,
>                 MYRB_DCDB_TMO_60_SECS = 2,
>                 MYRB_DCDB_TMO_10_MINS = 3,
> -       } timeout:2;                                       /*     1     4 */
> +       } timeout:2;                                       /*     4     1 */
> 
>         /* Bitfield combined with previous fields */
> 
> @@ -324624,10 +324641,10 @@ struct myrb_dcdb {
>         unsigned char              rsvd2;                /*    87     1 */
> 
>         /* size: 88, cachelines: 2, members: 17 */
> -       /* bit holes: 2, sum bit holes: 16 bits */
> +       /* bit holes: 3, sum bit holes: 64 bits */
>         /* last cacheline: 24 bytes */
> 
> -       /* BRAIN FART ALERT! 88 != 83 + 0(holes), diff = 5 */
> +       /* BRAIN FART ALERT! 88 != 86 + 0(holes), diff = 2 */
>  };
> 
> 
> Both DWARF and BTF output emits BRAIN FART ALERT and both can't handle
> 2-bit enums.
> 
> Here's source code definition of that struct:
> 
> struct myrb_dcdb {
>         unsigned target:4;                               /* Byte 0 Bits 0-3 */
>         unsigned channel:4;                              /* Byte 0 Bits 4-7 */
>         enum {
>                 MYRB_DCDB_XFER_NONE =           0,
>                 MYRB_DCDB_XFER_DEVICE_TO_SYSTEM = 1,
>                 MYRB_DCDB_XFER_SYSTEM_TO_DEVICE = 2,
>                 MYRB_DCDB_XFER_ILLEGAL =        3
>         } __packed data_xfer:2;                         /* Byte 1 Bits 0-1 */
>         unsigned early_status:1;                        /* Byte 1 Bit 2 */
>         unsigned rsvd1:1;                               /* Byte 1 Bit 3 */
>         enum {
>                 MYRB_DCDB_TMO_24_HRS =  0,
>                 MYRB_DCDB_TMO_10_SECS = 1,
>                 MYRB_DCDB_TMO_60_SECS = 2,
>                 MYRB_DCDB_TMO_10_MINS = 3
>         } __packed timeout:2;                           /* Byte 1 Bits 4-5 */
>         unsigned no_autosense:1;                        /* Byte 1 Bit 6 */
>         unsigned allow_disconnect:1;                    /* Byte 1 Bit 7 */
>         unsigned short xfer_len_lo;                     /* Bytes 2-3 */
>         u32 dma_addr;                                   /* Bytes 4-7 */
>         unsigned char cdb_len:4;                        /* Byte 8 Bits 0-3 */
>         unsigned char xfer_len_hi4:4;                   /* Byte 8 Bits 4-7 */
>         unsigned char sense_len;                        /* Byte 9 */
>         unsigned char cdb[12];                          /* Bytes 10-21 */
>         unsigned char sense[64];                        /* Bytes 22-85 */
>         unsigned char status;                           /* Byte 86 */
>         unsigned char rsvd2;                            /* Byte 87 */
> };
> 
> I've checked raw BTF data for that struct:
> 
> [12835109] <STRUCT> 'myrb_dcdb' (17 members)
>     #00 target (off=0, sz=4) --> [12832925]
>     #01 channel (off=4, sz=4) --> [12832925]
>     #02 data_xfer (off=32, sz=2) --> [12835107]
>     #03 early_status (off=10, sz=1) --> [12832925]
>     #04 rsvd1 (off=11, sz=1) --> [12832925]
>     #05 timeout (off=36, sz=2) --> [12835108]
>     #06 no_autosense (off=14, sz=1) --> [12832925]
>     #07 allow_disconnect (off=15, sz=1) --> [12832925]
>     #08 xfer_len_lo (off=16, sz=0) --> [12832933]
>     #09 dma_addr (off=32, sz=0) --> [12832946]
>     #10 cdb_len (off=64, sz=4) --> [12832929]
>     #11 xfer_len_hi4 (off=68, sz=4) --> [12832929]
>     #12 sense_len (off=72, sz=0) --> [12832929]
>     #13 cdb (off=80, sz=0) --> [12835084]
>     #14 sense (off=176, sz=0) --> [12835110]
>     #15 status (off=688, sz=0) --> [12832929]
>     #16 rsvd2 (off=696, sz=0) --> [12832929]
> 
> off is a bit field offset, sz is bitfield size (0 if not bitfield).
> 
> Notice how data_xfer has correct sz=2, but off=32 is totally wrong and
> should be 8. Similar issue with timeout with sz=2 and off=36 (should
> be 12). So there seem to be some problem when doing DWARF to BTF
> conversion. I haven't had chance to dig deeper, I'll try to create a
> small repro and dig deeper when I get time (it's really hard to work
> with allyesconfig anything due to humongous sizes of data/log/output).

Right, what I'm doing now is to pick the structs that and having things
like:

[acme@quaco pahole]$ size examples/DAC960.o
   text	   data	    bss	    dec	    hex	filename
      0	      0	      0	      0	      0	examples/DAC960.o
[acme@quaco pahole]$ ls -la examples/DAC960.o
-rwxrwxr-x. 1 acme acme 10736 Mar  8 11:07 examples/DAC960.o
[acme@quaco pahole]$ ls -la examples/DAC960.c 
-rw-rw-r--. 1 acme acme 4480 Mar  8 11:04 examples/DAC960.c
[acme@quaco pahole]$ pahole --sizes examples/DAC960.o
myrb_enquiry2	128	0
[acme@quaco pahole]
[acme@quaco pahole]$ btfdiff examples/DAC960.o
--- /tmp/btfdiff.dwarf.VMTvcw	2019-03-11 11:51:07.858695537 -0300
+++ /tmp/btfdiff.btf.f75DjU	2019-03-11 11:51:07.860695576 -0300
@@ -52,18 +52,18 @@ struct myrb_enquiry2 {
 			MYRB_RAM_TYPE_EDO = 1,
 			MYRB_RAM_TYPE_SDRAM = 2,
 			MYRB_RAM_TYPE_Last = 7,
-		} ram:3;                                   /*    40     4 */
+		} ram:3;                                   /*    43     1 */
 		enum {
 			MYRB_ERR_CORR_None = 0,
 			MYRB_ERR_CORR_Parity = 1,
 			MYRB_ERR_CORR_ECC = 2,
 			MYRB_ERR_CORR_Last = 7,
-		} ec:3;                                    /*    40     4 */
-		unsigned char      fast_page:1;          /*    40: 1  1 */
-		unsigned char      low_power:1;          /*    40: 0  1 */
+		} ec:3;                                    /*    43     1 */
 
-		/* Bitfield combined with next fields */
+		/* Bitfield combined with previous fields */
 
+		unsigned char      fast_page:1;          /*    40: 1  1 */
+		unsigned char      low_power:1;          /*    40: 0  1 */
 		unsigned char      rsvd4;                /*    41     1 */
 	} mem_type;                                      /*    40     2 */
 	short unsigned int         clock_speed;          /*    42     2 */
@@ -94,18 +94,18 @@ struct myrb_enquiry2 {
 			MYRB_WIDTH_NARROW_8BIT = 0,
 			MYRB_WIDTH_WIDE_16BIT = 1,
 			MYRB_WIDTH_WIDE_32BIT = 2,
-		} bus_width:2;                             /*   106     4 */
+		} bus_width:2;                             /*   109     1 */
 		enum {
 			MYRB_SCSI_SPEED_FAST = 0,
 			MYRB_SCSI_SPEED_ULTRA = 1,
 			MYRB_SCSI_SPEED_ULTRA2 = 2,
-		} bus_speed:2;                             /*   106     4 */
+		} bus_speed:2;                             /*   109     1 */
+
+		/* Bitfield combined with previous fields */
+
 		unsigned char      differential:1;       /*   106: 3  1 */
 		unsigned char      rsvd10:3;             /*   106: 0  1 */
 	} scsi_cap;                                      /*   106     1 */
-
-	/* XXX last struct has 65533 bytes of padding */
-
 	unsigned char              rsvd11[5];            /*   107     5 */
 	short unsigned int         fw_build;             /*   112     2 */
 	enum {
@@ -127,5 +127,4 @@ struct myrb_enquiry2 {
 	unsigned char              rsvd14[8];            /*   120     8 */
 
 	/* size: 128, cachelines: 2, members: 46 */
-	/* paddings: 1, sum paddings: 65533 */
 };
[acme@quaco pahole]$ 
 
> In any case, what was your plan w.r.t. new release of pahole? Do you
> want to iron out these obscure bitfield problems first and add
> --progress before new version?

--progress can wait, what I would like would be to have btfdiff clean
for that allyesconfig kernel, fixing these last odd cases. Getting the
exact same output (modulo flat arrays and the show_private_classes used
in btfdiff) would inspire more confidence in the whole thing, I think.

I've added your Tested-by to the csets changing uint16_t to uint32_t and
pushing to master now. Will try to spend some time fixing these last
issues.

- Arnaldo
