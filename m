Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5263845C9
	for <bpf@vger.kernel.org>; Wed,  8 Apr 2026 11:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775647619; cv=none; b=KG3IusDY/0kxZ2Hj1twK43UQ94RYa2qrNf00xra0lxvAenl7Ao5vopgddG3y8OasxQNnS3qZX1MFoRSqZnpoPUUlGORHjoHK+W3HcQxRkG1mtnXgvuvFwvw5PYk53xw0mNkrR0a74trXLbzJhCJlkfStIR759LDAY8PjPDtKbyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775647619; c=relaxed/simple;
	bh=AzehQ18alrzr2B4IsDUBovXNCXWu6SlHUOMWZ0pewVw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u+XIQoFoedOf9v5tZnS6nd+LsZFCB86cKv26tAN0cy+XEfL2G0eYzMNsWXsc1e66Krez/odE/jCeZkl+npZ0zrrF/pcwtGVAiCkZ0yv9UabHGCZlrl4xONgflvenc+LqzZ4Vl+V9zhUJcF3WE4sVrnEJOErYUxtQECRM5DOkjd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CsKD0Hkp; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CsKD0Hkp"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-488b150559bso24655045e9.1
        for <bpf@vger.kernel.org>; Wed, 08 Apr 2026 04:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775647616; x=1776252416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ge0u9kdZKFhKwQUuXKTE2s3xbjDUvzv/MSs18Mhdv0=;
        b=CsKD0HkpgqXsNjJgnvcv1ObDqF2sJmD5u1ayZeItzhEm0pRTwzxeUt0DKfNcEkHsgG
         HFZQXixnRkBfI0onpORV800pN0LBi/bS9OSNqtTkPOgv3rbybTu1DgQEpB4uhZVNi1AK
         QWypWUqmF2oeu4Zou+cgRBX33kyRPAo7Yu0Yye/j9RqGoh6PXhmqQlaS3H3fmg5o5XGM
         GVTYJ8Tv4ChS7F8aIKwcrN6XXp8pCMRrlMd/Iv32DLR3r2NNzAhySOKo89fdq6nTAagf
         cXMaORSDxcyLD6igT7iMJFVyVOgafM2DgDiEVjgkMlmLXB3j7lBjG7IbTdUM13TRJMsr
         vhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775647616; x=1776252416;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9Ge0u9kdZKFhKwQUuXKTE2s3xbjDUvzv/MSs18Mhdv0=;
        b=bYIJcZuQLNjnhQTRBbdpZAf8TTzopfsw8grn1hTI6pVrO/Zu3rC2T1PDZDmRK4wTmD
         LVvDy9+saR4hmnhpki8PLFGOrNPEOUMt9qxt7ljFHn3djrrz86TWL4TRTvkUh0PFG77H
         gn0EM04Sk3lXLJK+huw02DKq8gN2hsBbcviH2LLLpNG1TFrNgXx1bd5UNvaDuVn2DQGk
         2v35WqPIHGbGQchY0T68OM8Er9ZQHjWI2fpheYVgvSzIABG8LW/4R+I7GFmvrcyiK1Cf
         ujt9VTXJX/UaeTjPqFmpMq/zepz/+/ltFEAVzSGRwlcyKq8G4V4feM47PQbcO/ThZ12F
         ocHA==
X-Forwarded-Encrypted: i=1; AJvYcCV2IooW80LX3fuLvAQA/5jigRtAc3r9LsflC77a+AdhLLW3ISBo2Q/+VVVWaCf/nNfh/oA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzTEBRAzh0EUNTSxhXES0FabpT71gXW9gf6lHtYEgPZWKWq7fW2
	4X7H63z2eS758Eh9oYNDYM+KB4NuK3N9LltSTOjQPM9XHcgUl8JcLiQm
X-Gm-Gg: AeBDietYLGpP1W0WOceEGl7gZ60V7PXV60hdCTkDJGYVpIla1smcueNK6RSRR/FVtOa
	0azVk9+38h3JTPm6hfu1txXZaVdJbEx1UbJNiWp9s+ReYHfIpbZu+7KGYS4nFhmmPxclmoDM7ms
	w5XD8a4gM5UCzbeWVi+bLYvCbAHEE6OW33STJtp1JVvZTlnqrE5uNegtpzbG/1gnBXJnGsD/0ym
	tZayns1146mQgzwlEpej60vGLVj/eOTz+r4SJTSIT4uCzHhFUaVb4h4ThkbDyXDItasxSgYlqHX
	2BEcW+pedZ61jrk/wkWrsCIO9tcOKNgIwf75HFpsJx4R9ebmBZZryWPQtFZ5mt/gA22UOWPJSOO
	OPlThNMN1vHv5Mjs8gEpdnuR69KW8GFsN7WCzqAnUHxIXQk0d813FMQteUxcPuD2Ewv4rcr78Qr
	IIT28UrT084ylOFPNz9YlHBA3oyiGAnODDOXymIySujxbtGsvSDMRwEQYFEkKiXZBh
X-Received: by 2002:a05:600c:3544:b0:485:303b:c50a with SMTP id 5b1f17b1804b1-488997352d3mr282797795e9.13.1775647616063;
        Wed, 08 Apr 2026 04:26:56 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488c5d85452sm16295135e9.15.2026.04.08.04.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 04:26:55 -0700 (PDT)
Date: Wed, 8 Apr 2026 12:26:53 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Kuniyuki Iwashima
 <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>,
 metze@samba.org, axboe@kernel.dk, Stanislav Fomichev <sdf@fomichev.me>,
 io-uring@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v3 0/4] net: move .getsockopt away from __user
 buffers
Message-ID: <20260408122653.295953dd@pumpkin>
In-Reply-To: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
References: <20260408-getsockopt-v3-0-061bb9cb355d@debian.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 08 Apr 2026 03:30:28 -0700
Breno Leitao <leitao@debian.org> wrote:

> Currently, the .getsockopt callback requires __user pointers:
> 
>   int (*getsockopt)(struct socket *sock, int level,
>                     int optname, char __user *optval, int __user *optlen);
> 
> This prevents kernel callers (io_uring, BPF) from using getsockopt on
> levels other than SOL_SOCKET, since they pass kernel pointers.
> 
> Following Linus' suggestion [0], this series introduces sockopt_t, a
> type-safe wrapper around iov_iter, and a getsockopt_iter callback that
> works with both user and kernel buffers. AF_PACKET and CAN raw are
> converted as initial users, with selftests covering the trickiest
> conversion patterns.

What are you doing about the cases where 'optlen' is a complete lie?
IIRC there is one related to some form of async io where it is just
the length of the header, the actual buffer length depends on
data in the header.
This doesn't matter with the existing code for applications, when they
get it wrong they just crash.
But kernel users will need to pass the actual buffer length separately
from optlen.
It also affects any code that tries to cache the actual data and copy
it back to userspace in the syscall wrapper - which makes sense for
most short getsockopt.

(This is different from historic code where the length might be
assumed to be 4 regardless of what was passed.)

	David
