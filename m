Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C2A23EA87
	for <bpf@vger.kernel.org>; Thu, 19 Feb 2026 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771479544; cv=pass; b=G5R0bSAxJq+XBElYEWJyeuEbWDJdPaTL8xuW2DYNBfEHqvTm44qNBJhEzGX4FNPfctRE5dKOPTHXIzqhH17x8lFuK7xtIVQsw7s/AAQ/eBBpm6Qn1oqWYoR7cHuqSIUMkczfcB2uk/ijUqJuhaAkAnesVI3+aqNIYCPkEGwMG7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771479544; c=relaxed/simple;
	bh=JfpGmH93zrf0ivQZq5XswlZvKz2XZ0BAPJqLOFBVyDI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=sI0fOuN0PrXxtwGFzdc/znQ0uGfVHnL54IrrcSjujYlioDiLl7PETzKPJNVEA1Uoq2S33VZyO2NHN0cuUdrvgGWX+3Gj3P6tJfdyQqplRu9nGj15gszQqkdw+wstm9Xqf27wvh1C614vqUK0SC4TYve0z2rMPAQmnKyM1TRuAwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AAqBH+pI; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=rHvcnijn; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AAqBH+pI";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="rHvcnijn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771479541;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=kOS5XCAZ7s18H+yJMwEy2Ks3wIVTG5DOD6ofLB7byYo=;
	b=AAqBH+pI2zugUYF/HxAmXSxnifTE0QI5mMzuKtj3orXDOauwSxgckV89XfynH1Ch77fM6d
	GSrjaHrW/0wNad0MpWra5c/I6U6JFCu2bu7CqAIhQ7FE3TTOiZ0X4xSyF5xeQFwt2na/0O
	ZmTk/4hXBsR+gbPudOMUsd+8fQbyi5E=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-qfD4ZCrQMFenS8xg6jtDmg-1; Thu, 19 Feb 2026 00:38:59 -0500
