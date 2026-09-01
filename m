Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BC048F82A;
	Tue,  1 Sep 2026 17:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285339; cv=none; b=VKpuuw0AraJAAnIcDa0QMkjOyF11R4hxdDBpi1Oof6b+4zrgvgczc3e6r8M7v37N4lD5uu/VXZ7DhtMEvTysyKJloWnjyx9dnP3TmP2LB1s1VVZz4jkma8luoI+yfWWGpfpvFKr4G8jADm1+vnK6gX3vfEd6sZgvy+yn2VKi610=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285339; c=relaxed/simple;
	bh=aMJm+NVGLk628IMNs4aR257jZQ4tabKtpZkh8SwlwJc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=qohjtSWbUsMOKA3K3F6ofZyLupsg87XqGWkT+DNr8y1XHY2hsLextFS1/zgatD4jEjoenMcF61NKmZbinD8Q48qP9Iu8RdCATJSI1FNiYntysNw98sCAYx6GZLwZ1J7+mjwqYdDMxsSNM8YERK6FSD+7k1gTTeY7uKk3jb5D+OU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqzmXdN5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqzmXdN5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD561F000E9;
	Tue,  1 Sep 2026 17:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788285338;
	bh=pyktm6EM2KBBmBPLUTHoBEKKpIAeRKyCXylUpmzSIt8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=cqzmXdN5JreX1cpENaIrz/uxP6gzOwWa8vuSau/OLu63ON4chJ/JJ/PitZ1xg3Il3
	 3j5aReCXhN6m7NOGcdmRLCOrXYQDpxSET+UBRoWF2k2TLSs9IM5nnPt3uPmD0FBl5h
	 kwC+iZ/iA89DBX2NnFfDkepaNvxkxCVE+O+suJKNWGRf5A9I/Zbc+o9PiuhUm2ulkT
	 g/GsGQgS0KL+nwVw/lgbEYYgLSOTu56TCn/70yJtW0FK1tHs+Pp9qUCLzUTA2sFu6f
	 8prAziZhKcM+hg1XD011RvUuPMcKKTx9+juS5ecTE0kvkzqUS1rLR0JNVPd1A/uaYX
	 26DoyvYYN+dDQ==
Content-Type: multipart/mixed; boundary="===============8011504135443379956=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <64ea9202de27b0d82fd35352a2e24148f8c55c5e81cb6b74ab0d9295f0f24247@mail.kernel.org>
In-Reply-To: <20260901165757.801449-18-alan.maguire@oracle.com>
References: <20260901165757.801449-18-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 17/18] selftests/bpf: Test BTF sysfs inline representations
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,eddyz87@gmail.com,jolsa@kernel.org,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,bpf@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 17:55:36 +0000 (UTC)

--===============8011504135443379956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> selftests/bpf: Test BTF sysfs inline representations
>
> Load vmlinux, vmlinux.inline and all module and module.inline
> entries in /sys/fs/btf; this will allow us to sanity-check

The changelog references '/sys/fs/btf', but the directory is
/sys/kernel/btf. The code uses BTF_SYSFS_DIR "/sys/kernel/btf", the
existing call at test_btf_sysfs() uses "/sys/kernel/btf/vmlinux", and
the kernel side (89015dbacfe6) says "available in /sys/kernel/btf".
Should the message say /sys/kernel/btf instead?

> diff --git a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
> index 3923e64c4c1d..97eccfd7c134 100644
> --- a/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c
> +++ b/tools/testing/selftests/bpf/prog_tests/btf_sysfs.c

[ ... ]

