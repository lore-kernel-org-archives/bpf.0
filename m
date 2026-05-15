Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A680D3E9C3D
	for <bpf@vger.kernel.org>; Fri, 15 May 2026 20:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778877931; cv=none; b=AP/Uc81o0A9MZuU/H8V79xenoZRGKP1RtJUBzKZsZF8UqfP3eAHtWWDK3P1gpge6BQOJmAWbQJDz01sdLlRKpB4D8nC+SI8PK/BTCVjtKk8JD4ZyAANYvW9DCPbF3L6s4CqlfYI6g2dHwVQW0UuogrmH67xh2Wa1DJJS9cAYwt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778877931; c=relaxed/simple;
	bh=jYFCW0q2oH14t/Tdq68TImEf4QAJ0L7oEU4dKSkZpjY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UwQkVpktDjBYaaSlbHgvF45iG+Ld5lmyfy9SSFxmma3rWxRxpv122B+tIyijZUM9fW3+n5LI9B+y8H4Xh5TshvEPdr/TUg2QXAguppv5QiS9fs38Prq/2NgwZZvgOEHNCH/mwK037Xp31Qtn33syTAxBnMivgq+vOzBtNyYRbag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/DPFY2q; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/DPFY2q"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-368763a1bdfso114805a91.2
        for <bpf@vger.kernel.org>; Fri, 15 May 2026 13:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778877929; x=1779482729; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Jp3G/+8nHauE/XI0omIm5SsO4BbcTyQ1cU6IXSGwNU=;
        b=F/DPFY2qHcEADU66AoQ/HAiAUlJsUgix7K5w2KL/d345RfzWcZ6/PEzo+Y1thEIbVX
         D6pBggvaMQ4CeZvz4e+7UIecvaw/fDIZTZOkyf4rTCXp8iRSySBbW5Vno5f6XClfLy7Y
         sscb1UyDNZCvN4XOc4pZdW+IpC1S9opSJKuKSfZtVKazLuGgEpBJ2rL4274QDUb86avo
         elS6sVawMNeL20eBSkLQWSVJPwOQOeKdunhYEgARNhF1tAB1DyIDQv4PWfB89guc5O5g
         gcEfpJiN7Fy5RO8kI6D5jH+ss5UEHZ/1xjMKWg0S9lcPhQKlHmRuYKtZ37PYOKKX6rjq
         EE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778877929; x=1779482729;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Jp3G/+8nHauE/XI0omIm5SsO4BbcTyQ1cU6IXSGwNU=;
        b=gPAOh0yIexozMLNWgjkqMhdxNUUe7r8dOQU3/1pttnNwwyFA8SyJrY4XxafBW2Oio6
         Oq98Vby0TCuooqsM990guJp225BrYHqpwqWTSIrtnA64txmiH+P88FgHd5X6SzcZBhsM
         npW0SDOcG/4wCoXDpNbiP/PBDlW3ng2tqAdfS7rp5rraBkgYXJoC1NVhvCWkV7BbiACJ
         Dlexqur96HQUZ57rFxnDJlvZrmaPfoTPCba2zvfRNM8xeP7B/gmUXWAyuk3Ybg4kduhF
         OvUtuQ+Khjd+ZmyiTvAKCJEMaPep/z/VMJ7q+bUuqSRVu2SjZzGQaKCfKp6V6mae++VF
         gTug==
X-Forwarded-Encrypted: i=1; AFNElJ/XWhWr0Sqtane5ezez0J4YLiLN6XrGSC5no5AGj/JEU5rUYqVmuc/W/g/eBy2VTO4yZTw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyasWqexK4mmEEtENC+nJwG/kGTQzLnHDoRQdeSk7NI7/18vAKu
	CPy99CKv84Zm/RZK4L4GY7SCxDbzCnggFus7gt9RtWvLXomykY9PoENfIEC5s6d0
