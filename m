Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A963D429802
	for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 19:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789154774; cv=none; b=H6J51jh2pDqG9069nUM6UEfdlfKdx7VNYMPhA76Fn8HQyvmGk/+zf/PC4UpL4TJPcfid6FDEBdG7lHMGt++acpsU2X4B83VLgGwJOgPCgUJ/gaf8rsOL2Urq1k5YIHu6FgjMZlijmfzf+vYSWxvPpk1EBtA0R8JDyNoqjl0+T7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789154774; c=relaxed/simple;
	bh=E0nuT63K1UCUhatTxp/WsmIphFJjewYYXC7EfPUxVmM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YTe08KMcn9Fz3ZEOizBIchFsXchPf+fz1nWYrjBmpYcTNLh5BV16OXx3M8HuRSV4NywKKtRIglh685fPb47HfB/5wnJiNEBanghana0JOco3XuH8NdsafckzwziwrDDkP9aSNTXRWJngSE/2L1+2LdrH9l6SnJj4PO6CT8DHbik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T2WZsFs8; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T2WZsFs8"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48436216a98so811561f8f.0
        for <bpf@vger.kernel.org>; Fri, 11 Sep 2026 12:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789154766; x=1789759566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Nb+C2vqHps7zZGaA3lhpp4CjL1HIbRuVbwq1v+iSsLM=;
        b=T2WZsFs8+9Q1osND1zjFruum/Zhexy9Az6EhSEXD4dttx9oi1Anev1UmGzdt5Se+4/
         xTYmRrzBYPW/AfYyBq2rqr5/G2bf3+h5O7R+Tu08czj+20eVXOvDqaFRT4RAB+jdI520
         tbs1Zi3T6aSntQ9hqpzjy0CEP0DoJrwqvqNtk2vYMSAwU3o9GCFLwIukT84dR/eEN3u2
         e5bWgy5ojzpvvjz/fJ+tfB70sCi63OluaDuRb7YThDHuCp45bh8rGVunh8bBfPNvspLS
         Y980HqdKvIMI3Wcpxs+0EZmApbQFl01FXIL+jIdqdu2CY7KRG2onPDFo/Y4KDrEeH78w
         TUWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789154766; x=1789759566;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nb+C2vqHps7zZGaA3lhpp4CjL1HIbRuVbwq1v+iSsLM=;
        b=ZWENhl3fbTQQLj5Xr2hwDo6D8BsG5NCFgpAmf7iot5jdQV6spVfATZcy/kn4Yyitmx
         2RY4DHUuS1yvO32Aw49UlJqODnLVOQuvBEvRY0+QAsIFF6Z0yNs4gBdQLEOiJduPZgZP
         qp/fz5FjFx3AxYM+RDGefZTpVcqqROiZEyb7tUEmzFekSL62scny3RWcqWBajN4hy8eQ
         jLe8el/65RNdZxG/ryAvlCDwEu44x0dkVUys3yIgBVfrxcwJHqRX6FcK5jTOsCjMJ/vl
         +/sck6b+mpfLLbE3gaTT6KcnRCjxoXo7hqtPVuqhjRFuHYrHEpO6or7smakYEIlwasvT
         DKzQ==
X-Forwarded-Encrypted: i=1; AKwUvBwIZl1gfuhi1HZ/9BAFws+eHLINHsot+1kMR4XVWLXXe0rKiFY/8tia8umf9rdRrtquE7A=@vger.kernel.org
X-Gm-Message-State: AFuF++kkHSq19TAb4lHCdjn3U4IEOjPIE45qahjJJuG/yJgnwOjui6Fb
	9nigb0KXp7xGcc46nT+3mOwSRv99FybjhoxFWjvHG4V75jwagfhWcHpl
