Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C365636C9ED
	for <bpf@vger.kernel.org>; Fri,  6 Mar 2026 16:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772813705; cv=none; b=PsOlf01pj4Ci1c52rhMaNX6xHv6G+OS3XLYlxPwPFG89brZJpiuBvos3YUFw8Ipbn4DGT1XA4a2kMo3LFIrisZIL9CYWimv6oLQlF5/1szCwafKWMq2Np+I5McZt28tQgqkAi6mgCTm5LkejO35YHXgJ7T5L9n/mYhEXbeLLdIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772813705; c=relaxed/simple;
	bh=ZZ0W6nD9OBV5DaYZIwOImJ+cwH7dOfWfHd1We7Vj4NU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAOTManGA1OAWnU0hhRewHCBuY8WjVwGIN9aoa+LW3CXNGrrysILYm9wgB5fm/QHQb9wT3XvJrvLBHrBYYovUjL7G6XOjm4N+BBszoxtlbTr4QzYoidDK2SSsUYQoEwoAzFyrcs3+RZYrJJmixeHAKkGUWiDAs0e1fgbaA26U4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cdtkp0Un; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cdtkp0Un"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-480706554beso102597165e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Mar 2026 08:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772813702; x=1773418502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=occXS8oae/w92EkdqzWgWwMsYESYdwlcKweLDrs0LpM=;
        b=Cdtkp0Uncw1CKdi0ogz3+JO9ZmACUPIUo9n1++E6WwWcdHClzakO+shjzwFeBri4Uv
         SQ42RICgE59TB9j5sr7z+Zh4XI0fhqvOBzrZ9PI47LxsYE7/c9pDQI3IUxtbPOxSmIC/
         thMZQZf4xx8U5RYQuOFoIcTOiU3ITvTb4h4pHzo4DIg1Cb1rLr1jbBy8JLKte3ae8hqB
         0Gpypy8ilgDFQGJqMJ8LcgTgNQdc2QgsrqItzUWYOV8NQajBTgCHxysWqFpZFNYZ0/IC
         j+nxyTYUGPdlq5+X6rIXHKv30hpe6lEkB+FWzqkb7TEKaga3GK/EDYmhKIhqdg4psfVj
         9Fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772813702; x=1773418502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=occXS8oae/w92EkdqzWgWwMsYESYdwlcKweLDrs0LpM=;
        b=mh9ucAvcE7vad8PWsC96czpRuinGDof6yyOpJBmE6ZGL8f+UhDkWMXYo4dpQaBNBLb
         aLK6lz9z2S5EJ9dH8hW7tpbMumRJYDKaCKA5MgLwC4IZcNk1CQ8/OPtD3IP95VJ3hVUC
         imYvGdDR/2PjRPG+cMHuGNbFwVh9d9L35YUs6So+MsmgKLQm+/fFJkM3vy2Tl7aL9B4G
         xKVNGeaDi0BVsjFpLd3IG5A8Ohsr+VFxZOXPJN87AifphQCp5ufkX5ia49qWlmlNwnx5
         rsMBxo/Dij3vn7POYOXvaOqQD0/pXm44qUnuVbdSbSRIq0X67+Qi2nWUVPHxQnMmV83h
         NTiw==
X-Gm-Message-State: AOJu0YxbPZ1D5bSUdXTkHJspIP4fGMBc7Fa54gyDjaDeun0+mFBuJJZs
	6HtuDFrApsXzUs856r7uyo2TlMwu47ZjpYuLGRb4Hq03nrzGG2vHLYkl
X-Gm-Gg: ATEYQzyHmZbY2QSdoa/sp+KJOMKbw7uXdc/mECmgOy+qNNS35fuggGAVQESxXcNWe7g
	cykRrfozAEXYLUt4V99/ws0IxqLCy1EyuYoTmzTz+BZ4pFPFPlX+X7r1lqDg9d1NRjmwzdyIDJI
	enE0qtAkRIOoKELAqPO8N5seKS+/AAd4VoDOmVCA+QOQgvw+UmpySIOKVGdROVCwhE8advaRC4L
	quuE8uCjPjhiaOY+5h/vzmVtfKiSJpX1YyWwDkVy/6/yWTYstbm2FupggPxE6Sno9FDVzstA6H4
	XJdnrj/AlUxrLbCcyKiGX4bijtBpU2fDHLZ40ztB94Jh5PQWzd5Eof93FofBD5PUUsnHKhanGyY
	3DpyIgTwMJQonZGkCNJNDtd+Q/bVFkqCnZl5mzbZi7EDW9bJS1M0GUMPspPeNb87t8eeI0SX7bB
	DmUJzoTJJ1RidS2XtXZFgcpYXRX6GrUDsWatQUHkVD0ED0O9ZUmWU/7Rn3TcWlSMIjjFf1GINQy
	1wIFutMqfmaQ7InUjIPYCB/OY8a0qZWz8+u5S9ZSeORRVpvjTLrOrpEgysTjqb8UyE0vmoEIN1F
