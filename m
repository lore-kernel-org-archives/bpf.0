Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3C2046D5
	for <bpf@vger.kernel.org>; Sun, 24 Mar 2024 23:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321469; cv=none; b=hUGhY8nxsm4oEHn96l76KCc2InQz+dd4ZQMPHyA5k5GAZYjyCNJoJ92pVFq+7IePpJgT8OhQfijBlJoCIFL0ZCrGey5+qOmr4afU6Gt+/poIXt3a6P1vaPdWeXqtyVCwMtTyk+S5VdCP88upTmMh76DvU9YfWBm6hHCEVKOAjIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321469; c=relaxed/simple;
	bh=RnQ4VwuGkUm/NqgXum4xkxC1jnCGt5BzU55yWpupeyc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pwefpaEDIRKyzWPyL58CTczVyWm2Jj85MvSXasOWaL8MFcDLi0i31sQ1apKofY3IHFCjERJ/DVGxt6O3XUhehPofQlSncT+dZkQvKT5qfObxaQyK1mEiQ8yAk3fM3VxqaGMDKsAeAWNw1bSMmsJ+V3ARfh5P7n6aHKTRqnhHJVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bU1ZjGe1; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bU1ZjGe1"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-429f53f0b0bso26888091cf.2
        for <bpf@vger.kernel.org>; Sun, 24 Mar 2024 16:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711321465; x=1711926265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wnCjQadjDe91DKgj3FPRjn8BLMwPzyivK4zgGQ/ml+A=;
        b=bU1ZjGe14JLFSkZO2JaAxQI6a6gpb9TUOniVypCf0OMImdjIS5cOetgrKfTneWsKgE
         w3eRdnpKuJqCrEVFzXzPUWV+oVjWH4KZzzwHmGeSRmKkNx7dc8DaT81rBlrGKnUZbYGa
         Jt2l23DLk/d1nG8Hm7e7HbP282nNPl4Bxv96gNK+oF4i9zyaPk4vAMEDzuaOuQaKk+dv
         g6LQuDFC4JDS0RuLCwHOGVXzrvIyq+oET0Czrcw1GQC9eNofB85jE4c1FgO4w5x74H/n
         +BVFa9uguAWuo27j9b3x1VBPIG0Js5EQhpCJJjdFT2p01nTM6kn8kVP2CLPgvgK4VX7G
         YD9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711321465; x=1711926265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wnCjQadjDe91DKgj3FPRjn8BLMwPzyivK4zgGQ/ml+A=;
        b=aL/DTB6OevGJaTO0NTYtLshrqTfSNCD9GSzPNKNDfupw3zgj/CQxYkJn8e4t4tjQbH
         9xrHYTRH1ey4dNE8qeTWoZaNkjOhh2wzbLul8UBMCMkM+rxb11ck5f9vUcyxhNENdtXK
         A3jvXPVPi5Jom4F1IuJaHuR0S1IWL5p4B63xxta9EimX2g6cknDodSItGIQ9bYNKckpF
         PhdbRtdpbzs52xtpifiH4Zg6DMLhTuuZFVzKRjVaFaj5gTNUZ6V2ZT7sI1hE4jGrSCkf
         B+0TArxwHkkoLQ66JcMVjOBh5o+x6e5ibHjtAVjsHgGuWVyXTVQyC+wsaonjW/JgwN8v
         q6vg==
X-Gm-Message-State: AOJu0Ywk5uDvpFfNzjvX+Ayh6EmK9SivXpoaV1JZTL9b8f8+9H5fSz0c
	onZSqZVPyoWE27S44bZDSUDN1dehf8WjunNsN/IfBl02xtW/jBzlvJJgUQfcEI6Y5g==
X-Google-Smtp-Source: AGHT+IHBQM3r2vAAvxESh2VrLyalZeI2+stAp9lYdt9+CNEDLtepMWI7dt8KDd2s74u5g7JW2hMPOQ==
X-Received: by 2002:a05:6214:3002:b0:696:8de9:dbf with SMTP id ke2-20020a056214300200b006968de90dbfmr1815890qvb.0.1711321465014;
        Sun, 24 Mar 2024 16:04:25 -0700 (PDT)
Received: from andrei-framework.taildd130.ts.net ([2600:4041:599b:1100:65bd:9404:df98:e9e8])
        by smtp.gmail.com with ESMTPSA id jr11-20020a0562142a8b00b00691873a7748sm3445034qvb.128.2024.03.24.16.04.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Mar 2024 16:04:24 -0700 (PDT)
From: Andrei Matei <andreimatei1@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	Andrei Matei <andreimatei1@gmail.com>,
	syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
Subject: [PATCH bpf] bpf: Protect against int overflow for stack access size
Date: Sun, 24 Mar 2024 19:03:23 -0400
Message-Id: <20240324230323.1097685-1-andreimatei1@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch re-introduces protection against the size of access to stack
memory being negative; the access size can appear negative as a result
of overflowing its signed int representation (the respective function
arguments is sometimes converted from a u32 and u64 without any overflow
checking), and causes out-of-bounds array accesses in
check_stack_range_initialized(). This patch causes the verification of a
program with such a non-sensical access size to fail.

This check used to exist in a more indirect way, but was inadvertendly
removed in a833a17a.

This omission was found by syzkaller. I have failed to actually create a
program that triggers the issue (different other protections kick in for
different code paths). The syzkaller program is opaque and I failed to
fully decipher it; from what I gather, it declares a map with a huge
value type (0x80000001 bytes, which is INT_MAX + 2), and somehow calls a
helper (bpf_map_peek_elem), and manages to pass to it a pointer to the
stack while, at the same time, the size of values in this map is being
used as the "access size".

Fixes: a833a17a ("bpf: Fix verification of indirect var-off stack access")
Reported-by: syzbot+33f4297b5f927648741a@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/bpf/CAADnVQLORV5PT0iTAhRER+iLBTkByCYNBYyvBSgjN1T31K+gOw@mail.gmail.com/
---
 kernel/bpf/verifier.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 0bfc0050db28..2019d6177969 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -6701,6 +6701,8 @@ static int check_stack_access_within_bounds(
 	err = check_stack_slot_within_bounds(env, min_off, state, type);
 	if (!err && max_off > 0)
 		err = -EINVAL; /* out of stack access into non-negative offsets */
+	if (!err && access_size < 0)
+		err = -EINVAL; /* invalid negative access size; integer overflow? */
 
 	if (err) {
 		if (tnum_is_const(reg->var_off)) {
-- 
2.40.1

