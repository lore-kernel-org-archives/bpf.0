Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B62EEA8
	for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 18:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777140003; cv=none; b=NRmaKaMuaSpTf2anyiNoln2vo9C5R1zj6ga5fDpQ/JUjPqx0OHaALY8r+59e7oqX6fKUHNNeUN+m3hQwtO7bv9bte7lmuDbV6WZYo/Y7RFBd8XLEKdb7uIX8tROzhZQP3iQUe0W2W/rnvJJ121hbp7RC1Vo/kUozNL2GgD9z/9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777140003; c=relaxed/simple;
	bh=CK9YYDsSVZGCgJah9TQvpjQXc/1mFwRV9PzA3lTyxVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tXaVUJ7X+q3sK9NBbYC4ERb4CI9txEW2tq2NUgoveqkifqLwiD+z92egrveYAHi0FWnmkfjLLo93UfYlEkkQDyB8PwYBMN+HCEFAuFT3yHCNlgzK+g0XGXK9JxbiNrX0Tvxboovd+vcw8jLINkfGyyXDwFoFUMD5wkjMLcPLHbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eodqC1a5; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eodqC1a5"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-35fb166b0c6so4835812a91.0
        for <bpf@vger.kernel.org>; Sat, 25 Apr 2026 11:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777140001; x=1777744801; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qFcDbOFyHJ3yOFFB2U6uoZi3zDlX/raHpEMdVEL47T0=;
        b=eodqC1a5xSY4OQOtI1+tC7j6Hak8NtyEN5Q1FmzULRhs94K4UIRBhDAmqM4RfrX2oR
         sE+hdQZgSpbeEK4VqNYJvXJNKDwMlk/KGwbjpIVBGEqGO3sqvNndJ1h/iGDss72ESTjr
         7FWe3Xk0WjQyjWZN2S4l6yAEH17x2iQLaA2IGCJXdIe5oPSc7muDq6gAt7G61Jla3xkQ
         pW7/0RQ/1+ypsIUYi2irOx4TRLQrK07pATGK/3V492UMWiDCEQOBS85xuPyFG9IhDGVr
         21z/fa3uC3shqk0HRCPsjtwmaSSqe3SmbsG7ZPP5PMChw950Ccpn7ecvANVFV+tmYFO9
         dnXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777140001; x=1777744801;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qFcDbOFyHJ3yOFFB2U6uoZi3zDlX/raHpEMdVEL47T0=;
        b=pURnHFYbzjPjA6CeYO3Xas31tUusHZN5WUT499jFu2wUF2l3/x1TsFNdc+zFJtMo4+
         pN0xiCvt8C4ESV91+YnhSyd7KZyY+UTwNOj7YOC2wxd/f2oF6iLkipLuordHUieBRNYy
         oYxIWt0CAxBDPeHPRK1zA4lQ2Gsyrpye1TaJxJXLQ51ae9/h8V4cqyyRUe8DizSdFPkI
         5zgkZTr4JZhlT667LAtiej1XWz+7I4+j3MvvQ7j4b3BjVzB5Uf9ALoEKqX/svY0vRUA7
         WzhrybprCV0URP7OlbIFleHrNfh9/2quDqDYliMWbLKaZF3FUUbx4E9QcgDA+bl5vwv0
         fK2A==
X-Forwarded-Encrypted: i=1; AFNElJ8WN7nErff8sW3d7FdkOsjbFcZ/6PFVZSosbdKG5TE5HRJtRj6RGZK/qDeiP/kD4WnE588=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgz+mRm8wzuMYjQKBtkCy2godaO2LZxrU/2ARIV1WjjI9qbIC/
	y72xkggyhx8XG521qIgOibmNAm1/NJwPaP84uozWB42d3WUp4OKmR52U
