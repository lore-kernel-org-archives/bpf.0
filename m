Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4759541D13D
	for <bpf@vger.kernel.org>; Mon, 24 Aug 2026 12:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787575619; cv=none; b=dKZwJuEmq7sj/IXtKwPiX9d1BpBDJiX4ifK80E5A9dpo22z3y09sDyvB/jT1DWXjZmDqOZtI6vQW4fqxiv7LyM3rejNxxbOtC6slrNrbDFPfi/yX3IsPB4PkFTL9v7YGI0KPxs3SjuC7tgTxbMB21lIG8I78f4iJyyNQ7POZqdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787575619; c=relaxed/simple;
	bh=oiPqNJmLv2fIaGOuPfxjDG2ky9SG1c6WHibfcGvB3S4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BGbmzmNfJMgqcrD9MpQQblKfDbltf319ThNG60OZPsJy6aehf9rI+97/2NDi3mocq8bIz88FwVlPMTe5GwGGcVzc+f12tqgxRZeNg1ipd32p0vlo7U0h7Z8a8oXqGT9w0FwFxUPbOQkNbbPuYf96lwasYIPpu6Y0snBl/jF4R58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kIOfQQL7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kIOfQQL7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 030551F000E9;
	Mon, 24 Aug 2026 12:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787575618;
	bh=dTDl+P1PqqCi8yjFiUMrE4V7lA2ljvNXqYtZsFNVUb8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kIOfQQL7XIrK0dWeTCvNVDjtNwvY8z50O53IGntwWk+92BoHBgERfj60yv+ZHgO+5
	 WXBf1PEBuGcDmw6vyBxt+UdBv+dZJ0w9iD51bwa0AWTtzJuxF2skgXlAsLbqABHBFs
	 AtqO0KTvqy2Pj9TgZwit6uZZHBpmfdnExV4GeUDFnt96C7UO09QC9ukIeEUlvEF3RD
	 hKUW9GJLJ80u5my6Rn/d/3Jwmx24z0bTGm6puAWCdsWM80jmy0nvaNCYF2h9Pb0NFD
	 0TmZ98dK0EsqPZj0cKwc+GzXOng1WLAHi0yb7hRX78jwDe03FFZwFGC+cfW9/wp98v
	 dSs/JQrGNqqoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/5] selftests/coredump: test that TIF_NOTIFY_SIGNAL
 doesn't truncate a coredump
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260824-work-tif_notify_signal-v2-3-6609e42b3157@kernel.org>
References: <20260824-work-tif_notify_signal-v2-0-6609e42b3157@kernel.org>
 <20260824-work-tif_notify_signal-v2-3-6609e42b3157@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 24 Aug 2026 12:46:57 +0000
Message-Id: <20260824124658.030551F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Insecure use of hardcoded `/tmp` paths allows arbitrary file overw=
rites via symlink attacks, leading to Local Privilege Escalation.
- [Low] Incorrect substring replacement using `strstr()` leads to path corr=
uption and erroneous test skipping.
--

--- Patch [3]: [PATCH v2 3/5] selftests/coredump: test that TIF_NOTIFY_SIGN=
AL doesn't truncate a coredump ---
commit a5948cd46d81fc56087575c59d9596b04cf72843
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

[Severity: High]
Could this hardcoded path be exploited via a symlink attack?

Since this helper is spawned as root by the kernel via core_pattern, an
unprivileged local attacker could pre-create a symlink at
/tmp/coredump.notify_signal.core.tmp pointing to a sensitive file like
/etc/shadow.

Because open() is called with O_TRUNC but without O_EXCL or O_NOFOLLOW,
would this blindly follow the symlink and truncate the target file?

> +	if (fd_core_file < 0) {
> +		fprintf(stderr, "%s: open failed: %m\n", argv[0]);
> +		return EXIT_FAILURE;
> +	}
> +
> +	ret =3D recv_coredump_notify_signal(STDIN_FILENO, fd_core_file, true);

[ ... ]

> diff --git a/tools/testing/selftests/coredump/coredump_notify_signal_test=
.c b/tools/testing/selftests/coredump/coredump_notify_signal_test.c
> new file mode 100644
> index 0000000000000..4a98ab141c419
> --- /dev/null
> +++ b/tools/testing/selftests/coredump/coredump_notify_signal_test.c
> @@ -0,0 +1,245 @@

