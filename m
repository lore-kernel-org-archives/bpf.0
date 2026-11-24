Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.120
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795525638;
	b=KayScZuZ/ojsf4GXqTHleIJI+ZchYDJ5ivXLxWGkFbhFHGCn/3mrAAWJTlOMuhUYI5sb
	 qNe+awgoX0O8RBjfdQL2ME3lFH5E2QBg4ulSYfajRghv2d244OXNCqg5JlqlQFGL7lOH7
	 bngZPM2d4TAuYn/uZY5OUvEpj+/nFKNihTNwFC1HSRS05XsW7BknbHLSsBayRgB0fM9yY
	 ga5/kHiQOsMkIqqJmNrzi0zzYKuaLvaMMJfsFpZteafoqnq9MM3VEWQrfsYhqm8wnSzr3
	 75Ttjx5Wpk+Wvy6x/Ez3ZPvlhBNIYMmO+dvtH3C28ZdsoAlsPIK43pcd6WP4XjKDBfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795525638;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=OGZXgnfgRgczMbRxdKzz5YNMHRIhhkydTMZM2uhd6is=;
	b=5odoC2DkMhrGQ2DPA7ot01SMPoYeu1dMw/kl42O54ylMn29v4vOnAp7Qr335g0ffKHvq
	 XDIAeuN65tXs0cW7K5Hy9WL+o0PX59xXwkKUtgsRverzv1GBiEsVzlDrOfYeNBUEz7p29
	 py/hI6YNoajHxDe9IXNtkaUwjdNrJpeuCXfn9dz/eyIFuzhx6m2uaGSJEyMu4PHfDo2O+
	 nGlnxRniRnBnuAVcHoeMxpL2+SVzbG9JCL/JuXBbos1rYGLBo5iSydOahTOGaOtMYmmSi
	 sfDHKT9T3g55YZ/FO6YoX86KM4UgaZyGSjUd1wsoJioIHM6KFEPW71/oVNMgC/Y7Dsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A18EvcUC;
	arc=none smtp.remote-ip=95.215.58.120
Received: from mta1.migadu.com (out-120.mta1.migadu.com [95.215.58.120])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB28606A321
	for <bpf@vger.kernel.org>; Tue, 24 Nov 2026 13:07:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4BB28606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=A18EvcUC
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=n3QCrIbcPMvCGHu60XljvMPoh4Nl+HXMssIukfe4cX0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1795525635; v=1; x=1796130435;
 b=A18EvcUCcAsc5b5sW8FrRWkWIUwnhlal65rFjgyFiT9VRRcoJvhqrd/f6KOo0kun2erkrP7c
 jGU6GEBzq7E4aZHHHSrhw2+g4caOUnyLiEdYEvp9nxpLejjQIuBR5Mig6IpPStIXa6Z3VC/Ny0L
 fjF2t+ro9ShF6ottCDZvxIPs=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 8ce8cdb92deed85a;
	Tue, 24 Nov 2026 13:07:15 +0000
X-Mizu-Trace-ID: 8ce8cdb92deed85a
X-Migadu-Flow: FLOW_OUT
Message-ID: <e0df6f55-aae9-4abd-8434-f6b75e42a972@linux.dev>
Date: Tue, 24 Nov 2026 21:06:56 +0800
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cui.tao@linux.dev, bpf@vger.kernel.org, tj@kernel.org,
 hannes@cmpxchg.org, mkoutny@suse.com
Subject: Re: [RFC PATCH v14 3/4] selftests/bpf: add iocost cost model test
To: sashiko-reviews@lists.linux.dev
References: <20261118131029.797007-1-cui.tao@linux.dev>
 <20261118131029.797007-4-cui.tao@linux.dev>
 <sashiko-outbox-221050@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <sashiko-outbox-221050@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

在 2026/11/18 21:41, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issues to consider:
> - [Medium] selftests/bpf: iocost_test_env() hardcodes /sys/fs/cgroup
>   without mounting
Right, the tests access /sys/fs/cgroup without mounting anything there,
so they depend on the host's mount state and would see the tmpfs that
setup_classid_environment() leaves behind.  The next posting mounts
cgroup2 at /sys/fs/cgroup inside the private mount namespace that
iocost_test_env() creates, tolerating EBUSY, and skips the tests when
the mount fails.
> - [Low] selftests/bpf: open_nullb_dev() callers check -errno instead of
>   fd
That's a real gap.  open_nullb_dev() can return -1 with errno unset,
and the callers then pass 0 to ASSERT_OK() and keep using fd -1.  The
next posting returns a proper negative error code from the helper and
checks the fd itself with ASSERT_GE(devfd, 0).

And another one:
bpf-ci points this, the setns() unwind on the skip path may reset test_progs' cwd to "/"

Right, mntns_install() sets the pwd to the root of the new namespace on
the way back, so a skip moves the process to "/".  The next posting
saves the cwd before unshare() and fchdir()s back to it after setns().

Thanks,
Tao

