Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C0B2C027A
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 09:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769418859; cv=none; b=ZjjjIqOHpfOGr6DWq0r47t+DN4EnHqLIM/j+pk9QCSB05LZJallXMS7wpRbJguF391YYzh8BOmVNzQ6ckvheO91vQjx0Bspyy27PVnzPX///G2L4K91spXgCxt1zVU9MJWjLnAmij20UO2kpcXGTVI9hWy3YnKeTeVxIGHmZKxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769418859; c=relaxed/simple;
	bh=peXzD2DW8I6A7Eh0Zhw48glYUT/tjX1ZXrp/G2N7DTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FXvtvdw0Q5SIk+zeHKwgmOJ++AqZ0cSslvrRgJq+wPeVjNGz8Tc/W81s88cH1dQK9xrsyNMKhm6WAUZ7YDbJ1wBpF5LxuqeyVNbxizTNetYD1bE+5Q8ow0riOavtm1t7ceBODzWifznGffdb8kAj6t7wCh7Brwptt+YzLZOGRhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uzF9bXzp; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzF9bXzp"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b885e8c6700so492606666b.0
        for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 01:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769418856; x=1770023656; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T9rU2iT1saNSuK2hheS6KhfObC35hEt7+69FL4kQ6HU=;
        b=uzF9bXzpnC0BPCpJTNml5+errS39XXAOaMgIR1rZzIVUb3gp9fzSxN5aewPlnw3OVl
         tCKwe8nmfbYPE2r7EdNrk4yE0TXpdbB3I3i/LVnGnDnmUqdoz10ggvBvgndJME7UUSZc
         uM+BhV8PvoSEJ1Tb9IZ+7q2TAr437KBw+Rf0B/C7Wv7ENjzjp449a31Cvo1pImMtIsRI
         rTmQv3ieYUJenIZQqxHxi7/paUXApOmPlYNH+2wG85xzmwNzt/Ru4u5cneVnQhkECk44
         A6IY6SaC9fWtBozF3IqOULUQiiT4zmoUF9GFTs3pxnnbb1MBgMBcV5dVhzdLiQfwmv/W
         qLwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769418856; x=1770023656;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T9rU2iT1saNSuK2hheS6KhfObC35hEt7+69FL4kQ6HU=;
        b=Pxzhdr3AOVhf6PnYkQuBih2jOhU4zb9EI5OeWiYFzZky1nGRMaOdwlZcA+eq2iFcel
         3j9IeRkrQ8o6G4olzfqrfLJc6qkOndaP6a8+9CoEissx+8ZSuHipHjwBOc3hoKGatXnj
         bO5PHTOzQCj0dDuG7WjiWxqzrOExzsEOSFmNwkcLtHL8auKO5He1XOrJ28K6azcVmRNA
         FWc4aeTrYR9u8CfPRQ27fLRiNqtVRd8pZK+vUKYkKR+SFjiViNAxJjJNxKftHnxrSpZx
         AIVVZ11+6mTIYdFCgLNykYTGwrgm/tjByejFFtsmzeFd1skq+tfkNd9LDI2j+SYGUzUi
         xr8g==
X-Forwarded-Encrypted: i=1; AJvYcCWSqzuuV4aQFBeCiKGNNfFocNhJsLVSaXeYusBGs7UxpVHybtTkJ1bI3ILx3Ns0YeWEHLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcFM/maHmbxzBJV/CI0F5Ee7anyG86oX3Ne72H6deLwsZe67EJ
	4AahDcFCIlOXWOgcihktz+CeoZibbWnGxGcbHNxBLBL2NS2XSTruCiBHE7fGtif4tg==
X-Gm-Gg: AZuq6aLKSbS8kxfPjc6nfPdOozsl7Jc+9NdtFbxoxgAIy7rcrx4LXQBkH2EIFey4raY
	cYDU3IyN5mqCtUGCtgx18O+0d9dsX0SPm9/FEvOwf7Nl3m8PrUIFoPsiPrIL6YWkpknNXlE07wr
	n1QuNcM/HObE4PTStyLQJ9n5lbMq/pyRWVfUyJux2GPn/T4p/ocCyDqBPKyJj3ElrichG+V2OFu
	WlOXSOhZSBLWkMLfjhozC8B0isMU2d+4pUy/w07v2bc5dqy5ogJdauxNsAGUnvrVx7xJYS1Jb/8
	sLyw8ax+7+lpoFNynra4oVPJWEuexohnIpfpFM6K1METt1mBKjUrgWgGjnTOPoN6FqMJ0YHkmNj
	LFeCjtEdiJdh8C+kOl1BfUDBG5/8qvuH+ZW+oKqxz9+2ZkIpxpNlwy2kUbhfMNHFc46BKtBn8vf
	aFarrengmSuXqA7DmX6I2njZ7Ny/+r8QybySdsGVJYTZfvbRCUf/5CUitxGh7txQ==
X-Received: by 2002:a17:907:3d94:b0:b83:1349:3a7 with SMTP id a640c23a62f3a-b8cfee25cadmr292828466b.10.1769418856406;
        Mon, 26 Jan 2026 01:14:16 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8872854909sm495560566b.44.2026.01.26.01.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 01:14:15 -0800 (PST)
Date: Mon, 26 Jan 2026 09:14:12 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Tejun Heo <tj@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	ohn Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
	Jiri Olsa <jolsa@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add new BPF_CGROUP_ITER_CHILDREN_ONLY
 control option
Message-ID: <aXcwZOGHTdAIbzrP@google.com>
References: <20260121135444.187001-1-mattbobrowski@google.com>
 <CAADnVQ+8f1mK1+L9S6uDbo0n53zs9VeUhZr5eTg0+jXppRAhcg@mail.gmail.com>
 <aXNWLU7ay1HHmg6S@google.com>
 <aXPC_KMX_rvO14lR@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXPC_KMX_rvO14lR@slm.duckdns.org>

On Fri, Jan 23, 2026 at 08:50:36AM -1000, Tejun Heo wrote:
> Hello,
> 
> On Fri, Jan 23, 2026 at 11:06:21AM +0000, Matt Bobrowski wrote:
> > Would your stance change if Tejun agreed to mark css_next_child() as
> > exportable, or simply agreed to it being used from BPF cgroup
> > iterators?
> 
> FWIW, I don't think there's any issue to exposing css_next_child(). This is
> a part of the fundamental structure of cgroups and I don't see it changing
> in any foreseeable future.

Thanks for weighing in on this Tejun.

> That said, I wonder whether it'd be more flexible to expose
> css_rightmost_descendant() which allows skipping the current subtree
> during pre-order traversals. However, this has higher complexity for
> traversing just immediate children as it would have to skip each
> child subtree.

Yeah, css_rightmost_descendant() isn't what I'm immediately after at
this point. However, I also wouldn't argue against exposing it as
another possible control order available to the BPF cgroup iterators.
