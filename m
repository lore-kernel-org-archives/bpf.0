Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3AC3DD528
	for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 20:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785184805; cv=none; b=FQNgLMmgzShv+JiECqULHm1B97tP0sHiKLzwNhpF9eK2rJC5SfNWzpw+Ub+xjRjnpqylv7/r6GCHolnH3KR8UyU7hW6DHQ/UojICLUTw9yBksQekJRJUqF1rdA4hlFqEIPrBWosWciDmCOrbl7H6JS/fBNwvtionX34fwdoMsXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785184805; c=relaxed/simple;
	bh=2F0OlGhBUNHizkff5vBoWA0JxKOBKcseB7OG0LPcocU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OgR1t0d0LujN6S30ZcmcOWUCX8/q/2aCDOMQESAQsiRBXQONalMz5KHZA+2AS7wVNRN+k77JEiS9wVggrHj7oL73sAwkBlGKyl6BSI/jEZWXuP9PIX+HMh0GKBHZLpegyPXoyN7R82feqDbi0TmJ6W57zOF8R9wzTnSM0RCd3A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7/hGdJr; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7/hGdJr"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cc73e322dbso30270175ad.1
        for <bpf@vger.kernel.org>; Mon, 27 Jul 2026 13:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785184803; x=1785789603; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=2F0OlGhBUNHizkff5vBoWA0JxKOBKcseB7OG0LPcocU=;
        b=j7/hGdJrxEwc+qWIO/fHsBIX0d+n8CKjt/QfvWu/E7GlMzxdyrcNow7BsvBm2VhOiZ
         AXkM9a8oun/h+yeXbmVEJEarZwHJgHxWrno+vdzK/ezQ6IvdPmayDU2FMK95JVwM86RD
         mRGyW367W7/aPrJQZ3zhZmm7MSCCI0Ru1Yz7/E/k+5O4LSTGvIdffxxkEG9Ko7tLnZkz
         SN7A/gP95nbqwao2JUwEEE55Y7MMXJgnyRTFgKeuXIujwQhVJDDSDor4CqyQKpuYvFJa
         Az3n/Ks7l7Af9XZUdS7PyjpQBZDvcM6+m//t2RP/RyufdBbrgWLuQRtjcIlxYFqyzNFr
         NONw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785184803; x=1785789603;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2F0OlGhBUNHizkff5vBoWA0JxKOBKcseB7OG0LPcocU=;
        b=UI+UzU1djPL+JXWsZC6GMpF989sd7tz+SJxEBU9RZGgss+fzg5zR4kGom2v7zEtwbh
         IYdHQQv/EJmWU2ubmjvbuz6D5rG18zx2Jw370CqRYVBDV1s9t13I+D456MZSYt/Kkt2f
         w1CSbrBTfVC81HY+hvkVi49hSOae3JJLISvenptgi1IQorAleW72qHPGkssooqtX6ujI
         1nY/yp5vs533Bs6t134f99c+/6JNn/XeApF5otSmXEc0U8Wv1TM11HbPjBiJ75hoQM8+
         THhJL2TQzzrpZIehGU/qOOVjY1MrfuyL3EuGzFvxSNKVgpctgSbhVfrHJLzKLs3AmQfd
         losA==
X-Forwarded-Encrypted: i=1; AHgh+RqQ4jcxPE2Onr5grDsy1g+DbXVpfhR1Qul2TaGmCffZjHUNu0mkzbMBi+3qADkipQj6II4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzy5UF1vf7uwteEhnFRTATXse+D8ry9iZvkNMbp8iAdfzdQh3k3
	OT0ItzE6SnkMteJXzdN4kfCPe5ERcDO+K6Os3HXv/PAPkl45MGlEmKJ6
X-Gm-Gg: AR+sD129vC5a6EEgG5Gu5NxRZl25C6R2TpfrvFb3Yot6tFIMaWW2AhUECwCfIlDjec7
	5wE0s7Djr7CgYY1cAe0rxLssZK3+YKCoPSBodG5mskwlL3sZiDsgKhWJtxJJ1rrqEJ7A13sM/QS
	qrklqir3/D9e9E43bbqh/iFzi2fxuvLFb64putAkGyl66TI43tgMdp24vGVAUCQul0Ep3n5gS7m
	MvTPDzlmD7t9WiqmoaTbvfnmWWZoYTGQAc131aSfkjrNVzye2fL1odBokPHGAdfUWfTpJe4t7hv
	wV3DmhmaRKvaK66T8DUkuABMW/jP3+uYE7CNE8v2wB09JbCMyEh3HJWfzbMyY73K5IVMsWm1+Lf
	3RWWIiAup5jTl3yLnSv6qFUA+Ro0bjyyZm+S2zXN+fpie6S04UtTdYCgkuliabseEm2+2kqtOz3
	VfKnwXnhKfCoW2o2B0tyBCpKUptSk/RoxBlnMwNdiq
X-Received: by 2002:a17:902:ebca:b0:2c6:a172:55a6 with SMTP id d9443c01a7336-2d00f2bcf1fmr7889905ad.9.1785184803492;
        Mon, 27 Jul 2026 13:40:03 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfe1ab9c7dsm36773035ad.70.2026.07.27.13.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 13:40:03 -0700 (PDT)
Message-ID: <41316d1f8f4b934cfe81945d8625beb7095d524b.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 06/18] selftests/bpf: Add tests for helper
 and kfunc mem+size arguments
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>, bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, kernel-team@meta.com
Date: Mon, 27 Jul 2026 13:40:00 -0700
In-Reply-To: <20260724190813.1458271-7-ameryhung@gmail.com>
References: <20260724190813.1458271-1-ameryhung@gmail.com>
	 <20260724190813.1458271-7-ameryhung@gmail.com>
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
> Make sure the return of map-of-maps lookup cannot be passed to nullable
> memory buffer argument for helper and kfunc.
>=20
> - mapofmaps_value_as_kfunc_mem_buf: an un-narrowed (possibly-NULL)
> =C2=A0 map-of-maps value must not be usable as bpf_dynptr_slice()'s __nul=
lable
> =C2=A0 buffer. mark_ptr_not_null_reg() converts such a value to
> =C2=A0 CONST_PTR_TO_MAP; without it check_map_access() would let the prog=
ram
> =C2=A0 read the inner map descriptor as raw bytes.
>=20
> - mapofmaps_value_as_helper_mem_buf: the same map-of-maps value passed to
> =C2=A0 a nullable helper mem argument (bpf_csum_diff()) must be rejected =
too,
> =C2=A0 guarding that helper and kfunc arguments are checked the same way.
>=20
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---

Reviewed-by: Eduard Zingerman <eddyz87@gmail.com>

(Modulo error message issue raised in the previous email).

...
