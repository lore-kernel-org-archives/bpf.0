Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A37C2E06E6
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 10:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862842; cv=none; b=mx1va7LtJ5r+dIG0AM3+6qgWR5X0iE4POyDx3Jqf4YeE1Nq9h14rJRMpEFhR56S9GCMGvzTU78+yJYRdeFxoubNlnZsYb/Pgi4Biq/gYeYSIYKmrp8cB5r+LdHtnFg5DpKIfFhWUAtHPyQbcDpxA6piSRPjxRHPygChLzdzo6fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862842; c=relaxed/simple;
	bh=8te18+CD3XuoM2CfKhMXH9rsBLTKikRpl4jckzV0adI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W70zBWwezUhGabMkIZNQJRUibZMFRgUiAYLmL6cmzJRfEq5DOy/pZKEi0xVphnLGFRfYjZcQiP3kwiYIR8U4UcmhHmoHUupnt1R/VvM/d9vol/h3ga1K+FXkb1PNhmE2aM8UwXDwohK+RaYheomL+q6f/B50g1J8ftCptOZCd6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F45bFhAp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F45bFhAp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 628911F00A3A;
	Tue,  8 Sep 2026 10:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788862840;
	bh=Mafs43cK5l+VO41ALxOqouDXMJzl3127/to+BqftRFk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F45bFhApbkrf0ldzFZIFU0a7cj3yjXXCu12xW2W+y6MdLalBOiqcAgH3TdCWrbccq
	 nb2/aLRGyQXwvNz/DikDHG5V9wZH5fTK/eGaQeRVl+fZnN6K2GHP1ReN1kt+PSeJFs
	 rmcHN6GmTUGw6VBjDqXKQWPjM5tZMFNmN6vrQodOmpMqkKZKusWBztBNvWlPx2/1Pn
	 78lZfdKH4IsWjd+/jaKDThKwtTbBGoRkOPMOLsqWMFWDxhgc/FTshydPZ7RIjUdgX7
	 C5Uo8QwrvfmuCp9ZfMUthjiaAR253YUpTSKBprVatZhrWulfQY3xnUSRMDr9T3lKp2
	 lztHdQyvhYIMg==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 6/8] selftests/bpf: add iocost cost model test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: tj@kernel.org, bpf@vger.kernel.org, mkoutny@suse.com, hannes@cmpxchg.org
In-Reply-To: <20260908100143.47598-7-cui.tao@linux.dev>
References: <20260908100143.47598-1-cui.tao@linux.dev>
 <20260908100143.47598-7-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 10:20:39 +0000
Message-Id: <20260908102040.628911F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The negative test case incorrectly checks the return value of `f=
printf` instead of `fclose` or `fflush`, causing the test to assert the wro=
ng condition and spuriously fail.
- [Medium] Interleaved input and output on the same stream in update mode w=
ithout an intervening file positioning function causes undefined behavior.
- [Low] Several multi-line comments do not follow the mandatory BPF subsyst=
em multi-line comment style.
--

commit 312862fd426ea5bb64f752670a814d2e20308af1
Author: Tao Cui <cuitao@kylinos.cn>

selftests/bpf: add iocost cost model test

This commit adds an example cost model implementing iocost_model_ops and a=
=20
runner that registers it as a struct_ops. The runner verifies readback and=
=20
ensures that writing to the cost model is properly rejected if no model is=
=20
registered.

> diff --git a/tools/testing/selftests/bpf/prog_tests/iocost_model.c b/tool=
s/testing/selftests/bpf/prog_tests/iocost_model.c
> new file mode 100644
> index 0000000000000..386026241d5b4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
> @@ -0,0 +1,124 @@
[ ... ]
> +static int switch_to_bpf(const char *dev)
> +{
> +	char path[] =3D "/sys/fs/cgroup/io.cost.model";
> +	char word[256], line[256], buf[300];
> +	FILE *fp;
> +	int err, found =3D 0;
> +
> +	fp =3D fopen(path, "r+");
> +	if (!fp) {
> +		TH_LOG("open %s: %s", path, strerror(errno));
> +		return -1;
> +	}
> +
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (sscanf(line, "%255s", word) =3D=3D 1 && !strcmp(word, dev)) {
> +			found =3D 1;
> +			break;
> +		}
> +	}
> +	if (!found) {
> +		TH_LOG("%s has no iocost line", dev);
> +		fclose(fp);
> +		return -1;
> +	}
> +
> +	snprintf(buf, sizeof(buf), "%s ctrl=3Dbpf", dev);
> +	err =3D fprintf(fp, "%s\n", buf);

[Severity: Medium]
Is an intervening file positioning function like fseek() or fflush() needed=
=20
here before calling fprintf()?

