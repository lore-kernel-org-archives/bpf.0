Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBA2233938
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 23:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785194158; cv=none; b=BtZWO6f+KaR/YtjjHY/QJnhJJnJWWwOx030jMAyjXp4YLuG/e4hxbhwDpRDhpKqD1Ffi5wW55UUYy7NSb5d5WMgkWjh2Jl/afuw+Gv303JPiF1rrMr5ovVxjJJ6rirs63Key6qLXrwNUO3uobJg6w/i1Q64dfYFPBTnV94W2Dg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785194158; c=relaxed/simple;
	bh=yXS2i6fzFtIZ3zMGZCfeBCt1Bj2fQIeC5XZV6Vt3BR0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=U8p3ItyKz5798+n8TXLfWEtAnPzQ3b/mUrNbdpVWGk4ixtUff7JYb9fi7f3CEh1VvuhhzX6lZ45nA3O76SV47TJVFsTRMrx9kI5bofnhaHlvVGQMFTgu1K2ijnNItzKhssZx0aHlzSZvJ/imAD2oJTBAMndWhsJ0dFOwbS1WdU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vy2zfWM9; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vy2zfWM9"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cab973140bso43671935ad.3
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 16:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785194156; x=1785798956; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=yXS2i6fzFtIZ3zMGZCfeBCt1Bj2fQIeC5XZV6Vt3BR0=;
        b=Vy2zfWM9dfe2TfYgecwv2k6XZMmJZk5iSEscpke5elXy/HapqsLXcE/yfm6E/fxOx5
         bfCq8mnMl84sIyC+Ooi73eG8En7HiAqAXHn7W4CUTf/N11WzAqVk8cLLOj9Tx5hZaeFY
         BPg/UIbGFIvMvfYvHRlUKfUuOe+QUArdGrYeHM9XeeMjoi/VmWtLNN1+WRd7w8SOh9fh
         gTt2zgI/RpJ4akeUWSXmD9syOOJ3z4L+dWcEjnxv+Hz6PabsssXngVqQvLLGzYH6i/Ha
         C0Sx8Tv6xwCUik1KHpEZZjJfvJAbtf596qOAhijgTr2cWjRu0E39Ys1rBVaSYdEiQjW/
         1JkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785194156; x=1785798956;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yXS2i6fzFtIZ3zMGZCfeBCt1Bj2fQIeC5XZV6Vt3BR0=;
        b=OHYRceBKIdRAkifINndd6KiirFuV4KrYBG+ljd9NGtY86qqyIcgkjGpnuWWrrXCt05
         TQD0vcUeqrazu2EeI0h636lahzy3uGr0SHPAQEaodHlO3ZdR4YIyuHIbkvy48yLGksXd
         gHhqp3NwOayVUdRcggZc48JpLQUV0hE/jjLmTxDzO6uUKMyaZudc4ICj4IXmlOOVCPL/
         vAxTKR1uKM1FKoXWWVc18UVX3wN+SqgqiC7wKz1k6rNQiYbUAk73+BhJL6/u0I03Vot9
         rut91MqR0mymWSJcZN+ub6xIq1RiPZXCIYozIqE9IA62K+IwPDYKVr/NCqRKs+cpz5/X
         RUUg==
X-Forwarded-Encrypted: i=1; AHgh+RoMd/+EjDCkO8f3boE2m+JPaNRoxYY2WaDekiQZpIx2eP+DPfgCQxC9KkxYGXkcQ522KKo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxgs43k9a9qivC9pACOOmgi70jWsJrYPTh46n6M/02gq+GZF+YG
	dkoib7etuSv6Etmb9DaY4mbLuXBUzGgAdITvL4Fy3i48jO6QHnsC1a2l
X-Gm-Gg: AR+sD11l/AB2+aZKx58F2nwtB43haOwmj1/qiPkyt/zvXI6sCQvNqPDAFKnncvFyF/b
	F/2SZ5YWZ5zyDY/0Zpp9ONU4ao/z5phO884LWEhkVNcjkGRq7cq6OqjAIO+e1ZRcqEamGMNzGLi
	ujv8weJ8/U2GMOaaMXHEdNJNOCC6O2p6dxm5xET3ddn1DnYNE0q93lH0yW0YVLjLTBJB1SLeQ3K
	TBWKemYJqmFh363EhoK9GGQwtP3DKuvGx5aybx2rSuihBB93Rg/0uYSsNX/av1AwClhgR+nCiYd
	+XshdfMot3gjcivZv2H1efMLPYQJ0WU+AZ4xqfmxeQAtNRfc55vZ77REkW04Y7tv8xEKeK+tyTk
	lCNo/U8Xm2SIscFcmEff0msWOB+B4DjiZ4wnhOje7ooqD5kKGD8MpVh02ul5jFw5PCC9FeHrpOK
	i7ovaYbcPlZbPb9DB6OBZh6z3Ozo8V5w5NzxmOQOSNVP5WqFu9PyU=
X-Received: by 2002:a17:902:d4cc:b0:2c9:ff29:3f91 with SMTP id d9443c01a7336-2d01531cf81mr748325ad.6.1785194156343;
        Mon, 27 Jul 2026 16:15:56 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde5e2881sm41602335ad.25.2026.07.27.16.15.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 16:15:55 -0700 (PDT)
Message-ID: <fdc7fbcb25cf1f403e97d583ff1dbc80caf92d9b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 12/18] bpf: Handle NULL kfunc pointer args
 without a KF_ARG_PTR_TO_NULL type
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Mon, 27 Jul 2026 16:15:52 -0700
In-Reply-To: <20260724190813.1458271-13-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-13-ameryhung@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-07-24 at 12:08 -0700, Amery Hung wrote:
> get_kfunc_ptr_arg_type() returned KF_ARG_PTR_TO_NULL when a nullable
> pointer argument was passed a NULL register. This folded a register-state
> decision (bpf_register_is_null()) into what is otherwise BTF-based
> argument classification, and it short-circuited before the BTF_ID/MEM
> resolution.
>=20
> Drop KF_ARG_PTR_TO_NULL and handle the NULL case in check_kfunc_args()
> instead: a nullable argument that is actually NULL is skipped. Note that
> it is okay to skip even when it is a mem+size pair because the size
> argument check has been moved to the scalar section. The skip is done
> before get_kfunc_ptr_arg_type() so that a NULL passed to a nullable
> non-scalar-struct argument is not newly rejected by the BTF_ID/MEM
> resolution.
>=20
> No functional change.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

...
