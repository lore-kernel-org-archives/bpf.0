Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.30.110
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794486020;
	b=VmBNNsAXP/CzsBXpkS6XBESmuP0bVHvUHBH/yS/qg9LwTHOepW2Oh+H9lbdxk42GOyIK
	 nW5P54xvRr4QJ/aW9KLqVWwTcqodYrlqtcuzBXC76PRtrzopoN2O9xyZb761jpcVDRtzs
	 z9T/gjDhp2fAif2pFTawjNN9epQ846Kkl2egr25axGesGfW/INA2IAtA+KLIS74d4ekjl
	 +AqAoN8qF+mJWJfuqdZLcumszY8z2v8Usqqz7d3Qokw+TAPHEt8suooMTYV7b3D9uxpLN
	 OvTD+Jm5G7eljiMBSghf9t5oB/0cjaMZfP23FesFD6PCoA3p+JUyC4ox60lfWVEaSeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794486020;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UqAiL1iJo++zOrpUVuiW5V4oKItw6i+FFF5j6fUCEVA=;
	b=ysfwSi31+OvI6FX7+yE6DWh83i8642fQy0v+8mEG1MkhHKm/XSvzD+stZqFgW1zRIMyl
	 60nwqP0FZeDnHIKnSN2Gi+KiDpfpvNqYL369mhTjYF/eNVbbUG3fzi6zjD+i+TagilD71
	 hOmytjibRqjJZ4VG1B9ooTo9WGYYISbkvnQh/AYex/UbtcuqJeRvO5AD/6X6iEj3/GadE
	 8IK6SRCx7bDQiJ5CYFMK56Xc0xQ4WzPpvNJvREMhjVAlvHffQyKzlepJBNm6+El3ajPP5
	 3PlHMsOd5R7RKtcrLFw5zVJuNINH9UwkNE9fU8pvSKMp9ofSqwDNQUCmM8akgUsIj4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.alibaba.com;
	spf=pass smtp.mailfrom=linux.alibaba.com;
	dkim=pass header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r5key+SK;
	arc=none smtp.remote-ip=115.124.30.110
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1129606A336;
	Thu, 12 Nov 2026 12:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1129606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=r5key+SK
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1794486016; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=UqAiL1iJo++zOrpUVuiW5V4oKItw6i+FFF5j6fUCEVA=;
	b=r5key+SKJXGj1+bXX49WECb1aClddZsDYgZgjTTuFvz0Qqb/oONqoxmuGnf7swfgpGvKSLoiIdrfmdcu8jF5N51LEII9n677t644c+Iqh8jWtqQuNB5nCVr6w5Ya3pVC5SDDxOpV2PvGZGvPmLsvIVaSZcM+KUntnNihmmZFTsY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R681e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=jinyue.li@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0XEc1a7Q_1794486015;
Received: from aa8c952a0f58..(mailfrom:jinyue.li@linux.alibaba.com fp:SMTPD_---0XEc1a7Q_1794486015 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 12 Nov 2026 20:20:15 +0800
From: Li Jinyue <jinyue.li@linux.alibaba.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf] bpf: Fix soft lockup in fd_array_map_free()
Date: Thu, 12 Nov 2026 12:20:15 +0000
Message-Id: <20261112122015.3356106-1-jinyue.li@linux.alibaba.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fd_array_map_free() walks all map entries to assert that the map is
empty before its memory is freed. max_entries is not bounded, and the
free runs from the bpf_map_free_deferred work item, so with a large
max_entries the scan occupies the CPU for a long time without a
scheduling point:

  watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/u8:5:8894]
  Workqueue: events_unbound bpf_map_free_deferred
   epc : fd_array_map_free+0x7c/0xea

Add cond_resched() to the loop, matching what commit 4406942e65ca
("bpf: Fix RCU stall in bpf_fd_array_map_clear()") did for
bpf_fd_array_map_clear().

Fixes: 04fd61ab36ec ("bpf: allow bpf programs to tail-call other bpf programs")
Signed-off-by: Li Jinyue <jinyue.li@linux.alibaba.com>
---
 kernel/bpf/arraymap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 0ce26b538075..3c908373333e 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -924,8 +924,10 @@ static void fd_array_map_free(struct bpf_map *map)
 	int i;
 
 	/* make sure it's empty */
-	for (i = 0; i < array->map.max_entries; i++)
+	for (i = 0; i < array->map.max_entries; i++) {
 		BUG_ON(array->ptrs[i] != NULL);
+		cond_resched();
+	}
 
 	bpf_map_area_free(array);
 }

-- 
2.25.1

