Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795689925;
	b=swvZQPKZE2zbGW9U3QLl+PR3sgBtXaVC3yh70jbNIfeQucY8q1I5vclwaaDIFmSJ3jfm
	 Pqq6mEXlnQAohVBtSTpUL7DaUws5y51Mrx0JQfbLLBaTGm/KvxacQWstGMlb6NQIXewHC
	 Gbw1mwisHrXzsA32Qt1xsBrn3kg2k9FVdShXYZqly4Bh7Veebu/SQxuGRaG/FITSV0Avm
	 ccJ6N3lvaGKpr8TL3wmfYDc5MlraP9yWDDEH06JyAYTni3IpFURXQ1rbJEBh/AmwwwCAs
	 961P0S0FlLDoeq1Pik9AdlAatnvKmYo4RJaLH0zGOTjH86k2hORc9Pt4U/fY/edU/Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795689925;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Un6gMhy72C5GdMKpxarLNGYbqAQ9rBfW8csPHV3xsTs=;
	b=txtQ0mKayah1IDxPYCU9JvyqG7kyJDHYTI2CP1g9mIppe1kBwdgJYJjHvCWyG7Z6JdtU
	 N1IlZ7uNeqZ6R2OYiCqlDbaEAP3oyaR7pGc/j1TaBlqvadlduPna3Z6vVOxMOEgeq61eL
	 SWH3eVMoBwBDJMCeOGmgtDI6CeYOySeGOpJu+ixjllOqP48xC/YSGVLHgL+OTaxcyl+rg
	 GXZJu090I4sIZ0eVX5kXQ6LqVUMENLNf9XI7q5pzbVTLz74gkHdjuG43UrXo4T43vE1tW
	 ho6B/ewWvmC/i/zQ+SLf6rjj5+lWTR6udrJUyHntborCrXsHLnUuxFauoElZuoIBi/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b="fb/AnGuu";
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6B606A329
	for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 10:45:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEA6B606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=fb/AnGuu
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-492fcbfaa88so4535179f8f.3
        for <bpf@vger.kernel.org>; Thu, 26 Nov 2026 02:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795689923; x=1796294723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Un6gMhy72C5GdMKpxarLNGYbqAQ9rBfW8csPHV3xsTs=;
        b=fb/AnGuufRVSuumZI6EQLA6cj75+M3xYaDzd0Gy6RIfFD9vTufZ0ocvqMKbKkCMuJU
         HCBXLOxx8vgikybvFGaP8kOTEPC96KRwXnjjGdmpRLIAP3v7/cEX49ZmqXzavqZRuij3
         yAgWXhNLnFWVkhqNg9FhZPzLqKHj3vih4TQBrzWrYFpbfSQ4U8bI/qVviCwdNFG1GKRg
         Hxn6CMjZT5DpBlzV5e6WnYlgdhQXs2yNA/UJVS7jWkPiOHnO8ZNEWlUFaREDrgmI9OpC
         SZzobCPy89LxilfHUkDRa5QJboD//JYUx9AJLoSKPUrVgXCRpyowQ5xPdH3/qHs9I8jV
         3Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795689923; x=1796294723;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Un6gMhy72C5GdMKpxarLNGYbqAQ9rBfW8csPHV3xsTs=;
        b=kStQUMFUsVXTgMdThSTu8TYbI4R+kFWbYR7QwW6974GSof09BK6I0QbfCq9nj92xNI
         2TYDSrKOgHNZFGMGc33d6BEgtaGegzEzSfRLc3dNcrv/I3anjGLMOwkNgPxf5lDPnZ5k
         8beDXKfCrALsbeLoNlUC9IwewSFtxUqVOfZ7mG2fNoeMMWWafwzV70ICWl3QO99g+LT8
         PijbqBizrr5KwkLW1GLqp8fhyUQGf5TUjpTz6g/7luFishFWv9D1LtacIP3MxvpITk11
         sE9UphIwY9tmz8eqzXb+QbnAyNS0h9LfgmiALNOM0WbLMXwV3Dh1yXPEUleG5xGpXl8r
         1c1g==
