Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98640516156
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 11:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790682055; cv=none; b=Tl6zHck94ukYJqVvh4gblT5zY6wFE3ZFKzOoJSapgjiZ3ghOrNki1QKJS6NNTjqcZzze+hEuHgFuNUgjNH1aWOXRxkk+himEuRadezjstTz1fODfiejQwXgsUikzxIVgvOWaP4v8pQCC/PjxCbeHyZ4GDT+JZul9q7retrEbyQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790682055; c=relaxed/simple;
	bh=8V2k6bJPQ7oWRke/+DkQzvQK00A63HKqHpSI9HBEVTk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YlJSjrZTxNqv7BTyLj/1x2Gyk/eAzxQ9UE9edi5LmBNru9sYbgl866bGRLL/w6bm8295SwPcSLLn9nzqAjZztbEEj8tb9pKWAsTaVk+nuk/FAu3+BpC986oBn/IvpeW6M65vEcbGwepuWkCcx5h/bwVJSIVDVkLyKxebS3hMjLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+OBDzIu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+OBDzIu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B681F000FF;
	Tue, 29 Sep 2026 11:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790682053;
	bh=sdkHGP2wAzpteMPVinzRoKuvnK9ntwzNC2Fz06V30OI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T+OBDzIuA8I3PITM3hfxIgSZattN7ENCjhChad0T2fPN9x0hnlB4rYIOeNHwAkBz0
	 gZk6usctkaeyThInrP2LaYkGUAn2RnCJKNh17J56kDLGmOl088wA92Whtd3wOS7FFH
	 tZD2g6AuglkrZS6KtXbrXOKL918maB2Vh0x4yd5TM80vBvYFUQorglZwscEsD+RMSy
	 IqVndge7zhulJbXH2R8Kuw9QPgBEqxJGlfbQWxQVv+OdOD5dUZfLEkND+avSZ0eURd
	 4KLeKai8rs/xmIP34Fehp7SLRvby1xC+aVlnj9g7VE2xPNzuomEn64QyqdeArn2OWr
	 F9zMBwwXcHllQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 12/15] selftests/bpf: Test passing metadata
 to/from LWT hooks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jakub Sitnicki" <jakub@cloudflare.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260928-bpf-meta-gated-tracepoints-v1-12-844dbf3e1edf@cloudflare.com>
References: <20260928-bpf-meta-gated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com>
 <20260928-bpf-meta-gated-tracepoints-v1-12-844dbf3e1edf@cloudflare.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 11:40:52 +0000
Message-Id: <20260929114053.56B681F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] bpf: test_skb_trace__lwt() flushes host lo TC filters on error p=
ath
--

commit f9f501349280aad0f33d2b92ed8bad6a5848a1c3
Author: Jakub Sitnicki <jakub@cloudflare.com>

selftests/bpf: Test passing metadata to/from LWT hooks

This commit adds cross-hook tests for the metadata stash covering all gener=
ic
LWT program types. It tests LWT ingress, egress, and transmit programs by
tagging the skb on loopback and reading the stashed metadata from TC ingres=
s.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.=
c b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> index eb0d36e7a45d9..aea7a1c8a7552 100644
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_context_test_run.c
> @@ -1638,6 +1638,118 @@ static void test_skb_trace__nf(struct test_xdp_me=
ta *skel, const char *name)

[ ... ]

> +static void test_skb_trace__lwt(struct test_xdp_meta *skel, const char *=
name,
> +				struct bpf_program *lwt_prog,
> +				const char *encap_dir, bool writer)
> +{
> +	LIBBPF_OPTS(bpf_tc_hook, tc_hook,
> +		    .ifindex =3D 1 /* IFINDEX_LO */,
> +		    .attach_point =3D BPF_TC_INGRESS);
> +	LIBBPF_OPTS(bpf_tc_opts, tc_opts, .handle =3D 1, .priority =3D 1);

[ ... ]

> +	unlink(LWT_EXT_PIN_PATH);
> +	ret =3D bpf_program__pin(lwt_prog, LWT_EXT_PIN_PATH);
> +	if (!ASSERT_OK(ret, "pin lwt"))
> +		goto cleanup;

[Severity: Medium]
Will this error path inadvertently flush the host's loopback TC filters?

Because bpf_tc_hook_destroy() is called in the cleanup block, and netns_new=
()
has not been called yet, jumping to cleanup here means bpf_tc_hook_destroy()
executes in the host's network namespace on ifindex 1 (loopback). This could
disrupt the host configuration or other parallel tests by flushing all ingr=
ess
filters on the host's loopback interface.

Should this jump to cleanup_prehook instead?

> +	pinned =3D true;
> +
> +	ns =3D netns_new(name, true);
> +	if (!ASSERT_OK_PTR(ns, "netns_new"))
> +		goto cleanup_prehook;

[ ... ]

> +cleanup:
> +	if (fd >=3D 0)
> +		close(fd);
> +	bpf_tc_hook_destroy(&tc_hook);
> +cleanup_prehook:
> +	bpf_link__destroy(put_link);
> +	if (server_fd >=3D 0)
> +		close(server_fd);
> +	netns_free(ns);
> +	if (pinned)
> +		unlink(LWT_EXT_PIN_PATH);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260928-bpf-meta-g=
ated-tracepoints-v1-0-844dbf3e1edf@cloudflare.com?part=3D12
