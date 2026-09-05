Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DFB36B91F
	for <bpf@vger.kernel.org>; Sat,  5 Sep 2026 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788641292; cv=none; b=U6tE84D0UwQZ5uE6o99/9kb0TKsBqIaRw4rxUx2zhBveuhrbR5hYIoCZEgXcWP3Cfcb2/cJYSYct+Q3fB9XaE8eZyht724sjc9xznpAKjLk2NXCNR3JnS44v94xA/eP6TlTlgElTEN901+LqWiltm4gbx+pQYUj9lsC+z7SkQzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788641292; c=relaxed/simple;
	bh=A4kGqd0Z3TmiaTsoJKHYGK16iKhgkKr2v7xKHWcW8Jk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=USeMtBWzFp1pjipv3LztV0s3/t58EQ2sI378vgXXzGrSQ6QpCWksgUs9I9yu/pBvkjwtsi3R2jSTzD7XEcSYY+ckQjl8kX8LfT8Od/dMf5oko3cq8DTLQlBIX2FCPPzlezGMxRultgju9GskVU0t+yJ9r0lvhfin5RGkL3b193c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TQmwLBMA; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TQmwLBMA"
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4a45b3f0becso1747016b6e.1
        for <bpf@vger.kernel.org>; Sat, 05 Sep 2026 13:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788641290; x=1789246090; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Ll8R3SutNJw3bcBCy/eZULKcMm4QgvHNZq/L2aK/wXs=;
        b=TQmwLBMAuyII/YRRQ0ok4KkelbJrdPaCVnaxKCPlpp8TOtEvYj4F6K15atKfo3GoOy
         xgFbufcRqNnupPCAScbXuUK4HI399QMCMg4CDMCp/yH0qKoyAOvi/irWw+5Blvu8lJjS
         ga9yP74XfrVASuWa89Li4HRouF3ADhweUlkXUcRXK+W8jJfeoX60JB5VLc3TwkVLDEAv
         bs+lp2POv8QE03Qv/gI4aUfW1k5nmgBYswJZyiKBMZjuYJR2Qzuz5RHGGa9DdJkMIVcz
         Y5hHFWtdKntCbmeK+aBDjwe/ZLNIIefq/PWACpMyMt7IIYs2XeEC8fl0jB0ZMHIc4Rgh
         olcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788641290; x=1789246090;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ll8R3SutNJw3bcBCy/eZULKcMm4QgvHNZq/L2aK/wXs=;
        b=pgdvYhhfx4Y3Rjboj0SzhqCpBGWT5Z+/nv4NvmobyVuP/uu7mV59As8pqpHSP5j6a1
         7J0EIxuvmwDTE0fDtobnC8vnapWCrlDCEe/KWMU6t9bq+YG/5K3UUDFWhxBr5PXJ4DjE
         KaFUzTfFkjdOpE50Kj9SchJh7bWKWtyLwU2jA0wk/hWcvmCTuwXZ3ZvluPLHASrJX4RJ
         EGwOXBdQ10sPxiTvp3u346/k/6yeAFO25SaKx9zZ0pnIiXG4QqE7HelQqB/C1N4aTCPq
         hj72frbKhCvFCq7InIl9GOe8Agm1AwVkCxkyYoTg667fXn9zDTeZFIiW6HuSrWkcI8W7
         GB1Q==
X-Forwarded-Encrypted: i=1; AKwUvBxti4xdBx42wG5ekUzNXKl+wBHp3nidPbdHaX92bn76j5+Ckqq3Q3A9t44g8xACLh/AMwM=@vger.kernel.org
X-Gm-Message-State: AFuF++m4I98aG6tyvOQXeuyKQOwvLCrmp1aCk1Xfmq2LG3/4obYtCjTj
	YjBmPCFRDcDj208RvDu/NHHNPG8KQ6wODUV6BIPEtxMcKo51IvYHG3KS57V7nw==
X-Gm-Gg: AYBFou0g8GuyvveFpdL8A9ZACynNZoLHOHtTKBq3xp06+nzUHSFJhUxt4iGUob3Nv1W
	Ik+QB43jD6GHwB3Yecq6RWIgGq605Z1R8bbL+vPp5NjOj8oa94zrOXZTsDu/jOoGLfr78B0n07d
	4+r61VS9MQvKXS1fEF9t9dPKfs9q9N+++HMfcyfdNJd96s/4qy57Xi7gTj3sFfy9CsjiaUh50Ys
	ysWwRMwZTVkN87EiScptI2CpM1iKCvsVOyRbEO9eRhx92GzpeiqtcyL58HWQU9wXk/3W8SU8ItQ
	PWH6bGZxhSEnquZtTVHC8QTsbhN8zPKpUGLp9YtEVjBMWaQub6KckOngjaJDHbrfMbozA4KFkld
	ZEU9EUopfQyn5z8vRBmD6uwuyWnxGLqnEE1XCFj8CgP2ihthaKLE2GYnHky0ef7ZuCvzEIA4fxY
	hp3+X5QhlBmavbZwEgqdcNyO+u1buaK+UE8D/vAeHs4o9sFDeg2JZwdlD4OhLjGJQ6b6Hk8g/+T
	HLMd3xS+O5lyYbbQhFbSjBgoUIjKsZPmYRQVKeJr38dnfVItJT+4S9akGnNUgU6IQ==
