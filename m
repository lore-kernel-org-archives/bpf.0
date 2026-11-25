Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795577489;
	b=mQUhi8bXqkRbiLhcrZ7STTwmc2C3u+6VZpO+qb74+HwOwXjMJ/6YyftXLeEarjoW0eAA
	 T0m0d3Od7s6VxHgnjLcWHVRyI+UEZyllxg9mwccox8Ca95sMz479Zsybm1am8IJwGPtGa
	 BkNteYyUPlI/B1BfEP5Cc7EOKodMGV0tm7dcKgq5CqktgM7ES5VBSlPjkoWoI1r2ft2WO
	 +k7olsQ1sjoi3iKIloUL5Du0jVVKyVR8qm5Bqnu0d6yg8oNm3CdNbhRazMuCyOmkXVIaq
	 pC/c1ixfODEHbFG3clPkeHOJC5D5aiTWik0it8hAlr5+F339MWMQFVlDtvNMQoFaQmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795577489;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CqDRc6IQt2Ns26Py0QuyVdnOJBluI9tYj2VYEdLYTYs=;
	b=twtyLac5tTsLtNP+7dg+sID8MsvXHYHe0dzUsYicdZgYu+eZsd9ug3c2yjpEvf9UZMAN
	 EQ3dfx3NjjPQbuElp6Kam+xM9FoxV6IDSpZwiWougJVBeT4GRboa53a/iuAoGzRSGLVo5
	 TGM6LVrUHHv+admr3yM2E7RR7AHhvETgxsTHgtspZiUMXWy+ixL1O/4OweNKcqfApIYj5
	 iuUCCKxr7I8Q/f1jN0x83n4CXmPcGnwbaQGE8WuA062bZu8Id55WnDKbvtrw/xDQSa3Le
	 1tZEbluiNgIE2z0yoF5iA1w/kprZpnVDLBlBhtX+vw9DzeXooIBmvVfymwh9eorUDVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n6smQ4i1;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D314606A323
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 03:31:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D314606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=n6smQ4i1
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso2788327a91.2
        for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 19:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795577489; x=1796182289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CqDRc6IQt2Ns26Py0QuyVdnOJBluI9tYj2VYEdLYTYs=;
        b=n6smQ4i1WsRrftbUYlmlyBK8jJ4sCcLslIb0wU27mmcUHp0D0E0w682LYGA4byBi8H
         w1nNSGLzQoAS1VHorbzk/G0yO6EWFLSn0sc06Q5YQnjbVDC819fqEmst8RdldR7cxnnN
         CeD0zfuStTjs/NqiOxNU6mmWpXiQMFkfn+RiIMOVzRpc06Sy72WQuRPdcqs/fQ7KJepY
         i6HM3aj/OFcRyn8cqKTqPk0zZOzilnltyLNy4CDhbuwvouvuQuGRh1w19OeRx6oej94y
         r1aSnPVnBAl3j9AnKlY5GmTnqsLwiu0ioP7VmUwCYeBO+O6hNATKvZW0LL8FgiRRV1Ai
         wS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795577489; x=1796182289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CqDRc6IQt2Ns26Py0QuyVdnOJBluI9tYj2VYEdLYTYs=;
        b=sFEhq/9S21J4JxaRdBBNnWt/SPWzUZGMzdtcFnkelIxz7XFehvv+UQ4X1HptnzO47T
         uJx37dIi7/YuZ5oExof0Ruh+7BvnDPr6Jp9aDqVfILCHYp73B6r29VhKPlzLQAB+gDsi
         xvDzlzL4mJB6Pl42BUkjj10bT3fxu9gvr1+Ra5VnPuXD6if5HfL0I7HxSFBe7mrEC8Zn
         AUbxMLHnpnAJ/9sevlYDjbPrjJcElKLLNsH7QmXI6lAxACe/YAjtuLB7z5hYhtUvTXMI
         xFiq2m0Uk+oyZMr9MQBBO8TSl24oqRfT+TNwt5G7M5PU6QEMOxFW8ZXJKFVgIURPMj6L
         Oi+g==
X-Gm-Message-State: APuU4Z/MsQHOaxDL5hxCIKBB1lTE2oHlarWP0AWT8/zmPIshPO6JFxQw
	YimWvzGll5D94xzM/7rxa2fXSHd9qOK2v0e30NPJ2IJZZC5KJT6bkkltLrHKJY2T
