Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA74AEBF5
	for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 15:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790004318; cv=none; b=tZHqZfijXntWWd1LsoMndv/XtaJjWbx0pWWsDYH+xxuFjTW5H6mzzJ8oxYljo/8rK2pfhaTABgO1pmjuv0O768D2C7lWBBfZZgjyfckW94LTj7ji40t2UoodYDWHboTLM4EtI6GrxLb+1Dmn7JaLOWx8DxjT/4JJiKbbeJjvZmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790004318; c=relaxed/simple;
	bh=XIBUDzDIulK8h5ns2hWyPVLewhjCl1EzRllt9wV5v6k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hUXUNsDT6+787EuZmj+6igrgmG4laUzEBJYnp4pxYqDdmjPE5H0g4n5p/sLO2oOiIVl4REiSaF5L7MVtWEcbbGcdP0TZimlCXCTL+htucYFzU1jYSDzZDGyPfQe8cO4yGwzVW6R2DYFzpKZLsIANG3+ynZPeyc+5o4BnOh8Aekg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A/reSqlx; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/reSqlx"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49e6598dd44so16343515e9.1
        for <bpf@vger.kernel.org>; Mon, 21 Sep 2026 08:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790004314; x=1790609114; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RViz1WxJ34/nNwVSXOrenn9sMxmEANgxqa76nMh73Y0=;
        b=A/reSqlxe1kkP3VwmGYtGxefRVQFfooit5vdDpaweYW1kcXFO7JMTL53Cf8zPQMd/F
         TeEhQ80BfWpFfjzkivztTXlY7B4aldM/UaY2y525pTsXsx0qzrzJiXyYc6NHknIR4uwC
         /JjCUWp9gOPBB2JwtK0FyVCE0RYKN+9TXaaVVGjfr21FjOIZTVXut7Bvcar7Ej+WglRL
         Dib8KB7Bxvtd1h3tz5kvIlJEi/EiciuQ7NmYiA2gqOohyeDZ/RTo75zNerqqrMiAJFyh
         +JMx5wBOCW6WQYBs5TnWexMZ9qJvZEJ4iKqBEXiTCt0qfg902k2TURccbUF+5jqE6Njz
         QDZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790004314; x=1790609114;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RViz1WxJ34/nNwVSXOrenn9sMxmEANgxqa76nMh73Y0=;
        b=kSjUbxhL/IuA/Fv9jgo398jOOl9vMKGUtl2ToWQN3Q/1JzGfPY/+N2dJIguhMUWYg3
         PskpH6cro6EX5K5D7jxGBXP+Zc26S5HuQdTJCJBpzvEWoGNmVerUiXYD01aqBI4cyFvl
         7GMoNVZW/5s38jFMucNdZ07l3ckRFeFGOksSioE9hk1blQppbl46qsFoYcjhjJdTSLn9
         hfMyulZ9RHOXGyxGFwt4ZIPZa/v/lh2I29Ba0RcaDjPdzX0RgtAiVdiOTHqealFeRZEn
         OMXAxLqi7ERA77CrgZKwuMKRATevzag87x2eh9P2aEFcTdY67qvf/VZTryhID9zhc8o1
         kJNw==
X-Forwarded-Encrypted: i=1; AKwUvBzBvmXkExba357YkemsMfNkpXUwP/X8fAFmJ18qOdDWfnRHkIv9MXMExYTPcrFY7QPFTB4=@vger.kernel.org
X-Gm-Message-State: AFuF++n2rpTCmMR17ci0cCArRD+x/hcwr7Rq/7K2myGab8UvHkUH1YuY
	5oC+Qtsw19Rrjk/z5ymVp6ZXM/50jmCkttBD9PVcf9iXWbeUdEIQTyILZqxQa31Q
