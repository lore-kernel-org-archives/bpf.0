Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C029409295
	for <bpf@vger.kernel.org>; Tue, 29 Sep 2026 06:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790662308; cv=none; b=gTGBGXEPpkcQ8RujlwKgA+KuRtEuk7TeamVxbq6FvuOIQYzzsPeIBghQ+7DftwQZvWLEFv3gjNQgeWg3VajuTpuRHZEdrLeNTFd+e6sTp4HYBuffyzQDeMBDw/4bdu44372a7fVdh2ipCDyAkK1juxyL7gPUM48pnDCdO9uG6Fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790662308; c=relaxed/simple;
	bh=//UIWI6EBSx9Oag+8dQ5laZGpmh3mMNe3zb67AuJvD8=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=Z/0jqmOdSkvm0ssnvVa+sVCifD/D6/N7YcaZ+AcciZ6LyXKvLG9bjvUSb/bUBXKzsE2eFE1qFl/omUaf3Oy470jaDq/VeA5qjN9jqEQM+SixavGAA8wMkyaRlpvhvSwt96Ai71vVzqPx3a6dovfCJ8k6nA8vfwcsb2D4NFPS1mE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRmVdTQm; arc=none smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRmVdTQm"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc794a06e5fso1856519a12.3
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2026 23:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790662307; x=1791267107; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IBoCCGhRsJHq8tUovZJTNZLbswHaHS+w9f7EhlXZncE=;
        b=pRmVdTQmMnsn/Qu/OgOH3jKTZZLHXAU093PKquBGsFQkPjHnkz9gLUoGhfwNOnp16h
         wzcgONRaktsmhlBodCt5z/iuw1ruNiF2Bw5TG7X6d1tOMBfNjafRbOS0/psPq3zokksu
         zSSgh5C8WiEoaXM20/Lpfrm/3oCZPtg1PxRXcMElMSARclcwFtFVkUpXl4lT4oJnBNEp
         ArNR0UHRFctzsWsOoTWuolc07wdO59pS7zt+QsM3wNy/PZmDp7qIjYskMCQXC+R/amhy
         PEsHOPVnCgNc2CKpf8CXwZDaIGxilKiqz0FWNI5K6X4no3m9NoL3dq2DEIguQLdYZoVD
         HiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790662307; x=1791267107;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IBoCCGhRsJHq8tUovZJTNZLbswHaHS+w9f7EhlXZncE=;
        b=KSKQGBEHu2kCkVCC+y/fSzQm+E/+U6yTgdW3Exmon+vt8cGbVDKioW1iYUnqyLJRl7
         Y1jBy2w2x08+JCC6xH+39POwRHpqNqAOph00poC5b1QKvGRGdAzd9dhFmN9Fi0eqqvVP
         LGWeScfpXCh2USSUyX+H1UnMe/zgPYYmtrBPo7OfwNpJkqwl8zKVjmt1kVJOGB/ySf3U
         MkrQhr33X+DzJRIpGD8INtv5mdA5DnNvOXGXb4pI4CqflLjYc2f/yusRg9SvLjf1ZxHY
         NcIpJujZUYzdX/Zp2oPW9snH+VLPmJ4UBCl+kgeIop5UVDdTbCdyEtfhaa/uFC/mzCLw
         +kDg==
X-Forwarded-Encrypted: i=1; AKwUvBzzyxngozbuf95hQhKBXIOM8X02cj+XUygC/MOqclcSObqNgythUQZjL92QTc3DFok6pg0=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrUh/afm8/bxlcgyw+kLS+fp4tphDG40vA7tfrtZZP8GpZxsL7
	G8W8j3tALjgLzWexPPzUOOy3yWow4XNrkOIZOjLijINosbG83dha8lQJ
