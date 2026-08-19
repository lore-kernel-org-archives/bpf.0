Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F843AAF6B
	for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 22:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787178022; cv=none; b=K8qZFVEzbYCs4x3hRruAl0P73F/TKp0pPrXBpJT+nr89NKWk7H9sb15HiJlp6YO1vK3mqOYn/vSxcVA5ba00l6J5eSW9ERbcQeuaybtbn/iKFXZXVnwONUPTdRky3v4+aEiMJiM7aoxrySWjIoQPlBKpYwWVGMCatmQ21OeQRC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787178022; c=relaxed/simple;
	bh=M1VXUNwqUwGEgfRS0NgJ6OgY6SeOvTMhCU1xDOQSQ24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r/j/UlY20p+SDku8ti62GeD2AJm8Ql43SniTeiFap0Dr4hzaF1+YBF1wV5Z/b0M2P/659zTktwVXBMFf80oE1YOdnO3BoYfbjE/WQ7peucB+UiATF5XWwkfN8RLW8Apnui5kJJELEPZpW9HjdaRgCg23pU1UzSm1tUB2BHC/lPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VkPkvuFK; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VkPkvuFK"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38de840f2f0so1423212a91.0
        for <bpf@vger.kernel.org>; Wed, 19 Aug 2026 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787178021; x=1787782821; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=3pxS+zsXhr0mdIotv7+6gGRpeyumkKfkIec1uTTrutY=;
        b=VkPkvuFKv07HXhD/1isMbBl/+FiF6yPnHEATZ7cVaAcMOyo8Xx6ZVC3M6oMpUV4oAx
         Fs1sQmlI9IuXKdPqObUeL24zwpgXdkhshi08r+GMiVIlLFgB6+cV9JL9nrH42jCPsBU4
         +aNfi+MdOTO++mJ4d/w9hcE3kXSekoVs8HX/52jwlol1JLZNZWfgwyLTXlUVSM1zuKeC
         he8bVI8a2Tpgm4m7yXMAiTfSv1upeehI3xX7vQJ6npmGRGaw/J3kKdowBAPqZ8Fug7gy
         Mk+VQq92T8xT9b7ez/0VPvD8CzjhLqkCSLSaRrqtKeo/3uFgetXWYVO2dGJavaY4O2gm
         IUVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787178021; x=1787782821;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3pxS+zsXhr0mdIotv7+6gGRpeyumkKfkIec1uTTrutY=;
        b=SRj/u+i8/E8+hv6yXrbzsTuir+cQUPfauNSE1vpdNLqQsb4Z/1Q1MrpaT0fyZDEFRE
         62bFEG31P4j5Ip7jR8rga6z5EDbYYLzI2w4sRe4E5XGvm6/0RqaMDhhW6aZqkS+sH1gy
         QvIT3wWg1AI0gkX1K+2FMEHbRY7CZpBj0QcUUc5Lfa0VV6guoOtK34MK9PxT253TfWIl
         Jr/fpREbu6rXLmElFJZVziKWqZRL1k7y1iWUSvlQdTxYzRq+Ee53zPZGN6jihoU1I/WP
         rID2Cl8c2r0CCuBtTyhvOvq6qC0B6SPYzArDT0DB+9SuitTFpB1aQUIyQ6Ijybko9TrQ
         cXgQ==
X-Forwarded-Encrypted: i=1; AHgh+Rox2dG1u3KQIpzbW9PeBkC2q6iPs1t7NLfg+/LEjIiVBpxfx1kkN8jf8useWFFgSDS4z7Y=@vger.kernel.org
X-Gm-Message-State: AFuF++k4Pya9jo8M+Ga0Vizc5OXjNadkCDA83oQr2VFSABsw92wIM9qF
	xOoHifPsENtJ8bO3MJLaMvquHClRKHWNgHZdbtIQOj5PcrOOBby3FDBf
