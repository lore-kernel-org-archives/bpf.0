Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A07E2E738B
	for <bpf@vger.kernel.org>; Sun, 26 Jul 2026 16:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082637; cv=none; b=olnS09FgZl4sP1+xflIB+C8m20Ie3aX+dzegoibzykmTfxns7K9FUx4bdhLYDIRPIhjImQvWlShIekmLt7k5AO1ek0sjYt4+k+4gYmotfsyf4CpTTImTIB1+USCaO+zl8DhFKk9rMKDAs4v9jgGVelKjWgJdaIKP81035u6aLx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082637; c=relaxed/simple;
	bh=HGscw4nNIxIV1WzUsSCa51r2oLsUqiS3YcAlA8nvhrs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tMbvrH67fFRHHSREdLJMtQzzX4H2zVDdCqEABbp3omcYe8TCntpKi2Y7zAduj9XApWWWIru0l3NiyH7DP6ORdBgs5ngyEoOiOLWzWoTkUqiYEO87ESEEiZeihXSceREC3MLCM9JDDA5IoxBdd7volvsyom/dxhE7YdiP9g21qGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQaQlQkD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQaQlQkD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6831F000E9;
	Sun, 26 Jul 2026 16:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785082636;
	bh=inCslCkfb1UKP4swRnJclg3wPeHNJgJsRYxqZuxcf6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MQaQlQkDHX8Oy5mPAMwo315CINZz6nBdLNd+sONh6DZ+OJG1jaf80C853qxq7Nq+K
	 K6UQyV88QbprKT7EHS9/vlVmTD2QoPio1xxl9YkB7FxKelmSaLGlWVzhZK3U49dgfD
	 EElxO47U1eJrm7hkMSeGFJIejFavngjKLnP6hdQNSqEMmc9vE2cNCe2xfOFkKiTemO
	 EwC9p4CCwqNYrsJbxBEMDrj2aqL+WCB1CB4jgk5EKqSwnjUdYwrfzJcEJO1IoRYepU
	 VOo26/ZyJvN5/UIphXn/QMAGjN7wYzAknyQdwj2Dy2x8DCNV84LL511i5Qi+UE+X70
	 VKxSZKdDP63+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Cover RHash special-field
 recycle
Reply-To: sashiko-reviews@lists.linux.dev
To: "Nuoqi Gui" <gnq25@mails.tsinghua.edu.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260726-f01-23-rhash-cancel-bpf-next-v1-2-6e5e1131d885@mails.tsinghua.edu.cn>
References: <20260726-f01-23-rhash-cancel-bpf-next-v1-0-6e5e1131d885@mails.tsinghua.edu.cn>
 <20260726-f01-23-rhash-cancel-bpf-next-v1-2-6e5e1131d885@mails.tsinghua.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 16:17:15 +0000
Message-Id: <20260726161716.1C6831F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The RHash map implementation leaks BTF special fields (such as kpt=
rs) during in-place updates and element recycling by failing to call bpf_ob=
j_free_fields().
- [Medium] The new selftest test_rhash_special_fields_recycle incorrectly a=
sserts and enforces a kernel memory leak regarding BTF special fields.
--

--- Patch [2]: [PATCH bpf-next 2/2] selftests/bpf: Cover RHash special-fiel=
d recycle ---
commit d7b4034e22767ea5cd89689a56855953c3b5c45a
Author: Nuoqi Gui <gnq25@mails.tsinghua.edu.cn>

selftests/bpf: Cover RHash special-field recycle

This commit adds regression coverage for RHash value recycling with
referenced kptrs. It stores a referenced task kptr and updates the value
with BPF_EXIST, then verifies that bpf_kptr_xchg() still returns the kptr.
Finally, it deletes the element to exercise the delayed reclamation path.

> diff --git a/tools/testing/selftests/bpf/progs/rhash.c b/tools/testing/se=
lftests/bpf/progs/rhash.c
> index fc2dac3a719e9..d28d115cb74e7 100644
> --- a/tools/testing/selftests/bpf/progs/rhash.c
> +++ b/tools/testing/selftests/bpf/progs/rhash.c

[ ... ]

> +	err =3D 5;
> +	if (bpf_map_update_elem(&special_fields, &key, &val2, BPF_EXIST))
> +		return 5;
> +
> +	err =3D 6;
> +	elem =3D bpf_map_lookup_elem(&special_fields, &key);
> +	if (!elem)
> +		return 6;
> +
> +	err =3D 7;
> +	task =3D bpf_kptr_xchg(&elem->task, NULL);
> +	if (!task)
> +		return 7;

[Severity: Medium]
Is it intentional for this test to codify a kernel memory leak as a valid
feature?

The test updates the element using bpf_map_update_elem() with val2 (which
has no task kptr) but then expects the old kptr to still be present and val=
id
in the map.

According to the BPF subsystem guidelines, when a map element is overwritte=
n,
bpf_obj_free_fields() must be called to release resources held by the old
value. By asserting that the old kptr survives the map update, the test
appears to enforce a bug where bpf_obj_free_fields() is missing.

[Severity: High]
Could this highlight a resource leak in the underlying RHash map
implementation?

Looking at the RHash implementation in kernel/bpf/hashtab.c,
rhtab_map_update_existing() appears to overwrite the old value using
copy_map_value() but misses the required bpf_obj_free_fields() call.

Additionally, when deleting an element:

kernel/bpf/hashtab.c:rhtab_delete_elem() {
    ...
    /* Cancel reusable internal structs: bpf_timer, task_work, wq */
    rhtab_check_and_cancel_fields(rhtab, elem);
    ...
}

It seems to skip freeing kptrs, leaking the references. Should
bpf_obj_free_fields() be called during these operations to properly release
kernel resources like task_structs?

> +	bpf_task_release(task);
> +
> +	err =3D 8;
> +	task =3D bpf_task_acquire(bpf_get_current_task_btf());
> +	if (!task)
> +		return 8;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726-f01-23-rha=
sh-cancel-bpf-next-v1-0-6e5e1131d885@mails.tsinghua.edu.cn?part=3D2
