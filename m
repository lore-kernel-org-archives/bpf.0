Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795625141;
	b=0png7wEbBV06OB4ZiJzuYKq6E4DCTturezW2IRW9HN+3Ontf4JQsWEyK9ELgpt/g0cbe
	 pDQ/qOOeAikk4c53p7EcXplz9+7u7CBmxaZeR4JFDRzuELw/eR0GS48Kvumal3xoOgaGO
	 njkp4fE3A6PgXjIiBFDcJuFS/dUYkrevvSK+3m4H8L+O/iUJ7SuZF4oHp3qO/IAUBzFyz
	 WVC/mHDVGerfiBZHWtvjx1zm7C4D79m1i6bfoXDwrh2XEmnvSPBv5g1xsBnOur45OyZc8
	 y50q46tMUINVUrPtco9hgv9l0rY2IH4iVhC2HCJsRJ1JQQXILi/Id84nRxP7yxX0bYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795625141;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=qzSNzkmnLjAnm2o7UEPNC82u2CvWGqHDymHqRLR8nws=;
	b=UYefFA0GV1Cx0mnF41lSnFDwOtzb522ea2+OYItY2k0Y13mQZDTTXUpmwcB/yzxSbkje
	 kb2YOnmxyyykmoe2N4BdRZ08N8GQQmMFptVAOo3rknRsqNwv3kBw2/SH0rrU88TRKgFZ+
	 v1dLGQvO2PUvwBrCcK3/efsDBcbRD6gp2wtFai0OfwSokGtZvpYQhWpXUA7fDzxC4tQmu
	 5tiA9+RgS/kPFB+SoJYKsmVwnpeS6prcO1jjBgUi/In9OAuhH/ab6JLA5s5ZHmQaWAmzA
	 Vehrb9DtxcyVTY2lFE8Q6zR/ECD+ZPreYornVPW8Jm2rq6IZYzsWs51aA7Ev3Ls72KQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.com;
	spf=pass smtp.mailfrom=suse.com;
	dkim=pass header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VeMZMFlK;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A943606A680
	for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 16:45:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A943606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=VeMZMFlK
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-491971ac844so5413996f8f.2
        for <bpf@vger.kernel.org>; Wed, 25 Nov 2026 08:45:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1795625138; x=1796229938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qzSNzkmnLjAnm2o7UEPNC82u2CvWGqHDymHqRLR8nws=;
        b=VeMZMFlK4XeBzwrDD6z4Doe5ujZ5PmFlBvgdtXgvDNgqyB2+a2sCMN2wk+r327T/uW
         /r2BhYppBsmLCfA6wEf9rqAgdyevRRA01ag2IXLdtngT05rT8V5qUBbFQDnjjQgYE2gf
         VRO105Wv3wS0sYOzpdh62UmMxKFuJZsiAfPK9beaxT/i9ZUHpkfJOUrelw8QBpX9lGS4
         m35Q/nRZpkrOo84dL5yj6BJK1saMLREXy289b+W8lcU1Li54eo2LPH2XZ2BzxTKFv4V2
         TU/7Cyf6kqOyQ8kgJ2U5PgB/NbN2a8Bu0WSQShF93YOhfgaUMd2kQPQDvfuKKEMIIK8r
         gfQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795625138; x=1796229938;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qzSNzkmnLjAnm2o7UEPNC82u2CvWGqHDymHqRLR8nws=;
        b=M+YIxP2QAkHoUuu3qFxf3kInMratnGfJGPWMrlholMBSYt2SmGkYU+J1IPKTlw1Wub
         I2lyeqmyLb8388/45YKq79ZK5LsaGAS/40QSnWJZyY+2mwOfV5sR2wOmdzACLhYFUs0G
         7MvjKe+RVeKPLIHP2kisNihimjefBfjDejFPgltrHz725eF8oyJKPD6vvBh+9Ok6XEgK
         D8BNx5un7X8Cwez8+8TEq/bpPz19u3QtGFalMWn+0tFoWsqN+hv4YL+xHSXm7EaWpMPc
         iuc4CkfGz1Ot4voXyaReYl6t0qnqovN/ajs3t11vYzkzrD4nQV8iPvltgpK/NffA/tht
         Kp5w==
X-Forwarded-Encrypted: i=1; AL+hErET64m40IQg8qXCUhgXAwZYUkCPLJWthwgYYtEcuehC2Jbh+07FZLkNp2RiAipB4qFnzBM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/h6TFQN7mIqLxOnnG4pVDZ40+vYFCafGVDGX+sMdUynQspd+qw
	anQKOMBGTU7rC1QLD8t7Vw8Euccmpc6nzAVA20meBTmiRsvcimDHlyrxXGYnVk7U6BY=
