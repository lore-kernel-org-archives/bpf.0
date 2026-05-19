Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8772DCBEC
	for <bpf@vger.kernel.org>; Tue, 19 May 2026 01:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779153296; cv=none; b=Dg5LN6X4wOlUDskap2imncOSbBdboSx/ASw9wTKD+CdRzasHySodz68Qs6UCqaPaWHqhuU/TuJPMExOG/5XY1GEHfuyqd6AYwklmgeCChbSeAwpe5bkll8+Sken0PyYU4tGcd4iG0RsXS0Wjxsh17DpyqGxeUuKBy0vsJEdwCBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779153296; c=relaxed/simple;
	bh=Igsm3oxor1NmG7ctWOUK21kWAYZ61FBo8tfckEPmXpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLtZWKHSNlC6Md265S7xAYBRl0s7dn8SviPrBuRePtDkQjzyViaBmQDfLiItO+OgidmcqbJz/E9vOSsRx8GhV6pjxBY04bAlwOthxefFr5QArZKsPLYCl0sN74nQPqmFTTg2CWxpPMUzKSLRqg635GsNj32CwUsXVMlbuaUlhA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eLR6LAXa; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eLR6LAXa"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-65c3ea2ebf7so3445285d50.0
        for <bpf@vger.kernel.org>; Mon, 18 May 2026 18:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779153294; x=1779758094; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+pHowqh9r42OD6gFgijxJ3jwoY5jHJEgSSTj0IdNQS4=;
        b=eLR6LAXa6S0x46K4qZ8bnSPWYI+pyyS4dMR+hHNT9HkWxktR8r9ppXBWzgZDxGvKLG
         8Z1axXSDA1El01u1uYpp4XXk9lsvc3sxIg8BGE3oEBln35eZv0caHF6uA0YqC3Bhm92k
         ko1lvFz+OV5eFbOSdrwITYVB97yKcCDcbimx1JtrWXUjBUXWkjQB8hyTV1Qnp43cywJZ
         qkrL5lHHMfZsUwO2Kio6wfypfsACFMLLv7sVbpj2YQYKnGwEnsh4eFMOpDerernhJloK
         8swfKFTxdf8b7hY5DiKajDWRgAFAJbA0onkrZkOznKw4DPoqA303DDBLocsBODAwdzqj
         KPVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779153294; x=1779758094;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+pHowqh9r42OD6gFgijxJ3jwoY5jHJEgSSTj0IdNQS4=;
        b=o9i5f4lReMZnX8nQV9soqBuIgbWWmfxm3KaXdQnVrLsBHh4KL2SMR8XpX7ypALPOQf
         SZ9SF6jDGVjWTV6nUYj/mx2eB7gVjLayTnEkFmE5dsAQ1cry/ZswCsZ+35PU0qsQTHbU
         htDkdUUQ3sWIiJiF8sJlmMGsEgOvJEwUHqDt4B4LuyxACDL20t7PFm1cSEFvq9OrqmQ2
         CVzf9qyRSoagb2T4JYEyQPQqkNhuQ6dYaozhhh3N24Uz/ombRQA5CA2oI0kJCaD9Y52j
         WC8K55O55L3VC6CUuyGeNp31EsplLPGWryYu7vaRyKPTwn9rk7Q91rdW0yv5bd2hOv6x
         eFfg==
X-Forwarded-Encrypted: i=1; AFNElJ/oSl1buZdcsYQAp08Q/4aN0wtNrOTcNVBBSBfkxGnoWKAuKRO24s9gg2CXyqqBDLVd/wU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx63bZaiPQ4W65x450RYxC5n6hcGuhriKg50btvY3rcbERexWEK
	01kZCaJfUoXe8mzBDwELPOqfeCM/h36t7oK9s7hv6mTwtMy9d0Ns13vz+Ua+RGUe
