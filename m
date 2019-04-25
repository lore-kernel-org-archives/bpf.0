Return-Path: <SRS0=aERf=S3=vger.kernel.org=bpf-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C69F1C10F11
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 03:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 865A4217FA
	for <bpf@archiver.kernel.org>; Thu, 25 Apr 2019 03:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="qdHVx8e8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388708AbfDYDID (ORCPT <rfc822;bpf@archiver.kernel.org>);
        Wed, 24 Apr 2019 23:08:03 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33132 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387808AbfDYDIC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Apr 2019 23:08:02 -0400
Received: by mail-qk1-f195.google.com with SMTP id k189so12203804qkc.0
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2019 20:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Mqc1i5xgcySVQK5G0wioxIXvLn1mHfC7TLCiWVlSByQ=;
        b=qdHVx8e8vClXYDj+IZfS50h6YEt7Xj5QUt11uOiwAbDCzcER2J/HSLM2/iDVvAIc+4
         ltQS4MMOsWXhwNNAF20hnkhwcDOYKLnqFnKbQ27L1YGMIgC4xg7pasWGAPCf0VPryZJ0
         x4zGQKoSd+52FzJ37EY2AILhJ7xjSPsvuiy9Kxcp7k2C1T4YCKDMHQXvmifjVddkGx+g
         Mpg4Xq1+ZOX5zY5M+9Y/akqR2AsAupplAFUNTkZsvhpwCe6Y0EE5/GuAh7/AaXr1OByu
         HVEFKLCmBnECu7Qnm4djNv7uJix4ix1bC9ZiMWRDJRItToTOvmlQpcAkFwUjeJy2aRqj
         dcJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Mqc1i5xgcySVQK5G0wioxIXvLn1mHfC7TLCiWVlSByQ=;
        b=K71tHfFOg+watm5yOSA7bbZzDuLP61YV5BAWNpMHyKJkizFv7wF6XF64/j5Pk5tsL3
         cN6a7SxZoYvBnAzB2eFXI/YA3DgsHTleXybVp8tbBg1z9S820fzgFHdtRGOPHnInrUvT
         MM/CWkawaQqepX+xtiC1Jisw7Sg77XeXH99RqfU1BIRrVVFYhrYqBb147bspQUn7U9u5
         ZrkafRzCMaNxpjGTHpiqB6k8uPitM6t/9c7ZD6U9AOYoQFDCk+yd9EEhpb0md80ZOTRK
         jeMOXDmFTafdlhNd9VF7xJz11azEnBDHVHA33zfwUbrhZRo0FNvQUkRFArPFmR3+WKQz
         Ssmw==
X-Gm-Message-State: APjAAAVoGK4DrYx+wzNzCdakZpTT86DRNkBu/P2AThISYgs5BYSvAgQC
        x9hJPXwyzxuwlslrNes5ectZIA==
X-Google-Smtp-Source: APXvYqy0odNzNOfI4LR2Zw5wL5UFLO2BJu0wPdjIxjcKxfzozJWAYoeKpPZ+SqEHCaz2fnMpnVtlUw==
X-Received: by 2002:a05:620a:1091:: with SMTP id g17mr13868236qkk.114.1556161681305;
        Wed, 24 Apr 2019 20:08:01 -0700 (PDT)
Received: from cakuba.netronome.com ([66.60.152.14])
        by smtp.gmail.com with ESMTPSA id y189sm1542112qke.34.2019.04.24.20.08.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 20:08:01 -0700 (PDT)
Date:   Wed, 24 Apr 2019 20:07:57 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     John Fastabend <john.fastabend@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [bpf PATCH 1/3] bpf: tls, implement unhash to avoid transition
 out of ESTABLISHED
Message-ID: <20190424200757.0978cbd2@cakuba.netronome.com>
In-Reply-To: <155613366350.20131.18131808324848803588.stgit@john-XPS-13-9360>
References: <155613361373.20131.9399480750962676899.stgit@john-XPS-13-9360>
        <155613366350.20131.18131808324848803588.stgit@john-XPS-13-9360>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, 24 Apr 2019 12:21:03 -0700, John Fastabend wrote:
> It is possible (via shutdown()) for TCP socks to go through TCP_CLOSE
> state via tcp_disconnect() without calling into close callback. This
> would allow a kTLS enabled socket to exist outside of ESTABLISHED
> state which is not supported.
> 
> Solve this the same way we solved the sock{map|hash} case by adding
> an unhash hook to remove tear down the TLS state.
> 
> In the process we also make the close hook more robust. We add a put
> call into the close path, also in the unhash path, to remove the
> reference to ulp data after free. Its no longer valid and may confuse
> things later if the socket (re)enters kTLS code paths. Second we add
> an 'if(ctx)' check to ensure the ctx is still valid and not released
> from a previous unhash/close path.
> 
> Fixes: d91c3e17f75f2 ("net/tls: Only attach to sockets in ESTABLISHED state")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: John Fastabend <john.fastabend@gmail.com>

