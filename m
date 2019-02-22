Return-Path: <SRS0=sv//=Q5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F6CC43381
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 22:02:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10FA9206DD
	for <bpf@archiver.kernel.org>; Fri, 22 Feb 2019 22:02:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oqfFAMPp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725814AbfBVWC4 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Fri, 22 Feb 2019 17:02:56 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43785 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbfBVWC4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Feb 2019 17:02:56 -0500
Received: by mail-qt1-f193.google.com with SMTP id y4so4268144qtc.10;
        Fri, 22 Feb 2019 14:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WG0IHz3ZKMmoEBvW4H33j4lbr7yfknV4NwgWlfpc85g=;
        b=oqfFAMPp8iYlskf/iqhAxJLyKtfaT89fpzHVKAyNRa2UM8w+GC7+FZGb3P3mlf/qCn
         j07yfCsyxlcdA/ZkibIUJxSYSt8HXsufHIKrPLPD5o2y2fzlw7r0rT0Mv5smyWWeWEFE
         34zy7juOZeLACIQP/t7Co93Hf5cm9YM+q/NotZLeKuBJ9+vvCxx9X+HzxT2uaID3hVpO
         dMR8xf0DKV0RLlnIVZeoaIusw1geBfW0ewWlKAWfFrUJajsNDBEX1ZPR/dmJ/mLn5rIN
         AUSfBsawseq7YlCmFdWpZaUtA5Gm/jj6Mh6gHwlvZCLnWzhuZzKOYU5OCbhpOlZhQGWZ
         4uJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WG0IHz3ZKMmoEBvW4H33j4lbr7yfknV4NwgWlfpc85g=;
        b=bzZfU/e59NXzFElRtiZsVl7gZkO/QVEfmgtSRrQ+s3uT7tDhFUmILu+pCr/rh8jSVM
         YC7kL7Zy7r+QZSds2cVKTFTLEW/DZEe+u/bIuJEVpfE+MevkuN24BrLW6A2sGBt18BXU
         thtGR6ln89NGP1mTKrQHOfDn7onbDJaOsrZRC69P/0d1VWWfTQHp6cmKkYt1ZxZjaQD9
         Ki/tXEDkYiO0X44m0lnR6RYU4hwBQzP2O+XhkZ9epsG+JF9idz4HTEPxZO4uNI/rFzCu
         036rdyi2ezVkDfTeB5V8UXOGWjjBElOqHX0nYOncKt33FhaIhiqoK4vWuT/c+hCsiV67
         +flA==
X-Gm-Message-State: AHQUAuZ67eKLpgv64Q99Pp1QgyypAzOpIB6nfwvWjIR08pCYZGA2qdAv
        hpD9kmi1cUe7zt71iGNAI2k=
X-Google-Smtp-Source: AHgI3IZRhhdOXFW/kl+u50CAf/0EY0E5+NHBlyQWLzwFgUjyhH2RtROFE7p5pbaA2wK9JvH7TASVCQ==
X-Received: by 2002:a0c:d0b6:: with SMTP id z51mr4821932qvg.20.1550872974948;
        Fri, 22 Feb 2019 14:02:54 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id r20sm1215464qtp.68.2019.02.22.14.02.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 14:02:53 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9B94F410E2; Fri, 22 Feb 2019 19:02:43 -0300 (-03)
Date:   Fri, 22 Feb 2019 19:02:43 -0300
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     andrii.nakryiko@gmail.com, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, ast@fb.com, yhs@fb.com
Subject: Re: [PATCH pahole 0/3] fix handling of bitfields in btf_loader
Message-ID: <20190222220243.GI26132@kernel.org>
References: <20190220205732.2514975-1-andriin@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190220205732.2514975-1-andriin@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Feb 20, 2019 at 12:57:29PM -0800, Andrii Nakryiko escreveu:
> This patchset fixes the logic of determining bitfield_offsets and 
> initial bit_offset when using BTF type information. It eliminates all
> the remaining discrepancies, when doing btfdiff on vmlinux image, module
> two instances of incorrectly reporting struct member type name when
> bitfield is the very first field in a struct, which is only happening 
> when using DWARF data.
> 
> Patch #1 makes btfdiff script easier to use during local development.
> 
> Patch #2 fixes list of known base type names to handle clang-generated
> type descriptions better.
> 
> Patch #3 fixes bitfield handling logic in btf_loader.

Thanks a lot! Applied.

And here I see no differences in my vmlinux:

[acme@quaco pahole]$ btfdiff vmlinux
[acme@quaco pahole]$

