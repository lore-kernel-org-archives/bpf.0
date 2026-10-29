Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793310577;
	b=c7NNwl/PBB/bD3QVEtpG/syshQDJToFG/4Ujc0F+eRqNlzV0k9Xbn8pjaRsLPw5j7vHW
	 sJ24o5G/dHc0dtVJ/pgUJbxcHL1yVc+TvJGiMrem2RsGG+sHXM4jr25E1F5dtS5ABWtOs
	 xHV/W/mHqOit4mDGJpEIKL1+aV9dbAQ8S/7wKKCD7tJCo+oR1TraSw4TCvxAJv2xhX9n1
	 5tApzCwPjzvHvvJmPIiZTWXgl1UWNcuY9uazIO0FA7xDAS+b8NmrDc8h2AWxXS0v+XEDm
	 fco4E49vz5G1vecJlkM6dTlNB5ZcTVAOQo2ysHL/cQGCuL8mLvzvRDBGw65l6sIs5XQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=4LvPUtuyu2GhVduPqIuGkGvQXkCV6OpKfaG8/4pXsnI=;
	b=fBzKdQRMztGDpf+WPibu58RDuUWED/8I4R87n46Bo49jWUiRKsoxEVwYczeus2Vpsho/
	 bB7HF2qSJj4ZuUiZLOqYsD+G7fN/1kZpnHch+aeFsPxKxu45VmAhPIKVqHJnD+LcdxY3q
	 1SDth6tLYLqC5XOz2UX1P5zXfdN5u9w7Bi0JcCNhTxcUxk89rWA8SfxM5abvErX2xonVZ
	 NKo6UYLlaR3MWpFbqx7ynWqXlZtmqDaZHOIAAvauIxFYOPR4hr+QXeIw9osS83Z5vNPFu
	 V5M0IEKn6Wwhsjoc9tu+nN2N/xoWLJcD9QOxrmcILanzJVHIQiJaIe31OGuMxI0Ltfg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AgRIndwS;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1157B606A31A
	for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 21:49:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1157B606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AgRIndwS
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e987a2ba0cso513605ad.3
        for <bpf@vger.kernel.org>; Thu, 29 Oct 2026 14:49:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793310576; cv=none;
        d=google.com; s=arc-20260327;
        b=P+gv2DSWMmkLAYPhjr4D1CToQfK7yZan1n2FrlS770ExeU/Kq3f/VqNCKBZgm0cx+u
         nzVAmxfd/HLLxmTBsqx3WmWeiMa6F7lXZNNUb+TikLSg7it1gzzKssKdi3zCjzcxiDGr
         QXabUstDHAu0CR4UoFtb9CsNFRV49hp2SRHLMjaZEXA9KwJuELuLp+m5SzpwTELCxFgz
         4l53RR4lfSU/pLsxK11U77D2wI6EVZW+1R0Ul2TOZWBvwPFFsRyfK0Pbx1SEuYm1y4Yw
         AlOf8MMrywKLN8PrI1l/NXvowZdobkcPKaCbWHI1r/wKdEzpDTUG3WZrt7S3/cqlERbY
         o7Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4LvPUtuyu2GhVduPqIuGkGvQXkCV6OpKfaG8/4pXsnI=;
        fh=EPrjUbnvvSHhBunjQPwZkbkMnJ91Q4Xv6lSbxfgNnFs=;
        b=jXu/M/S9l5TR0CHltWCCLu9cXp18d4TnF4pxeUPpvvryh4av0aVeCcISwj//+3na4o
         rFOu0O5h5tuqteoefOc2OAFlJ8hxQgXRHbirrvQoZl45L4+RVobLWS9Rki+Om1uVmkPx
         4/MCCwE/DQcQM/q8sR11V5s/B3pZNyin+vCydpcNOJhG/b9SlFnv0Fh2M0WEKY5hz1M8
         GfCng+BOtwqlasAV5AUkKg/Ho7EVL5x/XMgJ63cHDOcWxONnmkZP4l52GbOWwyMfuJsL
         x4Vbn76cilfuPuyMgUN+7f/EcL7i3thqHdTpkVwPOuo64dS4csmdR+dmc9k9xJYn8u/Z
         wwGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793310576; x=1793915376; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4LvPUtuyu2GhVduPqIuGkGvQXkCV6OpKfaG8/4pXsnI=;
        b=AgRIndwS3WV6SQRUcimM7vIjUaj2pshPod+JJth0B2JylpaqqNRboC6UCHDDPreh/C
         lk1oaTX9OpfRGtSrTpedrIp+9TaM4h+FWTo4m9e7WocwOyyitCIhCgXE9Ldtz7r2mPdE
         beWmZDAhAkuzooTC4A6vvXGq1xVTr6TJ8u3pYEIUXpVySrDXeQ2L3icz+rqNPtKDQPwV
         VoCJTBYz8EbKYc9Cm0V1+lff6tctPHd/5VU+gLJH90oRpIPl5xkzRl8eY8C8glb3r1hn
         /tEZUFtXBMp6K1nHdF6mdobY8CsnHFcZEnZ7xTwunkaXl+lavoZ2gjNID6efrjaEj7bI
         NdbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793310576; x=1793915376;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4LvPUtuyu2GhVduPqIuGkGvQXkCV6OpKfaG8/4pXsnI=;
        b=bBW2kuMKb1ykeL72hCaaiiZKYWEfLIqB5FpCkBDAaaKqa40Bd7HqMNEl7uuHe2Szfz
         0MxHTuNZ96Rl8/RdUnns8cju6r7ctjFQVfyupTvBHr56+PMO2MngFTc/UqQjhiycF0MH
         7L1naxiaYNqCg/L3CE7RiNNYodvTAjLBpShCDNeNeJOZMeTMwZ/tamq4WBEuAfMNoX9W
         HBwe0JvUbpn1jUQ78z43hs+N5jq7MHVqx8UjkT4yr9vQFoGV33t0SnTy3/e6AoObQ63e
         TV+I0uzWvxcxxlRCVQHLCO7ipH+KSc4KdIgvVIY4fDTYvgbzUbdagXgJfYWvhAE8XL//
         254Q==
