Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9C83E51F4
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 14:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775139452; cv=pass; b=LfejCDQ+yLtpxAcAtYt+CH0CfB2L7FlDKTgD8gs15CGxEgRnzS/OTxTUlpXmHRwl7tLTKdQmi8HMMBpU8aayBPy25uo3sbYrGr5qFmXOgDcQvUuq211XkN5GV2sbZYPDHuRj4RT3J4XRyInwgVl+LK7lJMzvXN7NH4wdNEl6Ric=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775139452; c=relaxed/simple;
	bh=SURcYKHTGeY420edRBwFMlG5Lhq0YY1jLS/thZEEVPk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=k/wadD41xP80kWJwYuT+qlSBu22XyGVQBi1scPFt69wGyqlGDNUW4IeeL/3L8zI2cBnIQIXJTVvSK+KuvyBlNJBBchrjVdBiOITlXXMMA+LEVW8r43eZZCA8+LCa9ic8gWHBeRv9QTUfgrjTb03LAWK5vq2RM45FYOXv/+SFUcI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lE//TmXT; arc=pass smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lE//TmXT"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-486507134e4so12243375e9.0
        for <bpf@vger.kernel.org>; Thu, 02 Apr 2026 07:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775139449; cv=none;
        d=google.com; s=arc-20240605;
        b=QkOTpImhwxVHkk8CsQnmM7//Xwd3Qv1VFUtkao3qMuod6kO8pxREpVEJSn8/aG6/ba
         8IOCUAlVyMdNW5pqwBju4OuvPUOHw5DsbzomRzS0rau9sFAko6nXyZ9UVWKn+tdMk0ts
         AMvr+iSd9CFpOULdT0HUVo/axF8rQM8CbMcGjf2fwIyTkp4gxxZ3yqnR699xDR083waQ
         Z8Pso1b4BRa1lSnF1Ft1YUMgDxvYwL1Wa6oneZ5nxjgGa4HBNSL+mGYg6y/sOVTTjeOG
         iFgYQxMr3kPAfBPV0hwgpIVBbZ0yUbk8zvahRRffYve/Wl4xoTsPev1gZTt1jDq6o8sv
         Jt1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d02dseYsue6RqQDed3Qbak8xxKACKmJGEDfYW7cOJ0k=;
        fh=tsDqv3A2RBAexvnLqopkABwexBs5BQ34yuhFlSIGfkI=;
        b=YsEZp4BkfWUeMhCcAPCT+d8ap4jhW7XuJI4KBsYtPMXxsXyv/S5RcVncTzeROgohqw
         BT4GkmMHqddvVa7r5TUkjgooBYK1bS8MdxaiPrMJ2wT/e60TYSqEf8lsNlqmINdiOSI5
         uyCYoOoNydEf8oANZa45XAvrkBW9Rv9sZCVFYTw8L9Bojom6y+fCrGzyWmm53DUKotcC
         YbX8GvsJdnm9Q8DLpszz98Tu9Uqu9TNoW/7wtfsuNQGmEPBxNxgpBwGYCaxFKtOQafv+
         xPh3L8mX/Fp5ZtjPosoeDBvzPFXpH7ARpRe4tj5tYIGIqzwZMa2xU6ehac/eAukDjdrX
         VVSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775139449; x=1775744249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d02dseYsue6RqQDed3Qbak8xxKACKmJGEDfYW7cOJ0k=;
        b=lE//TmXTJ7IKfAML7iARBqS9YvfdkkrtpbsRmByY70seu3DvAML6TMVT8sWshilhJS
         AMoPNpdlb/PB0HLhNv7WPovdIAWVQTNGp/oB3K2+XYqiTZ3KxUs6q/QCt/r58s4Qyq3H
         x0s/HRP7Y81Js3KnjXt9O/c6O3IxwNuR1a56JRCnWq4YaY4vnqUDo/Cl/6kudDjyO/HQ
         ryVjBWb+o+Z7QBPXqNZOlQ47LyYFHoliik9H0GEplxJSDeuBM78qxi28Q0j8k7HfbSZ3
         iU309dy4y2JwGoTfmErWWyUakl18OwqGN8kXR9vzB2t+TaJ0tKA2ShgeHvHMZC/KlwY8
         x6rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775139449; x=1775744249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d02dseYsue6RqQDed3Qbak8xxKACKmJGEDfYW7cOJ0k=;
        b=TgwAyIIsaG39/jawFROST0RWaNI2E5EnDkU1yWl6GH+5BUgTRgY6ZZeXpyLJjvX/xI
         m/9laGcgsQupFXZRxAyxsvfarO/LpRTQoaPCYZAhmf/FvvAyRpKDnH9U8UTezU5N7Edb
         DNdGUO4DuRoIwCm74V8LcIN76xhjdUIqvNHMRqZ2KXEevthdYAuVf4N5lbvj+X1Xs6Pj
         wpbNco5gev6D2Mf5p0BTR8OYZJojizatmsG3CWC19NwqGjKOyIpoZ/C29siHcRRIYUOI
         +4oXJN+w8Pdie0X/eIrp9ZCV2VyCRwR12SOplbRj/uPZOsP6ep6MhB8NzXoDHIWNyRzi
         AkQg==
