Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78EAF2236EB
	for <bpf@vger.kernel.org>; Wed,  3 Jun 2026 00:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780446834; cv=none; b=tgLRM7ZD/93+2zdImV8OGxer4ge3dZ9056wOSGyOaYHkiknXefTFRM+P5tmmLbfljWZhUcrgHIoHe9hsvLjcQ/vbQelo+nUazAnM4d8TRaa/y+QtZ/lvpQE4H9xxdX+S6Z+e5d2+ra++PW5muv5praDXEjxRwLAxqb6XPYxWbwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780446834; c=relaxed/simple;
	bh=s2PIL3kHw5bcjmTZXCw7jjgBFIhsTTedP373LqgIUPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cmGl2TMtlIy6Q2PjbpYopCm6MHvOd9tPId7m6BV9H8leFZW4JF7YtuwFvZ6oRFKM+TRnBwzQf4F7tehcgSqCB9Vg0onlCqOn7fhUtCKBTk9BQV7ex0AG+0zhyYCwhl0MFO5mXAMPhtsB5b6iUjSfhh/xA8BlK3+n26FMs0A9t9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7WnCThW; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7WnCThW"
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-36bcbd7821fso2185906a91.2
        for <bpf@vger.kernel.org>; Tue, 02 Jun 2026 17:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780446832; x=1781051632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rwt0+gW9sPlUCL+DIlEfwjW/3Pmzh6toOUvHWzfa5kU=;
        b=r7WnCThWAun0w4/lp+kX5/blcLEdz7t92VYE5Ci5Tnv/B33xbLl0C2XQBgl1mHSLAb
         jooAY3I4cp2hQSOCLheNisM3JqtA1Rlb2Q8gNqpnIRV0Z/N7BjJkEKCoIo2CQ+O7iKtC
         MjBgv4NfCQ+6UnOLh+PFHthgEfx1oWun24q1lyMxN0VPzal/ITLM+pkM4tM8DiHDKUim
         kmBE6T5ZplwD687tKRU/wSNdSUOCvSTsI6ubnCxBtWqPaLdx9yVgtMo0a8UXuQISJndh
         YsH845LOf7NPK7vFHpUm1krqkoWCtabOvKwrAhiAMkAEWvnUI9/+io1obiFjJIL6Tywm
         7hLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780446832; x=1781051632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rwt0+gW9sPlUCL+DIlEfwjW/3Pmzh6toOUvHWzfa5kU=;
        b=ihoshzf5JVLTpMlqFnEYPUINAIPtG0lz79svKIkWGzv0PkyvVrPevOOpA8k/NNI8Ee
         vUKUexUEWFotwYakwxk3kQsrbxFVvCDb5RGkRnhIg7hB7rgSCVR9h/t1EDRp6fURymLG
         rXvMZaiBvdbsAebD0wYjco3A2UnILlF0qb7g8opRs9cre0wE9NZ7esZpuHO9n31AnOR0
         guaSrA0X1qH2/sT9ZfgdyEQG+I14D5gFB00ksB9l2a9o00/3txQA5qc0iAsuhk83msz7
         WCGikCmpLv9jZh5fdjJGaGMmKz0gz83mhQgIqm+KZg3Aq3AQGpuMJqbAun2JyEe2NGgq
         ugsw==
X-Forwarded-Encrypted: i=1; AFNElJ97TAGFZQz/zj4uiapsZwkxW/CGynSVIqFnA0FMn43j0MF7o7fKprGxTwI5PYzbsn3j6Wg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPiHBVvJKOMabSyMwQEeNZjHyKdwm8Iytn3RpkZ8bt/vOxhk5g
	unr9IVz0Wssy0s/9VifNViMn8ZIGOJ9OqHoq0YO3+4OfPycFg1+BsvY+
