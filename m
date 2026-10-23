Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792737139;
	b=JZP0LNzdUvrPTdl8b4MSXGcRJWlE2b3Ljmz5Uxs2sfvZKSy5TDPshABI1FwB8ABpWEO4
	 cYYP59KAcs0LfNUJWzVXtG8piY293cl/mS38RoTkPo74RS6H3XzLYnjDL1ZcGgaFs6siY
	 v6cN9EpcIZj9h1/zEJNlmbmQcup+ff/eJprJY8G8zWGhlXcoUmm0r8dIWCv2U3LiUMv/7
	 lvIl5xdvvjsNHzbYajemOX8xv4QqYImzWuTZ1IFI9hhBPc1qItLrq8ay4Vl6jHet+N7MD
	 +7yCMCRjEWJPDLGu3aMOJ/DUCCJgptSEHeFS7NZAHYRfp3PsCdoSkx36gFz6zBh1avg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792737139;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=53q4hKUwSxmOGTdqj6wVD4BacLZd8aKY6NwLSWD1Qbo=;
	b=ALBrDoD7Fh728tMLdIX9LQzGbPRYHsconEwuTlIqESWm2HtP5SyJA4lRLDaA68Z66gXQ
	 ZjXSNBCq/d9etCcjQmUBeklPQRmSOkYw9rxku/dldIeptc1mIiYrEqE24ua/nv12cMPqm
	 Fdvje4N2P0DbySdrgQ5n7GukQkXf68vUaYYTahc+zQwd9FkEfyWTk0XwYvEJ/TdJjwtLR
	 INdcFGRviVyQAQ+yTvQq9P1R7nsAMlPd1mVYJ2kMz9gAcEcy1TBNEnloGuP8XujtTMMJN
	 SbXFzwEEZ+MdRK816eOhV4+ylYYcsr7OW6C5kxrYJOgpoE7LCOqmDEhY1MJRpdMkX4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gLkNvysd;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA8A606A31B;
	Fri, 23 Oct 2026 06:32:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFA8A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=gLkNvysd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=53
	q4hKUwSxmOGTdqj6wVD4BacLZd8aKY6NwLSWD1Qbo=; b=gLkNvysdOjvphNNUNN
	IWR0nm78no+N9bg+1S9l2PNUM6aANbT0r4M0bssRp95U4wyLzBb+huJEceKa46WG
	qVsOJjXiwBqdtkUCAzlGsD+JL6OWcmixTCjPaztYjBzXakfU4+gyrVppTf3b7rrA
	GRaA1hWkLlLeFbfOXeEiUGHFY=
Received: from localhost.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgAHkJ5H_9pqSnUzBg--.1818S2;
	Fri, 23 Oct 2026 14:31:36 +0800 (CST)
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
Subject: [PATCH bpf-next] bpf: Fix out-of-bounds btf->types write for split BTF
Date: Fri, 23 Oct 2026 14:31:33 +0800
Message-Id: <20261023063133.563998-1-yangfeng59949@163.com>
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
X-CM-TRANSID:QCgvCgAHkJ5H_9pqSnUzBg--.1818S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWxGFykKFWUXFWrtFy3XFb_yoW5Aw13pr
	4rCFs5Cw4fW3WxXa47ta45Wa18Kw1rC3y7Jr90yrWFyF4j9r10vF1UJrW293sFqFn7GrWY
	yr409r9Ygw48WrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jjuWLUUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8ghj22ra-0iXPQAA3v

From: Feng Yang <yangfeng@kylinos.cn>

btf_add_type() bounds the btf->types array by BTF_MAX_TYPE, but for a
split BTF the type ids it registers are start_id .. start_id +
nr_types - 1, so what is actually left of the id space is
BTF_MAX_TYPE - start_id.  Two things follow from that:

 - the limit check is an equality test,
   'start_id + btf->types_size == BTF_MAX_TYPE'.  It is evaluated only
   when the array has to grow, with btf->types_size == btf->nr_types,
   and the growth (T' = min(BTF_MAX_TYPE, T + max(T / 4, 16)), starting
   from 0) is clamped to BTF_MAX_TYPE, which it lands on exactly (...,
   928143, then min(BTF_MAX_TYPE, 1160178)).  So unless
   BTF_MAX_TYPE - start_id is one of the 48 sizes that sequence hits,
   the check does not fire for a split BTF at all;

 - new_size is clamped to BTF_MAX_TYPE instead of
   BTF_MAX_TYPE - start_id, so the array can still grow to
   BTF_MAX_TYPE entries even though only BTF_MAX_TYPE - start_id type
   ids exist.

As a result nr_types can reach BTF_MAX_TYPE for a split BTF while its
type ids have already gone past BTF_MAX_TYPE; a type never validates its
own id, only the ids it references (btf_ref_type_check_meta()).  At that
point btf->types_size == btf->nr_types == BTF_MAX_TYPE and the growth
branch computes the same size again: it allocates a fresh BTF_MAX_TYPE
entry array, copies the entries, and the loop is left with
btf->types_size != btf->nr_types, so that branch is not taken anymore.
Every type after this writes btf->types[btf->nr_types++] past the end of
the array: BTF_MAX_TYPE * 8 == 8388600 bytes are requested, so the first
such write lands in the 8 byte rounding slack of the 8MB allocation, and
each further type writes another 8 bytes beyond it.

Fix both by bounding the array with BTF_MAX_TYPE - start_id and by
turning the equality check into a '>=' one, so that the array stops
exactly where the id space ends. Base BTF behavior (start_id ==
0) is unchanged.

Fixes: 951bb64621b8 ("bpf: Add in-kernel split BTF support")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/bpf/btf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 80b6f96263f1..6e54cd6c2eb5 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -1724,15 +1724,17 @@ static int btf_add_type(struct btf_verifier_env *env, struct btf_type *t)
 		/* Expand 'types' array */
 
 		struct btf_type **new_types;
-		u32 expand_by, new_size;
+		u32 expand_by, new_size, max_size;
 
-		if (btf->start_id + btf->types_size == BTF_MAX_TYPE) {
+		if (btf->start_id >= BTF_MAX_TYPE ||
+		    btf->start_id + btf->types_size >= BTF_MAX_TYPE) {
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

