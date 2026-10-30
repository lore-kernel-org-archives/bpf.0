Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793377263;
	b=bn4eIYvqXCXl8/0Djv5HhGooxYhmZDmS2RyJSQBKlaq3ZG1ScV8elSMW+/ahBnEkvmTa
	 hKBRMwmGrgk/1VJXNvn7MiC38Sn9mAgFASRG3BqIxKqOrgfgEBm+OVied8bUQo2gN4tsc
	 D7cMplBqiH1tXmTUDRYqxpg0QLijE0kmxgOrTejdlsoMsh1UAsK0FHMpolLCQjtjxx5J2
	 88mfyWFZdVWLFd8aIQitCTrb5jZd69NTl7d5+4lOW18BNPbcAODvAlaeCmF+2P0jKvBoO
	 rER7D9vxEa1nwN+9KU53DHV0u76gQ4Dxaa8kqTXe7ZlwGlDJjUkbDAU5OlJpLzomkNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793377263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:Content-Transfer-Encoding:MIME-Version;
	bh=zyOsXApbsMPDzz9xbQc9j82HAbVZYrZjlFKRD4aZyn8=;
	b=O0WmpjwPndjQwapB+0KWts1pQQnAX4u3kzW41kir4NXvomy7QZjGyARu+Qll7BGbWz7N
	 ztuA3QEi6nSmdaQa5BhCSRI9fjQ8BGTXbAPAoI7y4qRrOuNoKvd/Ba0jsWzyBCoOvVXMH
	 O8Biox+csEpPYlJECbx2BoKIiF4b7+51bznKL+ApK+pz7SIFfjFRKanhhFrjuONyPKuak
	 ERQTeperFoorcjwIQtUF12kn2hFmz3ozLPIJrTaZgGqxHCNn5zncAv9J8I+5Z4Ei0EYzx
	 KPhrd9jOGnMNgPKIM0VR6+cP5UtCxnFbiWDFG0mNnjHuXWOzZ3+jGUpN0UgJfdEj3jA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I9CHq1vD;
	arc=none smtp.remote-ip=209.85.216.48
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88B9606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 16:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C88B9606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I9CHq1vD
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ad41b47541so787442a91.1
        for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 09:21:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793377262; x=1793982062; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zyOsXApbsMPDzz9xbQc9j82HAbVZYrZjlFKRD4aZyn8=;
        b=I9CHq1vDLmpX5qnXoIUx7W4ASxXg58bg4CoxZea/IQTYf+7FRm2u6GrNy3Qn3j3nlg
         UJxqEUcKYHBqkycHpSJcauvmDbezNNIllKp/XE3mSKVZ1zgOp2R3GynGHy595JJsgYXu
         hE/0w2yfpfnz/FuJ4laOfNGSfBgSf3Af0drgGx+doom5rGA2n63qXsZfse1dFKmexB4d
         To4Rf9D1Pj20zXCgKf3MXZM867DNGx+EYScp2mpe5vNh0rzFMQNTx1r4XQ6MSFSoTXFq
         vYtAgD+txcxlyZvBVQxCZEP0gQXdtLXIV951fIg3IBC0ABpQSpyZudtRS+0isv9Jh83f
         H3ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793377262; x=1793982062;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zyOsXApbsMPDzz9xbQc9j82HAbVZYrZjlFKRD4aZyn8=;
        b=aKrNzaJl4WovRHCxRXN6prDI0kAaSeOrXVvoLIedPFTb1z/JY8lDj7JTqtyOrGHtdK
         FsSgKtGMcIE5BTgU9kxXIrnLluGzIqxfOoxEfj5dFvpE09JWzDRscXYKJT5zZXke0aoI
         txDGHop9p8L5iaMvRJSGAR+Yfxgenh4GNAGrRLdOWlrbnT9I523XoK/D4L6LoEnKIzkg
         IzEW+zpQbCOXqeow4sndHIzi3v3jM9sLCCfphRmL2GJ6Z4NMW2BrFErIxFHT+Q9G2jRL
         qdNEOEDdQIOu/iYVktRgLligBkPXDp0sNZAlwJpImnKMOslAPJ9J3arRzS33awVPRuqr
         ZL2w==
