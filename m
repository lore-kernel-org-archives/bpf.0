Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1170334D385
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 08:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781857861; cv=none; b=sIWE+UeGhydtrueLWerMVTTNbhw0kLjhOVdxx+ZHgQeaBP7wcJxfSd//W1ubb+E2RFPA7BlzryImvTNFlFpPy4MAnSoytAzsIUv1KOE0CY+Q4OLnEXyV8D28HO2xXK3WtEomMwLosGa1uT6E6RBMwFFhYUXqVuevBuCekbfYpmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781857861; c=relaxed/simple;
	bh=MzP2SJQm41disgu1F5DLjgUW0NXcf1kPeCEpR50nHQM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iNRyWzOL1RqwLHNOBqzIMOuosKAmn533yfNYogSyHS0mHTfKueXtm6arlrxeI53EUAiMqQlymVwa6PeyG+ARyJZ2Qwv9TymCV8dfsFaltu1E0j19BGgeG9uhdsXz2uwvtxkQTc8g7/sjd8OCByKozkVpnBcwzydq96hbq1FOEMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNQzWAd/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNQzWAd/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 985F21F000E9;
	Fri, 19 Jun 2026 08:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781857859;
	bh=i+P4O+nVuf8VvQPLR09Oa3sGFx75KJdc6vJb1lMvysM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QNQzWAd/VLbMoTfqq7bfB3+fwd7+My6bh23qYfvX4aGSYw+3dueIj6qNSJCRqVqbl
	 DiPCR+Qu5LkrYhmlKGBKxFXnfEw0bz3Plb9R7z8w5nWmCDD3boC5ZVDu5WgOXF6Wz/
	 AAZ7zVx8rQGXgt1kmz6dNBNHVk/1v5xImkGoLLGgRTWMyWeniJ9GwP9AhO3rHdNcad
	 usrGY64sCk5mPOS5KSVFoUuL3AK5t11QCTnMQoFhlBAX2JajoiHiRwSWXVvU/80Kev
	 SfkEMKCOLXyGUVAEqlT/7JLSO4PEOAHTQZ/ZvjaxhgdoF8R+H0OEr0UI8nvpsXjOyf
	 0Vc1/j7Vybm7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover refcount acquire node
 offsets
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yiyang Chen" <chenyy23@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <264dd4a10d3abdd037e01ccc6da44e5a5758dee2.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
References: <cover.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
 <264dd4a10d3abdd037e01ccc6da44e5a5758dee2.1781852308.git.chenyy23@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 08:30:59 +0000
Message-Id: <20260619083059.985F21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Logical double-free and verifier rejection in bpf_list_push_fron=
t error paths.
--

commit 822cb053457c04aa9becab9c713d49977dc74582
Author: Yiyang Chen <chenyy23@mails.tsinghua.edu.cn>

selftests/bpf: Cover refcount acquire node offsets

This commit adds regression tests for bpf_refcount_acquire() when used
with graph-node-derived pointers. It includes both accepted cases with
normalized pointers and rejected cases with non-zero fixed offsets.

> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr.c b/tools/=
testing/selftests/bpf/progs/refcounted_kptr.c
> index 61906f48025cc..7955a997316e0 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr.c
[ ... ]
> +SEC("tc")
> +__description("refcount_acquire_list_pop_container: acquire normalized l=
ist pop")
> +__success __retval(0)
> +int refcount_acquire_list_pop_container(void *ctx)
> +{
> +	struct node_data *node, *base, *ref;
> +	struct bpf_list_node *list_node;
> +	long err;
> +
> +	node =3D bpf_obj_new(typeof(*node));
> +	if (!node)
> +		return -1;
> +
> +	bpf_spin_lock(&lock);
> +	err =3D bpf_list_push_front(&head, &node->l);
> +	if (err) {
> +		bpf_spin_unlock(&lock);
> +		bpf_obj_drop(node);

[Severity: Medium]
Does this cause a double-free and verifier rejection?=20

Since bpf_list_push_front() consumes the referenced object unconditionally,
its reference ID is cleared upon return. The verifier treats the return val=
ue
as an unknown scalar and explores both branches of the error check.

Because calling bpf_obj_drop() requires an owning reference, dropping the
already-consumed node here might cause the __success test to fail loading
with a 'release kfunc expects referenced PTR_TO_BTF_ID' error.

> +		return -2;
> +	}
> +
> +	list_node =3D bpf_list_pop_front(&head);
> +	bpf_spin_unlock(&lock);
[ ... ]
> diff --git a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c b/t=
ools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> index 7247a20c0a3bf..f6cb084af16aa 100644
> --- a/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/refcounted_kptr_fail.c
[ ... ]
> +SEC("?tc")
> +__failure __msg("R1 must have zero offset when passed to bpf_refcount_ac=
quire")
> +long refcount_acquire_list_node_offset(void *ctx)
> +{
> +	struct node_refcounted *node, *base, *ref;
> +	struct bpf_list_node *list_node;
> +	long err;
> +
> +	node =3D bpf_obj_new(typeof(*node));
> +	if (!node)
> +		return 1;
> +
> +	bpf_spin_lock(&lock);
> +	err =3D bpf_list_push_front(&head, &node->list);
> +	if (err) {
> +		bpf_spin_unlock(&lock);
> +		bpf_obj_drop(node);

[Severity: Medium]
Similarly here in refcount_acquire_list_node_offset(), does dropping the
node after bpf_list_push_front() cause the same issue?

Depending on the verifier's branch evaluation order, this double-free logic
might cause the test to fail verification for the wrong reason, which would
break the expected __msg check.

> +		return 2;
> +	}
> +
> +	list_node =3D bpf_list_pop_front(&head);
> +	bpf_spin_unlock(&lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781852308.gi=
t.chenyy23@mails.tsinghua.edu.cn?part=3D2
