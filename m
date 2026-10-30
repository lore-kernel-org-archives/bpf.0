Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793386926;
	b=eS4tvzs6vLta+sXV3bHX4OfE47IOPP/KHLhou3SGcTS45mYGS5+LJ6yR3xd0LaOLZg0i
	 w3ESjTIhRXJfRoeRqdb5v/gy0GTiCbKRSePLf3rHxejEXNaDy50Tp7XWD7VgTzGAVzhX3
	 MuehkaGlbRDaNx4deZm9aZDGY4A8g5YceaJ/JL1p0Qnniwl54DMqmW+iC1lTBQBdZI1uo
	 kZzxKmVr9S8Nzce/VtkLD1/k8se6KLL/dpOC5/p9tcvR0e3zVDgyS50e6fsKOmIGiteDL
	 TApTn1LFigkeT6OC3PB8H+vA+lLtpotXWMUCq4PZtclx4/9AbDGgZPTU6L1j1c2HsVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386926;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qgo2eFfdYZE4US6A3BdNxMMkp63sSL0928N+G+O3344=;
	b=KaPCkkdyf7xJaPduo6e7GcnjFEEE2EIwWiRu2Y1qKVyLtvPNIXpV6lw+lZaH2N5YtWOK
	 H0DZMvP3Tdx/L9gMch1FDsIptWMuk2KwhS154UwzxwoXO05CS5/B1hl+t9QukVBC16Di+
	 fCw5RYRIEVHWG/lJ1c0zcUVJUdl9H2CzabkUrITCI0XhgfndwCzRPSDKCiK8Kbv3tZRo4
	 Rck48uMGwWPTTNg21OsNTurqsdjz92u+ZZr5xtxdpte2VK78kY0Oh8pH+g2n1kaYLFViF
	 G/C4bSYyGYWRnha28NICIQtb7RMwL3Uj9V/ZBarC2+vrbOxWhC9fj166B2zyRyKeTJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChuCNvDt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2C606A31A
	for <bpf@vger.kernel.org>; Fri, 30 Oct 2026 19:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ChuCNvDt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C79B1F0093A;
	Fri, 30 Oct 2026 19:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793386925;
	bh=qgo2eFfdYZE4US6A3BdNxMMkp63sSL0928N+G+O3344=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ChuCNvDt0PmOSSQf9zYfBI4Htzz/QFg3uQro8jMIe7nxkTysatWKPxO/MlFtAiTeF
	 Q3DEiGbpPj2il+JUCVS+7dZ9CJATljvdgSq2KnaDOKrvXnNCqWmQfFPgjMjR6wJ9db
	 Ynrv0zRNrpCk0TTeeMxeY8016TVcRe5d6vK9jVeNV5aaCD330L8eZBvWQ/CAS6pjwI
	 pbwJBB4yV3r4xej3IgWq+yIithiC/4JPz8ftBIncKl2uBRxCmtb9wTZanxe7N2zssu
	 vt+TphYXmyjZKsLSaOmmNVwnIH3oxsGvFpvRrJRhym5BOsmsS71b+ZaGkAFQ5Pz8u7
	 o2GMhhA+BWhfA==
Message-ID: <sashiko-outbox-191429@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] selftests/bpf: add helpers to manipulate
 ftrace
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QWxleGlzIExvdGhvcsOpIChlQlBGIEZvdW5kYXRpb24p?= <alexis.lothore@bootlin.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261030-ftrace_in_test_progs-v1-1-aa50c5dd1ccc@bootlin.com>
References: <20261030-ftrace_in_test_progs-v1-0-aa50c5dd1ccc@bootlin.com>
 <20261030-ftrace_in_test_progs-v1-1-aa50c5dd1ccc@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 19:02:05 +0000
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Medium] selftests/bpf: unchecked realloc() in tracefs_read() causes NULL=
 deref
