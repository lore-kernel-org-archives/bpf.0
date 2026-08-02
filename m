Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8707D23393A
	for <bpf@vger.kernel.org>; Sun,  2 Aug 2026 23:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785713899; cv=none; b=Qtx5FnyP+ojBSrFh+zdJWVU8MEN7eOpey1ykQAnIJwgaL+9oyHli1N5mzIdELzMK+Ezt5skmk40HaZx97LEWs7c444mh9WYG7RfSfacVwbWyylopnK49titXeqlkWFns6xBiLQ7zQE1xpRtpkV2RRf1LnE/Fwi3RPMMFTF3bBOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785713899; c=relaxed/simple;
	bh=+C+wAbM1mITAmu2SoMdnGJhuiekScTlWDtdGlyj7mIk=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=jaVIolzLxCD/94BSnt6E/re0oGQ5bMm/Qx31i1Tk8uJALevKgtdWqCnhAXzeQq6zYS3JibrYFkWf6j96pMgn4TSTN/nkAYH4axKzUSKk6VBBwBUW/bfEN86nDT5mwKct7a+I9Ii0h67ttPrh0xcTkQ0Zwxo4DJ3neXLMy3X3cho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YYlbh9aG; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYlbh9aG"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9e7391839cso2453152a12.0
        for <bpf@vger.kernel.org>; Sun, 02 Aug 2026 16:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785713898; x=1786318698; darn=vger.kernel.org;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=wVC6ZNErkENuKY2q+iSkfidbrSUBAoqUgOYVFs+1qAw=;
        b=YYlbh9aG/5p3MO7w8lG5dTZWl3W20Mf3k8T6t6m62k2OuWpe6W5MWaiEAPN444ilhw
         DwxtTpNELhEb7CAdmXWh+v/ovdmQsnqjdnuZRf+J4zW9hU8/bdNerhldwOIK8llRaDuu
         YnSX7ko3jWJzNJ+KVOkhO73o1f1ZNv9Rke7/Koo5QfqBExT1LNfB0d9kSItbR3vrkoZ8
         oixPN1+dijiYV70x7fic4bMNp1iCtfNpr88Vd6ncX0aQ0KBHYmDAkq8lyGJNt2bP1yj5
         H8/vx5s6Ni2e+DOL23P11zGXrJzXZx2NkOOkAI2bQTS+yTVg4sStJsHW/897c4gssZnF
         q3Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785713898; x=1786318698;
        h=message-id:date:references:in-reply-to:cc:to:from:subject
         :content-transfer-encoding:content-type:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wVC6ZNErkENuKY2q+iSkfidbrSUBAoqUgOYVFs+1qAw=;
        b=axQm4F3brUuXDVh95MCUAOOrprc4E18l7uvowpYWFMX0aYePZzI6ZrLiEs8ffSNm2U
         NfPFVCgN96l2qLEcowEcZQNKZXSuKMQx4OdjdKAnVpn86cynTAr6WYpS/vmjFbpeg9s3
         ZN30y9ERIyBMhtlXVVdkKi0Yr6761nny6Cf2//neA0D9uwvTP4S/g0CRdTLz2Hvx1g8J
         CElQ0ueWsEld5xO6nP5kMvd86Z8GPwIBQU0WdV5ExSjnq1vmHHTxVKfAhlXXmm59bjww
         S5BvWHZqFpQyvrXitHys7Vu1BiqZr5XjMM7FkBE/mW/kslSyx8vpFlkbjPQ2L/6SNR2y
         vu7w==
X-Forwarded-Encrypted: i=1; AHgh+Rr/T4J2cCMp1TlPyA6u6xNdAoCr20Ck4QgVM60smx6XcmykNAP3fhYrK5RO82VqXWsW1lw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyP+PfyXbDsNFoTx72yMrQoOmHgGa3OAXS1JHlwZVwEGqWDEXym
	MBrgnJ7XLoMJaaexUXtoy/tMWflcG3+6c+7F2zl3dI9JcBzMePmpH26ZSkc7A+d9
