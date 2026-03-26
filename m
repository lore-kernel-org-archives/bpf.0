Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D82034252B
	for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774538649; cv=none; b=pRwyJ5447wyp66TIauiYZJVVucl1flIFy43IalkQEtffkWrnGoXzRloJ9AEXKS27IbomD2d/nNlppconrt0LFRTN4JJaJ9y+cjR7PqeuQ9WjKcEz5jk24b/gOEfcfSxt8Rh1JVAg3l5Jd1K1E+mG5hecndVCyUu/Oy9NO1njCXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774538649; c=relaxed/simple;
	bh=QWjAEz//dMDe29W9qd/2cFtUHDd5g/j6psrsougQlNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u4qGx+PW3zLoBlu/flGT2X8nqpPia40n50hrPkfV/RuzM0cW8OrwR8CnPIu46WqSsWm1+75Imf5q0CXi0NQ9CtaPPAMM3h5TaCc0aryFJrR9UG3eOQm6KZZ74N7j9GAXc1/7ZQ4EVzlwnC/MqVJ0ZrIa4T1/nIhO36evUblB8Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Hj7gdRSk; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Hj7gdRSk"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439b97a8a8cso1088154f8f.1
        for <bpf@vger.kernel.org>; Thu, 26 Mar 2026 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1774538646; x=1775143446; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j3SXFjDHalKyWonr/KBPjxaxh1IpYZ1fsMvko8xEISQ=;
        b=Hj7gdRSkxjA0Q3zNxlYG4tUisg/RSiZbCy9gjg2PyZuKDQbU+G6tixw6iuiRh4+0BB
         KUbQCLDet8s/putaPZzvdDjbJYenkKzjPEfqituidWOFLb19l2bRqMD7DaG6k+TaxBlN
         0DBJZ/JjGywCH2q4mFId1uXQk4PfW5sMsrNV9NyC3g8GNuPERkw8ILKMZ3nw5UX9nWPM
         k1kkCDecM4PFmfva9fL4pHm1Me/UUnF17waKD9ApI2Cd30GYI/u8tb5Ig/OlJP/mqQNq
         +WxWeAS8s7t66wL1LbyvRBBk8tbuOmw63S+z1gpP01j5XVjraWL91qID3vzlSLv+Rqe0
         TjsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774538646; x=1775143446;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3SXFjDHalKyWonr/KBPjxaxh1IpYZ1fsMvko8xEISQ=;
        b=O0jLNsptYbKq1NWmrxrfkD8DNRtjHR0yxYjMyUy0sP3aijfdc1kHWVjw4Jv5HBqy6c
         13F7bOUS3wcNKpi46yBBRFtPO/Ib1H01YSg9QyPdA9ahxc38JuPRhsHgSrdoFGUFsHlx
         Vlk5wXGUeiJoHxWMzAb7tSoWSy0fGGoWsSL0nG273m5RZ41B1E/OaAvV9GlBZbYAqYgP
         xBSnSW/dM+Jhgv3A/htwZHwQVWqo6rSnlO0xjM8mWvCeyxsnbfQ2Z4Gu1fArLbSxcWiF
         SYpJfevGgbExmTTjQ5R7sXZBIHjh63Wa7u7mHaMCGbNqHh1Enhf4T2zWgFamabcG3TTa
         J2gA==
X-Forwarded-Encrypted: i=1; AJvYcCUdyIrnvw4ym8qgqnR3TulEcHk84DOesUBMt37aNVviOqVrk/08iB3cnVoDvAhn7IXyw/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw83/TAGg36jzZcVhmmzN5PYAJB00YmLXmJtYz++BKyLa7jCGpq
	Lxrqz9mEfGTWLg6HbThoLXtKDivILgPphwgAt09JCPzu7n6T8ATLfplrrZScACumK80=
X-Gm-Gg: ATEYQzzCFQQgCKIUiDkHWwJy+obTvKV1r6uvDG3GtY1+5DeWHUGxH0CZb75i3wm/4UX
	QQ38f0U894Q4CC6wBJpmJVZppBQCX5NIBwP5UHj5dVskyoX4AL2riA0TQbTPz3i6fQ/n9hk7j4+
	8Ms6pcVV0yAyvLw8Cq+O6jCiePZOiwD4PnucuxQ7eZbqTm8JzFYUzGcRyJupOWvYjUTtw1bKHks
	nOtCxo/3Y02dwII8zquiKCvv7UpjBcpu2gDKizk61iJGS5PZyy7YIq/mxPld0lB4mubi1rj8b5u
	6Pu7CgtBipBU5zHAHtR5IoC09RG4ceGUfvT2hG+zn06JrwV0whWFmpQf2qcMu6fYFrEIK5/msUN
	/LShPpChXYORExu4ndJp2yfrpOcN7WdVokZ1fdzZ/mCGfNQaslxJKanT/8lbCor+r1yexjWRutx
	bvovbjYhX4YxTPdvWyrojAeGhb/y9lrAeirM9d
X-Received: by 2002:a05:6000:40c7:b0:43b:4396:674c with SMTP id ffacd0b85a97d-43b88a39bc5mr11889230f8f.55.1774538646054;
        Thu, 26 Mar 2026 08:24:06 -0700 (PDT)
Received: from localhost (109-81-31-149.rct.o2.cz. [109.81.31.149])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b919cf2d3sm8479963f8f.19.2026.03.26.08.24.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 08:24:05 -0700 (PDT)
Date: Thu, 26 Mar 2026 16:24:04 +0100
From: Michal Hocko <mhocko@suse.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: lsf-pc@lists.linux-foundation.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	David Hildenbrand <david@kernel.org>,
	Qi Zheng <zhengqi.arch@bytedance.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Chen Ridong <chenridong@huaweicloud.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Axel Rasmussen <axelrasmussen@google.com>,
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>,
	Kairui Song <ryncsn@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, Nhat Pham <nphamcs@gmail.com>,
	Gregory Price <gourry@gourry.net>, Barry Song <21cnbao@gmail.com>,
	David Stevens <stevensd@google.com>,
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
Message-ID: <acVPlB1Y8IR-RKCg@tiehlicka>
References: <20260325210637.3704220-1-shakeel.butt@linux.dev>
 <acTcStxrTCWAN6Dt@tiehlicka>
 <acUzMdxCDfbuyv9J@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acUzMdxCDfbuyv9J@linux.dev>

On Thu 26-03-26 06:44:07, Shakeel Butt wrote:
> On Thu, Mar 26, 2026 at 08:12:10AM +0100, Michal Hocko wrote:
> > On Wed 25-03-26 14:06:37, Shakeel Butt wrote:
[...]
> > I think we should focus to make a single canonical reclaim
> > implementation work well. I.e. we deal with most (or ideally all) known
> > regressions of MGLRU. 
> 
> Here we disagree on the approach or steps to reach the single canonical reclaim
> implementation. MGLRU is a plethora of different mechanisms and policies and it
> never went through rigorous evaluation for each of those mechanisms and
> policies individually. To me that needs to be done to have one solution. 

If my recollection is correct from the LSFMM (2022) there was a promise that
MGLRU architecture should allow to add extension and eventually
supersede traditional LRU. If we do not see that happening then we
should re-evaluate current MGRLU approach. I do not think we want to
build reclaim_ext architecture on top of the current code. Or are you
suggesting to achieve MGLRU through reclaim_ext?
-- 
Michal Hocko
SUSE Labs
