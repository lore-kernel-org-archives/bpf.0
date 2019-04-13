Return-Path: <SRS0=1cax=SP=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3752C282CE
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 06:39:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B618218AF
	for <bpf@archiver.kernel.org>; Sat, 13 Apr 2019 06:39:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qelO1SEL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDMGjy (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Sat, 13 Apr 2019 02:39:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44782 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726918AbfDMGjy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 13 Apr 2019 02:39:54 -0400
Received: by mail-wr1-f68.google.com with SMTP id y7so14651627wrn.11
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2019 23:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=/YEuMPuAL1nenMEY3PEyo1evLU8Kef6/R2XR/9VgccU=;
        b=qelO1SELp51RjMuoYVq/4jdruRkyIHzkp8jjICpR0idHo0xI2Of9EaT1UbbyEtTYJb
         WYICz4EwAJuMoFbJEcWqeNaYsF2OhokvoHEwtATp2qxOGnnDyUbfqsw5MzlKAEYxVewB
         s4ij8XvajciS6oMFby+ghNe3zivet/jUVrqEGuebdedVYbdPBfAOGqQduZeYKv6qPKr7
         rsGFyMeAoSazQNjIqyiVzRSFwGbBpdo4D/TO2NGvmmL//bUXMHpObD8r6ZGUC0LWvJ/I
         UZrl6IfURLH4FSkCfarQWHPZZhp79kH3dLtPclFn+1VW/u/a5YTA5Tq7tXaPHd3WGtIc
         xslQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=/YEuMPuAL1nenMEY3PEyo1evLU8Kef6/R2XR/9VgccU=;
        b=tCmq3YRPGnAwT0DXxgyCskaCDaTa/hsgTz8yZX4tnz5CxxznhRo6rCnm4te5bDpCwn
         flKMLbXQC2u2EoxFidDx2TW6yW2zC7PcIpto/wJIkuxVReLXS4oW4iZ50ZUGmn4ZYa0n
         iY++sevNt7HXL6Ag1K74WaB1z0z5JFS+PEXDBfTeIoVeWH5xtzjZuz/PqbJuPsIUVOmo
         T9Fot7qxV3i9VvUFJIGF326R2M9pCVxWMP6Tw57BEK1x3SOhJo4AD05IR1RhcFm0tWHy
         Sf1jXWkv1Oi3Ld3crrH70tLg13w3yMBH0kuweCLpj6yuyAGDu+YCDHnNqIa64qPjZbgM
         BFXA==
X-Gm-Message-State: APjAAAXF7eCRw3NYDb5I1jt5NsXNz36Plzw8gj7AxI2mkApidYUGshWt
        VZt81sGkbl+EOB2l3JPJk/2jmQ==
X-Google-Smtp-Source: APXvYqzz0Dx4bB0lcHvQ+DsOeWXLSaxQNLUGFhdI7Ue94ecwujYlkUVdDeglrANun3WKpHJmrY2u/g==
X-Received: by 2002:adf:c60e:: with SMTP id n14mr39764498wrg.127.1555137593034;
        Fri, 12 Apr 2019 23:39:53 -0700 (PDT)
Received: from LAPTOP-V3S7NLPL (cpc1-cmbg19-2-0-cust104.5-4.cable.virginm.net. [82.27.180.105])
        by smtp.gmail.com with ESMTPSA id t81sm19600180wmb.5.2019.04.12.23.39.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Apr 2019 23:39:52 -0700 (PDT)
References: <1555106392-20117-1-git-send-email-jiong.wang@netronome.com> <1555106392-20117-6-git-send-email-jiong.wang@netronome.com> <20190412180734.2f863fbe@cakuba.netronome.com>
User-agent: mu4e 0.9.18; emacs 25.2.2
From:   Jiong Wang <jiong.wang@netronome.com>
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     Jiong Wang <jiong.wang@netronome.com>,
        alexei.starovoitov@gmail.com, daniel@iogearbox.net,
        bpf@vger.kernel.org, netdev@vger.kernel.org,
        oss-drivers@netronome.com
Subject: Re: [PATCH v3 bpf-next 05/19] bpf: split read liveness into REG_LIVE_READ64 and REG_LIVE_READ32
In-reply-to: <20190412180734.2f863fbe@cakuba.netronome.com>
Date:   Sat, 13 Apr 2019 07:39:45 +0100
Message-ID: <87h8b2flxq.fsf@netronome.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Jakub Kicinski writes:

> On Fri, 12 Apr 2019 22:59:38 +0100, Jiong Wang wrote:
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index c722015..3c5ca00 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -1135,7 +1135,7 @@ static int check_subprogs(struct bpf_verifier_env *env)
>>   */
>>  static int mark_reg_read(struct bpf_verifier_env *env,
>>  			 const struct bpf_reg_state *state,
>> -			 struct bpf_reg_state *parent)
>> +			 struct bpf_reg_state *parent, u8 flags)
>>  {
>>  	bool writes = parent == state->parent; /* Observe write marks */
>>  	int cnt = 0;
>> @@ -1150,17 +1150,17 @@ static int mark_reg_read(struct bpf_verifier_env *env,
>>  				parent->var_off.value, parent->off);
>>  			return -EFAULT;
>>  		}
>> -		if (parent->live & REG_LIVE_READ)
>> +		if ((parent->live & REG_LIVE_READ) == flags)
>>  			/* The parentage chain never changes and
>> -			 * this parent was already marked as LIVE_READ.
>> +			 * this parent was already marked with all read bits.
>
> No big deal, but I though said you'd modify this patch here...

Ouch, sorry, I created one internal branch before start the test
changes. Looks like the branch is v10 which listed before v2~v9 that
somehow later I switched v9 for the test changing thought it is the latest
branch.

Regards,
Jiong

>
>>  			 * There is no need to keep walking the chain again and
>> -			 * keep re-marking all parents as LIVE_READ.
>> +			 * keep re-marking all parents with reads bits in flags.
>>  			 * This case happens when the same register is read
>>  			 * multiple times without writes into it in-between.
>>  			 */
>>  			break;
>>  		/* ... then we depend on parent's value */
>> -		parent->live |= REG_LIVE_READ;
>> +		parent->live |= flags;
>>  		state = parent;
>>  		parent = state->parent;
>>  		writes = true;
>
>> @@ -6227,12 +6317,19 @@ static int propagate_liveness_reg(struct bpf_verifier_env *env,
>>  				  struct bpf_reg_state *reg,
>>  				  struct bpf_reg_state *parent_reg)
>>  {
>> +	u8 parent_bits = parent_reg->live & REG_LIVE_READ;
>> +	u8 bits = reg->live & REG_LIVE_READ;
>> +	u8 bits_diff = parent_bits ^ bits;
>> +	u8 bits_prop = bits_diff & bits;
>>  	int err;
>>  
>> -	if (parent_reg->live & REG_LIVE_READ || !(reg->live & REG_LIVE_READ))
>> +	/* "reg" and "parent_reg" has the same read bits, or the bit doesn't
>> +	 * belong to "reg".
>> +	 */
>> +	if (!bits_diff || !bits_prop)
>>  		return 0;
>
> .. and here?

