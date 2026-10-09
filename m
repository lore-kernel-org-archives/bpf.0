Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E568330F7E8
	for <bpf@vger.kernel.org>; Fri,  9 Oct 2026 04:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520489; cv=none; b=Mfcp6dL9DMZX7cejw2evpWVO3hWYEP+0O6hxTDrBta1SjuyfbGh7GgU6ZmwFtCrXKXZQ3pomvvMD1MsBHjsoNN95lJ4hdi+4FRACjQsijDCje1AkoKoAGSPhL69t/6LgiuyJKIs7hHD1/GDSSkEiHe51wbsQW8KBtB6l3rHEVZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520489; c=relaxed/simple;
	bh=KfdU/oGN1O5Kna1vAH+dFJ3AwD43tzfY8qqUaN+RXoI=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=V+OrXgXTe9+B2bBdMg/8/qGBG4a5pkzdGJyMRfvGkg38ASX/mGp7VMFugV100IcZs9j7Czaj8Mc2m2iaW3ftoW1Oh9vbKWMFiFEnl3WEU4lIcq5oX+A3j2VWTKmpXSfkUiz3Y+RjyDOtk4ZgE6mtjmcFGgz0OC0lwKQM45iHyRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fM6me8ym; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fM6me8ym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 596351F000FF;
	Fri,  9 Oct 2026 04:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791520487;
	bh=Z9o5KTQTJsMISOWaEA2LBIk9F829CusjJ6JzifJKet8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fM6me8ym56WIJ4Eey30qTGE1mcw/vGK0uQn2lOgViW/NYY0tOp1qJba59gEf6FfSZ
	 tjC+EiYw0YZsltdG1FqiCHeA3NaIAMa8yIbsvfrIa7PNILzNYJqg4QwpfaIY/ZUGro
	 /Aj/DDd2EgJR3U2ah1c4f4dDwsvjwmgkHJzQfGOX69gcILrnbeBzyIU43cZJGbrKAY
	 NFic2PokFt7NWKA1DWJjdyo+ib/t9/13tqVAC7caEHvPZklZ2AYY+TylgeofPG3XMN
	 o3Jgjcn0uUSsFCWRYtkKTSWGU1ovJN2eELktGh9wJ8f8V8RGOGC1bjaawJ71ncwYTJ
	 CPFa+xMHaxIyw==
Message-ID: <sashiko-outbox-164845@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next v10 05/24] bpf: Mark covered call sites and
 check a program can take a table
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yonghong Song" <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
In-Reply-To: <20261009041513.24198-1-yonghong.song@linux.dev>
References: <20261009041447.17092-1-yonghong.song@linux.dev>
 <20261009041513.24198-1-yonghong.song@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Oct 2026 04:34:46 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] bpf: exception landing pad target fails to shift under BPF_PATCH_M=
OVE_TARGET
--

commit 12354911ea762dbd3bb3462885368e582fd7efd5
Author: Yonghong Song <yonghong.song@linux.dev>

bpf: Mark covered call sites and check a program can take a table

bpf_exc_prepare() records the landing pad of every call in a cleanup record=
's
range. bpf_exc_check_prog() refuses offloaded programs, programs without
JIT support, and programs with epilogues or exception callbacks.

> diff --git a/kernel/bpf/exception.c b/kernel/bpf/exception.c
> index 2fef417dc090f..21bc1294227c1 100644
> --- a/kernel/bpf/exception.c
> +++ b/kernel/bpf/exception.c
> @@ -141,6 +141,76 @@ int bpf_exc_check_info(struct bpf_verifier_env *env,=
 const union bpf_attr *attr,
[ ... ]
> +static void mark_call_sites(struct bpf_verifier_env *env)
> +{
> +	u32 i, j;
> +
> +	for (i =3D 0; i < env->cleanup_info_cnt; i++) {
> +		struct bpf_cleanup_info *rec =3D &env->cleanup_info[i];
> +
> +		for (j =3D rec->begin_off; j < rec->end_off; j++) {
> +			struct bpf_insn *insn =3D &env->prog->insnsi[j];
> +
> +			if (!bpf_pseudo_call(insn) && !bpf_is_callx(insn) &&
> +			    !bpf_is_unwind_kfunc(insn))
> +				continue;
> +			env->insn_aux_data[j].cleanup_pad =3D rec->landing_pad_off + 1;

[Severity: High]
If a landing pad is at the exact start of the program or subprogram
(landing_pad_off =3D=3D 0), how does this interact with BPF_PATCH_MOVE_TARG=
ET
when prepending instructions?

Because kernel/bpf/exception.c:bpf_exc_check_info() permits landing_pad_off
to be 0 or subprog_start, this structural layout is possible. When it
happens, the shift logic in kernel/bpf/fixups.c:adjust_insn_aux_data() uses
a strict greater-than condition:

    if (env->cleanup_info_cnt)
        for (i =3D 0; i < prog_len; i++)
            if (data[i].cleanup_pad > off + 1)
                data[i].cleanup_pad +=3D cnt - 1;

If cleanup_pad =3D=3D off + 1 (e.g., when off=3D0), it doesn't get shifted.
But BPF_PATCH_MOVE_TARGET prepends instructions at off=3D0, such as
when gen_prologue is called in kernel/bpf/fixups.c:bpf_convert_ctx_accesses=
().

Will this leave the unwinder jumping into the newly prepended verifier
instructions rather than the program's original first instruction,
potentially causing issues like out-of-bounds reads or infinite loops if
registers are clobbered?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261009041447.1709=
2-1-yonghong.song@linux.dev?part=3D5
