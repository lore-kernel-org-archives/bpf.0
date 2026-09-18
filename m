Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938FC4D795B
	for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.99
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789729136; cv=pass; b=ozVxhFMKJqog1bRYRU5VDSGysvWbJ//17dY1xjSfey/jtHySgXRvoVCqc+Y3J0P2V+eI5Z9QQfS4IS9NUz3CC+S6n6Idpo4vGAy+0DsjTPQJvTkR9F4d1ZWTzFD4M17dP++y1zsNNOetsYOTynHQeoDPPLILDXNUEo7XSw/Qrn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789729136; c=relaxed/simple;
	bh=PU4xhmlWx858BmE7gAAS85VxJCPseREW97uqiUcKVyg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KzoKFXiv7O370oLkitrVHqv8qd69c/j6lQitY2nl0YminajhY7Q57XWhhbewkD4FD6VWKpDX60CW1WiVRKjatgycnGCRgP0hsVSOz9uavNo+r/nnbWnVEsCv9tjbBFncFr8JOfnAer3TfEHEclihTBJNina0+HMA3sOkzZCsb6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qg9uBU6W; arc=pass smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qg9uBU6W"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a6056c2064so668959a12.2
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2026 03:58:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789729133; cv=none;
        d=google.com; s=arc-20260327;
        b=cyVm+bTelOBdaN2WCkLx1lvP5GILQiLqjibIpfFPbKGQ3kEsv3rv+vn5nn938f4ger
         XvdB/oo0ObK+xhtdPKJJJtm4pbMEZ3cDHs6QKHLezK0SqSFJGQY6aOc3qJl6kyelY9te
         1XQoDqrMGKfFTMn7Hi697pzphBVlC/zqMWZRYKKsTSBrMJ1tvHFiqhpPzJvc+ipWjuNO
         Woiw/RN43Yse4pukVNA6GOSpXXBgS4Y5QaX4vvwY1M/kRCEBKH5Ifx2+9gyvop8T3BB6
         KBV1zaS8hr8m0qkbA3uQDbkkeVCQ1FSmrmiJ5r+uw73NkiXgbXKXi8sbTZ83NUFm4umz
         /vqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TMlA0tagVtBjA8CCzucBdpIo0a7MTz4RNAsPRQEaGLQ=;
        fh=+UQKyWD7vKCKBU5+NBnF3AlKFsIWeEbgPWafBO0XOa0=;
        b=jpgu1Z3x3gKR8F2kGvZKMzBJuhjjiLEBFGp/EORZC/6Jgsb7dIQMQDpuBw2PSTwLTL
         9HYy6P3Q26iVm9hJI30+z91ExCSzu4/KuzuWcavOGYnngNOWEsP2L/0VLYMlUILvNk/Q
         ESJ9Kzp3kDtYt3t283Hv517B0ptLP0h+YQ0eWohXjfmASK7I/PeedD0gY1jNxzx5HnM0
         mjgqeyQuKC8a8P6sm7g4rCH/PL/I3xlvEun9zhkgW6XV+bVs3vwgw0ZqWxPxuBb+Ytnc
         7sefqdEEQv0o/ChpX+Ne9IoJEoNxF66W7M86OLvf0Rpe1WoS3Dx7JmTzGO+rv5xXiJfj
         BNUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789729133; x=1790333933; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TMlA0tagVtBjA8CCzucBdpIo0a7MTz4RNAsPRQEaGLQ=;
        b=qg9uBU6Wbtt/PrcgcTz3vqvEsOLvMhziTScyWWiwCcA5pOLloCJ2fNDO6ZNrcVDLAl
         IsThsX0TApaEVuyzKvbSLLqMilhqC83YiuF82mS3GpjdB+RlNhFWZWcPpTTFN+JKyQtj
         ADoHc5GAQmqkBOSeAVoS2lvzr55HXljR3XiakLZVfwlbo9YQA4AhD7HNJSeMUFkDrLFH
         loGtB/FV0XiYupgEIgYuA4ViqTUI5ycGfyndulT3AxT9Vtaw97orDzYDwcMFEl8YT7ud
         DRJMc30zJRpPlG2ppQGaeYEPX0LO6eJAQNcR7sJesIvEZRtV3WFKqLY8Xk8HsgqjATIK
         g2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789729133; x=1790333933;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TMlA0tagVtBjA8CCzucBdpIo0a7MTz4RNAsPRQEaGLQ=;
        b=LI4nMSezwFppT7gQnP8WDGMUefxXCtu+LWTh9iC0101qOjZ8EvBmz6KY5CyNmhcxqN
         ZpM7BJtCOrMH3Keursmu8Wyl6NKHqMbwX83ZOYevjTwj8kXnOts/AauyBP4mtTWhaqtv
         t3uD1SYlN1jnHDPgi64ZUidx6S6iTeRRCmIjlTV2+aGHjp0iH9mmkT9buo8re+maUvQB
         uynCCYqsKKjvzVZGDs032t6c0yvbfXrvozQ5mLTQlczHIbAKNc0gD660qK/vqc53381Q
         Avxm+9y4+DCSr5WKpSVdEykX4GASJp+N9jBGWWCJP2Vq3DmjZrL/YM7x62iSYj4ybLhf
         BMtw==
