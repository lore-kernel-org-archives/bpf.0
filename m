Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5023321B191
	for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 23:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782169287; cv=none; b=Ukm7kUNTQxxL3+PiDyz8Yh+KamQ54Obsf+plFlfrgSF1LuMzbK6nLXy4q8Fmh1srrmo1v1HRt4sd9xB776mGY55JpTMI9qdirSBIAkHj2RpbkQNSOF/d1mWxC4L9Iyxy3WKabZCvHFC28q76MjP4QpJxS5WCXeu1B9x4BcCO0ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782169287; c=relaxed/simple;
	bh=3JBxGBnmq2p2FDhnDtI4+aT0V6p9eLbBXeAWbVZXxEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NVqTehNEBZM78eUzZ1ypxzmDleCK9QQHVsednvx3SOCfC0SK52cUOw0dMR+4WeUNz9YEwxoK8XDvpc7DcdcV5H0w9NUPZZMJVaxdLg3QQQQICfqAnBp2H81QQPWNbTsu/SZUYMR+ICKURPq2x+WWnxrS7Q/OHHIHTKJWW2TMuBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dhXwrePV; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dhXwrePV"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-492329c5514so1624075e9.1
        for <bpf@vger.kernel.org>; Mon, 22 Jun 2026 16:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782169285; x=1782774085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8raFnbe3ZmeHv8tNWRCnm2r9ziZZ3BplUai93sgg1aI=;
        b=dhXwrePVrgWJMf7swRp3i6C6yO+u2zGdcKDz78TNmC/kQkjWoshMQMIAVdXBzalLdx
         AIdI9p4tHT+ixmNpPg6EmcRKqU+P1FOWDSc0HcQ0KiyemwMqXmww67JbtUirTA+iTlR9
         795HT62uRbQmUxt5TxIpagalXgJQ3AccDwsJyaiH71Mef2yrNKY4goAULFLGCe/DnfjO
         5rOLccpftkTdBWbbzEQrGF49lrJI0CQWnFyPPml4oUFzl64u/b0ZJuuKaKxs0cOfANu8
         bR7CsokQWPRdIIaC+p8lv8dBG/n2sYmH08YZRxzW7zVwA2BJ6clfqxJIKSLEBeVBtWdU
         4oBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782169285; x=1782774085;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8raFnbe3ZmeHv8tNWRCnm2r9ziZZ3BplUai93sgg1aI=;
        b=LaVts/raj4ic7kfPRAPmJyZDEyzRYlKRTzxvP/kqw0QgmuXJV85WTkqy1MNI3+++n8
         uVRA/CqglDVLZspxgAOQWD58fik6joKHrxbcSsDNj7t55N4IGe7z+mnfzLCMkPp/nJ17
         j6Am1F/J+Y0hiMrallKbM2kTeT8QwsZt+myfAgqiDmxCSifErkw05yuFbQyT7q6FOPpD
         SF7GKtHp4ukrIZxx9ROEARA0kKqLhD3+1xYmctzDhqrioPV4CC7b0iEY2/TbUoc0U4z7
         CXCJan7qoPrN7Ixq3GU0fVJdmLW1CYJJaW4kKR6bz+YPJY1bXHC2askb+OBp2SW+ehQ0
         MBww==
X-Forwarded-Encrypted: i=1; AFNElJ9B6W82MpR1b0IWhfrkWo1TZBTR5Vog0mSUP4inrkHLWuDfahELxpDEsu0edfYr57lviqU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4+U11y5L097JO37J1nSfOf6laVU1EigUYVWI56TbWWJfeL1iV
	5cScvQAAU9IkyBQo676gIg6z1/qVdd6M1tcAoMwMyP9dgnn3kPnQdpA=
X-Gm-Gg: AfdE7cnknHUILw2Q1Tk5A0t46x35psPsEAFZW/yNPsgFkm/DBj4iMQfQuSLk+swLy7k
	INVu4lgXyWCdkdkolZBD4CDvE0UnxIOqQED4g1ezbYJqPh6aZ4vh8uEKIxKmu0v838u/THhu1Bn
	lZPn3gKuEG7imUCEEX0NOQFn0W/fQs6o34zazSDgDwItbwnvsxhII2iNdHKPa3E7tQ0oZ6n4kWA
	h5FZp0V75Atv+d0zN2V0mSErVB/oUrxGyKyHGh0+dILQnkNDSRPkslEJUn7PmYi9iejMgq5bkBM
	f6pTrTD+8a7Qpaor0X9rab6JN9U/vpSvTpDqFDvwM0jgVAr2IYSROKrxbYphajfm3TwfDXqKeRX
	mnc3g1RL4Oaae6FR+86VNbK2gKx2YuiYWSzOcjcN2Q09vktS/S0kApzmUK3uBj6uHkjPQ
X-Received: by 2002:a05:600c:3e0a:b0:489:32b:ac0b with SMTP id 5b1f17b1804b1-4925a0a9ad9mr16515335e9.6.1782169284668;
        Mon, 22 Jun 2026 16:01:24 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4923fd1fa34sm371339255e9.5.2026.06.22.16.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 16:01:24 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Xu Kuohai <xukuohai@huawei.com>,
	Jiri Olsa <jolsa@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	stable@vger.kernel.org,
	tristan@talencesecurity.com
Subject: [PATCH bpf v3 0/2] Fix stale register bounds on LSM retval context load
Date: Mon, 22 Jun 2026 23:01:21 +0000
Message-ID: <20260622230123.3695446-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tristan Madani <tristan@talencesecurity.com>

check_mem_access() calls __mark_reg_s32_range() to narrow a register to
the LSM hook retval range, but the intersection preserves stale bounds
from prior instructions. Add mark_reg_unknown() before narrowing (same
pattern as the else branch) and a selftest that catches the mismatch.

Changes in v3:
- Add selftest demonstrating the issue (Eduard Zingerman)
- No code change in patch 1 from v2

Tristan Madani (2):
  bpf: Reset register bounds before narrowing retval range in
    check_mem_access()
  selftests/bpf: Add test for stale bounds on LSM retval context load

 kernel/bpf/verifier.c                            |  1 +
 tools/testing/selftests/bpf/progs/verifier_lsm.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

-- 
2.47.3

