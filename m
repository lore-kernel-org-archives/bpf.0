Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5D9730DEB2
	for <bpf@vger.kernel.org>; Thu, 30 Jul 2026 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785419146; cv=none; b=G/Bvzyj/Vb07fHc22rAsNUFlkBtIArYv4/It+cpoIA4Y27QF6FvCx/Qq9+R1RjAOl+y+Apa9dc8IhpDLAkgAk0w87u6r9KjlmQO1lTBdxl6/bTVeV+RLK2ljjs9kCF12t1/LWbsBHwoqNRYEmdaeX/Zrlq9+kVoLxrRaYr+4jTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785419146; c=relaxed/simple;
	bh=+Qf6reX397qPyNLRKzXpTON85DDsGg52k3v/VcPqm+4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rz+CLPdoWVhOFPTPNRXdgftcka9Hd4NKMU4el9nfrffSLUJBoiLWoZ+lousT+QkBEL26BzKP3jAMTaVZy/WiM+gtHFpcyOaB2HiM1gH+SMPxO4q+2RcYG+L5c7We2aYmpMV2/0grSR+KJf8V6IS+RvR6GbJTrF9Iuh+9dJY8VA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt7HlKd/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt7HlKd/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 451731F000E9;
	Thu, 30 Jul 2026 13:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785419145;
	bh=TnhqTmPfkGTR5NglgS7LuSRtlUoALZ6makZ1/i8Bfss=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Bt7HlKd/JDC9p3hI7hlEFEPfLU3tjVRhZXD9LjSj+nxsBjbXIq/OlbGLaqZ9bgGsQ
	 5qqM2mOqq1NM6u4Agm/W2mYGBbMr2biQTyTsg3AVr09YhG4QvnlAbd3XHIlz+J2yyo
	 VUfMZwZQSnyGLruAkChK4bpHZCZ825PKkTTmOyb2FWPjEyqqBWsO6wiyU6ghUPOOiv
	 XA1cKYPaFagN+CUL4ktCu+ltyy1QvazuJYbutKp7zB2ooWRdKj/Jul0M8HywCF6utA
	 lQiLGrl1PnOublyE3rLbM69AMuClhsaDtbmVBE8kovvY7xTsr32FXZJN/CEtp8/Za3
	 /eIZs7ktiRtJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] selftests/exec: test registering an entry disabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260730-work-binfmt_misc-preopen-v1-3-4a0b0da71f16@kernel.org>
References: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
 <20260730-work-binfmt_misc-preopen-v1-3-4a0b0da71f16@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 13:45:44 +0000
Message-Id: <20260730134545.451731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The `removed_by_remove_all` test permanently clears all active `bi=
nfmt_misc` entries system-wide, destroying the host system's configuration.
--

--- Patch [3]: [PATCH 3/9] selftests/exec: test registering an entry disabl=
ed ---
commit 887542eb0fe41cea7f35d27e339ff39a03f72a8a
Author: Christian Brauner <brauner@kernel.org>

selftests/exec: test registering an entry disabled

This commit adds a test for the 'D' flag in binfmt_misc, which allows
registering an entry in a disabled state. It verifies that the entry does
not dispatch until enabled, retains the correct status, and can be toggled
or removed.

> diff --git a/tools/testing/selftests/exec/binfmt_misc_disabled.c b/tools/=
testing/selftests/exec/binfmt_misc_disabled.c
> new file mode 100644
> index 0000000000000..47c9e8a4ee42a
> --- /dev/null
> +++ b/tools/testing/selftests/exec/binfmt_misc_disabled.c

[ ... ]

> +/* '-1' to the status file sweeps a staged entry with everything else. */
> +TEST_F(disabled, removed_by_remove_all)
> +{
> +	int fd;
> +
> +	ASSERT_EQ(write_reg(RULE("D")), 0);
> +	EXPECT_TRUE(entry_shows(ENTRY, "disabled"));
> +
> +	fd =3D open(BINFMT_DIR "/status", O_WRONLY | O_CLOEXEC);
> +	ASSERT_GE(fd, 0);
> +	ASSERT_EQ(write(fd, "-1", 2), 2);

[Severity: High]
Could this inadvertently clear the host's global binfmt_misc configuration?

Writing "-1" to the status file triggers a removal of all binfmt_misc
entries system-wide. Since this test requires root privileges to run, but
doesn't appear to call unshare(CLONE_NEWNS) to isolate its mount namespace,
wouldn't this wipe out all active binfmt_misc registrations on the host
system running the selftests?

Other tests in the same directory (like binfmt_misc_selfpin.c) unshare the
namespace before modifying global settings. Does this test need a similar
isolation step to prevent breaking existing host configurations for
utilities like qemu-user-static or WINE?

> +	close(fd);
> +
> +	EXPECT_NE(access(BINFMT_DIR "/" ENTRY, F_OK), 0);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730-work-binfm=
t_misc-preopen-v1-0-4a0b0da71f16@kernel.org?part=3D3
