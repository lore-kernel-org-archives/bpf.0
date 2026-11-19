Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795052355;
	b=i0dM5QM73rsgx0JUUXibvEvCVwIv8daC0LyesCZJW1PmZgj73Yo8COlL6QWRNJXzvhrQ
	 gxr+8qptYmV+BprYek8Oz+YB3fQokJmAVTSBFkkd5KOnxdRnwf2sVDo6u2hcMo+2GQuwY
	 zUZySBXT5Dtvc71GDvf4XFiVmDO7A+gw3YFdxkOMW+3ihGv9ppYFJH0gEmbP2dinAmEHf
	 zYj5ldULi+H4zh3/x8tGNTJjsz9gxsfKJfXx1hECpPYdZUiizONTaocXhBmFC8ykRPzft
	 zvUq/HfaML8ftiVu0EOUX3uwmlJN2rt8fdy4g5LrmTBWQ/vIUnZBrCzEdEFgnhMiIpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795052355;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=SXeeMNceyQYFO6LuI/tQEAKqdF54TN3vYntI1YBMMnA=;
	b=MwOBZEFqE7bJq7cus9Jm2Jz+jBQ3G+vlYeDzYFg66YkZxnK1vjKMfo/LwPV1Ds1A/+te
	 CFVclcl4ffWWcUsa4Qmlh854rSnRu8zo5nngroyaCS98zsG3SDs0Dpe9PJpudFVkk30ZB
	 Q6qVlDUnwmh3+lTwL22i74WuKn6zkZkp3vvtxRbCSMwytxT2R67xTXQYmHEubID/BA1bE
	 wGgZSF0W/f32pTP1YMiw6cpxeg7WDcmjqC8ghWG3wU9P+qCGTysgjnFbqOwa+xzzfkHXq
	 3/lOx2XChjGk1QLZjoKCAaZytppeDrtJhOGAEVdhcbalJ1G/4N7RPwi7D39SP5/H0TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9RgF3fT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FC2606A33F
	for <bpf@vger.kernel.org>; Thu, 19 Nov 2026 01:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V9RgF3fT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BDEB1F000D0;
	Thu, 19 Nov 2026 01:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795052354;
	bh=SXeeMNceyQYFO6LuI/tQEAKqdF54TN3vYntI1YBMMnA=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=V9RgF3fT73DC+uWy8+aXr6JcCf5xHlzIs9oZuEVBpz5bvEvNfTOwchkYQi22NvfcG
	 pMRQVRnenfap7e4ySqU76+60TabR813YKN3pQbi/iCRSzJl7I8pvsqv2ValBaHPOSV
	 H6ZyEDgROYK1DjI71TonKFYNLhUUh1h1OtiaDnzVWs2QrKDTvTfDXgKX2S0f2BctaB
	 Q/FeqJtk09HcrTWPj7jwZWGqAmj1zNbyeqn5zzMWVQ37aG29KonfO1QV762z8dAb5j
	 wZPuUGgj2YkgReux2ILNSZF2TzfRIk8UT5CbqeZ2yMt7oBl36NWk/y1Idi7A+3hi4w
	 FfdWa7++NUcSg==
Message-ID: <sashiko-outbox-222288@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 3/5] bpf: Remove BPF_MAX_TRAMP_LINKS
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>, bpf@vger.kernel.org
In-Reply-To: <20261119012909.3657417-4-alexei.starovoitov@gmail.com>
References: <20261119012909.3657417-1-alexei.starovoitov@gmail.com>
 <20261119012909.3657417-4-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 01:39:11 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Critical] bpf: missing list rollback on error in
  bpf_trampoline_add_prog() [1]
--

commit 6cc47d6522f82133a841a876d884e04a65d2d4b1
Author: Alexei Starovoitov <ast@kernel.org>

bpf: Remove BPF_MAX_TRAMP_LINKS

This commit removes the fixed BPF_MAX_TRAMP_LINKS program count limit on
BPF trampolines, relying instead on a 4 KB image size limit
(BPF_TRAMP_IMAGE_MAX_SIZE), dynamically allocating the bpf_tramp_nodes
arrays, and patching s390 skip branches directly.

> diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> index 21d460866dfef..4dd4040e784f1 100644
> --- a/kernel/bpf/trampoline.c
> +++ b/kernel/bpf/trampoline.c
[ ... ]
> @@ -889,22 +893,17 @@ static struct bpf_tramp_node *fsession_exit(struct =
bpf_tramp_node *node)
>  }
> =20
>  static int bpf_trampoline_add_prog(struct bpf_trampoline *tr,
> -				   struct bpf_tramp_node *node,
> -				   int cnt)
> +				   struct bpf_tramp_node *node)
>  {
>  	enum bpf_tramp_prog_type kind;
>  	struct bpf_tramp_node *node_existing, *fexit;
>  	struct hlist_head *prog_list;
> =20
>  	kind =3D bpf_attach_type_to_tramp(node->link->prog);
> -	if (kind =3D=3D BPF_TRAMP_FSESSION) {
> +	if (kind =3D=3D BPF_TRAMP_FSESSION)
>  		prog_list =3D &tr->progs_hlist[BPF_TRAMP_FENTRY];
> -		cnt++;
> -	} else {
> +	else
>  		prog_list =3D &tr->progs_hlist[kind];
> -	}
> -	if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> -		return -E2BIG;
>  	if (!hlist_unhashed(&node->tramp_hlist))
>  		/* prog already linked */
>  		return -EBUSY;

[Severity: Critical]
This problem wasn't introduced by this patch, but can
bpf_trampoline_add_prog() leave a dangling node on prog_list when
fsession_exit() fails [1]?

Later in this function, node->tramp_hlist is linked into prog_list and
tr->progs_cnt[BPF_TRAMP_FENTRY] is incremented before fsession_exit() is
checked:

kernel/bpf/trampoline.c:bpf_trampoline_add_prog() {
    ...
	hlist_add_head(&node->tramp_hlist, prog_list);
	node->link->prog->aux->tramp_linked =3D true;
	if (kind =3D=3D BPF_TRAMP_FSESSION) {
		tr->progs_cnt[BPF_TRAMP_FENTRY]++;
		fexit =3D fsession_exit(node);
		if (WARN_ON_ONCE(!fexit))
			return -EINVAL;
    ...
}

If a BPF_TRAMP_FSESSION program is attached with a link type other than
BPF_LINK_TYPE_TRACING or BPF_LINK_TYPE_TRACING_MULTI, fsession_exit()
returns NULL and bpf_trampoline_add_prog() returns -EINVAL without
unlinking node->tramp_hlist, decrementing tr->progs_cnt[BPF_TRAMP_FENTRY],
or clearing tramp_linked.  Because callers free node on error, subsequent
trampoline accesses will hit a use-after-free on prog_list.

[1] https://sashiko.dev/#/bug/linux-6367ff56-4b7b-447b-bfcf-d5da9ee421e9

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119012909.3657=
417-1-alexei.starovoitov@gmail.com?part=3D3
