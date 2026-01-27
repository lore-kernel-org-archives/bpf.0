Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A475525A33A
	for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769502519; cv=none; b=QGFfkdf2wTkB7TCbrENqVLnjaNhsio8YWgHa/kcM3HwCCC8rMsUsGG8UCinullLDmeUhGiD3G6KnhgUfRTe9doKQB1Ur0bIt0hNKcGexFJSrCzfdpYZYcGE2P98in43bI6Yludze622lhbe+IcKGiyQQo71oQwKqlTu/YlBccNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769502519; c=relaxed/simple;
	bh=A8JwCYIxS1M/gmUZ0h+YdHUevcEtgUb9nDRsmiOT9+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWUVFn8ktSJI8eLFWO9A3DV9b5Y+rBFZjdyUit439dbLGvgoEEhjCBUlibpxoM7BQ4nViP9G7Hh1L/KZmRg+4j2VYvd4BzO9OqdCaf1+iZ5hSi0s0FKvHPTUXwXdRytkMhvz/tnCp8vpV+7CS5CCZRUdKDvBFaeqFguaH5CMAVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0/pVyl1; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0/pVyl1"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-65813e3e215so10176732a12.0
        for <bpf@vger.kernel.org>; Tue, 27 Jan 2026 00:28:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769502516; x=1770107316; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Dyy+icfn3HDAR1ozX26mB+mq8IBSe0yAe7PRjvsem8E=;
        b=H0/pVyl1A5S/204FUxEXtHPGETfXri2zRK5l8lAYHxAGk1iyC5H4QXaaAUw+ezVBUB
         rdaTskz9O8vCRNUTdyoZtlA+E5iSbO9H/vEv730vFmMe03/oXNHx2pDIWrJdMpCEpGRe
         mPvSTQZS8sKDpmRVXx0/utbkCeKaBH3YpLhtaT+Zqt6QIaIknOZLAy943TpI7w0/XHZD
         oyOYC2NZIPm0ZJwpIPwO2pyNFlbnQc2qxXcvlc8UDiGb7HIjWKx6z6a7JuAG5LtACNw6
         dC7qlnKX/UYB/4d35U/B+1XM+29rVLGrN0Wp2dAoEcCmqZAEVMMJOymqJU7CbOZIHWXs
         s4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769502516; x=1770107316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dyy+icfn3HDAR1ozX26mB+mq8IBSe0yAe7PRjvsem8E=;
        b=TGgtmyzB00CgMLtkmr8DkXbwl7sRZtjuvfMA9p2l6S9fZSVrWZPHKVT0rDMTpOAd3o
         /fgr90luR4Pwniu/HEe4ug9YyzIaKKIoKeXsjWtggKo82o1Oo4+XKIR2l3JY49DAN5YO
         l4IQ4aYuuTlmpSCtz6P8zJfnbQR0zT4x5sJo469WZurcI70OZsCJCVP7xFn3Ow6tML9P
         E8m1Cl+gW9pHz+fb8jwObW3BwUzeUkMoySntKAbFtvBfzWnt+0hi123wikS1N6s3F9dK
         phKC/JXQfwWF1aWHeWpNVq0zZjU3frA//1uucvGkVQ5os5NAywvXRiZIMp+EGVTgmHhn
         GfwQ==
X-Gm-Message-State: AOJu0YzayGr28FFMMmSnkt+MY2PxX2uP2d9RFmMZWjXndotm8NFb/Qbd
	+uwprruRHN48L5PUS40o784DiaqOrV37w3JClM22+aNxxTCLP9f0nMNCCjOahLXFqg==
X-Gm-Gg: AZuq6aI211hcIqovSPsrto4gvpf456fvczvfrTGBmZYBSxAB5pfXRUQvr7u2o+h9R0z
	f0NYnOPH0b2p0DZFNW3nbI0rDIogyGxXQER+cXT3Z6BC9gIcGKgB2WAmYmncYqZUtPSi7X2Lkd7
	fhnBtqSLWXtbI8qPx+pXfrDjoc34+9ig3lP2i2DhYXXRr0LnykSdxo2DFWF0TqiBOq+L+03EjgG
	OFNd2FHR3Y8E8S5man/HuEjZjyY5vA2/uG76KBde3wVKotMeaFG6hZ96DBcx3g3VQug2q7/YFOL
	QvCFQuD4RK3A10Lj5T+3+bznKqPtWvPqxcb6xm3+B4/89lfls7klul/92jMD9IKYtjUCfCpZHci
	aznSPYXRxKww6a+/T8W94sprBC/JNBQrJloHwTQYNHDgBOGBEAwapCU4hTVq+K3/UM0Lmv/noYo
	ZJAN1TIMkyGa/ACGm5HiyxR0996r6eC6IY4zqRpGzRpElZvqS3O3U=
X-Received: by 2002:a17:907:9688:b0:b8a:f7fb:4f4d with SMTP id a640c23a62f3a-b8dab1a4686mr80028066b.16.1769502515709;
        Tue, 27 Jan 2026 00:28:35 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b885b75e334sm753405566b.52.2026.01.27.00.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 00:28:35 -0800 (PST)
Date: Tue, 27 Jan 2026 08:28:31 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new BPF_CGROUP_ITER_CHILDREN_ONLY
 control option