X-Gm-Message-State: AFuF++kqWlj3k1mXqFeETbz3VisPv6MqtkPUkWMWQ7UzDOFMkrKEpJhX
	U3jhDMFLpbNBGcT5dBfITvcRzp9FGqb2eYyYmT0dCMkZPfb3A3Hgp71iyawXWEZSwJC6TxSweaL
	Tet2BwleLAKLG7q51Gh2qGpis/UydGz0=
X-Gm-Gg: AYBFou0jcN1IuNbOCgZwSSQ+yiGZ2LUKDB/8mhkwdm94PIQ7JM/bPbKgwAzv+JQJ4kd
	S/h1XWCzby030JuauED1bWtWrRHbIj5sL5PxMcaYHCVyt7UWETkdS8w0lclBlv114Bujw4f0+eR
	U3P76cruka2btOzmk7KSSEk5L32/JveCyS+OyPPd8hx6iozXWpa7TosqDn1gP7MlPX94DrJKA1f
	1dbkC8I6Lcqn9hk8VL11whDPTcLeThu52VboWYtLFzcb66G/6Ml7QEKfeciwrwBhcXwLNR0MIV2
	ev1KuN4MI1Uh/c4Nij1fN1R323Sv2TwmCXWUQDmy2+kJ/GDC6JpQ+QJrbUKn/l5jZznI00w=
X-Received: by 2002:a05:6402:3044:b0:6a9:a137:9ab with SMTP id
 4fb4d7f45d1cf-6aa5637c07emr846362a12.20.1789729132429; Fri, 18 Sep 2026
 03:58:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915154248.3612028-1-puranjay@kernel.org> <20260915154248.3612028-2-puranjay@kernel.org>
 <210f1bfa-e6ae-4d1e-a920-a6c8c9b4269f@gmail.com>
In-Reply-To: <210f1bfa-e6ae-4d1e-a920-a6c8c9b4269f@gmail.com>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Fri, 18 Sep 2026 11:58:40 +0100
X-Gm-Features: AcwNN1XZfTXkkKX_3JGi9RfSU461tgxxBg-bsGDiIbVR7bDjvuhObthNgEN_2_c
Message-ID: <CANk7y0gzipiJrObW0fbh0gP2DgKeZAUvCNuvaOdJrGWgE81LkQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/4] bpf: Add bpf_call_rcu() kfunc
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, rcu@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, "Harry Yoo (Oracle)" <harry@kernel.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 16, 2026 at 7:41=E2=80=AFPM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> On 9/15/26 4:42 PM, Puranjay Mohan wrote:
> > BPF programs that manage their own objects have no way to run their own
> > logic once an RCU grace period has elapsed.  bpf_obj_drop() defers a
> > free, but returning an index to an allocator or unpinning a resource
> > once readers are done has no equivalent.  sched_ext's BPF library works
> > around this today by pushing freed nodes onto a list and having a
> > userspace thread call membarrier(MEMBARRIER_CMD_GLOBAL) and then run a
> > BPF program to reclaim them.
> >
> > Add:
> >
> >       int bpf_call_rcu(struct bpf_rcu_head *rh, void *map,
> >                        int (*callback)(struct bpf_map *map, void *key,
> >                                        void *value));
> >
> > @rh is a struct bpf_rcu_head embedded in a value of @map, so the
> > callback runs as callback(map, key, value) for the element it lives in
> > and needs no cookie.  A head can only be armed once, which bounds
> > outstanding work by the number of elements.
> >
> > struct bpf_rcu_head holds the callback state inline rather than a
> > pointer to it, as bpf_timer, bpf_wq and bpf_task_work do, because there
> > is nothing to cancel and so nothing that has to outlive the map value.
>
> I tried to fully embed structure back when implementing bpf_task_work,
> Alexei rejected that approach, because some of the structures (irq_work) =
I used
> are not in our control and might change. I think this applies here: `stru=
ct rcu_head rcu`.
>
> Link: https://lore.kernel.org/bpf/CAADnVQJy0tAj9jkLrD1cBFkLK-DayjG6uNGZ3O=
BQh4V5Zt=3DWnQ@mail.gmail.com/

I agree with your analysis. Although struct rcu_head is unlikely to
change but still, I will change this to a heap allocated version where
we only keep a pointer and not the structure inline.

Thanks
