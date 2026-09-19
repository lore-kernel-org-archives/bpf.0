Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5122C0261
	for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 23:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789860106; cv=none; b=AcAjWxwR7ODI8FNR9KLjxHnp0+ycDaVF7Vbu1Su8d9/MWv8RQqc0RDEhQD4IBvmZmHD7NmA/Jxr42xkNfGy8GXKhAjDJLb3f2TJp7GZrgEPQSbloyknwBcpCI+KYUUmchloiw5W6wLLmapXqhlASdBQIOc4P5U+wbUr61raSrvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789860106; c=relaxed/simple;
	bh=rBz6B/di5S9FHTrFPqqLTj34SBL7t+mg2w5ZyJVUd6Y=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=R3mE5NG2E+6pd08PIsJOZHnE0cnDK9Xd5Pudkxnvk2JBxdG2Nf10ItSPIn1D2alJqfCrCfHzbVuECb14nzVrOtk9z6ApFQ5YUsCkUkF5HmgaVYk1vKyj1dAJNLdjG9bBN58jXSdS95U4Gi/toA9pXyUbnylLt9COdDIWe72PzRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/5W8r2f; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/5W8r2f"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb751so1561340a91.2
        for <bpf@vger.kernel.org>; Sat, 19 Sep 2026 16:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789860104; x=1790464904; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uvzYLHxwxs2iR6mGVYBYcimLQ2Sg/Va4WyJg4K0mC4g=;
        b=g/5W8r2fZ70GTVo3kIkd4VTrw45Q4MZr2ID2dPV3LgFawz9O7S0AR5sbY0wVM7EOvw
         Yxgq9vXYYB3zRJ6z0AUF3UWQf9tMCKNZ4Lh+oSVjKj+G4P3uvNi/J25o+9d6lSLm7geM
         f9ztyliiElFKZgB9OMgLKcAYm735mBtadt+WhgEw8kWNznVNFq3qxWkaSAoFJA9rPL+M
         87sxPmTqEC3zfptVvtEiAlSmtZ/BgG33AOtrYC4HBAcPML+9LKTGwF5vtufgQkd/rrE/
         xzj5pX4RfPLiHcM7WrdfOktK4doTJZOmda84F4Shg9658sn9kzposfNU3zFMH6q4lcxs
         GyJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789860104; x=1790464904;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uvzYLHxwxs2iR6mGVYBYcimLQ2Sg/Va4WyJg4K0mC4g=;
        b=RTA+fTm6DJ/ewEFRTBNr8s8prLOYcVvmJt1uu0SWr6mmZLG0HwDYVXQlVPNdmDxett
         ixwPVZRAast4JU/Lf7WafSY4RP4h93vOT48oQp3GR5eMH8eC+OWOojUbbOmTDpTzLt45
         aNGs+HA/ZnqUuiZMilvKxW9zxHu+8nWWwriGmTlZ9tphAbtHN2b9OW/tVFsqETWxCFXJ
         rt0vVjFShHP8zpWsciSteFfvDIFjmFWGnicmmijd8XaPxxyOPNeq6+iN8VFw6N4ltuZV
         fh7iPJZbyoGqDCQUoK2oIGQSD58YJYscXXmb7ZwKwzv37Qsm5NihBlIpc0LHXQjoSwap
         0NOQ==
X-Forwarded-Encrypted: i=1; AKwUvByqit0MG4bJxrklL97nX8Sio7PMDNVAPbIC0xAqTEz0xeoqUMksnun1veI5J2tIKib4+qQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lrKgRrTkWLpzyHjqrg2g7q/evbnx1evNEiDz57VKnsAmnoVnQB
	ZaC5JDuV80NiLvq20Y/hPnzPjwX55/oInAeddt2JtCc6sIPLcxLFSc9m
X-Gm-Gg: AYBFou2lCyNu0Qtc6feCYhxdZUwKHfeadRAJHS6MM2seiE2rtXfZtaNF/D4aLLi2crd
	UAoZdbsaNn7b8w25E0j4eKXZaGiZkcCC+KU1BH3vIVaJ4Via0WWa76ph4nG5i+5GoVQCSjKOPii
	n0N8P80nQ/Fc8C33kInFrRAWLvvv4oxQp/b8gGXch162i44NSjo36ZQgBlNLM2RcPttWtvJ+gO0
	0JBPTuL1SzLNCs6adJ21PX/zCrI4u8LyrmJqeQfXsoAOcw2G36VjRLuhu3Hr5+f2TJVQmptGTWL
	c1uV6SOdQvMfAehLV60qMX32EdkNoPxw38OP/S8yeua5qR5G7cg1L6s0YPSPWmUP9qFpcaPQ5VY
	IbTLuA9g+LkSgIZ6B6pHmNo093MLQjniqemEt3pMR0pdEIS1Kloz5Y3xV5l0IyeD3qCt0vld4MQ
	n3hKCZquXtSfaFwJ1dHueuyPB9U8bgIKk2J/LRhObBr64pWaxT4TrW9Qf47cnwm+sZD/bEXflMh
	4aHR0Xwdahze89QSpSf0dIUXUte6oM6mABLMXFMfxRFLFVXec1GM/PT6z4tnXX5e1wE9HpfBCtu
	ZlQLCAEKZfiMudY=
X-Received: by 2002:a17:90b:5305:b0:381:6c5:3f63 with SMTP id 98e67ed59e1d1-39e54dcd917mr17679110a91.6.1789860104144;
        Sat, 19 Sep 2026 16:21:44 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c3145e5sm6749632a91.5.2026.09.19.16.21.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Sep 2026 16:21:43 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 19 Sep 2026 23:21:43 +0000
Message-Id: <DLJOGC7M106N.33I0V3YRNYB8E@gmail.com>
Cc: "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu" <song@kernel.org>,
 "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <bpf@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bpf: arena: Flush stale TLB entries before reusing
 ranges
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Andrea Righi" <arighi@nvidia.com>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>
In-Reply-To: <20260919224616.3123513-1-arighi@nvidia.com>
References: <20260919224616.3123513-1-arighi@nvidia.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, Sep 20, 2026 at 12:46 AM Andrea Righi <arighi@nvidia.com> wrote:
> @@ -911,11 +910,17 @@ static void arena_free_pages(struct bpf_arena *arena, long uaddr, long page_cnt,
>  			zap_pages(arena, full_uaddr, 1);
>  		__free_page(page);
>  	}
> +
> +	ret = raw_res_spin_lock_irqsave(&arena->spinlock, flags);
> +	if (ret)
> +		goto defer_publish;
> +	range_tree_set(&arena->rt, pgoff, page_cnt);
> +	raw_res_spin_unlock_irqrestore(&arena->spinlock, flags);

Now the ptes are cleared in one locked section and the range is set in
another, and arena_vm_fault() can get in between. It doesn't look at
the range tree to decide. It does vmalloc_to_page(), sees no page,
range_tree_clear() of an already clear range returns 0, so it allocates
a page and installs it into the kernel pte. Then the code above marks
that range free. The next bpf_arena_alloc_pages() that picks it hits
  WARN_ON_ONCE(pte_page(old) != d->arena->scratch_page)
in apply_range_set_cb(), returns NULL, puts t
he range back into the
tree, and the next call does the same. All it takes is user space
touching the page while the prog frees it.

iirc Emil has patches that address this issue differently.

pw-bot: cr
