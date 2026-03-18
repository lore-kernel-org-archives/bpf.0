Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29CD42E5B27
	for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 22:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773872437; cv=none; b=BJ3olHmpoQQKlci9987ngSgM9SqUVXpqAsK2UYugvr4ZIXpnsimBxhIKifZGsQAbg0MmLPXgNKV28LJYg0/JiLG7Hf0DscV1YjyqmX1RyfxTSEkI81YW/wQvgPq/p5sPMJX55Hu3rqOslxyUAMLuM7oC91CrQxEsS669XM8D/A0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773872437; c=relaxed/simple;
	bh=6Kd6i+pBySTqpFxx4+L9ACFwiMgIqLCdG6lXWM1tFNU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G/bwFp7ejrDTANmmOzloM311e9xr7GlfseCRcJp9vBA/jreRw22hs4NsE8g+mh0n/0UC6wS7RpT+uArRe+JD3VRipFt+iLnkkc85TZeIWzYSNVU9/ApEsA5f3lNkNTg1sS2mVq9wfmjtgU18315rz8pjvGcPpMs0+5J1gtwiu5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i6hUX4sD; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i6hUX4sD"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-38a3066b68bso3139311fa.3
        for <bpf@vger.kernel.org>; Wed, 18 Mar 2026 15:20:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773872434; x=1774477234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zl7bHE8rz1hYj5X1Jmrw1LkoLqQWm8JiEcPKy45TQvQ=;
        b=i6hUX4sD07wkzAqXBoZYXtFkttqyk3AC18v9dcGPKxzPObkqfOKOuQ26pGOm7sHjyx
         sfy3ScJea7r52vWCbMJh3WemYGrRA3S3/+J9UG6sPXR/DYnLsZHwkdJPLUsaZu07k8UC
         TLp0obhgLbHFII5+aVXfIVk90H9CXob7mCvkP0cai7n+o7197xhUb9jWnx4F3VAsGB0x
         t0u1mkcs2fwnZV+LivYcZ7vYYvVzyJvwCsVuJFv85Bg28Ly87k1JkLgW9skylB8LoLa1
         ybxTMkFHs3norG0QCkmtWgl05ttDrwOwtV1QbmifJGsJ49FJhChUTpSalUzlyXNl12UD
         u9Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773872434; x=1774477234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zl7bHE8rz1hYj5X1Jmrw1LkoLqQWm8JiEcPKy45TQvQ=;
        b=r4XATA7TUzAPAsjMziCvyzFfCLbFU+ynKn0HIOIkT6+1W/txh/Cn3h0zi3JPhSaneI
         ixJh1zD6vPbi681cQhNwatV1SQv2a/JAJ75zuOwzvWBBuNIunsziXK8Qv+WSYmd0DlPs
         cWJHnzsAHnteWX9s1knf8oflJgiNyouHNwEN2N2lsjjpmHBkVNpY36rS05/yBBoyXRWO
         19QtirorE1shFGvbyfrmyshITDs1pVXWThrw4ACog9zL0gr6Pk+btCV9c9oEtIBdhAdz
         sUGKQdbAClwHKaWto+0r+J7EnX6GegNGcJk4UkTUIIKDKxGwndIaHNQjbNqod24Tu/vC
         WqLA==
X-Forwarded-Encrypted: i=1; AJvYcCXsO4g5MV3yOlSSeriVrMq9KTrIZOFEzQL4+Aoq0S9ZPU9kql9tNoWACkU/8tfD0CgTxQM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4HC0FQ9KUSYAX2vXP6AenRvQH02T3g+DCBZKLKNu48QT2OMxL
	Fzc6zCJvE4+50yrq92LxFLp4tdyXPaNTJO94P9Nm1EkGXIIPescXWXvZUyBPYAs=
