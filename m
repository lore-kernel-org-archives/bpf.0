Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794936224;
	b=Ei3Ompu2p9N5iLURlyAhJMED0e/WznOONQXy94EPoROsV1D022ut7pTCzIY5eV1dXejo
	 jvxynn0QJw03k/xwo6xPVrrJMT7iCEI7N2v4NRHxdqBXnDcofeyHonPFNEV5GVJmu1I/4
	 Cfxpyg0jcn6Dj5wZ1Md3xIPZ03aQM1g32cznPBVi178GjQccmNtmmHLqXiVZz1hVw2FJ4
	 ITMhguwnDin1Py4SELEYubJWWR5Ua2ZgOzqBXIZ8MN8Bl23O22CrmWci7tNhHkDCwQGW1
	 hOzFHG5UExQ+Z76nmLFX2e6KFBxd/L3nIVbQwc7s3krPdEzA4h1PFepbVLOOPFi2HSg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794936224;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vG0ERfGqtPpbt9YFDEN1CgPSxrt5MeiDqzo+7XubqQs=;
	b=PIxMBoPZ8HTff5ulBUtwZRscAdwDgancP3xAKZfq+BHAy4mMsp5BtAytSvY3Ks34Pm3R
	 c4F7d2ECXoHxV7vfnnaeZlQMFhRZc2K9t0ZWf2FtESEpWZuhlAO973Dqh6TvbJXw1o0Ew
	 kRwBKpF7/BPnJSY627giJjfEFVM3xZN/n2O1f5jbajwynD4mHLjH/zpKN7VTzGRgVuSbI
	 d/Ss/RSzfCsr8n9P4HGQQo5kL0f72A5mPUiAkNIFYT/v9PLNjgixqMqvsKwegOBdK5Jg4
	 wO5KPR3dZvc3AKWuHl/uaHIc+mRPXt10gnUOWXRdlwbF5mmUItSjd2kIBRzCLjdMvVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=riRd6YW3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.48
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0E606A32A
	for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 17:23:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDB0E606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=riRd6YW3
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-48dfc0421d9so6765f8f.1
        for <bpf@vger.kernel.org>; Tue, 17 Nov 2026 09:23:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794936222; cv=none;
        d=google.com; s=arc-20260327;
        b=P8GqfCxSHasf2RrDZcpov1LIo4EA0cdL/0vhScSjpuFLge6RprLqtPnJz66U4PToXL
         sx2qjVB+zla1fNA7b6JknHH3yN82ud0yiYajbVdMjRm3vhZ4gO+x/O3bVwKKvWIqijXy
         Ivjgzf9NDsb49EElbmW/p4k1suw2RkCMHnofPFKN2XEQSDN0JqrstIQeerAfBCpneGdR
         Ig5CfMgxw07XWftACSvN8NJAxIdmqYvrjTD+2yBdcIiPmqAIacJG7PZWpg1zX0E6rK2k
         JVpYWLFpeZYnosWSmqKH2k8o474P6wZwJ3+au+sj6/xHNH43mAx4cfZSo7Xfrq3Qp8Q0
         I7dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vG0ERfGqtPpbt9YFDEN1CgPSxrt5MeiDqzo+7XubqQs=;
        fh=njbzxkU5zQ8kE0raPX82s1WkWCvl49kLdJoc3G58m7Q=;
        b=J8Ayjhtp5wgBvfIt2wtGuNkKk6xJtQE+mQTxouvY+ky23llIJLCG1oZTJvm8cbL6rl
         by4C+waa5F6QyU9Aj7FtL3gTHB7xDg7VkMzm55BTFwVAjNLb4lOFEnpaIfbbfPjRqWJz
         wI13cxqQ2myoiRpLDTZ31FCqwVzwCd4KxuN0vEYXNGqIlQG4y3kA/o83fJSDuRhqrRHN
         KOt0pgYICXKQ2gef2WKeBXEax/q1VisAyBsw/1MJDZJCC77Av/0CLE06tCfeST/pmLpD
         tmOQFafDUEhQHlgddv006gpvHOZTOWHZdkNZ/iqxEnIC8hazwBNB/FdBY6LtElD0S5XL
         hgYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936222; x=1795541022; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vG0ERfGqtPpbt9YFDEN1CgPSxrt5MeiDqzo+7XubqQs=;
        b=riRd6YW3pKJmrKmwrQqs/CVt7lN0aLDbPkARf0OEgPA/lTDRllwOLQHArBv+F5Nm/V
         cXK7sGWZlMUJYs4I2xSrt+aIlowp0HrEWM26Cdljs98+qiGeiUxjtdPkHAy/jfjFhiv0
         WZG9AVCoS7MSAOgd+amn5mM/5xTArMeUxTMpGh9npbbMBJ5uvXrDC7ar7+HZYeyddyTq
         8P8tYzwY3z4Dmz1tKOosGt/9OeCeDago2yOSjy8eBkLi1vhtx0hFVx4juyz+6rvPJ4Qx
         HEevxAwVJQTtqwQtL6zyjlOwOSAdWjV148Y1r6n7a3QLBz4zJXYamtf1PCHP1d6hwmr/
         vxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936222; x=1795541022;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vG0ERfGqtPpbt9YFDEN1CgPSxrt5MeiDqzo+7XubqQs=;
        b=NRPu4YY7MGQdxW9YsnhIJuSNYCzYaW6X/O83PvoXdhwPRGWJYX+CJ7HEiUgJVkcDBL
         j+mVyCvCNcNI40J5GHDbo0YFrUa6YB5FPU11h7sGceKFGG7AmVJOP8DO2Z5CLmpsp1/3
         Joo7+4xLkc0RzO/AmBtrSwPbskcpTmB1msYQB7kwSVMtT2E1csXNjaqe58my4dMpFjSU
         TkB8+y4Tq4vuMJKsmooBKrVYMoi3FPDbQzfSLtRoK1z4vlAN1lrCN/Ga8bMyvTqdw/Fl
         aftnUjF5y9miuZSYx/Zostche7TikUs01HXBLNJK4ieZ8ibRg2H3v3iBjjo78z0oKJaD
         XcVQ==
