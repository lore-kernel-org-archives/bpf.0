Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5236606E
	for <bpf@vger.kernel.org>; Thu,  2 Apr 2026 17:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775149315; cv=none; b=irZEI80hbdbHdZrrIdv0/tN6rPvddhxwCjzoLs1xrLH4f1HjXQ7sTX5h1AwklO2zfl5Jp6jLGfADEJM/WOXEYwVSsBgHm8XyYDWgrLELv/QBbmSjDwdJisu/Ik9dC7Y7en3YknfQTCHFfRqWEn5KkpjI2FBqri9oDb9VJZfrNlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775149315; c=relaxed/simple;
	bh=yqumXcVR3q5lMN1WTcrSXHMqBHPGdTQKt4KuvtGlG2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eImHnjlwnBRlsyWEnehbLcsL2OewTEwAgrB3PtJApne4UAnl0p4EivYMp8vkeWacJTN9y976UCuvIinfCMdMWz01P46U5Apm4dQ/69TwN0SmiFD6Vjq06nGnzHQO9kpJ7GKG+tI95fWMDQ/WPG1ioNWpnnYq7RWbipVupZkYsBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xl3kqRH7; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xl3kqRH7"
Date: Thu, 2 Apr 2026 10:01:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775149303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=emrgkYOlDfhe8rH8ctFFL/DqqgvZg+1dTxJBJOlURGw=;
	b=xl3kqRH7VAYFWis2iNQgVDHeXf32AnS+324xsxYf/C1Bp+v2Lkn8x11YIh3SoFhx1R/kFh
	o1AXQ20/Bsm27sH3hUYYgX2uhcxiTxp+p7Qdd9toNHNHK2QS7SZowFoi4LywdG1+o+KGuC
	6CqX9YeQyd+PbBROxqFWtpv1SY7MH2Y=
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
Message-ID: <ac6ejZrcnfQfaTZS@devbig1721.ftw5.facebook.com>
References: <7653EEEC2BAB17DF+20260402073948.2185396-1-xulang@uniontech.com>
 <420FEEDDC768A4BE+20260402074236.2187154-1-xulang@uniontech.com>
 <CAADnVQJawYEk53kS9-w5EXU0GnUYWWW7AF_n02bUs-GPJ+4Raw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQJawYEk53kS9-w5EXU0GnUYWWW7AF_n02bUs-GPJ+4Raw@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Apr 02, 2026 at 07:17:17AM -0700, Alexei Starovoitov wrote:
> On Thu, Apr 2, 2026 at 12:43 AM xulang <xulang@uniontech.com> wrote:
> >
> > From: Lang Xu <xulang@uniontech.com>
> >
> > An out-of-bounds read occurs when copying element from a
> > BPF_MAP_TYPE_CGROUP_STORAGE map to another pcpu map with the
> > same value_size that is not rounded up to 8 bytes.
> >
> > The issue happens when:
> > 1. A CGROUP_STORAGE map is created with value_size not aligned to
> >    8 bytes (e.g., 4 bytes)
> > 2. A pcpu map is created with the same value_size (e.g., 4 bytes)
> > 3. Update element in 2 with data in 1
> >
> > pcpu_init_value assumes that all sources are rounded up to 8 bytes,
> > and invokes copy_map_value_long to make a data copy, However, the
> > assumption doesn't stand since there are some cases where the source
> > may not be rounded up to 8 bytes, e.g., CGROUP_STORAGE,
> 
> why? Just round it up there instead of penalizing perf everywhere.
> 
> > skb->data.
> 
> what that means?
> 
> pcpu_init_value() can access skb->data ?

After bound check, the skb->data can be used in
bpf_map_update_elem(&percpu_lru_map, &key, skb_data, BPF_NOEXIST)
which will call pcpu_init_value().
