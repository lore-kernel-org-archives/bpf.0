Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E563637AA9C
	for <bpf@vger.kernel.org>; Tue,  9 Jun 2026 20:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781036756; cv=none; b=JBr2O3HhGcnZPzvM/ArwSgi0JD/5lKiAiiceZTnraPDoxcGUgI/BZVwVaKRVgtACSrx0yyHQKQ5VxGQ4HldEN3DwmuqwIGlWEHm/U3bTQpzViX4rYT7NNPYwGxNw6JAyXo7mKh3Y+wIyogDtm2i5leWAhrXU3esrc+oJ9rcAIHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781036756; c=relaxed/simple;
	bh=Z/mGILi/mDa+m+UkG3O4DZpCakmIiT8vM6Y45GSmRA4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q1qJQQoc/GFOZdPjhSa0dAB7D8VgqalHDzDPey1X87FiBLXxJbCaCcU6nXG+Fe85QrwNJ7p0BFE8FvzHuVZeMuoMLgGuZyPrmcvfXfScLdNB0OqfREBAcLg2Fv1iMyaR7d6K2krZpbHEiyACMxKpomqYedNNaDtX3vCTtX8unWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTw2R1/Y; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTw2R1/Y"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so40947565e9.0
        for <bpf@vger.kernel.org>; Tue, 09 Jun 2026 13:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781036753; x=1781641553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G39HneNXCoMQdOmNn8w7lLEbKdnk/hb+Bh3tl1h3xyY=;
        b=VTw2R1/YSFrDeiQVFxhHngjGMNPso5LfLS+Suv2mf5dZ8PUF+N9yoHlndCrznXcsvg
         qlMAOc62GmDkZYmIjRmJqATp91r6bSZbdYandRnj0r98fwHS1kTvx7wQZ8NN/NEWRsUL
         +5Gp6uVfBMTS+YW0Bzk44XSI0wG8A+3y6hqjYHilJ7s32s2/bZwrnayFzn95hwkwbWcW
         OQlcQSKBU4YqbeK73Mrn4ZHNWk1mnCtKT4qE2MlQR/8VHhxRVgo6yFZyZ6hqPcAffgpU
         yva/Z1qpNP95J0UaKOm4gpd7YzXe8GPVnlt8QjXy9SWDmo8U1rwBHaKYzjs+3F/x/3E8
         UGPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781036753; x=1781641553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G39HneNXCoMQdOmNn8w7lLEbKdnk/hb+Bh3tl1h3xyY=;
        b=JSdWlK5S0uWxRDSei9KPbg0ZeAYmvxJ0idG+VGYzSNz/AJAIddFJ+zJhgBa5pmgfMx
         oAXGnvC0VOow66S5zJb5n79MBRbhKwjxivIxbdSYIfWq+YjixyKLZdaf83b9R7b98ubt
         n1zdG5JZJJeJZxSWQgfuKksgJznZ2aVxqjP54OgL0Vosfif7BrSV2vzCa5whtgpQSe6V
         54nvQi/40G2/9yNxyXDqDgaHnQwCx750vfbH4fp6H9PKY7tanqbbBJb4tYnLxS7sJVzt
         ETHAmQ3un0+1z5QHFvKPxu60uyKCUqJFiyLxCFQifF2+vIwNqPyYVr40gDhDh8lPamj4
         Kn2w==
X-Gm-Message-State: AOJu0Yz38XS+DqEYOT5dvrF5/sEblBmpqNwiRKiI8A/Qdop/09WZyxpg
	yBlMHJk0fSjzA8RlsCjA7LTSMGtoQet1KwFUGZPdL6Xr6/jkkV4bzYeoFw1EQ4nt
X-Gm-Gg: Acq92OFTHdtGIm8wzgHg757m0URomOLiSLum+bWx3sc9/gmiRS6RzuyKkumASIa2Zj5
	RAn2er00d8WcjceR12jNp0ObyILhbqu7N20jvHtjiD644vWjxTpAvwgT1YDOr2HGPqG6nr8JNId
	HshMw9SMFjiaPZz7woKDsb0oPRsVewOrrC2nGgUlbtmVE50I8m2ush6tcHsESI2YwZpmFGVso17
	nEAIIbRzjGqxfnE8AiX1ngT+I1r40Vd4fcLetzYUh8o5KBKnr0VIfDdXvwv/fQG9cGMibzs0Med
	/tued7fWyJdTGu0eGZtt6TYl+HMnRTwLdUYOXxYyeCuv5Jq13wh9eLlGtuzXtZpA7ggWC52sn72
	iGvmdWbp0PBPesKF4yzQ39x59i44dcc/a4QkF/jNSjGlJ0rJtcW7g21KWjTmqiGZPTo45l1kR9s
	y5ucRQPZlf9iuaNNyNwZWBL5AYwm+OPJ4+yxhmRqSoWaJFuyR1WF7yVvlzn5rE9E9kokesRrWtc
	U2+oQBBj2oYxx0//gkqL/LGvpHulMRPs4xSnJiwHb3IcwSE9cWfANmWoMjR/eHISIuVBXdX1ZfS
