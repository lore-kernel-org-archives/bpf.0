Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A69734F255
	for <bpf@vger.kernel.org>; Thu, 19 Mar 2026 02:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773889042; cv=none; b=UTvo2H2P9P0HencA0NKZ6svplPfxmcMjJEIAjwTRaygxdosWTejV0x78ODlcvVrsNFsfCXU+uswDRnkbvXWPnX0zlYq9FlCxGeTmpL3kkbMH85w4NmlISbux6AnsI2y1X850MuovtDqngqmc1x1CiTE3JV9q6mfGB9JoYfyxs2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773889042; c=relaxed/simple;
	bh=isDiqHq+7y/Q0POSwcg7wUwuIbacnJvZWVskf2kGDDc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AfYzuOlT5/gMWfAbMsDZQt3qHUuWviVxwCNfv0doYdlH2hBj0jALr1mt+bFS1vw7XNEz5mkVZx6kjrOSOPZ020MLC/BFD1d0eoFqHzShN3ytAzMrP+l0JV5OAXLGDvC85wt/DXeXRR16Sdw3mPpd8qNluYgJXbq798RrscoE9IM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e6rdfbcn; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e6rdfbcn"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c70bfef17a4so341209a12.2
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 19:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773889041; x=1774493841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0lbOTb7Ob7nzs4QJLTyz2Nvg4UlXJo6+iKuiYIVVUVQ=;
        b=e6rdfbcn0NVoH+ylrpTz/bvfImi0lFYbUgvfvoJwWcCweMQoipzkpm5ucwv/Il7EvR
         8FyUQ9E5W+GfSqgYkQg3UOgerBL/48Lnnra/OfY8WHk/mVDIjPjrC7BRMK04CPvUBfqX
         dfTtNM/t1YXQhMAOw+SYGHsENAwi6fO1Bpxhjl5r3JIqUVKIlzjH+rpsIB/eCqIKByss
         /FyJQRGjpxIhGPZMaho2+CoSpsj8wrymB1UFcc1OhZPwUe9jo7t3y9Pp87wURq9w2fS8
         yubt4WbWcD1YUygZ85okbjBvFFEaWSEBzg5ju0Hx8Rjoo8eBVqGki1RPlfJAiwpxGja9
         tbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773889041; x=1774493841;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lbOTb7Ob7nzs4QJLTyz2Nvg4UlXJo6+iKuiYIVVUVQ=;
        b=cNz4hLPHakXTA7ScD7fEI2MvYM+FVHvaKhhyJyGuJTmFW3N44IGeG8r1e/LW9eZhVm
         GHtWf5lNEzWt71A23qcxrAzXYIo3IQixEo6a10caA3ppKUzKH3ubW465ctBO1kgiHK6W
         uSp0HnbLyLGJiu7E4Dh/D1i4gsutXaejqu6rSBxsUaTVNt1QXZcwE20iNz1NRYSqZVkX
         g9zF1J74w+f80b/yPsPSd22StS1YiE+SvtM4j44DvMsR6EBduECXJ0DrreuZZ5H7pbIT
         de0piRJIKZwAfvMfnYKRgeBsmTowCr5elwjMchgxJhc0BThBT0Fy4HdULRJaXQLt6fj3
         K4oA==
X-Gm-Message-State: AOJu0YzL4LAexkw16f4GBA7gulHKINzmSJHcF/GAAK/7ZhL9HVrgZOKP
	meWyIh8ZEnxUeKWLmJZZkQhZIy3qcT1eOYPZsCkCl51hFbVC4OOIggAW09/gpw==
X-Gm-Gg: ATEYQzzc5/IOBUtvFLSso2iLA0n0GWhRJrjAPsFaNIFeN0Gi8gyFfTE/EHPMYeslseh
	SbOpmPmom9eEh/Y4ZSuOUkxC+fx7/Yxb/xG0jpCicLeoX3mM2GCdjexLNS1DHajQXCuLuHvN94m
	87zoyevsfV8g1osNGYRbYROUPOkiZmG3qbAjOkso9/C8zhNuGXEtebxuvEatPBpDuKRhMkl65AZ
	rrS/ysVzO++Qc5rKpj5KFjTk/Mbz9mr8PVSjr2iWccb3AIJpGizq/OnRJ4If+SWbJ/s6QBwYSfg
	SA6hOrA1W5alBr77V2X6ZtKZvrQqXUXWV4gqJtPuVCfmeZvQuZJ0lzIyvF7s0k2UFSROoqp0ZxE
	npyV61RwUyasEeCMMlqgMTEafWzGlb5kP149+3x/EQNIQaCWLZ3y5tjRO6WG9cIq5P+djuLe/Ex
	Cxh+vd5Inyhf14
X-Received: by 2002:a17:903:2445:b0:2b0:5e10:9dbd with SMTP id d9443c01a7336-2b06e30f40dmr58866445ad.3.1773889040752;
        Wed, 18 Mar 2026 19:57:20 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b06e61119bsm40631835ad.64.2026.03.18.19.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 19:57:19 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 1/1] bpf: Do not allow deleting local storage in NMI
Date: Wed, 18 Mar 2026 19:57:16 -0700
Message-ID: <20260319025716.2361065-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, local storage may deadlock when deferring freeing selem or
local storage through kfree_rcu(), call_rcu() or call_rcu_tasks_trace()
in NMI or reentrant. Since deleting selem in NMI is an unlikely use
case, partially mitigate it by returning error when calling from
bpf_xxx_storage_delete() helpers in NMI. Note that, it is still possible
to deadlock through reentrant. A full mitigation requires returning
error when irqs_disabled() is true, which, however is too heavy-handed
for bpf_xxx_storage_delete().

The long-term solution requires _nolock versions of call_rcu. Another
possible solution is to defer the free through irq_work [0], but it
would grow the size of selem, which is non-ideal.

The check is only needed in bpf_selem_unlink(), which is used by helpers
and syscalls. bpf_selem_unlink_nofail() is fine as it is called during
map and owner tear down that never run in NMI or reentrant.

[0] https://lore.kernel.org/bpf/20260205190233.912-1-alexei.starovoitov@gmail.com/

Fixes: a10787e6d58c ("bpf: Enable task local storage for tracing programs")
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_local_storage.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/bpf_local_storage.c b/kernel/bpf/bpf_local_storage.c
index 69bb2a7a71bc..cad17ca8552f 100644
--- a/kernel/bpf/bpf_local_storage.c
+++ b/kernel/bpf/bpf_local_storage.c
@@ -393,6 +393,9 @@ int bpf_selem_unlink(struct bpf_local_storage_elem *selem)
 	unsigned long flags;
 	int err;
 
+	if (in_nmi())
+		return -EOPNOTSUPP;
+
 	if (unlikely(!selem_linked_to_storage_lockless(selem)))
 		/* selem has already been unlinked from sk */
 		return 0;
-- 
2.52.0

