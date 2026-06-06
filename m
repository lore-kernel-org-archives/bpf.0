Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478C47262B
	for <bpf@vger.kernel.org>; Sat,  6 Jun 2026 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780713955; cv=none; b=qpvc1rn5/uyd2kOnCHeLyuMTGGPXR6Uvf5nV6tOm9yPYr78nWo8PsRZxwel8p9gZ1R+nGpIGwzhI+4qWr9LN20YMHJwgaNCkWoYtw3F47eE+tr0601LvCisbnuiKq0KnJp33o95eqc0U8rI/7fHecO6gFRomLda8ezeTJARV+wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780713955; c=relaxed/simple;
	bh=EUS17gaHP3VwdzOjEnkIAa8EiDrW9jPi3wQvqwur/BY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HzR6wa1KR9tHw2CjapTZIg7ifXpuYlkOdOGsCskNDSFqZk27MvZBRqIZFlaIpl8obiIm8m6ZTqBShe+HqDbr4cNMlwgtE91nC/JU4rP8/cruReLeF8oQcka5wMB0EJiLO0zvhnUeyoiiFT3iKbloF50bixsRdj5o2dtSOntH480=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SmX1+KPX; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmX1+KPX"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7ea16f090b4so35474207b3.2
        for <bpf@vger.kernel.org>; Fri, 05 Jun 2026 19:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780713953; x=1781318753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mFeh8vnsJ/53mEGAnb+wV/FsoZ1VLRMJLx23Gzq8RJI=;
        b=SmX1+KPXGqOMHrunf/tP/Cq7eWJ12212v5XTOzHLUOW3Umi6r1oFDMUVaypOKFlW3E
         BDWvIyWij3YCsUGVudPLJiU6bAuDn3byDXZr878pagMHlEumBKxNbBYbReDBDkTY9+r4
         UgsRRPJ58kVPOBx2JTWzukxYoTD/h+UCvppuST330/xjQaD3swWC2iptuHwpc1HRKam+
         CrniJnokUnJiruprOsHRverY39W6pttZNL2yXD9DnnMeJwgEU7l52RUdM+IZoWGfd989
         ezJqHyc4mKsRpScAZ4he6h+iwedLpILt1muD17oeGSWyGu9bwL1o0rKlAb0jzMtmDuQo
         ujdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780713953; x=1781318753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mFeh8vnsJ/53mEGAnb+wV/FsoZ1VLRMJLx23Gzq8RJI=;
        b=mT/+APPjR4doqxF2V+TLcp6obNWd2DD6jX+zp/uc2iCU5LH8bVUqOKk1PYlmjidVxn
         vfeUA31PepYP0fYfXBFuBOJS1gkOBqPGdjqXx4t+GwDeRMPlQWKLIneOkUERT+jiQJf9
         4rXsM3XL10vaOy9qqz7H5B/hCWibbyH4VqO4E2NzvejNYHlO06GptZ/+bC7co9wUVb28
         m3miogZoMZ8A/jVK8L2kAOWajvlJYE0AxWMiRXINMUBFsxNg/wt9JH7XdK6FU20n11ow
         0PZEqaj8c7XUc7VJ48LTv9s7PdVWXCPwGQr5Qp32poaz7p2QKuBTK9CUBDkNfaaaBBOy
         DD+A==
X-Forwarded-Encrypted: i=1; AFNElJ++vQGY/NxfHPEp8Hpwab+mNiXJ5YDhhzGHNyo3aEBc4iTlIRun5qHRU2FwwsbsusD25fw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjUixr5PHZqddqnY7ztT2hqUJVtN+OUsUbrXmrVBcIlfB8OAGu
	U5kK0yFUHcs3s9uRg75RIdWJTChqqI2fygKD+OwqpLxmWBEdzhqTYb/5
X-Gm-Gg: Acq92OGJbl+xcu092s4kC4r43LbJSAm7Yd0GJSZEWIjGs7QwYcgKvUgJtXEWNOh6ciP
	TQaf2gCZXz8hBayuyDfYH+Bc0/pEb7YeV2uDtpe87R+joyCrr765JBXaB470lflMBAiuchUunMR
	Y+gQDpuAW8xasqc4Gf00wyFuuxXEPJa85EQ5p9JjQm0Ip92KV0BSrw28ET7OKLTHO47R4UQXbWG
	rXvToYvpz4QApbg62CTm/3SD/ebMuCciz/Cf64MMFM8MIWbYcaxBTwNHFVBvAtSz+SuPpYETOJn
	EAVJELriv7heD7FsPoweLTQkk0m7BmQQhps7fZCvQ8QVsWPKD6vUwh6azda0flP9DNf/T+Dv8Q+
	lXBQqLwPYfdkya2rfv0nGpyHOB+V9XcodLEGcaB1yu6Hj+C6cjWgaytmgADN8zzN6q3diLRLg4y
	eaOyeOKQg9MBrKchq0fB9ygb0B4Y/wmEtympbmuGJ8a86SplZ8+B5tmbJccEI39uJGhWh7AaiYq
	Jpr5AzNobpkudSa6KZdWah2ePMrEZtIYJ46n7hDKZ9Cwbax7ky/sw==
X-Received: by 2002:a05:690e:1246:b0:660:54e4:5dd2 with SMTP id 956f58d0204a3-66106dcef06mr5707967d50.11.1780713953346;
        Fri, 05 Jun 2026 19:45:53 -0700 (PDT)
Received: from tux ([2601:7c0:c37e:2360:d412:6d5d:4bc3:48b2])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d6488b1csm6493022d50.19.2026.06.05.19.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 19:45:52 -0700 (PDT)
From: Ethan Tidmore <ethantidmore06@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Amery Hung <ameryhung@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Ethan Tidmore <ethantidmore06@gmail.com>
Subject: [PATCH] bpf: Fix signedness bug
Date: Fri,  5 Jun 2026 21:45:40 -0500
Message-ID: <20260606024540.47362-1-ethantidmore06@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function acquire_reference() returns negative error codes and 'id'
is an unsigned integer, so the check (id < 0) is always impossible.

Detected by Smatch:
kernel/bpf/verifier.c:13115 check_kfunc_call()
warn: unsigned 'id' is never less than zero.

Fixes: 308c7a0ae8859 ("bpf: Refactor object relationship tracking and fix dynptr UAF bug")
Signed-off-by: Ethan Tidmore <ethantidmore06@gmail.com>
---
 kernel/bpf/verifier.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8ed484cb1a8a..aa8f10fce071 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13111,9 +13111,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 		}
 		mark_btf_func_reg_size(env, BPF_REG_0, sizeof(void *));
 		if (is_kfunc_acquire(&meta)) {
-			id = acquire_reference(env, insn_idx, 0);
-			if (id < 0)
-				return id;
+			err = acquire_reference(env, insn_idx, 0);
+			if (err < 0)
+				return err;
+			id = err;
+
 			regs[BPF_REG_0].id = id;
 		} else if (is_rbtree_node_type(ptr_type) || is_list_node_type(ptr_type)) {
 			ref_set_non_owning(env, &regs[BPF_REG_0]);
-- 
Thanks,
ET
https://github.com/sponsors/ethantidmore

