Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C063ED5D8
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 13:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073195; cv=none; b=o8F98ft8cxBUpUuQDuwqnKNfgxN3oO9EQmABw8aMWEgrl7hMyTjxkRs4zGDvm6hF3SFPfEQP7dDNmDruskdGxSmyXka4Y0WSFqKMcK4iDG+ic9Ij33NUzvuxRvRN7Oy09FGbAO2I9Wi+rqV9zYFxm5jhQZ/gw6pnA9FbJ8/iXhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073195; c=relaxed/simple;
	bh=Rg3jO2w24i9LpX5guLk2D9k/ZTOfMWtvu3JERQPPmJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cncwONTYET1LUSDxFH/45GMHHYG1NLnQy4htHpMPpJ+Gudud8ECH4gfrNYy8tsKYMbH7c0dJ4S7QnCLeylkhPKbBKCDXSEzZU+ak9n+4OQbQdU23pwSDhUa61AUj3kZaAjraWZXSg4rroUUcrh2eQ7QPQKkPvdcczQVc8xPBV8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m98mJw7t; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m98mJw7t"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-44da2de25f3so2327261f8f.1
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 06:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778073193; x=1778677993; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oJJSTMiCwpnLKkCV6YiZOpx3mUtt99s2sNjfEEGSMEE=;
        b=m98mJw7tmloGARhJirymsaCBlDto0RHgjJW6xJbY0P5gqlNIjh26MFmbCvUPGENhBj
         eUrbkfsmAnl1aYeE/ON3xA+P1w2D03ELVZ6xzDaRG6vjNmdbtRxVQI0qxLE+Imr4K6aw
         kz44BCzigtYN+Fbw5noyQm4S+f2j/hR433SAU9pbfg0T/n5DBqAgyHrLkIVTKj+k7bh3
         e4dqUwQWg4nQ9S4BWsUGO8PuOhYggr7Jt8NBSgRJBShCZPuKy2OO3FXpa7CBLeGuiyD3
         tOwLFnRI56Op0DwE/OZOrNpPC/QdD766omDWBoxp6BI5kFUSsjyCEpxW2fQPMnOJ7aaa
         lndA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778073193; x=1778677993;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oJJSTMiCwpnLKkCV6YiZOpx3mUtt99s2sNjfEEGSMEE=;
        b=cJ44UHM+gQ2skCz7BjBliahgH5C51YBdiFDMOKRfZ6tdoBygJfbc8/iQguOh3nTuIm
         MjtXLLE03aAbMXOKrpk5ocvWWfhjn2h89Ap8cSKUNA63JDiPjSMC8LFRqW5O8JWyI2pn
         3+sP8v3R9TxsnrHz9nNr24mT+QkpcSzq+Or0L5AoxzyuYfsG4MnnrkbDJ+foJw2c2kHY
         0GunBmKt4fdw4gERurYNWmBqLCzYpDUMDWwP0nTZnTiki0iD11SViKNz/ySEuDT2GojM
         xfpBzOtd1pPZmAbFpegxebUhDmZsoTkk66xSWy5xTv1Fejte3ZQ8LEaG0CYQmmiH0jkQ
         la7Q==
X-Forwarded-Encrypted: i=1; AFNElJ80mKy+xBx9cLbPHXdzdI75OPG3VkbvpeoQovKiS1MA8I6NhSe8AfG7OGl3jo1iZa0a3pc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxT4Q/NTm0iMVI53aTIGi+e0eXG805GQLkM4l/DPVW9MioB/+Ep
	Kqp7FvM/BMHVSzLuqlFVJcYAqiQOf+CFzbpQ7x0bp3UIKv3moyaJ2Y10
X-Gm-Gg: AeBDievRCWsEXt1kYOw9qc1/Yj+7TF0i0UGgzVykGy0DuehH1Zx1EK+/X7F4D+Ob1Xa
	poBtz3vojLwq4GXxY2r7pBh903laBqnBOc98PITRVsmVlDmAqCeumta7pATaQTGYfpeBTUMIiNM
	zVFEqLxz9A6l5wzXtzA+Y6zNGFX5ZV7fDf84braCUmLx6hf77yUtJsjW1VUTmNHVGcCmjxJiQQr
	MYVWSOKPcEcX8sx+S2q8aoG6qHtJstPjSTuMJ1glVZ67FBzlCQhG31VPe5UgC174GtD7GFN5SBA
	gTdaKSMsYSbX6pF6TlWo8AD5J+8v2JvZRZruOGZAsuuBo+GJuCWkilChMPYkZ468KO2BfsyIuvu
	MElFsCW0KHIget6IOk88HyFMJNUgSfhqkxeGKkGRM5FIXKwBbeyQXD2EB3LLzZKX8cnmaGq8DIu
	TSimWHA69s/dAQMbSf4tyNHJR7jBVHiNgjlcpo+K0rviQoJ4gJ/7sTsA/b72tEez0SGkjBt5AHP
	K634UozjsVqXoWn1C2VR933fayrPqsVRzHNXt2TXMU++R0WIgqtz2NzseblOmUGzQ0=
