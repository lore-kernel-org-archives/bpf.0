Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A364ABBAA
	for <bpf@vger.kernel.org>; Wed, 30 Sep 2026 20:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790799730; cv=none; b=lZ+jI9hwrunKgbBDqyNRERaheC+NhUpPCovmgKhDN65zjazW90DY3pqbOSnSl4bBdnvbmLUnXZs+P08fn8+6y8c9k3onOD53uIToJjdnV8k38AD1m0nsGFtfUAKPlObENWz+qb2FvletD3+6UtVbHUclBgtP8ZV1d2vd4G0i+mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790799730; c=relaxed/simple;
	bh=AXqcbKk1NPoAkENL7DK8FDOn2PeJgfLN4Xok4EdtGYA=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=MbaGiH3DXy/JkF3eKW3BnpT+xLn3Zaw6H8/S3qtZlYheV51Xk5ro2uBXlX6uIfhKngftpsBNh6EpnbPSnEkQFmD1SMXSCgyIdAVqK73MQD92TkwhYzS+rlCt9M3AmEeJITuVaBURG2AKykQl4wKdPsKArAG1J5fIeqxM/ilTovU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czYG7kws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czYG7kws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291CE1F000FF;
	Wed, 30 Sep 2026 20:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790799728;
	bh=kAs8PYx6CIFN4pc5sT0bh8Gzm22x8MaApBj/wKFhSMw=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=czYG7kwsmdcTfg6XdmB8HeoQyssjuyt0E9wU/kbVvQkRfnWxT6eaoKeKLGS8I8J5c
	 8/y3ID4UlBPj1wrXvRqiOpGt5ZgRaN2T9ng7cfNT8zY4/7r//n1UBjigGfse8Ehlor
	 IubWz+3NyhehYnM/FmTjFtnVWsmdzi4JBaDCTP9PkjLn/ZM6bS2fx19rbzxS85pADW
	 nwpIrlUjmEW+WDXyfxu1Nwnp82u7NX4Uf4mijrznixwIug1wurdw0IGJygmY/posUJ
	 FGY9M19yuOJtUPGuGP4S2aqnmR7uRd9a/NX7cZVaR2byvLRcEiK8AKgR67dixGDG6q
	 E54QA848c1amg==
Content-Type: multipart/mixed; boundary="===============8418910095456652781=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <6ae994600b1317efbf6f647ce3f8e135198ea0ae3a399a0f48564f22669ac480@mail.kernel.org>
In-Reply-To: <20260930193127.2181684-13-alexei.starovoitov@gmail.com>
References: <20260930193127.2181684-13-alexei.starovoitov@gmail.com>
Subject: Re: [PATCH bpf-next 12/14] libbpf: Keep format strings of bpf_printk() in .rodata.str
From: bot+bpf-ci@kernel.org
To: alexei.starovoitov@gmail.com,bpf@vger.kernel.org
Cc: daniel@iogearbox.net,andrii@kernel.org,eddyz87@gmail.com,memxor@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Wed, 30 Sep 2026 20:22:08 +0000 (UTC)

--===============8418910095456652781==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> libbpf: Keep format strings of bpf_printk() in .rodata.str

TL;DR: Commit message only: it may be inaccurate for objects built with
BPF_NO_GLOBAL_DATA, where bpf_printk() keeps its format on the stack and adds
no .rodata.str map. Not a bug.

>     libbpf: Keep format strings of bpf_printk() in .rodata.str
>
>     bpf_printk(), BPF_SNPRINTF(), BPF_SEQ_PRINTF() and bpf_stream_printk()
>     copy the format into a static const array, which the compiler puts into
>     .rodata. When global data of the object is in arena .rodata is there
>     too and the helper doesn't take the format:
>
>       R1 type=scalar expected=fp, pkt, pkt_meta, map_key, map_value, mem,
>       ringbuf_mem, buf, trusted_ptr_, ctx
>
>     String literals are in .rodata.str1.1, which libbpf keeps in a read-only
>     map. No compiler flag moves a named array there. Put the arrays into
>     .rodata.str with a section attribute.
>
>     An object that uses the macros gets one more map, .rodata.str.
>
>     Signed-off-by: Alexei Starovoitov <ast@kernel.org>

This isn't a bug, but is the changelog accurate for objects built with
BPF_NO_GLOBAL_DATA?

The commit message says that bpf_printk() copies the format into a static
const array, and that "An object that uses the macros gets one more map,
.rodata.str."  With BPF_NO_GLOBAL_DATA defined, the patch leaves
BPF_PRINTK_FMT_MOD empty:

    #ifdef BPF_NO_GLOBAL_DATA
    #define BPF_PRINTK_FMT_MOD
    #else
    #define BPF_PRINTK_FMT_MOD static const ___bpf_fmt_sec
    #endif

so in that configuration the format in bpf_printk() is an on-stack array.  It
is not placed in .rodata.str and no extra map is created.  This looks
intentional, since tools/testing/selftests/bpf/progs/test_legacy_printk.c
relies on it for kernels without global data.

The exception only applies to bpf_printk() calls with at most 3 arguments.
__bpf_vprintk(), BPF_SEQ_PRINTF(), BPF_SNPRINTF() and bpf_stream_printk()
always use the static array.

Could the changelog either mention the BPF_NO_GLOBAL_DATA exception or scope
the claim to objects built without BPF_NO_GLOBAL_DATA?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/36768148430
--===============8418910095456652781==--
