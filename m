Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B1CEADC
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 17:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790013409; cv=none; b=D4cxRBAK/PkhT/bByahSBz+OQ08CgNvAiD+MON86zYHaiWkU/DlHr0bLIxfBtI2ejO+tU/8mJlutpGxgaFW50vJ/NJsIkAJ32hkxe8WZn0/jaXQNWu0sO3BjFTZDsHIKs3LqN/eXLpX/Cro7CPI3B2s6hRyY5kyY4nj+Mjr7/VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790013409; c=relaxed/simple;
	bh=hIroAZwSc3nQoJlCZ3vJeNTsUcIIxf9QIgTArRQ7t/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qqOJVgw+XwZ29DJPHM22bjMQN4xmvJFBX7kMrDEz6GtgO+w01IjGLiBkrHWL3dl7jyz8aHvuvf18PZJxKPEWdgMGJfML4o+naCMNMZ9RBJVdQpfKvUnqKK3HH/Ho55otDZXP8QkoGl3xZWHhDcZZwhrOXaSEkzMvP9iBfI6FmJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=byc9AtDi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="byc9AtDi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4871F000FF;
	Mon, 21 Sep 2026 17:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790013407;
	bh=+HsvVaTmCWU5tvDHmGEEMjz5K8fFzIUwcE+jTXyENXs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=byc9AtDinWAvQz9H3lzBNSwf4sFVJupD78ME/CuvjVwAc5cuVqJ47DY6/ohVmx/C+
	 OzVwQs1L3TaP5aD+FERJetAAre4bOhsSZaO9h6GmbDiI+1uv7/dKjDsIKkjnp3DWO8
	 Zzfao7H6GnBKUIO1rb1ZpaVhifxo2MxbzWPpmjgMWccYb95cMAyWxiYR6WnkiQZ3J9
	 qLqfSvYZuggJsMFz7NEuFwwHIT6ozpuHXhHhPrlJ/dVvjIcoLxpLRDvoNaEVVFrNlB
	 BERDdn/PRfIejMzKDbOvXDowxRkFnXtZp2lNtrzbAfQApIHibFicv1aajfvx2aZ98v
	 LJSJCcm2zvDRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] selftests/bpf: cover stale CB after LWT IP
 encapsulation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921173910.90847-3-bestswngs@gmail.com>
References: <20260921173910.90847-1-bestswngs@gmail.com>
 <20260921173910.90847-3-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 17:56:47 +0000
Message-Id: <20260921175647.9F4871F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: bpf_lwt_encap_stale breaks lwt_ip_encap_vxlan test due to a=
uto-loading
--

commit 62bf6da3e832e187b8a03919cec2518d27ebceed
Author: Weiming Shi <bestswngs@gmail.com>

selftests/bpf: cover stale CB after LWT IP encapsulation

This commit adds regression coverage to the LWT IP encapsulation test. It
verifies that the restored protocol control block no longer contains the
inner header's cached option offsets after LWT program execution.

Link: https://lore.kernel.org/bpf/DLKB3UXOH0IS.1UL8NV9HSJFXG@gmail.com/

> diff --git a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c b/tool=
s/testing/selftests/bpf/progs/test_lwt_ip_encap.c
> index 4a934fccf8f5b..8b57c7fb7fa8a 100644
> --- a/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c
> +++ b/tools/testing/selftests/bpf/progs/test_lwt_ip_encap.c

[ ... ]

> @@ -80,6 +83,29 @@ int bpf_lwt_encap_gre6(struct __sk_buff *skb)
>  	return BPF_LWT_REROUTE;
>  }
> =20
> +SEC("encap_stale")
> +int bpf_lwt_encap_stale(struct __sk_buff *skb)
> +{

[Severity: Medium]
Will this new program cause the existing lwt_ip_encap_vxlan() test to fail
unconditionally?

Since "encap_" is an unknown section name prefix for libbpf, it defaults to
the BPF_PROG_TYPE_UNSPEC program type.=20

The existing lwt_ip_encap_vxlan() test function relies on
test_lwt_ip_encap__load(skel) to load the skeleton. It manually disables
auto-loading for preexisting programs (like encap_gre and encap_vxlan) but
was not updated to disable auto-loading for this newly added encap_stale
program.=20

Consequently, libbpf attempts to load it, sees BPF_PROG_TYPE_UNSPEC, and
returns -EINVAL, which immediately fails the lwt_ip_encap_vxlan() test.
Should this program's auto-loading be explicitly disabled in the existing
tests?

> +	struct iphdr iph =3D {};
> +
> +	/* Exercise CB restore before post-run invalidation. */
> +	if (skb->cb[0])
> +		return BPF_DROP;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921173910.9084=
7-1-bestswngs@gmail.com?part=3D2
