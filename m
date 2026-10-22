Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792651699;
	b=TzwTuqq1s2hUqFuYb0Lnooy6dTPbFI7Trs8eCfdPO+8D/ypTW+SrRBUPDfAl8qXlIAkD
	 DyG5GqMT+tv+tu+7E4THtgTjc4ZiKn1S5J5idFRYVTo46r8iUPjL+X31PA62OmFaiY8Mt
	 21Mug1nqSXjyT2ckBZJMBsrb8/GeFS1LwXpKFQCTKbg8JiRKokyjdUm/6TvSfff0LZBxY
	 9p9wJnLjlw11BlIJbV9mkQ/IBWEELGDCiHHKF4d+6D/A3prl6z1dEtVtslyiK0IqNy97V
	 jFE/0qKLYhD6sGDxbrwakvvQ6jmC2XKouMxekeJNAsSRuYJJeFMMtcpoDl6jzeOBHXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792651699;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-CM-SenderInfo;
	bh=Ry9buNjD4dWmSmNLfetdWfkhyUMM3EO/GXmrykqBL64=;
	b=Q7r9TovvKTM97zGekYVC6UNjPU3vDpZ/CGmFA6+QpmsQFP/zfRA+JAaNa3SuOKTG74r5
	 pMPXhUnsGJOqg4PSnTimdwAGAp7kYXXZuja7BzwglK3Jy1Yz/H6YF95pRN5P2jwS7eEHH
	 1vLlu8jQC7bQhT19oXDRL9zO0cGXF5AwlTa6pPiF3UlKouo9Bsr9lIiwle1rNS2nmEfnR
	 mKyEXSvKPDwA8iMW/EJKB+DxhvrGPEUXmxNWt4a2gCad+hsBeCQ/Uaj0JtQyn10O+Zv+A
	 nfI/+Wtu5GwscvQns3zGUDPFpnJUTbOlMgIjW96ahkZxl2Y3aNGJXPT6vYq0tw/qxVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ly3wJWFi;
	arc=none smtp.remote-ip=220.197.31.2
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F17606A330
	for <bpf@vger.kernel.org>; Thu, 22 Oct 2026 06:48:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2F17606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=ly3wJWFi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ry
	9buNjD4dWmSmNLfetdWfkhyUMM3EO/GXmrykqBL64=; b=ly3wJWFiqYFMJLWXKh
	l3Fd7uZn8Es2fp9s/SlXszKzze6LYyMETO5u7mRqDb6YVqSLG2avTHAu2leks4Yj
	IS6sIABZYCgR8ExSycQWHmCEqnv8RgfxS4irux5mLC4aCLjEXx4lfQmhRynbxIgH
	iUJ3VZDRTnSHmIHFch3KK2S9w=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3X81_sdlqJUabBw--.32400S2;
	Thu, 22 Oct 2026 14:47:29 +0800 (CST)
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
Cc: bpf@vger.kernel.org
Subject: [PATCH bpf-next] bpf: Propagate btf_add_type() errors in btf_check_all_metas()
Date: Thu, 22 Oct 2026 14:47:27 +0800
Message-Id: <20261022064727.747304-1-yangfeng59949@163.com>
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
X-CM-TRANSID:_____wD3X81_sdlqJUabBw--.32400S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZFWxCr4UZFyDurW5tr1UJrb_yoW8AFWfpw
	4UJFZ7ZrWvgr43uanFyFs8ur15J395J3y8GFyqvr1IkF45Xr48ta1UJ3yjv3WSkFs5Cw4Y
	qFn0qrZ0vws7uFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6q2_UUUUU=
X-CM-SenderInfo: p1dqww5hqjkmqzuzqiywtou0bp/xtbC8QGdFmrZsYEQPAAA3U

From: Feng Yang <yangfeng@kylinos.cn>

btf_check_all_metas() ignores the return value of btf_add_type(), so a
type that could not be registered is silently dropped while the loop
keeps walking over the type section.

Both failure modes are reachable:

  - -E2BIG.  Once the types array reaches its capacity (BTF_MAX_TYPE),
    every following btf_add_type() fails the same way, so
    btf_check_all_metas() still returns 0 and the BTF object is created
    with btf->nr_types capped while hdr->type_len claims more records.

  - -ENOMEM.  btf->nr_types is not incremented and the array is not
    grown, so the next type is recorded at the slot of the dropped one
    and btf->types[] stays off by one with respect to the type ids for
    all remaining types.  btf_type_by_id() then returns the wrong type
    for those ids for the whole lifetime of the object, and the last
    type is silently left unresolved.

Propagate the error so that the object is rejected instead.

Fixes: 69b693f0aefa ("bpf: btf: Introduce BPF Type Format (BTF)")
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/bpf/btf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d870bc5e50bc..80b6f96263f1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5459,6 +5459,7 @@ static int btf_check_all_metas(struct btf_verifier_env *env)
 	struct btf *btf = env->btf;
 	struct btf_header *hdr;
 	void *cur, *end;
+	int err;
 
 	hdr = &btf->hdr;
 	cur = btf->nohdr_data + hdr->type_off;
@@ -5473,7 +5474,10 @@ static int btf_check_all_metas(struct btf_verifier_env *env)
 		if (meta_size < 0)
 			return meta_size;
 
-		btf_add_type(env, t);
+		err = btf_add_type(env, t);
+		if (err)
+			return err;
+
 		cur += meta_size;
 		env->log_type_id++;
 	}
-- 
2.25.1

