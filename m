Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793762145;
	b=eAK05bER8HoOrxnk+kO8fn/zZfDRddIioHyKFJKmsgROD8qQVo29UuTRIP/v0D6zI2pK
	 /TVgyegQ6VjxCb4L6QYXQsvmfHXCVFigcxWyJ54O6c+BHN93PAPxl+lnkZs7c2/XPDq0Q
	 dyATHkdHHhxDBVVTt/Oq34xZ6vbqwSLHGJEX+pBTpDKbhU49VrjGS6YB1wYT5RV9b3TC5
	 w9avoYNr1a0tBQeB3Ys79oB2+5qk4Imhtm9P0iSbfsDx+phBWEiXLERiEi+8NkghICNos
	 Mhd0HOS5/OsWamxLyksd1Kt964Eys5EM8WWyaT4rqayRjfgflinC/QUvm38HwxD4Xxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793762145;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Cc:Subject:To:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=vwCXeiQmRHPtq8z7DR8Mo+DyJHZ4kmJvy0Imvopyx+U=;
	b=X8iZbNy04DQX5e/qpHn05wrhmC+85B7DvW1YIL/Xhc8XpngpiQbUlhhnGtTHqL+r50+v
	 5ApHmSAHyEOLIe9R3VXAyvMCjGP4Mzgpq1pYoGux0zcJx295QK3izu2JilNvpKX8CvfiM
	 8JzHBauc6ubJrojYRidVfxTsmpPtcjGKpnQUvXZwOFd5q/0NOSvpXLEtv27APVr8mmcsQ
	 ZDa+Wy5A81TTN+pcIwkF8RxTMxqjP84RG+ORHZL82+MotJUdexkR8PJs3DivIDcbhnrSt
	 wYdWKxv3bWUabGPZI7Ds+wXUFhOZ5bKmM3/5k9AzM+WVeO361TmUc3WF7JM3BOmq0Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=re2ZBl1r;
	arc=none smtp.remote-ip=91.218.175.12
Received: from mta0.migadu.com (out-12.mta0.migadu.com [91.218.175.12])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9942F606A328
	for <bpf@vger.kernel.org>; Wed,  4 Nov 2026 03:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9942F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=re2ZBl1r
X-Envelope-To: bpf@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=B/mxMS3Qs/W9BwAXYU5T02aKLcApnrl+f7tJtwsZ6ho=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793762142; v=1; x=1794366942;
 b=re2ZBl1rI2mtiG62CUkhv2W5NJcwZTWkDGMFd/z5ewUrXJcUpp+8NO9LO7CNBuBfAnsegM3V
 ZVHkz48dDykFzEuq4o7zsdRKMH/0Q5Jq6wNfNmahTdgM4HxINTbKEm9jqBDs3Vy9qcVwRrugZR9
 voWwZqkJBW73wKzD0QQytTQM=
X-Envelope-To: bpf@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id b8e55fed3b1afd03;
	Wed, 04 Nov 2026 03:15:42 +0000
X-Mizu-Trace-ID: b8e55fed3b1afd03
X-Migadu-Flow: FLOW_OUT
Message-ID: <fa7b359c-12a0-4801-97ee-5c11052c6a30@linux.dev>
Date: Wed, 4 Nov 2026 11:15:35 +0800
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
Subject: Re: [RFC PATCH v12 3/4] selftests/bpf: add iocost cost model test
To: sashiko-reviews@lists.linux.dev
References: <20261103132613.1952975-1-cui.tao@linux.dev>
 <20261103132613.1952975-4-cui.tao@linux.dev>
 <sashiko-outbox-195431@kernel.org>
From: Tao Cui <cui.tao@linux.dev>
In-Reply-To: <sashiko-outbox-195431@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hello,

