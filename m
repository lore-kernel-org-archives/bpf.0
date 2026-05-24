Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28F22356D9
	for <bpf@vger.kernel.org>; Sun, 24 May 2026 03:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779593440; cv=none; b=uEH9ra3agLX/hW9ytCed2Fxy3x7jFK6FS2Sbgf5nbeUNF86K4tavMgwoxmEU67mfj8bAy+JliXo1cPwlSn0RmveD0MDPyDLKQKS2yu2Uf4o034TEoiNma9lqSaDpywMoyZuaX4oNCjY/JSoyH3NR+STjSFAYOtJpx4NAbbRgfFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779593440; c=relaxed/simple;
	bh=ngziuAyO5kJc2LlwMD4vrmcPIgcw0Bd2EACEGX38TiI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ku0v4luMPQGg4uAKefct6If514jXv6xFjDla2C7OyAd12ZJz8pBSdhAGbxaprg5ADd6dboWkbGbEN6h9+UQATUHY+MI/0DbbmQtTnAchIsFYW6tR2XIx4oA+P9BAvbB8703tSf5GM2pzy8xCX8WKG/YROkVKTcmAP6hLV33LoLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXDVqK++; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXDVqK++"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963AE1F000E9;
	Sun, 24 May 2026 03:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779593439;
	bh=llYpOyInnJDQIe/gdFq/8mp/nKbTGfXn0aBZU/FS/Xk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JXDVqK++AhxJJ7gqEQs6dAyTmAEBAv5+nq/xAvvcC4WycIkwa0l3Ky5VB97LUwARn
	 sYxDr92iBI65qgT6WKOJNjZyKuiiGt8gKcFImtNHdsyQBCfEnCL1X2pPTTRrTR4h6P
	 bdt99si9p1kVs9ROD/x1R1IgFcvDMK0JWk2meoyeDdir6+ACUS52HNKchT3Rdl5Z5R
	 iut/xi6Rl5aoM4VHd7bFf84Y9/ndVPTEIytWPds7+H/vcoQTmrlAgF1Vyg+AGTCD9q
	 p8IU8ovmuiG4FMcazYZAzPTVNrYoOOyv3yPygBO9eRBin8UjwYf9P1da6kThyyYR1H
	 QOwWEChnYG4PA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] bpf: replace pop/push emptiness check with
 bpf_list_empty()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260524025853.13786-1-suchitkarunakaran@gmail.com>
References: <20260524025853.13786-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 24 May 2026 03:30:39 +0000
Message-Id: <20260524033039.963AE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch introduces a call to `bpf_list_empty()`, which is an unde=
clared function, resulting in a build failure.
--

commit 9fb6024323da084c2713bff3f8a0e6018dc6bd72
Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>

bpf: replace pop/push emptiness check with bpf_list_empty()

This commit simplifies fq_flows_is_empty() by replacing a pop/push check wi=
th
a direct call to bpf_list_empty(). The intention is to avoid unnecessary li=
st
mutation and simplify the code.

> diff --git a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c b/tools/tes=
ting/selftests/bpf/progs/bpf_qdisc_fq.c
> index 1a3233a275c7e..8107f5934d2d7 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_qdisc_fq.c
> @@ -196,18 +196,13 @@ fq_flows_remove_front(struct bpf_list_head *head, s=
truct bpf_spin_lock *lock,
>  static bool
>  fq_flows_is_empty(struct bpf_list_head *head, struct bpf_spin_lock *lock)
>  {
> -	struct bpf_list_node *node;
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
Does bpf_list_empty() exist? A search of the codebase doesn't show this
function being defined as a BPF helper, kfunc, or macro anywhere in the ker=
nel
source or BPF headers.

Since BPF list structures are opaque, their access must be mediated by
verifier-recognized kfuncs. Will this cause a build failure due to an impli=
cit
declaration?

Could the existing bpf_list_front() kfunc be used instead to check list
emptiness without mutation?

>  	bpf_spin_unlock(lock);
> =20
> -	return true;
> +	return empty;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260524025853.1378=
6-1-suchitkarunakaran@gmail.com?part=3D1
