Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF8C43E4B1
	for <bpf@vger.kernel.org>; Wed,  6 May 2026 16:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778084006; cv=none; b=op13Ozf3SnGopDcKBFJr1JQj2jMSZ+DFLjXGIaNLA8s3OD10sF8x+O69Na/0OQfyE8C4jFzqXWWHff8zD19/9/0y1kTB3GfcUlwIURiYDhGZ/DFL/mxpCKiLijgQsi/oBm0+hfCYqmZ6C+1vpe24pYMPJbE8xcZY2u3UNVTVNj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778084006; c=relaxed/simple;
	bh=y74MLOMLH7c6TiNU9U7D07FV3MI7DGAyRAxDWGPqCr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iN6QmXa+4nMbajU8GWHWW75Xk3JCNRhmbtc8qVg5JL5EBQ1UOA/esHpq+sTc0Vy4i8vj/P3CRlu0pIfdzEMYbvowmxrSSdX7f+BJWefnZXTW9ZqD05RKon6t0CcWourq2rG6BdoH4oUxzl/av9OTeoa1RyzG46hdrypig05loSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AXo9f92O; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AXo9f92O"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-44e1ebb3122so1859322f8f.2
        for <bpf@vger.kernel.org>; Wed, 06 May 2026 09:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778083999; x=1778688799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=miII5ZqkJgNzle4NPFZEgC0UWrLh9zS7I5LiCOIJd+c=;
        b=AXo9f92OUr8D6/KP98f8KD4mHT4puYHtf51y6wrAd5SyEsaL8AriPMk3lXc+tEKmpD
         o1MDpzjFd0q+MARcc+U7PC7q1Uc7CsQS3n9aWWc8HY6Q1TgEacmkRIxZFsapyUbgr9RC
         lMGRqqi+qS5UMBC5qRzvCKyF6mdr8k8wwNgZTh2oyuW+dvH5+bKnttgFhCl9M4KRh8QH
         mpzcibNDmu/klHACxdMYDB5qrRJ2LsJNX0NCrtb77P926d2P4AOZ+7YyvTbnvhdhi3F6
         kz4Wzc1enuQZcz89hihMxx8VxCt5q5zVL1uMVue+giwD6C824dNpmx1aze50W2oYsQ1Z
         smZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778083999; x=1778688799;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=miII5ZqkJgNzle4NPFZEgC0UWrLh9zS7I5LiCOIJd+c=;
        b=RNzX/UOLf87dwvsKv0E20++xnsMGgPCTUkaMPYfN5UKvMU1wiUlyWt3Kfk2LGDVNIx
         zt5S8uB1hg6gqEDrQW21SyYxRwEf7XyeJZbylEfHPF3UkWtdYcrSlGnFxP/YVSmKKF7g
         uZJZ3dxFZWvhTsXtp17jrnOtPBNnUUaiHzO3BFU8LQhqfQjbRl4uyEnhXT0oA82ui5JS
         NSHSOdk1XmjDUYFewLPOcuEBLAjpjrsDDc/5jknWTla51/wzIsyejFMYBFirheTBuGPP
         0l3RkSPwq8oDHqcjU9RCB46v2UMlKPi1rsZ7s5+pjtofh09UcZc7fYYo1qssRDd/3mwE
         nG/Q==
X-Forwarded-Encrypted: i=1; AFNElJ8nBTiGE/twD7VZ4D8F5YIHhY+qo8YI1rW/ukEMQ/ONGiAPonA8/kEnnXOuw2tss8zVWGg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/zfMfXmhjIPinqPXtWDMgMpcSsMP8LXIRqVWYa3kbs+mAyzhm
	eFZceuULmapE3GDF6xz5VJQPlUOyPeUlk/VnChYsY11Ug/iBG3v36Z+G
X-Gm-Gg: AeBDievqLvT+H9V6dEMREvKm8TNwmxP6JiXmd6ETQxlCmayjQT2wUdS2RF9eHHJk9OI
	VmSQdCWIlMvnBaL7M26oavkeNM8vMYWftWOB1paEIvcPaGTe1va/SDT0Vfx+WzYLvVtZ9npkEPY
	yOImhbnmmUB2Gnh9ALSzBTs/oRhjMQfLRfmvEo+eDq8NiKO7uTlCSFim6ZAi1Vfb4UqTB5MJvf7
	wp6LbsfW7jxO5rcuQXJo6aRmLNYEqGEGncSgCVN5sK5Bqmfw+73oaICsNNAXalTgpMYqf5Q6bhu
	FhWdXQgvft7pHp01nbmam4CAc4Jx//5QRkN6cfMKGtLKhyTUjdZjGYbGIxpl4rC5m9+1jWeRDBS
	Rr4UVdAIAHimbYL3NCXiKvMptIsL76xmc6BS5NrR+LdIdbya0DC8wV5ECj9PaPYU7DF2/8vIEUa
	x7xK43zfnnxelBmLRIEbWKJkX8/odvRkRjpDD9BzLb+c1DtOrWKA+1401ZkpIIToCxwPDVJuiLn
	N2E2ZT8+ke9d4SRQqeLvZA44yC08ARFx0TMkb7+IHDP30uncpOH9G/DPsbQ1qZ07cvFVlNNQvF+
	qcRiNPs5A3N8qgGk6YQB6yV+xy8tCkrPrrdUqFEtezKFmGAgZYEYBA==
