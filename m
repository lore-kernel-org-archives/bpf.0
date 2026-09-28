Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA9C4E36D0
	for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 16:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790612058; cv=none; b=bME6dhlGmLC3Vluy0Odurfmq/aWLWLXaA0kiHSRPIJDjKDjOUxApe7yuIFLAqVnyU12roV0f2S4/uGyc70A2WX4W1hmz2Xm7gBI1qfylCAqMuLlVS3yynUWPQYiSgbVTP4pZ0Hgat5EY6aXiKYHwiqXAGm7hqP6BdjTZCF+G9Ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790612058; c=relaxed/simple;
	bh=0mNiBoZ+EjTYD7duzkXnrvojGRhNpWwj6eK4k43UdIg=;
	h=Content-Type:Date:Message-Id:Subject:From:To:Cc:In-Reply-To:
	 References:MIME-Version; b=lkKIeAkhvZixpxMhncycwde9x8Wo3qDVWA9PRY2YBgbhElNYxKXgwfE4V7dC4MinRE9AsXeXT3zR7FbNs3yFTiMQHz6agz2MR0wRrfMESC9IPxmN1RmmehmOY7aCJBNjdj+x2hp/MNmgeUs0kepYUu4I44vzrVbhK2+V0ZxHlK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVrbvnSu; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVrbvnSu"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d8fbef5018so22040155ad.0
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 09:14:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790612047; x=1791216847; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0mNiBoZ+EjTYD7duzkXnrvojGRhNpWwj6eK4k43UdIg=;
        b=VVrbvnSuaJz2ZwHKMfTDbeWKgGXlU+SRNnvIJADJjM5ZCLiBQUYVygyAhCJbAqdWSV
         vuomXrcTbVzHgRzEAWTIoP3CFv30oTmNyVkjT7oTsLd13PlpzPqIvKYymFB+NrD7UqEM
         AM3oHV5JBdB0jWQRZE/DcfrTBlSb6otB5azjhbORu1ncBEMfjiIsmepG4nS7e/WXNsf9
         r9zSmzrVlIFU3aqLgnd3ox49iyY3K061EvfEFpYc8FO2JIKJfeMsiP7c2Y+NDsDH63ih
         G/9WlONkPQsbWSvgGo03OIc0AXlqu2bhDmRyV1l9Qwmo+G0Ta0cal3qQpR/B9oJqEhhN
         quuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790612047; x=1791216847;
        h=mime-version:content-transfer-encoding:references:in-reply-to:cc:to
         :from:subject:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0mNiBoZ+EjTYD7duzkXnrvojGRhNpWwj6eK4k43UdIg=;
        b=iy5xe8JtCa5CK2GB7TGnGt9o6eHpsq/VL9t4YYVdJ8b/kNyT0RaNczrc1LRoSmcog9
         CAy/8oDrS7ITH6AxZntTnaoYeRrJ9cfxykTTq0jkcYOS1TWSKhugTJTfuCpVHQIM81S0
         PBJ+e1J+q3oTrLab2DXUj9qo7wbIg052Ts5VeSMp85tACyiFDwEVnIign8PNw0Orhmn+
         smL13ZVOxlTmwV8E/7nIdI9Xn+9xDyvJI2N/46fyCjVNYJaahE/mMZ90nHZldzSkNjAO
         twHrmKXJaYof/8aPRz11uiep0Enw+Zv6E3UGEEsdXFJqz1dH3pzdpwnBftQodBqzXkoF
         f7BQ==
X-Forwarded-Encrypted: i=1; AKwUvBwCMLe/23CgYJH0xqlZUTP57Grvq25OkSAJso/56Rxm8mg8VArGPAIXhITi9cH2KvTkSv8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIbjXXeusN3jn+oSqz3wSchwrLn9ht6mdTk7Zh2o8P9qyoXZIkb
	Q+8PQEB2R4uJSnFSQOg8091ZLNuHdi4roIidmcd5s8a2r3kJ96Kgbz1f
