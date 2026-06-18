Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4F0333440
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 19:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781809245; cv=none; b=i9NCpQ2ETSB4cO4vK0UlNPr7cy8dOcBZGExhRgOw8EpmxIAW3AIEuiqr3tt+LfKBlPa7H//4NM7s4jYiJQ4r1SrhQ/ou+biTsVkt29Y29zEn7cJ6VxOdUWK4C6NAle0UNyOn7R3IwU+3oi9Rap2Ik65Xp9lyWZH9QM0+Uo04G74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781809245; c=relaxed/simple;
	bh=8kJMz9LKQ/8hfHjif49visLmKVnF4eIjhO0ToUzckXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PUfkHVNfAUqDTwSl9co8BdnFDybCZYDihZi6JJRVSqAHWFmboxe9CXfDCsMgKoqAEEbFrsQx1D/OKMXPaOG7tn3Ra9AMtRDHOlhJOz5S2yc3vkTVAfW1Lv4QTvLxJZdtSv2vPI77X3aEEn6R+VaX/+uBx50fDpn5OnYWOFyI5y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MFKNZsJG; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MFKNZsJG"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-37ce68a54f8so803800a91.0
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 12:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781809243; x=1782414043; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KZJIVkKgNSYCGOK4bX9+88PTNdyEosGt30DWnvoVWjY=;
        b=MFKNZsJGybN51u5DlLE3vuL/c+ZASTuwQ8136Wh7+E648ocRlI9D91DTdsuiTrhVYr
         3FxYFqxZhNebkQggoHO6yNw7/2krANRroyNy1Z7peuTTVQYe7yeRDyucuxfRbzEaADMM
         qALQKFKCDK6T+uDuocjggyLSfjj94Etl14EvJJHX2LAs+jR8aCTE7oiyNmCCjKfONBfy
         sRzXc0aw8JIfWf8BgwJMbDiNHN+W9J8AL1tFC950NJ+FLgSPOlhsBXrPGtiHiNmgrbMF
         sMz8NKBEbnBdHW5+KF2DRp8pFgmemEcjRrNTCDWxVHyheBdY2lAWWIjV7QDlE/83Y+ke
         +XeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781809243; x=1782414043;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KZJIVkKgNSYCGOK4bX9+88PTNdyEosGt30DWnvoVWjY=;
        b=iXa5nTh16Gf0cYRIKDfMkelILx2tgSpJz4P4z232t50EE0MZUr6STHyrLyFkRKxsZI
         dCeg+OTZt2yr1PjimsZJ5dW10L+mBoB65yNCVv4rd4E9PzIatQIR9XEB+HQT7wUbBcm+
         KCdUS1K3Y5AhJ6mRQrhSw0L6Qh/eZYUA5lHEvdoZ6iV/llXWDXIdn0jK/xfRSfBHKGSu
         KQyWhVLIkPNoEJfp3Du1JHYtSsWoXb9Y78yQ3N4TjItuguoO4D02kWcvnvC5mik635Ki
         Vjoxw943jMWLXxv0rup7kYB09OPYbWHctLZH/Y+XuCztKvZHJw6a22jCT6oW1DlXnnqu
         vLtA==
X-Forwarded-Encrypted: i=1; AFNElJ+v+2IMQrJUieKR6cCE/KaRsvwVuaKEheD6yZxdugyiPumykk3fmD4uI1HwEhVRTcDYCdk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbmpXJqTkO8l3lWrDnjr7f/uIPvmXU+THlSyTDsxdMf+P5dFjV
	BPG6/Sfell5TNX00R47WwEBwm42Q88k9fjVr+2ppdX/0EZaowsIl7HpL
X-Gm-Gg: AfdE7ckjLFCjsQ7AB80cZZ+/xdXIBmLyd30WVakY5bFNYiFhwpwNpsIrlWX42ofQ4lk
	YYacOW3CgzURHI84XqL96micxLl6CgItSaO1XCDGAWwD+crOoPc46lnThxZIyH8HERluwLCj+Kt
	rakxmPqWtVy13wBV4ktr3uSTIBBqzP+4PvDWH3Y0/MHCY6TjawB4tK/8JFB2VTuiA52WWDfWHun
	8Ry7rsPR0F69KcqyuKkucfJYE/3VrwxfmSFqQYDiXD0sSLJ1HDO3hmbg1D/CVuxNPhEez14x/FO
	qIJLslEq1esdRtPj4PRhUL7Wmx6q6sFtn4NVr+qB2p4kv3x6zdOSahDKjPFP6KuaWSzLLTpwd1b
	uxXhASkTH9O3LyBya1ZmfljpCBW+RrZ1u4pqqyt8dznxTuVgyXwn+5mptZPzV651SbPgc3cv2pa
	HJuwo2kFZoTQ==
X-Received: by 2002:a17:90b:5103:b0:369:2e00:1ff0 with SMTP id 98e67ed59e1d1-37d15e170e3mr781639a91.6.1781809242899;
        Thu, 18 Jun 2026 12:00:42 -0700 (PDT)
