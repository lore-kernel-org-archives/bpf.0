Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2730C20125F
	for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 22:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786919530; cv=none; b=bvmK78aNuobKlRoHx3l01cb0Gi2ibCRO9nf/d35KFOV3KEnm88kgD13A6ijXc0Fpi3dqbvF94tzzMdJYVVzdLADRhzGeT7w4PS0Fg8zV4ci5/FuYUtVp2hLgwJ1fUm8mjGyLnJMmZSxizQQk2e4mrzIdpvJFFtnTCslR+tK1XBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786919530; c=relaxed/simple;
	bh=Z9Dd2gZjoJ7yETjz2g3Rlcg8H/KZx6LIckUUq8it2hA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lOXzMeWlHNCLFLS3ZfZlv3hRZEh11Z/D03r4jztZ8hlZJzWqy/yUODuzuLwm/rDrAMa+j2qoVUpy+Rtqe11Uu1sFhVT4EHRXX43vle7YSNgT1lVGdQyRU0X+b9buqNuaHC6bx7ck6v6cI5qjvvWA520TX7dJQTyHAEpSZxR5H9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoL9L2rF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoL9L2rF"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d049069377so28270065ad.0
        for <bpf@vger.kernel.org>; Sun, 16 Aug 2026 15:32:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786919528; x=1787524328; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=Z9Dd2gZjoJ7yETjz2g3Rlcg8H/KZx6LIckUUq8it2hA=;
        b=hoL9L2rFBke0GQCAobHsazWsHNNkxA8jHlG3fWQ7GfTIhwg9TaKyE0GIlQ/US/lcBB
         Rx1JbfUXxV3sp7W2yed9YKZGwAeHxbUMIMZVBuyxQt1Tkpw6pRvxxb4PJsCkh7yHl7Wa
         XayE8ZObpA/5Jo18zduERfls3Ux65ZXkbxWhpe/TM0PVpPMXYq/3lAKLNvKyyLYkrPyJ
         RiTfsP0P82wgp5KBnH1vsLuAkIxNFJX1bggpVL9vi/9PlEtYBAyLj5RFsL4DGm617dFG
         MLcOi30Zwvl3KogFzn0id9EDb0QCvpqUnEfcIKXNh9cwlYk0J9ngSzsTiMP7OgnUebQb
         9RcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786919528; x=1787524328;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z9Dd2gZjoJ7yETjz2g3Rlcg8H/KZx6LIckUUq8it2hA=;
        b=Z6+sP9YMDfkQtGjPAlBQALm43jHiYeUp+IQ/u70B7O7bgpJEYy+NqIK+yNnhUcJKsw
         bzlMmKZ2DYVoFyOW6FZ7bokBAwuK6kDOPwgZeWXE8EfvOMjiI07T8jIIye5MpWvngQdm
         X0E9Bj9lcodyOondJoB1hdrQB5HQu3vEChRYTvAY9Z+GQeChDMHKjIV0LlusRSm6O8k2
         vS+z3jzphfkINLkweOyn+CcX/ZINwR52YtkZya1PW/CLN/gHNhaZh7Hw2WC6w8iHL7oP
         ZUA4aDeTf5+dNBLDqO3W/rRfQVK02yFVdYh4IM3uQwQFgcM0UApmhx/DpMZsvP+FTCoU
         RmeA==
X-Forwarded-Encrypted: i=1; AHgh+RpK4aD28tEH8Xq2phSckzhLm8XYi4kUSxrko/46bcioEo4xo4Cj3l3lKkGuw3pMFW9n9+I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBr5Bdi95Jne/MyjssqhciZkx0QTOysJftXFi+if1Z/LXYUjkg
	xNMP2CJAwKqAlbPayLcpHk2/PdVB1BzqVZDZDh1bYdJZjDrkZaLfsLrg85NvpQ==
X-Gm-Gg: AR+sD13BnXWtHr8bpArWUw6WGYh0bbWbEQn4s8zXwpe1oNvIj9Uo/ZsOLLqxIbq7SX1
	+tEWcas1Yw+gSKKPR5NdJb6gO+xSX/O3/0+qioMj9efmIVlGRAlRjjxt+R0/rEILM/vy6J1tt3G
	PGwKCviNFFdUgH4Mn5WdEDwJMw2TR2kQPN64kfd6Z06nOwJPfFfo96bfTDzFgt5yWtffspkmN/N
	QpbQ4dB07EYaXPXI92qaMHlFoYrhdUNDR4Lk8ilcV38wcDJ/+c8vX2t+1FsVCFJYzEyOj43Lcqy
	pZ9xpu1TF0xQslr0w0qoLHTfz33FjN/ZC10CxhdzHk840R6EZgopgkY31AXu0rnHrQc0Jn6ATVU
	2E8QapLSo/VFRsQlcrhgCb64YuRffcSGDS+P4/Q3NxASiuGqzRRPLyWYrBFd3bva8/s/T6gcvUN
	FkAXboqWfv2SCSZO4G6zdya0HUvhIPSyomLeTKhn8P0YP4h2+3DYzhK8n224y/9er09Fjp2z2fu
	iWjvTcIOCBuhfJj
