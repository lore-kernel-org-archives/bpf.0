Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E922E9729
	for <bpf@vger.kernel.org>; Mon,  8 Jun 2026 19:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780948688; cv=none; b=THcT/gzHn8CDvK7nbxucvZpTy9himWUeD+fM4UUlOq2vcu4gfmR3ufEV0EWyfoG/cKXjqMa/DIdAdlwsB1pmVmMl1ZH1150mays/8zLBNygFpSQKOCwC1wvgrK1IQslJJ56aUtFg7pa0iv8GHFgvugY3lIt2ArL3xvP4IMwXG1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780948688; c=relaxed/simple;
	bh=6r9vbyCh4ODQGh6cykBW9zlBP7LN1nCYV/Ax1BNV05U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=C7X8WNANHYJjcuHROTcNQK5EGfaxET+oWrjWRMZL4WiWcDzopOOJxhXQp6NTE+8YdKTzCidrNqt5mJPG6D06e+Mxm/npZ4fnA79VTDqR9e38mpIHvPAVrdtz5f1GZdtfZFYm1eRIxjTkLw9vKLJHygFiVbEXg4Lig2wvHI1bEO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QcxkyJyo; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QcxkyJyo"
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-4863a7dac63so2405535b6e.1
        for <bpf@vger.kernel.org>; Mon, 08 Jun 2026 12:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780948686; x=1781553486; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Tq3KQGC3tU2yK+mYapte3MwesmVqS3nwz+ecMDb+Ng=;
        b=QcxkyJyoEAospXZqyI0YINj+5t5IOOMW1a1/jLjG0a0L8KAqJpO5fvCf/fuOkXsfB+
         +j7GFEc+n7baijoj/fjJ5+6upOTYGmmRYKn7wINMWqWZKzF0DPb/ZciWEe19NSnfNXI7
         XMZcsOm6/isJWTyP32U730ACyqbOug6yD4noNADmiUdZhusaWQF6OdQslRnq2GKD6IwS
         pZ8UtoPT+7TdGFzCYDbvrhTxSQz14Nx6V/ZNXRqZGTmWD31PqEpN0VcLeo2PQ7wu1h9Z
         NlbvNDVxjBQJIu2H+9qA7fHS4W9bNoHco/7InZN35Ocq3G1M8k8T7+gqwm02+JW8w6/w
         FERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780948686; x=1781553486;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8Tq3KQGC3tU2yK+mYapte3MwesmVqS3nwz+ecMDb+Ng=;
        b=IYPffsrfh4Nxkm4SzOgZMX+B1+wfQP3zy2dkIXsDMfKOUc35CGLmR7gabJw/ep0TU5
         AXeqPmWqCMkynw325vhaAh/3yGhoySj+LUgc2xtgxbXY5xKFdPItfJyrYwUriAgMQu86
         99G5ILvoa9bfCAlIffveaKf80pFSOktj78FBMxy/Sngj1V7AOMC3p3CtGCSx+Kxd5pTW
         hosQbsQq7RvdaqV5zJ3SMwpvf72R4CXyX4moTlHc7iogXTf4ENQi2i1PjlpsL4uHcOvT
         lLtSL3j6GhABW020vMKsHrwaA3gxfkLjzNThOY6KwsNSn808mrcml97MRGshO2Rdk/Os
         79nA==
X-Forwarded-Encrypted: i=1; AFNElJ9fNt4FZnusOba588s8KuvPaq+0AFD49NUTvfrffiJ/cxdt4RdK3SP7LbNsZnVtBl6NoOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdTArSEdJTmrHevIfGx6DKOEgyucWzm+ZogQGgxeFQkOa9mm0j
	y86jzPW1fSnxr3Ql5hnyYbv9UP4i6msIAqECP6YM/oHV52+Ls6o8fQd8rceicw==
