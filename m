Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795449879;
	b=CxXjfDIKuDHTDEGvHotnFT+B5JphKECNz2sodJmKpuAx+es96nMwgEdo+f/wiDib1zYW
	 HS9hkbxYinNZKYIJDK8dtBLakZAuYYEqTh2P1pV8DfpzRc1+mySg1tRT1KdlKfIzJUJZ1
	 Wc1OTVcqjlUUQbdcDcmsI9+RJCu3GLQEjfUW7w1YuKDi+il9+/NzQc0Y3dfFQlwE8DNR+
	 Ef151FyHowD322ldSCfV7/yQAyo3L2kZgz5cpGztj8/utHPzvfNWLiUdc99AYjtnt4MTa
	 n3POj//7A04SmQLOKhM7Bm1VCx75lp5cRN+uaIdfwuZ0HNHyLKepo/2d4abmeAMvVWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795449879;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=I9Jr6YJmZs8nZfgXSXnYWzj0Ncur09tzU0MWm7x5IHY=;
	b=BMVPNbY/FWCZPTD3Lg9461AUSQAVXVOreR2wP3vqoPSV7fjYwaEqbQeLAvHzvLgwBR7s
	 2rIz9O2TFz2ZQmFLoOmvUP9DDhNnX6vfs8J0BYNZUISnmTau1OY4lujzo/ywgz8selHJ+
	 AKUTaSszqKvgYqi1baMv3KyX+wACssg2QgJgOe3MjgoGQYzZ2xYlZ0HhCSSL1IxsKvhZi
	 jzzWjcMEdBqOABdGNcg81xGetxUNkXOM5Ejxdtc8nvR8EfwAbmMsfZDffvqinTgOZyWGk
	 P9JRTmWCUGBFvrnEB9Xa61AdP5lUnSBDIirx6j3y42dmxI7cw8AbvqSuw+efsJqJP2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCN1Gvo3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B2606A321;
	Mon, 23 Nov 2026 16:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CCN1Gvo3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F3F1F000EC;
	Mon, 23 Nov 2026 16:04:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795449879;
	bh=I9Jr6YJmZs8nZfgXSXnYWzj0Ncur09tzU0MWm7x5IHY=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=CCN1Gvo3r9pr0aSe8ti+33UGqAzGCha4Q8iB1Mr+LTZacvm8nm6Nqkv+ct5AeQHvU
	 uoYDgK553wECjJ7UvAMuvNYMqhMay4tU9VnzwV6f0xPTwLvVdsUKfPOx1Qgcn+K+Is
	 EuQHWWuNUIHrALPzWwvPPIyd/tVIhMzfJiM9Jh2sWOhUWRpFRPBZx2QL7QCOIpvrm2
	 MDH+q8nTLYuSLF9zqaM9JDNXBjQa5YZ7f51nmvUwfm/JaD/ig7kqYm+n9kf7Z95xqD
	 DhVpdAOh14js36nf3Lor+mmOWC/Yg9ylZMvGCuT/LmHKrqCz3aRmsZf7rCVQj0XPkM
	 N2Bt6T1Dw+sLg==
Content-Type: multipart/mixed; boundary="===============7517899553110599387=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <ec5343ff7b660c9126b72574cd89cbd54772bd4291d4af16f1b9e39f16939398@mail.kernel.org>
In-Reply-To: <20261123152743.19629-5-leon.hwang@linux.dev>
References: <20261123152743.19629-5-leon.hwang@linux.dev>
Subject: Re: [PATCH bpf-next v3 4/9] bpf: Add log support for cgroup prog link_create
From: bot+bpf-ci@kernel.org
To: leon.hwang@linux.dev,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,john.fastabend@gmail.com,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,martin.lau@linux.dev,song@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,rostedt@goodmis.org,mhiramat@kernel.org,mathieu.desnoyers@efficios.com,kpsingh@kernel.org,matt@bobrowski.net,shuah@kernel.org,leon.hwang@linux.dev,linux-kernel@vger.kernel.org,linux-trace-kernel@vger.kernel.org,linux-kselftest@vger.kernel.org,netdev@vger.kernel.org,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Mon, 23 Nov 2026 16:04:36 +0000 (UTC)

--===============7517899553110599387==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add log support for cgroup prog link_create

TL;DR: The new bpf_log() calls in cgroup attach run under cgroup_mutex and
cgroup_bpf_mutex, so a copy_to_user() fault on the user log buffer may stall
other cgroup operations. Consider logging after unlock.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c

[ ... ]

> @@ -1045,23 +1060,33 @@ static int __cgroup_bpf_attach(struct cgroup *cgrp,
>  	atype = bpf_cgroup_atype_find(type, new_prog->aux->attach_btf_id);
>  	if (atype < 0)
>  		return -EINVAL;
> -	if (revision && revision != cgrp->bpf.revisions[atype])
> +	if (revision && revision != cgrp->bpf.revisions[atype]) {
> +		bpf_log(log, "Cgroup revision mismatch: expected %llu, actual %llu.\n",
> +			revision, cgrp->bpf.revisions[atype]);
>  		return -ESTALE;
> +	}

[ ... ]

> @@ -1143,13 +1168,14 @@ static int cgroup_bpf_attach(struct cgroup *cgrp,
>  	cgroup_bpf_lock_hierarchy();
>  	ret = __cgroup_bpf_attach(cgrp, prog, replace_prog, link, type, flags,
> -				  id_or_fd, revision);
> +				  id_or_fd, revision, log);
>  	cgroup_bpf_unlock_hierarchy();
>  	return ret;

Can these bpf_log() calls block other cgroup users while the locks are
held?

cgroup_bpf_attach() takes cgroup_mutex and cgroup_bpf_mutex through
cgroup_bpf_lock_hierarchy() before calling __cgroup_bpf_attach(), and
the new messages are emitted from inside it (and from get_prog_list()
via insert_pl_to_hlist()):

cgroup_bpf_attach()
  cgroup_bpf_lock_hierarchy()
  __cgroup_bpf_attach()
    bpf_log()
      bpf_verifier_vlog()
        copy_to_user(log->ubuf + ..., log->kbuf, ...)

log->ubuf is the user supplied log_buf, so if that page is not resident
(swapped out, or backed by FUSE or userfaultfd), copy_to_user() can sleep
in the fault for as long as the caller chooses.  While it sleeps,
cgroup_mutex and cgroup_bpf_mutex remain held, so cgroup mkdir/rmdir,
migration, BPF attach/detach, BPF_PROG_QUERY and the cgroup bpf release
work would all wait.

Commit 40aec6bab02e ("bpf, cgroup: Protect cgroup_bpf state with its own
mutex") split these paths out from cgroup_mutex to avoid hung tasks, and
before this patch the attach path did not touch user memory under these
locks.

This isn't a lock ordering problem, since cgroup_mutex -> mmap_lock
already exists, but would it be better to record the message and emit it
from cgroup_bpf_link_attach() after cgroup_bpf_unlock_hierarchy()?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/45209424655
--===============7517899553110599387==--