X-Received: by 2002:a05:6000:2304:b0:44a:52d5:e4f1 with SMTP id ffacd0b85a97d-4515b057373mr7262639f8f.5.1778083998855;
        Wed, 06 May 2026 09:13:18 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e00b5a044c6307a465e.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:b5a0:44c6:307a:465e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4504f4857ffsm13138098f8f.0.2026.05.06.09.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 09:13:18 -0700 (PDT)
Date: Wed, 6 May 2026 18:13:16 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Paul Houssel <paulhoussel2@gmail.com>
Cc: paul.houssel@orange.com, Andrii Nakryiko <andrii@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Song Liu <song@kernel.org>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Florian Westphal <fw@strlen.de>,
	"T.J. Mercier" <tjmercier@google.com>,
	Li RongQing <lirongqing@baidu.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org
Subject: Re: [PATCH v3 0/2]  Introduce CONFIG_CGROUP_LSM_NUM to render
 BPF_LSM_CGROUP attachment limit configurable
Message-ID: <aftonBG4vXaieFLp@mail.gmail.com>
References: <20260506150547.767315-1-paulhoussel2@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506150547.767315-1-paulhoussel2@gmail.com>

On Wed, May 06, 2026 at 05:05:45PM +0200, Paul Houssel wrote:
> In include/linux/bpf-cgroup-defs.h, CGROUP_LSM_NUM defines the maximum
> number of BPF_PROG_TYPE_LSM programs that can be simultaneously attached
> using the BPF_LSM_CGROUP attachment type. It is currently hardcoded to 10.
> 
> This limit was introduced in 'commit c0e19f2c9a3e ("bpf: minimize number
> of allocated lsm slots per program")' in the first patch implementing
> BPF_LSM_CGROUP attachment, and has not been changed since. Rather than
> reserving one slot per LSM hook (a 1:1 static mapping across all 211
> possible available hooks at that time), it introduced a dynamic scheme
> where only 10 slots exist per cgroup allocated on demand.
> 
> In practice, eBPF-based tools may exceed this limit. I therefore propose
> making CGROUP_LSM_NUM a Kconfig option so that users can tune it to their
> requirements, rather than being constrained by static hardcoded default
> that has been arbitrarily decided on the first implementation of this
> attachment type. On the other hand some uses cases may be interest to
> limit the number of attachments to a lower value than 10 to prevent too
> much memory overhead.
> 
> Modifying this limit has been dicussed previously in
> https://lore.kernel.org/bpf/20220408225628.oog4a3qteauhqkdn@kafai-mbp.dhcp.thefacebook.com/,
> where the same thought on this limit being too small was being shared as
> well. Furthermore, this discussion seems to have yielded inconclusive
> about to render it dynamic, without a fixed array size.
> 
> Changes since V3:
> 	- refactor test eBPF programs by using a macro (patch 2)
> 	- improve the kconfig help text by elaborating on the memory
> 	  overhead (patch 1)
> 	- link to V2:
> 	https://lore.kernel.org/bpf/20260506131257.713895-1-paulhoussel2@gmail.com/

We typically keep the full changelogs (with each version). That can
help among other things to get a sense of whether the reviews are
converging.

> 
> 
> 
> Paul Houssel (2):
>   bpf: render CGROUP_LSM_NUM configurable as a KConfig
>   selftests/bpf: add tests to verify the enforcement of
>     CONFIG_CGROUP_LSM_NUM
> 
>  include/linux/bpf-cgroup-defs.h               |  2 +-
>  kernel/bpf/Kconfig                            | 19 ++++++
>  tools/testing/selftests/bpf/config            |  1 +
>  .../selftests/bpf/prog_tests/cgroup_lsm_num.c | 60 +++++++++++++++++++
>  .../selftests/bpf/progs/cgroup_lsm_num.c      | 46 ++++++++++++++
>  5 files changed, 127 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/cgroup_lsm_num.c
>  create mode 100644 tools/testing/selftests/bpf/progs/cgroup_lsm_num.c
> 
> -- 
> 2.54.0
> 
