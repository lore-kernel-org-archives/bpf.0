Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4633E2FB969
	for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 20:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782417725; cv=pass; b=bJmFHleWA3VvhGu77jkQkve3v5uIPigrj5uyyVlGI5PFzRtHw+PDT2fi0Sj1f7hJxac1zbkFI19a6kmvuOYzM1pGUjpNnSbKdFanew1YfMEuwRf0tLTBbzBjD8BObnxsM7Spn66KVY5L6KHg64cjhS+J/2z/wPJz9mgLf/nZGh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782417725; c=relaxed/simple;
	bh=4i+Jt2gLzMo/XoxVTGhsYzQiHBEBVYpA63kWSC8KzB0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RD0JYZTVq8fFUEWLDF7DzRUczSWopdGSNixrUD5wg0N+oXedXo8S27l8/Da2jPRdqdgSNJRhQaeGF/s8QsQ9dD30BLR/Tw0KEL7oXC2CN25rkZKLAlsmdCu+BIkLjcS7rzH+OozvT0nkzsdc7kD66jke/W1kpb5K6aCVrsCbJTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pJ8/vB86; arc=pass smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJ8/vB86"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-37e0035aad3so118093a91.3
        for <bpf@vger.kernel.org>; Thu, 25 Jun 2026 13:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782417723; cv=none;
        d=google.com; s=arc-20260327;
        b=ed0HdNBqHI1LTK46WOTcLFI+c2NCFlKrWo9YJApJCF05vScLWqY+GvR0feqlyRjUq5
         3ABY7ByQJcxiY0NG6jQjEE+84ZP7spFEGMjeuH+/ReoZOHw5Aum23NBGKWHECLfmwypZ
         O/tK5Qc4kh1iycpCE8pY9RlxdatxK3fgow0MQaQbRfYGgmYFHGWol1w97crr+ufgo9Sg
         XGqD9lcsNu4n5BtYEmhMuUg44MDcBaxbETu8GPsmkiwp6E0nWRZPLb1rJth4lqVpFKE+
         BlSZlhWXjRnZZ6B+6vg3TDIHZdWr2UMLgQGR/YY5wwX3CcPzvu8es26iTxl5z1b9/0jd
         8d2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4i+Jt2gLzMo/XoxVTGhsYzQiHBEBVYpA63kWSC8KzB0=;
        fh=/kuQpa2BoCNLU5rz8LGKLEs1ze06burEKPR7mVGvhHM=;
        b=B1sytS4k8zomDkm3BJIIRyZYqferYxPJ5TJPyE8l8NM3vqP/mY3inGqWsmH0J7yUmy
         5SvwdFvs+u/zn2Mj3aL9CTc9l55FAAPVpFbWOVe7SpnLtrNux+Kfdjucg9gZQUNaFVWx
         NZVo6BfgoFnVKdegotBAA6MVUNdIXcKzq5hqgfzmLPwTk2aHHx/CSIG3BwYRwyzpfPNx
         HrKQVwfa0rcKJgxr+G6Y5ln9LXnUbcDriacogU+4H9fU/Cc6UsUSyJipfdwr3DDRxQPC
         dmbA/4WikQMC51njuRcgzfxzVEa/xFZJSaf/vZlO9tzOKF8ebjcZ6vsdtaW8UzoXRcZz
         MmAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782417723; x=1783022523; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4i+Jt2gLzMo/XoxVTGhsYzQiHBEBVYpA63kWSC8KzB0=;
        b=pJ8/vB86bSEeqFQnid056mYV3Ex0b5JiNjMcNq/ibYCEPFoBqVAcwTmSeChBQayhgu
         EpbkCxvf/AY+LfmdhyEFMUQvDClNpah4liBkolO4mAeud1mPrB8tQI6HRrhTNOpb9+wm
         KmvRokxr1l25JItfBqr7IepHwJJGbEhOiCplFv/ROzAHxOHJskGi0TWE5QVq6Bt3S6DI
         rZaaRKEFgJRhVJHN3Mm+Xo8wjYfu+cVU1Jb4IbQnSlWYdWIl6bOmBM20tcDpRLyleD0B
         0KUYZH5WkUHRtz1hq2nmH9gj8QkMY7sr+1xvHZY5bGqzSliwtCSOe5If7giYcHjB977s
         41EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782417723; x=1783022523;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4i+Jt2gLzMo/XoxVTGhsYzQiHBEBVYpA63kWSC8KzB0=;
        b=DdRyu2Mz8HuSKXzWdWpPt2u+q0jDbUDva5ZCmkL8uIzxnrHtBK/12HyVzWw/cHZdRo
         AazuGl01KZs+f3+YtZJKdOkC8rZutu/O1woIpF4SP9rgZhyVkj6ei+wSDhH9tRAsoIz/
         /Z0kvOG+ItozjcgOyiNnx1vQ8TWnoDhmyuBIN8pzG9KbbeFBVxnw9I0SE+kNzaZIXzMY
         XC0mIRIJ2nherZFXlMEQSPa4MSgqHXa+wGIdkT6IYsqhGb7RoGPneCodJiWzwQiaisRi
         9sFWlgr6NEXwdm7bzYxRycHYdzwjhspqNQUhaFxnoi8KIncNHy4i2ZAtydlVUnH/T1UG
         rh/g==