> --
> 
> commit 7c8a11566574f6e4224eb8a8a97b22da0b3eb991
> Author: Tao Cui <cuitao@kylinos.cn>
> 
> selftests/bpf: add iocost cost model test
> 
> This commit adds two BPF struct_ops iocost cost models and selftests that
> attach them to a configfs-created null_blk device and verify model
> selection, IO pricing, tracepoint firing, and device removal.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/iocost_model.c b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
>> new file mode 100644
>> index 0000000000000..0fbaeb7c5b7ef
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
> [ ... ]
>> +/* open the nullb device node, creating it manually when udev hasn't */
>> +static int open_nullb_dev(const char *name, int flags)
>> +{
>> +	char path[32], syspath[64], devtok[32];
>> +	unsigned int maj, min;
>> +	dev_t dev;
>> +	struct stat st;
>> +	int fd;
>> +
>> +	snprintf(syspath, sizeof(syspath), "/sys/block/%s/dev", name);
>> +	if (read_file_token(syspath, devtok, sizeof(devtok)) ||
>> +	    sscanf(devtok, "%u:%u", &maj, &min) != 2)
>> +		return -1;
>> +	dev = makedev(maj, min);
>> +
>> +	snprintf(path, sizeof(path), "/dev/%s", name);
>> +	fd = open(path, flags);
>> +	if (fd >= 0 && fstat(fd, &st) == 0 && S_ISBLK(st.st_mode) &&
>> +	    st.st_rdev == dev)
>> +		return fd;
>> +	if (fd >= 0) {
>> +		/* a stale node from a previous run, drop and recreate */
>> +		close(fd);
>> +		fd = -1;
>> +	}
>> +	if (unlink(path) && errno != ENOENT)
>> +		return -1;
>> +	if (mknod(path, S_IFBLK | 0600, dev))
>> +		return -1;
>> +	fd = open(path, flags);
>> +	if (fd < 0)
>> +		unlink(path);
>> +	return fd;
>> +}
> 
> [Severity: Low]
> Can ASSERT_OK(devfd < 0 ? -errno : 0, ...) in serial_test_iocost_model()
> and serial_test_iocost_model_streams() pass when open_nullb_dev() fails?
> 
> If read_file_token() hits EOF without setting errno, sscanf() fails to
> match two tokens, or unlink(path) succeeds and leaves errno at 0 after
> the second open() fails, open_nullb_dev() returns -1 with errno == 0.
> The callers then pass 0 to ASSERT_OK() and proceed to call
> posix_fadvise(), read(), pread(), and close() on fd -1.  Using
> ASSERT_OK_FD(devfd, ...) in the callers (or returning a negative error
> code from open_nullb_dev()) would catch any failure directly.
> 
> [ ... ]
>> +static bool iocost_test_env(void)
>> +{
>> +	static bool ready;
>> +	struct statfs sf;
>> +	int orig_ns = -1, supported;
>> +	bool ok = false;
>> +
>> +	if (geteuid() != 0) {
>> +		printf("%s:SKIP:needs root\n", __func__);
>> +		test__skip();
>> +		return false;
>> +	}
>> +
>> +	if (statfs("/sys/fs/cgroup", &sf) ||
>> +	    sf.f_type != CGROUP2_SUPER_MAGIC) {
>> +		printf("%s:SKIP:needs cgroup v2 at /sys/fs/cgroup\n",
>> +		       __func__);
>> +		test__skip();
>> +		return false;
>> +	}
> [ ... ]
>> +	/*
>> +	 * Isolate the configfs and cgroup mounts from the host. A
>> +	 * failed setup unwinds the namespace so that a later retry does
>> +	 * not stack private namespaces.
>> +	 */
>> +	orig_ns = open("/proc/self/ns/mnt", O_RDONLY);
>> +	if (unshare(CLONE_NEWNS) ||
>> +	    mount(NULL, "/", NULL, MS_REC | MS_PRIVATE, NULL)) {
>> +		printf("%s:SKIP:cannot make mounts private: %s\n",
>> +		       __func__, strerror(errno));
>> +		test__skip();
>> +		goto out;
>> +	}
>> +	mkdir("/sys/kernel/config", 0755);
>> +	(void)mount("none", "/sys/kernel/config", "configfs", 0, NULL);
> 
> [Severity: Medium]
> Will all three iocost tests skip when /sys/fs/cgroup is not already a
> cgroup2 mount or after an earlier cgroup v1 test runs in the same
> test_progs process?
> 
> iocost_test_env(), cgroupfs_has_controller(), readback_model(),
> write_cost_model(), and the io.cost.qos writes all access /sys/fs/cgroup
> directly without mounting cgroup2 there, while cgroup_setup_and_join() in
> tools/testing/selftests/bpf/cgroup_helpers.c mounts cgroup2 at /mnt
> (CGROUP_MOUNT_PATH).  In addition, setup_classid_environment() in
> cgroup_helpers.c mounts tmpfs at /sys/fs/cgroup (CGROUP_MOUNT_DFLT) and
> cleanup_classid_environment() leaves that tmpfs mounted:
> 
> tools/testing/selftests/bpf/cgroup_helpers.c:setup_classid_environment() {
> 	...
> 	if (mount("tmpfs", CGROUP_MOUNT_DFLT, "tmpfs", 0, NULL) &&
> 	    errno != EBUSY) {
> 		log_err("mount cgroup base");
> 		return 1;
> 	}
> 	...
> }
> 
> When a test using setup_classid_environment() runs before
> serial_test_iocost_model*, statfs("/sys/fs/cgroup", &sf) sees TMPFS_MAGIC
> instead of CGROUP2_SUPER_MAGIC and skips the tests.  Using the cgroup2
> mount managed by cgroup_helpers.c (via get_root_cgroup() or
> write_cgroup_file("", ...) / read_cgroup_file("", ...)), or mounting
> cgroup2 inside the private mount namespace created by iocost_test_env(),
> would avoid relying on the host's /sys/fs/cgroup mount state.
> 

