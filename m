Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1C8239E88
	for <bpf@vger.kernel.org>; Mon,  2 Feb 2026 03:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770002775; cv=none; b=NGXFSUfmCPDyswYCpw4ma82oRBYrRA/dsAZVUQ4gr64+ofJhxbUtbyI7dHSKQDUvYXTPHmHOdigsGRd4t5FVUtA4Wj4+xdMjQVSTSWoFk2Mp2cPYl5SUvcAffPdNUs6SVllvCoavKpKAY6jtKlo6Vs3B9ukfHquqxhAmR6wVPVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770002775; c=relaxed/simple;
	bh=ZJqj9ri7+QRS7FBfUr198f3zndQJRIxPcf6OjR7r2ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a0XxHIlAocQ3Hbtwoi52u2jjE4WlDNv/n7AxZJvJxzbWw9J5amXLk+JYo0a0pnaYIYqCC9Hcs4JHgBoCA+DeZX4o9lpjxobexq67EfVdeDmep+27ral9FcjtRBSXkpMQ2+WsdQOMTsj5kPjuBYKKr313+0T3brC1tX+XQcFY50Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=m/J6OKSh; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="m/J6OKSh"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b885e8c6727so767287966b.1
        for <bpf@vger.kernel.org>; Sun, 01 Feb 2026 19:26:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770002772; x=1770607572; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8y1tSjszHwNi7K6C6xGA7ozYqT29UdTx9KR8G4VZTuc=;
        b=m/J6OKShA3QjFN/CjRWFK2+WtOuc4WjnkuZXwFP+pZt/mCT7QiSownfTIZd5cCtj59
         Slb6HDIjcOpo6RHuW+5BRpuUUvSOtGVwvQq0qbSXUk5n85IukSxzD94GPDX/Hj88GX3P
         5+v7w+z9lpKGSqlKjUuPIxjeSu6UdMRQrcmuALSEsA5gUq+j49dvELzBD7VBh3y951/w
         9DA8TlNBwhRDYzfxjSPFeikqY7pFoqnTwIHKuX/HwLt2UEDinqErci35UnzBRUBylUB9
         nb46qMxjJfT7rV0rOWapsmnLNX6Sd2rZbALgV9fdveszEtI8ol5k6apib47uSrK/y1XL
         AOzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770002772; x=1770607572;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8y1tSjszHwNi7K6C6xGA7ozYqT29UdTx9KR8G4VZTuc=;
        b=HKcfNSJzNCezMbZtlkUaADYfXNFsYM5gxOWhQHjAcGCDf5nuAo1lUNunJ+MFL9mE8F
         jZbwoR28QtwKeKf68e4y7ufxId0K1Gjf2gGCI5UvfMLqaQfxZdIRelr6+GAPfcAJVfwl
         HOcRL8YpLadMotFslYpct8aISAbkfk8datcDFp9LArMK+Opw2y+zoN5w91SC107ZMmTj
         kwzH62YscU/8TIlfBp8hh95ICck4i3PfcC2Ar1Y/2cNAfbKhx0F47z8RO50HRxn0Pd5D
         pa5QoT9PY3MHRxgZ57pAyIiYq21719/IHu2YHcQuW3bUyGnp40d+KAKXarLMBJ/UvFPj
         4oJg==
X-Forwarded-Encrypted: i=1; AJvYcCUYV/hZAeIX/zc4UuzUSaFHBFiy6wI47Xuzgrk633BXaZjBCnbQxihhTEcPY8PFmFAzlb8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4c1ojTBGwEprNPcFeaJlbVNtADGjQn/c/GQ8T7yZNHfOEAGNK
	ZO/JHNowAWyEZRCzIvu4kFyZN6zAndo+nTFv5nrJxSFCiYZ3ygsYmJuwPksrNoHe3Q==
