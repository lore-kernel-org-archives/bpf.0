Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F6A384CE9
	for <bpf@vger.kernel.org>; Tue, 23 Jun 2026 22:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782253540; cv=none; b=pVRg6n6pxBd5n9ydto567/wYEj9cQeXI6zhmKeY1YFEzXD0np46Q39u+sJvbLr4wMQrBx59XgZiwmKAi4x7SxZdC7INLqBQKoUJYgm2zGIkQ7LvOjcRhn74tbNCXrMcJ5UNn8Zwam6vYOTTZeEI3cD2CM1iGLPoFpttfMUhSxi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782253540; c=relaxed/simple;
	bh=JiVMk2kkfQPNcgIh31WBTDW1l+C+LW7E04l+mPva/i0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RbuBbCUkCnYkhhPtsIh8Os2LvyYMw4jurko4JjdLWq2exScHx0Qka1q5utWWDfhACnfmaX0XMcIaiA2JFCHkUSU9LbFNpzswG9CUQIH956jGakKfA5QgYEAaZoZ6tCeHcptf/lwIgbHgTRAXIr1N6phq/ryOH6M/zZ0F6paOWtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eK74mgiy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eK74mgiy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8DA81F000E9;
	Tue, 23 Jun 2026 22:25:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782253538;
	bh=dKyNzYDbwHgrKtdzwmUrKI+JIZuPqs1OCRemSBjLuqc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eK74mgiyy0ifEF22N7l1hhi5/4d5Mtq4PyffmXT9t5jHLUpKKZo6EAIyWFCW99paZ
	 srDVMOJ+ngvBlflqQ/eQ4Hi078Q9rhQgwWP3UA9FQMHv647OIOv4DtQ4CvT2sY7HIb
	 hoDNr5PDw8GE3mGIO9hoqIunwag4tbUiwsKUKI36TXd3kr6SfA6a5rHNILN0VXpu96
	 fS/JQU3kma/8T9oF/Ps/JGYtIzSOTOe1Fkg6aOQCfPCpkZ92QFbGH3Cjvl3uewfFpY
	 szpKWOzv8o9EsiW/4563YtFIfhU2kbL2XUcTKNEHbYonIJVN6YIY/0do2W//96UFC/
	 wiy+/JNEK1AoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 08/15] bpf: Add a few bpf_cgroup_array_*
 helper functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Amery Hung" <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260623175006.3136053-9-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
 <20260623175006.3136053-9-ameryhung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 23 Jun 2026 22:25:38 +0000
Message-Id: <20260623222538.B8DA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-After-Free of BPF programs due to absolute index misuse in `re=
place_effective_prog`.
--

commit b4f54d11b7b09f1a7417ca11be6452325ecc5aaf
Author: Martin KaFai Lau <martin.lau@kernel.org>

    bpf: Add a few bpf_cgroup_array_* helper functions
   =20
    bpf_cgroup_array_length(), bpf_cgroup_array_copy_to_user(), and
    bpf_cgroup_array_delete_safe_at() are added as a preparation work
    to allow skipping the cfi_stubs in the upcoming patch.

> diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
> index 7abbe12e108f0..081d81de18163 100644
> --- a/kernel/bpf/cgroup.c
> +++ b/kernel/bpf/cgroup.c
[ ... ]
> @@ -1166,7 +1227,7 @@ static void purge_effective_progs(struct cgroup *cg=
rp, struct bpf_prog_list *pl,
>  				lockdep_is_held(&cgroup_mutex));
> =20
>  		/* Remove the program from the array */
> -		WARN_ONCE(bpf_prog_array_delete_safe_at(progs, pos),
> +		WARN_ONCE(bpf_cgroup_array_delete_safe_at(progs, pos, atype),
>  			  "Failed to purge a prog from array at index %d", pos);
>  	}
>  }

[Severity: High]
This is a pre-existing issue, but when purge_effective_progs() replaces a
program with a dummy in the effective array, does it cause an index mismatch
for subsequent operations?

Looking at replace_effective_prog(), it updates the effective array using a
logical index from effective_prog_pos() directly as an absolute index:

replace_effective_prog() {
    ...
    pos =3D effective_prog_pos(desc, atype, pl);
    ...
    item =3D &progs->items[pos];
    prog_list_replace_item(pl, item);
}

If a previous detach operation failed to allocate memory and fell back to
purge_effective_progs(), it leaves a dummy program in the array while remov=
ing
the program from the logical list. Doesn't this mean pos is a logical index
that fails to account for the left-over dummy programs?

Unlike bpf_cgroup_array_delete_safe_at() which skips dummies to find the
correct physical index, replace_effective_prog() uses pos directly. Could
this cause replace_effective_prog() to overwrite the wrong entry and lead
to a use-after-free when the old program is freed via bpf_prog_put() in
__cgroup_bpf_replace()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260623175006.3136=
053-1-ameryhung@gmail.com?part=3D8