Ah, EDOESNTBUILD, now I get to nitpick too? :)

> diff --git a/include/net/tls.h b/include/net/tls.h
> index d9d0ac66f040..ae13ea19b375 100644
> --- a/include/net/tls.h
> +++ b/include/net/tls.h
> @@ -266,6 +266,8 @@ struct tls_context {
>  	void (*sk_write_space)(struct sock *sk);
>  	void (*sk_destruct)(struct sock *sk);
>  	void (*sk_proto_close)(struct sock *sk, long timeout);
> +	void (*sk_proto_unhash)(struct sock *sk);
> +	struct proto *sk_proto;
>  
>  	int  (*setsockopt)(struct sock *sk, int level,
>  			   int optname, char __user *optval,
> @@ -303,7 +305,7 @@ int tls_sw_sendmsg(struct sock *sk, struct msghdr *msg, size_t size);
>  int tls_sw_sendpage(struct sock *sk, struct page *page,
>  		    int offset, size_t size, int flags);
>  void tls_sw_close(struct sock *sk, long timeout);
> -void tls_sw_free_resources_tx(struct sock *sk);
> +void tls_sw_free_resources_tx(struct sock *sk, bool locked);
>  void tls_sw_free_resources_rx(struct sock *sk);
>  void tls_sw_release_resources_rx(struct sock *sk);
>  int tls_sw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
> @@ -504,6 +506,16 @@ static inline void xor_iv_with_seq(int version, char *iv, char *seq)
>  	}
>  }
>  
> +static inline void tls_put_ctx(struct sock *sk)
> +{
> +	struct inet_connection_sock *icsk = inet_csk(sk);
> +	struct tls_context *ctx = icsk->icsk_ulp_data;
> +
> +	if (!ctx)
> +		return;
> +	sk->sk_prot = ctx->sk_proto;
> +	icsk->icsk_ulp_data = NULL;
> +}
>  
>  static inline struct tls_sw_context_rx *tls_sw_ctx_rx(
>  		const struct tls_context *tls_ctx)
> diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
> index 7e546b8ec000..2973048957bd 100644
> --- a/net/tls/tls_main.c
> +++ b/net/tls/tls_main.c
> @@ -261,23 +261,16 @@ static void tls_ctx_free(struct tls_context *ctx)
>  	kfree(ctx);
>  }
>  
> -static void tls_sk_proto_close(struct sock *sk, long timeout)
> +static bool tls_sk_proto_destroy(struct sock *sk,
> +				 struct tls_context *ctx, bool destroy)

perhaps this destroy should rather be called locked?  It doesn't really
control destroying AFACT..

