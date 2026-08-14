Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AEAA3B3883
	for <bpf@vger.kernel.org>; Fri, 14 Aug 2026 01:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786672236; cv=none; b=taLCT/P/L+/3J4dcLVVH8zMEbJBIlHhXA+es3Cy0yk2x4yBlf+OHl/rBwUP4tgA1NEtC2Q0UIBYrRj4YSbXvtNJGWBv2o/ExCVCOs7AKLoMJnD9pvMEyLy+Z+lFnPdkW8Ne9jUsBjl38kPGhO1rJdSVnXeybCEHQa+BZ8Kxmb+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786672236; c=relaxed/simple;
	bh=TGfi3FSGaYR+VkCwXqbDhPvlF20ZquA7guL97jLqgdg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sPbqUP0WjTTirMIFral8tyYpuxh04N3/dncSaaaVUh/+/9M4bza/0IB746PTrhMdQf0Ck3jNucsVRFQzNsroQ9Olj7gMOjnqael4lUyH+Lp7ytUaCbYFVu8SC1qnCdqNvCLZVr5PVQYPF+BWmIcemWYfwLCCzSYMl4VRwVa5p80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HGCCwyiw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HGCCwyiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDD381F000E9;
	Fri, 14 Aug 2026 01:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786672235;
	bh=jYvJRvAqIFSMYc+Z186DIiYM6mzY/ahMmf8xCUGKg6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HGCCwyiw/277RuyDfz/YMQH1m0iZ9QWITRxg8+ROwMRaxM+nRXwUFfAMOguNgvGTz
	 bTay8x3M/eO2aA6HOuVKXUg5DSTUrF/VywxgghLNsP7Vt8V/VTacWdmp7fmL2BiN9J
	 6EyDvX2svJceBIabs0+sIzv16d/jbKKIvkVj7Znti2Njz1Qp9hG6YeWpffZX5IsUxa
	 lHXTp4nz4825uH1R4JeccG0fqlpclEgO+AM4qV164XCSRpB4Cfehmou/JFZsA2+Efy
	 1pAK17RymCb/29/hFU7QK0BLg8G07WcI4qQQWRL643PLj7PuilFJUd4E40mUjB2ki3
	 lZ+qFgYKzUquw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v5 05/11] bpf: Account R2 of register-pair
 returns in live register analysis
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260813200235.1995574-1-yonghong.song@linux.dev>
References: <20260813200210.1991507-1-yonghong.song@linux.dev>
 <20260813200235.1995574-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 01:50:31 +0000
Message-Id: <20260814015034.EDD381F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Static (non-global) BPF subprograms returning a register pair are =
functionally broken because the verifier does not propagate R2 back to the =
caller frame.
--

--- Patch [5]: [PATCH bpf-next v5 05/11] bpf: Account R2 of register-pair r=
eturns in live register analysis ---
commit 35ab629244a73b2ad2baa7b7f0fd5b365c1b35e9
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Account R2 of register-pair returns in live register analysis

This commit updates the live register analysis to correctly mark R2 as read
at the BPF_EXIT of a subprogram that returns a register pair. This prevents
R2 from being considered dead and pruned incorrectly.

> diff --git a/kernel/bpf/liveness.c b/kernel/bpf/liveness.c
> index 74fc4b3f80d6e..71f998c6eb888 100644
> --- a/kernel/bpf/liveness.c
> +++ b/kernel/bpf/liveness.c
[ ... ]
> @@ -2191,7 +2193,7 @@ static void compute_insn_live_regs(struct bpf_verif=
ier_env *env,
>  			break;
>  		case BPF_EXIT:
>  			def =3D 0;
> -			use =3D r0;
> +			use =3D ret_reg_pair ? (r0 | r2) : r0;
>  			break;

[Severity: High]
This is a pre-existing issue, and wasn't introduced by this patch, but while
we are fixing liveness tracking for register-pair returns here, is the
propagation of R2 back to the caller missing in the verifier?

Looking at prepare_func_exit() in kernel/bpf/verifier.c:

    } else {
        /* return to the caller whatever r0 had in the callee */
        caller->regs[BPF_REG_0] =3D *r0;
    }

When a static BPF subprogram returning a 16-byte struct is called,
check_func_call() sets all caller-saved registers (including R2) to NOT_INI=
T.
When the callee exits, it seems we only copy BPF_REG_0 back to the
caller's state, leaving BPF_REG_2 as NOT_INIT.

If the caller attempts to read the second half of the returned struct in R2,
will the verifier reject it with an 'R2 !read_ok' error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813200210.1991=
507-1-yonghong.song@linux.dev?part=3D5
