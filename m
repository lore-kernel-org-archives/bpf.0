Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793617395;
	b=CMXajPzKJWnwPy6mg8UInoJ5jLkeV/XluGDHZHTq4THJhTNEL47KVqPQ2QYagh6GrC+B
	 tNJmY4ABM8G28eF5Pcml6foVqayBRLecx59JUSDr0ortV+5Q5giPDrqJDy3rqxlznI+lA
	 95Gwh81Zf17LWSMKulBA25Md3LccuzTFCm/VDiLo1vIz8OmREbacrwRPt2UU9B3743w9i
	 0YK6RsY6/BeiXhM7qr0GWnCOifLzV9uKYdEoZDtBjK39hdURKWzWj+4ePyln3A/vYiYe7
	 uZgExhbUGWab0s/v0D8iV0O2t9vzJTQWqw/07y7dNcTEijmVur0cZjnlCWwZkHWiO3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793617395;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=gGvv1D3kz4yGFblt5aou1uFyOV+OwrUqmg2/eTEKzUM=;
	b=rcbC6GbqkhsHsl5DNv9g4vrNNt6+uC3dWhkR/kChOiZrR9+tTuA/EB/mR8y3ZPWrr5Pu
	 5jwfC9T9KokhcgOkV2V30qVr31rTWnX7DNyBPzkb1ixfbxHNMi1KuzMSoLaBTu6JYa4O+
	 0UtftP2DntY1IYTT5QjLECRQETATBD3eE8oBvtaaVDzEzrYRLdrXbwx0wDcKNacLEMJ9W
	 hyHL0EWauGAx/1g5tk01hP3jfKuj+cva2s5GX7uUTRK6ezv2zj1j7C2belykA4hS537AP
	 Db8l8kD3HIf7eDqkrsaliCO0b2ogBJLNunJ4Lk8Lmxj0QEIf6i4uf+0xVf7nz+kdu2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ok2+IPXy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF602606A324
	for <bpf@vger.kernel.org>; Mon,  2 Nov 2026 11:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ok2+IPXy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EE821F00A17;
	Mon,  2 Nov 2026 11:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793617393;
	bh=gGvv1D3kz4yGFblt5aou1uFyOV+OwrUqmg2/eTEKzUM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ok2+IPXyCupsnggF+YM/vJ1QwMXG9zOzcNPj6OQmuEufbaSjvyZTzz1i8AyX398yg
	 m8t/usUKXZJ2c87EpzD1i8HiFK2534y9sNpDpiZFvQpVZpXQdx86Tguyx/nSTJO64J
	 I/6dfTlY+7zqDmv1k8JwbBl6nPEGxPh20dDsJMwNE50C0YKgNHOWuzoZSowuIYBJK1
	 BanaUJrr7xT/b596G+sI/yKI4r+IQDvFYAlv7T7zltXZVwx2lEsoHTobOJOAhw0NRi
	 9SPtMTSc4H9XH1RowP9JU9elcRlBm51sfTSBJ+UzjRbTmu+V77kLdmpLM0JddFPj6h
	 QU4sQZI4gajmg==
Message-ID: <sashiko-outbox-193310@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH vfs-7.5.bpf v2 3/3] selftests/bpf: Test
 bpf_path_getattr()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anastasios Papagiannis" <tasos.papagiannnis@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261102104655.70901-4-tasos.papagiannnis@gmail.com>
References: <20261102104655.70901-1-tasos.papagiannnis@gmail.com>
 <20261102104655.70901-4-tasos.papagiannnis@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 11:03:13 +0000
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
- [Medium] selftests/bpf: missing CONFIG_OVERLAY_FS=3Dy in config for test_=
overlay()
- [Low] selftests/bpf: missing bpf_path_getattr() prototype in bpf_kfuncs.h
--

commit 17972af984223b5b9a2708744af62ce15fa7e1b6
Author: Anastasios Papagiannis <tasos.papagiannnis@gmail.com>

selftests/bpf: Test bpf_path_getattr()

