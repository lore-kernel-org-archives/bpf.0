Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BFDA3F482C
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 09:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788602136; cv=none; b=T+98ZWokj6cZdTGFDpjsIT+7lT8p5YU2ggkZ/0R0gXjs6iStxm3lFh3nyl76zZp3MnYDqfCVXoLaoGCd/PJhg+Ho2CC+Uwc+rDgjtbPjgfZeUUQlUp23ncVfLluX0c6imJuFy5mG8P+AuQgQ7cIGLybIgYrasxkoZXHRn/kZX5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788602136; c=relaxed/simple;
	bh=eRQAAXlWAMROkoD7OBw5ouB2i6O1eypSFuIjNF/KGNU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oguZxrGXYAqzReP6MogoUjCpHoQ8x8binWdQxKWo+rA4B0WRrXOjUulZDIl6c8c+VDeUR4XfCVkRVnzsf2H79zEvK0aBaloP6UbkmfOHOchRwMwNHnG/k61JV47TmYxEFa8d3tYMWUCeozESQBJAMbCfo/3SddIopTWhPzGXnA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G90UtnqV; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G90UtnqV"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-49b8687630fso16384095e9.3
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 02:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788602133; x=1789206933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Uinq+jcxQ1Le4rWdm3YmLWDbX4aGYVSl5HMyLui+hkg=;
        b=G90UtnqVLKjal8yi294rsHIj+3GB0u/VHCLm0Y5jO6X+r5W9d4SIWfH8tn6ywdUi5k
         CrFAQxpH7jvDvsBf/cyb8Csjd3NtLEzcwn+4SfwTJO/gV74Sk4Y2/gCoL2swne1Ltwt/
         7QEI1l0Z8RPijvWc/CnKr+/MsMrdqC+Mg/q3tHeE6FOt8RHazYJ21qFtbxtzyVGzNHg6
         JChk2InpPHbaEtH8HigA70LuKgbTAZiBJmMQambRnDCXAL+5NXMCpnzhQ63qh8wlPCoG
         q+IjHC12ZtPDDJUn+NN+gdrqmF1rjF04iDcFtGHwODjTnt2hl4nrtXCRpUNg0No5dx0a
         b7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788602133; x=1789206933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Uinq+jcxQ1Le4rWdm3YmLWDbX4aGYVSl5HMyLui+hkg=;
        b=YQlZWde/ALpQdz1+Wf5Guv5pQfSaeIF/EqwrwrKasCa2HXaULejld8HmYQTLQa2OpE
         v0OVQ9o9GzylJzunMQxlJPgcJ9PmK90n7cAhr8nlhDdHyJxnYCSFN8+bjzuHFV86LyCR
         hbG+ML9ZAW2jh+0uNMf/gyEzNa+uByZTUmUHSJMj7kaZzhAq17eRJuIGByAHnVd4ZUtn
         yDYHHQ4evJrdDEajk6+1/jYTK3ZxSur8ky70nsOze1RTUng3MvUQB1lM8UzeCftx1Ium
         6HB0Z5h56ShybLORMitjIlu2QosMUKzMRO+Wure7QGFIGLBndUbWbnjUW06itD71wqQg
         GDpQ==
X-Forwarded-Encrypted: i=1; AKwUvBztdgaICYcBcnjeEeBu251/4FbvnqQYs/hTWVndap7+2s9dZY9LTGYQDxnO75JJdGbjdF4=@vger.kernel.org
X-Gm-Message-State: AFuF++lsjiR3Ti7lL/Gezdutstkbod4DkeQxIftrWR3eGFZIURwUldZS
	dFVjUHV6p7TQF8uXtTZ4MUSh1WIHdTraFvQBaPABlmwkGl5fk10/zM3m
X-Gm-Gg: AYBFou023ARNZUl8R1eT6eCs5jbnb0/vOmR1updBMcM0b0pIlvLeMjAWCSF7qN5FKVn
	CVzFZNOpU35kAbnZGYjo4QNcyjitmGyJ7R+Cw3XHXjRZjC35S5zzTQWxFw/Qeva5izMTxb+oTxR
	5g9GttpzL8sp/9PRrRHFzcfjbOzKEXDreJJc4iwTDc4bcTk6PdyGpi+W7W73jW1V2XA3tq0E/g7
	LOUHxcsK14GmI3Um1IIvAd4EYuace9Vldnd5uEGw/5ZMUAqNh1c3tfTSJwfLWq8qYSEUaMaPIAa
	2h6CjmZB1LPlQUpB+ilOk+Aw1+EfXNrvlvG1nxjJrDQcEXSSIbVEezO80iNQgl14STc+F8Flg50
	tu112DW/XAoZbTcMha6YLMjaIZcQ/U2arPVuA3cRNYDNGrBW7OMGQ6FoUmPiBi1sstFCVZLX2Q7
	hUpl7KJX0KTuLagUyUHyqcR76ivN3afSIvlbiYawRWS0sj37jvTuRYW6vyExg/qRO3xnHidk/AY
	E3F/wfLDAVWcm0/Velqvo+OlkKtMc3MM78G5u1Fp96ddo4CjSWkimW6g0nuNcHhE1YxxappNFKo
	njMUiUF9VKbUwBO727lPYsb7RBqBMeZTbS+Q+56YyNHtgDgpbtUlMtguFePSs8jMjNs=
X-Received: by 2002:a05:600c:3b8e:b0:49d:7f5:4cdd with SMTP id 5b1f17b1804b1-49d07f55332mr5523515e9.27.1788602133188;
        Sat, 05 Sep 2026 02:55:33 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cf755c22esm135325035e9.0.2026.09.05.02.55.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 02:55:32 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	David Vernet <void@manifault.com>
Subject: [PATCH bpf-next] bpf, docs: Fix the struct bpf_cpumask name in kfuncs.rst
Date: Sat,  5 Sep 2026 11:55:27 +0200
Message-Id: <20260905095527.42261-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct bpf_cpmuask does not exist; the name is struct bpf_cpumask.

Use it.

Fixes: 027bdec89364 ("bpf/docs: Document the nocast aliasing behavior of ___init")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/bpf/kfuncs.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/bpf/kfuncs.rst b/Documentation/bpf/kfuncs.rst
index 85f73e0bbd0f..57831eda0a33 100644
--- a/Documentation/bpf/kfuncs.rst
+++ b/Documentation/bpf/kfuncs.rst
@@ -536,7 +536,7 @@ For example, for the following type definition:
 
 The verifier would allow a ``struct bpf_cpumask *`` to be passed to a kfunc
 taking a ``cpumask_t *`` (which is a typedef of ``struct cpumask *``). For
-instance, both ``struct cpumask *`` and ``struct bpf_cpmuask *`` can be passed
+instance, both ``struct cpumask *`` and ``struct bpf_cpumask *`` can be passed
 to bpf_cpumask_test_cpu().
 
 In some cases, this type-aliasing behavior is not desired. ``struct
-- 
2.53.0

