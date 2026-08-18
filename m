Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36DE413787
	for <bpf@vger.kernel.org>; Tue, 18 Aug 2026 10:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787049932; cv=none; b=X9oyfIWA1EAxqAERNeTih75RGw4BwK1eEi4xkoznzrOISWgsxh/zdU8JQ0EBfVks/1mNVly2rFcRrNNdcG1n8gk9IAI+wd1ia5gKhiQC64+eWdfl6cPJViowad2Pif5YFQzWFG9SYt4yPc8SQ3V8zyEDL3jlLohsOyxLhlY58z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787049932; c=relaxed/simple;
	bh=VNYEzDEFIzh7HU0l5Y0zwytz/Vy+uvUEaHlmkRFY8HY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ey0MYEsmZodKy7O0xZXaP/hRtL0Yzgohpzi2+CynH9k8bU6U7Km3r/Luq3jc4PBowvvQEsf47WBGekyhm+Mb/ArUPwyAazscNdzM7OFZ/mLep+1PvDCNVOj+/LHmerL+gF1IeAxhwZjzP/puzde9jmux388nSGmmKTjXKxep1C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7by9keT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7by9keT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A74C1F000E9;
	Tue, 18 Aug 2026 10:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787049930;
	bh=4Lb1lxLLHSXZCvF+ef9Nb+rnJYCy0NgAX1QFAOt13no=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=T7by9keTDhyscsJXEb+cAuoJrCurF6MX6TXeqWuvy9CyPknsRq6KonyrOxr5aUity
	 m9L2tMDY5yGA0jk5hrjI5f2zSbW2FrTxunDa8RrQGCp9Nxys6niX99UW7ZxyJov4Ay
	 VfK3/RPmSWEP9dqOpLY0ijRwX2EiatW6Y5PmRQCtP4IWphPSi03WkVtleg7uwSLwuD
	 0YkU7YMby1rlqmSsFHydDeC6SdBIpnBpx/0F25JnmcT/76US2ETYBKYalQprrrHUm7
	 WWNAhSuXD5iGHjWhKv1LWh1ZGUhDDfZoPQmK6F05FzSwAnKATr0nHhAt5fQtz+S/SX
	 xODAVjpFH243w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/4] selftests/coredump: test that TIF_NOTIFY_SIGNAL
 doesn't truncate a coredump
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260818-work-tif_notify_signal-v1-3-1ee1fcc5b3ff@kernel.org>
References: <20260818-work-tif_notify_signal-v1-0-1ee1fcc5b3ff@kernel.org>
 <20260818-work-tif_notify_signal-v1-3-1ee1fcc5b3ff@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 18 Aug 2026 10:45:30 +0000
Message-Id: <20260818104530.8A74C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] Missing cleanup of stale temporary files in FIXTURE_SETUP can by=
pass the polling synchronization in the notify_signal_pipe test, leading to=
 false test successes.
- [Medium] The test suite uses predictable, hardcoded paths in /tmp/ and op=
ens them with O_CREAT | O_TRUNC without O_EXCL, creating a vulnerability to=
 symlink truncation attacks.
- [Medium] The test globally changes /proc/sys/kernel/core_pattern to point=
 to a test-specific helper. If the test terminates abnormally, this configu=
ration is never restored.
--

--- Patch [3]: [PATCH 3/4] selftests/coredump: test that TIF_NOTIFY_SIGNAL =
doesn't truncate a coredump ---
commit c11ee8bbfd73149ce9b69d88e45aeab900d75512
Author: Christian Brauner <brauner@kernel.org>

selftests/coredump: test that TIF_NOTIFY_SIGNAL doesn't truncate a coredump

Add a test that verifies that a coredump cannot be cut short by
TIF_NOTIFY_SIGNAL through io_uring running task work for uninterruptible
tasks.

