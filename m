Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185E14A3419
	for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 16:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781713743; cv=none; b=E1FQA3Dkyw/gddfd9/gBWLxcV5ymC7Hs9vfknFsSgvj6vSxy1FLAJDJ5O1dFt1D1LCCxmd+jZ6kHXVRLaWVVO3c5XFbdWf/fYXc+2C1/TI3dT6a8JuAS2oFonh62W6+Xhnnr/uwyfqsonBrlGNP/4jqgcVuS0dI5Hg2M51LT/jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781713743; c=relaxed/simple;
	bh=2qk16IwOYT09Fse5cOKXXhlbtV/cCk6ZuBKHYKF4l54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iIFQQp/3n5CJbJsh4gZjJ6uUtM5zJ/aJmHCTIzHlGbjLEYSOoQOp0ZNPUa69YXgTWRf67AC9IbqD84axEQd/0C7Ed1G5oRGKVWXjc1w2zcuo9awqRzOuesbvjCyqQQ6o7yZJU+YuNjZ19UGh09MCLdkKPoSGQi0Sv/DSLc4dZLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YiolgDAf; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YiolgDAf"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-36dac5d5d05so3040115a91.2
        for <bpf@vger.kernel.org>; Wed, 17 Jun 2026 09:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781713738; x=1782318538; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=08V/TQ5VQXcHsQcXFJnBRANkcnWE7ncb/OpXpWrkpKY=;
        b=YiolgDAfnHh1GGATpUd2yBY/SrcM+QS2ECTk8bAlV+I9jaJseJ9f7rRz62F6z0I05Y
         B9oAkWWqHRp5xNOHfjnX/wTgO2Cpb/Bagn7oxGHFKAbYoc9I2DualEQM5ofhkMaOVe1A
         3jNkinT+YJLCGCHKceKqvGYxCQaJM0iqCW2mAb7UhNMjet9sIeto+AayYJfYNWBKl9gn
         njbKqmiFOhhs5DyduIxDFQ23kYKdGziOFOzM1MCc2Ou/+15n24TOHnNd+KMO7N1PqUmo
         5vPCRtK+5wKj5+X1myFO2JkC4/ZNBXwSZTt5jPBjrRTWFkOHCpFFAIUGkAT6RmeA84Du
         FImQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781713738; x=1782318538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08V/TQ5VQXcHsQcXFJnBRANkcnWE7ncb/OpXpWrkpKY=;
        b=PYiXWqh0T/9ABs3eO+Dri00fO7lMNbhqOadNNBNVDfs57HI2amngKVT47BgWPlmHFh
         4W3bndWLWl3UWDS8yavGp8X0UWW5ZBCkWSyUaIHGhw5yWyth2nIH7puYIrBkcnISLbnv
         +RlzRcUO8LFji6D5saK4UXrPBI2aSivnG2a3tIkbnfQe8wXJOu+v9VG5DhjljP+bZ0A4
         xzwEums1J0brs4F9lRNGNbweOTXPEizEIMOHebkfNpTu66aI3QtvQHDPfnK9RpOEXjiL
         lEq6adg5HObtVKowqGMRxVEaUuUTt8eQL2lEjB5pJRQY24QsTPBBmN67z64pf7o9jb+4
         tBjA==
X-Gm-Message-State: AOJu0YyZ/iufy+jpBOzj+DXKg1B981RON0ArisLlQmEHCA2kq+HYmTB8
	h8fSvUDXAsHDM1AMrsEfMDscq6jELCWYNRDcN0+sdifcxXpfj5U+dQIpca77Pw==
X-Gm-Gg: AfdE7cku7UXFWbQm/ev7U5Qtpn+XdV2K+wbtnsrzi5emQ8+/52bRvgl2ljnlW0SdWB+
	dbdpgfCSL73rM+2R0DxscXZKW1f0QVGHfVLPOrB5zOiHtzhwXP6CaB//vtNOgau5g6A234Q6eVc
	TzxVbIGloX0uj7gYUA4oz8ylTsvS9kIinXYlmt5O+p4Ph7tu01eT5vWeYuIIT2DOgWqm/WrB1Jw
	VrtXrShHjhF7WRijNMy6D8Ounp48CIGf/D9FuRB/8copgiLEyLkaDBAXsRL9zVJ9aMjEMuMzmUr
	rzs3H6IWlLFwtdMY5Sm0B2vorEW3/fAsfXCIX0aIrnJRnQY59q4pExZ2Tw55olxf+P4ukiZbW+g
	E2tPqzjji32wkxRDewZsijk0YpzHa+CjwwK/oGer8l8nv16KtTbggWZJFd7DJ7/qfS2C2zm74+/
	N7fzTFBM2SyQ==
X-Received: by 2002:a17:90b:5107:b0:36c:e254:4db with SMTP id 98e67ed59e1d1-37c93319ab1mr4568357a91.6.1781713738198;
        Wed, 17 Jun 2026 09:28:58 -0700 (PDT)
Received: from john-p8 ([98.97.43.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521ca980sm6741230a91.6.2026.06.17.09.28.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 09:28:57 -0700 (PDT)
Date: Wed, 17 Jun 2026 09:28:56 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 2/6] bpf, sockmap: Fix wrong rsge offset in
 bpf_msg_push_data()
Message-ID: <ajLLL6xN4oAUBSEi@john-p8>
References: <20260615021959.140010-1-jiayuan.chen@linux.dev>
 <20260615021959.140010-3-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260615021959.140010-3-jiayuan.chen@linux.dev>

On Mon, Jun 15, 2026 at 10:19:55AM +0800, Jiayuan Chen wrote:
>From: Weiming Shi <bestswngs@gmail.com>
>
>When bpf_msg_push_data() splits a scatterlist element into head and
>tail, the tail's page offset is advanced by `start` (absolute message
>byte offset) instead of `start - offset` (byte position within the
>element). This makes rsge.offset overshoot by `offset` bytes, pointing
>to the wrong location within the page or beyond its boundary. Consumers
>of the corrupted entry either silently read wrong data or trigger an
>out-of-bounds access.
>
> BUG: KASAN: slab-use-after-free in bpf_msg_pull_data (net/core/filter.c:2728)
> Read of size 32752 at addr ffff8881042f0010 by task poc/130
> Call Trace:
>  __asan_memcpy (mm/kasan/shadow.c:105)
>  bpf_msg_pull_data (net/core/filter.c:2728)
>  bpf_prog_run_pin_on_cpu (include/linux/bpf.h:1402)
>  sk_psock_msg_verdict (net/core/skmsg.c:934)
>  tcp_bpf_send_verdict (net/ipv4/tcp_bpf.c:421)
>  sock_sendmsg_nosec (net/socket.c:727)
>
>Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
>Reported-by: Xiang Mei <xmei5@asu.edu>
>Reviewed-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
>Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
>Signed-off-by: Weiming Shi <bestswngs@gmail.com>
>Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
>---

Reviewed-by: John Fastabend <john.fastabend@gmail.com>
