Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE3D15E5BB
	for <bpf@vger.kernel.org>; Mon, 29 Jun 2026 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782768811; cv=none; b=cSFaX+EEOVdNppiASvj4HsdtaT1wqCkjjZNxqx6CMhz4fJwwA9M6cq7CS24U52GE/bgF7FMK9HGpSqSeRiCvMlpH+CRXpyNUZTVm8NJmpaPqknd7qwFECobaWfPwDWr1soE5wXJbFGX1JAg6Jgp3/6WQCYDHBKPHd9c5qtOmR60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782768811; c=relaxed/simple;
	bh=hgKtRtkReq4+EtPij8Wu/zdHolciU1EPv2pvcH6mN54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W9EcWk8nTIViMUCTeTElbW6E6GghVs9qpUBu+BTjymmAN9pcV/kSlIn1Gmls/67/6ujwFu2CaZB/ANlOIlKSmeAJ+DvQ3EanW6Y02EKpa4KwPiYCHfOFz+CONRM7xOQfqA2tuez/RqYq1nzOzxiSUUan1YsNfbhW+H5SHan561c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TP6MvvCL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TP6MvvCL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ACD41F000E9;
	Mon, 29 Jun 2026 21:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782768810;
	bh=gtF3QTs1SGSgm5PukJMEbGKiexRy6jZkzeIlhtEyLW4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TP6MvvCLcxbHGdfX7SSxKa1xqC6aXmpGVHK7O7/piuV+e0g3zXSlRiqce/j5AcDBY
	 z0F10vS52vqsG53PsiBKfaWszq6Ts7NOVOUTaCDpjjsjSeiv1SoZhiBghD5VYkRV1C
	 BxBEIZ60vwW5hyPh9r+7FPput2+gJTBrJ1lLSrRwwpAUdRDaZdjx4HSCUFCBUpXOhJ
	 pdm4dz6Jp0Kz5AjruA/QR33gehVdaRwQ9fgJm01sd6htDUTOCpfPYVCn9NqDlILYIe
	 vzzRJ1gAfEJCv2W5/fMiAhPWo1EBBWl7wAOOD6K2VfaGn4u01SPmLp+ipAMKnz+55G
	 /b0QJHohgaZHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCHv4 bpf-next 3/3] bpftool: Add tracing_multi link info
 output
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Olsa" <jolsa@kernel.org>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260629212208.895962-4-jolsa@kernel.org>
References: <20260629212208.895962-1-jolsa@kernel.org>
 <20260629212208.895962-4-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 29 Jun 2026 21:33:29 +0000
Message-Id: <20260629213330.0ACD41F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] bpftool uses a non-existent `tracing_multi` union member in `str=
uct bpf_link_info`.
- [Medium] The kernel-side `bpf_tracing_multi_link_lops` is missing the `.f=
ill_link_info` callback.
- [Low] Memory allocated for `ids`, `addrs`, and `cookies` is leaked on the=
 error path of the `bpf_link_get_info_by_fd` syscall.
--

commit 3c4bad76286f49adf87a7b01dc7042ac6368c5ce
Author: Jiri Olsa <jolsa@kernel.org>

bpftool: Add tracing_multi link info output

Adding bpftool support to show tracing_multi link details. The new output w=
ill
display attach types, counts, BTF IDs, addresses, cookies, and functions.

> diff --git a/tools/bpf/bpftool/link.c b/tools/bpf/bpftool/link.c
> index bdcd717b0348f..088d1d206065f 100644
> --- a/tools/bpf/bpftool/link.c
> +++ b/tools/bpf/bpftool/link.c

[ ... ]

> @@ -403,6 +422,52 @@ show_uprobe_multi_json(struct bpf_link_info *info, j=
son_writer_t *wtr)
>  	jsonw_end_array(json_wtr);
>  }
> =20
> +static void
> +show_tracing_multi_json(struct bpf_link_info *info, json_writer_t *wtr)
> +{
> +	bool is_ibt_enabled =3D is_x86_ibt_enabled(), show_symbol;
> +	__u64 *addrs, *cookies;
> +	__u32 i, *ids;
> +
> +	if (!dd.sym_count)
> +		kernel_syms_load(&dd);
> +	show_symbol =3D !!dd.sym_count;
> +
> +	show_link_attach_type_json(info->tracing_multi.attach_type, wtr);

[Severity: Medium]
Does `struct bpf_link_info` in `include/uapi/linux/bpf.h` include a
`tracing_multi` member?

It looks like the `tracing_multi` struct is missing from `struct bpf_link_i=
nfo`
in the UAPI, which causes a compile error here when trying to access
`info->tracing_multi.attach_type`.

Additionally, the kernel-side implementation in `kernel/trace/bpf_trace.c`
appears to be missing the `.fill_link_info` callback in
`bpf_tracing_multi_link_lops`.

Without it, will the kernel silently return unpopulated link details when
queried via `bpf_obj_get_info_by_fd()`?

[ ... ]

> @@ -1114,6 +1226,26 @@ static int do_show_link(int fd)
>  			goto again;
>  		}
>  	}
> +	if (info.type =3D=3D BPF_LINK_TYPE_TRACING_MULTI && !info.tracing_multi=
.ids) {
> +		count =3D info.tracing_multi.count;
> +		if (count) {
> +			ids =3D calloc(count, sizeof(__u32));
> +			addrs =3D calloc(count, sizeof(__u64));
> +			cookies =3D calloc(count, sizeof(__u64));
> +			if (!ids || !addrs || !cookies) {
> +				p_err("mem alloc failed");
> +				close(fd);
> +				free(cookies);
> +				free(addrs);
> +				free(ids);
> +				return -ENOMEM;
> +			}
> +			info.tracing_multi.ids =3D ptr_to_u64(ids);
> +			info.tracing_multi.addrs =3D ptr_to_u64(addrs);
> +			info.tracing_multi.cookies =3D ptr_to_u64(cookies);
> +			goto again;

[Severity: Low]
Do we leak the memory allocated for `ids`, `addrs`, and `cookies` if the
subsequent `bpf_link_get_info_by_fd()` syscall fails?

When jumping to `again:`, if `bpf_link_get_info_by_fd()` returns an error, =
the
function returns early without freeing these arrays:

tools/bpf/bpftool/link.c:do_show_link() {
    ...
    again:
	err =3D bpf_link_get_info_by_fd(fd, &info, &len);
	if (err) {
		p_err("can't get link info: %s",
		      strerror(errno));
		close(fd);
		return err;
	}
    ...
}

Should the error path free these arrays before returning?

> +		}
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260629212208.8959=
62-4-jolsa@kernel.org?part=3D1
