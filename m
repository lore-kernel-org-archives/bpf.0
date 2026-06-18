Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA843E3141
	for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 10:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781778452; cv=none; b=QUvpv3s3M24410vj6Rb8vVoCdNF2KUD7Gy56zrAUCEwt4SIKE6o7yNeexRnkQCleMTxsXWFwB19TOXWcx8T01eUz5Y0W5ix60llZcwy/zUeb4ysO1ZJLZ8EL31fu7/Buhx+7u013cxzSaMJEZ8vCwEvtAUtxpYH7cx8jJlcSEpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781778452; c=relaxed/simple;
	bh=ie+WeF9YvCciqNwiy2FTqjhEPlH33sG92o0tD3DNuUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MReY6RDahD5u7/XMtUMCPGdCLrxLrQGg+eAy6/2ZE9rgxOs0Mmo62WQMxsgZVJOJBYia0IGIwDJssu5XQ7LIMrFdhimCpHL+tiY/E+1xyxk6YXFGbHNZ9bqQdMmAME1Qj/ZJWZy7pyDRQj8gwN1q+51MMxV4ZXlS1zCFA2J9vp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vxod0Tmg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vxod0Tmg"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-37cae9b7536so422983a91.3
        for <bpf@vger.kernel.org>; Thu, 18 Jun 2026 03:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781778450; x=1782383250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X+g3ajtkFOOFkEfqzNyMI8IOO/HHBfQmbFF+r03Fz6Q=;
        b=Vxod0TmgOV9GfPZJ29LcTX7XF3tczpqFvgyuvAMMZADv5UyG0PoyHU9iE391pFRwyY
         TaPBVHFHPd1pOTfvqyReAD5AP2THdJSjkqiBSFwC9T6UAS7Ey//vAB3BBf5VMZJHqpc/
         IPKBVnp02TjQII0ZuBBvbD1KEJwaobEPGE8PtpqfIfp5y5WkPuDQCWIFYDZb1noYscoJ
         Ra+bWxhLib7lX8Hpl0qyAf2N4YKpdX62YDks/C9/nHVLwGM5cnPMxXOqL9+epcdD5kW9
         7KW0u+VEmDtIUYLdsJX3IbE6GnvaRhqhO5iXFgieXrxwaHWt954vUn+LjqnrkmwaAN7m
         Dm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781778450; x=1782383250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X+g3ajtkFOOFkEfqzNyMI8IOO/HHBfQmbFF+r03Fz6Q=;
        b=s6sAT/0MUsPuP8yn7Vf4G7KKo7Awj38mr97fxUL3Z+Lzk8EGfAeObPukcKkrin5AFW
         m91OovGBe6SBnbTfHpSHj5H4j8f7ngY5tW9o52H5yJSl4Mk6/i0FY7zcxjcqbJxPBKhc
         EiLt2vuUluC161ujYXxAihIYPGS/jFIk9NeFEyjJr5r51M63wLwq1NuD+RBiih5Z1r8K
         Tumcdrclsca6OQMHHAxh3UFp5rXZ+j6kJbIgXdNS5cAA0isUM31g+pp19xNEABihgfxM
         iOkItIdYZytqqfVCTMXCB+lPCXhAMq2HHRdpy/42lqUHiV7T54Ft+5DLGG6+2svYXtyf
         siGA==
X-Forwarded-Encrypted: i=1; AFNElJ+WQn2fxqLOAEy2c0QrxzjAxFPy2/faptwFBFfLqbv4GOqe2mnMWl4QUIFO3L07+eCDm2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsGYSQS1l2eloZbG5TWtSvy3KE0Fd2/Csvbx6hCvSkdLrbiuL1
	ny2Ae7bpgSWDpRvIrqElAKcN05OL2Hj4wzQn58obc8i7pjeq2TYdjWQ4K8ywhg==
X-Gm-Gg: AfdE7clWp1bDE07nkmCh3TbdHN+JiOHfufrpPJ1vJCWLVbDOjZ2LUOw3Z/APeale0zz
	iLC1icVKHwI4AmfMowXPc5p1isFZQsh1GZL3WOamoNLaMHBpI0AwRzzw5/GQ1ccxAZawAiDKgbz
	1aq6jjSDMj8QO35tlaECbt/9Jc48D4RFwXyIgbx6h5qVyNY22r9GFfH5d+8MxczVCJljB2PmM7B
	bHLzPtxSi5EbbSN0akY73TF6W4gsIORWUuSNVJ1sFwJqNZf7CsjPeTaf5cDEkobUbQbBEabNQTp
	a6gB6BC56WDrHvvLDrCWHK1o6FyJFZmfP/GWCgOUfoYG/iNOEMlKaY848kCITga73fAP3mvd8/Y
	No/K2dYETAtDbwUcfR+ife7w//jRiXl1GCqeg8j4ASQ5xPi5NraO6dvoyZ6XJ8T3Pjiy+oXh1Bw
	BuAuMWvPtPEZ/qff+3+qqCghdHOJMieDv+BuUvMq1NxhA+mIX8apY=
X-Received: by 2002:a17:90b:3c12:b0:36d:8f51:fe29 with SMTP id 98e67ed59e1d1-37ce488901dmr3403296a91.17.1781778449635;
        Thu, 18 Jun 2026 03:27:29 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37c521cac5bsm8997512a91.5.2026.06.18.03.27.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 03:27:28 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 0/2] bpf, sockmap: reject a packet-modifying SK_SKB stream parser
Date: Thu, 18 Jun 2026 10:27:06 +0000
Message-ID: <20260618102718.2331468-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A BPF_PROG_TYPE_SK_SKB stream parser runs on strparser's message head,
which can chain skbs through frag_list. A parser that resizes the skb
frees the frag_list segments that strparser still tracks through
skb_nextp, leading to a use-after-free.

A stream parser is only meant to measure the next message, not to modify
the packet, so reject a packet-modifying parser at attach time rather
than working around the resize at runtime.

v3:
 - reject the parser at attach time instead of cloning the skb at
   runtime (Kuniyuki Iwashima, Jiayuan Chen)
 - add a selftest (Bobby Eshleman)

v2:
 - https://lore.kernel.org/all/20260612123553.2724240-1-rhkrqnwk98@gmail.com/

v1:
 - https://lore.kernel.org/all/20260609112316.3685738-1-rhkrqnwk98@gmail.com/

Sechang Lim (2):
  bpf, sockmap: fix use-after-free when the stream parser resizes the
    skb
  selftests/bpf: test rejection of a packet-modifying SK_SKB stream
    parser

 net/core/sock_map.c                           | 20 ++++++++++++
 .../selftests/bpf/prog_tests/sockmap_strp.c   | 31 +++++++++++++++++++
 .../selftests/bpf/progs/test_sockmap_strp.c   |  7 +++++
 3 files changed, 58 insertions(+)

-- 
2.43.0

