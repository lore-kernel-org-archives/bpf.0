Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980EA208AD
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 04:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712292739; cv=none; b=syfJhDLXhkudm6EaWz3NndOFISOgfoQoS/2cpYEeq/HNadMY1FPVya2u6S8WnE5h/lnkNAHcxKRjoRgRzTiFfCMZS2qhWH2uwGuEmwsKZWlJsxZDnatkyIuBvgzVoPp9sjiOBcdTF4mlIK3lKkgA5UbdO2t0yP2cRlkzmhRD3gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712292739; c=relaxed/simple;
	bh=KN4AHgf6ZxBccsLo49QfFOIDtSh/mT5uHpAcZfdBrNQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=I8LlyrjquT7RqyCNRtGL2t6MUQvzcEPncTgL8e67ZM0IenFEv81JqRTMNSCb1lkFuFr+aFV0w8BACDT113uJW1wx2fFGNg2uC3alQK7Ix7RyPt5rXQLM4gTXdnt+4e6G9/qkZ9p9yDVUM0ONsyxWe003rGafu874O9Hh6m6fvMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g+AT/5YC; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g+AT/5YC"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e0ae065d24so14906575ad.1
        for <bpf@vger.kernel.org>; Thu, 04 Apr 2024 21:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712292737; x=1712897537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eMnsm99QjMp7/RpE4OeJ33hRhVaELn41hfyW19g7XYI=;
        b=g+AT/5YCe4XxZLk8rp6vQ2lcwrQWIEt/TPPSWpgALbvw9OTB6zg0vMVlcGrNkPrxAj
         B9pm0YVSUnMGnG4xXvi6dDZ3FRBCd+4U04f3+D0TxRy7bHzFSEQN+oPiRZkPAPaHxJK6
         o4cENes8+46cU2Za9nkZm9BCp5YVq54j+S5+OZqOHgjoO6hOfPakqYOvGud54Zccv7J7
         D1gPtQZSFlbrEoAN4vM8QWOfw0ymqRCw3x8x4hN4YsRFka2bneCwXK+j2uLnlQ3o60uu
         ur8i1HM0dOYGZfrg6ZXA36IdlV1BDNygNRG4Y71GvL3+gn1BD4PCbX4/YXFNTS9TFUu5
         c+1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712292737; x=1712897537;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eMnsm99QjMp7/RpE4OeJ33hRhVaELn41hfyW19g7XYI=;
        b=D04m87/HtMl51mWT7vivZwejO7A3t9hqzMWe3fKu1dqEZ8/pct0RjEdnA0paxWO7w3
         qnSVeI2RaRf7ls879wAFpRiJ1YTESKI+0J2jonHIlYEwKxZidc09S8AzeDdcDSSeRBfG
         t/LuTWK4pfkC3QJHy4HuMCKuph77rCTmm/8nUwPSMIZlXloDrfoQ93BG0JQW+1uM+63L
         KyZ+or2IjyTRW8eMmWv/ksy8bDTD7kPXv4TOllyDS01QZ07O1XY8dC3bchyZsN9B5Q6p
         g4U5yezv+mZs4iMyOc0FA2gpJzBWdgrDvhAZZFJM5PUKHmwhlwGB3R75PKGhdYugg7n5
         HNsg==
X-Forwarded-Encrypted: i=1; AJvYcCWMFwzTN6hRbGoIYzk3TVP0424MEQnX0w0Sms0Gi7Eqk43ZzY+g+glL++jMZXJ1WWvmuZT+TGfw4rjJqFm1xRUHyyzG
X-Gm-Message-State: AOJu0YwTl2b0L/JBeDFKMaNEej8vAra4aXAX2MzAlTUdJQNcZ5gmOn5i
	ukuoIfwupj4XdQbrNFX6GeGCoSCO+bOKVjWKl3I9i7eevB61w5rr