X-MC-Unique: qfD4ZCrQMFenS8xg6jtDmg-1
X-Mimecast-MFC-AGG-ID: qfD4ZCrQMFenS8xg6jtDmg_1771479538
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-59dd649b4ceso1165636e87.1
        for <bpf@vger.kernel.org>; Wed, 18 Feb 2026 21:38:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771479538; cv=none;
        d=google.com; s=arc-20240605;
        b=QZ0k8ybVEMU74qjA+jC8o0vi1CdjcymLj0Hah3jnIdiQnd5ANXEWwlk3Yk/XNpjYiG
         4AQZ4GScZURipuaHCG148KsyqdtdDdvP2TXefirSQofP6XJ7SN6f1V9mC67VKKdhsOoY
         aNQfgkKr6lNnSNaFJ103Hh4gef4RopP0AC+hakKiMQLcY9XCP2LsUcDnhIu1zbFXuWsX
         wzqxbM/TOvmsT79cDKh0mTLTPlWTMItf2X2zvXVvJH673tlMT2qb+DVUHYBbQYwo67nT
         3dsjRtHQ3VtVpjGu8qR4VlezmNP4fX+SPEZTdsNcvZ3bq3chdeK+YspEMvFzhgcHSX2Q
         KR5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=kOS5XCAZ7s18H+yJMwEy2Ks3wIVTG5DOD6ofLB7byYo=;
        fh=nQ9ePAZXZYUF/qizShZBV+zNQy6LIE0sEqsBNLwbiWw=;
        b=YN0LR+N+68aqGN6FpKTZ/UCTTsq0J4Myt+MmkHl+daYd7Jr7JtTk8eu/nE/s0o1DWj
         87JGIRlWSLu5Vb9HBSr7buM6CWCCod/uy0Nqd+Ppg2nrZ2OoxHI9Go5L1iWNx8sw7pWW
         4Gk0/u7Rc+TR0fGiHOWDVaP5bKgYrmXYVW1Xtji097I3JSb//Hp1/1eQ4k8evgYz23TB
         tW4AoZkHCPAbf3z3YMJXf7URtLPlQwBC8HRJUanV49v3w65phXpaC3WqJoBEIeBL09Nt
         F6NwhJA4xqyzIESv2++8VEd0L6Y3lTvbqt5UUzYhkW9/ZwBxBUbnPIdfWhFWJiYr08Ht
         KApw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771479538; x=1772084338; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kOS5XCAZ7s18H+yJMwEy2Ks3wIVTG5DOD6ofLB7byYo=;
        b=rHvcnijnxE3cTF49pOuZ0aGDtCMxlBbeNOonYZMfxeBvS7h6cxZgSHsGlQZ6oN+E3A
         eGPE2PCC+uan4fjRxhVKr3Yg893XR39BvuTKzXjFa3MZ+ZOyp6uF8ab1RsP+r4lCOMzX
         HP4/v0x8IRN28wa4H2iA1vrWc9LwDaaJ51efiMvM2ESKX2tRSF9+XW7Yq23v/ZTTFhQY
         4XfqZYmHljYTmsdLaJsDjcinZh2ix0fYix9yMhA27niwvZSzGcZsKEPMgvv5hc8bBQHi
         NjHJMdfuxSXW4Y9yY6py21Fc3qJfpp3ZCuTjqx1S2xTgaTG7omwLKVHXNpuHGa1TY+0l
         0xSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771479538; x=1772084338;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOS5XCAZ7s18H+yJMwEy2Ks3wIVTG5DOD6ofLB7byYo=;
        b=pxq9dhnCygPy+ogJz+B+4CZlLmRCUrJaQANVAeQ3lijPwVG88sSA3XjeeL9a8BZEhw
         +xFSMONb8nhRmQffD0uLiQO6k4FzCN6onb9UXWa8yC0lJFxxzoml/7zMoDue7oYNMxiV
         yIzaPm8BP2OzNK5f2MbTQcJqUMyS4jM/jrEPpagSBeq5Q7ulCWF88QC7T4hKcrWYLFWK
         RQeDWG5za9LTAj9azIwqx9PRpa9QlS1Em+fxUOV/WZrcfNjcoF0sWO4Y0eWR85q4EokX
         r2NV9VHesGS8VWNY6Y8EPUC+pgebJ3cQNmul0GaSPkdyG5SxH4VRJ5cWHFVChVDHB+6f
         5uyA==
X-Forwarded-Encrypted: i=1; AJvYcCUjcek6AOab+XQFkcaUv7MR0/DQWCijfSqGlKMT6lPVv6eAKnJq/PEo3jVEUzBLgi3zj0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5TcTO2V3mjM2UcmT3ikW52l6X+RxnQKsiQfOAFfdvMB35dVXl
	5lobbNDnD/aQyS0nvt02NiuUobuO2v3HQSm3F5AnhFwkV/yP+2301wHI8ctp72XMZsHxtmosQ6Z
	KIYFd6gdrB4seK1tkB34otIoXusEQDcOHIUTYU7VaL1kYheGSCgV6kkHb/oIVPWW+9zI6zyvRbI
	wQVw/4fagk9+GJPbksoGYSr6PICSvW
X-Gm-Gg: AZuq6aJ8pn6uBhabAudkP4sQdZbNJ5uFel9DFvfCd8iOdRk+fE5IWdPzKTtSMd55zpo
	sb/+8WkOBnVn8D6Oe8osTMhaj5quGSzd35j0yMlHPvoP+WE+/DcmJv99SsSh8GHaGNpub+glBGK
	hqc5+485U6BdjPiUJj1+gBNJpAFwg8c8CYE8/0eBzV9DtcERHorRc6v12LHTy3v5iV13WtFeOMu
	cPKyJHuvEGMtmB/qONEMS98rls5liVd9YRYok6qXti646MulZC/w5tzM/A0YLSmoyNG+uzUNUkd
	niAI5A==