X-Gm-Gg: AYBFou02Phgz90VWHb3Kzfm/Fxqxv3eQfMo8U8AV7FlnrP4TCDKTpsHDKqgzyERj2f9
	LMXVQs9UgiitSDyvtIQA0QQW88x6PbFmOUZFBLOI8iu1QYznu9FeX3MLct9FYKNNMqhphN+D6yj
	WItrl799nssE30k2e1m8UROawG1CsQGeOa8g9/YeOZedxTlKL2jNNZkB3Xm/+jLeVBF1IZitFL7
	USyjDdg0y8VhxW/CItGDIyEXGcQdAjUQkReCaSWJPG9gq34IsmuyE9frKUl1TFbKtMRUFNjUW6C
	9OKBspotuEorMbCkCb0zXzMsjL4U+aJP0yuBHI/xU5HqlbZhPODTJaAK+njv94zwn+smYbS0mgS
	v+qHY4v9AqzhPJ2WJ+iZVVaaiWkzbhXX3iAIUuBcBTEqh6bx4pcMQH2CNBI0s7kCM5ZlRQumbZj
	WdQ/+dxetC3Nsozj4Cg/3GYz0x+FcBw1cK34E8DwRX6gCWmrERTRVtCst1gJTFaC2DODxE
X-Received: by 2002:a05:600c:c4a8:b0:49d:1df6:2592 with SMTP id 5b1f17b1804b1-49e619e0f7amr61198905e9.21.1789154764976;
        Fri, 11 Sep 2026 12:26:04 -0700 (PDT)
Received: from krava ([176.74.159.170])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e62232cb7sm71030065e9.4.2026.09.11.12.26.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 12:26:04 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 11 Sep 2026 21:26:02 +0200
To: Alan Maguire <alan.maguire@oracle.com>
Cc: ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
	eddyz87@gmail.com, ihor.solodrai@linux.dev, yonghong.song@linux.dev,
	song@kernel.org, qmo@kernel.org, martin.lau@linux.dev,
	memxor@gmail.com, emil@etsalapatis.com, mcgrof@kernel.org,
	petr.pavlu@suse.com, tj@kernel.org, kees@kernel.org,
	bpf@vger.kernel.org, nathan@kernel.org, nsc@kernel.org,
	arnd@arndb.de, puranjay@kernel.org, yatsenko@meta.com,
	atenart@kernel.org, ojeda@kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH v2 bpf-next 01/18] btf: Extend UAPI to support BTF
 location (inline site) info
Message-ID: <aqRVysZxIpP5lSOT@krava>
References: <20260901165757.801449-1-alan.maguire@oracle.com>
 <20260901165757.801449-2-alan.maguire@oracle.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901165757.801449-2-alan.maguire@oracle.com>

On Tue, Sep 01, 2026 at 05:57:40PM +0100, Alan Maguire wrote:

SNIP

> +
> +/*
> + * BTF_KIND_LOC_PROTO specifies location prototypes; i.e. how locations relate
> + * to parameters; a struct btf_type of BTF_KIND_LOC_PROTO is followed by a
> + * a vlen-specified number of __u32 BTF type ids which specify the associated
> + * BTF_KIND_LOC_PARAM for each function parameter associated with the
> + * location.  The type should either be 0 (no location info) or point at
> + * a BTF_KIND_LOC_PARAM.
> + */
> +
> +/*
> + * BTF_KIND_LOCSEC consists of vlen-specified number of "struct btf_loc"
> + * containing location site-specific information;
> + *
> + * - function (func)
> + * - location prototype type id (loc_proto)
> + * - address offset (offset) relative to kernel base address
> + */
> +
> +struct btf_loc {
> +	__u32 func;
> +	__u32 loc_proto;
> +	__u32 offset;
> +};

would it be possible to include btf id of the immediate parent function?
we have use cases for tracing just inlined function called from particular
parent

I thought we could use the location offset for that, but because inline
functions could be nested, this seems like hard search.. also we do not
know the size of the inlined code, so not sure how reliable it'd be

I checked the dwarves code and I wonder we could instead store parent
function (struct inline_expansion) during dwarf decoding and use that
later to get parent function FUNC_ID and have:

	struct btf_loc {
	     __u32 func;
	     __u32 parent;
	     __u32 loc_proto;
	     __u32 offset;
	};

wdyt? thanks,
jirka