在 2026/11/3 22:16, sashiko-bot@kernel.org 写道:
> Thank you for your contribution! Sashiko AI review found 4 potential issue(s) to consider:
> - [Medium] selftests/bpf: missing leading slash in cgroup paths in iocost_model tests
Confirmed, and the test host did accumulate leftovers named
cgroup-test-work-dir<pid>iocost_pairing. Will pass "/iocost_pairing"
and "/iocost_ms" so the cgroups are created inside the per-pid work
directory and nftw() in __cleanup_cgroup_environment() removes them.
> - [Medium] selftests/bpf: iocost_bpf_supported() requires /proc/config.gz to run tests
You're right. This was already pointed out in the v11 review.
I removed the unused `any` variable in v12 without fixing the
underlying issue.

I'll make the probe distinguish an unavailable kernel config
from CONFIG_BLK_CGROUP_IOCOST_BPF=n instead of treating both as
unsupported.

> - [Low] selftests/bpf: unpaired cleanup_cgroup_environment() in iocost_model
Right — in serial_test_iocost_model_streams() the environment is set
up after attach, so the skel_load and attach failure paths call
cleanup before anything was created. Will drop cleanup from those two
paths and keep it only where the setup has run.
> - [Low] selftests/bpf: missing rmdir() on error paths in nullb_create()
Confirmed. If either the size or power write fails, nullb_create()
returns without removing the instance directory, leaving the
configfs instance behind.

I'll mirror the read_file_token() failure path: power the instance
off and remove the directory before returning.

