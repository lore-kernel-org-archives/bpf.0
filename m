Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795077845;
	b=DWK6k+d33w+ygC7cyVMCEY1NzbSsv90vHVJfmgyskGnwyq54/GjOrovVQ0Nu1n4jggSD
	 ApGrMgSmEPIq8UdCxTdXBwPnWmPhRcY1C9DP/IaWCsPjxXcrFRtqBDSfDUhvoBARiDqJ5
	 JZT23hci0nyxs6bAvBRm5lpJp/ytso+Ge8SCsC7j4h2viJiZH1Ggeq8a/Mrclz8VPC65l
	 3K/nYWrS33MrKAW1uudBzMXnbla2gahPTirCQEclKsOMyPYvJhAtzbg+JEj2psYJWzib/
	 XYbbn1+mDY02WfMYoyefdI5ILzxUeN6euCZ0/5vxic1QTFMXfGEUKw0dHM50C9LhS+w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795077845;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=/A4ln7oWDupQv8wAGHpGQYZH4Kry63HuaRIfBmRJwfE=;
	b=0JpRcTheC3kfU/cMnuPRQoJpnZiKV3ybwvpVBUv9Eq/UoQ1D1Ki3lY/IbXlIgiJQhMKY
	 4Ja6XQTk6AlYsmFfvcmyQjfLLrBRH0M3I/kMIqaxsZbHzhBChilYV5cfzAoOwqu/0S3LB
	 /eMNxE3sGQsszfX/bM5Lb5SNjmQaY4HIYk6QKpN66ACviOGNBcip5sXkXZPX/TpBQw3xk
	 S2/q/b7ajAZMgo/ohFv2xABVaRphQQoEGtA2CBWBu5iq0amRtD9KAOTm41LyaQ88710Xl
	 Q5RuIuz8HYdQxRH32Bl3S79yjKJQvqnK/OVJAgWx9uUfUiy5AczrYIVXUlNAJf9SZ8Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qZSekRxy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.41
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFC8606A325
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 08:44:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDFC8606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qZSekRxy
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-92123588d53so7635736d6.1
        for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 00:44:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795077844; cv=none;
        d=google.com; s=arc-20260327;
        b=U4v5tcfY/TCh04+0uuhU13DT6P5/flhL6bpkdPpy5usBKwfqRLaLwr6gp4qCW4AfNr
         fqGFaqusZG7+7nj2SUdU6maV2Mbbp9az+KTYxVxbjMU4YfxhvqsSMAqzTdBMlZL0StTZ
         JAH8Ff+kw+p5uEWwfUb07SkXeszlRGK+WzMnI3QM/XnG2NaAA52TgfOw5hs2gYQCmqJD
         AVw0YQ2yM3kuVcmXUiwdPKTI2U8ChNTE9qHzr3bK6zrM7JLyGe61GtV0H93WlR3YtJKf
         fW9HvCxEeUEooLs95kDBvtSAIJJR5XFqQqNYXP+bMKPhjeKkfhXdi70VWFw8Yz73lmQ4
         7n7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=/A4ln7oWDupQv8wAGHpGQYZH4Kry63HuaRIfBmRJwfE=;
        fh=v/qBMU4wwadfiVHPQOJnoB8I8DXtsJMiG4gQ2sxzR1Q=;
        b=qbxhRSOpr4QkU7ghK8GxBrFQM89jFHo8T+XHr9UDr+D7foER5OvGkUg2YXEopuolL0
         MYJG8coEIUSU2GHbgrpS+lk4JQTugj3pXvKvKo2jV0cC6SnOQEZ9Wqfk+9TjU/65+WRI
         D1BAIl0SedIHqJ1WQ4L4Rlv4UCIx2PoryT3ungT2gGutNj/fP+fO6O97+VG3sI6FFGsR
         lztpi5s4qex83X3BVijuYx0lwpoRWWhexVoLN52KP67E3tXfYy1RTl7x0ZO2YqzRirj/
         xmGZKp1IWDiYpREtL2QBu7o0+4Gb99WLNwHj6TJSoKb9cYQwtXcRP/pLMPO9UhffZKr1
         r1Tw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795077844; x=1795682644; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/A4ln7oWDupQv8wAGHpGQYZH4Kry63HuaRIfBmRJwfE=;
        b=qZSekRxyGBWd9lIKqlMrhoek70YU55c2xT98Splbsv3LHovlnKXPggtQCo1YYVmJre
         kDLf2gkIOLxy2W1nro6L3L/8BdrrpMJvvJYSOzJDkwQmTjnRF43/+D83UyTTSMVM847R
         YY9y7yxGI+KMPKKNN5QFaSK05Rfi2IhtXnL+tDwVEDGRSjZUqb0uWow1vqUXn5XoL8Ru
         lvw3QBYejXH8ODZMSf+sRuSLjPSmJCptKgL8Jsq97/SX6IXW97jyYITU832HZvobEcT7
         OxnSaU3fXDp1CAY6X+wGDhESegyJAPAbB/9r8jjceZnL0nBn9leg1MjPKVacNdyEfBaS
         askw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795077844; x=1795682644;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=/A4ln7oWDupQv8wAGHpGQYZH4Kry63HuaRIfBmRJwfE=;
        b=gsa3+gcevheWsFKz5m/H0OCviXZa2SpTGE8XYHz5l7FBhqSL7jWaWm50jVUW6tZRKB
         A37mmOxJmhj5VhZML0+b5qegZJ2rgI1eFdoSexm4THOLkR2FSbjnm+usxXHEv8eTbete
         RETXx4qGFX/EVb2WhyqSlwQs8ZFD7QBemqP6EKHIc/f7S+66CUuOmOX+WLrE++MzGsyj
         GEhosGGKnEpWJHAb5d7I8rVyvbj+L/7UM+5xb037Cw6r6NZvZJejwEw9KGrI0C6Echcg
         jX5x9DwiqolZTmJcGZAMpqKPxCMy+hWbYehHxZOIBlAsH7Fxk9Q5Wd1vNVP0vdagZwfy
         oXlw==
