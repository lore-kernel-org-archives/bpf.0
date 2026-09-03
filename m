Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF25A37754C
	for <bpf@vger.kernel.org>; Thu,  3 Sep 2026 22:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788475260; cv=none; b=O0Wc5chSY3UOk7R+2Abs+waTgeXbqYccLnV41mhSs1tQcsNJPOGcem+Wo8Z1/04M4PmRQV/oU6McIad+KcS4ZZ92mmSjTE13noCQ9PRP8JbxfP5W5CsYEe9lcj7yv3z8IegIOYRgEz03tt8IDN3t0//sws5tRWgZrZlRfbDioyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788475260; c=relaxed/simple;
	bh=hCgHfMHD19qhV/083M++23KJFQcwxpYQSHCUHKRyexo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lX0PpQTF4NMa3BdzzRDRWBiZHESJ88IusVVzHOBGH3V7spTIykPxCgd9KR1gSu1FRBlLQ0HShzXu5C1eQxhgpEUuBby+mYm21513W/tRjHtdaetLx+jfFHzpKWdnkkunKEbYxttUIXtSE3AiFtwOM0mK+qtc0+Io97VKL6E5WnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJy+xO7z; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJy+xO7z"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-39b24d114d4so391492a91.3
        for <bpf@vger.kernel.org>; Thu, 03 Sep 2026 15:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788475258; x=1789080058; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=hCgHfMHD19qhV/083M++23KJFQcwxpYQSHCUHKRyexo=;
        b=LJy+xO7zkJJ6qvWFVky5hFSLkYf1CkHJ+MD2SG2TAvz+u27NjueJUtceMshMxPjfo3
         R8O3rRzAJmW1aPg2UKqltLamVZdrVra4FOd2hvH+dxEdTG3bWYSZWOeOfK1jCtZyH4eG
         zSZuWxfEjHp8sILW74jgYO8httOed+/V6dMB0EOdfDPVMdqvv5m83/1bfSG9wG0djI4r
         lV4RsZeETL0w3SQc+eFdzvPVCUbicKgfyzi0k8oT2h3hG7P/iV6+oAVaSa76hJqUb6vf
         dsqWdAXj70Qf5mIwUVtmtMN0G5MAOf3VXFiQoshgfUWpnGhs6nreop5jGoTww0o8XJT2
         K7Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788475258; x=1789080058;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hCgHfMHD19qhV/083M++23KJFQcwxpYQSHCUHKRyexo=;
        b=RhjEVSZfvnrHuQamC8JMi3EfUg498zxymS1lgbEi8EGprK3ji5wv3OxzacvgGUsR8K
         XS8lcxkbY76OftYGN1Y7iWd0QB24GBUC7jrNzAKTjcaA5kcdcC1pxHaVHMEEbw4GG9fE
         NQXmKd4qydc74mD9AZHAJx3iUUeNqesNs0lKbhFUpI2NoACno7khUtmj8j6Lngjo8WPV
         kLZ0F2G+EMD8YTygVb24ziMx6z8yJwKD9E9ry8uznzn4FGmHV64hZCu7oMbJa+F2xX0P
         2bGWjE2RvlCYUcfNjGMN4qSD8Cd/enmtjL8JTu+DsuK0LwJbfaMLZxUzt7OXOdratU9z
         LLQQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQLYFDwFtea7Nour07uEF8F7xs0KQkNDCA4FFln3ZDCpFX7wWwp/tBZO8KcWkdHBTIN2Y=@vger.kernel.org
X-Gm-Message-State: AFuF++l0CiX+g3JDlpvjlun1YFReQHgAz2ACkyBLendXtUf/5EQyEOSk
	GMP4gcJMVPHIfW/2VGmbZwaY/FjU6na+JiNkbQBF+u/GV7J5jMQxK+fF
