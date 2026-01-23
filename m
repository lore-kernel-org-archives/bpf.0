Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DEE34FF4F
	for <bpf@vger.kernel.org>; Fri, 23 Jan 2026 03:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769139304; cv=pass; b=dFq1SXe7kze9aVvjiQh2wte/KuUMIw5a9FEjGE3J10+R2EYONg2qk6N4V60o8AysKuJ1LvhWym8fhQDIGFHq/qnWstDhDQXJkz+N/A5Vb1G2SQie4cqJ/4D6hIAC9gmNANDQ7+xfMQz8SL6TX7iPNONIDygjAaoeIOozVuwxWa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769139304; c=relaxed/simple;
	bh=i4HPWZRaiQlyyM8ofRguvMleF4aLKqXRboho94ANFVM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jc4eOh2RhtA0UV3yln7NGoN9uR7+1YOQLW3qXyx7gyOVf67tYI0TcOovBJK4S/B7MjbClkPyKWag+Cq96rcQYgjoe14l8h6HqKwzj9BFUXEt+zWkxWKw/xyFxjzDB8Ijaf6EWsqCaFYTXzxRalP2ZC7dWuAeTEgLGvoJICKmGEE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AVciBDY/; arc=pass smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AVciBDY/"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-47d6a1f08bbso8259965e9.2
        for <bpf@vger.kernel.org>; Thu, 22 Jan 2026 19:34:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769139290; cv=none;
        d=google.com; s=arc-20240605;
        b=VLqIrZ7oRwyPVB6xkBIYKBRZQXxpKTrGNRATN71CWBNol0CsdheSLIY5vANm7tmd4r
         avmFzbzGrzajERr5fr6rtullVN5mpN2VH3Kh7V2Ersmg9fo7G5kN+Y2NBJ18sIQmPjgT
         fX4Uvyo/jfozl4684/uV0Vc3YzGZ2mltC28/5HSRlkQZZQDRmviwI8c58T5eRu04TC2x
         d/0ww9NddIFyt32GLT0yhfExds/TpvVeb9s5cYyW1M6wr/YqPApnuzSKryIsobpfkw3w
         bOba7v347UGjGLTC1gUsVd/NHSzHWWWSozFpyF7/rr5z40CGP8Ms9Z1TR9Zd81LK3OLb
         PakQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1cVqi1JkwaH24COmQQv0Ap1DWv3oHOK2fAjOdlZouXU=;
        fh=gb1jeHXMBGAhbLh5bEIHuiknArSEd8gP7PjWGq3dY5Q=;
        b=AoC6EDiHStTeqb5bHzdBr+15BZCCMQaGPcka02zH6/XgeT/4ypgi8SPT6qrkKNI7Sm
         Cgb5m60x1f8v/buhwc+9FUkyNKaggE57noSenan+kYP/zppZ2+bU4vdW6g2r4DG2ATPI
         pMov5lSfu3H1sZANyDwDItibAtPfVpJAfQIPH0+rWyO9mnjBrRetbLtGsBJuWRnEsa8U
         26S4zEsWNETYoCSozvKej1dSOVIhGc46fDldvIjGH+izWXBN1aU42Qdl8lHK1hgkq04b
         rScwobvIlVi2o00rrhMn38zo9srRx/uB9ET7V8BNuoSvcUGpQpgX70GsDb4IcsXJCGR3
         MHVw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769139290; x=1769744090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1cVqi1JkwaH24COmQQv0Ap1DWv3oHOK2fAjOdlZouXU=;
        b=AVciBDY/x8KvXU4kEOtGUHU87ay/iErBO7pz3zQUJknmouBzaGb2xmKL+HIYcoCAv5
         elNfX+RAgBVIHnUcBAy3rj77PhgV3OPAJQmXUVlx+tioNoSjRweoumbVypOMlyDzNC39
         m1J6x1IC3ewzM95GQHMeggKLyi93rF6yGTkWgRlSSXuNREb1cohnVf1Xce30csTIpN3r
         UJN6eRrken4zTLHseiMe61CEWdFFoNjTWPrymO3FefZWsMSiVrRvCyhERdK7+QsXpLRy
         dR3Wt0B9AmOHzANpeoP64C92xE/aQGQPW/Z/ca+Mdkajy0TrMIL5dhiGzd0FQ2Dx5hTf
         XKhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769139290; x=1769744090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1cVqi1JkwaH24COmQQv0Ap1DWv3oHOK2fAjOdlZouXU=;
        b=jclukWZ7oqNaJ5zbHx1ZSgfAj8QcpPl+vCE4lQFHu3p0qHuERQo8AxMR4j9gbPQ9jN
         4/eem+5f8JUG8Y5W7d3RDpEX+jKyEa7/15/HUUea2XiLBYaFBJl4ZihtIVKLHxjMAmVe
         hLo8m2obvlETEp7ry25+Ritf1HCxEPwtjm/rheV0VB7NegetP7lcGONV6qBxWcQQJlrM
         7MMrCix5JyO5p+S2uM4+06VZfgJ+fCPqxIRu9YeOFshZZd7a55ILDNr6KMwu5WPvoV5p
         mmRj9R4v3vjCJIKpJMkbCoZpAlZQy202D8oEvhVE+splOm/N/4MzUFUOPIDbdL36BiQi
         be8Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/fwGdfooy6gdn4Wus6BPXqP/IDxUQF50K762ApXSN6Hz0rM5/Ci5K8aBnNGkZHb9cSKo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPaYyWnYB1JOuHB8oLbRg0xAfXOMjwOmrMRa8Bda7Go4zdXDyn
	Ltmzf3Utx2DURkSY/7VUgEuah0DSzajzg8b1KcuYaB7Xeg4Wtjgv0Sb0PgqBfRUaAeSI9D0frDL
	uRNj1Q0a+v39bi9BzjImSxQsHoKPfPN8=
