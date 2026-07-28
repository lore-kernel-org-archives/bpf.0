Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F623ACF02;
	Tue, 28 Jul 2026 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245430; cv=none; b=ac8zJkCo/5tHttjIOZB9ujYNifyVBFuD9Zxa3e1In/PxI5Ye9GuKFFbWrwmV4KtJzpEYjwdct/DZ4GLkUYT180dbDRI3MMUz7zKoCmI+oMYT/dwbk3BN7MrQljbXOuRwHWi7qy4gNzksd8OsXK54i8itYBX74xkA5Udwbyu4CGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245430; c=relaxed/simple;
	bh=SoBAU7Engs1fLo9xe9F0d1LAQWnIhva3W+U2HFjh1H8=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=uoJeTFZ08Dbmf4iRU25n5QPlCNqRnIiMpyYip1kterAyeXSwvv/g5MfmaNGr8OOID2CCCKJw5IylOvDXf7UJWFlm0rr1tAp0gkn2bkFREr0I2QHAxm9bEp+6DzAhtvfxzIowN2CW5a0KSwirfpGFOc49tmT0CZ6S3bHJ0WG385Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZTevtNp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZTevtNp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2B51F000E9;
	Tue, 28 Jul 2026 13:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785245426;
	bh=E7k8qpO7ZE6dySGmGX/R7cCp+G4Bal4pIf1ocTwL8+c=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=VZTevtNpGHn94oGJVcaCIQk1sAFk4Gvcye9pA+TAXvdCzkjDhRs+gijfNbQ1Q0T4X
	 gQP+AoDx9qrmj3aKshU8ciDC7ZJABP3rK90R3S71L8oatpXzNpL0RdlWVO/250RzLC
	 qZqds+HC/bNTpKB9Fj+zCH/fB8Y9K/i00tmA7CVnH/U56XsRenKX/r/SRTYLuN3Dye
	 xAu4pTdtHoY/VhBsYBpNDc3PH8uUb57fCCDy6eGCVIJ/kmzNjkExoodSinQD6i8Rz2
	 lju85+ObxSz0OLxUZRoLsL6bV0m5u9I5AmlfV/gqZV+Y1BNjrc7Ew5rf13DlMDxCg4
	 PcICqoLsAMlAw==
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/2] binfmt_misc: don't let an 'F' entry pin its own
 instance
From: Christian Brauner <brauner@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Christian Brauner <brauner@kernel.org>, bpf@vger.kernel.org
In-Reply-To: <20260728124404.B23671F00A3A@smtp.kernel.org>
References: <20260728-work-binfmt_misc-selfpin-v1-0-74df5daeca5b@kernel.org>
 <20260728-work-binfmt_misc-selfpin-v1-1-74df5daeca5b@kernel.org>
 <20260728124404.B23671F00A3A@smtp.kernel.org>
Date: Tue, 28 Jul 2026 15:30:23 +0200
Message-Id: <20260728-asymmetrie-waghalsige-luftig-0ad562353bb4@brauner>
X-Mailer: b4 0.16-dev-cca4b
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; i=brauner@kernel.org;
 h=from:subject:message-id; bh=SoBAU7Engs1fLo9xe9F0d1LAQWnIhva3W+U2HFjh1H8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRlrPuYa7x0567e/oYu5+/RLJPXGAesVp/iE78kSi1+3
 du/VsrHOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby4yMjw9Iv2Vo2h3xE2PYp
 3pLbEL6bo740ZJ0O67EFFzetDsp0LGFk+LBktS/bCTv520/mc/9pUfjfL33p5JsFXw5V/t+Yt2l
 FPysA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

> [ ... ]
> 
> Looking at the rest of bm_fill_super() in fs/binfmt_misc.c:
> 
> 	err = simple_fill_super(sb, BINFMTFS_MAGIC, bm_files);
> 	if (!err)
> 		sb->s_op = &s_ops;
> 	return err;
> }

This _seems_ legit but I need to double-check.

> [Severity: High]
> This is a pre-existing issue, but does this error path permanently leak the 
> user_namespace reference?
> 
> If simple_fill_super() fails, or if a memory allocation failure occurs 
> earlier in bm_fill_super(), sb->s_root remains NULL. When vfs_get_super() 
> handles the error, generic_shutdown_super() will skip calling 
> s_op->put_super(sb). 
> 
> Since fc->s_fs_info was already cleared during sget_fc(), does this mean 
> the user_namespace reference in sb->s_fs_info is never released?
> 
> Could an unprivileged local user trigger this by intentionally failing 
> userns mounts (e.g., via memory exhaustion) to cause resource exhaustion?
> 
> 
> On a related note regarding pre-existing issues, looking at 
> put_binfmt_handler() in fs/binfmt_misc.c:
> 
> static void put_binfmt_handler(struct binfmt_misc *e)
> {
>         ...
>         if (e->flags & MISC_FMT_OPEN_FILE)
>                 filp_close(e->interp_file, NULL);
>         kfree(e);
> }
> 
> [Severity: High]
> This is a pre-existing issue, but does this teardown path leak the negative 
> i_writecount of the interpreter file?
> 
> When an entry is registered with the 'F' flag, bm_register_write() uses 
> open_exec(), which internally decrements the inode's i_writecount to prevent 
> concurrent writes. While the error path during registration calls 
> exe_file_allow_write_access(), put_binfmt_handler() only calls filp_close(). 
> 
> Since filp_close() does not automatically restore executable write access, 
> would deleting the binfmt_misc entry permanently leave the binary unwritable 
> (returning -ETXTBSY) until reboot?

This is fixed in another patch series of mine.