X-Gm-Gg: AZuq6aJuQL4j9YTx5nFhdWeqMM12bCp/pfcP04DRHknkUVWLA/HbiLkFGPDf+x8sBow
	AovKumC60HrGClJk8P8GphbJKQRNRzxk4HKRoUJQE3iDHRIaYBLkx4mNviLnzvJ9LQOBP8/BxqE
	SXTzAEgPuD4g5Mn5dBPB2yLSIQ8yWJdHiCVFlNBQaYCOkfXNlkrDW3yhPoMVV9ClkDnitskA/n+
	G/xRcVoRxeywJXS+A/kf9wDAjtaytPKOLTLVdAmbCIEffM11wUOnKvdURywhVxBVfm+eNMc9Hnd
	sCRZMPRbBijC+M6ajYpwcvzgasdeA9hHwYjG/KzXyk/2o8mnbMs7O1r0VGvRhD5EEId/xnGWarC
	d1duy1sOPpppGlKg1EuwU4JoXpnmPGVHm7ko1hmj4+76//MQM2T9ueQa8k8NItvdD4B3PiDbgio
	b/i1ae9MvHEJJjeK3/XG/0G4ZYqey9qkFFdbiaXQsYfY+O+dCN/a4=
X-Received: by 2002:a17:906:f049:b0:b87:6839:6175 with SMTP id a640c23a62f3a-b8ddf84586fmr869883966b.10.1770002771786;
        Sun, 01 Feb 2026 19:26:11 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-658b46abb3esm7161539a12.32.2026.02.01.19.26.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 19:26:10 -0800 (PST)
Date: Mon, 2 Feb 2026 03:26:07 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>, joshdon@google.com
Subject: Re: [PATCH bpf-next v3 00/17] mm: BPF OOM
Message-ID: <aYAZT-ZZSKdiChfd@google.com>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <aXh_LpTzDhvv20uB@tiehlicka>
 <7ia44io6kbwj.fsf@castle.c.googlers.com>
 <aXnDdkYmtipGwSjK@tiehlicka>
 <CAADnVQ+ghTc5FtJCjm4ya3y3xVpSuJe-7ctdT-thowqWguc1pA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+ghTc5FtJCjm4ya3y3xVpSuJe-7ctdT-thowqWguc1pA@mail.gmail.com>

On Wed, Jan 28, 2026 at 08:59:34AM -0800, Alexei Starovoitov wrote:
> On Wed, Jan 28, 2026 at 12:06 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> >
> > > Another viable idea (also suggested by Andrew Morton) is to develop
> > > a production ready memcg-aware OOM killer in BPF, put the source code
> > > into the kernel tree and make it loadable by default (obviously under a
> > > config option). Myself or one of my colleagues will try to explore it a
> > > bit later: the tricky part is this by-default loading because there are
> > > no existing precedents.
> >
> > It certainly makes sense to have trusted implementation of a commonly
> > requested oom policy that we couldn't implement due to specific nature
> > that doesn't really apply to many users. And have that in the tree. I am
> > not thrilled about auto-loading because this could be easily done by a
> > simple tooling.
> 
> Production ready bpf-oom program(s) must be part of this set.
> We've seen enough attempts to add bpf st_ops in various parts of
> the kernel without providing realistic bpf progs that will drive
> those hooks. It's great to have flexibility and people need
> to have a freedom to develop their own bpf-oom policy, but
> the author of the patch set who's advocating for the new
> bpf hooks must provide their real production progs and
> share their real use case with the community.
> It's not cool to hide it.
> In that sense enabling auto-loading without requiring an end user
> to install the toolchain and build bpf programs/rust/whatnot
> is necessary too.
> bpf-oom can be a self contained part of vmlinux binary.
> We already have a mechanism to do that.
> This way the end user doesn't need to be a bpf expert, doesn't need
> to install clang, build the tools, etc.
> They can just enable fancy new bpf-oom policy and see whether
> it's helping their apps or not while knowing nothing about bpf.

For the auto-loading capability you speak of here, I'm currently
interpreting it as being some form of conceptually similar extension
to the BPF preload functionality. Have I understood this correctly? If
so, I feel as though something like this would be a completely
independent stream of work, orthogonal to this BPF OOM feature, right?
Or, is that you'd like this new auto-loading capability completed as a
hard prerequisite before pulling in the BPF OOM feature?
