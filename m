Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBEC35E1C0
	for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781165347; cv=none; b=MtYPJcObTGPh0CerrIErVGi+fpCHG9xzAd8nwxUyzDQ1UhT9S8TiIWMabX8dbhKGZ5TDpXLxzzTPs4lFk1UJGtn+Qv2zumlL8v1nGRjI24GQAzfesXor5Lz6B7pQ+icWzS2iNt4EuoE3w6gAv6CcUQ6KuA0LSvWxjJeAv4xemFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781165347; c=relaxed/simple;
	bh=43aTg0uqeeQ1d2jMcSX4cwzeXgZpgGmCmaoUiCwIYpI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bk6Y5ivodk0kNautdjrmZH3iMyvTPewrTlQmt8ZWnIyoXgJFgRcOl40PK2Fo0wx5hcKPdEFaHruPtk0CrJ/ttK0gApuDrmxazxNMqL1dPNo/BqeXuEow3HwwCKyiTNnvX+QKukTg7ZmWoDZipu3jYR96xvuldS5mg3yZiZipKmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ByieKP5v; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ByieKP5v"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2c0c2d792c8so51445905ad.1
        for <bpf@vger.kernel.org>; Thu, 11 Jun 2026 01:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781165346; x=1781770146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ez/7YuAJr4Y+RG8kQa8JolzS7h4/ienZb2p4vynCkX0=;
        b=ByieKP5vYX53ZzYn26b8aIuF4w2nt9RdK9oz9i3Pjkcaq6FstjjKqymiWu6abi8/6u
         yN7DVZyQfN04v+PutYDUoEDYakHbmHuVkCabjR0m/gvxbWIDRkROG+xzpqoRMEn4g/EI
         p82Mgd14OMGuthhDvxrz1nPM2XHdkgXE0XYHiXzbvbBS/Lk8WE2P0p1fqiGM6V/sLzft
         Oi1I8NgKVN2ZRPf2JGbRLyANRUy8AssFq6CHQep3eLk/dVAzc/q6hXmfhyslMU+/oLKv
         9lvZJOdYtdtz1nFH/MTmokqrSuAYxUjSSjx0HrW9WwrIhJCMuR/n5u9cCMivJjsPrHBH
         l9jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781165346; x=1781770146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ez/7YuAJr4Y+RG8kQa8JolzS7h4/ienZb2p4vynCkX0=;
        b=M0gTmR1pxCL0Lxu73VVaZCVHiWGjFB5kHG0Mm0h9TntC4SyeElRLvU7lvIEAOg0NEP
         QDnWtxYalwRHX+u4YXMxE4USkcHyo3FVei0GljAeAQJE3v8srJM/C1y5EBYLWalhSFH8
         m8SnXBXT/AFr7H6dBvXkD44Co4E6ovkstxReYhqYPoIrML7uvoUEoLVGhTnpBdhAjVSL
         HbC9QCYqbL6TPSAzkxmULvuhN6S66mJjvN+oc1E95vfrjM9u9tN3gccqTurrVQ1z16EB
         q9kVuaD0b5R+dkl8/bYY6xIjhvk0uDRTLTHqxPQNfG0iy70iXpzpO+dtCLaPVfBT6wOy
         Ebyw==
X-Gm-Message-State: AOJu0Yzyls8kgl8KFA+BMW0vAOL6IARW0Tl31RHUj+YS4RCVFne5dX4Z
	aGwDz7rYIPoEh4J15NLP0rbrShJWlVaKWjQlIYPZUP7tpku3ura7CDgamSF3yVHSOs4=
X-Gm-Gg: Acq92OHjITteik6O0snFmwbZAdwr4M/CJwyD+lmsQOJCH9YiX5OzmWGvsf9AMEGjFWq
	NJ5Z/rAGXSWfnv8E/Ryh7FOvzZ8bQA8Z81iJHkO9nWJy1iUWr+c7/ZPOav3UaxXfWOSRZm+V93f
	TEN24FYe27HxEZMIu5RQpVI9iJMstfWR37KxJJOYjenP3EsimldhmDfd74YT8MAE0M2idJ69co/
	sSrkB5/dCSWh7auAzc4ZmYNIiuo4leAtZor6nByZNTnIjRdyHqcsfm6Es6XB17uE0bj2rN+adOY
	E49LYbgAKkW5zZN2CMuhv8TR0Z1bCnPltt/BG0lxw7DM229fbZUtqzKq7fNQB7D4WYoD9DoqFel
	90ABSD11QGI6uZ7J/zvEDobkLvU0QHMFZ5C232fdYYjqRskyrQPKbgo7sy7X/5ztffAWO3pAPcB
	AP8CiQ0u9cQQR975ld6eD1aKW7cn/Avhp+tMMQb7+BouqQ1YJn4uzgqoI/yulbUWGtBXKgY+6TA
	YqWi/tV0ryee36ZsyFvYN8dxN5ls7Qt6CmwDok=
X-Received: by 2002:a17:903:f8c:b0:2c1:a19:8396 with SMTP id d9443c01a7336-2c2f2a780bamr19562055ad.31.1781165345756;
        Thu, 11 Jun 2026 01:09:05 -0700 (PDT)
Received: from u2404-VMware-Virtual-Platform.localdomain ([2a12:a304:100::109f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c1664ad138sm277591035ad.82.2026.06.11.01.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 01:09:05 -0700 (PDT)
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
Subject: [PATCH bpf v4 0/2] bpf: Fix generic devmap egress skb sharing
Date: Thu, 11 Jun 2026 16:08:47 +0800
Message-ID: <20260611080850.536996-1-sun.jian.kdev@gmail.com>
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

v4:

* Preserve mac_len after skb_copy().
* Separate errno return from XDP action output in
  dev_map_bpf_prog_run_skb().
* Zero-initialize net_config in the new selftest.

v3: https://lore.kernel.org/bpf/20260611043317.512843-1-sun.jian.kdev@gmail.com/T/#m77fde65437b0398cb470649d4f1feeb85bc134bc

* Split the kernel fix and selftest into separate patches.
* Move the private-copy logic into dev_map_bpf_prog_run_skb().
* Use deterministic DEVMAP_HASH keys in the last-destination selftest.
* Fix the Fixes tag.

v2: https://lore.kernel.org/bpf/08c35c70-a59e-4e0e-91db-22b5ec30b611@linux.dev/T/#m613671b243e8651c47f84bb329f0ea668974c549

* Move the private-copy step into dev_map_generic_redirect() so the
  last-destination path is covered as well.
* Use skb_copy() instead of skb_unshare() to keep caller ownership
  unchanged on allocation failure.
* Add a generic XDP last-destination selftest case.

v1: https://lore.kernel.org/bpf/CABFUUZFimdrZdq=NWi+N-0sJZWvMwY=f4iF6-3TVMS8=m07Zmw@mail.gmail.com/


Sun Jian (2):
  bpf: Run generic devmap egress prog on private skb
  selftests/bpf: Cover generic devmap egress last-dst rewrite

 kernel/bpf/devmap.c                           |  41 +++--
 .../selftests/bpf/prog_tests/test_xdp_veth.c  | 152 +++++++++++++++++-
 2 files changed, 180 insertions(+), 13 deletions(-)


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.43.0

