Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D134E2D3727;
	Tue,  1 Sep 2026 17:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788285348; cv=none; b=L6pb0rIAHF09zElp9L6UADgG7nB9PC1GLYNODkOtJdSz12xizfJxOnLSDMLKsGibR0M+Ndi33gD69zdOW6Z/Z+xE8aV166qzvl8l7iVMKZUoj17jYfT7ajYJdwgnqXc21Rk4vcGu9iTIcXzK7YAjF4pTP0SVGVNi1W92npZg1kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788285348; c=relaxed/simple;
	bh=8XfcJbKctjW/O8Qo/Lw/el0OyCmOfYjyCqJFsWyA0Uc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=Ut/d/JfJAZEr8QESjPmcMTItOgoAG6YIUmVMNz0p15QpruHSx9Qr0YJLGxBv7Yoh2H/xF12sd31z7X4um49MrWZDCZBOnf0BF3pXAk4QIKO6quKDkdMmvXM4crVlHDtrHbRnFSILR7PuSE0iWuMxiMRxS1XQHkTMcYSMuT+V4Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4PBeAq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4PBeAq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EBD1F00A3A;
	Tue,  1 Sep 2026 17:55:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788285346;
	bh=eyfblexv+juqU8vvMtAuPJdez7dhV765sTfZODE8r8k=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=S4PBeAq3yozQll5MFLvEVP6jLcrTm6ojJifTriBpfgJRLfphpHNEFx701bYoAbdkD
	 NxPgOgQNKcA6hXLgkoyX61aTlPqcbTsTYgDoPfRfkuxwJe2ohRYsc1nrPPVgOjKfGs
	 3Vmi476swvMbRXbv67EtaXaTdXilmhQmP3uvmYCTgLUvBiJxNEP5ISXUI9ZPKTGfZ6
	 TaBstikWiR55GFEzzuXwad9hM2+gOmhIPWosQ29xBjNmsA3NFFYQcuqRuTA3TEao+a
	 n3r09SHqFmxy2xuL9qO8khcpTM/bgRPcRTTqG0JNdxWbCr99vZrqJgPd8X4AjdeMdC
	 xNeNfAn8KJh6w==
Content-Type: multipart/mixed; boundary="===============0164521486556876510=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <060d0c396b10371636b451c459e84b256f9e3fc79449a0dcf1aa88c3f61caea6@mail.kernel.org>
In-Reply-To: <20260901165757.801449-12-alan.maguire@oracle.com>
References: <20260901165757.801449-12-alan.maguire@oracle.com>
Subject: Re: [PATCH v2 bpf-next 11/18] bpftool: Add ability to dump LOC_PARAM, LOC_PROTO and LOCSEC
From: bot+bpf-ci@kernel.org
To: alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org
Cc: daniel@iogearbox.net,eddyz87@gmail.com,jolsa@kernel.org,ihor.solodrai@linux.dev,yonghong.song@linux.dev,song@kernel.org,qmo@kernel.org,martin.lau@linux.dev,memxor@gmail.com,emil@etsalapatis.com,mcgrof@kernel.org,petr.pavlu@suse.com,tj@kernel.org,kees@kernel.org,bpf@vger.kernel.org,nathan@kernel.org,nsc@kernel.org,arnd@arndb.de,puranjay@kernel.org,yatsenko@meta.com,atenart@kernel.org,ojeda@kernel.org,linux-modules@vger.kernel.org,alan.maguire@oracle.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,mason@kernel.org,ihor.solodrai@linux.dev
Date: Tue,  1 Sep 2026 17:55:45 +0000 (UTC)

--===============0164521486556876510==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index bca0a3982f09..4d8991c99b48 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c

[ ... ]

> @@ -415,6 +418,88 @@ static int dump_btf_type(const struct btf *btf, __u32 id,
>  		}
>  		break;
>  	}
> +	case BTF_KIND_LOC_PARAM: {
> +		const struct btf_loc_param *p = btf_loc_param(t);
> +		__u32 *v = (__u32 *)(p + 1);
> +		__u32 i, vlen = btf_vlen(t);
> +
> +		if (json_output) {
> +			jsonw_uint_field(w, "size", t->size);
> +			jsonw_uint_field(w, "flags", p->flags);
> +			jsonw_uint_field(w, "vlen", vlen);
> +			jsonw_name(w, "values");
> +			jsonw_start_array(w);
> +		} else {
> +			printf(" size=%u flags=0x%x vlen=%u", t->size, p->flags, vlen);
> +		}
> +		for (i = 0; i < vlen; i++, v++) {
> +			if (json_output) {
> +				jsonw_start_object(w);
> +				jsonw_uint_field(w, "value", *v);
> +				jsonw_end_object(w);
> +			} else {
> +				printf("\n\t value=%u", *v);
                                              ^^^^^

This isn't a bug, but was the extra space after '\n\t' in the format
strings intentional? Looking at the existing dump_btf_type() arms,
DATASEC prints "\n\ttype_id=%u offset=%u size=%u" with just '\n\t' and
no leading space. The new LOC_PARAM, LOC_PROTO, and LOCSEC arms all use
'\n\t ' (tab followed by a space), which indents the output one column
further than the rest of the function's raw dump lines. Could the space
be dropped to align with the DATASEC style?

> +			}
> +		}
> +		if (json_output)
> +			jsonw_end_array(w);
> +		break;
> +	}
> +	case BTF_KIND_LOC_PROTO: {

[ ... ]

> +	case BTF_KIND_LOCSEC: {

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/33537080133
--===============0164521486556876510==--
