Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927A836B93F
	for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786458156; cv=none; b=kEsR8asIe1IRySwZYkp7pGxvo1lP+KK1Ohea5oH+0foXZYWi+/G2IsxMrnXrsCgRQIFdTUCAGLQql9XCVZFFcq7/7XVVb/2eGJRtIY4avfpOULnsx1Pq4JKuFvJXnL9QIO6Uhi4n2/mdhZi1qKaENuPOcv+e8F/EkZp/gL4Alis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786458156; c=relaxed/simple;
	bh=nD2ZiDJtQsFCRpD1CX4m5JEumUvjwleLhSwPZM95u28=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=Uvimzpaw0ip2YLSfvL58/uSfd8mc4+vU8o+L04Pu28fjWDVMtvCeqy3eQK6gNrqvL3pXyBmCqvYc3EK1r0NqpGpaFq4FTFexZSK8IK8CtI8vY7Q20X3bzS+u01ELQclPcxfr9x2ke2GwWlvzDLxKB2Us+l0UHIFw0o5kXlbvqlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHrxhT3g; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHrxhT3g"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49556ce3549so11597335e9.0
        for <bpf@vger.kernel.org>; Tue, 11 Aug 2026 07:22:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786458153; x=1787062953; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yP++X0pXYzpQN6HJ157j1zYNVbC+m82XWMtDMMQ31/s=;
        b=bHrxhT3grp/nreL+gf/2+IoLc8RirYCt9SnYnIgx/Ka0EkgGlXzshWOXtDfdE70YMr
         72iveKrXhYTqzK41+BIcvIWX+zL+SWeUgQGGtZ9VMv1/IiaycJTMdSdgpL8L/hX92ugm
         21ymzXy0i5ITDHBOkaHqjZPff4uoswAYb2Z+X5SLM/5MvNIBQfEsyorKWTN90GgFD0p0
         S/hrR2uVANCLSIGLvEvhDUq1PIz0/hGxfP6S6hKE0jmra2UXdiaTPtp94rcgarp1SA5K
         2sKHa0u3V23QfAnsn33eH0wHmJixidMvFZvDk8blI+zkHlhPJMjcCByNym82GcojDkAJ
         d9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786458153; x=1787062953;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yP++X0pXYzpQN6HJ157j1zYNVbC+m82XWMtDMMQ31/s=;
        b=qQ1QvUvQNHtMcl3fzKcpt/yFfYbhXwJly8hXaA0hrJTrbe7bR2z0Nri/ol6+6eusBQ
         v9i4GB7nUnsAso1OYB/KZkWmMeryvpgulqnViKZTlzpK4PBOjPObQZSYgOHyfsIxeHuD
         7Gd1PpE2S5IV/gC7TzNTjNhy80e7FoDDr9NK6t+tFwTXIMKnAZ3nwK6+vkUy+SED3cha
         SRBc0Wy1QFPa25WiFWN/RDCNdT3MjH5n1rbcavhrPv2gk5jVcOmKrVocn/fhJpZqsq3X
         Dvl/jePK4clvPp3kxTP00Q9tqaKhzVvkMiqdelqYm3eNZhmAG9K+NZBGFzJgA8Xj2LZ6
         YCGw==
X-Forwarded-Encrypted: i=1; AHgh+RqGxX1zqc9YjJSmsprJTcpe7VP808bzqDVU/zC0qKU+gBQUHd+cXgZMmoWEfB6/+OdXTEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6yTB2w06phc5keWa1n4/2x8hVHgYv4WPl/7d/47TEQHxN2SQz
	3OArMdkTNjuep7KLVzqMAypzpnT4AuKk1X4Sxe7y04T23PmYKoW8gEM1