[acme@quaco pahole]$ perf stat pahole -F dwarf --flat_arrays --show_private_classes vmlinux > /tmp/dwarf

 Performance counter stats for 'pahole -F dwarf --flat_arrays --show_private_classes vmlinux':

         36,140.58 msec task-clock:u              #    0.998 CPUs utilized          
                 0      context-switches:u        #    0.000 K/sec                  
                 0      cpu-migrations:u          #    0.000 K/sec                  
           359,238      page-faults:u             #    0.010 M/sec                  
    83,741,861,962      cycles:u                  #    2.317 GHz                    
    99,851,434,338      instructions:u            #    1.19  insn per cycle         
    20,974,798,749      branches:u                #  580.367 M/sec                  
       288,410,045      branch-misses:u           #    1.38% of all branches        

      36.230455825 seconds time elapsed

      35.037146000 seconds user
       0.906593000 seconds sys


[acme@quaco pahole]$ perf stat pahole -F btf vmlinux > /tmp/btf

 Performance counter stats for 'pahole -F btf vmlinux':

            215.21 msec task-clock:u              #    0.994 CPUs utilized          
                 0      context-switches:u        #    0.000 K/sec                  
                 0      cpu-migrations:u          #    0.000 K/sec                  
             3,195      page-faults:u             #    0.015 M/sec                  
       460,363,235      cycles:u                  #    2.139 GHz                    
       546,688,575      instructions:u            #    1.19  insn per cycle         
       104,488,443      branches:u                #  485.522 M/sec                  
         2,012,815      branch-misses:u           #    1.93% of all branches        

       0.216609739 seconds time elapsed

       0.200431000 seconds user
       0.014834000 seconds sys


[acme@quaco pahole]$


[acme@quaco pahole]$ wc -l /tmp/dwarf
106101 /tmp/dwarf
[acme@quaco pahole]$ wc -l /tmp/btf
106101 /tmp/btf
[acme@quaco pahole]$

[acme@quaco pahole]$ pahole -F btf -C sk_buff_head vmlinux
struct sk_buff_head {
	struct sk_buff *           next;                 /*     0     8 */
	struct sk_buff *           prev;                 /*     8     8 */
	__u32                      qlen;                 /*    16     4 */
	spinlock_t                 lock;                 /*    20     4 */

	/* size: 24, cachelines: 1, members: 4 */
	/* last cacheline: 24 bytes */
};
[acme@quaco pahole]$ pahole --expand_types -F btf -C sk_buff_head vmlinux
struct sk_buff_head {
	struct sk_buff *           next;                                                 /*     0     8 */
	struct sk_buff *           prev;                                                 /*     8     8 */
	/* typedef __u32 */ unsigned int               qlen;                             /*    16     4 */
	/* typedef spinlock_t */ struct spinlock {
		union {
			struct raw_spinlock {
				/* typedef arch_spinlock_t */ struct qspinlock {
					union {
						/* typedef atomic_t */ struct {
							int                    counter;  /*    20     4 */
						} val; /*    20     4 */
						struct {
							/* typedef u8 -> __u8 */ unsigned char          locked; /*    20     1 */
							/* typedef u8 -> __u8 */ unsigned char          pending; /*    21     1 */
						};                                       /*    20     2 */
						struct {
							/* typedef u16 -> __u16 */ short unsigned int     locked_pending; /*    20     2 */
							/* typedef u16 -> __u16 */ short unsigned int     tail; /*    22     2 */
						};                                       /*    20     4 */
					};                                               /*    20     4 */
				} raw_lock; /*    20     4 */
			} rlock; /*    20     4 */
		};                                                                       /*    20     4 */
	} lock; /*    20     4 */

	/* size: 24, cachelines: 1, members: 4 */
	/* last cacheline: 24 bytes */
};
[acme@quaco pahole]$

The problem with the packed structs is gone:

