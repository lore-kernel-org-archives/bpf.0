Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243061;
	b=04tVSnrMsQhx7RdUU4ka9o8E+cPDLXexIORo6L2HN7GY+iYyo5OPgdbWLPfWm97ApBfM
	 n2Q2TFnPdBA8JnYRZXOivwrobwrHei2Z/dMjf/7Yadt9JT1H3QvW5BsKCKVuilClSpU9O
	 AnqmL3/SxG8fl6TukB7nwOSCndP7uPFA4z3asULLxj5M0JanWV5kKgdBJdwJFmAF+udwY
	 eyFKH9GlhChWpA7YhFys7iggvUKtdvTEPP2nQAkT5+gCXMZjwaqLpM4HUTbbiSjrPm5h5
	 5UGLe9Uxhwmcv+P8SHG+G4ArnIOZf93UD3G4NoKbRbb1RylGRtkvXBjpvMODlaUHXxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=IS1Mfm51OXnwhxZbYONc5jZW/Z2yaZ+F6WQ76H4U9Pc=;
	b=UuBHLSwylCUBo9kqJKiVaQOVjDYw5MUNL2qnEAk1y9ctEghQjsQaqGxRtEBheyVeedCL
	 E2EOFAhGmlW07flMV5Oyn5Xnob9taI6HbJxhq9nJo6riybdR8OLPoQx2ziCiiLZbZo/o/
	 PAMo4TbZea5d91RMJVP/IvIpkr0cL0TQer2zeuhkrkg2CC/7+tF3rCVnucymRpq9nEeTT
	 cgdjigk24DHE3/alDKCkLMhrifVTTTgCvd7kv6yqlux2+g6TbZA/6U7isWY0a2smn1NCi
	 SVtK1koooVaJCN1cftIjG5T7d/P8qH/ey2ugv0mK3wMrX4qc/QR6WQu8g8va/CAfZ7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NtHi+5FT;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A3D606EE83
	for <bpf@vger.kernel.org>; Mon,  9 Nov 2026 16:51:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51A3D606EE83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NtHi+5FT
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a4d7ae1ae9so10139635e9.1
        for <bpf@vger.kernel.org>; Mon, 09 Nov 2026 08:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243060; x=1794847860; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IS1Mfm51OXnwhxZbYONc5jZW/Z2yaZ+F6WQ76H4U9Pc=;
        b=NtHi+5FT8sSMrqPVn2bfj+WSGVIRPUS81smJI9xvYLMNB9lliq289J9mp1qechVBDq
         dzRWpDKsuXQ5CnyetVYNEgz6PUwqA2IdHPuDMYFmMwI/H5/0XSTgBjn1qFWDUlcoGfdj
         fdi58DtsyeQPYXIj6IgX+Zmz8H+uq3tMPIzfSeVk2gNrvp4Ib9bYIwdQz372siJV+9G6
         O+nKnScnTOyPpjYLvE4y3cofok13SKe/1qQ2sk4IgP8/4yiPWw1R4Vnj2TPvPamLJAbE
         OgqqSc/4voTWPsLIAnM2U72qVROZJ7wNARrWTCGoa5CldVFshyqlpVlJ+4KOdSBFkl35
         UYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243060; x=1794847860;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IS1Mfm51OXnwhxZbYONc5jZW/Z2yaZ+F6WQ76H4U9Pc=;
        b=Q8+eOwgsn1nSQQrVHcQsumKJC+wK6wM+/+7fCXmOkZ0KYgkhEdQBp8WjJ6vs70sB2L
         blwUEAY1l+N/xGnH0jnwy5Je0FO0Q3Cfb9sAq6GRueuDu8NmM6E/ykWj6yz46sGhLLQs
         a9mRvqjg5sWHVJwU8SJDr6S6IDCwnGrWaxmxYhL0OluNK12/FxK2bgldAecMuc3ExHgJ
         j30grHQSiwm/r+TPnopU7MdPRJED0wadjnJvm70i1P1yGg2sMZ46JQWjF6AfsEzQqWBq
         ENrJuRImW1pSeWKl+daxS66mpGJR1mHMnBx1MKTZr1enXeBRVO93xCa0GNAwIXX1wqFN
         czLQ==