Thanks,
Tao
> --
> 
> commit 853e704fa28b8b44bb71705b9e1a9ac55510a4dd
> Author: Tao Cui <cuitao@kylinos.cn>
> 
> selftests/bpf: add iocost cost model test
> 
> This commit adds two BPF iocost cost models (a doubled linear HDD model and a
> multi-stream sequentiality model) along with selftests that attach them to a
> configfs-created null_blk device and verify pricing, tracepoints, model
> switching, and device removal.
> 
>> diff --git a/tools/testing/selftests/bpf/prog_tests/iocost_model.c b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
>> new file mode 100644
>> index 0000000000000..fa9280fe9e34b
>> --- /dev/null
>> +++ b/tools/testing/selftests/bpf/prog_tests/iocost_model.c
>> @@ -0,0 +1,748 @@
> 
> [ ... ]
> 
>> +static int nullb_create(const char *name, char *dev, size_t dev_sz)
>> +{
>> +	char path[128];
>> +	char p2[128];
>> +	int err;
>> +
>> +	snprintf(path, sizeof(path), "/sys/kernel/config/nullb/%s", name);
>> +	if (mkdir(path, 0755)) {
>> +		if (errno != EEXIST)
>> +			return -errno;
>> +		/*
>> +		 * a leftover instance from an earlier crashed run may
>> +		 * still be powered: tear it down before reusing the
>> +		 * name
>> +		 */
>> +		snprintf(p2, sizeof(p2),
>> +			 "/sys/kernel/config/nullb/%s/power", name);
>> +		configfs_write(p2, "0");
>> +		if (rmdir(path) && errno != ENOENT)
>> +			return -errno;
>> +		if (mkdir(path, 0755) && errno != EEXIST)
>> +			return -errno;
>> +	}
>> +
>> +	snprintf(path, sizeof(path), "/sys/kernel/config/nullb/%s/size", name);
>> +	err = configfs_write(path, "128");
>> +	if (err)
>> +		return err;
>> +
>> +	snprintf(path, sizeof(path), "/sys/kernel/config/nullb/%s/power", name);
>> +	err = configfs_write(path, "1");
>> +	if (err)
>> +		return err;
> 
> [Severity: Low]
> As reported by Sashiko on RFC v11 [1], if configfs_write() fails when writing
> to size or power in nullb_create(), does this return early and leave the
> /sys/kernel/config/nullb/<name> directory and its underlying kernel
> nullb_device allocated?
> 
> In serial_test_iocost_model() and serial_test_iocost_model_streams(), the
> callers also return directly on nullb_create() failure without calling
> nullb_remove(IOCOST_NULLB). Should nullb_create() remove the instance
> directory on these error paths just like the read_file_token() failure path
> below?
> 
>> +
>> +	snprintf(path, sizeof(path), "/sys/block/%s/dev", name);
>> +	err = read_file_token(path, dev, dev_sz);
>> +	if (err) {
>> +		/* do not leave a powered instance behind */
>> +		snprintf(path, sizeof(path),
>> +			 "/sys/kernel/config/nullb/%s/power", name);
>> +		configfs_write(path, "0");
>> +		snprintf(path, sizeof(path),
>> +			 "/sys/kernel/config/nullb/%s", name);
>> +		rmdir(path);
>> +	}
>> +	return err;
>> +}
> 
> [ ... ]
> 
>> +static bool iocost_bpf_supported(void)
>> +{
>> +	FILE *f;
>> +	char line[128];
>> +	bool on = false;
>> +
>> +	f = popen("zcat /proc/config.gz 2>/dev/null", "r");
>> +	if (!f)
>> +		return false;
>> +	while (fgets(line, sizeof(line), f)) {
>> +		if (strstr(line, "CONFIG_BLK_CGROUP_IOCOST_BPF=y"))
>> +			on = true;
>> +	}
>> +	pclose(f);
>> +	return on;
>> +}
> 
> [Severity: Medium]
> As reported by Tejun Heo on RFC v11 [2], won't iocost_bpf_supported() still
> return false and cause iocost_test_env() to skip all three tests whenever
> /proc/config.gz is not present on the system, even if the running kernel has
> CONFIG_BLK_CGROUP_IOCOST_BPF=y enabled?
> 
> When CONFIG_IKCONFIG_PROC is disabled, popen() still succeeds while zcat
> outputs nothing, so fgets() reads zero lines and on remains false. In RFC v11
> it was noted that the any variable tracking whether any lines were read was
> set but never used; here any was removed rather than used to avoid skipping
> when /proc/config.gz is unavailable (or falling back to /boot/config-<release>
> or BTF probing).
> 
> [ ... ]
> 
>> +	cg = cgroup_setup_and_join("iocost_pairing");
>> +	if (!ASSERT_GE(cg, 0, "setup_cg")) {
>> +		iocost_model__destroy(skel);
>> +		nullb_remove(IOCOST_NULLB);
>> +		return;
>> +	}
> 
> [ ... ]
> 
>> +		ASSERT_OK(join_cgroup("iocost_pairing"), "join_pairing");
>> +		snprintf(qbuf, sizeof(qbuf), "%s 1000", dev);
>> +		ASSERT_OK(write_cgroup_file("iocost_pairing", "io.weight",
>> +				     qbuf), "weight_pairing");
>> +		snprintf(qbuf, sizeof(qbuf),
>> +			 "%s enable=1 ctrl=user min=100.00 max=100.00", dev);
>> +		ASSERT_OK(configfs_write("/sys/fs/cgroup/io.cost.qos", qbuf),
>> +			  "qos_enable");
>> +
>> +		devfd = open(path, O_RDONLY);
>> +		if (!ASSERT_OK(devfd < 0 ? -errno : 0, "open_dev_priced")) {
>> +			iocost_model__destroy(skel);
>> +			snprintf(qbuf, sizeof(qbuf), "%s enable=0", dev);
>> +			(void)configfs_write("/sys/fs/cgroup/io.cost.qos", qbuf);
>> +			nullb_remove(IOCOST_NULLB);
>> +			cleanup_cgroup_environment();
>> +			return;
>> +		}
>> +		ASSERT_OK(read_cost_usage("iocost_pairing",
>> +					  dev, &u1), "cost_usage_pre");
>> +		for (i = 0; i < 500; i++)
>> +			(void)read(devfd, buf, sizeof(buf));
>> +		close(devfd);
>> +		ASSERT_GT(skel->bss->calc_costs, 0, "model_priced");
>> +		/*
>> +		 * the usage stat is flushed by the iocost timer, give
>> +		 * the current period a chance to end before reading
>> +		 */
>> +		sleep(3);
>> +		ASSERT_OK(read_cost_usage("iocost_pairing",
>> +					  dev, &u2), "cost_usage_post");
> 
> [Severity: Medium]
> Does passing "iocost_pairing" (and "iocost_ms" in
> serial_test_iocost_model_streams() below) without a leading slash to
> cgroup_setup_and_join(), join_cgroup(), write_cgroup_file(), and
> read_cost_usage()->read_cgroup_file() leak the test cgroups in the root cgroup
> hierarchy?
> 
> In tools/testing/selftests/bpf/cgroup_helpers.c, format_cgroup_path_pid()
> formats paths without inserting a slash before path:
> 
>     #define format_cgroup_path_pid(buf, path, pid) \
>         snprintf(buf, sizeof(buf), "%s%s%d%s", CGROUP_MOUNT_PATH, \
>         CGROUP_WORK_DIR, pid, path)
> 
> Without a leading slash, this creates
> /mnt/cgroup-test-work-dir<pid>iocost_pairing as a sibling of
> /mnt/cgroup-test-work-dir<pid> rather than a child inside it. When
> cleanup_cgroup_environment() runs, __cleanup_cgroup_environment() only runs
> nftw() on /mnt/cgroup-test-work-dir<pid>, leaving the sibling cgroup
> directories and their associated kernel cgroup, blkcg, and cgroup storage
> allocated after the test finishes. Should these relative cgroup paths be
> "/iocost_pairing" and "/iocost_ms"?
> 
> [ ... ]
> 
>> +	err = iocost_ms__load(skel);
>> +	if (!ASSERT_OK(err, "skel_load")) {
>> +		cleanup_cgroup_environment();
>> +		iocost_ms__destroy(skel);
>> +		nullb_remove(IOCOST_NULLB);
>> +		return;
>> +	}
>> +
>> +	err = iocost_ms__attach(skel);
>> +	if (ASSERT_OK(err, "attach")) {
>> +		err = readback_model(dev, model, sizeof(model));
>> +		if (ASSERT_OK(err, "readback"))
>> +			ASSERT_STREQ(model, "bpf", "model_bpf");
>> +
>> +		/*
>> +		 * drive IO through the model: enable the controller, price
>> +		 * from a cgroup, and check the model actually charged them
>> +		 */
>> +		cg = cgroup_setup_and_join("iocost_ms");
>> +		if (!ASSERT_GE(cg, 0, "setup_cg_ms")) {
>> +			iocost_ms__destroy(skel);
>> +			nullb_remove(IOCOST_NULLB);
>> +			cleanup_cgroup_environment();
>> +			return;
>> +		}
> 
> [ ... ]
> 
>> +	}
>> +
>> +	iocost_ms__destroy(skel);
>> +	nullb_remove(IOCOST_NULLB);
>> +	cleanup_cgroup_environment();
>> +}
> 
> [Severity: Low]
> In serial_test_iocost_model_streams(), cgroup_setup_and_join() is only called
> inside the if (ASSERT_OK(err, "attach")) block, and it already calls
> cleanup_cgroup_environment() internally if it fails.
> 
> If iocost_ms__load() fails, if iocost_ms__attach() fails, or if
> cgroup_setup_and_join() fails, won't calling cleanup_cgroup_environment() in
> those paths attempt to clean up an uninitialized or already-cleaned cgroup
> environment and log spurious errors for /mnt/cgroup.procs?
> 
> [1] https://lore.kernel.org/r/20261028143534.135968-4-cui.tao@linux.dev
> [2] https://lore.kernel.org/r/b69d96a507aec382c279d62cfb038fa9@kernel.org
> 