> +static void test_btf_inline_sysfs_all(void)
> +{

[ ... ]

> +	while ((dentry = readdir(dir)) != NULL) {
> +		struct btf *base_btf = NULL, *module_btf = NULL, *inline_btf = NULL;
> +		char btf_path[PATH_MAX], inline_path[PATH_MAX];
> +		struct stat st;
> +
> +		/* Skip ".", ".." and "foo.inline" */
> +		if (strstr(dentry->d_name, "."))
> +			continue;
> +
> +		if (strcmp(dentry->d_name, "vmlinux") == 0)
> +			base_btf = vmlinux_btf;
> +
> +		if (snprintf(btf_path, sizeof(btf_path), "%s/%s",
> +			     BTF_SYSFS_DIR, dentry->d_name) >= sizeof(btf_path) ||
> +		    snprintf(inline_path, sizeof(inline_path), "%s/%s%s",
> +			     BTF_SYSFS_DIR, dentry->d_name, BTF_INLINE_SUFFIX) >=
> +			     sizeof(inline_path)) {
> +			ASSERT_FAIL("BTF sysfs path is too long\n");
> +			break;
> +		}
> +
> +		if (!base_btf) {
> +			module_btf = btf__parse_split(btf_path, vmlinux_btf);
> +			err = libbpf_get_error(module_btf);
> +			if (err) {
> +				/* A module can be unloaded while its sysfs entry is iterated. */
> +				if (err == -ENOENT)
> +					continue;
> +				ASSERT_OK(err, "parse_module_btf");
> +				continue;
> +			}
> +			base_btf = module_btf;
> +		}
> +		if (stat(inline_path, &st)) {
> +			err = errno;
> +			if (err == ENOENT)
> +				continue;
> +			ASSERT_OK(err, "stat_inline_btf");
> +		}

Is there a missing continue after the ASSERT_OK? On a stat() error other
than ENOENT (EACCES, EIO, ELOOP), the assertion records the failure but
then execution falls into the btf__parse_split() call below, which fails
on the same path for the same reason. Every other error branch in this
function continues; this is the only fall-through. Compare also
test_btf_mmap_sysfs() where every failed check goes to cleanup.

> +		inline_btf = btf__parse_split(inline_path, base_btf);
> +		err = libbpf_get_error(inline_btf);
> +		if (!err)
> +			btf__free(inline_btf);
> +		ASSERT_OK(err, "parse_inline_btf");
> +		btf__free(module_btf);
> +	}

The module-unload race documented at the module BTF read is not handled
for the inline BTF read. The comment above notes 'A module can be
unloaded while its sysfs entry is iterated', and the module BTF parse
tolerates err == -ENOENT. The inline parse has no such tolerance:
btf__parse_split() returns NULL with errno = ENOENT if the file has gone
away, and ASSERT_OK(-ENOENT, "parse_inline_btf") fails the test.

The stat() above does not protect this because it is a check performed
strictly before the use (TOCTOU pre-check, not exclusion). Concrete
sequence:

  1. readdir() returns "bpf_test_rqspinlock"
  2. module BTF parse succeeds
  3. stat(inline_path) succeeds
  4. concurrently another test unloads the module:
     prog_tests/res_spin_lock.c unload_module("bpf_test_rqspinlock"),
     or prog_tests/bpf_mod_race.c, or test_progs.c unload_bpf_testmod()
     reaches btf_module_notify(MODULE_STATE_GOING) and calls
     sysfs_btf_remove(btf_mod->sysfs_inline_attr), removing the file
  5. btf__parse_split() open() fails with ENOENT, err = -ENOENT
  6. ASSERT_OK fails, spurious test failure

Could the inline parse apply the same tolerance already used for the
module parse (treat -ENOENT as 'entry vanished, skip')?

Also, with CONFIG_DEBUG_INFO_BTF_INLINE off (the default, and the current
selftests/bpf/config), does this test report PASS without exercising
anything?

CONFIG_DEBUG_INFO_BTF_INLINE is 'default n' (lib/Kconfig.debug) and
'depends on PAHOLE_HAS_INLINE' (pahole >= 1.31). Neither
tools/testing/selftests/bpf/config nor any config.<arch> gains
CONFIG_DEBUG_INFO_BTF_INLINE anywhere in the series (verified over
a04bcbfa9ea1~1..f197212706a6: no commit touches those files).

With the option off, kernel/bpf/btf_vmlinux_inline.c registers nothing
(guarded by IS_BUILTIN(CONFIG_DEBUG_INFO_BTF_INLINE)), so
/sys/kernel/btf/vmlinux.inline does not exist. The module path in
btf_module_notify() is #if IS_ENABLED(CONFIG_DEBUG_INFO_BTF_INLINE), so
no <mod>.inline exists either.

Every readdir() iteration therefore reaches the stat() at the line marked
above, stat() fails with ENOENT, and 'continue' is taken. The loop runs
to completion, no ASSERT_* is ever evaluated against inline BTF, and
test_btf_sysfs is reported as OK. The very feature the series adds is
never touched by the test that is supposed to cover it, in exactly the
configuration the BPF CI builds.

A subsystem pattern flags this as potentially concerning: tests that
assert/fail on EOPNOTSUPP, ENOSYS, or similar "capability absent" errno
values instead of skipping, or that skip silently with no message,
receive this flag. The vacuous pass is not a crash and does not
destabilize the system, but this is the test not running at all in the
default/CI configuration, which is the 'silent pass' failure mode
selftests.md names.

The next patch in the same series (f197212706a6, 'selftests/bpf: Add a
test verifying inline information') explicitly states 'Test is skipped if
pahole does not encode inline info', so the skip idiom is being used
elsewhere in the series.

Could the test track whether any *.inline entry was found and call
test__skip() with a reason if none were, and add
CONFIG_DEBUG_INFO_BTF_INLINE=y to tools/testing/selftests/bpf/config?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33537080133
--===============8011504135443379956==--
