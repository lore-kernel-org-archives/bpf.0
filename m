Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F03F1661
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 12:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774526814; cv=pass; b=mMQYGAwhP0VbrmdxeVTDSsUsBXhGYLjZH7W1X/a9MZvGdMYj+7DFJRAZEoB6+hNUBca4gUJrbT883VqDax4Xtc1Z8EndsgsZ9TFcuyYN7tVBiUfcxxEEwnCHeKX7+XxxzRPvXDbsfixb+AEUapErcJzL1ibguDQvSv2fS+IdjGY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774526814; c=relaxed/simple;
	bh=c/LVk2If15MK7OxxP3YWk1vCwKamO5JLK1qJrCUqFms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mcjeIM7d7caeT3kfyZPHI/DmE/1CFMGPegwOkKce3XWST90xuRN5GYuA5aXgVe/HFF4RuXbSJGCqHv5vyw2GrOQhxHYUfmTwCzkpEqs/PH6e9AMzLBhU4w+z1b29dTrde5n1AN5NamU6eEeqEfMWqSMK782Zk0se6Z6ZYw3J5qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BpV5t5E3; arc=pass smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BpV5t5E3"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-667f8794e97so1599045a12.2
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 05:06:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774526810; cv=none;
        d=google.com; s=arc-20240605;
        b=Vyu9hNI2qYQwj0+2fDbmxPc5kixkT6hQwrdQZAJDDUGusksFfFR4COkjBQmscMdIIf
         JsNVObzyu2BRA7cVKXfeu0Bj+MW1zhzh90ITrp/HL56UfeAHLLo6zXcoshuSSlJfFbg8
         Vg8nRGDatkLKaNR2gc5te3bUe75MjoHTqOXCc3PM+qVcGgggQqiD9NrSAWLGh0i1dh32
         J/7g17Gf12hsf7d2JEIxbZba/GklGGifdj1RlEUe/S9Cox0zfc+9BGk5tw7ipykmYN4m
         7PhedN85g5qG9DykUfe8I9DCI2iROHTb0gU5kVPmcGVCFNLnMa6mjChriMQxKGwNJQGv
         ae2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UCPMWIti4WpvFBx+uoiLacb08LQC6AbfsXQqCnT6+V4=;
        fh=BFgNFYcUIAVu/EFjGxsvtKayIwBIIxhbAi1xyNNe7pg=;
        b=gUfe61idUgM07dZOqWz5DY5EKCpPmTSPrF+8/ZYTeYudqDoUCltpxiNJQ1CMSjvRs7
         wCQ0Fk/rMbyC3mu4BUZ82rDMg6C05vreKaNdCgVNk/UYjMtodaKYdOgq1tApvww3p1hz
         2j5taWBmKx6fyIXLOseVf6Fu/CHMZnKpNh8iOwtxhWS5oYXBD3zRCRa1RMsWqcWOmgcI
         ElIPR9VgNjgEWLC8kfopv+shNgf9p+x9Gxp/izJC2NufG1+3CWWTT8rda7j+qr/UQwYc
         vybbEZeyfTolZYTwAwSjDFnX5lc6BNWhqkDqSJ1tBZYxfl7snVAYTrUfSa6dKsCI1rB3
         3xQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774526810; x=1775131610; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCPMWIti4WpvFBx+uoiLacb08LQC6AbfsXQqCnT6+V4=;
        b=BpV5t5E3oktEaGfuvGqRYQ0En6VkGpv74WTKoRo+Nvut4TMZXD0EXl28+AQEj7tj1t
         SSpBFrt8O6aattwVMQGbS6LQLsBaD8Gbt6Iw2xmdA6DfYxyaJsOCvSZ7Kfzm7VOkLf2p
         HwUIkVQ+KlOoIDRKeQochutKam4mxXdIrLA6IstlUzl3USCXsMiTm6zLkO+UP42Smumz
         JqjmW6w8XIiUvLSdbZfCgoZCyh/Rh9IBGNYCg9NZ+sss0iec4QwZ8pUGofjuMEipjYoZ
         a6y2k+Ryo+aqyPRumv5WN6f51IVQJOrYoXqhg/v7jyqJok6rsW/8icOXfRtM+dq/bxQ/
         bqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774526810; x=1775131610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UCPMWIti4WpvFBx+uoiLacb08LQC6AbfsXQqCnT6+V4=;
        b=qIcdX5vZOMxNCMvp5WdhQx+zg1BLKlkO9zpQYGu0salgbt3eUGknNyK8IC9spKgCp7
         vjoF3Dco7R3pxbPUpOvERrPsKWfe6VULXHPOFSnW/PpDxuij+SDnzzpKXCuXESK9MEdT
         n+ns/avjhmy5LHNKoGL5ad3CVUSAaJHEryIS1vd+3zJC+dHX55MSKlupAjV2mzR3YThM
         OhCdeI4Z7I+nzPZ4PfBVSc0pwIDvI3sWk3dVjYgUIIvTpPW+2bdV8LlyOVldciIuS3Vo
         ijTn8p2C7St8FfRkv5KJ7Ky0NjIcKgbnlbkdYs9OrhhqC9StYiN7Je9mgCjOD7MUG9x0
         cxjg==
