Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6202110E
	for <bpf@vger.kernel.org>; Sun,  8 Mar 2026 13:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772977596; cv=none; b=tsfrs3SLFUOoshhbDPMQyectUY1x5YRoNb26uDoUZnqyYxoLPDK3MJKwVWGGeaITz/zc7uBK4P6cXqIPWehmlqZBuU//QT42Vho1gblzv/APEqC7bEuEIB5FjmB2mDqAU05XJZGMpbIw/KpvBNMZN85ROfobHMsYcCFdJMAp9aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772977596; c=relaxed/simple;
	bh=Ms1medIm3lUakbcGGlgIz09mCoV0O+2kC59uF9/DNwk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mt4Ep4tU+TPb9QU8plWcr7a/TnjQ9LAyknP8KU5AVsYTGp+89auZPpZF36tIk6U/x5PmDkHlFM+MSPVZree/5QGOBL6eZ/os/jW4kMMlCI3J9j+SaRd1YzmHhuVnlYVe5HmBsTiC3H9E3qUm1C/WGMPydjHROHk3k3m6WgV4Bjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PX5mBAl5; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PX5mBAl5"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-829a568f3ccso1004939b3a.0
        for <bpf@vger.kernel.org>; Sun, 08 Mar 2026 06:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772977594; x=1773582394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=724CiEVW7rjLnZsSrHgbVvU2fcWwebcILCwsZMr5Rok=;
        b=PX5mBAl5uZQiF0nryvc+cvTm6sromP2WjSBTVp5zthi1DTBFxDr3bqGQ5+vrMihVAv
         ShZFV3JmKAzKvr3Dny857Hl5MlYpftB497/OR9/CxfX1+RKlIZfTDpJ51SBqEYRBjpV5
         isRfELkEQ4r/baSSA/0Z5XAFHlHBspwgCTf9mitc65sCGrVzX14tU6q4S6gCeKVnW+Oj
         3BI5JXUV+XeTQzie2UP79wxlKA0kICdYixEOE3G5kIXlSoKDdvx3cMMfTu7Op1faewEN
         xUUvZNECfqMvzbBEboib118whoTfhZPrKtbcjGnt9/WzelijFtm2Yi/PFDQ97fiyrJph
         QiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772977594; x=1773582394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=724CiEVW7rjLnZsSrHgbVvU2fcWwebcILCwsZMr5Rok=;
        b=X8wUSLtb8sC/xH3r0fXXgTEiu7fVKioMVqie+AmkyRbaJkSwcPejbrUWMdDZ8qaxul
         bK5TmyJcvrbJQ/I1zOE0QyhU3asKObW+DCo+FhkTiSjhEeB9NDdMdQMGWmeo/OjCvxop
         cf6CvFiqhEs3ST9zEulY7Kgg0ZdkYy+YWbqidFlZwZojgaz1SkQb4ebv9uhOFKmVwd2U
         Q5m5bvv6k6dyWSamJEQ0mhCWAr2MsM51C+BC3Rb1j5R22BpycH5Ao3kev/v/9kROW/5d
         8g5J6F5InpDcAYfWPfMqRHDt7KQvu9m8Msy+37O/1E/hIPvy2Yw3vcl+MZnHxNQDAwn6
         tiaw==
X-Gm-Message-State: AOJu0YyoRkPyeWs/fpwVwk6LCZtuuuOLxH+VIcT6xrGeEgwGjMcC+zi/
	2Yf0N+5jwndFz6xHpENYUJTY5bBIegpubxTlmp15gM4j1Hp2j66StU0U
X-Gm-Gg: ATEYQzzfrnucQ7hO7Yhd3H4uacLdZSS1Gnk5MNalZ8Rxqg+nkNnPdcLDQQ6mLVXK3yP
	57Dhvst0f8B7MRwk3vBjtZfz0/E7aglWgFvCxrhjf7gf12hJ+C+wzXjBZ6cwcKnkN9K3k3Xwq3D
	stKtP+60BBnFjBe6beb0dhzCe/2T6DrS6GDjdYKzq0Vdi3RoKducJBx1FPFUnSsMVRKMl/nWidL
	IdZvUq4gcHc3hmcmmfcVEyOORC7AuZ4j9+AuslX0kaBFKCKqrKVxPFWO0VB9qgjX+mf5bHyOA6U
	8+uxbFdnqLXUKRvBNVhjt8lBxtlHDizspAG3ryNvKSgyz/cqoVHEnZmIrCxeVqKv4hyJx0YX1D0
	DTqVx0ilRAr/oMSuCx3N68eWYGxfclXddU75opzhuPglJOlnDhTjSEYT9CL/TsCMXQfGB0qZ3fv
	pt74rMpC6qZaW6UoOe2RonUtZj58CTP9WTSPVMP94P2mrob8Uq
X-Received: by 2002:a05:6a00:1397:b0:827:4bca:f1a2 with SMTP id d2e1a72fcca58-829a2d81a8dmr6902060b3a.10.1772977593860;
        Sun, 08 Mar 2026 06:46:33 -0700 (PDT)
Received: from localhost.localdomain ([113.218.252.35])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a4636968sm7095056b3a.9.2026.03.08.06.46.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 08 Mar 2026 06:46:33 -0700 (PDT)
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
Subject: [PATCH bpf-next v7 0/5] bpf: Extend the bpf_list family of APIs
Date: Sun,  8 Mar 2026 21:46:09 +0800
Message-ID: <20260308134614.29711-1-pilgrimtao@gmail.com>
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

Kaitao Cheng (5):
  bpf: Introduce the bpf_list_del kfunc.
  bpf: Add bpf_list_add_impl to insert node after a given list node
  bpf: add bpf_list_is_first/last/empty kfuncs
  selftests/bpf: Add test cases for
    bpf_list_del/add/is_first/is_last/empty
  bpf: refactor kfunc checks using table-driven approach in verifier

 kernel/bpf/helpers.c                          | 124 +++++++++++++---
 kernel/bpf/verifier.c                         | 107 ++++++++++---
 .../testing/selftests/bpf/bpf_experimental.h  |  16 ++
 .../selftests/bpf/progs/refcounted_kptr.c     | 140 ++++++++++++++++++
 4 files changed, 339 insertions(+), 48 deletions(-)

-- 
2.50.1 (Apple Git-155)