X-Forwarded-Encrypted: i=1; AKwUvBzIYwVuoEUYIQQ5GUB3VpnZxV+kvPzTbjWZxKTAzJhsRgK/uhg4lsKN/RZRTV5bhwWv5tE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLdjEu+eb+rAc5rc5ORkAmyCNffC+vIg2uTp6xeeZWALKyuLiNC
	7NjJGLTFf8NnqSJeAWsvbn2sjEHcC3l8tD2ds9xFs+sxpHpfUcMJqvEfa2XXqnPYYc5/l2vA1Sm
	kfvdSXoc+TU9zOkLJVbHNFsvJ0SEK/I8=
X-Gm-Gg: AYBFou3MCezkt1B7QkCgElYOEfibvE/cMo227urrBKI/IMCMzZ4lpjpNFbi6Fyzs9Jg
	IxsktXXm1e7x8xMZ6W5c+SC2dtQR/iI2CC/baqtBeLBBOfJKhEjpCxsJ+e1pfyrZrVAtRBxpweo
	TVPlCZ8Cq9jEag7FHb/cNwTGcRwSSCMSmn6bZusOmto0cqowq6SM6WSymkTb45E0P4R1N8bfz0q
	ADoxmAIe8kax98WjnAVPI4YVCbNn5L8hGZ/3QmfjtTey3bWAVJ9MwtDisG3U1fxva+tDCNyZjS2
	wYYR7epBFfAGK1wTO1Gif3PjzXv3/5E4uIe2Ove/FPNCeKVtr2ugHheiAsD+TBlZCL1dVav1Ax3
	0eeB3bt3lVeLD15xrg/5OyGruLLilHReXs7nrKGc9UdboFdztbaLEfWrGznH5bLFcaD80jPW6g8
	PTekoe6zkKEbyN0RcZXeikFjKGa0Pdv5dBBA==
X-Received: by 2002:a17:90a:c2d0:b0:3ae:533e:7e3c with SMTP id
 98e67ed59e1d1-3ae8981bf57mr183023a91.35.1793310576388; Thu, 29 Oct 2026
 14:49:36 -0700 (PDT)
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029212551.56964-1-jolsa@kernel.org> <20261029212551.56964-2-jolsa@kernel.org>
In-Reply-To: <20261029212551.56964-2-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 29 Oct 2026 14:49:22 -0700
X-Gm-Features: AclHuK_5bx_yu4DhThJ8Z6lvpTGvlgJql7An9DPk8XTshDlWp4Rvot3r6HrMVDA
Message-ID: <CAEf4BzbUQpQcdpCJ0o2g0YkaR_Lwe9EOXdj8Fth0UUpAs-LR6w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/8] bpf: Add __srcptr kfunc argument suffix
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	linux-mm@kvack.org, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Lorenzo Stoakes <ljs@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Federico Di Pierro <nierro92@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 29, 2026 at 2:26=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Generic sized pointer arguments are treated as writable memory. This
> prevents kfuncs that only read from a source buffer from accepting
> read-only BPF memory, such as const data.
>
> Adding __srcptr to mark pointers the kfunc only reads.

why can't we infer read-only from constness of a pointer? what's the
advantage of __srcptr (which, honestly, says absolutely nothing,
"__readonly" or "__ro" would probably make more sense if we have to go
with suffix)

>
> The get_kfunc_arg_type change sets the initial memory access mode
> and the resolve_func_arg_type preserves the suffix=E2=80=99s access mode
> when it converts a BTF pointer classification into a memory argument.
>
> Assisted-by: Codex:GPT-6
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  Documentation/bpf/kfuncs.rst | 24 ++++++++++++++++++++++++
>  kernel/bpf/verifier.c        | 20 +++++++++++++++++---
>  2 files changed, 41 insertions(+), 3 deletions(-)
>

[...]
