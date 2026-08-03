Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F3F34251B
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 11:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785756333; cv=none; b=dxsd168MtC3+jxS2VFco/1yLHi5u3LEnyaN5hyUnhkB4SZ+xbvSbnSXb5YUxceBbWTj9yC/v234C/MPoZAp+3DPUUjhSfIxEsYPHPAqBWk/J6bZPBFrBeFdHPAs81dBMiDEYmp/1UhIrSv5jUU3xfgPyB+iBwIVM5hzh4pO+xww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785756333; c=relaxed/simple;
	bh=Y9AIsjPbIPGueDse8hHLQDqbfy+XindtGyBeUBP/rvM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k0lrnPoOSNV2cgmsFm09UhmeF0Qf31BWnmR+YW0ViMoBsCnKq6lcNejribua/4SLOZTXK7Vxoon0jpHXR+PdesmIxDWbYq9lhgWu2UX6JDR62t3QU0SpL4SrEAvnkr1cKw9b1nHsVAJw5ddIOf3X8SDvJdCxoce6Q3bpQtHtDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7Ewn73U; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7Ewn73U"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so35639715ad.1
        for <bpf@vger.kernel.org>; Mon, 03 Aug 2026 04:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785756332; x=1786361132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k5tDp607U3XC+GO+sC+Kbg0SxU3/bHhXF0A90r92Gwc=;
        b=S7Ewn73UrqgDwTQJGK1LAqjznD8pKBeh0BS7XZMFPS474diUB1PCzn8kakXEqN5x9y
         iEXvYo3mhJJWC/cmHQ4hO5dlg5cZKucC4g7r0SmmzA7od9l4cAmbEP4Yc6lgWyt2rz2x
         MlbNko9QoRf2vC0BpG56ReCP2wuk6wfx9Bp4WYmP0oQXcyUpCfxZ7d1aehAhU7YpJI7T
         ipHHOg1MtWxDbILdaVWXCVXLkwXtOFRaE9iyZsu6PMqtBHLmyY3Ki6V3dr9uYnrzMt8c
         xC7zHwAcoRp9G9tZbSCcYlCfdM50EtckpzS07hA6r3zyYJsFhqfU3mbACKqJTZAE0sU8
         zQnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785756332; x=1786361132;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=k5tDp607U3XC+GO+sC+Kbg0SxU3/bHhXF0A90r92Gwc=;
        b=isIhnMuyaP8upDfPay+Lx+3juToPO1jINUWgVnYrWaqoYWBakzdQoQ6rz/3Y0Vle/o
         tFIMtNzp4LPy4pFchZHSUNuMNXoGUQ6u/5iMzPVclQwJP1BVBZbQ4mJcUFEPz0STNTDU
         3dXVuUkV+8+TnCWoczLELIzkrMhUnpbJOa+JqAxfNcB5zKrwmNBfoiBO6xIS0GOEkjX6
         PeFYjA2FBnlMBM3FYlh0o4hpz0BF0MRQ9LSz4wokhu7PW37mxAzlOTsMQklNbP7pVW3P
         lWKjeFNro+RyaWM5jaaXnGimRsQog4MH9+U9zJB59+FlZ4PWt60HS7bd1rWSfmmnlJ6X
         s3rg==
X-Gm-Message-State: AOJu0YwjZNAavcg6ie8FJ22IciSkuNTfaYvAsLTQEhp79A/lE+aRu1OL
	tEPtFXxom3waAukeyiudJmhEcQCoEf2TDoqCtfp+cgB93AKT+x3/d6ao0oShKU8j
X-Gm-Gg: AR+sD11f3DFUi+MTjSBgFkGV4zs+dEZq2GCbYHr70HXVJOEE2LTXNhp9xIu63SKfAtP
	VeT9T3mUSZMh8kpmkZGYNhRT0T5Aj1Uo/TiDT0Id1917CaD32+uhl7rzXA14UKkDaApn72FZ+9s
	jtaNK7jNIEZ3d+F1/1/txbxy+sc0mxLaExX7Jk/eGdOcB5O6zitAdCfthU7aowbKOlXwM+Ra84r
	csbrBzmFdV5d80iiWeiEupUzbk3DvjAp/ye9J54Nfhzat2P767R4jCsGtRIyYfEEwD/HBQFClCQ
	q9tIvt4E3q8tYR6jLCuPbvHqjZ6f+094Ug49uWeD/pjmPW24FCJG/9qpGNN+LeUN+LwJsrYILLw
	il3eiPu7kkr39W0y/Nv3xJKGYNtVIL/i6r38ejafeXu0eq8mVKJb1R3N6IRQWmV5s9RPDlrLMRB
	vcNSNJ1nydFDRvJrtA09AGanqFsxrjpnrj2w1jeEV9FwIUtEFdZldwR95jKrYDI4VYm4tJLLuxh
	PGSqcjOGJaW48uo
X-Received: by 2002:a17:903:1a06:b0:2ca:d172:7228 with SMTP id d9443c01a7336-2d0521b6908mr100228275ad.11.1785756331838;
        Mon, 03 Aug 2026 04:25:31 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04ae5a91asm36190685ad.21.2026.08.03.04.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 04:25:31 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	greg@kroah.com,
	Ning Ding <dingning04@gmail.com>,
	stable@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Dave Marchevsky <davemarchevsky@fb.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf v3 1/4] bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
Date: Mon,  3 Aug 2026 04:22:08 -0700
Message-ID: <20260803112218.3361213-2-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803112218.3361213-1-dingning04@gmail.com>
References: <20260803112218.3361213-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier can mistake an RCU-loaded map kptr for an owned reference and
assume bpf_refcount_acquire() cannot return NULL. The kfunc uses
refcount_inc_not_zero(), so it can return NULL after the last reference is
dropped. Passing that unchecked result to bpf_obj_drop() can crash the
kernel.

Only treat the argument as owned when the verifier tracks an acquired
reference for it. Borrowed pointers remain nullable, while owned pointers
keep the existing behavior.

Fixes: 1b12171533a9 ("bpf: Mark direct ld of stashed bpf_{rb,list}_node as non-owning ref")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.5
Assisted-by: ChatGPT:GPT-5.6-Thinking
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index fdc5fbb1f78ca..c47328be2505e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12419,7 +12419,7 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					reg_arg_name(env, argno));
 				return -EINVAL;
 			}
-			if (!type_is_non_owning_ref(reg->type))
+			if (!type_is_non_owning_ref(reg->type) && reg_is_referenced(env, reg))
 				meta->arg_owning_ref = true;
 
 			rec = reg_btf_record(reg);
-- 
2.43.0

