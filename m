Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.3
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793157621;
	b=TROcIsiPUun8bh1TeT3mjRrBF6ql9gIXj3ZY4YcBRygc57FlhnLPD2os+rkCu4VHzC0t
	 gc9AcZ3iZVw+yqp0g/HkQd9IjMlFbRvRxAeBLsrAjB1r7Op2NGmL1sfAx3okpq8u1HDNI
	 0yTPcUnbZrVOmI2yr1HyKTmAL91sBtuCBh1kHee3disivuybX0KTrjytZctszJPEfMORD
	 JV5aoN3v+4VKVBJHNKTiNepJ42V6hJmXHvVANmBc0tRgBfy71QCe1oWLpEMP+PeJ5orEI
	 4ZxYsnB3AKag8LC0WuGcyUdvpMS6tPuabJ1TJwATNPhU/hY4TXEs4yxp0p0tiHJe2qA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793157621;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=edxukvZT1wv5mfC7woY3zyXZbPK4Ck+cxdagnujaH0o=;
	b=4663TVHN8SBC3rrCo6E+mOx4597DDSeK+e8Dg/xHSIVrkfRlSnAJkGpGqfsjMADpN1mT
	 ecme6WUXKo/1iCbcMJG1We5+VsXHp8QbW2I6RlvqzEj6Ydx5iySxPEP09qMd4wxakYLRD
	 u27nSs3a1dWHIqLHcUv4sv56Rp5DGLOoKNNhmIXC7kOp0VxrC1LByXc6HZnq0o80yadFn
	 /R4w1A0QdpsYevv8ejxPvE6wiQdLTDiH+DosH5ipWh3HWWdZyBPiOAPt+glK8UL7iP78L
	 O5J01hOP0XOy6eJVnUGlPUAIn4zOv3rwkMQmXLMiRtjdalxt/FvTBxk35MqEEJ4RmrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RtDt8zaJ;
	arc=none smtp.remote-ip=220.197.31.3
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908C4606A31A;
	Wed, 28 Oct 2026 03:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 908C4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=RtDt8zaJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ed
	xukvZT1wv5mfC7woY3zyXZbPK4Ck+cxdagnujaH0o=; b=RtDt8zaJUqVIhlWDkM
	knNI4S+Y8lkmNKCSCyOfbzbZJ6jv7TWVilhqMSC2zLQRe3h6x2TC0Pqxgxo1rNa6
	tbZkrB6s/GPvUav/XV6azs8tV0J3CbbVvQ+L1vjUDVso/BaLKo4Z1IRbOcayJEpl
	Lj6XLT3elHZnHAHgbL102ddyg=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDXX7nFaeFqCf7_CQ--.61470S2;
	Wed, 28 Oct 2026 11:19:34 +0800 (CST)
From: Feng Yang <yangfeng59949@163.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev
Cc: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3] bpf: Fix out-of-bounds btf->types write for split BTF
Date: Wed, 28 Oct 2026 11:19:33 +0800
Message-Id: <20261028031933.277550-1-yangfeng59949@163.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDXX7nFaeFqCf7_CQ--.61470S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWxJryxKF4UZF1xuFyfZwb_yoW5Ww4kpr
	4UCFWrAw48W3WxX3W7Ka15Wa1UCw13A3y7JFyDZrWFyF4YvF10qF10y3ya934aqryDGrWa
	yF4qvrnYkw4rWFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjuWLUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8gifGGrhaci-owAA3L

From: Feng Yang <yangfeng@kylinos.cn>

btf_add_type() stores the types of a BTF in btf->types[], which can hold at
most BTF_MAX_TYPE entries.  The types of a split BTF get IDs start_id ..
start_id + nr_types - 1, so only BTF_MAX_TYPE - start_id of them fit, but
neither the limit check nor the size used to grow the array accounts for
start_id: the check is an equality test against BTF_MAX_TYPE
('start_id + btf->types_size == BTF_MAX_TYPE') and the new size is clamped
to BTF_MAX_TYPE.

The check therefore only fires if the array happens to grow to exactly
BTF_MAX_TYPE - start_id entries.  Otherwise, if the module has more than
BTF_MAX_TYPE types, the array is filled up to BTF_MAX_TYPE entries.  The
next type that needs to be added reallocates the array to the same size,
after which btf->types_size no longer equals btf->nr_types and the growth
path is not taken anymore, so every following type is written past the end
of the array:

  BUG: unable to handle page fault for address: ffffc90006200000
  RIP: 0010:btf_add_type+0x74/0x270
  Call Trace:
   btf_check_all_metas
   btf_parse_module

Bound both the array size and the limit check by BTF_MAX_TYPE - start_id.
Base BTF (start_id == 0) is unaffected.

Fixes: 951bb64621b8 ("bpf: Add in-kernel split BTF support")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
Reviewed-by: Mahe Tardy <mahe.tardy@gmail.com>
---
v3: Simplify the commit message. Thanks, Ihor Solodrai.
Remove the redundant btf->start_id >= BTF_MAX_TYPE check introduced in v2.
When entering this branch, types_size == nr_types >= 0, so the condition
start_id >= BTF_MAX_TYPE is already covered by the second check.
start_id comes from btf_nr_types (base_btf), and the base BTF is subject
to the same bounds check, so start_id <= BTF_MAX_TYPE.
Thus there is no u32 wrap-around for start_id + type_size,
and max_size cannot underflow.

v2: https://lore.kernel.org/all/20261026073654.840705-1-yangfeng59949@163.com/
---
 kernel/bpf/btf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 7ed1ff71a089..1be30487a2fa 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1752,15 +1752,16 @@ static int btf_add_type(struct btf_verifier_env *env, struct btf_type *t)
 		/* Expand 'types' array */
 
 		struct btf_type **new_types;
-		u32 expand_by, new_size;
+		u32 expand_by, new_size, max_size;
 
-		if (btf->start_id + btf->types_size == BTF_MAX_TYPE) {
+		if (btf->start_id + btf->types_size >= BTF_MAX_TYPE) {
 			btf_verifier_log(env, "Exceeded max num of types");
 			return -E2BIG;
 		}
 
+		max_size = BTF_MAX_TYPE - btf->start_id;
 		expand_by = max_t(u32, btf->types_size >> 2, 16);
-		new_size = min_t(u32, BTF_MAX_TYPE,
+		new_size = min_t(u32, max_size,
 				 btf->types_size + expand_by);
 
 		new_types = kvzalloc_objs(*new_types, new_size,
-- 
2.25.1

