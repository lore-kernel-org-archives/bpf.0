Return-Path: <SRS0=dSBe=R5=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB0D7C43381
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 19:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABA7020823
	for <bpf@archiver.kernel.org>; Tue, 26 Mar 2019 19:45:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="iQraO4TR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730449AbfCZTpQ (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Tue, 26 Mar 2019 15:45:16 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:40261 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfCZTpQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 26 Mar 2019 15:45:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id z24so11050185wmi.5
        for <bpf@vger.kernel.org>; Tue, 26 Mar 2019 12:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GQM8PM9dqHFCGSiig2m6YLKHFO02Ugyh/lMzStg3uiU=;
        b=iQraO4TRyeQxlikG0XjbsidoZZCcdpnrRq+5wfKPju4+KY0qLIT4jXgCRZY5mHuKsy
         ghz/eWEGvemsmSMbaG2/cC835pAnWLdAD46DowGD/txHSmM0ezzlqWSDzbOGCwPH4fLa
         IYEQdyXmNCoLG2GBt7Yp4kuCblT99fbBijGPYgm+yttYlRPjzv/Lf9yotrCL3wo+3LNy
         +AEYCdnMCLpcY8xlEGWgcIYhl1QKNNKCdjgCi/TY4xIEpuL9l7JcQ7BUh081Rdv0qtyO
         ZkuVW1uSMpR48CkrU5QXnXy8quBMXrQNoI0XtEZ7jm8cLYUOTGjCG1kbHpgAjYtFTp6q
         QMTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GQM8PM9dqHFCGSiig2m6YLKHFO02Ugyh/lMzStg3uiU=;
        b=ulmhWAJZ5nHJkfAoZteURF2PU5fegjU9C9yMILuFSpZzNWVHWPeo2EajSXM+P5CI/l
         a2jd0e7PyvfMfxBrFkKyfPmDF5MYt5GeIBy8CL9Ebqbf0zZZryd5tKGP/Gb0EaphhnqM
         S2YHsY12yEC3PCWCOK2pKRgt25JuXjoOEvCb+Z8dmWEs5NDvporkv2sKeBjRO8C4xgva
         drwiUQSwFQ5dp7ZMUJ9FjVn4p5ovAMgb78s94ERKoAiA+5nfVw/5Zqsg045moudz0xlO
         U6eW7Ipmq0bAi31ktcjiTRS0gIMtw3L/y9+dyXqGCYe+++OoQDaDiE/fh+8ERZNPB60+
         Kf2Q==
X-Gm-Message-State: APjAAAUCxVz9GPbBq7Kuk1Gcr59fXq9pP9s4kAZm5lGBNXeg86ESrGQ+
        lC+4FYCrI4/TUhXQj40xYqKW5w==
X-Google-Smtp-Source: APXvYqwPHyWunLLntYbUqZg2Kv7IORzgNPBzccelJWJ4y0jPOhw/7BCUeUiMQ7k6NSPRVcnNOQe8UQ==
X-Received: by 2002:a05:600c:219:: with SMTP id 25mr9842209wmi.7.1553629514380;
        Tue, 26 Mar 2019 12:45:14 -0700 (PDT)
Received: from [192.168.0.10] (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id f1sm9954134wrt.87.2019.03.26.12.45.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 12:45:13 -0700 (PDT)
Subject: Re: [PATCH/RFC bpf-next 02/16] bpf: refactor propagate_live
 implementation
To:     Jann Horn <jannh@google.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        Network Development <netdev@vger.kernel.org>,
        oss-drivers@netronome.com
References: <1553623539-15474-1-git-send-email-jiong.wang@netronome.com>
 <1553623539-15474-3-git-send-email-jiong.wang@netronome.com>
 <CAG48ez0s9HC8eJhS-T2+SwrD_X7FQJmD9Br72zcnnMVFTwhVwQ@mail.gmail.com>
From:   Jiong Wang <jiong.wang@netronome.com>
Message-ID: <ecd92556-cc7e-ac2d-4d44-c71b7591c22e@netronome.com>
Date:   Tue, 26 Mar 2019 19:45:09 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.0
MIME-Version: 1.0
In-Reply-To: <CAG48ez0s9HC8eJhS-T2+SwrD_X7FQJmD9Br72zcnnMVFTwhVwQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 26/03/2019 18:26, Jann Horn wrote:
> On Tue, Mar 26, 2019 at 7:07 PM Jiong Wang <jiong.wang@netronome.com> wrote:
>> Some code inside current implementation of "propagate_liveness" is a little
>> bit verbose.
>>
>> This patch refactor them so the code looks more simple and more clear.
>>
>> The redundant usage of "vparent->frame[vstate->curframe]" is removed as we
>> are here. It is safe to do this because "state_equal" has guaranteed that
>> vstate->curframe must be equal with vparent->curframe.
> [...]
>> @@ -6050,6 +6050,22 @@ static bool states_equal(struct bpf_verifier_env *env,
>>          return true;
>>   }
>>
>> +static int propagate_liveness_reg(struct bpf_verifier_env *env,
>> +                                 struct bpf_reg_state *reg,
>> +                                 struct bpf_reg_state *parent_reg, u8 flag)
> This function takes four arguments...
>
> [...]
>> @@ -6071,16 +6088,13 @@ static int propagate_liveness(struct bpf_verifier_env *env,
> [...]
>> +               err = propagate_liveness_reg(env, &regs[i], &parent_regs[i]);
> .. but both here...
>
> [...]
>> @@ -6089,11 +6103,13 @@ static int propagate_liveness(struct bpf_verifier_env *env,
> [...]
>> +                       err = propagate_liveness_reg(env, reg, parent_reg);
> ... and here you only pass in three arguments? Does this compile?

Yes, it compiles. It is fixed in patch 03/16...

I was doing some simplification on 03/16, then found it's better
to be put into 02/16, and forget to update the function prototype there,

apology for this.

Regards,
Jiong

