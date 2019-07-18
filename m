Return-Path: <SRS0=m+TU=VP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735EDC76191
	for <bpf@archiver.kernel.org>; Thu, 18 Jul 2019 13:59:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CF572173E
	for <bpf@archiver.kernel.org>; Thu, 18 Jul 2019 13:59:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AFw7nV3Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfGRN7j (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 18 Jul 2019 09:59:39 -0400
Received: from mail-oi1-f180.google.com ([209.85.167.180]:39871 "EHLO
        mail-oi1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726608AbfGRN7i (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 18 Jul 2019 09:59:38 -0400
Received: by mail-oi1-f180.google.com with SMTP id m202so21559099oig.6
        for <bpf@vger.kernel.org>; Thu, 18 Jul 2019 06:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=y8kCzYlR4BHltGQQxG5gSm0AfTbAwfNGeHMBSL9acLY=;
        b=AFw7nV3QViT7KAEreEYxj3eSmZb7vfQsQ9/L0/sy39TJoOB8YZc/Nyp4HdoYXg3wW+
         eTODhKhkU2jzrXDtuRF3nuYmMuHANB18/iNyqY6pM/0osyzNwusLkF5g+h1dZ7TC8wnE
         7zwmMV9bkXQCh7sBpVcW5d572/UXl6JIhcKhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=y8kCzYlR4BHltGQQxG5gSm0AfTbAwfNGeHMBSL9acLY=;
        b=H4D2aOoTgAQU9k3qQYTb932WozuTR46vmOTH27NJLFS6gJkti0ZCfSKYA+I6JmveBw
         lsuh44aG2MZyc22zzdLRvKvhtHItFufkTqkd26MACyT2fRGtGkiUvq/Vdkwl7QI4GhoD
         hqWODV+jC/bmBEEroShuVWxvGiK430xqs3pOSD31DznCYdMDjySP6iQOnwlxr3V6g0cp
         JtT/T9XuHexXZoIzVszxnX7JYFR5Yo1CmOs7ayiYgEOT0y4qmyhg/97LXIv4t+TH5wcg
         nALP5cjQGtSlxAawhmTgnOTTcKfTo8CH9vESLn1EE8pKeZvucoIfAPhAaBq8UlOUmyR3
         w6pQ==
X-Gm-Message-State: APjAAAX+cfyVnken1z8GDfB7RbeiZC1hmdSXkvwBQJbO4ZV1TzYjdQd5
        o+t27sBCUhSbfy3t7p1wYzq1m95mb6II4sPOA9kt20D88Ho=
X-Google-Smtp-Source: APXvYqyjw139XO/Kh/1GUC0tiur0AfIJZsWc9m+R54+XVAQYJcEnL/Eybg6u2EdKLzzA4fpaChKwnFWW914VF58DPI0=
X-Received: by 2002:aca:6104:: with SMTP id v4mr23608975oib.172.1563458377379;
 Thu, 18 Jul 2019 06:59:37 -0700 (PDT)
MIME-Version: 1.0
From:   Lorenz Bauer <lmb@cloudflare.com>
Date:   Thu, 18 Jul 2019 14:59:26 +0100
Message-ID: <CACAyw9-CWRHVH3TJ=Tke2x8YiLsH47sLCijdp=V+5M836R9aAA@mail.gmail.com>
Subject: Building bpftool with OUTPUT set breaks
To:     bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On 5.2 and current bpf-next, the following fails:

$ make -C tools/bpf/bpftool OUTPUT=/tmp/tmp.NUSttIbAYw/
make: Entering directory '/home/lorenz/dev/bpf-next/tools/bpf/bpftool'

Auto-detecting system features:
...                        libbfd: OFF
...        disassembler-four-args: OFF

  CC       /tmp/tmp.NUSttIbAYw/map_perf_ring.o
<snip>
  CC       /tmp/tmp.NUSttIbAYw/disasm.o
make[1]: Entering directory '/home/lorenz/dev/bpf-next/tools/lib/bpf'

Auto-detecting system features:
...                        libelf: on
...                           bpf: on

  CC       /tmp/tmp.NUSttIbAYw/libbpf.o
<snip>
  CC       /tmp/tmp.NUSttIbAYw/btf_dump.o
  LD       /tmp/tmp.NUSttIbAYw/libbpf-in.o
  LINK     /tmp/tmp.NUSttIbAYw/libbpf.a
make[1]: Leaving directory '/home/lorenz/dev/bpf-next/tools/lib/bpf'
  LINK     /tmp/tmp.NUSttIbAYw/bpftool
/usr/bin/ld: /tmp/tmp.NUSttIbAYw/libbpf.a(libbpf-in.o): in function `do_btf':
(.text+0x105b0): multiple definition of `do_btf';
/tmp/tmp.NUSttIbAYw/btf.o:btf.c:(.text+0x11f0): first defined here
<snip>

I think the problem is that objects for both bpftool and libbpf end up
in the same directory
if OUTPUT is set. Does anybody know how to fix this?

Best
Lorenz

-- 
Lorenz Bauer  |  Systems Engineer
6th Floor, County Hall/The Riverside Building, SE1 7PB, UK

www.cloudflare.com