X-Received: by 2002:a05:600c:8b04:b0:47e:e2eb:bc22 with SMTP id 5b1f17b1804b1-48e51f183demr55672855e9.5.1778073192540;
        Wed, 06 May 2026 06:13:12 -0700 (PDT)
Received: from paul-Precision-5770.rd.francetelecom.fr (2a01cb0404624b007a7d1e818d0f651e.ipv6.abo.wanadoo.fr. [2a01:cb04:462:4b00:7a7d:1e81:8d0f:651e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e53907a00sm43582655e9.12.2026.05.06.06.13.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:13:12 -0700 (PDT)
From: Paul Houssel <paulhoussel2@gmail.com>
To: paul.houssel@orange.com,
	Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Paul Houssel <paulhoussel2@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Song Liu <song@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Florian Westphal <fw@strlen.de>,
	"T.J. Mercier" <tjmercier@google.com>,
	Li RongQing <lirongqing@baidu.com>,
	"Paul Chaignon" <paul.chaignon@gmail.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "Stanislav Fomichev" <sdf@google.com>,
	bpf@vger.kernel.org
Subject: [PATCH v2 0/2] Introduce CONFIG_CGROUP_LSM_NUM to render BPF_LSM_CGROUP attachment limit configurable
Date: Wed,  6 May 2026 15:12:55 +0200
Message-ID: <20260506131257.713895-1-paulhoussel2@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In include/linux/bpf-cgroup-defs.h, CGROUP_LSM_NUM defines the maximum
number of BPF_PROG_TYPE_LSM programs that can be simultaneously attached
using the BPF_LSM_CGROUP attachment type. It is currently hardcoded to 10.

This limit was introduced in 'commit c0e19f2c9a3e ("bpf: minimize number
of allocated lsm slots per program")' in the first patch implementing
BPF_LSM_CGROUP attachment, and has not been changed since. Rather than
reserving one slot per LSM hook (a 1:1 static mapping across all 211
possible available hooks at that time), it introduced a dynamic scheme
where only 10 slots exist per cgroup allocated on demand.

In practice, eBPF-based tools may exceed this limit. I therefore propose
making CGROUP_LSM_NUM a Kconfig option so that users can tune it to their
requirements, rather than being constrained by static hardcoded default
that has been arbitrarily decided on the first implementation of this
attachment type. On the other hand some uses cases may be interest to
limit the number of attachments to a lower value than 10 to prevent too
much memory overhead.

Modifying this limit has been dicussed previously in
https://lore.kernel.org/bpf/20220408225628.oog4a3qteauhqkdn@kafai-mbp.dhcp.thefacebook.com/,
where the same thought on this limit being too small was being shared as
well. Furthermore, this discussion seems to have yielded inconclusive
about to render it dynamic, without a fixed array size.

Changes in V2:
	- fix SOB in patch 1/2
	- add reference to previous related discussion provided by Paul
	  Chaignon
	- add Stanislav Fomichev to cc
	- Link to V1:
	https://lore.kernel.org/bpf/20260506065048.592474-1-paulhoussel2@gmail.com/

Paul Houssel (2):
  bpf: render CGROUP_LSM_NUM configurable as a KConfig
  selftests/bpf: add tests to verify the enforcement of
    CONFIG_CGROUP_LSM_NUM

 include/linux/bpf-cgroup-defs.h               |  2 +-
 kernel/bpf/Kconfig                            | 13 +++
 tools/testing/selftests/bpf/config            |  1 +
 .../selftests/bpf/prog_tests/cgroup_lsm_num.c | 60 ++++++++++++
 .../selftests/bpf/progs/cgroup_lsm_num.c      | 92 +++++++++++++++++++
 5 files changed, 167 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_lsm_num.c

-- 
2.54.0

