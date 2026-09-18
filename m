Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365E751CF67;
	Fri, 18 Sep 2026 18:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755814; cv=none; b=MocHa8mMicf4Z8BDilmxv+p+Gajng59yS+/FvmbFtnLOZq4qkp3pnPlOYGwjGOp/yBbqhHxSNTKYFMzUwT2M2LUX2aHwxJEiBQT5ot4YIIuIv4+sT5R0pI3Risjld5W6CSOkzlvzogl6uTidqU9Te7yKiAR7hkC3gZaUOwntPi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755814; c=relaxed/simple;
	bh=v9QzBZRR/rsPC8cL/L499YoI9tzLVE1L+j/RF50vIGA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=CgMMXuokU3iAwLvqOuz9KJTC6DSOvihyYeH45KLIxX/sx4aCmishHre0uBb+6u7ciXLiKYTzf2aIkVSK1KOMfVYdtaRU32Z+UVGEY/7ZoN3UPf222ywmtgmKvryAu0dezcPZV99LbHg37HUj1MtLjbFkpz7/m8tv0/XrgNR5dtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjkrMvvM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjkrMvvM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C404C1F00898;
	Fri, 18 Sep 2026 18:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789755812;
	bh=iauEUtXSy+XwVmAgos5x1s9SmYPLjXW+NuFLuggjAMs=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=fjkrMvvMaq/Y7ifszl9uib5Fs8ev8rsOOMhiO/hf9/n+M69y6TX+eXLMWrsLjz9gx
	 6uVadPhssrHmFEBWvRdCqYb3HCL/JH2BOh2kX0iuSiMgrmrDAqQ5TGoy0VnzfBXQ4m
	 C2/bnjkJDFVDWI0P1GkuFpSCUVSQUZaMtlFNOHNNXSFSORQ9UjmMwLhQN3bUHcnDHl
	 74pOOqk11PFkgB1EDiBQ/DWDoSS72w4iFLsUIZBK/0n+K/V+M/Fnp8vEtlIAt2XLpJ
	 qxbMAl9uGeR/jQic1+wZovLmHcz6N7Bxq7N7ELgEtjDtK0b7UXV0BxpY4puhwfybCp
	 qS5nF3vw8fjTQ==
Content-Type: multipart/mixed; boundary="===============0751353136014118925=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1849fead1d504dc0df3da3fdc274efb9b21ffb0007ca5e42090d5180a7f94c56@mail.kernel.org>
In-Reply-To: <20260918172407.3459188-2-sh_def@163.com>
References: <20260918172407.3459188-2-sh_def@163.com>
Subject: Re: [PATCH bpf 1/3] bpf: Report BPF_F_PREORDER in cgroup program queries
From: bot+bpf-ci@kernel.org
To: sh_def@163.com,bpf@vger.kernel.org,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com
Cc: yonghong.song@linux.dev,qmo@kernel.org,martin.lau@linux.dev,song@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,shuah@kernel.org,linux-kselftest@vger.kernel.org,linux-kernel@vger.kernel.org,sh_def@163.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Fri, 18 Sep 2026 18:23:31 +0000 (UTC)

--===============0751353136014118925==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 149672c76c49c..e7c7efa1baa75 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
> @@ -1353,19 +1353,19 @@ static int __cgroup_bpf_query(struct cgroup *cgrp, const union bpf_attr *attr,
>  				id = prog->aux->id;
>  				if (copy_to_user(prog_ids + i, &id, sizeof(id)))
>  					return -EFAULT;
> +				if (prog_attach_flags) {
> +					flags = cgrp->bpf.flags[atype] |
> +						(pl->flags & BPF_F_PREORDER);
> +					if (copy_to_user(prog_attach_flags + i,
> +							 &flags, sizeof(flags)))
> +						return -EFAULT;
> +				}
>  				if (++i == cnt)
>  					break;
>  			}
>
> -			if (prog_attach_flags) {
> -				flags = cgrp->bpf.flags[atype];
> -
> -				for (i = 0; i < cnt; i++)
> -					if (copy_to_user(prog_attach_flags + i,
> -							 &flags, sizeof(flags)))
> -						return -EFAULT;
> +			if (prog_attach_flags)
>  				prog_attach_flags += cnt;
> -			}
>  		}
>
>  		prog_ids += cnt;

This changes BPF_PROG_QUERY to report a new flag value (BPF_F_PREORDER)
that was never reported before. Could this cause compatibility issues
with the stable backport?

Before this patch, prog_attach_flags[i] could only contain
BPF_F_ALLOW_OVERRIDE (0x1) and BPF_F_ALLOW_MULTI (0x2). After this patch,
it can additionally carry BPF_F_PREORDER (0x40), producing new values 0x40
and 0x42 where 0x00/0x02 appeared before.

Existing in-tree userspace does exact-match formatting on these values.
tools/bpf/bpftool/cgroup.c, show_attached_bpf_progs(), before commit
2af5b738880b2 (the third commit in this series):

    attach_flags = prog_attach_flags[iter] ?: p.attach_flags;

    switch (attach_flags) {
    case BPF_F_ALLOW_MULTI:
            attach_flags_str = "multi";
            break;
    case BPF_F_ALLOW_OVERRIDE:
            attach_flags_str = "override";
            break;
    case 0:
            attach_flags_str = "";
            break;
    default:
            snprintf(buf, sizeof(buf), "unknown(%x)", attach_flags);
            attach_flags_str = buf;
    }

The series' third commit documents the fallout: bpftool displays
"unknown(40)" when BPF_F_PREORDER is present alone, or "unknown(42)" when
combined with BPF_F_ALLOW_MULTI.

Within this series that is resolved (bpftool is fixed in commit 3), but
the tagging creates an asymmetry: this commit carries Fixes: 4b82b181a26c
(v6.15) which drives stable selection, while neither the selftest nor the
bpftool commit carries a Fixes: tag or stable Cc.

A stable backport of this commit alone would land the new query output on
a stable tree whose bpftool still has the exact-match switch, turning
bpftool cgroup show output from "multi" into "unknown(42)" for pre-ordered
attachments. The same skew applies to any distro bpftool older than
commit 3.

Should the Fixes: tag be dropped, or should the bpftool commit also carry
the same Fixes: tag so the two are backported together?

Also, the commit message does not state that BPF_PROG_QUERY starts
returning a previously-unreported bit in prog_attach_flags[]. Could that
compatibility fact be stated explicitly for reviewers?

---

Alexei Starovoitov raised a concern about the Fixes tag and target tree.
Alexei noted that this is not a bug fix but a user-space API change, and
existing bpftool will display "unknown(42)" for programs with
BPF_F_PREORDER. The suggestion was to target bpf-next (not bpf) and drop
the Fixes tag to prevent backporting to stable kernels.

Should this series target bpf-next instead of bpf, and should the Fixes
tag be removed?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/35376083935
--===============0751353136014118925==--
