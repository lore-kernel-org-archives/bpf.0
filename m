Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795009269;
	b=nh0GfEdCz6WLKnnN5p17Zx182joqfL6zbHZzlCvdqZr+jZzzjVUp14vtRc6pPliUzDhF
	 KufUecB4cwtvAO9UZr6Xu2wUujBMoPICVcH8PEA38VzSytlrTRFznM0A2QQjp2ImkLfY3
	 fceLhA6KKhFDEyJ9QK2lyQke/Edu+PV2mKmU5fGa916qX3HQEfZ7jqO9pL8t5FwkggZYs
	 7odbtRAP2hdKKPH9vSEcuTtavY+JLeMQfl5iIb9sJJ5Dwj2yy0lMNDHAK/buiARQ9n0ae
	 0MumWNzuy33risULIpWspw9vH0T0vxSXX/ylKTjPrLHQrM0aCinjeqqmSn8W6Rt6lSA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795009269;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UT7QiqHDaSMeRbrm9j69O8HfZ1aUJbjp72iuovVz/JI=;
	b=Q16u2U2e9vDHojMy8+MsOMfXQSAY90PwnW3Vym+yBtZGLGXeUS+N9ePR0y9ZIMoYC/Ga
	 7K/Y20IcXdd160fyVjBYaUGJd+UD0n8ZrNO+jOeZLHdAZiT+KCYB3qPNVzUSIFpxXZDv4
	 KBONYAcC/gD2WCfXmqIQXJCee6cVkm73g2VkHOnhZDdk9Qzzvw5Aa76V5GdpYyBUTfO/S
	 ixQ05whhDIedDx8/fSrgAyXyakknuNSZC2WM4HXfGN3g1+1in5/O+D2OmCBM8TGxNsKHn
	 YNAEW+YJya3zbwyGuSDaWtoTRvQJXrKNAfv0rEiPxYq/cHwZ3G3+MEoEBf1RiJo0F8w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iaUhBJsh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36F606A338
	for <bpf@vger.kernel.org>; Wed, 18 Nov 2026 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iaUhBJsh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973AD1F000CA;
	Wed, 18 Nov 2026 13:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795009268;
	bh=UT7QiqHDaSMeRbrm9j69O8HfZ1aUJbjp72iuovVz/JI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iaUhBJshYL53T4aIbLLmHwjBbtgyNCS9Th6oJs5R9wgkndxTvdRjoCisv0xjOCB2b
	 yfkZS+AMRbnSPjNoycU0Xs9XhmFlcAZuPc37NIozp3RIXASY+nzhAU579Qch/+l7ic
	 lIiYu2fdIJbSGOKDAFK50OPoYFqmsxoawlQw4NRKkyMljyooZs9FeQSNDkkcef95Hn
	 UHv2ck6TO8hRZ3F++EkQp4prNedEaPa38RN6OHAv/AxP3e+hGktI8JqLhIv7SqJqEZ
	 sE/GYK7/7ImyjGzi/NFdPBGkvWC2hI1Tt2RuxxPvUAnXpDTNQua4JIcgTQzJskRBEj
	 BbMzAJMXxAJuQ==
Message-ID: <sashiko-outbox-221050@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v14 3/4] selftests/bpf: add iocost cost model test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com
In-Reply-To: <20261118131029.797007-4-cui.tao@linux.dev>
References: <20261118131029.797007-1-cui.tao@linux.dev>
 <20261118131029.797007-4-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 13:41:08 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] selftests/bpf: iocost_test_env() hardcodes /sys/fs/cgroup
  without mounting
- [Low] selftests/bpf: open_nullb_dev() callers check -errno instead of
  fd
--

commit 7c8a11566574f6e4224eb8a8a97b22da0b3eb991
Author: Tao Cui <cuitao@kylinos.cn>

selftests/bpf: add iocost cost model test

This commit adds two BPF struct_ops iocost cost models and selftests that
attach them to a configfs-created null_blk device and verify model
selection, IO pricing, tracepoint firing, and device removal.

