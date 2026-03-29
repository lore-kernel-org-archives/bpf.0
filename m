Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95136378D76
	for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 14:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774793119; cv=none; b=FI7xsjCRgfzvSmj8btjZCWxX4OpB2mejhnsxlMndZ8LmuyHxqvkqDbD0ZFDIOwJdF6o8lMwjGjlI7IxpKU+x+g0Dk9dj718VqM2PdC9inPQ64FcuVi9BDpSYvfhsBH1F81cfaB/ZicAmwEBDNg3fhGBi8nYszXMXVyTFEX/HFuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774793119; c=relaxed/simple;
	bh=+ne+0mmU+TH4johwejMARgSVXL4tRCNd1WonWRkY57I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Dy4AETW+jVcZR7nSnmIKxFKvrkNQxKYIxjgObQ0F7fof8Du0gMlg/6UtYzH17i0Au81bX1vnPlA3B1vvmZbDc7VMl6r/7qtZjihAjuPUFIVsgo2XwRVk5kOk6RL4wCQEhCFg2EN+NDy+rN3WfXsC94aM0S6daXCd6arsvnCzqkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GD9XWZqj; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GD9XWZqj"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-35d95017a68so541614a91.3
        for <bpf@vger.kernel.org>; Sun, 29 Mar 2026 07:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774793118; x=1775397918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/P2cEhfTAZlAAcFjnHzMCawVs7idJ1YVuxYar8E7U3Y=;
        b=GD9XWZqjbndriGL0qBI4hIC2Ey54fLsMVNXfUlkiT6DcIXzLR170m2rC3isLveFQyM
         vmVDGjRM0YSURXdZCpcTo0K1ELjwA+Zud+UEdxBHjJ6zsEr/Epl4ViNqBzGbdT6HztMj
         Eri/bniTE4NDykFqGVEEsjdeTmhfmhJ54nXltnsEU2s0M3Z/Nt9x5XME5+GwvlWeAIEF
         ao6LYPUgD4oVf68upI1fRrQoRDxSWl3rYvycs8/EY72YefjrukcxpjUyWpAMCEAI79ss
         z5fgNaj1egrvoH8fe00R7ShN57imepUNKpPl2TgCMy3KnNLItpLj+5ruhxH4PkcH4ru2
         gaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774793118; x=1775397918;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/P2cEhfTAZlAAcFjnHzMCawVs7idJ1YVuxYar8E7U3Y=;
        b=fZom3PIiAOrabENDLOaNAifjchX34nd8SpG1V1jLnAoB9i5WmBU5u44w30EyqVNmB7
         GA7/TlVkrdF/YUMmER4nQ38ub+9jR1OCuGqWwf6gw7f2WHoQd0OTaN0w7DjUYeuoIErt
         p/S17NMS/NlcPplPQzBrqZ9OT4vzkgxfed/nOJePrYFfIZujLieD2Zm6NXkmWktmYwDG
         3uYaLUTz++n81oiwv1E4SsEogV3Jq+Jxf/PgJGH6ayscMk/HmRuWlzn/qr5i74MkNG/z
         +k/IixzSI4WqVHu73601zJF9zFdoZlP+886pt+0ZU3E0O5gdk9PbB6xGQSsbfNTlqUbh
         NUkw==
X-Gm-Message-State: AOJu0YwJ3a4M9bxWOpoqiS2Efrb9edluDVdT/HTYOjDcuGWF9VbuNYCq
	v6pEA93w8bA+Sf644huY+3y8+S4hE/95YZKzbglboxXcdsX3SOw6yyvQ
X-Gm-Gg: ATEYQzxcKHXPoJKyJaf0ebQFIkVli5kreGGQx9jshQz/D7uv/xtF1RIGjc8PN1Q0RFi
	inDE3dGlGBPGaT1clzX3NirpGJ7TPPv57tfv35FueSBLDREufDEoanRCWvGbaUOOO6w9amnWdP/
	6zp75K/tIgOxqH08cW91nMzZIPCc4xEb29cXbDEFXbFSX3WVvVMLTUtn/9g/oQ4eLm65571R4h8
	RaNhEXn+xhDJiAgJ74ZgD60wrPNQLoMPE3G5rckRdB6EafAMkysJyIYgSr8bQ8RiJTjlKkyL+Ce
	DNGk8glMgrT7dGL2n+wDWt3wrUpi7h7saVeDpSvvMzAt2/aOcEbGY1ywHgriUAVybh9HH7d1cKA
	wlfkhOFEtuF8NNO/K08MaPF7VLWato1NBm9+/sfz9NAYYQgZF39cZNLrv21bwqo4czuKtHa9KvS
	aua7pJeV7z4Y7Jt7VDTJ6XZb6vhSu67Na2k9YbQcazNsVzUByEnxtRfoGukUA0vblc
X-Received: by 2002:a17:90b:4c0c:b0:35b:e554:53a6 with SMTP id 98e67ed59e1d1-35c2ff8c23emr9330644a91.11.1774793117775;
        Sun, 29 Mar 2026 07:05:17 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.111])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35d950bd630sm4417454a91.16.2026.03.29.07.05.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 29 Mar 2026 07:05:17 -0700 (PDT)
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
Subject: [PATCH bpf-next v9 0/9] bpf: Extend the bpf_list family of APIs
Date: Sun, 29 Mar 2026 22:04:57 +0800
Message-ID: <20260329140506.9595-1-pilgrimtao@gmail.com>
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

Changes in v9:
- Expand table-driven approach coverage
- Clear list node owner and unlink before drop
- Remove warnings caused by WARN_ON_ONCE()
- Introduce the __nonown_allowed suffix

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

Link to v8:
https://lore.kernel.org/all/20260316112843.78657-1-pilgrimtao@gmail.com/

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

Kaitao Cheng (9):
  bpf: refactor kfunc checks using table-driven approach in verifier
  bpf: refactor __bpf_list_del to take list node pointer
  bpf: clear list node owner and unlink before drop
  bpf: Introduce the bpf_list_del kfunc.
  bpf: refactor __bpf_list_add to take insertion point via **prev_ptr
  bpf: Add bpf_list_add_impl to insert node after a given list node
  bpf: allow bpf_list_front/back result as the prev argument of
    bpf_list_add_impl
  bpf: add bpf_list_is_first/last/empty kfuncs
  selftests/bpf: Add test cases for
    bpf_list_del/add/is_first/is_last/empty

 Documentation/bpf/kfuncs.rst                  |  20 +-
 kernel/bpf/helpers.c                          | 126 ++++++-
 kernel/bpf/verifier.c                         | 301 ++++++++++-------
 .../testing/selftests/bpf/bpf_experimental.h  |  16 +
 .../selftests/bpf/progs/refcounted_kptr.c     | 311 ++++++++++++++++++
 5 files changed, 636 insertions(+), 138 deletions(-)

-- 
2.50.1 (Apple Git-155)

