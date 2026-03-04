Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EE920459A
	for <bpf@vger.kernel.org>; Wed,  4 Mar 2026 03:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772594184; cv=none; b=I6HiQY1j56QGygvEbjJqmXqIFW4ig2nBreUUkHhZ7lyHxE5pywFPSZAGjKXze4VWOaK/4BD89o2K9t2i5+cRImAk+5HlBSGCNbZfNCPWQgMd6etr0DPtH1f1/Tzx4lyxt2bsbWJaYYEspn4v2P0wD7lBGUOJtV8F871oIU/+fS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772594184; c=relaxed/simple;
	bh=So92N9StmJ2/HW3sZtZqLRTTKfgcTZ7gOdSXyepwb5E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGavSb1jTiGCfKkAKvpEN/KFWc6s+LaxSOglxEHTxRLo4hEb/gSZD8+WUrsjR8i2XfBTcGhGW0rkcFqADFxIpjJme8xPxfaHErLH3udoH9Z3ZPUilNpznrLrhH+kCurmGa265tDsozJv7cnLW/hFjZRTXB+12y0hts0p4wYPyVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PrdjYPqL; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PrdjYPqL"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-359894e17b8so2075095a91.1
        for <bpf@vger.kernel.org>; Tue, 03 Mar 2026 19:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772594182; x=1773198982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rhyuWZAAM7GaWavKLhRBU/I9cRSlzqfQcxXvGUKsI78=;
        b=PrdjYPqLfpEoscnXeQ5UpaK1qWRhDo889HaPNr/3kYbz32SI9EaJ5ebUU7upm4r6VG
         uc4i/m2r80P0H1n9Vh24RUsVtcl3LcibETVfHyLbBZ6EchQoX702xZW0LzoY+NIEKpKx
         5yDu2x/etfWrFxGjd55S3ewRxteWa3bpC7qYU1sZKyHDPkl0qv4AnRqKKP/A4sk3xdO0
         z16/Zfg+rJJjgcmZyuvnobEu33rDculFsVGoS6LggnG34x2XJ2rjJKMvt36oRsGCNon2
         4epTtBrK9HadRb7DQ/CB5u/2PtmnKDqZez+wr26/ZW2VmZLzzqEoImz8+6L1JkFy5ssR
         YT+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772594182; x=1773198982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhyuWZAAM7GaWavKLhRBU/I9cRSlzqfQcxXvGUKsI78=;
        b=In4NuyiErlFg9oBuRoCo2xJ89GDULctPV56edBJKcu5W/f8fG3dhYr9LQH5kf92Zdz
         mBwuvmK1qtI8uo52HRY8QdbWatMJKe403FZwC7Mj6uYp4pFs3lhDr/nU0hBcGNw+5Vpx
         3QJ2x7CVRiGtMkJetgsIIYqVdWxzNcU74SMZgvpgXHI4Gh4rRLWB4DD+tFLEqn+UPSfJ
         MkLRK+TVOUBwmwDYjGlrOWd8qWu8X4fawWtiOs3uiI6pe/al0PJUx7HXDOlTKW6rrUD1
         e61yOOjzYOaaz41ifsVfkaZorUAYLHbweQSC6nca8vuMI/hZoUGedRGfSkL18jG8Y9iz
         ueSw==
X-Gm-Message-State: AOJu0YxqBTU7ucpR1zU7puD1YbTHZLCd4eiJ1bB3GekzPRuGsJ3OuYx1
	/YudsKUP25p5AN3INNyPs4H1XlHy/6heeZs4M7ki8tiBsnVu77s0Sy3H
X-Gm-Gg: ATEYQzyiqiUeJBrzdk+AICLzfXmrQ6yiHafExUC1wIOjKFtuuWkFQrMH+xFWOp3TkbU
	EylccaxJtO+0deEaLnE719OI8eQKjreCwaYdCN+Ugx2q0wbO6t3FiI4rChmu3ewcdveBgn+2Rs9
	pDVn8aUYYxnHKY9IRgXUgpHRj4RQocNp/8Fd27fXiiOEzDO0UTzRT9p2+srHZ4zPZeWcHCf1mOd
	xNBXqpufpj1ngA4CLfVCH7ssQQShqZPJFREmV8PVZn/FJDP0LzO0sNf5EREIWnca/0MTJZgcuUm
	osL4h2pJPR0C9Oxy9W2OP74Q9IZdHPZ789LfpFb5yrczBnBGBbDuOA3aLjmM//bPSc7ppUsss0G
	OhOpiBiuEjaS4Pe5v2SjifKF8iF9LuOqQiNepgdPgI053DVbaIcce63B7ZDgdRuhn4fKkG47iFg
	cRjRc8iszxVvWfjUR2iEVhkTexaQoroezjXUsH4woOfnqm3srH9g==
X-Received: by 2002:a17:90b:1fc5:b0:338:3d07:5174 with SMTP id 98e67ed59e1d1-359a69a86b7mr619013a91.5.1772594182328;
        Tue, 03 Mar 2026 19:16:22 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3599c3ab946sm3610648a91.13.2026.03.03.19.16.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Mar 2026 19:16:21 -0800 (PST)
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
Subject: [PATCH v5 0/6] bpf: Extend the bpf_list family of APIs
Date: Wed,  4 Mar 2026 11:16:00 +0800
Message-ID: <20260304031606.43884-1-pilgrimtao@gmail.com>
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

Link to v4:
https://lore.kernel.org/all/20260303135219.33726-1-pilgrimtao@gmail.com/

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

 kernel/bpf/helpers.c                          |  85 ++++++++
 kernel/bpf/verifier.c                         |  30 ++-
 .../testing/selftests/bpf/bpf_experimental.h  |  42 ++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 182 ++++++++++++++++++
 4 files changed, 335 insertions(+), 4 deletions(-)

-- 
2.50.1 (Apple Git-155)

