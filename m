Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CF6175A74
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 22:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787092295; cv=none; b=SxfxvsyFcxbpYiRO4dlN34OF9vsynScMwxiXauA2Wxish65aPTEKip31LiyGxTzxA3hOtyo79XRxFTKImwnlB+VSxd0IAZ+NL4rZlsVLthHxqClfuDPf7xsctfU2b4k1mIEM4Rqd7lW8DJsTlRWUQyFZHJqNPZlj/ed0ZkGmkSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787092295; c=relaxed/simple;
	bh=uuQkTIjteO35Ck9wft7z8E25w0ojFQnZ5h0DvgiWKa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OR9L0ci/8odUaJsjfGcd2N4G/Be4bLycQcKyI5zGcSoNnY9lzgSLjsfaf4pRudoYu6FFeO3EPD+N1058hgunnVW3EdPcKj0V83iMioBitBCungZipxcGxyxOPxjVNzpsXjQJh7UPCpDNP5AU2l+u8fc6sDF7bUlIjAWw6JKeFOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/A5qmfb; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/A5qmfb"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso426516a91.3
        for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 15:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787092293; x=1787697093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EFl0Ov2rpc3xev/n5APT5V/efpbjI8Ad2gYSG/EUGz0=;
        b=s/A5qmfbuM+5ecriHmwzNPk4HIcLd+JECC9r2BEWPEHoIA7Tm8ve+21b9T6s9gpkga
         OJa2uKTSnLIQZOvUihDOiHo9sgNGKdwWzjoy74s3vGW5fxnoLXSNV7zjgIRnSW0ipRjM
         HtpXOJuKrNZAp+1IOFEm8GK5ne01k6KgKLGN69AxRqW56cRUOdM+zGbaZ321KEdvu20C
         QhbX4qDq2I+gjeCV8/P8IvlUFWJfGafqzHr+u/ZauF+F+0u5BTDZs6FdhMuRLTH2RRXy
         IzGmNAd5OLK/npqItfncg+b9R6Bbx5c/Bq+J3qXmFHzEVb5wY41BO4xKJnbhsdhYXOFO
         oRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787092293; x=1787697093;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EFl0Ov2rpc3xev/n5APT5V/efpbjI8Ad2gYSG/EUGz0=;
        b=Dk0z5+63LbP6Oq4XXsku/QJAHh7G7crSjvqVaEmv9y70KP6u7qb5l67GhA9hRRspzG
         OxP27FNRE8nrPOvkhciw+Jo1FfcXcxnHS7ctB+beHrSY9BhLtPjG3kQ6Ixdhj3D4a92P
         nuA87QgTIXfdqOlK+YeitbnbDHP5nHYR8o9rPn8o7bNGtUCnwA1p7cYCo5/qREUHNPu6
         D4UQeto6nCBR2Bn2oaK/ZZ8sgL8xbDKvkiYiwyjSi/RdfA3QxN3CnnvDXiEw+Tm7r9HQ
         1R94EM8ZPgrnj8kNOIe78hl2qyli7XEDQ1vm7C+SOhZzl/cJbCrm8ky2hGxrOlrdt3Hl
         sB2g==
X-Forwarded-Encrypted: i=1; AHgh+RpjFx9s3cqEpxsniTMRviKQTOGNUGW9/SSGgqY677u+L4VVrjR03/jQUp/PURkS82BCW7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQzi2NbsP0HaI6KDuYEv5GQt7ZliO0yLk7YwshztsTusAkgzZX
	McB5k/Q86UMVNqWwb7CpsX/nkcyRO5T62thVrnv6u24WerybcZITWpeO
X-Gm-Gg: AR+sD10HlGG7yIRkU2qtzLFW08+NbbDifyFWjrpMZc+glRr2gdT2LLcmR/h9Ms+PGOV
	SG3J6mQyhH+pDsQs67YEapuMssbhA1V+u7PDI4b0UVctn9FTdzsVZ+sN9LtfhBStO6mJTSvr6FC
	rvH8YxS0mxlWP3wgR5lm81GVTcU7dmR197P38feFA8/hEkfGCN82gPlwfZngfeLdvNckhzXfV4/
	ij9srfcsc6Gj9Rd7ZNGYD5dTYD8NLV8cnErdEENjtozcZY2b5XRPRQ3j6zPJudHC51oZDmy4S07
	Y5HQjtyLHR00MkYs/ABwfdRqVtqFhuuAHPF8fDbw+S5m0rwKL7bwndlEMHhvy4r3RR55HeHkCLG
	T7iuOShdFxkl2nuSDp/bKM0zE1WvFPtYPsT48aRYQVVDWcCoiVPeuuviXusbyZ3Z4MnkIK3hsrG
	jn5wdGvh9LiI7aAVcRNRKcOYASpSyP30Y2ye3mtrb5W65RlNdUM1h+JFMNIxa1xxScbaeA5wquX
	AOVOyCK
X-Received: by 2002:a17:90b:2685:b0:395:7fff:a08f with SMTP id 98e67ed59e1d1-3958049d47bmr482556a91.0.1787092293365;
        Tue, 18 Aug 2026 15:31:33 -0700 (PDT)
Received: from devvm16600.scu0.facebook.com ([2a03:2880:9ff:40::])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1416ae14162sm404407c88.9.2026.08.18.15.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 15:31:32 -0700 (PDT)
Date: Tue, 18 Aug 2026 15:31:29 -0700
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
Message-ID: <aoTdQeLZZuRirNHE@devvm16600.scu0.facebook.com>
References: <20260817214205.723267-1-ziyang.meme@gmail.com>
 <20260817214205.723267-2-ziyang.meme@gmail.com>
 <aoSUob1s8WBQ3buO@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <aoSUob1s8WBQ3buO@slm.duckdns.org>

Hi Tejun,

On Tue, Aug 18, 2026 at 07:21:37AM -1000, Tejun Heo wrote:
>Hello,
>
>On Mon, Aug 17, 2026 at 02:42:04PM -0700, Ziyang Men wrote:
>> +/**
>> + * bpf_blkcg_flush_stats - Flush a block cgroup's io statistics
>> + * @cgrp: cgroup to flush
>> + *
>> + * Propagate I/O statistics up the cgroup tree. Root statistics come from
>> + * block devices and include all cgroups' I/O.
>> + */
>> +__bpf_kfunc void bpf_blkcg_flush_stats(struct cgroup *cgrp)
>
>Either @css or @blkcg, probably the latter so that each operation doesn't
>have to verify subsys again. I'd make this and the cpu ppatches into a
>single series. Add blkcg cast there too.

Ok I will add the casts bpf_get_blkcg() and bpf_put_blkcg(), and remove the
check of css->ss in above functoins.

Next submission of this series will be together with the cpu one.

>
>Thanks.
>
>-- 
>tejun

Thanks for your review!

Best,
Ziyang
