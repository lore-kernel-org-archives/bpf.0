Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63AF6C10F03
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 03:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2036F214AE
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 03:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bJm59xnG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388984AbfDYDe5 (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 23:34:57 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:39161 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388852AbfDYDe5 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 23:34:57 -0400
Received: by mail-it1-f193.google.com with SMTP id e13so9938435itk.4;
        Wed, 24 Apr 2019 20:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=s3DVKVHbXz9A6ylBoou+24oTkD2XJRdpxMvUeDcib8M=;
        b=bJm59xnGNOeTJuSzHq2MKUZ6Im3PCGqLefQezya4N2uFoy8gnOzEp2AQlOrbIwyxOh
         nlljObokQT+o+fm1e/aBJzObCEcAQhG030S6n+hUXY9SxHbyegJgY4hQaFkjOKuex9km
         /ufd5IZhHZLJG5oen7TFTLnoukAbXliOXPC6pz5umJr1ynFMCzAyqNyYaNckPDnayvhj
         3poTmfoiftFmiSEsr5ySe4A4M+6ACaXzLOUR6eL3LRMU5cfzdiAdMh5E4HfYqi3v4FqL
         oLWEzYZzBGxElLyPuA9PmzBnWUl5bMqG0r79JUlmQ2ZDBrn6v65LwntYJPcNbckIj44L
         rlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=s3DVKVHbXz9A6ylBoou+24oTkD2XJRdpxMvUeDcib8M=;
        b=iKStjsfCaJJIY3e2o5vr+Gz5Ux79PJ+5qPDg38QnEyZ5395Ce8uRqVFZC5MgGm9iCE
         D6hh6b59EOcqjKMS1g/MgwVwcTXYDysMk5Uub80wxX3FNMVSOwh4MREPtLAEC1d0xDon
         /oqXqy+3yBxhtVcBcwth69wIso/lpoP93g42FuSkeciUFUbEE/qOsSZM0bp2NVdBqbIA
         3cY34TePOgOzhlmwgg8SJaJJFGB/ivkdl0vKNi86o291G68w8qOXiDkxnDZFnQlm+6ua
         Vmme/kapbkB1hUc9agH7l1exJ3sHC/d3MWOzVtrvEpIlZ1XjeFS5BpQeq7mjCWFTiVHc
         IbUQ==
X-Gm-Message-State: APjAAAXoOBF17z+KFpJHqObvThbgP+b5SA9WWmQJ4peeBFb0zPAEx6hO
        BoSn5l+qCiu22V1ziQpIGdp4Dfm/KEM=
X-Google-Smtp-Source: APXvYqw5jPwc+wsHXDMa/Zsy4oz8sVuwacltvb95bEiSd9DcaoCPPk1hhBzVHjCEqFCIgeCE1wV+DQ==
X-Received: by 2002:a24:ac3:: with SMTP id 186mr2121635itw.16.1556163296131;
        Wed, 24 Apr 2019 20:34:56 -0700 (PDT)
Received: from [192.168.86.29] ([184.63.162.180])
        by smtp.gmail.com with ESMTPSA id o16sm5977032ioo.45.2019.04.24.20.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 20:34:55 -0700 (PDT)
Subject: Re: [bpf PATCH 1/3] bpf: tls, implement unhash to avoid transition
 out of ESTABLISHED
To:     Jakub Kicinski <jakub.kicinski@netronome.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
References: <155613361373.20131.9399480750962676899.stgit@john-XPS-13-9360>
 <155613366350.20131.18131808324848803588.stgit@john-XPS-13-9360>
 <20190424200757.0978cbd2@cakuba.netronome.com>
From:   John Fastabend <john.fastabend@gmail.com>
Message-ID: <9551f4c2-cff1-86fb-bd6d-4fc83c5c0798@gmail.com>
Date:   Wed, 24 Apr 2019 20:34:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424200757.0978cbd2@cakuba.netronome.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 4/24/19 8:07 PM, Jakub Kicinski wrote:
> On Wed, 24 Apr 2019 12:21:03 -0700, John Fastabend wrote:
>> It is possible (via shutdown()) for TCP socks to go through TCP_CLOSE
>> state via tcp_disconnect() without calling into close callback. This
>> would allow a kTLS enabled socket to exist outside of ESTABLISHED
>> state which is not supported.
>>
>> Solve this the same way we solved the sock{map|hash} case by adding
>> an unhash hook to remove tear down the TLS state.
>>
>> In the process we also make the close hook more robust. We add a put
>> call into the close path, also in the unhash path, to remove the
>> reference to ulp data after free. Its no longer valid and may confuse
>> things later if the socket (re)enters kTLS code paths. Second we add
>> an 'if(ctx)' check to ensure the ctx is still valid and not released
>> from a previous unhash/close path.
>>
>> Fixes: d91c3e17f75f2 ("net/tls: Only attach to sockets in ESTABLISHED state")
>> Reported-by: Eric Dumazet <edumazet@google.com>
>> Signed-off-by: John Fastabend <john.fastabend@gmail.com>
> 
> Ah, EDOESNTBUILD, now I get to nitpick too? :)
> 

