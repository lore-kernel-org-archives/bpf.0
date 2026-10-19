Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792429128;
	b=VYCEVzjylvjj7PF+XRG1LB4aY3ovOvbH+jN1ASES/MW6GL+YaTpaHxlkKVJGnVkPCSv5
	 igHDCc3g7kwCxxVE1FCW6DDfFHWX17ucH/q0+O+Z4T4hk58lQzon5UteDkaqreT0kjwXg
	 L6SWlTi4eLXoh5xG+vtUKSyBsJ0y2VCesnLqwlmmxxlYkfIkZP1/S+ncNqqzcdr/QJ60s
	 gJpH6NNZk1epBpMuugpqrRFZOAvfQ5alVZ+GjV+eLOYrH0az8WtK7QwvNSzZKBg/Aklpl
	 xlwcJXZbEMb/hRSKBA1UCFCd5RWpFO1hoTnoJJJsCoR3cw2ahnUT67Pq9aFGfK0SZKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792429128;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Mime-Version:Content-Transfer-Encoding:Content-Type:Date:Message-Id:
	 Subject:From:To:Cc:X-Mailer:References:In-Reply-To;
	bh=KkMdWlrPdSNNduqxUUOw/TuQSGBXGO9cH3ilJ+obI3E=;
	b=NzbV9B+aNqP0nSJwRtPcTGLxIQH/mH/18Kzl+/Vp9X0Nw0JtfToRLhsYzZPXiYek1nKO
	 gcHHohtvi3MGzehCDdtuYX+HSQC0KIx6ddNNRqHgPQ7ZvwDB70HbA6/veMj7vso3Hdx3U
	 DMfiN1qz3rCmcFdZWndEnS7cmwcOP+H5bvU8m9zEZDmOsKs5uODcss8EA5GorJjWbtomb
	 8TNO+N70/O17cQlZ8k0duU510CQa47kt5Jvj/in1TFdSLuzx6K+oiHqeoofhswscwf2Cp
	 fOQkRdaSyvelOi/T4TF+rrgla+dTN3r7cNsw5uaHusQCCJU68s2g598OUO7LAK+9xzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g4MaDUX2;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C331F606A31B
	for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 16:58:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C331F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=g4MaDUX2
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2e8fe8e343fso12014325ad.2
        for <bpf@vger.kernel.org>; Mon, 19 Oct 2026 09:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792429127; x=1793033927; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=KkMdWlrPdSNNduqxUUOw/TuQSGBXGO9cH3ilJ+obI3E=;
        b=g4MaDUX28LQh6dEGXiyEcLOoXECScCKHQHOS02TSMQ4RJBsO+uWD5pVHNxxFeeKNex
         HzWdXWT89sanXVLsc0E7jADPCeouWDQfAf/5b0Dsn+UQuUqdp7gZDMSVj+jJdM0C/5Tg
         xWQpDZdTdX9KwyEVxyVSfMaCpKglGkDw3LM2BiL3/8O7AIXVDl0CxLglNrpMcimbjBTq
         ItJyoOEFkmPQc5NkjyDXV27xdT87ngyP95XEYmjw7jZiR7yI795FbWx6l+Op6y6iee1H
         WTWFceyt0Wi8EOqk/mRTc5sTXBSE2PdlPtjJQz4sARhLqvNEduFZO01UJmpgcXcwZnYn
         XmvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792429127; x=1793033927;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KkMdWlrPdSNNduqxUUOw/TuQSGBXGO9cH3ilJ+obI3E=;
        b=LleXGxW/5WgAMXcf6hbmPj0Rfk0xmU5ic+9LwWldWcKTXsPh7gm+HuCWuExtJz+23G
         2UdSkO45D5k64MTic4gZxE1QYiUvCipFF5U0SmQ8c3bEIP/VQHWhJe7NobI6rnDNuB/R
         Bb0sBRQ1FO4LzvNV3DxJDVP8Vce5Hq5ZVy2oi6LfZEjMyvZ30ZQM//fysKDyqS13sIM4
         8CAGviWrR6+RFQnxCupt8MiJHSF6skyUZpfHvUe8zidlUokk/mtmB9sK/BLuTa4IIsuq
         2w/7vzzoUMxY/o1t1HIFbPEGn6j4NhqyX+Rhdl/UbYCUvoxqlb9X/+bF8pmMMzjkzcPB
         NnjQ==
