Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB38B3F23DF
	for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 11:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768907310; cv=none; b=canPuaqJJbKFbllFsoleSCeICbxUOlV8cHRyHrY/nBMGN4lHy1psZv59bEMdR8TSczCzozVqBKBKIIsiy1k0bJivG2UFPvWVurl+kXLluFUc0CjPuLY+khx8T9QiL2ZatpEhlAA+FKDA8EnNkxBBLaaXgGfkg9p4cORczEx3aYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768907310; c=relaxed/simple;
	bh=0qGfsbUaYqLv1TeTFY/anvcSixqLUUhlzANqaazMZ6s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fMUNB+BKw58PYauqqiB8l2IKeEEvEptJvbqfcYk2w9o7y+7UigH4AP1V/ENblGOewei92SxzsdulXykJV5eFEX0yeP6NFAz/cEk7F7CfLO0+TCfkb4/9q67vCDpu45buoUHx72SbXTLwkccefk4n5r5NghBkDVjiHL2VtDe+GRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NxFmy/vr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=TN7wYjVB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NxFmy/vr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="TN7wYjVB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768907307;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftnBlBup++ZLoxWJcvRcIUlgWRhdF4uiJpY6AJyJ/aE=;
	b=NxFmy/vrlYe4AIjDoCsxQ28sH7bpReCvU4nArvUfZmxEBt/d1tdgF0IIz1fwNe0wnNQfNr
	G+nKI+LafToc0zaJK2qp/03rlqUM7GshLfygK/vL4Bb7nZaTOnXDRmqsOkNBGuJhD+CCXd
	0MS9uM3W0KPajyjg7FUpzcewngED2Wo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-669-P5nJ_4c3MweDZITWnBnzmA-1; Tue, 20 Jan 2026 06:08:26 -0500
X-MC-Unique: P5nJ_4c3MweDZITWnBnzmA-1
X-Mimecast-MFC-AGG-ID: P5nJ_4c3MweDZITWnBnzmA_1768907305
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-430f5dcd4cdso2957797f8f.2
        for <bpf@vger.kernel.org>; Tue, 20 Jan 2026 03:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768907305; x=1769512105; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ftnBlBup++ZLoxWJcvRcIUlgWRhdF4uiJpY6AJyJ/aE=;
        b=TN7wYjVBzEZ/lla9A3U53KJbZqa4Jo5bFkKGXhruYFSMyL6BmwI7lrGr+l4LTA0GBf
         XGLSj3s4lZWXrjhOLQFe4cNpQNbY3fSc2Kq2JaZYnRrVWbgGABlaWOawdFpn6D4MrYkL
         3r8adT1s7TjyLUqczRQ07S3Z0kfoIDPxU47NXOss2Fr8kyA/KfWmiPFy8OGuhzULOk5u
         K+hZEEuE5v6z+BzijQTGECUxuAIeeouIK9u3kG2lQxB1JqDDp2zXw3YtYDQtqb5gJvdX
         vSNB533J5x5R/v7wg5pqXODD8gQm+m0cqFt51440reNB8i14cvznSWSLCRwPIwdTPQpg
         PwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768907305; x=1769512105;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ftnBlBup++ZLoxWJcvRcIUlgWRhdF4uiJpY6AJyJ/aE=;
        b=iufMx9ZQph+jogWzLgY83ahIjKnOxgM5SbgE6bGM92G0kWzMnyycevEvT9YNcP1W+p
         6+wfsAXqIPSVG8eNd43TLGuPRXsnX52SM4nPjTaga6QL2M2WsKOxCBW1iu+zyBckwbAL
         qktSCyGl5bPdOWthVI1UkSPeShjpBwSgJcbCN7NcETdPnJtGm6d+CO0KsioizWKE1QVh
         4d9WvANFD+VjmkT1V74Ijp1HkIwTzyOSLFJVAjh+a9k5lpunoleRRp9coRKOKgr4WNnN
         iuteD4wwT6xtsRKpUckca90efbzA4dQS2sRxekoivdbfAl0myfMsNnU41DF/G15+h34C
         +0mg==
X-Forwarded-Encrypted: i=1; AJvYcCViTeSivUc3ahgocQcatHYGosF2SWWezOchvwtdz7c3uGOIqyRzY/QWVhcSLFFeANQtfeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6uXcFa8SFj0uki8byteEMq6FkcoJuGpVOFgtfE2RMbP98ilFb
	IPo/FSZgBaSRsxNCWdMHKCCMo9aj6FOwRuJCXMymuFKecVDOjJrKczIzBX8n1HMZRY9kmAg2ZeW
	T7FopyPYrK7vQq92OdSMijyZ9R+0tFNqxqmTKTZBnkDQKrVSOzFwC
X-Gm-Gg: AZuq6aJK05BO5q/Ux+2oDv/kHIOPOcWJ0BRvaMomzOkR1KNIlNIxA3umAyz0m6FPZdh
	wxcMderX+LlMLVhjGu1mZBayWhpCWa1ruvbFGExfcc9noSeGYlW0ZjUzwjAE1YrF663Lx6QY6WY
	FabUrNOXmhAf4A/yeIByIRRV8Ybnqr+nJ97PTHkBawq2SCbmWAVup/fJ7LWi1jOOPDCHvA8FHy6
	xSC2/j1Yq/egxSD1Y5nktAENQ8RLZsAt2uHXsIljR78mhTGwUzDuzQBneldDq2Uv+8+11gdNpD8
	D+YClMkZVtB/i3/wp/wrQdOwoNu3y52GYwxoOmFRvurN+P4eZCXdoMYPPA68hb/9AP6zKsn+
