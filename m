Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CAC47C0EB
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 11:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789815680; cv=none; b=qCXysmLJuwsGiwV59Hl1ZqTcmgQ75iK4rk6a23dkCGfVW+d7rN4ShFp6nixqR3LPm9j0GftTHVlArWMU1KAO55aqHlyx/Lme0XiJYUWM1wIzfz+uGOsB1IoOENEICPLraTiEJ0Wy+QssDcTWL0pC3D8gS3frV5NZvnkb3pmYr1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789815680; c=relaxed/simple;
	bh=Wn9+l2JU84UKw0Yiuc7+aPiX65TB6uHIAEb0BYHiXSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tf5Nkx3nPH+404XXYMVbJQtseIUl298eAqTUoC7QWaZpPTdFridSbloBjWf64+SAKYY3N4O1GZzRXfSN4r8c0BTlGgNTbj/epvtgZ1p8LLD+8iQRRxBTp7urTF09FNUBTvLDg7QvRslCaPqEd+CD+bbd2qdTfx0pw2vaFC1dHZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IyTMN9t9; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IyTMN9t9"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea50dc0so709412a12.2
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 04:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789815678; x=1790420478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=I7N46zResu6Oq8coyXJXO8ECM93/wLky7ePjmFlAAoA=;
        b=IyTMN9t9wzkxDoQGKqLt13m/xtlfT6VEp09EJRUXqlLrtn6xuXxV9WfXlW9pPj0bj1
         S1kJaRW12hQZjH7rWFNqSizWv3fAOxQZIHRG+WR88cf5AhM4a3MVcg11YSEh6kna1NRR
         X1YDYBJxzRW1KtDvzs/OE9tvhQZWteKdzKK9p/dn2xfExbzs8UqVuIdTQV4IA8dbB3s4
         o9uKkDLDK49uIQ5zDQL0WTrIVFkLNh/d1e1UfjQ3g3+j2H/I4ZsiDBmri9j6K4n6AEHq
         h6r4kyA08QTH49++hQcy8vCLLikh3DJx9ZqQtfj0Nk6yaaHKPhbiyI7Kss+2vcDXT0af
         POlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789815678; x=1790420478;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=I7N46zResu6Oq8coyXJXO8ECM93/wLky7ePjmFlAAoA=;
        b=otA0GEEebhLlhZGjEntkYqIT++16jgtkP3R2h1UXSt/pww4Cb9VYxB/99A5c6Mh/CP
         DqNIM3FslWYf++oYhFvzSZJqy03TFJkHhbxfIUcjznQ88BHBTnv8AmM1vghQUIh+F2nt
         M9irLFQjsABNi29wRxy+OiScewXtO+naUaJEd40z037hpUsGbjbEYYhn/Ct91jmv7cPG
         GgWjEynTN7IOQ+VIALdBAz1JwCfo/qzdrUr1n+pasCPCrbQYSLsPjRuDyqUthqVtXJFq
         HWc4M+4UiRbJySuvQd7zoaxHcv8/TmnD3hYEsECEaQC58hRMwmDCRP5l3byxU4/j72Z3
         WFsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzGDGCYo8H4a5moRzw28+rauIxV8smbcGsCBMJ2qII71z1nhJrQ0xPltfK60q5txyd3KY0=@vger.kernel.org
X-Gm-Message-State: AFuF++mXfrQakp2FamdDZxQOctUP6525TUGIOtk+gVOzzl/w/txcm1uR
	EbR6r13TzktaFd913J04OeI7s3RbAhhvFnmYg9N0vx/VdTl0Ge3+zms5
