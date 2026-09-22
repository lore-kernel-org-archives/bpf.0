Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38AD4D7D46
	for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 09:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790067836; cv=none; b=O8BWM0a2ej0o3sQlw0UpL8HaHBaU1CSupx4/fHSpnYXAGzZTzJ1Z4sBiaA14SfPwhXy+x8uJzEOsO3oW+QborFdlRGJv6tlI9X+8w8U1Coob6IUms+WUUZvY48m13Yc45W2eot7d67r4fhtESFQNt7kXMyoqAkirfS2ss0WTgEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790067836; c=relaxed/simple;
	bh=VTfd+kx4IzMN4HwWKAFk70C0fOTr88FdJxqeHWCpGr0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyYtt8ql2sbDhDXMh6xREkyLDeIkgpTs7cee6fT43VJjR2HViTmCUUkrSSYkavQbaKPNoYqD1t+yf+lZF64ckNjMYs53t/zJM8hCCZvDCWAqGpSlL9K0+/IP9CSmTyLhGVF2De9Fn7GIDWeARwonZeww/Y12lGnkE9kD8GkzCjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm1bRRHs; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm1bRRHs"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-4885a1480a2so1049704f8f.3
        for <bpf@vger.kernel.org>; Tue, 22 Sep 2026 02:03:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790067833; x=1790672633; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hBmqSfthoDkMfU3pfMgMsdFTjh/btwHVLwZmR3sypjM=;
        b=jm1bRRHsT98+lIiHTAmpF08989N4++WC+xUV1gRF28bGPVJ8MW6u7k9GqKizMK4utI
         OtRt339ZNJdyhBR6mwWhDpJFJpT2BOlbiXWxqjPvi4hkvOgf0h4Zowi/UyhoQt3/zRQc
         kvCVLazwg9/m4lcx71bK6aJJTxg8z9SYj4UJzXIoFycQMOwRytFZd1CWgAqCcFPkQedk
         hQaKq580USnnBWlba0Z989PefR+/SPPvxu8i5v6q8zDjAfwVsNgdtMmNbJZLW/EBXiws
         vvbDNUpVaLD5mGKuu6TdUw3If5PaQdDSmr9sgyLC9MpDXhCERPN98lRNk3Iao8s04AKH
         Tubw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790067833; x=1790672633;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hBmqSfthoDkMfU3pfMgMsdFTjh/btwHVLwZmR3sypjM=;
        b=CPwbcmJ1P+LsWFsfIoc2BXPj3HUvkgwehDQ9Ed/oclh1dzP/3dHfgxBTH8Pb/yjh8f
         OD2l2SrmIeU2Qij5AQ08Ab+LFZjTocDCy93+FuCALhMk+IIGab8ejH9DsszjfxiixJqj
         dVP7iBzQUfCm55XgEwE8gV8NzPEmSGPWTfTtYzflsAcMslh+aWW2LGAVjYH0qbZePIEV
         sq8hMHqmsGIJtVpEPDh5Cl8kCt3rGmqlvFgxX3rNYz+tNXzbsJPm9GP25qFGRRQQuGaO
         oqxSikSIZoShvEiC5Tmh+c08znjqaM/FwFb3TEOO2bGpBCP3sI+YGIEpwil4jkIsgIKf
         WPdw==
X-Forwarded-Encrypted: i=1; AKwUvBwd/NOAWkpV7vaydjRFC8NUpSI6bT9UYWrNnu8TSOMAuH9MWN5waT+EXMl77nx2mlOSHjE=@vger.kernel.org
X-Gm-Message-State: AFuF++kIKGvPZm48QfcVfW/9/hPfTTEg67/J2vVLKjdyb9uBMh3RYSzF
	xiScJb5kNbnQ4341f5IIcSetuCxqlT/IsYGYhgn/d/y0xZeTEXecnjKJ
X-Gm-Gg: AYBFou3jbIKggFtyPaSY6CeLD3qtPg9qn8D2FcxkGKO9WuqdmiH7V1Xr8i6uoTi3WbL
	TsGmCSMd0/sePmWUiFFc2jFs8c3tBwdWQDDntrQ7qadqdByRLHhKFxl5qo8xwfKkk+OCfvkYTJb
	gmPqcpwkdqw0jZOvIZ1KvScO2BHYDXqWZ17JYlJgOKul4MkVNZX6YpIvJyBEz5Hm9q7keOwIGyg
	ipaZGx+0lzX9NPwPUzvD+57TtjfN8i3PvUA4bvuE3TC81wDbTIozXpjxqV243pVV40qhnzs4nj0
	TaZ4oJMBlBveUraxHzMqZRVQuGJmgkyoqO3Ps7C5qgCgoTrnx/SyniYtPqwUpDjhKzNX+o+tY/l
	q7bsq1x1wcp4UQcsViYxVR2cWefUcdyaXOy7x0bIG2XaYQHGgM65Pxui/dRkD7vRSLsP2zGhl+g
	0anLS1viagL3hKobufR3sRvrDIlZEaoKBj93z0VQsGPGJzHfV58ej23KsOndsv3S91b6BaUHvU0
	sV9dv6CTbU5jSmd8aV2NHTyU9V+rD05GoM=