X-Received: by 2002:a05:6512:3190:b0:59d:dffb:cd70 with SMTP id 2adb3069b0e04-59f8adfa16amr216886e87.21.1771479538081;
        Wed, 18 Feb 2026 21:38:58 -0800 (PST)
X-Received: by 2002:a05:6512:3190:b0:59d:dffb:cd70 with SMTP id
 2adb3069b0e04-59f8adfa16amr216874e87.21.1771479537632; Wed, 18 Feb 2026
 21:38:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Xiao Ni <xni@redhat.com>
Date: Thu, 19 Feb 2026 13:38:46 +0800
X-Gm-Features: AaiRm511bzlGB3pDN7u3SHsYX-LO7QQII70qqttOYf0DSiJ8VulB68nwomLRZc4
Message-ID: <CALTww28QMg=YXqKWpWLZrLO+xiqOe3LGyput8dx68-dnQsxg=g@mail.gmail.com>
Subject: [LSF/MM/BPF TOPIC] User space RAID5 with ublk and io_uring BPF
To: lsf-pc@lists.linux-foundation.org, 
	linux-block <linux-block@vger.kernel.org>, bpf@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>
Content-Type: text/plain; charset="UTF-8"

Hi all

I'm doing some work on user-space RAID recently. I'd like to propose a
topic for LSF/MM 2026 regarding the implementation of RAID5 in user
space using ublk and io_uring bpf[1], particularly focusing on the
challenges encountered and potential kernel improvements needed.

Ublk raid5 uses the ublk framework (tools/testing/selftests/ublk/),
with the goal of leveraging io_uring's zero-copy capabilities and
BPF[1] for performance optimization. The implementation includes:
* RAID5 stripe handling with configurable chunk sizes
* Multi-queue support via io_uring
* Degraded mode for single disk failure tolerance
* Integration with io_uring BPF struct_ops framework

During the implementation, I encountered several technical challenges.
The primary challenge is performing XOR parity calculations in a true
zero-copy manner:

1. Bpf program support
Raid5 needs to calculate parity with data. Now io_uring already
supports zero copy. For targets such as raid0/raid1, it's enough. But
for targets such as raid5, it still needs to copy data to userspace
and calculate the parity. Bpf program is a nice solution[1] to resolve
this issue. Besides the patch set[1], it still needs another bpf kfunc
uring_bpf_xor() support.

2. Register buffer per io
Raid5 needs to calculate parity with data. So it still needs to
pre-alloc buffer and register it for each io. The total memory is
controlled by queue number and queue depth. With the pre-alloc memory
and bpf program support, target such as raid5 can support true
zero-copy manner.

Question for discussion:
* Should the kernel provide XOR operation kfuncs for io_uring BPF?
* What would be the appropriate API design?
* Are there security or verification concerns with BPF performing XOR
on registered buffers?

Current Status:
* Basic RAID5 functionality: implemented
* BPF struct_ops framework: successfully integrated
* Performance testing: in progress
* Main blocker: zero-copy XOR implementation waiting for kernel
support I've written a patch for testing based on [1]

Why this matters
User-space block devices (ublk) offer several advantages:
* Faster development and iteration
* Easier debugging
*  Ability to leverage user-space libraries
* No kernel panic risks during development
* Easy to evaluate/compare performance between kernel raid and ublk
based userspace raid.

Desired Outcome
* If proposal in [1] would be acceptable
* Get feedback on whether `uring_bpf_xor()` kfunc would be acceptable
* Discuss API design for BPF-based computation on io_uring buffers
* Understand the roadmap for io_uring + BPF capabilities
* Learn best practices from the community for similar implementations

I'll finish the ublk raid5(tools/testing/selftests/ublk/) and submit
patches later. Also, I'll try to prepare a patch for uring_bpf_xor.
Next, I'll try to impement it based on rublk[2].

[1] https://lore.kernel.org/io-uring/20260106101126.4064990-1-ming.lei@redhat.com/
[2] https://github.com/ublk-org/libublk-rs

Best Regards
Xiao