Received: from john-p8 ([98.97.43.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d1aa48f04sm25097a91.2.2026.06.18.12.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 12:00:42 -0700 (PDT)
Date: Thu, 18 Jun 2026 12:00:40 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Liu Jian <liujian56@huawei.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Cong Wang <cwang@multikernel.io>, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf, sockmap: fix BUG_ON in skb_to_sgvec() on a
 resized ingress skb
Message-ID: <ajQ9YXj216btyriM@john-p8>
References: <20260613082442.3252576-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260613082442.3252576-1-rhkrqnwk98@gmail.com>

On Sat, Jun 13, 2026 at 08:24:31AM +0000, Sechang Lim wrote:
>sk_psock_skb_ingress_enqueue() maps a received message into a scatterlist
>with skb_to_sgvec(skb, sg, off, len). On the SK_SKB strparser path off and
>len come from the message's strp_msg (stm->offset and stm->full_len), set
>by the stream parser. strparser does not trim the skb, so normally
>skb->len - off >= full_len and len is within the skb.
>
>An SK_SKB verdict (or parser) program may call bpf_skb_change_tail() and
>shrink the skb after full_len was recorded. len then covers more bytes than
>the skb holds, __skb_to_sgvec() walks past the data and trips BUG_ON(len):

FWIW this only happens if the strparser program is also attached. If 
there is no strparser program stm->offset = 0 and stm->full_len will be 
whatever the verdict program set. So there we would get

   len = skb->len; // then if it shrinks to skb->len - X its ok.
   off = 0;


>
>  kernel BUG at net/core/skbuff.c:5286!
>  RIP: 0010:__skb_to_sgvec+0x78c/0x790
>  Call Trace:
>   <IRQ>
>   skb_to_sgvec+0x32/0x90
>   sk_psock_skb_ingress_enqueue+0x42/0x370
>   sk_psock_skb_ingress_self+0x1a8/0x200
>   sk_psock_verdict_apply+0x33c/0x360
>   sk_psock_strp_read+0x24a/0x370
>   __strp_recv+0x66d/0xda0
>   __tcp_read_sock+0x13d/0x590
>   tcp_bpf_strp_read_sock+0x195/0x320
>   strp_data_ready+0x267/0x340
>   sk_psock_strp_data_ready+0x1ce/0x350
>   tcp_data_queue+0x1364/0x2fd0
>   </IRQ>
>
>Clamp len to skb->len - off, and drop the message if off is already past
>the skb. sk_psock_skb_ingress_enqueue() is the only skb_to_sgvec() caller
>and both ingress paths (verdict SK_PASS and the backlog worker) reach it.
>The clamp is a no-op unless the skb was shrunk.
>
>Fixes: 7303524e04af ("skmsg: Lose offset info in sk_psock_skb_ingress")
>Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
>---
> net/core/skmsg.c | 4 ++++
> 1 file changed, 4 insertions(+)
>
>diff --git a/net/core/skmsg.c b/net/core/skmsg.c
>index e1850caf1a71..2961178ebd1e 100644
>--- a/net/core/skmsg.c
>+++ b/net/core/skmsg.c
>@@ -550,6 +550,10 @@ static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
> {
> 	int num_sge, copied;
>
>+	if (off >= skb->len)
>+		return -EINVAL;
>+	len = min_t(u32, len, skb->len - off);
>+

This is blocking the BUG but will break the socket. We should fix
at the cause. Something like this untested... although I've never
used the strparser program in any of our cases.

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 2521b643fa05..95347f9d140c 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -542,6 +542,20 @@ static struct sk_msg *sk_psock_create_ingress_msg(struct sock *sk,
         return alloc_sk_msg(GFP_KERNEL);
  }

+static bool sk_psock_skb_strp_range(struct sk_buff *skb, u32 *off, u32 *len)
+{
+       struct strp_msg *stm = strp_msg(skb);
+
+       *off = stm->offset;
+       if (unlikely(*off >= skb->len)) {
+               *len = 0;
+               return false;
+       }
+
+       *len = min_t(u32, stm->full_len, skb->len - *off);
+       return *len;
+}
+
  static int sk_psock_skb_ingress_enqueue(struct sk_buff *skb,
                                         u32 off, u32 len,
                                         struct sk_psock *psock,
@@ -696,12 +710,8 @@ static void sk_psock_backlog(struct work_struct *work)
         while ((skb = skb_peek(&psock->ingress_skb))) {
                 len = skb->len;
                 off = 0;
-               if (skb_bpf_strparser(skb)) {
-                       struct strp_msg *stm = strp_msg(skb);
-
-                       off = stm->offset;
-                       len = stm->full_len;
-               }
+               if (skb_bpf_strparser(skb))
+                       sk_psock_skb_strp_range(skb, &off, &len);

                 /* Resume processing from previous partial state */
                 if (unlikely(state->len)) {
@@ -709,6 +719,9 @@ static void sk_psock_backlog(struct work_struct *work)
                         off = state->off;
                 }

+               if (unlikely(!len))
+                       goto out_free_skb;
+
                 ingress = skb_bpf_ingress(skb);
                 skb_bpf_redirect_clear(skb);
                 do {
@@ -737,7 +750,8 @@ static void sk_psock_backlog(struct work_struct *work)
                         len -= ret;
                 } while (len);

-               /* The entire skb sent, clear state */
+out_free_skb:
+               /* The skb has been handled, clear state. */
                 sk_psock_skb_state(psock, state, 0, 0);
                 skb = skb_dequeue(&psock->ingress_skb);
                 kfree_skb(skb);
@@ -1020,10 +1034,10 @@ static int sk_psock_verdict_apply(struct sk_psock *psock, struct sk_buff *skb,
                         len = skb->len;
                         off = 0;
                         if (skb_bpf_strparser(skb)) {
-                               struct strp_msg *stm = strp_msg(skb);
-
-                               off = stm->offset;
-                               len = stm->full_len;
+                               if (unlikely(!sk_psock_skb_strp_range(skb, &off, &len))) {
+                                       err = 0;
+                                       goto out_free;
+                               }
                         }
                         err = sk_psock_skb_ingress_self(psock, skb, off, len, false);
		}
