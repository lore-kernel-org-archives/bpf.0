Received: from mail-wr2-f10.google.com (mail-wr2-f10.google.com [74.125.225.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5970C47254A
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 11:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788607426; cv=none; b=DmSso5/C9TsE0+8hPYYA8ymvYmgcUHwYgdtlStOoZsbMT57ko9mqnblgSuqRlPEBTkemwyoH00xI2SLtgxG3S2tRbhQyj/fRzA58JfKqqw1nl+uMQSE72iD70lc2GCGXUAgHcskeBFEBAhwzvxNP4/80Prj/ZkgMAHfpgOAFPPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788607426; c=relaxed/simple;
	bh=46gfGGvOHamt2U6ZnlfStx9ZhBdMqYA1cvWxqwtmAYw=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=sydNmBg5SzqwwFSt5cHbNJp/3Xazu72bUHyUoHlNl5cyNMKYUZKCGgiFsubFMHeMk7EJQknISg0Y+EP1NUbQHZMjhdz2p7xad59h06XL4iZBU4NWlez4Km2NuDtiJAyJGBY4n0DG3M1/tdREg3ZxhdgXVBn6GwuCglVYZVgXCK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+A/z3ZD; arc=none smtp.client-ip=74.125.225.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+A/z3ZD"
Received: by mail-wr2-f10.google.com with SMTP id ffacd0b85a97d-48436370540so840099f8f.0
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 04:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788607421; x=1789212221; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=OK8u0A1r5wARyyx+mQthY7pulPX5uc00KjP5Fs0Y5/U=;
        b=Q+A/z3ZDMSiXVgbRXO+zPozELZ6V3vjOQVVoRzZiHgeBqo4Om9xkt7FGx+oqDs2h2C
         hl0rmc2a8oze26WlFknREh1Jp308JbGotgds7kI0cFTSZakdxrDuY2KF9wu2+0KyIooF
         rGCBNfr8KG/9g+l9oeIiEfjhd1ZnNZf+ZR51fjd3zatku5Y4FJF0feRCEU/K/5eT+/Zh
         9K7+hypVDH/AT8mQplZ5715R3Xg4ULsECVT4aKl/Y1xNNwuP7t6QJd8nCrIJCTkDYwV8
         3h9zUnW9wNSvqNVkluVJ5poCvKR5l5uYy7Gr/YZJadR679rlgxN/XGoOPRTlgwNsvMwW
         y28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788607421; x=1789212221;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OK8u0A1r5wARyyx+mQthY7pulPX5uc00KjP5Fs0Y5/U=;
        b=ZA4lz/e/av+DBIdXp5oTzlZI6Ga/e/uKJ6o0oxGRvbeIs9JohRYFdENXovx5gfgbua
         PUWa/+hjE6TsM6842z6Rs8I0dXwnw1aKOR7Sz8a1jEp2mx3sF8yyEi/vvvxcNXLw/snL
         cse1jca8KksuyZyGv9Wfh/BFYJKqttJKmZ3SS6R0tRx+mA61bAXPVKRP6dRLL8K8wRbu
         2DPWCqbShXEzcsRTtfa+CB9bAdLzu0F6tQ55ggY3byZpsqZ18NTKACO+h6/Dn2QBldBY
         W7iPpy/e8z9+I5xkdzPnSfRY6TLJx6Qb2olESZVyQzhaz44mkuGWsHY318B9GcgCD9QK
         nPyQ==
X-Forwarded-Encrypted: i=1; AKwUvByDzm5S+yhHX8K//p2k5w6d0lpjdWNyTDrmMG6d9iDorv9c/tyCvCTl9VILeocwHOAWnr8=@vger.kernel.org
X-Gm-Message-State: AFuF++mJ++dCcgqh4XgAX7Vg/gssRlgr60gPo/GSMC7PVjpQkeFBmdEh
	lgH7i/s8io0Q041hvvrRRWkksLD3KadMzKb+eVJ3/j2aFMReogMhUdFp
X-Gm-Gg: AYBFou36d2NdQhPrEUIj0xl9ZarOZwVyfXgoCLTMv5yFEvyShIuV+h2GnKngz6K0Z+0
	Rvny3sneP1TUbG5ncdSNjZ4UkpJlg2mneqD1v80ccYTFyeBYPiq2SQp4Vz5ACo3cE75LL/XMVCw
	gVmPlPHCYTUH46qIedX5uaoWTtIj93G8yPnAkedxDQIN2xWkdFNo0WQtvivoGOzKOzCtOD/yS2A
	PTShqfUiwLG4iRZDx3DLRVPihzo5+vRDjc779iXLf4qMYhpPjExkAT7jx8Kd0sF1sSI5yg+fSJl
	Rcuab7kkwz9xGzpCcICsGtAJl5ZAbQEYB4E+dDenxKETzegi+EP8GkGGVRrG1mW8WVlmKrttvnf
	m6NBaeGWjmNJ/Y8kcERp74bnQUek5V8HF2m6Z7HCWaPtE69ng3fuAvSOzBWkMpY8a8HUy5RjvRu
	n6OTzUc2k0e671Lu4tn59//NsmvvvmLDXnvz4J+bbLHypDxeVYgf5D6+gto0YMPrURWO9PxIsgC
	tSLusCAy3NFnx9USA6QjBtpDossJuKIkC4vsIHvGeUWwx954zgC9IJGKPnqKqoDHZx5YTTmXehe
	asmjXTwsxpdHgJJFH2sqXYvg+cg=
X-Received: by 2002:a5d:5888:0:b0:485:8c16:5ef9 with SMTP id ffacd0b85a97d-4858c166172mr8839779f8f.51.1788607421304;
        Sat, 05 Sep 2026 04:23:41 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485958f1493sm1014293f8f.37.2026.09.05.04.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 04:23:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 13:23:39 +0200
Message-Id: <DL7CEX9EX781.23V26M3600JEI@gmail.com>
Cc: "Roman Gushchin" <roman.gushchin@linux.dev>, "JP Kobryn"
 <inwardvessel@gmail.com>, "Shakeel Butt" <shakeel.butt@linux.dev>, "Andrii
 Nakryiko" <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "Alexei Starovoitov"
 <ast@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Martin KaFai
 Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>, "Yonghong Song"
 <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>, "Emil
 Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>, "Barry
 Song" <baohua@kernel.org>, "Geliang Tang" <geliang@kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>, "Hui Zhu"
 <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v7 1/2] mm/bpf: Add bpf_proactive_reclaim kfunc
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Andrew Morton" <akpm@linux-foundation.org>, "Hui Zhu"
 <hui.zhu@linux.dev>
X-Mailer: aerc 0.21.0
References: <cover.1788516769.git.zhuhui@kylinos.cn>
 <7d8b77dc99ffe99a7bef874a257472fdaaf07e1c.1788516769.git.zhuhui@kylinos.cn>
 <20260904110308.4473cde499e91aab14dbd5fc@linux-foundation.org>
In-Reply-To: <20260904110308.4473cde499e91aab14dbd5fc@linux-foundation.org>

On Fri Sep 4, 2026 at 8:03 PM CEST, Andrew Morton wrote:
> On Fri,  4 Sep 2026 18:20:19 +0800 "Hui Zhu" <hui.zhu@linux.dev> wrote:
>
>> @@ -159,6 +160,74 @@ __bpf_kfunc void bpf_mem_cgroup_flush_stats(struct =
mem_cgroup *memcg)
>>  	mem_cgroup_flush_stats(memcg);
>>  }
>>
>> +/*
>> + * Reclaim must not recurse: try_to_free_mem_cgroup_pages() overwrites
>> + * current->reclaim_state, so a nested call would corrupt the outer
>> + * reclaim state. Reclaim windows are marked with PF_MEMALLOC;
>> + * reclaim_state is also checked because it is installed slightly
>> + * before PF_MEMALLOC.
>> + */
>> +static bool bpf_in_reclaim_context(void)
>> +{
>> +	return (current->flags & PF_MEMALLOC) || current->reclaim_state;
>> +}
>> +
>
> Would life improve if try_to_free_mem_cgroup_pages() didn't do that?
> If try_to_free_mem_cgroup_pages() (or some variant of it) were to
> permit nesting?
>
> 	rs =3D new_thing(current, &sc.reclaim_state);
> 	...
> 	set_task_reclaim_state(current, rs);
>

My understanding is that given the current restrictions on where this kfunc=
 can
be called, this is mostly a defensive and shouldn't be firing (?). Given th=
at,
we can probably revisit this when such reentrancy is necessary, even though=
 I
doubt it would be the case in the future. It will at most be invoked from a=
 wq
callback or a kthread, so should be fine.

> ?