[acme@quaco pahole]$ pahole -F dwarf -C screen_info vmlinux > /tmp/dwarf
[acme@quaco pahole]$ pahole -F btf -C screen_info vmlinux > /tmp/btf
[acme@quaco pahole]$ diff -u /tmp/btf /tmp/dwarf
[acme@quaco pahole]$ pahole --hex -F btf -C screen_info vmlinux
struct screen_info {
	__u8                       orig_x;               /*     0   0x1 */
	__u8                       orig_y;               /*   0x1   0x1 */
	__u16                      ext_mem_k;            /*   0x2   0x2 */
	__u16                      orig_video_page;      /*   0x4   0x2 */
	__u8                       orig_video_mode;      /*   0x6   0x1 */
	__u8                       orig_video_cols;      /*   0x7   0x1 */
	__u8                       flags;                /*   0x8   0x1 */
	__u8                       unused2;              /*   0x9   0x1 */
	__u16                      orig_video_ega_bx;    /*   0xa   0x2 */
	__u16                      unused3;              /*   0xc   0x2 */
	__u8                       orig_video_lines;     /*   0xe   0x1 */
	__u8                       orig_video_isVGA;     /*   0xf   0x1 */
	__u16                      orig_video_points;    /*  0x10   0x2 */
	__u16                      lfb_width;            /*  0x12   0x2 */
	__u16                      lfb_height;           /*  0x14   0x2 */
	__u16                      lfb_depth;            /*  0x16   0x2 */
	__u32                      lfb_base;             /*  0x18   0x4 */
	__u32                      lfb_size;             /*  0x1c   0x4 */
	__u16                      cl_magic;             /*  0x20   0x2 */
	__u16                      cl_offset;            /*  0x22   0x2 */
	__u16                      lfb_linelength;       /*  0x24   0x2 */
	__u8                       red_size;             /*  0x26   0x1 */
	__u8                       red_pos;              /*  0x27   0x1 */
	__u8                       green_size;           /*  0x28   0x1 */
	__u8                       green_pos;            /*  0x29   0x1 */
	__u8                       blue_size;            /*  0x2a   0x1 */
	__u8                       blue_pos;             /*  0x2b   0x1 */
	__u8                       rsvd_size;            /*  0x2c   0x1 */
	__u8                       rsvd_pos;             /*  0x2d   0x1 */
	__u16                      vesapm_seg;           /*  0x2e   0x2 */
	__u16                      vesapm_off;           /*  0x30   0x2 */
	__u16                      pages;                /*  0x32   0x2 */
	__u16                      vesa_attributes;      /*  0x34   0x2 */
	__u32                      capabilities;         /*  0x36   0x4 */
	__u32                      ext_lfb_base;         /*  0x3a   0x4 */
	__u8                       _reserved[2];         /*  0x3e   0x2 */

	/* size: 64, cachelines: 1, members: 36 */
};
[acme@quaco pahole]$

And the definition in include/uapi/linux/screen_info.h is:

/*
 * These are set up by the setup-routine at boot-time:
 */

struct screen_info {
        __u8  orig_x;           /* 0x00 */
        __u8  orig_y;           /* 0x01 */
        __u16 ext_mem_k;        /* 0x02 */
        __u16 orig_video_page;  /* 0x04 */
        __u8  orig_video_mode;  /* 0x06 */
        __u8  orig_video_cols;  /* 0x07 */
        __u8  flags;            /* 0x08 */
        __u8  unused2;          /* 0x09 */
        __u16 orig_video_ega_bx;/* 0x0a */
        __u16 unused3;          /* 0x0c */
        __u8  orig_video_lines; /* 0x0e */
        __u8  orig_video_isVGA; /* 0x0f */
        __u16 orig_video_points;/* 0x10 */

        /* VESA graphic mode -- linear frame buffer */
        __u16 lfb_width;        /* 0x12 */
        __u16 lfb_height;       /* 0x14 */
        __u16 lfb_depth;        /* 0x16 */
        __u32 lfb_base;         /* 0x18 */
        __u32 lfb_size;         /* 0x1c */
        __u16 cl_magic, cl_offset; /* 0x20 */
        __u16 lfb_linelength;   /* 0x24 */
        __u8  red_size;         /* 0x26 */
        __u8  red_pos;          /* 0x27 */
        __u8  green_size;       /* 0x28 */
        __u8  green_pos;        /* 0x29 */
        __u8  blue_size;        /* 0x2a */
        __u8  blue_pos;         /* 0x2b */
        __u8  rsvd_size;        /* 0x2c */
        __u8  rsvd_pos;         /* 0x2d */
        __u16 vesapm_seg;       /* 0x2e */
        __u16 vesapm_off;       /* 0x30 */
        __u16 pages;            /* 0x32 */
        __u16 vesa_attributes;  /* 0x34 */
        __u32 capabilities;     /* 0x36 */
        __u32 ext_lfb_base;     /* 0x3a */
        __u8  _reserved[2];     /* 0x3e */
} __attribute__((packed));


Which ones where these: "module two instances of incorrectly reporting struct
member type name when bitfield is the very first field in a struct, which is
only happening when using DWARF data." ?

- Arnaldo
