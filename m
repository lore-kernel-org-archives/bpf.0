Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23AC72D47E9
	for <bpf@vger.kernel.org>; Mon,  6 Apr 2026 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775490772; cv=none; b=NnrKBfCY46gtyvKBfCoIzP8yBOcHCW6gm2a0MRs08jeJfDmAoKADBfBztZrBZeZGhJltM27QeZ4SoVdyx7q/vykf2hixdXWmTbbMUP8npePKQASEheqzzyV87A14Ine8UoBXllkesho9r8ZEgw+BSgSjdIb0jL8tDujumzZfzLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775490772; c=relaxed/simple;
	bh=m6jEtVqxj5kObYx0cOCK5SdoqJBZ7KCeJwdHeyTsJOE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nrl8MUbF8DzV7gMIiKweaY2ishVexaXN7GTElk68Y/TnC4GZZtKcS6m/S3mv5b/9K6h1rBANBilp7K4emsRKRa7o9ewhSImdQPplPx0W5fJ6ninxNaVmV70MTcXodvKrR+ElpI3k2ei19NJtXk2toXHeU+k0hwhT/7LlnhN0QY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zr6kqJTG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zr6kqJTG"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43cff5dafc3so3573521f8f.1
        for <bpf@vger.kernel.org>; Mon, 06 Apr 2026 08:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775490769; x=1776095569; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TFpP1TAegqsPhi5Zj9RyjpaFguoHV2edV3mpwnCY2ac=;
        b=Zr6kqJTGT842uGc8tPelyupVS5i/rXTLFNrIqPYQoEfPHNa6ykqy2dizPM5wWtVrzT
         519f5ktBcJ8uDz2qr/pbimHWxCNGeUgNSRH1ZOMrLPgqTCgf/L6LCKWiYeOUdpIGaZpY
         3PZU6wT0wdxLAI1nYgxwGFgDrLSGPoa44JOCff+bMlxmOSF7QeVbJZ79WOLJ/IGF3/Yh
         yrvhdIWC4+gBTvHVFAveDHok5JvhfuAVrgVW+HSTLoVImrCUokWjQmrSVyaFlRJe16zG
         psWiKoey7fQYvac7+hb4Aa1cNNsU8Rn7IvPGXgdgUiM8IT+FuGO4vSw1XK6K9L1aXZe3
         nD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775490769; x=1776095569;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TFpP1TAegqsPhi5Zj9RyjpaFguoHV2edV3mpwnCY2ac=;
        b=rIzKC4EeKvTJcaI1SKPu8UDpZ6p5wdKJcY1wkb3W9/hGousSWsKw31zvSeOTYwfHQ8
         isCwSI45lg9OeIzaA8qBQOfBKS13zy+zpAN8cPtaNSVbSQxbHdAFxk8jpY3UuwKLiFhp
         oIv6bymuELaBe7jK9RSGiHZKs7i6Yu6H5fZDm3sMFnzTydUFtPoPYRkEntUI+qn6EGbV
         3VfaMY91deqMMGbNEeF48NNU6GZrIteXz3nqL/E6t16asZwZ3xtE59McBeQq7XAfGwVN
         RRh1L0JzABK1/iwg78a9liosfI315rlLth4Tlb6Menzs7ur6Vv9JtECOSO029z0//h9J
         qRzQ==
X-Gm-Message-State: AOJu0YwFVoRGgCKFB3W1apIPUHaDAlw0Xr3hEkPxPDSyTpFsYdCbdJdC
	YdZILBdVrecHMjOxMk4zcJFazZVHnKIjAG0vTX+Hy0qUWIyRW4sq+w++hwAGdg==
X-Gm-Gg: AeBDietIyhHukoUVB76ZnXHMFlU3vclVl8PnJhiLcVp1OFatPaclQ87YMwxzxAUt6ji
	Uoeg0uZSVeQzIb0EQZmmoCxR+7to321GXRCF358fJfKTT/OADwYCPhslQmzOGxcrtxzrgN5UA64
	mMpSA/V33s7gOlFOv3wVdC+rBknXYmsCylPLloNPFD17ueXo/iiQCmtcakZ7qE5gLByjedFfY4A
	QuHjOjh4zTNHVct2imBUFrZP3H/GEfqyiwl4LkXKOLETicRpP512vlcPeASR5RYcv2UxlQg5UVa
	GudzXrZT2fRyqax/9ES8YxmhMYK3lt52xsdWSZmAconq7IHwm7/usCnQQLMxOvCs9nmNmb0QqLj
	3IBM+oA3tvRjAIxyq/GMtc1uiBiQdessDNRtdMkgmISAEbnG6zVg6RxSEc8GOkl+aAkgRcONneZ
	bymVvAm1EvT0SLkcf1Pu4IpD4GKdRaQFIbfrSdsjdA9g==
X-Received: by 2002:a05:6000:26c3:b0:43c:cf25:f29a with SMTP id ffacd0b85a97d-43d29267fa5mr19629568f8f.8.1775490769058;
        Mon, 06 Apr 2026 08:52:49 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d1e2a720dsm42114802f8f.4.2026.04.06.08.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 08:52:48 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Jiyong Yang <ksur673@gmail.com>,
	Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v3 bpf-next 0/2] Properly load values from insn_arays with non-zero offsets
Date: Mon,  6 Apr 2026 16:01:39 +0000
Message-Id: <20260406160141.36943-1-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PTR_TO_INSN is always loaded via BPF_LDX_MEM instruction.
However, the verifier doesn't properly verify such loads when the
offset is not zero. Fix this and extend selftests with more scenarios.

v2 -> v3:
  * Add a C-level selftest which triggers a load with nonzero offset (Alexei)
  * Rephrase commit messages a bit

v2: https://lore.kernel.org/bpf/20260402184647.988132-1-a.s.protopopov@gmail.com/

v1: https://lore.kernel.org/bpf/20260401161529.681755-1-a.s.protopopov@gmail.com

Anton Protopopov (2):
  bpf: Do not ignore offsets for loads from insn_arrays
  selftests/bpf: Add more tests for loading insn arrays with offsets

 kernel/bpf/verifier.c                         |  20 +++
 .../selftests/bpf/prog_tests/bpf_gotox.c      | 123 ++++++++++++------
 tools/testing/selftests/bpf/progs/bpf_gotox.c |  31 +++++
 3 files changed, 135 insertions(+), 39 deletions(-)

-- 
2.34.1

