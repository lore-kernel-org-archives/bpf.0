Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD017381B1F
	for <bpf@vger.kernel.org>; Mon, 27 Apr 2026 16:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309175; cv=none; b=WCnn4G35+Zpt/OC9EXfsb0QwJRhp9VA2XTt5kPym0pSGpBg29rUJ8xqQPB4oHaENgTMelgjQVixCi/u5MirgLbxj7pNOUvxj/14owjg6o1QTwHdnQaDFwel5wDdfYQY9vhAhppoeQxk/aA6fe80PpR0YI11j6/go/gO5EIH9Hd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309175; c=relaxed/simple;
	bh=Eh74TSifcGeEOIzcpSzOVIR1X9KHsOJLEHChXgvhSDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EhQ6N206z4bAcbnxRRFGb+h8BmHdDpkqPRSIydJEr8pOXVWTaoLRL/sk8KX63jNEGsiLMd8ocknvFFZAooQb1qz6SHcGUmSgaS1Ik+OkZ5VLuHHKKSLQR3NvbDhvbVcEHRF/5MSnJJNPNmnA35Wxp2iWoR/YpUL2awAxJzL/OyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OzHyqwzg; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OzHyqwzg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777309158;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KuQ4lB0Yb/eJHtuSptfULFcyza6MPAInuIUye+FUgmc=;
	b=OzHyqwzgNU3USZCD8JWyycUprZ4XXGPunbAZmN9q2DDrlE/rnk2oO3/z+8WAtD+PgM2xii
	DIzTG6vIKFB6XEAD5N7twZlE+j2hqFVfWtlWpS44HSRIbnQhQJwFHDiDfoxejMkt+sbPNC
	09m/HnPYV8uG9Z1pvLirzUIMVQQWIe4=
From: Kaitao cheng <kaitao.cheng@linux.dev>
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
	linux-kernel@vger.kernel.org,
	Kaitao cheng <kaitao.cheng@linux.dev>
Subject: [PATCH bpf-next v10 0/8] bpf: Extend the bpf_list family of APIs
Date: Tue, 28 Apr 2026 00:58:58 +0800
Message-ID: <20260427165906.84420-1-kaitao.cheng@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

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

And add test cases for the aforementioned kfuncs.

Changes in v10:
- Remove the table-driven approach (Ihor Solodrai)
- Use the __nonown_allowed suffix for bpf_list_del/front/back
- Add test cases for __nonown_allowed

Changes in v9:
- Expand table-driven approach coverage (Emil Tsalapatis)
- Clear list node owner and unlink before drop (Emil Tsalapatis)
- Remove warnings caused by WARN_ON_ONCE() (Emil Tsalapatis)
- Introduce the __nonown_allowed suffix (Alexei Starovoitov)

Changes in v8:
- Use [patch v7 5/5] as the start of the patch series (Leon Hwang)
- Introduce double pointer prev_ptr in __bpf_list_del
  (Kumar Kartikeya Dwivedi)
- Extract refactored __bpf_list_del/add into separate patches (Leon Hwang)
- Allow bpf_list_front/back result as the prev argument of bpf_list_add
- Split test cases (Leon Hwang)

Changes in v7:
- Replace bpf_list_node_is_edge with bpf_list_is_first/is_last
- Reimplement __bpf_list_del and __bpf_list_add (Kumar Kartikeya Dwivedi)
- Simplify test cases (Mykyta Yatsenko)

Changes in v6:
- Merge [patch v5 (2,4,6)/6] into [patch v6 4/5] (Leon Hwang)
- If list_head was 0-initialized, init it
- refactor kfunc checks to table-driven approach (Leon Hwang)

Changes in v5:
- Fix bpf_obj leak on bpf_list_add_impl error

Changes in v4:
- [patch v3 1/6] Revert to version v1 (Alexei Starovoitov)
- Change the parameters of bpf_list_add_impl to (head, new, prev, ...)

Changes in v3:
- Add a new lock_rec member to struct bpf_reference_state for lock
  holding detection.
- Add test cases to verify that the verifier correctly restricts calls
  to bpf_list_del when the spin_lock is not held.

Changes in v2:
- Remove the head parameter from bpf_list_del (Alexei Starovoitov)
- Add bpf_list_add/is_first/is_last/empty to API and test cases
  (Alexei Starovoitov)

Link to v9:
https://lore.kernel.org/all/20260329140506.9595-1-pilgrimtao@gmail.com/

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

Kaitao Cheng (8):
  bpf: refactor __bpf_list_del to take list node pointer
  bpf: clear list node owner and unlink before drop
  bpf: Introduce the bpf_list_del kfunc.
  bpf: refactor __bpf_list_add to take insertion point via **prev_ptr
  bpf: Add bpf_list_add to insert node after a given list node
  bpf: add bpf_list_is_first/last/empty kfuncs
  bpf: allow non-owning list-node args via __nonown_allowed
  selftests/bpf: Add test cases for
    bpf_list_del/add/is_first/is_last/empty

 Documentation/bpf/kfuncs.rst                  |  22 +-
 kernel/bpf/helpers.c                          | 139 ++++--
 kernel/bpf/verifier.c                         |  44 +-
 .../selftests/bpf/progs/refcounted_kptr.c     | 421 ++++++++++++++++++
 4 files changed, 593 insertions(+), 33 deletions(-)

-- 
2.50.1 (Apple Git-155)