X-Gm-Gg: AR+sD13s0n7HCrne1qK+SA5CAcJVuiVElHcVHaZ56lAslZyM/LA+mMe0vuumr41rhJS
	srMx9F05Bc07TOAjLXQjqmN+IBOzX33omnLxk4Mm8nb+Jt+qL7Jv2mKvprZb5VjBtfTonxl6hpR
	ZU7bfN5p3cGxc5pA7L/yIrVESGIKRBWZ4XkLaKK2+7LBJV8jcpG+qyjOPpBy91Xf25+qCVMpGhb
	RpKsTRy9X1x3ve44yeS3IncOjrnCYLS4YPr0t6XP2vkeagSnPPzR/AVIacoKex63ukcKlmzyuOJ
	9aRO269nSiNMPGIt4hP668s+wFzVhI3h2AykiGgbZEuae/wVyRtqeGTA0hE8cnGoCC/yDeO8Uj3
	6sEmcDi89T0I8MCykMjkvTHlfqRyOdiQxeQPnXi8o3Fkkq2C0N5FdMNbFYtAW3K0qUtxcEL8Pju
	2kZc5OcQB0nzy77i4pycK89lMoSJxRfMGywjxNBY0n94iCg9Jt2rBKFnXw9UxZEohXWa2zbo6j1
	vNqt00N1yOejk3EMcg=
X-Received: by 2002:a17:90b:4b8b:b0:38f:efed:5448 with SMTP id 98e67ed59e1d1-395812aa117mr13843288a91.8.1787178020794;
        Wed, 19 Aug 2026 15:20:20 -0700 (PDT)
Received: from devvm16600.scu0.facebook.com ([2a03:2880:9ff:64::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ad699c9sm10555337c88.8.2026.08.19.15.20.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 15:20:20 -0700 (PDT)
Date: Wed, 19 Aug 2026 15:20:17 -0700
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
Message-ID: <aoYsIYnoFDvjkzKp@devvm16600.scu0.facebook.com>
References: <20260817214205.723267-1-ziyang.meme@gmail.com>
 <20260817214205.723267-2-ziyang.meme@gmail.com>
 <aoSUob1s8WBQ3buO@slm.duckdns.org>
 <aoTdQeLZZuRirNHE@devvm16600.scu0.facebook.com>
 <aoTf7u20mo9s6ADj@slm.duckdns.org>
 <aoTkZhQDoaQKpPe3@devvm16600.scu0.facebook.com>
 <aoYVh1ihBH-TWvi3@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aoYVh1ihBH-TWvi3@slm.duckdns.org>

Hi Tejun,

On Wed, Aug 19, 2026 at 10:43:51AM -1000, Tejun Heo wrote:
>Hello,
>
>On Tue, Aug 18, 2026 at 04:01:58PM -0700, Ziyang Men wrote:
>> On Tue, Aug 18, 2026 at 12:42:54PM -1000, Tejun Heo wrote:
>> > On Tue, Aug 18, 2026 at 03:31:29PM -0700, Ziyang Men wrote:
>> > > Ok I will add the casts bpf_get_blkcg() and bpf_put_blkcg(), and remove the
>> > > check of css->ss in above functoins.
>> >
>> > RCU_PROTECTED is probably better than get/put().
>>
>> Yes we can make the blkcg* RCU_PROTECTED but then the bpf_blkcg_flush_stats()
>> needs to take the @cgroup* since it is SLEEPABLE. Does this work for you?
>
>Do we really need that function? css_rstat_flush() is already exposed and
>css can already be obtained, right? blkcg_fill_root_iostat() is just
>accessing system-wide bdev stats, which you probably don't need to begin
>with or if necessary just access through bdevs.

Yes the css_rstat_flush() is exposed but currently it is marked as SLEEPABLE, so
it doesn't accept a RCU_PROTECTED css we proposed. This is not a problem for cpu
ones since &cgrp->self is a trusted pointer. 

Best,
Ziyang

>
>Thanks.
>
>-- 
>tejun