X-Gm-Gg: AYBFou1yX7Qb+WGG0PCS5UtnBs1UAgscDA1LlBxjvHfSVDlJfmHA7YTVDu/3k9vnrZ1
	qT0Ag+InBe2QFdbOb2TGaBblHZ6oaKfnJ4iH27WoHc3/64WDCQPQdchsYzPdvpCrI0kzDWNQb3k
	crf36rZ434Pl98kZ8YPIvDHAKJPc4z+UQCTrpHUUe7j4521jNXGCfdXdEkNK8lJvLE7L0vxCbt1
	PjeJ6BNQrTg8xjB+NBwNmuiDSsZzEncoRxHLMLKvdD2GiO+LPRLVB2d2V5BaYYyF2Wf1ceIL8nz
	ZIZbXKSDEsjAmfSTNraqNhu29tlOekOowIkY25eRU+Hk+svMhu9HsLOA6pNhZ/91L67oOBlou8W
	CodZGPIkqF8ylUgkQ35myR2Qz910PWfq7MZIiSbr+DfeSHPRqujra+hENpu3ieLwTMT/ba/UFRJ
	U/Jsj6rSIdL41CPy1jRkESJk1JkzQokQ5HG1OqSXkWFaUvWFDRwIqcjSjVbSeQ6JOzNHYy8ut5R
	12sZ2+tmt2THY3kieMqC+B3nNeEKfJl
X-Received: by 2002:a17:90a:1057:b0:39f:d323:c988 with SMTP id 98e67ed59e1d1-39fd323d93fmr1553771a91.48.1789815677698;
        Sat, 19 Sep 2026 04:01:17 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c4ba12csm4147054a91.11.2026.09.19.04.01.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 04:01:15 -0700 (PDT)
From: bestswngs@gmail.com
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	xmei5@asu.edu,
	co+ac0a8c41de69121d@bugs.sh,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v2 1/2] bpf: reject dev-bound-only programs on other devices
Date: Sat, 19 Sep 2026 19:00:53 +0800
Message-ID: <20260919110053.497301-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260917161335.1020405-2-bestswngs@gmail.com>
References: <20260917161335.1020405-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Weiming Shi <bestswngs@gmail.com>

__bpf_offload_dev_match() falls back to comparing offdev pointers after an
exact netdev mismatch. Bound-only programs normally have NULL offdevs, so
unrelated netdevs compare equal. A bound-only program on an
offload-registered netdev can instead inherit a real offdev and match a
sibling port. With CAP_BPF and CAP_NET_ADMIN, a caller can use
bpf(BPF_LINK_CREATE) with a different target ifindex to run metadata kfuncs
specialized for the bound driver on the target driver's xdp_buff. Running a
veth-bound program on tun reads beyond tun's bare stack xdp_buff as a
veth_xdp_buff.

  Oops: general protection fault, probably for non-canonical address
  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:veth_xdp_rx_timestamp (drivers/net/veth.c:1673)
  Call Trace:
   ...
   tun_build_skb (drivers/net/tun.c:1739)
   tun_get_user (drivers/net/tun.c:1856)
   tun_chr_write_iter (drivers/net/tun.c:2091)
   vfs_write (fs/read_write.c:595 fs/read_write.c:687)
   ksys_write (fs/read_write.c:739)
   do_syscall_64 (arch/x86/entry/syscall_64.c:84)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: Fatal exception in interrupt

Restrict non-offloaded programs to exact netdev matches and retain the
shared-offdev fallback only for genuinely offloaded multi-port programs.

Cc: stable@vger.kernel.org
Fixes: 2b3486bc2d23 ("bpf: Introduce device-bound XDP programs")
Reported-by: <co+ac0a8c41de69121d@bugs.sh>
Link: https://lore.kernel.org/bpf/20260917161335.1020405-2-bestswngs@gmail.com/
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
Changes in v2:
- Drop the redundant offdev NULL check.
- State the capability requirements instead of using attacker wording.
- Move the regression test to patch 2.

 kernel/bpf/offload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index 0d6f55695..d85539981 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -698,6 +698,8 @@ static bool __bpf_offload_dev_match(struct bpf_prog *prog,
 		return false;
 	if (offload->netdev == netdev)
 		return true;
+	if (!bpf_prog_is_offloaded(prog->aux))
+		return false;
 
 	ondev1 = bpf_offload_find_netdev(offload->netdev);
 	ondev2 = bpf_offload_find_netdev(netdev);
-- 
2.55.0
