Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C2D03563F4
	for <bpf@vger.kernel.org>; Tue,  3 Mar 2026 13:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772545957; cv=none; b=c+YK0W5iqvlP2FNxJx7GMOg0DjWZeYECs3bx81pB/u5d4S6MPuBvw0vNhSsHWvZYOSB8By6IYEr4pr4DlGIuX7bo+m9f8gHIJ15SukzteLWOY2ponpX/nZGa0+De8dnr0HQQ+cHcBbhtRYKGjnyglVB6XO/S+lPYTy8dVedujGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772545957; c=relaxed/simple;
	bh=Nkf8JlPVeJXLKi0iPhGG4eo4Fcm0ni1f811PWvrmEF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=scydbk5F/Cf9wgMjGlKy4GVdrz8AxnlfE7TVbeMLnzYJ6mEWISzRB1PVmb5heD0x1VmdoNq94ciclDmE0z31B8jt4jaqtVVQ3aw1THHlNLngkTrh3FLeLBUwXolFpCSQbavW1bUp6C/NSpWQUVBOH0X5PmV8rWBLjrSFGz3FWxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lk6hJbzb; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lk6hJbzb"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c2af7d09533so3534302a12.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 05:52:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772545956; x=1773150756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gDqgDDKpTGV+mlW/ZuWopljs3ZXh/rIIG37HcjmrN4U=;
        b=lk6hJbzbrEk7UGgTG8JwNxbKqqi4AsDHcXs03ynCVlm0uixiZyHiAUW5ymmAGkwJDA
         MilnL1Mu60aTM/IOePHSQBK9/KtEjcM50m76wIdLkPXzwByoFo8DXY3SrS7ZTwt0Z/0p
         JQy6ePBpT1Gyd9NEJdOvpK/T83CxVzfyb4hqkBjXmqh06C//OYJzwreiufZQIYqOWhyA
         uVlemrz3RGDvIHpBa0joL5608qZ45XCes7iabR/ThrTv5u6JukqA9u3gaeY1f2+oBaWV
         i7+FnszbxQxBi/bvfkYAblSj9uupvTbERwv7meVBfUsEAbevXdzIE9h8ZKsawL8YTDyM
         9E3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772545956; x=1773150756;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gDqgDDKpTGV+mlW/ZuWopljs3ZXh/rIIG37HcjmrN4U=;
        b=Dt/XSh0atfH8Na24k4bE2ndzjGZbui9RzrN+d3ByeyN9A/S4pq2VKO2j8LN3UCtkL7
         ZEM4sJRyfYlu404SieUtV0ERz2WeIzw1r02djXTk0rP9eDl2X6ZgcPItA5a56SNSkFof
         QvL/CbQIvUUGOqWHV/bAUfDBbf4HSUHSkVrIx7a96DqvG/Zbkh0mTt0FYIdZDXtnpuKn
         1qJyCWsfL7aoc7PBL5+VSr7FCPosb06mQmsjPBmdFtNiadoOM/ITWEUPENLoiq7u/zJ1
         VmG+L97g1hxJFLqCuN3ppGUeZqmNlcZq75WhjDcfmQGRaSJOFtT67/W6B2RWR+xs1Qnv
         cxlA==
X-Gm-Message-State: AOJu0Yy0jxQ2wbXsIv5pVpQNNVPEtJVLMIenfBmVZaYTtHH08f4BW6zc
	EsR16JLgbb8pmecpBokpVNm8bn0tC6mMRqSS9LO3w1XUF2OB2ofML+cE
X-Gm-Gg: ATEYQzzozAsgp7JSV4uN/915DIhYCeySweHcsJMs9dqiM/bAxJuK/0bJmmQUag9RYFS
	kb5yNnkXQKxOhXxlzypwQMPJFWyjxewDisrh089xlzpiM6eWoGacG+7Gk6xFuPDFnFdNnh1NnJr
	xLlwHqytZ3TLBLzl8guZektvggzdPuaeR+msGollHzmNmMwI2W66mjlcwF+13tLcWRHNmSWay6G
	N9Tm+mJt0+ClsAuF+UtjWMh1c1UMkWIXgXZLz7CUUlNndvZMlUPSrYmrMWu8q43raJYQeYUZK+f
	1this/f3yXcazH04l1AkYWin3+xCkg1FHVrdjYKyYzzt9hx9fYSscBdl9+g3ou8uJ3IzWoPL2/Y
	mpK6d7ddkLAQ/VM106Rb0DeBi31wmeg71sU+/Q1bb6j1E8m3c+DwOscAKWlV3fDthCeDqK0TEtD
	v+K4Q0rgWgImwi7Gh20GGDcOJXo+ukKqwS56P/RG6mnyeq8UQz
X-Received: by 2002:a17:902:c943:b0:2ae:5426:da3f with SMTP id d9443c01a7336-2ae5426dccemr63203185ad.28.1772545955680;
        Tue, 03 Mar 2026 05:52:35 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.129])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa62147esm14689782a12.12.2026.03.03.05.52.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 05:52:35 -0800 (PST)
From: Chengkaitao <pilgrimtao@gmail.com>
To: martin.lau@linux.dev,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	chengkaitao@kylinos.cn,
	linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/6] bpf: Extend the bpf_list family of APIs
Date: Tue,  3 Mar 2026 21:52:13 +0800
Message-ID: <20260303135219.33726-1-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

In BPF, a list can only be used to implement a stack structure.
Due to an incomplete API set, only FIFO or LIFO operations are
supported. The patches enhance the BPF list API, making it more
list-like.

Five new kfuncs have been added:
bpf_list_del: remove a node from the list
bpf_list_add_impl: insert a node after a given list node
bpf_list_is_first: check if a node is the first in the list
bpf_list_is_last: check if a node is the last in the list
bpf_list_empty: check if the list is empty

Changes in v4:
- [patch v3 1/6] Revert to version v1
- Change the parameters of bpf_list_add_impl to (head, new, prev, ...)

Changes in v3:
- Add a new lock_rec member to struct bpf_reference_state for lock
  holding detection.
- Add test cases to verify that the verifier correctly restricts calls
  to bpf_list_del when the spin_lock is not held.

Changes in v2:
- Remove the head parameter from bpf_list_del
- Add bpf_list_add/is_first/is_last/empty to API and test cases

Link to v3:
https://lore.kernel.org/all/20260302124028.82420-1-pilgrimtao@gmail.com/

Link to v2:
https://lore.kernel.org/all/20260225092651.94689-1-pilgrimtao@gmail.com/

Link to v1:
https://lore.kernel.org/all/20260209025250.55750-1-pilgrimtao@gmail.com/

Kaitao Cheng (6):
  bpf: Introduce the bpf_list_del kfunc.
  selftests/bpf: Add test cases for bpf_list_del
  bpf: add bpf_list_add_impl to insert node after a given list node
  selftests/bpf: Add test case for bpf_list_add_impl
  bpf: add bpf_list_is_first/last/empty kfuncs
  selftests/bpf: Add test cases for bpf_list_is_first/is_last/empty

 kernel/bpf/helpers.c                          |  87 +++++++++
 kernel/bpf/verifier.c                         |  29 ++-
 .../testing/selftests/bpf/bpf_experimental.h  |  42 ++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 182 ++++++++++++++++++
 4 files changed, 336 insertions(+), 4 deletions(-)

-- 
2.50.1 (Apple Git-155)

