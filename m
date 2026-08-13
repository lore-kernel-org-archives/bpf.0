Received: from mail-wm2-f9.google.com (mail-wm2-f9.google.com [74.125.225.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB67314A8D
	for <bpf@vger.kernel.org>; Thu, 13 Aug 2026 01:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786582913; cv=none; b=cJEZkZ0upNtLUXodJhaNw+4iZZNKklOglX/VFSdyxVqnMKoQ080I8chd28GH8N6SHc3UFlE6Sypi8KhTkE4tbjrpMYUYiZejpfKFmfB1e8aSGJo8+FqqW1TCu1xd/7kL6kQ/gDXFblUwfeLUeP+xeC++HFMBoxIJOy0v4RhdeEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786582913; c=relaxed/simple;
	bh=muTbayIHnU/H6lCZiJDxMSpqcbT7t/+H78XUaWL31UQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=JcUwEHNSwYa9hTw0EhkFIGcx5CPLeZ3UtvuDrYbhGsK/YnsJwFOnWbL3yICo9Vn7PrLoyHdvggGaaMJTwz6+mllkx56qjOlQryDLhPPeoBTbpjCV9Oz30Wbj6xbwHHk7AQrpnHZiJWQUbXDf6tTobOSsZovwPGC0AJNjaO3TOC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p2y4rkco; arc=none smtp.client-ip=74.125.225.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p2y4rkco"
Received: by mail-wm2-f9.google.com with SMTP id 5b1f17b1804b1-49553b57612so311475e9.1
        for <bpf@vger.kernel.org>; Wed, 12 Aug 2026 18:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786582910; x=1787187710; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XTpt2/LZ7+UdpBiyBfBFxsa5plQ+r90fyz3STBPz1iM=;
        b=p2y4rkcoHHJVf1FsDp/BZGrniGQH49pjUbWbi8O/dJkCw2ce/JkjzMlRBoN4JMuLq8
         tsE0vMqWSh/IQ9Dc3e/beKYQkIAYkZpWo28irn0I69oxTFE+ESWfDEZk2l/uv9U53DBD
         8Pdfw47YCn8I70nzs5YM9qXUnIjqqqAOQM1F3SLdnV+0ddEx7u4A2S9KFBXVYPu1tmP6
         QNbhBI5xr4UF2DtjIPGWi7U6EdL2WOkznma9tAE4KJpy1DWD7ELv6UfQsz5WaLZMNfXg
         0fkxvuDx+UiNotSsDkZMN/p8MQx1NwBcNJXi7GVGPBvoVpaxQiDanJaTjBstNBuChfMw
         d1TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786582910; x=1787187710;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTpt2/LZ7+UdpBiyBfBFxsa5plQ+r90fyz3STBPz1iM=;
        b=Yu+VJgkss1p7HyioGf4f+J0dDyzWI1TFSazwlsx5s7ZHznOSPvuDEDRZuAP7nSss9K
         na8SlVc/IpMWQOOi0tQ+BZ9CoHDu7k4xZxtgl8TThWf5gZW9IqbUKiLObrQvxwxdyk+K
         t571pflR+RM5fMd133It3/yV2n8VXncOn1Yb+TZFz0wVvA433CKYxYI7JC8McT8ql4CO
         Vt8VBUabMd0p97LieJ2BO21l2fPyjNJtotxtSXsUiWnpkRnIbTLlYGpuwF/yk1o121bZ
         S3PIPJ+0ZA/bC6yqt0VihdGciS9QrmuR5zTgp7Ec+IubiqzKfYYFl29Lrp6nwrxm7Z7r
         EtUg==
X-Forwarded-Encrypted: i=1; AHgh+RqQ6w7AvshT44nBCZApl944bi8A1j33b4H8QtugOsUvYGhKCe2DWdUnCEVysQS0vLyVHkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFJrvSW8d6CoetVpZCerK2R0AS9AEChaYuUPAR4Cr95E8B4Bl3
	2/aB2R0FBfnHAFp4x25YzQ6NsYnGbg8bQqh/mV9U7JHdqRaaUcF0CPX4
X-Gm-Gg: AR+sD12oIAeOwsjD6NcBznzpVms68B+1jV8XiWozwYdv5bAW65/KuVq/EvKF/jIa1eO
	1hpjKP3nucXd88OIr9rQrD7H1j6tovNkY9SK9aKFIc1g5kctQf+9nogCMCNO7h4Njilb1b/lUIO
	NcOCo+ER1g9pBZmNpZaWxSfgXdFd/imb3aq1PLfCytovSfCXYl6q/tn9CV2TzcF9grXdyE+N0ic
	M9PUICmVcG7XRqx1LJYgqJCF8CC6CdYwSOylPSA6lLT/I5QSgjwOb6m3YsGLGfqJ/O9hjSi/pUL
	FFLxswzj8mufz2WG/u5KDbzbvA6PEPfh5JwXJbn1ml9SIXldaFK5SMcCgtVzNGbxPWrXJNMXQys
	27dqUI+qDcAuLXKCwXlSoRfSo1svvGojraoRVyH34u9ouuRLSSYszEhAPtGe9nRqV3ai2GqpHV4
	mnvWBuWeJ9DU+b0YYmZEvAtXjvGTbfRdn+odmwVvcTexbS0BxTYO+TOwP4NcDXA3lAjUIEq4W8t
	YTmqp0iyNzqT+KTXoxCLDJi99vlCg5yyy/iRwZxthig6lUcAu+AXXs3l4+Rp0jtkFyqb7NMRJpe
	S4NgYM2ebAOrm142HPqrZJGczwM=
X-Received: by 2002:a05:600c:4f54:b0:498:2b1f:e0c6 with SMTP id 5b1f17b1804b1-499821fb125mr14780215e9.18.1786582910122;
        Wed, 12 Aug 2026 18:01:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b0f4afsm29808285e9.5.2026.08.12.18.01.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2026 18:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Aug 2026 03:01:48 +0200
Message-Id: <DKNES9HIPWUR.1Z9BVZ9VDT420@gmail.com>
Cc: "Hui Zhu" <zhuhui@kylinos.cn>
Subject: Re: [PATCH bpf-next v5 0/2] bpf: Fix trampoline image UAF on multi
 detach failure
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Hui Zhu" <hui.zhu@linux.dev>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "John Fastabend"
 <john.fastabend@gmail.com>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>,
 "Song Liu" <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>,
 "Jiri Olsa" <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Ihor Solodrai" <ihor.solodrai@linux.dev>, "KP Singh" <kpsingh@kernel.org>,
 "Matt Bobrowski" <matt@bobrowski.net>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <cover.1786412280.git.zhuhui@kylinos.cn>
In-Reply-To: <cover.1786412280.git.zhuhui@kylinos.cn>

On Tue Aug 11, 2026 at 4:46 AM CEST, Hui Zhu wrote:
> From: Hui Zhu <zhuhui@kylinos.cn>
>
> This series fixes a UAF in bpf_trampoline_multi_attach_free() where
> old_image is freed while ftrace still calls into it, and makes
> bpf_trampoline_multi_detach() return void as suggested by Jiri Olsa.
>
> Patch 1 fixes the UAF.  Patch 2 is an independent cleanup that
> changes the return type to void and drops the WARN_ON_ONCE at the
> call site.
>
> Changelog:
> v5:
> According to the comments of bot+bpf-ci, split the single patch into
> two: the bug fix and the return-type cleanup.
> v4:
> According to the comments of bot+bpf-ci, add Fixes: and update comments
> of bpf_trampoline_multi_attach_free.
> v3:
> According to the comments of Jiri Olsa, drop patches 2/3 and the
> prog-side machinery.
> keep only the simplified image-side fix in
> bpf_trampoline_multi_attach_free() and make
> bpf_trampoline_multi_detach() return void.
> v2:
> Folded v1's two detach patches into patch 1.
> According to the comments of Jiri Olsa, Pin the prog (pinned_prog) on
> cur_image so it stays alive while ftrace may still call into it.
> Make bpf_trampoline_multi_detach() return void.
> Fix the same UAF in standard (non-multi) trampolines.
> According to the comments of sashiko, Fix the prog UAF in
> bpf_trampoline_multi_attach() rollback.
> Leak the trampoline in bpf_trampoline_put() when cur_image is left
> by a rollback.
>

Applied, thanks.

> Hui Zhu (2):
>   bpf: Fix UAF in bpf_trampoline_multi_attach_free on update failure
>   bpf: Make bpf_trampoline_multi_detach return void
>
>  include/linux/bpf.h      |  9 ++++-----
>  kernel/bpf/trampoline.c  | 16 +++++++++++++---
>  kernel/trace/bpf_trace.c |  2 +-
>  3 files changed, 18 insertions(+), 9 deletions(-)

