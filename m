Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9643F33372A
	for <bpf@vger.kernel.org>; Sun, 13 Sep 2026 15:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789311732; cv=none; b=nsGtFph8bEIKcWRXP9rvb06BEH2gL1pi0L2OZ1ux94tnttdJKsUR/WxkpADLZvGOb70fgqKnsKYQ+tTzaseZLkGvrcw1ldcHO9fs/oGgx3/aQMC4D2hcoREeLlr9c3GvORcsrGkU0jEJg8xeU37yBkjTlHqpZm3p7OjarUx9pf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789311732; c=relaxed/simple;
	bh=kLdHNSrnGcQ/45Qg3HIp49+GvJACCY03hoKGKkJLz3o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SPVNSaTkdrLy++daPOgb3T1peHO2CGn7yFmLC7BeQv74rq4NNCgPr1RI6oitIlYt3Ht3SwfdXpiQn5u53gOhFsil9AA+zlrWtCnLUhbG2YxawWXkMgk2vDLw6Tn3Y58WoQw0oBhYEX1HN4VdPsLru4FOOXUM9mibXs2XbsRwfj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cRM4cua+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cRM4cua+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF02B1F000FF;
	Sun, 13 Sep 2026 15:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789311731;
	bh=nczS7rZ9FCWe5TZU5pFqsgCjUQUDASrRi+r8Dl1P8pY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cRM4cua+1mHNqYMflikq4JdMWHg2Kmu4yg5FV+Dpo7Q76uaBYmoMU//F9f2lJxMHh
	 KozxX3u4TxKumDsbdlN6rrhdPDQWEdsATi8GpbwIXkoKmdQyQ56ME02UVJ64kP4LVR
	 OoCnYvbIJmzhPWYZfGYK1HQVe3Ws+h6ZtwHX9MbcP0yoPVA6+2gNnw4zhVeFWAiBCo
	 YVQ4OcfDFPzAQ2S1nrZvipajQP9//lESV7QhtUpIH2aPh6j/4ySya9pooWk1nuBGXo
	 v0jqLkUxN1SxfXhpiD144ivCS4e57/fQ/ULrBVVA76pvmML1niltLAsuEYUH/+/w4p
	 iN1aGt/pEipxw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf v2 2/3] bpftool: Keep struct_ops field offsets when
 skipping bitfields
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mingpei CAO" <caomingpei@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260913145233.1446643-3-caomingpei@gmail.com>
References: <20260913145233.1446643-1-caomingpei@gmail.com>
 <20260913145233.1446643-3-caomingpei@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 15:02:10 +0000
Message-Id: <20260913150210.EF02B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Multi-line comment does not follow the preferred BPF subsystem comm=
ent style.
--

commit 76b7f5ec797f551d88f419af56f14122daae2704
Author: Mingpei CAO <caomingpei@gmail.com>

bpftool: Keep struct_ops field offsets when skipping bitfields

This commit modifies the struct_ops skeleton generator to correctly handle
bitfields by representing unsupported bitfield storage as padding. This
prevents excessive padding generation and keeps supported fields at their
declared BTF offsets.

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
[ ... ]
> @@ -1108,34 +1125,64 @@ static int walk_st_ops_shadow_vars(struct btf *bt=
f, const char *ident,
[ ... ]
> +		case ST_OPS_SHADOW_OPAQUE:
> +			/* Avoid emitting named types that might conflict with
> +			 * definitions from other skeletons.
> +			 */

[Severity: Low]
This isn't a bug, but does this multi-line comment in
walk_st_ops_shadow_vars() adhere to the BPF subsystem guidelines? The
preferred style for multi-line comments under BPF-related paths requires
the opening /* to be on its own line, rather than on the same line as the
first line of text.

>  			printf("\t\t\tchar __unsupported_%d[%d];\n", i, size);
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913145233.1446=
643-1-caomingpei@gmail.com?part=3D2
