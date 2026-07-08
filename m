Received: from mail-wm2-f1.google.com (mail-wm2-f1.google.com [74.125.225.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE011B87C9
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 01:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474774; cv=none; b=T1TQ+9Yd/NCNElXHBJXBs5TnfTr0sx9GdCh3YF152utDqpghJGlfKj0bdh/slEarghAG9ObJAssgwx3y2onX81oJDTMX5qU5tP+tzifusIY0IpLL9ZkbXir+bI/uQAz0Ir9VjVIAv3VSyOM2+k/AYc9+7dFLBGNxZcL4/8U6xWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474774; c=relaxed/simple;
	bh=2wmsozWPs+qGWig/vbpOkldVCPzPpwC3zx/e/LlpuYg=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=YFFZtS3shEinFpNoYQ/pGJjRFDqSbLLWh1m2L2pTtRnsSQob16H9HP5q1nUXcAEv4Etphv38k8L0XSYMVwDjKDSzwyGYin5U6KjxXmi1Fxxo9jBQ4yXL8K6J8APXUduEjHi/7qdoHfbuIbceT6BKRPq0MODl/Ps7l4jeAjNk9cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkBUeHXq; arc=none smtp.client-ip=74.125.225.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkBUeHXq"
Received: by mail-wm2-f1.google.com with SMTP id 5b1f17b1804b1-493b829982dso333975e9.0
        for <bpf@vger.kernel.org>; Tue, 07 Jul 2026 18:39:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783474771; x=1784079571; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=2wmsozWPs+qGWig/vbpOkldVCPzPpwC3zx/e/LlpuYg=;
        b=MkBUeHXqYRiEUiehq1JnKI4CDJth7uPKi+cX+t/A5M/gIF1Bii95kwSIfuJmDtWQai
         Tn3wl2Uwc/UjS3KTPEQMQ6LqJkt1hKfjf/KWQdhVBk6VEsMBq34b16rZ9D1Z0n78ZDWf
         UK8yMvdV4IQUQkluRNuKkXn9Z7+zAWi/SoXxc2WEXYNSuv75V2TqT4HWZ03gy9AGTROO
         nhrsXg2Np94hvCg7mppfFyDUNSOCObNxeuUfdzlspxyrfIT+sIrzfVIPwNiB2JzyspRr
         YqCpofMbuXFOWDBHz24MkvwI6SM1uagmSAZNyUDYeKsI6uTUXwbWM/MKhBGUhDr4F22g
         grAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783474772; x=1784079572;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2wmsozWPs+qGWig/vbpOkldVCPzPpwC3zx/e/LlpuYg=;
        b=YkNCVXoL5zbjC4DW8OkEKq5aAGNbkBhkHH4xNSZiSxQ8SewL/bm1d42msN54s4QC17
         TpVF96wqLjURCHei+Fsjry1wlrOvc5DrkAPkeYH0p+bVIasqHBc+xtKQPiJiKErVtjYH
         iJMuA7gj3+UWo8U1e0VuGA8VlOYP5/bD69b6zwsdG2CUI8EH+9EbTMV4Bbor3RizcDKn
         8wui6zYtPRHgcaKK+cTK7/sq8bcVJ8msksNympFTfXSst95MVJ7YnNiUmgXgy29fSas8
         kawsvLHWwR5pB3LGkn0LxbOQyY/s6AzvcB7A2s+svywvR8LDusgF06Fa61Uq/Uogu/h2
         NvwQ==
X-Forwarded-Encrypted: i=1; AHgh+RqO+8mBITJkBsqTyQ/BE+ycvYsnMil95/0TX6pyq0Trjp+aAw7EI6Tkk1t0j0BxqihlIFw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye81pKh8Q0wIr72aSBr1/dABAnprf1l4eKWWlyTLzb5mKA8g49
	5fSMCWIPwL74QoJcpk+NsRLL9B+xalRYpbzdJ/C5RapfGWNzq9WgI4bl
X-Gm-Gg: AfdE7clx6vy/huqSi+vwv4fV9tmh9INBgLFgsmYxlK6o4KCmQX4PGKmgeXJ2CoCA00p
	yayfTx85jIsMoRnBC1QVQ5X3WXUJAGC7Bmu/2h+gvdVc9rYIu+OqmliKUUMXfSn7jgJPFUCdnBE
	CVML5A6ie3pcf6Xq8b4h/8U8kVTYnj9TzkmCFcsck1GsMW0f2spajqnQZotVEnXgRFOhH7iO+Ew
	5DCJe45RvyJWSPS32F5UwMgKAA6u2hHDQvgOpnogkUuE0LMQRkH7ItDfnz6CA848e7ZSO24PSCH
	FL/qEcxUkLXZJlgqX7uR36OAU1tm4cxGRDqhrOqzk6ukVRm4rjYK9HMsNzajWqRX36hMWsxWUS8
	YEFgNfYsirqMcg2cJOxbVTIfhouFRvBirROoo9qyPE7VPwgntVzsRD6dliFeGyDnsV0Adh9BK6g
	cPWdKkB2bL24FFbsPn3KBWP4jK1I/aLWNV6pUIyUhC005nB5aNy4jL1/IeVVs4agfd0DrL7j2ua
	2NHMOmjUKpZtFlYmOzMTO0Tfd7Yeyoddzl9yNQcrvTkbYTg9W0uXLI=
X-Received: by 2002:a05:600c:8710:b0:493:aa0a:45b0 with SMTP id 5b1f17b1804b1-493e6891e1bmr2994535e9.23.1783474771378;
        Tue, 07 Jul 2026 18:39:31 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493e0f50418sm89233925e9.11.2026.07.07.18.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 18:39:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 08 Jul 2026 03:39:30 +0200
Message-Id: <DJST1IPR1FR0.E6DTKO42NK3G@gmail.com>
Cc: <daniel@iogearbox.net>, <martin.lau@linux.dev>, <kernel-team@fb.com>,
 <yonghong.song@linux.dev>, <memxor@gmail.com>, <andrii.nakryiko@gmail.com>,
 <martin.lau@kernel.org>, <clm@meta.com>, <ihor.solodrai@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: remove artificial limitations on
 pointer types eligable for spilling
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: <bot+bpf-ci@kernel.org>, <eddyz87@gmail.com>, <bpf@vger.kernel.org>,
 <ast@kernel.org>, <andrii@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260707-missing-spillable-types-v1-1-44a92121dc41@gmail.com>
 <3516affcc37014f57354a8cdee8cc55c28f11654502a4547b68012c6284a7f19@mail.kernel.org>
In-Reply-To: <3516affcc37014f57354a8cdee8cc55c28f11654502a4547b68012c6284a7f19@mail.kernel.org>

On Wed Jul 8, 2026 at 3:31 AM CEST, bot+bpf-ci wrote:
>> bpf: remove artificial limitations on pointer types eligable for spillin=
g
>
> This isn't a bug, but could "eligable" be "eligible" here?
>
>> There are no technical reasons for this limititation.
>
> And could "limititation" be "limitation"?
>

Fixed while applying.

>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/289097=
12027

