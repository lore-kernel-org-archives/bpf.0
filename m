Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE17133E35F
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 05:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777009107; cv=none; b=YllUhJqJ4NzI25FzpNCqzsey/WA4nXKpYxWAu+WAUnd3wd3s0ixKKH45slEaVUDVIC4MrOrvLrEVQjRX37wHDAdQ4rrroy6/UDipp748u6dF9lkf7P1CyZznZwnqdB7Kzgq0AqbJRaWw6k6Hw53VGnGR1xRbQot7keXIK3Ao/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777009107; c=relaxed/simple;
	bh=jKUtYQkcUdb6GMiVBeZKnn2Sg4Wt48SXWC8LTq8RAjI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pN0sTW4VE6/eHSMCnFrkKUApouGZ6mGiEQaH8sFIarZPULSzTYxnAe68ebHDpzE3SyydhiZ+EzP/wmAOD6b4+KGFI0K1AI/D5lOgs1iXF1wWVvlqnuijRuN1AZY9xFag7M9QldSJT/KOdXxSKtOlKPeInM17arDcWsrpnpDkP/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwJA9U35; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwJA9U35"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2b45cb89f7eso48188255ad.0
        for <bpf@vger.kernel.org>; Thu, 23 Apr 2026 22:38:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009105; x=1777613905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SvxaDNg9rd7ZuL5f80UF/S9IKmmFHCybFxij/pdjuYw=;
        b=NwJA9U35rCIFYqCR/ys3E7KG/rfMKTN1rm3AaFVpq6l1wkllhf9g/riwxgoScSsqRb
         gWgudmmZF0S5qY4cKKdT6pKSTiRgyCcBw2vG6yBVcWrv1SX94q4ZxfqX+cO6ILecvXO4
         j7/Pj8fyiOSQhU4BT8yDreecJRiI8qKJWt2AiRqAdfHSB1BmLco8mJNV+toe/7gfrU71
         P+JFGmJCk+gExQxWK13QcCEHz02yy2Nk4Q74u65svT41cbzQBTPfAbElJBvQwvry/MN7
         6DeM72QCTZMuofN+h1EoscsdcQOVj3ZKGAGbVmehVZjEYE6cNQA3ObfTYVgXMRHs5QUd
         Z2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009105; x=1777613905;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvxaDNg9rd7ZuL5f80UF/S9IKmmFHCybFxij/pdjuYw=;
        b=hpmyHLuyRS+dSNjwFyGrK9cyE/6wvq/RJetFHfxNR+HNlsp/Zy/ph+qQ36BwT0J/BE
         +f87ThILGVz1nsOJm5Kb8n1ycgIO7niuEonsdqkg0rV+h48e7E10E5O2igW8HjKTdO8Y
         0Y/OL5dbrSlB/q11gf2/uDAsYQJRAps7tmu8tLq8RAjiEX5melJMoLB9jmUf2M09g8+C
         ceZAk205P0q5MhagUJSK007FwjlEC8aY3vuU9WAQYsY3NgSv1gHx2v8TkKchasdxYxvU
         opaWAMHvzyW2Jvd//AnjE83zzn06+x0dygOSp/fuPjdXY+KRYpt1J1wWYeUu4P1mNe5V
         AN1A==
X-Gm-Message-State: AOJu0YxLPal90v47gXSuMs4gtJSwdmG7JjAU3YyWs2Z+qZeerFi1vAic
	ia4JtK8wfTb0H7+2y7bVBLZGirctHBEDzfCKglrRc8wnsPg/+XpUcY0k
X-Gm-Gg: AeBDievw9NNnsySMECOO0/g2njZfCtc+0P0LpqrixkDdKDEaI1XjnQHCeObDpG1VmMZ
	vli5oMSuhmX4bHsPzQs3qFR3fBfNk+Xqr2IuHlel55p1yK0STsRayIRrCjGPGhT69iDOprX2oS/
	8AkTZgUP+4qqR2ISxP2MFeycLMvPY+wmJmQGbSOty+AdR9piyvptoPW9SQaKCeDw9Qzxcm2p7W5
	2AK0QB53pWhUmfUXWj9zGohmeurVDpPDMxR5uIfLuyVhyqB9Fi+YpD9C3eg/eIlVJTcXE3+tiD+
	Sg694e5WwbtQTZzyBzS54VwQwpPZ3GC0wGSA2lH4YBb4jUBJXQ/gSEtDP0dum3/fDprVLl0mpDt
	mRT4spXcHdTesGzJwf3EA8Nz4IuuHx26bzFblpCGE1Sfr4v93Pdh4QreqLFA0XOAZnFz0/01U/o
	Uets0J9T26VT6SZD6hvgtjZYSWlePUfi4usKh3Dj2Do5Zq0yC30WWZwfVn18fl9M7KFY6jA16fl
	tH6DAxr1Zb18+lh/WJMfZRjwh3RgyTzgvRNkMiN
X-Received: by 2002:a17:903:1b48:b0:2ae:c5fc:b2ea with SMTP id d9443c01a7336-2b5f9f5f84cmr309649415ad.30.1777009105137;
        Thu, 23 Apr 2026 22:38:25 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab405f3sm209444725ad.78.2026.04.23.22.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:38:24 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	jonathan.lemon@gmail.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	aleksander.lobakin@intel.com
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net v4 0/8] xsk: fix bugs around xsk skb allocation
Date: Fri, 24 Apr 2026 13:38:08 +0800
Message-Id: <20260424053816.27965-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

There are rare issues around xsk_build_skb(). Some of them
were founded by Sashiko[1][2].

[1]: https://lore.kernel.org/all/20260415082654.21026-1-kerneljasonxing@gmail.com/
[2]: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing@gmail.com/

---
v4
Link: https://lore.kernel.org/all/20260422033650.68457-1-kerneljasonxing@gmail.com/
1. fix 32-bit arch issue in patch 8 (Alexander && Maciej)
2. add acked-by tags (Stan)

v3
Link: https://lore.kernel.org/all/20260420082805.14844-1-kerneljasonxing@gmail.com/
1. use !xs->skb as the indicator of first frag in patch 3 (Stan)
2. move init skb after it's allocated successfully, so patch 4,5,6 have
   been adjusted accordingly (Stan)
3. do not support 32-bit arch (Stan)
4. add acked-by tags (Stan)

v2
Link: https://lore.kernel.org/all/20260418045644.28612-1-kerneljasonxing@gmail.com/#t
1. add four patches spotted by sashiko to fix buggy pre-existing
behavior
2. adjust the order of 8 patches.

Jason Xing (8):
  xsk: reject sw-csum UMEM binding to IFF_TX_SKB_NO_LINEAR devices
  xsk: handle NULL dereference of the skb without frags issue
  xsk: fix use-after-free of xs->skb in xsk_build_skb() free_err path
  xsk: prevent CQ desync when freeing half-built skbs in xsk_build_skb()
  xsk: avoid skb leak in XDP_TX_METADATA case
  xsk: free the skb when hitting the upper bound MAX_SKB_FRAGS
  xsk: fix xsk_addrs slab leak on multi-buffer error path
  xsk: fix u64 descriptor address truncation on 32-bit architectures

 net/xdp/xsk.c           | 65 +++++++++++++++++++++++++++++++----------
 net/xdp/xsk_buff_pool.c |  3 ++
 2 files changed, 52 insertions(+), 16 deletions(-)

-- 
2.41.3

