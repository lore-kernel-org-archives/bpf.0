Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784101E87C
	for <bpf@vger.kernel.org>; Fri,  5 Apr 2024 22:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354943; cv=none; b=NmIzDT80FQNIBKd5got+CNNR/QOTg3WWNB/7i8NuHQzBaOi9YLPhlvVFEDQrjwdSLSf0lQHPOJrLhX5CyS4TFdZiZp/cAEGUMLC7z85xrNi1hSvi867emI1+2SRjT8t1Ddhx4y+fU3Uw1/0qdkTLcTRq15UhoOuDRh7x0QLxDBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354943; c=relaxed/simple;
	bh=0YkUL0OfCREOqLSq21CJf3esAynAiLRa/S5IZF5N3eg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZQgxkqsgC1Cja4e/dChyTsyod+0oD61nLfk5LjRcgjtVNQMfqc6QSjEYKbTC92RnTD3pqWJOGVaZf6/n+yItFkkrdE3ibUXoOjlL8e/LP2SMK6KFQdJPyOJXOCnBZ5uyY97IaPd1fZPhCX0stmZ9iI+wNKayjMFdJOmZX87qTg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cb4EvPfm; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cb4EvPfm"
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-56e1baf0380so2986948a12.3
        for <bpf@vger.kernel.org>; Fri, 05 Apr 2024 15:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712354940; x=1712959740; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HpAItr0VE9jNBiWn3IQc6d5xh5pEePqPWvrPMuhyjUc=;
        b=Cb4EvPfmuZwSvlf1LEd9YGVLGWaH2I1ut14GK1khGMFE3sndJNJQWRJYQKQ8xX3M0L
         0re5Y0D3WKst66sSE2t8kiuMYWbGxMD76S6r/cJFodBBPeLg3bfFjNamnWgZGOHct9En
         pWA6T1tvg3oyfEFu+kQdJP8o8ybJiN02taWGt4TqewjUniyaIIo60QA/PHNhf6g/Hxsx
         hmjADQS/MsVhd8KG0CpZVavURhzL50BqzgeVQP/bgXREyVJYBewPH0sNoFQ6JuX3/+GA
         s4DYOllwVPgrJw1JgiD5Ni09y5vfu0GAoc5BsijrB24FqeuxNBx7gk02sjYO6R4ItoXG
         J8ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712354940; x=1712959740;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HpAItr0VE9jNBiWn3IQc6d5xh5pEePqPWvrPMuhyjUc=;
        b=KmenRtwv1AHIdcaxu5GkjEp7j6dTHH48pbcsQAaeXWBHt7uJ8CI7sIFmDVQQXH1OAA
         6dXFA/crly+gj/9o7rLOLMxxa6yMsABx7l4PvDsUE0tmsJPmtFDBDVYZhwOuh5jhSPFs
         mIdgVqoiUOD9UKCcOIr2PYu7WZ5HM4pAnqeYXp+5464+z6jx0xVM8aZRTbfxtnCXMBr8
         4jo8YgsF8jaZc8NjNX3n3Y9uc72UOOEnu34X5thaSI1Mll8Je901OLXOjQfLD6ym0nsU
         AwZY44+ptBjWp5IQ8ypcLObGqo16jKtMDTo8DaiibAfPq9UmahQXp2f4Hzrifb9qKgzM
         cnww==
X-Gm-Message-State: AOJu0Yx9dLazw25bSfBFgF5jjH1Dh0dDyPhTtXDBoHOXdrPajrzTCd09
	Heukq+v9U9hpBpWjyN6i2dyzYN1M4QQnVM7I8gEPC4YS/hUCXi+cFkbOH8GwTfsRNe53KM03vrp
	fF6NR3OgySpLB8UO+js8XIaQDjiywYN4HNBA=
X-Google-Smtp-Source: AGHT+IFhz6xnNpMoGGot+FR3G+zzMvkmdyzpoNBT0aseN8nAwbio5XN/SanXE9We3TF8ytuWrE32T2mvwKrncDapR4I=
X-Received: by 2002:a50:9e48:0:b0:56e:2464:7c4b with SMTP id
 z66-20020a509e48000000b0056e24647c4bmr1927384ede.10.1712354939614; Fri, 05
 Apr 2024 15:08:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAP01T74=OChcu8V2u3bSMas=Lh-y72Y+7my1djn-uSKygBoX+w@mail.gmail.com>
 <660f837f9e83a_50b8720828@john.notmuch>