X-Received: by 2002:a05:600c:6085:b0:483:71f7:2797 with SMTP id 5b1f17b1804b1-48526930d9dmr45295675e9.14.1772813701838;
        Fri, 06 Mar 2026 08:15:01 -0800 (PST)
Received: from Tunnel (2a01cb089436c00026735364ee29b1d3.ipv6.abo.wanadoo.fr. [2a01:cb08:9436:c000:2673:5364:ee29:b1d3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dada9116sm4772407f8f.14.2026.03.06.08.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 08:15:01 -0800 (PST)
Date: Fri, 6 Mar 2026 17:14:59 +0100
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Sun Jian <sun.jian.kdev@gmail.com>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, andrii@kernel.org,
	eddyz87@gmail.com, ast@kernel.org, daniel@iogearbox.net,
	martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
	john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
	haoluo@google.com, jolsa@kernel.org, shuah@kernel.org
Subject: Re: [PATCH v2] selftests/bpf: avoid jump seq limit in
 verif_scale_pyperf600
Message-ID: <aar9gzh7QVhezeII@Tunnel>
References: <20260306120024.1032301-1-sun.jian.kdev@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306120024.1032301-1-sun.jian.kdev@gmail.com>

On Fri, Mar 06, 2026 at 08:00:24PM +0800, Sun Jian wrote:
> pyperf600 is a verifier scale test. With newer LLVM, calling __on_event()
> twice can push the generated program over the verifier jump sequence
> complexity limit (8192), failing with:
> 
>   The sequence of 8193 jumps is too complex.
> 
> Let pyperf600 provide its own on_event() that calls __on_event() once, and
> guard the shared wrapper accordingly. Other pyperf600 variants are
> unaffected.
> 
> Signed-off-by: Sun Jian <sun.jian.kdev@gmail.com>
> ---
> 
> v2:
>   - Drop runtime -E2BIG skip; instead tweak pyperf600 program source to avoid
>     hitting the verifier jump sequence complexity limit.
>   - verif_scale_pyperf600 now passes; other pyperf600 variants unchanged.
> 
>  tools/testing/selftests/bpf/progs/pyperf.h    | 4 +++-
>  tools/testing/selftests/bpf/progs/pyperf600.c | 7 +++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/progs/pyperf.h b/tools/testing/selftests/bpf/progs/pyperf.h
> index 86484f07e1d1..c02c49c52c77 100644
> --- a/tools/testing/selftests/bpf/progs/pyperf.h
> +++ b/tools/testing/selftests/bpf/progs/pyperf.h
> @@ -343,8 +343,9 @@ int __on_event(struct bpf_raw_tracepoint_args *ctx)
>  	return 0;
>  }
>  
> +#ifndef PYPERF_CUSTOM_ON_EVENT
>  SEC("raw_tracepoint/kfree_skb")
> -int on_event(struct bpf_raw_tracepoint_args* ctx)
> +int on_event(struct bpf_raw_tracepoint_args *ctx)
>  {
>  	int ret = 0;
>  	ret |= __on_event(ctx);
> @@ -354,5 +355,6 @@ int on_event(struct bpf_raw_tracepoint_args* ctx)
>  	ret |= __on_event(ctx);
>  	return ret;
>  }
> +#endif
>  
>  char _license[] SEC("license") = "GPL";
> diff --git a/tools/testing/selftests/bpf/progs/pyperf600.c b/tools/testing/selftests/bpf/progs/pyperf600.c
> index ce1aa5189cc4..31e8a422d804 100644
> --- a/tools/testing/selftests/bpf/progs/pyperf600.c
> +++ b/tools/testing/selftests/bpf/progs/pyperf600.c
> @@ -9,4 +9,11 @@
>   * the loop will still execute 600 times.
>   */
>  #define UNROLL_COUNT 150
> +#define PYPERF_CUSTOM_ON_EVENT
>  #include "pyperf.h"
> +
> +SEC("raw_tracepoint/kfree_skb")
> +int on_event(struct bpf_raw_tracepoint_args *ctx)
> +{
> +	return __on_event(ctx);
> +}

I'm not sure I like this approach. It feels like the 600 in pyperf600
wouldn't really be comparable to the 600 or the 180 in other test cases
since they wouldn't correspond to the same program (yours in five times
shorter). A low-effort alternative would be to tweak STACK_MAX_LEN and
UNROLL_COUNT, but I only managed to make that work by reducing
STACK_MAX_LEN to 180 and then I guess there isn't much difference with
pyperf180 :(

Ideally we would understand what changes in the bytecode with LLVM 19+
and mitigate that by adapting __on_event.

> 
> base-commit: 5ee8dbf54602dc340d6235b1d6aa17c0f283f48c
> -- 
> 2.43.0
> 
> 
