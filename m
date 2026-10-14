Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F5B4A090C
	for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792014260; cv=none; b=P1osnBIt626aulg5Bvwa6Og4DtWWLR+hThhKO/v6Xq468gB+MxzXttWUqzH0R6p06S1Y7qMIQtIX3Aaj9eLM7Qw8JddDdwPgAR2GTYbIVXLnW1wsCLIpdbaGhVg73FmEwL42dRxNQd21hQk5RvtVLVs4CxfJXxtuOTrQeWOgq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792014260; c=relaxed/simple;
	bh=ZlsnNdUfOVho9jmT6Hnl5zvOQLLi6uv8gJyum34DEYE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdhRRoxEfyeWhYi1cMgxUnoD/sZItqeehu3XorlVCUNj+XZNaCFiehQW5Lo+p/WPt9b1XPec0EZbyhffrXZtt3QgSkIEW1FRbKhNWwIZ6doK657DcYgzKRZORDlIxRMjXnl4P1fcXqdmDw5HUYhlIH3DTFj+L3BDjUWR2pv6j4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rCs/NXI8; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCs/NXI8"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so37629425e9.0
        for <bpf@vger.kernel.org>; Wed, 14 Oct 2026 14:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792014256; x=1792619056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cff983+JIMMydZYhp9A54f/c6x1XpQzAnWFKZyZ7iSQ=;
        b=rCs/NXI8euK/ZK7HX1EnkZvgdG9BVnllooU4kf3BE/44kmSh7X9dP7mH0+hJuaH/3X
         SHHP6fXkK62Ro3qBm/p0OdhOm06qxaGj1MFgHrm6bP+BKRvcAioDWI2u0KsnGkFGVMei
         lTcFILxkLxLxkvnKwyjPTV5/TgRbDhhMgVU5dOaEP3J32gdVDZ2jf4QAMWXsdkq4AcsW
         w7wR7DQovTlvLKaw/xsWiaSJUdPsIzalOMnJQHZ6ul8rGevMgKGjTQ6mUdG5fc1w6Tcx
         8W8nWg/2eQpgS6vbh4hApd44mpP1yfw+m+Fa1j7sDsUj+qudZe19B/pf76R1dgMiovB8
         2u7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792014256; x=1792619056;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cff983+JIMMydZYhp9A54f/c6x1XpQzAnWFKZyZ7iSQ=;
        b=DnmJVlS+vin1MhW4nE8qdBiA2+YeNU2mxM9FiD03eYA5dxeEY/l36pstZ+TVxp4qQl
         mt7EI2yudAnJK3fMUovlSpBpn7NiQZdu22VrHaOTp65YnQtjP9cYRp4pNUNJC8hM2WsW
         depcr/OqXu2wqRkyJlZHu6k/CIIUZ7LZEa9AN76nBbsm03a/EXooDkHY+Z/6+D3gdZmU
         hTK8aHAT8Dgx3ZN5Sj6mh/NU6tnyf7mNIBEpgND821Xgi8AcLa3v5xZJQH38h7jnI5kC
         Z8qX6qTpBYZySR5gRgW+OxBr8BnpyoEnIj/oC9/WGFgLu2HuubBY1UXoLSnpU+3xcNwU
         M1FQ==
X-Gm-Message-State: AFq9FYI/yFPnoQdV70waXD1NPDFKFyTZs6tzVqbp9J/KSHS55IxsHN6r
	qY8HE0jfI30oX6vugtfW9JLuz8pcKHUB8YKnr1n1y3lmYkkN4quQQfWA
X-Gm-Gg: AYBFou0NDR0BttvfKySlhrZlNXrD2ODLIK9AE3ahfz8Jfv1n10DBnZWyL0rW+LV1VRu
	OfmJ7W7wwkZn07b+25USNVkm2qTllOrbNcPF4D90lbLVZbbIjRIToC6Uc0MqXuw+91far+3Gblf
	lrrplpeCtSOdPFis21F+FL3hkT547cVaF+Zjtli8b7eDN2GqQkOjRpoRhryMsGBTbFS5nF1/Sgl
	QawSI8NdOxDxXqDvOXKwyx4pp2B7Lt8QAsX/2c8horwj12SpC05f3KuF0tRiyUagKdvf7ZovZYe
	x1ocy7sCcrVMZQsVJeYcGSzWtGC0NmKVFytPfA/8VR/1uTV+TEuGx/OKCwy2rbaglKv4bumTZs+
	0p7dmDf04E3z4mNWWZTTr2hkdmuzusrATA8zUGBH6NJqql72ervqjJDtLVdVTzCpYMt48Xz+n30
	PAoSC9Zvr6ceYHEsMwt5ZuG8nBIHOm5xTwFmEgf49igaxO+FhAHcseSa9ZsA==
X-Received: by 2002:a05:600c:c176:b0:4a0:c2a:485e with SMTP id 5b1f17b1804b1-4a18e4dce0cmr348735225e9.33.1792014255987;
        Wed, 14 Oct 2026 14:44:15 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bdbace19sm18835365e9.14.2026.10.14.14.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 14:44:15 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 14 Oct 2026 23:44:13 +0200
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Quentin Monnet <qmo@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Mykyta Yatsenko <yatsenko@meta.com>,
	Avinash Duduskar <avinash.duduskar@gmail.com>,
	Anton Protopopov <a.s.protopopov@gmail.com>,
	Amery Hung <ameryhung@gmail.com>, Jordan Rife <jordan@jrife.io>,
	Rong Tao <rongtao@cestc.cn>, Eyal Birger <eyal.birger@gmail.com>,
	Pu Lehui <pulehui@huawei.com>, Jingguo Tan <tanjingguo@huawei.com>,
	Lin Ma <malin89@huawei.com>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v2 18/21] selftests/bpf: Add tracing_multi bpf
 prog rollback test
Message-ID: <as_3rZ5ToLjzQidZ@krava>
References: <20261012154024.29423-1-leon.hwang@linux.dev>
 <20261012154024.29423-19-leon.hwang@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261012154024.29423-19-leon.hwang@linux.dev>

On Mon, Oct 12, 2026 at 11:40:20PM +0800, Leon Hwang wrote:
> When rollbacking, the prepared trampolines should be reverted.
> 
> In this test, the first bpf prog will be attached with the trampoline, and
> the second bpf prog won't be attached because the bpf prog has been
> attached by a fentry.multi prog, that causes the rollback procedure.

there's rollback in bpf_trampoline_multi_prog_attach and in
bpf_trampoline_multi_prog_prepare, would be great to cover
both with tests

jirka
