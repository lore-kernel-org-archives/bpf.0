Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7EBF13A244
	for <bpf@vger.kernel.org>; Thu,  5 Feb 2026 00:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770251937; cv=none; b=JMYr2O+IaGxxqqzufOcCWBoRZ9075aAx638oKHxuuL4QQhA3QaEmVSTThz58rU77Lh8gZouBXEC0V7ota6hfqz0L2NAUSLLLgV/hvUqGUoUlhzc1fEYbnwsLfqrUlKLpURbVsjdLVGuPlb/FDU3nXHIJYPHvZROqwu8kZY4wJfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770251937; c=relaxed/simple;
	bh=yogizhgeTs3Xjf7KJgZLsiJv2L9GoCs/baVsujXZ/ck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=b5Ktt86UVF8P0dOrH5KZ83md9wzidK+jIOiggbQxKdOTA6vxIpVgCV52Myhdqcs002oRCj1lUpmrFi7TEaR2Yq9XWAgmwMyMpmIqXbLygk4LrHCuL316wZX9yXOEq6bA6KfLPaa+P0LPUPlyfMBvRmzfAr6Pvgz2mJ4u18Vcuug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETMRaxPk; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETMRaxPk"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-47ee2715254so2148485e9.3
        for <bpf@vger.kernel.org>; Wed, 04 Feb 2026 16:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770251935; x=1770856735; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s35lMVKdGYU4TZk5/SXjdJDJEa8hAxHwn9epec3tWL4=;
        b=ETMRaxPkQfM9agX5JjTh6U2ZlgbN9rnSBTrQe4rVyRNnWb4PpC0xSEZkChh5vi4DN8
         a9MCo8gIk8BQqxdqy4k+ZNj7yiIYlS5pm36Nm3VdFeUYr1IOixQqYOP1N7CoTEQXtOAm
         cXfjFvgzh8RgcCvYw2I7zcKQrlTsp5sUAh5yT8w3xGsDPJbeOly66swCOzsmAdD7itZe
         LCk3a2pfvvVz2Hcc/8XiFYW+F5zKvgLU04S7JnrQwnbWGIp+N1QG/Zil8X2z9gBpea9d
         DIKZeSOYQe3ibnlwzxlrlfT5w2SWKp8D1n1gS1RrhzCpc+MsUjXZvcSUw0OFWntauzeE
         ukZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770251935; x=1770856735;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s35lMVKdGYU4TZk5/SXjdJDJEa8hAxHwn9epec3tWL4=;
        b=FtC/r3CGbAlujRm/wU1HrCxze9KIfsiR/qgEP6t0+lQpfUUNIdsf+w+/0+drh6nq6/
         TNcszDt7/rIyhbOVcz/QpdSop9KhTkZJCHNnGK/Y9oW1UZdwEXLpa6PP42V+GUEU4GZl
         zQlKFmRkMz2U9fbkduSZE7r8kaEUVVBkE4Iuj81qr5/i7qusy3gJvKiwh3lsx5E2t5B7
         H6QdrcQCpDXTHw/gakCz/y4cP/RTazwPo/iVAi2/n7MyBcvVjno6Og50ujkg+4WB43r/
         DLFhbCJ5xo6jXhqr9deXUQY7gSzOsepR1Rjf5xOv+H+mpg0zh9HY8hv+BEHcXt6w+gSK
         digg==
X-Gm-Message-State: AOJu0YwJJQ7lL5gyU+sh8eWx3b97ZBN85y1ci9to4ub8qT0ze5vMISw3
	wwf4nwpgfOEr1f5rR+JalYqDFOe2s/BRg4frp9D6UUs+bDWvQuPfQlQ8uwwHM6KK
