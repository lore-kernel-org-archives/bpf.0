Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3E3515F2
	for <bpf@vger.kernel.org>; Sat,  3 Oct 2026 06:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791009146; cv=none; b=dxK0MinKYtCAQ5rq7gZLERdSEqJyjZynEC1mLggWcmHah5G0rtfYqyQ1Id8PqgpxfWRlVtjpQcJJrVMk43E+JyofHQd9WTPDLvujrV3dhxQszpgCMgjrGh0Vhd8utxKJyvTYTNTajQwil5PXxJmoRehZSfqjWmUFZfwRc58PtmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791009146; c=relaxed/simple;
	bh=VuiMGsvrxoxHYIMjTtEAMKJLNMC58E+oDp1FFjB26XU=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=dyAB5+YPK9KLyhRkb6RY1+RHqA57NSetwksESYDkKQb3An4hlxWwKkG0lCvGJqXXedQyycbWBFCQ9fYpVc7QjQdFjw70uUWDCdVLdarTPHdmrAWRmmCQuowcW6A/bkSnuScafSRYsKO4HdeE6sc5+6JuQpcViBmwdlHtOOe6OO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DL3guCmC; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DL3guCmC"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc797656e44so44314a12.2
        for <bpf@vger.kernel.org>; Fri, 02 Oct 2026 23:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791009144; x=1791613944; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vr5KVZoPR0cul9dM0w9bT4mgxCHNEHDqUMfTuf7KfX8=;
        b=DL3guCmCAoGGad5fqQhT+5W2N60ezuvD94VtFpob8EDuN/9oZNMQlKHDpKAkIFeIqv
         cOYuDc2THo5GGGolhJh0u08uEpd/a0aW2pVhSbGM+DGfgBTDKm22DxkQ6LX2FkKiM7yS
         jJV/jTe/NGZqAqIfD6TfS+NvtBajMlBp4v/HObTFUIzWKLyviiMPwG3ZAouqLj26zAwG
         ZcJjzfa+1isefTBiR26J43dKgCqETQBDF8CPhVZde99KZyOFaecA23+M4lrbFKXIXN/C
         dkTOqRKnWejNq/nzi8KHvYZV7R7OXmRw9eMk5898z5VOh6iUMuXoiZABMloEUTphOZXz
         PHIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791009144; x=1791613944;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vr5KVZoPR0cul9dM0w9bT4mgxCHNEHDqUMfTuf7KfX8=;
        b=u/hkCxfrPRZb9cQ0gxThVXONfYrpE1OUDJjKKkml5TKuYr8aDiSdWgGuwq0ClJRLuD
         MIv5Nzd9d02o24drDGYSRwe5uaByGZJLB3oC0QHKGpdmFJgiWQ2cBgt8TjpETpAb7G/T
         0Icl4L+QkV7kSowgx6sLL5T9D+BTwIqyhzgwl3eashWEnzHUcTrTYs+ablFpuo/m/i8c
         gl9ZSHRGK0fWN+qSTX86ivBqFicOB/oTsk0Uu4eEokH0bCHBZZoaJ7RYCzDLNIE2m5/m
         DI4tj/7ACN/h2nEM2nyPfoFsyMr1t1KF6dha2XUIfGHoos1EiERxEpyYj0zQuM5pu9gu
         Xxlg==
X-Forwarded-Encrypted: i=1; AKwUvBy0UyKkNeXesvfpuE6mcwurjRFpg31SNoJWgePTyzUTQzuI13IUTpbhiNGojEtdu/3D3oA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAdJXoX4p2TNGBGrHpTKLlKkTIxw3GM9RhwKn4v4P2gxDGnoRG
	IEMQBDtuoV1/QxqCs7JkaKnvjZO6yPzWjCdakSwRpG8+ppRDhMP/yR5x
