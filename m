Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6496034F483
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 23:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787184000; cv=none; b=nkivRa8lM8bi+UJTXkRc6p7rr+cm72PxD7mHQFvVRsk3NcFgx6bi6LQY2Z9bAL+uxqJjlm3q32vw7vO7JG47C1cv3oVt0hV/z+15/HxP63oSKeqRLdlGABq2ZkUxvZee/SoVeWC8fX6q96tSJlNaZe6VPYj5GBniBXqkB5n0+FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787184000; c=relaxed/simple;
	bh=NGp/aL9J6o0WYmHnohWsvAE5IdAJbRwI8aWJlovJsXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H0SxLMP+lf4MaQpeNnGuraLSSLuDtC2PrTjqBs8OFIETSnBy0Vf6ueanPISnCmPlUzRl148lwINaYbenNJN/SAkAiS9QGKJIMVCbybfni19Hyk6W9tm1930FfBC0JAYIh7hdMtvRXnk5FxcEIinP7JykZ+whwqs8mqUcqTSku9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOo4Affm; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOo4Affm"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-cbedbaba5fdso864528a12.0
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 16:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787183999; x=1787788799; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sLv4USOHSGhU+T0T1FSL7i8gQWx1GCa8Cf4zSXBJYXM=;
        b=UOo4AffmBRNzbrzeIGhyS9M+DR3r68ADGTp0Ohq7tgP9DAdDWXa62tsUBF8f3vanYM
         G1kni+ApT+WrhlibrZr5aJHzcww9D+Djuy6yXjK0/ZQHlN8Bvy9hmeRspLcS/mky+9aQ
         Kq8qNuLX+LeRoA3wNntmNHgPaQn0S7AU4/osJv13dN8egm3wIFb5QdA2oB8o01+07EZ3
         ujCa0smf3o0KdVsDDuuWcKKX0V5t8BVJPr18KfLQrwrVIEbzwpANKc4MXQFQbss/FOiv
         i+mquYQeSYBMCDZHSSfqUDEryfW15Rxj0Mw4w0/huCdoK7khE/pZAjKB+q7iaUrp6jNR
         8L4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787183999; x=1787788799;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sLv4USOHSGhU+T0T1FSL7i8gQWx1GCa8Cf4zSXBJYXM=;
        b=fbN40P6Dffze434OVj21jSvVAU+byxOm0wZEjPktG91uqUlzQVmXyZG61aVhBEtHG7
         3njld45sk4Umj1TtMDWC6kzH18PVAC+ewldZDWjZXR+hlzOnakpfcM4N1kx4midpSpBg
         mVUOcuEaPISi+QNh3hxctpvBLon3MYuKGJsMIyHUDHXfkaNfO3UomSNE2y53Wl94dPOr
         TXPd0Ary+Mn1Pcu1R3MRzSk8y662RPo2oLjs/fwWpcI4XMV++VsFE0Jxguzh2M/5hPvp
         Sl+lZLzcvtOy2YHEwFx9Zr+oEAhYKOahrfSoew4ddf9YBSy/CaIWntH9uwqT1ykD4c4f
         36xg==
X-Forwarded-Encrypted: i=1; AHgh+RpchF3YpsaYze/SEAm7GINMwljw1mFgCgu5mYKKWfE13ToDyWq0wjit+m+IcP3kXHjwl8U=@vger.kernel.org
X-Gm-Message-State: AOJu0YweOzEs6ntT5yTyaM8bDUQopJAUWYj3bTp4dvprN7iOAMnZ6h+u
	eR1lPxMyEy5PjDGT0FlD4D2WRF8qfem9dOPFCc/knUe2tFB3rdEyUWOr
