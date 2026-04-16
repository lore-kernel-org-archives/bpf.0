Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5E5396B8C
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776333745; cv=none; b=PQGknD4GSUw2A9SjjF/WQCZYVDYDw8A2ipUEpB55hedxhJo7EQ4Fnac9VoPx+8CIgfWDa67ykIOteIZQ/bS5EasWHAUhpb669zdbsS01PixXq+Z57EIaf98oWSj4ysoaGww1v3tD+pdEs5n2dMBM9nb6DpD5x8Zv0WYvh7v7q2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776333745; c=relaxed/simple;
	bh=X7VDJFE6zclFCsPyU2T0Hv4iOXLWFXzlwNCw0e4GO+k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=iHQnB/o+L/AIMeB75qmGzlf9xWmkSUluBby8deS/EWDCE87W3JX3VzwIQW2QY3by5qGST/kT4mH7Vg4TNJ6BrnqYw3r5wKbp4VgMZbX0wqb5KXUoWmRRxvXw9IykAes8+cOWKwFeg39kVWsztnOglLuM//2zSRIeQU1NkNri9jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U4zOytg1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U4zOytg1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 178D6C2BCAF;
	Thu, 16 Apr 2026 10:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776333745;
	bh=X7VDJFE6zclFCsPyU2T0Hv4iOXLWFXzlwNCw0e4GO+k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=U4zOytg1QSJNr/1BqvtLUEcmRdPG3Jz9+K+6iXAxXiC+gSpipqWUzt3baIT/mNY/x
	 Y0vcIhBAg9WzOGroY+Qj1itNo30Fu4QkdAwkuLGJ7E2uHJ3C3sSc6goDExsb1B7SWG
	 T4ooiZmjvlviSg1Gu7deSEFcshWLivJrtT+P9bwLByTup/+DfS+XvPVDGLZ3znjcRi
	 madpR5ztMoEkgGBkTvE/8Nkbla7IjHX+PH/EwvmfNd/ACQ4uw75s3amciu+9/ix4rg
	 BRYarMqUslTTaHc5VbBlLCiy7FiKW61wIVQLAQmxCy+ajShOJcBMCs5nWXjOdE8aoH
	 LywMJKmBy4cfw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 1/6] bpf: name the enum for
 BPF_FUNC_skb_adjust_room flags
Reply-To: sashiko@lists.linux.dev
To: "Nick Hudson" <nhudson@akamai.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260416075514.927101-2-nhudson@akamai.com>
References: <20260416075514.927101-2-nhudson@akamai.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Apr 2026 10:02:23 +0000
Message-Id: <20260416100225.178D6C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Sashiko AI review found 1 potential issue(s):
- [Medium] The newly named `enum bpf_adj_room_flags` will not be emitted in=
to the kernel's BTF, rendering the intended CO-RE lookups non-functional.
--

commit d9be60117de7ebbae2642c8a29e31a5aa11ff502
Author: Nick Hudson <nhudson@akamai.com>

bpf: name the enum for BPF_FUNC_skb_adjust_room flags

This commit names the previously anonymous enum for BPF_FUNC_skb_adjust_room
flags to bpf_adj_room_flags. The stated goal is to enable CO-RE lookups in
BPF programs.

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index c8d400b7680a8..bc4b25eb72ce5 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -6209,7 +6209,7 @@ enum {
>  };
> =20
>  /* BPF_FUNC_skb_adjust_room flags. */
> -enum {
> +enum bpf_adj_room_flags {

Since this enum is only declared in the UAPI header and never actually used=
 as
a variable, parameter, or struct field type in the kernel C code, will the
compiler generate DWARF debug information for it?

If it is omitted from the DWARF info, pahole will not emit it into the
vmlinux BTF. This causes libbpf CO-RE checks for these values to silently
evaluate to false regardless of the kernel version, which seems to defeat t=
he
purpose of this patch.

Does the kernel need to explicitly force the emission of this type into the
target BTF, for example by using BTF_TYPE_EMIT(enum bpf_adj_room_flags) in a
compiled C file?

>  	BPF_F_ADJ_ROOM_FIXED_GSO	=3D (1ULL << 0),
>  	BPF_F_ADJ_ROOM_ENCAP_L3_IPV4	=3D (1ULL << 1),
>  	BPF_F_ADJ_ROOM_ENCAP_L3_IPV6	=3D (1ULL << 2),

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260416075514.9271=
01-1-nhudson@akamai.com?part=3D1
