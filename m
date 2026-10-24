Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792880868;
	b=EXGE1y5lU8wOMhrKoF4dCVkX1x/Y6/ZDrsbLMNBh/RC+4uGzp89NAEkzas9PBTV2WeMu
	 WgCUH5WYWgk+aKzsG0vSuVOiyNIe8MUKvdAu1FQUXDfIOAla0tkhN7Kw5rJHbzB+aS6CZ
	 hY/8BDk8QJbh91c0EC4IlV+3/+rSBfEhTxrWsUvc+gXYAqfVD9J9WXlu2cNMT6v9sl4eB
	 lf6HM9MhRyFKYDXl6Ah0nNcDU8B5B+41d0YJWWbldRnb76X6ggJIqczqBjU18vnvYTlTk
	 73nEAUaL6205oV8phMpz92oOJQg2ddLjDUDUjhlLg17fxBOcF5R2D0zhPIEkhBtJAsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792880868;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vZIKDKKS2FdRJ5bhHVdKxJNVCBF7h98gzdI0qBLThok=;
	b=MxmQGMl3su8wBzx9s6Ifx5fWiRiMM2mAteIuJx5kmOo8TmmqEm+prGuknwCYGwEGJpOr
	 R3Ai01gEk36Qqj5aMbjvC7PcnyXW0gIckckYPt6SR7X6/dBHlEETnXi4Oq0VGCBPcYCKI
	 43acW+CnL+Rt0miAEgt89FFfvwf2EcpLXv1vvA3bYVvvC0qmA/xhf6ut5Rf7jrkFtn1qy
	 Dd+ZMdTD42gnQaR6hTpH/aUG8ersmnCMnAVAZRQ3WT6yRcKGhYS8zZuzJh9752ju725aJ
	 hLXNBVojk/MQTn6Tm1hmJkkE3N1Ze9fdkabNVNgUAu8eZ3qJrjltU2GoI2Nv5frjm6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSsZEjmF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F589606A32F
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fSsZEjmF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5FB11F031EC
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 22:27:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792880867;
	bh=vZIKDKKS2FdRJ5bhHVdKxJNVCBF7h98gzdI0qBLThok=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fSsZEjmFpPx7gWLUDKT75qvXylgPoUNbQkOLf+Oyt8mLrKmFtp/pm60U21UnyGh75
	 WzjMSWgFxIV+yWtziTLWDffjK7YhV1XUbIFFjO8XC1WL2sPRkwOCFcKSx8XAyHcgga
	 G3sYpF0HbFKOAHNF3nud48Ggy90jwVzbO7GrmvOrfY437cSqqSuDPith1EwwSbFFKp
	 oqLpiX1q/nbOBAaLJ8EOFpB8klsCYVZgl9CXGLTV7QKO2QaOHHfMGJk4oWdhz6yeYE
	 vgRC3E/qPSlyX21qeNFVV4o8z4dPn1EPpzpl5BB4pAjI0zHZbYUBKG5pd0c9l1UYZs
	 sSx2LzUZO4r9A==
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93f560af6aeso202186285a.0
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 15:27:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzDaStTL+xIR0N0vtdbJFhlMHuvgSsxL0s6ixqBUVlvHBfMPCBW4Ahgtu/6X0s10pdKA20=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+pXpSjBeyu61ExUQt5MX1FcbnmCyR9YjoSuHtWdLlaEVYHoeN
	eXqSefKEdGMVCLZLKWPgguhMylP8W/qES5AL80l7WQPAtnIWbJf0yyHa9blyr7B3GBJre92mneQ
	CoSMVmn3kfK1o94mM76Kz7M6uq1Ukygg=
X-Received: by 2002:a05:620a:6ccd:b0:93f:43a4:a47e with SMTP id
 af79cd13be357-940ef8db9ffmr456761185a.43.1792880867226; Sat, 24 Oct 2026
 15:27:47 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019034426.2354049-1-ridong.chen@linux.dev> <20261019035252.2357900-3-ridong.chen@linux.dev>
In-Reply-To: <20261019035252.2357900-3-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Sun, 25 Oct 2026 06:27:36 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4zuFsooOk+PEaSxCGJXm__uS0d_sGbGKsniB+vkdMqAGw@mail.gmail.com>
X-Gm-Features: AclHuK-TQu5lTS1fOR976skmXR1N0B8TphWnkqZazAAO_9122YtVC3DM7Ag6eek
Message-ID: <CAGsJ_4zuFsooOk+PEaSxCGJXm__uS0d_sGbGKsniB+vkdMqAGw@mail.gmail.com>
Subject: Re: [PATCH v4 3/9] mm/vmscan: move struct scan_control to a dedicated header
To: Ridong Chen <ridong.chen@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Michal Hocko <mhocko@kernel.org>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Dave Chinner <david@fromorbit.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <qi.zheng@linux.dev>, David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Kairui Song <kasong@tencent.com>, Axel Rasmussen <axelrasmussen@google.com>, 
	Yuanchu Xie <yuanchu@google.com>, Wei Xu <weixugc@google.com>, 
	Baoquan He <baoquan.he@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org, cgroups@vger.kernel.org, bpf@vger.kernel.org, 
	Ridong Chen <chenridong@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 11:53=E2=80=AFAM Ridong Chen <ridong.chen@linux.dev=
> wrote:
>
> From: Ridong Chen <chenridong@xiaomi.com>
>
> The definition of struct scan_control has lived inline at the top of
> mm/vmscan.c. Move it out to a new mm/vmscan.h so the reclaim-internal
> state can be referenced from other reclaim translation units without
> duplicating the definition.
>
> The header uses an ordinary include guard and pulls in only what the
> struct needs (nodemask_t, gfp_t and struct reclaim_state).
>
> mm/trace_vmscan.h includes the new header directly so that any
> translation unit pulling in the trace events (mm/vmscan.c, mm/shrinker.c)
> sees the full definition of struct scan_control regardless of include
> order.
>
> No functional change.
>
> Assisted-by: LLM
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---

Well, vmscan.c is way too long, so moving some common
code out of it seems like a good idea, beyond just serving
the needs of tracepoints. We may move more code out of it
in the future.

Best Regards
Barry
