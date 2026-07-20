Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650C33C81B9
	for <bpf@vger.kernel.org>; Mon, 20 Jul 2026 10:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541624; cv=none; b=Ff7KdWbOzIchntNBxZPtYdhKABtN3pN+Qml0whLa1BndObRPiZs7ONf+W1t5cZy+9Q/hZ9ydWzTAxXeCsUjk8/hiz3TFvgheQcLv6nIGQkVxBvaslRn7bYYSqoWvg/6rW2e92PRgdDG9VQys7Bx+6mQCoTQXbUutteWs67kOkus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541624; c=relaxed/simple;
	bh=Ox5xuzzNPTI0VVUullMc/BDq5C7Kwa8mWw+23uSR4h4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bCIm33mQPhh1m/2Qm9aFU5qG4r59dP/7pCZpW8kOy1UEaR/Gtgwn2Y53cAvfRwWBIAXRmkjTsW2rqxeO21Cq36/54ScPahQ1EM+1lTO+Ng2vfxVuB69IqmZ54dviPc6YlkwtOATUkTyVQ8a892Fp4C6TNftl+7nv9z37OG25f3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfGHdXNO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfGHdXNO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9212B1F00A3A;
	Mon, 20 Jul 2026 10:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784541622;
	bh=hKNk9p0aSJLb4UhRp8r3ZRZO80pvIx1qv5/uXoP+EoI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nfGHdXNOFQrcjksPNxpHno3s86V5TEMfflw6CHZ03URr0tRF77j3byy88i/2Vo5+L
	 LsqaiJ1TJTVsraocEBDD9pZ7y76baIWQZjuwrperUV76MKvHmKK6Y6jAmSLq1Xfp3E
	 m4ua7omr6XW9kDIak2uw+NdYF1mgWHOvM5HICUY6nEe81k2NChViS5uAIyf9avSaRa
	 D+bszo3fuhWBUzFLmvP6bKqsBs2fx5G+urPwWXoFIaDC7ABl5j6SPpAy7zVFhWosu2
	 ke6CeFtSEFD4iRYzr/bEzMKXNY73NQxf5PMI5x614nawHb26pZdcsxqXePOb1JyW9a
	 bBY5LgrpWT4EA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/21] exec: do not act on a stale execfd request
 without an executable
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260720-work-bpf-binfmt_misc-ptinterp-v1-1-ddb76c9a508e@kernel.org>
References: <20260720-work-bpf-binfmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org>
 <20260720-work-bpf-binfmt_misc-ptinterp-v1-1-ddb76c9a508e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 10:00:22 +0000
Message-Id: <20260720100022.9212B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch fails =
to fix it completely. It fails to clear leaked `have_execfd` and `execfd_cr=
eds` flags if the fallback format uses an interpreter (e.g., `binfmt_script=
`), potentially allowing setuid script execution.
--

--- Patch [1]: [PATCH 01/21] exec: do not act on a stale execfd request wit=
hout an executable ---
commit 9dcfa7daaba6407f79aa884e4fa9f0bc5d755870
Author: Christian Brauner <brauner@kernel.org>

exec: do not act on a stale execfd request without an executable

This commit addresses an issue where binfmt_misc leaves bprm->have_execfd
and bprm->execfd_creds set when it fails to open an interpreter. It clears
these flags in begin_new_exec() if bprm->executable is NULL to prevent a
subsequent NULL pointer dereference.

> diff --git a/fs/exec.c b/fs/exec.c
> index c698aabe9abd0..2f50aa0398278 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -1112,6 +1112,12 @@ int begin_new_exec(struct linux_binprm * bprm)
>  	struct task_struct *me =3D current;
>  	int retval;
> =20
> +	/* A declined execfd request has no executable for a later format. */
> +	if (!bprm->executable) {
> +		bprm->have_execfd =3D 0;
> +		bprm->execfd_creds =3D 0;
> +	}

[Severity: High]
This isn't a bug introduced by this patch, but does this check completely
resolve the leaked flags issue?

If load_misc_binary() leaks the have_execfd flag and the kernel falls back =
to
binfmt_script, it looks like exec_binprm() might unconditionally consume the
leaked flag and set bprm->executable to the script:

fs/exec.c:exec_binprm() {
    ...
    if (unlikely(bprm->have_execfd)) {
        if (bprm->executable) {
            fput(exec);
            return -ENOEXEC;
        }
        bprm->executable =3D exec;
    } else
    ...
}

In the case of a setuid script with a statically linked interpreter (like
#!/sbin/busybox.static sh), would this cause begin_new_exec() to see a
non-NULL bprm->executable?

If so, would it bypass this cleanup and compute credentials from the script
rather than the interpreter, potentially honoring the setuid bit on the scr=
ipt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-work-bpf-b=
infmt_misc-ptinterp-v1-0-ddb76c9a508e@kernel.org?part=3D1
