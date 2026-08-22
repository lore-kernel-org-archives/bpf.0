Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357EC1E7C02;
	Sat, 22 Aug 2026 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787381749; cv=none; b=I9pAxYEfNNTMAyxM3gmrXE1PUKn/dFqaKOIScLKjgncS3E/TYHxY7JUx+59RjB1YUX9k4n9hxPhg/YvEuwB0J9r4n5IKtcNXy/3TbVoFKdtjAUtb8BvbIy8bGC9E/VFBb9od77GIhs7lMTMTTiS2+Z2oZKznP1wpbGrA1df7DE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787381749; c=relaxed/simple;
	bh=+q+2IVCdj4arDldOmGGz3hvgqoQcbxdK3yId/TiKFBA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mjzAO023EMNYn1u5PR6Ks6eZP2W3BIjkmxpY+q0BAsvS0U+Ds/ok+20Hrd4SG+2emSAp9Zue9RULSEF6yeMC9Cv4qhD/RQ+BtNNGReRJWJdV/hn/fvjwxFGC8oBqfPGqummsTxn91PBlpODD1j/XVKPw3GPujVGDuhX5JHMIbKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKDjSqC5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKDjSqC5"
Received: by smtp.kernel.org (Postfix) with ESMTPS id A015DC2BCB8;
	Sat, 22 Aug 2026 06:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787381748;
	bh=+q+2IVCdj4arDldOmGGz3hvgqoQcbxdK3yId/TiKFBA=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UKDjSqC5YM0Op7uybRngAVtheEPNhvFIWtPtsxpjpnVPrU6qE64xTkIvcFPARP1NQ
	 RLv4KrF1tQn/ytMFMXkWMY5nUOwgxtDVe75ChoQW9QuAxznxtsolNz8adaGugAE/vJ
	 EZfaJkQdO0kXWPDBAiq50+uqiDf9XFMNqaaUoHTmj/BPe13mwhoFSDM1q0TFKHBS7I
	 mqElfM+ib/L4TyBTZ5qqOhTe2JQ4FAlWMfZvjoJw+4onrbpdYcmB+zyBx2xA1LeUQH
	 brkCI3HSdzIzq08nRiLva9kzNGJnqbGL6QLvqLKkJC5WvxEJzU+/9Dcy1A8CSJpQqa
	 nKc+g/lmTnl0w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FB47C5DF97;
	Sat, 22 Aug 2026 06:55:48 +0000 (UTC)
From: Quanye Yang via B4 Relay <devnull+quanyeyang.proton.me@kernel.org>
Date: Sat, 22 Aug 2026 14:55:33 +0800
Subject: [PATCH v3] bpf: Annotate bpf_obj_memcpy with data_race
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-bpf-kcsan-obj-memcpy-v3-1-4227b2edd8b4@proton.me>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42NsQ6CMBRFf4V0toY+oAUn/8M40PIqxUCbFomE8
 O8WdHBwcDzJvecsJKA3GMgpWYjHyQRjhwjZISGqrYcbUtNEJpACT0tWUek0vatQD9TKjvbYKzd
 TLtIcJNMKRUPi1XnU5rlrL9c3h4fsUI2ba1u0JozWz3t3Ytvuk4D0d2JilNFMgCqqnAPw8uy8H
 e1w7JFsiQn+kUCUcAEFE3XG8kJ/S9Z1fQH02QaEDwEAAA==
X-Change-ID: 20260819-bpf-kcsan-obj-memcpy-67042b1fce7d
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 syzbot+44044637ef892e79ca2b@syzkaller.appspotmail.com, 
 Quanye Yang <quanyeyang@proton.me>, Ihor Solodrai <ihor.solodrai@linux.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787381746; l=4009;
 i=quanyeyang@proton.me; s=20260801; h=from:subject:message-id;
 bh=EdAjWYlb5Q2PjeX/bA31+J2pOKETgVMLDyHFAoIpgJ8=;
 b=4hFW+sqs2n7mWyxX2L/0XIoGUg43ttrMGzbnw+4h8coSZ4vMC4DDOtO6E9eVoFYRYmtdm7z1I
 I1KCi35/kkpCgA2QwtHM20zduaSw3S1Be2r17fMoOuUoYdYXYwj15RA
