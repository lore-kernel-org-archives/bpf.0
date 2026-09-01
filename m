Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ED4835E1BC
	for <bpf@vger.kernel.org>; Tue,  1 Sep 2026 06:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244904; cv=none; b=J7EN6J3SfmyAjxhLNL/vzC1WGOcliOPfNzjXHvIkU/IYutX3/8E3udame3bn6xjw5ypbYRADx3kS0MtiJdob0hOr1gSGgCEfFCNi9EGKxk5iSwSFtzV7YQzymYvxJB/GTjHDnRxCZHJQ8UjSYHzKD0sIlP4xsOkQeekgQbHnYQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244904; c=relaxed/simple;
	bh=+LA7BsNK4UpYctj67vOq63JX76iehygIUcCvGspx5rQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=P4z7GQ2kGjk8w6y7yQY0uY+b7TgF1+Yy91OWm7OP/o4/glJh1enue08B3jv+RZFRfOHdnUdfC1UFr7qOZ2JqmnktwKikOdKg0vFhz8fDF8efpKfSxqsUNSNobBycYTDVpQkRoKz0ySnlO0k/w2MY5nC2XeaaFA857aI6CE4quxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KqWqvMr2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KqWqvMr2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFEED1F000E9;
	Tue,  1 Sep 2026 06:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788244902;
	bh=KsM2RpaQ5Php2MTwunTKMJPWn+cm/4CfkdQd2isBn/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KqWqvMr2C13rrXwVLO3ubsPjRtUIB8YuDj1Dipj7O8Um/WGeG8oDYdkY9VV54fh2W
	 pTaDcZok2lAPnKF1Om455ilusyyzkheOZjv/l1wYLZLKAGeEbRnQjda2a8hknISDc4
	 VzhGUePBLz+SpC0MFRGmqTTsT7LyTGCcQ/ECYwK5JCOHdFXw4WSITfvN0IYjKusdWL
	 4p9dn9HpY3wJqTPoNJlP5eh/5vOoppVksDZlHNPkpZnpJraERc8Y7hBmM97f8+oiRE
	 SEosInbk3pzKg1pVFvtWOv6Twv3DMW0I5sOt9K28YXC9Ud6GapIzPaCWbFS1yn9Ngh
	 twqfgU7ebDPXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v3 4/4] selftests/bpf: Test rhtab special-field
 combinations
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260901062845.1379760-5-chenyuan_fl@163.com>
References: <0560a24d-2cf9-4e5b-aa61-580af1e56de1@gmail.com>
 <20260901062845.1379760-1-chenyuan_fl@163.com>
 <20260901062845.1379760-5-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 06:41:42 +0000
Message-Id: <20260901064142.BFEED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Missing file descriptor validation after manual program lookup.
- [Low] Multi-line comments violate the modern BPF kernel comment style by =
placing text on the opening line.
--

commit c8d6d3baf7be1c36675cff2687886747c8f66dba
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: Test rhtab special-field combinations
   =20
This commit introduces tests for BPF_MAP_TYPE_RHASH with different special
field combinations like spin locks, timers, and kptrs. It verifies element
recycling behavior and ensures references are correctly maintained.

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c b/tool=
s/testing/selftests/bpf/prog_tests/rhtab_fields.c
> new file mode 100644
> index 0000000000000..93e8cbacca656
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c
> @@ -0,0 +1,337 @@
[ ... ]
> +/* Userspace view of the lkmap value. The BPF side owns the real layout;
> + * the spin lock and the kptr are special fields that value copies skip,
> + * so only the plain bytes actually matter here.
> + */

[Severity: Low]
This isn't a bug, but does this violate the modern kernel multi-line comment
style?

The preferred BPF style requires the opening /* to be on its own line. There
are several multi-line comments in this patch (both here and in
tools/testing/selftests/bpf/progs/rhtab_fields.c) that put text on the same
line as the opening /*.

[ ... ]
> +static int run_prog(struct rhtab_fields *skel, const char *name, int *re=
tval)
> +{
> +	LIBBPF_OPTS(bpf_test_run_opts, topts);
> +	struct bpf_program *prog;
> +	int err;
> +
> +	prog =3D bpf_object__find_program_by_name(skel->obj, name);
> +	if (!ASSERT_OK_PTR(prog, name))
> +		return -1;
> +	err =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);

[Severity: Medium]
When manually looking up a program with bpf_object__find_program_by_name(),
bpf_program__fd() can return a negative value if the program is not valid.

Could we pass a negative file descriptor into bpf_prog_test_run_opts() here
if that happens? Should we validate the file descriptor with ASSERT_GE()
before using it?

> +	if (!ASSERT_OK(err, name))
> +		return -1;
> +	if (retval)
> +		*retval =3D topts.retval;
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901062845.1379=
760-1-chenyuan_fl@163.com?part=3D4
