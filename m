Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793607807;
	b=Pqk5kRlgo5b5awnwGkMr7pI4PP948Xqwm4zfmn3P5k3tQt7yUakirbhmsyAifUJ7DdrG
	 IEJBiZ1Wwh/3zhDb40M8n41s98vTMx221W5FvBQxBCOBwBtJIcejx8TNR7/6n+er4pBD5
	 cxzSpqSRoz511sxzkwfThjlL0HOOU9AJWNS27puRTBq04xNRlpaan01nP8zV2oSr7WOWV
	 j+m2Lz9yYfZjV8GLp48pvHGO8+jgU3Nbu54vSAj/8ggQWkWUn+lxSCHCL3JqL1PETnjsO
	 gr2Jeam/h5H+Wou1cxkEz32d3UAlJQavkbeHeIaby3jMK+mhDPVEia773B5GTKoMU9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793607807;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0W7vYX2FrWSVGNVSfgrq9//jMplfVSp6vpvTJJUUr/Q=;
	b=2HXaoW1gxHAlTRTt4etYzWdtaePRGHiL50RZYGqiSAz0KXbIPQf4Z6qZOlMCqalf+imC
	 TOl7w9qinokp/BGRDtCRcsYxfGOOWxVq5fcsUPuHUUAIqLk4EifcAjwduBBfjOYypwu97
	 YsJHsGYcwORqTPWAyh9dkckAo8ylwMpZR/4UrVA0QQZ/fZio84jRQSyRyagSeu5KZJKs9
	 FWN7lCj3Tit5BmrMp2GfdGoEVLu+PzbSt2fy1/5Dl9lwfJuS6+fRO5QrmUcQ1Z97UYKdk
	 Bp7tnkZC+RWFYEwuSEhtgYXkkS2oKZr2odBooOejxcTWImAvEM1sQvafsAyUnd1CkRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="eH/bAfY0";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13624606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 08:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eH/bAfY0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4761F000C1;
	Mon,  2 Nov 2026 08:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793607806;
	bh=0W7vYX2FrWSVGNVSfgrq9//jMplfVSp6vpvTJJUUr/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eH/bAfY0mXln9+ImOyjGZlYqAKd1kXIbRx1M8AigVEZmCPio6GN0cWlcFLblfImbL
	 4csCctt9gnl9GbGTvkEQ39VHmEtCVCdZm2p6GMKxslGpZo2DmI7RVcRHzUfYDPF2sz
	 I7GX+SxXwu35ziAo1AiyhLNq5HgQZt5SCH6uueUElsrvt1p8F0KG08jpIibDHrCDCg
	 tiKH3lsYaLByxDtgoDx6dJjZ/EjMCZl5wUjRJ85Gk6qFNTa9mfLPraFXGDzj+Cf+0i
	 OoTJQByI4g0tK6cuEdfNNW5DAcSb2iP9zcqWUhNHrojbBXCUornCz42D6Bq/aHiQEm
	 0BLIHXV7VqLkg==
Message-ID: <sashiko-outbox-193100@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v1 2/2] selftests/bpf: Handle unaligned access
 failure in fexit_bpf2bpf
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tiezhu Yang" <yangtiezhu@loongson.cn>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261102081230.7063-3-yangtiezhu@loongson.cn>
References: <20261102081230.7063-1-yangtiezhu@loongson.cn>
 <20261102081230.7063-3-yangtiezhu@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 08:23:26 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] selftests/bpf: fexit_bpf2bpf skips tests instead of aligning sub=
prog offset
- [Medium] selftests/bpf: get_unaligned_access_enabled() masks EACCES verif=
ier errors
--

commit 7711595f0d56f0638a8acca1420d5b1c4401c310
Author: Tiezhu Yang <yangtiezhu@loongson.cn>

selftests/bpf: Handle unaligned access failure in fexit_bpf2bpf

This commit adds a get_unaligned_access_enabled() helper and uses it in
fexit_bpf2bpf to skip subtests when bpf_prog_test_load() fails with -EACCES
and CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is not enabled.

> diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c b/too=
ls/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> index d2f2dcc0f2e11..1c0e93dcb3ce5 100644
> --- a/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
> +++ b/tools/testing/selftests/bpf/prog_tests/fexit_bpf2bpf.c
[ ... ]
> @@ -76,6 +77,11 @@ static void test_fexit_bpf2bpf_common(const char *obj_=
file,
> =20
>  	err =3D bpf_prog_test_load(target_obj_file, BPF_PROG_TYPE_UNSPEC,
>  			    &tgt_obj, &tgt_fd);
> +	if (err < 0 && errno =3D=3D EACCES && !get_unaligned_access_enabled()) {
> +		test__skip();
> +		return;
> +	}

[Severity: Medium]
Should the packet offset alignment in test_pkt_write_access_subprog() and
new_test_pkt_write_access_subprog() be constrained instead of skipping these
subtests in test_fexit_bpf2bpf_common() and test_fmod_ret_freplace()?

The five subtests (target_yes_callees, func_replace, func_replace_multi,
fmod_ret_freplace, and func_replace_global_func) test BPF-to-BPF fexit,
freplace, and fmod_ret rather than unaligned packet access.

In tools/testing/selftests/bpf/progs/test_pkt_access.c, the caller
test_pkt_access() passes a 2-byte-aligned packet offset (void *)tcp - data.
However, because test_pkt_write_access_subprog() is a global function, the
verifier checks it standalone with an arbitrary scalar off bounded only by
off <=3D 54:

tools/testing/selftests/bpf/progs/test_pkt_access.c:test_pkt_write_access_s=
ubprog() {
	...
	if (off > sizeof(struct ethhdr) + sizeof(struct ipv6hdr))
		return -1;

	tcp =3D data + off;
	if (tcp + 1 > data_end)
		return -1;
	/* make modification to the packet data */
	tcp->check++;
	...
}

And the replacement program in
tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c has the same pattern in
new_test_pkt_write_access_subprog():

tools/testing/selftests/bpf/progs/fexit_bpf2bpf.c:new_test_pkt_write_access=
_subprog() {
	...
	if (off > sizeof(struct ethhdr) + sizeof(struct ipv6hdr))
		return -1;

	tcp =3D data + off;
	if (tcp + 1 > data_end)
		return -1;

	/* make modifications to the packet data */
	tcp->check++;
	...
}

Skipping these tests in fexit_bpf2bpf drops fexit and freplace coverage on
strict-alignment architectures while leaving the other selftests that load
test_pkt_access.bpf.o (pkt_access, dynptr, kfree_skb, and prog_run_opts)
failing with the same -EACCES verifier error.

Would constraining the alignment of off (or performing a 1-byte modificatio=
n)
in test_pkt_write_access_subprog() and new_test_pkt_write_access_subprog()
allow all of these tests to run on strict-alignment systems?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/unpriv_helpers.c b/tools/testing=
/selftests/bpf/unpriv_helpers.c
> index c8dd5d8485841..54ce342b3fe41 100644
> --- a/tools/testing/selftests/bpf/unpriv_helpers.c
> +++ b/tools/testing/selftests/bpf/unpriv_helpers.c
> @@ -161,3 +161,8 @@ bool get_kasan_multi_shot_enabled(void)
>  {
>  	return cmdline_contains("kasan_multi_shot");
>  }
> +
> +bool get_unaligned_access_enabled(void)
> +{
> +	return config_contains("CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy") =
=3D=3D 1;
> +}

[Severity: Medium]
Can get_unaligned_access_enabled() cause test_fexit_bpf2bpf_common() and
test_fmod_ret_freplace() to mask genuine -EACCES verifier regressions as
skips?

In tools/testing/selftests/bpf/unpriv_helpers.c, open_config() returns NULL
and config_contains() returns -1 when neither /boot/config-$(uname -r) nor
/proc/config.gz is available in the test environment. Because
get_unaligned_access_enabled() checks for equality with 1, a -1 error return
is treated the same as CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS being disable=
d,
even on architectures where it is enabled.

In addition, EACCES is the generic error code returned by the BPF verifier =
for
most verification failures, and test_fexit_bpf2bpf_common() also loads targ=
et
objects that do not perform unaligned packet accesses
(./test_pkt_md_access.bpf.o, ./connect4_prog.bpf.o, and
./test_global_func7.bpf.o). Whenever get_unaligned_access_enabled() returns
false, wouldn't any verifier regression returning -EACCES in those programs=
 be
silently reported as skipped instead of failing?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102081230.7063=
-1-yangtiezhu@loongson.cn?part=3D2