X-Received: by 2002:a05:600c:154d:b0:490:44eb:c1ec with SMTP id 5b1f17b1804b1-490c260f3cdmr346183585e9.27.1781036753182;
        Tue, 09 Jun 2026 13:25:53 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490bc413541sm544359495e9.14.2026.06.09.13.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 13:25:52 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Justin Suess <utilityemal77@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 3/4] selftests/bpf: Exercise unsafe obj drops from tracing progs
Date: Tue,  9 Jun 2026 22:25:45 +0200
Message-ID: <20260609202548.3571690-4-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609202548.3571690-1-memxor@gmail.com>
References: <20260609202548.3571690-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2238; i=memxor@gmail.com; h=from:subject; bh=Z/mGILi/mDa+m+UkG3O4DZpCakmIiT8vM6Y45GSmRA4=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JIUujLE5o/4nmB8eFIuLurbNwzp/yPK/ma8eu8+8V4gMlX r6O3cTeUcrCIMbFICumyFLyfx+T8YnK34G2y7hh5rAygQxh4OIUgIlU/mL4K7B3uhzD0gdp0+Ke hIuvfqUXaH9QN3W6YauC6HPLd95H3Bn+iqmYXy/bpeqxilOZae6apuexHlbHOje4sWqZ8F8u2vC PDwA=
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Add task_kfunc failure cases for bpf_obj_drop() on local objects with
referenced kptr fields from tracing and NMI tracing programs. These programs
must be rejected because dropping the object would run full special-field
destruction synchronously in an unsafe context.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/task_kfunc_failure.c  | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
index 8e947d445f8e..8942b5478129 100644
--- a/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
+++ b/tools/testing/selftests/bpf/progs/task_kfunc_failure.c
@@ -5,6 +5,7 @@
 #include <bpf/bpf_tracing.h>
 #include <bpf/bpf_helpers.h>
 
+#include "../bpf_experimental.h"
 #include "bpf_misc.h"
 #include "task_kfunc_common.h"
 
@@ -233,6 +234,45 @@ int BPF_PROG(task_kfunc_release_unacquired, struct task_struct *task, u64 clone_
 	return 0;
 }
 
+SEC("tp_btf/task_newtask")
+__failure __msg("bpf_obj_drop cannot be used in tracing programs on types with NMI unsafe fields")
+int BPF_PROG(task_kfunc_obj_drop_with_kptr, struct task_struct *task, u64 clone_flags)
+{
+	struct __tasks_kfunc_map_value *local;
+
+	local = bpf_obj_new(typeof(*local));
+	if (!local)
+		return 0;
+
+	bpf_obj_drop(local);
+	return 0;
+}
+
+SEC("tp_btf/task_newtask")
+__failure __msg("bpf_obj_drop cannot be used in tracing programs on types with NMI unsafe fields")
+int BPF_PROG(task_kfunc_obj_drop_nmi_with_kptr, struct task_struct *task,
+	     u64 clone_flags)
+{
+	struct __tasks_kfunc_map_value *local;
+	struct task_struct *acquired, *old;
+
+	(void)clone_flags;
+
+	local = bpf_obj_new(typeof(*local));
+	if (!local)
+		return 0;
+
+	acquired = bpf_task_acquire(task);
+	if (acquired) {
+		old = bpf_kptr_xchg(&local->task, acquired);
+		if (old)
+			bpf_task_release(old);
+	}
+
+	bpf_obj_drop(local);
+	return 0;
+}
+
 SEC("tp_btf/task_newtask")
 __failure __msg("Possibly NULL pointer passed to trusted R1")
 int BPF_PROG(task_kfunc_from_pid_no_null_check, struct task_struct *task, u64 clone_flags)
-- 
2.53.0