X-Gm-Gg: AYBFou2pyn3dksMKkMC6/NpicJex7mXWUiUjf2g5fvZy2XWff38PXNiCJehQqfm9myk
	xXvDaQ6bb1fTvT3KIpjRux39rRDmctdczyE1Q+6zXi4+BZ0lG7B8Iw8k8vNkIwjcT3uQvZrrvqW
	Kk7ieW++r2dyZmq3UG5ne/ktWTAdh5UjP9+wnN45NfGjMn4chEQeBN0RIcM4b0b/tcz2iVAvPoX
	cH2Q7uHu/7HVjsAXowfvwMd+PN4Eswa1E4wFqiIiWgbiQ9n1gDz0M7/O37BPngUsmv36F+cMBJy
	BcOtbL0QomjMInCsb7bSQ4z7danoyStq4qzO5XFTUCM6Q93uaglO0bQMRrwyqZ0UQnzHvVFpcQp
	kB7g+3LZvXj2w5kYvZY4oAE1mzWkqn51QhGM0cqyMufme3FRq05hFGDqfpZFd3LmRPLzTfAw7t7
	Y/iXYKswjxkrPyHFkKqut0TUP+opTZekZsGjeMK4M/hpj7gTos1hEbDkNTAGbgTwauqODgs0rJd
	V3hEBpQHvIqNmTHGMS60dtjxka5rnRr9U/Swhp90QTMLVTPXgrKyw5wUW6Ny6yBj8o+8uIyVLTc
	tvxM
X-Received: by 2002:a17:90b:2d81:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-3a0bb552feamr10274508a91.9.1790662306492;
        Mon, 28 Sep 2026 23:11:46 -0700 (PDT)
Received: from localhost ([153.61.198.244])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4985fb0b3sm3308212a91.10.2026.09.28.23.11.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Sep 2026 23:11:44 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Tue, 29 Sep 2026 06:11:43 +0000
Message-Id: <DLRKT5MG6W2P.2V1P0QD4GQEKY@gmail.com>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, <bpf@vger.kernel.org>,
 <kernel-team@fb.com>, "Tejun Heo" <tj@kernel.org>
Subject: Re: [PATCH dwarves 1/2] dwarf_loader: Trust the entry value
 register over the first location entry
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, "Alan Maguire"
 <alan.maguire@oracle.com>, "Arnaldo Carvalho de Melo"
 <arnaldo.melo@gmail.com>, <dwarves@vger.kernel.org>
In-Reply-To: <e3f30691-a5d8-41b8-a075-10cf8cf4bd95@linux.dev>
References: <20260925213619.2187751-1-yonghong.song@linux.dev> <DLP2WZASF7LP.18SWCONJDR4LV@gmail.com> <e3f30691-a5d8-41b8-a075-10cf8cf4bd95@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sat, Sep 26, 2026 at 10:49 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> Maybe we need to poke into locations to get precise parameter register.
> For example, for argument 'b', we have
> 	[0x0000000000000000, 0x0000000000000000): DW_OP_reg4 RSI
> 	...
> 	[0x0000000000000008, 0x0000000000000015): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
> RSI has location starts from 0x0, RDI starts from 0x8 although it has DW_OP_entry_value.
>
> But this makes things complicated, and there is no garantee across different compilers due to
> code gen.

I don't think it has to be complicated.
In your gcc 14 dump the first entry of 'b' starts at low_pc and it's RSI.
In scx_bpf_task_set_lazy_resched() low_pc is ...d70 and the first entry
of 'lazy' starts at ...d8b. RBP there says nothing about the register
'lazy' was passed in.
parameter__decode_location() already has 'start' of every entry.
Can it take the register of the first entry only when that entry
starts at low_pc and use the entry value otherwise?

There is no guarantee, right, but when the guess is wrong the function
is dropped. It's not encoded with a wrong signature.

> One possible workaround is change 'lazy' type from 'bool' to say 'int'.
> As Alexei mentioned in the above, clang didn't handle 'bool' well
> in debug info.

That works for this kfunc and for pahole that is already released,
but every other function with a bool arg is still dropped.
Can clang be fixed to keep the entry range?