X-Gm-Gg: AYBFou1RqEtlbf5sW02Ji71lcF1JwY3M0+OvfN95fP0ax5foOGUNYOPYXulJo4vVQD+
	8sXVc25rouE0Nd5ZeBuTWSinE6CNMuPebHoc5r7gyafSvEu97gO0CedzrSuPjeUstQdGpuQsXLK
	qlf4rotcsurttEUw1EsAlex3ukoDhr+yZDBUU8eJ+juZBlBXbJ5NBRsiVpOQ/kYmBbgMw4+fCKj
	zx3dIh/hkRsd/ad6dP4WAhTCPTiYYHKxXDuBs7cBH2tY59WjJ45BI1JHOawF2ru5OYeod666Jw/
	rxFOm48BJmTEbho5s95nzBybEGc96J3fjnb9XwBeufx7TQYV4rW59kozirGqhgyLgNKPo1QL6Ln
	77WuGIv96NJ+LlOhgcB+Fo/uPtbsb4PffFVH3MCVq+4aIfQ8UP8GEpe005jb+wPaWSt43qGJwmW
	ffigfOs2pyEPVYLNdAnSCSI5BdXnmNTeE8opSzr2Cimn+ZHkU3yYaroRIhtTSPcVDzn8MsEItV5
	WY23YDUGOsKKq5MyI+sBj04IjPLlw5+hMIl
X-Received: by 2002:a05:600c:35c9:b0:49f:bcce:13f5 with SMTP id 5b1f17b1804b1-49fc5736229mr180188565e9.24.1790004314350;
        Mon, 21 Sep 2026 08:25:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fc56eff84sm256455815e9.1.2026.09.21.08.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 08:25:13 -0700 (PDT)
Date: Mon, 21 Sep 2026 16:25:11 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes
 <ljs@kernel.org>, Kees Cook <kees@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH 2/3] kallsyms: Add 3-byte index into compressed symbols
 to replace marker scans
Message-ID: <20260921162511.233196a5@pumpkin>
In-Reply-To: <20260919-ksyms-tune-v1-2-d85c97da1a32@gmail.com>
References: <20260919-ksyms-tune-v1-0-d85c97da1a32@gmail.com>
	<20260919-ksyms-tune-v1-2-d85c97da1a32@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 19 Sep 2026 21:58:56 -0600
Jim Cromie <jim.cromie@gmail.com> wrote:

> From: Jim Cromie <jim.cromie@gmail.com>
> To: Andrew Morton <akpm@linux-foundation.org>
> Cc: Lorenzo Stoakes <ljs@kernel.org>, Kees Cook <kees@kernel.org>,   Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,   linux-kbuild@vger.kernel.org, bpf@vger.kernel.org,   Jim Cromie <jim.cromie@gmail.com>
> Subject: [PATCH 2/3] kallsyms: Add 3-byte index into compressed symbols to  replace marker scans
> Date: Sat, 19 Sep 2026 21:58:56 -0600
> 
> The compressed symbol table (kallsyms_names) packs ~130k kernel symbol
> names, in address order, into variable-length records with format
> [<len>][<tokenized-strings-wo-\0>].
> 
> This layout optimizes address-to-name mapping, but name-to-address
> lookups require a linear scan.  To accelerate lookups, kallsyms_markers
> was added to record the offset of every 256th entry, cutting the
> worst-case walk from 130k to ~128 hops on average.  However, this
> still leaves substantial work: during a 17-step binary search in
> kallsyms_lookup_names(), the marker walk repeats at every step
> (17 * 128), decoding ~2,176 record length headers per lookup.
> Address-to-name resolution (sprint_symbol) pays the same 0..255 hop
> penalty on every call.
> 
> Introduce kallsyms_names_offsets, a 3-byte-per-symbol direct index into
> the compressed kallsyms_names table.  scripts/kallsyms.c emits this
> table at build-time while writing kallsyms_names, capturing the exact
> byte offset for each symbol.  Using 24 bits covers up to 16 MiB of
> compressed symbol names, easily spanning the ~2.3 MiB table while
> saving 25% space compared to u32 entries.
> 
> With kallsyms_names_offsets:
> 
> 0. get_symbol_offset() performs an O(1) 3-byte table lookup, eliminating
>    the ~2,176 header scans per name search.
> 
> 1. Drop the legacy kallsyms_markers table, saving ~2 KiB of .rodata.
> 
> 2. Unroll the shift loop in get_symbol_seq() to match
>    get_symbol_offset() as a direct 3-byte big-endian load.

Why big-endian?
Most cpu are little endian, gcc 16 and clang 10 will replace two of
the 8bit loads with a 16bit one.

I'd also comment that the overhead is 3 bytes/symbol - with a note
about the average symbol size (excluding rust).
The +573kB sounds like a lot - but isn't that much compared to the
size of the table.

You should only need half the table.
The only odd index you need to check is the last one, and you'll have
just read the symbol below it.

David
