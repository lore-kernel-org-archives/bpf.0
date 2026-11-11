Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794385309;
	b=Pjkf1QLn8N72YHn17WknaAXguccqUf7DCMe6qFjaIdBmVLsXBCJ4zTteoDMys1JktBWo
	 s/W1WFMiHhqZD2Lq9app2/M51eZEfRhEWolRcz52JxUHUlhc/nLRz05M9qztLuDzBxckY
	 YivmBLSUYAoKgYubQLR6aGOMrndRfqW9JK/Dd6Q75+50isEwthnfh0xayET+FVaeikj5s
	 Bp5WRN5NrnpsptJVEKWxiMzXxdeMPNTSYsohZ+h5u+/jKVh+uNrSjc7g5L1WwaOzjMZ8S
	 6ce2BsD4GXl3Y+F1eTkDBW6FfbLD3M2id4tVkCUWB2ZUh/quCFjjfO+QXJcnT5MhjUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794385309;
	h=Received:DKIM-Signature:Content-Type:MIME-Version:Message-Id:
	 In-Reply-To:References:Subject:From:To:Cc:Date;
	bh=WKLx6/kLUidwXklCrRd8FA/ciDdDJmeHxNFf/YEFKMA=;
	b=GXUnM56Q411EEpKeTtKHZMzYSj24+dIf5oRoEH8hgOpik+GLek3LxhLVkBHmrX5nfaXn
	 l4rAvd3gDp6ZGEKO0JZUK8satDZaOH0abOGSfBStZNKK/sLE67W9L8E+nKb2lPsMNLuGl
	 VsbxHUeP1p7MXjO3a+dIxrGzzrDYZkGSh1/h+ttOkRvaHRNCAKxzRQ3VkIMaDkRFIUT7D
	 wjZmcO15tHwwBmzVjITIoV22tiWfl3fHBQtCRAGqNYU/koRSl8bExx+nXRbKpbDYQ4N37
	 biD2RBDmuuWZxp0Lz381gDSWnUKd4UzB+6ohv6jrdrQKEJEB7qcMLaoGfn8WQVX6dsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6Usp9U+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77130606A335;
	Wed, 11 Nov 2026 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n6Usp9U+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBFD51F00A05;
	Wed, 11 Nov 2026 08:21:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794385309;
	bh=WKLx6/kLUidwXklCrRd8FA/ciDdDJmeHxNFf/YEFKMA=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=n6Usp9U+VH15/sawXeAN8D8Gh//hV7+wE/xaEpPFNIPL/7FlgyR4rThDqsn3T/gFe
	 v24IVfMMcW2rXSq2SzGt1FGTWegzY5vlJr5cIu50FXsFppa9ILj7H2ginSdfsJmuop
	 bNm0XN92oiBdwZGCiJA6x9MQ0NV9efns3yDRsbZt6hsSW48LSWhUYw4Me/KEO7BCny
	 p1RLtbhZv+L74/KdT0borm/CitRAtPz5o17fl4mKuMO+q9ryPn4GVVo+mBds90KK/Z
	 E9imDj4QyCMPdDnPitcjq+cKZflhPKXtyX3VGJz8KqXW6Szumm1IMp+f/jZT74DZO8
	 V+20abA+EouEQ==
Content-Type: multipart/mixed; boundary="===============0859370046887065683=="
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-Id: <36f85a8b94e7329f1afbb7d5eef1eb2e4dd197b1fe5e46e1cb2f7ce7fb8b4912@mail.kernel.org>
In-Reply-To: <20261110164046.454431-9-a.s.protopopov@gmail.com>
References: <20261110164046.454431-9-a.s.protopopov@gmail.com>
Subject: Re: [PATCH v3 bpf-next 08/18] bpf: Add the bpf_scan_ir LLVM plugin
From: bot+bpf-ci@kernel.org
To: a.s.protopopov@gmail.com,ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,almagui@kernel.org,john.fastabend@gmail.com,qmo@kernel.org,brauner@kernel.org,kpsingh@kernel.org,yonghong.song@linux.dev,jolsa@kernel.org,emil@etsalapatis.com,ihor.solodrai@linux.dev,sashal@kernel.org,bpf@vger.kernel.org,linux-kernel@vger.kernel.org
Cc: a.s.protopopov@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 11 Nov 2026 08:21:47 +0000 (UTC)

--===============0859370046887065683==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> bpf: Add the bpf_scan_ir LLVM plugin

TL;DR: Nit only: with the plugin enabled, link-vmlinux.sh adds --emit-relocs
to the .tmp_vmlinux1 link, so two existing comments (top-level Makefile,
vmlinux_link()) now say the opposite; they should be updated.

> diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
> index d5710e900bd4..f39e2d1f1400 100755
> --- a/scripts/link-vmlinux.sh
> +++ b/scripts/link-vmlinux.sh

[ ... ]

> @@ -89,6 +89,13 @@ vmlinux_link()
>  		ldlibs=
>  	fi
>  
> +	if is_enabled CONFIG_CLANG_PLUGIN_BPF_SCAN_IR; then
> +		if [ "${output}" = ".tmp_vmlinux1" ]; then
> +			ldflags="${ldflags} ${wl}--emit-relocs"

This isn't a bug, but two existing comments now say the opposite of what
happens here.

The top-level Makefile says:

    # --emit-relocs is added by scripts/link-vmlinux.sh, for the final link only.

and a few lines below this block, vmlinux_link() says:

    # Only the final link actually requires the relocations.

With the plugin enabled, the .tmp_vmlinux1 link also gets --emit-relocs, and
on arm64 it gets it without --discard-none.

Could both comments be updated to mention the .tmp_vmlinux1 case?

> +		else
> +			ldflags="${ldflags} ${wl}--script=${srctree}/scripts/bpf/fmodret.lds"
> +		fi
> +	fi
>  	ldflags="${ldflags} ${wl}--script=${objtree}/${KBUILD_LDS}"
>  


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/42981885558
--===============0859370046887065683==--