X-Gm-Gg: Acq92OHrDsvnbqjRCsJeJ9Eyb4ivteulHyjTfrH1y2YoqikCuo3Dm45NaGUHGANeaPl
	IMptwj3Bv2AF0ydp3uotDxx3GjCfTDhNYjEzyzbS/+jfRvP5GiQPWy/QPivwc8Aj92hwJ1f6wFo
	u2B7aP4c+jg+7920Mk/nDqB1sbfrJlU/xJO9O2X6n9M59mj8+ChMM/C6Fi3R4V5D634k5VEWpP1
	pPsUneQKdhdeHINNJPyCCBQWNvIx/uINDk9OQvGHlX2HP5rumo+4vrt9fgqQsbtk72fVqw7nY1T
	B/F/s0wF13akvR3IyR8d1zQK1u4BOOYF4+65E1l1GS72NMY/9G00jyGxjahoWro//fsB627uMr8
	QwhIvI73/Y739V1c3UaTO/lGoRK4ZrU2gaHTEvuYd6H4G51UogXWp+mzV8tN9FX5EYf6ijRgDng
	iOBnEy60M7fBwDMQkSLDYwfpj9wLR1
X-Received: by 2002:a17:90b:2811:b0:36d:5dbe:2a0d with SMTP id 98e67ed59e1d1-36e30c23af4mr1075420a91.7.1780446831498;
        Tue, 02 Jun 2026 17:33:51 -0700 (PDT)
Received: from laptop ([61.254.29.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36e6d169abdsm92012a91.0.2026.06.02.17.33.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 17:33:50 -0700 (PDT)
From: Woojin Ji <random6.xyz@gmail.com>
To: yonghong.song@linux.dev
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	jolsa@kernel.org,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	memxor@gmail.com,
	qmo@kernel.org,
	random6.xyz@gmail.com,
	sdf@fomichev.me,
	song@kernel.org
Subject: [PATCH bpf v2] bpftool: Use libbpf error code for flow dissector query
Date: Wed,  3 Jun 2026 09:33:39 +0900
Message-ID: <20260603003339.33791-1-random6.xyz@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <22ab9375-e7e6-4929-a80c-0ee9cc74a907@linux.dev>
References: <22ab9375-e7e6-4929-a80c-0ee9cc74a907@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_prog_query() returns a negative errno on failure.
query_flow_dissector() currently closes the namespace fd and then reads
errno to decide whether -EINVAL means that the running kernel does not
support flow dissector queries.

That errno check controls behavior, not just diagnostics: -EINVAL is
handled as a non-fatal old-kernel case, while any other error makes bpftool
net fail.

The namespace fd is opened read-only, so close() is not expected to
commonly fail in normal use. Still, the BPF_PROG_QUERY error is already
available in err, and reading errno after an intervening close() is
fragile. If close() does change errno, the compatibility branch may be
based on close()'s error instead of the BPF_PROG_QUERY result.

This was reproduced with an LD_PRELOAD fault injector that forced
BPF_PROG_QUERY for BPF_FLOW_DISSECTOR to fail with EINVAL and then
forced close() on the netns fd to fail with EIO. The unpatched bpftool
reported "can't query prog: Input/output error". With this change, the
same injected failure is handled as the intended non-fatal EINVAL
compatibility case.

Use the libbpf-returned error code instead. Keep the existing errno reset
in the non-fatal path to preserve batch mode behavior. The success path
is unchanged.

Fixes: 7f0c57fec80f ("bpftool: show flow_dissector attachment status")
Assisted-by: ChatGPT:gpt-5.5
Signed-off-by: Woojin Ji <random6.xyz@gmail.com>
---
v2:
- Expand the commit message to explain why relying on errno after close() is
  fragile for this error path.
- Mention that the netns fd is read-only and that close() failure is not
  expected to be common in normal use.
- Add the LD_PRELOAD reproduction result.
- No code changes.

 tools/bpf/bpftool/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/net.c b/tools/bpf/bpftool/net.c
index 974189da8a91..dba28755d284 100644
--- a/tools/bpf/bpftool/net.c
+++ b/tools/bpf/bpftool/net.c
@@ -603,14 +603,14 @@ static int query_flow_dissector(struct bpf_attach_info *attach_info)
 			     &attach_flags, prog_ids, &prog_cnt);
 	close(fd);
 	if (err) {
-		if (errno == EINVAL) {
+		if (err == -EINVAL) {
 			/* Older kernel's don't support querying
 			 * flow dissector programs.
 			 */
 			errno = 0;
 			return 0;
 		}
-		p_err("can't query prog: %s", strerror(errno));
+		p_err("can't query prog: %s", strerror(-err));
 		return -1;
 	}
 
-- 
2.54.0
