Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EC8340401
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 15:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779206111; cv=none; b=ULUZcfTIBHGkzX23gPFP04zhzOpL/lNbHB+gPvQh1iVZ/4hI8+TWQZqbfWEkpgTNIrhVCKdilNWvwwUZ+TXohm0koJ+JnnBJLtyuXCxEYHX9YZ5upu7opxTTBUrFr4yTB2Gk7Xm/aMkXnfzsV0GNdcA15mRgme30xUXLjv59ghI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779206111; c=relaxed/simple;
	bh=py1MRqKn7exNdjXsmsX1yh47Z7tsmCUTS6qgb/gwScY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DACSvSPWJ6pw/gf+XBVUyJ9b/i30jetXG4ozVV5JGSDK8zfEw1ijRdPdRcIUmx4hKOlnwWfwsCUrskbXrKuGd6Bz6mj9Euo/mC3aOCtch3t2PQWxNizTGWO7QWmIWmv3bci0JOvEAMyBTXrgzaJabwEIOPSjfas3Rz9rLi1TJms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RLiNirB9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRC8Ur9P; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RLiNirB9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRC8Ur9P"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779206107;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ShAj6l51xuzBF/j17UKisc3z8T5wY7lSXY12qKT0nQ=;
	b=RLiNirB98MQtvysGuKDevkML9nC8af80wSeFBz6q7T28pPQx7ww5MahJ+x6jUzewkOwPK+
	t4cAYs1nftRg1ku2SBdqZsq2hhxL90SQH9j4/H/ZhWLT4199xv4WTCshwhd5WunmF0F5bs
	+MKKJa07afOVJw6uUzzl7DJ1kiKhMx0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-8vcJB1WlN7Ku1MUxrOwuFQ-1; Tue, 19 May 2026 10:08:44 -0400
X-MC-Unique: 8vcJB1WlN7Ku1MUxrOwuFQ-1
X-Mimecast-MFC-AGG-ID: 8vcJB1WlN7Ku1MUxrOwuFQ_1779199723
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-488d1b5bca0so14745415e9.2
        for <bpf@vger.kernel.org>; Tue, 19 May 2026 07:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779199723; x=1779804523; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ShAj6l51xuzBF/j17UKisc3z8T5wY7lSXY12qKT0nQ=;
        b=BRC8Ur9Pe6V8siEVZXvjQ4vQL/dOC7tOrTJVQO4KlIAJGjCSqmNKiuq0WqYYb75s9e
         5YGxcmggdQw2MnMThPhCaDTB7oAfDMafrXc83MAhMa8XvCBIW8LAJhgnVAO+UCDrIKwl
         DYfSQvQo1lZJCfOrABPbMrMmEmhxfsSKOpRodnWeK5GyYPIvGWW9VtGc//IG517niLBX
         izknrQRhMAEtj2ZmoQJNItwF1B9mbvwfBOlyT2EUPUuiWfduMnSoqDe6BIiRVFq13kJ/
         I4yrK7HeJAd8nBWD127GBSR0o+MavsTji0Lc7uWImQ8WHA8XlIUTmYZKiu4GuTqHdbMF
         8TUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199723; x=1779804523;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ShAj6l51xuzBF/j17UKisc3z8T5wY7lSXY12qKT0nQ=;
        b=B7hRMutpq1UAmIWKRaHLKhWJewl6S2zdlD5rv+kBcZZ93tcBPnAdQy5nV8rNqXKQNr
         kbW27xG2UZzISP32xGo6f+IRt08KUiLMG9ZPQuCNSRmfl0EcA3vN0ltuFaeujjdzcDjr
         wgK3fuSx6KadMlX/SRf8YbKnKDAjeG+zEJRIjqtAYaTM4MCrPwyhePzN1XM7EFmyj+6N
         rBXJB2J1yG7z4VECBe6yohEfx9trdl21GNuI0v1DYrJViTVtV6+USpzT/SJBFQx/IDUM
         VD2+7Zs+PLKU7KRjXSi+I80j4zP9Ho0gJZBgbHU0V6LEKaqXbD5W3BvDL0dP8lHn2Dsu
         V5sw==
X-Forwarded-Encrypted: i=1; AFNElJ+dvqL+8YowGx657D9xDQUDgccycunzFCsT4QGFE6zXH4RahkqzW4acIA7ubzbKXAtvN34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgi7wxL9kxbhDTBsPzCEub1Phxk/ewwB1e298mMbXD5NsfKRyl
	dIC430mdt1+17mPd80a+5xcngiIpxFkXclI7WMx3CwzhvGT33eRV946XaxGkEMGwimR/t2zLrt/
	xeW3kWiY9YD4AO3jTjuSXMipmSGHpF0DBl8xVyzZAp4DG2jxpZbtDNQ==
X-Gm-Gg: Acq92OFSTXGN3Izt2+qhMRYvvQMAS4YW3UIhXbsFeoeorVf4ME7WrMaFVq222bqyL3A
	kMXC9M8xgObxWijrtRNh49rn0g8TeCERw5t+T3IHbXNxaem0Y4wryOI8PPOeHpoNBYvoBkfkld2
	MB9PFsk0tzQPPn1+szVCrzyPIzL2LP2QR9wJp3JZRuKF8gfR7ZUAuutEqlQ20JNWcP8u3Egui2l
	0yQvBseQUytseGYX4j7sAwBVSFQHSpzOyhIsPopojt/55YWZEDL/eqUoZv1VoJqsztxJgKnr6XD
	9Gb5J1/unctW3LWJ+BwFHZ31m1l4brZJPTn5wUaRw9bWLKvXkfRdHJ+SwQDOeqdsEpcNGUP//iY
	YYUUKYSC65ULtcPHm44KXhT1vzOkDL96jEmkAqu/6EFvRkNjPJzOVp52UHLRpCqnvtw==
X-Received: by 2002:a05:600c:5304:b0:490:17da:27f8 with SMTP id 5b1f17b1804b1-49017da2830mr97673405e9.18.1779199722778;
        Tue, 19 May 2026 07:08:42 -0700 (PDT)
X-Received: by 2002:a05:600c:5304:b0:490:17da:27f8 with SMTP id 5b1f17b1804b1-49017da2830mr97672985e9.18.1779199722357;
        Tue, 19 May 2026 07:08:42 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe5bc94sm204874615e9.4.2026.05.19.07.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 07:08:41 -0700 (PDT)
Message-ID: <c05304bd-1c7a-486a-9929-e6947de07adb@redhat.com>
Date: Tue, 19 May 2026 16:08:39 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/7] tipc: convert to getsockopt_iter
To: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, David Heidelberg
 <david+nfc@ixit.cz>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-s390@vger.kernel.org,
 linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev,
 kernel-team@meta.com
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-7-0d8eed952627@debian.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260515-getsock_four-v2-7-0d8eed952627@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/15/26 10:32 AM, Breno Leitao wrote:
> @@ -3260,7 +3260,6 @@ static int tipc_getsockopt(struct socket *sock, int lvl, int opt,
>  		break;
>  	case TIPC_CONN_TIMEOUT:
>  		value = tsk->conn_timeout;
> -		/* no need to set "res", since already 0 at this point */

Since you have to repost, there is another obsoleted comment referring
to "res" later on:

		return res;	/* "get" failed */

please strip it, too.

/P

