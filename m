Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB6963074A1
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 14:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772634923; cv=none; b=LhjOHMMkO+4vhkFYqvf3fxEsYHNP5DmVF75loBjkKXjN/BoJcoyjsHLaLPm1pIoHh01NYvTCXiUWeMUqdiVG8OVnPoFa7tnQ/ilMOUiarKbL5OljcDZoSa3ySRnzexOiKeIT/7Sx9563Cwibkp8V5DxW6/cKo+mlktBlkRcaiIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772634923; c=relaxed/simple;
	bh=tm9z4rhCez5HLQviad/BMnNVmKmKuVcBpkwCJjwSoVk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OxeP3Mq7+HGkYMcn8A1CLvWrz6xXAtaNQGVhOK1Mwonp/x6bQJ9GJy3AdUvH1QYEhK/0V01v25kCMQs7lXabVnZLC4WpjgCldLka+vQRJ5oQcfGgQZyLdGn7vKe38PIFKbFO8TdQNlqoepnZKySsmqkctB+9IPGhBTXK2j3ITVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cCkZjH6K; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cCkZjH6K"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8274936d2c0so6790634b3a.3
        for <bpf@vger.kernel.org>; Wed, 04 Mar 2026 06:35:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772634920; x=1773239720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ww9Gg44/nr/4wT9Ug3u7VZF84qM0My1cXsMZLyLTfi8=;
        b=cCkZjH6KDc3rfZSUR97IZCxY49d8uBPWZhxsbCjwQ0OU+Fz/7kydz6KFZ5+w3K82gl
         bKC2d/JX2B5qZmNgmuBbWi7La1zss6d6CpDdDuqMlqJLISxKGxvofJRydk59cNYyoSc+
         cUMKefLrlCsOtfIBOPcmhheOzTqMsZmCGk4Ny2ha/nBuPNF9fqmeGjLzFNnTR16aOd61
         1GnnUCGzfbpE7abrI65jCEdDmKljFC21nroxEo5uAjQmiisFwtayfiJ91bL5HhsCO+2D
         XVxHUT7I55tUT1s4LhYUK4QEeCFJzHpE9PoZuu/r1bS2Ki9IJl29jbuzu7zmazPB7SjE
         AFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772634920; x=1773239720;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ww9Gg44/nr/4wT9Ug3u7VZF84qM0My1cXsMZLyLTfi8=;
        b=MLIHKT8hbK0GTRXrRWBDh5XLGxRCQpBlfiaRsZJYDpEvble1sow+/5bz8pOG+kgHgJ
         9CRRI+OKc9oxqZt7LeAkmj/gQ2nFZW5F3tGmmpyZbqTlKyE3oBmKUXJsf8AICPImjZeP
         ppaIUVAClTs/Hyfy8mwv/f5FJXNa3H6UxZytgB1HWcd3WZ5bZaGPX5h/+LJLsBNqVJ4S
         7tc30kdhHkd+W9F/k67ZuIWesGKCI82IR2YAi6aaeZ069vMahiO6RRNiYeV5xuhu4i20
         9Nt9qP2Kv36I3I+UkDdzgiIeAgrvWaMi30jj+YJHxy52m3dspF+svsP9zkJSNDwQnnOr
         dwAA==
X-Gm-Message-State: AOJu0YzOeBqUGzqgn5+uPQHIB5oWY7BtLnNIhftyPu2KWCzTYer6eTd1
	BPrzovTehyVhIqUHdCkV8hoNlianRK/cuDYf+DfNRCSxXD9BTtApQE4Nkc/GYA==
X-Gm-Gg: ATEYQzwtO/IXTRGc1AKwjOXTGJMGidVYQblyb7fAf7Cg3jR4vFw2QIu1t3i10QkiVOG
	C/tHugtjIQxMCMpDlYpuahcEnsI7YwE6gMK2zZtl9L67KcsGzLCzHMhoL8Gi4ApSGf9LY73enu9
	SPdRuzCxqrboeq/Sc2oJgh8AsSIbG4QAxmGb/TMuEUHewMDanI+z/soVgh/xxAZpYLbMcXIfgiW
	UXbq5+/R8f9PftX8CBhSEOZM3bDG3Z7NePtyzL2OqIyraA42lsEM4HZmLfZzcxiVceqPLAYhoJC
	tPubM+eTqm/xFnELS8x1URwKvU737ruo+W1O1K3ZT8EngBsCil8tidViuW54Jcd6XzqG9vatjFG
	pHHtNlen0RIOBkCJRBgZ141IsSUQ4Iy1gE040uG20l/f18phIwOhYIx3YT6/8XwDbWr/9RiZYOs
	M+w371rEHfYk6wxunezxwbb2L6pblTPH08rJBKUCaiE2DRINzYMLqRXg==
X-Received: by 2002:a05:6a00:94cf:b0:823:1d04:e280 with SMTP id d2e1a72fcca58-82972b5e2camr1819011b3a.22.1772634920093;
        Wed, 04 Mar 2026 06:35:20 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d87e4csm18470184b3a.15.2026.03.04.06.35.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Mar 2026 06:35:19 -0800 (PST)
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
Subject: [PATCH v6 0/5] bpf: Extend the bpf_list family of APIs
Date: Wed,  4 Mar 2026 22:34:54 +0800
Message-ID: <20260304143459.78059-1-pilgrimtao@gmail.com>
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

Four new kfuncs have been added:
bpf_list_del: remove a node from the list
bpf_list_add_impl: insert a node after a given list node
bpf_list_node_is_edge: check if a node is the first or last in the list
bpf_list_empty: check if the list is empty

refactor kfunc checks to table-driven approach, and add test cases for
the aforementioned kfuncs.

Changes in v6:
- Merge [patch v5 (2,4,6)/6] into [patch v6 4/5]
- If list_head was 0-initialized, init it
- refactor kfunc checks to table-driven approach

Changes in v5:
- Fix bpf_obj leak on bpf_list_add_impl error

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

Link to v5:
https://lore.kernel.org/all/20260304031606.43884-1-pilgrimtao@gmail.com/

Link to v4:
https://lore.kernel.org/all/20260303135219.33726-1-pilgrimtao@gmail.com/

Link to v3:
https://lore.kernel.org/all/20260302124028.82420-1-pilgrimtao@gmail.com/

Link to v2:
https://lore.kernel.org/all/20260225092651.94689-1-pilgrimtao@gmail.com/

Link to v1:
https://lore.kernel.org/all/20260209025250.55750-1-pilgrimtao@gmail.com/

Kaitao Cheng (5):
  bpf: Introduce the bpf_list_del kfunc.
  bpf: Add bpf_list_add_impl to insert node after a given list node
  bpf: Add bpf_list_is_edge/empty kfuncs
  selftests/bpf: Add test cases for bpf_list_del/add/is_edge/empty
  bpf/verifier: refactor kfunc checks to table-driven approach

 kernel/bpf/helpers.c                          |  98 ++++++++++
 kernel/bpf/verifier.c                         | 103 +++++++---
 .../testing/selftests/bpf/bpf_experimental.h  |  39 ++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 182 ++++++++++++++++++
 4 files changed, 398 insertions(+), 24 deletions(-)

-- 
2.50.1 (Apple Git-155)

