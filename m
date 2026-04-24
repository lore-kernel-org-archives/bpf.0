Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F312BE65F
	for <bpf@vger.kernel.org>; Fri, 24 Apr 2026 03:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777001872; cv=none; b=a2n6oLpPJz+bbyfrBP2u3Z3hmMNrctGAJgcxoQQsRRhL0Y8s+/TTs9JKq8jEFwpwhP6ryP7xuJ9j/Jqa5ayItL5wENexbDGR9lBKfZ25+oUc9yHrj+O++An+zzQxXfIt46jM+S09DdVhiQNQg8Uynz3/c6X2VF6dPRzbQQNKifM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777001872; c=relaxed/simple;
	bh=8wPeNFKf8GcZqOXwfNdWa0IKml4/HEqFnepOeSan1lU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZTUOjA0NKA6/obBlDy40yihTfhCMvjIgxy0TJ1FNw4OqOz6vazmkHKZMlNAqSXzCBcCH75UoM/5iStnCCKnRA6KhNNK0H5mp+14vg6LRQWOsqxvoezAcuWivNc85a3cSHa1ILzPQHKvoYQP63xwcF7j4ZqABN6XqetkIWaNydrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mEc/jxXs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mEc/jxXs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F76BC19425;
	Fri, 24 Apr 2026 03:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777001872;
	bh=8wPeNFKf8GcZqOXwfNdWa0IKml4/HEqFnepOeSan1lU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=mEc/jxXsJleP7fjdUFRrbFeRNKnVcdOJEz6jumrGZSqFBr7D5G6ak7sxYY0jIWE/m
	 XmJjdbVrdtuez4uplqusldB3RkMqvPg3jt7h/XuAR4Ti1LSKEqckuqPQMpeQlTKu3s
	 kDunG06jN8HxH18aXwNx37wFZdYXGmgQil6tlyO7YsdCxlDgWyjHSFn0TL4pBCScHi
	 PTVvOdZDeKX0fM/1K2LZ2rngYxTs2nLcMPOiNCZfn0FhTsFMQiZzBYAfuG7AZzninc
	 TJZkX99gLfap87XClrlORl/6ljqA1LD4UB5JLHRhOkZ8X9pVgd4TdmcC4ndbe/fPo8
	 uHvcMTCL4cDmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf 2/2] bpf, netkit: reject offloaded programs on
 attach
Reply-To: sashiko@lists.linux.dev
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260423033609.252464-3-jiayuan.chen@linux.dev>
References: <20260423033609.252464-3-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 24 Apr 2026 03:37:51 +0000
Message-Id: <20260424033752.1F76BC19425@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [High] The patch prevents attaching offloaded programs during link creati=
on and program attach, but fails to secure the link update path, allowing a=
 complete bypass of the fix.
--

commit 4b4a6a3785c138df3a0a76f92652aa68a0ea77d6
Author: Jiayuan Chen <jiayuan.chen@linux.dev>

bpf, netkit: reject offloaded programs on attach

This commit rejects offloaded BPF programs in netkit_prog_attach() and
netkit_link_attach() to prevent them from triggering a WARN in
bpf_prog_warn_on_exec() when executed on the software path.

> diff --git a/drivers/net/netkit.c b/drivers/net/netkit.c
> index 7b56a7ad7a496..d845a24c5915d 100644
> --- a/drivers/net/netkit.c
> +++ b/drivers/net/netkit.c

[ ... ]

> @@ -1000,6 +1003,9 @@ int netkit_link_attach(const union bpf_attr *attr, =
struct bpf_prog *prog)
>  	struct net_device *dev;
>  	int ret;
> =20
> +	if (bpf_prog_is_offloaded(prog->aux))
> +		return -EINVAL;
> +

Is it also necessary to reject offloaded programs in netkit_link_update()?

It looks like a user could bypass this fix by creating a netkit link with a
non-offloaded program, and then using BPF_LINK_UPDATE to replace it with an
offloaded program.

The netkit_link_update() callback directly passes the new program to
bpf_mprog_attach() without checking bpf_prog_is_offloaded():

static int netkit_link_update(struct bpf_link *link, struct bpf_prog *nprog,
			      struct bpf_prog *oprog)
{
	...
	ret =3D bpf_mprog_attach(entry, &entry_new, nprog, link, oprog,
			       BPF_F_REPLACE | BPF_F_ID,
			       link->prog->aux->id, 0);
	...
}

Note that tcx_link_update() in the earlier tcx fix appears to suffer from
the exact same omission.

>  	rtnl_lock();
>  	dev =3D netkit_dev_fetch(current->nsproxy->net_ns,
>  			       attr->link_create.target_ifindex,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260423033609.2524=
64-1-jiayuan.chen@linux.dev?part=3D2