X-Gm-Gg: AYBFou1LRL0NKWdb0jZ0m9Ay0EHFc6+uwXWyC/eJAsrVkIVXNSLsLsk8RZiibxh9HED
	iZxjcIxisCBEfPHhK+t/LoZYylqI6N5u/OLANLybMtWCBScQNQviNp69AwbefnAJPCl6r9OGAT2
	6CaSTEqe6nAs8a1D0Wys3pKf4oUus93evIzv+x0L9qp+zzDJVKUQOsSRtjRHSfokOEKqq9zt+Zh
	Ej6ZdwS7JtLtCYoL9JKLrGAvgvPVmgO5khFHPhaFu7auf50+6foffp5jpKhqOBQX0BE8J9CrAWb
	rVI1VqKIKpY3ErRZtADephsii6VSleZjMrMiEF+90CKxhmkPwliQWBN1U2LQjJp/9MfXpKwU7BO
	gsyXElp6LTbg1F+IgXGEKMsaEnKmBWPJ13MTKs6iCJ9Wf24rd+AKQjIkSnuIdQs85qvlvsG057z
	VGQsWipeu/8akJEfHLQWjO3Lyjw3aSkxwSNtnYKd85MDGL5vCWGEhC97EG/Mhqn0bycm9bDz8EC
	L5Dsbt85o/2KZk7RUR/swxj8cmBXNY1kIiY0Ti4754g0Uw/GFpbuf4YU061AAkxWgMQoMtkkA1t
	ym40EecY9a0fqA==
X-Received: by 2002:a17:90a:1650:b0:3a0:7261:d58e with SMTP id 98e67ed59e1d1-3a6e622a50cmr2049092a91.22.1791009143685;
        Fri, 02 Oct 2026 23:32:23 -0700 (PDT)
Received: from localhost ([153.61.198.249])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a78d6b5c3dsm1823004a91.13.2026.10.02.23.32.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 23:32:22 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Sat, 03 Oct 2026 06:32:21 +0000
Message-Id: <DLUZR540Z45R.3RTC4COS2IW2V@gmail.com>
Cc: "Jonathan Corbet" <corbet@lwn.net>, "Andrew Morton"
 <akpm@linux-foundation.org>, "David Gow" <david@davidgow.net>, "Petr
 Mladek" <pmladek@suse.com>, "Sergey Senozhatsky"
 <senozhatsky@chromium.org>, "Shuvam Pandey" <shuvampandey1@gmail.com>,
 "Steven Rostedt" <rostedt@goodmis.org>, =?utf-8?q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, "Andy Shevchenko"
 <andriy.shevchenko@linux.intel.com>, "Masami Hiramatsu"
 <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Jiri Kosina" <jikos@kernel.org>, "Daniel
 Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>,
 "Eduard Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "Christophe Leroy (CS GROUP)"
 <chleroy@kernel.org>, =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
 <u.kleine-koenig@baylibre.com>, "Madhavan Srinivasan"
 <maddy@linux.ibm.com>, "Michael Ellerman" <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, "Shivaprasad G Bhat" <sbhat@linux.ibm.com>,
 "Thorsten Blum" <blum@kernel.org>, "Alison Schofield"
 <alison.schofield@intel.com>, "Dave Jiang" <dave.jiang@intel.com>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Guangshuo Li"
 <lgs201920130244@gmail.com>, "Ira Weiny" <iweiny@kernel.org>,
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, "Vishal
 Verma" <vishal.l.verma@intel.com>, "Randy Dunlap" <rdunlap@infradead.org>,
 "Shuah Khan" <skhan@linuxfoundation.org>, <linux-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-security-module@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <nvdimm@lists.linux.dev>, <linux-doc@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH v4 00/11] seq_buf: Add seq_buf_strlen()
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: "Kees Cook" <kees@kernel.org>, "Bill Wendling" <morbo@google.com>
In-Reply-To: <20261003035906.too.263-kees@kernel.org>
References: <20261003035906.too.263-kees@kernel.org>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, Oct 02, 2026 at 08:59 PM Kees Cook <kees@kernel.org> wrote:
>   seq_buf: Add seq_buf_terminate()
>   bpf: Remove dead newline stripping from format_disasm_line()

For bpf bits:
Acked-by: Alexei Starovoitov <ast@kernel.org>
