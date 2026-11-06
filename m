Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793959133;
	b=zXaXloeb4HDzrtzMbrqyLMguBUCxiae4INRcFc5dgepq8znIOzS7c3Fops6Lc3IFZiJv
	 fN3rJero+vZGSkhqZaFU2/GXx63ssLn7akTM+dta2Pbzf8GlNGgFQhjl3sEMLDOrAUW3n
	 nESbdlARNfT4+anq3G6BDou8cWA9CmZOk6jk/74t+d1sDRXdJXaVFfvy0Hd0tyWnjktAt
	 tMp67NYycjBuIh/O5HgoQEXm8XEBwCG7tUfREV3hJZjaBQvPnIgpnf8Pt2FTFyxoajsop
	 U6IKHaO80B25SWPz0996YqiZ+Kyl0H3YKbhi7+nqmAEHUNnw2qo8R3mZyabXnYjXzvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793959133;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-CM-SenderInfo;
	bh=nK4QUttsM4OLDaefL8J+99RjqRf+d+fmgxtWQp7q5Ms=;
	b=h2dy0UqN0OPAdye6IBiTTRQLhT0RMYRhqguqexmLuFC8M+zlmPb+2R+IqUgVPwluJkOj
	 nkW5New173xkXuaaSwaAbIvERaUL72Ngwds2r7FBttaB0X/DLKqN8m0gjd2ELUWSlV1W5
	 TBTB9TVtbm1kXvRV0RXwMf6B03Ww1igDycPgKuErd0QCIm8+jBoqMGGYYSkx0eEUjpqJs
	 1TwlePaD1peRNtxDakBOhiR0d8fDoTiDzh6/HM/ljX5Fwfpv2VMiE7Kq9a7PglI9s61Te
	 P1fvNkA+rqi6qBXSapJ7uLZvBOOkiGSDPniW7B9A/eSDOQ0MhGBTR/yW0Dxvv9vS/fA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nAndgAjc;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EE4606A33B
	for <bpf@vger.kernel.org>; Fri,  6 Nov 2026 09:58:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E3EE4606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=nAndgAjc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nK
	4QUttsM4OLDaefL8J+99RjqRf+d+fmgxtWQp7q5Ms=; b=nAndgAjcAZBluJDT1m
	e7sAfahSel8Q9nMYmGfGMd6yXK0b5yQpk6ydwFsK4imFCFryDLuvTCvWmkD1LcAH
	u7rdfQi2YS0xPScGwRpNlTWYS8O3CkGlX+FwatTkNOLO/Zjynvw5FC5WRtQMSb9H
	n4YN9a5yTeyq6Q7hWBBeY1urI=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wA3JjikpO1qsU61Fg--.28308S7;
	Fri, 06 Nov 2026 17:58:01 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
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
Cc: yatsenko@meta.com,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 5/8] bpf: Check bpf_wq value membership before use
Date: Fri,  6 Nov 2026 17:57:44 +0800
Message-ID: <20261106095747.471718-6-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261106095747.471718-1-luyun_611@163.com>
References: <20261106095747.471718-1-luyun_611@163.com>
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
X-CM-TRANSID:_____wA3JjikpO1qsU61Fg--.28308S7
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWxKrW5tr4UJw1DWryUJrb_yoW5uFykpF
	W5WFya9r4UWF4xZ3Wxtw4rCa4fZrWvqa9rGFZ8G34FyrsYgr1qkryjyF12vFZxZr4vy3Wa
	va10gFW5uw4UCaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jexRhUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC6wlpOGrtpKnAZgAA3f

From: Yun Lu <luyun@kylinos.cn>

bpf_wq_init() checks the map's usercnt but not whether its value is still
linked. A program retaining a value pointer across deletion can publish
and configure a new cb after deletion has already cancelled the element:

  reader                       delete / reclamation     worker
  retain value E
                               unlink E, cancel work
  publish cb, set and start
  leave read-side section
                               finish E's grace period
                                                        enter callback
                               cancel_work(), free E
                                                        access E

The callback's trace read-side section is outside that grace period's
waiting set. Keeping cb alive does not keep E alive, and the destructor's
cancel_work() does not wait for the running callback.

After publication and the existing usercnt check, look up the key and
require the result to equal cb->value. Either lookup rejects the removed
value or deletion finds the published cb. On rejection, cancel only this
init's cb and return -ENOENT.

Repeat membership checking in the setter and return -EINVAL on mismatch.
Another CPU can use the published cb before init completes its checks,
so checking only init would leave that configuration window open. Use
pointer identity to reject an old value after same-key replacement.
Enable these checks only for WQ here; timer follows separately.

Fixes: eb48f6cd41a0 ("bpf: wq: add bpf_wq_init")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 kernel/bpf/helpers.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 1227debd3e8a..7bcb66c92abd 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1448,6 +1448,11 @@ static int __bpf_async_init(struct bpf_async_kern *async, struct bpf_map *map, u
 		bpf_async_cancel_cb(async, cb);
 		return -EPERM;
 	}
+	if (type == BPF_ASYNC_TYPE_WQ &&
+	    !bpf_map_value_is_linked(map, cb->value)) {
+		bpf_async_cancel_cb(async, cb);
+		return -ENOENT;
+	}
 
 	return 0;
 }
@@ -1567,6 +1572,9 @@ static int __bpf_async_set_callback(struct bpf_async_kern *async, void *callback
 		return -EINVAL;
 	if (!atomic64_read(&map->usercnt))
 		return -EPERM;
+	if (cb->type == BPF_ASYNC_TYPE_WQ &&
+	    !bpf_map_value_is_linked(map, cb->value))
+		return -EINVAL;
 
 	return bpf_async_update_prog_callback(cb, prog, callback_fn);
 }
@@ -3520,7 +3528,8 @@ __bpf_kfunc void bpf_throw(u64 cookie)
  *
  * Return: 0 on success; -EINVAL for invalid flags; -EBUSY if already
  * initialized; -ENOMEM on allocation failure; -EPERM if the map has no user
- * reference.
+ * reference; -ENOENT if the current map lookup does not return this value
+ * when the membership check is reached.
  */
 __bpf_kfunc int bpf_wq_init(struct bpf_wq *wq, void *p__const_map, unsigned int flags)
 {
@@ -3570,8 +3579,8 @@ __bpf_kfunc int bpf_wq_start(struct bpf_wq *wq, unsigned int flags)
  * Success does not prevent concurrent cancellation.
  *
  * Return: 0 on success; -EINVAL for invalid flags, if @wq was not initialized,
- * or if its containing value was already invalidated; -EPERM if the map has
- * no user references.
+ * if its containing value was already invalidated, or if the current map
+ * lookup does not return that value; -EPERM if the map has no user references.
  */
 __bpf_kfunc int bpf_wq_set_callback(struct bpf_wq *wq,
 				    int (callback_fn)(void *map, int *key, void *value),
-- 
2.43.0

