Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12C561FCE;
	Mon,  7 Sep 2026 02:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788748574; cv=none; b=klfxDK7dDxZIlkAl2QdLzhDh2O9rDcXaGImrYjE0faAHSW/mpeI5O6abmY7qUfxkIaYln4ja22kL2dqXV7tazYuFtn+o4IYaHuUvB5lLxXAKTcwSyL18a1SKtvcC0shoMUA/EKuba5si/bXqms4vDvekaq1PyR00bP3W/va4Oxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788748574; c=relaxed/simple;
	bh=PKjgGL7wqRSAIYcUtgZTni3j/REQVBk4n4ke07d4vV8=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jDZtFZet/NzoEOYN9G4Xghy9DHtuf8/o4vdaB2dx0nxZgS1ZOQRfLML7WM+ibsAIksdm9laqQqnkCGVuivAO2Zv380f76dYN1X4Ajbl+eEV96jNJb98oznXlBT8YMjq8aAPP5IUTA/uV6d9TeH6C191WDJWRhmq36ZJckkC32js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/PB0F6u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/PB0F6u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E42E1F00A3A;
	Mon,  7 Sep 2026 02:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788748573;
	bh=bTtpSexXUEzx8fR/jzDmJs1dEgtp2NCHWJDwbujXQII=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=F/PB0F6uom0UGqRVbUvDEwzudZDEdCFLpmrSJ9UmPydFRGlcx2BdesSIvFE7yk1tE
	 InH6Q/jnWA2tyw4kU7RmWoyVa3hg8V7mTXMe2F9QLzwqbACwN6xe0V6318WGUDvrdx
	 r/W/U8VcOPe4139iuuQO6ZsElcHbVm8LTat/jj+77Iuq/vGnPBfZk1Ky7HgOjGBEin
	 TxZc8qf1MAD9ZilFXuCV3GquE4cegvQvHE6jD6bVTzt76uAw1R6Pulw1m1z6jPLfd5
	 lxfUAHJIoKTcc6YGxABuEqHXa9Hldutc12veaFuU13SCYcQQJyObXFgzoJ080KrdnF
	 a9a8phjdW2fpQ==
Content-Type: multipart/mixed; boundary="===============4744973200865761988=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <514a0c26ff5e0322fe0442d07142cafc7dda338a3ce2c5b7e9437dd994cb0ba1@mail.kernel.org>
In-Reply-To: <20260907015003.65087-2-sanghyun.park.cnu@gmail.com>
References: <20260907015003.65087-2-sanghyun.park.cnu@gmail.com>
Subject: Re: [PATCH bpf-next v6 1/2] bpf: Validate program attach type during link update
From: bot+bpf-ci@kernel.org
To: sanghyun.park.cnu@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,bpf@vger.kernel.org
Cc: sanghyun.park.cnu@gmail.com,leon.hwang@linux.dev,john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,sdf@fomichev.me,pulehui@huawei.com,suchitkarunakaran@gmail.com,xukuohai@huawei.com,linux-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon,  7 Sep 2026 02:36:12 +0000 (UTC)

--===============4744973200865761988==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index c7bc9ba9b331..b394a37eecb4 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -4481,14 +4481,9 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
>  	case BPF_PROG_TYPE_CGROUP_SOCK_ADDR:
>  	case BPF_PROG_TYPE_CGROUP_SOCKOPT:
>  	case BPF_PROG_TYPE_SK_LOOKUP:
> +	case BPF_PROG_TYPE_LSM:
>  		return attach_type == prog->expected_attach_type ? 0 : -EINVAL;

Does adding BPF_PROG_TYPE_LSM to this arm also relax the check on the
BPF_LINK_CREATE path?

Before this patch, BPF_PROG_TYPE_LSM fell into the default arm:

	default:
		ptype = attach_type_to_prog_type(attach_type);
		if (ptype == BPF_PROG_TYPE_UNSPEC || ptype != prog->type)
			return -EINVAL;
		return 0;

