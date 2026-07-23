Received: from mail-wr2-f2.google.com (mail-wr2-f2.google.com [74.125.225.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D66E3002D8
	for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 16:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784824501; cv=none; b=OZSHhvo8ZdiJaCLzobtoNvnwZ/jTHYJRZen3nHLR67DNvz/HBCQpg/SN3aKW3s/M/+RQzvoAK4RG7yV59TeOTRYZylmhkepqNBimohVBnt5I544vuaXctIijSyqrkgT3rETzKB7X6eKPLSQPktqySEfUOLm4u46QM6SrZU4g0ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784824501; c=relaxed/simple;
	bh=7m82xzqlJkh65jW256B5rGHgJcOKOQgUqpe4ySi022s=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=HcCU3qKARMliFzMWreXwgpHTzPrVPr/6FIZYhj4mGG+JEM4yNCg4xb8S4KOuN6cFWtj9QmliGr6mquUCcx7dTKJ8aljwdW9q6ot3aaZZ6MIkDxdq59vvr7GyhRATVlPR+9yG9hsHdk2frTHp6G6ddkLtRyxxcGBn+M5cpQYtgIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KY3PUL/O; arc=none smtp.client-ip=74.125.225.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KY3PUL/O"
Received: by mail-wr2-f2.google.com with SMTP id ffacd0b85a97d-4730b8edae6so239792f8f.0
        for <bpf@vger.kernel.org>; Thu, 23 Jul 2026 09:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784824498; x=1785429298; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=RzKzsNHJv/q6QP0M/pOIm3e3686GKdtjl/fwuHYCAMQ=;
        b=KY3PUL/O/wej1SKrFinSCYwcvBuW7hesDXWj1J+lXGYE1U+uqYZ0jDyE5vgi3FkGzs
         kFZirKTR7zVkQmq/nAxBtNTRgqyxSuA5nxyhmjzXJmr1ikSA+eKIqX4zr99Yy4md72vb
         kpnV4elAESKLIKXNfnYKVhLDdr1chRcic7Sj2VDQ04JVM8dVZ02SzfbvFMLWm2YEbvUE
         uL6SVh4z8OJLcL8uvCBa7mrrQNhWlrxVglPybmi+xYPgHMX/+B9vNKt8aH7zJDoDJXCS
         3cRIthDgnVMeUWy1FsBo89DPivYvRtdptFtSnBb0cNluwPXpl1hX6As29c8M/ADSwr+N
         gm1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784824498; x=1785429298;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RzKzsNHJv/q6QP0M/pOIm3e3686GKdtjl/fwuHYCAMQ=;
        b=LSB1F1Mk1DyBz66YcHX1KA+NaW9MnQieuyLmnvBhtdjllDuWT6uN2hSqrfpOtCYzoW
         hYGqLohyYOEWZzqoXbOjNYmilNnsGud9+LO9kTdu4+eOIgTzdwnqwNGn2hI9Pjh254bU
         hrvGj182bT0TePd0a7SduOdIUim7b693+Mtuychjm4dfWJN3Z/gzVIu1OZyrTgmAL/qt
         ywRN9UZiBOgXICq4PZ1BHQQMcK+i/VyZE2Z3L+nvSyoVUTOnMmnnnSJ4c7GwIqnkKyfD
         MDevlxuBHxddodR07iukzYtWElYNNv2VvteuqX4U7pOxaTjOPjlP7NYWhSjHM2BLxs7u
         HZng==
X-Gm-Message-State: AOJu0YyVgPMaWoJt61AEGK706mY9AFICGBx7I9zymrSg8IMdNZlImwoF
	n23U56MINz6k0EHl/S6E3NuuPaCYIjaN7Z2D/g5qIWT92Dy/gz613kSZ
X-Gm-Gg: AR+sD10znpUIVGunQGMFT2HXeYTNEBLsPtzLCRUQ2nZ7WkemljkNUjlXQMy6CI8Pe/3
	K7aCXE7BO8lOmCdtclDgIsjJiODijfsEc5RFBFSMGb7Byz+THU3+hH2fjLiQoKywxXv0W+FXLRk
	elKC1P0/h6XDCOK0yV1533yWXsGgT7SqGzOGJ7/VDAYLhVFQOWaIh55OuYxV76jjFcqq0zV5OaJ
	alBJxPIsHHHygsU3dDZ3GGnheWJAOLk1r4Xyf00QSW+vr567DwZ2CwJa1lwqwjxgQ3TETemNzwq
	dae1xnQywH11byhveT8CYi54jjjv32u4VtovG5Kc4lQYmsnesrrgxJTDhxiVULmDlCIJdwGkbIf
	EHJ1/oV7yxwAtC0c+hJi/LrSKnlG0b5Z8oB1mqyKRn7ZxGyxSLERX7npw2TieeoJyLontKIGez1
	2fB0+MYTyHdL4LqRrQ1ELNz6fQAvJ7LjJV1th7l1TTvRKW8Erk54zNtifweDMqzJZRXy9kd/5j2
	PpO+OB37Kn+Uts0BsrKU8OgoSwcZFzxHu8SayyZqk9OCfSGhtJwSuk=
X-Received: by 2002:a05:600c:198b:b0:495:6c0c:c221 with SMTP id 5b1f17b1804b1-49573d20820mr41953695e9.31.1784824497945;
        Thu, 23 Jul 2026 09:34:57 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957af79365sm6222315e9.9.2026.07.23.09.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 09:34:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 23 Jul 2026 18:34:56 +0200
Message-Id: <DK63HA8KEYWH.1W1W2IJEWEVRD@gmail.com>
To: "Maxim Khmelevskii" <max@linux.ibm.com>, "Alexei Starovoitov"
 <ast@kernel.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>
Cc: <bpf@vger.kernel.org>, "Ilya Leoshkevich" <iii@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>,
 "Alexander Gordeev" <agordeev@linux.ibm.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Fix flaky refcount asserts in
 map_kptr_race
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
X-Mailer: aerc 0.21.0
References: <20260723114042.559926-2-max@linux.ibm.com>
In-Reply-To: <20260723114042.559926-2-max@linux.ibm.com>

On Thu Jul 23, 2026 at 1:40 PM CEST, Maxim Khmelevskii wrote:
> bpf_testmod shares objects across tests; prog_test_struct that holds
> cnt.refs.counter is one of them. Refcounter release is deferred behind
> an RCU grace period, so it may still be pending when this test asserts.
> wait_for_refs prevents flaky failures when other tests have contaminated
> the refcount.
>
> Fixed tests:
>  - test_htab_leak
>  - test_percpu_htab_leak
>  - test_sk_ls_leak
>
> Reported-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> Signed-off-by: Maxim Khmelevskii <max@linux.ibm.com>
> ---

Wouldn't this still be flaky? Could we order these tests and wait for a RCU=
 gp
to pass before finishing each one? We have kern_sync_rcu(). Either way, I d=
on't
think the current approach is the right way forward.

pw-bot: cr

>  .../testing/selftests/bpf/prog_tests/map_kptr_race.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c b/too=
ls/testing/selftests/bpf/prog_tests/map_kptr_race.c
> index 506ed55e8528..5a543b3465a8 100644
> --- a/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
> +++ b/tools/testing/selftests/bpf/prog_tests/map_kptr_race.c
> @@ -28,6 +28,15 @@ static int read_refs(struct map_kptr_race *skel)
>  	return skel->bss->num_of_refs;
>  }
>
> +static void wait_for_refs(struct map_kptr_race *skel)
> +{
> +	for (int i =3D 0; i < 500; i++) {
> +		if (read_refs(skel) =3D=3D 2)
> +			return;
> +		usleep(10 * 1000);
> +	}
> +}
> +
>  static void test_htab_leak(void)
>  {
>  	LIBBPF_OPTS(bpf_test_run_opts, opts,
> @@ -73,6 +82,7 @@ static void test_htab_leak(void)
>  		sched_yield();
>
>  	ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
> +	wait_for_refs(watcher);
>  	ASSERT_EQ(read_refs(watcher), 2, "htab refcount");
>
>  out_watcher:
> @@ -134,6 +144,7 @@ static void test_percpu_htab_leak(void)
>  		sched_yield();
>
>  	ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
> +	wait_for_refs(watcher);
>  	ASSERT_EQ(read_refs(watcher), 2, "percpu_htab refcount");
>
>  out_watcher:
> @@ -195,6 +206,7 @@ static void test_sk_ls_leak(void)
>  		sched_yield();
>
>  	ASSERT_EQ(watcher->bss->map_freed, 1, "map_freed");
> +	wait_for_refs(watcher);
>  	ASSERT_EQ(read_refs(watcher), 2, "sk_ls refcount");
>
>  out_watcher:

