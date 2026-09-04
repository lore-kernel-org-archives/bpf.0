Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A9E3DAAC8
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 06:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788504478; cv=none; b=LudN7lH8KQeJxt29ESkdBx5ryIvxeInY8J9pap/L5bg6EB3sjFgE0d8CDxLt4/vR12Da0lNNCvnsN4orA8PlU1r8Ix1dqbccMI8doMMdQQz+UhX5c6YK2F5zvTfuZj2plgPsZ4e6GTIK5YLabEo3R0q90+w9UQazxuUTIipEKi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788504478; c=relaxed/simple;
	bh=Nfn/mAGw5wrfxN7ZCSRlKTYCEsbSUf70SRph7up/Z5U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=pJBGrNJ5YW7n0AqUTuBDMRibQZsGAY71uYWBxQWscbkVae0r51RAY18u/4MIzA8Aja7zxDeBDe+Kq9VN5fbdn4uGRDIxotsFM/tiK9Y7XEk4fLWulGJetHNrPOE4J4F/67oaGz8r/iaIgl1NQ4dd7DeK8ezbBhgr4xFSTalEhkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0+3UP7w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i0+3UP7w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222541F00A3D;
	Fri,  4 Sep 2026 06:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788504476;
	bh=Go/0a8r2V3xStm3so9DX45n28Jl0lOIwGjM5jlnlYgw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i0+3UP7wNJqjUWnGAYy9ajBKsM53l34iB+m/hfwmFsTiV2duwmEOR3GpfZlha6SxV
	 efpDrg0i/cnXj4266D7xpQsjO6na16SMDboL0Q88Qi+7EF1PuV5FD5K3gFz9h0dlb+
	 bKmGwJRjp/zcTrGt+XjRGM9S68NHmzSjQMTkrW+tSYktGEni9gyMJjgWqlBYUh5Yv6
	 QZW2R4K7VUpAd6zbBavqxs1M2U2+osYLrCVNobcQv+NaCZAtJV1ngzeKO/9P8c515Y
	 iUOsh9xVa6Cda9h8nvgz4CJGa43Mv6srvm9ZxFvxjOgOmj5Gp9vJEoVwlyrvsQrEoG
	 I1OZ9laH0cFRA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v1 2/8] selftests/bpf: Reject non-percpu values in
 percpu kptr fields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904063650.3877826-3-memxor@gmail.com>
References: <20260904063650.3877826-1-memxor@gmail.com>
 <20260904063650.3877826-3-memxor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 06:47:55 +0000
Message-Id: <20260904064756.222541F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Newly introduced selftests assert on incomplete verifier error mess=
ages, cementing a preexisting verifier logging bug and making the tests bri=
ttle.
--

commit ecbf9b0933ebffdc896739df59e08ba01779b11c
Author: Kumar Kartikeya Dwivedi <memxor@gmail.com>

selftests/bpf: Reject non-percpu values in percpu kptr fields

This commit adds verifier coverage for the two ways a non-percpu pointer can
be stored in a __percpu_kptr field. It ensures that passing a program-BTF
local allocation or a referenced kernel-BTF task_struct pointer correctly
fails verification when MEM_PERCPU is required.

> diff --git a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c b/tool=
s/testing/selftests/bpf/progs/percpu_alloc_fail.c
> index 08379c3b6a038..3701f4ea58c75 100644
> --- a/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
> +++ b/tools/testing/selftests/bpf/progs/percpu_alloc_fail.c
[ ... ]
> @@ -137,6 +151,51 @@ int BPF_PROG(test_array_map_5)
>  	return 0;
>  }
> =20
> +SEC("?syscall")
> +__failure __msg("invalid kptr access, R2 type=3Dtrusted_ptr_ expected=3D=
ptr_task_struct")
> +int reject_kernel_ptr_into_percpu_kptr(void *ctx)

[Severity: Low]
Does this test hardcode an incomplete verifier error message resulting from=
 an
uninitialized reg_name in the verifier?

In map_kptr_match_type(), when triggering the MEM_PERCPU mismatch, the
verifier jumps to bad_type before reg_name is populated. This leaves the
struct name out of the output (e.g., outputting "type=3Dtrusted_ptr_" inste=
ad
of "type=3Dtrusted_ptr_task_struct").

If the verifier logging bug is fixed to properly include the struct name,
this substring match will break. Could the test be made robust against
verifier log improvements, or could the verifier fix be included?

> +{
> +	struct kernel_percpu_elem *e;
[ ... ]
> +	old =3D bpf_kptr_xchg(&e->task, p);
> +	if (old)
> +		bpf_task_release(old);
> +	return 0;
> +}
> +
> +SEC("?fentry.s/bpf_fentry_test1")
> +__failure __msg("invalid kptr access, R2 type=3Dptr_ expected=3Dptr_val_=
t")
> +int BPF_PROG(reject_plain_alloc_into_percpu_kptr)

[Severity: Low]
Similarly, does this assertion also rely on the incomplete verifier string
(expecting "type=3Dptr_" instead of "type=3Dptr_val_t")?

> +{
> +	struct val_t __percpu_kptr *old;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904063650.3877=
826-1-memxor@gmail.com?part=3D2
