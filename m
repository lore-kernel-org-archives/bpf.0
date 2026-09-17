Received: from mail-oo2-f13.google.com (mail-oo2-f13.google.com [74.125.231.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE594EB85E
	for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 20:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789675577; cv=none; b=PEnR/Q+4u5zGHOV0CWJKcWbmSpddwvOfMnuYEMC6mIYpe6PYOWMp5q0iV8vAj3hjL4x6IGv6OHCHE0XnKXMKicfWOsnkHzsIyCHl6U5lgy+YScBFA8zKH1OGEU6Rabqze8D7sMSfjribraSInYvd+5vaEBvVnJLcKSLgKFjIPFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789675577; c=relaxed/simple;
	bh=KWV6aWQYmH4deDnVX82coMiZxImTQreqd6fjSuI1h10=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tccyz5x7TmuhgiqGyp7CIqV9tLxOLjef9UEpIv/5SbqCm4EtTzOf+NQzuy7n+uyga9sgwCXROAC0sewbFUoOkJDzYKMX5MGSRVVtMW6upFm42WKcUSlUgkqLJcggQp9bvP3yhPXGGJv447DJc/xEwok+rIA/0DL/myfkPZaMZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iPJC6Ysv; arc=none smtp.client-ip=74.125.231.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iPJC6Ysv"
Received: by mail-oo2-f13.google.com with SMTP id 006d021491bc7-6b1ae7089c0so8035eaf.0
        for <bpf@vger.kernel.org>; Thu, 17 Sep 2026 13:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789675567; x=1790280367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9OLuSfUhJFvayd43S3ln5vAMWoBx4ysBdw/1W1WxYpU=;
        b=iPJC6YsvlxiCl4gTV0RpIFPlgccU/0sTFOa+aDPuHUPBkTopw/MfjHSnuySxpxWUTf
         h1vN/4tAevEmr3PrdonJgRW8EnnZaFnn+38A85fTz1qIwjPyePVkF/04zTo7WXXrxI7h
         cS1gQxRk/W0kUg2fkERPKhRXb9t9yNqvykhOjqN303ltei9v0lTR+LcJgzOcfowvt1uJ
         by0pY6SETKOzHwbvDJ9Yo2DYDbZ5EhS7RyDXxhC6xm8/ErFwQcFM9JcTGtbRsJTlgqCf
         kVvGut+OGf87aHlih9PZyc6+ZXidS+7+6Zg8v7ZJSNSYHeJY1CNtaL6kBZ26h4+uEegf
         iM/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789675567; x=1790280367;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9OLuSfUhJFvayd43S3ln5vAMWoBx4ysBdw/1W1WxYpU=;
        b=P4whR7HFfqUAqHgu/HobhsxW9/1goOZ+nbMszIIOfEEZ1hS6z4H/CdG51/84HvpEff
         gn6OfT35y7ieS5XkKZxV4QU1/7PZaWc23/hylXa4x0KKxDXNCdZqNQVcWHif/DppdoaS
         3VMvuuIrQEEfUC4k4eMSPOoxYf2JMhzEicMNz4g2HaxmPmWmSbZxpwqIx0+dq8wESJUP
         VPLYVHocFsLmOJHgH6570JgiSlX3+xdJNryJMngYrWg/DmAeFE1E8/RZLU0t2YUu1JkH
         gMe5Ccwd0R0EZJ4iHcizgXt53lG14c3rrx3hjS2YtpDb+mAuhC+YKvbZO2TU0E1jkwLh
         GuRg==
X-Gm-Message-State: AFuF++lhGn5rndihQErBVIyRHpJgCCx4AQGnjzRrKZ97mpaxQDyjJXfJ
	cw7lSiN45CCBwTYbln6TMUV/d1QCopg/OVrQbzJpaH4frcwPFdjCXGMk+y0jDQ==
X-Gm-Gg: AYBFou2IXJCNEEsbomh5y3qcCITOWGXKCQLtq35KdliPZK1qRIsBJ9th1+cne8+y8h1
	Dkik2Ynzv8RT5aRKH8tRTJt65nL6M4RBhVQSeDrxQgrnKwu9p4tENiZZ56IEhED9D7VyXM37oJ8
	grSvs0Iq2E/2shZQ6L43XZ6ANzzSdv6vluuNB3GaW0aCa9I/GE4l+1UP2ki8a0rSvN6xKDleHsb
	MelIY9AJMMsOrovdK4HwAQ0TatrUWOS8fhLU04Uo9gB6QV7CTN0TLVemqkixD8VHWag3ZRxKvbF
	C7/mPStOpCOMwlGUCfVBhac0XATMbguR1D+QuvnIZvfYBslQKw3NjAQd6fqHCx6hLRS+f0QcaVR
	NTbf6V6Rj39P9lYceHfVc5OW+nhigLIJ6Nuj2iIed0UQUTabWfopAIKol5h7Yd1kt5hLWjRTh4c
	vg3dJmH8gvzcIVnCNa/mEbx0fQV5bdGeXYe7knOtUvJFEb39XDzfMCCuQa60cvjA==
X-Received: by 2002:a05:6820:4c15:b0:6c8:dccc:eb1d with SMTP id 006d021491bc7-6ca9cb58461mr89553eaf.55.1789675567532;
        Thu, 17 Sep 2026 13:06:07 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:53::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c8f727fe99sm3378877eaf.12.2026.09.17.13.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:06:06 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 10/15] bpf: Allow all struct_ops to use bpf_dynptr_from_skb()
Date: Thu, 17 Sep 2026 13:05:36 -0700
Message-ID: <20260917200542.3689605-11-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260917200542.3689605-1-ameryhung@gmail.com>
References: <20260917200542.3689605-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_dynptr_from_skb() was only made available to bpf_qdisc, so far the
only struct_ops type that needs to read an skb. The upcoming bpf_tcp_ops
header-option hooks (parse_hdr/write_hdr_opt) also want to access the TCP
options of an skb through a dynptr.

All struct_ops programs share BPF_PROG_TYPE_STRUCT_OPS, so register
bpf_kfunc_set_skb (which holds bpf_dynptr_from_skb) for that program type
once, instead of per struct_ops. This makes bpf_dynptr_from_skb()
available to bpf_tcp_ops and any future struct_ops.

With the kfunc now provided to all of struct_ops, the bpf_qdisc-specific
registration becomes redundant and is dropped: bpf_qdisc_kfunc_filter()
only constrains kfuncs listed in qdisc_kfunc_ids, so removing
bpf_dynptr_from_skb from that set (and from qdisc_common_kfunc_set) lets
it fall through the filter unchanged, and bpf_qdisc keeps access via the
generic struct_ops registration.

Widening the registration is safe: a struct_ops that does not receive an
skb in its context has nothing to pass to the helper.

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/core/filter.c     | 1 +
 net/sched/bpf_qdisc.c | 2 --
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 61940e753552..47b7a8f73069 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12887,6 +12887,7 @@ static int __init bpf_kfunc_init(void)
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_LWT_SEG6LOCAL, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_NETFILTER, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_TRACING, &bpf_kfunc_set_skb);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS, &bpf_kfunc_set_skb);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &bpf_kfunc_set_skb_meta);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &bpf_kfunc_set_skb_meta);
 	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &bpf_kfunc_set_xdp);
diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 098ca02aed89..5691c13781a8 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -280,7 +280,6 @@ BTF_KFUNCS_START(qdisc_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_skb_get_hash)
 BTF_ID_FLAGS(func, bpf_kfree_skb, KF_RELEASE)
 BTF_ID_FLAGS(func, bpf_qdisc_skb_drop, KF_RELEASE)
-BTF_ID_FLAGS(func, bpf_dynptr_from_skb)
 BTF_ID_FLAGS(func, bpf_qdisc_watchdog_schedule)
 BTF_ID_FLAGS(func, bpf_qdisc_init_prologue)
 BTF_ID_FLAGS(func, bpf_qdisc_reset_destroy_epilogue)
@@ -290,7 +289,6 @@ BTF_KFUNCS_END(qdisc_kfunc_ids)
 BTF_SET_START(qdisc_common_kfunc_set)
 BTF_ID(func, bpf_skb_get_hash)
 BTF_ID(func, bpf_kfree_skb)
-BTF_ID(func, bpf_dynptr_from_skb)
 BTF_SET_END(qdisc_common_kfunc_set)
 
 BTF_SET_START(qdisc_enqueue_kfunc_set)
-- 
2.52.0

