Return-Path: <SRS0=A/va=RL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7695CC43381
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 00:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3016A20675
	for <bpf@archiver.kernel.org>; Fri,  8 Mar 2019 00:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6ddhWVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726259AbfCHA0o (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 Mar 2019 19:26:44 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33417 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbfCHA0n (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Mar 2019 19:26:43 -0500
Received: by mail-qk1-f193.google.com with SMTP id x9so10256095qkf.0;
        Thu, 07 Mar 2019 16:26:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7rh7mFpEm9Tm5Uz8Eec5+O11qJMBTnRV7f4Q/VhDlKg=;
        b=d6ddhWVpxIp+a0QagHQ7IHgu7lyLzkeO3MW6DdtA4eVMt8vYg8Tv3pBfa46bYKAwRt
         g9iAZkoXEAwxe6oX6nglPS6W2ZAtYrctP2OvC+kf6ovaz11DmEGchvpFY/SYAedCZAew
         8KIJSFtiBKV6gPKeBsr7d22EImnAAWwlm7IA6W1YDjJklOxDnPweU6LWy3GbASiziInF
         tDI2HwVu2EGfNH7iIuT+mhlInq7UtfYbzYFmTwbL+O8T1C/G9+UvYBft20bHaVdmMIb7
         9cMPI06aJnu2hzcJGtVvcynlxzjhL1O0Fdus2XBf5lIGm+pizb7ZdRKVzWdfr0WdnHNP
         VG1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7rh7mFpEm9Tm5Uz8Eec5+O11qJMBTnRV7f4Q/VhDlKg=;
        b=Jtj4PsfLLNIySmZ54N3SPXQ6ZCsGRvU1QZlGGXGr6ZBgmyeYAY4rmjd907w78HRUGP
         tJyDXqaHFM9G72BS/lQKv68QX6H6/lqMDc5ObwrxgbUOT2+jy3STa9pjwX01RF1UV8+f
         Hm/90xm3P+NQcmszOQ9lNpmI2f4ujcdEe1tXTKNNluEtcX8ANfi8dNsQZqgVNYTbSR9A
         ltqxp9xtxrTjYdLr6xRiy98Sa3OoOZYF7plhdoh+oF/teYRM3Rq3/qGl3gvzzCvoh1Mm
         YXU3HdnqvRrnV5SJ9CbGK4Px4BZKFjSXNt5Oh7tpXq7Vazcx88nD62dGMnw6O/b9k25A
         lvng==
X-Gm-Message-State: APjAAAWyeCbROTsWCLquZmwFNpYkwhNEOTkB84JKTwRx1sNj5sk2hJzw
        JPcxv2oV7OL+yUAO+yPTTI8=
X-Google-Smtp-Source: APXvYqzVva4WihjpFU+9dF+wd/cP0sAl/NV+UKY/lNh/KHBSd+L3Sh6kOaHkUt9WR1NFj1KgIdix2A==
X-Received: by 2002:ae9:e00a:: with SMTP id m10mr940334qkk.229.1552004801675;
        Thu, 07 Mar 2019 16:26:41 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.97.35.11])
        by smtp.gmail.com with ESMTPSA id h10sm5727842qta.3.2019.03.07.16.26.39
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 16:26:40 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id CFE034039C; Thu,  7 Mar 2019 21:26:37 -0300 (-03)
Date:   Thu, 7 Mar 2019 21:26:37 -0300
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <ast@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>, Martin Lau <kafai@fb.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH pahole] pahole: use 32-bit integers for iterations within
 CU
Message-ID: <20190308002637.GF32240@kernel.org>
References: <20190307002321.4071708-1-andriin@fb.com>
 <20190307140247.GV13100@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307140247.GV13100@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Mar 07, 2019 at 11:02:47AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Wed, Mar 06, 2019 at 04:23:21PM -0800, Andrii Nakryiko escreveu:
> > Existing code base assumes that single CU doesn't have more than 65535 types
> > per each CU, which might be a reasonable assumption for DWARF data. With BTF,
> > though, all we get is single, potentially huge, CU which can easily have more
> > than 65k types. For example, this is the case for allyesconfig version of
> > Linux kernel, which has >200k types.
> 
> And your patch seems to be a step in removing this limitation, thanks
> for working on it.
>  
> > Due to this assumption, libdwarves and other parts of pahole are using 16-bit
> > counters to iterate over entities within CU. This can cause infinite loop when
> > iterating BTF data, if there are more than 65535 types. This patch changes
> > non-public variables to use 32-bit integers, where appropriate.

So, I've worked on this today and pushed a tmp branch for you guys to
check, please try what is in:

git://git.kernel.org/pub/scm/devel/pahole/pahole.git  branch tmp.type_id_t-as-uint32_t

Since I had to change the type in several functions and structs, I'll
bump the soname to have a libdwarves2, etc.

With it, and with that vmlinux.aarch64 built with allmodconfig, we're
down to these cases, and I re-run 'pahoje -J examples/vmlinux-aarch64':

[acme@quaco pahole]$ file examples/vmlinux-aarch64
examples/vmlinux-aarch64: ELF 64-bit MSB pie executable, ARM aarch64, version 1 (SYSV), statically linked, BuildID[sha1]=7fcff18ec214eee2f8c6b288fca21dc6d9771ad6, with debug_info, not stripped
[acme@quaco pahole]$ size examples/vmlinux-aarch64
   text	   data	    bss	    dec	    hex	filename
238902279	138150199	28423136	405475614	182b111e	examples/vmlinux-aarch64
[acme@quaco pahole]$ ls -lah examples/vmlinux-aarch64
-rwxrwxr-x. 1 acme acme 2.3G Mar  7 18:17 examples/vmlinux-aarch64
[acme@quaco pahole]$ pahole -F btf --sizes examples/vmlinux-aarch64 | wc -l
51023
[acme@quaco pahole]$

Wow! 51023 unique structs and unions, w00t :-)

Several looks similar and the low hanging fruit to investigate, seems to
be enum bitfields, and the others may as well end up being the same, in
miscalculated stats for structs embedded in other structs:

$ btfdiff examples/vmlinux-aarch64
--- /tmp/btfdiff.dwarf.81KCPb	2019-03-07 18:20:13.153319625 -0300
+++ /tmp/btfdiff.btf.g1QkcZ	2019-03-07 18:20:13.928328675 -0300
@@ -306626,18 +306626,15 @@ struct myrb_enquiry2 {
 			MYRB_RAM_TYPE_EDO = 1,
 			MYRB_RAM_TYPE_SDRAM = 2,
 			MYRB_RAM_TYPE_Last = 7,
-		} ram:3;                                   /*    40     4 */
+		} ram:3;                                   /*    40     1 */
 		enum {
 			MYRB_ERR_CORR_None = 0,
 			MYRB_ERR_CORR_Parity = 1,
 			MYRB_ERR_CORR_ECC = 2,
 			MYRB_ERR_CORR_Last = 7,
-		} ec:3;                                    /*    40     4 */
+		} ec:3;                                    /*    40     1 */
 		unsigned char      fast_page:1;          /*    40: 6  1 */
 		unsigned char      low_power:1;          /*    40: 7  1 */
-
-		/* Bitfield combined with next fields */
-
 		unsigned char      rsvd4;                /*    41     1 */
 	} mem_type;                                      /*    40     2 */
 	short unsigned int         clock_speed;          /*    42     2 */
@@ -306668,18 +306665,15 @@ struct myrb_enquiry2 {
 			MYRB_WIDTH_NARROW_8BIT = 0,
 			MYRB_WIDTH_WIDE_16BIT = 1,
 			MYRB_WIDTH_WIDE_32BIT = 2,
-		} bus_width:2;                             /*   106     4 */
+		} bus_width:2;                             /*   106     1 */
 		enum {
 			MYRB_SCSI_SPEED_FAST = 0,
 			MYRB_SCSI_SPEED_ULTRA = 1,
 			MYRB_SCSI_SPEED_ULTRA2 = 2,
-		} bus_speed:2;                             /*   106     4 */
+		} bus_speed:2;                             /*   106     1 */
 		unsigned char      differential:1;       /*   106: 4  1 */
 		unsigned char      rsvd10:3;             /*   106: 5  1 */
 	} scsi_cap;                                      /*   106     1 */
-
-	/* XXX last struct has 65533 bytes of padding */
-
 	unsigned char              rsvd11[5];            /*   107     5 */
 	short unsigned int         fw_build;             /*   112     2 */
 	enum {
@@ -306701,7 +306695,6 @@ struct myrb_enquiry2 {
 	unsigned char              rsvd14[8];            /*   120     8 */
 
 	/* size: 128, cachelines: 2, members: 46 */
-	/* paddings: 1, sum paddings: 65533 */
 };
 struct myrb_ldev_info {
 	unsigned int               size;                 /*     0     4 */
@@ -306741,7 +306734,7 @@ struct myrb_pdev_state {
 		MYRB_TYPE_DISK = 1,
 		MYRB_TYPE_TAPE = 2,
 		MYRB_TYPE_CDROM_OR_WORM = 3,
-	} devtype:2;                                       /*     1     4 */
+	} devtype:2;                                       /*     1     1 */
 
 	/* Bitfield combined with previous fields */
 
@@ -306868,7 +306861,7 @@ struct myrb_config2 {
 			MYRB_SPEED_SYNC_8MHz = 1,
 			MYRB_SPEED_SYNC_5MHz = 2,
 			MYRB_SPEED_SYNC_10_OR_20MHz = 3,
-		} speed:2;                                 /*    12     4 */
+		} speed:2;                                 /*    12     1 */
 		unsigned int       force_8bit:1;         /*    12: 2  4 */
 		unsigned int       disable_fast20:1;     /*    12: 3  4 */
 		unsigned int       rsvd8:3;              /*    12: 4  4 */
@@ -306891,7 +306884,7 @@ struct myrb_config2 {
 		MYRB_GEOM_255_63 = 1,
 		MYRB_GEOM_RESERVED1 = 2,
 		MYRB_GEOM_RESERVED2 = 3,
-	} drive_geometry:2;                                /*    52     4 */
+	} drive_geometry:2;                                /*    52     1 */
 	unsigned int               rsvd12:1;             /*    52: 7  4 */
 
 	/* Bitfield combined with next fields */
@@ -306913,7 +306906,7 @@ struct myrb_dcdb {
 		MYRB_DCDB_XFER_DEVICE_TO_SYSTEM = 1,
 		MYRB_DCDB_XFER_SYSTEM_TO_DEVICE = 2,
 		MYRB_DCDB_XFER_ILLEGAL = 3,
-	} data_xfer:2;                                     /*     1     4 */
+	} data_xfer:2;                                     /*     1     1 */
 
 	/* Bitfield combined with previous fields */
 
@@ -306928,7 +306921,7 @@ struct myrb_dcdb {
 		MYRB_DCDB_TMO_10_SECS = 1,
 		MYRB_DCDB_TMO_60_SECS = 2,
 		MYRB_DCDB_TMO_10_MINS = 3,
-	} timeout:2;                                       /*     1     4 */
+	} timeout:2;                                       /*     1     1 */
 
 	/* Bitfield combined with previous fields */
 
