Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795069115;
	b=gZ/Ig3cPGyFJTIxfrUV2NDoQyaopZQZvSC1WfKWKW6pAjWNcO5hMr/MaDWQsiNUNv2Jd
	 Sh1ODNMeI3yaEgd3Xdmj5j2wFNGChyWELIWVge7B8BQSdr6rQc1GAFCkodeQAJkK3y3f/
	 fDWPhz4jhh5zRQT3/FFyAMnH6t6Z3rWzM7d93aHYd/t31J2iYFaZkYq5TR5AQh1BxPbdg
	 Ra+mYE8l8pHWcv2LxWDQ58yoyEKIZyo7Iy/6WhXfOhOqDzWN1Uu27pb6WdlAv9bA1rshQ
	 HyL/IO0O2GaAYmfYwKcuH+P0194TBewWqahd2H0jmZazZBMbSPUm3xMn3A6LQOVUSUA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795069115;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=FkwRSQFDonsNjEAPB2zFYO6lMt6WVqW7I67T9GbDWzM=;
	b=ayAUZK1eHtWIwXp2wBCJdYP9gGIA75XcQMllT2M+wU7k8dJoI4mFxSkdCL/aTTH43ElA
	 r0zv+n0d7ypYEpLP0ml+2Eet9+BxZvUmFFqXuls3OHT7XS21TPfVgoUIKMw6IAPzfQ27I
	 UzGNJDa8ptgkcrNp8uM2zPvdGhzg/UiKosKrwJCBL+wUXKPwaDi22tFQnJLkda82H8ILG
	 ELs1wMBPSKKaH6gkkRW1W66bqkLAUY0YaDH4hzsax7uPNQyMHLvazCv52xLCRWKSWoUTc
	 GcRrDJOmWiz8sY/9LnireWidCPbyj3X05t+n2MEfQ8vK14RsNxGteJUib0RijO5F6Og==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j7XBeknV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D896606A320
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 06:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D896606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=j7XBeknV
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91c847584b8so6900746d6.0
        for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 22:18:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795069114; cv=none;
        d=google.com; s=arc-20260327;
        b=JkP+BgAUUGelNjHSa2NHW9LVt2AzzpFYzgq81+TRxxR/lIN9PaTjbvnXgiEe9Twogq
         Kyw27dtTnNEDRjG5ewFMA2lFkmc0atmsjuEO6SjbS0/s++3G+RJi3UdIFsR6M5vsKPDG
         8fk9LNP3zSfa+xnouHhAQvJ/0VvTfRWpBKtc80+gA0X7jD7RyOupV4E6BSBIweuIW04n
         92S37YW9fdM7OyzuDXs+RPR//An+3593yH6FJrz1HQ2dkOQSzKYhLBymGTztt5s5vmQX
         eBng8hJcKOu+pjLc/SKikBAAr89meuSPRO4yHSLVNObd7iRimy3G8mjlffsAMXZY5Qs8
         v5Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=FkwRSQFDonsNjEAPB2zFYO6lMt6WVqW7I67T9GbDWzM=;
        fh=v/qBMU4wwadfiVHPQOJnoB8I8DXtsJMiG4gQ2sxzR1Q=;
        b=qtDf1lPvM6VdioRUbHfKrDpPQCVjpkTUr4ygAArRMP4pKRei29Q5Z7oHeSPlFFh3n0
         auKo6haR+B/KZqSTVE7VyUICvXqxWZEu5gBxG0P0h0JmBhsISqaJlRdAK0AGyDSccZ32
         s8RrlzNz4PzqBsz0ZmUk0lM0PHI37tsrVUde6UfQKCTPnmTmcWVx7MuhBNxjOt65+oPD
         80tpveE/QvCC1fq42KPi4MGq1M5s86RgiAjQ4RDsvOnhMiS6i7oG15ICRYAFJ/Q3XouJ
         N5KCxm1CwTdLzI2FVdXGuDX5N0BBWkOoliq3Mp7H4fLCHwSum1UnyrrI1T6NllLrNLQh
         AJ4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795069114; x=1795673914; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FkwRSQFDonsNjEAPB2zFYO6lMt6WVqW7I67T9GbDWzM=;
        b=j7XBeknV5sIlnxlFuRpkyMchLbY9nrTW1brjVrqw6QAEZr1JwjhL3KEueCnPsuhxTM
         hrOQJrwovvArkCYAEoSyjQrOADbOS53Ys+HcB61CbRLwrPncMi7Isz8FI3lSSbNNUANJ
         rGDpTrwmQYHyOUwNwpR19HtOTJVoHb28ANOaJxPaI1eVrEdANXHbOL5BqfvRm7rT9tat
         okT7uIfrVsHnV6SwOPhAQ7i4xxeXieD6bksBtKvCjuYmNCndxetspKINIZbOJ37mzzjZ
         eqdtbeipNAx9PmYuGxOqv2mbXFWP/eb4719QqFFDj3lIX7pSSjRLyYrh6F6K21f0vx/h
         LT3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795069114; x=1795673914;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FkwRSQFDonsNjEAPB2zFYO6lMt6WVqW7I67T9GbDWzM=;
        b=rZU3iE8Wl7M/CoiTu3d2eNE+bqX0kFIFJElHZ631r8qU8OchsTltMp23z4bwxfzFMs
         p7JWA+cMU+wdhCUVSFpcXs4Hqxh38r7C7rhrrGssEWqu0K20VHhaGznyazfS2+URNR81
         IUfHamEyKW5i7gqEaay4rOufXq0Cvf8vCrMxZ0Jv/Uwc8aw5bfTBCrZZn1GiasgIPaWL
         0NNExhXuNuUDm1Y9KAgA14fZLHYu+7PzBxHwVlbWB8FZn0eqpXC/0KwkI2ZK3NCj3Baf
         cOkHUBeTK7rE8uTYZSkMgTdPzFfix0We+qXkPpxD0JMx/Nmhy/l+W99pYFakIq7LzQkE
         0mkw==
