Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B13939D7
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792117220; cv=none; b=dnG8bqtm9nJPcvgeNEWWIZAmZ/WOQavhHODbgesJ6raBr2QznWtBrNlLsfNRjJNGqsFlXVpvEALTizQQfS0fFay0KrLzC3zfQtWwDm1LkmJAreB1U5XlA4Lfm442HtKNZUM+dqMn6+pGXhL4OX3kp5Nb2CuVKDDI71a54H/z9FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792117220; c=relaxed/simple;
	bh=xGfc8hkwQ1JzAZbx3cw8pks2pYJ+XRlDMgDsnChrvZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HA/bYTqf/vEnkQgzjSMc+uSNM9oWEjHgQbpQ475HexC3S7F/m6nXfPoC4ehxK1jMfWVCoUeD0eBJ3u6URqDg62QNRRG+Hr9mYvAF2INZ+sQjqTGOGU/HDx+XgUmnVzVSoMxhEVfcHcOp0MQ+x3zc/NWYzfkm8sA6GLMZrK6XG9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=AMxzgrU5; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="AMxzgrU5"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-17bc533fda3so2906770c88.1
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:20:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1792117218; x=1792722018; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bIkNKmu4tNSbGV5T07Rx97zRUQ3kfDdV0Kwy8SxGUtQ=;
        b=AMxzgrU5Um2cY/sdHPnv6OI9SVONYnMSqpBBKinHSCfhox+E/iZtlxxhozLbfziSmY
         VazFM2+ZGmbhDsWoqdzfAbd6nH6AY3GDYNbvKFACuz9Y5OJfhfjnTaVtnP8eig9/pMp/
         R/bI1Kh/Shw7ZMOdciMQ7SKN+5MzXleXuzsweSd2X6EEEJSj878iqVl6G1bue8yJH+X7
         /5sKwUQhzvhJr2uWyUK00hsw0KEjBpVg2RrrWm9EptllrmnVJxMc7XTlK9w6beSoEHQi
         1O2lkQGMTlzab1PmMTVnanfV7ORmTlP845sLOeN34HtdHyjByNwk3RjL4k7Vq7AHQLUA
         OWJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792117218; x=1792722018;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bIkNKmu4tNSbGV5T07Rx97zRUQ3kfDdV0Kwy8SxGUtQ=;
        b=oTLxpvMgkuX4RQgYKoc/UbnUuTfMqXbOiLtQWaoLzoSTdvq70K4OdqbCXUc1DRoytS
         R8w9FYFjkslmJjIijdZa6/0TJ5IcIDAsC6Ly/YSvSdexWV5S5DJeVI7yFY7TAEejYJnY
         JdCshjpoS+CzdRv2p70TSuQ2WgOawiwHSyZ1814yVotGf+HOjix0xU4605aCBtNugXxW
         AAW/Oi96QnJ9ay1YMjrMXYt1bEkBRfqZggiJTcKy3tH/Bl8GTei8bEeG9GoJNXQpgrFN
         vR/3b/fTLEYCN7t20jDsudW+kaPXZeyKUFyIDZDwPO++fHhN0kS1vzFbHi7QQbpi4hEc
         lORw==
X-Forwarded-Encrypted: i=1; AKwUvBzE0InBMKIV4iNWdzjOPT8YEG31rNq/j0yYrLYA6YR4XTbfjjRPai7hzCEiIw2dOu+JpVE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIUAEvR/a3hpKvpTYiz1Xr49fQO3UvqjIdGOZQOR85W4FOF4UBw
	tNlBw/+IfMmCjCvX2e+ybG8ZVRKFt6/JSs/BmZTc5l3Vaw6JlyQqNFtic0ugxMn7OTc=
X-Gm-Gg: AYBFou0B4+7W5t+Fkk43w3+/GIQxhfJu468g8g+jXJTTbRASQyShYF3rRr9afeL+0q8
	g3bX45d1hlqNkr1nbbE1ogWxEJTVfrCDuZOp5wwXQxGxhc0HWyjUK9L3NoTn24nXT+fD5Wd6g7i
	IlNkeLaFXtccmVn3T+e3Y8TuDbhWDsSZVRoaVh/+vqMGD2V2qEDJNm9Ck801FiD7cslPTdvWmTK
	Xm8pGnxIkJn044If+V9iAZtIyix+eDc4yUNmgIXqv5hGtWbGz05rPnuYJ00XszDwP+Xx/XQpDFq
	zKYXtt+Ca0Acv2iNTJRxcpCNs7pEY+vhbyONLK9X6BVNoQFIwmPUEA4P6rztBaO+Rfg1SNk36fB
	D3wl+tRAfatwoHRRbwztUVEFX5cTS1Iew8cnRlecT3wwbALNNsE9V6AI/2CNYPBlldH5zp6Rl9Q
	FBM7kEJNwI2CRicU64GdrEoGs7K14GjzSjxc20u0n7z87fO0lvY/GjCDu59pzPn0Yc1sTquWoew
	5XaBnHBfcnkjYo/qquQyXPZFKPg5G65yTHrs2WOvg6WTxoVueektHncxDZ5tUYjbYHeXw==
X-Received: by 2002:a05:701b:2403:b0:145:152:b547 with SMTP id a92af1059eb24-16a56ab0d40mr26503724c88.1.1792117218235;
        Thu, 15 Oct 2026 19:20:18 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:d66:d0e8:dae3:3257])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831c5cb39esm1434734c88.22.2026.10.15.19.20.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 15 Oct 2026 19:20:17 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	emil@etsalapatis.com,
	ihor.solodrai@linux.dev,
	john.fastabend@gmail.com,
	jolsa@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev
Subject: [PATCH 6.6.y 2/2] bpf: abort verification if env->cur_state->loop_entry != NULL
Date: Thu, 15 Oct 2026 22:20:11 -0400
Message-ID: <20261016022011.16938-3-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016022011.16938-1-artem@trailofbits.com>
References: <20261016022011.16938-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eduard Zingerman <eddyz87@gmail.com>

[ Upstream commit f3c2d243a36ef23be07bc2bce7c6a5cb6e07d9e3 ]

In addition to warning abort verification with -EFAULT.
If env->cur_state->loop_entry != NULL something is irrecoverably
buggy.

Fixes: bbbc02b7445e ("bpf: copy_verifier_state() should copy 'loop_entry' field")
Suggested-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20250225003838.135319-1-eddyz87@gmail.com
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
Hi,

Please consider this backport of the corrective follow-up for
CVE-2025-38060 to 6.6.y.

The code changes are identical to upstream.

The complete fix is already present in 6.12.y, 6.18.y and 7.2.y.

Build-tested only as part of a cumulative 6.6.y series on x86_64
(allmodconfig, CONFIG_WERROR=y); no runtime testing.

Thanks,
Artem Dinaburg

 kernel/bpf/verifier.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index c00113e691955a6c9c6caa56007ccf90ce9b87d8..37abde03f174ef5c0a47317d9b9d19eeaeb0ccd2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -17562,8 +17562,10 @@ process_bpf_exit:
 						return err;
 					break;
 				} else {
-					if (WARN_ON_ONCE(env->cur_state->loop_entry))
-						env->cur_state->loop_entry = NULL;
+					if (WARN_ON_ONCE(env->cur_state->loop_entry)) {
+						verbose(env, "verifier bug: env->cur_state->loop_entry != NULL\n");
+						return -EFAULT;
+					}
 					do_print_state = true;
 					continue;
 				}