@@ -307053,7 +307046,7 @@ union myrb_cmd_mbox {
 			MYRB_SGL_ADDR32_COUNT16 = 1,
 			MYRB_SGL_COUNT32_ADDR32 = 2,
 			MYRB_SGL_COUNT16_ADDR32 = 3,
-		} sg_type:2;                             /*    12     4 */
+		} sg_type:2;                             /*    12     1 */
 		unsigned char      rsvd[3];            /*    13     3 */
 	} type5;                                       /*     0    16 */
 	struct {
@@ -453415,15 +453408,10 @@ struct ieee80211_tx_rate {
 	/* Bitfield combined with previous fields */
 
 	u16                        count:5;              /*     0: 8  2 */
-
-	/* XXX 3 bits hole, try to pack */
-	/* Bitfield combined with next fields */
-
-	u16                        flags:11;             /*     1: 5  2 */
+	u16                        flags:11;             /*     0:13  2 */
 
 	/* size: 3, cachelines: 1, members: 3 */
-	/* bit holes: 1, sum bit holes: 3 bits */
-	/* bit_padding: 5 bits */
+	/* padding: 1 */
 	/* last cacheline: 3 bytes */
 };
 struct ieee80211_key_conf {
@@ -488743,6 +488731,9 @@ struct ieee80211_tx_rate_control {
 	struct ieee80211_bss_conf * bss_conf;            /*    16     8 */
 	struct sk_buff *           skb;                  /*    24     8 */
 	struct ieee80211_tx_rate   reported_rate;        /*    32     3 */
+
+	/* XXX last struct has 1 byte of padding */
+
 	bool                       rts;                  /*    35     1 */
 	bool                       short_preamble;       /*    36     1 */
 
@@ -488758,6 +488749,7 @@ struct ieee80211_tx_rate_control {
 	/* size: 64, cachelines: 1, members: 10 */
 	/* sum members: 50, holes: 2, sum holes: 7 */
 	/* padding: 7 */
+	/* paddings: 1, sum paddings: 1 */
 };
 struct rate_control_ops {
 	long unsigned int          capa;                 /*     0     8 */
@@ -528758,7 +528750,7 @@ struct skb_pool {
 };
 struct vc_map {
 	volatile unsigned int      tx:1;                 /*     0: 0  4 */
-	volatile unsigned int      rx:1;                 /*     0: 1  4 */
+	volatile unsigned int      rx:1;                 /*     0: 0  4 */
 
 	/* XXX 30 bits hole, try to pack */
 	/* XXX 4 bytes hole, try to pack */
@@ -675819,7 +675811,10 @@ union zip_zres_s {
 		u64                exbits:7;           /*    16:41  8 */
 		u64                reserved_137_143:7; /*    16:48  8 */
 		u64                ef:1;               /*    16:55  8 */
-		volatile u64       compcode:8;         /*    16:56  8 */
+
+		/* Bitfield combined with next fields */
+
+		volatile u64       compcode:8;         /*    23: 0  8 */
 	} s;                                           /*     0    24 */
 };
 struct sg_info {
@@ -784966,12 +784961,14 @@ struct ieee80211_tx_data {
 	struct ieee80211_key *     key;                  /*   128     8 */
 	struct ieee80211_tx_rate   rate;                 /*   136     3 */
 
+	/* XXX last struct has 1 byte of padding */
 	/* XXX 1 byte hole, try to pack */
 
 	unsigned int               flags;                /*   140     4 */
 
 	/* size: 144, cachelines: 3, members: 8 */
 	/* sum members: 143, holes: 1, sum holes: 1 */
+	/* paddings: 1, sum paddings: 1 */
 	/* last cacheline: 16 bytes */
 };
 struct ieee80211_rx_data {


For a more usual vmlinux, with a .config similar to the one in a fedora
distro, we get everything seemingly ok:

[acme@quaco pahole]$ btfdiff vmlinux
[acme@quaco pahole]$ file vmlinux
vmlinux: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), statically linked, BuildID[sha1]=e7b4562926e9f69b2f478a3b4a7dd33136f42f5d, with debug_info, not stripped
[acme@quaco pahole]$ size vmlinux
   text	   data	    bss	    dec	    hex	filename
17124425	7038546	5378112	29541083	1c2c2db	vmlinux
[acme@quaco pahole]$ ls -lah vmlinux
-rwxrwxr-x. 1 acme acme 621M Mar  7 15:40 vmlinux
[acme@quaco pahole]$ pahole -F btf --sizes vmlinux | wc -l
7472
[acme@quaco pahole]$ pahole -F dwarf --sizes vmlinux | wc -l
7445
[acme@quaco pahole]$ pahole -F dwarf --show_private_classes --sizes vmlinux | wc -l
7472
[acme@quaco pahole]$
[acme@quaco pahole]$ pahole -F btf -C perf_event_attr vmlinux
struct perf_event_attr {
	__u32                      type;                 /*     0     4 */
	__u32                      size;                 /*     4     4 */
	__u64                      config;               /*     8     8 */
	union {
		__u64              sample_period;        /*    16     8 */
		__u64              sample_freq;          /*    16     8 */
	};                                               /*    16     8 */
	__u64                      sample_type;          /*    24     8 */
	__u64                      read_format;          /*    32     8 */
	__u64                      disabled:1;           /*    40:63  8 */
	__u64                      inherit:1;            /*    40:62  8 */
	__u64                      pinned:1;             /*    40:61  8 */
	__u64                      exclusive:1;          /*    40:60  8 */
	__u64                      exclude_user:1;       /*    40:59  8 */
	__u64                      exclude_kernel:1;     /*    40:58  8 */
	__u64                      exclude_hv:1;         /*    40:57  8 */
	__u64                      exclude_idle:1;       /*    40:56  8 */
	__u64                      mmap:1;               /*    40:55  8 */
	__u64                      comm:1;               /*    40:54  8 */
	__u64                      freq:1;               /*    40:53  8 */
	__u64                      inherit_stat:1;       /*    40:52  8 */
	__u64                      enable_on_exec:1;     /*    40:51  8 */
	__u64                      task:1;               /*    40:50  8 */
	__u64                      watermark:1;          /*    40:49  8 */
	__u64                      precise_ip:2;         /*    40:47  8 */
	__u64                      mmap_data:1;          /*    40:46  8 */
	__u64                      sample_id_all:1;      /*    40:45  8 */
	__u64                      exclude_host:1;       /*    40:44  8 */
	__u64                      exclude_guest:1;      /*    40:43  8 */
	__u64                      exclude_callchain_kernel:1; /*    40:42  8 */
	__u64                      exclude_callchain_user:1; /*    40:41  8 */
	__u64                      mmap2:1;              /*    40:40  8 */
	__u64                      comm_exec:1;          /*    40:39  8 */
	__u64                      use_clockid:1;        /*    40:38  8 */
	__u64                      context_switch:1;     /*    40:37  8 */
	__u64                      write_backward:1;     /*    40:36  8 */
	__u64                      namespaces:1;         /*    40:35  8 */
	__u64                      ksymbol:1;            /*    40:34  8 */
	__u64                      bpf_event:1;          /*    40:33  8 */
	__u64                      __reserved_1:33;      /*    40: 0  8 */
	union {
		__u32              wakeup_events;        /*    48     4 */
		__u32              wakeup_watermark;     /*    48     4 */
	};                                               /*    48     4 */
	__u32                      bp_type;              /*    52     4 */
	union {
		__u64              bp_addr;              /*    56     8 */
		__u64              kprobe_func;          /*    56     8 */
		__u64              uprobe_path;          /*    56     8 */
		__u64              config1;              /*    56     8 */
	};                                               /*    56     8 */
	/* --- cacheline 1 boundary (64 bytes) --- */
	union {
		__u64              bp_len;               /*    64     8 */
		__u64              kprobe_addr;          /*    64     8 */
		__u64              probe_offset;         /*    64     8 */
		__u64              config2;              /*    64     8 */
	};                                               /*    64     8 */
	__u64                      branch_sample_type;   /*    72     8 */
	__u64                      sample_regs_user;     /*    80     8 */
	__u32                      sample_stack_user;    /*    88     4 */
	__s32                      clockid;              /*    92     4 */
	__u64                      sample_regs_intr;     /*    96     8 */
	__u32                      aux_watermark;        /*   104     4 */
	__u16                      sample_max_stack;     /*   108     2 */
	__u16                      __reserved_2;         /*   110     2 */

	/* size: 112, cachelines: 2, members: 49 */
	/* last cacheline: 48 bytes */
};
[acme@quaco pahole]$
