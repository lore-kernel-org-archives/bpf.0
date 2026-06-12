Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AFF3E6386
	for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 11:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781264452; cv=none; b=mN6UsztAjMnYRBlsgX6UJwgIL2AlDKjJcXEQ7sG8PgNIrf9ZRTs7gKt2yKfeXMHfPJJt7O/B1KeuBf6m44BI963yOdH5On9ldb96zaFIxVPmXiw83bPYt+vURbxwNijX7OqwBlsrDvm52cUxMvbXZwErfQPgDpJAAWHGOATzwdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781264452; c=relaxed/simple;
	bh=+8lv4XArd/KwhtE8lU4HJ+brttyOEuvASR41k7r5TA8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=JCGyE8WgbUakxlkp5AHggjadhqXSlGVL5D3qBKHUTTLnfF7bfOFyG2AbnjTyTv2AwNGuqSRJsGCcTvHQp4AFyCMHilOh4jPrVX/VK84shquctLfujsNYjKSOCSs2KsvCJ34CbR6kuXMENKvcoZ5U/MFLcFrKVKpmwek93EDJbHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTLi//zo; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTLi//zo"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c35980fdso8381875ad.2
        for <bpf@vger.kernel.org>; Fri, 12 Jun 2026 04:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781264451; x=1781869251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3A4DI9oNtTuCvLmw1xW2OUzcOaOyUCmbNpOHdpzsdg4=;
        b=DTLi//zoU2/xdLbXTb4+wkj+x5uATOGdWvETmUQyuCOGcgh/WeZ93d/uP4P+0j3Xi5
         bxjEq2tsNy/L3HSRW9TBHC0nmglGGilRUXUHZEizIZ2djuuaqdHPEB1kUb5tmn1qMGjO
         Yw1kRjao1IAAE5Y+zUU2/wzSkNF2CtV+kQPkfSQe9BiTeVPnChYpYc/FvnoGmT/Me7wl
         3cfauM/jxh5SRC/jnh2BRR6FyXJkXF+iNpukDHY+UIkQv31FpeY3cHoenuSSU5iM+HBU
         nVtv4kB+ue2lovGsWX9DjNnNLrpdWrBYGspUDgnNsnD/GsLP2ef9ZMSzJ0g1SiyNyceU
         1itQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781264451; x=1781869251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3A4DI9oNtTuCvLmw1xW2OUzcOaOyUCmbNpOHdpzsdg4=;
        b=a4RYJz/RvO9yEdMa/UQxJhyqWTUJ7KlsYzKkWTbpumWRN1yjAUxyc7h3LUjWl4VlHp
         Y5R6NGzYYA5f51UED52XjdtiJMrjpt6R25W/8Njfg5DZaHiodjMSQWiScpqvnTOKsfw4
         LvLhvqt6BWeCgsBAkalL4V/XvzBfSkJp8F37s8R2Hrzo+QI2HaXw6WwK7lNVElzbjeZy
         AbFcsoLH6mubHFG9z9dp1Tw0kOoXQxvhAnN3k7rr3LcOauupw+6j3+jkQ0JN4UxKkND5
         /57M/4cZGHrSRuDQA0wSgjzJ2EaXhobLRLaPJhDzaWgl8YAMCSVvnaR0lH1g36G+3Uap
         fBVA==
X-Gm-Message-State: AOJu0Yx1+AnoQmiKHn9WA3HGpvenw9NTWhtKLo/VA0swFgHesSkDjaF9
	qeQbZRCzGSsJVbSJe5NJHwvfQVpNjF3YOyaluEXZUuOKCptsnpd/yDZdGoMexH2Yv6o=
