Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792826550;
	b=Dl9Twz4ppReHrfx6skitzoypDlKyrKOigNqiDyAkTIOP4ZO8pkNmJnOZ0lwH9Gnw/evz
	 rQl5wPNZOu1kc7tYLD/1oaWwzyREScMjySLC78MHkWs8fpZjeovwv5Z72q6DV2xYObJ3b
	 x7QiZA3TbutkTdjZyQvgZg3LlOtVMsPbNtn9XOdUAytIIIShsLsF48ZSl1OiXzF11H3Bk
	 /aQG+773zR7cG0RNl9v9R+LW3km1DhOOekLSA2NqwqRBoxa86Kbp3JJXEzCf6rqUNN73J
	 5QVVpNP/J0LczoDRfROIGhw5tqUs8ChrA77C/IjE3rmfpjV7xdUB2FvwRKr36hgg4pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792826550;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=TkGvhbo8uCfcmT5BQSwIkA1ZNaWITnDyLwroqOawhFA=;
	b=hpBwrZanMobpQ6HNtsgz7geRo/iCfZJZhaQljHBRiNauBkeh+Un8BFpVUQL534WhKh+q
	 yyJvoBIYKJUC80zfItN1Gq3sPpLmIZyCWwxhpjCdRP5s39yJNU9usWg3fV+uHdOLkVQnD
	 /k0HLGoJUiG/M1zdMc0nvDGcITc/EnCExtPLdN8qzdaJeaNMF4IhLMO+b7+GPkdhL7Tsv
	 KJprezntn8NnCWV2FSTCYnA+8hCslrbMk8k5B3DiI87MRmF/n+O53mJe4a9ZL7v72nfqR
	 IIfneLxkdk8IdfGPTc/C8U2kIA/4z20BvTVElNsGffV/qy1qIL8BmL/CeVhQuo08L/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C66Wz9GK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D37D606A31A
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 07:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=C66Wz9GK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39A6E1F01825
	for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 07:22:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792826549;
	bh=TkGvhbo8uCfcmT5BQSwIkA1ZNaWITnDyLwroqOawhFA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=C66Wz9GKMH9eWP3KjPne9n1gdC4LfnIDpgTBj18latoVkXOi5f8/BiwnoQ+pw7Jym
	 9Ugyp50w53PhzBHJjiWK5gPvLwW3lcjB7mZ+FMvTtWxwkUpX/8WRGr2LCXCwRhvrrH
	 hki5q9lJcrQt0yNY8OSjhrztMPEqhUFkY0aW4JZ0oV9VAmRfBNU0v/o7HSNBxbql64
	 7qYTzvgL8jFqSuiSrnxfgM7CDFATdqkG6601ofKjJk+qESWsqs01zXqPh8ksRUEutG
	 gnm2pNyCoGLuIqwU7AkaV9uweRXZfdeHEZTBtMrOENMVC0zaaIBcJ/tEWOFGYmuVY4
	 7uJlMNZ6dw8EQ==
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-93f3c616c84so122392985a.1
        for <bpf@vger.kernel.org>; Sat, 24 Oct 2026 00:22:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzNMYs/cSoNcpWC1Rp26Hot2R8V9aBv7HUZmVn/7AX3WMqCPJcnVk0Yaz3frQPJYHrctSc=@vger.kernel.org
X-Gm-Message-State: AFq9FYICgjJB3YJMG6G0ZQ9SgyTgpktkiRsLdzmNJM1eBG2Itc8vRy1S
	/WRX49ofWdE3xQ5j2q+Kj+lOwJIggBTSILuNBeLgUC+ip3ixKDxQdYrCeN+L3A9TuM7jGblAVo+
	il+FgtdupqP5FQmSQK88bJHqOHTGJIZg=
X-Received: by 2002:a05:620a:4385:b0:93f:953:9a1d with SMTP id
 af79cd13be357-940ef9bc448mr169348385a.67.1792826548495; Sat, 24 Oct 2026
 00:22:28 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019034426.2354049-1-ridong.chen@linux.dev> <20261019035252.2357900-2-ridong.chen@linux.dev>
In-Reply-To: <20261019035252.2357900-2-ridong.chen@linux.dev>
From: Barry Song <baohua@kernel.org>
Date: Sat, 24 Oct 2026 15:22:17 +0800
X-Gmail-Original-Message-ID: <CAGsJ_4yQrp3kKJfkXPyLN35Zk_O_gBvnPnUmbwxCU2GVzrE-Zw@mail.gmail.com>
X-Gm-Features: AclHuK89s87eEZ3BnSPuNzTPl5Fwn-4GMSCXcuFKmZMlVEBMhQsRB9l0-sHv3zY
Message-ID: <CAGsJ_4yQrp3kKJfkXPyLN35Zk_O_gBvnPnUmbwxCU2GVzrE-Zw@mail.gmail.com>
Subject: Re: [PATCH v4 2/9] mm/vmscan: move vmscan tracepoints to a local header
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
> Move include/trace/events/vmscan.h to mm/trace_vmscan.h so that the
> tracepoints can be extended to reference vmscan-internal structures such
> as struct scan_control, which is not visible outside mm/.  This mirrors
> what several other subsystems already do with their trace headers (e.g.
> fs/fuse/fuse_trace.h, fs/gfs2/trace_gfs2.h, fs/lockd/trace.h).  As they
> do, set TRACE_INCLUDE_PATH to "." and add mm/ to the include path of
> vmscan.o, the only user that defines CREATE_TRACE_POINTS.
>
> No functional change.
>
> Assisted-by: LLM
> Signed-off-by: Ridong Chen <chenridong@xiaomi.com>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>
