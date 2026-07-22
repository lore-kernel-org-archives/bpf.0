Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8D480976
	for <bpf@vger.kernel.org>; Wed, 22 Jul 2026 11:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720158; cv=none; b=ldXdG7MHRMwQ3qGiw5YmJ4VBS2wsuDzH7RUp+lWNNC8P+J1iGmt61qqqXOp8qojztbA29sxBa7NFnYzz+YVdOwORxkTkkBsr8diQYHhPCGbn7yAr2cdaQetbucEJs039EvMEWax4AJquQ1X9/crzPpUnMyPr8k8KigNO7Qb1T7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720158; c=relaxed/simple;
	bh=W/HZJetZhiaiUsJd59XbA0Rkwa1XWzpOEKQ4WI8B/Nw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fErYNoUWddE6d5TDh4110O1rkqpXOK+azS6/bZhgFOiJ1O1Y9sEmlTMGw0kzHkzZIQdAS8azi8u5qufEWVNqLdDD8PNZ/fcs+5ZWDSifYmqoXRSmvTS7Sog+97UcpcPtvah73cdRizo5kEkC+cnMjTKx7//Gknq2JbxD+gEVcRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SmniWGEE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SmniWGEE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63A971F000E9;
	Wed, 22 Jul 2026 11:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784720156;
	bh=TfmqCIMg/EBjgQH5sv+kkCtBe1b3BVm0iU9tsotSjgM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=SmniWGEED5+kzNDHe7tXSxSFK9qogg6dt8HnF+tEVrcwyFoWYgTG/pOIjBJjVKd78
	 GFTer6Z1W7/Qcgp+V5VBv/XR1iNgKS7pwEGSip8hXXulT3uEIDLZ4irA0EQGLQqrk3
	 I8W3yFHwlSDdUZdBD0U/MgoF4ALfBMKHK45MpvM1qlLT0HpRdm+AKdMbiev5fIZseK
	 rxAz7V/TLd352xDv3reuT+54BVaUyb/pZqRraux7Nl2embori+pUT9fD+20E2uA1Po
	 A5FMALlLZsNuEHXbJdSnYx2pzrP1eXczuWRF7NjyLXl/WWaeU46MzKosz+xOcqFfVz
	 VqSVzQIKoierQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/4] LoongArch: BPF: Fix memory leak in
 bpf_jit_free
Reply-To: sashiko-reviews@lists.linux.dev
To: "Pu Lehui" <pulehui@huaweicloud.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260722112754.1615201-3-pulehui@huaweicloud.com>
References: <20260722112754.1615201-1-pulehui@huaweicloud.com>
 <20260722112754.1615201-3-pulehui@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 11:35:55 +0000
Message-Id: <20260722113556.63A971F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch series correctly fixes a memory leak of `prog->aux->jit_=
data` on JIT subprogram failure in `arm64` and `loongarch`, but misses the =
identical architectural flaw in `s390`, `parisc`, and `sparc64`.
--

--- Patch [2]: [PATCH bpf-next 2/4] LoongArch: BPF: Fix memory leak in bpf_=
jit_free ---
commit cacb56acd5af4ef394049dd1560a358cf9a04bae
Author: Pu Lehui <pulehui@huawei.com>

LoongArch: BPF: Fix memory leak in bpf_jit_free

This commit fixes a memory leak in the LoongArch BPF JIT compiler. When
bpf_int_jit_compile() returns early for subprograms, it leaves ctx->offset
allocated, which bpf_jit_free() previously failed to clean up on abort.

> diff --git a/arch/loongarch/net/bpf_jit.c b/arch/loongarch/net/bpf_jit.c
> index 2738b4db11653..3d3ed1677d018 100644
> --- a/arch/loongarch/net/bpf_jit.c
> +++ b/arch/loongarch/net/bpf_jit.c
> @@ -2361,6 +2361,7 @@ void bpf_jit_free(struct bpf_prog *prog)
>  		 */
>  		if (jit_data) {
>  			bpf_jit_binary_pack_finalize(jit_data->ro_header, jit_data->header);
> +			kvfree(jit_data->ctx.offset);
>  			kfree(jit_data);
>  		}

[Severity: High]
This is a pre-existing issue, but while this patch correctly fixes the memo=
ry
leak of the JIT context arrays for LoongArch, do we have the exact same leak
occurring in s390, parisc, and sparc64?

Looking at s390, parisc, and sparc64, they also return early for subprograms
and leave memory attached to prog->aux->jit_data. For example, in s390:

arch/s390/net/bpf_jit_comp.c:bpf_int_jit_compile() {
    ...
    } else {
        jit_data->header =3D header;
        jit_data->ctx =3D jit;
        jit_data->pass =3D pass;
    }
    ...
    if (!fp->is_func || extra_pass) {
        ...
        kvfree(jit.addrs);
        kfree(jit_data);
        fp->aux->jit_data =3D NULL;
    }
}

However, these architectures do not have a custom bpf_jit_free() implementa=
tion
and rely on the weak generic bpf_jit_free() function instead:

kernel/bpf/core.c:bpf_jit_free() {
    if (fp->jited) {
        struct bpf_binary_header *hdr =3D bpf_jit_binary_hdr(fp);

        bpf_jit_binary_free(hdr);
        WARN_ON_ONCE(!bpf_prog_kallsyms_verify_off(fp));
    }

    bpf_prog_unlock_free(fp);
}

The generic bpf_jit_free() does not check or free prog->aux->jit_data. If J=
IT
compilation fails for a later subprogram, the BPF core aborts and calls
bpf_jit_free() on all previously JITed subprograms.=20

Does this mean s390, parisc, and sparc64 will still leak their jit_data and
offset arrays on this failure path?

>  		hdr =3D bpf_jit_binary_pack_hdr(prog);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722112754.1615=
201-1-pulehui@huaweicloud.com?part=3D2