> diff --git a/tools/testing/selftests/bpf/prog_tests/iocost_model.c b/tool=
s/testing/selftests/bpf/prog_tests/iocost_model.c
> new file mode 100644
> index 0000000000000..0fbaeb7c5b7ef
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
[ ... ]
> +/* open the nullb device node, creating it manually when udev hasn't */
> +static int open_nullb_dev(const char *name, int flags)
> +{
> +	char path[32], syspath[64], devtok[32];
> +	unsigned int maj, min;
> +	dev_t dev;
> +	struct stat st;
> +	int fd;
> +
> +	snprintf(syspath, sizeof(syspath), "/sys/block/%s/dev", name);
> +	if (read_file_token(syspath, devtok, sizeof(devtok)) ||
> +	    sscanf(devtok, "%u:%u", &maj, &min) !=3D 2)
> +		return -1;
> +	dev =3D makedev(maj, min);
> +
> +	snprintf(path, sizeof(path), "/dev/%s", name);
> +	fd =3D open(path, flags);
> +	if (fd >=3D 0 && fstat(fd, &st) =3D=3D 0 && S_ISBLK(st.st_mode) &&
> +	    st.st_rdev =3D=3D dev)
> +		return fd;
> +	if (fd >=3D 0) {
> +		/* a stale node from a previous run, drop and recreate */
> +		close(fd);
> +		fd =3D -1;
> +	}
> +	if (unlink(path) && errno !=3D ENOENT)
> +		return -1;
> +	if (mknod(path, S_IFBLK | 0600, dev))
> +		return -1;
> +	fd =3D open(path, flags);
> +	if (fd < 0)
> +		unlink(path);
> +	return fd;
> +}

[Severity: Low]
Can ASSERT_OK(devfd < 0 ? -errno : 0, ...) in serial_test_iocost_model()
and serial_test_iocost_model_streams() pass when open_nullb_dev() fails?

If read_file_token() hits EOF without setting errno, sscanf() fails to
match two tokens, or unlink(path) succeeds and leaves errno at 0 after
the second open() fails, open_nullb_dev() returns -1 with errno =3D=3D 0.
The callers then pass 0 to ASSERT_OK() and proceed to call
posix_fadvise(), read(), pread(), and close() on fd -1.  Using
ASSERT_OK_FD(devfd, ...) in the callers (or returning a negative error
code from open_nullb_dev()) would catch any failure directly.

[ ... ]
> +static bool iocost_test_env(void)
> +{
> +	static bool ready;
> +	struct statfs sf;
> +	int orig_ns =3D -1, supported;
> +	bool ok =3D false;
> +
> +	if (geteuid() !=3D 0) {
> +		printf("%s:SKIP:needs root\n", __func__);
> +		test__skip();
> +		return false;
> +	}
> +
> +	if (statfs("/sys/fs/cgroup", &sf) ||
> +	    sf.f_type !=3D CGROUP2_SUPER_MAGIC) {
> +		printf("%s:SKIP:needs cgroup v2 at /sys/fs/cgroup\n",
> +		       __func__);
> +		test__skip();
> +		return false;
> +	}
[ ... ]
> +	/*
> +	 * Isolate the configfs and cgroup mounts from the host. A
> +	 * failed setup unwinds the namespace so that a later retry does
> +	 * not stack private namespaces.
> +	 */
> +	orig_ns =3D open("/proc/self/ns/mnt", O_RDONLY);
> +	if (unshare(CLONE_NEWNS) ||
> +	    mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
> +		printf("%s:SKIP:cannot make mounts private: %s\n",
> +		       __func__, strerror(errno));
> +		test__skip();
> +		goto out;
> +	}
> +	mkdir("/sys/kernel/config", 0755);
> +	(void)mount("none", "/sys/kernel/config", "configfs", 0, NULL);

[Severity: Medium]
Will all three iocost tests skip when /sys/fs/cgroup is not already a
cgroup2 mount or after an earlier cgroup v1 test runs in the same
test_progs process?

iocost_test_env(), cgroupfs_has_controller(), readback_model(),
write_cost_model(), and the io.cost.qos writes all access /sys/fs/cgroup
directly without mounting cgroup2 there, while cgroup_setup_and_join() in
tools/testing/selftests/bpf/cgroup_helpers.c mounts cgroup2 at /mnt
(CGROUP_MOUNT_PATH).  In addition, setup_classid_environment() in
cgroup_helpers.c mounts tmpfs at /sys/fs/cgroup (CGROUP_MOUNT_DFLT) and
cleanup_classid_environment() leaves that tmpfs mounted:

tools/testing/selftests/bpf/cgroup_helpers.c:setup_classid_environment() {
	...
	if (mount("tmpfs", CGROUP_MOUNT_DFLT, "tmpfs", 0, NULL) &&
	    errno !=3D EBUSY) {
		log_err("mount cgroup base");
		return 1;
	}
	...
}

When a test using setup_classid_environment() runs before
serial_test_iocost_model*, statfs("/sys/fs/cgroup", &sf) sees TMPFS_MAGIC
instead of CGROUP2_SUPER_MAGIC and skips the tests.  Using the cgroup2
mount managed by cgroup_helpers.c (via get_root_cgroup() or
write_cgroup_file("", ...) / read_cgroup_file("", ...)), or mounting
cgroup2 inside the private mount namespace created by iocost_test_env(),
would avoid relying on the host's /sys/fs/cgroup mount state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118131029.7970=
07-1-cui.tao@linux.dev?part=3D3