X-Gm-Gg: ATEYQzwI2flqcwo8NIhD8ipeVI3ifrpLuyUSd+958wlDS1oYVPCIRDjEiQJ9YxFxI7K
	cnHpBX+Xg9ayWgD5oIbWL3Iba+MG/OZYx7EdKOW0v+voeL4VM5kGzzpvrW2QTRFARkQYLrkOALI
	0kOhWNHHfHOGMivx4j7raxvOWEQXk2uow3iCAIKeZE9Wy3z8uwh0IhKGkyAAWnD+fVXHnoJrCqy
	5FBsb05JVn7KlBrUoaFWWdSj9VUzYuAPLHXzUU9wlUtBSFxacPFBNXLY5bFEBqHRr6v5RJ+p1Ad
	zfBpKE6OqnMeq2TB69yW9pdGKFTXk3vrigMWb23ZIdtzv5Hb2fu3QRI89Amu6u8kDU4PISjIDXC
	LOzC+sUGeUxBH/3hruZWpctEri1QBRZkFCGkdbsn7fHAFHWxhUijMTe2ONHHjoZqHKXDISbONvn
	cfHHlGqnY8Uq1bfg==
X-Received: by 2002:a2e:9bd8:0:b0:38a:4de2:85d7 with SMTP id 38308e7fff4ca-38bd57813f6mr15970391fa.3.1773872433951;
        Wed, 18 Mar 2026 15:20:33 -0700 (PDT)
Received: from jacks ([197.38.173.144])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38bd5488cbfsm8489331fa.26.2026.03.18.15.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 15:20:33 -0700 (PDT)
From: Ibrahim Zein <zeroxjacks@gmail.com>
X-Google-Original-From: Ibrahim Zein <ZeroXJacks@gmail.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	martin.lau@linux.dev,
	andrii@kernel.org,
	bpf@vger.kernel.org,
	Ibrahim Zein <zeroxjacks@gmail.com>
Subject: [PATCH] bpf: fix out-of-bounds write in bpf_bprintf_prepare with %pI4/%pI6
Date: Wed, 18 Mar 2026 18:20:13 -0400
Message-ID: <20260318222013.2009349-1-ZeroXJacks@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ibrahim Zein <zeroxjacks@gmail.com>

In bpf_bprintf_prepare(), the bounds check for %pI4 and %pI6 format
specifiers uses sizeof_cur_ip (4 for IPv4, 16 for IPv6), which is the
raw byte count of the IP address. However, snprintf() returns the
length of the formatted string, not the raw bytes. For IPv4 this can
be up to 15 characters ("255.255.255.255") and for IPv6 up to 39.

tmp_buf is then advanced by (err + 1) using the full string length,
which can push tmp_buf past tmp_buf_end. The next iteration's bounds
check underflows due to unsigned arithmetic and passes, allowing a
write past the end of the per-CPU bin_args buffer.

Fix this by checking against the maximum formatted string size instead
of the raw byte count: 16 bytes for IPv4 and 40 bytes for IPv6.

Signed-off-by: Ibrahim Zein <zeroxjacks@gmail.com>
---
--- a/kernel/bpf/helpers.c	2026-03-18 18:04:49.000000000 -0400
+++ b/kernel/bpf/helpers.c	2026-03-18 18:09:39.126681954 -0400
@@ -930,7 +930,7 @@
 				goto nocopy_fmt;
 
 			sizeof_cur_ip = (fmt[i] == '4') ? 4 : 16;
-			if (tmp_buf_end - tmp_buf < sizeof_cur_ip) {
+			if (tmp_buf_end - tmp_buf < (size_t)((fmt[i] == '4') ? 16 : 40)) {
 				err = -ENOSPC;
 				goto out;
 			}
--- a/kernel/bpf/helpers.c	2026-03-18 18:04:49.000000000 -0400
+++ b/kernel/bpf/helpers.c	2026-03-18 18:09:39.126681954 -0400
@@ -930,7 +930,7 @@
 				goto nocopy_fmt;
 
 			sizeof_cur_ip = (fmt[i] == '4') ? 4 : 16;
-			if (tmp_buf_end - tmp_buf < sizeof_cur_ip) {
+			if (tmp_buf_end - tmp_buf < (size_t)((fmt[i] == '4') ? 16 : 40)) {
 				err = -ENOSPC;
 				goto out;
 			}
