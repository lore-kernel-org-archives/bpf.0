Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795793204;
	b=iCTPytR3mjJNuQ4KZl8gKfcAOUxmil7ysoTOfAht2R5TX8c2zf4jJ/atd3fqGMDSgAcf
	 BzHNIiuuIaIS0KkqhsdoZYI/svulXOPMYDNmkWKm5WrpXQSLX/q8ZnpLL6+imHKrbjjAc
	 x56eb2vmL01WtOdynOXv/0GcvoA0wvTdarcPzvQFBDRd7ywAUUMG08QPt6oo7OMtzi7wR
	 faytHY8wUqwLJhFlBM5P0egs8WZRelw89TFnnN2iokxfigEu+1GdUN64kchfKig3H/3Ob
	 RcTE6J16Jfs3ASvzPCBJ70rFNkyrOSaMB5GGz+gELnN9aCfV/mSTtqnKfRZ+fNbJfVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793204;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=+cNaFNq+h0C98G3vTstsz5kW6XsnAXUPToskRbu44xM=;
	b=DgLDSehWEbIZxtImrj/fEuH5pGgF9biChdBvCNNjnqihzr/nxS1gqntL+LUXoVpAmdOw
	 Xv/I9fUG6GF44fYJq6WiEj9fYyjqKti1f+2rp41n+9nWZzI6kMNocn7H1hGlpI3+RQxO0
	 SmFNuWIYOfIY4PCxnj9njrADMnOu8IZIfvpuds1dtVWCEhsKyX31bSB5vnN2rMyRkdJXE
	 t1k7PC1noUNIrVbXfVxIA0cdxtUj5PEXqLQz3ylpyqg56dfJkBhjVfbkxByrwlL9ZoPuD
	 lDIL5vfW4lALjM8n8Ay8JJr+vKiQ+9YEoXprWxmdzMS+vvTiyoNl0evQDrDgOrmb8Qw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=n94mAkyJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2E6606A31F
	for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 15:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D2E6606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=n94mAkyJ
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b51389f58cso88865357b3.3
        for <bpf@vger.kernel.org>; Fri, 27 Nov 2026 07:26:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795793203; cv=none;
        d=google.com; s=arc-20260327;
        b=OB+rbA5/Z/exzZicQd+KtZJWaw+dZn7VIys306v7gaHLQKRxknB53d3ytKvuJ8nHgQ
         mejG6lGmCkHmprY0IRtLNPajGZuFyg8+M2ivMpnewyprZw+qBmOa690T+pDjtmrXbgN0
         XPP+R86YMnE1cnC7E3FC/NlEC/7BeSOdlwjxsrEkmR4mbnQ6tReZvld1XC8aWfVDUunf
         4NZ+4zMLIZLIDOFbz73uPbeUm75nVvKiuAXEMrM+SsFq8siMKPG8EfguwcJ73zyu6vzK
         lCDn0VTT0Z6RvuRITuhdUoy3SWlbjo8A8E11xS+4A5224qBPvVExJKfDDEJgfLppPs/6
         0oLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=+cNaFNq+h0C98G3vTstsz5kW6XsnAXUPToskRbu44xM=;
        fh=0BriLjjnjGp8Rt54Co//E2Y2BEbNsV4v0dGErHMayFA=;
        b=LCoCs3PHEIwX+pbstOVQd+7XBfkRANqZ7ez+M2aB+cp7G7O9wRrUvDY8xaciwg8fLo
         ATzNEMq7jqKSw6nSX8TC7p7XkawVBCU0amLO0iIhMS5VvE3DMU2ROlH8awp7E/e48Ag/
         aevum2Tfxd+XWuWQBhUhUONgA/tQsl3mIJWDzyaXcXvqvhx/JImzgZYP1ALcXI32H2Y1
         g6i1SiNRVp2OstMCKJ13Z3KCiO1zaITcxppymdsjiY1ZSoj2uUUrRMbq4WTusd/AXyRL
         6/E3mzv7ewFGVOHtYLf/2RlyISYigGIO71jLcfdqQoOPkpjVV3dbu+ONlqnJllKAz6QC
         NEBw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1795793203; x=1796398003; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cNaFNq+h0C98G3vTstsz5kW6XsnAXUPToskRbu44xM=;
        b=n94mAkyJOfvvvFdqyDtEpzjXrweT8JaZWeLZ+JYOiBFDDuYaMPknPGxHUMwIf2p4QI
         XbOKYuOKTdVMFxaHokKbNXTGDBUktL/B8JSyE7b6YdHb/W74KbvW6rbiCZmnIQlF/i8I
         ALou6ktP1I5Zbs41mBTFycRR8rPWR02G+g/k6UH6l6DD/aedUb053tQ5jkZ91GKvmJIw
         67G0iRK3SJp9Ne0ESx6cqkBNNWwucbSzu7o0e1KmDO5YpJZRB7LNyeyOHGcjxEYRPjwa
         qp45YwL1Q5w8yIJrLzHHQk7QAC0knp49PvcDTYRwISeZGMmOYrkYRgoOL+1gkc/Fe8L+
         ufMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795793203; x=1796398003;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=+cNaFNq+h0C98G3vTstsz5kW6XsnAXUPToskRbu44xM=;
        b=PAwzQs1frNsRjOnSIC8GilhaWC5i0n9U7X3ieA3BXhW48Pg7jTe3qe/Jr17EfpoPys
         FSbfVUkzRQypbhXg0WxLq4ab1wsSA3nHQHLT3YW/aDYxGLu7uOtGcaFrgV/P0slliPvq
         6BRrSoBL112PU07wz9WZbZiqu/GiakXXMG2SoKMVScQnbynp8hAI1lxsqnEemF/Ez8qP
         sP89kfl78wwoDdUHiGkxptzNmZgwRxYr9dMddMH0myBdpcN98KzHjfx9DpY1wyB9nx3r
         irncSYcN+pHaYf18Udt84FACLeNm0Y9HLDLgChoWUII3qHe53r73Um7fMWYKIjLpbsA6
         mQTQ==