X-Gm-Gg: Acq92OE3V0MiTth+63lF7i8H5Gu74MGneOSk29LBbf02CN4G6VTPPLJ71FFj9+4tEFk
	Ej98aeTH00+nz9rn2N3xmZADjuO6FrDZI50MLRE/KGZfN7wEGsmZ2Ygu6gsd87uPSnPnTQRRQTy
	KHS7HQ6ahgfc9jyJFoOInCKz+Aw+zCM9YAlWI1DQ1yjWmbPGx8bZmYvFvLzB82XrIFyhh2R0Avv
	yHQv2izNPpZEI7PTYEY/yECKhjHN8nhGEiHt4yHufcaYzRxuabE+/pA0Q+ANxpuJel+1aiq8gTL
	mRYSKhDL6ma0926uZBzoZeE0b2nytFCR1btVpBxnBxjaVDXAk/z99y3oAlu9Up/BRcVpgENeQgt
	9T7A4ePHf/XWANMbPuNN0HwgcCyX7kP8kaZxmgqNihVX/bqfYs8FrDT0/CX6C3JDwLAPaPaQ7L1
	0F9ZWTd2V7uecueXpl
X-Received: by 2002:a17:90b:1810:b0:35c:cba:3453 with SMTP id 98e67ed59e1d1-36951ca602amr5899046a91.22.1778877928785;
        Fri, 15 May 2026 13:45:28 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5f::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-369703bcc91sm167683a91.3.2026.05.15.13.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 13:45:28 -0700 (PDT)
Date: Fri, 15 May 2026 13:45:27 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Breno Leitao <leitao@debian.org>
Cc: Chas Williams <3chas3@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>, 
	Alexandra Winter <wintera@linux.ibm.com>, Thorsten Winkler <twinkler@linux.ibm.com>, 
	James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>, 
	Marc Dionne <marc.dionne@auristor.com>, David Heidelberg <david+nfc@ixit.cz>, 
	Samuel Ortiz <sameo@linux.intel.com>, linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, tipc-discussion@lists.sourceforge.net, 
	linux-s390@vger.kernel.org, linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next v2 1/7] af_iucv: take socket lock around
 SO_MSGSIZE getsockopt
Message-ID: <ageFn6UV-c-pOPBW@devvm7509.cco0.facebook.com>
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-1-0d8eed952627@debian.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260515-getsock_four-v2-1-0d8eed952627@debian.org>

On 05/15, Breno Leitao wrote:
> Mirror the locking used by the SO_MSGLIMIT case directly above: take
> lock_sock() before reading iucv->hs_dev and dereferencing hs_dev->mtu,
> and release it afterwards. This keeps the two adjacent getsockopt arms
> consistent and matches the lock held by iucv_sock_close() when it
> clears hs_dev.
> 
> This is not an exploitable bug. iucv_sock_close() is the only writer
> of iucv->hs_dev and only runs from the protocol release callback,
> which the socket layer invokes after the last file reference drops.
> The getsockopt() syscall holds an fd reference for its entire
> duration via fdget()/fdput(), so iucv_sock_close() cannot run
> concurrently with the SO_MSGSIZE read on the same socket. There is
> no other writer of hs_dev, and the aligned pointer load cannot tear
> on any architecture Linux supports, so the existing code cannot
> observe a NULL dereference or use-after-free in practice.
> 
> The change is purely defensive: making the locking pattern uniform
> across the function avoids surprising the next reader and removes a
> foot-gun should the close path ever grow a new caller that does not
> hold the fd reference.
> 
> Note: For the reason above, it doesn't contain a "Fixes" tag, and is
> aiming at net-next instead of net.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  net/iucv/af_iucv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 72dfccd4e3d58..3dd11d7a967c8 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1566,9 +1566,11 @@ static int iucv_sock_getsockopt(struct socket *sock, int level, int optname,
>  	case SO_MSGSIZE:
>  		if (sk->sk_state == IUCV_OPEN)
>  			return -EBADFD;
> +		lock_sock(sk);
>  		val = (iucv->hs_dev) ? iucv->hs_dev->mtu -
>  				sizeof(struct af_iucv_trans_hdr) - ETH_HLEN :
>  				0x7fffffff;
> +		release_sock(sk);
>  		break;
>  	default:
>  		return -ENOPROTOOPT;
> 

SO_IPRMDATA_MSG also seems to be only reading the value set via setsockopt,
so maybe it's ok to just cover the whole switch with lock/unlock? (will
mirror what setsockopt does)
