Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DDF3B6364
	for <bpf@vger.kernel.org>; Tue,  7 Apr 2026 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584340; cv=none; b=CPFeTcvq0GA4yzey0HXwT4RChPZ50uwSRoVjX32rR06WPZPxrMX4LcHQuR1VaNgjSEGa4mMCTT7vp3zWkn09kH7YzJ13OrUNtgUmH1arJWlPY9Ip2SegwnGLilGA4TK2KX3hv9WqEP7Y4zqEHPC71d5Dx6sT3wqO3Jx4OBzUPDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584340; c=relaxed/simple;
	bh=QB0AIHP/yhGlos3su1xlt+tWn96F4bm5REKqaebKwxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UksKXfovBRWB2KQ/ajdJttZAJkwo7YXPZ2bbjPcS512RHPTsFHVFB/VAI4SZGZPBSJVFZyp9tQ8LE7dGqumKBq8w7BPNemF3mzjja0Kd1fFD7QfSHlGY7oqwmO9uvGT4n66KRoTWonDYM84GOmF4rVVLvrP7P4A4Qm7zS9t5tnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=gdP1pQGY; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="gdP1pQGY"
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8d00cf835b7so661459085a.1
        for <bpf@vger.kernel.org>; Tue, 07 Apr 2026 10:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1775584334; x=1776189134; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f0ZTt7KTo1Z5++sDXYYTj6JcPbx8mSVmg26ovVl8fYI=;
        b=gdP1pQGYki9gHZLNbbzKeJDOTEzz/UxLRJX0VJEXVHYCpZIRJ5r1N5EnN+VoWYx3kP
         bgzeSWyQL3odh8I/Uifqd2e9R17oz8ZJ1ojmCDdh3GGgkzM56zmya+B/eagE1Q5w2kuX
         PSklg2RuKq7JxaWKxZsePyb8gWIsTZRLA9HLs5H/vf5Swi9BqHYRLmUsBlw+bJWftrsC
         rm8xW3RkV8OJofNZlBY6vnQhC1z2KHUBT05UYkHNFEn3q4lT3kB/o+fashmO203YfhEX
         B9lny7uPCK461YtW+TQ8/qmugxrceuZKYJaIixQB2j7oE4O3FODreW1ytuhmA/O3jo82
         UykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775584334; x=1776189134;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f0ZTt7KTo1Z5++sDXYYTj6JcPbx8mSVmg26ovVl8fYI=;
        b=lU3sjPz5/eNChsKFtqc8H91zzMgtMWrAl2j2JZ62frGWADHPtOodBh05u6ZuVh7dCG
         0WLMvO49zlMGtqSm/J2SIywYoRySpoiy4+3RmFvwkcoj5J6As/Z6qd7bxHXJ7Scg0xco
         hnSUPus2ZQ7fZFxj0fXZZXrMx7Srn25LxTdVE7fONcsTHN0LuYdn2eMeySvg9HmuF3rK
         FsmbasGx4THVy3L+45kqZd78nPP53VtcRcPzAz+j/j82cL5d1FL4fMs4JlgYY7QGk+bb
         Q1a/3LF0tKCVlAsvWOjOl6TnVBCZqUdOoARt+EmJ0istEVxGJ7SksYcccUOYOkOGqsQX
         hjuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgBtbWXw7KJC5EvWQJfA+fKmsJ5stihN/VOpKF8UtBTKBEgU2tfz4BJ5RuwpaiV14a3V8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJIDqNncBFQ0/ebYsZw5o1zf3xBd3uowZAXaq6TSJVj5/66lSV
	y7qCXE9mwFo8aWYf5DjXvOxBV1DKzBpcJ1ofZ5gCzb20L1crt5/cqVHNnrW3GvJeR0E=
X-Gm-Gg: AeBDiesw3kJCbz1EyOwy7erAg7OsrNH8zUjIHJLJjH/fWjr61s4sbo9e3FRLpZxXvlG
	CtY0t/xbyQTWfa4QIo8FvI/d1TcgYKGMZcIJqnSlGn7z8bKXSsSdpGS0xYfxT0LnX6m3srhgCt4
	QDiyqd1g1BeD8dLwdyfZ+L9sk+dJVjSvrG2xldRorlbNdkT2YLMSE8F3bm94QCuPU4QbUQvz+Yf
	kpRTCaDsr+u/VwoJ66Re/FH4+0wbB1xAUG328EHYNhQl+2xpI1dC4MxOfvgGmU5GlIvToXo+8CL
	0FKGY6YPdRLzJ3DqcbBgydkO+6tNMOYGoyPvG/Uy3vmr33ZYnc7Y+RF1j+xQJqyIMrSubYDiZMF
	b6HRrZXqS06u0AO4YhwydWgseAtT0SyF30TRs97pz4DkLLLUqNiA5JphhJ+mKfGecd4TQhOb+H6
	oCV/Pu5iWCu/AJChscwseXrg==
X-Received: by 2002:a05:620a:171f:b0:8c6:ff8f:58af with SMTP id af79cd13be357-8d41e244447mr2488312085a.51.1775584334577;
        Tue, 07 Apr 2026 10:52:14 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5c5fe8esm1376946685a.16.2026.04.07.10.52.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:52:11 -0700 (PDT)
Date: Tue, 7 Apr 2026 13:52:09 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Gregory Price <gourry@gourry.net>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	lsf-pc@lists.linux-foundation.org,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Michal Hocko <mhocko@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kairui Song <ryncsn@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>,
	Barry Song <21cnbao@gmail.com>, David Stevens <stevensd@google.com>,
	Vernon Yang <vernon2gm@gmail.com>,
	David Rientjes <rientjes@google.com>,
	Kalesh Singh <kaleshsingh@google.com>,
	wangzicheng <wangzicheng@honor.com>,
	"T . J . Mercier" <tjmercier@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [LSF/MM/BPF TOPIC] Towards Unified and Extensible Memory Reclaim
 (reclaim_ext)
Message-ID: <adVESVyz11NMa7Lp@cmpxchg.org>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <42e26dbb-0180-4408-b8a8-be0cafb75ad9@lucifer.local>
 <acVPrEyfcE4Naz5b@gourry-fedora-PF4VCD3F>
 <248a126c-43e7-4320-b4bb-282e0b6da9c4@lucifer.local>
 <acbgIKuwDsPvPjdF@cmpxchg.org>
 <adTonuzmUc2AzUhp@lucifer>
 <adU3P9fk8h-AmEp4@gourry-fedora-PF4VCD3F>
 <adU8VnzlLw9JUHB3@lucifer>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adU8VnzlLw9JUHB3@lucifer>

On Tue, Apr 07, 2026 at 06:30:55PM +0100, Lorenzo Stoakes wrote:
> On Tue, Apr 07, 2026 at 12:56:31PM -0400, Gregory Price wrote:
> > Might as well consider the functional testing question as well as we
> > decide what those interfaces look like anyway.
> 
> Yes, adding unit-level tests would be hugely useful.

Do I know just the tool for generating these...
