Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2676826D4CA
	for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 12:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771072864; cv=none; b=i3ssJTbJid9Fy1Y4KatqWgSVPkdm4GdQAxOfWCji5l1Veq+mr/CkP6sjWNkMf0k80X7+OLL6TlJY5DmAuWBeCg3GpbPnqgjT+NJqQF4+4d7YFbx1LO9GQqRl/WMNisMR1AbnsB4bWkt/YXPQzuA5qH0Kb7A9q4pdLaV3aHZ87w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771072864; c=relaxed/simple;
	bh=aJnFa1Hsewgi8H7YxpRPpFYJuripGJ/a5ZfAUhM+lFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKf14EcrmVh+s3rvDb9pQWe0DbTGxs8bsoGdmaz57HTsIw/biCCvfWLW8HHvOic2UAjREwVyhZdPsIL0TooSxcOB7E9obuO4g/KM7kX8ga8igYT+fQ0XjRUz0dLKbOFOk3qugJQtX0gWRzeAs1tMRPpFnsHILh4KnI/9hkQVMNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jE0XANPn; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jE0XANPn"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-824b5f015bcso2132010b3a.1
        for <bpf@vger.kernel.org>; Sat, 14 Feb 2026 04:41:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771072862; x=1771677662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6tCm1dSlSN76Pq+BKvxzLO0K4J3qy/k2J9RReSkTgE=;
        b=jE0XANPntZmPjg79xXv/G+pctvHqQFQ8q/XrZzkUxCt1aF6b/a7JExzVye3EThvBl+
         OiIdpJo02UrycuDQzMicMABlptaWql/+qp5IOe6UDhGfyLb6ftYC8f5OamH3cQ4p7ZNd
         LkH2Rzp0jPcm3S+WSPLHUzk28ytM3/nhHOEsuLnnKdxRC/tJWYdGH/pCTs1U4JDF2FO0
         GPIo2jF4Q9+B+qBbYGjUDKTfbmC0JHEg27f46GXpAdpF//Mmg3hgzc/AK3ZfwLvw6qUt
         71DgdcuhgLqiqqakjE2//acKxwWy7jmoUT2bfvpD9/Z00vx3gl42Svs+kV59seFmbkjp
         kM9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771072862; x=1771677662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L6tCm1dSlSN76Pq+BKvxzLO0K4J3qy/k2J9RReSkTgE=;
        b=TuklZkHEuZw11Ijs2MaFmqj5XIiqhX0KCshayXdQ1Hd9lIR6BFVk5Uc6Symx/XgmKm
         2uLvP0DWHnM0653xsO+b37n9Jkd1SgfrxtHBa1It6v4c1iQny+ykHcGRXZ5ODM2puK2D
         Ai9/SaNSQL/nZP5BwDyXQJ9tFwlBSgsujGpwm5TVR7fm+1IoQYU5MnYr8UFQGrD/Xx/6
         8JSGOH535LJ1AojC2wxjjZuZuGX/V590Bw+2IaNAHDreOUHQRGgsOYqMkLEEn912mg5N
         CwW5LMQUJzY5mOLdkiIF7eSLxUEmyApomXbIzjCV/swZHdawOFM6E0GLYgYu6ZuOWjuN
         o6Rw==
X-Forwarded-Encrypted: i=1; AJvYcCV+aQrbXbLmL7qYUlDdRqklSScRZtAD7iUzPP1MYUnqg3pduV4d1ljbkYHWgKY00Jy56KU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwclFYHCt18xLeFvn14Adzp3kGLmjddrNgwTJCrtFp+AI6hMP/6
	THS6n2dmF6VaKWHdImblFV1ArAzHx1PTuxVz8hvh1DS0hxSuT4BToFyG