X-Forwarded-Encrypted: i=1; AKwUvBwPa3pUpMX22XyH43vxT2rGljvDZ6dYTDLc5dkskiNxc76EO533BWT/IxkAK0LNZIUaGf4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKzFVFaaBeKKZB+ADkyVmMKRjMIMx5XEsk/K5MwqGOcq4CkSeEU
	/dXXNAlNTJ6WTVWxwafa2a/EigATP7zGv8gl008BaYriIPv0uQ08TMCy
X-Gm-Gg: AYBFou3eCIIdKBRi4JdTK9Fz+WL1cxKrP8mv39FhzLLojbEFm0yvdRTgZe5InnRIMOn
	2znOtkRkZl2EV68wzNlSK6QOjISTYGNDZp1DXEZkrjr2wkgQ1T6+GupkUgoL6FIOYJBgUNRjfCF
	fz8W42sC7wU49J/JsTclusZz4itswyo3zGRCAVZCgGP94y0OF2V/pr5gG1H62K9fjGHXhjc/g/2
	+BHslGVHI0mLcSjSrqiu3UcXpt7kwzbq+Nfm/w5wA4L+cIQ7xpuxTKT6jS2EwAkbModP0pis8m+
	RD29BJ2/K65Dtf17PcuaY1fQN652+wQ0tbkOurbcogRqUE8u3RHwTx89Q5Gp2Dubm3RVBKL2z4T
	hY44hPi3SFj003pcUVjnPwBCLPD4liC3fUsOoMWZnVVBfds1rzo+c8oSCmJPC8YiJ1qd9VMDVdt
	KdcwmoYeccTQHaUUjXnnMC8/DmELuUyzgBBPhVsqmBZ63R93mQ3ri+BNmI6IeTBD7UK/GKUUMQT
	SYpgeMACGOUlkOPicsc8WZtYfBXB9qtG8O1qh0+yq3ua/NyX/N4fQLHqezeB+o6Re3cbt69nj8/
	daTL599+yP4ZkH3TBedNpHvGDN7TAkcn/i0hXVs25eVa5QH6gWqCJPFjTYl+
X-Received: by 2002:a17:903:3503:b0:2dd:ad73:c989 with SMTP id d9443c01a7336-2e9a69e9d24mr66985745ad.33.1792429127112;
        Mon, 19 Oct 2026 09:58:47 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea1501f4a7sm3688635ad.43.2026.10.19.09.58.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 09:58:46 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 19 Oct 2026 16:58:45 +0000
Message-Id: <DM8Z3GGUEUFH.2WBEEIG5RKMRL@gmail.com>
Subject: Re: [PATCH bpf-next 0/5] bpf: Expose pinned arenas as sized bpffs
 files
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrii Nakryiko" <andrii.nakryiko@gmail.com>
Cc: "Andrea Righi" <arighi@nvidia.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Josh Don" <joshdon@google.com>, "Vineeth
 Pillai" <vineethrp@google.com>, "Balbir Singh" <balbirs@nvidia.com>,
 "Shameer Kolothum" <skolothumtho@nvidia.com>, "Himadri Chhaya-Shailesh"
 <himadrics@protonmail.com>, "NchangRoy" <royfru44@gmail.com>,
 <bpf@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-349-gb940a4174a3e-dirty
References: <20261010224902.1232178-1-arighi@nvidia.com>
 <DM6HVNSP3USV.AJSWS289Z3I9@gmail.com>
 <CAEf4BzZZRrD86ZswsB2r-swqNi7D1p52Vs=fQ9MXSgGATN31Jg@mail.gmail.com>
 <DM7JXB4PREVH.1BHG31CCNRXF1@gmail.com>
 <CAEf4BzaeXxoPqtcV6E1x8zh-Uv_C1cfNjzUYLKDWwod=k2ttLQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaeXxoPqtcV6E1x8zh-Uv_C1cfNjzUYLKDWwod=k2ttLQ@mail.gmail.com>

On Mon Oct 19, 2026 at 4:19 PM UTC, Andrii Nakryiko wrote:
>
> Yeah, there are just so many cases where we have some memory that is
> special in some way (e.g., huge page-backed memory, or some IOMMU,
> e.g., that doorbell stuff, which, if I understand correctly, is done
> though writes to specially set up memory ranges), and we can't shove
> all this into BPF_MAP_CREATE interface if we want to have BPF program
> accessing that memory. So having a generic way to just bolt ARRAY on
> top of already created memory seems like a useful primitive.

I see. In such light the use case makes sense to me.