X-Gm-Gg: AR+sD11i0AeRPN1qvse+rEzokpUrwJXrugNT3oOu0wmyja5ebLU/IeSFp6S1IAqUn4/
	G2vy3FzNN89R4o0uXG/FFwzKOavzsusqAL0MlPlDw8aMHTxA+J8C4RZ3fWCi9IzKoMcc6ks1ROK
	cr2N1az6lDAvPYtihVLO1f5uIIQe+AwkZHqzeVwSn9z2z5CbKfMDlu7Cmn1uzXDpb2V/WUWe8+E
	rF9DaVAi6YfpDtvl4+qeyl9DQPzac+UqLZueXTW0HJ9jGP7wafqEnNx3AVs4cpXxDdcJxT/Ib/D
	srcnBnmO3KK6A62o/5LnJPKaOL38JAAG9AOtTE0ojOVK9YVjpjBoiktVPZh1KQk1ysSz2dDIr0l
	U21rvMRv8mkt4rGGCUuDJPSofK8RI9MOb9Lp1Ro7azkjNB6+xriA9QCO56Du7Z51b96uFR84gzV
	NyhowI2Y5SZJWwUfBFLtsb9Hlkpt416b5hi0Grgs+dDCkIqz0tIoyAfEHAoi/YYjroQQRSgS0uw
	/okaE+P
X-Received: by 2002:a05:6a20:734e:b0:3c3:954d:278d with SMTP id adf61e73a8af0-3cd010ff4b9mr13863807637.9.1787183998514;
        Wed, 19 Aug 2026 16:59:58 -0700 (PDT)
Received: from devvm16600.scu0.facebook.com ([2a03:2880:9ff:66::])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef3ce17sm15822174eec.1.2026.08.19.16.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 16:59:58 -0700 (PDT)
Date: Wed, 19 Aug 2026 16:59:55 -0700
From: Ziyang Men <ziyang.meme@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: kernel-team@meta.com, Jens Axboe <axboe@kernel.dk>,
	Josef Bacik <josef@toxicpanda.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>,
	Mykola Lysenko <mykolal@meta.com>, linux-block@vger.kernel.org,
	bpf@vger.kernel.org, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] block: add BPF kfuncs to read blkcg io.stat
Message-ID: <aoZDe0yvb49flaOs@devvm16600.scu0.facebook.com>
References: <20260817214205.723267-1-ziyang.meme@gmail.com>
 <20260817214205.723267-2-ziyang.meme@gmail.com>
 <aoSUob1s8WBQ3buO@slm.duckdns.org>
 <aoTdQeLZZuRirNHE@devvm16600.scu0.facebook.com>
 <aoTf7u20mo9s6ADj@slm.duckdns.org>
 <aoTkZhQDoaQKpPe3@devvm16600.scu0.facebook.com>
 <aoYVh1ihBH-TWvi3@slm.duckdns.org>
 <aoYsIYnoFDvjkzKp@devvm16600.scu0.facebook.com>
 <aoYzjaXQNmm9bDcE@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aoYzjaXQNmm9bDcE@slm.duckdns.org>

Hi Tejun,

On Wed, Aug 19, 2026 at 12:51:57PM -1000, Tejun Heo wrote:
>Hello,
>
>On Wed, Aug 19, 2026 at 03:20:17PM -0700, Ziyang Men wrote:
>> Yes the css_rstat_flush() is exposed but currently it is marked as SLEEPABLE, so
>> it doesn't accept a RCU_PROTECTED css we proposed. This is not a problem for cpu
>> ones since &cgrp->self is a trusted pointer.
>
>Yeah, bummer, so we get ref on cgroups but the subsys pointers are RCU, so
>that means those refs are only RCU protected. I guess we can't avoid a kfunc
>to get acquire a subsys css from cgroup. I wish css_rstat_flush() didn't
>schedule but it does need that cond_resched().

Yeah that would be a pity. I will add kfuncs bpf_cgroup_css() and
bpf_css_release() to handle the reference for the css.

The bpf_blkcg_flush_stats() will be removed as well.

Thanks,
Ziyang

>
>Thanks.
>
>-- 
>tejun