This commit adds BPF selftests for the bpf_path_getattr() kfunc, comparing
its returned attributes with statx() across tmpfs and overlayfs and verifyi=
ng
its BPF verifier restrictions.

> diff --git a/tools/testing/selftests/bpf/prog_tests/path_getattr.c b/tool=
s/testing/selftests/bpf/prog_tests/path_getattr.c
> new file mode 100644
> index 0000000000000..6d8cabfd24c65
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/path_getattr.c
> @@ -0,0 +1,162 @@

[ ... ]

> +static void test_overlay(struct path_getattr *skel, const char *root)
> +{

[ ... ]

> +	snprintf(opts, sizeof(opts), "lowerdir=3D%s,upperdir=3D%s,workdir=3D%s,=
xino=3Doff",
> +		 lower, upper, work);
> +	if (mount("overlay", merged, "overlay", 0, opts)) {
> +		if (errno =3D=3D ENODEV || errno =3D=3D EOPNOTSUPP) {
> +			printf("%s:SKIP: overlayfs unavailable: %s\n",
> +			       __func__, strerror(errno));
> +			test__skip();
> +			goto out_lower;
> +		}

[Severity: Medium]
Should CONFIG_OVERLAY_FS=3Dy be added to tools/testing/selftests/bpf/config
so the overlay subtest in test_path_getattr() -> test_overlay() is not
skipped on standard BPF selftest kernels?

The shared tools/testing/selftests/bpf/config enables CONFIG_TMPFS=3Dy and
CONFIG_FS_VERITY=3Dy for filesystem kfunc tests, while CONFIG_OVERLAY_FS=3D=
y is
only present in tools/testing/selftests/bpf/config.aarch64. When running on
kernels built from the BPF selftest config on x86_64, s390x, riscv64, or
ppc64el, mount("overlay", ...) fails with ENODEV and skips test_overlay().

[ ... ]

> diff --git a/tools/testing/selftests/bpf/progs/path_getattr.c b/tools/tes=
ting/selftests/bpf/progs/path_getattr.c
> new file mode 100644
> index 0000000000000..509cf13a00479
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/path_getattr.c
> @@ -0,0 +1,42 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <vmlinux.h>
> +#include <bpf/bpf_helpers.h>
> +#include <bpf/bpf_tracing.h>
> +#include "bpf_kfuncs.h"

[ ... ]

> +SEC("lsm.s/inode_getattr")
> +int BPF_PROG(path_getattr, const struct path *path, int ret)
> +{
> +	struct kstat stat =3D {};
> +
> +	if (ret || (__u32)bpf_get_current_pid_tgid() !=3D monitored_tid || call=
s)
> +		return ret;
> +	calls++;
> +	getattr_ret =3D bpf_path_getattr(path, request_mask, 0, &stat, sizeof(s=
tat));

[Severity: Low]
Both tools/testing/selftests/bpf/progs/path_getattr.c and
tools/testing/selftests/bpf/progs/verifier_path_getattr.c include
bpf_kfuncs.h and call bpf_path_getattr(), which is only built into the
kernel when CONFIG_BPF_LSM=3Dy.

All other filesystem kfuncs from fs/bpf_fs_kfuncs.c are declared with
__ksym __weak in tools/testing/selftests/bpf/bpf_kfuncs.h:

    extern int bpf_get_dentry_xattr(struct dentry *dentry, const char *name=
__str,
                                    struct bpf_dynptr *value_p) __ksym __we=
ak;
    ...
    extern int bpf_inode_init_xattr(struct xattr *xattrs, int *xattr_count,
                                    const char *name__str,
                                    const struct bpf_dynptr *value_p) __ksy=
m __weak;

Should bpf_path_getattr() also be declared in
tools/testing/selftests/bpf/bpf_kfuncs.h so compilation does not fail when
vmlinux.h is generated without CONFIG_BPF_LSM=3Dy or compiled with
BPF_NO_KFUNC_PROTOTYPES?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102104655.7090=
1-1-tasos.papagiannnis@gmail.com?part=3D3
