Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245424E1CE
	for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 21:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710366843; cv=none; b=RDnvWtsqS/kUH/c2M3t8YZa/4MtYK3d70aO3hDkzH4SHOBy4rJv32YiLvevQ9Lt9CQVXHYjvDY2/wW6caZaUE9kbQIJn+L+EKp1ocQ9EPHmWJHRD28ACX2BsxsbLrvusmIwhMwTzUo28ZpZ+KAsgoh1HhTpuzKtnsS9+r5RYWLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710366843; c=relaxed/simple;
	bh=IS+WsJ5TLvLtZdo+Uk62ZZK6uhmnItQcpKASq8gj7aw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tqupLys7LRoEduZW/lJACUEmmQqpk44pJul47eSDM9+Y74W/xxsnZP352HgrrjbKgDt9nrBF1K59t/p5ewwnQFi6Hx2iO6ZCOpHvLJDuqvzpsMxkyDGWTYtfmhLUuDBnJaktZxQar2ugsyFv/ASQZDxcZAYimMZmOAQMVL8cx6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cA6e+Bbz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cA6e+Bbz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710366841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2KPW5KF47bF+5Cf+8HkAv2DAr6yEshp1fbNv4HMysQ=;
	b=cA6e+BbzVgel1bDgxk6HnILWxb/+MrOte7ZAYORLgM6wZeP7brEMJobeQAtIhMPpG12tYm
	A07WMH5Ki1WRELc9WK9kVP6zbwJKKG/91c875UmjXd1dGzBVK04scrN3CCZssYeBX1gbyq
	u8w3PSPJs93EXFTxpSKIx7CR769aLK8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-IJtfRS94OHmUMUUKUMlW6g-1; Wed, 13 Mar 2024 17:53:59 -0400
X-MC-Unique: IJtfRS94OHmUMUUKUMlW6g-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-41312565bd4so1486805e9.2
        for <bpf@vger.kernel.org>; Wed, 13 Mar 2024 14:53:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710366838; x=1710971638;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E2KPW5KF47bF+5Cf+8HkAv2DAr6yEshp1fbNv4HMysQ=;
        b=MMb9yVtDrkpnvZ4B12CdvrvGuuzqgM3UGMQIF6AjvinGXgkc48nwszRgp0krynGkzE
         gm96deZEP8uhlXwko8WE5GaoPjNiei103ok9CiRwyMBmdhRGhiBhxkygOxtsYibZpnrq
         Ua8hg0URYT3nXyIqbKjVEedVp8QD6/glsAevXZ6lUjHkri0JNYdhEHAL36rKVoGf+UPB
         BbTJG/0Ovo9F2Mk0Z82s9FGUyktLmL+jAVyPAsmGixCjXLTSUNg+mBYiqI4nbrImJZ7m
         I94blPNnZFopvhi/1AD23yUACHVhm/nxS5409vyD04SvtMAG1H60Pwj+JPuTYRV/Qx1J
         wftA==
X-Forwarded-Encrypted: i=1; AJvYcCX+K4YUkbXOaUwt7SybKvRgRa8ecB9imsnI0Srb62F1/J124YrZMixHbB77IMQPsN4IsAJTnawBCY8JQV50TOGmOdA8
X-Gm-Message-State: AOJu0Yw24IpkNoteaGP5dKgn25O568kDGz8eVhcEBQKbkbnPmVkV6g+U
	RbiCqfAbfNoTVutOKF1SBzJShSCRuS6JQGUHp63+WmUy5YfPd5mhhIiiscOfiHDqAG9fwUCwwaQ
	idR9OnjYSWbvl7gCNzO8cwpd295szQaT44YPMdnlz8/gtdpli3g==
X-Received: by 2002:a05:600c:3d96:b0:413:1012:5b6 with SMTP id bi22-20020a05600c3d9600b00413101205b6mr49527wmb.22.1710366838609;
        Wed, 13 Mar 2024 14:53:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJ0OheeUPMmjuVVJzjxLnfhEvsYHX+e2ieqRk+uD2jbxBCs+tKv1zogU1HQmjXy61sfj7CPw==
X-Received: by 2002:a05:600c:3d96:b0:413:1012:5b6 with SMTP id bi22-20020a05600c3d9600b00413101205b6mr49513wmb.22.1710366838213;
        Wed, 13 Mar 2024 14:53:58 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id l24-20020a05600c1d1800b00413e6a1935dsm313510wms.36.2024.03.13.14.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 14:53:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 70547112FDA8; Wed, 13 Mar 2024 22:53:57 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Yan Zhai <yan@cloudflare.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Simon Horman
 <horms@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Coco Li <lixiaoyan@google.com>, Wei Wang
 <weiwan@google.com>, Alexander Duyck <alexanderduyck@fb.com>, Hannes
 Frederic Sowa <hannes@stressinduktion.org>, linux-kernel@vger.kernel.org,
 rcu@vger.kernel.org, bpf@vger.kernel.org, kernel-team@cloudflare.com, Joel
 Fernandes <joel@joelfernandes.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com, Jesper
 Dangaard Brouer <hawk@kernel.org>
Subject: Re: [PATCH v3 net 0/3] Report RCU QS for busy network kthreads
In-Reply-To: <cover.1710346410.git.yan@cloudflare.com>
References: <cover.1710346410.git.yan@cloudflare.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 13 Mar 2024 22:53:57 +0100
Message-ID: <87a5n1pzm2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Yan Zhai <yan@cloudflare.com> writes:

> This changeset fixes a common problem for busy networking kthreads.
> These threads, e.g. NAPI threads, typically will do:
>
> * polling a batch of packets
> * if there are more work, call cond_resched to allow scheduling
> * continue to poll more packets when rx queue is not empty
>
> We observed this being a problem in production, since it can block RCU
> tasks from making progress under heavy load. Investigation indicates
> that just calling cond_resched is insufficient for RCU tasks to reach
> quiescent states. This at least affects NAPI threads, napi_busy_loop, and
> also cpumap kthread for now.
>
> By reporting RCU QSes in these kthreads periodically before
> cond_resched, the blocked RCU waiters can correctly progress. Instead of
> just reporting QS for RCU tasks, these code share the same concern as
> noted in the commit d28139c4e967 ("rcu: Apply RCU-bh QSes to RCU-sched
> and RCU-preempt when safe"). So report a consolidated QS for safety.
>
> It is worth noting that, although this problem is reproducible in
> napi_busy_loop, it only shows up when setting the polling interval to as
> high as 2ms, which is far larger than recommended 50us-100us in the
> documentation. So napi_busy_loop is left untouched.
>
> V2: https://lore.kernel.org/bpf/ZeFPz4D121TgvCje@debian.debian/
> V1: https://lore.kernel.org/lkml/Zd4DXTyCf17lcTfq@debian.debian/#t
>
> changes since v2:
>  * created a helper in rcu header to abstract the behavior
>  * fixed cpumap kthread in addition
>
> changes since v1:
>  * disable preemption first as Paul McKenney suggested
>
> Yan Zhai (3):
>   rcu: add a helper to report consolidated flavor QS
>   net: report RCU QS on threaded NAPI repolling
>   bpf: report RCU QS in cpumap kthread
>
>  include/linux/rcupdate.h | 23 +++++++++++++++++++++++
>  kernel/bpf/cpumap.c      |  2 ++
>  net/core/dev.c           |  3 +++
>  3 files changed, 28 insertions(+)

For the series:

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

