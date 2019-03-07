Return-Path: <SRS0=xp9Q=RK=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B00C43381
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 14:11:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C972F20684
	for <bpf@archiver.kernel.org>; Thu,  7 Mar 2019 14:11:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cMU3OhxL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726241AbfCGOL5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 7 Mar 2019 09:11:57 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40784 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfCGOL5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 7 Mar 2019 09:11:57 -0500
Received: by mail-qt1-f193.google.com with SMTP id j36so17175957qta.7;
        Thu, 07 Mar 2019 06:11:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1SQxtYAzSgLekcZeDA3j0Oj191t5XIcbgyFqR/rY7ro=;
        b=cMU3OhxL2xOSRI6qlgFpisfU4LazMD9XG3nBL7qXU6ZLIiUde+JEn/U00Ye+c8I4lJ
         WiK3QEQX6ClcxVssp6M6MYWZ5/Aof9AsGgxnw/KZ24jPsT61YAFEP0nBIN1ki9yOMWD4
         7yMPso2rEJ53cBEc8JYfy3cl5JjUZYBMrqP0p5cJsAmhI45oXqv3wRG+jVnk2v3b3Zek
         XR0kdXcyQomZbwqE29V/ATQ5BVBP56D8/Fo0unNoY/sFmHKkWJNnkfQ3JjuXw+n4J7K+
         N0W3M76/rRoBug5ZbDTbN6rFwRF/NV9VkokRvLzigQvhhNIGZVRSPo/uYJiHFU4bLA17
         Pj3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1SQxtYAzSgLekcZeDA3j0Oj191t5XIcbgyFqR/rY7ro=;
        b=QwMFIGKuFFeYOqXSEQUfR/c8PIZEh8mGFD6V5qr4/lVkmhv+Wf1ku6Ya5Y9qFJgBpv
         ELLT8j4JflLPpeajhiqIUpivItQ+nlaQALMBeWU4TyJupd5qjBAkHT7Lb3ZuDz5bxQ8x
         hEcznVr2Moh+QyBaauligQGcyApE9dQvv95zwp3GyCfCbF0eG9AcH4zmiBxb4kRi/Vkp
         Hi1WTRksw2ILQcn37yNRvioXp2GEYFINZM/YlTAQRTBAG1PSqKrIlnIos77LXio7Bzu2
         Rq35CXfuJyZRbwrzfP+YLAl1PjT9uAS02jIuslBVYaOBT+nP+qqeivfxJUmxRiPVtedq
         woIQ==
X-Gm-Message-State: APjAAAVc7hkpnf67zycqcLL3WBeWNmZa8QgktrGbdonUztsH0dcCUwLR
        4ZuhDMa62Z521Q/LXmhaSQsmBgvj
X-Google-Smtp-Source: APXvYqz2YUZr6R3/SBYGLTdMDWgD6IL0qLv4fGtarUuD7o8FFukFedAIncS5AeX32pQBD0EzFRupxw==
X-Received: by 2002:ac8:2847:: with SMTP id 7mr10142232qtr.335.1551967915641;
        Thu, 07 Mar 2019 06:11:55 -0800 (PST)
Received: from quaco.ghostprotocols.net ([190.15.121.82])
        by smtp.gmail.com with ESMTPSA id x80sm3686640qkx.85.2019.03.07.06.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Mar 2019 06:11:55 -0800 (PST)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 86F764039C; Thu,  7 Mar 2019 11:11:52 -0300 (-03)
Date:   Thu, 7 Mar 2019 11:11:52 -0300
To:     Andrii Nakryiko <andriin@fb.com>
Cc:     arnaldo.melo@gmail.com, andrii.nakryiko@gmail.com, ast@fb.com,
        yhs@fb.com, dwarves@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH pahole] pahole: use 32-bit integers for iterations within
 CU
Message-ID: <20190307141152.GX13100@kernel.org>
References: <20190307002321.4071708-1-andriin@fb.com>
 <20190307140247.GV13100@kernel.org>
 <20190307140917.GW13100@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190307140917.GW13100@kernel.org>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Thu, Mar 07, 2019 at 11:09:17AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Thu, Mar 07, 2019 at 11:02:47AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Mar 06, 2019 at 04:23:21PM -0800, Andrii Nakryiko escreveu:
> > > Due to this assumption, libdwarves and other parts of pahole are using 16-bit
> > > counters to iterate over entities within CU. This can cause infinite loop when
> > > iterating BTF data, if there are more than 65535 types. This patch changes
> > > non-public variables to use 32-bit integers, where appropriate.
>  
> > Ok, there are some bits that are unrelated, I'm comment on it and remove
> > before applying.
> 
> Ooops, see below, I'm removing the non-type related parts, and will look
> at changing the types till btfdiff with that allyesconfig aarch64
> vmlinux image shows no diffs.

This one as well is not needed:

@@ -1225,7 +1225,7 @@ static size_t __class__fprintf(struct class *class, const struct cu *cu,
        struct tag *tag_pos;
        const char *current_accessibility = NULL;
        struct conf_fprintf cconf = conf ? *conf : conf_fprintf__defaults;
-       const uint16_t t = type->namespace.tag.tag;
+       const uint32_t t = type->namespace.tag.tag;
        size_t printed = fprintf(fp, "%s%s%s%s%s",
                                 cconf.prefix ?: "", cconf.prefix ? " " : "",
                                 ((cconf.classes_as_structs ||


As this is just for the type of the tag, not its type, i.e. its about
DW_TAG_struct_type, etc.

- Arnaldo
