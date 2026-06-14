Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4371DA62E;
	Sun, 14 Jun 2026 01:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401738; cv=none; b=DlI33o/FEEqanO5MdyxEdx89s3na1uWGgKPQbs3UI3poRbWCneIf+weWQRcLlrA4WTlqgibdxsbkAcQt2Qm/fcYVsU+d5k7MXJAa7gS3biycN32I5reg5pn3rUbErRr42rQ+l38Wh64bw/L2IGtziV77ksb+korwunfl18m/t3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401738; c=relaxed/simple;
	bh=YeEP+WqCxnv2RnQpadTTC+q/SBm19DgQ7NfxB2XwN00=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FBj7DZQQCC7E3traCwNHO3zcwJb3JoAeZdXUoRnsTPuwL58By8PAR9w0MaJtVzmP/tG+LxnhqbQe8T7M2FfDj6rUvxzo3diyhOpo4Ahu6Wk0Q17pCy7hJJlqzj7d8JMVKAB78+NfTr+8O0kPPvkeZYJZ5ZI61a9+PmMXFhXtfpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KX9vI8Vq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KX9vI8Vq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 697511F000E9;
	Sun, 14 Jun 2026 01:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401737;
	bh=qVtgME4gMEoVa5tgfXnYNnnTRLVRhPpsyIl4+EaBT/4=;
	h=From:Subject:Date:To:Cc;
	b=KX9vI8VqJjHcprbN4iJZkgM/Xvl8s9DLoU9ggUCD6IddIokkI2oyCeAlg95vFrFH5
	 W0cYLimIzoVQXeqd+Jn2tbh063jwT+BjmrPJBT8Yh1IxMR+3ntr+nnkx+Ne5A+Se7E
	 ETPAeCioKxjyrSjq7/2XXbib308q8gjoSZhYrbosbY3dPTwSdOVRsMsO2VfU6JcMvt
	 z3/8osT4n9RxP/aPWNTJouKCYAKSgyQrnUSX9f82BL9btWV4fbwWi+8nUfKkBQLI6I
	 1xrzbKhKEC63g4FTZJVVX62Gls/J7Ol+iPnOyQ3wU1vUPD11aluh5fODVjv556jmd1
	 RUi9vUWqJpLOQ==
From: Tamir Duberstein <tamird@kernel.org>
Subject: [PATCH bpf 0/6] libbpf: Fix ring buffer consumption
Date: Sat, 13 Jun 2026 21:48:43 -0400
Message-Id: <20260613-bpf-ringbuf-fixes-v1-0-e623481cb724@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ7CMAwEv1LtGUtNKiLgK4hDHZxiDqGKKUKq+
 ncMHGd3Z1eYNBXDqVvR5KWmj+oQdh3ybayTkF6dEfuY+hQG4rlQ0zrxUqjoW4zkOB54yCnEPcO
 9ucmvcO0Mn+PyD23hu+Tn9w3b9gG1uFN4egAAAA==
X-Change-ID: 20260613-bpf-ringbuf-fixes-e9a8b3c6125b
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Shuah Khan <shuah@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
 Xu Kuohai <xukuohai@huawei.com>, Andrea Righi <andrea.righi@canonical.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, Andrew Werner <awerner32@gmail.com>, 
 Zvi Effron <zeffron@riotgames.com>, Andrii Nakryiko <andriin@fb.com>, 
 Tamir Duberstein <tamird@kernel.org>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2159; i=tamird@kernel.org;
 h=from:subject:message-id; bh=YeEP+WqCxnv2RnQpadTTC+q/SBm19DgQ7NfxB2XwN00=;
 b=owGbwMvMwCV2wYdPVfy60HTG02pJDFl6HE1i7a7f7v8qEX51o+HDHt8VH7ZdKDwq5CO8wf2su
 FPXzrplHRNZGMS4GCzFFFkSRQ/tTU+9vUc2891xmDmsTCBDpEUaGICAhYEvNzGv1EjHSM9U21DP
 0EjHQMeYgYtTAKZa8DrD/+AJBfWKzOIpCvqP6lcJTDgzheXBjKuSqcxe8pXTL5dmCDD8Yn79rzg
 8TXPblJmxq1NnrbmeVXqo5dBhWa7lnm92F9qs4wAA
X-Developer-Key: i=tamird@kernel.org; a=openpgp;
 fpr=5A6714204D41EC844C50273C19D6FF6092365380

Fix several correctness issues in libbpf's ring buffer consumer.

A zero record bound currently consumes one record. A NULL callback is
accepted during manager construction but crashes when callback-based
consumption reaches the ring. Position counters stop consumption after
wrapping because they are compared by magnitude.

The consumer can also miss a readiness notification after publishing its
position and checking for new data without a full StoreLoad barrier. Use
compiler atomics and add the missing barrier, including when retrying a
busy record after publishing earlier records.

Callback traversal does not follow the overwrite position maintained by
BPF_F_RB_OVERWRITE maps. Reject callback consumption of those maps, as
discussed here:
https://lore.kernel.org/bpf/CAEf4Bzaq5drHWChXoRBnrmkb6reAsSVj8r=uByFSup31FMA7hw@mail.gmail.com/

Andrew Werner found the position-wrap and missed-wakeup failures while
implementing Aya's ring buffer reader. Aya's original implementation
contains the equality reasoning and edge-triggered regression test:
https://github.com/aya-rs/aya/commit/e2cf734490bc188bcedb1eac92d23d81123e42cd

Aya later corrected the consumer ordering with the same explicit fence:
https://github.com/aya-rs/aya/commit/7277a57ea8cdb74918d3096a4b22b6d814481973

Assisted-by: Codex:gpt-5.5
Signed-off-by: Tamir Duberstein <tamird@kernel.org>
---
Tamir Duberstein (6):
      libbpf: ringbuf: Honor zero consume bounds
      libbpf: ringbuf: Prevent NULL callback crash
      libbpf: ringbuf: Handle position counter wrap
      libbpf: ringbuf: Use compiler atomics
      libbpf: ringbuf: Prevent missed wakeups
      libbpf: ringbuf: Reject overwrite callback use

 tools/lib/bpf/libbpf.h                           |  34 +++-
 tools/lib/bpf/ringbuf.c                          |  84 +++++++--
 tools/testing/selftests/bpf/prog_tests/ringbuf.c | 229 +++++++++++++++++++++++
 3 files changed, 323 insertions(+), 24 deletions(-)
---
base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
change-id: 20260613-bpf-ringbuf-fixes-e9a8b3c6125b

Best regards,
--  
Tamir Duberstein <tamird@kernel.org>

