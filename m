Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6929D263C7F
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 23:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787094123; cv=none; b=RlwTB/JQAzIPfUumwaGY+FQx+xKd69PsOKErm53+eYdjWkV+U3Xw/wshd+T5lVJJ3Aiisix/yjIUW6RpGO05Z+6s3QO2Y53nX2qepswlXAiDHMGXm6yR/RYr0Jza8AZBoCyTwX3ZdAv7vdpwpCg/tjzkKpzm73P4JQRKQ38oAEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787094123; c=relaxed/simple;
	bh=LFNPoDeeTwavqXDYvxKz/k1t7gN3cxa/PZ/r6DBfaz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUelhcvjxTENF8jN2IGwia4u0iJpockLfpzV1sKCyk662jUbdK9JSu5Yg8N6iiAbTgja9LZMSRFyr9Vnokk0vdIskt5JkEHzbSWgv9pvjLe5ExpQAGzQte0d28sx4zjRYMK4w2RvJKk1w8fb7XrDmfOuW97sPjVJ3XH31C1z8X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/xOsERq; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/xOsERq"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d01663d816so2870555ad.1
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787094122; x=1787698922; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jjfWQTULW6kpWj4uQcqe65fiA3Rop9X8RDu4HH8k3wc=;
        b=B/xOsERqIgCHWDOaMzy5GePw25OdJ9GeVqYJEzDQPsIyPRuRHWsfBJ7iAwZE4fZGC/
         l3fsT0PvL4SjsE49AnYsX1JiOi5gMeLe+nEvZK0AKBn+gx1GEp+8VJq2pHAGJjVqBS2n
         g/pasXB8FcgNvFReysZ8YVJQ91XHEnZEL9mnrSttJnjRKA9Kp5XDI+e6mYtqYk3/Wck0
         0Zr6QDaU9O20NrnyZCccqQYHXVpQePtC9oAum1JpSCQCiwFUBTFV4TsznhIz0wLeQ2lb
         jXRBR1ntij6h0j4ZYa8UtmMX/Oeq5dRwpSZTEHh1NOusZmHE/L/1SH66/yKgK8PMFVNG
         vUdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787094122; x=1787698922;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jjfWQTULW6kpWj4uQcqe65fiA3Rop9X8RDu4HH8k3wc=;
        b=K5taNZjh3HCUg4XLa508XvqF5STuhjT04RL/gWNrJhDl7uPhAvtsBhb4ExVfFpBcS3
         QkMcBxiI85njCxPTFLaM0OqztmAbxHq76Kt15fBqhK+0AHkTb6zwiN3OvXprzmrFWTJe
         +zqa0h0VW9C2IhWQbn9vbIi3a6SyYi7s74n+dn1uoFpLbsPvczsdP7Usm9pFezrJGvhy
         4E2mySvNaXrFjl28SpYTV1jfliqm/FJTppPwM1bf1liodf77fJCA63m/I039Q2Dd4d0Y
         Xa6XaNqQfWMQl7GDbZkFAEwIqwNd46YY7AssJqNYNvSXsCZr1/LwJ7FyNSYKP+SoeO09
         U7Qg==
X-Forwarded-Encrypted: i=1; AHgh+RqNIoD8fY+tB4nXuao+bMJYCvsOWKedlvGr0nP4qnA8Ibua8PTCjjIssg0Mvuv/wzIkl+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiRnReXjJCVkS+Bp4TfpX31u7cT28tilUQEb80qfrbVq1y9Qpf
	yfn8lhkhmk5ouGu9liOMVrzbW9MJZjl+rCRJnZsBukYCjegWfC5lt+Jk
X-Gm-Gg: AR+sD1266/FF3UQrR5MB3oeDg2oxqo3tookT51kbxML6JDiwbFyHoB0oBxNA71JELA8
	wX9WFWtP0s5KibWSSkat7Tb0Ax8S2bcTUV+UoT/Fkrgfz5TiXQgPY3QXR+U7/fcsjdgo+hFpYMf
	wKrqfa7/SP7xkFdKVL6YmtEKE3jl/pyMe/8WVnb6BKzGr930LMVlr7a/q2xUQ94Doc60hH/KBDO
	uWAwcScVLAjHdvLDRRGe5p08YSZM0jx1AHg7D6CTwZ818eJzpCsnostINd8dvS2fkPQUXqCqwIg
	fbwD7Y9Lvz+JQd5rlWbUr1qIv+QTwmiqzStXhif7eaQGOHfrv80mRXyO8LN/dpwgDvC6SHTcl8w
	Iu4JnBkPRMP83xdBdiu3eLGDHWv+foSfGnDdXEsmMNHSLgp4j13/E/q2viUQQ63UGHUFO9lZabE
	ys5wT4fGwPYeb0/7yPmsLD7mFPTYMRck7jxY3jAqUcXKgf96wfSsVeDn32Q+M4ce+bwhQfqLdHf
	GZkayAq
X-Received: by 2002:a17:902:f682:b0:2b2:67ca:5ff9 with SMTP id d9443c01a7336-2d5fd41d626mr5840475ad.0.1787094121673;
        Tue, 18 Aug 2026 16:02:01 -0700 (PDT)
Received: from devvm16600.scu0.facebook.com ([2a03:2880:9ff:64::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3bb51sm456874eec.6.2026.08.18.16.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 16:02:01 -0700 (PDT)
Date: Tue, 18 Aug 2026 16:01:58 -0700
From: Ziyang Men <ziyang.meme@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Mykola Lysenko <mykolal@meta.com>, linux-block@vger.kernel.org,
	bpf@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] block: add BPF kfuncs to read blkcg io.stat
Message-ID: <aoTkZhQDoaQKpPe3@devvm16600.scu0.facebook.com>
References: <20260817214205.723267-1-ziyang.meme@gmail.com>
 <20260817214205.723267-2-ziyang.meme@gmail.com>
 <aoSUob1s8WBQ3buO@slm.duckdns.org>
 <aoTdQeLZZuRirNHE@devvm16600.scu0.facebook.com>
 <aoTf7u20mo9s6ADj@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aoTf7u20mo9s6ADj@slm.duckdns.org>

Hi Tejun,

On Tue, Aug 18, 2026 at 12:42:54PM -1000, Tejun Heo wrote:
>On Tue, Aug 18, 2026 at 03:31:29PM -0700, Ziyang Men wrote:
>> Ok I will add the casts bpf_get_blkcg() and bpf_put_blkcg(), and remove the
>> check of css->ss in above functoins.
>
>RCU_PROTECTED is probably better than get/put().

Yes we can make the blkcg* RCU_PROTECTED but then the bpf_blkcg_flush_stats()
needs to take the @cgroup* since it is SLEEPABLE. Does this work for you?

Best,
Ziyang

>
>Thanks.
>
>-- 
>tejun
