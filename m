Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795708385;
	b=p6VEKm7E08aM9KoQly+BlqWgKy2ld9sxO+CVjd+vm3e3DFEKkEU+FA4twrX67zc9Ixl+
	 ALggJhDBQOCw661bEvLplQMO74BHWDrVWlIY4upr4MmixnONYLFgoKX0gktmV0pjelljg
	 lVD9MjVumJ9srxkRC2w1v9cc4zGD3dIsuQunL+DWjLtMf9VOaRns+JXACBrDYFnJTqbcQ
	 vKUqID9S5HgmjAIafL0mtHi8WUJEMb5GpJYWF9+2M+j5+hlkL6czyj4LMcveFSFT2/BAC
	 87Iu9VltuN7U3tDOLI9L9jiwbi/EFAckfE2Kexg19Q5lVcTdurNfUCrJmqCKYYNvswg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795708385;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=329C+ObflaGrYeJM1Uot0DWEfxpJGTZhLlPmSd8KCDM=;
	b=0bd4lSBJGbVwluC27/omTy4HGCl01OOjT/DT6ah/4T2nI+NZRyXUaAQyvSzuM5Elqp2i
	 /Gp/l1m2LbTto0JCo56PnX6q5PAimZW39TRyxYT1pWVG+4+RAWkCTmVdBPEkKzYeXQP4A
	 xnU7IJXXwBMFu0XN8sRD8BLLLgM61CRnNEMLYD9pdhQaesV9tMK5aUw4kIFBxFVUAOG35
	 mvoI/ms/ZBY1y54AdnSMWNd2ZBin/o8XKQCseceNvEm7oelhJYXx1LliLjC9fhiAaNpVA
	 nl5gZnIVoWanzb8Cwa7OuUg3mbgemzXusIW5pwqPogR22AUlLf70RcSrDmY7OhIhxHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="t/SoC3jt";
	arc=none smtp.remote-ip=209.85.221.181
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A93606A321
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 15:53:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 60A93606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t/SoC3jt
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-5eaa5e03c47so6543496e0c.0
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 07:53:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795708383; x=1796313183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=329C+ObflaGrYeJM1Uot0DWEfxpJGTZhLlPmSd8KCDM=;
        b=t/SoC3jtV0KvwF2cmafxNEx4F2ggLj2qXY3egSMHdzhxt++JfUQfyqDJLDX+QatAXR
         VokmzVoEZ99HAYo/6XJrFB6g5YLfAJFwZihbIFaTldkYC789NDHY075SS4xVFslGfo5z
         uzbBbPA2Er4hKhEoNP5yV8HAKjlW4wZ0bztSOc3mKI1FjX+tc8ONsx/rsDIK+6ShBijf
         Z+YDrPn4GaXlH7JUHqTj9WA8qFeSidUaigVHPZprnxesObG5P1+BTBwiwtcxR4D2/KRZ
         sSAqJO8KJW1X5p+0R+j/yC7Fxrnb/c+/tQlpDtQqvu73lnDHfNAHrJLQffl9lJ8dSlPH
         HJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795708383; x=1796313183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=329C+ObflaGrYeJM1Uot0DWEfxpJGTZhLlPmSd8KCDM=;
        b=HnnaKOiPLMGE0BDP7BCOa1Dp7Jhl1rW/ZB+v7/s5vbvBZjNoih/cct6t2yiJvde8Yy
         3YbIcP6K5catEx6ScrLIxSRoAEvG5Clt9LrlfedlwEfPOL3F/1MFDuQmlvIyhmNaxd//
         3+vkTvAoZSYjrzkoqhnr0wUqP7I1K04EoYMkVRLF+T4QK5HVTCi7655KNVOQfC/jhrhQ
         QIyswmV0NcA1yosHbKsd54UdD/SL6B/UEaM5tqrYwUJgjGbv8MC7ISR9RlKEWbY5ysed
         rLFVIHvTA+aPqaEYHTfhOeCqOBv/e9NTsu/Dik7UpzygDqU8pkB8UOPmNBSalrjiX8td
         OLOg==
X-Forwarded-Encrypted: i=1; AL+hErFWEiFhE479CCnUvY2euLj2OIBznUSoQR0ZxPFaZV+M+4PeAaLw1a/9Q6Jgvsuf0S5cGfI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9juqEa975c+HapFedsZJOJQVCDAw9Kpt2QF+CadeawY0Iyxj/Q
	GA0pvxSRshwRi12D3VZt+ZBPZRuK1Va97GLfGq6NlHwLdzTk6R4OsZ+l
