Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F0538AC7D
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 06:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973784; cv=none; b=HXuREI+OMkHR0zkNj/DBPUUhUuq/G5EoanRbK7jD/idFqLpWOT26VNdPToqO2OjtcElUV4pcfBz2eK396olh3+tSMVqGmUn5BWWNhosLL87nXbn3tIYTB4eca2Zer/UFVotKQaZ2kve4pGviG+AFAttfqqLaDaLHzN06pnr4dmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973784; c=relaxed/simple;
	bh=EkucCOPz8GZoCCEzERPCc1P/c5lfa7EDa7Hlgmx02AA=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=rEGU6DkS/l37YTMDyaWo4RiPB4dIY9JYZMkANp4yFWoSXoF2NT71N6EX0sZRpA89lCVnxx1QdUpHJieN7h/B8e8ITQo+iqBFglxg4GBDNlXkKGPFUzXo730HOdrjiHHAirKkvU1eFc466Qxk8BmeITRu0azBMQ4aJ91RMNG9oYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lH2XapNI; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lH2XapNI"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49b963f51f6so11795005e9.1
        for <bpf@vger.kernel.org>; Sun, 20 Sep 2026 23:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789973781; x=1790578581; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EkucCOPz8GZoCCEzERPCc1P/c5lfa7EDa7Hlgmx02AA=;
        b=lH2XapNIbMgfWFe7sTKpWeHxiCEsZbYaVKjtkxDyANXtYz93i0hmg12JbNd1qKYmB/
         o5HUPAboqdnzpOKr+u/173tdXHWqZuP7mgI7x+uj04z5f5YzSMM/zY+qZPufZ0JhuN4e
         8yR5kHNFystMvZeG/gctS/V4zy9aiOi9injSE7sxhp9GWs9+Ww7Za+1XyrDIiOlPfxuj
         vj52q6JrGmQ4b6FqeJj94rg/FCb0vP+++2ca9ismrSMC+4ti65fOIC3EA+PcbnCjyUO+
         dNhY/s87s2h65ZD8CX/ogIuhFt0pnemq1Wu6aieAKNcblHMqeamjICj1DFD/tEN4zWBC
         Bo5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789973781; x=1790578581;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EkucCOPz8GZoCCEzERPCc1P/c5lfa7EDa7Hlgmx02AA=;
        b=HHzlhJjRW/AIPc2KjFrI1Ubg9IOHCQPwohT0fhWxPP0NJBf1U+SFfFrP2USS2cdc6F
         EIGudcWaTevd36EdM3Q778bcHaCxQZvwLgShZJjtCQ9xyHcKwcuZn2YH8mvwMRxHg+tJ
         8yLDhWCRIv025Lu95S7+L8SRmU4UacZcxWcUBBRYxvQaDhpdPshRkfIT3LpAp09cvOHA
         Rf7GidUabJ4m/feELY9tJmLp+0mh4Zx1RXFMyN417r1hUrbLFcrs17E6xBdgfgy+wKdh
         t1Ujqz5ZrTB020eLN+V+FAw1wSv2xhY2JXxnj+N2xgdSvMJMGLJ8bQwBRKH+7MQ+f7is
         X7Bw==
X-Forwarded-Encrypted: i=1; AKwUvBzrXOAIHwMs5E6mW/8tfI14LuVX3lQtw/GSNQ0OBgWPb5TFL2jTA1eObDNmkD317d9RBmI=@vger.kernel.org
X-Gm-Message-State: AFuF++mytEuq1996vtxtEWl7HGFgj0StZiKHw9/Bujvj/j5W3DcmPNJk
	hgbDfw5/BAhu9SxYGkuSRoYBEuUq6/DinqG+XYq/H1g5cmj8VX/B8CpT
