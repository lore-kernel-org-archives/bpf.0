Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9586368D5E
	for <bpf@vger.kernel.org>; Mon, 10 Aug 2026 09:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353606; cv=none; b=jaYW6ftgi7uZSmpdFNcxm1GPyX71ZLanmAHTzW3OQdBytDjNPeHLVvDJDXwrMnhwjLu9ZeP5h88ZOwOJpZneRi2zNCTIQ87yJx9M4geag9ZqAW9NskoQMLJ7MVTmTWQ4gfsfNv8a/b4cTPjYQYIgWk7+0zYMe9l4fujTPWbFkw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353606; c=relaxed/simple;
	bh=jHJ2/Fs8Fnao8T8pDx13bTvap6/RakRPwx6StnNBqSQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ni2PzTgvmTxKwM5PW/eQmu4VBiOYVks0kUuizGqvwRpAy/MKRaMS20srfUryuU+rWkBY0m/ptBDX2XX6AereqjvIu4lP81qvPApE8FkG78TgVmioWiP27Lk0bz5qc4/jnihA1zmByjJ2CTdST4C2nnmpYn1w9L31QmmDRql49jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGzFPD0F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGzFPD0F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36DF01F00A3A;
	Mon, 10 Aug 2026 09:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786353604;
	bh=7fyK8zEMMqIsItMmVFZ2A92EdJW8A8ywenv3TX6XQBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hGzFPD0FabfSeLJDdw9jJ+f4KBjzEwdYzFW6k5F1NzeRP87I7hLdf/7Ybt+xM6Kva
	 4p/v0q0AVkrn+fs85FVQe7tmDHpzxnNzbvvg7gFI2I9svMeIZbZJbhu0F+awIAwWP9
	 Cg/n2A+L/ms3hL6YzqrVkxXWGkOAodHnVrAg3XlLT+bVqT3XFiL0D+DQ/x49n/3c6a
	 FUDjkNSjU3J+W/hQGylAPCVkgqdSSn4VCBMnM3G4441Z4oWROJzdipOyksl86oXIql
	 DuRXE7JGIMc7JF1cF6vIgAkl1aYtsvdcVM23LLYUMP9RMOd1x5Th4O4VNaMBrUBNFT
	 IiG9BhhlfFHCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/3] bpftool: fix double close in map dump
Reply-To: sashiko-reviews@lists.linux.dev
To: chenyuan_fl@163.com
Cc: bpf@vger.kernel.org
In-Reply-To: <20260810090459.2666243-2-chenyuan_fl@163.com>
References: <20260810090459.2666243-1-chenyuan_fl@163.com>
 <20260810090459.2666243-2-chenyuan_fl@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 09:20:03 +0000
Message-Id: <20260810092004.36DF01F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Missing error propagation when `bpf_map_get_info_by_fd()` fails =
on subsequent maps in `do_dump()`.
- [Medium] Double close of map file descriptors in `do_show_subset()`.
--

--- Patch [1]: [PATCH bpf-next v4 1/3] bpftool: fix double close in map dum=
p ---
commit 8a5aea6bcad40d4506c71d6f8f2b151ddbe0ed20
Author: Yuan Chen <chenyuan@kylinos.cn>

bpftool: fix double close in map dump

This commit fixes a double close in map_dump() where the map file
descriptor was being closed in the error path, and then closed again
afterward by do_dump().

> diff --git a/tools/bpf/bpftool/map.c b/tools/bpf/bpftool/map.c
> index 6b9649294ca1a..e9f4dd9458cf1 100644
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -895,7 +895,6 @@ map_dump(int fd, struct bpf_map_info *info, json_writ=
er_t *wtr,
>  exit_free:
>  	free(key);
>  	free(value);
> -	close(fd);
>  	free_map_kv_btf(btf);
> =20
>  	return err;

[Severity: Medium]
This is a pre-existing issue, but I noticed another double close pattern=20
in tools/bpf/bpftool/map.c:do_show_subset():

tools/bpf/bpftool/map.c:do_show_subset() {
    ...
		if (json_output)
			show_map_close_json(fds[i], &info);
		else
			show_map_close_plain(fds[i], &info);

		close(fds[i]);
    ...
}

Since the show_map_close_json and show_map_close_plain functions already
unconditionally close the file descriptor, does the subsequent close(fds[i])
result in a double close?

This seems like it would also poison later errno checks exactly like the
bug this patch addresses.


[Severity: Medium]
This is a pre-existing issue, but while looking at do_dump() in the same=20
file, there appears to be a missing error propagation:

tools/bpf/bpftool/map.c:do_dump() {
    ...
	for (i =3D 0; i < nb_fds; i++) {
		if (bpf_map_get_info_by_fd(fds[i], &info, &len)) {
			p_err("can't get map info: %s", strerror(errno));
			break;
		}
		err =3D map_dump(fds[i], &info, wtr, nb_fds > 1);
    ...
}

If a user executes bpftool with multiple map file descriptors, and
bpf_map_get_info_by_fd() fails on any iteration after the first, the loop
breaks without updating err.

Doesn't this incorrectly cause bpftool to exit with a success status if
the previous iteration succeeded, silently hiding the error from scripts or
users relying on the exit code?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810090459.2666=
243-1-chenyuan_fl@163.com?part=3D1
