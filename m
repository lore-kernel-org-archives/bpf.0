Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40F1374738
	for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 11:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773660538; cv=none; b=j05e6cRHeh4DNzkGznC7QqGGG2cT/6qrvSuB3Oah5R+9OkwnFW5c8KTIomv5E6HaaNY2Q3dqI99fEECuqJfWWpAb17KK2jYv/vX7QCHzWDQ9HdpDdjLcq1+3m6HeazGVHLbQ+XE/FY9yncxRJ7Xf94DIufmQXV+VOpx9Ns1zG2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773660538; c=relaxed/simple;
	bh=1O+LEkCcALqHcjZwSpKQxGV6mvhgBFLNsSL9qxtZpNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OQqJ7tdgy6aLHObNpYUk2faYhGM8UUHvMqTkDUQQ9cTJzxm0sqRN2rPA/zaiUyLPtLsscHzr3nT/rQvK9I3X9xMPJ0vXwtV103aBmf0CpunVrtAcZ/2FET12cabtZ5mC4zbMWzC6hGC+ZwwH0Zm1tiYti+8RgyZcdC6dsuM1l8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzJQopGs; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzJQopGs"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35a211df8e3so2102086a91.2
        for <bpf@vger.kernel.org>; Mon, 16 Mar 2026 04:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773660536; x=1774265336; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2ntIiD+GdH03++TVgBGF+pBQuOhfJiM87likhblk8EQ=;
        b=mzJQopGs/RKtIDhXvrPisJO7Emh7R0GUHblMPaBeaH8KoJUIgI89/eWYYVUbvN0V33
         80UbliMs1oEtdyKyc4xYrRW8KrXbn6mNpfcPhU5eyebOYhob78lknH01y0SmwdEnAkG6
         CxUJ5HQCrfinCLbNyVDyiNmHthzzxhu6VVJNa2SXIgVAndFGBY+xbQoND5/d1fSouoLc
         xB094FCwDxPTPY2u7PU6k5KLBnc7v1fpnPYMBN788eJZTdq5rVyBauZJqVDf3fbZP2p6
         AVX0JxH0Ys9gyrVt61kf9mdh6GL4kHjRWQLK39TEdqZSR2OosDIU0RaVQ2Uedq+LAfU3
         t11g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773660536; x=1774265336;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ntIiD+GdH03++TVgBGF+pBQuOhfJiM87likhblk8EQ=;
        b=kwo2e4hdTKoTx/1v19bwc76snDdRuVLe9jGvpbP1kehKYGbb46MelfxFKHR24LIDtg
         s9hrx7jnPhNH8LZTv5b4gwD1gzpr2BCVnV4+uQ6PRVdYUG1omkfbGrbVcHjR8HmRNF5/
         DgmfZFuTX+2JOUQ5S4+yEMw3cU5HkVERukY33RATn00DVENdzq/iuUd3yFHNWEd7Bgv2
         QPJtOji50TC0UEk1H3PqfcbnZwqWkVf7zqInkZvX6G8VUcHVqDdT7AvshGAkEYK93/aE
         WMzf6zpHxqoi2S8gr0icNHE7kqsokcrRT6CawGa4y0C8Ik+ggBjO2oHZ/FM9iy2p+EeR
         T87w==
X-Gm-Message-State: AOJu0YwVbdcrD5mHaS5FlU1YD0StrnCGs5C7/Wvmje7pSq4zBJWpH5z3
	/GYVm+DGXInqkI7vjcUB3xeVIVyzlx9pqsLWKmF56ysP6Ptz0ARgnNJv
X-Gm-Gg: ATEYQzwAlMtYC1c8ld81IpX/iy/DbFMWt9Ei/skxXtCb4/6GK7JkoKkWjHmXG+shfin
	OtokWtXAOh5uBpEvSds/yD7hDxwVZ2mJgK1Iv1dA2HBNF4KJtqBa/eorKVIWiijrkAZlICziS8p
	SNaaFewvPU2tQKnZ7yJUF+OrXD85x1YRo94lhLAjLwp58CmnTfEQmsm6sY5y6fu5YCA9iFj1vKl
	l9N10SQfTOMgrN+0bkjfKEoYw3Mc8PGox9qku0+uDzxfSN+onRVidc4sn9HlZAiyIaEG78qb9Qy
	yqF7bThN60xG3saeZJb0Ck10m8nUt5MiooeN0PD2QIstEAwFzfUiwMdnFLAvCJWrP7rmdIXObN0
	jmw6dNo00Anwv869CoolNVVs3zQA4YWf2Xru245qFYhHx7LOlLpE6MyimlNx6jcVt0VZQhfkXZX
	iKY3x38fhrROxbEtQIL+2oPWhmpzjPpjmQ6YR7oBsWQD1XfFUjbEkkxSA=
X-Received: by 2002:a17:90b:278a:b0:35b:9719:b7ab with SMTP id 98e67ed59e1d1-35b9719b972mr4306322a91.23.1773660536304;
        Mon, 16 Mar 2026 04:28:56 -0700 (PDT)
Received: from localhost.localdomain ([116.128.244.171])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7401588ecesm4684940a12.32.2026.03.16.04.28.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Mar 2026 04:28:55 -0700 (PDT)
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
Subject: [PATCH bpf-next v8 0/8] bpf: Extend the bpf_list family of APIs
Date: Mon, 16 Mar 2026 19:28:35 +0800
Message-ID: <20260316112843.78657-1-pilgrimtao@gmail.com>
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

refactor kfunc checks to table-driven approach, and add test cases for
the aforementioned kfuncs.

Changes in v8:
- Use [patch v7 5/5] as the start of the patch series
- Introduce double pointer prev_ptr in __bpf_list_del
- Extract refactored __bpf_list_del/add into separate patches
- Allow bpf_list_front/back result as the prev argument of bpf_list_add
- Split test cases

Changes in v7:
- Replace bpf_list_node_is_edge with bpf_list_is_first/is_last
- Reimplement __bpf_list_del and __bpf_list_add
- Simplify test cases

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

Link to v7:
https://lore.kernel.org/all/20260308134614.29711-1-pilgrimtao@gmail.com/

Link to v6:
https://lore.kernel.org/all/20260304143459.78059-1-pilgrimtao@gmail.com/

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

Kaitao Cheng (8):
  bpf: refactor kfunc checks using table-driven approach in verifier
  bpf: refactor __bpf_list_del to take list node pointer
  bpf: Introduce the bpf_list_del kfunc.
  bpf: refactor __bpf_list_add to take insertion point via **prev_ptr
  bpf: Add bpf_list_add_impl to insert node after a given list node
  bpf: allow bpf_list_front/back result as the prev argument of
    bpf_list_add_impl
  bpf: add bpf_list_is_first/last/empty kfuncs
  selftests/bpf: Add test cases for
    bpf_list_del/add/is_first/is_last/empty

 kernel/bpf/helpers.c                          | 121 +++++--
 kernel/bpf/verifier.c                         | 116 +++++--
 .../testing/selftests/bpf/bpf_experimental.h  |  16 +
 .../selftests/bpf/progs/refcounted_kptr.c     | 311 ++++++++++++++++++
 4 files changed, 519 insertions(+), 45 deletions(-)

-- 
2.50.1 (Apple Git-155)

