Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC903225788
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 04:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781152415; cv=none; b=SMJ09WCptEgzs2fsvg6jHH7y06lCIv49uO4fnUpbSjHKq4011rcecp6oj0oLZP0JDDvxGFePw3yZXDTb6jDLhopbOUQ/bhBJK3FQfhka+opIyN9RYbOyQ7TC/gSP0hfkyYVNEsriAHSNyrmL533MOaRhJ7z6p9p7zjCHoWKevPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781152415; c=relaxed/simple;
	bh=/W0U/udYLncDv9LsEfSV4QGDZWt1TafOfr/YSKBgyfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IfDOjxId1T2zlg/8qdu7YrdHiMPD8g39Hh1awjHT1oNMb+UC5Y38pJsRmoDRon1glPH5WWiipmtadlnRY6KFi5O26Sbn6dsTePyYANrM9Kmm8twXkCpnx7SmGQ5soZGJ7cjV6sRhkPNKaCLe0Lx6rSbjL/wbqpp5DD+YSxt91vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvPrFEqj; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvPrFEqj"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c0c3546924so50235255ad.3
        for <bpf@vger.kernel.org>; Wed, 10 Jun 2026 21:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781152414; x=1781757214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HGo2CfD8GEYYcXOuR9CaVUNmMurmqTJup52Dqz8uepE=;
        b=KvPrFEqjj+TPQabGu8WNhyIlKLuMKw/GRmjnCWxlNMLCTAUPH+GmA5l4u/rKAco7rM
         00zRwDV3YDn5Pq+8oVfL5I4E7O/IQi4DZORcCEJ3x0OomQDH0AQLhBirjDP+suOhusJu
         bRJV8BtWSLFKtOIJ2k2zM8qs9sOgv+TADOBgOBigHNMPgf30zEMHa2gxRGAuL/iq504m
         r02qk/6EWaTKCw9X7QbvjNbnwCYMhO/9xwZpkxAJeTaswStr0w103t5+4fHcz9atlIcZ
         tSuR25wwKNprP2cBkkSasaBv0SJOqeyqSQK0v7qVXn6mJPikDViwvhnMcuxhpUn+ZjvZ
         1DoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781152414; x=1781757214;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HGo2CfD8GEYYcXOuR9CaVUNmMurmqTJup52Dqz8uepE=;
        b=S8zR6GOfTtd5jEFiH/8xNE4CwTBTVHF7nngpKhf2gpzp5X0v7ZirPLDhNBOgn+45b6
         dgFQXiDoWBOA3ze2Pf7fuVu66nkVdJZ079kIBuFoHU+1lVT+eWUs2IIDXu5/xneNjtr1
         bwFTcZU3x1W8FYs+F+mut3ajcmWsSCRq2ZgVX4+YBKA/X8s6Ok15hBxfFplFrd9kjs+t
         utja7eZDWrac3RWVQDiTwkCbja9115PMzFS2iOFdf85S67hi9z7aik7AfcyHozwWMiHR
         2VOHb7qGDEMdixP6uWa/rooJUKt9bXbVFUVgge+8Jr4StFM2GykJhidAHDIi1+rCJPvA
         AhbA==
X-Gm-Message-State: AOJu0YwFuezW+rLBO/p3UKSru1e6jIoa3452vKkQLesOaEuuZBZbGxDe
	vHEAdIgDMPi1+zFB/SmkbXOkv8jTOPz3rtp1abi0p9h3h33gDRFadvUvo70GMaNp3CY=
X-Gm-Gg: Acq92OGZDuwZS30IV3E+9kO/L+o+PlaCrFCqwz/0fioT2oabEcZ3wBaX2mpyuG1+DDq
	AoUOtf0qVYkXezQ+X7DZRq3cY86T9C2JmYoBrByzDmqNRnEzzVzr9ZbOP4Uw0UIoX4wA7am944w
	ELkvB81gPbNGXM1diVl7Hr3hiNUIlXwHgAOyT7LRD8+veZCU3XrmOsZ1GjinyXQSaPLuWqwbEmI
	n3VYgxccKptQsJc3xFt3TsvTBYtrCf789UMRcDo9YpjTErAcf+dfcfsFXsy/oVEvVn5O2hRN3HH
	87qcAzbU4K/GGyrAgZKX677lJqefBPFftjQ627tAc/6AWCxhwuth+r/oingc6SMRyfjNwHt9X/n
	4170aSh9bkHj9s33xuL6aI5fyO8UHgFpy5GcNF28lhN1jYs+42mtEUWF9goqipWkQCiSzxjll5Z
	WoVD5Bmv5e4wpZNYy3OBoPoMdMURdAOqUf0AtFPv2BGGQRxT+7MMYYm89WOavTVM+sPLeJyDXot
	Q58FnHm9mcoPb6FzKrDREv7wcQi
X-Received: by 2002:a17:903:acd:b0:2c1:f29a:b554 with SMTP id d9443c01a7336-2c2f21a11f5mr12091875ad.21.1781152414032;
        Wed, 10 Jun 2026 21:33:34 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([2a12:a304:100::109f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c16609e05fsm270794455ad.54.2026.06.10.21.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 21:33:33 -0700 (PDT)
From: Sun Jian <sun.jian.kdev@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	shuah@kernel.org,
	jiayuan.chen@linux.dev,
	toke@redhat.com,
	menglong.dong@linux.dev,
	emil@etsalapatis.com,
	Sun Jian <sun.jian.kdev@gmail.com>
Subject: [PATCH bpf v3 0/2] bpf: Fix generic devmap egress skb sharing
Date: Thu, 11 Jun 2026 12:33:15 +0800
Message-ID: <20260611043317.512843-1-sun.jian.kdev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Generic XDP devmap multi redirect can leave cloned skbs sharing packet
data. When a devmap egress program mutates packet data, another
destination sharing the same data may observe that mutation.

Fix this by making cloned skbs private before running the generic devmap
egress program. Add selftest coverage for the last-destination case,
where the final destination runs on the original skb while earlier
destinations use cloned skbs.

---
v3:
- Split the kernel fix and selftest into separate patches.
- Move the private-copy logic into dev_map_bpf_prog_run_skb().
- Use deterministic DEVMAP_HASH keys in the last-destination selftest.
- Fix the Fixes tag.

v2: https://lore.kernel.org/bpf/08c35c70-a59e-4e0e-91db-22b5ec30b611@linux.dev/T/#m613671b243e8651c47f84bb329f0ea668974c549
- Move the private-copy step into dev_map_generic_redirect() so the
  last-destination path is covered as well.
- Use skb_copy() instead of skb_unshare() to keep caller ownership
  unchanged on allocation failure.
- Add a generic XDP last-destination selftest case.

v1: https://lore.kernel.org/bpf/CABFUUZFimdrZdq=NWi+N-0sJZWvMwY=f4iF6-3TVMS8=m07Zmw@mail.gmail.com/

Sun Jian (2):
  bpf: Run generic devmap egress prog on private skb
  selftests/bpf: Cover generic devmap egress last-dst rewrite

 kernel/bpf/devmap.c                           |  21 ++-
 .../selftests/bpf/prog_tests/test_xdp_veth.c  | 152 +++++++++++++++++-
 2 files changed, 168 insertions(+), 5 deletions(-)


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.43.0

