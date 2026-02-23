Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58133090E8
	for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862958; cv=none; b=kDfmYkwWC2OOOV6Jsgh0/bk2b1n1KpvtkYlpXd2YYtU97KyWGiJ5Gsd9kDD7T9LM+i9kSZAHn0IWrYJekGzwW7N8KG4+G1IcXyhn2Eu6SNaS2ASJCu1n5uO8m/co1kceV2SxdYRf6aHGzpFAJXWKQvosW1wUyH/BaXaC3005FBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862958; c=relaxed/simple;
	bh=waWzNOqJQHIwZ+qhrfnYHcqYdrF5a8LH+CvfWPTPF18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQ9RCfsK7dT9ghzDy+s1GJ+5Tjpg1UYBX89JTRoD/Jg7tcr+mqHjByHwUKTbBOpAkSoiUL1do+AZDDtSGPb/WiBZRUNp9ogqEZ9W+sIMtMHspB4o//bDdwLsSvZjYt+RTZXZkbUdFdV47AsR8EshT9wTlNXsVVg7ckKYbYqGSow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2c6Ajb8; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2c6Ajb8"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43638a33157so4221544f8f.1
        for <bpf@vger.kernel.org>; Mon, 23 Feb 2026 08:09:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771862955; x=1772467755; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dGudY9SBGHg1c0jEbQ14DEP17sqdiPhfYYOJi6m96V8=;
        b=N2c6Ajb80+snQEqOC7QCzx+vgw5GyOM+7CMzb7+p6uis20BqxVCwN+y8pBBDpGzQnE
         EIFIsVg+6zYYkAQVh23Nwtn+3n5s5QnAEj5ETgFAu2ctiFf5+Zb+aR8SGLf6b/DIm9GD
         CrN/H1a/f46UM+BZ2hBD5STewZ0RfFKw561lQUrtPibEYu5cVoyrIonhKO2WsIk1/LES
         7Wg5IBWgALWBj37TDLpUF0bF9Pp3Cv3C09dDiGvf5Doc0qfpxmuJYj6Bg0JCrQ0Z2AK4
         8CKEptB60j0/AqAagYJk5X66UQaGXSU5XeVA1ZTwgPmG6aCzZ9ahU5Epbfzg3y2ChbQq
         sHvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771862955; x=1772467755;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dGudY9SBGHg1c0jEbQ14DEP17sqdiPhfYYOJi6m96V8=;
        b=wUw/YpAkSsqVm/sHwaVeUMpUJFimudmRjCdzpndyjaLzHWPPbA60bM2BMLeML/tGAf
         flrsTlMeXiMGZCpKiPVt/GYtJbJ56iqcpWyU6WnFnLmQUBmy0U7ZG8hniXreCUx+8UAj
         WBj9FkWlRQYmYsx7YFjsfRNG/WHtnWNJVBH1gWi+e6d8VPwCpUJr0tgH8tz5EsbcGFWQ
         KceQycdosuSnuW3zou+f7vcR/0L22pB0Ce+czrUvxqSXiMrFr17a/0ZFvqGkCEpdi6gZ
         BhYqMWsZ06hcOHOmVFyFYL+t/1dl2Bv3ju+UaINhiZAPNzDuNhMgpFhvwyjv5Qqt+33T
         iFcQ==
X-Gm-Message-State: AOJu0YywYUVHC1ljFGnug7DhQB3ulc2P+cAxUcRielB8luRsxiYgkJ3u
	fLLJTbQ++XASxLh+1paK7+Djhh0gd3s0uQK7dilJQcbufot36L6M86Dt
X-Gm-Gg: ATEYQzxjBag4bbeYz90v+yhEESvpf+ZhsOpQrnhEsPPhsIhgaua+T2Cwu+a0SghpgSc
	IcW+XFycmVFmKhaovxbmzFp6+HxQvhVsJQ6X8UxO7tWTY7OooikvTftMalxy4eNR3F0Udmx7D8c
	CiPx1aNY71f8/W17AGU+xxfwpPigvQjANqEryswXU9yGC0lM9wGkSKAR85CSmkZHpznjyaBYOoD
	wyWD7nDFULKQ7va2h5Z+2DomCJtGgvVkUtPDpHs16Xkc+qcGmRCBuNAxjYGVQe+g4myRiFUKhqc
	0vWatix2i3buycZMG6cRT0hhsJ6vIStgxrMBYr9eQ1LaArVidBSaem6SQ3t9alTnjDG6+u4nBNh
	phlCIW6NwTi9A6DGlgicvpqoxUi8Pndgws+vacW6jxJ3nmMv0hy+WWLerXT6iM1YGXox7z6uE3O
	0rKoxJQVPnvlOU/wAsOAAYvMPqa0GnStrxURgIAdYxSAU=
X-Received: by 2002:a05:6000:1883:b0:437:7773:91d6 with SMTP id ffacd0b85a97d-4396f15aacbmr17737504f8f.25.1771862955046;
        Mon, 23 Feb 2026 08:09:15 -0800 (PST)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970d54754sm20195561f8f.36.2026.02.23.08.09.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:09:14 -0800 (PST)
Date: Mon, 23 Feb 2026 16:17:35 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: adubey@linux.ibm.com
Cc: bpf@vger.kernel.org, puranjay@kernel.org, ast@kernel.org,
	andrii@kernel.org, daniel@iogearbox.net, martin.lau@kernel.org,
	eddyz87@gmail.com, memxor@gmail.com, mykyta.yatsenko5@gmail.com
Subject: Re: [PATCH] selftest/bpf: enable test for instruction array on arm64
Message-ID: <aZx9nyyZsqIckCV4@mail.gmail.com>
References: <20260223203511.118475-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223203511.118475-1-adubey@linux.ibm.com>

On 26/02/23 03:35PM, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> As arm64 JIT now supports instruction array, make sure
> all relevant tests run on this architecture.
> 
> #21/1    bpf_insn_array/one2one:OK
> #21/2    bpf_insn_array/simple:OK
> #21/3    bpf_insn_array/deletions:OK
> #21/4    bpf_insn_array/deletions-with-functions:OK
> #21/5    bpf_insn_array/blindness:OK
> #21/6    bpf_insn_array/incorrect-index:OK
> #21/7    bpf_insn_array/load-unfrozen-map:OK
> #21/8    bpf_insn_array/no-map-reuse:OK
> #21/9    bpf_insn_array/bpf-side-ops:OK
> #21      bpf_insn_array:OK
> Summary: 1/9 PASSED, 0 SKIPPED, 0 FAILED
> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>  tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> index 269870bec941..93166c2da8e7 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_insn_array.c
> @@ -3,7 +3,7 @@
>  #include <bpf/bpf.h>
>  #include <test_progs.h>
>  
> -#ifdef __x86_64__
> +#if defined(__x86_64__) || defined(__aarch64__)
>  static int map_create(__u32 map_type, __u32 max_entries)
>  {
>  	const char *map_name = "insn_array";
> -- 
> 2.52.0
> 

Acked-by: Anton Protopopov <a.s.protopopov@gmail.com>
