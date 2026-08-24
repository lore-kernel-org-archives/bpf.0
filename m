Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3DC444A3E8
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787586066; cv=none; b=KVIWYgwwpJ2VZ/wzpXP17fwesxyrN1OU9FsRaPLIRlA9xokdTdTBnvW6ZBnSiysUwcXKBF7aCmgu/tydM5HDi/1pQbWxWQ1jEFUIfHsaM3x5Gx+hHT8Cn/F20qS63UO6KbbyGeYjSkbwtZ1vRabssUiSuePXCjPxpel74eRGq+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787586066; c=relaxed/simple;
	bh=kDp+HmrajfIyPpvqgGNMXxHc/clICS7CUUov5AlOHeE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=twnd8QJ1GHBgddqa/PL8igA1OkZfuzgTjy0EzIhB9t3iXo2WB3SuV674BsALDPiFwglxeZVuR1bWwqXLVvYG2oFTaa/KzSdaj6z+35ap8xhv5Liwrv0864u1RzV3RFSV9a9KseirzI2nv9ey4wNDulNKjKccyPHbmASKbiQNUfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWHxUkAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWHxUkAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0401F000E9;
	Mon, 24 Aug 2026 15:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787586059;
	bh=9CRAvXtGGIineNs2nIubMJOR7yDb+QHAQfh5i40WDcM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gWHxUkAsXsXdGu8w98x1Xo+MGnCA/w5ui6XMNJFlMu8YH2OJbsr64noQsW6p2OQEA
	 jJlMcqWWOI3yRhAdZcXeX37dwzSV9W7ehzYdWd+A4I3gxXQuiLjO05K2kKbr6J1qQd
	 W3I3xS4Ll7TL3LWKFyacOPSr7AMPQKCfNkd6VDSXGlOKWdNA1m962zTFfBTXqyRh1r
	 TDdG7DQPbdmOJauI/mDcz2xpLFDJz/gdTt3dMK/WBFVIlQnlBhdc0E6Ul12ymwMrBg
	 Ysv9RfNwzKFDlXBHTcxrVvgLUPgtiUrGYl4aBmFWUVFq1Trbna/7H9eWkMn+cTm/Qm
	 C8s8Za2byJgFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] selftests/bpf: Test rhtab special-field
 combinations
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824143621.2098856-5-chenyuan_fl@163.com>
References: <DKM6K95EN9OF.3O9XNYWVLYHDE@gmail.com>
 <20260824143621.2098856-1-chenyuan_fl@163.com>
 <20260824143621.2098856-5-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 15:40:58 +0000
Message-Id: <20260824154059.1E0401F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] Passing an undersized buffer to `bpf_map_update_elem` causes an =
out-of-bounds read on the userspace stack.
- [Medium] Missing file descriptor validation after manual BPF program look=
up.
- [Medium] The timer cancellation test is ineffective because it attempts t=
o cancel a one-shot timer that has already expired.
- [Low] Multi-line comment does not follow the mandatory BPF subsystem styl=
e.
--

--- Patch [4]: [PATCH 4/4] selftests/bpf: Test rhtab special-field combinat=
ions ---
commit 97a820b266ff0381e757c9ee521aee4aca7caef2
Author: Yuan Chen <chenyuan@kylinos.cn>

selftests/bpf: Test rhtab special-field combinations

This commit adds selftests for BPF_MAP_TYPE_RHASH special-field combination=
s,
verifying the recycling of memory for various field types like spin locks,
timers, and kptrs.

> diff --git a/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c b/tool=
s/testing/selftests/bpf/prog_tests/rhtab_fields.c
> new file mode 100644
> index 0000000000000..29de05bcbd4b0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/rhtab_fields.c

[ ... ]

