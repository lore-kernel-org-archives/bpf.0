Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CA26582B81
	for <bpf@vger.kernel.org>; Thu, 10 Sep 2026 18:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789065624; cv=none; b=XD5/UOMcGPss7P4pAeICQpV/XV9sa9EZomluiopXaqFmQo45BLIAvRTk6kQ1GriYt+WbDzZZNFWzpZh7phKQLSiAEhyEKY9Jpp8JdANd3QgYWUhLhR54JuC+SfTRRwtSS8M2ziwaXuLxacBRjib7PWno0wrMiV6S+o1azepRWkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789065624; c=relaxed/simple;
	bh=58YgaIG4pBlR8EtjPNlkKmt9sNdlKg7gmxrUbam2YJc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GxWMw7eZY4FkfXVbHAvwXMMrsv1CQHxcWyKILzbTaejeHBfJ1z/391JJH+7jFdWX+/nV0zTFVmEfXq6QtQzQO389J9blriX+CKASvMcJpVPxL4LMg1aKJCkUcdXpNw9FU+n8+Sh0ryoE97ynFFHTq+esPv41LQJELZlc0xsSCjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wpa3pyQa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wpa3pyQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545FD1F00893;
	Thu, 10 Sep 2026 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789065618;
	bh=H1on85zaCOIuHcjYYVyMsYJKuCgXa3FAPwrT2dway5E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Wpa3pyQa+87yshTJrXNRVbavzqxrxnUvMfUjSqYI/UIA43KLg48q4evjKRIhE99uZ
	 WDq9GTgEqUHywbkVgiIv9/XFvHH52F/3sFsKS/1gn1kPtXbqVibQ8dL+SMLAvc53KW
	 i5VjyuI5QNYEyNXCdwL4ql/CJcwqDVB0HM2B/kivJ40b1f9Y6wtfjMQWMHr393ALGg
	 j+RT420US5G4ICicQpdskGDbjaw5AOfA7n0F7OllGR3eNYROJV/GmjS6nKk3+nXX1g
	 b7JJLIO7lAAwG3rAQQi2FEsbTV6ps36L27fgMTVfmA1M7UlZbcvCvKzag7K8hUNlST
	 RdgKE8mxDPFGg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v2 1/4] libbpf: Add bpf_program__add_flags()
 and bpf_program__clear_flags()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260910183222.307208-1-toke@redhat.com>
References: <20260910183222.307208-1-toke@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 18:40:17 +0000
Message-Id: <20260910184018.545FD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The newly introduced multi-line comment in `libbpf.h` does not foll=
ow the required BPF subsystem comment style.
--

commit 70c14f22413bc6ac7381ed8252533a749bda07d7
Author: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>

libbpf: Add bpf_program__add_flags() and bpf_program__clear_flags()

This commit introduces two convenience helpers, bpf_program__add_flags() and
bpf_program__clear_flags(), which wrap bpf_program__set_flags(). They allow
modifying BPF program flags without overwriting existing ones.

[ ... ]

> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index b965ad5715403..3932bf9cb4903 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1011,6 +1011,12 @@ bpf_program__set_expected_attach_type(struct bpf_p=
rogram *prog,
>  LIBBPF_API __u32 bpf_program__flags(const struct bpf_program *prog);
>  LIBBPF_API int bpf_program__set_flags(struct bpf_program *prog, __u32 fl=
ags);
> =20
> +/* Convenience helpers to non-destructively add or clear the specified f=
lags
> + * instead of clobbering them as bpf_program__set_flags() does.
> + */

[Severity: Low]
This isn't a bug, but does this multi-line comment format violate the BPF
subsystem coding style?

The BPF guidelines explicitly require multi-line comments to have the openi=
ng
/* on its own line, rather than having text on the same line as the opening.

> +LIBBPF_API int bpf_program__add_flags(struct bpf_program *prog, __u32 fl=
ags);
> +LIBBPF_API int bpf_program__clear_flags(struct bpf_program *prog, __u32 =
flags);

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910183222.3072=
08-1-toke@redhat.com?part=3D1
