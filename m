Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96CF030D41F
	for <bpf@vger.kernel.org>; Fri,  4 Sep 2026 03:24:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788492278; cv=none; b=VVpn8DjKfuIcNbpSrf0o4YiT72Y3Umc4gLXvmwg4/c2qCa2N9khLfPq2Xk07aKhXS0MgpmBRIyRlEVQNaKL6ysRgIeHw73lEmre75f5JibyAedWsbM6rklbW43TwuIt04p6ITFqunKKwZ9o11spGWRqP8qiEoDzl9K8BEP5zRYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788492278; c=relaxed/simple;
	bh=yKrtvke+EIHZ6rdJ+zZq7KzQi0tfBgwKTc6il9WqeLg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dMuJj3bEXWFe3D8YGnlrIaHeQT8jNG+jufAdt7z7a1sn7/h9wvglNzxViZo9ysRx0uaF1iJSXeWILJSm9KHTgDSxYw4GOYOE+UO+h8cGbLDpALOCr89drXiOMkTJVBUKVjaRI/1QuUxazQlt954VLx2XR7Vohy2en+ESeGDxpr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob/oG9zF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob/oG9zF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BDA1F00A3D;
	Fri,  4 Sep 2026 03:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788492277;
	bh=9FQuv9sr3Y0UJLRwvXyp1MNTpsgI1wiyhjpSr9cPsQQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ob/oG9zFKk3xYErER1C4baPwrz1TP3LQlSlQyzLPkoq3WcgfJYojG84ALCkctmt0y
	 kTdghdfROuocUxwAprg1U7BSBuWv/GtSr+xxXxJx+aEJDD9M+TTBQl2ekQErTS5+d2
	 KeHLIy6NsEmx2DHsC3pnYWLfURmE8HSHI/Tw8dL1Cu6zo6dVc8GKRqYsRPc0RH/Lvq
	 qlnboQ8OXMaGds7sjN05p7hEfypiNg2rD17PoY0y4L2mm2n66ndRhKlf1uqC9YFNoW
	 b72zej4MmY9DXdmc6k3zfNrpmyQ7+w15k47FGg6Wdeyry7TEJmRTP7n2OfdSD+BScM
	 xgiOuhcSTTrWw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH bpf-next 2/2] bpftool: Reject non-autoload programs for
 light skeletons
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?VGhpw6liYXVkIFdla3N0ZWVu?= <tweek@google.com>
Cc: bpf@vger.kernel.org
In-Reply-To: <20260904031912.2133476-2-tweek@google.com>
References: <20260904031912.2133476-1-tweek@google.com>
 <20260904031912.2133476-2-tweek@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 03:24:36 +0000
Message-Id: <20260904032437.24BDA1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Direct return on the error path for non-autoload programs leaks the=
 file descriptor, memory mapping, and BPF object.
--

commit 2f23ddc68c8f556d1272e5244820c6008be97512
Author: Thi=C3=A9baud Weksteen <tweek@google.com>

bpftool: Reject non-autoload programs for light skeletons
   =20
When generating a light skeleton (bpftool gen skeleton -L), there is no
libbpf runtime object or bpf_program__set_autoload() API available to
enable/disable the autoloading of programs. This commit explicitly rejects
non-autoloaded programs when use_loader is true with an error message to
prevent generating broken light skeleton headers.

> diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
> index a50540ef6521c..1583150241c88 100644
> --- a/tools/bpf/bpftool/gen.c
> +++ b/tools/bpf/bpftool/gen.c
> @@ -1340,6 +1340,12 @@ static int do_skeleton(int argc, char **argv)
>  	}
>  	bpf_object__for_each_program(prog, obj) {
>  		prog_cnt++;
> +
> +		if (use_loader && !bpf_program__autoload(prog)) {
> +			p_err("program '%s' is marked as non-autoload, which is not supported=
 for light skeletons",
> +			      bpf_program__name(prog));
> +			return -1;

[Severity: Low]
Does this code leak the file descriptor, memory mapping, and BPF object?

Since this returns directly, it bypasses the established resource cleanup b=
lock
(the out: and out_obj: labels) at the end of do_skeleton(), which would
normally call bpf_object__close(obj), munmap(obj_data, mmap_sz), and close(=
fd).

Could this set err =3D -1 and use goto out; instead?

> +		}
>  	}
> =20
>  	get_header_guard(header_guard, obj_name, "SKEL_H");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904031912.2133=
476-1-tweek@google.com?part=3D2
