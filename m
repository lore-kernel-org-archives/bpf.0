Received: from mail-wm2-f2.google.com (mail-wm2-f2.google.com [74.125.225.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1712037F019
	for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 20:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784924201; cv=none; b=YEeJv9BfiXYt/Vd1Zpzf4FFfGZKu99HjbJdTIf7YA2zAd9j8K8NGrN4hvziLs/z2YsVbYxnUY7jTqDAntStVEMIzDi5ZkDiLQGMqET2cN3fBLvkEHR2J/u+nTCnkIhLs4Y9uw5ZmytnTWjJFoqehXIzT5HMOrRgaMRkxncgigy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784924201; c=relaxed/simple;
	bh=YZJjE95HRP1Cb1abNOpRDXjaj+GXTlS0V8ZhFYcTW40=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rSYt1ty/jNIn7aocNcvfn3Om5TYrpf9RNdgN305opl7O16KmWc14t8sJOaCGWwUbUH2W5nanDfff1Jv/sBKCWVzoFuW1PRy6HMzTFiDseYpNBReFRet8JlpSHfTIEEBoF4TLlBMhRbA8gS6WYLE06HqYY+nLrmFhWWffGmUagBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IIiyGjfC; arc=none smtp.client-ip=74.125.225.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IIiyGjfC"
Received: by mail-wm2-f2.google.com with SMTP id 5b1f17b1804b1-4926d058720so2141535e9.0
        for <bpf@vger.kernel.org>; Fri, 24 Jul 2026 13:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784924195; x=1785528995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HE3z3AH+ui95i316i7tM7VE3CirKwHn9PdELkdB1VMY=;
        b=IIiyGjfCchzRWJCSQMlznFTuHpeQGt5J6DPz5EpCDgIQL9GFRFVZbC2ZIiLLKKkdbS
         sYYBHOqEh/ukEDHGP4lkqXN3531cRt3wpteh8QwrtSUJG5GCtI9r0BnpHBe3ZLHV5zjQ
         plSjI8fjHdHJjWf12tFuxtguOe6qwt65a2g5OtYQXLC1IQZXYHZ9V3PtVkSMxq80HYpT
         FKbYaLVlTKYk679/EBP19nO6nAU4NmjNBIHFja4c+hQMc3Qevbt6wPd1HBJ4KHi6CLVF
         /hOXUEUFRKP11huhtEJO+4/jfqFdmmpk2ywvx0UT5bFZQ5ZOdFpf9XCAZGtRqts2XO4y
         StGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784924195; x=1785528995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HE3z3AH+ui95i316i7tM7VE3CirKwHn9PdELkdB1VMY=;
        b=NbpzzZj7u2o5ub0U4/Vj/lJ/ZwwGscTiINBX07LQlYl32QYxlUg9FZrMHRY1lh599K
         qsbX6ct3ZF2/jWCV08jlM8A6Gj0ivZwGRa/bCY2FKHS9qRRNdiPqdGhumsG2Ib0G2mev
         oi3yWd2jKjtOvYrj9dKU31Y0xxxkzdNhyRw0Oiv1ZqEljYzoVw+P39evLW3R6m8qzN3s
         Tn/YpzCfLD9JczgkoJCQECM9LKiOo/j0qFql7iiHvJPA6xpfyFni3ykPMpWuVwf5Vryo
         LjTnXjh1qbF58iF1XC0iSq+3S4lUQqm8NtxAn6y1fQiXyonQUuIS+/ieMDExm7TiYQLM
         LdRA==
X-Gm-Message-State: AOJu0YzAMNKfeIFJ+x1Ugt6ZbWNlQi/EOd/XKC6xiPptmCW+LUPEJy90
	Q3yZ9P05UYKNSy7EBobsiNQnez4g0wIFzjOfQQ3sRY2ji6KHOueDuy6/0hO5f891
X-Gm-Gg: AR+sD12O5vKMIUDuF765bo9ZA/iBCQqoDvEEWa9tVoZJdBfOKkoc+Keo+rsELolBSzi
	uBUGHj3rAmFbDGy/XoAfXojtOvJlNpDrpUjF9kicsxT9p6h305ruRChj6HrLuN2/JKfvtJvyvbj
	TSgM3hD+G0KAFP6jg4LbJsXMwcwMTW0zdaLoGktnmxAPxDMILuWRlU5AitDaa025xlWyVAQ5hlP
	Zrxz3fCTyq2Ecxw2bGqNXF0mqStPdYemPgF64iJrNNy6M904GBoP1bxDU/X6UHob8fT+xehnNWn
	8RfGueO852Q5vszK1nutxHAgQXM84dxAOWe8cR4D7y6Q0Qvc7NynTfGkE1epSANsVrcH5wJNd8o
	QBBU3hZevf0ehY38RpDDh7wFhZ1XsUC7/aLmUlrgqN5D5TfzBke029YG7riDKRSAOJbBEG/0z5H
	rYHTuB5xY2+VdDrFZngMBm6AISNJkn0F0tCgDtl8yFLMWbO9ZnfB+9MQty9L0rOHq8TEQ4TJR/r
	/8sRVGnzePBdo+6sIExD8YUAc30RGoEl6Sg8x+sOo6r
X-Received: by 2002:a05:600c:548a:b0:495:779c:fbef with SMTP id 5b1f17b1804b1-495779cfc79mr81625905e9.37.1784924195217;
        Fri, 24 Jul 2026 13:16:35 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85bdac28sm25271441f8f.16.2026.07.24.13.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:16:34 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Open up res_spin_lock() in all contexts
Date: Fri, 24 Jul 2026 22:16:30 +0200
Message-ID: <20260724201634.3025247-1-memxor@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=532; i=memxor@gmail.com; h=from:subject; bh=YZJjE95HRP1Cb1abNOpRDXjaj+GXTlS0V8ZhFYcTW40=; b=owGbwMvMwCXmrmtenRyi38x4Wi2JISv5eKy7bXaJ4O/7e947399mOPXZwpalCQEb9y9flfrA5 9x8NdH8jlIWBjEuBlkxRZaS//uYjE9U/g60XcYNM4eVCWQIAxenAEzkuT8jQ+uuA//dPjku3L3x hgBbRtn7pzXCHOf2JvVxWb+yfpIesIPhr8gE7j2C0+2PyP2yuce5z32H0CF5X/7L52fOfXI46au 7NT8A
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=B34BD741DE8494B76E2F717880EF20021D46C59B
Content-Transfer-Encoding: 8bit

Spin off first patch with added tests from [0]. See commits for details.

  [0]: https://lore.kernel.org/bpf/20260719113551.1294284-1-memxor@gmail.com

Kumar Kartikeya Dwivedi (2):
  bpf: Allow bpf_res_spin_lock() in all contexts
  selftests/bpf: Test res spin locks in tracing programs

 kernel/bpf/verifier.c                         |  2 +
 .../bpf/progs/verifier_helper_restricted.c    | 66 +++++++++++++++++++
 2 files changed, 68 insertions(+)


base-commit: 87267b89459813cb50ab5377e076b639c07b4491
-- 
2.53.0

