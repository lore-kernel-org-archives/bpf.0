Return-Path: <SRS0=vk/n=RD=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A739CC43381
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78952218B0
	for <bpf@archiver.kernel.org>; Thu, 28 Feb 2019 19:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="sEx5KvJF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbfB1ThQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 28 Feb 2019 14:37:16 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:34314 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730845AbfB1ThQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Feb 2019 14:37:16 -0500
Received: by mail-wr1-f67.google.com with SMTP id f14so23318886wrg.1
        for <bpf@vger.kernel.org>; Thu, 28 Feb 2019 11:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=ywNJegvrXCPzOehxRf8aYVJrGRQRF+VxBdtUvrZbviQ=;
        b=sEx5KvJFPb/NWNVI0Xi5gJPjhRxrMcDwUkhHwFJLgR1BRYlyEQIp/nVAFczYVlfz2j
         Nhe65Y06VHSPLvRuj0/AB0VZCMiQxTF7+y6lXErbUeLam0Tkk/CCUmKsnV5UI0qLt7r8
         KDI8hLcmZWdHcPvrm+6P8MrlF3K84MdmJyrtY0uHB6OoBiBYzrbr5hlKObMISkpkDzg1
         ZXFbhY4806ndMwNxECa0i5c2JyBi+JAUQjas4/0ww/KK8TxXpfcW52mAzV5pkWpMr/Lk
         iMn3CEuIG3y2VPjz8wOVsLSW/JkMMMEQfveorZkv5jyaT5eMHGmAUSNp8TzPWul0XYzr
         TpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=ywNJegvrXCPzOehxRf8aYVJrGRQRF+VxBdtUvrZbviQ=;
        b=S67SYsceZ3hHjbmpzYlO2c86luWxvG179XXHcYPmnmWEhJTVdoVAMeLsp0LMfD+KSW
         0UlJPf+rIJFGutbMcmlyGC3ko7g3PRTGGQkjy5wk1ot+XjbXSan3IZNCRbSoZNaPmaqE
         VljG3pjKH2LzDvu42Nyk7UgpN9lZn9TKlniMXr806f2FvM483jCwHOkJ6FQl5vYQnWBE
         wIJiwUNyp49R2//wPGqRbAkh13+Jn1Hi6tXHtzBi/7CF3MSo0dOnmmL8n6UFtAlyMB3/
         L3+bwvqNV19y52uROo5+4i7a6HvUbR/wNgGtDlQXmMTs/8COk48VwrAupaT1f/lQ4YQr
         PCPA==
X-Gm-Message-State: APjAAAVbZTL+NUvQUQGdINiQJOreiZJYpsF7lF4UNshL2ypVZejjZnsi
        YMXdvPzY6leN4wKbbbtI9OPBGw==
X-Google-Smtp-Source: APXvYqwLYwR2jW794wEqDiYOjVi0Jvs/F8sYhPIHrmFxPT8DC3kldCsb0aopJRJ12M7E08Hji2YAtA==
X-Received: by 2002:a5d:4843:: with SMTP id n3mr675691wrs.209.1551382634391;
        Thu, 28 Feb 2019 11:37:14 -0800 (PST)
Received: from LAPTOP-V3S7NLPL (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id b10sm15989122wru.92.2019.02.28.11.37.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 28 Feb 2019 11:37:13 -0800 (PST)
References: <1551347957-4068-1-git-send-email-jiong.wang@netronome.com> <1a4bf225-2f41-aa35-cf28-3ddf5cc23a9d@fb.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        "alexei.starovoitov\@gmail.com" <alexei.starovoitov@gmail.com>,
        "daniel\@iogearbox.net" <daniel@iogearbox.net>,
        "bpf\@vger.kernel.org" <bpf@vger.kernel.org>,
        "oss-drivers\@netronome.com" <oss-drivers@netronome.com>
Subject: Re: [PATCH LLVM v2 0/3] bpf: improvements on XADD semantics check and code-gen
In-reply-to: <1a4bf225-2f41-aa35-cf28-3ddf5cc23a9d@fb.com>
Date:   Thu, 28 Feb 2019 19:37:12 +0000
Message-ID: <87sgw7u2l3.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Yonghong Song writes:
<snip>
>
> The change looks good. Tested with unit tests and kernel selftests.
> I added something like below to one of test_progs bpf programs:
>    (void)__sync_fetch_and_add(value_p, 1);
> and the generated code is correct for alu32 mode and the objdump
> is able to disassemble correctly with -mattr=+alu32.
>
> You can add my ack:
>    Acked-by: Yonghong Song <yhs@fb.com>
>
> Could you go ahead to push to llvm trunk? Thanks!

Done, thanks.

Regards,
Jiong

>
>> 
>>   lib/Target/BPF/BPFInstrInfo.td                  | 28 ++++++-
>>   lib/Target/BPF/BPFMIChecking.cpp                | 97 ++++++++++++++++++++++++-
>>   lib/Target/BPF/Disassembler/BPFDisassembler.cpp |  3 +-
>>   test/CodeGen/BPF/xadd.ll                        |  2 +
>>   test/CodeGen/BPF/xadd_legal.ll                  | 26 +++++++
>>   test/MC/BPF/insn-unit.s                         |  3 +-
>>   test/MC/BPF/load-store-32.s                     |  3 +
>>   7 files changed, 154 insertions(+), 8 deletions(-)
>>   create mode 100644 test/CodeGen/BPF/xadd_legal.ll
>> 