>  {
> -	struct tls_context *ctx = tls_get_ctx(sk);
>  	long timeo = sock_sndtimeo(sk, 0);
> -	void (*sk_proto_close)(struct sock *sk, long timeout);
> -	bool free_ctx = false;
> -
> -	lock_sock(sk);
> -	sk_proto_close = ctx->sk_proto_close;
>  
>  	if (ctx->tx_conf == TLS_HW_RECORD && ctx->rx_conf == TLS_HW_RECORD)
> -		goto skip_tx_cleanup;
> +		return false;
>  
> -	if (ctx->tx_conf == TLS_BASE && ctx->rx_conf == TLS_BASE) {
> -		free_ctx = true;
> -		goto skip_tx_cleanup;
> -	}
> +	if (ctx->tx_conf == TLS_BASE && ctx->rx_conf == TLS_BASE)
> +		return true;
>  
>  	if (!tls_complete_pending_work(sk, ctx, 0, &timeo))
>  		tls_handle_open_record(sk, 0);
> @@ -286,10 +279,10 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
>  	if (ctx->tx_conf == TLS_SW) {
>  		kfree(ctx->tx.rec_seq);
>  		kfree(ctx->tx.iv);
> -		tls_sw_free_resources_tx(sk);
> +		tls_sw_free_resources_tx(sk, destroy);
>  #ifdef CONFIG_TLS_DEVICE
>  	} else if (ctx->tx_conf == TLS_HW) {
> -		tls_device_free_resources_tx(sk);
> +		tls_device_free_resources_tx(sk, destroy);

this part breaks the build tls_device_free_resources_tx() doesn't need
changes.  tls_device_offload_cleanup_rx() will though, cause it sleeps.

>  #endif
>  	}
>  
> @@ -310,8 +303,39 @@ static void tls_sk_proto_close(struct sock *sk, long timeout)
>  		tls_ctx_free(ctx);
>  		ctx = NULL;
>  	}
> +	return false;
> +}
> +
> +static void tls_sk_proto_unhash(struct sock *sk)
> +{
> +	struct tls_context *ctx = tls_get_ctx(sk);
> +	void (*sk_proto_unhash)(struct sock *sk);
> +	bool free_ctx;
> +
> +	if (!ctx)
> +		return sk->sk_prot->unhash(sk);
> +	sk_proto_unhash = ctx->sk_proto_unhash;
> +	free_ctx = tls_sk_proto_destroy(sk, ctx, false);
> +	tls_put_ctx(sk);
> +	if (sk_proto_unhash)
> +		sk_proto_unhash(sk);
> +	if (free_ctx)
> +		tls_ctx_free(ctx);
> +}
>  
> -skip_tx_cleanup:
> +static void tls_sk_proto_close(struct sock *sk, long timeout)
> +{
> +	struct tls_context *ctx = tls_get_ctx(sk);
> +	void (*sk_proto_close)(struct sock *sk, long timeout);

reverse xmas tree

> +	bool free_ctx;
> +
> +	if (!ctx)
> +		return sk->sk_prot->destroy(sk);
> +
> +	lock_sock(sk);
> +	sk_proto_close = ctx->sk_proto_close;
> +	free_ctx = tls_sk_proto_destroy(sk, ctx, true);
> +	tls_put_ctx(sk);
>  	release_sock(sk);
>  	sk_proto_close(sk, timeout);
>  	/* free ctx for TLS_HW_RECORD, used by tcp_set_state
> @@ -609,6 +633,8 @@ static struct tls_context *create_ctx(struct sock *sk)
>  	ctx->setsockopt = sk->sk_prot->setsockopt;
>  	ctx->getsockopt = sk->sk_prot->getsockopt;
>  	ctx->sk_proto_close = sk->sk_prot->close;
> +	ctx->sk_proto_unhash = sk->sk_prot->unhash;
> +	ctx->sk_proto = sk->sk_prot;
>  	return ctx;
>  }
>  
> @@ -732,6 +758,7 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
>  	prot[TLS_BASE][TLS_BASE].setsockopt	= tls_setsockopt;
>  	prot[TLS_BASE][TLS_BASE].getsockopt	= tls_getsockopt;
>  	prot[TLS_BASE][TLS_BASE].close		= tls_sk_proto_close;
> +	prot[TLS_BASE][TLS_BASE].unhash		= tls_sk_proto_unhash;
>  
>  	prot[TLS_SW][TLS_BASE] = prot[TLS_BASE][TLS_BASE];
>  	prot[TLS_SW][TLS_BASE].sendmsg		= tls_sw_sendmsg;
> diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
> index f780b473827b..0577633c319b 100644
> --- a/net/tls/tls_sw.c
> +++ b/net/tls/tls_sw.c
> @@ -2044,7 +2044,7 @@ static void tls_data_ready(struct sock *sk)
>  	}
>  }
>  
> -void tls_sw_free_resources_tx(struct sock *sk)
> +void tls_sw_free_resources_tx(struct sock *sk, bool locked)
>  {
>  	struct tls_context *tls_ctx = tls_get_ctx(sk);
>  	struct tls_sw_context_tx *ctx = tls_sw_ctx_tx(tls_ctx);
> @@ -2055,9 +2055,11 @@ void tls_sw_free_resources_tx(struct sock *sk)
>  	if (atomic_read(&ctx->encrypt_pending))
>  		crypto_wait_req(-EINPROGRESS, &ctx->async_wait);
>  
> -	release_sock(sk);
> +	if (locked)
> +		release_sock(sk);
>  	cancel_delayed_work_sync(&ctx->tx_work.work);
> -	lock_sock(sk);
> +	if (locked)
> +		lock_sock(sk);
>  
>  	/* Tx whatever records we can transmit and abandon the rest */
>  	tls_tx_records(sk, -1);
> @@ -2080,7 +2082,10 @@ void tls_sw_free_resources_tx(struct sock *sk)
>  		kfree(rec);
>  	}
>  
> -	crypto_free_aead(ctx->aead_send);
> +	if (ctx->aead_send) {
> +		crypto_free_aead(ctx->aead_send);
> +		ctx->aead_send = NULL;
> +	}
>  	tls_free_open_rec(sk);
>  
>  	kfree(ctx);
> 