X-Gm-Gg: Acq92OH8+2ryMUpDY2bqsUzmFpGddzjLQUTUAZ5BBAwKYfRu5naXEFC5h3z/II1+zXI
	4NMCElTSti2DIWajXWz2Ho5n8sp/X/iCH4JH/USVpKU5mS5eXEyc+xN2nI4kJ2nWMj6Xfxp+KIA
	Gn3mjKVL9Hyp1Z+7tkcYdlciGQ8C9VcD9x4GO0sHRMdMu2cRBi3inu7KNJomSJrq+Zx45s4fh5B
	sod7EnxC3xuMjhwTXXQLZDZiuElMq+viMVJ4EvRuqKh53JXsB0QDKEHWiAheJfPnNAtodFZbe4S
	mnVtJRKI4NdniiF9xnBNu80hBzfPPodZmct35C0PbRp+51LCkbqZ4Bcylzot9dH9MgS6p2hhFgu
	XXzZut22IrAI9PY579WwsOSlvZ6tGCuDPUI7uDsWrP1FXxGd0grH5Q7heRQI5v99tAoxXaAjVdM
	DRdS3ElRj1bxgKgXJoXMQ0pO5A4fSq4I8xhjUvolBv+hhKqyyarpR6M9uP9E5vBVNEUQNsXHjdo
	fe9jCTsGisC
X-Received: by 2002:a17:902:e54b:b0:2c0:bb2d:a314 with SMTP id d9443c01a7336-2c4129391a8mr31141165ad.28.1781264450591;
        Fri, 12 Jun 2026 04:40:50 -0700 (PDT)
Received: from localhost.localdomain ([45.142.165.58])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327ac72asm20697455ad.38.2026.06.12.04.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 04:40:50 -0700 (PDT)
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
Subject: [PATCH bpf v5 0/2] bpf: Fix generic devmap egress skb sharing
Date: Fri, 12 Jun 2026 19:40:30 +0800
Message-ID: <20260612114032.244616-1-sun.jian.kdev@gmail.com>
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
egress program. The private copy is made in dev_map_generic_redirect()
so dev_map_bpf_prog_run_skb() can keep returning the XDP action directly.

Add selftest coverage for the last-destination case, where the final
destination runs on the original skb while earlier destinations use 
cloned skbs. The test records the source MAC observed by an earlier
destination and checks that it is neither the sentinel value left in the 
result map nor the MAC written by the final destination.

---

v5:
- Move the skb_copy() check back to dev_map_generic_redirect() to keep
  dev_map_bpf_prog_run_skb() returning only the XDP action.
- Preserve mac_len after skb_copy().
- Use __be64 temporary values when updating mac_map from userspace.
- Initialize rx_mac with a sentinel in the last-destination test instead
  of relying on -ENOENT for ARRAY map lookups.
- Adjust the last-destination test topology so the checked earlier
  destination is not the ingress/source veth.
- Split the last-destination check into two assertions: one for store_mac_1
  updating rx_mac and one for detecting last-destination rewrite leakage.

v4: https://lore.kernel.org/bpf/20260611080850.536996-1-sun.jian.kdev@gmail.com/T/#mf830f03d362f33e0941d1b0e425169698fce76e5
- Preserve mac_len after skb_copy().
- Separate errno return from XDP action output in
  dev_map_bpf_prog_run_skb().
- Zero-initialize net_config in the new selftest.

v3: https://lore.kernel.org/bpf/20260611043317.512843-1-sun.jian.kdev@gmail.com/
- Split the kernel fix and selftest into separate patches.
- Move the private-copy logic into dev_map_bpf_prog_run_skb().
- Use deterministic DEVMAP_HASH keys in the last-destination selftest.
- Fix the Fixes tag.

v2: https://lore.kernel.org/bpf/08c35c70-a59e-4e0e-91db-22b5ec30b611@linux.dev/
- Move the private-copy step into dev_map_generic_redirect() so the
  last-destination path is covered as well.
- Use skb_copy() instead of skb_unshare() to keep caller ownership
  unchanged on allocation failure.
- Add a generic XDP last-destination selftest case.

v1: https://lore.kernel.org/bpf/CABFUUZFimdrZdq=NWi+N-0sJZWvMwY=f4iF6-3TVMS8=m07Zmw@mail.gmail.com/

Sun Jian (2):
  bpf: Run generic devmap egress prog on private skb
  selftests/bpf: Cover generic devmap egress last-dst rewrite

 kernel/bpf/devmap.c                           |  12 ++
 .../selftests/bpf/prog_tests/test_xdp_veth.c  | 166 +++++++++++++++++-
 2 files changed, 175 insertions(+), 3 deletions(-)


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.43.0

