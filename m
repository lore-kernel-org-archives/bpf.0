Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30B7486341
	for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776378011; cv=none; b=aXgnsqGNWsemHr8GKlk1HzJQ+dLyDBBy/Ygg6Xq2Ee8TUPX0ouAKqtjvphH4cd3R30ZGKUg8pcbZ56ZkA+sJPXd996vVHNng3QzOZefeCp4s6PaY7j2YOiDzaPTTHHSjojmTUO+t/FjZpN39w6lppwh4SZFdx34ZbTgUrVt/hEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776378011; c=relaxed/simple;
	bh=qKZX8c9tqVaHMbF8Bx14W+Wwtg06QDCSa5Pavj+gTi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n0YTtOI5uUJ15Wp0AdA+IlKXe0iUYVIYIar8MF6qTj0RB3B105C2/3ebBxPmkpYO4FYapv8DxQU6U9sK1xEHnf8huS9QT+VFGrhPI5swH3ph9lhIy/xsFWWfGe1QNdMTxgGuhjaAkpohz93Q58NOVhE3u74lZBOQXHgvSapgENY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pWLSbHJp; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pWLSbHJp"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488a9033b2cso342835e9.2
        for <bpf@vger.kernel.org>; Thu, 16 Apr 2026 15:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776378008; x=1776982808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IDaaH1nx5H1B0uWMYCrxJOYAQ042A9K3TwdQm9qFq5s=;
        b=pWLSbHJp35CtNIVIv4ip0NQr/m07f0dJAsHpq98qtB8iE7d7pe7T05G2K3PrBzJXEJ
         pTXESH43ysjelmGpoOoY1IOKjeSQd2DokNilBrWtTdTsDRzxDXXpLq+od6nIqT/oTrU0
         KtueDsISDUPOZntYKJaUH/p6PArW8z6wOx1/GhryF7bBT44LiEE2IClycHEaT3HkPtAT
         p7LjTXPsHpG23q90EMywZT0oHj4bMJVvkd0PAKbc9SPNsAQFnCcPx5LtYl/3l9/goMyF
         SYg1qxy7dDhg36xaXPosyG9gAmax/wIAMiS7ZYduGQ9DD8r/f1Sg91C4L68sm4Dp80s8
         05KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776378008; x=1776982808;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDaaH1nx5H1B0uWMYCrxJOYAQ042A9K3TwdQm9qFq5s=;
        b=b6f9+KqXex8Qi8O8naxSIx6OZZP+bPcVlBgMX2aOBreo1GLkAiPrDd3E5imqHUo1c0
         WNa3RhiTWjrmXsVGif49vGel54eBHJi7xOHbm6nkHm7767ycOSgkh106aRKfGTn3AY6K
         ZVxYQ8gfsqP0WdN3u0io7QCZ/qxANKZUKIZr/tHUo/i73TH9qqVtAPTwfF0QXBUMD5S3
         EcscqRbEgNW2J08E20ytrfF6l+hh1ZienbBXKIpK5IGp8rYyl8S3Ag28IBVrkEgfb+9d
         d9xz4zq0fKFLt+18zEL6mAgSmpKMN/gz9YTt8+JP9oZAGOErcuPQpdoNpZuenuJG25tG
         MegA==
X-Gm-Message-State: AOJu0YwuCb4kzmzB59+vZXFCnxFSlm1e/rPizL8rAvL3PzcayCS3v0qs
	v5hmiqID3o8xcfUmwhS7r7rGd+KeKVhND3KDOyWZ54kzycw3vbKpw/GHKT7g2cAj
X-Gm-Gg: AeBDiess6o3yZYRAjzzZYyveSmP6Tf6Tttr4+7hnU5DWo/EuCIQlXIz2kU1dGoZ0lpe
	ZGt2Jw4gzwmfJzX6MP9346Zvvnqw70IAm4I+pU9ife8Js/e1fzXInEeYRVPp0M1lnXW92C07ELA
	90OFneNt3QPa7lMZMewUU9g6kzd+WG31Mpi6oHH0LknGYCVejUHRC7uYQy1kJQol12zKHRShhty
	R7fTKSkqQN6Dd/1wivWrbfOYAwyPTQN2+gW928TBYvhtol2I6FG6xaUh38cu0GwDv8dMZ/UHZ9d
	JZ9sTMw0PYJqQuhF3Ly0UFSeem539UzBfrSsLhELNf/rBGvvveWCbjz+Era4aJ5+QU9AhMfp661
	I3shjQHuykrmjclaIXmCqKhLYta4QfiTCH1jLWHVfXJ+FPCjS4rlHX91ntr/ICM6QmJ9CqFJy+F
	Zdce4KtvpG16GEHk4vZ+j5c7uxadiGDpOK2+/SUv8Lhn7FMgsOPh/J5to+VuBQYiYeUIW0nyhuS
	kOCKmcVMkBdezRVcfY4vDQ0qdzYFEwD3KkuUiwMMPw/dMzs8elymChZF3xgYTqGxOk3TsrCqCdh
	OUkY9YpBHMgVrwDnhpD200XYaSe9M2hRma9VJ04H/bgof1niJBkmjg==
X-Received: by 2002:a05:600c:681b:b0:488:b9c6:11ba with SMTP id 5b1f17b1804b1-488fb794f80mr3854995e9.28.1776378008377;
        Thu, 16 Apr 2026 15:20:08 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0092ca608f43e4326a.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:92ca:608f:43e4:326a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488f5818e51sm136202645e9.5.2026.04.16.15.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 15:20:07 -0700 (PDT)
Date: Fri, 17 Apr 2026 00:20:06 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com,
	eddyz87@gmail.com, memxor@gmail.com,
	Mykyta Yatsenko <yatsenko@meta.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: Reject scalar store into
 kptr slot
Message-ID: <aeFglj36jC4DyiIC@mail.gmail.com>
References: <20260416-kptr_crash-v1-0-5589356584b4@meta.com>
 <20260416-kptr_crash-v1-2-5589356584b4@meta.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416-kptr_crash-v1-2-5589356584b4@meta.com>

On Thu, Apr 16, 2026 at 11:08:08AM -0700, Mykyta Yatsenko wrote:
> From: Mykyta Yatsenko <yatsenko@meta.com>
> 
> Verify that the verifier rejects a direct scalar write to a kptr map
> value slot without crashing.
> 
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>

The test makes sense and causes a NULL pointer dereference as expected
when the fix isn't applied.

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

> ---
>  tools/testing/selftests/bpf/progs/map_kptr_fail.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/progs/map_kptr_fail.c b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> index 6443b320c732..ee053b24e6ca 100644
> --- a/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> +++ b/tools/testing/selftests/bpf/progs/map_kptr_fail.c
> @@ -385,4 +385,19 @@ int kptr_xchg_possibly_null(struct __sk_buff *ctx)
>  	return 0;
>  }
>  
> +SEC("?tc")
> +__failure __msg("invalid kptr access, R")
> +int reject_scalar_store_to_kptr(struct __sk_buff *ctx)
> +{
> +	struct map_value *v;
> +	int key = 0;
> +
> +	v = bpf_map_lookup_elem(&array_map, &key);
> +	if (!v)
> +		return 0;
> +
> +	*(volatile u64 *)&v->unref_ptr = 0xBADC0DE;
> +	return 0;
> +}
> +
>  char _license[] SEC("license") = "GPL";
> 
> -- 
> 2.52.0
> 
> 