X-Gm-Gg: AZFdTZdTE3K/1sbTWqiJ9pnYKoMRtAWExOc9BzPFeyXL4/rKAPQSyW6qCJ7ap0nHYGA
	NSQAc7FBLFRlHV88x5PaUZuCfdBB4LPgdU92E75s8D+kckzcdYSD4CJP9jt/+Xlq76i3aLY1R7B
	/IVrTbSUptFXDLo7ve3bc4qmI4VVps7HBYS+N/5FyPPOlF7DTBuUXZxqr6nBye8Qd1iIguPI86i
	p49jR7+jcKHPvQu5q7Emv9KcdSonAl4mqyDMH9PW9FJCDCOyLQRdCCwM355/KVxtUYMGT7kCufw
	LmB+dBIGLq4HtcF9een2EYMzm+RD+IUNpKBM+IL7jXJ09Ql//8GneUez1R+qiT97ELg6G/h7KwD
	yigpxNax/H0e749kCUeoizc2BmhIQbbeyJgz42p9HoeVJoVWTW5bnzWGD1l8qy1uZZ9YSFOpy1P
	yDXYjSX4ZZs75dUfvDOHoMyeNoJBofLcJL1FFblKXPtf/9vAyt4v6UWTe4AYKf+jF/81IPn7uz3
	sGSQTm2gNbGT8tcwRkSF55u+y9dBsGcdy5/OA9tWsMSk1EP5MBH9GQz6Va+Z9k6KMw0s7/8dl61
	q57DtE8HsG+cZTkwUtPRTJ+BfU/UAn53a+4GC/dETPyzPrg0gS853NlvyDr4lA7+8Q==
X-Received: by 2002:a05:6000:4617:b0:48d:f464:6989 with SMTP id ffacd0b85a97d-4abb18cbe2cmr35982135f8f.27.1795625138335;
        Wed, 25 Nov 2026 08:45:38 -0800 (PST)
Received: from ?IPV6:2a07:de40:8100:0:89a9:fd0e:583d:4a53? ([2001:af0:8000:1409:193:86:92:181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b110c50sm34852448f8f.37.2026.11.25.08.45.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Nov 2026 08:45:37 -0800 (PST)
Message-ID: <0c2e606e-e0b8-4466-b9dd-4db14cc35d1d@suse.com>
Date: Wed, 25 Nov 2026 17:45:36 +0100
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
Subject: Re: [PATCH bpf-next v3 2/9] module: Add module_kallsyms_find_name()
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
 <20261113221248.3535369-13-wusamuel@google.com>
Content-Language: en-US
From: Petr Pavlu <petr.pavlu@suse.com>
In-Reply-To: <20261113221248.3535369-13-wusamuel@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/13/26 11:12 PM, Samuel Wu wrote:
> KALLSYMS_QUERY_BY_NAME, added later in this series, needs to find a
> symbol name or prefix across module symbols in one pass.
> module_get_kallsym() walks the module list from the head and runs an
> export bsearch() for every symbol index.
> 
> Add module_kallsyms_find_name(), and put the shared query struct in
> linux/kallsyms.h, so we have a more efficient linear walk.
> 
> Signed-off-by: Samuel Wu <wusamuel@google.com>
> ---
> [...]
> diff --git a/kernel/module/kallsyms.c b/kernel/module/kallsyms.c
> index 1ff8ce857d92..72006c9bad42 100644
> --- a/kernel/module/kallsyms.c
> +++ b/kernel/module/kallsyms.c
> @@ -406,6 +406,63 @@ int module_get_kallsym(unsigned int symnum, unsigned long *value, char *type,
>  	return -ERANGE;
>  }
>  
> +/**
> + * module_kallsyms_find_name - Find a module symbol by name or prefix
> + * @symnum: in: index to start at; out: index of the match. The index
> + *          counts the symbols of the searched modules in list order.
> + * @q: name query; if @q->modname is set, only that module is searched
> + * @value: set to the symbol address
> + * @name: set to the symbol name (KSYM_NAME_LEN bytes)
> + * @module_name: set to the module name (MODULE_NAME_LEN bytes)
> + *
> + * Undefined (SHN_UNDEF) symbols are skipped.
> + *
> + * Return: 0 on a match, or -ENOENT.
> + */
> +int module_kallsyms_find_name(unsigned int *symnum,
> +			      const struct kallsyms_name_query *q,
> +			      unsigned long *value, char *name,
> +			      char *module_name)

Nit: kernel/module/kallsyms.c already contains a zoo of lookup functions
with similar names. Adding module_kallsyms_find_name() adds more to the
confusion, being similar to module_kallsyms_lookup_name() and
find_kallsyms_symbol_value().

I suggest calling it module_kallsyms_query_name() to match the
kallsyms_name_query parameter and to express that this is a structured
query, as opposed to a simple by-name lookup. It might be a good idea to
similarly stick to "query" instead of "find" in kernel/kallsyms.c.

Otherwise, this looks ok to me from the modules perspective. Feel free
to add:

Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

-- 
Thanks,
Petr
