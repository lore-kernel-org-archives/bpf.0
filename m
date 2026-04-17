Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4833B2857EE
	for <bpf@vger.kernel.org>; Fri, 17 Apr 2026 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776395315; cv=none; b=QNa1ivdIRd//BeQ9H1W7l3oXToNonD8ohxGTC0WNWyOCrMzUATsy9YWwxo6H2hpk4K+5b8mrhVl1IfRFIMn7ApSvdDDFR0XDEZ75NaHZPEy6YHpmwYGw0qoNlUxitFL5NroP5btjNjQIW/RRoJ3n2cUKIjgXfe7KRtKwwu/LFrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776395315; c=relaxed/simple;
	bh=qPlTbEZw35AsBE/G7ZHRttLjCnYveS+K3cvQbHTG8xk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XBuEnKvoTCEDMlxumEwrdrxi3VII+D9LKP+sUZa9Z91UEry9EOtk23BZneJD6hMjTPe2TdWQRlkua27XHhFh8pxyG7/+Eedcxg1R+cRCGed333QqBDXofhhJO04gXKQNMLZTknzsWmIL89FMESxXfgCa/gvM2Z1ASooST8l0loc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FJimC2q6; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FJimC2q6"
Message-ID: <d3560ae4d662400e64b1cc72b84e3836b7bc371a.camel@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776395302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7RBHgDM72E4FFRUPPk/y4OrCekuqa2O/ftWhf5CuOtM=;
	b=FJimC2q6T7NSgxyJH739fNQrfVEGxPCogVc/rCWcdC3Z5b7MkYez+QRdKhbMXJTr3pPEhk
	VGy9xapTeyEHv3OKImdvFDakF8dLrX2x5yxYlCOTMlOBhud8DUA9fuwcVZh1PvhzmBJxc1
	+mAso4Ufu3IYv8aB0QJeeQWU8Ezqs98=
Subject: Re: [PATCH bpf v2 2/2] selftests/bpf: Test TCP_NODELAY in TCP hdr
 opt callbacks
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: KaFai Wan <kafai.wan@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me, 
 ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, 
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 davem@davemloft.net,  edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org,  shuah@kernel.org,
 jiayuan.chen@linux.dev, bpf@vger.kernel.org,  netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-kselftest@vger.kernel.org
Date: Fri, 17 Apr 2026 11:07:50 +0800
In-Reply-To: <2026416184330.-HAW.martin.lau@linux.dev>
References: <20260416112308.1820332-1-kafai.wan@linux.dev>
	 <20260416112308.1820332-3-kafai.wan@linux.dev>
	 <2026416184330.-HAW.martin.lau@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Migadu-Flow: FLOW_OUT

On Thu, 2026-04-16 at 12:06 -0700, Martin KaFai Lau wrote:
> On Thu, Apr 16, 2026 at 07:23:08PM +0800, KaFai Wan wrote:
> > index 56685fc03c7e..2d738c0c4259 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/tcp_hdr_options.c
> > @@ -513,6 +513,59 @@ static void misc(void)
> > =C2=A0	bpf_link__destroy(link);
> > =C2=A0}
> > =C2=A0
> > +static void hdr_sockopt(void)
> > +{
> > +	const char send_msg[] =3D "MISC!!!";
> > +	char recv_msg[sizeof(send_msg)];
> > +	const unsigned int nr_data =3D 2;
> > +	struct bpf_link *link;
> > +	struct sk_fds sk_fds;
> > +	int i, ret, true_val =3D 1;
> > +
> > +	lport_linum_map_fd =3D bpf_map__fd(misc_skel->maps.lport_linum_map);
> > +
> > +	link =3D bpf_program__attach_cgroup(misc_skel->progs.misc_hdr_sockopt=
, cg_fd);
> > +	if (!ASSERT_OK_PTR(link, "attach_cgroup(misc_hdr_sockopt)"))
> > +		return;
> > +
> > +	if (sk_fds_connect(&sk_fds, false)) {
> > +		bpf_link__destroy(link);
> > +		return;
> > +	}
> > +
> > +	ret =3D setsockopt(sk_fds.active_fd, SOL_TCP, TCP_NODELAY, &true_val,=
 sizeof(true_val));
> > +	if (!ASSERT_OK(ret, "setsockopt(TCP_NODELAY) active"))
> > +		goto check_linum;
> > +
> > +	ret =3D setsockopt(sk_fds.passive_fd, SOL_TCP, TCP_NODELAY, &true_val=
, sizeof(true_val));
>=20
> Why are these two setsockopt(TCP_NODELAY) calls needed?
>=20
> Instead of creating a new "void hdr_sockopt(void)", can the test be done =
in the
> existing "void misc(void)" by doing bpf_setsockopt(TCP_NODELAY) in the
> misc_estab() bpf prog?

Oh, I see.=C2=A0I meant to test on both active and passive side. We can onl=
y test on active side in the
existing "void misc(void)".
>=20
> The PASSIVE_ESTABLISHED_CB can do the bpf_setsockopt(TCP_NODELAY, 0)
> if it wants to keep the same expectation on Nagle. The
> BPF_SOCK_OPS_HDR_OPT_LEN_CB and BPF_SOCK_OPS_WRITE_HDR_OPT_CB
> can do bpf_setsockopt(TCP_NODELAY, 1) to test recursion and
> the error return value.
>=20
> > =C2=A0void test_tcp_hdr_options(void)
> > diff --git a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_option=
s.c
> > b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> > index d487153a839d..a8cf7c4e7ed2 100644
> > --- a/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> > +++ b/tools/testing/selftests/bpf/progs/test_misc_tcp_hdr_options.c
> > @@ -28,6 +28,12 @@ unsigned int nr_data =3D 0;
> > =C2=A0unsigned int nr_syn =3D 0;
> > =C2=A0unsigned int nr_fin =3D 0;
> > =C2=A0unsigned int nr_hwtstamp =3D 0;
> > +unsigned int nr_hdr_sockopt_estab =3D 0;
> > +unsigned int nr_hdr_sockopt_estab_err =3D 0;
> > +unsigned int nr_hdr_sockopt_len =3D 0;
> > +unsigned int nr_hdr_sockopt_len_err =3D 0;
> > +unsigned int nr_hdr_sockopt_write =3D 0;
> > +unsigned int nr_hdr_sockopt_write_err =3D 0;
>=20
> nr_hdr_sockopt_estab, nr_hdr_sockopt_len, and nr_hdr_sockopt_write
> are unnecessary. These tests have already been covered in some ways.

yes, they are unnecessary in existing misc_estab()
>=20
> Mostly a nit. The new counters are used in both connections. Note the
> existing nr_xxx is exclusively used in either active or passive,
> so there is no parallel counting in practice.
>=20
> Instead of counting, just use a bool nodelay_est_ok,
> nodelay_hdr_len_err, nodelay_write_err and assert them
> to be true in userspace.

indeed. will fix these in next version.

--=20
Thanks,
KaFai
