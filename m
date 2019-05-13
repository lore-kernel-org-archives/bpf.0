Return-Path: <SRS0=YueQ=TN=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE5FC04AA7
	for <bpf@archiver.kernel.org>; Mon, 13 May 2019 17:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E598520873
	for <bpf@archiver.kernel.org>; Mon, 13 May 2019 17:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Udd90F4h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731898AbfEMRwR (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Mon, 13 May 2019 13:52:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42995 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731830AbfEMRwR (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 13 May 2019 13:52:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id 13so7587559pfw.9;
        Mon, 13 May 2019 10:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gG0BeH3aPQX6+9LO5Ic0rQpmKN+xGb6eZVLaTkbtrKc=;
        b=Udd90F4h0zCNNnbXAe+164TapFQw71wxN7u8OpVilQLDN2CAyCa7LF+znZakjhxeHJ
         2JNP4csDk4coCIrwSntcXc7HRFk72zS6MDtQs17ck3OeABYzwTrOmjYSOO1FRP7r3Z71
         V9FnaLbUX0Yt3I69Ps7TGVrNefJHEQXjk/7+NIvvHLL5hf2+PRpnlaIYL/Nylna7eMN7
         AG4ljkSarqeOGZ+JhxAQLeV3fBotXHZqJN1izwapxqEe8bHMwfGmTW6C/I4PfGGHAWAy
         v22WoTAIVlvcfWu63bevXOkut85yEw/+hlcHIqhXTpB+ybvIjJSmyI4hWW9vd8g9MhKL
         0vJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gG0BeH3aPQX6+9LO5Ic0rQpmKN+xGb6eZVLaTkbtrKc=;
        b=ImvKp6BAfi0hSn97LgFywtif5CLxO1xGyOT5+RW7bm+kPqGt9weMTZ5B7rE8hcR1eV
         3OLylDydWZloJSKrDsi7Q1m5OU/IY5O8/EJ+aAyt/v/Wv6MnJIDRmvvpy4gunu4lg92X
         K5ewSKNkh3TdHVCyoeREb3EFBhy6XVeuOrguYhPvFOod7Bd4EbvtoaMH8ibfpvN5UFbd
         EtWSIEMgPhcgX7aQ+dHI0yuYhaeGyyUt9nV2xT3SecowdKT+V6Nhx+qppcTYSYx7Y56Z
         FFBqJMzo5K0/6PhB250umyOkvgzFZPH/X04UWpvY6yEz95j5zOF42gP6GqESfGNrRaWt
         cGFA==
X-Gm-Message-State: APjAAAXE7/h8wdGElwIh81r5D+hCkVKsGJnWzcySZr4o9BctkBzwGkrm
        BSbd9c4SzTe2+Mb2JLaGcya6LxFh
X-Google-Smtp-Source: APXvYqxseWYBCRfSGJpzKVqfYOLwGQPN63KyKSEflyxw90tRLNWj/yCNvcE0oWLz6A9qW1LfWTDtfA==
X-Received: by 2002:a65:610b:: with SMTP id z11mr12844675pgu.204.1557769936363;
        Mon, 13 May 2019 10:52:16 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id r138sm25380068pfr.2.2019.05.13.10.52.14
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:52:15 -0700 (PDT)
Subject: Re: [PATCH net] flow_dissector: disable preemption around BPF calls
To:     Mark Rutland <mark.rutland@arm.com>,
        Eric Dumazet <edumazet@google.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        netdev <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        syzbot <syzkaller@googlegroups.com>,
        Petar Penkov <ppenkov@google.com>,
        Stanislav Fomichev <sdf@google.com>
References: <20190513163855.225489-1-edumazet@google.com>
 <20190513171745.GA16567@lakrids.cambridge.arm.com>
 <CANn89iJzsUbLXB_M5UZr2ieNyQdGHsKPFzqeQFGtKtL8d9pu0Q@mail.gmail.com>
 <20190513172527.GB16567@lakrids.cambridge.arm.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <49f8b98e-c717-c1c4-893d-cddccca3b887@gmail.com>
Date:   Mon, 13 May 2019 10:52:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190513172527.GB16567@lakrids.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/13/19 10:25 AM, Mark Rutland wrote:
> On Mon, May 13, 2019 at 10:20:19AM -0700, 'Eric Dumazet' via syzkaller wrote:
>> On Mon, May 13, 2019 at 10:17 AM Mark Rutland <mark.rutland@arm.com> wrote:
>>>
>>> On Mon, May 13, 2019 at 09:38:55AM -0700, 'Eric Dumazet' via syzkaller wrote:
>>>> Various things in eBPF really require us to disable preemption
>>>> before running an eBPF program.
>>>
>>> Is that true for all eBPF uses? I note that we don't disable preemption
>>> in the lib/test_bpf.c module, for example.
>>>
>>> If it's a general requirement, perhaps it's worth an assertion within
>>> BPF_PROG_RUN()?
>>
>> The assertion is already there :)
>>
>> This is how syzbot triggered the report.
> 
> Ah! :)
> 
> I also see I'm wrong about test_bpf.c, so sorry for the noise on both
> counts!

No worries, thanks for reviewing !