X-Gm-Gg: Acq92OE9+TVvA6mySFJZV2x2hRAsXFOdKlw2wyXdAnmeFG9wbEqr3aT8M8GEdl6H0Ij
	HI6Mc0rvSS+J7gF8qdX2XjbJ2g/YzMo7zNmxRNzGQlLeNq7apu0iC/iEBQhXZK3Dc/svDRKNagP
	4cTN6WDomORcAnv2XLs9SEN9nLEDsumeCFsGIQezwG6ziOmMRbCTIBReKxhE8mtdXu04M2JPuSN
	BQDRPAHMZqyEHgaQ94lY3XCCXyBW5fbbms+5L0Q39y5pLeZBYxasQ+JTHTvsY0kBKA5vPzWkjQp
	4WH1Hr5gCbUmy1C/T3mGIqTrU/oUzD5YhiWVm9sML36jXnp3U/n3JIFO8yIUv2IrTt+ZqQ/5V9b
	NDsrhhWqMVLkZBFTJRgK2gw2O+LPQt3h30ViWiTnbZq94i0NdXERc2+hIPrXr6x/KxCZWbCd8v4
	treqxRqPok0+bUgFb/Oe4BavGbf4I3CxjtZbNmFo6/NxvNs1w3LtCthbwOl5Luejy4NabgT0xt
X-Received: by 2002:a53:c04c:0:20b0:65d:b6dd:69f3 with SMTP id 956f58d0204a3-65e227f6c40mr14246463d50.36.1779153293924;
        Mon, 18 May 2026 18:14:53 -0700 (PDT)
Received: from zenbox.prizrak.me ([2600:1700:18fb:6011:ab86:dbf9:c4df:2e70])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0b11esm7118675d50.11.2026.05.18.18.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 18:14:53 -0700 (PDT)
From: Justin Suess <utilityemal77@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	mic@digikod.net,
	Justin Suess <utilityemal77@gmail.com>
Subject: [PATCH bpf-next 0/1] bpf: Fix deadlock in freeing of special fields in NMI
Date: Mon, 18 May 2026 21:14:49 -0400
Message-ID: <20260519011450.1144935-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

While following up on a Sashiko report [1], I found that referenced kptr
destructors can run from NMI context. One way to trigger this is from a
tracing program attached to tp_btf/nmi_handler while a map element is
being torn down.

This is a discards any approach from the previous series [2], thus starting
fresh with a new one.

This changes the existing eager freeing behavior of bpf_obj_free_fields to only
freeing certain fields in irqs_disabled contexts.

These fields not safe to free in irqs_disabled contexts like nmi include
BPF_KPTR_REF, BPF_KPTR_PERCPU, BPF_UPTR, BPF_LIST_HEAD, and BPF_RB_ROOT.

The freeing of the fields under those conditions will now be done by the bpf
memory allocator, which has a safe destructor mechanism that guarantees the
fields are freed in a non-irqs_disabled context.

Some changes were required to the hashtab map specifically. When the above listed
fields are present, the map is converted at initialization time to the non-prealloc
variant. Additionally, the in-place field updates used by LRU and percpu maps were
disabled when these special fields are present, to avoid leaking references and
overwriting those fields when we can't free them immediately.

The relevant discussion for this change is here [2]

Kind regards,
Justin Suess

[1] https://lore.kernel.org/bpf/20260421010536.17FB1C19425@smtp.kernel.org/
[2] https://lore.kernel.org/bpf/20260507175453.1140400-1-utilityemal77@gmail.com/
[3] https://lore.kernel.org/bpf/agCXEJKJh-JGMhjG@zenbox/

Justin Suess (1):
  bpf: fix deadlock in special field destruction in NMI

 kernel/bpf/hashtab.c | 93 +++++++++++++++++++++++++++++++++++++++-----
 kernel/bpf/syscall.c |  8 +++-
 2 files changed, 89 insertions(+), 12 deletions(-)


base-commit: 576482b55c19e7ec00e162a0fde4c4f1a95128c7
-- 
2.53.0