X-Gm-Message-State: APuU4Z+rpInkdZ17Bdy4BTivCrZSUdskvpOsXytSAnVCz+KQhAQYf9L8
	EiqX0I60DH24bEEwpDpqXVS+5gc7ZBV7tkYGaVXX+xKX6wKLHbOkBsVdu7WV13ClbkglZNiPcQT
	fLolfO0soXksHCJ2eTeiLTsCDdi62CeJ34Axp4bKh33aM
X-Gm-Gg: AZFdTZfJ/6LDKdaO/HWVA6fO2/+igJS61H+9J7WIJBZSR9dp9She//LQ21yilkA/AQc
	Mw/SU0HeIBj6o8Z8dgcSpD1ScTrwCZoB3tB7QJ/3CDjVRKcDmh/l+dsHk9Cnmrf8cKrBVHx8yTT
	mzHBT0rtd5DOAb18cbUzR16V7y0TmPz2pmxqRaqMQUWzmDL9W5EzKSuj0hO8HXUjORGcjpxeehi
	nw6Nz7+Hv29qHOECMQhIliCsCNQ9o4o03Ed/y/yAof4g+heVKfVMel2QDafIhAJRadqE8ex9ru+
	si3P2rEorZ16Zfv7kyv9SO8LiuE1KFHTl+bFqaAPH/Yp3B1ZatMNZVQ+SjKc7+agYiXOzN4JHTd
	tOj73BTKDrc8TdD3I3Bix1RhpQWxCwFVSvDbj5jjKJL6P2PXPc/aekGG7lQGEs5IWJWIyq33Q3I
	+1gyFa2IU3oM3d2tAEIA==
X-Received: by 2002:a05:6214:27ed:b0:921:d0e:3980 with SMTP id
 6a1803df08f44-9212e09d4c6mr6709196d6.13.1795077843795; Thu, 19 Nov 2026
 00:44:03 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Yingke Xiao <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 03:43:52 -0500
X-Gm-Features: Aa3M54pzdVub43aRWcLLt_mpg_U50pT-PxWG6mqH_aYeoBXAOv6oz8O-dCuo7qY
Message-ID: <CAMcAce9MNLam=t_48M0jQDg36GghfAGs=jX7oAejKdUmdCqj4g@mail.gmail.com>
Subject: [PATCH bpf v3] bpf, lsm: Remove bpf_lsm_release_secctx from sleepable_lsm_hooks
To: bpf@vger.kernel.org
Cc: security@kernel.org, kpsingh@kernel.org, matt@bobrowski.net, 
	ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

security_release_secctx() invokes release_secctx LSM callbacks
(selinux_release_secctx() and apparmor_release_secctx()), which only
kfree(cp->context) and never sleep. Because the hook is non-blocking,
Netfilter callers legitimately invoke security_release_secctx() under
atomic, RCU, or softirq context:

  1. net/netfilter/nf_conntrack_standalone.c: ct_seq_start() acquires
     rcu_read_lock() and holds it across ct_seq_show() ->
     ct_show_secctx() -> security_release_secctx(&ctx) until ct_seq_stop().
  2. net/netfilter/nfnetlink_queue.c: nfqnl_enqueue_packet() runs under
     rcu_read_lock() in packet RX softirq and calls
     nfqnl_build_packet_message(), which allocates with GFP_ATOMIC and
     calls security_release_secctx(&ctx).
  3. net/netfilter/nf_conntrack_netlink.c: ctnetlink_conntrack_event()
     allocates with GFP_ATOMIC and calls ctnetlink_dump_secctx() ->
     security_release_secctx(&ctx).

Listing BTF_ID(func, bpf_lsm_release_secctx) in sleepable_lsm_hooks
lets BPF_PROG_TYPE_LSM sleepable programs (lsm.s/release_secctx) call
blocking helpers/kfuncs such as bpf_copy_from_user() in atomic/RCU/softirq
context, causing BUG: scheduling while atomic or RCU stalls.

Remove bpf_lsm_release_secctx from sleepable_lsm_hooks. Verified by
line inspection and live QEMU BPF verifier runs on x86_64 7.4.0-rc3
and 6.12.118 (lsm.s/release_secctx: LOADED pre-patch -> REJECTED post-patch
with -EINVAL, "bpf_lsm_release_secctx is not sleepable").

Fixes: 423f16108c9d ("bpf: Augment the set of sleepable LSM hooks")
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: Yingke Xiao <inkxiao12@gmail.com>
---
v2 -> v3:
  - Rebase onto current bpf tree (4b4eb7f44ee0) to resolve merge conflict in CI.
v1 -> v2:
  - Correct sender identity and Signed-off-by with real legal name per DCO.
  - Remove drafting notes.
  - No functional code changes.

 kernel/bpf/bpf_lsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index f39a3766f..791dcad12 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -368,7 +368,6 @@ BTF_ID(func, bpf_lsm_path_chown)
 BTF_ID(func, bpf_lsm_mmap_file)
 BTF_ID(func, bpf_lsm_netlink_send)
 BTF_ID(func, bpf_lsm_path_notify)
-BTF_ID(func, bpf_lsm_release_secctx)
 BTF_ID(func, bpf_lsm_sb_alloc_security)
 BTF_ID(func, bpf_lsm_sb_eat_lsm_opts)
 BTF_ID(func, bpf_lsm_sb_kern_mount)
-- 
2.43.0
