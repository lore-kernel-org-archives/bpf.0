Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C37DC43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 20:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D9892087C
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 20:51:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="HSKraqn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732157AbfCZUvE (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 16:51:04 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38813 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726207AbfCZUvE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 16:51:04 -0400
Received: by mail-wm1-f66.google.com with SMTP id a188so14415429wmf.3
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 13:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=WUWufCSMYpcuZ1Q8U5VJuhgr37Yg/XhDeh/+r3Sv10M=;
        b=HSKraqn3SZcHLNFUJkumuEPmblFSGz8wVcgZaFj14FYIDpe651/GsNjhlUoVgug/Y7
         L+AabMM7klnrVboYWvQgp89MBCMCCxdrJ5g68wLkOQGxdTtct1sHKVBh9+CJCT+rGTlW
         xNnmGPgev9UKCIXaOgoZiTe8StH7PJFUqVMkvHZtyc2Lc6ZD1TgLmaeZRJ+A4tGXumOS
         Wa6QRgwGAVCK9S7W48+NSh0nFOPK0kpmD+7DBEmS6hGFFadvT/yOJLaEdUfIhpZdzrZQ
         u6IrlXICeonoQyKDG3EosK+Yuq04p43b/OnpCxJq89ke286oGER9zADR0f4vfasq/G/p
         hgLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=WUWufCSMYpcuZ1Q8U5VJuhgr37Yg/XhDeh/+r3Sv10M=;
        b=rq5te/d1YhvEVoFAz8NCaWm23aWFw8g8VnCKKouG3zbXRmiIAZZ1LHvSLEMKja+WXt
         ZpNlYslH0SXaqlCEyyPSXz3bsjIcgFn1RvGCxUogn1MsKm2Z7+b64vSaxIvtmIzyn7u1
         iTkuOwaR8VTaM+czeRgCyiNScPsMbIdYEacYIrjrT9cbJMT8cAYepoxb1owJ7kunKWXk
         In0NFdEpAHT033rmSx0ehoQzJnsIJcYvcBELUywFLsAYtzrd/DXILgSIbYWn9BJ4g525
         NYMxiL1kT5BYrwkGXXsdO/akeH2G0qkGNw/VhbTQlqrxhB6r2i26/kMiXc5Iwt1wUrKP
         /d3w==
X-Gm-Message-State: APjAAAWAxFrPnGEmNcI/hdI5XD8BH+diqKTV9w7+qNRM2z9A0bcajZtH
        hBbMoujb+Z5Q9OOTDD98uBXiYA==
X-Google-Smtp-Source: APXvYqyma+psEB1bMfpQ/yy+FKsL2GSXCDjid46x7kVdsWH3vpbzl6lXaGmhi9VGGPMPOTdssfJZDA==
X-Received: by 2002:a1c:c4cd:: with SMTP id u196mr9962254wmf.70.1553633462992;
        Tue, 26 Mar 2019 13:51:02 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id b204sm33714808wmh.29.2019.03.26.13.51.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Mar 2019 13:51:02 -0700 (PDT)
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com> <1553623539-15474-4-git-send-email-jiong.wang@netronome.com> <CAG48ez0inUUF3wZw5P6o35T3CKQ=CEue1vo-H-dSLDKKo2OHow@mail.gmail.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Jann Horn <jannh@google.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        oss-drivers@netronome.com
Subject: Re: [PATCH/RFC bpf-next 03/16] bpf: split read liveness into REG_LIVE_READ64 and REG_LIVE_READ32
In-reply-to: <CAG48ez0inUUF3wZw5P6o35T3CKQ=CEue1vo-H-dSLDKKo2OHow@mail.gmail.com>
Date:   Tue, 26 Mar 2019 20:50:58 +0000
Message-ID: <87lg114ax9.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Jann Horn writes:

> On Tue, Mar 26, 2019 at 7:06 PM Jiong Wang <jiong.wang@netronome.com> wrote:
>>
>> In previous patch, we have split register arg type for sub-register read,
>> but haven't touch read liveness.
>>
>> This patch further split read liveness into REG_LIVE_READ64 and
>> REG_LIVE_READ32. Liveness propagation code are updated accordingly.
>>
>> After this split, customized actions could be defined when propagating full
>> register read (REG_LIVE_READ64) or sub-register read (REG_LIVE_READ32).
>>
>> Signed-off-by: Jiong Wang <jiong.wang@netronome.com>
> [...]
>> @@ -1374,7 +1374,8 @@ static int check_stack_read(struct bpf_verifier_env *env,
>>                         return -EACCES;
>>                 }
>>                 mark_reg_read(env, &reg_state->stack[spi].spilled_ptr,
>> -                             reg_state->stack[spi].spilled_ptr.parent);
>> +                             reg_state->stack[spi].spilled_ptr.parent,
>> +                             size == BPF_REG_SIZE);
>
> Isn't it possible to use a 4-byte read on the upper half of an 8-byte
> stack slot?

I think that's fine, and is irrelevant with zero-extension on register.

If it is a 8-byte stack slot comes from spill of register, then the
definition of the register should have been marked as needing
zero-extension if that register was generated by sub-register write.

Regards,
Jiong

>
>>                 if (value_regno >= 0) {
>>                         if (zeros == size) {
>>                                 /* any size read into register is zero extended,
>> @@ -2220,7 +2221,8 @@ static int check_stack_boundary(struct bpf_verifier_env *env, int regno,
>>                  * the whole slot to be marked as 'read'
>>                  */
>>                 mark_reg_read(env, &state->stack[spi].spilled_ptr,
>> -                             state->stack[spi].spilled_ptr.parent);
>> +                             state->stack[spi].spilled_ptr.parent,
>> +                             access_size == BPF_REG_SIZE);
>
> Same thing as above.
>
>>         }
>>         return update_stack_depth(env, state, off);
>>  }
> [...]