X-Gm-Gg: AR+sD13vXYygE0uQZ95tc/d6S1vQ5RZ85/hK2gmiSHLBSdchi58ecN5yu3oq8UZDQMg
	pxtQD81fJ0GbyKLEuWGzFpuGQZnnjNWYROAmelUaSs3L4YDmJePa15D7hd7587s4C+kr61Ejs/P
	icdIUK9ZFqm2bpShnjMn+YIVbDGiXpRHoqULl3ff8mITJHTcbV5JOtXmywvI9PluViEv7sleUny
	WryCyu+tAEVXqxh+L80sOI+uewHDMhUVE31mya+O+xNMFlhfP5pkgBm0KLEvOZED1JqoTzkW3ZW
	Wk0Bs6b42KvU+3yVCpo4avrg0mogG5wVPyHtEWa2e/oIYme1y05tAJOm1vin+EPsTZaRLLau1We
	Ef0OckZZblA0UzFxqR1vcBcmRRmybPP58zibh4ArMxzPeO8K50Ni74nJeOctPzX7Vy39s5u+006
	C/kQg3dYu4yRmmOsxnXnSqphMv4vOSKpuo34sVd8inFCnLop2RknfHvoGiHrQjEJzqyjQ9e2Xrg
	re/yVDRNSJwFqJuG9QOwmsKNLlUoptBnpQU2cUbU9HC9jthO0ihxJ870b9sPVkgNvyeY/Pjph8H
	pRYPfNt/h7d+oAoeg6cPNOCnyikBsWM11gyQ8Q==
X-Received: by 2002:a05:600c:138b:b0:499:5c3c:41a5 with SMTP id 5b1f17b1804b1-499783b0a4bmr57469525e9.0.1786458152621;
        Tue, 11 Aug 2026 07:22:32 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499788f13cbsm59767885e9.9.2026.08.11.07.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2026 07:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 11 Aug 2026 16:22:31 +0200
Message-Id: <DKM6K95EN9OF.3O9XNYWVLYHDE@gmail.com>
To: <chenyuan_fl@163.com>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Yuan Chen" <chenyuan@kylinos.cn>
Subject: Re: [PATCH bpf-next 0/2] bpf: Cancel special fields in resizable
 hashtab on recycle
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260811095531.3294167-1-chenyuan_fl@163.com>
In-Reply-To: <20260811095531.3294167-1-chenyuan_fl@163.com>

On Tue Aug 11, 2026 at 11:55 AM CEST, chenyuan_fl wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> The resizable hashtab (BPF_MAP_TYPE_RHASH) still eagerly calls
> bpf_obj_free_fields() when an element is deleted or its value is
> replaced, which runs kptr destructors in the caller's execution context.
> This is unsafe for BPF programs running in NMI context (e.g. perf_event
> programs attached to hardware PMU overflows), where referenced kptr
> destructors may take locks or otherwise cannot run.
>
> Commit a3a81d247651 ("bpf: Cancel special fields on map value recycle")
> switched the hash map and array recycle paths to bpf_obj_cancel_fields(),
> which only cancels NMI-safe fields (timer, workqueue, task_work), but it
> missed the resizable hashtab. Patch 1 applies the same semantics to
> rhtab; patch 2 adds a regression test.
>
> Yuan Chen (2):
>   bpf: Cancel special fields in resizable hashtab on recycle
>   selftests/bpf: Test rhtab kptr recycle from NMI context
>

At least go through the mailing list before sending patches.

https://lore.kernel.org/bpf/DKEVG8ZVJDDQ.2G40FTOIZKU57@gmail.com

pw-bot: cr

>  kernel/bpf/hashtab.c                          |  28 +++--
>  .../selftests/bpf/prog_tests/rhtab_kptr.c     |  87 +++++++++++++++
>  .../testing/selftests/bpf/progs/rhtab_kptr.c  | 101 ++++++++++++++++++
>  3 files changed, 207 insertions(+), 9 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/rhtab_kptr.c
>  create mode 100644 tools/testing/selftests/bpf/progs/rhtab_kptr.c

