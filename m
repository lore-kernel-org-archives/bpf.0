Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAADC3E49F3
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 19:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792177586; cv=none; b=MU9c+PWpBnlHOUoU12RcDPE2ABral29dpeNxmK1btJt+MS+qsReFNSfGpggM/OJoLK2oJa0qSgYqN8O9fx+hsTNLFBrXr/ErzObpusq6j6nmCO4Vh1ShvbZa293fQfGSwIPGsyOT0YAFnuW4Wt71bSu/CD58fmTT/x/AkWIbsl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792177586; c=relaxed/simple;
	bh=OpMS+6FzySrFV1lZQmnL5w19GqRngTRsLy37qcsUoFA=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=eTVQ9Dt4ImcGun0BzOfPt7m+A0vY8pUd8yeVRukOJAQjuSK3wQuSDmuVK77ErBM79JaARO09RPc5DK2XZl9Vua93X3TIme0sUajgu6ZrnUn7HFBmyOadcDITcNH0Huc0IMFOBjO/045khyctaFbU0eJ0uu5sdVcCQS7Xr2PpnTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TVzllX6t; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TVzllX6t"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-89f1318195fso166933b3a.1
        for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 12:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792177584; x=1792782384; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hSRgHunWgFpzvexlIiLUerDvkn0BvQ3M9sVaWvKaM2o=;
        b=TVzllX6t4/7axJ44qluE3Wqf24CWAeXMDP/8PMzgpG4edCwkSNK4FxNCXc5m1M39ju
         pYHOqkbq47OI72DdsWSNKjsLyWNa2p7dZfNcI3913KjYjUAP5PVQsAaHK7wjZWUiwJlP
         cMhy5csnEi6W8LKOtFQTk1v6TK4mgjIb0p/aGQZqWL6Gwo+D4eNH4OTLq8DWYV0Ek6rS
         fUgs0dCBjA63jMds4Ee7QgLeEbb99Xmqy4auhUEvZIbLpPb2t2OCGtlgW9fKQxb7G4lD
         pRgvj3KVqKUJN32sdge1YObB4QsRQxn6uWHW/rK+mQo+a7MRFRr9eT8Oe3YD2+2QJBh+
         478A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792177584; x=1792782384;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hSRgHunWgFpzvexlIiLUerDvkn0BvQ3M9sVaWvKaM2o=;
        b=A7jj1FuPaXOGWGX2Ubzup2rCT6iH0nvS3AbT+kJNhVqWjMUUKTmRNjvshDaxhbQ15c
         USwrzsSNqdpKRXq2+xekoReDUikpsiNy/7xyhh8iM0MLHEBvDEcJbcpA+MDLFVGhMra7
         8MdalJwm+bEzxFeGu0uVNEB9Pmj9nk5L1bDX8yVi6ywmhb22NyvufKYg7xbI51dyQcTl
         d6dxHaUTIqaqb5R6k2Ia3PmSdKnBt+h2z+G3yr9CTgiKv8zsTfcrz4u+0mDR4KL6iflG
         IcmZugJEgGmRK/XmANHxJcOaWgFHVj4uiVmzo0PjAuHPXR2ys7PcNLIMRT3ejA+9TtWy
         NeYQ==
X-Gm-Message-State: AFq9FYKRjJ44wNUsJ61YLypY28r5FmnA4JbJ7Ba3C9kDS5DOeApXMi2E
	Z0p1UPHXqpxbAv5Ms79xq5+sG4NL+06m6jKFIoYJHdnGRk/f0pDrhXj4
X-Gm-Gg: AYBFou2lDeezD4tdg7hRdRNtVXMP5u6GPJpFV3+NRw+ww0n+yhpcpe9+Gi2HnpA0eMZ
	6tPX5inj7esMAw9SL7LT85lvrnW8Zug4mH/2g6sOPjPIe/UMXg0zo5ofZbr1gEuXbWPdB4jSQsx
	UCiveWbaviSLG5nz3fFYsH+Tlhn2L0qa8Xzbx1aI8VOCn1N9DEltbE2BpVcyCX+FRxCE0djzoKB
	/TLp1CcV5luUdQBlUHO1KFMg7JLQ+BAuDPvTzkYtlLATK7xJhzYJdAu+hsodqlCCO89Smccqueg
	SZjFSlQhjOALGHTF3691zfWRyi+D8naU8Qw7M1pGrU2qZIUAmfUtFKem7dJLwH4M2J+Dq5SdTY3
	uxDQIlG9w3otzfH0YdfQClfD/CH4VwaVXYrrmxN8cHa/sKMBO1kek7KAELTZodhdfh0OYlIYHaC
	GLa4B2J6W3Gli+tAj6vCt7yHFiFri9nu2Z1iSKsTcW9+kVc43sd+QE3zu+d33LR0crJ8ZFs3Z5v
	UIPe/NCeYmFc9FLAFieTE41wlm65G+JdG6CFfdRElmSRSaKrJ3ysKFphYC4lfzr1XtSIhHyhERC
	0gI=
X-Received: by 2002:a05:6a00:2da3:b0:89e:43ee:6538 with SMTP id d2e1a72fcca58-8a04be62fc6mr443146b3a.36.1792177584089;
        Fri, 16 Oct 2026 12:06:24 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f5735dd55sm1563594b3a.26.2026.10.16.12.06.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 12:06:23 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 19:06:22 +0000
Message-Id: <DM6HXJLRTM4D.H1WFBHSKIH2W@gmail.com>
Cc: <bpf@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Dissociate struct_ops progs before
 the grace period of the map
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Qiliang Yuan" <odys.yuan@gmail.com>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Eduard Zingerman" <eddyz87@gmail.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Kumar Kartikeya Dwivedi" <memxor@gmail.com>,
 "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa" <jolsa@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Shuah Khan" <shuah@kernel.org>,
 "Amery Hung" <ameryhung@gmail.com>
In-Reply-To: <20261016-selftests-bpf-struct-ops-assoc-timer-v4-2-9ad31c21220c@gmail.com>
References: <20261016-selftests-bpf-struct-ops-assoc-timer-v4-0-9ad31c21220c@gmail.com> <20261016-selftests-bpf-struct-ops-assoc-timer-v4-2-9ad31c21220c@gmail.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 16, 2026 at 10:59 AM Qiliang Yuan <odys.yuan@gmail.com> wrote:

> -	map->free_after_mult_rcu_gp = st_ops_desc->st_ops->free_after_mult_rcu_gp;
> +	/*
> +	 * A prog dissociated in map_free_pre_rcu() may still run the struct_ops
> +	 * from a bpf_wq callback or a sleepable prog, under RCU tasks trace.
> +	 */
> +	map->free_after_mult_rcu_gp = true;
>  	map->free_after_rcu_gp = true;

In v3 thread you asked whether to leave it to each struct_ops.
No. The owner of struct_ops cannot know whether a non-sleepable prog
starts bpf_wq.

bpf_map_put() checks free_after_mult_rcu_gp first,
so free_after_rcu_gp = true is dead now. Drop it.
st_ops->free_after_mult_rcu_gp only picks the gp for cgroup prog array
after this patch. Update its comment in struct bpf_struct_ops.

pw-bot: cr