X-Forwarded-Encrypted: i=1; AL+hErHVg5cBxxBrdTbtqZZjkCtpJ0Tx28CQls5K240ev7QxTTo76BrRLddpZ/fApBSj0B2qWmk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/ZO06PIZ0uNAU8SDLN7s+BY63SObDVGCqIvHpsxwt29eeU53Li
	SMGkziv0R1BptC3k1ZGIEcN80SUpRz6mSDbdcbC+U5K3LcaEU9Tv90L8hNChx9g1ro4YUriK1SD
	xyr7dQWG2S6oROOGqi5e8l9Xv59ECWoKJ6DDJCb8=
X-Gm-Gg: AZFdTZfVNvC0bK/AA/7sHBmoE88+HJreM+KUrvU3nzkZ34h+9vmi8Nk9YvVLgOH1P4+
	o7/5OcffCFBa+YFusEueRzI4LvK6JpH12bk+c6V9lrZnQ/Khup6urN77LlbZ+0eD1N5ZTEAGpNd
	sLeOs56V/2w2/6vPL2GBkibgy+ZYtpLSD8fbgHI0/lcNkWLvBj4IT/FTFmYct4eEmOAL/FHgHpw
	3jvtPGH5eOHYI+RmyjDLG2Za8C5NTgJvZDNlgxb1D38IF04lUj4b5VYAw90hPTx6i81w5VMqjLM
	Q7u6B+Lc62dGWyJViIZBIhtkm59pYdSedWucVhUeWjP97HSRYPmNEg/Z2JcN1HpVG1hGIYDwK63
	SQeEg7ljJTZRrmcNBI5tQnHzA2F27ZzSoOLKSMppHWMesmfhBrjWkvTsDM7X79fNSCv5QvTA/RU
	R2yczSUgg30A+q2BxsC+Or7GVkMTt5IEnQyg==
X-Received: by 2002:a05:6000:4b1e:b0:4a6:b87:d799 with SMTP id
 ffacd0b85a97d-4a6380582f8mr278310f8f.17.1794936221985; Tue, 17 Nov 2026
 09:23:41 -0800 (PST)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <cover.1794269506.git.memxor@gmail.com> <DMUHWUF1OF82.3VM2D2YIBY40V@gmail.com>
 <CAEf4BzYAS8V=XcULjRvL=v0ffn6T_HOQVAxDkBy4mC+mwaQ_Uw@mail.gmail.com> <DMX8CTRXDMKG.2SGJHE0H48TBK@gmail.com>
In-Reply-To: <DMX8CTRXDMKG.2SGJHE0H48TBK@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 17 Nov 2026 09:23:30 -0800
X-Gm-Features: Aa3M54r7SQzdkrpOjur5XVVdduA6tGw7BrcPQIfs96bbbehBH1GQr_jx3Vn7NpU
Message-ID: <CAEf4BzYKN1eqbXsRSwVgUE6L6ZbdRrJ+PB1nwGSek_sx6dt-5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 00/20] BPF kthreads and waitqueues
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Eduard Zingerman <eddyz87@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, Tejun Heo <tj@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, kkd@meta.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 9:18=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Mon, Nov 16, 2026 at 10:31 AM Andrii Nakryiko <andrii.nakryiko@gmail.c=
om> wrote:
> > What if we allow creating dedicatd "BPF kthreads" that would have
> > "exclusive" BPF ringbuf (because it needs to be single consumer) in
> > front of it, and for each submitted ringbuf record that kthread would
> > run an attached BPF program. Associated BPF link will keep kthread
> > alive until destroyed/detached.
>
> Such thing already exists today in the form of cpumap.
> xdp prog redirects to it and kthreads handle the traffic.

that's just one example and it's too limited for general use, of course

> Such ringbuf+kthread setup won't work as a replacemnt,
> since ringbuf cannot pass xdp_frame pointers (yet).

yep, but we can copy data out of xdp_frame into ringbuf, for example
(if that works for a particular use case user has). but to be clear, I
didn't have packet routing as the main use case for this, it's more of
a generic application logic with communication channels between
multiple BPF worker threads.

> Another analogy is golang channels.

exactly, except channels have fixed value type, while with BPF ringbuf
we have more flexibility (which can be an advantage or disadvantage,
but it's generic and well-known interface we have, so...)

> if we can make them generic to pass kptr, then sure, why not.

Is it really a requirement? kptr can be stashed in BPF map (or arena,
or wherever we can stash kptr into today) and ringbuf record will pass
a look up key. BPF worker program will lookup any necessary extra data
when processing a message.

>
> but pls not a kthread.

I see, PF_USER_WORKER thread. That might work as well, although it
would be nice to keep BPF worker program (and its link) pinned in
bpffs and allow it outlive user space application that loaded and
attached it. If I understand correctly, user worker thread is part of
the process and will have to die when user space process dies, rigth?

I mean, it's technical details that will need to be worked out, but
seems like the general "worker thread with BPF-based event handler
fronted by queue" idea is workable, right?

>
> vhost moved from kthreads to threads to do proper limits.
> commit 6e890c5d5021 ("vhost: use vhost_tasks for worker threads").
>
> There are also i/o threads that io_uring is using for similar
> accounting reasons.
>

yep, I agree, having better accounting story than kthread is great.
lifetime is the only hiccup, but maybe that can be solved somehow even
without kthreads, we'll see
