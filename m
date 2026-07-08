Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF53439346
	for <bpf@vger.kernel.org>; Wed,  8 Jul 2026 20:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783543536; cv=none; b=FrTci6xDT3/g5yNtQy/82iFD3Kq7Rks8OCnzBTedAR92Bitl4TJKGzPsvrKZlD2lz3l0C0UiWSeDObAOoOpmxJrAknoZ5BG9rB3QmO47vHTW44bVYWuOlwScwFnvRsCwM+4fcZmfEi8kVnkp1H1lYpd5Lt7G1OR9nwHTvUBSCW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783543536; c=relaxed/simple;
	bh=qmf+5d8VvcXIbV/CLboFAl5DOBHD8TZYzt/ovlYj18Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GuqWFJYlweBcfaP1C4zcJQ+EuEpQTnkQxmaF16n0ULdyrU4imd/wJMlwYtT1wVWl5OthH3Tds9RPXiEqLZNYodEyJtujWGKJ4mAEpd8mwcw9JIFUpE+IpQnXgC8OTm+ZpU0SHPFy6c9LJ6ZdAlA9ywChGEKb8xSEl9bRWWl/i00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFdm4EJr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFdm4EJr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C85F1F000E9;
	Wed,  8 Jul 2026 20:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783543535;
	bh=jiytFXpfCWHu5tDae87S0ODplipF+af5a82bzCeFN9s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dFdm4EJrPajO4nm98qLQE1Dl8Q/DPBP/aPiVxSz0ESGZH/7IYjJmafoWEqMlKn4tt
	 MhlpHfy51IoXPejXO8frjdgTkBv9p3wApEKUgF6B9ye6X4SIYyQfsfrWL0PyoxNm3C
	 R7OBIuxs41bs74durOrIE1zdjSPU90C2Weq+N3w2JqoDuLo1k31CD+Q3v6QiGrrP7/
	 IB5LKjZPZ8djwD4zXI+X7v8fnRvzF6pPOBv30vpcFAP006byW0neRdgVZpBgRC/9zH
	 8QPSDY11YNrbK4amCnAnPso0aKRMr8aZCA3MTZECRJ7WzTHl1Ip0yK6dB4VxVj57UR
	 smBXSf7N5b8SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v4 5/6] selftests/bpf: Add
 bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat prog
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vladimir Vdovin" <deliran@verdict.gg>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260708203410.45121-6-deliran@verdict.gg>
References: <20260708203410.45121-1-deliran@verdict.gg>
 <20260708203410.45121-6-deliran@verdict.gg>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 20:45:34 +0000
Message-Id: <20260708204535.0C85F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Addition of fields to `struct xdp_meta` changes its size from 32=
 bytes to 44 bytes, causing an alignment-induced offset mismatch between 64=
-bit BPF programs and 32-bit userspace architectures.
--

--- Patch [5]: [PATCH bpf-next v4 5/6] selftests/bpf: Add bpf_xdp_metadata_=
rx_checksum support to xdp_hw_metadat prog ---
commit 1839c76747e10e7e5dc96d9eb03c1675cdf0e646
Author: Lorenzo Bianconi <lorenzo@kernel.org>

selftests/bpf: Add bpf_xdp_metadata_rx_checksum support to xdp_hw_metadat p=
rog

This patch introduces the capability to dump the HW rx checksum in the
xdp_hw_metadata program. It achieves this by using the new
bpf_xdp_metadata_rx_checksum() kfunc.

> diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/s=
elftests/bpf/xdp_metadata.h
> index bca09b94af261..f864d4a8bd8c6 100644
> --- a/tools/testing/selftests/bpf/xdp_metadata.h
> +++ b/tools/testing/selftests/bpf/xdp_metadata.h
[ ... ]
> @@ -52,10 +53,13 @@ struct xdp_meta {
>  		};
>  		__s32 rx_vlan_tag_err;
>  	};
> -	struct {
> -		__u32 ip_summed;
> -		__u32 cksum;
> -		__u8 cksum_level;
> +	union {
> +		struct {
> +			__u32 ip_summed;
> +			__u32 cksum;
> +			__u8 cksum_level;
> +		};
> +		__s32 rx_cksum_err;
>  	};
>  	enum xdp_meta_field hint_valid;
>  };

[Severity: Medium]
Does this change create an alignment mismatch between the 64-bit BPF program
and 32-bit userspace architectures?

The addition of these fields changes the size of struct xdp_meta to 44 byte=
s.
On a 32-bit x86 system, the __u64 fields earlier in the struct require only
4-byte alignment, keeping the userspace struct size at exactly 44 bytes.
However, the BPF program runs in a 64-bit context where __u64 requires 8-by=
te
alignment, causing the compiler to pad the struct to 48 bytes.

When verify_xdp_metadata() is called in userspace:

    meta =3D data - sizeof(*meta);

Userspace will subtract 44 bytes from the packet data pointer, while the
BPF program actually placed it at data - 48. Could this shift all metadata
reads by 4 bytes on 32-bit platforms, leading to incorrect results and
metadata corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708203410.4512=
1-1-deliran@verdict.gg?part=3D5