X-Received: by 2002:a05:6820:1623:b0:6a3:1dc5:3570 with SMTP id 006d021491bc7-6b6fdac419amr8644519eaf.31.1788641289753;
        Sat, 05 Sep 2026 13:48:09 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:73::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6b6dcb85657sm6928741eaf.7.2026.09.05.13.48.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Sep 2026 13:48:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 05 Sep 2026 13:48:08 -0700
Message-Id: <DL7OF45PMXXL.M40Z5M90EVCF@gmail.com>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Andrii Nakryiko"
 <andrii@kernel.org>, "Daniel Borkmann" <daniel@iogearbox.net>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Emil Tsalapatis" <emil@etsalapatis.com>,
 "Nicholas Carlini" <npc@anthropic.com>, <kkd@meta.com>,
 <kernel-team@meta.com>
Subject: Re: [PATCH bpf v2 3/7] selftests/bpf: Test packet pointer class
 displacement pruning
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>, <bpf@vger.kernel.org>
X-Mailer: aerc
References: <20260905083418.3723623-1-memxor@gmail.com>
 <20260905083418.3723623-4-memxor@gmail.com>
In-Reply-To: <20260905083418.3723623-4-memxor@gmail.com>

On Sat Sep 5, 2026 at 1:34 AM PDT, Kumar Kartikeya Dwivedi wrote:
> Add two paths whose packet pointer ranges are individually compatible at
> a join but whose members have different relative displacements. The first
> path proves an eight-byte access through one member. On the second path,
> the same guard only proves that the access starts before data_end.
>
> An affected verifier prunes the second path and accepts the program. With
> packet pointer class displacement preserved, it explores that path and
> rejects the out-of-bounds access.
>
> Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
> ---
>  .../progs/verifier_xdp_direct_packet_access.c | 44 +++++++++++++++++++
>  1 file changed, 44 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet=
_access.c b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_ac=
cess.c
> index 0b86d95a4133..692a8468f3d7 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access=
.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_xdp_direct_packet_access=
.c
> @@ -5,6 +5,50 @@
>  #include <bpf/bpf_helpers.h>
>  #include "bpf_misc.h"
> =20
> +SEC("xdp")
> +__description("XDP pkt regsafe preserves packet pointer class displaceme=
nt")
> +__failure __msg("R2 min value is outside of the allowed memory range")
> +__flag(BPF_F_ANY_ALIGNMENT)
> +__naked void pkt_regsafe_class_displacement(void)
> +{
> +	asm volatile ("\
> +	r8 =3D *(u32 *)(r1 + %[xdp_md_data_end]);\
> +	r9 =3D *(u32 *)(r1 + %[xdp_md_data]);\
> +	r6 =3D r9;\
> +	r6 +=3D 8;\
> +	if r6 > r8 goto l_exit_%=3D;\
> +	r0 =3D *(u64 *)(r9 + 0);\
> +	r4 =3D r0;\
> +	r4 &=3D 15;\
> +	r7 =3D r0;\
> +	r7 >>=3D 63;\
> +	if r7 !=3D 0 goto l_path_b_%=3D;\

why all the loads and math? Are they meaningful for the test?
I suspect the test can be reduced in half.

> +	r2 =3D r9;\
> +	r2 +=3D r4;\
> +	r3 =3D r2;\
> +	r3 +=3D 4;\
> +	goto l_join_%=3D;\
> +l_path_b_%=3D: \
> +	r4 &=3D 3;\
> +	r4 +=3D 8;\
> +	r2 =3D r9;\
> +	r2 +=3D r4;\
> +	r3 =3D r2;\
> +	r3 -=3D 4;\
> +l_join_%=3D: \
> +	r5 =3D r3;\
> +	r5 +=3D 4;\
> +	if r5 > r8 goto l_exit_%=3D;\
> +	r0 =3D *(u64 *)(r2 + 0);\
> +l_exit_%=3D: \
> +	r0 =3D 0;\
> +	exit;\
> +"	:
> +	: __imm_const(xdp_md_data, offsetof(struct xdp_md, data)),
> +	  __imm_const(xdp_md_data_end, offsetof(struct xdp_md, data_end))
> +	: __clobber_all);
> +}
> +
>  SEC("xdp")
>  __description("XDP pkt read, pkt_end mangling, bad access 1")
>  __failure __msg("R3 pointer arithmetic on pkt_end")