X-Gm-Gg: AYBFou1zlD7G+qGu/pMgjYtZOI44sY2Yn2aWwl8u4/4VRKSIx0jKBUDeVHbFORBvKsh
	DCIqYWoP2dL/tuPo7iGH8hTvDEA3SDcDvkG9mn8lb0XCXP9oBXSS+aE1ZzVnG6FaIfMxcBO1oE9
	HmJsGpuDfGn+q7Sr5WRXQxJrkOrewvpgAkLFZPd3+n/QALhkiwJFZ7Udf4XoU5xA1CLiZMrBC9+
	MjsOTUdW0u4WbH8taPv1oaZCtn7iNIS+6PbNvMBcU2H+eLBjUmEV6A0mJdu/ocwKL5V8IBMJ4gY
	n9aVdxcMyXcCAlBvMljEIETOb46DkNMibSI8HFno+SGPHk2QfaLGAYmoDv4UQs9hELAw1xEBO3G
	lAkhuOCtlk4xJpWQaenD4iTqyVCHshSk2BYeg2thldPSFgQ+DxrCze+oATY1jOaJUqRJ72cGJht
	llucriREt/YWv7AKoSN1dm7bDhTnt/+AoZvLaICDs4FAijqDD4FzVX6oGQPwXPAj4m12KYXn3ny
	w35rUbxIOYKtFeDd0+CW/fTQxmifS4NMcUZC9/07bX6yw==
X-Received: by 2002:a17:90b:5844:b0:398:e436:370 with SMTP id 98e67ed59e1d1-39b260ff0e9mr2960767a91.2.1788475258066;
        Thu, 03 Sep 2026 15:40:58 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:fe3c:fb36:dc7c:5b5? ([2620:10d:c090:500::6:dba3])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339bdf44ffsm1777722eec.28.2026.09.03.15.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 15:40:57 -0700 (PDT)
Message-ID: <ef8616d9adae2c2dc1371c407b86a504103e9cd1.camel@gmail.com>
Subject: Re: [PATCH bpf v1 1/8] bpf: Check ancestor frames for rbtree
 callbacks
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, bpf@vger.kernel.org
Cc: Nicholas Carlini <npc@anthropic.com>, Alexei Starovoitov
 <ast@kernel.org>,  Andrii Nakryiko <andrii@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Emil Tsalapatis <emil@etsalapatis.com>, 
	kkd@meta.com, kernel-team@meta.com
Date: Thu, 03 Sep 2026 15:40:55 -0700
In-Reply-To: <20260903214758.2727663-2-memxor@gmail.com>
References: <20260903214758.2727663-1-memxor@gmail.com>
	 <20260903214758.2727663-2-memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-09-03 at 23:47 +0200, Kumar Kartikeya Dwivedi wrote:
> bpf_rbtree_add() invokes its comparator while the caller holds the root
> lock. The native insertion code retains raw parent and link pointers acro=
ss
> the callback, so the verifier prohibits unlocking, consuming tree nodes,
> or changing RCU state from that callback.
>=20
> in_rbtree_lock_required_cb() only checks the innermost verifier frame.
> Static subprogram calls are permitted while holding a spin lock, and such=
 a
> call pushes a frame without in_callback_fn set. Consequently, all callbac=
k
> restrictions disappear in the nested frame. The subprogram can unlock the
> tree, remove and drop the node being compared, then relock. Native insert=
ion
> resumes with the stale parent pointer and links freed memory into the tre=
e.
>=20
> Walk all active frames for the rbtree callback instead. Benign static
> subprograms remain permitted, while callback restrictions follow executio=
n
> into nested frames.
>=20
> Fixes: a44b1334aadd ("bpf: Allow calling static subprogs while holding a =
bpf_spin_lock")
> Reported-by: Nicholas Carlini <npc@anthropic.com>
> Suggested-by: Nicholas Carlini <npc@anthropic.com>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---

Acked-by: Eduard Zingerman <eddyz87@gmail.com>

...
