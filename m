Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459933F58C
	for <bpf@vger.kernel.org>; Fri, 19 Jun 2026 20:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781899642; cv=none; b=UcZ6Pv+aidmtertYlvlXNtgtdf77D8XV2HbOeXoqVCUou1OiuyJdp2wX5tR52UUT5aoZ3zxx9vcQFe+4XxLW3UkP2GO/lZ1Hnuqds69TeVPZnK6J5B+qL/xa1dU10HMq8QquFPUhlSKqLRsLK3bTDffMcYC5vKWypW0Bkur/Mg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781899642; c=relaxed/simple;
	bh=M7bo/MeYtDVHXWxGqs+aqqWl2r5fAtIWu/YTcu2ruXk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qIStRl7XdiK/tvFsWIHxTQA1zD/NiWHisUlrpTss1IwanZXyR4qz+1ECAdNpaFm0V051mqAujdeYgfRUDqXYLV0trUdukfYuLKYXMhMYxIXlbSd4JxwCb7V7otBatHTB52MiS2hHQYH1vCzQkLLF6/h4Y5eNzlBmbmvuT87qW+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqhWuG1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqhWuG1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07AD51F000E9;
	Fri, 19 Jun 2026 20:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781899641;
	bh=4Y1Lh134q/e7DGq8OxcIe3D+ur3Dl/tCpB7kUCwdVBc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dqhWuG1ukRKmDG8JLAKOTPZGmOhZxAdKkYrUlE4KC3++ofVbN8nDrJg3Yac44cyw7
	 aj/3BdQyj5lFaK84H/RJQFUCXoGHtn0WzEgIs7ITPl9XrSYQ2yqLzKGrA4vQ0ilAP7
	 WyMMF9ohz9OMw7Jz0Wkn546GeoK3DlU0U6hFIM2D+0gPzG4LCP+JnT0YoWk13EWSE3
	 VuRwhn6IWB9cJ/MPzYgOYcNNX4vcij36peMzQjUqB8lYqK2aKZ8Y844AHCylPskK+e
	 077kQO1aE+SpWlt3+hsXS0xoATqOGId95gREly8BEDnOvNTRM7ZJGr5d5WADkVMhuX
	 56DbeQi3J9qtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] selftests/bpf: validate rx_queue_index in
 xdp_metadata
Reply-To: sashiko-reviews@lists.linux.dev
To: Siddharth_Cibi <siddharthcibi@icloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260619195759.41254-3-siddharthcibi@icloud.com>
References: <20260619195759.41254-1-siddharthcibi@icloud.com>
 <20260619195759.41254-3-siddharthcibi@icloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Jun 2026 20:07:20 +0000
Message-Id: <20260619200721.07AD51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] ABI / Struct Layout Mismatch on 32-bit platforms
- [Medium] Uninitialized Memory Leak in `xdp_hw_metadata` BPF Program
--

commit 601fd9ffcc49bcd779869ed0a9069b48be1a4a14
Author: Siddharth_Cibi <siddharthcibi@icloud.com>

selftests/bpf: validate rx_queue_index in xdp_metadata

This commit extends the xdp_metadata selftest to validate that
rx_queue_index is preserved after an XDP redirect. It captures the
queue index in the metadata and asserts it matches the expected queue ID.

> diff --git a/tools/testing/selftests/bpf/xdp_metadata.h b/tools/testing/s=
elftests/bpf/xdp_metadata.h
> index 87318ad1117a1..1f0ae4c00091b 100644
> --- a/tools/testing/selftests/bpf/xdp_metadata.h
> +++ b/tools/testing/selftests/bpf/xdp_metadata.h
> @@ -49,4 +49,5 @@ struct xdp_meta {
>  		__s32 rx_vlan_tag_err;
>  	};
>  	enum xdp_meta_field hint_valid;
> +	__u32 rx_queue_index;
>  };

[Severity: High]
Will adding this 4-byte field without explicit padding cause an ABI layout
mismatch between 64-bit BPF programs and 32-bit user-space test environment=
s?

On 64-bit architectures, the __u64 members force the struct alignment to
8 bytes, causing the compiler to implicitly pad the struct size to 40 bytes.
However, on 32-bit architectures like i386, __u64 only requires 4-byte
alignment, meaning the struct size remains exactly 36 bytes.

When verify_xsk_metadata() calculates the user-space pointer:

    meta =3D data - sizeof(struct xdp_meta);

Could this subtract 36 bytes instead of the 40 bytes reserved by the BPF
program on 32-bit platforms, shifting all metadata fields and causing the
user-space program to read corrupted values?

[Severity: Medium]
Does increasing the size of this struct expose uninitialized memory in
the xdp_hw_metadata BPF program?

Because struct xdp_meta is shared, xdp_hw_metadata.c now allocates more
headroom via bpf_xdp_adjust_meta().

Since xdp_hw_metadata.c wasn't updated to initialize rx_queue_index or
the new implicit padding, does this leave uninitialized packet headroom
memory exposed to user space via the AF_XDP socket?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260619195759.4125=
4-1-siddharthcibi@icloud.com?part=3D2
