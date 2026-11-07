Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794071031;
	b=qrhwh3qILnuBTjiAFZjKFbUTTnr0RCuVFUggHXLbzjdOjstpbt53+HbaCR8GVyXcTgh8
	 vRomdrwdrZ1UTckBG6IoQUgT5Ov+kXqVIgL8sruT7C9AEpN9eEPA/KmroTK+oLxz1aMq+
	 t/b4YjfHwH0v0kuiuLydM22UZhyxrqO+KiDH1660JmZIfb1nkp8ilVNGt/znsFqMdDWit
	 ttxvNjgGeundH8UsI4EE4EPcHB5B/jw8RKSxAj7yh0s/ibaM5h8uEAbF2vgjlx+mLLsU5
	 XzhSZy1wO5MPPkH+vHewYD0q7d6tE4x7Tf8u1ytnMW5NMuVwLGCyP2KeRcSH8yg0YQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794071031;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=8WS576eCdE4W3OYOUuC8uitFLqIQHpoBJ+GUuWM9vA4=;
	b=aM7+SVJBfxn3XjKqjlpUfORbGdjggTUpjzfnyGk3L+JPRx84Ak5QftnE1N1C385c0Mwe
	 tjUhT9Cl2DDLOA/+1SST1QHTLc6j8cKw0+3ZYvmCJ/KqmSgEpcjrVn0944yLTUBqBxMDd
	 mIPGkVJGC2pGnqInIcDuVs39busOxGeUS9hzp8AHx6+Z9TpC1LKB8D1vKmpJqs+odcKy3
	 dqDhASCxU92vVKkgr1nJpcgVrvkSh1S/vjcjykFtkChMth4ddUfYD3Ol3S9H+lNnb415t
	 97ERJt2HBVv2Y8BKghgk4xcBI7CmghFxeKdnnpDfZZM+Gj8t+z1vAzE/2fpevW0M5ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vD4xb9eo;
	arc=none smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14960606A32D
	for <bpf@vger.kernel.org>; Sat,  7 Nov 2026 17:03:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14960606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vD4xb9eo
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8b29b83fdf1so647182b3a.2
        for <bpf@vger.kernel.org>; Sat, 07 Nov 2026 09:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794071030; x=1794675830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8WS576eCdE4W3OYOUuC8uitFLqIQHpoBJ+GUuWM9vA4=;
        b=vD4xb9eoGEniLa7o9nP8Stcc1lm7gZZdMN+SIu2Pp7lXmVBAhlUEfcSGZxsahRcEYN
         MGvgBRQgi0gFa7u5EHtVC0aCBDuOARw7JGtR/uKomEjfD912pWDYeJwx8WbcpqJMemwL
         gH+M/Ks3q/Jzm7XMeXL3voNTJadWRI/pLG+mXl09tGXTgOt3whUsMfkPn6ULWpxQ2Yj1
         xO2Ctf/Z1ck/EM+Ck0fMVwHvKfoCIOGbntkv/RUuIwiM9cRy14uNSUVTGXihyNBABdXR
         41Ydt2E9uUxK261niCZ93BWkmrJpprKzgEKwa1wkLddEH5nUQYhmjwVp+5PpqQErbON5
         ArVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794071030; x=1794675830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=8WS576eCdE4W3OYOUuC8uitFLqIQHpoBJ+GUuWM9vA4=;
        b=TR3HVxbM0xdMhBUW5IUJ4/Nf0MO4u5fzXYm+LzSDeu9tq08NZtp//IrvXFYqqI24ok
         aoVkSeoQPrNro/9DeBSBYu5TJiVLtjqgrNNOKuoMe+/p/3SSGPfDaAp/43tTCuNV1kqO
         ISb61Irvgg3kKeucGJ/idZVsH2hIT2ZICwujNSV34dqjGiwMeoHvj9jXQWOXUZxnGBNC
         lGH+J86iRnqyJxV5AjxRkqIJY8zqfIcg2xH4DeI5+AdHwDbPmfZJqqaweZ2EqUh70uVk
         G/WXQYqgzxMtLmC6GSyVz4stljPOB+FuLmtL43iAPuxx21iJjo81EbIux7XKe7OvpNzK
         vq4Q==
