Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0F13F7E66
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 19:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775159958; cv=none; b=g9sMvbeNonah2lH1rGJItfRgWfjlxZvbhjTZT16EJ7OydRSyWavcWq76gGJwMdqcTTWaLS4L3yC7lA4FUx589vhiwgLERdJLW8fCoTBLdHuUGqTLr+eLQ4Deoh8PUCZO+28VFe/DY0Jw1IMtGECFEBYNfHZLWfZPjpBonLV6mWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775159958; c=relaxed/simple;
	bh=Zs2Qp/55D6fwTX9zLMhOqR68fxQnYl0gowt7wOZZv/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GnUZTimcpu+Lwrt4EOOxBtoOSqJkd5vBCEh7ycQdLMxQbEunGlj3/qr8va3jmENkuf19d55Wk01ESO8Aa6XyExdl1kUxHQPfwUyc5vVD+6AyayLzyF9o3RGLeCMGYAw77jy8ptp3OdsyzgAottJpVk9uyGKutrSVNULe25tMEm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QMQkXjlP; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QMQkXjlP"
Date: Thu, 2 Apr 2026 12:58:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775159953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=h4LXrn22TBGi7bcYpI2LLlP6JOFXPvP5DoNVklG2FQQ=;
	b=QMQkXjlPaoUSCq/FKYpfN3UVix7tt1OPKJyq5VMxY8kyQ19D4oRoLzu0mYXXcMG84lyz0P
	RLFWR7K776TAClJmfpA3u5D8hTsYwambL7UzULFDI1rRcb8P6RyI5/u9na1yeJ0wtQGUq8
	UE0JWoy63mx6bYxU3U06p7gHI+uu3/A=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: xulang <xulang@uniontech.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Dongliang Mu <dzm91@hust.edu.cn>, Eduard <eddyz87@gmail.com>, 
	Hao Luo <haoluo@google.com>, Ihor Solodrai <ihor.solodrai@linux.dev>, 
	John Fastabend <john.fastabend@gmail.com>, Jiri Olsa <jolsa@kernel.org>, 
	=?utf-8?B?5qKF5byA5b2m?= <kaiyanm@hust.edu.cn>, kernel@uniontech.com, KP Singh <kpsingh@kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Paul Chaignon <paul.chaignon@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf v5 1/2] bpf: Fix OOB in pcpu_init_value
Message-ID: <ac7Afa6_HDzyAxSt@devbig1721.ftw5.facebook.com>
References: <7653EEEC2BAB17DF+20260402073948.2185396-1-xulang@uniontech.com>
 <420FEEDDC768A4BE+20260402074236.2187154-1-xulang@uniontech.com>
 <CAADnVQJawYEk53kS9-w5EXU0GnUYWWW7AF_n02bUs-GPJ+4Raw@mail.gmail.com>
 <ac6ejZrcnfQfaTZS@devbig1721.ftw5.facebook.com>
 <CAADnVQLSUU8Yo1Wmym4B05jam6qqUPEXUDJpBH+00kjqkrYigw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLSUU8Yo1Wmym4B05jam6qqUPEXUDJpBH+00kjqkrYigw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 02, 2026 at 11:36:04AM -0700, Alexei Starovoitov wrote:
> On Thu, Apr 2, 2026 at 10:01 AM Martin KaFai Lau <martin.lau@linux.dev> wrote:
> >
> > On Thu, Apr 02, 2026 at 07:17:17AM -0700, Alexei Starovoitov wrote:
> > > On Thu, Apr 2, 2026 at 12:43 AM xulang <xulang@uniontech.com> wrote:
> > > >
> > > > From: Lang Xu <xulang@uniontech.com>
> > > >
> > > > An out-of-bounds read occurs when copying element from a
> > > > BPF_MAP_TYPE_CGROUP_STORAGE map to another pcpu map with the
> > > > same value_size that is not rounded up to 8 bytes.
> > > >
> > > > The issue happens when:
> > > > 1. A CGROUP_STORAGE map is created with value_size not aligned to
> > > >    8 bytes (e.g., 4 bytes)
> > > > 2. A pcpu map is created with the same value_size (e.g., 4 bytes)
> > > > 3. Update element in 2 with data in 1
> > > >
> > > > pcpu_init_value assumes that all sources are rounded up to 8 bytes,
> > > > and invokes copy_map_value_long to make a data copy, However, the
> > > > assumption doesn't stand since there are some cases where the source
> > > > may not be rounded up to 8 bytes, e.g., CGROUP_STORAGE,
> > >
> > > why? Just round it up there instead of penalizing perf everywhere.
> > >
> > > > skb->data.
> > >
> > > what that means?
> > >
> > > pcpu_init_value() can access skb->data ?
> >
> > After bound check, the skb->data can be used in
> > bpf_map_update_elem(&percpu_lru_map, &key, skb_data, BPF_NOEXIST)
> > which will call pcpu_init_value().
> 
> I see, but if we round up on cgroup storage size the problem is gone,
> right?

Right, it will fix the problem tested in patch 2 which
passes cgroup_storage_value as the source to
pcpu_init_value(). The bug should only manifest with BPF_NOEXIST.
For BPF_EXIST, pcpu_copy_value() will be used and it
currently uses copy_map_value() instead of copy_map_value_long().

> Doesn't matter what the source of the copy is.

I think the source (PTR_TO_*) matters here because the bug is about
reading beyond the boundary of the source. A few other map types
were audited when their values were used as the source.

For skb->data, using skb->data to reproduce is practically
not possible because there should be at least shinfo beyond data_end,
so some of shinfo may get copied to the pcpu map in the extreme case.
One thing that may be worth noting is that map_lookup_elem() in syscall.c
does copy 'round_up(map->value_size, 8) * num_possible_cpus()' bytes in
copy_to_user().
