Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D48634F24D
	for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 11:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769599736; cv=none; b=Mgx4SIFn5ZfnjYey7BoR22o/22JLLwx5wRZzJHg30e2H64l6QqQpw+wzHCaTuYrwHhwPlAcem9R2sqcvGxHt6Rq3ia+SwXFhuTvKAeo3b84qsZjof3poXyxVo3UOnuUHpX3YC6oSgmqiRgBE6pNBZWGcq+H25CORWMYr/nWkd1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769599736; c=relaxed/simple;
	bh=q2MeOp8Y5yyCDXFyyC7HRaeDTb2/mMO8W7CGD3ap0g4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SLMsTJERRGDXVcpmKA+nI2nAzxi4ubSdTsxHgckQfT99ObBH8DisVHWomv236KQPnRbL3gAkuq4ItQge4qQHt5xqg9unqKHlK4WM6mZwp4VBRZ8GtxZj/CthRcnFmS4ZmP4SwmyasDPd7gesWe+Ei12sNTWzc9aTRSkEcpNZmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x12SDAY4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x12SDAY4"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b8869cd7bb1so883571966b.1
        for <bpf@vger.kernel.org>; Wed, 28 Jan 2026 03:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769599732; x=1770204532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zsg0G1qQnJMZmcTOUlSvTX8oIURapE56eMOFO0KQLsg=;
        b=x12SDAY4P7hJjjLp0pjmj166dB2i46aKenafbmB0cyaehI+YOyazxhKRa/x9QwyX5m
         DCBdIdwR/5z+IIVPSVc3al1TV+BPxBvpYJIJ+2LwCDsgOT8p9JQl4J3Pa225aRFiMfBT
         T95CyTwJlhyG3GgJkFAA0Ad5TRbg23j8bnF/hjg3TMJKssDIwQUbfukmFR0L8VRvnUwb
         0NITXfPaJTQk9ZcBMOD/8A51n5w9w/4wE0a62/1O9T4a8CeYSp1yNi8H5Ox7pxML2bOv
         1D+1Lvw/68PzYU9QBpwtGXAsv3VrAj6pLjTWykULOSXOzhP1dsRtAyfuQgBTS+m/8N3H
         sXtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769599732; x=1770204532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zsg0G1qQnJMZmcTOUlSvTX8oIURapE56eMOFO0KQLsg=;
        b=vslIQKVQldz3E2jWWF2f9e3tUrDLitiumQZ8K9m0MTlLtoHoX5VG1Gho6Je2gYSeDT
         o9mifYrzNXNaCVaTR2CevLrXai70Wap//DuvuN9PBo8DA1KJLKgaK8Izdcy1qkRdZFZU
         U+6RdCjo7svbh0UHZSWpAB58nxqRz1BcYa/IbmbZ9KlFhbruIsyWIYYyW7RbDENu09Qr
         UK8nwbWrKNTvV0N6sfh1t7uJnJKpRzGaF9GW3tT4Olzkv6//ZT1sPQgTQRYQyvXUOFAM
         bmhhNgIdgZb/F7h+EcgOo5PzVWU+a0H+rHKE2+qa/F6EYdTjoNhaUuF/7PIal86RuaEm
         f7TA==
X-Gm-Message-State: AOJu0YzqxZrIjHQUvXVFNCycXx+rquU51W0cF0vkkEjAtOOX4XeqCuJM
	6hUSDsKNp9AYuNEp+a0yUylzGx0Re8+eSRi1CAGgb5/XQns47jZeeS0h1raAd+f08Q==
X-Gm-Gg: AZuq6aL6i1kWnrUgRndBgg6DKMwb4crS8drV0nRAJwbFprbxai7o5lfj9B+7l/LCW+R
	bHoNwCp3jkQ7Ql5yREFS/BqP/vzplbNM5kO0mR4+C4O0gVGK2JVoRwXfpeEULvP5rrUT5BUeaQ0
	6qmeQMVEGor7b4VOIMxLpB3ty0b4l0v0Cbjr6d7GNBCHIsBwNvrO/CpyUymy7hIzrh+FamqO4pz
	o3FI44vsItsIOttiAHaj/g1d+QNJjNyFYkpAdtEtVOgJuD6IOBM1+0Tal8EKUz7Vpu8k3o6VON5
	HsZBHRu/V5oeg5MaouR0QqxCVfkLDenxJczqAG+qzhO0iy+3gaQhtoyKRiR8ZBPjJ74JfHRekd2
	rTA6cbM1iA+xAGragKlivbJnr1NU8jC0r4JyM2wX10+oR9fgxFsOUApXjyTMXr5A9ieGvVi78aI
	7+KO1cPlIcUBPCnYyVQz5q6Lyv+Y3qA/Lx3Nh9zimECP6RooxkYuE=
X-Received: by 2002:a17:907:da16:b0:b88:646b:ae3f with SMTP id a640c23a62f3a-b8dab1a5c0dmr331559966b.15.1769599732400;
        Wed, 28 Jan 2026 03:28:52 -0800 (PST)
Received: from google.com (93.50.90.34.bc.googleusercontent.com. [34.90.50.93])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8dbeff5629sm116615766b.27.2026.01.28.03.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 03:28:51 -0800 (PST)
Date: Wed, 28 Jan 2026 11:28:48 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: bpf@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	JP Kobryn <inwardvessel@gmail.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Suren Baghdasaryan <surenb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH bpf-next v3 01/17] bpf: move bpf_struct_ops_link into
 bpf.h
Message-ID: <aXny8JWF3KZiqBZi@google.com>
References: <20260127024421.494929-1-roman.gushchin@linux.dev>
 <20260127024421.494929-2-roman.gushchin@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260127024421.494929-2-roman.gushchin@linux.dev>

On Mon, Jan 26, 2026 at 06:44:04PM -0800, Roman Gushchin wrote:
> Move struct bpf_struct_ops_link's definition into bpf.h,
> where other custom bpf links definitions are.
> 
> It's necessary to access its members from outside of generic
> bpf_struct_ops implementation, which will be done by following
> patches in the series.

Looks OK to me:

Acked-by: Matt Bobrowski <mattbobrowski@google.com>

> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> ---
>  include/linux/bpf.h         | 6 ++++++
>  kernel/bpf/bpf_struct_ops.c | 6 ------
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 4427c6e98331..899dd911dc82 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1891,6 +1891,12 @@ struct bpf_raw_tp_link {
>  	u64 cookie;
>  };
>  
> +struct bpf_struct_ops_link {
> +	struct bpf_link link;
> +	struct bpf_map __rcu *map;
> +	wait_queue_head_t wait_hup;
> +};
> +
>  struct bpf_link_primer {
>  	struct bpf_link *link;
>  	struct file *file;
> diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
> index c43346cb3d76..de01cf3025b3 100644
> --- a/kernel/bpf/bpf_struct_ops.c
> +++ b/kernel/bpf/bpf_struct_ops.c
> @@ -55,12 +55,6 @@ struct bpf_struct_ops_map {
>  	struct bpf_struct_ops_value kvalue;
>  };
>  
> -struct bpf_struct_ops_link {
> -	struct bpf_link link;
> -	struct bpf_map __rcu *map;
> -	wait_queue_head_t wait_hup;
> -};
> -
>  static DEFINE_MUTEX(update_mutex);
>  
>  #define VALUE_PREFIX "bpf_struct_ops_"
> -- 
> 2.52.0
> 
