Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360534D3B0
	for <bpf@vger.kernel.org>; Fri, 16 Oct 2026 02:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116762; cv=none; b=sgIhkf15lWd6wogUHT7Gd7VXjbIB489azKuo+1HOHDSOISMiLTgy5MYqCQMnaOyMgW3iAIXUrvsiJNgIpSFMs2eekaTTsj83KGMfqWhoPVxkJbq573pMfx1SgScCAQURpBhD7NaNo8WxikJy3eA2cEcutqMZpGeUL7PCsRolPKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116762; c=relaxed/simple;
	bh=dBvwVO4ackLCLCxKZbUlFj+08D8GjgWMgNNWIi+NiB4=;
	h=Content-Type:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:
	 References:MIME-Version; b=ncZGQ2ocCvnDpW1YuDZYE9g/J2XLiaQkq/8QLx/KpExfW4MJpBJCKe3S8GASj8E09EflTfPEYAVd57Di88bTGZdc3KJewYL1GQ3YoD1b61/OyZBAyZRZ4FyPHcoOOo4pbB1gHDVRC1nmqHeU4fQpaK+0oDJ3ZX0pJKjS/95MGfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QX7GhEsu; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QX7GhEsu"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e901e114fdso25764465ad.2
        for <bpf@vger.kernel.org>; Thu, 15 Oct 2026 19:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792116761; x=1792721561; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SAV9AIYPkjHseS+zBUGJlwhUSVxUufsLG2L3xvTTNVA=;
        b=QX7GhEsum9c5cIS5c2lqRiL48NLHPNPZYI7KHvyhjBIvU4klDR3Hxr2Zy/t24KNiP2
         J1B0cp+03CV8X9j8M6xEgm4/a92w3KiIm0CjKYuR2nUgAsGAXJSXsdV0IfpGf7fSOiwL
         LbpgW5k3ETe0wZcQBKsyzdxtfhBjhUh28wmMtpMjZTXcqSpUSnfIFFPyCcAcRhSuk5xF
         8Eo2NfJ4k9Tt0yo6KIA/92F4pbxZrvXTYCxBA7KQPuAyHuDCSuAmPjUdFuoQzJ4Y5g84
         nRCnrFZ9AS/hW6bxfovlRnbN+ok/LVrhvyRQJzov/Bn6w3g0rqr8IShaYIWqxCfIskwX
         IFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792116761; x=1792721561;
        h=mime-version:content-transfer-encoding:references:in-reply-to:from
         :subject:cc:to:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SAV9AIYPkjHseS+zBUGJlwhUSVxUufsLG2L3xvTTNVA=;
        b=1BZi9KvCI1eGAfNOUJkpw8FKNXGN6jN/FjW2BrkD058/6xdHc/JlgZ7QUJX52o3979
         UcMjvY1UAF1aRfGpAFMDh9aMeMPHAdKnEwIwPfV1Z+nzjAMajNzzThvcnwU7m0OqyxX8
         6o9KlHpKLfrbuDwuhvgVkFTgeodAzAyBwAoGKj86THKRCpr8orcAFfbV/LgxxJdtvRvY
         MzaEdkut9g0F/oyxJwZJnaZKP5+sI/HIgDbnQYw5yVeuDH4bZzINUwYJXv+4RZ6vyzMl
         uPNh0NBumn5QoWCdOZW6CgfvKc6xR+SfKNp0TchXS0t8zzrHVUq1aEimXGGqNXpj2++P
         05DQ==
X-Forwarded-Encrypted: i=1; AKwUvBzjIYAfqGW6KLE8B3ObZupLtk7+jedV6plJAidrLGI42qEmjxDCB6OBp0lX8cQG3Il/FXk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQLuG3w7DmEvGfY2Vy6H27lhrJyX7y+hkiSPC30xt+Om3kSzyM
	D0jh2a8RIeKdwnePJIxhXWe4LuT+s5bJPk15n+q8P/rvV6/c5c2IbIfJ
X-Gm-Gg: AYBFou2E78VWBcCbcU/sSrslv0CCHOU5kkdXaxPMR9suZ71uE0BO7M8bWUQKK5e5STX
	/Pvken3mrr8r1T34nyQy8/6TE3vobyVhxUIHBrVRs5Ua4wfcH0AyWQmJbvrGVk9nUNuT5e2g6FR
	EK6cVhkv8QlXAcAmWfh3MnUtmD7ZIMKKLW/rPCcurt03MMoN3bapGAXc5fZs9Iv1uOv6sYGN+oX
	d0v/zikPJViD4bvNvzbFb/xJdJVXxsz8CQhfgKaCUquI6dvR5IhsKRFq1pbyeHjMGznBwiQaIJb
	JrUndQ35emrTQUQmeamyI/KE7yPFH2dru+i4ZBwMbkbO1hHNn/MJu6plP1auVK6sleBMBcj9i6r
	D+2S7Eac8CXvo9iR3lW/0CPXM/sIy0Z6czGysxr27kgV0GCvtD11fEWN2SyTRJ+nX4b8jq3bqCG
	LtdnPKpC1d0osvbcEm1pP+lxnNlhw0QgdEzbXUEMYmtUX5BjQmGmj8wMkA2zSl7yJmeVkVIRleY
	h6fmrQj2+NESqaq5jaX6s3zaXNM6rQzYrxgmpgwL/gpAzaOSyo6TfGZTSK5msLkm2sqT7HPzU2/
	eak=
X-Received: by 2002:a17:903:41cb:b0:2e9:66c4:1711 with SMTP id d9443c01a7336-2e966c417f1mr31710645ad.52.1792116760965;
        Thu, 15 Oct 2026 19:12:40 -0700 (PDT)
Received: from localhost ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e878bf6sm3044545ad.57.2026.10.15.19.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 19:12:40 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 Oct 2026 02:12:39 +0000
Message-Id: <DM5WDDT1HM2C.BQULK4DXMUU2@gmail.com>
To: "Yonghong Song" <yonghong.song@linux.dev>, <bpf@vger.kernel.org>
Cc: "Andrii Nakryiko" <andrii@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Eduard Zingerman" <eddyz87@gmail.com>,
 <kernel-team@fb.com>
Subject: Re: [PATCH bpf-next v11 13/26] bpf: Allow a subprog to end with a
 call that does not return
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
In-Reply-To: <20261015040250.860960-1-yonghong.song@linux.dev>
References: <20261015040143.854070-1-yonghong.song@linux.dev> <20261015040250.860960-1-yonghong.song@linux.dev>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, Oct 14, 2026 at 09:02 PM Yonghong Song <yonghong.song@linux.dev> wrote:
> Let a call to a subprog or to a kfunc be the last insn of a subprog, and
> give it no fall-through edge in the CFG walk or in bpf_insn_successors().

[...]

>  include/linux/bpf_verifier.h | 10 +++++
>  kernel/bpf/backtrack.c       |  6 ++-
>  kernel/bpf/cfg.c             |  5 +++
>  kernel/bpf/liveness.c        |  9 ++---
>  kernel/bpf/verifier.c        | 74 ++++++++++++++++++++++++++++++------
>  5 files changed, 85 insertions(+), 19 deletions(-)

This is quite heavy.
keep_subprog_exits() in the previous patch adds 'exit' after the last
insn with bpf_patch_insn_data().
Can we do the same for a subprog that ends with a call
before bpf_check_cfg() ?
Then cfg, liveness, backtracking, fastcall and prepare_func_exit()
don't need to know about it. Only the check_subprogs() hunk stays.