X-Gm-Gg: AYBFou37zrcy6yxmkll97AdjuxUL6BPuydvuVOFKvIusEo+GXFZi/NyWiJnyfmdHJlm
	6dvyTAj+JHdVgMl/SVafctow2e5krgTKkEH1F2UHPFrEcOl/zx701X/P2coZgW/dD9vUw9Tsgx4
	ZTlEYkuWhrksUGOcmzd5Pn3nyziupss+AzboDng2JOH7dVrivFa9YHVKY5tHTmWkMNBMUCmcBfg
	oX9HZGkKxN7lspKahRJLUuL4oyPtrGZ5cmukW43ZF3Dsq/0MMNmy024XXhpEB2fQRxqNuGujJ7F
	11G/V1rSsx1YmvxhaC6od5fzBuCV2mSathsdL4zNH+hsFN3gdD5JpwE4mCGokRVxiXw1xsR41zr
	yHrTtfhaxmY6sVooH9QFQ+PSdm/rmdSVQ/dJzLH8/fisA9FJOFqppkazP7hmPBufIU+nkFXHMgT
	OIPp32UAJMHp5piUvJo7bs/rT/rVkDEqK8k8msinOJcZxqmrT29e5WzUgN3jJ8QPEARPFWROB3w
	26S07EKnRCX14Lm3tlAtQwBl7Kdg15dTK0UAzHAmKRdoccGO7pDd467Hl1xpdpSPojoePdtN9bs
	KgQleOGdcGW8s69jpKQc5at2U4zb3u7sGQXzucwYg9vI/ah8
X-Received: by 2002:a05:600c:83cd:b0:49c:c0d4:53d9 with SMTP id 5b1f17b1804b1-49fc56f7a11mr113732135e9.14.1789973780380;
        Sun, 20 Sep 2026 23:56:20 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fcd068124sm201507435e9.3.2026.09.20.23.56.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Sep 2026 23:56:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 21 Sep 2026 08:56:18 +0200
Message-Id: <DLKSQY1PP3WS.2ARYV8F47YY55@gmail.com>
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Hui Zhu" <hui.zhu@linux.dev>, "Roman Gushchin"
 <roman.gushchin@linux.dev>, "JP Kobryn" <inwardvessel@gmail.com>, "Shakeel
 Butt" <shakeel.butt@linux.dev>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Ihor Solodrai" <ihor.solodrai@linux.dev>,
 "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song
 Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri
 Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah
 Khan" <shuah@kernel.org>, "David Hildenbrand" <david@kernel.org>, "Barry
 Song" <baohua@kernel.org>, "Geliang Tang" <geliang@kernel.org>,
 <linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-mm@kvack.org>, <linux-kselftest@vger.kernel.org>
Cc: "Hui Zhu" <zhuhui@kylinos.cn>, "JP Kobryn" <jp.kobryn@linux.dev>
Subject: Re: [PATCH v13] mm/bpf: Add bpf_proactive_reclaim kfunc
X-Mailer: aerc 0.21.0
References: <20260921030854.17858-1-hui.zhu@linux.dev>
In-Reply-To: <20260921030854.17858-1-hui.zhu@linux.dev>

On Mon Sep 21, 2026 at 5:08 AM CEST, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> BPF programs can observe memory pressure on a cgroup, e.g. refault
> stats via bpf_mem_cgroup_page_state(), but cannot act on it:
> triggering reclaim requires writing to memory.reclaim, which BPF
> cannot do.
>
> Add bpf_proactive_reclaim(), a sleepable kfunc performing one
> proactive reclaim pass on a memcg, like a write to memory.reclaim
> but without retrying until the target is reached, so that when and
> how hard to reclaim is BPF policy rather than hard-coded thresholds.
> The reclaim target of a single call is capped at MEMCG_CHARGE_BATCH,
> as high_work_func() does for memory.high; reclaiming more is left to
> the program, which can call the kfunc once per bpf_wq callback and
> stop at any point. It is limited to BPF_PROG_TYPE_SYSCALL, because
> other sleepable programs may run with filesystem locks held, on
> which the reclaim path could deadlock via filesystem shrinkers.
>
> Convert MIN_SWAPPINESS, MAX_SWAPPINESS and SWAPPINESS_ANON_ONLY from
> macros to an enum so that they are emitted into BTF and usable from
> BPF programs via vmlinux.h.
>
> Signed-off-by: Hui Zhu <zhuhui@kylinos.cn>
> Acked-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reviewed-by: JP Kobryn <jp.kobryn@linux.dev>
> Reviewed-by: Barry Song <baohua@kernel.org>
> ---

Applied.

> [...]
