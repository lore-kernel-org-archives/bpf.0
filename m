Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240E3ED5B5
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 15:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778079956; cv=none; b=Su2WKJiUWNo1mjd2pasmBTpCS/y1XeAmk/l+zlLfYnDQO4Mc7A56c5QKS/5KnSu80s+KQvkRNM8n6exoENP8LCOTvXt2TpjqDqCY91ywra5M25Vir+I+m8BWHIhwMhZSQBK0OTG59QusJshljEfJXp1zQanYv75WWBTj+yqyuIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778079956; c=relaxed/simple;
	bh=iyyIzhUZqKmogpHm8sYePct5eSWyKuXgC1vT/8cPyMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5ThpcPCwTF6Eq3SxoNQEl9EzfmhWMQ9xH+ewnPo6FkFdcUhtt+P1ZOfbj6OZllY6G158GXmgx63iqL7H2X7Y85bSIjSP51U0MzAdrNIP4uRNcN+Y8RYb9DgrxnsC104+/1Qihzrw6ahc+59LUkZBZHE3UMtA+StB4NOSBMpNco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WHfEEuaG; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHfEEuaG"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48896199cbaso57662415e9.1
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 08:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778079954; x=1778684754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hpuZpEJdSWnit6krf2QbgKq/6arpy+poajpzOKbixQU=;
        b=WHfEEuaG+TA06ZPC2TxwwYW2T01ZRrNRCQpNHkoluF9Lz0NogJ9nYjYpVyLd+TAgY0
         j/V15BwW+6xvdcHvVWrdozRJO/0bpjacP06hXE6T1KvNXlSDmPTwLvbqf8FV7ercdwIx
         O3mPSx8Z4c3qYPkTqAicfuJB6gJnJVd/SeFZubjpv85XHP1XwbAvPnIUzIB+FuxcdLTd
         E9GQvWUnLc1AO7ehWxnbxh3Ta8FWS08lgJJP+uUgOfPRtKyQ9XEoOLgsetqK5SoIedpU
         oIAXSSc+pzg4BDHyP1Ep3v6A7oC82ebOwv2OkpfiZGBws2cmajFNJI0vPS3T7qQTE4HN
         GKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778079954; x=1778684754;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hpuZpEJdSWnit6krf2QbgKq/6arpy+poajpzOKbixQU=;
        b=d0X0gzEiQrA1TAXR1fXjBgKvzmefL5uh7H4JovUmWRDT2t1DZCdVikFQgvd5skgpOK
         u8dPcSk5j8TOPxFhAFqv+anXoOq5WwVd3mcBeT4H/gUFdP1thAXhH5g6m+Xh9rkjwp75
         RlVG0bLBFZyfeWI0EMzuIc8xRL/v5Uztc51qJKg4FAsiqqIcqDaDWQS884tKPQc33RAp
         AOPIB7rwRlPgm6RDD+g8iqqQiE5lNJJhU+EbP2BVxLprv/iEh85oEZitOVBHVvRMvLpL
         wjZTRqJfZTFMTP9VAIRYms2aoRnXNwsmFq9Wk8FL7V783mMeF1w+NigYemrZMCZdMR3+
         jqyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ybX5l5Bd1nJbOYLECDGgGt2IA+uCXkRR+gFupLQA9nrdgvBq6GN/c1ChkqSdGWC+D9RE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxc6CfTW3vqBqw8hd5I8cQ9/U+GXBWxWZ4t+S39jNlBC8eLy5ef
	KTZ0UDHnwWTGoav9RRZuRvuUbLZWYDVcdtUW5aQ1k8vZV0Sf6iH2hr81
X-Gm-Gg: AeBDievhW0Rhc2vJu71OB5s3YEUq1xhuVTSZAj/mpcx6+Vdz0fcZk6kKpLXHeP61oLn
	zPpHV1FvOXurK+8GsTGr4wQF1x4mhuCuavPCYY+uucwV+NRX3hwHLE+YApR2/PwyLGNgo1eyizB
	O9Ef8mNjCgjQsp0KaTlU5JVyQcFL5zIuBSwkL8M5j71d06DhkiGzbSNCDsxiFJYVoIos9UXjif+
	fpa4ICiqKOmj5enYjWbXUn2CnlSqrLbF5d1EfGwM5EhU6Fa9O/VcD5w8ZdZGm5D6Zjgpy00a8FB
	HvDmuif0Z513nIcz1aWUtvmSdEoHFpUqi9qNGhi9P9ELcTNCcAMKioVbQgvpXcIf4M0G1kPpWuw
	I0RuA/peVKMoipnqsjQrk0X0yRF12tQNz9M1pQWyYzM+8B/FamA4+LaI6lFRnhEb6BdvRyBEHLn
	UbSLugT77gKQo5jIh1W9Fl9DoS/ist7hAqKq/m82U1KXp32xTLWjYb9QAw/OrdQ+bMhBrBhO+Ly
	FBFo7RjFsmUisQfTRWJlw71IthOsMHPfcc9lg9q
X-Received: by 2002:a05:600c:871b:b0:48a:592c:e655 with SMTP id 5b1f17b1804b1-48e51f45eddmr62173085e9.17.1778079953381;
        Wed, 06 May 2026 08:05:53 -0700 (PDT)
Received: from paul-Precision-5770 (2a01cb0404624b007a7d1e818d0f651e.ipv6.abo.wanadoo.fr. [2a01:cb04:462:4b00:7a7d:1e81:8d0f:651e])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e5312de76sm18382985e9.21.2026.05.06.08.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 08:05:52 -0700 (PDT)
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
Cc: "Stanislav Fomichev" <sdf@fomichev.me>,
	bpf@vger.kernel.org
Subject: [PATCH v3 0/2]  Introduce CONFIG_CGROUP_LSM_NUM to render BPF_LSM_CGROUP attachment limit configurable
Date: Wed,  6 May 2026 17:05:45 +0200
Message-ID: <20260506150547.767315-1-paulhoussel2@gmail.com>
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

Changes since V3:
	- refactor test eBPF programs by using a macro (patch 2)
	- improve the kconfig help text by elaborating on the memory
	  overhead (patch 1)
	- link to V2:
	https://lore.kernel.org/bpf/20260506131257.713895-1-paulhoussel2@gmail.com/



Paul Houssel (2):
  bpf: render CGROUP_LSM_NUM configurable as a KConfig
  selftests/bpf: add tests to verify the enforcement of
    CONFIG_CGROUP_LSM_NUM

 include/linux/bpf-cgroup-defs.h               |  2 +-
 kernel/bpf/Kconfig                            | 19 ++++++
 tools/testing/selftests/bpf/config            |  1 +
 .../selftests/bpf/prog_tests/cgroup_lsm_num.c | 60 +++++++++++++++++++
 .../selftests/bpf/progs/cgroup_lsm_num.c      | 46 ++++++++++++++
 5 files changed, 127 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
 create mode 100644 tools/testing/selftests/bpf/progs/cgroup_lsm_num.c

-- 
2.54.0