X-Forwarded-Encrypted: i=1; AJvYcCXXEjg/mHZLYsuJ9iQ3A3/0y+TzLYjp9ena4ALrIKyUjML3SWRa+P+KFpBGt3MRP3YWNCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLLu2fhYiDaCR0fXCdaDGWR8kZpmqWs+D8cKjkHlDom4qA+cLt
	Tt0bIZQFjIDt9uqqKudxxzqjSO9rTxA0NCKmNA7lAqIll4DaoETDh3pHwgGlGUygiLIzBSQOuXL
	0javgnKZSdUFClWcYqTrPuB3tM4KqVHc=
X-Gm-Gg: ATEYQzyNQ8K2u/tSPPKRkSJI/6iYF0qXV1Jxa7Frra/pKIP9KW7Y8lxD8It7Ml3KSWk
	AX/CJ0uogEBatqBmMpdmp9kSiWpnvRWuEVB/kH2CKwBlE3B1DJag73oO1Nqo+I9+eb3V1Tv1jig
	Xqm8/9RPUt2qfCOpzgMQ6RFzB1h9ybp3tr5PiwOW8HaXtwjTGQZXXTXGCdqFM+D4fYZPMSEo9WS
	Wiekwy6lI+8xTzhJ+KT/ttw8LKkVBUKMo8C2rncJAi5BNvVmbpl77bkhDxh/Xvl19GJK5Y1nkHz
	OS1jeun7zouGQ0pYQav5H4UG5RpmbhCz3ki/U8Lk
X-Received: by 2002:a05:6402:400f:b0:665:33eb:22fe with SMTP id
 4fb4d7f45d1cf-66a82622bc2mr5320318a12.9.1774526809603; Thu, 26 Mar 2026
 05:06:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325210637.3704220-1-shakeel.butt@linux.dev> <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
In-Reply-To: <20260325190547.abb7309fb63473b57b7a90a0@linux-foundation.org>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 26 Mar 2026 20:06:13 +0800
X-Gm-Features: AQROBzCNij5ZIZYiccbOybvn12nUAvCYLf33aTbpussW3sa2ckcJHvGDC3YLdQo
Message-ID: <CAMgjq7A01C+wyHxytZfVFVvaJ+gUNqkKvYN61_Peo911YaBHOw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim (reclaim_ext)
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, lsf-pc@lists.linux-foundation.org, 
	Johannes Weiner <hannes@cmpxchg.org>, David Hildenbrand <david@kernel.org>, Michal Hocko <mhocko@kernel.org>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	Chen Ridong <chenridong@huaweicloud.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Alexei Starovoitov <ast@kernel.org>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>, 
	Gregory Price <gourry@gourry.net>, Barry Song <21cnbao@gmail.com>, 
	David Stevens <stevensd@google.com>, Vernon Yang <vernon2gm@gmail.com>, 
	David Rientjes <rientjes@google.com>, Kalesh Singh <kaleshsingh@google.com>, 
	wangzicheng <wangzicheng@honor.com>, "T . J . Mercier" <tjmercier@google.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Suren Baghdasaryan <surenb@google.com>, 
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 26, 2026 at 10:05=E2=80=AFAM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Wed, 25 Mar 2026 14:06:37 -0700 Shakeel Butt <shakeel.butt@linux.dev> =
wrote:
>
> > We should unify both algorithms into a single code path.
>
> I'm here to ask the questions which others fear will sound dumb.
>
> Is it indeed the plan to maintain both implementations?  I thought the
> long-term ambition was to knock MGLRU into shape and to drop the legacy L=
RU?

I personally also agree on that, so far I'm not aware of any major
issues with MGLRU except some corner cases that are not hard to fix.
Once these are done, I don't see the need for more complexity.


> And that Linus has expressed such a desire, but my googling fails me.
