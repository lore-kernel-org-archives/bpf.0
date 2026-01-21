Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com [209.85.218.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A60478E31
	for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 09:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988599; cv=none; b=bDXhTTKH/CUGvnaUNw4TPueNXizw5tIoWbdQrXvZHEFaEMtvbOMXYZFx6rodUxscxn/siWLaRCf8o/eWPqAd8dSX2YfbHKQaoxMKv527u+bhUcSxDLvkZXfs+9qk91YK/kaRqFWJVvu9gIy/uNSVgzSE5o5myC1KubU+DZrsn1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988599; c=relaxed/simple;
	bh=mH2DmH07sEpwrcUFlhBvHMXUkoUhNBdPHIXzor+swzc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GTIZQXU1woA+NMWr2fsAqRkU+UFv0lSiqk+JrquZOL289GLQMX/coTzlbs0BHGXltQI3ISNLJfzFAtEFs8MuEYd4d6zYKGGFwewsyh8SvyJLRitqrBZ0HYTswt2fSfSlyXvb9PkOeNJ+5wV2MWfIH46jKMfaG8R1wVz0B418hPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Jn0f4eUf; arc=none smtp.client-ip=209.85.218.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Jn0f4eUf"
Received: by mail-ej1-f65.google.com with SMTP id a640c23a62f3a-b8768225837so901791666b.2
        for <bpf@vger.kernel.org>; Wed, 21 Jan 2026 01:43:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768988595; x=1769593395; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mH2DmH07sEpwrcUFlhBvHMXUkoUhNBdPHIXzor+swzc=;
        b=Jn0f4eUfUmBNLPEV6HP65smxEVsU4IBzOkKsosX70uLJpdVhbGesuuUglaRQ6qIy6x
         oBYVupubj9y2kHD/3Bt8bHJxbrO/ROO7lDaoAABkHnrSEZ3m2yMh7oEwP9DVp4W7awDg
         YGy4jUe+n7ErMXHh8OPx9gcf0Ria2Un2n10Bby9Xfmz++/a+eeBz84/fgxpq8CCO46Zv
         WxsTfI9ay0P9X0V6/goUVn7CQXfvskQEZsDh6yFg7QcWcbAxmSeqYc6DkwXF/9HF0BMl
         15YNMgRGu7rOd6QXBiHErWftqtcJUyttMxIWJgnSpL5P8xTxOTOFaYKqRc1+dPHk9GLv
         CKJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768988595; x=1769593395;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mH2DmH07sEpwrcUFlhBvHMXUkoUhNBdPHIXzor+swzc=;
        b=iKiQAcZyEDDNxor2ydSIKphWT5UZlX5cktbLVghvuOZnspCIQqF2o4eL+SKT0AyT9G
         Vid90gQg1h0UAbiYZsdov9YkXLwpJ4hg7klsl6oCrLAGzHiFoq4mslOFT50rdU67GzNY
         d5MKh+aEoEXKkDT9bslduo24H4nEWI9oWaE/GVqqyO2F7HtWfbNxv5KaskkTrsnPYNNW
         uDiD2jz265BPttIc9v5/cBV5S8uM5tEGnzVizPQcPO605ckOWKPj0VaRuTlDn+/q2TeT
         s7RHKdrsKHONYN0eXeKlbfo4B4WEGEp+ACiYA1iS82RyQerLhPIGJUUV44qehj6cKdlH
         OtSg==
X-Forwarded-Encrypted: i=1; AJvYcCUU/64muJaE+h/qWNBo6q70KRAlUdM1rWkdGL5Uwpwd+oFDU9F9o3nEKh+OD93W0qzAb54=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8eUUBWfb9K628NoV2W3kOvbKjQtF7ZQ7d5RWyz//mWRNBM7rN
	reVW9WGFwWD0KkdVUWcIo6Ex/jBw4ojLgc1wRe96tKblDiLYID7G8zagpnUOlPjb6ps=
X-Gm-Gg: AZuq6aJg8DIbxvrbCh8yPOa/eGR5EhwY5y1ySDToCBHBlifVjSxxga67TxMLhoMpj98
	T8av/Xilx0nVg64WJc/cAMo84D7Z974oniVSgF49AncW9jzwpWVlXBQx7HsqKklHj7vzpj2Qhw+
	N9vyPwXsYQgBJ0jh43/j611FkUY4V0NjmmchxP4cAqMOpnVwXBoCTsmQM9AB3IUvIrOykroEKqQ
	EKZ82o6RIwgbyY+aKq069o0ihMjVrZtXIrA1SRaEKZ633q8EWvPyQ2FSqmf7FKTLhrsY5Sgn3ng
	B1DShDpJGkZzV8mhhYi7VEcil54zZwKIxJhbr1eL0dq0LofqUTN6jHCGXGdwFU17h4mEUIxfR5V
	eE3cJtRHDRJhx8iR3MMcv4MvxDbBrLHO3ZFR2zHPOfWXT38gCDmWmcvzTHT2C4uq47I4WR5C0os
	nawQ==
X-Received: by 2002:a17:907:930a:b0:b87:751:6f21 with SMTP id a640c23a62f3a-b879300b515mr1545567366b.36.1768988595143;
        Wed, 21 Jan 2026 01:43:15 -0800 (PST)
Received: from cloudflare.com ([2a09:bac5:5063:2dc::49:217])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8825616964sm25011466b.46.2026.01.21.01.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:43:14 -0800 (PST)
From: Jakub Sitnicki <jakub@cloudflare.com>
To: John Fastabend <john.fastabend@gmail.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,  bpf@vger.kernel.org,  "David S.
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Simon
 Horman <horms@kernel.org>,  Neal Cardwell <ncardwell@google.com>,
  Kuniyuki Iwashima <kuniyu@google.com>,  David Ahern <dsahern@kernel.org>,
  Alexei Starovoitov <ast@kernel.org>,  Daniel Borkmann
 <daniel@iogearbox.net>,  Andrii Nakryiko <andrii@kernel.org>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  Eduard Zingerman <eddyz87@gmail.com>,
  Song Liu <song@kernel.org>,  Yonghong Song <yonghong.song@linux.dev>,  KP
 Singh <kpsingh@kernel.org>,  Stanislav Fomichev <sdf@fomichev.me>,  Hao
 Luo <haoluo@google.com>,  Jiri Olsa <jolsa@kernel.org>,  Shuah Khan
 <shuah@kernel.org>,  Michal Luczaj <mhal@rbox.co>,  Cong Wang
 <cong.wang@bytedance.com>,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v7 1/3] bpf, sockmap: Fix incorrect copied_seq
 calculation
In-Reply-To: <20260120153807.gzwnhxxtcocycfmr@gmail.com> (John Fastabend's
	message of "Tue, 20 Jan 2026 07:38:16 -0800")
References: <20260113025121.197535-1-jiayuan.chen@linux.dev>
	<20260113025121.197535-2-jiayuan.chen@linux.dev>
	<875x8wuy4e.fsf@cloudflare.com>
	<20260120153807.gzwnhxxtcocycfmr@gmail.com>
Date: Wed, 21 Jan 2026 10:43:13 +0100
Message-ID: <87wm1bti6m.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jan 20, 2026 at 07:38 AM -08, John Fastabend wrote:
> We could probably push this without the 2/3 patch? If we are debating
> that patch still would be good to get this merged.

Definitely. But also see my email from today [1]. I think I figured a
way how we can make leave FIONREAD in a better shape that it is today -
with what Jiayuan proposed - and improve it in the future.

[1] https://msgid.link/871pjjux2u.fsf@cloudflare.com