X-Forwarded-Encrypted: i=1; AHgh+Rrr49cYcAEz3WLqMjKwdHy+nAOuV+y8whga2HrrBhfTh/UewEBkNCYZ/kPha4h8HGLdbzU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5EJwUKlsyDZ4D/uLGYSLLjjJmCryfaBl1xSYGThCMn054dRb1
	AtAtXYwxSSClXD0ZKBcnYCxrIGXRpfk+SiwPusW4uh+WlLxx6e+f8/by44H23iLddJqmmnKWmK2
	IXIOFsCnN8Q5mjt9aIXJVxD/BKKMOFeM=
X-Gm-Gg: AfdE7cnmOakTBn5fc8L5cp+r1AkHqP2zY+RFrpwxLV6jY066dkrgPNQFp/3SB10SAx1
	s3qQBmBgxmKThhg2nfy1tra75dEwHI77bENFuqKcE95px0F43gCGd+ZQNYvDA7j14eEb8fQM8W2
	LIXNygvY/QFj8W5Y9b578+MCzkHT0Fu82+bp01ut0b9/ZsOvFkqHiufFeNivxD8aZq9n3F5RLYo
	6Lr1UPLdD+EcjPx0BR4LJszLz6YOetXc5FMUtuBA/HYqTGC8rrfiygO+uWmXHpCy+k3YDB2Cjcx
	CBk+bl27KdUsOmKgpFmLor4kL+gDDzyoXFzwm0KgguS1ROsASSl6mf4OKsBklq/2qwNglCvpvVt
	v4B4z4lSk8EjA
X-Received: by 2002:a17:90a:d605:b0:37d:8849:a093 with SMTP id
 98e67ed59e1d1-37dfa1eee13mr3874706a91.11.1782417723187; Thu, 25 Jun 2026
 13:02:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260624-bpf-lskel-fixes-v2-1-e8ac5974a72c@google.com>
In-Reply-To: <20260624-bpf-lskel-fixes-v2-1-e8ac5974a72c@google.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 25 Jun 2026 13:01:51 -0700
X-Gm-Features: AVVi8CerpP3JXnxWwj0kngfVf0cs_Uu0Z1eZKknvcduNBSzamBu1smQ9UnhuEWk
Message-ID: <CAADnVQLURewU9wJ+4MTjCG9Uq0nR=c=oBbJ4vGbL-tRdp9YJBg@mail.gmail.com>
Subject: Re: [PATCH v2] bpf: allow BPF_LOG_KERNEL from kernel space
To: Siddharth Nayyar <sidnayyar@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, LKML <linux-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Giuliano Procida <gprocida@google.com>, Matthias Maennich <maennich@google.com>, 
	Tiffany Yang <ynaffit@google.com>, Neill Kapron <nkapron@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 24, 2026 at 11:19=E2=80=AFAM Siddharth Nayyar <sidnayyar@google=
.com> wrote:
>
> When loading a BPF program or BTF from kernel space (e.g. using a
> light skeleton generated loader module), the kernel module may want
> to output verifier logs to dmesg by setting attr->log_level =3D
> BPF_LOG_KERNEL (16).
>
> Currently, any attempt to do this through the standard syscall path
> (kern_sys_bpf -> bpf_vlog_init) fails with -EINVAL because
> bpf_verifier_log_attr_valid() rejects any log_level bit outside
> BPF_LOG_MASK. This prevents in-kernel loaders from successfully
> using BPF_LOG_KERNEL, causing silent failures if the BPF object
> is rejected by the verifier.
>
> This patch modifies bpf_verifier_log_attr_valid() to accept
> BPF_LOG_KERNEL unconditionally. To prevent userspace from exploiting
> this to spam the kernel log, the patch enforces a strict privilege
> check at the syscall boundary points (btf_parse, bpf_log_attr_init,
> bpf_log_attr_create_vlog), ensuring BPF_LOG_KERNEL is only permitted
> when uattr.is_kernel is true.

I don't think it's a good idea.
BPF_LOG_KERNEL prints to dmesg and it's there for cases
where BTF is corrupted in vmlinux or in the module.
The verifier log can be large. It's never suitable for dmesg.

Let's step back and discuss the end goal.
Not just this patch, but overall.
You're sending a bunch of patches for various lskel things.
Please explain the full picture.

pw-bot: cr
