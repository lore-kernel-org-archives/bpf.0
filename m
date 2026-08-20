Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F2374E5A
	for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 15:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239618; cv=none; b=EDH9kvKKEETHMI8bW12fXMuy7OwrCJgImw3Y+gjHwRf2Al8KQ1pOoNue+iXiLCK5LxdCe13GIBe+x4EcpklFLspyACAWpl8oqoPk9N08i3zBdqEbxEuBKsGh+tCtbDb/SBU1LlGl6mcrHZu4EtLc77R9GGaMgLPktVPmjDpvRJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239618; c=relaxed/simple;
	bh=4Z1WvXEDeUzIJWnIoL1PNeHzSYoaGhcYd2vTSVbFVHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u28D7iBVRpHh1p3KtEsywKAbXocG1QqluXo8jb0bHF1Es7ERbG16kEIRbf5SoUpFSCUfZUITq3Im4+hE/3BYHa1LBs3Dfc2AvASuXLP6t8DIViUpbSipBYful9VLKx+hJxGmLb+5UElL9A0gB9TIpCtB6eJap+QEtf9JNPwjNCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nkPaU4Im; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nkPaU4Im"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2389150a91.0
        for <bpf@vger.kernel.org>; Thu, 20 Aug 2026 08:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787239616; x=1787844416; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IvV+0X/Y3gO0VxJslvx+LbEOAaQHrjOILkScrCstO+E=;
        b=nkPaU4ImKryPFaE6CROYwgA8FdCT3lbs8R/nOwkWpYWi6PSAE87YCuFYK/6dNneGlD
         /PXeN/ndWWPeSJUpjzA4uf7IOPD6LC5+ZriSZtzcz5MGdBDc658yj1+n2JYmKvnpxrox
         D67eOuxhf7JHGHLm5WYiUnhWw31O9eaWmsrZL7Gc70Hc+6d36EKY5H4gSJbrYjwhMShQ
         PzCcK3dGOsTmFjOYX+bqX1p9krSKYiz0TuYwwiVKoFvHDRP4V5NA7JxWHwzEFh+VD8VZ
         SJqZcVB/UyRcG3M0DWwMddrlvPNsW1gF0PChpYrXOiEH6d3mk+78WI9TTEYRJ6zZKagq
         Z2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787239616; x=1787844416;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IvV+0X/Y3gO0VxJslvx+LbEOAaQHrjOILkScrCstO+E=;
        b=sazDMktaEbbABn1xY7RAJBG+BhHjeqASNf2TLcjLi8yDFzFpc0svXOVosJyTmFjTTu
         O9u69XB+mwqoRMNw+0Io+aCHp0LVJ71dBjJnb6OK5g8/HIHYInEyDn0KYh/HLglLYWSG
         KfvzqlX5JvC+Bljj+ei0amlM2n+WdAAmOfBL7b3oDx75gDTo9uNGT5eYVQadUYi9Xcqy
         DgAemdIrwtRQ8JadwmBCG/vHzPRi2bx4g8YouPlQ1qhGn/bL9yjsJiyFfKPzzvTW2CTN
         3aRqhGn9Oed96nHFjxSTyhfXaXSGWPVs0iKbpiDkZK10VFbusDVYyvILoxjdHKz/3j1+
         k7Cw==
X-Gm-Message-State: AFuF++kZwhavsr2qNNJ5QrZCvFSE4Xv/H1wD7LhXJzBuFvXl3Dgrl7af
	mD9OQA9xcYZfEscPfFBLgu+XjksofwewsP/Y4N1fKppOXSkdo8nuwa2F
X-Gm-Gg: AR+sD11knIE9466x1TNb1XVp16oz5zQu+4z4bNW9RqyBsK5R07Ks/iBmld/Z4aHgq7m
	pS1PhTg+IOy+/zEiF0OLRv18ttX7v4s2i9FqvO10TfHCSyW7079u53RsRiEIukCLf2DMtl5Cypn
	4LlJA9G43uvwySkO0bWY83cVPbzR9CJMseOy+LMBk5qvPmaRcZBNtceKzm3dtvBkIJmKOANK/sE
	pmGnkbHnlqFEy1hrmz9eYEHd1ZxGiw4c1Mu43R9awNjBQi7TN/tXynfr/ZjCw1THV4LJe2GgaNI
	uF6lUPk8drjLoqyScxfyaxIevuG8GFX2FTlg00vs9YQEuBbsgPYu+rJSPVYKgU5oHs61JvQoTbe
	e2+P9JsJ0hWMXJzfN7vgWpzsVVD9wwF3D1JpowQNg5xUZxmvzb5RRw/9dl7TnS50cF1dv525KEk
	QYeQqc34vpj7HXS3Rzg7OvvHsklvWLX4kmc49YeTnfJ78kQFp+RjesJxE=
X-Received: by 2002:a17:90b:2792:b0:395:5404:95 with SMTP id 98e67ed59e1d1-3958108bb19mr28368646a91.12.1787239616312;
        Thu, 20 Aug 2026 08:26:56 -0700 (PDT)
Received: from omen-arch ([211.58.239.197])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395a9e14d1dsm1201204a91.1.2026.08.20.08.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 08:26:55 -0700 (PDT)
Date: Fri, 21 Aug 2026 00:26:48 +0900
From: Junseo Lim <zirajs7@gmail.com>
To: "Florent Revest (Anthropic)" <florent.revest@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, John Fastabend <john.fastabend@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Jose Fernandez <jose.fernandez@linux.dev>, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf] bpf: Keep progs alive until the trampoline image
 calling them is freed
Message-ID: <aocadTp5OaOybxzT@omen-arch>
References: <20260819122252.1782790-1-florent.revest@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260819122252.1782790-1-florent.revest@linux.dev>

On Wed, Aug 19, 2026 at 12:22:50PM +0000, Florent Revest (Anthropic) wrote:
> bpf_tramp_image_put() makes sure a trampoline image is not freed while
> a task may still be running in it (call_rcu_tasks() + im->pcref), but
> nothing similar is done for the progs called by that image. Since
> commit e21aa341785c ("bpf: Fix fexit trampoline."), detach patches the
> return path so that a task still in the original function skips the
> fexit progs when it comes back, and counts on the prog's own RCU flavor
> to cover a task that is inside a prog. On that basis the last prog
> reference is dropped right away and the prog is freed after a single
> RCU / RCU tasks trace grace period.
>
> [...] 
> 
> Fix it by having the image take a reference on every prog it calls, in
> bpf_tramp_image_alloc(), and drop them in bpf_tramp_image_free(). A
> detached prog now stays loaded until the old image is gone, which
> reverts a deliberate choice of commit e21aa341785c ("bpf: Fix fexit
> trampoline."). Detached fexit progs still stop being called right away
> since the return path is patched.

This appears to be the same issue addressed by my earlier patch [1].

I think the flexible-array approach here is cleaner, so I'm fine with this
version going forward. Could you please carry the original Reported-by tag?

Reported-by: Sechang Lim <rhkrqnwk98@gmail.com>

[1] https://lore.kernel.org/bpf/20260815071927.147049-1-zirajs7@gmail.com/T/