X-Gm-Message-State: APuU4Z/YuzoXL4+SLj6qYkACv2vXPXdQCJhAP8RsD6fLcaMVVQBkEp8/
	ap15MJeQOsH3UuYRaNqjHVD/mDXEA89ZRA+SyMj5zxKTKQPJsLEX0fX0e2MLzg==
X-Gm-Gg: AYBFou1A5M4lBaVlKse7pmuYhJhTjQkQUMUtDGgMLRKwPFndABfwpev0bzwWqGYyKGJ
	gIovxipmkKqZE6gCRGkxhjW2GfWHjeVuIDurPBfxpcK0Q1z+AAAGe+6Ep0E4CXuY+lLxFfK+B1e
	1m2MrkWhOSZSWjBjKxohjl7pyUwJ9YRSLYmXn7wZExXI43rj0vZ48WkvSVmqNMgXFZPSHX8mEr8
	Xab++80pQCw5pgrvxhYxJQhI3OTRI13N5kXtJZDtFnaHVn5nXXyi/xAvUXkrX3cbOwkGJ2/JAS1
	QX+6Y/1CdSN0fgd9ZU4v3Q/ITA4gFBhKvRFO4a8rQGDPiMiRAFVEkb2BnmNUuzFTuJfd7Kofoi1
	05e1qE6GmRcJIHwYZpbp1TAFlBgRiVDv3OYCT+d0/xmkxlDwA0DBPw6Lv88+OruqFl4JswA1atr
	Jq7e2pYejOPmO48vEabWO/7Ab+BVq4n0ktLyzmrIKwHeAIQ8TMStbgqFxkL/lpmE7v3CCj1Ghre
	DjuNNQ9DaoCB3RZU43jkDFFUZsHseKUviPYxLjTj8bFgehY9Iin2hnddanhe+rAAG4yKCDcUNgs
	B9N4JnPyyHg6adBGyvxUUh4lpIbawpNN7oJBA36skaktIFFvSKlRaIctSmq0S/UWbBxWRNS/GQZ
	W0HCqzj7M85Zj+EPEIiahXni1kC8iAHLBrGOFY9eibm5brRhb1f9OkMy6eA7ZnoAT4fjJ4XAZeg
	==
X-Received: by 2002:a17:902:d54f:b0:2e9:7dda:bfc7 with SMTP id d9443c01a7336-2ed40e05c74mr62206475ad.66.1794071030282;
        Sat, 07 Nov 2026 09:03:50 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.254])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d837fesm13279475ad.65.2026.11.07.09.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 09:03:49 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf-next 5/9] selftests/bpf: Expect GCC's first error in test_alloc_double_release
Date: Sat,  7 Nov 2026 17:03:02 +0000
Message-ID: <20261107170306.2831028-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
References: <20261107170306.2831028-1-alexei.starovoitov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

test_alloc_double_release has two errors: it releases the cpumask twice
and it does not check create_cpumask() for NULL. The test expects the
message for the first one:

  R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_

GCC gives the path with NULL its own copy of the two calls. The verifier
gets there first and says:

  Possibly NULL pointer passed to trusted R1

The prog is rejected with both compilers. Expect GCC's message with GCC.

Fixes: dd43eeaf99eb ("selftests/bpf: Adjust tests to new verdicts, messages and order")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 tools/testing/selftests/bpf/progs/cpumask_failure.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index 715218d32105..2a58209eb8be 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -45,7 +45,12 @@ int BPF_PROG(test_alloc_no_release, struct task_struct *task, u64 clone_flags)
 }
 
 SEC("tp_btf/task_newtask")
+#ifdef __clang__
 __failure __msg("R1 type=scalar expected=ptr_, trusted_ptr_, rcu_ptr_")
+#else
+/* no check for NULL either: in GCC's layout the verifier gets there first */
+__failure __msg("NULL pointer passed to trusted R1")
+#endif
 int BPF_PROG(test_alloc_double_release, struct task_struct *task, u64 clone_flags)
 {
 	struct bpf_cpumask *cpumask;
