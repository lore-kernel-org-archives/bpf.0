Return-Path: <SRS0=uow0=RJ=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FBE6C43381
	for <bpf@archiver.kernel.org>; Wed,  6 Mar 2019 08:59:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6CB720840
	for <bpf@archiver.kernel.org>; Wed,  6 Mar 2019 08:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="oy4oq9yz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbfCFI7Q (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 6 Mar 2019 03:59:16 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39314 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfCFI7Q (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Mar 2019 03:59:16 -0500
Received: by mail-lj1-f196.google.com with SMTP id g80so10138300ljg.6
        for <bpf@vger.kernel.org>; Wed, 06 Mar 2019 00:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=1z2lAKclTsS+iuS3T7KcT8UEol80bg+om3zRGMhnM+M=;
        b=oy4oq9yzO/1num5bG0XzsxcpE6NrUswTBxB0ANRRi6aATGTBuTUGO2VhEKttUrQVRx
         sDQDfHDZmDeZh3bFDqoHzuhTuSZbvSKSQ330JbKYaYl7/fddCOSe6ibp36d+ibv7nNxJ
         mpOaWuMx58R4gEfgpauuuQicQOJ9fUCSGgXbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=1z2lAKclTsS+iuS3T7KcT8UEol80bg+om3zRGMhnM+M=;
        b=q1hVF8iFcbfaHpR9b0gdo8/yFYiO1nQbvCp3UDBdB7X3WXanz6FerdSEe8ENdE1M4L
         PsVlxcCR+lllI6rnrkI9DyY45qwpPz/LfeWKBZkMtGdlRFcAkq3+FUNIhG2gS+sIiiZi
         K7LVqMnR6IUPAifD0/7t0IW+BnPIMTgZGpGAOg4EcJ3YAZfStf88Gj+mZEjoRj5e44Us
         bj/c8zuL9VrG2o9EtOiZeVrFPKVjZGtsZDJN4S3Bs+eQWtZ38/s8QRptXLzxzNav1+T1
         fDkmfbA6sdDGO25bMPfFl6Iblf/lzSYbEZiMNAJcuJzFdc/LHVwSdwM6XDUHMQhrTOFh
         yxcQ==
X-Gm-Message-State: APjAAAUEE+QxI4EMVy1gb0mDvWHnDTguQ7Cm3DWSBfArXICuAuePjA99
        JOsbk0yL0KBFpxXerdgCRxOYhA==
X-Google-Smtp-Source: APXvYqyKVRgqDcV6wLVzcIcrCOphv31chyO0tbseVQWh2Dg36MZt6MkbJya/IPsY7FS2fX+3QCPQbA==
X-Received: by 2002:a2e:6f08:: with SMTP id k8mr1671553ljc.197.1551862754289;
        Wed, 06 Mar 2019 00:59:14 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id t14sm201656lfk.83.2019.03.06.00.59.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Mar 2019 00:59:13 -0800 (PST)
References: <20190301210529.8218-1-daniel@iogearbox.net> <87lg1tz9ys.fsf@cloudflare.com> <831131a1-59e3-e7c7-f56e-7b69d4850ffc@iogearbox.net>
User-agent: mu4e 1.1.0; emacs 26.1
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     ast@fb.com, afabre@cloudflare.com, marek@cloudflare.com,
        bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: fix sanitation rewrite in case of non-pointers
In-reply-to: <831131a1-59e3-e7c7-f56e-7b69d4850ffc@iogearbox.net>
Date:   Wed, 06 Mar 2019 09:59:12 +0100
Message-ID: <87k1hcz8db.fsf@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 05, 2019 at 03:30 PM CET, Daniel Borkmann wrote:
> On 03/05/2019 03:12 PM, Jakub Sitnicki wrote:
> [...]
>> Could you please queue it for -stable which has d3bd7413e0ca ("bpf: fix
>> sanitation of alu op with pointer / scalar type from different paths")?
>
> Already done here yesterday morning:
>
> https://lore.kernel.org/stable/40b25ec1c31e234cf7eee75d62083a9a4bcbdbfe.1551702973.git.daniel@iogearbox.net/T/#u

Ah, you're one step ahead of me. Thank you.
