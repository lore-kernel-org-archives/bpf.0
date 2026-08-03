Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB0930F526
	for <bpf@vger.kernel.org>; Mon,  3 Aug 2026 02:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785724132; cv=none; b=OrKb3adSOIaapjeeIFMpWTHuQJPvuq4KId5vu2aJOkR6BHJL8b8bHQVyC5Cx20xfYFvuiiOFwRvwlhWaPnIrCYbG77C0QjUjBwluGLyoYELbWJK6YbmOBDBly3vzd0A4+gRB0mBcX4izgi7ywHbExVicH9XN3EcsCh8t+Pe4brk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785724132; c=relaxed/simple;
	bh=nkG2rJXEEJSPsdeY++AM8bHYFpXtt3/YNhjuEeVJjko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QAZ6518CU3X/20CHUUHu1fgo+0sATeDWgA6jdFmaEDwvHTsyKIUcjaK9N3oYsoBpl8xVdMpB9shL3TEAGSk0X7la10Zu0/8csO0qOsyFcSu3UDOjvjiQQ5DdHPukau19pl035/WnuQ4ecS7LIOGNqB4aEg7Vb6LoaOM3eOz42fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KYEGKHLH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KYEGKHLH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 785B81F00ADF;
	Mon,  3 Aug 2026 02:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785724130;
	bh=T6jYh40DzacNFpd7onPEpjt2TPlgdizGDp1nV6KU+rI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KYEGKHLHa1P6gQv7uQrRasILrg9Is7qprA2t1w19bNdTBV0cEdV6fZ/NewKNEDmif
	 mdZMwYPPW47j03GPdfQISvtQhbHWXjH966cwo36qp47pb5g0rY8ADn+q0m3PM+1Lci
	 ORkjqd/ybBOC6nJ4/hYywn0wzYKlsUmCS+2I+XLF1arXnaA1J6ovb5A3n6AkhARtRS
	 RM+u6ha47MRyQDZJW7JT9bd3SDdFicyX/aYeKTFqWA32fgIl1ILiHZPh6idAem+lue
	 OGOFt23/yFqqiWfvUpDEm4BxNDbrxL7RPtLPkccg/C0vkGG3kFBwg3s/oKyZc9BGPV
	 lL+Gc6gkoIxJA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next] bpf: add BPF_F_SEALED flag to seal BPF links
 at creation
Reply-To: sashiko-reviews@lists.linux.dev
To: "David Windsor" <dwindsor@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260803021643.2189641-1-dwindsor@gmail.com>
References: <20260803021643.2189641-1-dwindsor@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Aug 2026 02:28:50 +0000
Message-Id: <20260803022850.785B81F00ADF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] The BPF_F_SEALED flag is applied via a file descriptor lookup afte=
r the FD has been exposed to user space, creating a TOCTOU race that allows=
 cross-object sabotage and unauthorized link sealing.
- [High] The implementation of BPF_F_SEALED introduces a permanent memory l=
eak, enabling a Denial of Service (DoS) via kernel resource exhaustion.
- [Medium] Concurrent executions of `link_seal_fd` on the same link can lea=
k multiple self-references due to a missing atomic read-modify-write.
--

--- Patch [1]: [PATCH bpf-next] bpf: add BPF_F_SEALED flag to seal BPF link=
s at creation ---
commit f9d98fb378be461fdf9509562339b45a07b8d912
Author: David Windsor <dwindsor@gmail.com>

bpf: add BPF_F_SEALED flag to seal BPF links at creation

This commit introduces a new BPF_F_SEALED flag for BPF_LINK_CREATE that
creates a permanently sealed link. A sealed link cannot have its program
replaced, cannot be detached, and holds an extra self-reference so it
persists until reboot.

> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index 94091130bcc50..e8bd57d5c907a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
[ ... ]
> @@ -5776,17 +5777,41 @@ static int bpf_map_do_batch(const union bpf_attr =
*attr,
>  	return err;
>  }
> =20
> +/* Seal the just-created link: take a self-reference that is never relea=
sed. */
> +static void link_seal_fd(int fd)
> +{
> +	struct bpf_link *link;
> +
> +	link =3D bpf_link_get_from_fd(fd);
> +	if (IS_ERR(link))
> +		return;
> +
> +	if (!READ_ONCE(link->sealed)) {

[Severity: Medium]
Is this flag check safe against concurrent execution?

If the file descriptor is raced via dup2(), multiple threads might enter
link_seal_fd() for the same victim link concurrently. Since the READ_ONCE()
and WRITE_ONCE() are not atomic, could multiple threads observe false and
increment the link reference count multiple times?

> +		bpf_link_inc(link);
> +		WRITE_ONCE(link->sealed, true);

[Severity: High]
Does taking a self-reference here without any release path allow users to
exhaust kernel memory?

Since link_detach() explicitly returns -EPERM for sealed links, a user could
repeatedly create sealed links and close the fds, leaking the bpf_link and
bpf_prog indefinitely. Is there an administrative way to reclaim this memor=
y?

> +	}
> +
> +	bpf_link_put_direct(link);
> +}
[ ... ]
> @@ -5880,6 +5905,9 @@ static int link_create(union bpf_attr *attr, bpfptr=
_t uattr)
>  out:
>  	if (ret < 0)
>  		bpf_prog_put(prog);
> +out_seal:
> +	if (ret >=3D 0 && seal)
> +		link_seal_fd(ret);

[Severity: High]
Does looking up the link from the file descriptor here create a race
condition?

By the time link_create() reaches this point, attach functions called
earlier have already installed the fd into the process's file descriptor
table.

Could a concurrent thread use dup2() to overwrite this fd with one pointing
to a different victim bpf_link before link_seal_fd() executes? This would
cause the system to permanently seal the victim link instead of the newly
created one.

>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260803021643.2189=
641-1-dwindsor@gmail.com?part=3D1