Since attach_type_to_prog_type() returns BPF_PROG_TYPE_LSM only for
BPF_LSM_MAC and BPF_LSM_CGROUP (kernel/bpf/syscall.c:4457, 4463), an LSM
program could only ever be accepted for those two attach types.

The new arm drops that constraint and accepts any attach_type as long as it
equals prog->expected_attach_type. The other members of that arm are safe
because bpf_prog_load_check_attach() restricts their expected_attach_type
to a set that all maps back to the same prog type. BPF_PROG_TYPE_LSM is the
one type in that arm with no such restriction: bpf_prog_load_check_attach()
(kernel/bpf/syscall.c:2766 onwards) has no LSM case and falls into
`default: return 0`, so prog->expected_attach_type is entirely
userspace-controlled for LSM programs.

An LSM program can be loaded with expected_attach_type == BPF_TRACE_ITER
and attach_btf_id pointing at a bpf_iter_* function, because
check_attach_btf_id() takes the ITER shortcut before the LSM-specific
validation (kernel/bpf/verifier.c:20810-20819):

	if (prog->expected_attach_type == BPF_TRACE_RAW_TP) {
		prog->aux->attach_btf_trace = true;
		return 0;
	} else if (prog->expected_attach_type == BPF_TRACE_ITER) {
		return bpf_iter_prog_supported(prog);
	}

	if (prog->type == BPF_PROG_TYPE_LSM) {
		ret = bpf_lsm_verify_prog(&env->log, prog);

bpf_check_attach_target()'s `case BPF_TRACE_ITER:` (kernel/bpf/verifier.c:
20551) and bpf_iter_prog_supported() (kernel/bpf/bpf_iter.c:337) both
switch on expected_attach_type only and never look at prog->type, so the
load succeeds and bpf_lsm_verify_prog() never runs.

Post-patch, BPF_LINK_CREATE with attach_type == BPF_TRACE_ITER then
succeeds for that program. link_create() fetches the prog with plain
bpf_prog_get() (no type filter, kernel/bpf/syscall.c:5813), so
bpf_prog_attach_check_perm() is the only prog_type/attach_type gate; it now
returns 0, and the `case BPF_PROG_TYPE_LSM: case BPF_PROG_TYPE_TRACING:`
arm dispatches to bpf_iter_link_attach() (kernel/bpf/syscall.c:5847), which
also performs no prog->type check. The result is a live BPF_LINK_TYPE_ITER
link holding a BPF_PROG_TYPE_LSM program. Pre-patch this returned -EINVAL.

BPF_PROG_ATTACH is not affected, because bpf_prog_attach() still calls
bpf_prog_get_type(attr->attach_bpf_fd,
attach_type_to_prog_type(attr->attach_type)) before the check. BPF_TRACE_ITER
is also the only newly-permitted attach type that lacks a downstream
prog->type guard: RAW_TP, FENTRY, FEXIT, FSESSION and MODIFY_RETURN all
funnel into bpf_tracing_prog_attach(), which rejects
`prog->expected_attach_type != BPF_LSM_MAC` for LSM programs
(kernel/bpf/syscall.c:3663), and the *_MULTI types cannot be loaded for
LSM at all.

Could this be tightened to keep the mapping constraint for LSM?  For
example, handle BPF_PROG_TYPE_LSM like BPF_PROG_TYPE_CGROUP_SKB does:
verify attach_type_to_prog_type(attach_type) == prog->type first, then
compare expected_attach_type.

>  	case BPF_PROG_TYPE_CGROUP_SKB:
> -		if (!bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
> -			/* cg-skb progs can be loaded by unpriv user.
> -			 * check permissions at attach time.
> -			 */
> -			return -EPERM;
> -
>  		ptype = attach_type_to_prog_type(attach_type);
>  		if (prog->type != ptype)
>  			return -EINVAL;

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/34074783015
--===============4744973200865761988==--