X-Forwarded-Encrypted: i=1; AJvYcCWtutDV7lDZ0aBrbvnOumOaMgT1HdeRWExNS2L8lY2hizPZBXyfyFkLz4qe+LrfFjq/Sc0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUDQBAGAZGfU0nREfP9pejtEihfOcETKMu5HyMZfQObiRnZP7k
	mZFoJ/jdEudX3mOT7pho8UK/tfT7RsMsulKqiiPOUtyymTGZhbQNe0PDvbU9+vDi1KI43ZXmNdE
	G+zaiH0H5O0oq0gz3d1TzdcF5tk1VU6w=
X-Gm-Gg: ATEYQzxKo+dagoG2RYQOfMkIbL61no6BbrY7aJDrLaBQThk5jr84hQkLEkvFGs1QJYF
	0A6EgKo3hCCp50RTWH0tLz501zdGIYJvzID7OJjwap/lJAF/LVy9x6cNl/QK3kT29xvMUA0oOGK
	YqvmapUDZCA6lN8VmFZ3cjgmOOOPHFGWlS7WKpq87zZAf2rH6abSnH9v0vlFLAE8yi5719QS+eT
	THOWVbveL4iEL9mxp50jVDTlGAov5+0va5+EVxVgcjuukA4yVrr25+5+3WW68YN5/XMjQOTHV3X
	wxGW9IbcpKf/gV1KSrZFW3xDwJTZObpFY4MqLyuraYNLfktGf7RwI8o24SZLzW8rzK7aMhS8sV4
	okNf1xlxMlgVGNNnbJG5CuXsJFw==
X-Received: by 2002:a05:600c:858e:b0:485:3ee1:eba5 with SMTP id
 5b1f17b1804b1-488835ccc9dmr113145145e9.27.1775139448943; Thu, 02 Apr 2026
 07:17:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7653EEEC2BAB17DF+20260402073948.2185396-1-xulang@uniontech.com> <420FEEDDC768A4BE+20260402074236.2187154-1-xulang@uniontech.com>
In-Reply-To: <420FEEDDC768A4BE+20260402074236.2187154-1-xulang@uniontech.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Apr 2026 07:17:17 -0700
X-Gm-Features: AQROBzCJN6KLhJqu__wW0KrOg081-PAJ5P8_idZtDjyZtUY3LslIDvZlJbUtBto
Message-ID: <CAADnVQJawYEk53kS9-w5EXU0GnUYWWW7AF_n02bUs-GPJ+4Raw@mail.gmail.com>
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix OOB in pcpu_init_value
To: xulang <xulang@uniontech.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dongliang Mu <dzm91@hust.edu.cn>, Eduard <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?UTF-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>, kernel@uniontech.com, 
	KP Singh <kpsingh@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Paul Chaignon <paul.chaignon@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 2, 2026 at 12:43=E2=80=AFAM xulang <xulang@uniontech.com> wrote=
:
>
> From: Lang Xu <xulang@uniontech.com>
>
> An out-of-bounds read occurs when copying element from a
> BPF_MAP_TYPE_CGROUP_STORAGE map to another pcpu map with the
> same value_size that is not rounded up to 8 bytes.
>
> The issue happens when:
> 1. A CGROUP_STORAGE map is created with value_size not aligned to
>    8 bytes (e.g., 4 bytes)
> 2. A pcpu map is created with the same value_size (e.g., 4 bytes)
> 3. Update element in 2 with data in 1
>
> pcpu_init_value assumes that all sources are rounded up to 8 bytes,
> and invokes copy_map_value_long to make a data copy, However, the
> assumption doesn't stand since there are some cases where the source
> may not be rounded up to 8 bytes, e.g., CGROUP_STORAGE,

why? Just round it up there instead of penalizing perf everywhere.

> skb->data.

what that means?

pcpu_init_value() can access skb->data ?

pw-bot: cr