X-Gm-Gg: AZFdTZdn6epPCfjbCUzgMnO/A25LPEHV8LY9rlCkv/UY5HLmivTA7x7ET8gUe8j7rJA
	YHT5kpPTZcLN8gBcsN6YeuS3EpZJJSw8eLDO+HGO95yNI0IxPRkZpgt2DUuo7iTWSK+UaeZi/X7
	XwdWyW8GmGsJ8A3PWUuQjRPt/PBeAheqavAsYgodceQe4eS0Ja0oTQZyz4UINKoxVBoRodCxgXI
	2OIkICHZ/L6znxMW5b5Tk+iTbnkVBUAvwe6UBNmJq5zw0CwVPzeaYZ7gXPrDWR46PGecFEd6msx
	mbzyT5KdhuSlf+cND+8yF4zmdWvwPGSbV+M90lzeCu/LQL6yfUYWUGsFbPYylnnIIs+w3J9YDK4
	TX6hQiPcl++4dHbg0faP/8jCD5+Zgk2IdM9rROOMufVec4G9ErhBaLWHNtk+13zMoEKC7Hw127C
	ZqEP3fkN1ezykLRC/HO2M1REpH7KkLNlsRmjSW79Vit+R+b+DZZ6XgJNKXC33axrQfoEI7UFtNl
	pVEooOem+ISAzEQW/RzjfokG4kEPWUIM8KQwZGMxFtJxmcRF3yzdZxZtx/lHVI2Tz/LrhcDpAbD
	Gn32NS/6EPBaKGoAX1M4sjdeya/DPzwx63LGPoUgY5Z2UqEsTK6MKDocH9gqQfX1vnVxMUbXApH
	gqc32TaDNnZChT8Ph/XHqndK9JMz676aUnj4dWiQNxX32uIAmypCUNKE98Ocu2D8xvFzpIgWPw7
	s=
X-Received: by 2002:a17:90b:2803:b0:3ac:ad90:7090 with SMTP id 98e67ed59e1d1-3b41c9830c4mr15072498a91.67.1795577488340;
        Tue, 24 Nov 2026 19:31:28 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.253])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm25121922a91.4.2026.11.24.19.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2026 19:31:28 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Subject: [PATCH bpf 18/47] bpf: Refuse metadata maps of signed programs that can be mapped writable
Date: Wed, 25 Nov 2026 03:29:09 +0000
Message-ID: <20261125032938.670542-19-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
References: <20261125032938.670542-1-alexei.starovoitov@gmail.com>
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

The signature of a program covers the value of its metadata maps. It
holds because they are frozen and exclusive. The freeze is not final for
an array that user space was allowed to map for writing, which is why
bpf_map_mmap() refuses that for read-only maps. A loader writes to its
map, so it's not one of those.

Refuse a map that has BPF_F_MMAPABLE without BPF_F_RDONLY_PROG. Light
skeletons do not set it.

Fixes: b707068e0ed9 ("bpf: Verify signed loader metadata at load time")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 Documentation/bpf/signing.rst | 3 ++-
 kernel/bpf/verifier.c         | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/signing.rst b/Documentation/bpf/signing.rst
index 27fdad3df96f..db48965cea64 100644
--- a/Documentation/bpf/signing.rst
+++ b/Documentation/bpf/signing.rst
@@ -141,7 +141,8 @@ reuses the existing ``fd_array``:
    ``excl_prog_sha``) and a plain array map (``BPF_MAP_TYPE_ARRAY``); only an
    array map exposes its value buffer through ``map_direct_value_addr()`` as a
    kernel address spanning ``value_size`` bytes. A map that is not exclusive, not
-   frozen, or not a plain array is rejected, with a verifier log message naming
+   frozen, not a plain array, or that user space could map for writing
+   (``BPF_F_MMAPABLE``) is rejected, with a verifier log message naming
    the offending map. The kernel appends each map's frozen
    contents to the instruction buffer and verifies the PKCS#7 signature over the
    concatenation ``insns || metadata_0 || metadata_1 || ...`` in ``used_maps``
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 4cc9a210cb25..76a50cc2138b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23850,6 +23850,13 @@ static int bpf_prog_verify_signature(struct bpf_verifier_env *env,
 			err = -EPERM;
 			goto out;
 		}
+		/* The freeze is not final for it, see bpf_map_mmap() */
+		if ((map->map_flags & BPF_F_MMAPABLE) && !(map->map_flags & BPF_F_RDONLY_PROG)) {
+			verbose(env, "signed program metadata map '%s' must not be mmapable\n",
+				map->name);
+			err = -EPERM;
+			goto out;
+		}
 		data_sz += map->value_size;
 	}
 	if (bpf_dynptr_check_size(data_sz)) {
-- 
2.55.0

