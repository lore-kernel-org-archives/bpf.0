Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCD61C43218
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:32:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0955E20645
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 19:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDdBg0Oe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbfDYTce (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Thu, 25 Apr 2019 15:32:34 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:55597 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728499AbfDYTce (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Apr 2019 15:32:34 -0400
Received: by mail-it1-f195.google.com with SMTP id y134so2010006itc.5;
        Thu, 25 Apr 2019 12:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gezOQt3hkLSYmxqTvMLaSTpzxk6Y9QJJ1Ot80iq6tUc=;
        b=uDdBg0Oe7B8ncuHr8IOA4Pg3KOgby8rdNjixvKB1wgKtAeuWPsNrKJZk+JloDFsDAU
         q2ecu7vn5yKANRtw3d95H+F0p0jjdJK/4/U7pQm8LbtaXK1JtZnPgIum0xQpTTEYZ8GA
         j+JJj7tpRSL13DBUjhJ9rJoPJpw77husnjckbDe4kYNTQmCeAOlrPerCN58jYIeH84Lu
         Ls+M6/wz9Az82Aj7PWOXoUaco7vJlZI5b3N7R7JkZKwV731zGibakvDuSv0l6IvPLb75
         PowjiRC4bNbqzd9n0YLGSm3MPBxhnjXMEtVXzVfD3uUWCx1OidKmeD0Pdg40/PZyxSKe
         3RZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gezOQt3hkLSYmxqTvMLaSTpzxk6Y9QJJ1Ot80iq6tUc=;
        b=BZObfD6wi60YaPomB0t4PFPh+aGwdtaYpygZaLRAgiNseirOxKwaI/zs/+ZoQjHgyX
         fUHhhZ8t3Y196AQjCsEuHj18hE8l9dX+21hCprMA7BYmTIvmVwJXRdvoib53UtN9zncb
         Ns6jRB+xMMBMefevKWnZl3CEdIYh/uZ8C9+skEtvu7882izeYN3e1urEycH2EAf8+1IJ
         WdwtNqlfbyPgUrpMVP3wSn0aMfvNryKYteUc5oSO+TgwNRy2woYdtqdq77YtMxMbAJIk
         WViijZBlcWnoUD1B1sbvOZSudnW4iWi59IwpGLeAg/HzYaZhvsOjoa5tqFdyT1Y5q5OX
         jRoA==
X-Gm-Message-State: APjAAAWpPzXIZCoSPZWooJrv6SQF5QiWG5P0SVfmVl5KwqPuQ5pUAie5
        VsQ9JcW1kNltw8os/JcEvLtnsq5DXUg=
X-Google-Smtp-Source: APXvYqxCbzD/vNIXbVKshIi0sOVzOhGG+nOJaq5UDpZCc7M+ijCpT+L/2CT226bc6PafDIVXfybXew==
X-Received: by 2002:a24:d643:: with SMTP id o64mr5098995itg.148.1556220753383;
        Thu, 25 Apr 2019 12:32:33 -0700 (PDT)
Received: from [192.168.86.29] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id z10sm1688213itk.19.2019.04.25.12.32.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Apr 2019 12:32:32 -0700 (PDT)
Subject: Re: [bpf PATCH v2 1/3] bpf: tls, implement unhash to avoid transition
 out of ESTABLISHED
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <155620799743.22884.8046772841813554446.stgit@john-XPS-13-9360>
 <155620818860.22884.14832636768748270693.stgit@john-XPS-13-9360>
 <20190425122908.68b8d759@cakuba.netronome.com>
From:   John Fastabend <john.fastabend@gmail.com>
Message-ID: <fed3deb5-0119-4f24-9a53-cad7a9b0fcbe@gmail.com>
Date:   Thu, 25 Apr 2019 12:32:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190425122908.68b8d759@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/25/19 12:29 PM, Jakub Kicinski wrote:
> On Thu, 25 Apr 2019 09:03:08 -0700, John Fastabend wrote:
>> +static void tls_sk_proto_unhash(struct sock *sk)
>> +{
>> +	struct tls_context *ctx = tls_get_ctx(sk);
>> +	void (*sk_proto_unhash)(struct sock *sk);
>> +	bool free_ctx;
>> +
>> +	if (!ctx)
>> +		return sk->sk_prot->unhash(sk);
>> +	sk_proto_unhash = ctx->sk_proto_unhash;
>> +	free_ctx = tls_sk_proto_destroy(sk, ctx, false);
>> +	tls_put_ctx(sk);
> 
> Oh, I think you can't put_ctx() unconditionally,
> when free_ctx is false, tls_device_sk_destruct() 
> needs it the ctx pointer.
> 
> I think this explains the offload crashing.
> 

ugh yeah. So we need to _not_ free it from tls_sk_proto_destroy
do the put_ctx and then finally free it. Otherwise we can't
restore the sk_proto fields. v3 on its way. Thanks.

>> +	if (sk_proto_unhash)
>> +		sk_proto_unhash(sk);
>> +	if (free_ctx)
>> +		tls_ctx_free(ctx);
>> +}
>>  
>> -skip_tx_cleanup:
>> +static void tls_sk_proto_close(struct sock *sk, long timeout)
>> +{
>> +	void (*sk_proto_close)(struct sock *sk, long timeout);
>> +	struct tls_context *ctx = tls_get_ctx(sk);
>> +	bool free_ctx;
>> +
>> +	if (!ctx)
>> +		return sk->sk_prot->destroy(sk);
>> +
>> +	lock_sock(sk);
>> +	sk_proto_close = ctx->sk_proto_close;
>> +	free_ctx = tls_sk_proto_destroy(sk, ctx, true);
>> +	tls_put_ctx(sk);

