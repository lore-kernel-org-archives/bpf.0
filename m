Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CF2319860
	for <bpf@vger.kernel.org>; Thu, 28 May 2026 05:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946021; cv=none; b=b5hIAd0vzjaN7vEmHx9LfQo+jkdv6XYR/54XgOQeMKCCykD/D2bQXIS6FpRcHoYMvdVgsU0Xi2DrLcbk77jK5YMLLwr711dOM29vo/sHRjufg2lt8YAYOeYGwHoZGMtf5JkIKzxSdIwyDrFNJ9Xt+Rq3URGOFFPwzHDUCEVW/rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946021; c=relaxed/simple;
	bh=xx54sAco+6m3AjMvNwtpeIRSEjr4pcpTSs5UMGBZpv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FvpHKiVP5xfugVfr0B/e6vGMA9J8JDmKgsEoPmLYGMj47uW3SlMdYut3P3vci3kk9xh473Tc3YhNql9RlVzyyCNOdZFE388TqQT2NoO4jRYN745f6sM9LcgJA4jkF234tGtS5Cjsj11N3KZGkgu93RcKiwGjG4jq7TKRT4KQIXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SkQgWdwW; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SkQgWdwW"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2baca4df358so79319315ad.2
        for <bpf@vger.kernel.org>; Wed, 27 May 2026 22:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779946018; x=1780550818; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jbgqf3mu8JYb4D5FqVjFkGrGI4aSc89zJJbOU4Y7BTU=;
        b=SkQgWdwWjtj7NoyHUG6N5Aa21jLgg1ocPDmD07kHy1KzUP3vbrvKLK/9G2bO/Z88nC
         GEwUAdN3msn9xss4JEgMXHW6Yrk5is+s14vR7oPcsejFJQoWgDViA9QfjuliQTWzMCHj
         wrfzo2VdZu9YxpkmHwfQ7NUO6dK8sBqUfNd/BOoS8qfFuZQ/GzuSafE6HozPg5NjM6oG
         a0AWMI9r0pYskrj13pRCTmznn6z+Ap9krXCOl6ikvAI47K66qG+3Boy8iS1n7ZO1Nfw5
         vqVifUbNVW9xYaSvQAVJepQU6V9b5EF765+ysQ6dPu9PW1lTmWcOLgh3UMHVOsvMkKJ0
         35Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946018; x=1780550818;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jbgqf3mu8JYb4D5FqVjFkGrGI4aSc89zJJbOU4Y7BTU=;
        b=b0NOH8bYMujDPARYgSfUWOgplO+nC+WbRwF8nXLJ4xXTsRDEjfXlfNXs1ggnDEdZ5k
         WuyVrtHiiEijj3pBfElfUsvIhQ3CkPjGMi56ksIiPZ64abJzlGXqr0/217VXqq58pDwl
         St3bZKceSBFoMowp5fCugoACZFmOuYUPTPgQtl/Mca9o+pCAR6q3r3v1yMcd0lJAyk2C
         VwuIyPSAYmJhP2U1+JexJRqz3eg1BzVMZUHYcjlz/o0D8rEbL/dNT+BAoTBFheyAmTFm
         e1/FTQx2axOrTwsKF0rJ9idqjANPmlcBR6sgurPSYL+A8KtEExqmYI35NmuiaRMPm2B2
         iAPw==
X-Forwarded-Encrypted: i=1; AFNElJ/4rE1q6iB4vgdOU3w1B0pEeJ75rDmVmJa+b1sdOxBXX1YNslEOpajJNsWwUUTN+xg/+/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyZEmR8puCZlZfZGRAWiB1buQNt4Y7YF77LAg6DuYb8yPCheP9
	KQHW+axYkcN+fQIF3+GhYKbrvZI3BZRjILhBLrOCbFflkJ/GIUwagnze
X-Gm-Gg: Acq92OEtcqftBLzd91hbLwN70jGmVSkCY+wkNIEvE5eitnpvzDXq8Fq6/+gTjyFw8pC
	C7tWPd069dWFaN3JmrhuQqv608Li4QQJ5fI2ZtJ/YKFHbyc8EfXyghCBDJn1YXt0Slu9mlnvAAD
	QwCNyafCf9W1pEgsCzfni1cA+HL9fq64xaluXjK+1LL/ZJO1KD9TecUJH0HxyWs3fDlUtihh5ll
	DVdtIl1bJau8GIstVwl+rqrW4ax3vOpbbhEO4CE3L2f6hOMhIVU4sGG8A5TboQvRNB/D2XQPpYu
	0akW9Fh+ZaAGtgJR5h0ZCDqOQlCeMnqMdJCdkDEqB4/5AnW9RN8FB8Rbnytcriym5dc8H/0DOwm
	OeHHp70kABVVzM11NZM/CYhDMYna6+9bIYZ2bLLvsCcdzR3x2rQhrf2cdQWjzsWeOreUO38JNcY
	T6i3iVOmRJ6a0JOS3Jnzv9P6JD8iFrNbzl/M260xtef7zfzMSF6YveSrJozcV3zUJF
X-Received: by 2002:a17:902:c403:b0:2bd:2458:50d4 with SMTP id d9443c01a7336-2beb07f5ademr283061445ad.41.1779946017786;
        Wed, 27 May 2026 22:26:57 -0700 (PDT)
Received: from foxirain.tailf10b76.ts.net ([220.83.29.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58c7046sm172642695ad.57.2026.05.27.22.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:26:57 -0700 (PDT)
From: Taegu Ha <hataegu0826@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Taegu Ha <hataegu0826@gmail.com>
Subject: [PATCH v2 0/1] bpf: reject overlarge global subprog argument sizes
Date: Thu, 28 May 2026 14:25:32 +0900
Message-ID: <20260528052533.3940181-1-hataegu0826@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527052539.3388700-1-hataegu0826@gmail.com>
References: <20260527052539.3388700-1-hataegu0826@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This rejects BTF-derived global subprog argument sizes that cannot be
represented by the verifier's signed access-size API.

The issue is not a large immediate in the generated BPF instruction stream.
The oversized BTF pointee size wraps the caller-side PTR_TO_STACK argument
check before the callee is verified with the original large mem_size.

Changes in v2:
- Expand the commit message to describe the caller/callee verifier mismatch.
- Keep the existing size expression unchanged after adding the S32_MAX guard,
  as suggested by Yonghong.

Taegu Ha (1):
  bpf: reject overlarge global subprog argument sizes

 kernel/bpf/verifier.c                           |  5 +++++
 .../bpf/progs/verifier_global_subprogs.c        | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

-- 
2.43.0
