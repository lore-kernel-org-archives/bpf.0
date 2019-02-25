Return-Path: <SRS0=zbR4=RA=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFBE1C43381
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 19:00:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EE2620C01
	for <bpf@archiver.kernel.org>; Mon, 25 Feb 2019 19:00:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h+GqvOyi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbfBYTAG (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 25 Feb 2019 14:00:06 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:38690 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfBYTAG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 25 Feb 2019 14:00:06 -0500
Received: by mail-qt1-f193.google.com with SMTP id s1so11856967qte.5;
        Mon, 25 Feb 2019 11:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=iHXGvFEYriakLuErlfAi7m/EXU3o7q2d0r9eUVXRRT0=;
        b=h+GqvOyix7XJd5VoO/pfA2RfjL0kGLuwEA3TkYqmxJSVlqz8hCgtxnupGn6IAfatDm
         YGgaNqhNYDoxUySWsEPqYj7yAEoCrApEKmX+iZ0/ILwYAC5crRZRPrLi7VdpTKkP6pN1
         tQyJjrNAq+HSMhW6gKPQ7vWGx/2+mu30VzP+GLq3Rg28KZXVhdr1icPvT6I3I639wwl1
         fEbWWj6K1v6D4bkD5eemwS23tbIieRI6NYRCU0/wF1H51eu1+NPGfacOGvLRvYk+ZSvP
         00jGjeWIk2MyntLkPpk5G0igmzfbrCfElYR1mrDS+Msop1NL4d3781T29ZsQVb0Tu/WI
         9Q9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iHXGvFEYriakLuErlfAi7m/EXU3o7q2d0r9eUVXRRT0=;
        b=QWpkb8JVFCZLPjlaVxpoB0G1UZ6Sm7Qcpq7HHMoqeF4fHjQDlF1F0ljUi29gH5BUgy
         vd9UFmuyMTBdj7eWgMO1ljPv5i59rubZEBd725f/blEgM7iJ3nYsTvOX4rroSg1WeOCr
         /BcHEtssbJaPUV2ssXLXsvMQfvqR/KUEiKjONvjzohlvFvAHFXt2KV+yMo203TGbmQmM
         MTSvAR277Ibc3pkVBtDseBiLkdlAeWo2JJCgyWwSjeAE6YE5Pic7KZwb3t6lbeTwAcWF
         1xGf+ejEXibqEWj0zoKLXuHoo52e1jNns+VF37NjB/s7zBWmG8nI8/M22q22reh1GwIV
         Ka0w==
X-Gm-Message-State: AHQUAuafEi7FMEpYFfr59n/FpK2UK6u8UXDTAiQd78UHyYK0Av0JGhP1
        R8GJYfB++0bO+OOqEfNT3X9HzJNGKj4=
X-Google-Smtp-Source: AHgI3IYVyb4g0eSlh4RzKPLq1SZ2pvrL9G/guqHJ46kkvKxFelfukQdztHLSLGr5I7L3wJhvdvqB7g==
X-Received: by 2002:ac8:43d5:: with SMTP id w21mr13970335qtn.98.1551121204551;
        Mon, 25 Feb 2019 11:00:04 -0800 (PST)
Received: from quaco.ghostprotocols.net ([179.179.86.104])
        by smtp.gmail.com with ESMTPSA id g24sm7414263qtc.61.2019.02.25.11.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 11:00:03 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D5D9E4039C; Mon, 25 Feb 2019 15:59:49 -0300 (-03)
Date:   Mon, 25 Feb 2019 15:59:49 -0300
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Andrii Nakryiko <andriin@fb.com>, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@fb.com>,
        Yonghong Song <yhs@fb.com>
Subject: Re: [PATCH pahole 0/3] fix handling of bitfields in btf_loader
Message-ID: <20190225185949.GT31136@kernel.org>
References: <20190220205732.2514975-1-andriin@fb.com>
 <20190222220243.GI26132@kernel.org>
 <CAEf4BzYoJgxYWX9iS7pda62cnGr5VOC70NGgqPurMNWP_w1daA@mail.gmail.com>
 <20190225160239.GR31136@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225160239.GR31136@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Mon, Feb 25, 2019 at 01:02:39PM -0300, Arnaldo Carvalho de Melo escreveu:
> So yeah, the BTF encoder/decoder is working just fine, the problem is in
> pahole's DWARF code, lemme see...

Please try the patch below, for me btfdiff continues to show no diff for
all types in my vmlinux and now it also produces the same output for
when the first element of a bitfield has its bit_size equal to its
byte_size * 8:

[acme@quaco pahole]$ btfdiff vmlinux
[acme@quaco pahole]$ btfdiff examples/andrii/hsw_tsx_tuning-gcc
[acme@quaco pahole]$ btfdiff examples/andrii/hsw_tsx_tuning-clang
[acme@quaco pahole]$ pahole examples/andrii/hsw_tsx_tuning-clang
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
[acme@quaco pahole]$ pahole -F btf examples/andrii/hsw_tsx_tuning-clang
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
[acme@quaco pahole]$

diff --git a/dwarf_loader.c b/dwarf_loader.c
index adef437109f6..37477fb23be3 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -607,7 +607,8 @@ static struct variable *variable__new(Dwarf_Die *die, struct cu *cu)
 
 int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t bit_size)
 {
-	uint16_t id;
+	int id;
+	uint16_t short_id;
 	struct tag *recoded;
 	/* in all the cases the name is at the same offset */
 	strings_t name = tag__namespace(tag)->name;
@@ -620,7 +621,7 @@ int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t bit_size
 		struct tag *type = dtype->tag;
 
 		id = tag__recode_dwarf_bitfield(type, cu, bit_size);
-		if (id == tag->type)
+		if (id < 0)
 			return id;
 
 		struct type *new_typedef = obstack_zalloc(&cu->obstack,
@@ -660,10 +661,9 @@ int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t bit_size
 		 * the dwarf_cu as in dwarf there are no such things
 		 * as base_types of less than 8 bits, etc.
 		 */
-		recoded = cu__find_base_type_by_sname_and_size(cu, name, bit_size, &id);
+		recoded = cu__find_base_type_by_sname_and_size(cu, name, bit_size, &short_id);
 		if (recoded != NULL)
-			return id;
-
+			return short_id;
 
 		struct base_type *new_bt = obstack_zalloc(&cu->obstack,
 							  sizeof(*new_bt));
@@ -683,10 +683,9 @@ int tag__recode_dwarf_bitfield(struct tag *tag, struct cu *cu, uint16_t bit_size
 		 * the dwarf_cu as in dwarf there are no such things
 		 * as enumeration_types of less than 8 bits, etc.
 		 */
-		recoded = cu__find_enumeration_by_sname_and_size(cu, name,
-								 bit_size, &id);
+		recoded = cu__find_enumeration_by_sname_and_size(cu, name, bit_size, &short_id);
 		if (recoded != NULL)
-			return id;
+			return short_id;
 
 		struct type *alias = tag__type(tag);
 		struct type *new_enum = obstack_zalloc(&cu->obstack, sizeof(*new_enum));