X-Gm-Gg: AeBDiest0hXGXo+TYJVdviUgVEO4JtH7w1H6kwTiVugbN39QKZlPjyohgJjOJmUBfh0
	TZXzmjzjVYNIghpMlVYGxEUTxKesAFj7xDnbyUqZ6ywa6Lakh+gLMPWYpYv29Ew0tNY6M1TDhDs
	BjBsCmCD1XJ9pqR6UATCdZtYUJBcWP8eDbSEA2RNh1xByZwesN/YLd4ZYllwlH/M6iXVFYsfMia
	YCt4h0/EBHOIySrQEqPlRHmiyTQN8jMZVkvhXzrBUa4bfg6U70GCoS7+PcgLfUg2wQ9tDk/ayX7
	tbOxiSUyuplWC+e8txRrVw4UYI+SPoMwN2sqq/BvCFBQJPsqBI+gnS5W997dNhjg0HLmcGdWMox
	EPlKVJ/8SLpVe41LWhxwzhF+H9HiL7qJsjdiJ9pZnMeCI08YLWePqjbaI4/FMSJ7457KQIECbkj
	EEeTTj7GlUB84j37BOND2ZRwb5Djg2EJQ8BxQLRAJmJ0XkUKdhohLqrMyVYmhi2ETm6LXdeKN5
X-Received: by 2002:a17:90b:384a:b0:35b:9e53:e2df with SMTP id 98e67ed59e1d1-361401beeaamr33976893a91.2.1777140001191;
        Sat, 25 Apr 2026 11:00:01 -0700 (PDT)
Received: from Air.local ([198.176.50.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fab30f29sm258765765ad.68.2026.04.25.10.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Apr 2026 11:00:00 -0700 (PDT)
Date: Sun, 26 Apr 2026 01:59:51 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: Martin KaFai Lau <martin.lau@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, Simon Horman <horms@kernel.org>, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>, 
	Xinyu Ma <mmmxny@gmail.com>
Subject: Re: [PATCH bpf] bpf, sockmap: zero-initialize pages allocated in
 bpf_msg_push_data
Message-ID: <aey55I9gC0VtaN1p@Air.local>
References: <20260424190310.1520555-2-bestswngs@gmail.com>
 <c4a9412d-b6ad-4b80-9580-865575f4152c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c4a9412d-b6ad-4b80-9580-865575f4152c@linux.dev>

On 26-04-25 11:17, Jiayuan Chen wrote:
> 
> On 4/25/26 3:03 AM, Weiming Shi wrote:
> > bpf_msg_push_data() allocates pages via alloc_pages() without
> > __GFP_ZERO. In the non-copy path, the entire page of uninitialized
> > heap content is added directly to the sk_msg scatterlist, which is
> > then transmitted over TCP to userspace via tcp_bpf_push(). In the
> > copy path, a gap of len bytes between the front and back memcpy
> > regions is similarly left uninitialized.
> > 
> > This leads to a kernel heap information leak: stale page content
> > including kernel pointers from the direct-map and vmemmap regions
> > is transmitted to userspace, which can be used to defeat KASLR.
> > 
> > Add __GFP_ZERO to the alloc_pages() call to ensure the allocated
> > page is always zeroed before it enters the scatterlist.
> 
> 
> 
> As the helper's own documentation says:
> 
>     If a program of type BPF_PROG_TYPE_SK_MSG is run on a msg it may
>     want to insert metadata or options into the msg. This can later be
>     read and used by any of the lower layer BPF hooks.
> 
> The inserted region is meant to be written by the BPF program — that's the
> entire point of calling push.
> 
> If the program doesn't fill it,  the push has no purpose to begin with.
> 
> 
> Isn't the uninitialized content a bug in the BPF program rather than
> something the kernel helper should paper over?
> 

Hi, Thanks for the review.

In my testing a process with only CAP_BPF + CAP_NET_ADMIN can receive
kernel heap and vmalloc pointers through recv() from the uninitialized
pushed region. The uninitialized memory contains critical kernel metadata
such as direct-map and vmalloc pointers, which breaks KASLR.

Kernels without CONFIG_INIT_ON_ALLOC_DEFAULT_ON (e.g. RHEL) are
directly affected the leak is not masked by any mitigation.

Thanks,
Weiming Shi

> 
> > Link: https://lore.kernel.org/all/20260424155913.A19FDC19425@smtp.kernel.org
> > Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
> > Tested-by: Xiang Mei <xmei5@asu.edu>
> > Tested-by: Xinyu Ma <mmmxny@gmail.com>
> > Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> > ---
> >   net/core/filter.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index bc96c18df4e0..ea02239892fd 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -2820,7 +2820,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
> >   	if (!space || (space == 1 && start != offset))
> >   		copy = msg->sg.data[i].length;
> > -	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP,
> > +	page = alloc_pages(__GFP_NOWARN | GFP_ATOMIC | __GFP_COMP | __GFP_ZERO,
> >   			   get_order(copy + len));
> >   	if (unlikely(!page))
> >   		return -ENOMEM;
