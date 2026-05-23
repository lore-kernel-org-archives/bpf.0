Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B4288C2C
	for <bpf@vger.kernel.org>; Sat, 23 May 2026 18:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779562793; cv=none; b=L7LXTRsBvSIqWpN45Qdo68rfy2XGK3QYhOFzgP5zVNWRHyzBdU1sepVEcsGrj2USqBqvZ/t8/HT5mXnSiMfVvpAQmru51pFJPf573DbH81RETHQRaDjQ9OSOBdh2W5b92NzYp2d74l5nbKpb1Ng8HRMysZe6QfUPXKjHeMaUUNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779562793; c=relaxed/simple;
	bh=rcr+T++vDY6hc10XK2shhiJXW2US+2I1A8cVYK1r1Tg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SSTXtiKfcOILc5rfDLOAdfkMQwFSZnUtjOmFiOuJ842J/kFsvbot3zArG2P06dcPXoa9iu6Yu9/XrR43Rl3xpcq3XI19xrt4Cy0EjQhEjxeKoMBsi843JAehA0qnvvUVsXQg6hLzXbHTCmnHI3Nx2wOL4Tax3DtTsTl7YCs+G9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDsf7LJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDsf7LJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22C61F000E9;
	Sat, 23 May 2026 18:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779562791;
	bh=bGWJlou9XxKoQsdzMXvIfWkuzsP7fjoFmcpZvKm0fpk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iDsf7LJVmFcPwN++ogoXfoEyCKNxfaYTxTrtuLHRHkmhkAc4JJxhtHy+GcwvHmgZQ
	 tuvIxsD/L7yStYT7A65ieOhNT1tqDeIHNtAvik0h0nuy8tAvUFW+nHLev1D8EXF0sX
	 AmzuLJYnPWa0PnjyZ4PYuZcdkVdVpsJ7N26+FKbvUuT07xEqob0PhK8/5cYEN3WC6T
	 c2OntC7SZyoWYjWiO6WRnkewvCjISnb1+DeH7UZtWi/UlYJFDbKdnQCT/k/rxmM54w
	 thnaga14f6oqZahzNigzVW+7KeuTb4tFpYpFnhgkK0KenR5JWiRsUGaYTf05b+9P2d
	 tm1DE/ZsL1OGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: replace pop/push emptiness check with
 bpf_list_empty()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260523183422.124105-1-suchitkarunakaran@gmail.com>
References: <20260523183422.124105-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 23 May 2026 18:59:51 +0000
Message-Id: <20260523185951.D22C61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The patch introduces a call to `bpf_list_empty()`, which does not e=
xist in the BPF API.
- [Low] The local variable `node` is declared but never used.
--

commit 0412c8130cf7d0d205c2cc937b2838067c31fb8b
Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>

bpf: replace pop/push emptiness check with bpf_list_empty()

This commit attempts to simplify fq_flows_is_empty() by replacing the
pop/push based emptiness check with a direct call to bpf_list_empty().
This is intended to avoid unnecessary list mutations.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c b/tools/tes=
ting/selftests/bpf/progs/bpf_qdisc_fq.c
> index 1a3233a275c7e..3b05ac1d7c776 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> @@ -197,17 +197,13 @@ static bool
>  fq_flows_is_empty(struct bpf_list_head *head, struct bpf_spin_lock *lock)
>  {
>  	struct bpf_list_node *node;

[Severity: Low]
Since the pop and push logic was removed, is the node variable still used
anywhere? Leaving this declaration here might trigger an unused-variable
compiler warning and break the selftests build.

> +	bool empty;
> =20
>  	bpf_spin_lock(lock);
> -	node =3D bpf_list_pop_front(head);
> -	if (node) {
> -		bpf_list_push_front(head, node);
> -		bpf_spin_unlock(lock);
> -		return false;
> -	}
> +	empty =3D bpf_list_empty(head);

[Severity: Low]
Does bpf_list_empty() exist in the BPF API?

The BPF linked list API does not appear to define a bpf_list_empty() kfunc,
helper function, or macro. Could this lead to an implicit declaration
compilation error?

>  	bpf_spin_unlock(lock);
> =20
> -	return true;
> +	return empty;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260523183422.1241=
05-1-suchitkarunakaran@gmail.com?part=3D1
