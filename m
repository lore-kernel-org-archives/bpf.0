Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4101F4AF17E
	for <bpf@vger.kernel.org>; Tue,  8 Sep 2026 10:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862863; cv=none; b=UvhZR2sQl3XOuQJqRV3twrwU3hvLKdjLJ+lhxgzE6l1vpaZzUFN4Pz9ZkMvISgAROeHoBF5HEu1bfDguN0JVw4qeJTK+LwEcUxLRAU9PXzaQRK7NlSpmpLNE6V/EbywyaC3xzfgUzqCZaJbrSRaaj5//MDwymY3HVOABEfJRD84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862863; c=relaxed/simple;
	bh=WJROOoqPC/Ks9I2BO/kt0UcpF3RoyLqU7Klc6tNZtCE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=T73U0Kz7DAZzjEnBbrtP+uNE1VW9ZMYSZIMsZM1Nqj5MZQX6iWP5uzmAYJlrOLhtnUSmJWQM37/hA3VFndspnAZPvwHyW5ZVsEQu7IC82hpXEMdJsFqmT60RlWhsIJ3UAjNncvWSXIwGUgjNHhTPDJhzjekZxYAiG4SvS6jQsqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdUgT8hI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mdUgT8hI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517B91F00A3A;
	Tue,  8 Sep 2026 10:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788862861;
	bh=rb5DiSyFnY2J2RGa9G7W/NtrKDNvQ3PW9iU8ofEWgqA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mdUgT8hIBVAWqEZ0+qDX84KFLHWLhfAvwXn9IyRqKqB7LF3h7cTVNS0Qujpb6eSZw
	 0gCvQpqmEhKHtGoXk73ax70mDcF0aYatTVkNUvPpX6eU0Qy/rA3vZjhRWhnagXxZho
	 OzUkxROfdZTCkf11PoYi73zW0NOAu7julKCmUIZd7xWItIB6lOB9o1Dj400J5GI8aE
	 eNUsweoUzRuhRf5nXXIracJDmgcxI6fcPxwKGuwGvRF+tcz6qlXWAOKTTYqeWLp2oP
	 ZWgi1O7sVSD4JpNFQ01IUm3dAusTEA7l9EJPhz5moL4RM/gqnD/0ivR1QYbnfQ2V9r
	 GPO/fdh5LA/2w==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 7/8] selftests/bpf: add multi-stream sequentiality
 example model
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tao Cui" <cui.tao@linux.dev>
Cc: bpf@vger.kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, tj@kernel.org
In-Reply-To: <20260908100143.47598-8-cui.tao@linux.dev>
References: <20260908100143.47598-1-cui.tao@linux.dev>
 <20260908100143.47598-8-cui.tao@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 10:21:00 +0000
Message-Id: <20260908102101.517B91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment does not follow the required BPF subsystem comme=
nt style, starting on the same line as the opening '/*'.
--

commit d8df4bd81fa04615013e2f2662dbdb807cb8794c
Author: Tao Cui <cuitao@kylinos.cn>

selftests/bpf: add multi-stream sequentiality example model

This commit adds a second example cost model which replaces the single-curs=
or
sequentiality heuristic with a per-cgroup table of stream slots keyed by
iocg_id. This improves pricing accuracy for interleaved sequential readers
and windowed random IO.

> diff --git a/tools/testing/selftests/bpf/progs/iocost_ms.c b/tools/testin=
g/selftests/bpf/progs/iocost_ms.c
> new file mode 100644
> index 0000000000000..465fd5d5c62e0
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/progs/iocost_ms.c
[ ... ]
> +/* VTIME_PER_SEC comes from vmlinux.h (a BTF enum constant) */
> +#define IOC_PAGE_SIZE		4096
> +#define IOCOST_COST_F_MERGE	(1ULL << 0)	/* not in BTF: a plain macro */
> +
> +/* DIV64_U64_ROUND_UP / DIV_ROUND_UP_ULL equivalents, folded at
> + * compile time */

[Severity: Low]
This isn't a bug, but does this multi-line comment follow the preferred
kernel comment style for the BPF subsystem? The BPF guidelines specify that
multi-line comments must have the opening /* on its own line, rather than
starting the text on the same line as the opening marker.

> +#define RU(x, y)		((x) / (y) + (((x) % (y)) ? 1 : 0))
> +
> +#define RBPS	174019176ULL

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908100143.4759=
8-1-cui.tao@linux.dev?part=3D7