X-Gm-Gg: AZFdTZfTEj5Q0xxLE7sVR38iNWIJcK/oU/VPSFgTOATfQNB8iup7sfFzwIhFZpkkqT8
	fa56JETIRYIzu/jN4bqiLYPQ/D3/L+HBDv7YkZ8xQUSL8M6PI77scd97Z+lFa61mp9BtDIWZopT
	X+Fc4N/jth+7A+b1U2we5mvMkua9Z6IbaxRVWv83aW+RT9O13Ppfz7YH0FiAJLAOG94SXVPoKXb
	qqNGjDxfaqDXQkZHSEwPQJklT1P4V1PuzVTeRPF1TKaHI+hvzmsEEM8EOEmnBihm5pF3nPpGIX5
	oZQnauD6H429pS42NW5958LPtcesryqP+NjA7Lp/s9+GmIns1ncxTTbv2BWFWqTMPBUqHFEKr4F
	pvhYnp7dAJA4yGuCuTg7ZaXZKoQbF9FuRG9TzSQ8uZuYtmBnTjpU6zrIHiwDt/Esci/SnuSagL8
	4WpAraIaL9Wf6kzTLMKHMn+VVHQhHr2QK4aYw0hOue/N2ImXcVw2mv/AirSMUxl5fMCwf/bFlZI
	e77/d3AZAli0VfnNZLQ3eCWOU7E2ONR9N6OOqg0ElgxxuNUpUWAjpSnVNtpQ8q5rNjtl+QMBhY2
	T/kBWddCCHtzHcomhtzR8FhoQYUPVLDX01We5nebuv5MRojB0nbJm4Fc6EZuwBszHQkv6MJBAOC
	GYGx6TSWT5q+DTqiXg5iLNA==
X-Received: by 2002:a05:6123:4204:10b0:5ea:bc01:a2f9 with SMTP id 71dfb90a1353d-5ee81fe07f8mr7007269e0c.0.1795708383219;
        Thu, 26 Nov 2026 07:53:03 -0800 (PST)
Received: from localhost.localdomain ([207.174.22.68])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee8b5bb61asm20980341e0c.10.2026.11.26.07.52.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 26 Nov 2026 07:53:03 -0800 (PST)
From: Yingke Xiao <inkxiao12@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	bpf@vger.kernel.org,
	Yingke Xiao <inkxiao12@gmail.com>
Subject: [PATCH 6.6.y] bpf: Drop inet_conn_established from lsm sleepable hooks
Date: Thu, 26 Nov 2026 23:52:48 +0800
Message-ID: <20261126155248.56002-1-inkxiao12@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <2026112616-garden-overfeed-1512@gregkh>
References: <2026112616-garden-overfeed-1512@gregkh>
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

The backport of upstream commit beaf0e96b1da ("bpf: Drop task_to_inode and
inet_conn_established from lsm sleepable hooks") to linux-6.6.y (commit
26b380a3ca0b) removed only bpf_lsm_task_to_inode from
sleepable_lsm_hooks.

bpf_lsm_inet_conn_established is still listed in sleepable_lsm_hooks in
kernel/bpf/bpf_lsm.c, even though security_inet_conn_established() is
called from softirq context in tcp_finish_connect() (net/ipv4/tcp_input.c)
and cannot be used by sleepable LSM programs (CVE-2026-63865).

Remove bpf_lsm_inet_conn_established from sleepable_lsm_hooks to complete
the backport on linux-6.6.y.

Fixes: 26b380a3ca0b ("bpf: Drop task_to_inode and inet_conn_established from lsm sleepable hooks")
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
Tested on linux-6.6.y (v6.6.163, x86_64 QEMU with CONFIG_BPF_LSM=y,
CONFIG_DEBUG_INFO_BTF=y, CONFIG_SECURITY_NETWORK=y):
- Pre-patch: BPF_PROG_LOAD for SEC("lsm.s/inet_conn_established") with
  BPF_F_SLEEPABLE (calling bpf_copy_from_user) succeeded (prog_fd >= 0).
- Post-patch: BPF_PROG_LOAD rejected with -EINVAL
  ("bpf_lsm_inet_conn_established is not sleepable").

 kernel/bpf/bpf_lsm.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 790451337..411622162 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -305,10 +305,6 @@ BTF_ID(func, bpf_lsm_file_lock)
 BTF_ID(func, bpf_lsm_file_open)
 BTF_ID(func, bpf_lsm_file_receive)
 
-#ifdef CONFIG_SECURITY_NETWORK
-BTF_ID(func, bpf_lsm_inet_conn_established)
-#endif /* CONFIG_SECURITY_NETWORK */
-
 BTF_ID(func, bpf_lsm_inode_create)
 BTF_ID(func, bpf_lsm_inode_free_security)
 BTF_ID(func, bpf_lsm_inode_getattr)
-- 
2.25.1

