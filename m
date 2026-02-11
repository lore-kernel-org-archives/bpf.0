Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFEA1D5170
	for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 17:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770829547; cv=pass; b=pV3ZNX5NhHedZVQ61Srmc8RtUOH2K98ePw0AXQxJpORQkSVbB/TCUlh90c2MgMJ6+ukWHhU80GihCQYLjAGjC0h5gg9pMEV7/OIox45SDHuJE27yCG9qIAg6kBKYQgPk+5EovLAa5s6ax5gtmN7kHZHOXHD6gGwahfWq1iN/NEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770829547; c=relaxed/simple;
	bh=436b2tZ8/NBvfm/4AtoMT5MgV6A+YuG2ZoDj9TOQggI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N0BJedgXCYkYHx7rGxW2k2N7oUAbo+1fupqprUCz0D9A5jY4M1wxGGDzkyjY6oZY9VWt57UJd4RohsoKMe9nNacGgDw3NMYycb8ZAU4Kyz1M3I7srB1Ue0JCOMEC+LeI6HfW0+rsgDEPjkrk/0rZyRNIvEwSTLmKn4mrZEjmV+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEKgh7Uj; arc=pass smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEKgh7Uj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so26300585e9.2
        for <bpf@vger.kernel.org>; Wed, 11 Feb 2026 09:05:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770829544; cv=none;
        d=google.com; s=arc-20240605;
        b=E6zWn89rfQTRgG4SSCiz69x5NXqn/CvuFMDYkSMxEodMqR/bRxo7OQf8T9drKr2OZh
         g3xyk42S3Gu9o+a6uzgWOXreqFQIn6hp3oDUOBhMU9Eoerl7ECTY4kz9Yzf7dWwKDcQc
         EtmCeiIUfU+1jLxIwA1YpTUpCczYp6rOV9BtYv1/JGjiXGmMc8jIZvcNLFfJBkNpWCAQ
         RlU/gZglpQOdT0hBaNjv29/L+KGGJEBvrfG7XyQ0uw1jrxY++y43L5joLf8DNcbep3Pf
         DjxdLQVaxciC5jI9QZnUUHG6s7zSp+cTVul3mX6zpMWzCw1nTnfemIy8SfmgefeL1R70
         Y5fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qhsgB31/ghAQLiMpXxxQYUueF6pRoQ5LWy5bH9EPYkU=;
        fh=y18y5tQC5P/gcLE+dYdXJsA8o0oE8JG+23opGWC42NY=;
        b=X3ZWgIt45SZGxFmd2PT8vu363St0hOLf2olm9ASFqHV1o8UFt957f2u1/DjG+Iyt6U
         0uzbdzwsLxKKTyvFptnxgzclgDnHfMQo7tXHuhiaOy7YERrA6LjxkjlPqIkBqayLOW0H
         hb6PN6Lt42/U5U0yCW5ErXae3lTxLbrFj1OwsKWMX8rAdxj1uFNH3u/9lFeIu2BlqGGQ
         Cn8aPtIYpvJ1+RfIJ20M+NKyHy6c8ufCkwN/r0Lw5hiqyQu+8w7IeIPVzUH9XCpHzwzW
         0JfoSEIuU9Wm3Yjg2XC8JezBu0plWHArUrALhtUfO3sgurL0GV1gS6whLeXKf9Rnf5OC
         m1ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770829544; x=1771434344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qhsgB31/ghAQLiMpXxxQYUueF6pRoQ5LWy5bH9EPYkU=;
        b=EEKgh7Uj85bBDsFliaTmZx5NTZ0DhCF0wk4DLvyQuaIJpj0G3+wiSMjnSUwnPifEfa
         iaHYjg6YfSogtL45+sqS/GGkAmz34YuSb9kyG5MG9XIGOwMJL5uSfSc/pPMSHrEIxBh1
         XR2n0YhAHge0Edk8gOscGcfxzcK1pBYkOuad3LASPtZhsr6hLqp7jeDhTHRYRWRM1SL5
         PZJOrMzO3+BlRtck49+D4RoGvuNyJJcy7l1yOKhaXaU7qeenTtsj6HhuLuMRRlRBdiss
         Bl0o2GWxVw46M+Dlcp3vHXx/5zyvqe54IP7kdjxfO2LEwVcILVa9hXcBJ9JNkG/k9PpK
         r0gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770829544; x=1771434344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qhsgB31/ghAQLiMpXxxQYUueF6pRoQ5LWy5bH9EPYkU=;
        b=UH7rFdB5veO1sXEIdt6W4K4RWSHw6GCIy9GcaEOrmKPfVBxwYBq9vxjgjFduMznS2+
         rM+QZMeVEWtHq1FO2UdycpsWvGAYdZmy+7/Z4iLeCj4AAQRrksIDnRWT3UJr2PJ71On3
         c5+NUfqH8JwOigTjCnrM7ZdKhRWmU3axHLIGTC5A5MCjB10nNF9l6Luyk7q0HNfRm3u2
         bfluVRLmBivfJ0vOCm1yz3sW1ja2J/pag7Wd13CJNxycYW5E4r+WE9PcXrf9nomQ2qfq
         amIxu1YVdkrPexec9RLeUiQHqkvClHL6vmurufZtkUFTrwDlap76w/tsRr8YZI8gy3SV
         i7aA==
