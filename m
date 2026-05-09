Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0688378838
	for <bpf@vger.kernel.org>; Sat,  9 May 2026 07:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778311118; cv=pass; b=fHMatCvybm172fKsNDxheLEil4G3vUjBSOyf7aDK2SfDeZ4xrdV1ApYAKPH+MojG6SKN9dDHWJKeH0Sy62S0op8aL39Rdc3pY5HnUJT5bOAXk8mCIBwb8I4Lo7BfNlWCEpobaET/V2/RVUtV18WucpED9ZRaNE04lRUC+YDgCOQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778311118; c=relaxed/simple;
	bh=pbICpdMRCZvZ50IHhxVma1ZkYUoOVniItWErjrjKK/w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iSGgB3j4XB7tktt+uAY0doPuzfefgGPlZ8b6txurNshGd8iFAL4GNtdlkMJ2I1+h7JQTz/Oh4A7OQM+VJGHKU4fKdmPEItRvBSSR+Lb4cIH75r4c7HWac2chwtg2vInCpm9shPyz2wB3GHfm/dcG4V72v2EyzZqcMLP9M86lzmM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mPd9L6Cs; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mPd9L6Cs"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5a0ff30b240so3856917e87.0
        for <bpf@vger.kernel.org>; Sat, 09 May 2026 00:18:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778311114; cv=none;
        d=google.com; s=arc-20240605;
        b=UksgLaOd+3DQez9m0tr1YA0vX1xX+644kjveijMkYxlIm+gFln6dXpLcgxA/je6ENT
         MGUxgUYHICiDIJLv09wjtjTUlKFdBPTfFDfdbg8htIotz9KqG3xUQBcuDeN70XHAB78a
         KnT8HxEkJ3lCUOfBR7XsAComo5Yq4mrGGrd5Jwex5G8SiAIkAu6mTtJ41Obeo8CFpDB8
         heCRa5e6X/O3OI4bHPO3rnuvCKVahmZx4b+hKEBwRieoc9UvaSrJGhlwvmY93lvQpg5R
         ZtbOl+mvr655Fq1W8tqUXOmLxVWxsfoJx5XQpv9UpT5MJXV+Su9ZTUeek2jEkcsUuJBV
         xDGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OGTzXJA9ES0mx7H989TSSSZHimLRqgQzpIBVyzdPw84=;
        fh=jfkxpjcSMiD4olrCPaTPmcnEZ6tUWAbAE6I3oHcqXAc=;
        b=e2P7MFVh4fVod27MP+JZFbb5LlGoDJqvuCCSqXU4bc9uYvBqUhXJSYsOgcQTLli6gc
         fop5gdHgBRd/OfPKSUlkUY/pguXnoQMLfbJKFtkfSl39QO4CUqeVTJv+4KT9SNtdMWZ0
         zEf3f0BgX0TNWA85WhdX+oGDD4RCXHKijnZFso+YwODyjk1dAAK93xzf3eb3rCAlnm/l
         JkI8MN3pwc2FqOLyPeoOQGNnpkGkvT617gWYNvRVTtTm2I3SQ7NuqAV5k2id56KjWZrp
         KKe2qinIxq8sJhHOXK7mOgqdgUuTD64yNk+NiyMMPPYV0TulVq1XolRSAcxKO+amM0ME
         AMTQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778311114; x=1778915914; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OGTzXJA9ES0mx7H989TSSSZHimLRqgQzpIBVyzdPw84=;
        b=mPd9L6CsCGyGRSbcNGVrlJ3sy+4xS9eySw2QE9TXc5X2AEZbEGMeqto0DHlcbVxkwU
         RamhYpmQE3/yKAId6wnO7PvPWtpEKoxIDkh+aYo6IIU2tS5zohzkfBFWYydswVHyI5aj
         g5zu1ngY7sxQhKqsLA4nqZIUIMB4mRI9qh58XYtQ5khWAjnTK0/lpL/9snwvDmkRV2YX
         Bm+5SLygw45vD2/HMgv9nXWe5jxFKOlza5anSvvjH4vASSZkAEeFpkP8aayikTPUPlKT
         3v9ryBCMH5zp/xkk+d2pFtnvSxqSlSDfKVyCq8FHbbwpAk5sSz22Sea+ms7hSKRPPeSj
         QycA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778311114; x=1778915914;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OGTzXJA9ES0mx7H989TSSSZHimLRqgQzpIBVyzdPw84=;
        b=TCQ8NjvYUHIpfMxWLWDlrm3BDJu/8YTvk66kz66qajoVBLOSj4CyJET65YFfzNdIen
         JFjTt1cW3fnGI8lNtoxIG2FFHTAysBEfXDbI+UkipSDfy86LAXHwbGTyv8ix/Ut5zslm
         mtlRW/TYM6uSRbabLix0J/kzPOu6qA7cd4swtd5ReycFNvdUz1Y/G9PWUMViD++emC2Y
         j5iG9YGPH81GvSD6VTzBUeI0KnE/luzUiNb1Se29mivgOg/8Gx0PSh9xiSaW9tko+XiL
         4ggFfWpQV/ICojOpqitMpTVCmuxK7F4TH9moX/vq01qUG/E7zbgJ5TEkvbjbOpbbTQNb
         k5bw==
