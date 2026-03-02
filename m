Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B455437419A
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772455241; cv=none; b=IUaYZZHp+1+Gxp3UvOJ9ig/UDqNguvw1cYuBmfRy9LK2msO8toqC+RzC9f4yLeK22W1EXMGAlVxJX4aGuwdmDBGTSEhPJmR8bZjtXydSRWNUjKKmmBr+gvo3+pPCoGdW98C1toPSSFEiLXXy2vWTZK2tSm66kAom+FQn6rBFT/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772455241; c=relaxed/simple;
	bh=JMbovVkIHjyw1SkxJf+jyB5p2bx22jbBcT5wRY+P+dQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=swVjuDJDPfndPPoVgmUNzwE9KViTZMt5farx915a3Ms6OUIyJx1mX1qfkSLPXqn7IKJ4IiW8yRWdm4rxn2QbWlg5Oo2A0rLcpZcmRTbBEnELL2AShD00n1nnyUInfJW/+hEW16xpBSuyOg9VH1+PD+qquw4PFBhp9qE4NciXaQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YgFWjEzN; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YgFWjEzN"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ae56e68216so4693675ad.2
        for <bpf@vger.kernel.org>; Mon, 02 Mar 2026 04:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772455240; x=1773060040; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AEZZVDsX2jfTU9OZR6R9bxtazsvL2oFzaTbwqEvIxnU=;
        b=YgFWjEzNFn6IhEs9pX8fFxIYZ8cotPD2pWWy1pdsBPLiy1z0Ax47HBrK+qnce+PNDf
         633YtGqXjVYSuLdyfY+uF7GcrOQ3xu4/TDLSydQpzxOXZPP9anNwg21DsQyPWyE+nVRY
         63SA0iSbxSFobsd7ap1ulhqtCFXIFOlDBwRsgmfwZiqOhe2RfBDL7hvtZb2q92hvgfXM
         gjeUTJmOOGqN9jQ78hfs0BgDEQaV56KY0COfCnC2JeMfVdINq2jMbpTs+IAWxJrwc54e
         6pr2B/ZLX4tMiO0FNkGTkdgN+QT6fGA/7I/lAf/xxcCCNXdJ0GS2o9nCwxTQlzVPrGLL
         MHmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772455240; x=1773060040;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEZZVDsX2jfTU9OZR6R9bxtazsvL2oFzaTbwqEvIxnU=;
        b=LAO2KRG371CFZ5D1MPJhTNg9mZerPBZ5+OsQv6PTMYhORHnInrpTsV/GIZKOh9AMGb
         YEZPx18giWHmumLy/mZfPJuylN25BFo8FfgTCeBOSDkId2Ny2etg7TRYnqAcnihNYw33
         PM2dh/trdl9xsJVeql3lYTaiFxU1wYU7fSCasVG3foKw44qO7VigZeCtZlvz4G125j9r
         kxMWe+AsqQn89rOUGi+Fz4RdCD5rx6EuAb1W7dLyAqEpnEc1pVN/H4Dg2+ren71aDrns
         Lz2lSTh1fMHH17TjPu7mAxaKOIcPApuQNDg1eLSz0cL4XZvNjdM1sbBgDTETUUOyNv7Z
         KpsQ==
X-Gm-Message-State: AOJu0YzN2mv+rfbXLLlC4poYDtrQ0mWrPI4VHv6WBWdNOO4+99gPDvrd
	CccREnPW5ADsgauWCS86qIReZkocLtcKiQM085oK8wIQSTp3xaZuMoqN
X-Gm-Gg: ATEYQzzQleNY6DOErtmOV7f2vZxl/gLTB9znlzvFx3y+PFyRPDG+SjsKY000MPJE0ti
	eEsh8zTXlohES8B+xlsmmce1nvBvd3++hYaBbH/zWcbrC/DGp36YwhOSGVu7LNwC8UrVRk1H2L5
	dWAoW0TsQURvyvgg6KDmgy3zxUgSMp1rtMh1krw5lpDWAtkJ2pCA3hIkRbjy2lf2dpodWFn7j2v
	G1KvltFhA7h2cZzHnJLKOQKCHlLnG4R1Rwzzj+ZtAkv9Z/TlHU+YpI8K2WF83e0GCwws6JM+26x
	+tngLJpSS9oLI2rzV60pEY/HMGqpUYUnjttdf4VIWW5cUGxnUcRaNpBRP4mFUn9TBT0lTTwfnq0
	4tdM4+Jm6I00BYw5r8bG/YDyF+y8a/r0lgTzQ0x0+7wTh3G6nHojjaMDocX0EyGWdcGF5lfChxN
	0aKoO/d8hRqsWJJNqDXyPtRykbX4C9QEWGp5tt0QS2XrAjr1VFVFPdDw==
X-Received: by 2002:a17:903:1110:b0:2a9:616c:1711 with SMTP id d9443c01a7336-2ae2e3f75fdmr136529535ad.42.1772455240071;
        Mon, 02 Mar 2026 04:40:40 -0800 (PST)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3d1956absm67910225ad.14.2026.03.02.04.40.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Mar 2026 04:40:39 -0800 (PST)
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
Subject: [PATCH v3 0/6] bpf: Extend the bpf_list family of APIs
Date: Mon,  2 Mar 2026 20:40:22 +0800
Message-ID: <20260302124028.82420-1-pilgrimtao@gmail.com>
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

Changes in v3:
- Add a new lock_rec member to struct bpf_reference_state for lock
  holding detection.
- Add test cases to verify that the verifier correctly restricts calls
  to bpf_list_del when the spin_lock is not held.

Changes in v2:
- Remove the head parameter from bpf_list_del
- Add bpf_list_add/is_first/is_last/empty to API and test cases

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

 include/linux/bpf_verifier.h                  |   4 +
 kernel/bpf/btf.c                              |  33 +++-
 kernel/bpf/helpers.c                          |  92 +++++++++++
 kernel/bpf/verifier.c                         |  76 ++++++++-
 .../testing/selftests/bpf/bpf_experimental.h  |  39 +++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 149 ++++++++++++++++++
 6 files changed, 385 insertions(+), 8 deletions(-)

-- 
2.50.1 (Apple Git-155)