X-Gm-Gg: AZuq6aL4/j/t6sgvaLz5kYpYMMgGZlQiosBfZDcwilLaFdXFinmiuMl2PWqM1rby3rv
	3VU5LASeQiIjYXkHVJBbWX6O8HFlQR56bd43A5kraCDhcFZm+2nIjFL06ZEEs0sHIL4t0DNXx3d
	VNeeU7uY+HcrCpq5kMSjaVJpU1WMKgdgVphYLwauNFGhe3iqqM9DfMiPYi8ny1CShIVaImPZpNK
	T91rtAZjIdOhXgPXmH7OOM30ns4SL1ss9//+u+vtwDla7LNHQwgcWEubyG5oL1UBCZQT6k+Echt
	LnVwgRq8T997dq/KoB/ZpMEaJbqhIZnPPEAS9YhP2UCQd3SldYATf3bArb8vdsxfxYVT3gQZdEw
	Ac3gSO+Sx/2DfMA==
X-Received: by 2002:a05:600c:1c17:b0:47e:e20e:bba3 with SMTP id
 5b1f17b1804b1-4804c9418f3mr30320745e9.7.1769139290087; Thu, 22 Jan 2026
 19:34:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122081426.78472-1-pilgrimtao@gmail.com>
In-Reply-To: <20260122081426.78472-1-pilgrimtao@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 22 Jan 2026 19:34:39 -0800
X-Gm-Features: AZwV_QiHiV29-x9T-Sl4OHOsOUk7yt7p8hL6fK2f4OmS2_-XikfA7hZ4pp1JB3A
Message-ID: <CAADnVQ+TwUwzrWZ3EJnPz4S48HqBJxw3+OA6UL-K4CWgU+4PvA@mail.gmail.com>
Subject: Re: [PATCH] bpf/verifier: allow calling bpf_kptr_xchg while holding a lock
To: chengkaitao <pilgrimtao@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Chengkaitao <chengkaitao@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 22, 2026 at 12:14=E2=80=AFAM chengkaitao <pilgrimtao@gmail.com>=
 wrote:
>
> From: Chengkaitao <chengkaitao@kylinos.cn>
>
> For the following scenario:
> struct tree_node {
>     struct bpf_rb_node node;
>     struct request __kptr *req;
>     u64 key;
> };
> struct bpf_rb_root tree_root __contains(tree_node, node);
> struct bpf_spin_lock tree_lock;
>
> If we need to traverse all nodes in the rbtree, retrieve the __kptr
> pointer from each node, and read kernel data from the referenced
> object, using bpf_kptr_xchg appears unavoidable.
>
> This patch skips the BPF verifier checks for bpf_kptr_xchg when
> called while holding a lock.
>
> Signed-off-by: Chengkaitao <chengkaitao@kylinos.cn>

The idea of the patch makes sense, but selftests is required
and you have to use proper full name in SOB.

pw-bot: cr