X-Received: by 2002:a05:6000:25c7:b0:432:dfa8:e1b6 with SMTP id ffacd0b85a97d-4356a053748mr20443900f8f.39.1768907305378;
        Tue, 20 Jan 2026 03:08:25 -0800 (PST)
X-Received: by 2002:a05:6000:25c7:b0:432:dfa8:e1b6 with SMTP id ffacd0b85a97d-4356a053748mr20443863f8f.39.1768907304917;
        Tue, 20 Jan 2026 03:08:24 -0800 (PST)
Received: from [10.43.17.17] ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43595e0a6fasm587274f8f.10.2026.01.20.03.08.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jan 2026 03:08:24 -0800 (PST)
Message-ID: <2c88f929-a0fd-4fbe-bc8c-24b1a798c507@redhat.com>
Date: Tue, 20 Jan 2026 12:08:23 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v4 1/2] bpf: add bpf_strncasecmp kfunc
To: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>, bpf@vger.kernel.org
Cc: mykyta.yatsenko5@gmail.com, andrii@kernel.org, ast@kernel.org,
 daniel@iogearbox.net, martin.lau@linux.dev
References: <20260120110011.1805037-1-ishiyama@hpc.is.uec.ac.jp>
 <20260120110011.1805037-2-ishiyama@hpc.is.uec.ac.jp>
From: Viktor Malik <vmalik@redhat.com>
Content-Language: en-US
In-Reply-To: <20260120110011.1805037-2-ishiyama@hpc.is.uec.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/20/26 12:00, Yuzuki Ishiyama wrote:
> bpf_strncasecmp() function performs same like bpf_strcasecmp() except
> limiting the comparison to a specific length.
> 
> Signed-off-by: Yuzuki Ishiyama <ishiyama@hpc.is.uec.ac.jp>

Acked-by: Viktor Malik <vmalik@redhat.com>

> ---
>  kernel/bpf/helpers.c | 30 +++++++++++++++++++++++++-----
>  1 file changed, 25 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 9eaa4185e0a7..6c36f0fb5da7 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -3406,7 +3406,7 @@ __bpf_kfunc void __bpf_trap(void)
>   * __get_kernel_nofault instead of plain dereference to make them safe.
>   */
>  
> -static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
> +static int __bpf_strncasecmp(const char *s1, const char *s2, bool ignore_case, size_t len)
>  {
>  	char c1, c2;
>  	int i;
> @@ -3417,7 +3417,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>  	}
>  
>  	guard(pagefault)();
> -	for (i = 0; i < XATTR_SIZE_MAX; i++) {
> +	for (i = 0; i < len && i < XATTR_SIZE_MAX; i++) {
>  		__get_kernel_nofault(&c1, s1, char, err_out);
>  		__get_kernel_nofault(&c2, s2, char, err_out);
>  		if (ignore_case) {
> @@ -3431,7 +3431,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>  		s1++;
>  		s2++;
>  	}
> -	return -E2BIG;
> +	return i == XATTR_SIZE_MAX ? -E2BIG : 0;
>  err_out:
>  	return -EFAULT;
>  }
> @@ -3451,7 +3451,7 @@ static int __bpf_strcasecmp(const char *s1, const char *s2, bool ignore_case)
>   */
>  __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>  {
> -	return __bpf_strcasecmp(s1__ign, s2__ign, false);
> +	return __bpf_strncasecmp(s1__ign, s2__ign, false, XATTR_SIZE_MAX);
>  }
>  
>  /**
> @@ -3469,7 +3469,26 @@ __bpf_kfunc int bpf_strcmp(const char *s1__ign, const char *s2__ign)
>   */
>  __bpf_kfunc int bpf_strcasecmp(const char *s1__ign, const char *s2__ign)
>  {
> -	return __bpf_strcasecmp(s1__ign, s2__ign, true);
> +	return __bpf_strncasecmp(s1__ign, s2__ign, true, XATTR_SIZE_MAX);
> +}
> +
> +/*
> + * bpf_strncasecmp - Compare two length-limited strings, ignoring case
> + * @s1__ign: One string
> + * @s2__ign: Another string
> + * @len: The maximum number of characters to compare
> + *
> + * Return:
> + * * %0       - Strings are equal
> + * * %-1      - @s1__ign is smaller
> + * * %1       - @s2__ign is smaller
> + * * %-EFAULT - Cannot read one of the strings
> + * * %-E2BIG  - One of strings is too large
> + * * %-ERANGE - One of strings is outside of kernel address space
> + */
> +__bpf_kfunc int bpf_strncasecmp(const char *s1__ign, const char *s2__ign, size_t len)
> +{
> +	return __bpf_strncasecmp(s1__ign, s2__ign, true, len);
>  }
>  
>  /**
> @@ -4521,6 +4540,7 @@ BTF_ID_FLAGS(func, bpf_iter_dmabuf_destroy, KF_ITER_DESTROY | KF_SLEEPABLE)
>  BTF_ID_FLAGS(func, __bpf_trap)
>  BTF_ID_FLAGS(func, bpf_strcmp);
>  BTF_ID_FLAGS(func, bpf_strcasecmp);
> +BTF_ID_FLAGS(func, bpf_strncasecmp);
>  BTF_ID_FLAGS(func, bpf_strchr);
>  BTF_ID_FLAGS(func, bpf_strchrnul);
>  BTF_ID_FLAGS(func, bpf_strnchr);