X-Gm-Message-State: APuU4Z9kMm61Ughz2EiuG/wCh1atwoG44xugZl+p13+Xs/PGsnQXpmKa
	LY8lfSgmw5dTPAi+l/3aGbyzIemFB/3zgqaWhLb9LcpellKsK9f7awuuGur1XeTSqcjjPDjyqoJ
	Onj4rnwvYsbPEVNcohRH1+J9aOsV/WjWcwoajs0B668hM
X-Gm-Gg: AZFdTZe7aupmahIwGPGlToAI24Cqz5xcIx8I93QP/b8bOdvHXFeZmtxavQzmYLYUdC4
	hhFDXYNqLkqd9dw9Gs/qZ4mkTW1Nh48w5E38cXt5ZBvXxqoZEl+sm6y4zh8VuGjmpDeVYwJ8st9
	ruZe4O9gHYmvrRdGxMvBfVNWJKy4oy4cXdYb3sfJZ8AJrXX8NilN/ydhsiGbF8eu+KxD5OTem5W
	RX0GJpLNX8tNMSpn7koECfr0b2XRcNymvdED0ge3S6xPSN4Cggu5dz0H+orREQR1n2Ba6qDFTYt
	7UdDLPmYoI2/1sPSs7gv23QQxdBGAfwu6JJzD0Sg09Jov7ZBNq2Jjd1hi4cCh+ZupaIHV7j3Vfr
	UKAN0KrhwLsMhPnbfEpu8VoJbNLg9rvDeaS/ojTKEBC85p+v4A03Ue5fAOCMVZpocoH+ZjtopzD
	JbsMzsbDwp0qhRoCxQYQ==
X-Received: by 2002:a05:6214:627:b0:921:2c0:a46 with SMTP id
 6a1803df08f44-9212de35a74mr2230366d6.2.1795069114246; Wed, 18 Nov 2026
 22:18:34 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: =?UTF-8?B?5qKT5bed5ZKy5aSq?= <inkxiao12@gmail.com>
Date: Thu, 19 Nov 2026 01:18:22 -0500
X-Gm-Features: Aa3M54qvL-gkZG-PDrhf4v1NxnLtVHwK458mPPxFaslFbH2AjBYMlncoZPd-AZU
Message-ID: <CAMcAce8_ZR9xr8KJe6kvDNxr-JW2A5Ya5tn_2SO86hn7oR1KCQ@mail.gmail.com>
Subject: [PATCH bpf] bpf, lsm: Remove bpf_lsm_release_secctx from sleepable_lsm_hooks
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
line inspection on 7.4.0-rc3 (20eef29b7c84), 6.12.118 (bpf_lsm.c:347),
and 6.6.162 (bpf_lsm.c:337), and live QEMU BPF verifier runs on
x86_64 7.4.0-rc3 and 6.12.118 (lsm.s/release_secctx: LOADED pre-patch ->
REJECTED post-patch with -EINVAL, "bpf_lsm_release_secctx is not
sleepable").

Fixes: 423f16108c9d ("bpf: Augment the set of sleepable LSM hooks")
Cc: stable@vger.kernel.org # 5.10+
Signed-off-by: BoBppy <inkxiao12@gmail.com>
---
 kernel/bpf/bpf_lsm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 468e63d..c7d683e 100644
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
