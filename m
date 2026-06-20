Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4391F09A8
	for <bpf@vger.kernel.org>; Sat, 20 Jun 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781959012; cv=none; b=WVmjyuaSPR7faWOOUWvxFrrKOYCDYk3IurM1Yoi64k6RICZoWVWDTyHDg40axjQVMEe+UhDsqKANaTJ1+8ZMBl6gvnd3IUxxTiODXFez+I7GuaaHwp2LUhjnLkzmlINJ+oIlq/ZrLPE9STuljVidULZJVWmJRqPR7KJ1gX2j6qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781959012; c=relaxed/simple;
	bh=HSlyYi2Ice+jZZeXUz527v8KmNgufwfuaNDE3D+uvGY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R4oTY8gatCCqDH395vc1ScOfTqRMMddC9OP1BRCBECJ/7jlHQazi4CKFby0cGU3A+CRjvR25csr/MkyAcO9Quojh4/t6MadSf5pwPUpeZFYskg8/Rt4Y8OBpJNNd/h6Yh/s1j4akX7WNdwqpJX7XwPmx7OmQI8PKavaXYCEZB9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HJVT/sBu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HJVT/sBu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20DA1F000E9;
	Sat, 20 Jun 2026 12:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781959010;
	bh=HCm7zkOCRCQJcciA+JeGtlDivRciQmzX7Ux9dLHaYRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HJVT/sBuvSaQcASiR7db/d+suEf9swE/fpVhTnjMowV9QACNoJfNOUhHAUzLCtg/+
	 Sq0e6wXCw5J2D+xCLfMwdk2AHHaS5T6x92UoLguiq1tH/eXnwZ8zmVbCXpRJWVPVB7
	 Vu7ATM6arFa8Qdv92Y0ifdW3ZqkFUQJwE0pUTfOsKyTpkM+ZwDynzwEaG+mZh3mkz+
	 aVKO6kJqEoljwY5S1Nzn1IOXPabKNHjXlorABH4Xeq7NrwToEaTew6rUp9AWmDXvFE
	 1rsFrknlxo1LiDbSUsuk5xHZrp10KsSoNxQ38ZiuT93iM6ZptOrQ0AWLO5u/64c5Ax
	 +/DN2F2Y1QBXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/bpf: validate rx_queue_index in
 xdp_metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: "Siddharth C" <siddharthcibi@icloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260620121321.45227-3-siddharthcibi@icloud.com>
References: <20260620121321.45227-1-siddharthcibi@icloud.com>
 <20260620121321.45227-3-siddharthcibi@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 20 Jun 2026 12:36:50 +0000
Message-Id: <20260620123650.B20DA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Adding `rx_queue_index` changes `struct xdp_meta` size to 36 byt=
es, causing implicit padding to 40 bytes on 64-bit systems but not on 32-bi=
t systems. This creates a BPF-to-userspace metadata offset mismatch on 32-b=
it hosts.
- [Low] The newly added assertion returns directly with incorrect space-bas=
ed indentation.
--

commit 5d50c9ea90d4f7a83d1f9562df723456d7ed8e43
Author: Siddharth_Cibi <siddharthcibi@icloud.com>

selftests/bpf: validate rx_queue_index in xdp_metadata

This commit extends the xdp_metadata selftest to capture and validate
the rx_queue_index field. It adds the index to the xdp_meta structure and
asserts its value matches the expected queue during packet verification.

> diff --git a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c b/tool=
s/testing/selftests/bpf/prog_tests/xdp_metadata.c
> --- a/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> +++ b/tools/testing/selftests/bpf/prog_tests/xdp_metadata.c
> @@ -309,7 +309,8 @@ static int verify_xsk_metadata(struct xsk *xsk, bool =
sent_from_af_xdp)
> =20
>  	if (!ASSERT_NEQ(meta->rx_hash, 0, "rx_hash"))
>  		return -1;
> -
> +	if (!ASSERT_EQ(meta->rx_queue_index, QUEUE_ID, "rx_queue_index"))
> +        	return -1;

[Severity: Low]
This isn't a bug, but does this return statement use spaces for indentation
instead of tabs?

[ ... ]

> diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/s=
elftests/bpf/xdp_metadata.h
> --- a/tools/testing/selftests/bpf/xdp_metadata.h
> +++ b/tools/testing/selftests/bpf/xdp_metadata.h
> @@ -49,4 +49,5 @@ struct xdp_meta {
>  		__s32 rx_vlan_tag_err;
>  	};
>  	enum xdp_meta_field hint_valid;
> +	__u32 rx_queue_index;
>  };

[Severity: Medium]
Does adding rx_queue_index cause a structure size mismatch between the BPF
target and 32-bit hosts?

The xdp_meta struct contains __u64 fields, so on the BPF target and 64-bit
hosts, the 36-byte structure will be padded to 40 bytes to maintain 8-byte
alignment. In the BPF program, bpf_xdp_adjust_meta() will then allocate 40
bytes.

However, on 32-bit hosts where __u64 only requires 4-byte alignment, the
compiler will evaluate the structure size as 36 bytes. The userspace test
then reads the metadata pointer exactly 4 bytes after the start of the
BPF-populated metadata, leading to misaligned reads for all fields.

Should an explicit 4-byte padding field be added at the end of the struct,
or an explicit alignment attribute be used?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260620121321.4522=
7-1-siddharthcibi@icloud.com?part=3D2
