Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9142F46DFF1;
	Fri, 21 Aug 2026 09:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305323; cv=none; b=ScVAsr4LsNOMn8BT3dABcXvMHG5DaWJ+S/HUraiw3Qh1SSEdkQ/J1SxCJgKRuh5+XcrMCFokBxtMJwD4PMPnh6NrsLJt/LqARVqcK9xTC5i67lLmnfSix8aDtn3vtwtjq0BhYTNWp8p++ZHAU35kIlfIxBWcTQU/njG8F/l08hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305323; c=relaxed/simple;
	bh=VeTcA5MwrGthUyG7cJEFRyk62o3fx96Kk0CLLwaSwzk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=EmxN+Y4Iz0J/bjUaBS0CkKNm5SeVRU5kt1yc+WSl5Q2ec29k0fdUrQjNJdSHT6XqwGHu5aaMW68jdf26C4ACSjk5L0Tp91z27truqXC2mW97AuEe16EF1YipTg8eufzs1/tQiJapGCIBs/rRJC7EQ0HNFhKhpEYcZ1VeAoGIJWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ap8G/tj4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ap8G/tj4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE1C1F000E9;
	Fri, 21 Aug 2026 09:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787305306;
	bh=9A+8A6s25n0SQ5fvtYxPTDpevpeVYgRWJJtH69nAFyU=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=Ap8G/tj4EcUTjQER6pk44eI4z2PXV9atIKHuOBNZMR9QuHnuXbeEE1JTG2+V9LngS
	 KWVZz+T6pG8jLKKO9ByLWBQql6Dj/+5mJexoVVMwN28F4VZChQhNijaAyuyODYei4C
	 GYHwQ0Yd96kIpez+GGh4YFd3aZorGsgOA7bLyxUd0jcOJIvWvd9mhYyfKXFLvsAteL
	 KO4L1H111tOTjo9lmdSSGyFKxhwrfAreBsHUnW8o/9fYJS5BZjp4jLBFDRJT41iBgy
	 PZcpTvJ3hi5G9d8e0gkjNUxJTrKoULauOfTHaiCjsSWRRF5VaG3fJ78sgsow2kIhu7
	 wcSHz3JNyjOow==
Content-Type: multipart/mixed; boundary="===============3203392408353547802=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <0cc1a9e0e2964114bdae810b0d9bb32f49c589e379ebcf4df07d02a3993467f8@mail.kernel.org>
In-Reply-To: <20260821084726.3769957-2-sanghyun.park.cnu@gmail.com>
References: <20260821084726.3769957-2-sanghyun.park.cnu@gmail.com>
Subject: Re: [PATCH bpf-next v3] bpf: Fix stack out-of-bounds write in cgroup link update
From: bot+bpf-ci@kernel.org
To: sanghyun.park.cnu@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,bpf@vger.kernel.org
Cc: sanghyun.park.cnu@gmail.com,leon.hwang@linux.dev,john.fastabend@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sdf@fomichev.me,pulehui@huawei.com,linux-kernel@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Fri, 21 Aug 2026 09:41:46 +0000 (UTC)

--===============3203392408353547802==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6874ba1424af..dfea337ff25e 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -4542,6 +4536,19 @@ static int bpf_prog_attach_check_attach_type(const struct bpf_prog *prog,
>  	}
>  }
>
> +static int bpf_prog_attach_check(const struct bpf_prog *prog,
> +				 enum bpf_attach_type attach_type)
> +{
> +	if (prog->type == BPF_PROG_TYPE_CGROUP_SKB &&
> +	    !bpf_token_capable(prog->aux->token, CAP_NET_ADMIN))
> +		/* cg-skb progs can be loaded by unpriv user.
> +		 * check permissions at attach time.
> +		 */
> +		return -EPERM;
> +
> +	return bpf_prog_attach_check_attach_type(prog, attach_type);
> +}
> +

This isn't a bug, but would a name that mentions the permission gate
read more clearly next to bpf_prog_attach_check_attach_type()?

The new helper bpf_prog_attach_check() sits near
bpf_prog_attach_check_attach_type() in the same file, and the two names
differ only by a suffix while the security-relevant difference is which
one enforces CAP_NET_ADMIN.

link_update() deliberately calls the longer-named, non-enforcing one
(bpf_prog_attach_check_attach_type), and bpf_prog_attach() plus
link_create() call the shorter, enforcing one (bpf_prog_attach_check).
A name like bpf_prog_attach_check_perm would make the choice at each of
the three call sites self-evident.

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/32466070697
--===============3203392408353547802==--