> diff --git a/tools/testing/selftests/coredump/coredump_notify_signal_help=
er.c b/tools/testing/selftests/coredump/coredump_notify_signal_helper.c
> new file mode 100644
> index 0000000000000..849f5c1ea7365
> --- /dev/null
> +++ b/tools/testing/selftests/coredump/coredump_notify_signal_helper.c
> @@ -0,0 +1,46 @@
[ ... ]
> +int main(int argc, char *argv[])
> +{
> +	int fd_core_file;
> +	ssize_t ret;
> +
> +	fd_core_file =3D open(NOTIFY_SIGNAL_CORE_TMPFILE,
> +			    O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC, 0600);

[Severity: Medium]
Could this predictable hardcoded path in /tmp/ be vulnerable to a symlink
truncation attack? The helper is spawned by the kernel (typically as root)
and opens this path without O_EXCL. If an unprivileged user pre-creates this
path as a symlink, it might truncate important system files.

> +	if (fd_core_file < 0) {
> +		fprintf(stderr, "%s: open failed: %m\n", argv[0]);
> +		return EXIT_FAILURE;
> +	}
[ ... ]
> diff --git a/tools/testing/selftests/coredump/coredump_notify_signal_test=
.c b/tools/testing/selftests/coredump/coredump_notify_signal_test.c
> new file mode 100644
> index 0000000000000..e63c06a81562f
> --- /dev/null
> +++ b/tools/testing/selftests/coredump/coredump_notify_signal_test.c
> @@ -0,0 +1,245 @@
[ ... ]
> +FIXTURE_SETUP(coredump)
> +{
> +	FILE *file;
> +	int ret;
[ ... ]
> +	self->fd_tmpfs_detached =3D create_detached_tmpfs();
> +	ASSERT_GE(self->fd_tmpfs_detached, 0);
> +
> +	ret =3D fclose(file);
> +	ASSERT_EQ(0, ret);
> +
> +	unlink(NOTIFY_SIGNAL_TRIGGER);
> +	ASSERT_EQ(mkfifo(NOTIFY_SIGNAL_TRIGGER, 0600), 0);
> +}

[Severity: Medium]
Should FIXTURE_SETUP() also unlink NOTIFY_SIGNAL_CORE_FILE? If a previous
test run fails or is interrupted before teardown, a stale file could be left
in /tmp/. The polling loop in notify_signal_pipe() would immediately break
when it sees this stale file instead of waiting for the new coredump, leadi=
ng
to a false test success.

[ ... ]
> +TEST_F(coredump, notify_signal_pipe)
> +{
> +	char pattern[PATH_MAX], helper[PATH_MAX], *p;
> +	struct stat st;
[ ... ]
> +	ASSERT_LT(snprintf(pattern, sizeof(pattern), "|%s", helper),
> +		  (int)sizeof(pattern));
> +	ASSERT_TRUE(set_core_pattern(pattern));

[Severity: Medium]
What happens if the test terminates abnormally (e.g. via SIGKILL) after
modifying core_pattern here? FIXTURE_TEARDOWN() would not run, leaving the
global /proc/sys/kernel/core_pattern permanently pointing to the test's
temporary helper binary. Could this break core dumps for the entire system?

[ ... ]
> diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/t=
ools/testing/selftests/coredump/coredump_test_helpers.c
> index 2a20faf9cb0ad..20fcc5b644c32 100644
> --- a/tools/testing/selftests/coredump/coredump_test_helpers.c
> +++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
> @@ -1,11 +1,18 @@
[ ... ]
> +static int make_file_mappings(void)
> +{
> +	long pgsz =3D sysconf(_SC_PAGESIZE);
> +	int fd, i;
> +
> +	fd =3D open(NOTIFY_SIGNAL_MAPFILE,
> +		  O_RDWR | O_CREAT | O_TRUNC | O_CLOEXEC, 0600);

[Severity: Medium]
Is this another potential symlink truncation vulnerability? Like the helper
above, this opens a predictable, hardcoded path in /tmp/ with O_CREAT | O_T=
RUNC
but without O_EXCL.

> +	if (fd < 0)
> +		return 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260818-work-tif_n=
otify_signal-v1-0-1ee1fcc5b3ff@kernel.org?part=3D3
