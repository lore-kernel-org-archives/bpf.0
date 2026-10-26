Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793006905;
	b=G/gsmAPLue0IE65/i2ONfkXUxJIGj3DftfyM6ZW94s73YbYU2QowFYRTomCuWsChAs2g
	 +pfreJ2N7MFWR58BoLrUpRkJf021q79vACJFdMFX+DwqQirzomJ7CyixhM2QwTLjEZUtr
	 AbLkdIn8ckgN/XvoYYQ7OTp7Pety2n7Jlbuww/SWzgdYKxBS0QyyWG4RJ7KlfKKkCmqz/
	 A1bBo7h4vH0o6WUU8EYk9L+GTB1t0mXlVYnmdo6qtiKs/BAm7icUr7tkEsrhrFkT+Fa1j
	 xsTZioFs3ZZbG5t+cEgOl9iQmI2iTCRKT1wVoW5sj/dB2CaWYYuVVxXhk2B8JxU+1Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793006905;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6Q5jKmXgzoo+WiVGo4LfNDJTiePFUGEuuUfFv2a/kxQ=;
	b=LMpPsnIizuoHn06T09jMMbCj0aSn/FjjipEtFk5u+gHbfmk4NCASYc0EyANNtQsriIDh
	 cVNqEzF4mNHdXqITqN8JFR1QboUp9auMhXkv+ZaXqeSpwT8WNpH0qTWF4lRS4w02S/G5v
	 WcSifYGICXg/pvQovuJxf7A6vYIL+SxLseM3V9Sy1R4jAJZ7EfpwKQTq5JanQ7/ld4Fwq
	 h8TF04v/pOIWWjd6Fz8njkcrqEJBBsY88fjQDynZ4ZRilZ2w0O1PUQ8OOSYFwmtW5uR2g
	 H1WrDH9x9A5Q+TrY7JAgDbxirjBZieeOMLHqB/KKSRWoiUHZ4nYsCVfY5Bqn9IThN2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CZ4B9P7w;
	arc=none smtp.remote-ip=209.85.128.42
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279A560A262E
	for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 09:28:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 279A560A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=CZ4B9P7w
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a1df4c0966so17431495e9.1
        for <bpf@vger.kernel.org>; Mon, 26 Oct 2026 02:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793006903; x=1793611703; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6Q5jKmXgzoo+WiVGo4LfNDJTiePFUGEuuUfFv2a/kxQ=;
        b=CZ4B9P7wQDiCoHwSght5HMF1Reu0ZpEa5W9PxymJM4iRKAeArJA9+p8mAQXrRP0Y5A
         533t1AnsPiaCD41CbQs4XdyVl85RGWOO2pjj95r+rqneOJOXEwburRPd+pn4RRpCkkjO
         9BynAhJWvsvPV8cU6J/Kj7PEUdurJMpgy/N0wkHcDKZPOtPNtlEZVJBt6agC7TcorWLo
         ZcoVuCinwHjIjKyFJwHBsfK3FTyHH8JKDImrVugE1Q0JThuEUCMT7WXn+R+Fgm8Zv8Vz
         F2ab9z3r5ovxvhgO8V5SRxUTac/RZ8vyZAKQD9TaKGf3RXpiJdWrhWVCK1SInHdQ/Qyx
         98JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793006903; x=1793611703;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6Q5jKmXgzoo+WiVGo4LfNDJTiePFUGEuuUfFv2a/kxQ=;
        b=jkFSoAIbY8IK1TaT2ub2CYm/p0lCWqT1wULRa6Ihkrz6a5oS+8twB96MQCCYMXKyJO
         CKPtbG7gqpX6Bsc85RE88uzrmRGY+X7/5dFC9ESbJ6WZz1LGHv2RPKCtNfL3aKI75o9q
         GIuEITSwo2U56InUaL4iIjmtZkq+rraudcMforRTbGSPOi8jjRbYZdCuZFlmlDJbeVXc
         v96WJVF/EiqKxAhU7EsnFCXTlbuN9KSI9tHSEy4dDXbOzLgqw9eD1QPPBdaRwE4zjiPK
         zDQDHaaKGRwRG8R3+YDyh3fgopV/tJQUNbinoIIyuewDcXEbdmOb2GWO+w34h4JJbiWo
         WobA==
X-Forwarded-Encrypted: i=1; AKwUvByApWLoE1nlI5mc5L6xh8c4iLBjI6l3MVY1jqY14oZaUXDFWqbv2EQgV22r+fizuwpdtOo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWRkp09kzCr6ouKCUiPk5yuk4ek5Gm+CypJ8JY9G2faxYh6DJq
	YvmmD5LBzMHqGeU6Gd0dFPq75OEQxuFg5+cfXFfSpGT3nD+D7OVaiJ2w