X-Gm-Gg: Acq92OHKGwDheedLDQqpn5eZuxWiAZJnNvpa8Iz18fxAwcqumBVd9ZuhsJDEaTB57vZ
	JC16CAxsVZFX8O+HRX7LsaB1KTHK6RWMCHmsSI4qMp7zLhSIaD1snKPt3XxZWJ78cpOvmYktzL+
	jBsHs2TYpmBHzfPv/TCoR4/9TLxnemhpxw4FC7c8rhODUlx4OOUOaP5Kj4VgO0TtZwYcKpjJInh
	Sq7W/Su8+aI0KWaVDuaeFHo8FRFxfV7YU/i5v+g62qTYcv3Kk50fCCtbHfN0fXeXoNcYajAC2LS
	Wno+fuJ3zjHAlwjoKPDU+h7ljTfTJsrrSdUkrhsQRuHuh8Ri8nSYxMg+0XUnC1oCgBzKs5xQ46d
	7q5SE1hCe+/zCg5Ap7kvoseiBo3MqzeYNQvDfxRblsXsOoMRBg14mv+f4hqP88dR3njEMn/PUJh
	zRkWBGMv/xV8/sO4lDlb0gRr2BJ1BB/XTab4cGenNKnItoTJ9MLjJgj4Fy2dTTanaWhaCftT+nw
	vqyRXQ2Z7wKdsYh5DGOjHo5gAM=
X-Received: by 2002:a05:6808:c227:b0:485:4443:dbed with SMTP id 5614622812f47-4868dbf7a46mr10511768b6e.8.1780948686022;
        Mon, 08 Jun 2026 12:58:06 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:9::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4865b7ad946sm14131286b6e.8.2026.06.08.12.58.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jun 2026 12:58:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 12:58:04 -0700
Message-Id: <DJ3XMAR8TVS5.R5MDDZH8N1IS@gmail.com>
Cc: <andrii@kernel.org>, <ast@kernel.org>, <bot+bpf-ci@kernel.org>,
 <bpf@vger.kernel.org>, <chenyuan@kylinos.cn>, <clm@meta.com>,
 <daniel@iogearbox.net>, <eddyz87@gmail.com>, <ihor.solodrai@linux.dev>,
 <jolsa@kernel.org>, <linux-kernel@vger.kernel.org>,
 <martin.lau@kernel.org>, <martin.lau@linux.dev>, <memxor@gmail.com>,
 <song@kernel.org>, <yonghong.song@linux.dev>
Subject: Re: [PATCH bpf v5 0/2] bpf: Fix kfunc implicit arg injection and
 add selftest
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <chenyuan_fl@163.com>
X-Mailer: aerc
References: <20260602093836.2632714-1-chenyuan_fl@163.com>
 <20260608142618.3064380-1-chenyuan_fl@163.com>
In-Reply-To: <20260608142618.3064380-1-chenyuan_fl@163.com>

On Mon Jun 8, 2026 at 7:26 AM PDT, chenyuan_fl wrote:
> From: Yuan Chen <chenyuan@kylinos.cn>
>
> v4: https://lore.kernel.org/bpf/20260602093836.2632714-1-chenyuan_fl@163.=
com/
>
> v1 made btf_types_are_same() cross-BTF aware by comparing kind, size
> and name.  Alan Maguire pointed out that this would be too permissive
> since two different structs can share the same name and size.
>
> v2 used a name-based classifier (get_kfunc_arg_inject_type).
>
> v3 splits the combined is_kfunc_arg_ignore || is_kfunc_arg_implicit
> check in check_kfunc_args(), so that an implicit argument reaching
> is_kfunc_arg_implicit() without any prior handler is rejected with
> -EFAULT instead of silently skipped (Eduard Zingerman).  This prevents
> the silent fallthrough that occurred when module BTF was inconsistent
> with vmlinux (e.g. pahole 1.30 breaking distilled base dedup).
>
> v4: fix a build error in the selftest.
>
> v5 changes:
> - Patch 1: extend the kfunc allow-list in check_kfunc_args() to cover
>   all kfuncs with implicit args handled in bpf_fixup_kfunc_call():
>   obj_new, percpu_obj_new, obj_drop, percpu_obj_drop,
>   refcount_acquire, list_push, rbtree_add (Eduard Zingerman).
> - Patch 2: simplify the selftest by verifying aux->name in
>   bpf_kfunc_implicit_arg() instead of adding a separate struct_ops
>   test program with inline assembly (Eduard Zingerman).  This is
>   a single-file change exercised by the existing kfunc_implicit_args
>   selftest.

Pls address feedback from Eduard and respin with [PATCH bpf-next v6] subjec=
t.

pw-bot: cr