X-Forwarded-Encrypted: i=1; AL+hErF9NJzWjFoweV2d+kWjQYX7Xd4s82cNbQ0xuRfVF1QUmkg6+Ojb8eBGMhIy2nCe5oO0E04=@vger.kernel.org
X-Gm-Message-State: APuU4Z9zAviO8JCSpgrgOsQxa/NRztG6IVjzE31b2wU9D0DSMTecyqir
	OJs12CAdl9OAnCe203B5CLfLxlsEqlRI4wqd+jqVn67I21Sk0sPDSvMvjddo6vOQOW4=
X-Gm-Gg: AZFdTZdy7mgQNa1giwlNugs33uwXvDuEVZ8HNmzaOv1JUI5Gi9EKzGG5YD12IGC3qlT
	3xF2aR2LsRmIBAECxKgkW/QQdvKgCFx1aYZjCYr5ZCrFmFgtYo0wiLaCItirSCyM1OB2Rf66NA7
	o3gMjOYlG/EL30q0u2JFxp10v0NYER+JNxLIQqhg6yZ6poo20KpeWPAymjRNmIdhTW2KlAD9TB9
	aYYEmxF/MFPvclx7xZl6apX5xdap+ay5Q3wymPQ0Q1qb+xJbjo9sDqoGyhZ9U8vykaexZ+JHer1
	i2UZsGJyeilLz59IcYxE4EAQyAzuSZ0PPFgfe/rXTMF+xHt3TtPXtP0Z5WTTgH+jkhUEmfuPBdQ
	VV3517D4/Cgt4peyKdvwrhkuajdVIMH6+8UAbg4Bnu/vJWxw7iCAKwbwKR5scLXyhoCDgKHPUQo
	S1z5smE3LLneXp9vIQf1fUF/wEmP50u+GCEaG2omgJ5PsSMVw14DXCRSKTlvl2/QLKyftIp1ySg
	S9uJgvWOBHOYDYJ2vk7k0d+Wr6t0J04/tne+7RJYf33SgK1FnhDIf3/SneHSX7zTC6nrZoCIYiN
	p3kHOS+6n6TCrO/XtTU9c48GAK6dBvJwX9AfSp/roO4dovlpYVdUrJK/YCxmAgrBfQ==
X-Received: by 2002:a05:6000:248a:b0:487:b50:101c with SMTP id ffacd0b85a97d-4abaa97702bmr38359967f8f.5.1795689923186;
        Thu, 26 Nov 2026 02:45:23 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6bb98b4dsm40416103f8f.53.2026.11.26.02.45.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Nov 2026 02:45:22 -0800 (PST)
Message-ID: <a40ad738-cb7b-469e-b67b-353b64622dbd@suse.com>
Date: Thu, 26 Nov 2026 11:45:21 +0100
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 3/9] kallsyms: Add KALLSYMS_QUERY_BY_NAME
 ioctl to /proc/kallsyms
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Luis Chamberlain <mcgrof@kernel.org>,
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>,
 Aaron Tomlin <atomlin@atomlin.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>,
 Jan Kara <jack@suse.cz>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>,
 David Laight <david.laight.linux@gmail.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-modules@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
References: <20261113221248.3535369-11-wusamuel@google.com>
 <20261113221248.3535369-14-wusamuel@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261113221248.3535369-14-wusamuel@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/26 11:12 PM, Samuel Wu wrote:
> To find a few kernel symbols, users such as libbpf parse all of
> /proc/kallsyms, which is several MB and text based.
> 
> Add the KALLSYMS_QUERY_BY_NAME ioctl. It finds a symbol by exact name or
> by prefix in the entries of /proc/kallsyms, with vmlinux matches first,
> and optionally in a single module with module_filter, or all modules by
> default. Each call returns one match and its position; pos + 1 continues
> the search, until -ENOENT. The output returns the address, the size, and
> optional name and module buffers. A buffer that is too small gives
> -ENAMETOOLONG and the required size.

The kallsyms data in the kernel can change between two
KALLSYMS_QUERY_BY_NAME calls, for instance, when a new module is loaded.
Should the mechanism provide a way to detect such changes, likely by
tracking and exposing some kind of generation number, or is it
unnecessary?

-- 
Thanks,
Petr