- [Medium] selftests/bpf: tracefs_ctl_update() fails to truncate filter on =
first write
- [Medium] selftests/bpf: tracefs_ctl_update() ignores tracefs_read() failu=
re
- [Medium] selftests/bpf: tracefs_write() drops multi-token filters on shor=
t write
- [Medium] selftests/bpf: tracefs helpers return -1 instead of -errno on sy=
scall error
--

commit 569748d9037859f0dfb26ca03c10fd22fc3a99b9
Author: Alexis Lothor=C3=A9 (eBPF Foundation) <alexis.lothore@bootlin.com>

selftests/bpf: add helpers to manipulate ftrace

This commit adds tracefs control helpers to tools/testing/selftests/bpf/
so tests can modify ftrace settings and filters and automatically restore
their original state upon completion.

> diff --git a/tools/testing/selftests/bpf/trace_helpers.c b/tools/testing/=
selftests/bpf/trace_helpers.c
> index 6d7a4b8c4ab8c..1f26a057a810a 100644
> --- a/tools/testing/selftests/bpf/trace_helpers.c
> +++ b/tools/testing/selftests/bpf/trace_helpers.c

[ ... ]

> @@ -557,6 +561,245 @@ void read_trace_pipe(void)
>  	read_trace_pipe_iter(trace_pipe_cb, NULL, 0);
>  }
> =20

[ ... ]

> +static int tracefs_read(int fd, char **content)
> +{
> +	size_t len =3D 0;
> +	char tmp[CHUNK_SIZE];
> +	char *buf =3D NULL;
> +	ssize_t n;
> +	int ret;
> +
> +	ret =3D lseek(fd, 0, SEEK_SET);
> +	if (ret < 0)
> +		return ret;
> +
> +	do {
> +		n =3D read(fd, tmp, CHUNK_SIZE);
> +		if (n < 0) {
> +			if (buf)
> +				free(buf);
> +			return n;
> +		}
> +		if (!n)
> +			break;
> +		buf =3D realloc(buf, len + n + 1);
> +		memcpy(buf + len, tmp, n);

[Severity: Medium]
What happens in tracefs_read() if realloc() fails while reading chunks from
the tracefs file? Assigning the return value directly to buf loses the
existing buf allocation and then dereferences NULL + len in memcpy().

> +		len +=3D n;
> +	} while (1);
> +
> +	/* No data read at all, file was empty */
> +	if (!buf) {
> +		buf =3D malloc(1);
> +		if (!buf)
> +			return -ENOMEM;
> +	}
> +	buf[len] =3D '\0';
> +	*content =3D buf;
> +	return 0;
> +}
> +
> +static int tracefs_write(int fd, const char *str)
> +{
> +	ssize_t ret;
> +
> +	ret =3D lseek(fd, 0, SEEK_SET);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D write(fd, str, strlen(str));
> +	if (ret < 0)
> +		return ret;
> +	return 0;
> +}

[Severity: Medium]
Can a single write() call in tracefs_write() drop patterns when writing to
ftrace filter files?

In kernel/trace/ftrace.c, ftrace_regex_write() (for set_ftrace_filter and
set_ftrace_notrace) and ftrace_graph_write() (for set_graph_function and
set_graph_notrace) parse user input with trace_get_user(), which stops at
the first whitespace character and returns the byte count consumed for only
that single token.

When a caller passes multiple space-separated patterns (or a function with
a module suffix like "func [mod]\n" during tracefs_restore_file()), write()
returns a short byte count for the first token and tracefs_write() returns 0
without looping to write the remaining tokens.

In addition, if a pattern does not end with whitespace or a newline,
trace_get_user() marks the parser as a continuation (parser->cont =3D true)
and defers regex evaluation until close(), where release errors are not
reported back to close(fd).

> +
> +static int tracefs_write_file(const char *path, const char *str)
> +{
> +	int fd, err;
> +
> +	fd =3D open(path, O_CLOEXEC | O_WRONLY | (*str ? 0 : O_TRUNC));
> +	if (fd < 0)
> +		return fd;
> +
> +	err =3D tracefs_write(fd, str);
> +	close(fd);
> +	return err;
> +}

[ ... ]

