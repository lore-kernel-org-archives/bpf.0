Received: from mail-yx1-f68.google.com (mail-yx1-f68.google.com [74.125.224.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466083F0751
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 12:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781697622; cv=pass; b=ubm+r+kyqLj2GCzb3TsHge/iV9sAk0VqvBEYtKhdJ+EAyUXjzkTDWBZ53ZklRxTBA/IPfqTfzjr032e/wauhS474lDJfwpQYt96VktK/HjlbtJVbq/h6eXqiYglINIrlfPkWn8q1af/Wslsm1JPlGdu7cZCJTM8/Ogn2XSyz3MM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781697622; c=relaxed/simple;
	bh=9ymoeEPidKfzkZONuR4B16ek9eOD8FYaVaAsgJjxHfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XiO7UE5EKEaXk7mLoSptvc13NNGOgtCkvU34Ldoo+Lsbhl3voi9s0qPjwqM58rv0eEllmacl+QqHFgTBIXg44rjvwY4BvBqp3vSCGu+ljgsXubyqptroPOMJ675Z9qyltf3qkc2XwGPiAHg3UthAAhP2ydLP5Xxu90YCJk6kqtg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fKKasQGQ; arc=pass smtp.client-ip=74.125.224.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fKKasQGQ"
Received: by mail-yx1-f68.google.com with SMTP id 956f58d0204a3-660512d80b4so1065051d50.1
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 05:00:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781697618; cv=none;
        d=google.com; s=arc-20240605;
        b=dgj0/92M7IEcE5mhJwbu8xnkscaLl04wTBO/E4ZTv+08u5T+v6z480dGh15G2FzTew
         2Wd4mA/68jV0sTVJa8FPEn2GH5WBKjxuhuGr9F0RZCklkzJ1V2WXstP43C16yTUuLfjw
         2NoqSLmYMPJdqgaS0+VqhycrRL1DXVNzEvXDibRf3tpYaoXpULXefTft81VDy3uCRwIz
         lFPe1p32o3c+8siBaH0hzf0jnnjwedIl7P2GTW93U0b8IqaeJ21usfC47XlzRjZ8NTcJ
         UQRGCs1Fm0Wuh5qhiVDRFsT0CstTIT921IWLLSt/7Qzc5GHjuGf0Wll+wQNnEp504bKS
         ZovA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ymoeEPidKfzkZONuR4B16ek9eOD8FYaVaAsgJjxHfc=;
        fh=EvvwhkXYzdSjFibnMsr+0ei5uyYGaJ3ZHKo9b54o4Mw=;
        b=iiMjEaJQNs6g62jMGWnPy7uteBW5zxsRogCnL3apYCPGVTIGzNbNmxOXt/uVCRf3k9
         DqtUPY7vnc+VsjYOcaboN94QNEnkdWT6522qVh3/3dLSLGixtRPWC/MmKuz1RacDDHPP
         Re5NhBdq3TZ9A0ndBga2d+EoXDga/aVSk4jxzPgQe4wNzv8iiqddqPkB3G/DzsIbY2fV
         MZwAOGTxE3fFcU98LIFFS0H492Y5Ei3xvS/KSCltiZqIk1VLC4qzY4D0GIIF3nRgIcnc
         pm+OXWjZhSZgEzjFeIQzCtwoqQhIcpzhopHONjLmzQMW3F9iUVD6ITn7asRvYcUFr5zL
         hDJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781697618; x=1782302418; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ymoeEPidKfzkZONuR4B16ek9eOD8FYaVaAsgJjxHfc=;
        b=fKKasQGQAyaUMtkjvtNnqJDg9XHwD33ASWPqISkI9Esv/eA2Gfvz+JNuom6/vOcjRf
         n/NVyDLmeYTL4KS8qJ3lJmUzD3fqbUtWTMdRqxU2WbvFIdo6LDZ+IcpHNcM4eomL9uu0
         8XwgcQVzDij2C5iwve8JJ5h7BAlBkhPDCYohbUo7NHSWxt6bCfIN9+uz+aBTWILmcLYB
         lF5Ebe4G6pvBII6qp+ev8Wq8UKJZZCwwMeoLjvFFUNsD9qRj0PT+ijS83ooEkl3McGSk
         b8rrq0ACFdIXJdGB45s6vnrpJJrjN8bD/lgx5/gQd/t7yogsk4kH/DJ9icypPn8Ib9Wq
         UAcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781697618; x=1782302418;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ymoeEPidKfzkZONuR4B16ek9eOD8FYaVaAsgJjxHfc=;
        b=YeeVs8d5zxgkkIRhPdkKjv/dH2cupHmSUaiBoK3yeb5tcxBdxYkX1Ji4xGLdstExCK
         lcnV82frnnkARA6Y97EEe9QJKVly2eBaqPlkhfwiDmhLVC1Hoj6u4+/s4JbBpD+ROI7m
         jcruAQ+K9AeHEhRdjwxCFo+01x0wu/UxknyKrEe/DsuHB9B0DQ9JhjAVYH0z6K8HUaZU
         sM5Dfv4qaGw2OJSE7FQJ32LnGx62mp1mvHR8gQ4ULCQWTfb73S6RTudS3wsXf0bJlCUc
         PfyXQe4SmG3kwtg3NBPxk20hbm3vNOxfnI4IPIZa5ft9lVgM/oBwvLJAdC0mQZacvxx+
         BYKg==
X-Forwarded-Encrypted: i=1; AFNElJ/FipLh3lvksmDYAN6mJpSE9lWYLBfabP/6t12FdyfilORKJ2BXPz4Htqub4HUqp8iFudU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsQUPJMischR6bfjzFRYb2JcnFJUPSptOP5I+RqTa5wwbpl1zf
	4BNDZrma1ymuQUc4f7pWFN6s/Gh21Ba3uAbHfJNXRiaeZ4IBGKxUnn9tQzxsAlKVpChPqv+eSjn
	pmg7pY2VWRzaCelSvjmnBwUNr9Bm5Btw=
X-Gm-Gg: AfdE7cl9UdWFUJ/fCw7vSBo0WqX72t0fTKAn6YJQnCQveSKjo1jObMVQ3FO/9hgj3CI
	2TDAhoI5hBX44tpVtTTPbw8VmN6TkBG/zOjGPMTwfbtvXImS6o+0lmVSnccCMKish98HCqiHTd4
	no/eU3oO2y81xT6fI3hDHIN8f+H7A+loRq0LUN/rUgf93UpTjd+qCPqtzyxin3oc6wSywleDvtT
	KwuEj2sZvE71xlQVAp3SH7goLXuUKZzS+Yb48DTK/fGWTjzYEzwvdG5oH6fxzFaL2yzz/mVjNw=
X-Received: by 2002:a05:690e:1306:b0:654:3fca:3515 with SMTP id
 956f58d0204a3-662ced30a5dmr1739473d50.30.1781697617856; Wed, 17 Jun 2026
 05:00:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611071242.2485058-1-dongml2@chinatelecom.cn>
 <20260611071242.2485058-2-dongml2@chinatelecom.cn> <20260613112113.55d9313f@kernel.org>
 <TYn10tJ2SIGF1pAhF26DRQ@linux.dev> <ajJrckiXEUztBQDz@boxer>
In-Reply-To: <ajJrckiXEUztBQDz@boxer>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Wed, 17 Jun 2026 20:00:06 +0800
X-Gm-Features: AVVi8CceZgHFM8mfvFHKtEXFCMHWNlKB0MljWDwvRAc_BYBHABk8LGbFC_ALR_Q
Message-ID: <CADxym3aXnGwna-TKQmJ24UD1XNmq3hsapRQXQtwKF=YC-qqrOA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/3] net: busy-poll: introduce sk_tx_busy_loop()
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Menglong Dong <menglong.dong@linux.dev>, Jakub Kicinski <kuba@kernel.org>, jasowang@redhat.com, 
	mst@redhat.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, magnus.karlsson@intel.com, sdf@fomichev.me, 
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bjorn@kernel.org, kerneljasonxing@gmail.com, 
	netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 5:40=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Sun, Jun 14, 2026 at 06:12:46PM +0800, Menglong Dong wrote:
> > On 2026/6/14 02:21, Jakub Kicinski wrote:
> > > On Thu, 11 Jun 2026 15:12:40 +0800 menglong8.dong@gmail.com wrote:
[...]
> >
> > I'm not sure if it is a good idea to introduce the sk_tx_busy_loop().
> > Maybe we can modify the driver instead by using the same NAPI
> > for both data sending and receiving, just like others do. The
> > advantage of introduce sk_tx_busy_loop() is that we can split the
> > data sending and receiving, which maybe more efficient.
>
> Would be good if you back your changes by any performance numbers. I
> believe that drivers do tx processing via rx napi as before AF_XDP it was
> only about cleaning up writebacks, AF_XDP added more weight via actual tx
> descriptors submission.
>
> Maybe you can vibe-code virtio-net to work only with rx napi and see what
> are the results.

Hi, Maciej. I have not done such performance testing yet. It's a good
and interesting
idea to do such testing on viriot-net, and I'll do it. If there is no obvio=
us
performance differences, I'll modify virtio-net by sending data via rx napi
instead.

>
> Side note/question - Do you have a tx-only use case for AF_XDP ? I am
> planning (for a long time actually) to implement asymmetric AF_XDP
> sockets. Currently for ZC scenarios xsk socket occupies both rx and tx
> queues even when you do rx or tx only.

I think this is an interesting idea, and will be helpful in some cases.
I'm improving the performance of MySQL with AF_XDP. For this case,
tx-only is not suitable, as data reading and writing are both needed.

But for the other case, such as Redis, data reading is mostly. And in
this case, I think it's a good idea to use such "tx-only" ZC AF_XDP.

In my case, I don't want to occupy the whole NIC or the whole queue
with AF_XDP, and the other users can use the NIC too. However, the
ZC of AF_XDP has a little additional overhead to the skb in rx path,
as there is an extra data copy.

If such "tx-only" ZC is supported, the performance of AF_XDP is still
good in the read mostly case, and doesn't have additional overhead to
others too.

I haven't used AF_XDP for such a "reading mostly" case yet, so I'm not
sure if I'm right ;)

Thanks!
Menglong Dong

>
> >
> > >
> > > Third, this series does not apply.
> >
> > Ah, I'll rebase this series if a V2 is acceptable.
> >
> > Thanks!
> > Menglong Dong
> >
> > >
> > >
> >
> >
> >
> >
