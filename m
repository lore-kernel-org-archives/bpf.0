Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D81C2ECE93
	for <bpf@vger.kernel.org>; Mon,  6 Jul 2026 17:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783360058; cv=none; b=GFBEyN3uJkkd+uXSy5VH6F28t8iUDEqyebkm9PNHQkN7BgwoueW5PI2vmApe0plOSwMQoN+arkQ5a+AnO1i9kaUi1gBiHpOxIc2akFerunJ7KVxDnnfxtO3t1bXma4deP17bj2Q8hZZlfMmAzGOMjamy26dLLhsxTQYc5ZZ42sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783360058; c=relaxed/simple;
	bh=ow+O9E9XbAMzKubM4SOoTUqB+X24cx1f2dkudtH5sLI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YgyoQNJ/o01ZnTh5I7W3ZsVosWxOE6pWmD+H7l1zY8f8suF55nYSJ4YFgDvMo39EdGZeY0+657FxNQVbeMFAJBTyOcNoYZgbPGuqxi8ynxjLoqKMC6NA1LtofqHrK0Af/6ENC9l76Qvpd/m1EX3eT4N9amS5ydqgK3O8L1sZ6KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3odfC3/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3odfC3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9CB1F000E9;
	Mon,  6 Jul 2026 17:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783360057;
	bh=JkRH6U1jZBiiS43EF1OgH9v9yV5VTnQDEC5tpkQHyK0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=b3odfC3/trWtfrRzb1ePAb+kL1AmdldtfFdVkEuggjmA9X5ZJK6djA1W4lS2ek3qO
	 rg3HGK5TChSFGjThpR6pYWZoRcQUKBGJccV4gNMUF5qDqF6TocJmLtHqkxBqyVJGA6
	 a9RK6+kcZox6wlsgCK3mA9WwVlL/+niO6urzPTp9X2S9voBtQ7wfeG3fFoFRS7tb/U
	 iO8z1k/GLDFJ+NtZKvganeT7nm2bOzmxCFsCzdy2qGwiG/78C7E8r2W39im/Nd8DPQ
	 mwq2zSLjMq0vsA+R3ugqlhx1VbymLkuwGpGHTTBxlY/4XN0++QRxhskjkTtPBRhRIy
	 xJHqSzS0lEt0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 09/15] bpf: Add infrastructure to support
 attaching struct_ops to cgroups
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260706171918.317102-10-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
 <20260706171918.317102-10-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 17:47:36 +0000
Message-Id: <20260706174737.0C9CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] replace_effective_prog() computes a logical array index but uses i=
t as a physical index, overwriting the wrong program.
--

commit d4dcc595e5c89fd20e4539f0b30d115f2408a4a8
Author: Martin KaFai Lau <martin.lau@kernel.org>

bpf: Add infrastructure to support attaching struct_ops to cgroups

This patch adds the necessary infrastructure to attach a struct_ops map to a
cgroup. It creates a consistent expectation for attaching struct_ops to
cgroups across subsystems by reusing the existing bpf_cgroup_link and
handling struct_ops maps similarly to traditional program links.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 081d81de18163..745e826c9f615 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
[ ... ]
> @@ -2820,6 +2897,270 @@ const struct bpf_verifier_ops cg_sockopt_verifier=
_ops =3D {
[ ... ]
> +static int cgroup_struct_ops_link_update(struct bpf_link *link, struct b=
pf_map *new_map,
> +					 struct bpf_map *expected_old_map)
> +{
[ ... ]
> +	bpf_map_inc(new_map);
> +	WRITE_ONCE(cg_link->map, new_map);
> +	replace_effective_prog(cgrp, atype, pl);

[Severity: High]
This is a pre-existing issue, but does replace_effective_prog() risk
overwriting the wrong program in the physical items array?

In replace_effective_prog(), effective_prog_pos() returns a logical array
index based on the current hlist length, which is then used directly as a
physical index into the progs->items[] array:

kernel/bpf/cgroup.c:replace_effective_prog() {
    ...
    pos =3D effective_prog_pos(desc, atype, pl);
    ...
    item =3D &progs->items[pos];
    prog_list_replace_item(pl, item);
}

If a detach operation falls back to purge_effective_progs() (e.g., due to a
memory allocation failure in update_effective_progs()), it marks the detach=
ed
program's entry as a dummy without shifting elements, and removes it from
the hlist.

If another program is subsequently updated via BPF_PROG_ATTACH with
BPF_F_REPLACE, effective_prog_pos() calculates the target's logical index
based on the new, shorter hlist.

Using this logical index on the physical array could point to the dummy
element instead of the target program's actual slot.=20

Would this cause the update to overwrite the dummy, leaving both the new and
original programs to execute?

Should replace_effective_prog() skip dummy elements when indexing the
physical array to align the logical index with the physical position?

> +	bpf_map_put(old_map);
> +	cgrp->bpf.revisions[atype]++;
> +
> +out:
> +	cgroup_unlock();
> +	return err;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706171918.3171=
02-1-ameryhung@gmail.com?part=3D9
