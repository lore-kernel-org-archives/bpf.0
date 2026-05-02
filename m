Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07091C5D44
	for <bpf@vger.kernel.org>; Sat,  2 May 2026 10:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777716766; cv=none; b=ia+tsqrbBkDeV+v73tvR7W3MP0DL32B/UUiNNzSQXrXTyd8Vze05MrJK1T0ehqEw6qDy8R7Uq9OI029z7YD2nLvwWiY8l43Gp002Bw6bl0jDWbMadKnukIX6uvfi7yXetOwYc9oVNB6elGpNvgjiik0RDuBRfKqw5aiHiM7u18Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777716766; c=relaxed/simple;
	bh=vJ80vzO6vDSTVC6etVNflKXbJGFafEpXXhjSbZ2gn0o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BlvVWbbRaAlayNe7rjzJa7VW+KHc5aY5Xscqb7QLD1N2FTGLYRbJQPfkmLM9Sj8+jNhSyatNPu2Hs8BZ//lZ80n0hFdTRQd/lgLMhj12A0n4CS0HDTZeaYeG9Soq+92Kp/7fHdI0MXWhphtrIATEkM1TDNGs9Bt/FHhnb2R+pQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sahwD4gD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sahwD4gD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so41717185e9.2
        for <bpf@vger.kernel.org>; Sat, 02 May 2026 03:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777716763; x=1778321563; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MckL8kJwyZ93oJAC8HiQkckMfFDfg9Qz652ybz48mQM=;
        b=sahwD4gDj5xC9ik5gThnojXcUS6x13we5GKAox1xAJKUPleCsE8e3PmljEf7xolLjQ
         VaJlY/1sFk+KpVaXWd8gkgfGUtZWqK7H0vOJ9kDhyXLQ7ACHvbGKmImusIT0n+KY4U/2
         RxFQoh0cGFzvJp9PP8XRoUFn5PUShqIT5zWuQiCuNm5TezzbU5EQ9SwL5Y/N8dAopb+k
         DjqdDPTNGXOTakQzI2AE0L6SnLbssLW83u0M3bbG7G7C+jkUTz0D+KaGpYYJOUEMsher
         qyKOJuleX0AhFf6yqoF9ZThzog14CEBsYvUknUneIWRCFSEbHiEhUSyfts1IOtsGCz6N
         AETQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777716763; x=1778321563;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MckL8kJwyZ93oJAC8HiQkckMfFDfg9Qz652ybz48mQM=;
        b=gSIurM+ntWL36oeiiw5BrH7hA9Day96nhljIDtN3LQ1LigJ1WwS12s7k2TR0g8ndNP
         Rwv4iM2zkmktW8DleR7xlf0/cCY456tS9LYTVGOJ0BweXgp0p0P+ciVRLQNCMWH5DpQL
         IRJ9ErV9yy4tIPN5b1Jkx2QKmakFyOJxr1sReUT+e3eGXKvqnEAiN3cTkyeYFLfm+Jg2
         NDFcomv80caOULQdXDoQxZWfSulqqQtNxzWMJBTNZRPoA0EveSzeGwOzP7qnGf2W3nnx
         roAdIABfuKQSJfETVaajvd+cGlJYdHDNgF+HUDnwGVdgsSH5+6V9Bohgvf0tzTwiUN5T
         rffg==
X-Gm-Message-State: AOJu0YxuTKhO4gQonu1HBWf2BFBqT5BLrB5XQOV7ArYO5ABx2zfF9Hr1
	oH81LnWoDht6WcAHDI9UP6VFHrD1zfS3S+pnCGB0T9bVn6jTudELNOHmQErxHQ==