In-Reply-To: <660f837f9e83a_50b8720828@john.notmuch>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Sat, 6 Apr 2024 00:08:22 +0200
Message-ID: <CAP01T75qSESitcoP8fCmHwZFrhxUUNa7qUDXrJ8r=ThTRKYOhw@mail.gmail.com>
Subject: Re: [Bug Report] Packet drops after trimming skb using bpf_skb_adjust_room
To: John Fastabend <john.fastabend@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Kashyap Sanidhya <sanidhya.kashyap@epfl.ch>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jakub Sitnicki <jakub@cloudflare.com>, 
	"rishabh.iyer@berkeley.edu" <rishabh.iyer@berkeley.edu>
Content-Type: text/plain; charset="UTF-8"

+ Fix email in Cc

On Fri, 5 Apr 2024 at 06:52, John Fastabend <john.fastabend@gmail.com> wrote:
>
> Kumar Kartikeya Dwivedi wrote:
> > Hello John,
> >
> > For background, I have a sk_skb program where for certain flows, a
> > subset of request handling logic (on Rx) that is typically done in
> > user space is handed over to a BPF program for doing it in-kernel.
> >
> > Since the protocol is over TCP, I'm using sk_skb programs to handle
> > these requests and generate responses from within the kernel. The user
> > space application will decide which flow should be added to the
> > sockmap on socket accept and then let it be handled in the kernel for
> > some of the request types.
> >
> > However, when generating replies and trimming away extra bytes in the
> > packet by using bpf_skb_adjust_room, I see packet drops because the
> > strp_msg->full_len is not updated unless tls_sw_has_ctx_rx is true for
> > the socket. Removing that condition makes everything work, but I am
> > not sure that is the right fix.
> >
> > My understanding so far is that in sk_psock_backlog,
> > sk_psock_handle_skb returns an error since the stm->full_len is not
> > correct (and passed into it as len), and SK_PSOCK_TX_ENABLED gets
> > cleared due to this error. Then, on the redirect side
> > (sk_psock_skb_redirect), it does sock_drop because the test for the
> > SK_PSOCK_TX_ENABLED flag fails, which does kfree_skb.
> >
> > I have attached a patch with a selftest (skb_adjust_room) that you can
> > run to verify the problem. It should basically hang on the second read
> > as the packet would be dropped by the kernel. The first read goes
> > through fine. Applying the diff below allows the selftest to pass.
> >
> > I am not familiar with the code to know whether the fix below is
> > correct, but it seems to resolve the problem for me (and I carried it
> > for a while and ran my stuff on it until I got around to reporting
> > this now).
> >
> > In case gmail screws up the formatting, I'm just removing the
> > tls_sw_has_ctx_rx(skb->sk) conditional on the strp_msg->full_len
> > update in sk_skb_adjust_room.
>
> I think your analysis is correct and patch looks good. I'll study
> a bit more tomorrow.  It looks like I just messed it up there and
> didn't consider the case of redirect in non-TLS case.

Great. Let me know your conclusion after you take a closer look, and I
can post the fix as an official patch with the selftest.
Thanks!


>
> Gmail did fine pushing code through.
>
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 524adf1fa6d0..e3009d0f3352 100644
> >
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -3622,11 +3622,7 @@ BPF_CALL_4(sk_skb_adjust_room, struct sk_buff
> > *, skb, s32, len_diff,
> >
> >                         return -ENOMEM;
> >
> >                 __skb_pull(skb, len_diff_abs);
> >
> >         }
> >
> > -       if (tls_sw_has_ctx_rx(skb->sk)) {
> > -               struct strp_msg *rxm = strp_msg(skb);
> > -
> > -               rxm->full_len += len_diff;
> > -       }
> > +       strp_msg(skb)->full_len += len_diff;
> >         return ret;
> >  }
> >
> > --
> >
> > Thanks!
>
>
