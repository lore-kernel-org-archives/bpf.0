Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583DA34104E
	for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 21:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791666177; cv=none; b=EUugPlwiVYK32KV2S65Ezgi4N5TfNqbZMGxsGAcfmqXdS1ExbZOfnLYqwD5Oax4CYPCZdihPjuUY37CpUSFs+CzzBtJ+DboZ3+TtUIBSNIIn2s/lIPLmL1hENCWkhXcvPaEhcz1AHmgmhTO0vnlknAQqAqU6swvPzaJkE5RPuCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791666177; c=relaxed/simple;
	bh=CWB005W1JYdLCvsKy7Ozq6WQtnMeMg9lxlm/MnPEdhw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lEqRGst+jXFJRQCsiHLc7ji7sz8yCWDyeTqx0yLWUR0VLm7YApJxBTtft8F/shwAo0dA1Xgx6VjVim0PIXYVrs6TZy1mXFump+qgF8mF+bw/VZWAtn7uLFApTth0YIoGu+bw+RyaoJDM2kLPVpLZByWwW14pwOsY051Ul+dKPkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=idIOcLWG; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="idIOcLWG"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93e63ee7b4cso72047985a.2
        for <bpf@vger.kernel.org>; Sat, 10 Oct 2026 14:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1791666175; x=1792270975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jcVxPsPHkMv7myJPq9OeT+TVrTGAJUgIg48UHobGlpI=;
        b=idIOcLWG+QVHdypSONwQHE+9TeUQXC+vWFNEG61iof8GBQis7IpCJyFlCtPp13vgHA
         Zrj419D1emcp+DDAWYeSZ7i+8kOLuw9ijFtrlzvZszjte/x4h5KtBXlCblMKwd08l8vk
         PVHprpU36Qq75rE2KoIUOBvm0o1JN5HoE3WGQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791666175; x=1792270975;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jcVxPsPHkMv7myJPq9OeT+TVrTGAJUgIg48UHobGlpI=;
        b=Y5utXh0aOieWTrITloHtwS4qJJNHVz4SlWPLMeNAoTZNmXQy7qrJE0hLzx/vjFmHbD
         5srI21mGvFWFgxMhRC8gqvDmXq5vRbfR5aeD3Cpt+NgBqNtSUt7hqoi2oLmlM8UJhS4P
         rN3cSV8CqiJC8gCT0HUyAhhZpZAyI6e/0fP9ALsGKc3NSnBSYRk4P8qWNzVad30ZRsVR
         FbWGyfTXX1B5hQrgiAprnZ5mI3YJHbDlRSwVAo9asefvW1q7ei9tzx71nv/BS2HZ5OWW
         UPsVs//bzbHnMNA0d/zXQReFEAFFAvqe4KZBAfJzhq3GgsFDOmotzLMf/SRs883c599f
         WS9A==
X-Forwarded-Encrypted: i=1; AKwUvByM5fOyd/6b2FTOH2Vb1ju0p45Tr7WmCrcRPhKgw118M3iNqiSXEY/yQdSrpvq8ek86d5A=@vger.kernel.org
X-Gm-Message-State: AFq9FYLaLhxAgZIThXz5hXt4Uv5VLC3N9QhJVAPpbVRoE6rqr1bTJsts
	X052lC4nnn0iHwF4/zagLAft4Wvy5kaSLpP1/yb+svF8I1m1eSC72kFbiEY4OiXpKQ==
X-Gm-Gg: AYBFou3/uVTggWNc4peKJPOJAFlCf8ZCcm1G7IacoUjzcvq0ZXZ9B6QmT+H7/SRn1Q8
	7r6pkYZliPVNSNUysKwIP6KJFdCAZN/9WmJXQNChclm+GzoThJOWYjjkq7rhTvwsDqNuDzvx7+t
	r1jEbQUA2vEPLr2JEHRAV7duUsRAVUXd+ej5Kv7+nWuGoL6MW2zwnq/ebdgIBaD/biDIJfM13fW
	8e5eQycqM7aqFB2lew0rpaL23+zGS3Cjzu1kDuoqc/bOMA8y3VsnwrihdymhG9F5kJINROfSDVg
	rQAdivaLy3tuBImgDLI7389X62iHooIfLJU1xHBiuG3SdnDv7Ojvui0aHgKjI2aS1Pz0Bm8Ag0f
	4Gwgs4qilNK92z/R5q1nLiRi60JKWiTQVVz8pxPapxJGHWHyetlrH53U8Kmqtfo4FGQr7WZGaSn
	nLG11M5yL+/ExToKHJVg8KmjMyJ7SWIk+hV8JIA3+BBoOqODNcRze1byhUj8BG3jbN8OURk1ew6
	fzM2WMGnNfuEBJaGNnIh9E/UkTa7EIcw7JSl1BGvPif
X-Received: by 2002:a05:620a:2b8b:b0:93e:c12c:f12a with SMTP id af79cd13be357-93ec12d08ebmr821334685a.69.1791666174924;
        Sat, 10 Oct 2026 14:02:54 -0700 (PDT)
Received: from mbili.waya ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb984845csm498538085a.14.2026.10.10.14.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 14:02:54 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	sashiko-bot@kernel.org,
	victor@mojatatu.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	andrew+netdev@lunn.ch
Subject: [PATCH net v2 0/3] net/sched: cls_bpf: accept dev-bound programs on shared blocks
Date: Sat, 10 Oct 2026 17:02:47 -0400
Message-Id: <QDISC-PYC7.v2.20261010165947@mojatatu.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes the regression where a device-bound SCHED_CLS program
attached through a shared block is rejected even when it is bound to a
netdev that owns the block, and closes the bind/reoffload replay hole a
later-joining device would otherwise exploit.

Patch 1 gives netdevsim's cls_bpf TC block callback the device-match
check nfp already has; the callback is the authoritative per-device
acceptance boundary and the defect there predates the cls_bpf core
change.

Patch 2 makes the core attach-time check derive the target device from
the shared block's member set (block->q is NULL for a shared block) and
require every member to match, mirroring the broadcast fan-out of the
offload path.  Patch 1 is a prerequisite of patch 2 on v7.2+ trees:
commit 120977e2c096 ("net/sched: cls_bpf: reject dev-bound programs
bound to a different device") made the replay path unreachable through
shared blocks as a side effect, and patch 2 re-exposes it, so a stable
tree must take both together.

Patch 3 adds shared-block and late-join coverage to bpf_offload.py; it
uses the existing sample_ret0.bpf.o with an explicit `type classifier`
override instead of adding a new sample object.

---
Changelog:

v1 -> v2
- Patch 1 (netdevsim): enforce bpf_offload_dev_match() on the cls_bpf TC
  block callback, closing the bind/reoffload replay path (nipa High).
- Patch 2 (cls_bpf): reject an empty shared block; reformat the comment
  (gemini + nipa Low).
- Patch 3 (selftests): new shared-block + late-join coverage in
  bpf_offload.py.
- Split the v2 draft into three patches; patches 1 and 2 each carry their
  own Fixes: and stable metadata (the selftest companion carries neither).

Jamal Hadi Salim (3):
  netdevsim: reject cls_bpf programs bound to another device
  net/sched: cls_bpf: accept dev-bound programs on shared blocks
  selftests: net: exercise dev-bound cls_bpf on shared blocks


 drivers/net/netdevsim/bpf.c                |  12 ++
 net/sched/cls_bpf.c                        |  28 ++++-
 tools/testing/selftests/net/bpf_offload.py | 139 +++++++++++++++++++++
 3 files changed, 175 insertions(+), 4 deletions(-)

-- 
2.43.0

