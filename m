Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E9D23ED60
	for <bpf@vger.kernel.org>; Fri,  7 Aug 2026 00:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786063452; cv=none; b=t+Fy2McSHYAn+zFYoSavDGbWKJrADuoIXiknmR+/nNuhmo3ksZS8OE+q+bszwAZmcP7V24afpq3gTHFDL5hbb7fEhN6QZrfkN737WzeRbQEp+Ekoxg7Df7eQJDQKmtmlR76ZXGYMZQg6mN9nhqPwUvkdmvLLewvZmQ1WpNS/SdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786063452; c=relaxed/simple;
	bh=snB2L+HUQbNtyGefpQxRnMwzaVPncrebZ/vfvOKEgVw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KuNEK7bXOxwO4Vet64/p1BvHLC60pqGzWjflkvblwhj+UwVHVhPQLwWQzprUr5EK6D6M8U+Zx0LTcqavruJMlP1Feg6k/ShVYjZtRoyfltkYynQLyoCYU0ivSbyB8k8+DcJJnaaOlHmSIx5PpWonbPSLf4TBjKEcNbggjEvnLk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJZQ9qLX; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJZQ9qLX"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so2658447b3a.3
        for <bpf@vger.kernel.org>; Thu, 06 Aug 2026 17:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786063449; x=1786668249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N+RlxWYLHhvfrSCgOSfrmuFljr7W39DgQCccVhG1vok=;
        b=fJZQ9qLX41CLD3533CSdQJNB4Jmgiv9t9CMYKG4vT8HfbVpZudXN4yHsnFE/Nymrua
         2bIzXHM29oqUZk2NzVl0sX9xZUbAt1w2tCvSS/vLY+548DO6VWJLas53+4RTYe3xhfVO
         SHGPjo3TG+RziJ5q1mT5a9PT8YroOeEBkQA+pxFpdz6LcDEl7sTUmDQAw85uG3fze+Ts
         rUDba0DVCklJ3TvhMPLsn90Yz87oONovHhqgivPIQMDCNhSmQoCDDDEmWfkE3rK2s5Hp
         d2F/WAKKbLbHlFf8dKfeYbhYR8hkwFoASbjxB48r/PqVttRh1nEQSZanEBSKjmQ6p5YX
         448A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786063450; x=1786668250;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N+RlxWYLHhvfrSCgOSfrmuFljr7W39DgQCccVhG1vok=;
        b=KUi16/TuvQ/u5kgbyyuG6cqDDhFt4MayZlnWLXhKkV7RJxI8rVatLR4ew8e/pR7mpC
         u2gTbcLh13zZfZWEb1uZI6UObxwlnRo+5vLatzhe5KZ+cU5PEAkRZKt8BfT/psEoQgfZ
         4JPhg17+GkaTik3ZzjAy+wRzQcuWMzy0fKNHTwMwgkzFvTybxeP2CZ0TL5/aWrScTajI
         eSfheZ+WmsHNGQoZF7fsXpaCIVcYUxxKQ/hQYpudUWAgBzkcfCKep18B1VMZLP9JtseJ
         86eiAa6XUHgbEBmkfhf3tIe4o7P0kCJhLcIKKwENDhkUJ2CfkYcH4j7k3u04hGKyuTEr
         DHYw==
X-Gm-Message-State: AOJu0YwrgLzPQqomKeeuYxOvEtkXMMZd8f4+r3a9cu06Z9X7QZ40A8f8
	v9WbfbFK4wNxGBt2MqjTeIr1KV42ibntk9m+JN1IQaJPRt/5hVFIvTou910ftw==
X-Gm-Gg: AR+sD13mHt9dxv5GqbGZwHfGYv2W6J5wHOKuFygKsc5jueIP97jEZyVH9L5BA5mr914
	aoL7d+DA2WWs1aydPgkOe5EYxwXC5vanL9jJoVfHw8zfgFOxl4TLSgaZ+nsx3NPv/mWJRmODI/y
	koaFo1+G5w1atdYN0DxSLLoBilvp+mcL3mhHxKmPP5ohYvTM4pe7Dq6d25UYTiTnNJ1zgoxRTmM
	1RlraebhLroKuBtxk6ldyK9l2GDe6CihBIdvXl4hXCjBNYltNMgAcPVKoWvjZehm3C1UrURy/o1
	ua3lPM/1gi/kj1P7bU7FnXBfGen91Vfn4hF2Ec59xGzCsFVfqo0e9daCog3a6eb2lsVOczpVccP
	1Kb6XHZeom2FFwPPOXwu8KS1fLgTH2WzvNo4+IdohHRYbdg8F/sTnW+sBLK+nOPlo0jFpHzw8X/
	mzvjJ0OzQtEsyl8so5V5BIVACuy2KqDVi7KUcpa1qoa3nwucSICqpAyzH6wz/K0Ndl6Gz+hhyl0
	59HOajbOZY5PS1m
X-Received: by 2002:a05:6a00:23cc:b0:847:c014:864e with SMTP id d2e1a72fcca58-84f4febeb98mr5766759b3a.30.1786063449596;
        Thu, 06 Aug 2026 17:44:09 -0700 (PDT)
Received: from patterson.cs.ubc.ca (patterson.cs.ubc.ca. [198.162.52.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84f5a552859sm172922b3a.42.2026.08.06.17.44.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 17:44:09 -0700 (PDT)
From: Ning Ding <dingning04@gmail.com>
To: bpf@vger.kernel.org
Cc: memxor@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Ning Ding <dingning04@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Compare iterator types during state pruning
Date: Thu,  6 Aug 2026 17:43:19 -0700
Message-ID: <20260807004320.134069-2-dingning04@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807004320.134069-1-dingning04@gmail.com>
References: <20260807004320.134069-1-dingning04@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

An iterator stack slot can be MEM_RCU or PTR_UNTRUSTED. These states
must not be equal, or the verifier can prune an unsafe path.

Compare the pointer type for STACK_ITER slots.

Fixes: dfab99df147b ("bpf: teach the verifier to enforce css_iter and task_iter in RCU CS")
Signed-off-by: Ning Ding <dingning04@gmail.com>
---
 kernel/bpf/states.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/states.c b/kernel/bpf/states.c
index ea2153cf28d0a..4e6aafad33bd2 100644
--- a/kernel/bpf/states.c
+++ b/kernel/bpf/states.c
@@ -812,7 +812,8 @@ static bool stacksafe(struct bpf_verifier_env *env, struct bpf_func_state *old,
 			 * infinite loop check triggering, see
 			 * iter_active_depths_differ()
 			 */
-			if (old_reg->iter.btf != cur_reg->iter.btf ||
+			if (old_reg->type != cur_reg->type ||
+			    old_reg->iter.btf != cur_reg->iter.btf ||
 			    old_reg->iter.btf_id != cur_reg->iter.btf_id ||
 			    old_reg->iter.state != cur_reg->iter.state ||
 			    /* ignore {old_reg,cur_reg}->iter.depth, see above */
-- 
2.43.0