X-Received: by 2002:a17:90b:264c:b0:38d:ddc2:7ccb with SMTP id 98e67ed59e1d1-3933b714f34mr21321459a91.1.1786919528367;
        Sun, 16 Aug 2026 15:32:08 -0700 (PDT)
Received: from [192.168.0.13] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531cb18f0sm2519023a91.0.2026.08.16.15.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 15:32:07 -0700 (PDT)
Message-ID: <2d1e698da4802d4c1870f60db8e201333eeba05a.camel@gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] selftests/bpf: Add tests for pointer
 type merge at a shared load
From: Eduard Zingerman <eddyz87@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: memxor@gmail.com, bpf@vger.kernel.org
Date: Sun, 16 Aug 2026 15:32:05 -0700
In-Reply-To: <20260814215301.709827-5-daniel@iogearbox.net>
References: <20260814215301.709827-1-daniel@iogearbox.net>
	 <20260814215301.709827-5-daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-10 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-08-14 at 23:52 +0200, Daniel Borkmann wrote:
> Cover the ways in which the type recorded for a shared load used to lose
> the BPF_PROBE_MEM rewrite which would then trigger a NULL deref if not
> handled properly.
>=20
> =C2=A0 # LDLIBS=3D-static PKG_CONFIG=3D'pkg-config --static' ./vmtest.sh =
-- ./test_progs -t mem_rdonly_untrusted
> =C2=A0 [...]
> =C2=A0 #238/1=C2=A0=C2=A0 mem_rdonly_untrusted/btf_id_to_ptr_mem:OK
> =C2=A0 #238/2=C2=A0=C2=A0 mem_rdonly_untrusted/ldx_is_ok_bad_addr:OK
> =C2=A0 #238/3=C2=A0=C2=A0 mem_rdonly_untrusted/ldx_is_ok_good_addr:OK
> =C2=A0 #238/4=C2=A0=C2=A0 mem_rdonly_untrusted/offset_not_tracked:OK
> =C2=A0 #238/5=C2=A0=C2=A0 mem_rdonly_untrusted/stx_not_ok:OK
> =C2=A0 #238/6=C2=A0=C2=A0 mem_rdonly_untrusted/atomic_not_ok:OK
> =C2=A0 #238/7=C2=A0=C2=A0 mem_rdonly_untrusted/atomic_rmw_not_ok:OK
> =C2=A0 #238/8=C2=A0=C2=A0 mem_rdonly_untrusted/kfunc_param_not_ok:OK
> =C2=A0 #238/9=C2=A0=C2=A0 mem_rdonly_untrusted/mixed_mem_type:OK
> =C2=A0 #238/10=C2=A0 mem_rdonly_untrusted/mixed_mem_untrusted_btf_id_type=
:OK
> =C2=A0 #238/11=C2=A0 mem_rdonly_untrusted/mixed_mem_btf_id_type:OK
> =C2=A0 #238/12=C2=A0 mem_rdonly_untrusted/mixed_rdonly_mem_btf_id_type:OK
> =C2=A0 #238/13=C2=A0 mem_rdonly_untrusted/mixed_mem_mem_type:OK
> =C2=A0 #238/14=C2=A0 mem_rdonly_untrusted/mixed_map_value_mem_type:OK
> =C2=A0 #238/15=C2=A0 mem_rdonly_untrusted/mixed_stack_mem_type:OK
> =C2=A0 #238/16=C2=A0 mem_rdonly_untrusted/diff_size_access:OK
> =C2=A0 #238/17=C2=A0 mem_rdonly_untrusted/misaligned_access:OK
> =C2=A0 #238/18=C2=A0 mem_rdonly_untrusted/null_check:OK
> =C2=A0 #238/19=C2=A0 mem_rdonly_untrusted/ldx_is_ok_commuted_addr:OK
> =C2=A0 #238/20=C2=A0 mem_rdonly_untrusted/helper_param_not_ok:OK
> =C2=A0 #238=C2=A0=C2=A0=C2=A0=C2=A0 mem_rdonly_untrusted:OK
> =C2=A0 Summary: 1/20 PASSED, 0 SKIPPED, 0/0 FAILED
>=20
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---

Hi Daniel,

GCC-BPF fails for the series [1]: because of the difference in
codegen some __msg patterns do not match. How would you like to handle
this, land first 4 patches and do the tests as a follow-up or as a v3?

[1] https://github.com/kernel-patches/bpf/actions/runs/31970050902/job/9522=
2785689

...
