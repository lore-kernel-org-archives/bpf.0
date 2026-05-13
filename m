Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AFEB39D6F6
	for <bpf@vger.kernel.org>; Wed, 13 May 2026 22:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778711630; cv=none; b=oRFk8nclNHwKa+9WsMANz3FPxfdfEiRIx9zve/iW6NMOe2jSbMEImj//BgGBxIuiJE5Ctovxzl0UznbJh/+hefgf3I3s6EoWdSaYfjb1hf5o6friaQp/Qs09c+cjJEPXLtGW1mRr8wQL1+vC1TGToCIC8aIX6umgsS6GOY5s29E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778711630; c=relaxed/simple;
	bh=kgA0KAea695MAc8LHoG5EseKaGFUKSpbXPmYExsdEug=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=auDLabtiX0PcGUq15kf1GpZjQvdylOz12MmCkrcb28IQ3btnyiJJYmdWaD6tGTdkiCbylPjeGPzEYIgLq8WIXsFx5CDqQK2kAr7kErRdgVblrP+w99SSjgotyNbX/gKtYokyXTMnOsKutvKQAMq2csHvDVKs3KLJX5exMcSFtOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VnHmWezM; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VnHmWezM"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2f03d6cf77bso8369713eec.0
        for <bpf@vger.kernel.org>; Wed, 13 May 2026 15:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778711628; x=1779316428; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kgA0KAea695MAc8LHoG5EseKaGFUKSpbXPmYExsdEug=;
        b=VnHmWezMo0YlbCNcA++RfdlNu1SAfug0zNNW+AX2t6EAp7QeMQCIqBLPh9tYDkgJn/
         Ukjlom+POn5HpSnk683AJE96NFrKsWoEOtWmHsQzraB917NphnoaZ4WfEa1S6pQ/jCJY
         Xu7TMuRJ79epD8mXu+HYjS7UN97TZmYuJYHvbjxNeniFR3pf6GuSDGcuvgfqBypKmW3L
         EZlQWBd8gtqqFqvbjtD6dd8xsGCG2rMAgqmJAqxfNvdt3Z0ZRHupXQwRdBgQkVX81l0e
         Cw4KrJS3DEIv7lawH2dowOP0mBVBTS8xR+eRmiHNMMTmUWyY0cGm0t6hUwjm6iI6ur44
         LvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778711628; x=1779316428;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kgA0KAea695MAc8LHoG5EseKaGFUKSpbXPmYExsdEug=;
        b=XVASKJNn74Vl/KISLquz4OebddnkVrFieYFhIaXESF1ynKjju0vv/0mzLd/Xb2twLy
         fbfgOZEh4B3AdtFcDn/d8OFo/qQX5/TwLrLLRbg2t6yAl8jBVR89ifijzUzbuz4t5UV1
         nuBv+QCID98xUIZIXOLsBdP3083s+x0IqAg/TMbJbjyQtC/eA3bUYwWJE7cp/Wvr7Igm
         7FdTano2IMe14VoMSgWwmBbAPEL8wdUX4SN8Vt/xTwjtRyZVhQXLJuwAl607/F1aAmhz
         I/MohbYupf3D45RKaopD/TmgMHGycL7/+87Z9Mn1MsK+Wrl70oCC9LHkWRDS/Bqq0jL/
         Jk1Q==
X-Gm-Message-State: AOJu0YxrQWS3UTHdR5fo4oqJPlkcA6mpflz/E8vgc+oJFHjac9diO82Q
	xUhikX88fPZzg0LgtCB3umMACxzuXZN/V41M361ktg4zmSpaC5V4GYfH
X-Gm-Gg: Acq92OHzrK4TXpUlfQ5lk7vCiiRtMmpvJ3CzTWXMW/66QDFHAgAonnDXDVqNapdtEZR
	PVxRcY8bzIqBBDmf+d6bZ4mGa2NyCrZ9rwGL1DFaUXLm3ujjjSy4S+WvxHR8+38+uzL/5GOrVmV
	jPWdTNhO/q5OHA59ddgTeRIYOa7lX+Lp/5Xe2gI7jf+0kYOHMDwsMKaKeRbzb2eSLmioXD/EHDa
	m0DVpImqmDsW/sY0HXjJnZwcjr3yBDFaTXEV+hvyh/xA5tpudCgIANL6zFn2SPEPFQ5JSVD3aW5
	BhRRN6QixCalKAEgJBtLykoBsFEaklpPbo/qy7D3VoC1+/0QsdC3oDBdBbIDysyLypH5Gp0+rOR
	FXTImg11ORo0stzrZJJqaSrqWUHq0oN+uHf3tER97aQ7Lq7KOay9f5W6YsK4vpQynSqzrfgCjc1
	Q4O7sPWkUNkfwA7KuzB4r08E+SakwJbWf0Gqh4FQnTBtU2uPgS21s5eRp3CaXyC0gWgOV6DeCFy
	S7SyIw=
X-Received: by 2002:a05:7300:c87:b0:2d9:6f2f:9f6f with SMTP id 5a478bee46e88-30119f5955dmr2880656eec.24.1778711627516;
        Wed, 13 May 2026 15:33:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5152:641f:f5ef:6c7b? ([2620:10d:c090:500::2:8a9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30297bbc9a3sm718642eec.31.2026.05.13.15.33.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 15:33:47 -0700 (PDT)
Message-ID: <2ec40641b6d0313674557a682984d7ea9cdf24a4.camel@gmail.com>
Subject: Re: [PATCH RESEND bpf-next v10 4/8] bpf: refactor __bpf_list_add to
 take insertion point via **prev_ptr
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kaitao cheng <kaitao.cheng@linux.dev>, ast@kernel.org, corbet@lwn.net, 
	martin.lau@linux.dev, daniel@iogearbox.net, andrii@kernel.org,
 song@kernel.org, 	yonghong.song@linux.dev, john.fastabend@gmail.com,
 kpsingh@kernel.org, 	sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 shuah@kernel.org, 	chengkaitao@kylinos.cn, skhan@linuxfoundation.org,
 memxor@gmail.com
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, vmalik@redhat.com,
 linux-kselftest@vger.kernel.org
Date: Wed, 13 May 2026 15:33:44 -0700
In-Reply-To: <20260512055919.95716-5-kaitao.cheng@linux.dev>
References: <20260512055919.95716-1-kaitao.cheng@linux.dev>
	 <20260512055919.95716-5-kaitao.cheng@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2026-05-12 at 13:59 +0800, Kaitao cheng wrote:
> From: Kaitao Cheng <chengkaitao@kylinos.cn>
>=20
> Refactor __bpf_list_add to accept (node, head, struct list_head **prev_pt=
r,
> ..) instead of (node, head, bool tail, ..). Load prev from *prev_ptr afte=
r
> INIT_LIST_HEAD(h), so we never dereference an uninitialized h->prev when
> head was 0-initialized (e.g. push_back passes &h->prev).
>=20
> When prev is not the list head, validate that prev is in the list via
> its owner.
>=20
> Prepares for bpf_list_add(head, new, prev, ..) to insert after a given
> list node.
>=20
> Signed-off-by: Kaitao Cheng <chengkaitao@kylinos.cn>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

[...]