> @@ -28,34 +28,45 @@ static int run_prog(struct rhtab_fields *skel, const =
char *name)
>  {
>  	LIBBPF_OPTS(bpf_test_run_opts, topts);
>  	struct bpf_program *prog;
>  	int err;
> =20
>  	prog =3D bpf_object__find_program_by_name(skel->obj, name);
>  	if (!ASSERT_OK_PTR(prog, name))
>  		return -1;
>  	err =3D bpf_prog_test_run_opts(bpf_program__fd(prog), &topts);

[Severity: Medium]
Is it necessary to validate the file descriptor returned by bpf_program__fd=
()
before using it? According to BPF selftest patterns, file descriptors from
manual lookups should be verified (>=3D 0) before use, as they can return a
negative value if the program is invalid.

>  	if (!ASSERT_OK(err, name))
>  		return -1;
>  	return topts.retval;
>  }
> =20
>  static void recycle_loop(struct rhtab_fields *skel, int map_fd,
>  			 const char *init, const char *del,
>  			 const char *upd, const char *probe)
>  {
>  	u64 zero =3D 0;
>  	u32 key =3D 0;
>  	int i;
> =20
>  	for (i =3D 0; i < RECYCLE_LOOPS; i++) {
>  		if (run_prog(skel, init) !=3D 0) {
>  			/* Element may be gone; recreate and retry once. */
>  			if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &zero, BPF_ANY),

[Severity: Medium]
Could this result in an out-of-bounds read on the userspace stack? The zero
variable is 8 bytes, but this function is called for maps like lkmap which
expects a 24-byte value structure. bpf_map_update_elem() will read
map->value_size bytes from this pointer.

>  				       "recreate_elem"))
>  				return;

[ ... ]

> @@ -119,25 +130,24 @@ static void subtest_timer(struct rhtab_fields *skel)
>  {
>  	u64 zero =3D 0;
>  	u32 key =3D 0;
>  	int fired, map_fd;
> =20
>  	map_fd =3D bpf_map__fd(skel->maps.tmap);
>  	if (!ASSERT_OK(bpf_map_update_elem(map_fd, &key, &zero, BPF_ANY),

[Severity: Medium]
Could this also lead to an out-of-bounds read? The tmap map value
(struct timer_val) is 24 bytes in size, but it's being updated from the
8-byte zero variable.

>  		       "create_elem"))
>  		return;
> =20
>  	if (!ASSERT_OK(run_prog(skel, "arm_timer"), "arm_timer_first"))
>  		return;
>  	usleep(300000);
>  	if (!ASSERT_GT(skel->bss->timer_fired, 0, "timer_fired_first"))
>  		return;
> =20
>  	/* Deleting the element must cancel the timer. */
>  	fired =3D skel->bss->timer_fired;
>  	if (!ASSERT_OK(bpf_map_delete_elem(map_fd, &key), "delete_elem"))
>  		return;
>  	usleep(300000);
>  	ASSERT_EQ(skel->bss->timer_fired, fired, "timer_cancelled_after_delete"=
);

[Severity: Medium]
Does this assertion actually test the cancellation of the timer? Since
arm_timer() sets a 50us one-shot timer and this code sleeps for 300ms
before calling bpf_map_delete_elem(), the timer has already fired by the
time the element is deleted.

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/rhtab_fields.c b/tools/tes=
ting/selftests/bpf/progs/rhtab_fields.c
> new file mode 100644
> index 0000000000000..85335f19f1722
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/rhtab_fields.c

[ ... ]

> @@ -89,20 +89,20 @@ struct {
>  	__uint(max_entries, 9);
>  	__type(key, __u32);
>  	__type(value, __u64);
>  } counters SEC(".maps");
> =20
> +/* 0: lk init ok, 1: lk probe xchg non-NULL, 2: lk probe xchg NULL,
> + * 3: lk probe magic ok, 4: u init ok, 5: u probe ptr non-NULL,
> + * 6: pc init ok, 7: pc probe xchg non-NULL, 8: pc probe xchg NULL
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment format violate the
BPF subsystem style? BPF subsystem multi-line comments should have the open=
ing
/* on its own line.

>  static __always_inline void bump(u32 idx)
>  {
>  	u64 *v =3D bpf_map_lookup_elem(&counters, &idx);
> =20
>  	if (v)
>  		(*v)++;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824143621.2098=
856-1-chenyuan_fl@163.com?part=3D4
