Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E9A481DB
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 16:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347153; cv=none; b=s6L0+mVw25OWfWUTWyZ8hD987y06a/fJNKkUJgSJ9v/1diSZy3T7UCrcVIe39XQ5+y0tOjXrfJdf4ij1nAo+53stZ7ulE+Wd04dV6jpQ7bsvxci+Qo/A/6x6zoMIUvskoFaubkgyx5S35FUEV5b4DTs4/19RlJMqMTdqwXzXSsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347153; c=relaxed/simple;
	bh=yb4jRK9TMInttE6q+PR3jZu8SJZDS3zxRBM0iXRZdaA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CjcHuwSfTCAaA6SILqD08vy8tD/l12H5/Pib+9BtSuDsLhFsDXmdtggWGJ+v3RNQB8ze9JAwvF8zoD5B159qc1ULBNlm0Pz49xEY8hiNxbgCuo+tIZNIL1lem9MZJCp15oAeZm3k/Lq5M5DhpqjC9a9hjyY2MSckJswKM/kfLZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=b02lJKGC; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="b02lJKGC"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-690be110d0dso425596d6.3
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 09:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710347149; x=1710951949; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DadrGgosL3YryhdTAvt8AZb2nS0kYApS+oQ0568RY2w=;
        b=b02lJKGCL9bKyu9gXYrKcPdORweFkR4RW2SgxJhzAMUzbipKJuwyqvkW4kXHLuTtnC
         PLPYRzl4uGjKwOLbajBA6r8UqRMP4gmMLqfqQBGYT68RfT4PGLj8Z2rqyKFemrermI5H
         2XvaS3n6dXacjAMO1FmNIcTvM8v+dPpl8EbYveHh+0d/UilYE1PYaRBzDdSIBvYgb4W+
         iPM0XL9OmQOBwueO/p6LmF4kKht7v36B3qE8Y8XwPv2L/7efZuL8ofECxM2kY1uuefDP
         VQxJloBUsvjkkLABC5wFmchllkmucv7G0/23SdRWEV4KsGwFDCKHdqvcJd/szBeYVruB
         2pIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710347149; x=1710951949;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DadrGgosL3YryhdTAvt8AZb2nS0kYApS+oQ0568RY2w=;
        b=e0WA4h08H8VciXdx8jRmGBQVzle9I5UQPCMqGpfyaWF8K62siW5JTY+70X33maa+yz
         Dc44FdI2GwsGaacdIs1s1/iK2KJGlZZmj804Gp9KW8lbAU2HZ9e4awsxA2EoW6KH/79a
         CUvzEGis9Vk22zm10XJG/IdwUFFLExdSSGz5woqS0W15JLmcBYnUP8mvErCVl5OLHC2k
         l3Dz7qvVxHiE9JPx6cG84RlJy9mL9SpDKUwjrpVqXroGDVl8dt69Ulza7PKao056Xzms
         kTjfUxZhm6ekYufsbsuI5SF8RYEHnLtRdDlmUlqvOVy0sR2jLMcbZhqT20Q/BTQixcTO
         O2AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfB/8TUkXSN1mTdGkrcVKHLflvaHcVdt6ZdImTL6Gbgm3NtNIgjZdnT3U0icJVlixoUUy+DzhobmsU1TdYPx0VcAd8
X-Gm-Message-State: AOJu0YyE3II1mWHzbaOsRPeNe2YV8Yggwq7E1H5uEHVSqhNOZ8cTTFn2
	HdcNfjLMtjN3/gICfZ3aN/hdi01GKfI2dr8hohLGqp5sUJljO1hkUBnbb/cVZGw=
X-Google-Smtp-Source: AGHT+IEyo5tKDcSWoxixlYGVqG9bZ4LNG2VjJrGAN13tcTVJ4L3ooYeXW/5GADQ+vNBaR4uTwySDrw==
X-Received: by 2002:a05:6214:9c7:b0:690:def9:18d9 with SMTP id dp7-20020a05621409c700b00690def918d9mr339944qvb.27.1710347149560;
        Wed, 13 Mar 2024 09:25:49 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f91::18d:37])
        by smtp.gmail.com with ESMTPSA id s6-20020ad44386000000b00690c5cc0ff6sm4238154qvr.124.2024.03.13.09.25.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 09:25:49 -0700 (PDT)
Date: Wed, 13 Mar 2024 09:25:46 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [PATCH v3 net 0/3] Report RCU QS for busy network kthreads
Message-ID: <cover.1710346410.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This changeset fixes a common problem for busy networking kthreads.
These threads, e.g. NAPI threads, typically will do:

* polling a batch of packets
* if there are more work, call cond_resched to allow scheduling
* continue to poll more packets when rx queue is not empty

We observed this being a problem in production, since it can block RCU
tasks from making progress under heavy load. Investigation indicates
that just calling cond_resched is insufficient for RCU tasks to reach
quiescent states. This at least affects NAPI threads, napi_busy_loop, and
also cpumap kthread for now.

By reporting RCU QSes in these kthreads periodically before
cond_resched, the blocked RCU waiters can correctly progress. Instead of
just reporting QS for RCU tasks, these code share the same concern as
noted in the commit d28139c4e967 ("rcu: Apply RCU-bh QSes to RCU-sched
and RCU-preempt when safe"). So report a consolidated QS for safety.

It is worth noting that, although this problem is reproducible in
napi_busy_loop, it only shows up when setting the polling interval to as
high as 2ms, which is far larger than recommended 50us-100us in the
documentation. So napi_busy_loop is left untouched.

V2: https://lore.kernel.org/bpf/ZeFPz4D121TgvCje@debian.debian/
V1: https://lore.kernel.org/lkml/Zd4DXTyCf17lcTfq@debian.debian/#t

changes since v2:
 * created a helper in rcu header to abstract the behavior
 * fixed cpumap kthread in addition

changes since v1:
 * disable preemption first as Paul McKenney suggested

Yan Zhai (3):
  rcu: add a helper to report consolidated flavor QS
  net: report RCU QS on threaded NAPI repolling
  bpf: report RCU QS in cpumap kthread

 include/linux/rcupdate.h | 23 +++++++++++++++++++++++
 kernel/bpf/cpumap.c      |  2 ++
 net/core/dev.c           |  3 +++
 3 files changed, 28 insertions(+)

-- 
2.30.2


