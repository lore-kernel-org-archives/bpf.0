Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403EB330D23
	for <bpf@vger.kernel.org>; Tue, 28 Apr 2026 23:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777417725; cv=none; b=SyGdHWC7z9mKLOQdhvdfSMufpbzQlPy/ukZb5gAOL7BNJeVXN1G3EMA1/ssKioKIBlBW7/7sobJsjIDrAEAUFIjF+Wdm9PA1xZ4lIRYnVlDhuNSqEMwgQU7DcfV/dpK08XN9kXTNFMOdHidzfPl56SNclVe9C0cUJaNdHMwmVDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777417725; c=relaxed/simple;
	bh=ASXN7fVHZpr5urB5amjuzNWywVq2BZZrpqn2wn3pCws=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TpIKnYonVygi3sxaxqCa5wRjbcFGb4M715uWQqdVsk8ctggAlaoWaE3mNsiXKNyHjqeeCYmEY8+qSlb0UQ1RwvReaojRgkyEBu9moj70XkQBuTBKyQtioQrjjahi1OYhxXS9aGih1nKeWGWVAAqmrETB5SPYx5F6UCYa0MOVZws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw2jYSRf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw2jYSRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFA64C2BCAF;
	Tue, 28 Apr 2026 23:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777417725;
	bh=ASXN7fVHZpr5urB5amjuzNWywVq2BZZrpqn2wn3pCws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=jw2jYSRf8XnxAO5UMn0rv3gxWzs0U60PAM5SVmA/j+V6jwFAb4uy3yApFIquWJmEg
	 cx//JpWFyTyV6aLfHCwtPFlZdMj1B0NRAuR8sWeP0VBejVKbYzm5g+v6fv8fadTzbF
	 4LSq9W1N4XHL92bdpIhom4ZeGeVUBt7B8z7bAErvlb206SYtdqQuexGlge/bNrEudy
	 aqqv4pgjTxnh6EQhc4MJuUT7nluJeoCujCeclJxZptVamv0ku+U8w/JhqxOArCm41b
	 UlJzlU1BA4nPuzftemmout5LWWiI6dP19gstEBNtkG/U7IibGN3cdSGge+AfaQjTcz
	 qarqA3sDHQpkQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 1/2] bpf: Print breakdown of insns processed by
 subprogs
Reply-To: sashiko@lists.linux.dev
To: "Paul Chaignon" <paul.chaignon@gmail.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777388107.git.paul.chaignon@gmail.com>
References: <5c3514dbc879f22ba3f9eff8a2c730e13bd0572c.1777388107.git.paul.chaignon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Apr 2026 23:08:44 +0000
Message-Id: <20260428230844.EFA64C2BCAF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Out-of-bounds read in `bpf_subprog_is_global()` when printing veri=
fication stats for programs with hidden subprograms.
--

commit 08128f883e58301e0f97b1d4a94656be63b8f790
Author: Paul Chaignon <paul.chaignon@gmail.com>

bpf: Print breakdown of insns processed by subprogs

This patch tracks the number of instructions processed by each global
function (subprog) during BPF verification. It then reports this
breakdown in the verifier logs under BPF_LOG_STATS.

> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index 03f9e16c2abe..b48389b48eb6 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c

[ ... ]

> @@ -18288,6 +18295,13 @@ static void print_verification_stats(struct bpf_=
verifier_env *env)
>  				verbose(env, "+");
>  		}
>  		verbose(env, "\n");
> +		verbose(env, "insns processed %d", env->subprog_info[0].insn_processed=
);
> +		for (i =3D 1; i < env->subprog_cnt; i++) {
> +			if (!bpf_subprog_is_global(env, i))

Could this introduce a regression due to an out-of-bounds read on the
func_info_aux array if there are hidden subprograms?

At load time, if BTF is present, env->prog->aux->func_info_aux is allocated
with exactly func_info_cnt elements, and env->subprog_cnt initially matches
func_info_cnt.

During verification, if a feature like bpf_throw is used without an explicit
callback, add_hidden_subprog() is called which increments env->subprog_cnt
but does not resize the func_info_aux array.

Since this loop iterates up to the updated env->subprog_cnt, when i reaches
the index of a hidden subprogram, bpf_subprog_is_global() will access
aux[i].linkage where i >=3D func_info_cnt:

kernel/bpf/verifier.c:bpf_subprog_is_global() {
	struct bpf_func_info_aux *aux =3D env->prog->aux->func_info_aux;

	return aux && aux[subprog].linkage =3D=3D BTF_FUNC_GLOBAL;
}

Is it possible to skip hidden subprograms here, or limit the check to
func_info_cnt?

> +				continue;
> +			verbose(env, "+%d", env->subprog_info[i].insn_processed);
> +		}
> +		verbose(env, "\n");
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/5c3514dbc879f22ba3f=
9eff8a2c730e13bd0572c.1777388107.git.paul.chaignon@gmail.com?part=3D1