The C11 standard mandates an intervening call to a file positioning functio=
n=20
or fflush() between reading and writing when a stream is opened in update=20
mode ("r+"). Without it, stream buffer pointers can become corrupted, causi=
ng=20
the write to fail, be dropped, or write at an incorrect offset.

> +	if (err <=3D 0) {
> +		TH_LOG("write ctrl=3Dbpf failed");
> +		fclose(fp);
> +		return -1;
> +	}
> +	fflush(fp);
> +
> +	rewind(fp);
> +	found =3D 0;
> +	while (fgets(line, sizeof(line), fp)) {
> +		if (sscanf(line, "%255s", word) =3D=3D 1 && !strcmp(word, dev)) {
> +			found =3D strstr(line, "ctrl=3Dbpf") !=3D NULL;
> +			break;
> +		}
> +	}
> +	if (!found)
> +		TH_LOG("readback does not show ctrl=3Dbpf");
> +
> +	fprintf(fp, "%s ctrl=3Dauto\n", dev);

[Severity: Medium]
Similarly, is an fseek() or fflush() needed here between the fgets() read
loop and this fprintf() write to avoid undefined behavior?

> +	fclose(fp);
> +	return found ? 0 : -1;
> +}
[ ... ]
> +void serial_test_iocost_model(void)
> +{
> +	struct iocost_model *skel;
> +	char word[256], *dev;
> +	int err;
> +
> +	dev =3D getenv("IOCOST_TEST_DEV");
> +	if (!dev || geteuid() !=3D 0) {
> +		test__skip();
> +		return;
> +	}
> +	if (!ASSERT_TRUE(dev_has_iocost(), "iocost_mounted"))
> +		return;
> +
> +	/* negative: ctrl=3Dbpf must be rejected while no model is
> +	 * registered, so a typo cannot silently disable cost model
> +	 * updates */

[Severity: Low]
This isn't a bug, but does this violate the BPF subsystem multi-line comment
style?

The BPF guidelines specify that the opening /* should be on its own line:

/*
 * negative: ctrl=3Dbpf must be rejected while no model is
 * registered...

> +	if (sscanf(dev, "%255s", word) !=3D 1)
> +		return;
> +	{
> +		char path[] =3D "/sys/fs/cgroup/io.cost.model";
> +		char buf[300];
> +		FILE *fp =3D fopen(path, "w");
> +
> +		snprintf(buf, sizeof(buf), "%s ctrl=3Dbpf\n", word);
> +		err =3D 0;
> +		if (fp) {
> +			err =3D fprintf(fp, "%s", buf) <=3D 0;
> +			fclose(fp);
> +		}
> +		ASSERT_TRUE(err, "ctrl_bpf_without_model_rejected");

[Severity: Medium]
Should this error check evaluate the return value of fclose() or fflush()
instead of fprintf()?

Since fopen() on cgroupfs files defaults to full buffering, fprintf() will
merely copy data to the userspace buffer and return success. The actual
rejection from the kernel (-EINVAL) occurs during the write() syscall
triggered by fclose(). Checking fprintf() here might cause the test to asse=
rt
the wrong condition and spuriously fail.

> +	}
> +
> +	skel =3D iocost_model__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open_load"))
> +		return;
> +
> +	/* attaching the struct_ops registers the model; a second
> +	 * registration of the same ops would fail with EBUSY */

[Severity: Low]
This isn't a bug, but this comment also doesn't follow the preferred BPF
multi-line comment format where the /* sits on its own line.

> +	err =3D iocost_model__attach(skel);
> +	if (ASSERT_OK(err, "attach"))
> +		ASSERT_OK(switch_to_bpf(dev), "switch_and_readback");
> +
> +	iocost_model__destroy(skel);
> +}
> diff --git a/tools/testing/selftests/bpf/progs/iocost_model.c b/tools/tes=
ting/selftests/bpf/progs/iocost_model.c
> new file mode 100644
> index 0000000000000..70f7987f8eb6a
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/iocost_model.c
> @@ -0,0 +1,91 @@
[ ... ]
> +#define IOC_PAGE_SIZE		4096
> +#define IOC_SECT_TO_PAGE_SHIFT	3	/* 512B sectors to 4kB pages */
> +#define LCOEF_RANDIO_PAGES	4096	/* 16MB seek threshold */
> +#define IOCOST_COST_F_MERGE	(1ULL << 0)	/* not in BTF: a plain macro */
> +
> +/* DIV64_U64_ROUND_UP / DIV_ROUND_UP_ULL equivalents, folded at
> + * compile time */

[Severity: Low]
This isn't a bug, but this multi-line comment has the opening /* on the same
line as the text, which isn't the preferred style for the BPF subsystem.

> +#define RU(x, y)		((x) / (y) + (((x) % (y)) ? 1 : 0))
> +
> +#define RBPS	174019176ULL
> +#define RSEQIOPS	41708ULL

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908100143.4759=
8-1-cui.tao@linux.dev?part=3D6
