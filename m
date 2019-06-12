Return-Path: <SRS0=ovpu=UL=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59BC0C46477
	for <bpf@archiver.kernel.org>; Wed, 12 Jun 2019 15:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F14A20874
	for <bpf@archiver.kernel.org>; Wed, 12 Jun 2019 15:25:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="OBLr88sX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408727AbfFLPZy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 12 Jun 2019 11:25:54 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38952 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727419AbfFLPZy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 12 Jun 2019 11:25:54 -0400
Received: by mail-wr1-f67.google.com with SMTP id x4so14733072wrt.6
        for <bpf@vger.kernel.org>; Wed, 12 Jun 2019 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=oc2s3mGWcayhrebkSWIB4EAZJBK7ag895TM7UNOYyCY=;
        b=OBLr88sXg8cPnlD8QmsZKfQEYWaFQd79s9+Siy02Q9bPeW8U42bneigTJlCeEPDNzA
         7o9Zpc0xcjyJPDHzHd3laS2DAhGUeLjJMW65jkiJV+0y+hIihSF2/pwbYsHEnn2liaJE
         XN3mLNgh9hdknUym7a1wGK2ZYJMxGterqd3NPLY6dz7HFcyuHjGT5b3KqVIgne4A3GNm
         sjWDpdhJ5lx5UoYlJaxVKLmRIWJOw7TrY0Kho5BWd6TS0h0BFV+8wei7ViUZfzqUK8WQ
         sAilX8xiicb45RD3QnQwJHUjEZhwv1k6WTqzFHj6JP6H3SBzv4lkLaSUq/Z4XLUUnQRv
         d21A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=oc2s3mGWcayhrebkSWIB4EAZJBK7ag895TM7UNOYyCY=;
        b=R4F/W4I9FPL/MgzM4HjE8QeJa6Md2zXy6mJhY4kfP/TW/WPYUhVMpQM+/eViG9PgUL
         hxadzpdJmHljB9hoLm7znOxIeqlnHS8drLnyhBJtu8oiFgwqfnb6thhWFRC1mhxrFbQB
         ipLd6WKWDpdNCUHBhFZf6tPrp4TysSESA3nGDhNi1FYDNYNNDv7uUaJX6Ns5JXTze4HE
         Ex9GfETv92HPSuA4j2XEvOVWuN75422tJGKNj4KF/DWDFyhL3i+ACWIZO+2U71IA58lf
         codC2eLCY85I0pjEeJGNe5WZvkw2ljKT1ehG6hzn0blD0CD4CH+oFUcmnTJ+Fs1FOghI
         KMag==
X-Gm-Message-State: APjAAAUPdclwl11jSB0fiuuSSzvnxHN8tYKLRBruTobgY23IiddDCBm3
        kw3wA0jcLyPm5tmHh0meQFQUxA==
X-Google-Smtp-Source: APXvYqxxhsv8IezgxryRNtKLBW/kt3b/DyD8DUKo6ow/FI9nZRHvAa3K8dkjlpTo1G0qDkQ9f9RhRg==
X-Received: by 2002:a5d:5283:: with SMTP id c3mr25392922wrv.268.1560353152061;
        Wed, 12 Jun 2019 08:25:52 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id j7sm24960098wru.54.2019.06.12.08.25.50
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Jun 2019 08:25:50 -0700 (PDT)
References: <20190612113208.21865-1-naveen.n.rao@linux.vnet.ibm.com> <CAADnVQLp+N8pYTgmgEGfoubqKrWrnuTBJ9z2qc1rB6+04WfgHA@mail.gmail.com> <87sgse26av.fsf@netronome.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Jiong Wang <jiong.wang@netronome.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        bpf <bpf@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jakub Kicinski <jakub.kicinski@netronome.com>
Subject: Re: [PATCH] bpf: optimize constant blinding
In-reply-to: <87sgse26av.fsf@netronome.com>
Date:   Wed, 12 Jun 2019 16:25:48 +0100
Message-ID: <87r27y25c3.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Jiong Wang writes:

> Alexei Starovoitov writes:
>
>> On Wed, Jun 12, 2019 at 4:32 AM Naveen N. Rao
>> <naveen.n.rao@linux.vnet.ibm.com> wrote:
>>>
>>> Currently, for constant blinding, we re-allocate the bpf program to
>>> account for its new size and adjust all branches to accommodate the
>>> same, for each BPF instruction that needs constant blinding. This is
>>> inefficient and can lead to soft lockup with sufficiently large
>>> programs, such as the new verifier scalability test (ld_dw: xor
>>> semi-random 64 bit imms, test 5 -- with net.core.bpf_jit_harden=2)
>>
>> Slowdown you see is due to patch_insn right?
>> In such case I prefer to fix the scaling issue of patch_insn instead.
>> This specific fix for blinding only is not addressing the core of the problem.
>> Jiong,
>> how is the progress on fixing patch_insn?

And what I have done is I have digested your conversion with Edward, and is
slightly incline to the BB based approach as it also exposes the inserted
insn to later pass in a natural way, then was trying to find a way that
could create BB info in little extra code based on current verifier code,
for example as a side effect of check_subprogs which is doing two insn
traversal already. (I had some such code before in the historical
wip/bpf-loop-detection branch, but feel it might be still too heavy for
just improving insn patching)

>
> I actually was about to reply this email as we have discussed exactly the
> same issue on jit blinding here:
>
>   https://www.spinics.net/lists/bpf/msg01836.html
>
> And sorry for the slow progress on fixing patch_insn, please give me one
> more week, I will try to send out a RFC for it.
>
> Regards,
> Jiong