X-Forwarded-Encrypted: i=1; AKwUvBxZyabI216ljCFoABIYVRQiaEoa1tgsYjUtyB22U4iEzrLwaX/uqglzp/zr+nC7HRZg2bs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDeJ/XPz8Yhoc/LkOk2BGf/oEGkdctGpQfRNvmyJmfIp9I6VFD
	IOr5b4cIxD8AIoYutPY9IVjE6zBORJiSGDbPWDGQXoAvsQlbJpeH39d9
X-Gm-Gg: AYBFou0iatw7XfICtwFOkOmc7pq91E/2y3kBx/1GizkqgbW5/BLlmjsbFIhmwTVFmo9
	F85/GRpO3xswoW8HePCHCzknlrMMgNa2o7pOec99wY/l1p64qWeEI5QYHfq+L8YKU/iOJXl2obX
	pDenIPoBSXy33RtEZB+0SE4J6zh91qBVJexsUDtTZEhiPBI9TPJGrb0tII66LovCvJXXHpyuZst
	Il2dS8R2IyieWMufZGTOilhbN07ovC3njBv2G38eL8JvXXTXNSXJ8mpTimbH1jlflmqdUCkr2ZM
	H8WWPktI++xrrnwdwTTQZKZOQAbysg6EdcsSkBq9+lLDT++P5GQTtRueIuWhc6k0aEhER9OHJpE
	RYCuZziCiCObi/54pqptkE5NAJTT6zTOmW2eLrrKO1TDBT1mMmNBcyCBauj+wZdI2i98TJzkjI7
	tall/cgff8G/FFpVoPlIOk5gfRXIYe8tRaVUWTBwHhDVXzewxxCNTBTRmB2oLuY6OwcI4gQFCo3
	hRLTDSbAbj9jfUWCzGbq1nX4WlN4gIq9rJe40rC/CnP1/82/ZQthIG6UvWarHyGUIJTAdsogomt
	lUqyIcyX4uKv/r+p8oREDJDPnPltc/5nq6HVzYFs9XRvSGqy+Sgym129UCbBpreS/1DwAVgApuJ
	Boy0Ynw+g2ou41P/Yo7YUw9/D26Ru0h4x7A==
X-Received: by 2002:a17:90b:1f92:b0:3ad:4a8b:c701 with SMTP id 98e67ed59e1d1-3ae897b51a8mr2370584a91.45.1793377262057;
        Fri, 30 Oct 2026 09:21:02 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae880b1f71sm2113239a91.4.2026.10.30.09.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Oct 2026 09:21:01 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 30 Oct 2026 16:21:00 +0000
Message-Id: <DMIB6JXDLTPX.15EVLOCXRDOOO@gmail.com>
Cc: "Willem de Bruijn" <willemb@google.com>, "Simon Horman"
 <horms@kernel.org>, <netdev@vger.kernel.org>, <bpf@vger.kernel.org>, "David
 Laight" <david.laight.linux@gmail.com>, "Willem de Bruijn"
 <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH v2 net] udp: restore hlist_nulls for primary and
 secondary hash tables
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Eric Dumazet" <edumazet@kernel.org>, "David S . Miller"
 <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>
In-Reply-To: <20261030122045.3035709-1-edumazet@kernel.org>
References: <20261030122045.3035709-1-edumazet@kernel.org>
Content-Transfer-Encoding: 8bit
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Fri, Oct 30, 2026 at 05:20 AM Eric Dumazet <edumazet@kernel.org> wrote:
> @@ -3431,12 +3477,12 @@ static struct sock *bpf_iter_udp_batch(struct seq_file *seq)
>  	for (; state->bucket <= udptable->mask; state->bucket++) {
>  		struct udp_hslot *hslot2 = &udptable->hash2[state->bucket].hslot;
>
> -		if (hlist_empty(&hslot2->head))
> +		if (hlist_nulls_empty(&hslot2->head))
>  			goto next_bucket;
>
>  		spin_lock_bh(&hslot2->lock);
> -		sk = hlist_entry_safe(hslot2->head.first, struct sock,
> -				      __sk_common.skc_portaddr_node);
> +		sk = hlist_nulls_entry_safe(hslot2->head.first, struct sock,
> +					    __sk_common.skc_portaddr_node);

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