> +static int tracefs_ctl_update(struct tracefs_ctl *ctl, const char *file,
> +			      const char *str, enum tracefs_ctl_kind kind)
> +{
> +	struct tracefs_ctl_entry *entry, *tmp;
> +	char path[PATH_MAX];
> +	char *old =3D NULL;
> +	bool recorded =3D false;
> +	size_t i;
> +	int fd, err;
> +
> +	if (!ctl)
> +		return -EINVAL;
> +
> +	err =3D tracefs_path(path, sizeof(path), file);
> +	if (err)
> +		return err;
> +
> +	for (i =3D 0; i < ctl->cnt; i++) {
> +		if (strcmp(ctl->entries[i].path, path))
> +			continue;
> +		if (ctl->entries[i].kind !=3D kind)
> +			return -EINVAL;
> +		/* Already altered, keep the value read on the first write. */
> +		return tracefs_write_file(ctl->entries[i].path, str);
> +	}
> +
> +	fd =3D open(path, O_CLOEXEC | O_RDWR);
> +	if (fd < 0)
> +		return fd;
> +
> +	err =3D tracefs_read(fd, &old);
> +	if (!err) {
> +		tmp =3D realloc(ctl->entries, (ctl->cnt + 1) * sizeof(*tmp));
> +		if (!tmp) {
> +			free(old);
> +			close(fd);
> +			return -ENOMEM;
> +		}
> +		ctl->entries =3D tmp;
> +		entry =3D &ctl->entries[ctl->cnt];
> +		strcpy(entry->path, path);
> +		entry->old =3D old;
> +		entry->kind =3D kind;
> +		recorded =3D true;
> +	}
> +
> +	err =3D tracefs_write(fd, str);
> +	close(fd);

[Severity: Medium]
Should tracefs_ctl_update() bail out when tracefs_read() returns an error?
Right now, if tracefs_read() fails, execution skips recording the entry in
ctl->entries and proceeds to tracefs_write(fd, str), which modifies the
tracefs file without saving its original value for tracefs_ctl_restore().

Also, when the first operation on a tracefs file passes an empty string ""
to clear it (such as clearing set_ftrace_filter or set_graph_notrace), does
calling tracefs_write(fd, str) on the O_RDWR descriptor actually clear the
filter?

In kernel/trace/ftrace.c (ftrace_regex_open() and __ftrace_graph_open()) and
kernel/trace/trace.c (tracing_open()), clearing a filter or trace file
requires opening it with O_TRUNC, whereas a 0-byte write() to a descriptor
opened without O_TRUNC is a no-op. Unlike tracefs_write_file(), which opens
with O_TRUNC when *str is empty, the first update in tracefs_ctl_update()
writes to the descriptor opened with open(path, O_CLOEXEC | O_RDWR). Should
tracefs_ctl_update() close fd after tracefs_read() and use
tracefs_write_file(path, str) instead?

[ ... ]

> +void tracefs_ctl_restore(struct tracefs_ctl *ctl)
> +{
> +	size_t i;
> +	int err;
> +
> +	if (!ctl)
> +		return;
> +
> +	for (i =3D ctl->cnt; i > 0; i--) {
> +		struct tracefs_ctl_entry *entry =3D &ctl->entries[i - 1];
> +
> +		err =3D tracefs_restore_file(entry);
> +		if (err)
> +			fprintf(stderr, "Failed to restore %s: %s\n",
> +				entry->path, strerror(-err));

[Severity: Medium]
In tracefs_ctl_restore(), strerror(-err) expects negative errno values,
which matches internal errors like -ENOMEM, -EINVAL, and -ENAMETOOLONG.
However, when open(), lseek(), read(), or write() fails in tracefs_read(),
tracefs_write(), tracefs_write_file(), or tracefs_ctl_update(), those
functions return -1 rather than -errno. Won't any syscall failure during
tracefs_restore_file() cause strerror(-err) to evaluate strerror(1) (EPERM)
instead of the real errno?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-ftrace_in_=
test_progs-v1-0-aa50c5dd1ccc@bootlin.com?part=3D1
