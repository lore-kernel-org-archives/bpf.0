Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com [209.85.210.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2943314C4
	for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 16:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776702430; cv=none; b=DND+yte0gCggqE8K/CCuBVubfmHgNmyvrNGREqU/2Y1e5T97bLkNIi5rQRqjOrCVuIUnXbB8zMuyN7QmSw9oVFn5IMGeBy3GzMh3AQkKFFrfN+YlFL4xSnENrnD2ghXuOtmGlYHLZ+y41noIWbT7FsdnrcHIP0faKLBOsfsZBy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776702430; c=relaxed/simple;
	bh=dY4fqKECo7eqADZphbJATvq9E4FnAFlZU510YDrjeE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va4jrVkYI/jbrApYYI+Bnhq44lghnKuGTkH7ACv6rkiRKbWlKlfwKXpjtqeXvdurE5EFjpVT4SIzRUhUiINFAZmy2BzT+ncob+TAPE9XSggxlkBjSNgxbTKCwu5g7rg3QVnkAOFXh9dq1h9JA9+fbuJ7p3WOCXzNQcKlzqA/opw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sE1n2UzV; arc=none smtp.client-ip=209.85.210.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sE1n2UzV"
Received: by mail-ot1-f68.google.com with SMTP id 46e09a7af769-7dbe437b072so1904441a34.2
        for <bpf@vger.kernel.org>; Mon, 20 Apr 2026 09:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776702428; x=1777307228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cx+Z1b8A20YiWzWJo1QqCE8ssM1GtNYptzqBgdgASec=;
        b=sE1n2UzV4f1t/MddfTc8ZVAtW4sVbeXbdJuYBQLhafPzquSAALqD1ITPLEQgTCPX0Y
         31wFYAeQ5WLnZ+zStrs8KFhRDHXRNzwdb1CyXPNPWxtHI0Zfw6f2Wk0SKuk6NgdFdt/n
         r7Y4IT8joLxE63ZmH16QRcjvEzSbyjKcYA2qNkFeWs/rcU7I/AWow8B9SmpEB3r6sqK4
         lpJ6n68ANOtTjLiP9azLXA3LnHtHTItF+Pdm8c9Esy6h7ZFUn8FU08S/R1RSIu3zZnRk
         4IgooCyU0kSm/Midl7PiQfU5Xzye1uNnmRyQnKa90qAs2wgeIYmWoi7W/oc+jxOrHXQ4
         4nPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776702428; x=1777307228;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cx+Z1b8A20YiWzWJo1QqCE8ssM1GtNYptzqBgdgASec=;
        b=Bc1VNtWJNlxFPP5vI8nZsna2/E+mULtitbYb2kv8zXSGmbZ13PQQej1bIuhI4yn254
         XdRKHmshLWXGJztuzlslWvUmPeMxvHKY+ovGnwfCJizuvQOcWTTW3iyl08IlNTpiG417
         y9K/T8vrEAAXE5yxFiJ1lnEJVczCchXBgjxyBbwJt/d2QYuXIK4ac8yQxjnse3m+zADy
         jZO48NLspYzOqXIF3qIbDTVgbPpuJig1PFLuipMpQDOP7z2LuTAE3l9FUa2ods9rwqpj
         P1La+uc8QYQVBNARD1sxChHmI/45bQOSn7TSQAQtYmGhp0cqvlX/agEUmXChbg1Ejmvn
         Uy/g==
X-Forwarded-Encrypted: i=1; AFNElJ/3mCgKlOoIja24Bsc9fvwEPhVycrIicQq2jfk2QZhkcvUFdeSuDabIXipFexgdmcOAoxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxcbucz46cZfw+U9ic0EvbJuljHim1ebWfO9JgbxnfqjXTM3FKz
	SWN09eH9hPe2PyP5LamnrYjc6yKioseRe4v3mjIGhTBmZbHVSFhErAKd
X-Gm-Gg: AeBDiet7lw6dRTtm+PGdwR7+h/yyri5UEm9N5ZMFMmysZXcdZWTwx+8BSMt0Rb+Upj5
	qWLd24OjPzz4UANrjankpFtDtxKmMOLKpZ8pwxQt8BCB689kx4zOtSrbhPCqTg1/3Jd/L0oJTVd
	mp7elvVXIuRiV15XdUka5pzVj3b74UKrbMtM6GIQSMxb9yBPrqLXxtbauVpdRHQVH9gZblQrUuh
	Rod0ulF766LGxDv8yZw5G/n7prMgO9B0QpAdW6dijVUTJD81c22OFe9XoF9omoIAVZHSs+J8G1e
	aGA9mN3j8Nl8lsmqLgL39QjIaLuiGiCBUPTV6Kokf0jLOMxWv/R06o03VD8ByjVv4Uh+Ku54auo
	8VGsj7gbxSPpc27JxLN7ACJ1fIyKAm2x15WRO8VW9+au1kwe6arY5zO3a2LgKedmY6BO6EVjuH1
	G7tVFR5rBFYA9D0iuBxEOs7GTAsXXf
X-Received: by 2002:a05:6820:f021:b0:683:1323:e183 with SMTP id 006d021491bc7-69462ee4226mr7718815eaf.32.1776702428293;
        Mon, 20 Apr 2026 09:27:08 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:41::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69464fe6d3esm6031932eaf.14.2026.04.20.09.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 09:27:07 -0700 (PDT)
Date: Mon, 20 Apr 2026 09:27:05 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, horms@kernel.org, 
	andrew+netdev@lunn.ch, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net 1/4] xsk: avoid skb leak in XDP_TX_METADATA case
Message-ID: <aeZTxgvr0mdIG-lK@devvm17672.vll0.facebook.com>
References: <20260418045644.28612-1-kerneljasonxing@gmail.com>
 <20260418045644.28612-2-kerneljasonxing@gmail.com>
 <aeZEjZSsVIdpcbFF@devvm17672.vll0.facebook.com>
 <aeZI3ig6w0PhGaVU@devvm17672.vll0.facebook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aeZI3ig6w0PhGaVU@devvm17672.vll0.facebook.com>

On 04/20, Stanislav Fomichev wrote:
> On 04/20, Stanislav Fomichev wrote:
> > On 04/18, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > > 
> > > Fix it by explicitly adding kfree_skb() before returning back to its
> > > caller.
> > > 
> > > How to reproduce it in virtio_net:
> > > 1. the current skb is the first one (which means no frag and xs->skb is
> > >    NULL) and users enable metadata feature.
> > > 2. xsk_skb_metadata() returns a error code.
> > > 3. the caller xsk_build_skb() clears skb by using 'skb = NULL;'.
> > > 4. there is no chance to free this skb anymore.
> > > 
> > > Closes: https://lore.kernel.org/all/20260415085204.3F87AC19424@smtp.kernel.org/
> > > Fixes: 30c3055f9c0d ("xsk: wrap generic metadata handling onto separate function")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > 
> > Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> 
> Actually, I take that back.. While looking at patch 2 (which always
> confuses me with that -EOVERFLOW handling), looks like we set
> skb->destructor in xsk_skb_init_misc? So this kfree will do
> xsk_cq_submit_addr_locked? Not sure that's what we want? Should we
> move xsk_skb_init_misc to happen after xsk_skb_metadata?

Ooops, looks like you already addressed these in v2? Let me look into
that..
