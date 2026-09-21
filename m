Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277F83C3F58
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 15:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790006387; cv=none; b=pqNtZ+IHLii6Ffg7N9eSEObX5uBLB4R+QlUioRI9RWM8F4Van7oIRiTKF5T6CzmEv2gOkocxyeq8WrEBZP5Finpnc0gzRriPUIWMaqfB8y2EgzSDXaDmma/S6yW2pEVAYeRSFGnoOEPdtV9UMukqh2qbECH8njGpOtbPo9Fl6AM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790006387; c=relaxed/simple;
	bh=v/q8Pks4DRp+sZnSR9urT63GT271YuxfubLRI8+0N7k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aGDJsn9AIGZC089WFIn5BTRbw7vFHbUYt2zW/nb4aaPaotUscRSktoTuPwWIO6SbICz3f1M6/5Xw7XPnoSY9lNZoOilej5XoHCW+CaarfmjYmWU5ulI/XvnR+yY8Og+dRYNylTokCgtzuwdqoes1nHgk37WgxhXOwSKLArqRcKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwEokjxE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwEokjxE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949431F00893;
	Mon, 21 Sep 2026 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790006385;
	bh=1ccwwRZHKt/zDegwQK2HJHD9hOQrgLx9p/WeRr4BjeA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gwEokjxE0swbvScg9k4qIvzZvnR5HZq7toEO8FtGYhgrdQZ1F8KuO7W2mmIRqK5bn
	 9zm7+pv9T3XDdrqldu2nNqvpvik0+TwtQrzn0vHTALcK6plTK+Yv2pp8sgnWohWqfz
	 XNNz92mg+T0511sWcpkjOJn9+fU2GfdLNR6+Iyd3yo4ePlfJg21TEmXYP2EeQ8TP66
	 GOStwGVU3onkCdm5qAXzO8icbhZuSjwzlXSMEy01gSz6Yk9hGJUtN+XzOzrmx9ZFws
	 0Sjt8W0t9K+oaFeoSSoI87LoLTSuGWloAmNm6kutqArr61IbqKf7DXDJhswiBeTet1
	 R8sqI2MOGjsGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] bpf: add diagnostics for rejected memory and map
 accesses
Reply-To: sashiko-reviews@lists.linux.dev
To: "Suchit Karunakaran" <suchitkarunakaran@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260921154650.130677-1-suchitkarunakaran@gmail.com>
References: <20260921154650.130677-1-suchitkarunakaran@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 15:59:45 +0000
Message-Id: <20260921155945.949431F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] bpf: incomplete diagnostic coverage for read-only and packet writes
--

commit 4bb7159fc40bb3fd0415a49f32660f99d3a92102
Author: Suchit Karunakaran <suchitkarunakaran@gmail.com>

    bpf: add diagnostics for rejected memory and map accesses
   =20
    Emit structured verifier diagnostics when BPF programs are rejected for
    unsupported or prohibited memory operations. Cover sign-extending arena
    loads without JIT support, read/write access restrictions on maps, writ=
es
    through read-only pointers, direct packet writes, and modifying helpers
    used with BPF_F_RDONLY_PROG.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 18aad4886f9cf..a4ca95168a01f 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
[ ... ]
> @@ -6529,6 +6535,9 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
>  		if (t =3D=3D BPF_WRITE && rdonly_mem) {
>  			verbose(env, "%s cannot write into %s\n",
>  				reg_arg_name(env, argno), reg_type_str(env, reg->type));
> +			bpf_diag_policy(env, insn_idx, "write through a read-only memory poin=
ter",
> +					"this pointer permits reads only",
> +					"Use a writable destination, or copy the data into a writable buffe=
r before modifying it.");
>  			return -EACCES;
>  		}

[Severity: Low]
This isn't a bug introduced by this patch, but does the check for PTR_TO_BUF
also need this diagnostic when rejecting direct writes in check_mem_access(=
)?

kernel/bpf/verifier.c:check_mem_access() {
	...
	} else if (base_type(reg->type) =3D=3D PTR_TO_BUF &&
		   !type_may_be_null(reg->type)) {
		bool rdonly_mem =3D type_is_rdonly_mem(reg->type);
		u32 *max_access;

		if (rdonly_mem) {
			if (t =3D=3D BPF_WRITE) {
				verbose(env, "%s cannot write into %s\n",
					reg_arg_name(env, argno), reg_type_str(env, reg->type));
				return -EACCES;
			}
	...
}

Should writes to read-only PTR_TO_MEM and PTR_TO_BUF via helper function
arguments also emit the structured diagnostic?

kernel/bpf/verifier.c:check_helper_mem_access() {
	...
	case PTR_TO_MEM:
		if (type_is_rdonly_mem(reg->type)) {
			if (access_type =3D=3D BPF_WRITE) {
				verbose(env, "%s cannot write into %s\n",
					reg_arg_name(env, argno), reg_type_str(env, reg->type));
				return -EACCES;
			}
		}
	...
}

[ ... ]
> @@ -6608,6 +6617,9 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, struct b
>  	} else if (reg_is_pkt_pointer(reg)) {
>  		if (t =3D=3D BPF_WRITE && !may_access_direct_pkt_data(env, NULL, t)) {
>  			verbose(env, "cannot write into packet\n");
> +			bpf_diag_policy(env, insn_idx, "direct packet write",
> +					"direct packet writes are disabled for this program type",
> +					"Remove the direct write, or perform the modification in a program =
type and hook that support packet writes.");
>  			return -EACCES;
>  		}

[Severity: Low]
This is a pre-existing issue, but should the same diagnostic be emitted when
packet writes are rejected via helper function arguments?

kernel/bpf/verifier.c:check_helper_mem_access() {
	...
	case PTR_TO_PACKET:
	case PTR_TO_PACKET_META:
		if (!may_access_direct_pkt_data(env, meta, access_type)) {
			verbose(env, "function access to the packet is not allowed\n");
			return -EACCES;
		}
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921154650.1306=
77-1-suchitkarunakaran@gmail.com?part=3D1
