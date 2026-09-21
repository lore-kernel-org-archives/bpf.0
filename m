Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE7F3F3294
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 23:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032356; cv=none; b=HZykVRryIO8h2Y6I3WpPiG3bP+JvmTl6tJRYCEtX8JhQIPLZRolBGdLsY0lnyMNbkpi3+65s7cLU3UtYQKGjAEfhPx8Y8VNJaI3TiEGNTdZpJl0nfrNz1fiLZfMnhXlYduwee5V/o09rA6Zm+g3dForGgsoYbN96HQGiw2+FRUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032356; c=relaxed/simple;
	bh=8FaBWxla7g0xmQTtti5KlIh8p3BEkqCuY/vsqsl8W2Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FG8N6Cdo8d+weD6S+hOjAZk/yQPasHwCxHtQp+qWkW/wuwkUASkbs68wzwWqSluVBXGjXDhlgsf5EBUIyGC0jZtQVQrY3e++VK+LIBzK7VgILFLm8QlQTr8nuqql2lKueg6CJ1WOqZWXLB3oICgJR/GYEAbZ+0WFIRi068chk9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EJAfbbXn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EJAfbbXn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5331F000FF;
	Mon, 21 Sep 2026 23:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790032355;
	bh=n+YnqWlAdAxHbEVpmncknXlHe4ItN9FUpNW6TDzxQzA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EJAfbbXnL3uEWytR948FFdG7uD4lB9JGV5wBHq/FzvsSbJKCqXfpGMrph3aujha+q
	 yvcXw+oWBsXQFKoFgPvGSQpmgriLQ1iNo5eN3fAF3z9pJWu1z8Z2DJzBLIs8fV4rHC
	 c4R/WW2jLoryUwVgRLgglWM7Qz36Zzm9+LHQYano8KnMmLM4FZXgj+IuoKNKJRezhu
	 q3+aRlsiDXoTd2ZjV/Au9EmGjBdYxo3svWc7zHe85Wy5XYRx3nRrigrDyXOifdN3yI
	 NZL/l0gy9m/A8lwyt2WSmz155auTkXy34/zpH0a+nd+aOpJTOs1t9BVBLQVjTCon1b
	 MzPWL7Pgpb3YQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 3/7] libbpf: Support declarative manual load
 via SEC("!...") prefix
Reply-To: sashiko-reviews@lists.linux.dev
To: "Andrey Grodzovsky" <andrey.grodzovsky@crowdstrike.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921223937.3203093-4-andrey.grodzovsky@crowdstrike.com>
References: <20260921223937.3203093-1-andrey.grodzovsky@crowdstrike.com>
 <20260921223937.3203093-4-andrey.grodzovsky@crowdstrike.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 23:12:34 +0000
Message-Id: <20260921231235.0D5331F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] libbpf: BPF multi-line comment style violation in bpf_object__init_=
prog()
- [Low] libbpf: comment references non-existent bpf_program__load_manually(=
) API
--

commit ad283ccfb2e02481009ae746b5802475a68fb97e
Author: Andrey Grodzovsky <andrey.grodzovsky@crowdstrike.com>

libbpf: Support declarative manual load via SEC("!...") prefix
   =20
Add a SEC("!...") section-name prefix, letting a program declare itself
manually-loaded in its source instead of requiring an imperative
bpf_program__set_load_strategy() call. The prefix is recognized and strippe=
d in
bpf_object__init_prog(), directly setting the load_strategy to MANUAL.

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 939f0d6378e38..476172933a1fc 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -892,16 +892,25 @@ bpf_object__init_prog(struct bpf_object *obj, struc=
t bpf_program *prog,
>  	/* libbpf's convention for SEC("?abc...") is that it's just like
>  	 * SEC("abc...") but the corresponding bpf_program starts out with
>  	 * autoload set to false.

[Severity: Low]
This isn't a functional bug, but the BPF subsystem guidelines strictly requ=
ire
all multi-line comments in tools/lib/bpf/ to place the opening /* on its own
line. Since this patch expands the comment block to document the new SEC("!=
...")
prefix, should the opening /* be moved to its own line to align with the
formatting standards?

> +	 *
> +	 * Similarly, SEC("!abc...") marks the program for manual loading:
> +	 * it is skipped by the bulk auto-load pass and must be explicitly
> +	 * loaded later via bpf_program__load_manually().

[Severity: Low]
Is this comment accurate? It references bpf_program__load_manually(), but t=
here
is no such function in the libbpf API. Should this reference bpf_program__l=
oad()
instead?

>  	 */
>  	if (sec_name[0] =3D=3D '?') {
>  		prog->load_strategy =3D BPF_PROG_LOAD_STRATEGY_DISABLED;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921223937.3203=
093-1-andrey.grodzovsky@crowdstrike.com?part=3D3