X-Forwarded-Encrypted: i=1; AL+hErHCeg+Y2Go5DeO0vOIFQrQodTifSTEcecFqS+0iT2iinKVLsZ8DLhTCYYFK5Zxj7c3Kg9A=@vger.kernel.org
X-Gm-Message-State: APuU4Z88pqLBtQEhLvf7xIEfF5urGw6ONsyHWhu9q6EVriOum3YHP1Ix
	6QZUqT92xCGeBET6iynq8WaE0j1PFbkn4pvTBmXhFkDAoF0Zkg8E+jq23Pyx2r+7Ct9BM4Fi1AN
	ylXgeEPi9naxUgNAvYIEjAL23QoFh93UTl3Y5r8Sl
X-Gm-Gg: AZFdTZfdOj2k5vOexr23HbQAwG88b4kfMxGYdBh9qGZtyhB8/rSkcYe5M74iG3TKhhQ
	3PWk5Py4NWiL5NuFJeQRFIW6GJsE4KMSQcx24iAUTfyE6nCIVwHIds3HGPuk2LGPZ4phlOANUqS
	XSgH6DARIUM4p02APwz1EH7FeRTCX0rzIC9RLYntPR1khSnS3PHJEzgoIuGYvQ5z1pFyD5zqdR0
	ISc13ZGVCaV3XOQjDlSruFSingdQJwtxTSxjDk94ASed0YUdhgrnrSomsCTw/DvjqeCN609nV2x
	JHg3N2D+7H9MsxtXJYUxMyPoTAG2Ze4Z7oywr9qnpWUOHSfsbKa6D6TvlNIBFvsug2EXoy8Il05
	E7/Li+Rbh+5LePhTubd0pB6+spDVHavTYgSd2LQcUkc1e9/hfwZoTqcxGloZt6BgVIeMtm8+a28
	VGgiVWUIuNamYH6l94snF2p9cWvISPX0qO6qUD1cKXt8/Z2Jvf4i3/KI9mRkyOHpouMuWimeelN
	AC9YA9pEz7ZvhE1kfy4+qT5JrKKkVGGxQ8vnp9977xhCwGebSWg+z92PILQ52t6tJfLZOkdFKn4
	0nYyq6817XRjwDPRrthMPqzp16zZ9Rs19LIq11OVbjDP72RYLR/t1936CSXMHqBZhdOu4vb1VDh
	kMpjNgWdWvXQiosTbwyhEiYc6IjP56lzh
X-Received: by 2002:a05:690c:698e:b0:8b3:45b:a4f3 with SMTP id
 00721157ae682-8b5204ed736mr106681927b3.83.1795793203488; Fri, 27 Nov 2026
 07:26:43 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1795284858.git.julius@bairaktaris.de> <7c74b2076dc7dee1d481d39a135e0946d5e04145.1795284858.git.julius@bairaktaris.de>
 <34e77fff-c57b-4ed0-9035-b9682ad3914e@redhat.com>
In-Reply-To: <34e77fff-c57b-4ed0-9035-b9682ad3914e@redhat.com>
From: Julius Bairaktaris <julius@bairaktaris.de>
Date: Fri, 27 Nov 2026 15:26:08 +0000
X-Gm-Features: Aa3M54pxMqgZ_s-9JbfNek_3dyGz87LXsEraMMuneoiDkKTrHn3sKg0m5hARvDM
Message-ID: <CAC1t37L_+P72w+gNcrdphB7xkBmCQp5PQRFpcu1zqM1m-2Am+A@mail.gmail.com>
Subject: Re: [PATCH net v3 1/2] net: keep the TCP fixed-ID flags on the header
 they describe
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, willemb@google.com, horms@kernel.org, andrew+netdev@lunn.ch, 
	dsahern@kernel.org, idosch@nvidia.com, ncardwell@google.com, 
	kuniyu@google.com, steffen.klassert@secunet.com, herbert@gondor.apana.org.au, 
	richardbgobert@gmail.com, ecree.xilinx@gmail.com, andy.moreton@amd.com, 
	alex.austin@amd.com, linux-net-drivers@amd.com, saeedm@nvidia.com, 
	tariqt@nvidia.com, mbloch@nvidia.com, leon@kernel.org, 
	linux-rdma@vger.kernel.org, alexei.starovoitov@gmail.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev, 
	jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev, 
	john.fastabend@gmail.com, sdf@fomichev.me, izaiahsun@gmail.com, 
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org, 
	shuah@kernel.org, bpf@vger.kernel.org, ipsec@lists.linux.dev, 
	linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Ack.

Thanks for looking into this!

Julius