X-Gm-Gg: AZuq6aIj3bKc1J+rbjzGpZewyj8JGF9lL6tBWeiSN5MO7LLE+fJeoiwh9POidu9bL/p
	rND8eK0SIwtqVPd1qHqMrnVXpDWkfHdUSaFU6FX0OFGXfSTPg9QOWgelFBO8hZ/5WrDP8l61O5O
	IXBzyfsT5O+5IB9QRnmDeQiqLZzuYkAOaRpL/tQ+hOPW+fHfmmQ4JwoGFES8/YZY2OI5JOcBU2/
	btAcOi6mP9lQzHLl/I1QiSAbXaGwjKMPcqj+7oGE+AvFP9Jl9XGJ7RJpWThGVbaT7Tbl8dKWC4w
	bNZYhh1VtgarjpBYjSSGkMn/aa0cn9kRHzQI+4KwlRCnXdWPh5jB5ecM5PZBRuYUEIQxs/Wpa91
	pqQrI+R7xlI6Ge5C5bg6RuTWhT1TuWryp51G6fWdNWAjZHfD4zJ2kEkwGsuh8zUBuT+qlWpjSZO
	lLYvJCljughcsZIFdIM52FbsypA7S8HH+r
X-Received: by 2002:a05:600c:c04b:10b0:483:a21:774a with SMTP id 5b1f17b1804b1-4830e9926cbmr48248695e9.26.1770251934747;
        Wed, 04 Feb 2026 16:38:54 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d8e8d4sm17240865e9.15.2026.02.04.16.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 16:38:54 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 0/2] Fix for bpf_wq retry loop during free
Date: Wed,  4 Feb 2026 16:38:51 -0800
Message-ID: <20260205003853.527571-1-memxor@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=524; h=from:subject; bh=yogizhgeTs3Xjf7KJgZLsiJv2L9GoCs/baVsujXZ/ck=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBpg+Z79C4qbI7DT7dz7FRqMup3nrdd4a94qPOlPovY 6HfKV4uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaYPmewAKCRBM4MiGSL8Ryr7sEA Cu1y7Q3HBhEYfvQ8ETsIfNaRhxQQoHS4fHABJd4ZggxKGmaR8ZsMx+U120cvoBQl2lCUrVvqIMsn6G ah9pGxpqbe7xgmAVe45mU7Q6xk4rrzlBgRvcKq8MrSgQI0FmwPgtMTVlL7pUB4ZDJqcO7FD2LyP1wu Rz8ZWo0MRH5sKwxhJSH45mONuwj8EdlM1RMEq/l7Z3IntKJxLONpUIcVDqrwUvIc28vJIMob0d3+c3 vUQQjs3ypQYIaAhBC156I2lPzCAwwFfaH56h0j+j16yYnRjvpBJnlmnnxHlR3hZWklV3sRW015H6eH PvaWR5e5dj5Tck8kW8NIU3aYRSDHqiUKH4dEl9SV+3yNbf+7PU690RiG3tWR5UglM4M3aCMg0hdfyI BJZk5PIgGukSD6aVS/n3UqdWnaCSx/b/aStmOQDHIHG+ThEunYN7cOEDeSfgYu+T3QkI+8hDuKamIe YUDhJUQkiW3rvNIIAD+hZzTAwZ2oLCznRD6spcIecZucAY6R5Ge8YTxVfXb89NJqOjfobN0E5MALmb u/QcyCS71HI8AS6dzX+MHsfUE5l4HQj6QzNT+N3Fp9Q1HFpNjwbtBwKBwl36aqMoy4rrvrKaQFkzOj MkLAR1m6ZUBctGz4xnMu1R/qink/XF8Err2F+9qfo0w65iHxLMVp0U5VfB5Q==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Small fix and improvement to ensure cancel_work() can handle the case
where wq callback is running, and doesn't lead to call_rcu_tasks_trace()
repeatedly after failing cancel_work, if wq callback is not pending.

Kumar Kartikeya Dwivedi (2):
  bpf: Check for running wq callback when freeing bpf_async_cb
  bpf: Reset prog callback in bpf_async_cancel_and_free()

 kernel/bpf/helpers.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)


base-commit: 6e951a9b1af5dc063dfe9e17ca433be099527c43
-- 
2.47.3

