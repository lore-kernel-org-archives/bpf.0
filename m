Received: from mail-wm2-f8.google.com (mail-wm2-f8.google.com [74.125.225.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7D85409265
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 08:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788511413; cv=none; b=pCfYXVWj5AawAbE96qu/rhohqHzEdzs1Pe6DWocWoVykRfYJahyev/jagEz+VXnsItKnflReytxwl+DFix7GYbrA1gBP9ql58l6B22zPeGTaKcivkNLIH3R66jPoAO4JGOIa2N5WC3xkhs/RBP+oteR9JZucwpGVfga2rMA9EHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788511413; c=relaxed/simple;
	bh=gyGFupeiwbNQYNaUtCJuaz+U5O8ubztMCl4978nBCOk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PB1Uxkh6pjL/Jor9GbollbuuWF7bX84Lo1IvyZBIkAbSHkK9WwckihNyyR6Py/aAB+sqrmnHzbvcExD2DbWc8+mp0KVi9PUWKsV0ruBmjj5putLLdFusDWruI8JX6dzINYUwPKfosrOC+bpnF6ul4y1CfCLC0zNMdQUCZzPe7Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnH8+aCO; arc=none smtp.client-ip=74.125.225.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnH8+aCO"
Received: by mail-wm2-f8.google.com with SMTP id 5b1f17b1804b1-4956bc73c0eso2640545e9.1
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2026 01:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788511407; x=1789116207; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jlwz/LTRHzweJ5A27WHH/C63iPiSHBJpbaH3V36Dpso=;
        b=XnH8+aCOtrtZjp4XGQLMzQ2PFEwlvxUq9WTyXvjv9CV3voibGuTeNl2bh2Jrirw2JT
         QAxWop3CDTbzt+Sthz/8uD7t48QcrN06HEm6LKaFGd4aMNHpHHuaBUJWcOXbZBCiD/Hp
         RrSVn0d5WlcAeATGE5WxcySOy985Hw+hAgY2PU3AfSPyTXlPZDNk64tf9WK/2UJs3nVB
         sz2wHQ8cBAwIMjvhdQRxdD5iY4MzeXMrCNk/lIvy82RJZa6XaxtZwkG9BdGmZwoLc4cz
         ZZdZq5AEKcLAGvB9gDxGWljKTiygx7HkC19OavsIjdRfi3WnL5y3mbD3/2rKu5LuOMce
         OjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788511407; x=1789116207;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jlwz/LTRHzweJ5A27WHH/C63iPiSHBJpbaH3V36Dpso=;
        b=YVmpRIC6PiMco4L41O4+U5Wsmb57/d0oLPOss+MN+0M+hbVQKvqYJLYCEou+zyN6nu
         g3ggufcnkF1WptkTStxkbNiytcQak7bJUXVwE4q4IpH9pC2vccbfMnqy3eksk6/8C3BM
         b8U7PQw36M1PjdeAAf4ilj4Mm91gXHrY+mCsq6zj5lNcHn+mhbux0DPcXdH49UWjNVOe
         ejc7zrI5KmHQ1Khn8OfnqThJugVIPJzsj2sucyI0+n9iCfF1QL0R9PW1jIel2UgZq8UA
         yh0fQ6EomaUCXTErkEIAwS5+aHVUdkAJR0ohVgxmJYlK/QunVNvNIWGHeXatMCkp4fSR
         0qbQ==
X-Gm-Message-State: AFuF++kwOiAgPVYz6awZ4d+Apu1DM/osM22z0Lmb1XZ8m5b8aoib75MS
	9FrC2bQ0G4BqHBevRB/NTZoNgGaXMl1UIEhWCsC6JwSVhSBbL4r91OWSMxY1gs4K
X-Gm-Gg: AYBFou2yCck2tvhf+fruSQMawqQ4wz0+xUoDbvY7QXT72XivGlLcDIgXPAZNh7W1nrU
	64kKOWInVPeKm0TXUnZLAlkAZ+x/iF2b+aS8FchCudFcDH9T0HjJW8o4aNTMUk2UxDMHPNnmggy
	URIkWkZ2f4ugnfKulbHbLyB8HagY4clIW9eF1bXHLOsxN2vhcCMqKg2PmlSbZhXJr8gG9dfcgQ8
	EO6WpjIV/vk0XTiNBbFIMie8Gw1EH2elacoE5GDFyQQLUsf3fdfK5I1jLLmjEIV7NeQyj0Lxoyw
	xL6kq/CpjzpV/HIPW9O67O5FP3RiKkwuK/9EAox+AOky3FlBvn2hYEhqeMWaw8TxdqNWQpE8t7O
	nYFbOFe14suhIsI9MooscOycEX3pykhxD2qRpIlp950Q6YucnmPqnxKQiZT1sWVak1pBoZGZmOg
	3ocYNx8C7w0os5g/A9mbbgo8nnhmp+90vq5K/hUo2cGpA5HAbgtugsZE0Sz0GCJdvdg2D61BWNx
	rbTjJP6JxPa2U4wbLzFiSQY2KnidgG6lxF2kpcOd94a5WGkyhIgr3wCTRi4dVRx+wn/NmLbAImo
	WvBNmB+a6of2ewjlbVTo9PmgT3k=
X-Received: by 2002:a05:600c:8b05:b0:499:be2d:c290 with SMTP id 5b1f17b1804b1-49cf824e751mr52668265e9.9.1788511406589;
        Fri, 04 Sep 2026 01:43:26 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee7fec25sm152612835e9.13.2026.09.04.01.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 01:43:26 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nicholas Carlini <npc@anthropic.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 0/8] Misc bug fixes - part 3
Date: Fri,  4 Sep 2026 10:43:13 +0200
Message-ID: <20260904084325.52250-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1452; i=memxor@gmail.com; h=from:subject; bh=gyGFupeiwbNQYNaUtCJuaz+U5O8ubztMCl4978nBCOk=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIWtWywQh1ocP9VeFujhO3er+5+zvxzwa2Sl3Wx8yV/7Y/ V9KM8C6o5SFQYyLQVZMkaXk/z4m4xOVvwNtl3HDzGFlAhnCwMUpABOZv5zhf/j2qMg7jCc3lq1Z ZvXlpvZGbeMKjgUR3axSbk2xr2btXsvwz9wi71/Hnmix0//yXSSN6uOVdtV0rPzGo6Mk9Vonal4 wPwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

A set of miscellaneous fixes for bugs reported by Nicholas, batched
together again. See commit logs for details. Some of this was caught and
posted by Ning before, but AI raised some concerns, so I'm resolving
those issues and commandeering their patches now.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20260904063650.3877826-1-memxor@gmail.com

 * Fix GCC-BPF failure due to missed BTF emission for a type.

Kumar Kartikeya Dwivedi (4):
  bpf: Require MEM_PERCPU for percpu kptr stores
  selftests/bpf: Reject non-percpu values in percpu kptr fields
  bpf: Clear NON_OWN_REF after RCU protection ends
  selftests/bpf: Reject graph kptr use after RCU unlock

Ning Ding (4):
  bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
  selftests/bpf: Test borrowed refcount acquisition nullability
  bpf: Reject untrusted allocated-object pointers
  selftests/bpf: Reject refcount acquisition after RCU unlock

 include/linux/bpf_verifier.h                  |   4 +-
 kernel/bpf/verifier.c                         |  27 +++-
 .../selftests/bpf/progs/percpu_alloc_fail.c   |  59 +++++++
 .../selftests/bpf/progs/rcu_read_lock.c       |   6 +-
 .../selftests/bpf/progs/refcounted_kptr.c     |  61 +++++++
 .../bpf/progs/refcounted_kptr_fail.c          | 150 ++++++++++++++++++
 6 files changed, 298 insertions(+), 9 deletions(-)


base-commit: 254c881fe0554c5efb16d355c273702a27a32a20
-- 
2.53.0

