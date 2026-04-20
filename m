Received: from mail-oi1-f193.google.com (mail-oi1-f193.google.com [209.85.167.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E721F3876AB
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 19:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776713676; cv=none; b=K2A6Cx+siN86F4dayQN9JLeeuByB/Rm6i5tG50EL71G8KR1toVDzVmjhxT2wREdU25Lgu2lHKk5PzwXOZsR6JEM4AyKedtFYQTJcAqJoe6wbxoLRWDwQgoUu5hE4hIcCb0Ldcc6DYnYHEV000L7hPH2Q0241YHKumTAOx6LKbeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776713676; c=relaxed/simple;
	bh=XGKPoDmpV4MgNLy7Oyucks5h+XmlNtCvsW6dSrH75wQ=;
	h=Date:Message-ID:From:To:Cc:In-Reply-To:Subject:Content-Type; b=ooIUMrsgmLS7MwUhaAwAPNxUQJrmigfK2BzDFVc/Vcs/p1tk2LH71B/KPc02TDcvXrNcUpFsQ4lOqUlSf2vhodoMLFDN0ZrluXTQrXSgXhG3jZszdwrqrGpfdnrBl5fwOKLwT6LW81hTKoVPMU39D+1dPPDr6G3vo6/oQFwzIEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=llGQI+J5; arc=none smtp.client-ip=209.85.167.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="llGQI+J5"
Received: by mail-oi1-f193.google.com with SMTP id 5614622812f47-479dd56d016so539342b6e.3
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 12:34:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776713673; x=1777318473; darn=vger.kernel.org;
        h=subject:in-reply-to:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nqPhSL9n4a1mVszPHKUpvP/Qwk2uvuWeoKOStpa8Uv8=;
        b=llGQI+J5G5w5lOohwAhTZ0opB4yVzbsZM9edTtsl6KPau1ejStsLql7TFCL2PHgzdR
         3AoGy8mA/3T6JE78CT4PqWNEP4tcwGxkxCCinOZWR3FbwsPB020BbGqGENeVarLQxpXo
         dZ0rcec8dbJOGmvkdPMh9aS2o20fUz/pb5JvBvsFAvGVID/ZRag2ScwEcoAfdpV0i8/I
         BlUwK9SeKSfbg9FrVQ3mOcESqRFETKkSCwznX5cv1A07s+448ZUtYOlPyY+EhpR0PeXw
         f+ilNOu02LzLZdkowMY5nspzd1NTfOhw/0P6aIEDAnfrwHMDb7v0JQjsTBAOYQ7shjm+
         oZTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776713673; x=1777318473;
        h=subject:in-reply-to:cc:to:from:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nqPhSL9n4a1mVszPHKUpvP/Qwk2uvuWeoKOStpa8Uv8=;
        b=SgsfWmjLwWOsPKZnig1nqoGnPvMp7PXjGCX467a4dyNizF1YRbqNKxE7FzIpREUoFo
         k/YiyL9y/fSMo1klGnj4cD7ZOj4kJQduWs2BJR1b4sNapxfAY9t8g66jKOd0/2PAAs0j
         JJq2jW2QSzZFg5id43niHle5rettOySfnKBzvzCRwrO0nfasx/GODl31eEIhsqeI9qAm
         3R5LQlql4m4h5qRctXDzdCBWJia77ce2UKOszx+p9m60VaxLnDFtcyYo8Nr4nYtLj0kD
         hMqXwUCsfUNKCq8BchClyHL+j6tEmeis3sI+3kC5PfuCKwhdEShVKzgU4DEbCHLFUGLn
         vLsg==
X-Gm-Message-State: AOJu0Yw7III0VOLqFlGjgJn3qyliIW0kXyX+PB+41ZHNbpP111qtsFrm
	PKzgP/U4a0PxZ+EGDQ3hE02w1ihcql/3FZes2NJ99k5yRKR6F8OMZ6cs
X-Gm-Gg: AeBDietxji+wZ9/5c/LADLJBzmy59rh1Rkikt4PseXDYVKFAIC02Za8q9FByg38GjdZ
	KR7t3LCtcyHT00HQcukwKSqJpI+OkG61EdAvcI/vPciVsnZ5O+fKt7MAcC9I+du+CpuWZwVr7Wa
	MVN3TzTNbAYgOkN5hNnYw59yKUisKjoZ8DCFxPRR0qi1HcR4CmzbsvXwIlmKhiogvFiJLnYMytZ
	dG63cHnjMKtEhUCMyLHHBUuL2kcRu71FZ021DnCF8TDw+c/PTP2Jl48X3KJ9Tdnd6TFgsNE801q
	oA50bJc0hTlCf4BdHe4D3ljK2OD+5F7i2MzVMbR/+MxyZYpjc7h+RVrSE/RGfVCXMmZ+E4GAHja
	TvqBhuugtnu+GF5wKbgGa73TcPdsFJ10N/A78T831MBHz4qWeYtv8hO4jljIzOQaI+tn9RV70mk
	lYT3jlEtH+X+WkaE3aLhw2k0I3IoY=
X-Received: by 2002:a05:6808:2015:10b0:479:af11:5262 with SMTP id 5614622812f47-479af115488mr3864242b6e.33.1776713672820;
        Mon, 20 Apr 2026 12:34:32 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:1::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975b057bsm10256033a34.20.2026.04.20.12.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 12:34:32 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:34:31 -0700
Message-ID: <519af099662f2b79eb95ceaabc7f7069.sdf.kernel@gmail.com>
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org,
 Jason Xing <kernelxing@tencent.com>
In-Reply-To: <20260420082805.14844-3-kerneljasonxing@gmail.com>
Subject: Re: [PATCH net v2 2/8] xsk: handle NULL dereference of the skb
 without frags issue
Content-Type: text/plain
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

> From: Jason Xing <kernelxing@tencent.com>
> 
> When a first descriptor (xs->skb == NULL) triggers -EOVERFLOW in
> xsk_build_skb_zerocopy (e.g., MAX_SKB_FRAGS exceeded), the free_err
> EOVERFLOW handler unconditionally dereferences xs->skb via
> xsk_inc_num_desc(xs->skb) and xsk_drop_skb(xs->skb), causing a NULL
> pointer dereference.
> 
> In this series, the skb is already freed by kfree_skb() inside
> xsk_build_skb_zerocopy for the first-descriptor case, so we only need
> to do the bookkeeping: cancel the one reserved CQ slot and account for
> the single invalid descriptor.
> 
> Guard the existing xsk_inc_num_desc/xsk_drop_skb calls with an
> xs->skb check (for the continuation case), and add an else branch
> for the first-descriptor case that manually cancels the CQ slot and
> increments invalid_descs by one.
> 
> Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on Tx path")
> Signed-off-by: Jason Xing <kernelxing@tencent.com>
> ---
>  net/xdp/xsk.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
> index 6149f6a79897..6521604f8d42 100644
> --- a/net/xdp/xsk.c
> +++ b/net/xdp/xsk.c
> @@ -893,9 +893,14 @@ static struct sk_buff *xsk_build_skb(struct xdp_sock *xs,
>  		kfree_skb(skb);
>  
>  	if (err == -EOVERFLOW) {
> -		/* Drop the packet */
> -		xsk_inc_num_desc(xs->skb);
> -		xsk_drop_skb(xs->skb);
> +		if (xs->skb) {
> +			/* Drop the packet */
> +			xsk_inc_num_desc(xs->skb);
> +			xsk_drop_skb(xs->skb);
> +		} else {
> +			xsk_cq_cancel_locked(xs->pool, 1);
> +			xs->tx->invalid_descs++;
> +		}
>  		xskq_cons_release(xs->tx);
>  	} else {
>  		/* Let application retry */
> -- 
> 2.41.3
>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