X-Received: by 2002:a05:600c:310d:b0:49d:15b9:2a2a with SMTP id 5b1f17b1804b1-49fc5721b9dmr200390075e9.10.1790067832375;
        Tue, 22 Sep 2026 02:03:52 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fdaaf0074sm34525095e9.3.2026.09.22.02.03.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 02:03:52 -0700 (PDT)
Date: Tue, 22 Sep 2026 10:03:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Jim Cromie <jim.cromie@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes
 <ljs@kernel.org>, Kees Cook <kees@kernel.org>, Masahiro Yamada
 <masahiroy@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 3/3] kallsyms: Match compressed tokens on the fly
 during binary search
Message-ID: <20260922100351.04555f43@pumpkin>
In-Reply-To: <20260922-ksyms-tune-v2-3-a333ee31eac7@gmail.com>
References: <20260922-ksyms-tune-v2-0-a333ee31eac7@gmail.com>
	<20260922-ksyms-tune-v2-3-a333ee31eac7@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Sep 2026 01:19:21 -0600
Jim Cromie <jim.cromie@gmail.com> wrote:

> kallsyms_lookup_names() runs a binary search across kallsyms_names[],
> a packed array of ~130k encoded kernel symbols.  For each of the ~17
> comparisons in the search, it currently decompresses the candidate
> symbol into a temporary buffer on the stack before calling strcmp().
> 
> Comparing raw tokens directly in compressed space is impossible.  The
> BPE token table assigns values by frequency, not alphabetical order
> (e.g. token 0x05 might expand to "zebra" while 0x42 expands to "apple"),
> so comparing raw token values scrambles lexicographical order.
> 
> However, full string expansion is equally wasteful: roughly 16 of the
> 17 binary search steps fail within the first two characters.
> 
> Introduce kallsyms_strcmp_symbol() to compare ASCII queries against
> compressed tokens on the fly.  It walks kallsyms_token_index and
> kallsyms_token_table incrementally, matching characters directly and
> bailing out on the first character mismatch without expanding subsequent
> tokens.
> 
> This optimization:
> 
> 0. Avoids decompressing non-matching tokens, short-circuiting ~94% of
>    binary search character expansions without adding any tables in
>    .rodata.
> 
> 1. Drops the 512-byte namebuf buffer from the kernel stack in
>    kallsyms_lookup_names().
> 
> 2. Leaves sequential address ordering and kallsyms_expand_symbol()
>    streaming invariants intact for /proc/kallsyms and table walks.
> 
> Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
...
> +/*
> + * Compare an uncompressed ASCII string against a compressed symbol table entry.
> + * Returns negative if name < sym, positive if name > sym, 0 if equal.
> + * Exits immediately on the first mismatched character without decompressing
> + * the rest of the symbol name.
> + */
> +static int kallsyms_strcmp_symbol(unsigned int off, const char *name)
> +{
> +	int skipped_first = 0;
> +	const char *tptr;
> +	unsigned int len;
> +	const u8 *data = get_symbol_data(off, &len);
> +
> +	while (len) {
> +		tptr = &kallsyms_token_table[kallsyms_token_index[*data]];
> +		data++;
> +		len--;
> +
> +		while (*tptr) {
> +			if (skipped_first) {
> +				int diff = (unsigned char)*name - (unsigned char)*tptr;
> +
> +				if (diff != 0)
> +					return diff;
> +				name++;
> +			} else {
> +				skipped_first = 1;
> +			}
> +			tptr++;
> +		}
> +	}
> +
> +	return (unsigned char)*name - '\0';
> +}

Since len can't be zero you can move the test to the bottom and remove the
skipped_first test completely. Something like:

	tptr = &kallsyms_token_table[kallsyms_token_index[*data++]] + 1;
	for (;;) {
		do {
			int diff = (unsigned char)*name++ - (unsigned char)*tptr++;
			if (diff)
				return diff;
		} while (*tptr);
		if (!--len)
			break;
		tptr = &kallsyms_token_table[kallsyms_token_index[*data++]];
	}
	return (unsigned char)*name;

Also 'char' is now 'unsigned char' in all kernel builds you don't
need the casts.
But I'd make the types explicitly 'unsigned char' just in case.

David 
		

>  
>  /*
>   * Find the offset on the compressed stream given an index in the
...