Message-ID: <aXh3L7BukANG6Dve@google.com>
References: <20260121135444.187001-1-mattbobrowski@google.com>
 <CAADnVQ+8f1mK1+L9S6uDbo0n53zs9VeUhZr5eTg0+jXppRAhcg@mail.gmail.com>
 <aXNWLU7ay1HHmg6S@google.com>
 <CAADnVQKHuj1snSOBh+VEJrcW82OW2zNOEd1=Dqe-m+kuOV7MWw@mail.gmail.com>
 <aXct9XxD43eBZs-H@google.com>
 <CAADnVQJXs1NinaahP-uKOrqKUHEZ4PgwOAAVpWkHDWkapBZ2YA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJXs1NinaahP-uKOrqKUHEZ4PgwOAAVpWkHDWkapBZ2YA@mail.gmail.com>

On Mon, Jan 26, 2026 at 06:26:55PM -0800, Alexei Starovoitov wrote:
> On Mon, Jan 26, 2026 at 1:03 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> >
> > On Fri, Jan 23, 2026 at 09:17:03AM -0800, Alexei Starovoitov wrote:
> > > On Fri, Jan 23, 2026 at 3:06 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> > > >
> > > > On Thu, Jan 22, 2026 at 08:26:49PM -0800, Alexei Starovoitov wrote:
> > > > > On Wed, Jan 21, 2026 at 5:54 AM Matt Bobrowski <mattbobrowski@google.com> wrote:
> > > > > >
> > > > > >                 break;
> > > > > > +       case BPF_CGROUP_ITER_CHILDREN_ONLY:
> > > > > > +               kit->pos = css_next_child(kit->pos, kit->start);
> > > > > > +               break;
> > > > >
> > > > > There are no users of css_next_child() outside of cgroup
> > > > > internals. It's a red flag for me.
> > > >
> > > > Hm, I can see the slight hesitation here. However, until somewhat
> > > > recently, the same argument could have been applied to functions like
> > > > css_next_descendant_post(), right?
> > > >
> > > > css_next_descendant_post() has rather recently started seeing usage in
> > > > other subsystems (block/, kernel/sched/, kernel/bpf), despite
> > > > remaining internal-only since its inception over a decade ago. Given
> > > > that css_next_descendant_post() continues to remain unexported, in all
> > > > fairness, I don't see css_next_child() being all that different in
> > > > this context.
> > > >
> > > > Would your stance change if Tejun agreed to mark css_next_child() as
> > > > exportable, or simply agreed to it being used from BPF cgroup
> > > > iterators?
> > > >
> > > > Both css_next_child() and css_for_each_child() have remained virtually
> > > > unchanged - and therefore inherently stable - since their
> > > > introduction. I should also mention that functions like
> > > > css_next_child() and css_next_descendant_post() were originally marked
> > > > as exported, and only later unmarked. This presumably was done as part
> > > > of a symbol cleanup, not because the functions were unstable
> > > > primitives.
> > > >
> > > > > I feel there is something wrong with the use case. It should have
> > > > > been handled by the primitives we have.
> > > >
> > > > Right, arguably it could be handled with the current set of
> > > > primitives, but it isn't nice and certainly not as efficient as I'd
> > > > like.
> > >
> > > Why is it? Just descdant_pre and break out of the loop if not immediate.
> >
> > If I use a break when I hit a grandchild in pre-order traversal, I
> > will still terminate the loop early and miss all the subsequent
> > immediate children?
> >
> > I do understand that using css_next_descendant_post() (without a
> > break) could allow me to logically filter for children in the
> > loop. However, my concern is purely about algorithmic complexity and
> > scalability.
> >
> > css_next_descendant_post() performs a full subtree walk
> > (O(Descendants)). If I have a top-level cgroup with only a few
> > children but a massive hierarchy underneath (hundreds/thousands of
> > grandchildren), using the descendant based iterator requires me to
> > literally visit every single node in that subtree.
> >
> > In contrast, iterating immediate children is just a linked-list walk
> > (O(Children)). For deep hierarchies, the performance difference is not
> > constant - it's orders of magnitude.
> >
> > For example, if I have 5 children under a given root/parent with each
> > of those 5 children having 500 nested descedants each:
> > - A pre-order traversal would lead me to visiting 2505 nodes.
> > - A linear traversal would lead me to visting 5 nodes.
> >
> > > The thought process should be to use what's available as much as possible.
> >
> > Well, I get that and it was my initial idea. But, I quickly realized
> > that we have a gap in the current iterators capabilities, and this
> > patch is meant to address this gap.
> >
> > > Adding UAPI for specific use cases isn't great.
> > > If it was a new kfunc that's one thing, but here you're touching uapi/bpf.h
> > > So acceptance bar is much much higher.
> >
> > OK, but now that Tejun confirmed [0] that he's fine with exposing
> > css_next_child(), how does this weigh up?
> 
> ok. let's add it.
> Maybe shorten the name to
> BPF_CGROUP_ITER_CHILDREN
> "_ONLY" looks unnecessary.

Sounds good, thank you. Shortening to BPF_CGROUP_ITER_CHILDREN is OK
too. Will send it out as part of v2.