X-Forwarded-Encrypted: i=1; AL+hErGyUBXSsIiNGNGj7pyTJ9p0hOpaxyqcGyzofJzmYqlAhki7CWDl1bbj6rxQtXhmQu+gBLM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/oG9ovbwCLTHujXAxZCD1h/y+TM9sGj/ePk9Tz91XZL/iEx74r
	eJebZr615aI00HVsY+odwBIVHV1vVHhX43br4eQHebvS8eZ/KOIfq4dR
X-Gm-Gg: AYBFou2hT7t0CUncglrRVWEsHYjbjZ0jOogEt99QFdBJGHVUHAKrz3WfDORArtzQ6sE
	zIJnqyQhyvV20tgQHr3NS/FPA60AJeFTy3jLtTXVuXsbk6m0cIgXdsImNaXyX8Itw/A1iaZdBiZ
	vOII8AdgtWo41ax2xDsrM4mnSmB+CRVEQtRtjOpc2OBPvMMP7RY4HNtSZso0STOWruTdEMIMwvY
	HUsFA1qxMdC/k1KZdwHCLOEc7cy4f8Q8A3LtCkVodgzTZuH8h5alvoPW9DgBpMbem1UdC7EpulJ
	sT9jiGJhL6znRIDq6wJc8UTJYhSNl1Ug1sUdZ/qHPiLBvIaIynwd+tnIdKgj91ScEwsRpdXk00J
	1rT042QsdcxkRTjzo4a+GZGKQgDaT9WUwmBFH/EqSSJcCz/eBplXdvF5IOo+v9iwe/NsSvCjkK9
	CbxbrlVMU8A2AI984iYRae/QXkl3VkaFpHE4wnDbms5JWUEODXS7KmxWScXOZPyNawmxu601du2
	D/GLvSzQlItDGcrq2o3+QBV4gOTrkgDv2hyy8GYixSRaeJfRgXffuK7RhkTL5IoBEh9ueG/qL3H
	qlfQvIMwIdubd7nixCqEqYGgn7AmDYzHJi2P
X-Received: by 2002:a05:600c:c16b:b0:4a2:167a:c946 with SMTP id 5b1f17b1804b1-4b963c6754fmr82890925e9.13.1794243059544;
        Mon, 09 Nov 2026 08:50:59 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49597b2066esm11035695f8f.52.2026.11.09.08.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:50:59 -0800 (PST)
Date: Mon, 9 Nov 2026 17:02:32 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Alan Maguire <almagui@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	KP Singh <kpsingh@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Sasha Levin <sashal@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 bpf-next 01/18] bpf: Add BTF ID sets for fmod_ret
 targets
Message-ID: <avH8qEQmhj7KhBOD@mail.gmail.com>
References: <20261106210314.1767267-1-a.s.protopopov@gmail.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106210314.1767267-1-a.s.protopopov@gmail.com>

On 26/11/06 09:02PM, Anton Protopopov wrote:
> Add BTF_SET8_FMODRET and the BTF_FMODRET_START() and BTF_FMODRET_END()
> macros to declare the functions BPF fmod_ret programs may attach to.
> They work like kfunc sets: each entry is a BTF_ID_FLAGS() line and
> KF_SLEEPABLE marks targets sleepable programs may attach to.
> 
> Teach resolve_btfids to find these sets and tag every listed function in
> BTF with a "bpf_fmodret" decl tag, plus "bpf_fmodret_sleepable" when
> KF_SLEEPABLE is set. The sleepable tag never comes without "bpf_fmodret"
> and readers of the tags may rely on that. Share the set walk with the
> kfunc collection. Any other flag is an error. Nothing in the code refers
> to the sets, so keep .BTF_ids in the linker script, or --gc-sections may
> discard them.

going to send v2 to address robots comments + rebase (latest merge broke CI for me)