X-Gm-Gg: AYBFou1HA/v8EiamtQTLEEy2Pv3OkZw++X9qWwFJygvLUeLsGxFi2IjeKiGpHwJXF6p
	M6eOzzLPdR2rAgHyPVZ1QyLdp9CVs1ujAoj5Ojzm55B596xv0yQGGJ1EP/iQMtTLQiTwUaBMc7O
	4AQikeFRoyN5e8Mpf55X8a0BSv4LRbNiufyCTxM24TKo+Lt1sIDdrJJW7/BG477/cSznf6yM3BK
	Q2xUqPhcVSEmNPwKfAHb7fHtZuwQh8jnsJTVqaDuK1GtnNerZuHUPxXIJDoh3XxccSClVMaYK+L
	nb32hDyGQM0gEM6LRo0eKhPqONDAhcZDZBNI16c+yMZxSKISlPsyHkVtSTmqUK3QiTTVNu/FxpL
	BmFfDOsO1rRjnA1497hGkRSqjesRkaMmDlulzYKxwKybb5svpS0Lo/ULe2lTkzDu6s+q8AYgM99
	e6X+NF8VD8ramTGzE+LMqaKJ9twjHz2rRhii6XYn4x0gO9suxt3pqvLdCq4wyLsRrBi5sbIfPpJ
	LTwEOLvoTIPJydS6RX82O4Q6I9c
X-Received: by 2002:a05:600c:3553:b0:4a0:20b4:ba93 with SMTP id 5b1f17b1804b1-4a35aead203mr116295105e9.16.1793006903112;
        Mon, 26 Oct 2026 02:28:23 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::25dc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a359ff2189sm215058535e9.1.2026.10.26.02.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:28:22 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 26 Oct 2026 10:28:20 +0100
To: Samuel Wu <wusamuel@google.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, kernel-team@android.com,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-doc@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH bpf-next v2 4/6] libbpf: Resolve typeless ksyms via
 KALLSYMS_QUERY ioctl
Message-ID: <at8dNNb4vwovNZcZ@krava>
References: <20261023001603.560210-8-wusamuel@google.com>
 <20261023001603.560210-12-wusamuel@google.com>
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Post: <mailto:bpf@vger.kernel.org>
List-Help: <mailto:bpf+help@vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
List-Owner: <mailto:bpf+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261023001603.560210-12-wusamuel@google.com>

On Thu, Oct 22, 2026 at 05:16:05PM -0700, Samuel Wu wrote:

SNIP

> +static int bpf_object__query_ksyms(struct bpf_object *obj)
> +{
> +	struct kallsyms_query q;
> +	struct extern_desc *ext;
> +	int err = 0;
> +	int fd;
> +	int i;
> +
> +	fd = open("/proc/kallsyms", O_RDONLY | O_CLOEXEC);
> +	if (fd < 0)
> +		return -errno;
> +
> +	for (i = 0; i < obj->nr_extern; i++) {
> +		ext = &obj->externs[i];
> +		if (ext->type != EXT_KSYM || ext->ksym.type_id)
> +			continue;
> +
> +		q = (struct kallsyms_query){
> +			.size = sizeof(q),
> +			.query_flags = KALLSYMS_QUERY_BY_SYMBOL,
> +			.sym_name_addr = ptr_to_u64(ext->name),
> +		};
> +
> +			err = -errno;
> +			if (err == -ENOENT) {
> +				err = 0;
> +				continue;
> +			}
> +			if (err == -EADDRNOTAVAIL)
> +				pr_warn("extern (ksym) '%s': resolution is ambiguous\n",
> +					ext->name);
> +			break;
> +		}
> +		ext->is_set = true;
> +		ext->ksym.addr = q.sym_addr;
> +		pr_debug("extern (ksym) '%s': resolved in kernel to 0x%llx\n",
> +			 ext->name, ext->ksym.addr);
> +	}
> +	close(fd);
> +	return err;
> +}
> +
> +static int bpf_object__resolve_typeless_ksyms(struct bpf_object *obj)
>  {
> +	int err;
> +
> +	err = bpf_object__query_ksyms(obj);

hi,
we could also add similar support for libbpf_available_kallsyms_parse and
probably in some other places like bpf_get_ksyms.. which makes me think it
could be useful to have KALLSYMS_QUERY support for multiple symbols

thanks,
jirka


> +	/*
> +	 * Fall back to parsing /proc/kallsyms only if the ioctl is not
> +	 * accessible: not present (-ENOTTY on older kernels) or kallsyms
> +	 * addresses hidden from this opener (-EPERM, e.g. kptr_restrict).
> +	 */
> +	if (err != -ENOTTY && err != -EPERM)
> +		return err;
> +
> +	pr_debug("KALLSYMS_QUERY unavailable (%s), falling back to /proc/kallsyms\n",
> +		 errstr(err));
>  	return libbpf_kallsyms_parse(kallsyms_cb, obj);
>  }
>  
> @@ -9922,7 +9996,7 @@ static int bpf_object__resolve_externs(struct bpf_object *obj,
>  			return -EINVAL;
>  	}
>  	if (need_kallsyms) {
> -		err = bpf_object__read_kallsyms_file(obj);
> +		err = bpf_object__resolve_typeless_ksyms(obj);
>  		if (err)
>  			return -EINVAL;
>  	}
> -- 
> 2.56.0.257.gf7497c7d27-goog
> 
