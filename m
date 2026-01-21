Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF0C346779
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768986336; cv=none; b=c7RgANAXKV0VEv/yp1UB8qvePZfpgniUuTe5GibYK3CcT2GsFEL+L5OTYP7PQmrma/DxZPJfG0VWj6UC3RGGzZlNF8t1i/RHKti9uOUaOWWla+9AsdeLh2XS8RxJ/lf45TSDxH2A2JBEAwlRa1s2Inn/Tm/u6Vg/vT5EkXBNCmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768986336; c=relaxed/simple;
	bh=qwEoAQLDX/5h8NAQXTfxwCkGV2Suky+pDFPtQgUCCbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YcOptVGLZQYXtKO7x//jbUsXsNC9cNZMfL8ILt3tsPFWJIl9op1YTQS/K7HLhFc3A7fjOATgsfeiPtahDqrta6Bky+rRbRYDovljmqaBVpcFWrW5kQ5tzltwrdebayOnKuTw8ctBqzqG5c3Lc38UAwHeINXF7rFkrfgtqqFfvt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dQSfjqQK; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dQSfjqQK"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65819e75691so514087a12.3
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:05:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1768986333; x=1769591133; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ohl1we9x5hyENAs+tCuDOyOLGaGSuak7eV44ZP7lm6Q=;
        b=dQSfjqQKhOM6g/+z9w4X9Z7/N6kTlaRO+J6y/nZSuwfYMndTCNshuPMQotOedwa0Gd
         wlB8S6y0cv+/JfYCYm3Ayo1JBYuXb6idVl97NkG6B4v+6QPlVI9L3m/NVY6C6VjoWEpn
         R9J9TwxVXTHDYsVMJQEuyKibcGZBpt2+xDid2MYgvHfGCDQY1nySaVWDk/8p8y4QNAMl
         xRRvnwymtY/ue024UJ3ytzWS0JqpQzzmupGsBy5m9mjbCyuMV5fQw/yu3gvz9sTwA5Jm
         Cfjq+BVPY/zmt9mGkKtnQBXuzQwVf5Iyu3P9cx7ZZwLtdE4REA5FkpRO0ZS5J8D6/PqP
         8QbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768986333; x=1769591133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ohl1we9x5hyENAs+tCuDOyOLGaGSuak7eV44ZP7lm6Q=;
        b=BkCkr4oukNLfDQ26YHu9VNbOcK8YXGZhTIY83E+JSWiET4R6cjliPdNy5zBeZuDibh
         sr0BqoyXHAR78DiyYZ83CZvkv570535ojCTIOeMsRTwpVHYmVqEG2fYqyqjUXQrvY9R1
         m/02aFXWjrkPcfT0rV55t8ABoJAoa4tYpaftRn6Clca1aFwksN46vPtME5QlIbNkHq5N
         MECbzWfiGZeta5WK5JqTDYjYZfcHBhoMX7bP3w/D0JGxDfuU+nt4ES8SKC7O66Vsj9ze
         Nr3ZotlRpMkKjVvXiAYMx2WXt/AznvwYq+Qkvkyo2yvO0V+o0HqAI5ufCbKzGG37sZza
         b9Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUecKc/jOTQIjdFQ5QBgO1AaImSALwhr04nUyqX9EEKGOwqkn/Sv0DVfxIU5TPcEEsc2Uc=@vger.kernel.org
X-Gm-Message-State: AOJu0YymJ1B7Xw8zkDKIa/wOI7V/+V5h1xat+48l8zYq0BsbTtcR3FxP
	FyZOZFz8qZyMIBoE9QEZpTghr2uOdhGn/uIYUteS0qjTH8nOayAi9XJDoY2KOsvi2Q==
X-Gm-Gg: AZuq6aInn9vApfyMRFL+7EbpMj/vcCUx3XRGndRHIp0evLavfz33pGP3c40ATT04Ekn
	vSuKxt5u48IKOYJ6R/thaD7Xw7mkHivRShpiTatrOc7/5r2M5IerkvJ+munwPnvpr35oyTXdcST
	1otT97pXN0EsqzHok5D7J5dcUtawNgKroGOfUNT/4yyz4/kPZuqBKHxsPK+YFLYBvYKOYbwJ052
	hdANFIQzdWknB2KIvYrAiKi4YhABoLhFPNQrGKBOiB41ncoswUODufOMryzBagjOkY61zIEXkkg
	YgCLTO1rc1o0n6VL+tEYklLHyY80FCZxlQcUCuoc2TbAt94OTmN2yXDKWz2iWI1XkN/2ZESA6uO
	KEKs2/8z9arijdMP0PxDFLOH1p1N9iupQHSNLhPF/BWinu2wL5MrLYRzH+k+IjfsSH+B0NQ+1O3
	2ySyuvdg6GGwyLlGluMg/GcRdP62U+4RxR7+w8WqGbldAUhTyMyqqWoA==
X-Received: by 2002:a05:6402:1e8c:b0:653:eb48:7e4d with SMTP id 4fb4d7f45d1cf-654ba3bc76bmr14187224a12.15.1768986332859;
        Wed, 21 Jan 2026 01:05:32 -0800 (PST)
Received: from google.com (14.59.147.34.bc.googleusercontent.com. [34.147.59.14])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452bce213sm14933518a12.2.2026.01.21.01.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:05:32 -0800 (PST)
Date: Wed, 21 Jan 2026 09:05:29 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Roman Gushchin <roman.gushchin@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	bpf <bpf@vger.kernel.org>
Subject: Re: Subject: [PATCH bpf-next 2/3] bpf: drop KF_ACQUIRE flag on BPF
 kfunc bpf_get_root_mem_cgroup()
Message-ID: <aXCWn2yijf4z3lOX@google.com>
References: <20260113083949.2502978-2-mattbobrowski@google.com>
 <87y0lyxilp.fsf@linux.dev>
 <aWnu-b0dlm0xZFDS@google.com>
 <CAADnVQKd-yu=bZjx+3=QKLq+26wcGJtJSrZoQh8b8ByKSPEXcQ@mail.gmail.com>
 <CAADnVQ+45MorO=pODKOEVXhpY1skVy1tPkkABPAxDJGx4vOijg@mail.gmail.com>
 <878qdx6yut.fsf@linux.dev>
 <CAADnVQ+iKDvHxg_bEd6Knp3dNb9cr+FiemFSCR=NBnyt1UdYig@mail.gmail.com>
 <877btbu6ds.fsf@linux.dev>
 <CAADnVQ+6d1Lj4dteAv8u62d7kj3Ze5io6bqM0xeQd-UPk9ZgJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+6d1Lj4dteAv8u62d7kj3Ze5io6bqM0xeQd-UPk9ZgJQ@mail.gmail.com>

On Tue, Jan 20, 2026 at 05:14:04PM -0800, Alexei Starovoitov wrote:
> On Tue, Jan 20, 2026 at 5:00 PM Roman Gushchin <roman.gushchin@linux.dev> wrote:
> >
> >
> > >
> > > Matt,
> > > please come with a way to fix a selftest. Introduce test kfunc or
> > > something.
> 
> Applied the tweak for selftest.

Thank you Alexei!

> Matt,
> please send a patch to go back to acquire behavior and summarize
> this thread in the commit log.

Sure, and here it is:
- https://lore.kernel.org/bpf/20260121090001.240166-1-mattbobrowski@google.com/T/#u
