Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FB025B0B7
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 03:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784519434; cv=none; b=SZyDjSm6Zs9qLCyFB6172enGxYYs3Svq1yHl4J4nZuzqPrd192LRQqtW1u/UQJJrS9dceHLGvg8shZrJnZZrE/Sgt1k+yH1CdbNjupaJLXZkXyaozpr882bm7GrRn2VI+mRiiWvs07kDPfm4DsNR/XEF9uyCvI3OlRWhUVxxfgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784519434; c=relaxed/simple;
	bh=/C1qGTd04vgqbx6HtbIjiFRhz8h4pAb3WGs8Z934LKU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Juu8EKH4Hw7vENDuJthVf2A84R0wnm0Ime/fmJLQ52O41plXxLH2uDYhlJQ+m/JiCukB7bZVlTszkr8vOsacyrDKRPMeId3sFXtftnOQfUSPae5YAymglGLl60+eFQVwClFAbbQf6GE9wHTHiKtyJawg/DotoadV85GFHLpVr7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBcOWQHU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBcOWQHU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C8021F00A3A;
	Mon, 20 Jul 2026 03:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784519432;
	bh=Ze7WjwCIMjWc1W7MXi+Ni0mfjcxJBAG+Yh08kNSZJ4w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NBcOWQHUkDH3t2gFnrKsZhubeDFd++DLV9NAXVnljh0FlVww+gbs13LH5axEhVbps
	 6UL4uqUNsbx//eqwBJONWvUJlTKQ82iSXQNOMkPtPwlXh6a4a/HR2xtfV6+k0QLUm8
	 T3OmMrXBMaw3puAT/hdh0ianw8P+UXaneOXcQF+FnkiP0re3/FS8pLsDPneFf4fHP7
	 0kcj7qFtYrIEAUnmPPcKYv8jDwv15qKpnpFpL8B0qUg/YUSW7SiDFAHdS4BtlKaMdQ
	 ytbAvkYhSXhU2GjxLQJ3fk0Kn5nWnC+tYzW5j5hCIVrM6U8KQYYcEnlhPrXbVddpzb
	 uAFwSAoK8PCqQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v3 1/3] bpf: Fix potential UAF when reading bpf link
 info
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720033055.1215477-2-pulehui@huaweicloud.com>
References: <20260720033055.1215477-1-pulehui@huaweicloud.com>
 <20260720033055.1215477-2-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 03:50:31 +0000
Message-Id: <20260720035032.6C8021F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] bpf_netns_link_update_prog checks link->prog locklessly, allowing =
a TOCTOU race that violates atomic replacement guarantees.
- [High] Concurrent BPF_LINK_UPDATE can race with bpf_mprog_link to cause a=
 Use-After-Free when dereferencing link->prog->type.
--

--- Patch [1]: [PATCH bpf v3 1/3] bpf: Fix potential UAF when reading bpf l=
ink info ---
commit 5b8e0ac8575ebc387f2ddc7dee211697bb704588
Author: Pu Lehui <pulehui@huawei.com>

bpf: Fix potential UAF when reading bpf link info

This commit addresses a potential Use-After-Free issue when accessing
link->prog without locks in bpf_link_show_fdinfo and bpf_link_get_info_by_f=
d.
It resolves the problem by acquiring both normal RCU and tasks trace RCU
read locks before dereferencing the program, preventing concurrent freeing
during bpf_link_update operations.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 6db306d23b479..2458c68146b95 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3490,13 +3491,23 @@ static void bpf_link_show_fdinfo(struct seq_file =
*m, struct file *filp)
>  	}
>  	seq_printf(m, "link_id:\t%u\n", link->id);
> =20
> +	/* prog can be sleepable */
> +	rcu_read_lock_trace();
> +	rcu_read_lock();
> +	prog =3D READ_ONCE(link->prog);

[Severity: High]
This isn't a bug introduced by this patch, but since you are fixing lockles=
s=20
dereferences of link->prog here, could a similar TOCTOU race happen in=20
bpf_netns_link_update_prog()?

kernel/bpf/net_namespace.c:bpf_netns_link_update_prog() {
    ...
	if (old_prog && old_prog !=3D link->prog)
		return -EPERM;
	if (new_prog->type !=3D link->prog->type)
		return -EINVAL;

	mutex_lock(&netns_bpf_mutex);
    ...
}

Two threads concurrently calling BPF_LINK_UPDATE on a netns link could both=
=20
evaluate the old_prog !=3D link->prog check locklessly and pass it. If they=
=20
acquire netns_bpf_mutex one after the other, would the second thread=20
blindly overwrite link->prog, overriding the first thread's update and=20
violating the BPF_F_REPLACE API contract?

[Severity: High]
This is also a pre-existing issue, but does a similar Use-After-Free race=20
exist in bpf_mprog_link()?

kernel/bpf/mprog.c:bpf_mprog_link() {
    ...
	if (type && link->prog->type !=3D type) {
		bpf_link_put(link);
		return -EINVAL;
	}
    ...
}

If a thread calls BPF_PROG_ATTACH on a tcx hook (holding the sleepable=20
rtnl_lock) and supplies a relative_fd pointing to a netns link,=20
bpf_mprog_link() executes without an RCU read-side critical section.

Could this thread be preempted, allowing a concurrent BPF_LINK_UPDATE on=20
the same netns link to replace and free link->prog? When the first thread=20
resumes, it would dereference link->prog->type where link->prog now points=
=20
to freed memory.

>  	if (prog) {
>  		bin2hex(prog_tag, prog->tag, sizeof(prog->tag));
> +		prog_id =3D prog->aux->id;
> +	}
> +	rcu_read_unlock();
> +	rcu_read_unlock_trace();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720033055.1215=
477-1-pulehui@huaweicloud.com?part=3D1