X-Google-Smtp-Source: AGHT+IGJ1O6er88crei12qoj6EIiHx60KQTcIx0/cH7gLebObLqoYWELy1873PfqAXwoWdqYSV7gMA==
X-Received: by 2002:a17:902:f7cc:b0:1e0:fcf9:95e0 with SMTP id h12-20020a170902f7cc00b001e0fcf995e0mr348229plw.20.1712292736767;
        Thu, 04 Apr 2024 21:52:16 -0700 (PDT)
Received: from localhost ([98.97.36.54])
        by smtp.gmail.com with ESMTPSA id ix5-20020a170902f80500b001e24a287d66sm536032plb.117.2024.04.04.21.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 21:52:16 -0700 (PDT)
Date: Thu, 04 Apr 2024 21:52:15 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 bpf <bpf@vger.kernel.org>
Cc: Kashyap Sanidhya <sanidhya.kashyap@epfl.ch>, 
 rishabh.iyer@berkley.edu, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Jakub Sitnicki <jakub@cloudflare.com>
Message-ID: <660f837f9e83a_50b8720828@john.notmuch>
In-Reply-To: <CAP01T74=OChcu8V2u3bSMas=Lh-y72Y+7my1djn-uSKygBoX+w@mail.gmail.com>
References: <CAP01T74=OChcu8V2u3bSMas=Lh-y72Y+7my1djn-uSKygBoX+w@mail.gmail.com>
Subject: RE: [Bug Report] Packet drops after trimming skb using
 bpf_skb_adjust_room
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Kumar Kartikeya Dwivedi wrote:
> Hello John,
> 
> For background, I have a sk_skb program where for certain flows, a
> subset of request handling logic (on Rx) that is typically done in
> user space is handed over to a BPF program for doing it in-kernel.
> 
> Since the protocol is over TCP, I'm using sk_skb programs to handle
> these requests and generate responses from within the kernel. The user
> space application will decide which flow should be added to the
> sockmap on socket accept and then let it be handled in the kernel for
> some of the request types.
> 
> However, when generating replies and trimming away extra bytes in the
> packet by using bpf_skb_adjust_room, I see packet drops because the
> strp_msg->full_len is not updated unless tls_sw_has_ctx_rx is true for
> the socket. Removing that condition makes everything work, but I am
> not sure that is the right fix.
> 
> My understanding so far is that in sk_psock_backlog,
> sk_psock_handle_skb returns an error since the stm->full_len is not
> correct (and passed into it as len), and SK_PSOCK_TX_ENABLED gets
> cleared due to this error. Then, on the redirect side
> (sk_psock_skb_redirect), it does sock_drop because the test for the
> SK_PSOCK_TX_ENABLED flag fails, which does kfree_skb.
> 
> I have attached a patch with a selftest (skb_adjust_room) that you can
> run to verify the problem. It should basically hang on the second read
> as the packet would be dropped by the kernel. The first read goes
> through fine. Applying the diff below allows the selftest to pass.
> 
> I am not familiar with the code to know whether the fix below is
> correct, but it seems to resolve the problem for me (and I carried it
> for a while and ran my stuff on it until I got around to reporting
> this now).
> 
> In case gmail screws up the formatting, I'm just removing the
> tls_sw_has_ctx_rx(skb->sk) conditional on the strp_msg->full_len
> update in sk_skb_adjust_room.

I think your analysis is correct and patch looks good. I'll study
a bit more tomorrow.  It looks like I just messed it up there and
didn't consider the case of redirect in non-TLS case.

Gmail did fine pushing code through.

> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 524adf1fa6d0..e3009d0f3352 100644
> 
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -3622,11 +3622,7 @@ BPF_CALL_4(sk_skb_adjust_room, struct sk_buff
> *, skb, s32, len_diff,
> 
>                         return -ENOMEM;
> 
>                 __skb_pull(skb, len_diff_abs);
> 
>         }
> 
> -       if (tls_sw_has_ctx_rx(skb->sk)) {
> -               struct strp_msg *rxm = strp_msg(skb);
> -
> -               rxm->full_len += len_diff;
> -       }
> +       strp_msg(skb)->full_len += len_diff;
>         return ret;
>  }
> 
> --
> 
> Thanks!


