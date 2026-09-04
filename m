Received: from mail-wm2-f11.google.com (mail-wm2-f11.google.com [74.125.225.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A99141F5EA
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504012; cv=none; b=QPBDvpfxdYPxp6pGlg9kL0u5P7m5GKnLs5dWlUI27qFo2/Lc+JxB6/y9dCz5zZWdeOeVqkkwOI1rmAW7Zc7FKHWgv1zM09ocuEX+V3ZOckYzwyl77lpJRoq8wvo7uA/+P+7I4Xt7Juir2uD/X3iqlLUM6QqqXdK4qoVo/hFVbq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504012; c=relaxed/simple;
	bh=QjyFemmIozERhodCkzXtL4veL+JAmYERTTa3YaCe5bk=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=cx5cIHUINDSTGcybZ4366Zt8kTdXcbalku4/fMqnBwoHuxCpAFdDNW2N4gnKgsZudBUoiut7953KBRB560mK7psiG91czjz3ThBst8TPOnYfYet1Pe1dE4MXwtSNfP4G8fuVikC2E/Q5xLkzeLXWTBIx1OxI6XxwgyQfNMuSDy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XQxOFsEs; arc=none smtp.client-ip=74.125.225.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XQxOFsEs"
Received: by mail-wm2-f11.google.com with SMTP id 5b1f17b1804b1-49cfcf2548aso489645e9.0
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 23:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788504009; x=1789108809; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=nkzwoOSsNSMFNmfOP7u2WhxZBj6+UodQ8M2EJ24NymA=;
        b=XQxOFsEs6NXZNTMjdeDL/De5nXwNQhEk5lBrcSRsLH+oG2HxfcHLrNHqUqMTPxKsRR
         QDJ5RlhOHdKo2pWzdBW1b61IK0aHnmBzN1+WmI8hVxnQGKTViYyIwbEpMEUwFoYbSRKZ
         8ZkfDDj8hxJtKF+GAZ+oRxcthHZ10JwBD9Utl/RWUZFp60jEZQo5aaKuUqJvcolDQmm3
         /LGX9dB2cQ88Oa7mhr4oQPGI3hJIkrUT7BYCEpFuEHpILJ6ZATWKb+abrn2Pq450GJoG
         eWzMHdwZNDf2neI7iRdBMKWxT+OoImsOCGMxTQWj8LrcRdMBldWebXC+OOERBdKiGg2t
         3R4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788504009; x=1789108809;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nkzwoOSsNSMFNmfOP7u2WhxZBj6+UodQ8M2EJ24NymA=;
        b=KWu041nXK7POSH4A95guvBKu1HkvFN9HNzk2dzAjXR2C6JD67QDQEX6oFoem0rmk4H
         9Y8Sm6pEdJfmqp6WDjuST2H2OdocgrR7JQv2gcfhlFZSv7KY0s2P+Gd+C0sPaEq67bEv
         kyVoATfz25c/H54/+vgjt4Bd/9HsfVj/0rwjpKyvllYoWgljbaJ/il/h7R7doQRtcjY8
         SGOqNfv06dPtuoiHagSjFSV/ANgPW2CtZoza/2GW8Dy63UzGLYgJWNUpL6eQtFSxNR+O
         7tX4Tpu3MlSh4Qd5g+Mo+WdDTvYRUDq1t14HkiymrD2Xr0UPOiWsTQy+Cse/rPltSX+Y
         FIhg==
X-Forwarded-Encrypted: i=1; AKwUvBygQT2fEcUIRD4qphxjy9WxX79RcSozpKUsZx+doRZRfCg6I+ry5XRSXVY0h3LCDIF3ndc=@vger.kernel.org
X-Gm-Message-State: AFuF++mbgC22tdQili8Y57sGqbtoWoH3WWU8NTE9NqLMGXB5WgBVEV9X
	W8YkyzazFVP7r8XwU8/j6iG9ZL+/62CNRW/WLHfi6+ltR8nanqF8dvason3NPjrw
X-Gm-Gg: AYBFou3qgEuqahDjuMX9EbS11SN1XF4xF3FFbZwmuwfhJUQLNhcy5coTxRq1Dr+iwRU
	O9rZNgZBDqzwpQUnwAS24Qc2Yu2wn7oRbjS+mEGN8GA/qLBKXbGeYCjjhA9VcyWHFDk8cjR3nvH
	ODzuVpuIa6uc0Mqp5sf7ibtk75BGjHapy+6el7dASF4CC0QalhDjxPxJPUJUSH8hGfPH3psXUlh
	1k79xT7s1Q44hp5AXCPvujD9//ydVCZV394aiVGF1nldOdbYWaujy/HutrECjH2JuZ4B4FOHV8R
	CLW2V7tDUmhyuNfgIT0Z14tnfJKFKpezuvSrTUbpCgr9TB56ClrTNuUL+XHXsJG447jhE1+ka8A
	KdumZ0Bf81sYefU09dBbCA4c/r4xLjTMM5Wb484bXXQnmPu+ZJV5HT5ylB6Rx4JM4fqOk8tHwQa
	KOhtxjCOtrOdQOcKZJlHFPndhrOEvsoumcBqk6eWZe0CD7a0ZwxclbmkntwYfGEybeTGSExpud1
	BgT73Zp/Qivjsl+5VvPPohvzmNpCNsHkQVbEjYrq7Ruy/G0zB1+fpxIP84AgNd0zNwENEMZ+BTo
	yHqYTaoWj/66q7KTiQ1cK1ucSTECbE7jhPrsJdcH
X-Received: by 2002:a05:600c:3b02:b0:49c:fa21:1c7d with SMTP id 5b1f17b1804b1-49cfa211d76mr18050155e9.18.1788504008912;
        Thu, 03 Sep 2026 23:40:08 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f9114sm126410025e9.5.2026.09.03.23.40.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Sep 2026 23:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 04 Sep 2026 08:40:08 +0200
Message-Id: <DL6BRAOHPT5T.8N108I2TRDJX@gmail.com>
To: "Ning Ding" <dingning04@gmail.com>, <bpf@vger.kernel.org>
Cc: <greg@kroah.com>
Subject: Re: [PATCH bpf-next v4 0/4] bpf: Fix refcount_acquire handling for
 borrowed kptrs
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260813211533.290256-1-dingning04@gmail.com>
In-Reply-To: <20260813211533.290256-1-dingning04@gmail.com>

On Thu Aug 13, 2026 at 11:15 PM CEST, Ning Ding wrote:
> Fix two verifier bugs involving bpf_refcount_acquire() and map kptrs.
>
> First, the verifier can mistake an RCU-loaded map kptr for an owned
> reference and assume bpf_refcount_acquire() cannot return NULL. The kfunc
> can return NULL after the last reference is dropped, so passing an
> unchecked result to bpf_obj_drop() can crash the kernel.
>
> Second, type_is_ptr_alloc_obj() accepts PTR_UNTRUSTED pointers. This lets=
 a
> pointer that is no longer protected by RCU reach bpf_refcount_acquire(). =
If
> the object was freed and its address reused, the verifier may acquire a
> reference through stale memory.
>
> Patches 1 and 2 fix and test the return-value nullability. Patches 3 and =
4
> reject untrusted allocated-object pointers while keeping safe
> BPF_PROBE_MEM reads accepted.
>
> The series is based on bpf-next commit 806c1a185215
> ("Merge branch 'bpf-introduce-global-percpu-data'").
>
> Testing used a fresh virtme-ng KVM boot with KASAN enabled:
>
>   full test_progs:           757/6685 passed, 7858 skipped, 0/0 failed
>   KASAN/Oops/panic markers:  none
>

Hi Ning, thanks for the patches, and sorry for the delay on this set. I've =
been
buried with several other fixes. Nicholas also reported similar issues, and
there were unresolved AI issues here, so I've taken over the series and mad=
e
some adjustments and sent a new version here, which I think should address =
all
concerns properly. If you have some time, please take a look and let me kno=
w if
you see any issues [0].

I have kept your authorship to credit you for the original work on this. Th=
anks.

  [0]: https://lore.kernel.org/bpf/20260904063650.3877826-1-memxor@gmail.co=
m

> ---
> v4:
>   - Rebase and retarget the series onto bpf-next.
>   - Change only the affected verifier test program sections from ?tc to
>     sleepable ?syscall, as suggested by Kumar Kartikeya Dwivedi; leave th=
e
>     test logic unchanged.
>   - Drop Cc: stable@vger.kernel.org.
>   - Rerun the full unfiltered test_progs suite.
>
> v3:
>   - Make type_is_ptr_alloc_obj() reject PTR_UNTRUSTED, as suggested by
>     Kumar Kartikeya Dwivedi.
>   - Add a separate helper for the BPF_PROBE_MEM read path.
>   - Add read, refcount-acquire, and direct-write verifier tests.
>   - Add Cc: stable@vger.kernel.org to both fixes, as requested by Greg
>     Kroah-Hartman.
>   - Split each fix from its selftests.
>
> v3: https://lore.kernel.org/r/20260803112218.3361213-1-dingning04@gmail.c=
om
> v2: https://lore.kernel.org/r/20260726235030.1152542-1-dingning04@gmail.c=
om
> v1: https://lore.kernel.org/r/20260726015330.705259-1-dingning04@gmail.co=
m
>
> Ning Ding (4):
>   bpf: Keep refcount_acquire nullable for borrowed RCU kptrs
>   selftests/bpf: Test refcount_acquire return nullability
>   bpf: Reject untrusted allocated-object pointers
>   selftests/bpf: Test untrusted allocated-object pointers
>
>  include/linux/bpf_verifier.h                  |  11 +-
>  kernel/bpf/verifier.c                         |  10 +-
>  .../selftests/bpf/progs/refcounted_kptr.c     | 161 ++++++++++++++++++
>  .../bpf/progs/refcounted_kptr_fail.c          |  74 ++++++++
>  4 files changed, 253 insertions(+), 3 deletions(-)
>
>
> base-commit: 806c1a185215382fab5a7fafc74e30070b2fb043