Oops messed up a merge conflict. nitpicks seems like a fair enough
punishment.

# CONFIG_TLS_DEVICE is not set


[...]

>>  static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
>>  		const struct tls_context *tls_ctx)
>> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
>> index 7e546b8ec000..2973048957bd 100644
>> --- a/net/tls/tls_main.c
>> +++ b/net/tls/tls_main.c
>> @@ -261,23 +261,16 @@ static void tls_ctx_free(struct tls_context *ctx)
>>  	kfree(ctx);
>>  }
>>  
>> -static void tls_sk_proto_close(struct sock *sk, long timeout)
>> +static bool tls_sk_proto_destroy(struct sock *sk,
>> +				 struct tls_context *ctx, bool destroy)
> 
> perhaps this destroy should rather be called locked?  It doesn't really
> control destroying AFACT..
> 

Sure we can call it locked.

>>  {
>> -	struct tls_context *ctx = tls_get_ctx(sk);
>>  	long timeo = sock_sndtimeo(sk, 0);
>> -	void (*sk_proto_close)(struct sock *sk, long timeout);
>> -	bool free_ctx = false;
>> -
>> -	lock_sock(sk);
>> -	sk_proto_close = ctx->sk_proto_close;
>>  
>>  	if (ctx->tx_conf == TLS_HW_RECORD && ctx->rx_conf == TLS_HW_RECORD)
>> -		goto skip_tx_cleanup;
>> +		return false;
>>  
>> -	if (ctx->tx_conf == TLS_BASE && ctx->rx_conf == TLS_BASE) {
>> -		free_ctx = true;
>> -		goto skip_tx_cleanup;
>> -	}
>> +	if (ctx->tx_conf == TLS_BASE && ctx->rx_conf == TLS_BASE)
>> +		return true;
>>  
>>  	if (!tls_complete_pending_work(sk, ctx, 0, &timeo))
>>  		tls_handle_open_record(sk, 0);
>> @@ -286,10 +279,10 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
>>  	if (ctx->tx_conf == TLS_SW) {
>>  		kfree(ctx->tx.rec_seq);
>>  		kfree(ctx->tx.iv);
>> -		tls_sw_free_resources_tx(sk);
>> +		tls_sw_free_resources_tx(sk, destroy);
>>  #ifdef CONFIG_TLS_DEVICE
>>  	} else if (ctx->tx_conf == TLS_HW) {
>> -		tls_device_free_resources_tx(sk);
>> +		tls_device_free_resources_tx(sk, destroy);
> 
> this part breaks the build tls_device_free_resources_tx() doesn't need
> changes.  tls_device_offload_cleanup_rx() will though, cause it sleeps.

OK will touch that path as well.

> 
>>  #endif
>>  	}
>>  
>> @@ -310,8 +303,39 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
>>  		tls_ctx_free(ctx);
>>  		ctx = NULL;
>>  	}
>> +	return false;
>> +}
>> +
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
>> +	if (sk_proto_unhash)
>> +		sk_proto_unhash(sk);
>> +	if (free_ctx)
>> +		tls_ctx_free(ctx);
>> +}
>>  
>> -skip_tx_cleanup:
>> +static void tls_sk_proto_close(struct sock *sk, long timeout)
>> +{
>> +	struct tls_context *ctx = tls_get_ctx(sk);
>> +	void (*sk_proto_close)(struct sock *sk, long timeout);
> 
> reverse xmas tree
> 

+1

>> +	bool free_ctx;
>> +
>> +	if (!ctx)
>> +		return sk->sk_prot->destroy(sk);
>> +
>> +	lock_sock(sk);
>> +	sk_proto_close = ctx->sk_proto_close;
>> +	free_ctx = tls_sk_proto_destroy(sk, ctx, true);
>> +	tls_put_ctx(sk);
>>  	release_sock(sk);
>>  	sk_proto_close(sk, timeout);
>>  	/* free ctx for TLS_HW_RECORD, used by tcp_set_state


Thanks for reviewing.