X-Forwarded-Encrypted: i=1; AJvYcCWN5mQgoLgqwUFhZiurHHgaqjxUz+B4F9Bn33/qDL1iP+vXKZWSNYf5QK/JkDZOY38dsWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSo4US6H5O0YDcN9Q6uYGcpQ8JqDK9BqcZeyD1eMo1qr5QgyC0
	jQnYc8Ic76wFOhjuAayzoGNC207jDLeUHR5qaNdnldra3bHb0uTgHG4wDHDWnaBcwWDfR5/msPN
	7L5LDs34cSd4QpgBMJcVTI3DwjHLVFtk=
X-Gm-Gg: AZuq6aLKpupI4lRQT8hJ7Z2jbUxnt/Ufh5Zjovqy08f1BtvOUNl8I56+puiPaeY07lV
	iwdUglYmRQcO5R9YkuJdv9XwDXCm9VPY1aBWeyNmNKjDKb4dLu8zpdF6l7McWBY5wyS85b6Os3N
	r3JLqNreCfeVGqpjcbG/UJ8YzgH7PIrEbtKZ0NrZ64TlictNvShaeKoiSJoblsX4dH5gXePEGg3
	x99rla9Y3jwOixcDbp9RTX06Os4fOL4FGQo5/XNfmg7x8bArMYWuIR/LFOKsCnzx8LNzbw587wY
	EZRwQAsAyZzt0GXcG8UXybN0LHDtUEn+0R7YMNbUsQCyU2NOnFIpThuaAIJ4etxWmSJgLQEEszi
	Z71vxlCM8fVgtRSNck4TgIVT9Mg==
X-Received: by 2002:a05:600c:3e87:b0:477:76c2:49c9 with SMTP id
 5b1f17b1804b1-4832020025bmr266578595e9.2.1770829543582; Wed, 11 Feb 2026
 09:05:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260206093410.160622-1-harry.yoo@oracle.com> <20260206093410.160622-2-harry.yoo@oracle.com>
 <aYxXE6CC0XQr1KNK@milan> <aYxdleYc7_TWj9To@hyeyoo> <aYxfumz5IlwBDS4n@milan> <aYxnfk6kCZ66CaOJ@hyeyoo>
In-Reply-To: <aYxnfk6kCZ66CaOJ@hyeyoo>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 11 Feb 2026 09:05:32 -0800
X-Gm-Features: AZwV_QiDUaUdudmrkVUWLFGKFv0zB3qmz_v6ysYrl7sGxUVKWt-RqFUZSJsWWZ0
Message-ID: <CAADnVQKk_Bgi0bc-td_3pVpHYXR3CpC3R8rg-NHwdLEDiQSeNg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/7] mm/slab: introduce k[v]free_rcu() with struct rcu_ptr
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Uladzislau Rezki <urezki@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@gentwo.org>, David Rientjes <rientjes@google.com>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Johannes Weiner <hannes@cmpxchg.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Michal Hocko <mhocko@kernel.org>, Hao Li <hao.li@linux.dev>, 
	Alexei Starovoitov <ast@kernel.org>, Puranjay Mohan <puranjay@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Josh Triplett <josh@joshtriplett.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Zqiang <qiang.zhang@linux.dev>, Dave Chinner <david@fromorbit.com>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, Muchun Song <muchun.song@linux.dev>, rcu@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 11, 2026 at 3:27=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> On Wed, Feb 11, 2026 at 11:53:46AM +0100, Uladzislau Rezki wrote:
> > On Wed, Feb 11, 2026 at 07:44:37PM +0900, Harry Yoo wrote:
> > > On Wed, Feb 11, 2026 at 11:16:51AM +0100, Uladzislau Rezki wrote:
> > > > If this is supposed to be invoked from NMI, should we better just d=
etect
> > > > such context in the kvfree_call_rcu()? There are lot of "allow_spin=
" checks
> > > > which make it easy to get lost.
> > >
> > > Detecting if it's NMI might be okay, but IIUC re-entrancy requirement
> > > not only comes from NMI but also from attaching bpf programs to
> > > kernel functions, something like:
> > >
> > > "Run a BPF program whenever queue_delayed_work() is called,
> > >  ... and the BPF program somehow frees memory via kfree_rcu_nolock()"=
.
> > >
> > > Then, by the time the kernel calls queue_delayed_work() while holding
> > > krcp->lock, it run the BPF program and calls kfree_rcu_nolock(),
> > > it is not allowed to spin on krcp->lock.
> > >
> > >
> > > > As i see you maintain llist and the idea is simply to re-enter to t=
he
> > > > kvfree_rcu() again with allow-spin=3Dtrue, since then it will be "n=
ormal"
> > > > context.
> > >
> > > It tries to acquire the lock and add it to krcp->head, but if somebod=
y
> > > is already holding the lock, it re-runs kvfree_rcu() with irq work.
> > >
> >
> > Check no_spin on entry, if true, llist_add, queue-irq-work. Re-enter.
>
> That is much simpler! Actually, I tried this way during the initial
> implementation. I like its simplicity.
>
> But I wasn't sure about performance implications of the approach
> and switched to current implementation.
>
> It'd be nice to hear Alexei's thoughts on this; I think he'd have some
> insights on performance aspect of this, as we have something similar
> in slab (defer_free).

It's not a good idea. !allow_spin doesn't mean that we're in in_nmi
or reentering. It means that the running context is unknown,
but 99% of the time it's fine to go normal route and try to lock
and everything will proceed as usual.
if (!allow_spin) irq_work() will 100% hurt performance.
In kfree_nolock() (before sheaves) we have a fallback to irq_work
that we thought would be rare in practice. Turned out that even
relatively rare spikes of irq_work hurt overall throughput by 5%
for that workload. So, no, irq_work must be absolutely the last resort.
