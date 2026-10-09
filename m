Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5422F4C9E0A
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791549806; cv=none; b=FK0ngp5WoGAAPMTclQmnVN70cPKMre8XRJ3KWaN7adb2K/X6aA44MjY093M7OzluUsyqIJqQdR0LCn56vJc3rI+g3EisR1ix0IFuRmAetvPthbk2cp8RS4MQz8QcPEzfhTQu+dNAxYprjAT1adhmuxgjnRc6NdYDIfRFsRiaHgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791549806; c=relaxed/simple;
	bh=168IGskqtnAHMIhuudogHrSlqn6wexkfWcI3hS8fyVs=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=OarIbxG9JbsiAlPNTalge4lWZdPsvpSSbt2KagMSo4w2+1Ek9wHQ45agMSQEvnmo2rrgiyLsY0lx0IG9w+0spKy0MXhXXTcOcsvND3QDR1+ENaKBpBLjjKt+aFoCYuynOtZ+q8CJqRyqYo61XUmT+b9LZUdv6G41EbyN+y2qk88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sh/ieF7M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sh/ieF7M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D32A1F000FF;
	Fri,  9 Oct 2026 12:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791549801;
	bh=LByv+9BHAc28GedDsNmSrVs1bxjgTSueGWKSYlm8YM4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sh/ieF7Mv0bH+ZXA/LeAS3bHOTYntVelNPH5flDhnjZlYvdvdyjNCJawrWPCF9bB3
	 R4a96CG5i+YkJ9bcj2quBPu/VemQWZAEfZDgxVxxghwxLlbS6x5BJq8fIgGXkc/8qn
	 Nd4+gdrEyKuRFpxa8cxKvVn7UvcBfypiTwLyDAEYogwJ5obqo9WJKQSplzEyB4YJ7v
	 BIVe8SC3PgAVnuh74Cuh3WEXDAtXBhwqM0ONebxWAQeMxc+RyHWFvC/JSaxWlv457G
	 ZEJMoNi3fdrKi/I8M625vlbTNtyc/s4rUIoKXJdUfgQn7YFwW0248wW8htj+rL1MC9
	 iP74PufHQRWoQ==
Message-ID: <sashiko-outbox-165554@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] mm/page_owner: add bpf_page_owner_get_memcg_info()
 kfunc
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zhen Ni" <zhen.ni@easystack.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009112308.240769-6-zhen.ni@easystack.cn>
References: <20261009112308.240769-1-zhen.ni@easystack.cn>
 <20261009112308.240769-6-zhen.ni@easystack.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 12:43:20 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] bpf: Missing __sz annotation allows BPF stack overflow in memc=
g kfunc
- [High] bpf: missing __sz annotation on size param causes stack buffer ove=
rflow
--

commit 98bc7e204a48312a6be1bc67be9ade762ffed9ff
Author: Zhen Ni <zhen.ni@easystack.cn>

mm/page_owner: add bpf_page_owner_get_memcg_info() kfunc

This commit introduces a new BPF kfunc to expose per-page memcg information,
including the cgroup path. It extracts memcg data collection into a new
helper function that the kfunc calls directly.

> diff --git a/mm/page_owner_iter.c b/mm/page_owner_iter.c
> index 907517a291443..e7a8ca1e90e8d 100644
> --- a/mm/page_owner_iter.c
> +++ b/mm/page_owner_iter.c
[ ... ]
> @@ -170,4 +170,11 @@ __bpf_kfunc int bpf_page_owner_get_nid(struct page_o=
wner_scan *scan)
>  	return page_owner_get_nid(scan->page);
>  }
> =20
> +__bpf_kfunc int bpf_page_owner_get_memcg_info(struct page_owner_scan *sc=
an,
> +					      struct memcg_info *info,
> +					      char *buf, u32 size)

[Severity: Critical]
Does this size parameter need the __sz suffix for the verifier to track
memory bounds correctly?

Because the parameter is named size rather than buf__sz, it appears the
verifier might treat buf as a fixed 1-byte allocation and size as an
unconstrained scalar.

Could this allow a BPF program to pass a 1-byte stack buffer alongside an
arbitrarily large size value? If so, when this calls into
get_page_memcg_info() in mm/page_owner.c and executes:

get_page_memcg_info()
    ...
    if (buf && size)
        cgroup_path(memcg->css.cgroup, buf, size);

can it overwrite the BPF stack and corrupt adjacent kernel memory?

[Severity: High]
Do the buf and info parameters also need the __uninit suffix?

Without this suffix, the verifier might improperly force BPF programs to
pre-initialize these output variables just to pass verification.

> +{
> +	return get_page_memcg_info(scan->page, info, buf, size);
> +}
> +
>  __bpf_kfunc_end_defs();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009112308.2407=
69-1-zhen.ni@easystack.cn?part=3D5