X-Forwarded-Encrypted: i=1; AFNElJ9+U9wC9kRG0qYxslWOsfXXnTyIXw7kTJhCmjIpZopg2DoKxj/p4wccIRKJdcaNx7RqN/o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeEzIUvNo5MnR1x3MOvJx/Lbyz1UFe0gna4HLrBYgUtZ4RG/oI
	B/IZeyReNZ3Nblt1huqS3zBpzRCjVofONuNZ6UDWOuk9fUsjinqDeLbNv3m3KXo2MTwemsdUmBr
	JjDdZyTvpabLFNd8//VaaWVnx1iUKrmo=
X-Gm-Gg: Acq92OHvTk7WgmtWAAAMuA9GI2EZq79Tf+1d7j6J0vP6lpHFJfkxj2yLlB8CylB6L3R
	4K7hQtLyQajt96WnrGCNYvO0GNBv6cwb2nf5/FtOv5eH7HMiGxfg7rC5dHKmTm5w+ID5nigKki6
	WTAzlqzkf6OUqowrxCIULq3Dh7bHfTUNTtW0Z+FxLE9WNNQ2FODgns58h9WBeKQxrq8Ch2IcOUK
	pZaBrKiubkaApfjJEI3mzo9eXw4jjXvjtMNWdOSEtD16eKcs8fVbM29I7yvEUGVTfsTC1SFaXiq
	KSDSHJTf9blm7kNyNgWvGLdGWTt1bQiv8MkE47u3
X-Received: by 2002:a05:6512:3a88:b0:5a7:470c:daed with SMTP id
 2adb3069b0e04-5a8b6ca6e5bmr601388e87.16.1778311113737; Sat, 09 May 2026
 00:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260508144344.694-1-linpu5433@gmail.com>
In-Reply-To: <20260508144344.694-1-linpu5433@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sat, 9 May 2026 15:17:55 +0800
X-Gm-Features: AVHnY4JlMp6MnmwMwsLAGRRLfDaSg7w4dUAGrqXeTvNSXYdNN12sv-gwcBYGaKw
Message-ID: <CAL+tcoD4QARiHjwyW4RPBAQT-XmnLPPnathHfTSz6Uy2qJcAVQ@mail.gmail.com>
Subject: Re: [PATCH bpf v4] xskmap: reject TX-only AF_XDP sockets
To: Linpu Yu <linpu5433@gmail.com>
Cc: magnus.karlsson@intel.com, maciej.fijalkowski@intel.com, 
	netdev@vger.kernel.org, bpf@vger.kernel.org, sdf@fomichev.me, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org, 
	john.fastabend@gmail.com, bjorn@kernel.org, linux-kernel@vger.kernel.org, 
	tanyuan98@outlook.com, yifanwucs@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 8, 2026 at 10:43=E2=80=AFPM Linpu Yu <linpu5433@gmail.com> wrot=
e:
>
> XSKMAP entries are used as redirect targets for incoming XDP frames.
> A TX-only AF_XDP socket lacks an Rx ring and cannot handle redirected
> traffic, but xsk_map_update_elem() currently allows such sockets to
> be inserted into the map.
>
> Redirecting packets to such a socket on the veth generic-XDP path
> causes a kernel crash in xsk_generic_rcv().
>
> This became possible after xsk_is_setup_for_bpf_map() was removed from
> the XSKMAP update path, which allowed bound TX-only sockets to be
> inserted into the map.
>
> Reject TX-only sockets during XSKMAP updates to avoid the crash.
> They remain fully operational for pure Tx purposes outside XSKMAP.
>
> Fixes: 968be23ceaca ("xsk: Fix possible segfault at xskmap entry insertio=
n")
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Reported-by: Yuan Tan <yuantan098@gmail.com>
> Reported-by: Xin Liu <bird@lzu.edu.cn>
> Signed-off-by: Yifan Wu <yifanwucs@gmail.com>
> Signed-off-by: Linpu Yu <linpu5433@gmail.com>

Even though AI suggested using EOPNOTSUPP instead, prior to this
thread, I pointed out ENOBUFS makes more sense because it is identical
to how xsk_recvmsg() detects the failure of the rx ring. If needed, we
can cook a follow-up patch to replace that in __xsk_recvmsg().

It looks good to me:
Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks,
Jason

> ---
> Changes in v4:
> - retarget the patch from bpf-next to bpf
> - resend after no feedback
>
>  net/xdp/xskmap.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/xdp/xskmap.c b/net/xdp/xskmap.c
> index afa457506274..3bff346308d0 100644
> --- a/net/xdp/xskmap.c
> +++ b/net/xdp/xskmap.c
> @@ -184,6 +184,10 @@ static long xsk_map_update_elem(struct bpf_map *map,=
 void *key, void *value,
>         }
>
>         xs =3D (struct xdp_sock *)sock->sk;
> +       if (!READ_ONCE(xs->rx)) {
> +               sockfd_put(sock);
> +               return -ENOBUFS;
> +       }
>
>         map_entry =3D &m->xsk_map[i];
>         node =3D xsk_map_node_alloc(m, map_entry);
> --
> 2.54.0