X-Gm-Gg: AR+sD12IoAhV3K1vYTaDRQnLDNfMkai9AOk8JNGAdMz5/YGyJLyYnuvvKxKZcwR3gt7
	ygCmqyezXVGz69tstmyo6VgsVUrJffLMfWaHgtzxpke+GWEL56kAu8uPgc+jF9+fkGZbxVLKCR0
	3vg2fd599RDmyvvOzFlfIiTLtUTvqpcmzd9Rm0O9UvSJnHaGpCfn4yhsm3N+e4QVxxUTzH9HbEl
	WgMevn4B8YAyXvib0NctA1+7avDWpJ6EogPxSMmutEu31beOScloQQwzn+YmaJukj747oFr1QvI
	ceivdKz8wZQh5UV5YEvD3Vf8IwH+NuHSaOEbv3iG2Qw4ieTBUNywV28kssdiwAiIub4WfFK84ze
	O9l6A6SNl/Otc3cqZSjZVGhjA+DfrFyXfHlB4tE9YqtSf0y9iAQBBrF24StNX14ciOI2IJHTzXm
	D55VoKDL5mzYjMv9RhhB00UNtEeXTksvhGYsPz8N6hgOlwG2De7c6ZjsbdNTxm6meuEw==
X-Received: by 2002:a05:6a21:6b0f:b0:39c:126c:93b5 with SMTP id adf61e73a8af0-3c92a5d6d28mr7873983637.21.1785713897970;
        Sun, 02 Aug 2026 16:38:17 -0700 (PDT)
Received: from [127.0.0.2] ([73.222.46.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fab4e44bcsm35070094c88.12.2026.08.02.16.38.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 16:38:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/9] binfmt_misc: let a register string create an entry
 disabled
From: Farid Zakaria <farid.m.zakaria@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Kees Cook <kees@kernel.org>, linux-mm@kvack.org, 
 bpf@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, 
 Farid Zakaria <farid.m.zakaria@gmail.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
 jannh@google.com, mail@johnericson.me
In-Reply-To: <20260730-work-binfmt_misc-preopen-v1-1-4a0b0da71f16@kernel.org>
References: <20260730-work-binfmt_misc-preopen-v1-0-4a0b0da71f16@kernel.org>
 <20260730-work-binfmt_misc-preopen-v1-1-4a0b0da71f16@kernel.org>
Date: Sun, 02 Aug 2026 16:37:58 -0700
Message-Id: <178571387898.1880415.17662890925792360904.b4-review@b4>
X-Mailer: b4 0.15.2

On Thu, 30 Jul 2026 15:34:03 +0200, Christian Brauner <brauner@kernel.org> wrote:
> diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
> index 707f8a14f8a6..ca7840b01a2b 100644
> --- a/fs/binfmt_misc.c
> +++ b/fs/binfmt_misc.c
> @@ -75,6 +86,7 @@ static const struct binfmt_misc_flag misc_flags[] = {
>  	{ 'F', MISC_FMT_OPEN_FILE,	0,			"open interpreter file now"	},
>  	{ 'T', MISC_FMT_TRANSPARENT,	MISC_FMT_OPEN_BINARY,	"transparent"			},
>  	{ 'L', MISC_FMT_LOADER,		0,			"loader substitution"		},
> +	{ 'D', MISC_FMT_DISABLED,	0,			"register disabled"		},

AI brought up an interesting point that this now changes the set of
valid delimiters which you might want to call out in the commit message.

For instance 'DnameDMD0DmagicDDinterpD' was allowed before.
It might be a very obscure feature to pick a delimiter because
https://docs.kernel.org/admin-guide/binfmt-misc.html does not even
mention it beyond 'where you can choose the : upon your needs'.

-- 
Farid Zakaria <farid.m.zakaria@gmail.com>