X-Developer-Key: i=quanyeyang@proton.me; a=ed25519;
 pk=9L9FrcvzMgxPaBRU6XV0EnqTgjDqVO596rQKSZ9qZoY=
X-Endpoint-Received: by B4 Relay for quanyeyang@proton.me/20260801 with
 auth_id=963
X-Original-From: Quanye Yang <quanyeyang@proton.me>
Reply-To: quanyeyang@proton.me

From: Quanye Yang <quanyeyang@proton.me>

syzbot reported KCSAN write-write races when two tasks concurrently
update the same map value. Both accesses reach the ordinary memcpy()
paths in bpf_obj_memcpy() through copy_map_value().

Unlocked in-place updates of published map values are intentionally not
serialized and may produce torn values. Callers requiring consistency
must provide synchronization appropriate for the map type.
bpf_long_memcpy() already annotates the same behavior for long-aligned
copies.

Annotate the ordinary memcpy() sites in bpf_obj_memcpy() with
data_race(), matching bpf_long_memcpy(). This documents the existing
concurrency semantics and suppresses KCSAN reports for these intentional
races without changing synchronization or map update behavior.

Reported-by: syzbot+44044637ef892e79ca2b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=44044637ef892e79ca2b
Signed-off-by: Quanye Yang <quanyeyang@proton.me>
---
The annotations remain in the common bpf_obj_memcpy() helper, matching
bpf_long_memcpy(). This keeps the existing copy helper interfaces
unchanged. A narrower annotation would require propagating the
concurrency context through copy_map_value() or introducing separate
copy helpers.

The following checkpatch warnings are expected:

- DATA_RACE is reported for the three annotations because checkpatch
  only recognizes an immediately adjacent comment.
- MISSING_FIXES_TAG is reported because the commit references syzkaller.
  No Fixes tag is included because this documents long-standing
  intentional lockless semantics rather than a regression introduced
  by a particular commit.
---
Changes in v3:
- Restore the original bpf_obj_memcpy() comment as suggested by Andrii.
- Use the properly cased full name for authorship and Signed-off-by.
- Link to v2: https://patch.msgid.link/20260820-bpf-kcsan-obj-memcpy-v2-1-672517a3145f@proton.me

Changes in v2:
- Drop the BPF_F_LOCK recommendation because it is unavailable for
  per-CPU maps.
- Scope the concurrency description to unlocked in-place updates of
  published map values.
- Fold the redundant commit message paragraphs.
- Link to v1:
  https://patch.msgid.link/20260820-bpf-kcsan-obj-memcpy-v1-1-372c59462268@proton.me

To: Alexei Starovoitov <ast@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
To: Andrii Nakryiko <andrii@kernel.org>
To: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: Martin KaFai Lau <martin.lau@linux.dev>
To: Song Liu <song@kernel.org>
To: Yonghong Song <yonghong.song@linux.dev>
To: Jiri Olsa <jolsa@kernel.org>
To: Emil Tsalapatis <emil@etsalapatis.com>
To: John Fastabend <john.fastabend@gmail.com>
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 include/linux/bpf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index b7dbf3d9b5c0..6248ff2f506d 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -572,7 +572,7 @@ static inline void bpf_obj_memcpy(struct btf_record *rec,
 		if (long_memcpy)
 			bpf_long_memcpy(dst, src, size);
 		else
-			memcpy(dst, src, size);
+			data_race(memcpy(dst, src, size));
 		return;
 	}
 
@@ -580,10 +580,10 @@ static inline void bpf_obj_memcpy(struct btf_record *rec,
 		u32 next_off = rec->fields[i].offset;
 		u32 sz = next_off - curr_off;
 
-		memcpy(dst + curr_off, src + curr_off, sz);
+		data_race(memcpy(dst + curr_off, src + curr_off, sz));
 		curr_off += rec->fields[i].size + sz;
 	}
-	memcpy(dst + curr_off, src + curr_off, size - curr_off);
+	data_race(memcpy(dst + curr_off, src + curr_off, size - curr_off));
 }
 
 static inline void copy_map_value(struct bpf_map *map, void *dst, void *src)

---
base-commit: 75b0a6db4300e4c2c9e97a0848deaa7acfb42fb7
change-id: 20260819-bpf-kcsan-obj-memcpy-67042b1fce7d

Best regards,
--  
Quanye Yang <quanyeyang@proton.me>