X-Gm-Gg: AYBFou3pMaj3tKt2/VOZjJPdog0OBwPa8TmV/kaJxfkRIuZPr3nMRoNUbEkkVUcfDwj
	Mi5tH44KzK4RrO3xag238NFJzlYNopXQ1X1YAbnCavgVNxJkTGVbqigkd6xc2+1gPllg/WuSdHF
	EqSYxpoFXU+pZeUv0B+Ys+J4yov+Y63dqGdZrABX4ZaWCHulIskcd2egt0JVgjlp6uw0OqEqm20
	fy18M4O2H+jU6kMbgGFa8y7flLrULTp+iv+pCTkdiNxg7oeplSROOR7bEAeprck+8k7MqdUHmO4
	hV+sYQVd+LbKwWXDhrzgxK0OehoMzkLb597ZcAydOyTY6b9Ldd11o/PaTUjg5VRcFJJkn6SVAys
	ulw1KFDkVEopqNC/xaR1JGAjP3glhCkNY6JYzNOGp+G6V80UvwnYNPumgcDXMySNDt7irSNPgZY
	HE2ctsVsTbdwdP3AHSXkEqSMMxDzitF7oYcpxmP8ep0kkJK5qmFC/lZzi06408N3DWpSgIQfVVS
	b4mofPfSgd193p01zl+S3ChfWmhbkUPSStlW44MIor/HNZwOlaJ+CrUBA7zxzf0XmCITwupPzdb
	yhU=
X-Received: by 2002:a17:902:ef4c:b0:2dd:ad74:ac20 with SMTP id d9443c01a7336-2df7dea7d02mr104273185ad.27.1790612046704;
        Mon, 28 Sep 2026 09:14:06 -0700 (PDT)
Received: from localhost ([153.61.198.245])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df913dfea3sm43852325ad.14.2026.09.28.09.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 09:14:05 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 16:14:04 +0000
Message-Id: <DLR2ZT65RKF3.3KZ8O8P4VKTI2@gmail.com>
Subject: Re: [PATCH net-next v2 03/14] bpf: Make BPF skb extension survive
 packet scrubbing
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: "Jakub Kicinski" <kuba@kernel.org>, "Daniel Zahka"
 <daniel.zahka@gmail.com>, <netdev@vger.kernel.org>, "Kuniyuki Iwashima"
 <kuniyu@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Stanislav
 Fomichev" <sdf@fomichev.me>, <bpf@vger.kernel.org>,
 <kernel-team@cloudflare.com>, "Daniel Borkmann" <daniel@iogearbox.net>,
 "John Fastabend" <john.fastabend@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar
 Kartikeya Dwivedi" <memxor@gmail.com>, "Martin KaFai Lau"
 <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Simon Horman"
 <horms@kernel.org>, "Jesper Dangaard Brouer" <hawk@kernel.org>, "Willem de
 Bruijn" <willemdebruijn.kernel@gmail.com>, "Florian Westphal"
 <fw@strlen.de>, "Jack Wang" <163wangjack@gmail.com>
In-Reply-To: <87jyo5bcgs.fsf@cloudflare.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com> <20260910-bpf-meta-inside-skb-ext-v2-3-0b21e42180b0@cloudflare.com> <DLMVTU0WA4OA.BWWVXT5BYT8V@gmail.com> <87fqyypp67.fsf@cloudflare.com> <DLNZU9RYL0GW.CHHAJ4R62R9M@gmail.com> <20260925121849.2ac5150b@kernel.org> <DLONQQN0RB03.1NVWVFHGRRWV4@gmail.com> <20260925132004.171b751e@kernel.org> <DLOOI89GKM5B.W4XPBNJUXRV1@gmail.com> <87jyo5bcgs.fsf@cloudflare.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 28, 2026 at 05:52 PM Jakub Sitnicki <jakub@cloudflare.com> wrote:
> The correct results - as in reproducible and with lower variance - are
> the other way around - BPF skb ext is cheaper CPU-wise than gated skb
> tracepoints. Please see:
>
> https://patch.msgid.link/20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com

I don't think these numbers measure the mechanism either.
cpustats.py divides busy by ncpus, so +16.4 and +6.6 are the mean
over 6 cpus, while 146k pps is the total of 3 flows.
So it's 6.7 usec vs 2.7 usec per packet and not 1125 ns vs 450 ns.
That's a lot for one kmem_cache_alloc/free and a 16 byte copy.

Pls share perf report for both and rerun.