[ ... ]

> +TEST_F(coredump, notify_signal_pipe)
> +{
> +	char pattern[PATH_MAX], helper[PATH_MAX], *p;
> +	struct stat st;
> +	int status, i;
> +	pid_t pid;
> +	ssize_t n;
> +
> +	if (!coredump_io_uring_available())
> +		SKIP(return, "io_uring not available");
> +
> +	n =3D readlink("/proc/self/exe", helper, sizeof(helper) - 1);
> +	ASSERT_GT(n, 0);
> +	helper[n] =3D '\0';
> +	p =3D strstr(helper, "coredump_notify_signal_test");
> +	ASSERT_NE(p, NULL);
> +	ASSERT_LE((size_t)(p - helper) + sizeof("coredump_notify_signal_helper"=
),
> +		  sizeof(helper));
> +	strcpy(p, "coredump_notify_signal_helper");

[Severity: Low]
Can this strstr() matching lead to path corruption if the kernel source
tree is placed in a directory named coredump_notify_signal_test?

By matching the first occurrence of the string rather than the basename,
the directory component would be replaced instead, leading to a failed
access() check and the test being silently skipped.

> +	if (access(helper, X_OK))
> +		SKIP(return, "coredump_notify_signal_helper not built");

[ ... ]

> +TEST_F(coredump, notify_signal_socket)
> +{
> +	pid_t pid, pid_coredump_server;
> +	int ipc_sockets[2], status;
> +	char pattern[PATH_MAX];
> +	char c;

[ ... ]

> +	pid_coredump_server =3D fork();
> +	ASSERT_GE(pid_coredump_server, 0);
> +	if (pid_coredump_server =3D=3D 0) {
> +		int fd_server =3D -1, fd_coredump =3D -1, fd_core_file =3D -1;
> +		int exit_code =3D EXIT_FAILURE;
> +
> +		close(ipc_sockets[0]);
> +
> +		fd_server =3D create_and_listen_unix_socket(NOTIFY_SIGNAL_SOCKET);
> +		if (fd_server < 0)
> +			goto out;
> +		if (write_nointr(ipc_sockets[1], "1", 1) < 0)
> +			goto out;
> +		close(ipc_sockets[1]);
> +
> +		fd_coredump =3D accept4(fd_server, NULL, NULL, SOCK_CLOEXEC);
> +		if (fd_coredump < 0)
> +			goto out;
> +
> +		fd_core_file =3D open(NOTIFY_SIGNAL_CORE_FILE,
> +				    O_WRONLY | O_CREAT | O_TRUNC | O_CLOEXEC,
> +				    0600);

[Severity: High]
Is this open() vulnerable to the same /tmp symlink attack as the helper
above?

Adding O_NOFOLLOW | O_EXCL might be necessary to ensure we aren't
overwriting arbitrary files if the test runner operates with elevated
privileges.

> +		if (fd_core_file < 0)
> +			goto out;
> +
> +		if (recv_coredump_notify_signal(fd_coredump, fd_core_file,
> +						true) < 0)
> +			goto out;

[ ... ]

> diff --git a/tools/testing/selftests/coredump/coredump_test_helpers.c b/t=
ools/testing/selftests/coredump/coredump_test_helpers.c
> index 2a20faf9cb0ad..f8d416180d5b3 100644
> --- a/tools/testing/selftests/coredump/coredump_test_helpers.c
> +++ b/tools/testing/selftests/coredump/coredump_test_helpers.c
> @@ -381,3 +391,304 @@

[ ... ]

> +static int make_file_mappings(void)
> +{
> +	long pgsz =3D sysconf(_SC_PAGESIZE);
> +	int fd, i;
> +
> +	fd =3D open(NOTIFY_SIGNAL_MAPFILE,
> +		  O_RDWR | O_CREAT | O_TRUNC | O_CLOEXEC, 0600);

[Severity: High]
Does this file creation face the same symlink overwrite vulnerability as
the other hardcoded /tmp paths?

> +	if (fd < 0)
> +		return 0;
> +	if (ftruncate(fd, (off_t)NOTIFY_SIGNAL_MAP_COUNT * pgsz)) {
> +		close(fd);
> +		return 0;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260824-work-tif_n=
otify_signal-v2-0-6609e42b3157@kernel.org?part=3D3
