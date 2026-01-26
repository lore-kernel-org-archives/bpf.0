Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E7834C808
	for <bpf@vger.kernel.org>; Mon, 26 Jan 2026 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448207; cv=none; b=I8Z2/wBczvg90jNxUG0mEnIqBRM2QMmdcwG+pmh/lfPpbdj7Qmn6LD8G5p8a+N31plfyP4ZOQVRyj+IQfu9qjmcB5SgmINipHVf4rft38Unn7Ss3GX8wmasGYEM6UeHFjG0ffVY7I7HiUWwmz/t/PfKDuUwNYVsNzGjpLVQ0mnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448207; c=relaxed/simple;
	bh=a61Rv5nLvD5l5KkbbwW7hFpNTrf/agcjWG5ZkmQoNHI=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=toU5bIc8E8FJ9Lk0hhz7gO5x+G8OVZqGSaEu/hzfipshAXsOyxpkAfSj/LKhioqwT0W8xJQfR9u2mQDqa2szgARVWx0QmKYxwFiiGsZ1U/GKFVYeoonFseKATlvg4u69/aKm0YAIOTj8EZLm1tS9jH55A3a7HOISttrwUo2SwbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VaohyIin; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VaohyIin"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342BBC116C6;
	Mon, 26 Jan 2026 17:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769448206;
	bh=a61Rv5nLvD5l5KkbbwW7hFpNTrf/agcjWG5ZkmQoNHI=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=VaohyIinvinm5+xWHDGrAtEJwiUjCtLadY3CEATXPDaLL04oQa4+R1FqmQgilBE6O
	 IuTyIJvXzfTTKklstHoRqKHc/u27ADbhvtaNXUktWudiYiAeywVqsZrIGxQOQDAWf7
	 zqEkKc++dIOU7tw0xxgu853kwQIjaKYRsOaj8m2fiWUbgVV0QGns/xcJWXx5bmPKnH
	 eI2rppUGndiOaO73KuZBGwEY06IMjNxpciypQeunleky4c5CvaGO/K7bt2ql4oopS4
	 xuorWetvXEQACGMhx9Y+Za/ZcyaCgMy1sJJluDq+x5K5T7Fnto0N+Qki4LXws+H1zy
	 4UW+c+B++qKGQ==
Content-Type: multipart/mixed; boundary="===============2719241576939665696=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <d269a9b8946d21a9f93724baa6ed06e9873e8c13890902ff09e201a89c727804@mail.kernel.org>
In-Reply-To: <20260126170731.16321-1-ggonnet.linux@gmail.com>
References: <20260126170731.16321-1-ggonnet.linux@gmail.com>
Subject: Re: [PATCH bpf] bpf: fix TCX/netkit detach permissions when prog FD isn't given
From: bot+bpf-ci@kernel.org
To: ggonnet.linux@gmail.com,daniel@iogearbox.net
Cc: ast@kernel.org,bpf@vger.kernel.org,ggonnet.linux@gmail.com,john.fastabend@gmail.com,martin.lau@linux.dev,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 26 Jan 2026 17:23:26 +0000 (UTC)

--===============2719241576939665696==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 4ff82144f885..9796fe5b9ab5 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c

[ ... ]

> @@ -4565,6 +4560,8 @@ static int bpf_prog_detach(const union bpf_attr *attr)
>  			prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
>  			if (IS_ERR(prog))
>  				return PTR_ERR(prog);
> +		} else if (!bpf_mprog_detach_empty(ptype))
> +			return -EPERM;
>  		}
>  	} else if (is_cgroup_prog_type(ptype, 0, false)) {

There appears to be a brace mismatch here that would prevent compilation.

The original code structure was:

    if (attr->attach_bpf_fd) {
        prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
        if (IS_ERR(prog))
            return PTR_ERR(prog);
    }

The closing brace on its own line closed the if (attr->attach_bpf_fd) block.

After this patch, the else-if clause closes that if block, but the original
closing brace remains as a dangling brace:

    if (attr->attach_bpf_fd) {
        prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
        if (IS_ERR(prog))
            return PTR_ERR(prog);
    } else if (!bpf_mprog_detach_empty(ptype))
        return -EPERM;
    }  <-- this brace has nothing to close

This creates a mismatch where there are two opening braces (outer
bpf_mprog_supported and inner attr->attach_bpf_fd) but three closing
constructs.

Was this patch tested to compile? The fix would be to remove the dangling
closing brace on the context line, resulting in:

    if (attr->attach_bpf_fd) {
        prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
        if (IS_ERR(prog))
            return PTR_ERR(prog);
    } else if (!bpf_mprog_detach_empty(ptype))
        return -EPERM;


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21366799473

--===============2719241576939665696==--