X-Gm-Gg: AZuq6aLhZKs90kKwgxuv8HyPS4PBx/VYgTjT7NynqGeYqMbmhhUKQoYoCAeh6lMhsq2
	qnSQ1NMG8sDR7lQU/uTTU4zlyRlGZeL3Z8nQxLXZdFCXyVsTo944/SPYZZluDKJoOREfMpUN+Ym
	frfLc7G+l3McyzbCsZiQHiIWHFRgWRCL2lBlzEmpnWp1x72XOWJeFhq+GkqvGE47kLgOMv95dkW
	QFP0zOyIv2myevkIjHmvXnGY42/qbxmKNVHQi9s/vGznrTxRrZTBPTjP1wfedqJ/iGuJKP9I6fP
	I/MR24JSwH0Zp02HBETPPahZWjoXAr3F627/HrCo9s78Y2nBUhxrWeLC+D6UmcDPgdQaS6oNnAr
	nuzx0Z5pIbj5wiSIo7NhJ+jZf05OcPjaT+7ery4W3zJp2LTo0G29K+QmSwN+dVKhZWFlhcpKUNN
	UDRJC/JGFMUJdomnCUFkrTlUsXs3olbthPtCYCdZJZCPro61/0rmUG
X-Received: by 2002:a05:6a00:3c8b:b0:81f:b3ce:17a3 with SMTP id d2e1a72fcca58-824c613364dmr5989012b3a.48.1771072862533;
        Sat, 14 Feb 2026 04:41:02 -0800 (PST)
Received: from localhost.localdomain ([113.218.252.61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824c6a2e40bsm7064497b3a.11.2026.02.14.04.40.57
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Feb 2026 04:41:02 -0800 (PST)
From: Chengkaitao <pilgrimtao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	yangfeng@kylinos.cn,
	alexei.starovoitov@gmail.com
Cc: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Kaitao Cheng <chengkaitao@kylinos.cn>
Subject: [PATCH RESEND v7 2/5] bpf: allow using bpf_kptr_xchg even if the NON_OWN_REF flag is set
Date: Sat, 14 Feb 2026 20:40:39 +0800
Message-ID: <20260214124042.62229-3-pilgrimtao@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260214124042.62229-1-pilgrimtao@gmail.com>
References: <20260214124042.62229-1-pilgrimtao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kaitao Cheng <chengkaitao@kylinos.cn>

When traversing an rbtree using bpf_rbtree_left/right, if bpf_kptr_xchg
is used to access the __kptr pointer contained in a node, it currently
requires first removing the node with bpf_rbtree_remove and clearing the
NON_OWN_REF flag, then re-adding the node to the original rbtree with
bpf_rbtree_add after usage. This process significantly degrades rbtree
traversal performance. The patch enables accessing __kptr pointers with
the NON_OWN_REF flag set while holding the lock, eliminating the need
for this remove-read-add sequence.

Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
Signed-off-by: Feng Yang <yangfeng@kylinos.cn>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2927a4622ff8..3536a91ff8c7 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -9329,7 +9329,8 @@ static const struct bpf_reg_types timer_types = { .types = { PTR_TO_MAP_VALUE }
 static const struct bpf_reg_types kptr_xchg_dest_types = {
 	.types = {
 		PTR_TO_MAP_VALUE,
-		PTR_TO_BTF_ID | MEM_ALLOC
+		PTR_TO_BTF_ID | MEM_ALLOC,
+		PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF,
 	}
 };
 static const struct bpf_reg_types dynptr_types = {
@@ -9489,6 +9490,7 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
 	}
 	case PTR_TO_BTF_ID | MEM_ALLOC:
 	case PTR_TO_BTF_ID | MEM_PERCPU | MEM_ALLOC:
+	case PTR_TO_BTF_ID | MEM_ALLOC | NON_OWN_REF:
 		if (meta->func_id != BPF_FUNC_spin_lock && meta->func_id != BPF_FUNC_spin_unlock &&
 		    meta->func_id != BPF_FUNC_kptr_xchg) {
 			verifier_bug(env, "unimplemented handling of MEM_ALLOC");
-- 
2.50.1 (Apple Git-155)