X-Gm-Gg: AeBDieviLgCBmqtLei/7GXffIRmnNE8YHg3HMfUTwRsbsKNs/aEfmRNiSLQiJeeb4Pb
	IrQYLbewVP/ZYuiKV4q26EayxdT1YUaYNv3zVdwJoqZCXsEarMRESUAtlvLHuq0qHF/ETwCOsrI
	1pYQI9XS4dlfl6zxS2QjhPoyICBxASQBHiaLncEA4n64DD93EbksR7CiOkbAICy9nPV1qe+/Y0G
	FPKyXc5Fx8hwGcieJyOEL4oY+M3gBGHF9dpQvRgtxE5VPQUj+b6KJwffE1bnkv9djLU4dTF1ziE
	rJDpVGCAd+mJo1WvbEHQd18uQlsl21m1B9CDopz50Cf1fPTsUhBJW4HrsW59qNFcYNRZ4WO5oRG
	6EzlwVxNDWmcjRq4jDCwAJs4uR29bVqqQExMjtfb3gzlzVKI1xggBzMOJULgMSvlnqA03v3eUzn
	uU97Dw8NJpZF94nRiYY45oCjH3GHJpjKaIwFYQm8SvTewIlJxtY0g+azwCZJD1HgP5PFhNzLf6I
	nRrgggX16ZiD6bhiBsYmSvmRpwiZ63CNqFmMbirVb8nYhLqRr7f1m6pf0YQNdy2hTs5pQzfBcjl
	hDe78bE5kBhj6MvuMWZ1mG5LTqA/MoOUZ3HxVfMksYyZ81AxpAqd5g==
X-Received: by 2002:a05:600c:a411:b0:488:b14f:b8ed with SMTP id 5b1f17b1804b1-48a980fc5d0mr28642655e9.0.1777716762908;
        Sat, 02 May 2026 03:12:42 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00eecfd87cb979cbdb.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:eecf:d87c:b979:cbdb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a8eb75fe8sm119275875e9.8.2026.05.02.03.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2026 03:12:41 -0700 (PDT)
Date: Sat, 2 May 2026 12:12:40 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Subject: [PATCH bpf] tools/headers: Regenerate stddef.h to fix BPF selftests
Message-ID: <8da8ef16055aa452d940668ed5359ce54adc6b0b.1777715500.git.paul.chaignon@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

With commit dacbfc167808 ("crypto: af_alg - Annotate struct af_alg_iv
with __counted_by"), two selftests, test_tag and crypto_sanity, now
indirectly rely on the __counted_by macro. On systems with commit
dacbfc167808 in the installed UAPI headers, the selftests build fails
with:

  In file included from tools/testing/selftests/bpf/prog_tests/crypto_sanity.c:7:
  /usr/include/linux/if_alg.h:45:22: error: expected ‘:’, ‘,’, ‘;’, ‘}’ or ‘__attribute__’ before ‘__counted_by’
     45 |         __u8    iv[] __counted_by(ivlen);
        |                      ^~~~~~~~~~~~

This patch fixes it by regenerating stddef.h in tools/include using the
instructions from commit a778f5d46b62 ("tools/headers: Pull in stddef.h
to uapi to fix BPF selftests build in CI").

Fixes: dacbfc167808 ("crypto: af_alg - Annotate struct af_alg_iv with __counted_by")
Signed-off-by: Paul Chaignon <paul.chaignon@gmail.com>
---
I'm a bit unsure if this should go to bpf or bpf-next, but it currently
applies cleanly to both.

 tools/include/uapi/linux/stddef.h | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/tools/include/uapi/linux/stddef.h b/tools/include/uapi/linux/stddef.h
index c53cde425406..457498259494 100644
--- a/tools/include/uapi/linux/stddef.h
+++ b/tools/include/uapi/linux/stddef.h
@@ -3,7 +3,6 @@
 #define _LINUX_STDDEF_H
 
 
-
 #ifndef __always_inline
 #define __always_inline __inline__
 #endif
@@ -36,6 +35,11 @@
 		struct __struct_group_tag(TAG) { MEMBERS } ATTRS NAME; \
 	} ATTRS
 
+#ifdef __cplusplus
+/* sizeof(struct{}) is 1 in C++, not 0, can't use C version of the macro. */
+#define __DECLARE_FLEX_ARRAY(T, member)	\
+	T member[0]
+#else
 /**
  * __DECLARE_FLEX_ARRAY() - Declare a flexible array usable in a union
  *
@@ -52,3 +56,23 @@
 		TYPE NAME[]; \
 	}
 #endif
+
+#ifndef __counted_by
+#define __counted_by(m)
+#endif
+
+#ifndef __counted_by_le
+#define __counted_by_le(m)
+#endif
+
+#ifndef __counted_by_be
+#define __counted_by_be(m)
+#endif
+
+#ifndef __counted_by_ptr
+#define __counted_by_ptr(m)
+#endif
+
+#define __kernel_nonstring
+
+#endif /* _LINUX_STDDEF_H */
-- 
2.43.0

