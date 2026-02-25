Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408FF299950
	for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 09:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772011639; cv=none; b=LkBnVAdoyX/q2hQvt0FOgW4uHKr9fql2uQd796ZlP2VY9MUVb7FVz4hxJtsQDJ3Fhkor+8uHQ6kLD1pWGnIzKapqFpRal+znoxsGVsipO/vhg9l7DwqbdApDPObP5HApAEoLlHSTbL4fp7cxQbjN4OwfNyoxh/U9jnz65YTMD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772011639; c=relaxed/simple;
	bh=DSh9cmYcoDq6RSZ2gJWFd5OqBgP4RP8EBSvvqxMW3uM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iF6IQMf/cjzZ8grybDh+ayDl5ywo3dMXqYcbMAnewQCFuEBbJudJigfYsgUg3UyhpYtwWn5BAckHZGFOR7D+Oh5Ezmp0TnNZnFq/7pyZxEulIPmd41HnGA62L4E7Sdhr6041QLlaTJY5cxSu2EYDm13U1rKUchh8dxn3fyQeQvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gk1tpvoK; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gk1tpvoK"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3590042fa8eso646633a91.1
        for <bpf@vger.kernel.org>; Wed, 25 Feb 2026 01:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772011638; x=1772616438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xce9lXDzX6z1O07ZSxBwTpQMJv4vT6Yu3vRs6kQbfoQ=;
        b=Gk1tpvoKR6WEnHFYtTOEG1fnHZ23zBcYdRjnZ+oyAZd35iQeqOVShD2upmXl5RbJPm
         dnxz+yip746WDDjcSvSjljdf/eeZ5a+D6XLoK2t3AeP/LPv+cSz766D1T/9EZ/OICRHz
         IIRLj5dhjKVgywEK3CiF+9eVb/VPcyPprkeCruMavk7Cezd/JLUXTxnwWtOtfBvKY2UM
         M2+LItV/iZFY2ttpcTsoQfu/Kdaj16icwxMPysCGl4jmDEmFwJJ858gZ4t3wuPsDIXYX
         98IxLzZ8umYgGqNSRzy8P+8HbBY6xzdJf19QK2K46GZVMwfheqi8dRJlYE6K4q4GutjQ
         R7jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772011638; x=1772616438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xce9lXDzX6z1O07ZSxBwTpQMJv4vT6Yu3vRs6kQbfoQ=;
        b=n9VX/e/gy8k3jsYwJo1RjZJ3nhLbMjdD9rnfdMsNQFhR6AjqMgVnKHFJfnBp0aN8gL
         VEaIaR77w3BO47cxgsOiL4e39yPqslIwb1p2fgBmaAOO2myXqnOAY5lXrQfAdq4b5EJ2
         wvG/o2G0axGNlQyS4a+03QsEHJyIFe8PgD3t/QYGXZgTJmDhWPVEbKtxasXwboCpW73l
         yn74Qj7zMs1B0EitBccJVMuKpvJ7FOwvpoTgXZLGjvynTSUuCEPy+0pVwoErhx8fvYFw
         0BvZBZMLPqkmMxtSdJ4fHhxLXOLJo2XXk7mtfw6vvGURamkWzFYDjjjEHZNtWX0MKZ7K
         /M/A==
X-Gm-Message-State: AOJu0YzJLBlx4QHuxrHzCT0VyF4pFNOhZ+MysghpwrdTLdTLxchWp+BU
	p09QEpYPCEOAn+sBNSPN+r7wfs6YkEw5QSfzhoA6V3K/RJBd2KLKYZXf
X-Gm-Gg: ATEYQzyhxwC7LVdli/brPkQ+lzoqLD8YQF5QifdNWNq8bunSL1sOVW8A2qe2J8NtXsc
	08z75J0uc2Y9wGU0gCsaYK4yPmEneF53mXK21kKAKhUozbtIOUfo3Aqy0y4q8/QXMpv0pQoNq4R
	0Add6zJ85kVTHgbboqmky+aX9tWJqRgafodmqsLmaauExcesDjs6ulRh/nh8zR87zmlt/RH1bQZ
	v1CA3MGQOzb4v4y4yA/Rg8dDs5eiDWY0b4jx2gEH5llB1r9GHi+WdOS6/nfGjUfGpQJI2ZHitBx
	NJ8yR92+fplUBYrLXh3k21AmGYTr91zk4C6tCdMorOoIqfZ5EawwQt3thLdPwxY2QQgALcYZYFb
	cLpLZBO3t7iJDUxbUIY4HnzJLvrjUs2Me/pp5xPo2tKmRNGXqRkQJ0wJXajIkcrTdN35+eqZN+D
	2rqg8QHW5lKacAgz5eDoJ/4vSFkqWrdA5EMFSw8msepDxjtJdgwz58UA==
X-Received: by 2002:a17:90b:4a4c:b0:356:41c2:897e with SMTP id 98e67ed59e1d1-358ae7c31a4mr10841911a91.1.1772011637566;
        Wed, 25 Feb 2026 01:27:17 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35912f5f29fsm837901a91.1.2026.02.25.01.26.59
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 01:27:17 -0800 (PST)
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
	leon.hwang@linux.dev,
	linux-kselftest@vger.kernel.org
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/6] bpf: Extend the bpf_list family of APIs
Date: Wed, 25 Feb 2026 17:26:45 +0800
Message-ID: <20260225092651.94689-1-pilgrimtao@gmail.com>
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

Changes in v2:
- Remove the head parameter from bpf_list_del
- Add bpf_list_add/is_first/is_last/empty to API and test cases

Link to v1:
https://lore.kernel.org/all/20260209025250.55750-1-pilgrimtao@gmail.com/

Kaitao Cheng (6):
  bpf: Introduce the bpf_list_del kfunc.
  selftests/bpf: Add test cases for bpf_list_del
  bpf: add bpf_list_add_impl to insert node after a given list node
  selftests/bpf: Add test case for bpf_list_add_impl
  bpf: add bpf_list_is_first/last/empty kfuncs
  selftests/bpf: Add test cases for bpf_list_is_first/is_last/empty

 kernel/bpf/btf.c                              | 33 ++++++-
 kernel/bpf/helpers.c                          | 92 +++++++++++++++++++
 kernel/bpf/verifier.c                         | 28 +++++-
 .../testing/selftests/bpf/bpf_experimental.h  | 38 ++++++++
 .../selftests/bpf/progs/refcounted_kptr.c     | 87 ++++++++++++++++++
 5 files changed, 272 insertions(+), 6 deletions(-)

-- 
2.50.1 (Apple Git-155)

