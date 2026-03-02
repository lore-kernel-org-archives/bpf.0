Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75CED390983
	for <bpf@vger.kernel.org>; Mon,  2 Mar 2026 21:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772488317; cv=none; b=sfgJ6dJs46S4AIM+cgKX2TSe+EBpxd6EsXhBjOoiopLZ+2YOzl5RPxYHJ0otiTnQMv8TYr4xFQ+K909S6TsLKQAG4mmc3qTOTduLAGntODSgephQXKp4OTRipVOzfAT/gHmKhjDIyn9dKzyHIgKL8TUGkv+nTPnernhO13s07Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772488317; c=relaxed/simple;
	bh=EBdZLzwLznoES2jZaMk9N4WwPiie/cHZlPrNbp3rcsc=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=OLZy++UmQw2Eqiq3UeCjOm9+fOPlmcMLshWIMRcDb+7Nc2GzvohkJ3fgKgySM+UEqOhgDmFSJDKxu6Ni5Q4dccvsowAzoIooGEADzyimJYYy8XZn6s/7RqjelJw8cNIR83goH9VphRhgRtX3muaPHg4vM1Ha6iMIrH0M1Uv4ehw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JX6kGMmT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JX6kGMmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E17C19423;
	Mon,  2 Mar 2026 21:51:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772488317;
	bh=EBdZLzwLznoES2jZaMk9N4WwPiie/cHZlPrNbp3rcsc=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
	b=JX6kGMmTb+ogdbjfMLXUnOOWOzU14+8VltdU1tUI+yKr7MjvD70RXQKAneun2NAIq
	 AThvX3GBtObmxcmqJRbDC0rwVjPf+8C5l3+TcyfkwdMWBB34/nFdePwVBYTteyTnb1
	 jkt7nnZmaBk9ET2um9UE1Y0ax8P3pZWmc1H8hXCjUS6KqCc/hoh/h4P9N3JiaFatBF
	 JQkcoQvp5mLNe6O0iIuwMjw7I7a+yR4fXJLLRtlTDYjl1qYXV3baSJwH+Xiinzchvl
	 cYHIJnvmV3+2FOuI09OOMfJ8PPqNwYzYhJ4pRGZjTWhEu2G25COs+stCa4gdfjoPiN
	 fJCzl9PVGvaJg==
Content-Type: multipart/mixed; boundary="===============5632147425714675464=="
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <f4cdeadb4a7981cfaf13afb1604f1ae80a60e9e4b2435566192853fc9146146a@mail.kernel.org>
In-Reply-To: <20260302210532.381083-2-andrey.grodzovsky@crowdstrike.com>
References: <20260302210532.381083-2-andrey.grodzovsky@crowdstrike.com>
Subject: Re: [PATCH bpf-next v4 1/2] libbpf: Handle duplicate kprobe symbols in attach_kprobe_opts
From: bot+bpf-ci@kernel.org
To: andrey.grodzovsky@crowdstrike.com,bpf@vger.kernel.org
Cc: ast@kernel.org,daniel@iogearbox.net,andrii@kernel.org,jolsa@kernel.org,emil@etsalapatis.com,linux-open-source@crowdstrike.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon,  2 Mar 2026 21:51:56 +0000 (UTC)

--===============5632147425714675464==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c

[ ... ]

> +static int find_kaddr_cb(unsigned long long sym_addr, char sym_type,
> +			 const char *sym_name, void *ctx)
> +{
> +	struct find_kaddr_ctx *data = ctx;

[ ... ]

> +		if (data->kaddr && data->kaddr != sym_addr) {
> +			pr_warn("kernel symbol '%s': resolution is ambiguous: 0x%llx or 0x%llx\n",
> +			sym_name, data->kaddr, sym_addr);
                ^^^^^^^^

Should the continuation line be indented one more tab to align
closer to the opening parenthesis?  The pr_debug() a few lines
below in the same function aligns it properly:

			pr_debug("found kernel symbol %s at address 0x%llx\n",
				 sym_name, data->kaddr);

> +			return -EINVAL;
> +		}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/22596279807
--===============5632147425714675464==--
